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
# testlog/testlog_<Id>/ folder. NEVER run this script for two projects at once —
# even though the AST app and the source-direct app bind different ports, the
# host gets overloaded and the shared-resource contention corrupts results.
#
# Output (per test file <base>):
#   testlog/testlog_<Id>/<base>.result.json  machine-readable (--file-reporter json)
#   testlog/testlog_<Id>/<base>.log.txt       full stdout incl. framework/overflow errors
#   testlog/testlog_<Id>/metrics.txt          per-file exit code + pass/skip/fail summary
#
# metrics.txt opens with an ATTRIBUTION HEADER (SCD164) — `# `-prefixed
# lines naming the run id, its start time, this package, and every `tom_`
# package this package and its companion app resolved. The locks are
# gitignored, so without it a testlog folder cannot be matched to the
# interpreter that produced it.
#
# A failing test file must not abort the rest, so errors are non-terminating.
param(
  [string]$Id = ((Get-Date -Format 'yyyyMMdd-HHmm') + '-issue-analysis')
)

$ErrorActionPreference = 'Continue'
$scriptDir = $PSScriptRoot
Set-Location (Join-Path $PSScriptRoot '..')
$project = Split-Path -Leaf (Get-Location)
$out = "testlog/testlog_$Id"
New-Item -ItemType Directory -Force -Path $out | Out-Null

# Idle-output watchdog: kill a test file that produces NO output for this many
# seconds. Catches mid-run stalls AND "never reaches the first test" hangs so a
# wedged transport fails fast. Override with $env:IDLE_TIMEOUT.
#
# SCD131: 300, not the 70 this used to default to — the watchdog was SHORTER
# THAN THE THING IT WATCHES. `SendTestRunner.setUp` waits up to 120 s for the
# companion app to start, so on a cold build cache the first file produces no
# output for longer than the watchdog allows and is killed with exit 124 and
# zero tests, which reads as a hang and is not one. That state is exactly what
# a `flutter pub upgrade` leaves behind, i.e. exactly the state the corpus
# protocol requires the sweep to run in.
#
# NOTE, and it is why this default matters more here than in the .sh twin:
# THIS SCRIPT HAS NO WALL-CLOCK BACKSTOP. The shell runners wrap each file in
# `timeout 900`; this one has only the watchdog and the per-test `--timeout`,
# so raising it lengthens how long a genuinely wedged file survives. That
# asymmetry is a real gap and is SCE148, not something to paper over by keeping
# a default that misfires on every cold run.
$idle = if ($env:IDLE_TIMEOUT) { [int]$env:IDLE_TIMEOUT } else { 300 }

# Full corpus: the flutter_base_NN then flutter_extended_NN split files, in
# numeric order (base before extended, interactive is the last extended file).
# Globbed so the list auto-tracks the generated files; each runs its own app.
$files = @()
$files += Get-ChildItem -Path 'test' -Filter 'flutter_base_*_test.dart' |
  Sort-Object Name | ForEach-Object { $_.Name }
$files += Get-ChildItem -Path 'test' -Filter 'flutter_extended_*_test.dart' |
  Sort-Object Name | ForEach-Object { $_.Name }

Write-Host "== $project :: issue-analysis run $Id =="
Write-Host "== output: $out =="
Set-Content -Path "$out/metrics.txt" -Value ''

# Resolve the companion app before the first file. It is a separate package
# with its own gitignored pubspec.lock, and nothing else re-resolves it when
# this package moves — a stale app lock once built against an interpreter
# releases behind, and the run died in setUpAll naming only a timeout. The
# harness now refuses to launch an app out of step with this package
# (test/companion_app_resolution.dart); resolving once here keeps that refusal
# for machines that skipped the runner.
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

# Attribution header (SCD164). Both twins gitignore `pubspec.lock`, so the
# interpreter a run resolved appears in no diff and no commit — and a testlog
# folder was therefore a pass/skip/fail triple with no provenance. Written
# AFTER the app is resolved, so it records the versions the run actually used.
# `dart` may be absent on a machine that has only `flutter`; a run whose
# attribution failed is still a run worth having, so this never aborts.
if (Get-Command dart -ErrorAction SilentlyContinue) {
  $attr = & dart run test/run_attribution.dart '.' $appDir $Id 2>&1
  if ($LASTEXITCODE -ne 0) {
    $attr = '# attribution: FAILED - dart run test/run_attribution.dart exited non-zero'
  }
} else {
  $attr = '# attribution: FAILED - no dart on PATH'
}
Add-Content -Path "$out/metrics.txt" -Value $attr

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
Write-Host "./test/run_issue_analysis_tests.ps1 -Id $Id"
