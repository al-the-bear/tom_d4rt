#!/usr/bin/env pwsh
#
# Issue-analysis test runner for the D4rt Flutter bridge corpus.
# Windows (PowerShell / pwsh). macOS / Linux users: run_issue_analysis_tests.sh.
#
# Runs the 13-file corpus FILE BY FILE, strictly SERIAL. The corpus drives a
# single long-lived companion app over one local HTTP server, so concurrent
# `flutter test` invocations corrupt each other's results. See README.md in
# this folder for the full rationale (serial-only + the 60s per-test timeout).
#
# Usage:
#   ./run_issue_analysis_tests.ps1 [-Id <id>]
#
# Id defaults to <yyyyMMdd-HHmm>-issue-analysis. Pass the SAME -Id to the
# sibling project's script so both projects' logs land in an identically named
# doc/testlog_<Id>/ folder. NEVER run this script for two projects at once —
# even though the AST app and the source-direct app bind different ports, the
# host gets overloaded and the shared-resource contention corrupts results.
#
# Output (per test file <base>):
#   doc/testlog_<Id>/<base>.result.json  machine-readable (--file-reporter json)
#   doc/testlog_<Id>/<base>.log.txt       full stdout incl. framework/overflow errors
#   doc/testlog_<Id>/metrics.txt          per-file exit code + pass/skip/fail summary
#
# A failing test file must not abort the rest, so errors are non-terminating.
param(
  [string]$Id = ((Get-Date -Format 'yyyyMMdd-HHmm') + '-issue-analysis')
)

$ErrorActionPreference = 'Continue'
Set-Location (Join-Path $PSScriptRoot '..')
$project = Split-Path -Leaf (Get-Location)
$out = "doc/testlog_$Id"
New-Item -ItemType Directory -Force -Path $out | Out-Null

# Spec order: heaviest/most-relevant first, interactive last.
$files = @(
  'essential_classes_test.dart',
  'important_classes_test.dart',
  'secondary_classes_test.dart',
  'hardly_relevant_classes_1_test.dart',
  'hardly_relevant_classes_2_test.dart',
  'hardly_relevant_classes_3_test.dart',
  'hardly_relevant_classes_4_test.dart',
  'hardly_relevant_classes_5_test.dart',
  'timeout_tests_test.dart',
  'blocking_tests_test.dart',
  'generator_interpreter_issues_test.dart',
  'generator_interpreter_retest_test.dart',
  'interactive_tests_test.dart'
)

Write-Host "== $project :: issue-analysis run $Id =="
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
