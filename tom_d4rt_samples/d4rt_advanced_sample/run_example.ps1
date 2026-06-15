# Run a D4rt example by folder name, or a script piped on stdin.
#
#   ./run_example.ps1 physics_sim         # runs example/physics_sim/main.dart
#   '<script>' | ./run_example.ps1        # runs a single script from stdin
#
# If lib/dartscript.b.dart is missing, the bridges are generated first.
$ErrorActionPreference = 'Stop'
# Remember where the user invoked us, so a stdin script can import sibling
# files relative to the caller's directory (not the package root we cd into).
if (-not $env:TOM_D4RT_CALLER_CWD) { $env:TOM_D4RT_CALLER_CWD = (Get-Location).Path }
Set-Location -Path $PSScriptRoot

if (-not (Test-Path '.dart_tool')) {
    Write-Host 'Fetching dependencies (first run)...'
    dart pub get
}

# The generated bridges (lib/*.b.dart) are checked in, so the examples run
# without the generator. If they are missing, regenerate them - see
# run_generator.md.
if (-not (Test-Path 'lib/dartscript.b.dart')) {
    Write-Error 'Generated bridges are missing. See run_generator.md to regenerate.'
    exit 1
}

dart run bin/run_example.dart @args
