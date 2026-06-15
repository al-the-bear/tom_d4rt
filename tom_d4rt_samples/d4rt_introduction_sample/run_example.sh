#!/usr/bin/env bash
# Run a D4rt example by folder name, or a script piped on stdin.
#
#   ./run_example.sh calculator          # runs example/calculator/main.dart
#   ./run_example.sh calculator 2 + 3     # forwards "2 + 3" to the script
#   echo 'void main(_) { print(1 + 1); }' | ./run_example.sh
#
# Always run from the package root so example/<name>/ resolves.
set -euo pipefail
# Remember where the user invoked us, so a stdin script can import sibling
# files relative to the caller's directory (not the package root we cd into).
export TOM_D4RT_CALLER_CWD="${TOM_D4RT_CALLER_CWD:-$PWD}"
cd "$(dirname "$0")"

if [ ! -d .dart_tool ]; then
  echo "Fetching dependencies (first run)..." >&2
  dart pub get
fi

# No arguments => stdin mode (the runner reads the script from stdin).
exec dart run bin/run_example.dart "$@"
