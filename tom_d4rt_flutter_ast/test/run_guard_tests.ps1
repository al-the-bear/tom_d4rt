#!/usr/bin/env pwsh
# The fast, transport-free guards — Windows (PowerShell / pwsh) flavour of
# run_guard_tests.sh. macOS / Linux users: run_guard_tests.sh.
#
# SCE198. Until this file the guard suite was Unix-only, the one runner of the
# four without a .ps1 — and the cheapest: it answers in seconds what the corpus
# answers in sixteen minutes, and it is where every repo-wide guard in the twins
# is registered. A Windows session could run the corpus and not the guards,
# which inverts the cost ordering the runners exist for.
#
# SAME CHECKS, SAME ORDER, SAME TWO MODES as the .sh — see it for why each one
# is here and what bucket it is in. The two are kept in step by a test, not by
# care: scd142's F-SCE197-1 fails when the two flavours of a runner select
# different test files.
#
#     ./test/run_guard_tests.ps1           # every guard (run + pair)
#     ./test/run_guard_tests.ps1 --pair    # only the pair guards, which is how
#                                          # tom_d4rt_flutter's runner reaches them
#
# Exit code 0 when every check passed, 1 otherwise.

$ErrorActionPreference = 'Continue'
Set-Location (Join-Path $PSScriptRoot '..')

$script:status = 0
$pairOnly = $args -contains '--pair'
if ($pairOnly) {
  Write-Host 'pair guards (live in tom_d4rt_flutter_ast; subject includes tom_d4rt_flutter):'
}

# One check: a label, a command, an accumulated status. Output is shown only
# when the check fails, as in the .sh.
function check([string]$Label, [scriptblock]$Command) {
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

# `run`: subject is this package only, so skipped under --pair.
function run([string]$Label, [scriptblock]$Command) {
  if ($pairOnly) { return }
  check $Label $Command
}

# `pair`: subject includes the source twin, so the source twin's runner
# reaches it through --pair.
function pair([string]$Label, [scriptblock]$Command) {
  check $Label $Command
}

pair 'user-bridge sync (tool --check)' { dart run tool/sync_shared_user_bridges.dart --check }
pair 'user-bridge sync (test)' { flutter test test/sync_shared_user_bridges_test.dart }
pair 'doc/ holds no runner output' { Push-Location ../tom_d4rt; try { dart test test/scd110_doc_holds_no_runner_output_test.dart } finally { Pop-Location } }
run 'bridged enums resolve to themselves' { flutter test test/scd133_registry_enum_resolution_test.dart }
run 'no bridged name covers two native classes' { flutter test test/scd195_registry_collision_test.dart }
run 'bridge registration is pooled (step #20)' { flutter test test/registration_skip_test.dart }
run 'bridges execute in-process' { flutter test test/bridge_execution_test.dart }
run 'import-optimization timings hold' { flutter test test/import_optimization_perf_test.dart }
pair 'companion app resolution is checked' { flutter test test/companion_app_resolution_test.dart }
pair 'hosted is the default resolution strategy' { flutter test test/scd66_resolution_strategy_test.dart }
run 'the package''s own smoke test' { flutter test test/tom_d4rt_flutter_ast_test.dart }
pair 'every test file is reachable from a runner' { flutter test test/scd142_runner_coverage_test.dart }
pair 'the twins share one script corpus' { flutter test test/scd141_shared_corpus_test.dart }
pair 'the scd133 dynamic deferral has not expired' { flutter test test/sce157_typed_registry_pending_test.dart }
pair 'corpus skips state a mechanism and cite evidence' { flutter test test/scd140_skip_hygiene_test.dart }
pair 'corpus runs record the interpreter they resolved' { flutter test test/scd164_run_attribution_test.dart }
pair 'cluster log is derived, dated and blast-radius rated' { flutter test test/interpreter_issues_doc_test.dart }
run 'generator issues log is a derived register' { flutter test test/sce158_generator_issues_doc_test.dart }
run 'open-issues doc is rated and derived' { flutter test test/sce159_open_issues_doc_test.dart }
pair 'proxy registries agree across the twins' { flutter test test/sce164_proxy_registry_parity_test.dart }
pair 'runtime registrations mirror below the prologue' { flutter test test/sce165_runtime_registrations_mirror_test.dart }
pair 'one definition of a passing corpus script' { flutter test test/sce167_pass_verdict_convention_test.dart }
run 'bridge step is streamed and content-decided' { flutter test test/sce13_bridge_gate_test.dart }
pair 'launch retry leaves no orphaned build' { flutter test test/sce14_launch_retry_test.dart }
run 'tool lookup picks a runnable file on Windows' { flutter test test/tool_resolution_test.dart }
pair 'framework-error inventory reads the harness format' { flutter test test/framework_error_inventory_test.dart }
run 'stdlib types route to the stdlib under Flutter scope' { flutter test test/sce177_stdlib_routing_under_flutter_test.dart }
pair 'shared test infrastructure agrees across the twins' { flutter test test/sce170_twin_test_infrastructure_test.dart }
run 'sibling-tree guards declare where they must run' { flutter test test/sce191_structural_guard_anchoring_test.dart }

$scope = if ($pairOnly) { 'pair guards' } else { 'guards' }
if ($script:status -eq 0) {
  Write-Host "all $scope passed"
} else {
  Write-Host "one or more $scope FAILED"
}
exit $script:status
