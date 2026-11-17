# Architecture

```text
ChatGPT Desktop -> private MCP tunnel -> read-only connector -> canonical Markdown vault
                                               |
                                               -> optional QMD search index
Local agent -> Agentic Librarian -> governed writes -> canonical Markdown vault
```

The connector is an explicit retrieval tool, not ChatGPT account memory or a write service. It searches canonical files, preferably via QMD, and returns bounded excerpts or a selected full note. It must not expose proposal data or paths outside the configured vault. The separate bundled Librarian preserves its own approval and stale-base protections for local writes.

A local preflight does not verify the tunnel, account permissions, or a ChatGPT tool call; those are separate deployment checks in [the connector guide](chatgpt-desktop.md).
