#!/usr/bin/env bash
#
# run_test_profiler.sh — drive the source-direct D4rt Flutter corpus against an
# ALREADY-RUNNING test app, for a manual profiling session. macOS / Linux (bash).
#
# TWO-TERMINAL WORKFLOW
#   Terminal 1:  ./test/start_test_profiler.sh         # starts + keeps the app
#   Terminal 2:  ./test/run_test_profiler.sh [patterns...]   # <- this script
#
# Unlike run_base_tests.sh (which launches a fresh app PER FILE), this driver
# runs the selected flutter_base_* / flutter_extended_* files in a SINGLE,
# strictly-serial `flutter test` invocation and connects to the one long-lived
# app that start_test_profiler.sh already launched (D4RT_USE_RUNNING_APP=1). That
# is what keeps a single DevTools recording valid across the whole corpus — the
# app is never torn down or relaunched mid-run.
#
# FILE SELECTION (positional args, short form; default "*")
#   ./run_test_profiler.sh                 # all flutter_base_* + flutter_extended_*
#   ./run_test_profiler.sh '*'             # same as default
#   ./run_test_profiler.sh base_01         # only flutter_base_01_test.dart
#   ./run_test_profiler.sh '*base*'        # all flutter_base_* files
#   ./run_test_profiler.sh '*base*' '*extended*'   # both groups (== default)
#   Each ARG is expanded as  test/flutter_<ARG>_test.dart  (ARG may contain *).
#   QUOTE patterns containing '*' so the shell doesn't expand them first.
#
# Init-path [PROFILE] spans only appear when D4rtProfiler.enabled == true in
# tom_d4rt (see start_test_profiler.sh header). With it off the run still works;
# you just won't see the per-phase init breakdown lines.
#
# No concurrency (--concurrency=1), per-test --timeout 65s, idle-output watchdog.
# Output: streamed to the console AND written to testlog/profiling/run_<ts>/.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$(dirname "$0")/.."
PROJECT="$(basename "$PWD")"
PORT="${TOM_D4RT_TEST_TEST_PORT:-4248}"
IDLE_TIMEOUT="${IDLE_TIMEOUT:-80}"

# --- Resolve which test files to run from the short-form patterns. -----------
PATTERNS=("$@")
[ "${#PATTERNS[@]}" -eq 0 ] && PATTERNS=("*")

FILES=()
for pat in "${PATTERNS[@]}"; do
  for f in test/flutter_${pat}_test.dart; do
    [ -e "$f" ] && FILES+=("$f")
  done
done

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "ERROR: no test files matched: ${PATTERNS[*]}" >&2
  echo "       (patterns expand as test/flutter_<pattern>_test.dart)" >&2
  exit 2
fi

# Dedupe + sort for a stable, serial order.
IFS=$'\n' FILES=($(printf '%s\n' "${FILES[@]}" | sort -u)); unset IFS

# --- Pre-flight: the app must already be up (start_test_profiler.sh). ---------
if ! curl -fsS "http://localhost:${PORT}/health" >/dev/null 2>&1; then
  echo "ERROR: no test app responding on http://localhost:${PORT}/health" >&2
  echo "       Start it first in another terminal:  ./test/start_test_profiler.sh" >&2
  exit 1
fi

TS="$(date +%Y%m%d-%H%M%S)"
OUT="testlog/profiling/run_${TS}"
mkdir -p "$OUT"
LOG="$OUT/run.log"

echo "== ${PROJECT} :: profiling run ${TS} =="
echo "== app port:   ${PORT} (using already-running app; not relaunching)"
echo "== files (${#FILES[@]}):"
for f in "${FILES[@]}"; do echo "==   $f"; done
echo "== output:     ${OUT}/"
echo "== idle watchdog: ${IDLE_TIMEOUT}s"
echo ""

# Connect to the running app, never start/own/regenerate one.
export D4RT_USE_RUNNING_APP=1

"$SCRIPT_DIR/idle_timeout.sh" "$IDLE_TIMEOUT" "$LOG" -- \
  flutter test "${FILES[@]}" \
  --concurrency=1 \
  --timeout 65s \
  --file-reporter "json:${OUT}/results.json"
rc=$?

# Extract the profiler / metric lines into easy-to-read summaries.
grep -aE '^\[PROFILE\]' "$LOG" > "$OUT/profile.txt" 2>/dev/null || true
grep -aE '^\[METRIC\]'  "$LOG" > "$OUT/metric.txt"  2>/dev/null || true

echo ""
echo "== done (exit=${rc}). =="
echo "== full log:     ${OUT}/run.log"
echo "== [PROFILE]:    ${OUT}/profile.txt  ($(wc -l < "$OUT/profile.txt" 2>/dev/null | tr -d ' ') lines)"
echo "== [METRIC]:     ${OUT}/metric.txt"
if [ ! -s "$OUT/profile.txt" ]; then
  echo "== NOTE: no [PROFILE] lines — D4rtProfiler.enabled is false (profiler compiled out)."
  echo "==       Flip it to true in tom_d4rt + rebuild the app to capture init-path spans."
fi
exit "$rc"
