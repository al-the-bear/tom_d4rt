#!/usr/bin/env bash
# Directly run this example. Forwards any args to the calculator script:
#   ./run.sh                  # demo program
#   ./run.sh "(2 + 3) * 4"    # one expression
set -euo pipefail
# Resolve the package root (two levels up from example/calculator/).
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" calculator "$@"
