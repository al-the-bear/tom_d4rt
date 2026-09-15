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

# SCD195 — the collision check one layer above the stdlib. Registration-level,
# so it needs no companion app and belongs here rather than in the corpus.
run "no bridged name covers two native classes" \
  flutter test test/scd195_registry_collision_test.dart

# Import-optimization step #20. In-process, no transport — and, until now,
# invoked by nothing: it matches neither corpus runner's glob. Same SCD108
# shape as the user-bridge check above.
run "bridge registration is pooled (step #20)" \
  flutter test test/registration_skip_test.dart

# SCD142: four more in-process tests that were reachable from no runner. Each
# says in its own header that it does NOT spawn the companion app, which is what
# makes them belong here rather than in the corpus or harness runners.
run "bridges execute in-process" \
  flutter test test/bridge_execution_test.dart
run "import-optimization timings hold" \
  flutter test test/import_optimization_perf_test.dart
run "companion app resolution is checked" \
  flutter test test/companion_app_resolution_test.dart
run "hosted is the default resolution strategy" \
  flutter test test/scd66_resolution_strategy_test.dart
run "the package's own smoke test" \
  flutter test test/tom_d4rt_flutter_ast_test.dart

# SCD142: every test file is reachable from SOME runner. SCC48 named its
# isolation test outside the corpus globs on purpose and it was then executed by
# nothing for six weeks — this is what notices the next one.
run "every test file is reachable from a runner" \
  flutter test test/scd142_runner_coverage_test.dart

# SCD141: the two twins execute ONE script corpus, and it lives in this package.
# `tom_d4rt_flutter` has none of its own — its `send_test_runner.dart` points at
# `send_ast_via_http_scripts/` here. A missing path is already loud (the sibling
# suite fails at run time); a SECOND, forked corpus is the silent case, and SCC47
# nearly created one by hand. Pure file I/O.
run "the twins share one script corpus" \
  flutter test test/scd141_shared_corpus_test.dart

# SCD140: every `skip:` in BOTH twins' corpus drivers states a mechanism and
# names evidence a reader can check. A skip is a claim that the interpreter
# cannot be measured here, and twice that claim has been false — SCC47 found one
# asserting a bridge behaviour that does not exist, SCD139 another claiming a
# capability gap that was really a permission gate. Neither named evidence, and
# that is the part a test can check. Pure file I/O over both `test/` dirs.
run "corpus skips state a mechanism and cite evidence" \
  flutter test test/scd140_skip_hygiene_test.dart

# SCD164: every runner that writes metrics.txt attributes it. Both twins
# gitignore `pubspec.lock`, so without the header a testlog folder is a
# pass/skip/fail triple that cannot be matched to the interpreter that produced
# it. The census is globbed from disk and covers `.ps1` as well as `.sh` — a
# `.ps1` left behind is how this corpus once wrote to `doc/` on Windows and
# `testlog/` everywhere else. Pure file I/O over both `test/` dirs.
run "corpus runs record the interpreter they resolved" \
  flutter test test/scd164_run_attribution_test.dart

# The cluster log is a status register, and these keep it honest: the header
# table is DERIVED from the section markers (ISSUES-1/2), no corpus numbers
# live in the header (ISSUES-3), the recorded interpreter pair still describes
# this machine (SCD65), and every open cluster is rated by what the defect can
# REACH rather than by how many consumers currently trip over it
# (ISSUES-4/5/6). Pure file I/O — no companion app.
run "cluster log is derived, dated and blast-radius rated" \
  flutter test test/interpreter_issues_doc_test.dart

if [ "$status" -eq 0 ]; then
  echo "all guards passed"
else
  echo "one or more guards FAILED" >&2
fi
exit "$status"
