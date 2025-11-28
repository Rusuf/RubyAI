# Project Plan (MVP-first)

Goal: Deliver a working Rust AI backend that the PHP system can call for recommendations, stock insights, and trending recipes—keeping scope lean and focused on business value.

## Phase 0 — Foundations (1–2 days)
- Align on success metrics: response time (<200ms), uptime, first endpoints usable by PHP
- Confirm DB access method (direct read vs dumps vs replica)
- Decide stack: Rust + Actix Web, PostgreSQL (analytics store), MySQL source
- Create repo and skeleton (health endpoint, CI format/lint)
- Docs ready: README, GETTING_STARTED, ARCHITECTURE, API, AI_DATA_INGEST

Deliverables:
- Running server with `/api/health`
- Basic CI (fmt+clippy)

## Phase 1 — Data Ingest (3–5 days)
- Implement incremental sync from MySQL using `log_table_sync_change`
- Normalize to Postgres tables: products, sales, receipts, customers
- Backfill last 30–90 days of data for initial models
- Add observability: basic logs and counters (ingested rows, lag)

Deliverables:
- Ingest job running locally on schedule (or loop)
- Postgres populated with core entities

## Phase 2 — Recommendations (5–7 days)
- Baseline: item co-occurrence (also-bought) from recent sales
- Expose `GET /api/recommendations/{menu_item_id}` with simple scoring
- Add minimal caching to avoid recompute hot paths
- PHP integration: example call and response

Deliverables:
- Working recommendations in PHP UI for top sellers

## Phase 3 — Stock Insights (5–7 days)
- Baseline: average daily sales + safety stock heuristic
- Endpoint: `GET /api/stock_optimization?horizon_days=7`
- Include restock flags based on `restock_level` and sales velocity
- PHP integration: management dashboard section

Deliverables:
- Prioritized ingredient/product restock suggestions

## Phase 4 — Trends (optional MVP+, 7–10 days)
- Crawler for 1–2 reliable sources (HTML/API), async with rate limits
- Simple NLP: keyword frequency for dish names/ingredients
- Endpoint: `GET /api/trending_recipes`
- Cache results and refresh periodically

Deliverables:
- Chef’s tab fed with a list of trending items

## Phase 5 — Hardening and Deploy (3–5 days)
- Auth between PHP↔Rust (static token/JWT)
- Error handling, timeouts, and input validation
- Containerization: Dockerfile, compose for local
- Basic dashboards (logs/metrics), alerting later

Deliverables:
- Dockerized service ready for staging

## Phase 6 — Feedback & Iteration (ongoing)
- Track endpoint usage and quality (CTR on recommended items, stock-outs avoided)
- Improve models if ROI warrants it (e.g., embeddings, time series)

---

## Minimal Scope for MVP
- Data ingest of products, sales, receipts
- Co-occurrence recommendations
- Simple stock heuristic
- 3 stable endpoints + health

## Out of Scope (initially)
- Advanced ML (deep models, embeddings)
- Full text NLP for multiple trend sources
- Complex auth, multi-tenant, RBAC

## Risks & Mitigations
- Inconsistent schema relations → Normalize in Postgres, validate joins
- Mixed numeric types/strings → Cast carefully, add data cleaning
- Missing FKs → Backfill surrogate keys (product_id/customer_id mappings)

## Success Metrics
- Adoption: endpoints called by PHP daily
- Latency: P95 < 200ms for cached reads
- Accuracy proxies: click-through on recommendations; restock alerts reducing stock-outs

## Tracking Checklist
- [ ] Health endpoint
- [ ] Ingest pipeline (initial + incremental)
- [ ] Products/sales/receipts models in Postgres
- [ ] Recommendations endpoint
- [ ] Stock optimization endpoint
- [ ] PHP integration demos
- [ ] Docker build
