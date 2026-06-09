#!/usr/bin/env bash
# Launch the D4rt CPU-profiling driver with the VM service + profiler enabled.
#
# This is the "profile mode" entry point for the perf suite: it starts the Dart
# VM with sampling-profiler flags so d4rt_cpu_profile.dart can pull aggregated
# CPU samples after running the benchmark corpus.
#
# Usage:
#   test/perf/run_profile.sh                       # all benchmarks, 1500ms each
#   test/perf/run_profile.sh --budget-ms=3000      # longer measured window
#   test/perf/run_profile.sh --only=list_ops,recursion_fib
#   test/perf/run_profile.sh --top=40
#
# All extra args are forwarded to the driver.
set -euo pipefail

# Resolve the package root (two levels up from this script: test/perf -> root).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$PKG_ROOT"

# --profiler            : enable the sampling profiler
# --sample-buffer-duration=180 : keep ~3 min of samples so nothing is dropped
# --enable-vm-service=0 : bind to an ephemeral port (0) to avoid clashes
# --no-pause-isolates-on-exit : let the process exit cleanly after profiling
exec dart \
  --enable-vm-service=0 \
  --no-pause-isolates-on-exit \
  --profiler \
  --sample-buffer-duration=180 \
  test/perf/d4rt_cpu_profile.dart "$@"
