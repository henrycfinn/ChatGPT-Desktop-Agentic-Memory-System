# Connect ChatGPT Desktop to the memory connector

This connector gives an explicitly connected ChatGPT session read-only access to the configured knowledge root. It is not ChatGPT account memory, is not automatically available in every conversation, and does not provide a write tool. Only connect a trusted workspace and knowledge root. The bundled Librarian can govern local writes separately.

## Prepare

From the repository root on Windows, with Python and pip available:

```powershell
.\scripts\setup.ps1 -KnowledgeRoot C:\path\to\your\wiki
.\scripts\doctor.ps1 -KnowledgeRoot C:\path\to\your\wiki
```

The preflight verifies the root and registers the three read-only MCP tools locally. It does not test ChatGPT, tunnel access, or make a network connection. Setup creates a local virtual environment; it does not alter the vault or persist a credential. Review [QMD guidance](qmd.md) if you use QMD.

## Start the connector

For an OpenAI Secure MCP Tunnel on a trusted local machine, run this in a PowerShell window and leave it running:

```powershell
.\.venv-chatgpt-mcp\Scripts\python.exe .\scripts\chatgpt_desktop_mcp.py `
  --knowledge-root C:\path\to\your\wiki --host 127.0.0.1 --port 8765 --tunnel-only
```

`--tunnel-only` deliberately disables the local bearer-token check. **Any local process able to connect to the port can read the configured knowledge root.** Use it only when the machine and local users are trusted and the official authenticated tunnel is the sole remote ingress. Never expose this unauthenticated endpoint via a public proxy. Without `--tunnel-only`, the connector requires a random bearer token of at least 32 characters from the process environment variable `CHATGPT_DESKTOP_LIBRARIAN_TOKEN`; configure a compatible authenticated local transport separately. Store secrets in a secure environment or secret manager, not in the repository, wiki, command history, or chat.

## Connect a private tunnel

1. Follow the official [Secure MCP Tunnel guide](https://developers.openai.com/api/docs/guides/secure-mcp-tunnels). Create or reuse a tunnel associated with your intended Platform organization and ChatGPT workspace. Creating/managing it and using it require the respective tunnel permissions; custom MCP servers may also be restricted by workspace policy.
2. Install the official `tunnel-client`, supply its runtime API key securely, and configure it for the local HTTP endpoint `http://127.0.0.1:8765/mcp` and your own tunnel ID. Use `tunnel-client help quickstart` and the official guide for the current commands. Run `tunnel-client doctor --profile <profile> --explain`, then keep `tunnel-client run --profile <profile>` running.
3. In ChatGPT Plugins, choose **Add custom MCP server**, select **Tunnel**, and choose the same tunnel. Configure the connection and confirm its permissions. Workspace administrators may need to enable custom MCP servers.

The connector and the tunnel client must both stay running. Creating a tunnel does not itself grant a ChatGPT workspace access; verify the association and permissions. Public plugin distribution has separate hosting requirements.

## Verify

In ChatGPT, invoke `memory_status` and confirm `writes_enabled` is false. Search for a unique heading in a non-sensitive test note, then use `read_memory` on the returned path and confirm it returns the intended content. Check that an outside path and `.obsidian/...` are rejected. Confirm no credential or vault text is written to application logs. If the connector is not discoverable, check both running processes, the tunnel association, workspace permissions, and the tunnel client's doctor output.

The connector prefers QMD for search when available and falls back to local lexical search when it cannot obtain usable results. A stale index can still produce incomplete results; check and refresh QMD deliberately. Never index pending proposals or receipts as authoritative knowledge.
