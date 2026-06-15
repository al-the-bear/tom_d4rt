#!/usr/bin/env bash
# Convenience wrapper: run this example from anywhere.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" shell_run "$@"
