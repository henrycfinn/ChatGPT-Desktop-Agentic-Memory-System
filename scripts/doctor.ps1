[CmdletBinding()]
param([Parameter(Mandatory = $true)][string]$KnowledgeRoot)
$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$python = Join-Path $repo '.venv-chatgpt-mcp\Scripts\python.exe'
if (-not (Test-Path -LiteralPath $python -PathType Leaf)) { throw 'Connector environment not found. Run scripts/setup.ps1 first.' }
& $python (Join-Path $PSScriptRoot 'chatgpt_desktop_doctor.py') --knowledge-root $KnowledgeRoot
exit $LASTEXITCODE
