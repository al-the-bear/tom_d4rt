#!/usr/bin/env bash
# Directly run the config_overrides example.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" config_overrides "$@"
