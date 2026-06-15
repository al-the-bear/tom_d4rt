# Run a D4rt example by folder name, or a script piped on stdin.
#
#   ./run_example.ps1 calculator          # runs example/calculator/main.dart
#   ./run_example.ps1 calculator 2 + 3     # forwards "2 + 3" to the script
#   'void main(_) { print(1 + 1); }' | ./run_example.ps1
#
# Always run from the package root so example/<name>/ resolves.
$ErrorActionPreference = 'Stop'
# Remember where the user invoked us, so a stdin script can import sibling
# files relative to the caller's directory (not the package root we cd into).
if (-not $env:TOM_D4RT_CALLER_CWD) { $env:TOM_D4RT_CALLER_CWD = (Get-Location).Path }
Set-Location -Path $PSScriptRoot

if (-not (Test-Path '.dart_tool')) {
    Write-Host 'Fetching dependencies (first run)...'
    dart pub get
}

# Args are forwarded to the runner; with none, it reads the script from stdin.
dart run bin/run_example.dart @args
