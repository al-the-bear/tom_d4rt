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
# doc/testlog_<ID>/ folder. NEVER run this script for two projects at once —
# even though the AST app and the source-direct app bind different ports, the
# host gets overloaded and the shared-resource contention corrupts results.
#
# Output (per test file <base>):
#   doc/testlog_<ID>/<base>.result.json  machine-readable (--file-reporter json)
#   doc/testlog_<ID>/<base>.log.txt       full stdout incl. framework/overflow errors
#   doc/testlog_<ID>/metrics.txt          per-file exit code + pass/skip/fail summary
#
# NOTE: this script does NOT use `set -e` — a failing test file must not abort
# the remaining files; every file is always attempted.
set -uo pipefail

cd "$(dirname "$0")/.."
PROJECT="$(basename "$PWD")"

ID="${1:-$(date +%Y%m%d-%H%M)-issue-analysis}"
OUT="doc/testlog_${ID}"
mkdir -p "$OUT"

# Per-FILE wall-clock backstop so a wedged transport can't hang the whole run.
# (The --timeout 60s below is the PER-TEST limit; this caps an entire file.)
# Uses coreutils `timeout` (Linux) or `gtimeout` (macOS+coreutils) if present;
# otherwise relies on the per-test timeout alone.
TIMEOUT_BIN=()
if command -v timeout >/dev/null 2>&1; then TIMEOUT_BIN=(timeout 900)
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT_BIN=(gtimeout 900); fi

# Spec order: heaviest/most-relevant first, interactive last.
FILES=(
  essential_classes_test.dart
  important_classes_test.dart
  secondary_classes_test.dart
  hardly_relevant_classes_1_test.dart
  hardly_relevant_classes_2_test.dart
  hardly_relevant_classes_3_test.dart
  hardly_relevant_classes_4_test.dart
  hardly_relevant_classes_5_test.dart
  timeout_tests_test.dart
  blocking_tests_test.dart
  generator_interpreter_issues_test.dart
  generator_interpreter_retest_test.dart
  interactive_tests_test.dart
)

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
  "${TIMEOUT_BIN[@]+"${TIMEOUT_BIN[@]}"}" flutter test "test/${f}" \
    --timeout 60s \
    --file-reporter "json:${OUT}/${base}.result.json" \
    2>&1 | tee "${OUT}/${base}.log.txt"
  rc=${PIPESTATUS[0]}
  # flutter test summary line looks like: "00:42 +45 ~2 -1: Some tests failed."
  summary="$(grep -oE '\+[0-9]+( ~[0-9]+)?( -[0-9]+)?' "${OUT}/${base}.log.txt" | tail -1)"
  echo "${base}: exit=${rc} ${summary:-<no summary>}" | tee -a "$OUT/metrics.txt"
done

echo ""
echo "== done. metrics: ${OUT}/metrics.txt =="
echo ""
echo "== re-run this exact ID (copy-paste; e.g. in the sibling project) =="
echo "./test/run_issue_analysis_tests.sh ${ID}"
