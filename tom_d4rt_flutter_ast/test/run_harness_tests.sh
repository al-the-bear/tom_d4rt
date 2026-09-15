#!/usr/bin/env bash
# The HARNESS-level tests — the ones that drive the companion app but are not
# part of the corpus.
#
# WHY A FOURTH RUNNER (SCD142). `run_base_tests.sh` globs
# `test/flutter_base_*_test.dart` and `run_issue_analysis_tests.sh` adds
# `test/flutter_extended_*_test.dart`. SCC48's `framework_error_isolation_test`
# is deliberately named outside both, so that adding it could not shift the
# metrics tables every verification run is compared against. That was the right
# call for the baselines and the wrong outcome for the test: it was executed by
# nothing, and a regression test nobody runs is a comment.
#
# It is the only thing standing between the corpus and a silent return of
# cross-script error attribution — the reading that, on 2026-07-28, nearly had
# twelve independent script defects recorded as one harness bug, and would have
# made every cluster count in `interpreter_issues.md` an upper bound of unknown
# tightness. It is also unusually fragile to SDK drift: its offender probe needs
# Flutter's guard at `list_tile.dart:832` still to admit an opaque `tileColor`.
# F-SCC48-1 detects that and says so loudly — but only if something runs it.
#
# WHY NOT FOLD THESE INTO run_base_tests.sh. Harness tests assert about the
# HARNESS, not about interpreter behaviour. Mixing them into the base metrics
# would reintroduce exactly the baseline instability the naming avoided, and a
# verification entry would then be comparing two different things.
#
# WHY NOT run_guard_tests.sh EITHER. That script is for the fast, transport-free
# checks, and says so: it exists to answer in one second what the corpus answers
# in sixteen minutes. These tests drive one companion app over one local HTTP
# server, so they are serial-only by the same constraint as the corpus.
#
#     ./test/run_harness_tests.sh              # ID = <YYYYMMDD-HHMM>-harness
#     ./test/run_harness_tests.sh my-run-id    # explicit ID
#
# Output lands in `testlog/harnesslog_<ID>/`, matching the corpus runners:
# a `.log.txt`, a `.result.json` and a `metrics.txt` summary per file.
#
# Add a test here when it needs the companion app and is not a corpus file.
# `scd142_runner_coverage_test.dart` fails if a test file ends up reachable from
# no runner at all, so a future harness test cannot repeat SCC48's outcome.

set -uo pipefail
# SCRIPT_DIR resolved BEFORE the cd — after it, `dirname "$0"` still names the
# original relative path and appending /test yields test/test.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$(dirname "$0")/.."
PROJECT="$(basename "$PWD")"

# Matches the corpus runners: a cold companion-app start is slow enough that the
# old 80 s default reported healthy first files as IDLE-KILLED (SCD131).
IDLE_TIMEOUT="${IDLE_TIMEOUT:-300}"

ID="${1:-$(date +%Y%m%d-%H%M)-harness}"
OUT="testlog/harnesslog_${ID}"
mkdir -p "$OUT"

TIMEOUT_BIN=()
if command -v timeout >/dev/null 2>&1; then TIMEOUT_BIN=(timeout 900)
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT_BIN=(gtimeout 900); fi

# Globbed, not listed: a list is one more thing to forget, which is the defect
# this script exists to fix. `*_isolation_test.dart` is the naming convention for
# a harness-level test; `scd142_runner_coverage_test.dart` is what notices if a
# future one is named outside it.
FILES=()
for f in test/*_isolation_test.dart; do
  [ -e "$f" ] && FILES+=("$(basename "$f")")
done

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "no harness tests matched test/*_isolation_test.dart" >&2
  exit 1
fi

echo "== ${PROJECT} :: harness-test run ${ID} =="
echo "== output: ${OUT} =="
: > "$OUT/metrics.txt"

# Resolve the companion app before the first file, for the same reason the
# corpus runners do: it is a separate package with its own gitignored lock, and
# the harness refuses to launch one out of step with this package.
APP_DIR="test/tom_d4rt_flutter_ast_app"
echo "== resolving ${APP_DIR} =="
if ! pub_out="$(cd "$APP_DIR" && flutter pub get 2>&1)"; then
  echo "$pub_out"
  echo "companion app: flutter pub get failed in ${APP_DIR}" | tee -a "$OUT/metrics.txt"
  exit 1
fi

status=0
for f in "${FILES[@]}"; do
  base="${f%.dart}"
  echo ""
  echo "---- ${f} ----"
  IDLE_TIMEOUT="$IDLE_TIMEOUT" "$SCRIPT_DIR/idle_timeout.sh" \
    "$IDLE_TIMEOUT" "${OUT}/${base}.log.txt" -- \
    "${TIMEOUT_BIN[@]+"${TIMEOUT_BIN[@]}"}" flutter test "test/${f}" \
    --timeout 65s \
    --file-reporter "json:${OUT}/${base}.result.json"
  rc=$?
  [ "$rc" -ne 0 ] && status=1
  summary="$(grep -oE '\+[0-9]+( ~[0-9]+)?( -[0-9]+)?' "${OUT}/${base}.log.txt" | tail -1)"
  note=""
  [ "$rc" = "124" ] && note=" (IDLE-KILLED after ${IDLE_TIMEOUT}s of no output)"
  echo "${base}: exit=${rc} ${summary:-<no summary>}${note}" | tee -a "$OUT/metrics.txt"
done

echo ""
echo "== done. metrics: ${OUT}/metrics.txt =="
echo ""
echo "== re-run this exact ID (copy-paste; e.g. in the sibling project) =="
echo "./test/run_harness_tests.sh ${ID}"
exit "$status"
