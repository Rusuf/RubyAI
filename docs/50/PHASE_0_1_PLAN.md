# Development Plan: Phase 0 (Foundations) and Phase 1 (Data Ingest)

A pragmatic, step-by-step checklist to reach a working base service and reliable data ingest. Keep it simple; ship value fast.

## Phase 0 — Foundations (target: 1–2 days)

### 0.1 Environment and Repo
- Install Rust via rustup; verify `rustc`, `cargo`
- Initialize repo or open existing workspace in Cursor
- Add `.gitignore` (Rust, Node, Docker) and `.editorconfig`

Acceptance: `rustc --version` works, repo is committed.

### 0.2 Service Skeleton
- Create binary crate
  - `cargo new ai-backend --bin`
- Add dependencies in `Cargo.toml` (start minimal):
  - actix-web = "^4"
  - serde = { version = "^1", features = ["derive"] }
  - serde_json = "^1"
  - env_logger = "^0.11"
  - tokio = { version = "^1", features = ["rt-multi-thread","macros"] }
- Implement `/api/health` returning `{ "status": "ok" }`
- Run: `cargo run` and hit `http://localhost:8080/api/health`

Acceptance: Health returns 200 and JSON; logs visible.

### 0.3 Project Hygiene
- Add `RUST_LOG=info` default in `.env.example`
- Add `rustfmt.toml` (optional) and ensure `cargo fmt` passes
- Enable Clippy in CI (local pre-commit is fine for MVP)
- Basic folder layout for future modules: `src/api`, `src/ingest`, `src/models`

Acceptance: `cargo fmt` and `cargo clippy -- -D warnings` pass.

### 0.4 Container (Optional but Recommended)
- Add `Dockerfile` (Debian slim or distroless) with multi-stage build
- Add `docker-compose.yml` (dev) for running Postgres
- Verify: `docker build .` completes

Acceptance: Image builds; container runs health endpoint.

---

## Phase 1 — Data Ingest (target: 3–5 days)

Goal: Keep a clean analytics copy in Postgres using `log_table_sync_change` for incremental updates.

### 1.1 Connectivity and Config
- Add crates:
  - mysql = "^25" (or `mysql_async`), tokio enabled
  - sqlx = { version = "^0.7", features = ["runtime-tokio","postgres","macros","uuid","chrono"] }
  - anyhow = "^1", thiserror = "^1"
- Add env vars in `.env`:
  - `MYSQL_DSN=mysql://user:pass@host/db`
  - `PG_DSN=postgres://user:pass@localhost:5432/ai_backend`
  - `INGEST_POLL_SECS=5`

Acceptance: App can open MySQL and Postgres connections.

### 1.2 Postgres Schema (analytics store)
- Create minimal tables (mapped from `docs/DB_SCHEMA.md`):
  - `products(product_id TEXT PRIMARY KEY, code TEXT, name TEXT, category TEXT, department TEXT, unit TEXT, buy_price NUMERIC, sell_price NUMERIC, current_stock NUMERIC, updated_at TIMESTAMPTZ)`
  - `sales(sale_id BIGINT PRIMARY KEY, at TIMESTAMPTZ, receipt_no BIGINT, product_code TEXT, product_name TEXT, qty NUMERIC, price NUMERIC, total NUMERIC, customer TEXT)`
  - `receipts(receipt_id BIGINT PRIMARY KEY, receipt_no BIGINT UNIQUE, at TIMESTAMPTZ, payment_channel TEXT, customer TEXT)`
  - `ingest_state(id TEXT PRIMARY KEY, watermark TIMESTAMPTZ)`

Acceptance: `sqlx migrate run` (or simple SQL init) succeeds.

### 1.3 Backfill (initial load)
- Query last 30–90 days from MySQL for `products`, `sales`, `receipts`
- Transform types carefully (many numeric strings in MySQL)
- Upsert into Postgres (conflict on primary keys)

Acceptance: Postgres row counts match expectations; spot-check joins by `receipt_no`.

### 1.4 Incremental Sync via Change Log
- Poll `log_table_sync_change` using a watermark (`change_time`)
- For each change: fetch the full row by PK from source table; upsert/delete in Postgres
- Start with 3 tables: `products`, `sales`, `receipts`; defer others
- Store `watermark` in `ingest_state`

Acceptance: Creating/updating a sample source row reflects in Postgres within poll window.

### 1.5 Observability and Safety
- Add counters: processed, upserts, deletes, errors; log lag (`NOW()-watermark`)
- Backoff/retry on transient DB errors; skip and log bad rows
- Idempotency: ensure upserts deterministic; avoid duplicates

Acceptance: Steady ingest with clear logs; zero crash on malformed rows.

### 1.6 Ready for Phase 2 Hand-off
- Provide Rust function to query Postgres for co-occurrence inputs (sales by product_code)
- Confirm PHP can continue to own writes; Rust reads only from Postgres copy

Acceptance: Simple query shows enough data to compute also-bought.

---

## Minimal Commands Reference
```bash
# run service
cargo run

# format + lint
cargo fmt
cargo clippy -- -D warnings

# docker (optional)
docker build -t ai-backend:dev .

# sqlx (if using migrations)
sqlx migrate run
```

## Deliverables Checklist
- [ ] Phase 0: Health endpoint, fmt+clippy clean, optional Docker
- [ ] Phase 1: Postgres schema, backfill, incremental sync with watermark, basic metrics

## Notes
- Keep scope tight. Only ingest what Phase 2 needs (products, sales, receipts)
- Normalize IDs early to avoid name-based joins later
