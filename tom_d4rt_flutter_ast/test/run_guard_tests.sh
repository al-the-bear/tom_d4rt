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

# TWO KINDS OF CHECK. `run` is a check whose subject is THIS package alone.
# `pair` is one whose subject includes the source twin (tom_d4rt_flutter): the
# shared user bridges, both twins' drivers and runners, the duplicated
# registrations and test infrastructure, the repo-wide doc/ and pubspec rules.
#
# The pair checks live here, once, because two copies of a cross-twin check
# report identically on every run. The source twin's own runner calls this
# script with `--pair`, so "run the guards" covers the same pair checks from
# either side, with no second list of them to drift. Before this existed, a
# session working in tom_d4rt_flutter got 4 checks and no sign that 16 more
# covered the files it was editing.
#
# `scd142_runner_coverage_test.dart` (F-SCE171-*) fails when a check whose test
# file names a path into ../tom_d4rt_flutter is tagged `run`, and when the
# source twin's runner stops calling `--pair`.
mode=all
if [ "${1:-}" = "--pair" ]; then
  mode=pair
  echo "pair guards (live in tom_d4rt_flutter_ast; subject includes tom_d4rt_flutter):"
fi

check() {
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

run() {
  [ "$mode" = pair ] && return 0
  check "$@"
}

pair() {
  check "$@"
}

# The user-bridge de-dup. `--check` is the same code path the test asserts, and
# is run directly so this script stays useful even when `dart test` cannot
# start (no pub get, a broken lock).
pair "user-bridge sync (tool --check)" \
  dart run tool/sync_shared_user_bridges.dart --check

# The test that pins the PROPERTY rather than the tool's exit code — SCC37
# replaced a hand-written basename list with the intersection of the two
# directories, and this is what holds that.
# `flutter test`, not `dart test`: this is a Flutter package, and `package:test`
# reaches it only through `flutter_test`. It is still transport-free — the file
# does pure file I/O and needs no companion app.
pair "user-bridge sync (test)" \
  flutter test test/sync_shared_user_bridges_test.dart

# SCD110: `doc/` holds no runner output — tracked tree, this machine's disk, the
# runner scripts, and the `.gitignore` ratchet. It lives in `tom_d4rt` because it
# is a REPO-wide invariant (the same reason `release_hygiene_test.dart` does),
# and it is run from here because this is the repo's only assembled set of fast
# guards. `dart test`, not `flutter test`: `tom_d4rt` is a plain Dart package.
pair "doc/ holds no runner output" \
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
pair "companion app resolution is checked" \
  flutter test test/companion_app_resolution_test.dart
pair "hosted is the default resolution strategy" \
  flutter test test/scd66_resolution_strategy_test.dart
run "the package's own smoke test" \
  flutter test test/tom_d4rt_flutter_ast_test.dart

# SCD142: every test file is reachable from SOME runner. SCC48 named its
# isolation test outside the corpus globs on purpose and it was then executed by
# nothing for six weeks — this is what notices the next one.
pair "every test file is reachable from a runner" \
  flutter test test/scd142_runner_coverage_test.dart

# SCD141: the two twins execute ONE script corpus, and it lives in this package.
# `tom_d4rt_flutter` has none of its own — its `send_test_runner.dart` points at
# `send_ast_via_http_scripts/` here. A missing path is already loud (the sibling
# suite fails at run time); a SECOND, forked corpus is the silent case, and SCC47
# nearly created one by hand. Pure file I/O.
pair "the twins share one script corpus" \
  flutter test test/scd141_shared_corpus_test.dart

# SCE157: the `dynamic` registry lookup in BOTH twins' scd133 is a deferral with
# an expiry — `tom_d4rt` exports `BridgedEnum` from 1.109.0 and the sibling twin
# still declares ^1.77.0. This fires the moment that floor moves, in the commit
# that moves it. Pure file I/O over both `test/` dirs and one pubspec.
pair "the scd133 dynamic deferral has not expired" \
  flutter test test/sce157_typed_registry_pending_test.dart

# SCD140: every `skip:` in BOTH twins' corpus drivers states a mechanism and
# names evidence a reader can check. A skip is a claim that the interpreter
# cannot be measured here, and twice that claim has been false — SCC47 found one
# asserting a bridge behaviour that does not exist, SCD139 another claiming a
# capability gap that was really a permission gate. Neither named evidence, and
# that is the part a test can check. Pure file I/O over both `test/` dirs.
pair "corpus skips state a mechanism and cite evidence" \
  flutter test test/scd140_skip_hygiene_test.dart

# SCD164: every runner that writes metrics.txt attributes it. Both twins
# gitignore `pubspec.lock`, so without the header a testlog folder is a
# pass/skip/fail triple that cannot be matched to the interpreter that produced
# it. The census is globbed from disk and covers `.ps1` as well as `.sh` — a
# `.ps1` left behind is how this corpus once wrote to `doc/` on Windows and
# `testlog/` everywhere else. Pure file I/O over both `test/` dirs.
pair "corpus runs record the interpreter they resolved" \
  flutter test test/scd164_run_attribution_test.dart

# The cluster log is a status register, and these keep it honest: the header
# table is DERIVED from the section markers (ISSUES-1/2), no corpus numbers
# live in the header (ISSUES-3), the recorded interpreter pair still describes
# this machine (SCD65), and every open cluster is rated by what the defect can
# REACH rather than by how many consumers currently trip over it
# (ISSUES-4/5/6). Pure file I/O — no companion app.
pair "cluster log is derived, dated and blast-radius rated" \
  flutter test test/interpreter_issues_doc_test.dart

# SCE158: the generator issues log carries a state per entry and its header
# register is derived from them. Same failure the cluster log had before its
# header was derived, at twelve times the size — 36 written-out analyses and no
# way to tell which were still outstanding. Pure file I/O, no transport.
run "generator issues log is a derived register" \
  flutter test test/sce158_generator_issues_doc_test.dart

# SCE159: the open-issues doc rates every open entry by blast radius and derives
# its header register from the entries — including the red set and the
# open-but-green set, which is the one cross-check the cluster log has no
# equivalent of. Pure file I/O; it deliberately does not RUN the reproduction
# suite, whose red is correct by design.
run "open-issues doc is rated and derived" \
  flutter test test/sce159_open_issues_doc_test.dart

# SCE164: the twins' hand-duplicated proxy registries agree, every proxy exposes
# its interpreted instance, and the two bases measured-and-withheld stay
# unregistered. Pure file I/O over both registration files.
pair "proxy registries agree across the twins" \
  flutter test test/sce164_proxy_registry_parity_test.dart

# SCE165: the twins' ~200 KB hand-duplicated d4rt_runtime_registrations.dart
# agrees line for line below its import prologue. The largest duplication in the
# repo and, until now, the only one with no mechanism at all. Pure file I/O.
pair "runtime registrations mirror below the prologue" \
  flutter test test/sce165_runtime_registrations_mirror_test.dart

# SCE167: all 41 corpus drivers in BOTH twins ask one helper what a pass is, and
# the gating flip is keyed to the floor that makes it free. Pure file I/O.
pair "one definition of a passing corpus script" \
  flutter test test/sce167_pass_verdict_convention_test.dart

# SCE13: the harness's bridge step stays visible, content-decided and
# uncommitted. Source-shape only, and deliberately so — the property it stands
# for ("a fresh package is left untouched") needs a ~45 s generation to observe,
# which is exactly the cost this runner exists to keep out of the cheap set.
run "bridge step is streamed and content-decided" \
  flutter test test/sce13_bridge_gate_test.dart

# SCE14: both twins kill the app as a process TREE, wait for the build database
# before retrying, and report both attempts. Repo-wide (it reads the sibling's
# runner too) and source-shape only — the behaviour needs a ~3 min cold platform
# build to observe, which is exactly the cost this runner keeps out.
pair "launch retry leaves no orphaned build" \
  flutter test test/sce14_launch_retry_test.dart

# SCE172: the harness's flutter/dart lookup, pinned to the `where` output
# measured on legiondary01. Pure; its Windows branch otherwise runs only there.
run "tool lookup picks a runnable file on Windows" \
  flutter test test/tool_resolution_test.dart

# SCE170: every non-driver file both twins carry in test/ is classified, the
# derivable ones agree as CODE modulo the twin parameters, and none carries the
# other twin's parameter. Repo-wide (it reads the sibling's test/). Pure file I/O.
pair "shared test infrastructure agrees across the twins" \
  flutter test test/sce170_twin_test_infrastructure_test.dart

if [ "$mode" = pair ]; then
  scope="pair guards"
else
  scope="guards"
fi
if [ "$status" -eq 0 ]; then
  echo "all $scope passed"
else
  echo "one or more $scope FAILED" >&2
fi
exit "$status"
