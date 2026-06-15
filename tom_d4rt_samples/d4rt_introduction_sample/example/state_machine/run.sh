#!/usr/bin/env bash
# Directly run the state_machine example.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" state_machine "$@"
