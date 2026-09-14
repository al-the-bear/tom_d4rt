#!/usr/bin/env bash
# The fast, transport-free guards — the ones that need no companion app, no
# HTTP server and no `concurrency: 1`.
#
# WHY A THIRD RUNNER (SCD108). `run_base_tests.sh` globs
# `flutter_base_*_test.dart` and `run_issue_analysis_tests.sh` adds
# `flutter_extended_*`, so a test matching neither is invoked by nothing. That
# was true of `sync_shared_user_bridges_test.dart` — the only check on the
# AST/non-AST user-bridge de-dup — for as long as it existed.
#
# Folding it into `run_base_tests.sh` was the obvious fix and is the wrong one.
# That suite is serial-only because it drives ONE companion app over ONE local
# HTTP server; chaining a millisecond file-I/O check onto it makes the cheap
# guard hostage to the expensive one, and answers in sixteen minutes a question
# that answers in one second. The independence is a feature. The invisibility
# was the bug, and the fix for invisibility is a hook (`.githooks/pre-commit` at
# the repo root), not a longer corpus run.
#
# So this script is the half a HUMAN invokes — it gives the fast checks a name
# and a home. The hook is the half that fires without being remembered. Neither
# replaces the other: a hook can be un-installed on a fresh clone (it needs one
# `git config core.hooksPath .githooks`), and on such a machine this script is
# what a reviewer runs by hand.
#
#     ./test/run_guard_tests.sh
#
# Add a check here when it is fast and needs no transport. Anything that needs
# the companion app belongs in the corpus runners instead. A check may live in
# another package — the second one does; what makes it belong here is its cost,
# not its address.

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

# The user-bridge de-dup. `--check` is the same code path the test asserts, and
# is run directly so this script stays useful even when `dart test` cannot
# start (no pub get, a broken lock).
run "user-bridge sync (tool --check)" \
  dart run tool/sync_shared_user_bridges.dart --check

# The test that pins the PROPERTY rather than the tool's exit code — SCC37
# replaced a hand-written basename list with the intersection of the two
# directories, and this is what holds that.
# `flutter test`, not `dart test`: this is a Flutter package, and `package:test`
# reaches it only through `flutter_test`. It is still transport-free — the file
# does pure file I/O and needs no companion app.
run "user-bridge sync (test)" \
  flutter test test/sync_shared_user_bridges_test.dart

# SCD110: `doc/` holds no runner output — tracked tree, this machine's disk, the
# runner scripts, and the `.gitignore` ratchet. It lives in `tom_d4rt` because it
# is a REPO-wide invariant (the same reason `release_hygiene_test.dart` does),
# and it is run from here because this is the repo's only assembled set of fast
# guards. `dart test`, not `flutter test`: `tom_d4rt` is a plain Dart package.
run "doc/ holds no runner output" \
  sh -c 'cd ../tom_d4rt && dart test test/scd110_doc_holds_no_runner_output_test.dart'

# SCD133: every bridged enum in the live registry resolves to itself. A
# registry-wide property test over the real `FlutterD4rt` environment — it
# needs no companion app because it asks what the registry RESOLVES TO, not
# what a script renders. Two seconds for 213 enums / 857 values; SCC46, the
# defect it pins, cost four corpus files of a sixteen-minute suite to find.
run "bridged enums resolve to themselves" \
  flutter test test/scd133_registry_enum_resolution_test.dart

# Import-optimization step #20. In-process, no transport — and, until now,
# invoked by nothing: it matches neither corpus runner's glob. Same SCD108
# shape as the user-bridge check above.
run "bridge registration is pooled (step #20)" \
  flutter test test/registration_skip_test.dart

if [ "$status" -eq 0 ]; then
  echo "all guards passed"
else
  echo "one or more guards FAILED" >&2
fi
exit "$status"
