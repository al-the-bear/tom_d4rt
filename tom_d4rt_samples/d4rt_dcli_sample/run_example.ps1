# Run a D4rt example by folder name, or a script piped on stdin.
#
#   ./run_example.ps1 physics_sim         # runs example/physics_sim/main.dart
#   '<script>' | ./run_example.ps1        # runs a single script from stdin
#
# If lib/dartscript.b.dart is missing, the bridges are generated first.
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Test-Path '.dart_tool')) {
    Write-Host 'Fetching dependencies (first run)...'
    dart pub get
}

if (-not (Test-Path 'lib/dartscript.b.dart')) {
    Write-Host 'Generating bridges (first run)...'
    dart run tom_d4rt_generator:d4rtgen
}

dart run bin/run_example.dart @args
