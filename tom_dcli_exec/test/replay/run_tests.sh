#!/bin/bash
# DCli Replay Test Runner
# Runs all replay tests in the test/replay directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
TEST_DIR="$PROJECT_DIR/test/replay"
RESULTS_DIR="$PROJECT_DIR/test/results"

# Create results directory
mkdir -p "$RESULTS_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================"
echo "DCli Replay Test Runner"
echo "========================================"
echo ""

# Track results
TOTAL=0
PASSED=0
FAILED=0

# Run each test file
for test_file in "$TEST_DIR"/*.dcli; do
    if [ -f "$test_file" ]; then
        TOTAL=$((TOTAL + 1))
        test_name=$(basename "$test_file")
        result_file="$RESULTS_DIR/${test_name%.dcli}.result.txt"
        
        echo -n "Running $test_name... "
        
        # Run the test
        if dart run "$PROJECT_DIR/bin/dclie.dart" -run-replay "$test_file" -test -output="$result_file" 2>&1; then
            echo -e "${GREEN}PASSED${NC}"
            PASSED=$((PASSED + 1))
        else
            echo -e "${RED}FAILED${NC}"
            FAILED=$((FAILED + 1))
            # Show failure details
            if [ -f "$result_file" ]; then
                echo "  Details:"
                grep -A 100 "VERIFICATION FAILURES" "$result_file" 2>/dev/null | head -10 || true
            fi
        fi
    fi
done

echo ""
echo "========================================"
echo "Test Results: $PASSED/$TOTAL passed"
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}$FAILED test(s) failed${NC}"
    exit 1
else
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
fi
