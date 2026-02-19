#!/bin/bash
# test_stdin.sh — Integration tests for dcli --stdin smart preprocessing
#
# Usage:
#   ./test_stdin.sh [project_root] [dcli_binary_path]
#
# If project_root is not provided, the script assumes it is run from the
# tom_dcli_exec project directory.
#
# If dcli_binary_path is not provided, falls back to compiling
# bin/dclie.dart into bin/dclie (or reuses an existing binary).
#
# Exit codes:
#   0 — all tests passed
#   1 — one or more tests failed

set -euo pipefail

PROJECT_ROOT="${1:-$(cd "$(dirname "$0")/../.." && pwd)}"
DCLI_BINARY="${2:-}"
PASS=0
FAIL=0
TOTAL=0

# Colors (disabled if not a terminal)
if [ -t 1 ]; then
  GREEN='\033[0;32m'
  RED='\033[0;31m'
  YELLOW='\033[0;33m'
  CYAN='\033[0;36m'
  NC='\033[0m'
else
  GREEN='' RED='' YELLOW='' CYAN='' NC=''
fi

# --------------------------------------------------------------------------
# Helpers
# --------------------------------------------------------------------------

run_dcli_stdin() {
  # Run dcli --stdin with the given input string.
  # Returns the exit code; stdout/stderr captured in global vars.
  local input="$1"
  set +e
  STDOUT=$(echo "$input" | $DCLI_CMD --stdin 2>"$TMPDIR_TEST/stderr.txt")
  EXIT_CODE=$?
  STDERR=$(cat "$TMPDIR_TEST/stderr.txt")
  set -e
}

assert_exit_code() {
  local expected="$1"
  local label="$2"
  TOTAL=$((TOTAL + 1))
  if [ "$EXIT_CODE" -eq "$expected" ]; then
    PASS=$((PASS + 1))
    printf "${GREEN}  ✓${NC} %s (exit=%d)\n" "$label" "$EXIT_CODE"
  else
    FAIL=$((FAIL + 1))
    printf "${RED}  ✗${NC} %s — expected exit %d, got %d\n" "$label" "$expected" "$EXIT_CODE"
    if [ -n "$STDERR" ]; then
      printf "    stderr: %s\n" "$STDERR"
    fi
  fi
}

assert_stdout_contains() {
  local expected="$1"
  local label="$2"
  TOTAL=$((TOTAL + 1))
  if echo "$STDOUT" | grep -qF "$expected"; then
    PASS=$((PASS + 1))
    printf "${GREEN}  ✓${NC} %s\n" "$label"
  else
    FAIL=$((FAIL + 1))
    printf "${RED}  ✗${NC} %s — stdout does not contain '%s'\n" "$label" "$expected"
    printf "    stdout: %s\n" "$STDOUT"
  fi
}

assert_stdout_equals() {
  local expected="$1"
  local label="$2"
  TOTAL=$((TOTAL + 1))
  # Trim trailing whitespace/newlines for comparison
  local actual
  actual=$(echo "$STDOUT" | sed 's/[[:space:]]*$//')
  expected=$(echo "$expected" | sed 's/[[:space:]]*$//')
  if [ "$actual" = "$expected" ]; then
    PASS=$((PASS + 1))
    printf "${GREEN}  ✓${NC} %s\n" "$label"
  else
    FAIL=$((FAIL + 1))
    printf "${RED}  ✗${NC} %s — expected '%s', got '%s'\n" "$label" "$expected" "$actual"
  fi
}

assert_stderr_contains() {
  local expected="$1"
  local label="$2"
  TOTAL=$((TOTAL + 1))
  if echo "$STDERR" | grep -qF "$expected"; then
    PASS=$((PASS + 1))
    printf "${GREEN}  ✓${NC} %s\n" "$label"
  else
    FAIL=$((FAIL + 1))
    printf "${RED}  ✗${NC} %s — stderr does not contain '%s'\n" "$label" "$expected"
    printf "    stderr: %s\n" "$STDERR"
  fi
}

# --------------------------------------------------------------------------
# Setup
# --------------------------------------------------------------------------

TMPDIR_TEST=$(mktemp -d)
trap 'rm -rf "$TMPDIR_TEST"' EXIT

cd "$PROJECT_ROOT"

# Ensure we have a compiled binary for fast execution.
if [ -z "$DCLI_BINARY" ]; then
  DCLI_BINARY="$PROJECT_ROOT/bin/dclie"
  if [ ! -x "$DCLI_BINARY" ] || \
     [ "$PROJECT_ROOT/bin/dclie.dart" -nt "$DCLI_BINARY" ]; then
    printf "${YELLOW}Compiling dclie binary...${NC}\n"
    dart compile exe "$PROJECT_ROOT/bin/dclie.dart" -o "$DCLI_BINARY" 2>&1
  fi
