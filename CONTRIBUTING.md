# Contributing

Thanks for contributing to the Ruby Restaurant AI backend!

## Branching
- main: stable, protected
- feature/*: new work
- fix/*: bug fixes
- docs/*: documentation only

## Commits
- Conventional Commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
- Keep messages imperative and scoped, e.g. `feat(api): add trending endpoint`

## Pull Requests
- Small, focused changes; include docs updates when relevant
- Add screenshots or sample JSON for APIs
- Link issues; describe testing performed

## Code Style
- Rustfmt and Clippy must pass
- Descriptive names; avoid abbreviations
- Error handling via `Result`; avoid `unwrap()` in non-test code

## Tests
- Unit tests in `src/`
- Integration tests in `tests/`
- Add regression tests for fixed bugs

## Security
- No secrets in code or Git history
- Report vulnerabilities via SECURITY.md
