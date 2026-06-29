#!/usr/bin/env bash
#
# start_test_profiler.sh — launch the source-direct D4rt Flutter test app for a
# manual profiling session. macOS / Linux (bash).
#
# TWO-TERMINAL WORKFLOW
#   Terminal 1 (this script):   ./test/start_test_profiler.sh
#   Terminal 2 (the driver):    ./test/run_test_profiler.sh [patterns...]
#
# This script starts the companion test app (test/tom_d4rt_flutter_test_app)
# under `flutter run --profile` and leaves it in the FOREGROUND so you can:
#   1. read the "Dart VM Service" / "Flutter DevTools" URLs it prints,
#   2. open DevTools and START RECORDING (CPU profiler / timeline / memory),
#   3. THEN run ./test/run_test_profiler.sh in the second terminal.
# Stop the app with Ctrl-C (or `q` in the flutter-run console) when done.
#
# IMPORTANT — init-path profiler switch (compile-time, ships OFF)
#   The D4rt init-path profiler is `D4rtProfiler.enabled` in tom_d4rt — a
#   `static const bool` that is `false` in published code, so every measurement
#   site is dead-code-eliminated (zero runtime cost). To capture the per-phase
#   init breakdown you must, for a LOCAL session only:
#     (1) flip `D4rtProfiler.enabled` to `true` in tom_d4rt/lib/src/profiler.dart,
#     (2) keep the path dependency (pubspec_overrides.yaml) so THIS app builds
#         from that edited source,
#     (3) **REVERT the switch before committing or publishing** — a guard test
#         (tom_d4rt/test/profiler_disabled_test.dart) enforces it stays false.
#   With the switch OFF the app still runs fine; you just get DevTools data
#   without the extra `[PROFILE]` init breakdown the driver prints.
#
# Output: streamed to the console AND tee'd to testlog/profiling/start_<ts>.log
#
# Env:
#   FLUTTER_DEVICE   override the auto-detected desktop device (macos|linux|...)
#   MODE             "profile" (default) or "debug" (1st positional arg also works)
set -uo pipefail

cd "$(dirname "$0")/.."
PROJECT="$(basename "$PWD")"
APP_DIR="test/tom_d4rt_flutter_test_app"
PORT="${TOM_D4RT_TEST_TEST_PORT:-4248}"

MODE="${1:-${MODE:-profile}}"

case "$(uname -s)" in
  Darwin) DEVICE_DEFAULT=macos ;;
  Linux)  DEVICE_DEFAULT=linux ;;
  *)      DEVICE_DEFAULT=linux ;;
esac
DEVICE="${FLUTTER_DEVICE:-$DEVICE_DEFAULT}"

mkdir -p testlog/profiling
TS="$(date +%Y%m%d-%H%M%S)"
LOG="$PWD/testlog/profiling/start_${TS}.log"

ARGS=(run -d "$DEVICE")
[ "$MODE" = "profile" ] && ARGS+=(--profile)

echo "== ${PROJECT} :: start test app for profiling =="
echo "== mode:   ${MODE}  (profile = AOT, best for DevTools CPU profiling; first build 1-3 min)"
echo "== device: ${DEVICE}"
echo "== port:   ${PORT}  (the driver connects here)"
echo "== app:    ${APP_DIR}"
echo "== log:    ${LOG}"
echo "=="
echo "== NEXT: when flutter prints the DevTools URL, open it + start recording,"
echo "==       then run  ./test/run_test_profiler.sh  in a second terminal."
echo "== (For init-path [PROFILE] spans, D4rtProfiler.enabled must be true — see header.)"
echo ""

cd "$APP_DIR"
# stdout/stderr → console + logfile. stdin stays on the TTY so the flutter-run
# interactive console (q/r/R) and Ctrl-C keep working.
flutter "${ARGS[@]}" 2>&1 | tee "$LOG"
