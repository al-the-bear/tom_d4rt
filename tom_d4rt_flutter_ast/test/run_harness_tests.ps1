#!/usr/bin/env pwsh
#
# Harness-test runner for the D4rt Flutter bridge twins.
# Windows (PowerShell / pwsh). macOS / Linux users: run_harness_tests.sh.
#
# The harness-level tests drive the companion app but are NOT corpus files.
# SCC48's `framework_error_isolation_test.dart` is named outside the
# `flutter_base_*` / `flutter_extended_*` globs on purpose, so adding it could
# not shift the metrics tables every verification run is compared against —
# right for the baselines, and it left the test executed by nothing until
# SCD142. See run_harness_tests.sh for the full reasoning; it is the same.
#
# Serial for the same reason the corpus runners are: one companion app, one
# local HTTP server.
#
# Output (per test file <base>):
#   testlog/harnesslog_<Id>/<base>.result.json  machine-readable
#   testlog/harnesslog_<Id>/<base>.log.txt      full stdout
#   testlog/harnesslog_<Id>/metrics.txt         per-file exit + pass/skip/fail
#
# UNVERIFIED ON WINDOWS. Written on macOS as a close adaptation of
# run_base_tests.ps1, which is proven; every construct here appears there. It
# has NOT been executed on legiondary01 — the fleet VPN was down when SCD142
# landed — so treat the first Windows run as the verification. sce172 owns it.
#
# A failing test file must not abort the rest, so errors are non-terminating.
param(
  [string]$Id = ((Get-Date -Format 'yyyyMMdd-HHmm') + '-harness')
)

$ErrorActionPreference = 'Continue'
$scriptDir = $PSScriptRoot
Set-Location (Join-Path $PSScriptRoot '..')
$project = Split-Path -Leaf (Get-Location)
$out = "testlog/harnesslog_$Id"
New-Item -ItemType Directory -Force -Path $out | Out-Null

# Idle-output watchdog, matching the corpus runners. SCD131: 300, not 70 — the
# watchdog used to be shorter than the thing it watches, so a cold companion-app
# start was reported as a hang.
#
# As in run_base_tests.ps1, THIS SCRIPT HAS NO WALL-CLOCK BACKSTOP: the shell
# twins wrap each file in `timeout 900`, this one has only the watchdog and the
# per-test `--timeout`. That asymmetry is sce148, not something to paper over.
$idle = if ($env:IDLE_TIMEOUT) { [int]$env:IDLE_TIMEOUT } else { 300 }

# Globbed, not listed: a list is one more thing to forget, which is the defect
# this script exists to fix.
$files = Get-ChildItem -Path 'test' -Filter '*_isolation_test.dart' |
  Sort-Object Name | ForEach-Object { $_.Name }

if ($files.Count -eq 0) {
  Write-Host 'no harness tests matched test/*_isolation_test.dart'
  exit 1
}

Write-Host "== $project :: harness-test run $Id =="
Write-Host "== output: $out =="
Set-Content -Path "$out/metrics.txt" -Value ''

# Resolve the companion app before the first file: it is a separate package with
# its own gitignored lock, and the harness refuses to launch one out of step with
# this package.
$appDir = 'test/tom_d4rt_flutter_ast_app'
Write-Host "== resolving $appDir =="
Push-Location $appDir
$pubOut = & flutter pub get 2>&1
$pubRc = $LASTEXITCODE
Pop-Location
if ($pubRc -ne 0) {
  $pubOut | ForEach-Object { Write-Host $_ }
  Add-Content -Path "$out/metrics.txt" -Value "companion app: flutter pub get failed in $appDir"
  Write-Host "companion app: flutter pub get failed in $appDir"
  exit 1
}

$status = 0
foreach ($f in $files) {
  $base = [IO.Path]::GetFileNameWithoutExtension($f)
  Write-Host ''
  Write-Host "---- $f ----"
  & "$scriptDir/idle_timeout.ps1" $idle "$out/$base.log.txt" `
    flutter test "test/$f" --timeout 65s --file-reporter "json:$out/$base.result.json"
  $rc = $LASTEXITCODE
  if ($rc -ne 0) { $status = 1 }
  $m = Select-String -Path "$out/$base.log.txt" -Pattern '\+\d+( ~\d+)?( -\d+)?' |
    Select-Object -Last 1
  $summary = if ($m) { $m.Matches[0].Value } else { '<no summary>' }
  $note = if ($rc -eq 124) { " (IDLE-KILLED after ${idle}s of no output)" } else { '' }
  Add-Content -Path "$out/metrics.txt" -Value "${base}: exit=$rc $summary$note"
}

Write-Host ''
Write-Host "== done. metrics: $out/metrics.txt =="
Write-Host ''
Write-Host "== re-run this exact ID (copy-paste; e.g. in the sibling project) =="
Write-Host "./test/run_harness_tests.ps1 -Id $Id"
exit $status
