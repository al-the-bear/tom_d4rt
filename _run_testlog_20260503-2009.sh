#!/usr/bin/env bash
# Driver for testlog 20260503-2009-issue-analysis.
# Runs the 14 standard test files SERIALLY in tom_d4rt_flutter_ast,
# then SERIALLY in tom_d4rt_flutter_test (never parallel — port 4242
# is a shared HTTP server).

set -u
ID="20260503-2009-issue-analysis"
ROOT="/srv/repos/al_the_bear/inhouse/second_wind/enterprise_flutter/tom_agent_container/tom_ai/d4rt"

FILES=(
  essential_classes_test.dart
  important_classes_test.dart
  secondary_classes_test.dart
  hardly_relevant_classes_1_test.dart
  hardly_relevant_classes_2_test.dart
  hardly_relevant_classes_3_test.dart
  hardly_relevant_classes_4_test.dart
  hardly_relevant_classes_5_test.dart
  crashing_tests_test.dart
  timeout_tests_test.dart
  blocking_tests_test.dart
  generator_interpreter_issues_test.dart
  generator_interpreter_retest_test.dart
  interactive_tests_test.dart
)

export D4RT_SKIP_BRIDGE_REGEN=1

run_project() {
  local proj="$1"
  cd "$ROOT/$proj" || exit 1
  local dir="doc/testlog_$ID"
  echo "=== Project: $proj ==="
  for f in "${FILES[@]}"; do
    local base="${f%.dart}"
    local json="$dir/${base}.result.json"
    local log="$dir/${base}.log.txt"
    echo ">>> [$proj] $f -> $json"
    date
    flutter test "test/$f" --file-reporter "json:$json" 2>&1 | tee "$log"
    echo "<<< [$proj] $f exit=${PIPESTATUS[0]}"
    echo
  done
}

run_project tom_d4rt_flutter_ast
run_project tom_d4rt_flutter_test
echo "=== ALL DONE ==="
date
