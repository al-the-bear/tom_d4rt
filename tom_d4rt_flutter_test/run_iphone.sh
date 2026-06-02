#!/usr/bin/env bash
# Convenience wrapper: run on an iPhone simulator. See run_simulator.sh.
set -euo pipefail
exec "$(dirname "$0")/run_simulator.sh" iphone
