#!/usr/bin/env pwsh
#
# Base-test runner for the D4rt Flutter bridge corpus (fast regression gate).
# Windows (PowerShell / pwsh). macOS / Linux users: run_base_tests.sh.
#
# This is the SHORT sibling of run_issue_analysis_tests.ps1. It runs ONLY the
# essential + important corpus files (2 of the full 13), as the fast
# early-warning regression gate after any bridge/proxy/relaxer regeneration.
# Use the full run_issue_analysis_tests.ps1 for a complete reference pass.
#
# Like the full runner, this runs FILE BY FILE, strictly SERIAL. The corpus
# drives a single long-lived companion app over one local HTTP server, so
# concurrent `flutter test` invocations corrupt each other's results. See
# README.md in this folder for the full rationale (serial-only + 60s timeout).
#
# Usage:
#   ./run_base_tests.ps1 [-Id <id>]
#
# Id defaults to <yyyyMMdd-HHmm>-base. Pass the SAME -Id to the sibling
# project's script so both projects' logs land in an identically named
# testlog/basetestlog_<Id>/ folder. NEVER run this script for two projects at once
# — even though the AST app and the source-direct app bind different ports, the
# host gets overloaded and the shared-resource contention corrupts results.
#
# Output (per test file <base>):
#   testlog/basetestlog_<Id>/<base>.result.json  machine-readable (--file-reporter json)
#   testlog/basetestlog_<Id>/<base>.log.txt        full stdout incl. framework errors
#   testlog/basetestlog_<Id>/metrics.txt           per-file exit code + pass/skip/fail summary
#
# A failing test file must not abort the rest, so errors are non-terminating.
param(
  [string]$Id = ((Get-Date -Format 'yyyyMMdd-HHmm') + '-base')
)

$ErrorActionPreference = 'Continue'
$scriptDir = $PSScriptRoot
Set-Location (Join-Path $PSScriptRoot '..')
$project = Split-Path -Leaf (Get-Location)
$out = "testlog/basetestlog_$Id"
New-Item -ItemType Directory -Force -Path $out | Out-Null

# Idle-output watchdog: kill a test file that produces NO output for this many
# seconds (default 70 = ~60s per-test max + margin). Catches mid-run stalls AND
# "never reaches the first test" hangs so a wedged transport fails fast.
# Override with $env:IDLE_TIMEOUT.
$idle = if ($env:IDLE_TIMEOUT) { [int]$env:IDLE_TIMEOUT } else { 70 }

# Base subset only: the flutter_base_NN split files (essential + important +
# secondary corpus, ~50 tests each, own test app per file). Globbed in numeric
# order so the run stays serial and reproducible.
$files = Get-ChildItem -Path 'test' -Filter 'flutter_base_*_test.dart' |
  Sort-Object Name | ForEach-Object { $_.Name }

Write-Host "== $project :: base-test run $Id =="
Write-Host "== output: $out =="
Set-Content -Path "$out/metrics.txt" -Value ''

foreach ($f in $files) {
  $base = [IO.Path]::GetFileNameWithoutExtension($f)
  Write-Host ''
  Write-Host "---- $f ----"
  # The idle watchdog wraps the run: it streams output to the log and kills the
  # whole process tree (returning 124) after $idle seconds of silence.
  & "$scriptDir/idle_timeout.ps1" $idle "$out/$base.log.txt" `
    flutter test "test/$f" --timeout 65s --file-reporter "json:$out/$base.result.json"
  $rc = $LASTEXITCODE
  # flutter test summary line looks like: "00:42 +45 ~2 -1: Some tests failed."
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
Write-Host "./test/run_base_tests.ps1 -Id $Id"
