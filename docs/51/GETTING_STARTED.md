# Getting Started (Rust AI Backend)

This guide helps new contributors set up the Rust backend locally.

## Prerequisites
- Rust toolchain via rustup (`rustc`, `cargo`)
- Git
- Docker (optional, recommended for DB and local services)
- Windows: PowerShell or Git Bash; Linux/macOS: Bash/Zsh

## Install
1. Install rustup: https://rustup.rs
2. Verify: `rustc --version` and `cargo --version`
3. Clone repo and open in Cursor

## Create Project Skeleton
- Option A (single crate):
  - `cargo new ai-backend --bin`
- Option B (workspace, for services/workers):
  - `cargo new --vcs none .` (if starting empty)
  - Create `Cargo.toml` workspace and add members later

## Run
1. `cargo run`
2. Open http://localhost:8080 (health endpoint to be added)

## Next Steps
- Read `docs/ARCHITECTURE.md`
- Review `docs/API.md`
- Set up environment variables per `docs/DEVELOPMENT.md`
