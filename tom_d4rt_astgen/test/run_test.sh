#!/bin/bash
# Test runner script for astgen

set -e

echo "========================================"
echo "AST Generator Test Suite"
echo "========================================"
echo ""

cd "$(dirname "$0")/astgen_test_project"

echo "Current directory: $(pwd)"
echo ""

# Clean previous output
echo "Cleaning previous output..."
rm -rf ../astgen_test_output/assets/* ../astgen_test_output/walkers/* ../astgen_test_output/scripts/*
echo ""

# Test 1: Dry run
echo "Test 1: Dry Run"
echo "----------------------------------------"
dart run ../../bin/astgen.dart --dry-run
echo ""

# Test 2: Actual conversion with verbose
echo "Test 2: Running Conversion (verbose)"
echo "----------------------------------------"
dart run ../../bin/astgen.dart -v
echo ""

# Test 3: Verify output files
echo "Test 3: Verifying Output"
echo "----------------------------------------"
echo "Checking file count..."
FILE_COUNT=$(find ../astgen_test_output -name "*.ast.yaml" | wc -l | tr -d ' ')
echo "Found $FILE_COUNT AST files"

# Expected 6 files:
# 1. main.runner.dart
# 2. tool.runner.dart (nested, preserved structure)
# 3. helper.runner.dart (nested, preserved structure)
# 4. metrics.walker.dart
# 5. filesystem.walker.dart
# 6. cleanup.dart
if [ "$FILE_COUNT" -eq "6" ]; then
    echo "✓ File count is correct (6 files)"
else
    echo "✗ Expected 6 files, found $FILE_COUNT"
    exit 1
fi

# Test 4: Check structure preservation
echo ""
echo "Checking structure preservation..."
if [ -f "../astgen_test_output/assets/structured/tools/tool.runner.ast.yaml" ]; then
    echo "✓ Structure preserved correctly"
else
    echo "✗ Structure not preserved"
    exit 1
fi

# Test 5: Check flat output
if [ ! -d "../astgen_test_output/assets/tools" ]; then
    echo "✓ Flat output verified"
else
    echo "✗ Expected flat output but found nested structure"
    exit 1
fi

# Test 6: Check sourcemaps
echo ""
echo "Checking sourcemaps..."
if grep -q "sourcemap:" "../astgen_test_output/assets/main.runner.ast.yaml"; then
    echo "✓ Sourcemap present in Test 1"
else
    echo "✗ Sourcemap missing in Test 1"
    exit 1
fi

if ! grep -q "sourcemap:" "../astgen_test_output/walkers/filesystem.walker.ast.yaml"; then
    echo "✓ Sourcemap absent in Test 3 (as expected)"
else
    echo "✗ Unexpected sourcemap in Test 3"
    exit 1
fi

echo ""
echo "========================================"
echo "All tests passed! ✓"
echo "========================================"
echo ""
echo "Generated files:"
find ../astgen_test_output -name "*.ast.yaml" | sort
