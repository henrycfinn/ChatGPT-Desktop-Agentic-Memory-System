# ChatGPT Desktop Agentic Memory System

A local-first, read-only memory connector for ChatGPT Desktop and an existing Markdown or Obsidian knowledge base. QMD is optional search infrastructure; the Markdown files remain authoritative.

The connector exposes `search_memory`, `read_memory`, and `memory_status`. It does not write to the vault. Agentic Librarian, included in `librarian/`, is a separate governed-write component for supported local agents; this connector does not expose its write tools to ChatGPT.

## Set up on Windows

1. Clone this repository and open PowerShell in its root. You need Python and pip.
2. Prepare the connector against an existing knowledge directory:

   ```powershell
   .\scripts\setup.ps1 -KnowledgeRoot C:\path\to\your\wiki
   .\scripts\doctor.ps1 -KnowledgeRoot C:\path\to\your\wiki
   ```

3. Start the local connector, configure an OpenAI Secure MCP Tunnel and add the private MCP server in ChatGPT. Follow [the complete connection and security guide](docs/chatgpt-desktop.md).
4. In ChatGPT, run `memory_status`, search a non-sensitive test note, and read the returned note. Only then is the end-to-end connection verified.

Setup installs Python dependencies into a repository-local virtual environment and checks local tool registration. It does not create a tunnel, connect an account, store credentials, or change vault contents. The connector must run while ChatGPT uses it. Custom MCP server access depends on your workspace and Platform permissions.

## Memory and QMD

| Component | Role |
| --- | --- |
| Markdown / Obsidian | Canonical knowledge |
| ChatGPT Desktop connector | Read-only search and retrieval |
| QMD, optional | Local search index; filesystem search is the fallback |
| Agentic Librarian, separate | Governed writes and review for supported local agents |

QMD indexing, the QMD CLI, and a Hermes `memory.provider` plugin are distinct. This project does not install a Hermes QMD provider or turn on automatic conversational recall. See [QMD guidance](docs/qmd.md), including the stale-index and provider diagnostics.

## Boundaries

- The HTTP service binds to loopback. No public proxy is set up by this project.
- The default local HTTP mode requires a bearer token; the explicitly selected tunnel-only mode accepts unauthenticated loopback requests. Other local processes can reach that endpoint: use tunnel-only mode only in a trusted local environment and never expose it publicly.
- The connector excludes application metadata and refuses paths outside its configured knowledge root. Search and read return vault content to the connected ChatGPT session; connect only a workspace you trust.
- QMD synchronization is off unless you deliberately run or configure it. Pending proposals and receipts stay outside the indexed vault.
- The bundled Librarian subtree retains its own upstream files, license and notices. It is not installed by the ChatGPT setup script.

## Tests

```powershell
python scripts\run_tests.py
python .\scripts\check_public_repo.py
```

MIT; the bundled Librarian retains its own license and notices.
