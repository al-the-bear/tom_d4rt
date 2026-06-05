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
# doc/basetestlog_<Id>/ folder. NEVER run this script for two projects at once
# — even though the AST app and the source-direct app bind different ports, the
# host gets overloaded and the shared-resource contention corrupts results.
#
# Output (per test file <base>):
#   doc/basetestlog_<Id>/<base>.result.json  machine-readable (--file-reporter json)
#   doc/basetestlog_<Id>/<base>.log.txt        full stdout incl. framework errors
#   doc/basetestlog_<Id>/metrics.txt           per-file exit code + pass/skip/fail summary
#
# A failing test file must not abort the rest, so errors are non-terminating.
param(
  [string]$Id = ((Get-Date -Format 'yyyyMMdd-HHmm') + '-base')
)

$ErrorActionPreference = 'Continue'
Set-Location (Join-Path $PSScriptRoot '..')
$project = Split-Path -Leaf (Get-Location)
$out = "doc/basetestlog_$Id"
New-Item -ItemType Directory -Force -Path $out | Out-Null

# Base subset only: essential + important (heaviest/most-relevant first).
$files = @(
  'essential_classes_test.dart',
  'important_classes_test.dart'
)

Write-Host "== $project :: base-test run $Id =="
Write-Host "== output: $out =="
Set-Content -Path "$out/metrics.txt" -Value ''

foreach ($f in $files) {
  $base = [IO.Path]::GetFileNameWithoutExtension($f)
  Write-Host ''
  Write-Host "---- $f ----"
  & flutter test "test/$f" --timeout 60s --file-reporter "json:$out/$base.result.json" 2>&1 |
    Tee-Object -FilePath "$out/$base.log.txt"
  $rc = $LASTEXITCODE
  # flutter test summary line looks like: "00:42 +45 ~2 -1: Some tests failed."
  $m = Select-String -Path "$out/$base.log.txt" -Pattern '\+\d+( ~\d+)?( -\d+)?' |
    Select-Object -Last 1
  $summary = if ($m) { $m.Matches[0].Value } else { '<no summary>' }
  Add-Content -Path "$out/metrics.txt" -Value "${base}: exit=$rc $summary"
}

Write-Host ''
Write-Host "== done. metrics: $out/metrics.txt =="
Write-Host ''
Write-Host "== re-run this exact ID (copy-paste; e.g. in the sibling project) =="
Write-Host "./test/run_base_tests.ps1 -Id $Id"
