#!/usr/bin/env bash
# Directly run the geometry_calc example.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" geometry_calc "$@"
