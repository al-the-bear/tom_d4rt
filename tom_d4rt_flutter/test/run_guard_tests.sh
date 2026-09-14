#!/usr/bin/env bash
# The fast, transport-free guards for this twin — the ones that need no
# companion app, no HTTP server and no `concurrency: 1`.
#
# WHY THIS EXISTS (SCD108, applied to the source twin). `run_base_tests.sh`
# globs `flutter_base_*_test.dart` and `run_issue_analysis_tests.sh` adds
# `flutter_extended_*`, so a test matching neither is invoked by nothing. The
# AST twin grew `test/run_guard_tests.sh` when that bit it; this package kept
# the same hole. Three files sat here reachable only by someone naming them:
# `registration_skip_test.dart`, `mapped_iterable_resolution_test.dart`, and
# then SCD133's registry guard.
#
# Folding them into `run_base_tests.sh` is the obvious fix and the wrong one.
# That suite is serial-only because it drives ONE companion app over ONE local
# HTTP server; chaining a two-second in-process check onto it makes the cheap
# guard hostage to the expensive one, and answers in sixteen minutes a question
# that answers in two seconds.
#
#     ./test/run_guard_tests.sh
#
# Add a check here when it is fast and needs no transport. Anything that needs
# the companion app belongs in the corpus runners instead.
#
# NOT here, deliberately: `interpreter_generator_open_issues_test.dart` is
# EXPECTED to fail — it reproduces known-open defects, and a red result there
# is its correct output, not a regression.
#
# The user-bridge de-dup check is absent on purpose too: `tom_d4rt_flutter`'s
# copies are DERIVED, so `tool/sync_shared_user_bridges.dart` lives in the AST
# twin and the check runs from its guard runner.

set -uo pipefail
cd "$(dirname "$0")/.."

status=0

run() {
  local label="$1"; shift
  printf '%s ... ' "$label"
  if out=$("$@" 2>&1); then
    echo "ok"
  else
    echo "FAILED"
    printf '%s\n' "$out" | sed 's/^/    /'
    status=1
  fi
}

# SCD133: every bridged enum in the live registry resolves to itself. A
# registry-wide property test over the real `SourceFlutterD4rt` environment —
# it needs no companion app because it asks what the registry RESOLVES TO, not
# what a script renders. Two seconds for 151 enums / 589 values; SCC46, the
# defect it pins, cost four corpus files of a sixteen-minute suite to find.
run "bridged enums resolve to themselves" \
  flutter test test/scd133_registry_enum_resolution_test.dart

# Import-optimization step #19 — the pooled-registration skip path.
run "bridge registration is pooled (step #19)" \
  flutter test test/registration_skip_test.dart

# Precise `nativeNames` match in an enclosing frame must beat a fuzzy
# name-prefix match in a nearer one — the `MappedListIterable` → `Map`
# regression that broke `List.map(...).toList()`.
run "precise bridge match beats fuzzy prefix" \
  flutter test test/mapped_iterable_resolution_test.dart

if [ "$status" -eq 0 ]; then
  echo "all guards passed"
else
  echo "one or more guards FAILED" >&2
fi
exit "$status"
