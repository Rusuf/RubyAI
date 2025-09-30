# Working Effectively in Cursor

This repo is maintained in Cursor. Follow these rules to stay productive and avoid conflicts.

## General Rules
- Prefer small, focused edits; describe intent clearly in commit messages
- Use inline code blocks and code references when discussing changes in PRs
- Avoid long-running commands without `--yes` or non-interactive flags
- Keep file writes under ~30 lines per chunk; continue in appended chunks

## File Ops
- Always use absolute paths in Desktop Commander actions
- Read files before editing; re-read after multiple edits to avoid drift
- Never mix tabs/spaces; preserve existing indentation exactly
- Do not paste binaries or giant blobs into Markdown

## Search & Navigation
- Use semantic search for concepts; use exact search for symbols
- When scanning code, parallelize searches (imports, usage, definitions)
- Prefer code references when quoting existing files:
```
12:18:app/example.rs
let x = 1;
```

## Branching & PRs in Cursor
- Create feature branches; keep PRs small and reviewable
- Link docs and API changes in the same PR when coupled
- Run linters/tests locally before requesting review

## Secrets & Env
- Never commit secrets; use `.env` with a sample `.env.example`
- Use OS keychains or secret managers for production

## When Stuck
- Add a minimal reproducible example
- Share exact errors and environment details
- Prefer asking with context links to files/lines
