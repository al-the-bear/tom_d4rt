#!/usr/bin/env bash
# Run a D4rt example by folder name, or a script piped on stdin.
#
#   ./run_example.sh money_math           # runs example/money_math/main.dart
#   echo '<script>' | ./run_example.sh    # runs a single script from stdin
#
# The bridges must exist before running. If lib/dartscript.b.dart is missing,
# generate it first:  dart run tom_d4rt_generator:d4rtgen
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -d .dart_tool ]; then
  echo "Fetching dependencies (first run)..." >&2
  dart pub get
fi

if [ ! -f lib/dartscript.b.dart ]; then
  echo "Generating bridges (first run)..." >&2
  dart run tom_d4rt_generator:d4rtgen
fi

exec dart run bin/run_example.dart "$@"
