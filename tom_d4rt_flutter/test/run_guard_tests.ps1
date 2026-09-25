#!/usr/bin/env pwsh
# The fast, transport-free guards for tom_d4rt_flutter — Windows (PowerShell /
# pwsh) flavour of run_guard_tests.sh. macOS / Linux users: run_guard_tests.sh.
#
# SCE198. Same checks and order as the .sh: this package's own guards, then the
# PAIR guards, which live in tom_d4rt_flutter_ast because their subject spans
# both twins and are reached through that package's runner with --pair. Kept in
# step with the .sh by scd142's F-SCE197-1.
#
# Exit code 0 when every check passed, 1 otherwise.

$ErrorActionPreference = 'Continue'
Set-Location (Join-Path $PSScriptRoot '..')

$script:status = 0

function run([string]$Label, [scriptblock]$Command) {
  Write-Host -NoNewline "$Label ... "
  $out = & $Command 2>&1 | Out-String
  if ($LASTEXITCODE -eq 0) {
    Write-Host 'ok'
  } else {
    Write-Host 'FAILED'
    foreach ($line in ($out -split "`r?`n")) { Write-Host "    $line" }
    $script:status = 1
  }
}

run 'bridged enums resolve to themselves' { flutter test test/scd133_registry_enum_resolution_test.dart }
run 'no bridged name covers two native classes' { flutter test test/scd195_registry_collision_test.dart }
run 'bridge registration is pooled (step #19)' { flutter test test/registration_skip_test.dart }
run 'precise bridge match beats fuzzy prefix' { flutter test test/mapped_iterable_resolution_test.dart }

Write-Host ''
& (Join-Path $PSScriptRoot '../../tom_d4rt_flutter_ast/test/run_guard_tests.ps1') --pair
if ($LASTEXITCODE -ne 0) { $script:status = 1 }
Set-Location (Join-Path $PSScriptRoot '..')

if ($script:status -eq 0) {
  Write-Host 'all guards passed'
} else {
  Write-Host 'one or more guards FAILED'
}
exit $script:status
