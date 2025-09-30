# Architecture

Rust AI service operates alongside the PHP system, exposing HTTP endpoints for intelligence while PHP remains the source of truth for menu, orders, and inventory.

## Components
- Rust API service: Actix/Rocket HTTP server
- Workers: async jobs for crawling and model refresh
- Storage: Postgres (service data), Redis (cache), object storage (artifacts)
- Integrations: PHP backend via HTTP, external trend APIs

## Data Flow (conceptual)
1. PHP sends requests to Rust for recommendations or stock insights
2. Rust reads its own state + external signals and returns JSON
3. Workers periodically fetch trends, update cache/DB
4. Optional webhook from PHP to notify menu changes

## Endpoints (initial ideas)
- GET `/api/health` — liveness
- GET `/api/recommendations/{menu_item_id}` — related items
- GET `/api/stock_optimization` — ingredient priorities
- GET `/api/trending_recipes` — trending ideas

## Boundaries
- PHP owns transactional data and menu lifecycle
- Rust owns analytics, models, and external intelligence
- Only minimal read-only mirrors of PHP data in Rust if needed

## Observability
- Structured logs (JSON), request IDs
- Metrics (Prometheus), basic dashboards
- Traces (optional, OTLP)

## Security
- Auth between PHP↔Rust (token/JWT over internal network)
- Rate limiting on public-facing surfaces (if any)
- Secrets via environment/secret manager