fi
DCLI_CMD="$DCLI_BINARY"

printf "${CYAN}══════════════════════════════════════════════════════════════${NC}\n"
printf "${CYAN}  dcli --stdin Smart Preprocessing Tests${NC}\n"
printf "${CYAN}══════════════════════════════════════════════════════════════${NC}\n\n"

# --------------------------------------------------------------------------
# Case 1: Bare statements — auto-import + auto-wrap in main
# --------------------------------------------------------------------------

printf "${YELLOW}Case 1: Bare statements (auto-import, auto-wrap)${NC}\n"

run_dcli_stdin 'print("hello stdin");'
assert_exit_code 0 "bare print statement exits 0"
assert_stdout_contains "hello stdin" "bare print statement output"

run_dcli_stdin 'return 42;'
assert_exit_code 42 "bare return int → exit code 42"

run_dcli_stdin 'return 0;'
assert_exit_code 0 "bare return 0 → exit code 0"

run_dcli_stdin 'var x = 10 + 32;
print(x);'
assert_exit_code 0 "multi-line bare statements exit 0"
assert_stdout_contains "42" "multi-line bare computes correctly"

# Test bridge availability (dart:math from stdlib imports)
run_dcli_stdin 'print(max(3, 7));'
assert_exit_code 0 "stdlib bridges available in bare mode"
assert_stdout_contains "7" "dart:math max() works"

# Test dart:io availability
run_dcli_stdin 'print(Platform.operatingSystem);'
assert_exit_code 0 "dart:io Platform available in bare mode"

echo ""

# --------------------------------------------------------------------------
# Case 2: Has main() but no imports — auto-prefix imports
# --------------------------------------------------------------------------

printf "${YELLOW}Case 2: main() without imports (auto-prefix imports)${NC}\n"

run_dcli_stdin 'void main() {
  print("hello from main");
}'
assert_exit_code 0 "void main without imports exits 0"
assert_stdout_contains "hello from main" "void main output correct"

run_dcli_stdin 'Object main(List<String> args) {
  print(max(5, 9));
  return 0;
}'
assert_exit_code 0 "Object main with bridge usage exits 0"
assert_stdout_contains "9" "bridge imports auto-prefixed for main"

run_dcli_stdin 'int main() {
  return 7;
}'
assert_exit_code 7 "int main() return value used as exit code"

echo ""

# --------------------------------------------------------------------------
# Case 3: Complete script with imports and main — execute as-is
# --------------------------------------------------------------------------

printf "${YELLOW}Case 3: Complete script (imports + main)${NC}\n"

run_dcli_stdin "import 'dart:math';
void main() {
  print(max(100, 200));
}"
assert_exit_code 0 "complete script exits 0"
assert_stdout_contains "200" "complete script output correct"

run_dcli_stdin "import 'dart:io';

void main() {
  print('os: \${Platform.operatingSystem}');
}"
assert_exit_code 0 "complete script with dart:io exits 0"
assert_stdout_contains "os:" "complete script accesses dart:io"

echo ""

# --------------------------------------------------------------------------
# Error handling
# --------------------------------------------------------------------------

printf "${YELLOW}Error handling${NC}\n"

# Empty stdin
set +e
STDOUT=$(echo "" | $DCLI_CMD --stdin 2>"$TMPDIR_TEST/stderr.txt")
EXIT_CODE=$?
STDERR=$(cat "$TMPDIR_TEST/stderr.txt")
set -e
assert_exit_code 1 "empty stdin exits 1"
assert_stderr_contains "No input" "empty stdin error message"

# Unclosed string — parser is lenient, treats as valid (prints partial)
run_dcli_stdin 'void main() { print("unclosed }'
assert_exit_code 0 "unclosed string is lenient (parser recovers)"

# Actual syntax error — incomplete expression
run_dcli_stdin 'void main() {
  int x = 10 +;
  print(x);
}'
assert_exit_code 2 "syntax error exits 2"

# Runtime error (undefined variable)
run_dcli_stdin 'print(undefinedVariable123);'
assert_exit_code 2 "runtime error exits 2"

echo ""

# --------------------------------------------------------------------------
# Summary
# --------------------------------------------------------------------------

printf "${CYAN}══════════════════════════════════════════════════════════════${NC}\n"
if [ "$FAIL" -eq 0 ]; then
  printf "${GREEN}  All %d tests passed ✓${NC}\n" "$TOTAL"
else
  printf "${RED}  %d of %d tests failed ✗${NC}\n" "$FAIL" "$TOTAL"
fi
printf "${CYAN}══════════════════════════════════════════════════════════════${NC}\n"

exit "$FAIL"
