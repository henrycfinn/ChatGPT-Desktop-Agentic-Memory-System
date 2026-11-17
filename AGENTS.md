# ChatGPT Desktop Agentic Memory System

Keep this repository portable: never commit vault contents, home paths, user identifiers, credentials, proposal bodies, receipts, or QMD index data. The primary product is a read-only ChatGPT Desktop MCP connector; do not add write capabilities or weaken path containment without an explicit design and tests.

`librarian/` is a pinned upstream subtree. Refresh it deliberately from a released revision; do not independently edit its policy implementation. QMD is optional and synchronization defaults to off. A successful local preflight must not be described as proof of a working ChatGPT tunnel.

Run before publishing:

```powershell
python scripts\run_tests.py
python .\scripts\check_public_repo.py
```
