# Development Workflow

## Tooling
- rustup toolchain, cargo, rust-analyzer
- rustfmt, clippy, cargo-nextest (optional)
- Makefile or justfile for common tasks (optional)

## Environment
- Use `.env` for local secrets; provide `.env.example`
- Configure DB/Redis only when schema is available

## Branch → PR
1. Create branch `feature/<short-name>`
2. Implement change with tests
3. `cargo fmt && cargo clippy -- -D warnings`
4. `cargo test` (including integration tests)
5. Update docs (`README`, `API`, etc.)
6. Open PR, request review

## Testing
- Unit tests colocated with modules
- Integration tests under `tests/`
- HTTP tests use a test server and fixtures

## Releases
- Semantic versioning when applicable
- Changelog entries per PR
- Tagged builds; Docker image builds in CI (later)

## Observability in Dev
- Log JSON to console with level env var (e.g., `RUST_LOG=info`)
- Add request IDs for tracing across PHP↔Rust
