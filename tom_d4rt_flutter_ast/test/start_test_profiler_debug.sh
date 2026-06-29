#!/usr/bin/env bash
#
# start_test_profiler_debug.sh — launch the analyzer-free (AST) D4rt Flutter test
# app for a profiling session in DEBUG mode (no AOT --profile build).
#
# Why a separate script: the AOT `--profile` build used by start_test_profiler.sh
# can take 1-3 minutes (sometimes much longer) on the first build. A debug build
# comes up in seconds, so this is the fast-iteration option.
#
# Tradeoffs (debug vs --profile):
#   * init-path D4rtProfiler spans (the [PROFILE] lines) are IDENTICAL — they are
#     plain Stopwatch timings, unaffected by JIT vs AOT;
#   * the DevTools timeline / memory views work the same;
#   * the DevTools CPU profiler is LESS representative — JIT warmup and the lack
#     of AOT inlining inflate and distort hot-path samples. For accurate CPU
#     sampling use start_test_profiler.sh (--profile) instead.
#
# Everything else (DevTools URLs, two-terminal workflow with run_test_profiler.sh,
# the D4rtProfiler.enabled compile-time switch, logging to testlog/profiling/) is
# exactly as documented in start_test_profiler.sh — this is a thin wrapper that
# runs it in debug mode. Honors FLUTTER_DEVICE / TOM_D4RT_TEST_TEST_PORT too.
exec "$(dirname "$0")/start_test_profiler.sh" debug
