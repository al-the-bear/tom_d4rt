#!/usr/bin/env bash
#
# sweep_both_projects.sh — periodic full-corpus regression sweep
# for tom_d4rt_flutter_ast (AST-bundle path) and tom_d4rt_flutter_test
# (source-direct path).
#
# Usage:
#   tom_d4rt_flutter_ast/tool/sweep_both_projects.sh <testlog-folder> [<ast-port>] [<test-port>]
#
# Required: <testlog-folder>
#     Folder name under each project's doc/ where outputs land.
#     Example: testlog_20260530-0900-issue-analysis
#
# Optional: <ast-port>   (default 14250) — TOM_D4RT_AST_TEST_PORT value
# Optional: <test-port>  (default 14251) — TOM_D4RT_TEST_TEST_PORT value
#
# Outputs (created automatically):
#   tom_d4rt_flutter_ast/doc/<testlog-folder>/<file>.{log.txt,result.json}
#   tom_d4rt_flutter_test/doc/<testlog-folder>/<file>.{log.txt,result.json}
#
# Sweep mode:
#   - Both projects in parallel (different ports), per the 20260528-2206
#     analysis methodology — they use separate test_apps so concurrent
#     flutter test invocations across projects are safe.
#   - Files SERIAL within each project — required by the workspace rule
#     "Never run multiple flutter test invocations in parallel in this
#     package" (concurrent runs corrupt the shared HTTP server state).
#   - Per-file budget per the 1919 analysis §7 recommendations.
#
# Notes:
#   - macOS bash 3.2 compatible (uses case statement, NOT declare -A).
#   - D4RT_SKIP_BRIDGE_REGEN=1 is set so the run does not re-trigger
#     bridge regeneration mid-sweep.
#   - Existing per-file outputs in <testlog-folder> are overwritten.
#
# Origin: distilled from /tmp/sweep_2206.sh used for
# testlog_20260528-2206-issue-analysis; promoted here per the
# 2206 testlog's TODO #39 for reproducibility.
#

set -u

if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]; then
  echo "Usage: $0 <testlog-folder> [<ast-port>] [<test-port>]" >&2
  exit 64  # EX_USAGE
fi

TESTLOG_FOLDER="$1"
AST_PORT="${2:-14250}"
TEST_PORT="${3:-14251}"

# Resolve the d4rt repo root (tom_ai/d4rt/...). Use git for robustness.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
AST_PROJ="$REPO_ROOT/tom_d4rt_flutter_ast"
TEST_PROJ="$REPO_ROOT/tom_d4rt_flutter_test"

if [ ! -d "$AST_PROJ" ] || [ ! -d "$TEST_PROJ" ]; then
  echo "Error: expected projects not found:" >&2
  echo "  $AST_PROJ" >&2
  echo "  $TEST_PROJ" >&2
  exit 1
fi

# --- per-file budget table (macOS bash 3.2 compatible) ----------------
budget_for() {
  case "$1" in
    essential_classes_test)               echo 300 ;;
    important_classes_test)               echo 900 ;;  # 2206 found 300s insufficient
    secondary_classes_test)               echo 2400 ;;
    hardly_relevant_classes_*)            echo 1200 ;;
    crashing_tests_test)                  echo 300 ;;
    timeout_tests_test)                   echo 900 ;;
    blocking_tests_test)                  echo 300 ;;
    generator_interpreter_issues_test)    echo 900 ;;
    generator_interpreter_retest_test)    echo 900 ;;
    interactive_tests_test)               echo 900 ;;
    *)                                    echo 600 ;;
  esac
}

# Standard 14-file corpus order.
FILES=(
  essential_classes_test
  important_classes_test
  secondary_classes_test
  hardly_relevant_classes_1_test
  hardly_relevant_classes_2_test
  hardly_relevant_classes_3_test
  hardly_relevant_classes_4_test
  hardly_relevant_classes_5_test
  crashing_tests_test
  timeout_tests_test
  blocking_tests_test
  generator_interpreter_issues_test
  generator_interpreter_retest_test
  interactive_tests_test
)

# --- inner: serial per-file sweep within one project ------------------
# Args: $1 = project root, $2 = env var name, $3 = env var value
sweep_one_project() {
  local PROJ="$1"
  local ENVVAR="$2"
  local PORT="$3"
  local PROJ_NAME
  PROJ_NAME=$(basename "$PROJ")
  local LOG="$PROJ/doc/$TESTLOG_FOLDER"
  mkdir -p "$LOG"
  cd "$PROJ" || return 1

  for f in "${FILES[@]}"; do
    local BUDGET TS PID ELAPSED
    BUDGET=$(budget_for "$f")
    TS=$(date '+%H:%M:%S')
    echo "[$TS] [$PROJ_NAME/$f] starting (budget=${BUDGET}s)"
    ( env "$ENVVAR=$PORT" D4RT_SKIP_BRIDGE_REGEN=1 \
        flutter test "test/$f.dart" \
          --file-reporter "json:$LOG/$f.result.json" \
        > "$LOG/$f.log.txt" 2>&1 ) &
    PID=$!
    ELAPSED=0
    while [ "$ELAPSED" -lt "$BUDGET" ]; do
      sleep 10
      if ! kill -0 $PID 2>/dev/null; then break; fi
      ELAPSED=$((ELAPSED + 10))
    done
    if kill -0 $PID 2>/dev/null; then
      kill -9 $PID 2>/dev/null
      wait $PID 2>/dev/null
      TS=$(date '+%H:%M:%S')
      echo "[$TS] [$PROJ_NAME/$f] KILLED after ${BUDGET}s budget"
    else
      TS=$(date '+%H:%M:%S')
      echo "[$TS] [$PROJ_NAME/$f] finished within budget at ${ELAPSED}s"
    fi
    # Brief settle before next file (matches /tmp/sweep_2206.sh).
    sleep 5
  done
  echo "DONE: $PROJ"
}

# --- launch both projects in parallel ---------------------------------
echo "sweep_both_projects: starting at $(date '+%Y-%m-%d %H:%M:%S')"
echo "  AST  project: $AST_PROJ   (TOM_D4RT_AST_TEST_PORT=$AST_PORT)"
echo "  TEST project: $TEST_PROJ  (TOM_D4RT_TEST_TEST_PORT=$TEST_PORT)"
echo "  Testlog folder under each doc/: $TESTLOG_FOLDER"
echo

sweep_one_project "$AST_PROJ"  TOM_D4RT_AST_TEST_PORT  "$AST_PORT"  &
AST_PID=$!
sweep_one_project "$TEST_PROJ" TOM_D4RT_TEST_TEST_PORT "$TEST_PORT" &
TEST_PID=$!

wait $AST_PID
AST_EXIT=$?
wait $TEST_PID
TEST_EXIT=$?

echo
echo "sweep_both_projects: finished at $(date '+%Y-%m-%d %H:%M:%S')"
echo "  AST exit:  $AST_EXIT"
echo "  TEST exit: $TEST_EXIT"

# Surface a non-zero exit if either project hit an unrecoverable error
# (per-file timeouts inside the loop are not propagated as failures —
# that's expected behaviour, captured in the .log.txt files for analysis).
if [ "$AST_EXIT" -ne 0 ] || [ "$TEST_EXIT" -ne 0 ]; then
  exit 1
fi
exit 0
