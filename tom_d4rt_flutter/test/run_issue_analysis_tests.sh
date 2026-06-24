#!/usr/bin/env bash
#
# Issue-analysis test runner for the D4rt Flutter bridge corpus.
# macOS / Linux (bash). Windows users: run_issue_analysis_tests.ps1.
#
# Runs the 13-file corpus FILE BY FILE, strictly SERIAL. The corpus drives a
# single long-lived companion app over one local HTTP server, so concurrent
# `flutter test` invocations corrupt each other's results. See README.md in
# this folder for the full rationale (serial-only + the 60s per-test timeout).
#
# Usage:
#   ./run_issue_analysis_tests.sh [ID]
#
# ID defaults to <YYYYMMDD-HHMM>-issue-analysis. Pass the SAME ID to the
# sibling project's script so both projects' logs land in an identically named
# testlog/testlog_<ID>/ folder. NEVER run this script for two projects at once —
# even though the AST app and the source-direct app bind different ports, the
# host gets overloaded and the shared-resource contention corrupts results.
#
# Output (per test file <base>):
#   testlog/testlog_<ID>/<base>.result.json  machine-readable (--file-reporter json)
#   testlog/testlog_<ID>/<base>.log.txt       full stdout incl. framework/overflow errors
#   testlog/testlog_<ID>/metrics.txt          per-file exit code + pass/skip/fail summary
#
# NOTE: this script does NOT use `set -e` — a failing test file must not abort
# the remaining files; every file is always attempted.
set -uo pipefail

# Absolute path to this script's dir (captured BEFORE the cd) so the idle
# watchdog wrapper can be located after we change into the project root.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$(dirname "$0")/.."
PROJECT="$(basename "$PWD")"

# Idle-output watchdog: kill a test file that produces NO output for this many
# seconds (default 70 = ~60s per-test max + margin). Catches mid-run stalls AND
# "never reaches the first test" hangs so a wedged transport fails fast instead
# of burning the timeout-900 backstop. Override with IDLE_TIMEOUT=<seconds>.
IDLE_TIMEOUT="${IDLE_TIMEOUT:-80}"

ID="${1:-$(date +%Y%m%d-%H%M)-issue-analysis}"
OUT="testlog/testlog_${ID}"
mkdir -p "$OUT"

# Per-FILE wall-clock backstop so a wedged transport can't hang the whole run.
# (The --timeout 65s below is the PER-TEST limit; this caps an entire file.)
# Uses coreutils `timeout` (Linux) or `gtimeout` (macOS+coreutils) if present;
# otherwise relies on the per-test timeout alone.
TIMEOUT_BIN=()
if command -v timeout >/dev/null 2>&1; then TIMEOUT_BIN=(timeout 900)
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT_BIN=(gtimeout 900); fi

# Full corpus: the flutter_base_NN then flutter_extended_NN split files, in
# numeric order (base before extended, interactive is the last extended file).
# Globbed so the list auto-tracks the generated files; each runs its own app.
FILES=()
for f in test/flutter_base_*_test.dart test/flutter_extended_*_test.dart; do
  [ -e "$f" ] && FILES+=("$(basename "$f")")
done

# Optional targeted re-run: FILES_OVERRIDE="a_test.dart b_test.dart" runs only
# the named files (still serial, still through the idle watchdog), e.g. to
# double-check a subset that failed in a prior full run. Default is the full
# corpus above.
if [ -n "${FILES_OVERRIDE:-}" ]; then
  # shellcheck disable=SC2206  # word-splitting is intentional here.
  FILES=( ${FILES_OVERRIDE} )
fi

echo "== ${PROJECT} :: issue-analysis run ${ID} =="
echo "== output: ${OUT} =="
: > "$OUT/metrics.txt"

for f in "${FILES[@]}"; do
  base="${f%.dart}"
  echo ""
  echo "---- ${f} ----"
  # Guard the array expansion: under `set -u` on bash 3.2 (macOS), expanding an
  # empty array with "${arr[@]}" aborts as an unbound variable. The +-form makes
  # an empty TIMEOUT_BIN expand to nothing instead of erroring.
  #
  # The idle watchdog wraps the run: it streams output to the log (tee-like) and
  # kills the whole process group (returning 124) after IDLE_TIMEOUT seconds of
  # silence. The timeout-900 below remains the chatty-but-stuck wall-clock cap.
  IDLE_TIMEOUT="$IDLE_TIMEOUT" "$SCRIPT_DIR/idle_timeout.sh" \
    "$IDLE_TIMEOUT" "${OUT}/${base}.log.txt" -- \
    "${TIMEOUT_BIN[@]+"${TIMEOUT_BIN[@]}"}" flutter test "test/${f}" \
    --timeout 65s \
    --file-reporter "json:${OUT}/${base}.result.json"
  rc=$?
  # flutter test summary line looks like: "00:42 +45 ~2 -1: Some tests failed."
  summary="$(grep -oE '\+[0-9]+( ~[0-9]+)?( -[0-9]+)?' "${OUT}/${base}.log.txt" | tail -1)"
  note=""
  [ "$rc" = "124" ] && note=" (IDLE-KILLED after ${IDLE_TIMEOUT}s of no output)"
  echo "${base}: exit=${rc} ${summary:-<no summary>}${note}" | tee -a "$OUT/metrics.txt"
done

echo ""
echo "== done. metrics: ${OUT}/metrics.txt =="
echo ""
echo "== re-run this exact ID (copy-paste; e.g. in the sibling project) =="
echo "./test/run_issue_analysis_tests.sh ${ID}"
