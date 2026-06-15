#!/usr/bin/env bash
# Directly run the money_math example.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" money_math "$@"
