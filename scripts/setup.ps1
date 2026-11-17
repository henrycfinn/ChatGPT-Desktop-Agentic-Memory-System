[CmdletBinding()]
param([Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$KnowledgeRoot)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $KnowledgeRoot).Path
if (-not (Test-Path -LiteralPath $root -PathType Container)) { throw 'KnowledgeRoot must be an existing directory.' }
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$venv = Join-Path $repo '.venv-chatgpt-mcp'
$python = Join-Path $venv 'Scripts\python.exe'
if (-not (Test-Path -LiteralPath $python -PathType Leaf)) {
    & python -m venv $venv
    if ($LASTEXITCODE -ne 0) { throw 'Could not create the connector environment.' }
}
& $python -m pip install -r (Join-Path $repo 'requirements-chatgpt-mcp.txt')
if ($LASTEXITCODE -ne 0) { throw 'Connector dependency installation failed.' }
& $python (Join-Path $PSScriptRoot 'chatgpt_desktop_doctor.py') --knowledge-root $root
if ($LASTEXITCODE -ne 0) { throw 'Connector validation failed.' }
Write-Host 'Connector prepared. Follow docs/chatgpt-desktop.md to start it and connect ChatGPT.'
Write-Host 'No vault files, credentials, tunnel, or ChatGPT settings were changed.'
