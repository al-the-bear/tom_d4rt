#!/usr/bin/env bash
# Directly run the grid_report example.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" grid_report "$@"
