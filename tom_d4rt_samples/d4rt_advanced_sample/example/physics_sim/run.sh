#!/usr/bin/env bash
# Directly run the physics_sim example.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
exec "$ROOT/run_example.sh" physics_sim "$@"
