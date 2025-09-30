# Security Policy

## Supported Versions
- Main branch receives security fixes until otherwise noted

## Reporting a Vulnerability
- Email the maintainers or open a private issue (if available)
- Provide steps to reproduce, impact, and proposed severity

## Guidelines
- Never commit secrets; use environment variables and secret stores
- Rotate tokens regularly; least-privilege for service accounts
- Validate all inputs; prefer prepared statements/ORM
- Use HTTPS/TLS for all network traffic; verify certificates
- Log security events; avoid logging sensitive data

## Dependency Security
- Keep dependencies updated; audit regularly
- Pin versions where needed; avoid abandoned crates

## Runtime Hardening (Later)
- Containers: run as non-root, read-only FS, minimal base images
- Network: restrict ingress/egress; internal auth between PHP↔Rust
- Observability: alert on auth failures and unusual traffic
