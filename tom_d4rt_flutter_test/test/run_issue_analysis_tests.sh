#!/usr/bin/env bash
#
# Issue-analysis test runner for the D4rt source-direct Flutter twin
# (tom_d4rt_flutter_test). macOS / Linux (bash).
#
# Sibling of tom_d4rt_flutter_ast/test/run_issue_analysis_tests.sh — same output
# contract and the same idle watchdog, but this project does NOT carry the
# 13-file flutter-material corpus. It holds the two in-process sample/asset
# tests, which run via SourceFlutterD4rt.buildMultiFile inside WidgetTester
# (no shared long-lived HTTP companion app). They are still run FILE BY FILE,
# strictly SERIAL, and you must NEVER run this script for two projects at once
# (host-overload contention corrupts results — see the AST README.md).
#
# Usage:
#   ./run_issue_analysis_tests.sh [ID]
#
# ID defaults to <YYYYMMDD-HHMM>-issue-analysis. Pass the SAME ID the sibling
# project used so both projects' logs land in an identically named
# testlog/testlog_<ID>/ folder.
#
# Output (per test file <base>):
#   testlog/testlog_<ID>/<base>.result.json  machine-readable (--file-reporter json)
#   testlog/testlog_<ID>/<base>.log.txt       full stdout incl. framework/overflow errors
#   testlog/testlog_<ID>/metrics.txt          per-file exit code + pass/skip/fail summary
#
# NOTE: no `set -e` — a failing file must not abort the rest.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$(dirname "$0")/.."
PROJECT="$(basename "$PWD")"

# Idle-output watchdog: kill a test file that produces NO output for this many
# seconds. Override with IDLE_TIMEOUT=<seconds>.
IDLE_TIMEOUT="${IDLE_TIMEOUT:-70}"

ID="${1:-$(date +%Y%m%d-%H%M)-issue-analysis}"
OUT="testlog/testlog_${ID}"
mkdir -p "$OUT"

# Per-FILE wall-clock backstop (coreutils timeout/gtimeout if present).
TIMEOUT_BIN=()
if command -v timeout >/dev/null 2>&1; then TIMEOUT_BIN=(timeout 900)
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT_BIN=(gtimeout 900); fi

# This project's test files (no corpus here — just the two real tests).
FILES=(
  asset_sample_source_test.dart
  sample_apps_in_tester_test.dart
)

echo "== ${PROJECT} :: issue-analysis run ${ID} =="
echo "== output: ${OUT} =="
: > "$OUT/metrics.txt"

for f in "${FILES[@]}"; do
  base="${f%.dart}"
  echo ""
  echo "---- ${f} ----"
  IDLE_TIMEOUT="$IDLE_TIMEOUT" "$SCRIPT_DIR/idle_timeout.sh" \
    "$IDLE_TIMEOUT" "${OUT}/${base}.log.txt" -- \
    "${TIMEOUT_BIN[@]+"${TIMEOUT_BIN[@]}"}" flutter test "test/${f}" \
    --timeout 60s \
    --file-reporter "json:${OUT}/${base}.result.json"
  rc=$?
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
