#!/usr/bin/env bash
#
# start_test_profiler.sh — launch the analyzer-free (AST) D4rt Flutter test app
# for a manual profiling session. macOS / Linux (bash).
#
# TWO-TERMINAL WORKFLOW
#   Terminal 1 (this script):   ./test/start_test_profiler.sh
#   Terminal 2 (the driver):    ./test/run_test_profiler.sh [patterns...]
#
# This script starts the companion test app (test/tom_d4rt_flutter_ast_app)
# under `flutter run --profile` and leaves it in the FOREGROUND so you can:
#   1. read the "Dart VM Service" / "Flutter DevTools" URLs it prints,
#   2. open DevTools and START RECORDING (CPU profiler / timeline / memory),
#   3. THEN run ./test/run_test_profiler.sh in the second terminal.
# Stop the app with Ctrl-C (or `q` in the flutter-run console) when done.
#
# IMPORTANT — init-path profiler switch (compile-time, ships OFF)
#   The D4rt init-path profiler is `D4rtProfiler.enabled` in tom_d4rt_ast — a
#   `static const bool` that is `false` in published code, so every measurement
#   site is dead-code-eliminated (zero runtime cost). To capture the per-phase
#   init breakdown you must, for a LOCAL session only:
#     (1) flip `D4rtProfiler.enabled` to `true` in
#         tom_d4rt_ast/lib/src/runtime/profiler.dart,
#     (2) keep the path dependency (pubspec_overrides.yaml) so THIS app builds
#         from that edited source,
#     (3) **REVERT the switch before committing or publishing** — a guard test
#         (tom_d4rt_ast/test/profiler_disabled_test.dart) enforces it stays false.
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
APP_DIR="test/tom_d4rt_flutter_ast_app"
PORT="${TOM_D4RT_AST_TEST_PORT:-4247}"

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

# SCD193: resolve the app before launching it. This workflow is the one the
# corpus runners' `flutter pub get` does not cover — they resolve the app
# before their first file, this script launches it directly — and the app is a
# separate package with its own gitignored lock that nothing re-resolves when
# the twin moves. A profiling session against a stale interpreter produces
# numbers that look exactly like good ones.
#
# The harness refuses to drive an app out of step (test/companion_app_
# resolution.dart, and it checks in attach mode too since SCD193). Resolving
# here means the refusal is something you never see rather than something you
# hit after a three-minute AOT build.
echo "== resolving ${APP_DIR} =="
if ! pub_out="$(cd "$APP_DIR" && flutter pub get 2>&1)"; then
  echo "$pub_out"
  echo "companion app: flutter pub get failed in ${APP_DIR}" >&2
  exit 1
fi

cd "$APP_DIR"
# stdout/stderr → console + logfile. stdin stays on the TTY so the flutter-run
# interactive console (q/r/R) and Ctrl-C keep working.
flutter "${ARGS[@]}" 2>&1 | tee "$LOG"
