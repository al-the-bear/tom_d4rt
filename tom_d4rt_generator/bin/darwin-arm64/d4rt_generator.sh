#!/bin/bash
# D4rt Generator Runner Script
# 
# This script runs the compiled d4rt_generator binary with the provided arguments.
# It automatically sets the DART_SDK environment variable for the analyzer package.

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Find the Dart SDK path if not already set
if [ -z "$DART_SDK" ]; then
  # Try to find dart in PATH
  DART_EXEC=$(which dart 2>/dev/null)
  
  if [ -n "$DART_EXEC" ]; then
    # Resolve symlinks
    while [ -L "$DART_EXEC" ]; do
      DART_EXEC=$(readlink "$DART_EXEC")
    done
    
    # SDK is two directories up from the dart executable
    # e.g., /usr/local/opt/dart-sdk/bin/dart -> /usr/local/opt/dart-sdk
    export DART_SDK="$(cd "$(dirname "$DART_EXEC")/.." && pwd)"
    
    # Verify the SDK directory exists
    if [ ! -d "$DART_SDK/lib" ]; then
      echo "Warning: Could not find Dart SDK. The analyzer may not work correctly." >&2
      echo "Please set DART_SDK environment variable manually." >&2
      unset DART_SDK
    fi
  else
    echo "Warning: Could not find 'dart' in PATH. The analyzer may not work correctly." >&2
    echo "Please ensure Dart is installed and in your PATH, or set DART_SDK manually." >&2
  fi
fi

# Run the binary with all provided arguments
exec "$SCRIPT_DIR/d4rt_generator" "$@"
