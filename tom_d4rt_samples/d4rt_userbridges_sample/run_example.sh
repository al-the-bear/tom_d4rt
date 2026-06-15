#!/usr/bin/env bash
# Run a D4rt example by folder name, or a script piped on stdin.
#
#   ./run_example.sh money_math           # runs example/money_math/main.dart
#   echo '<script>' | ./run_example.sh    # runs a single script from stdin
#
# The bridges must exist before running. If lib/dartscript.b.dart is missing,
# generate it first:  dart run tom_d4rt_generator:d4rtgen
set -euo pipefail
# Remember where the user invoked us, so a stdin script can import sibling
# files relative to the caller's directory (not the package root we cd into).
export TOM_D4RT_CALLER_CWD="${TOM_D4RT_CALLER_CWD:-$PWD}"
cd "$(dirname "$0")"

if [ ! -d .dart_tool ]; then
  echo "Fetching dependencies (first run)..." >&2
  dart pub get
fi

# The generated bridges (lib/*.b.dart) are checked in, so the examples run
# without the generator. If they are missing, regenerate them — see
# run_generator.md.
if [ ! -f lib/dartscript.b.dart ]; then
  echo "Generated bridges are missing. See run_generator.md to regenerate." >&2
  exit 1
fi

exec dart run bin/run_example.dart "$@"
