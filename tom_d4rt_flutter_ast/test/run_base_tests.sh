#!/usr/bin/env bash
#
# Base-test runner for the D4rt Flutter bridge corpus (fast regression gate).
# macOS / Linux (bash). Windows users: run_base_tests.ps1.
#
# This is the SHORT sibling of run_issue_analysis_tests.sh. It runs ONLY the
# essential + important corpus files (2 of the full 13), as the fast
# early-warning regression gate after any bridge/proxy/relaxer regeneration.
# Use the full run_issue_analysis_tests.sh for a complete reference pass.
#
# Like the full runner, this runs FILE BY FILE, strictly SERIAL. The corpus
# drives a single long-lived companion app over one local HTTP server, so
# concurrent `flutter test` invocations corrupt each other's results. See
# README.md in this folder for the full rationale (serial-only + 60s timeout).
#
# Usage:
#   ./run_base_tests.sh [ID]
#
# ID defaults to <YYYYMMDD-HHMM>-base. Pass the SAME ID to the sibling
# project's script so both projects' logs land in an identically named
# testlog/basetestlog_<ID>/ folder. NEVER run this script for two projects at once
# — even though the AST app and the source-direct app bind different ports, the
# host gets overloaded and the shared-resource contention corrupts results.
#
# Output (per test file <base>):
#   testlog/basetestlog_<ID>/<base>.result.json  machine-readable (--file-reporter json)
#   testlog/basetestlog_<ID>/<base>.log.txt        full stdout incl. framework errors
#   testlog/basetestlog_<ID>/metrics.txt           per-file exit code + pass/skip/fail summary
#
# metrics.txt opens with an ATTRIBUTION HEADER (SCD164) — `# `-prefixed
# lines naming the run id, its start time, this package, and every `tom_`
# package this package and its companion app resolved. The locks are
# gitignored, so without it a testlog folder cannot be matched to the
# interpreter that produced it.
#
# NOTE: this script does NOT use `set -e` — a failing test file must not abort
# the remaining files; every file is always attempted.
set -uo pipefail

# Absolute path to this script's dir (captured BEFORE the cd) so the idle
# watchdog wrapper can be located after we change into the project root.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$(dirname "$0")/.."
PROJECT="$(basename "$PWD")"

# Idle-output watchdog: kill a test file that produces NO output for this many
# seconds. Catches mid-run stalls AND "never reaches the first test" hangs so a
# wedged transport fails fast instead of burning the timeout-900 backstop.
# Override with IDLE_TIMEOUT=<seconds>.
#
# SCD131: 300, not the 80 this used to default to. The watchdog was SHORTER
# THAN THE THING IT WATCHES — `SendTestRunner.setUp` waits up to 120 s for the
# companion app to start, so on a cold build cache the first file produces no
# output for longer than 80 s and the watchdog kills it:
#
#     flutter_base_01_test: exit=124 +0 (IDLE-KILLED after 80s of no output)
#
# That is not a hang, and the state it happens in is not unusual: it is exactly
# the state a `flutter pub upgrade` leaves behind, which is exactly the state
# the corpus protocol requires the sweep to run in. `interpreter_issues.md` had
# recorded the default as too tight since 2026-08-12 and every run since had
# been passing `IDLE_TIMEOUT=300` by hand.
#
# The watchdog's job is unaffected. `timeout 900` still caps a genuine hang per
# file, so this only changes how long a wedged transport takes to be noticed —
# and only for the first file, where the cold-cache start makes the old default
# wrong rather than strict.
IDLE_TIMEOUT="${IDLE_TIMEOUT:-300}"

ID="${1:-$(date +%Y%m%d-%H%M)-base}"
OUT="testlog/basetestlog_${ID}"
mkdir -p "$OUT"

# Per-FILE wall-clock backstop so a wedged transport can't hang the whole run.
# (The --timeout 60s below is the PER-TEST limit; this caps an entire file.)
# Uses coreutils `timeout` (Linux) or `gtimeout` (macOS+coreutils) if present;
# otherwise relies on the per-test timeout alone.
TIMEOUT_BIN=()
if command -v timeout >/dev/null 2>&1; then TIMEOUT_BIN=(timeout 900)
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT_BIN=(gtimeout 900); fi

# Base subset only: the flutter_base_NN split files (essential + important +
# secondary corpus, ~50 tests each, own test app per file). Globbed in numeric
# order so the run stays serial and reproducible.
FILES=()
for f in test/flutter_base_*_test.dart; do
  [ -e "$f" ] && FILES+=("$(basename "$f")")
done

echo "== ${PROJECT} :: base-test run ${ID} =="
echo "== output: ${OUT} =="
: > "$OUT/metrics.txt"

# Resolve the companion app before the first file. It is a separate package
# with its own gitignored pubspec.lock, and nothing else re-resolves it when
# this package moves — a stale app lock once built against an interpreter
# releases behind, and the run died in setUpAll naming only a timeout. The
# harness now refuses to launch an app out of step with this package
# (test/companion_app_resolution.dart); resolving once here keeps that refusal
# for machines that skipped the runner.
APP_DIR="test/tom_d4rt_flutter_ast_app"
echo "== resolving ${APP_DIR} =="
if ! pub_out="$(cd "$APP_DIR" && flutter pub get 2>&1)"; then
  echo "$pub_out"
  echo "companion app: flutter pub get failed in ${APP_DIR}" | tee -a "$OUT/metrics.txt"
  exit 1
fi

# Attribution header (SCD164). Both twins gitignore `pubspec.lock`, so the
# interpreter a run resolved appears in no diff and no commit — and a testlog
# folder was therefore a pass/skip/fail triple with no provenance. Written
# AFTER the app is resolved, so it records the versions the run actually used.
# `dart` may be absent on a machine that has only `flutter`; a run whose
# attribution failed is still a run worth having, so this never aborts.
if command -v dart >/dev/null 2>&1; then
  dart run test/run_attribution.dart "." "$APP_DIR" "$ID" >> "$OUT/metrics.txt" \
    || echo "# attribution: FAILED — dart run test/run_attribution.dart exited non-zero" >> "$OUT/metrics.txt"
else
  echo "# attribution: FAILED — no dart on PATH" >> "$OUT/metrics.txt"
fi

for f in "${FILES[@]}"; do
  base="${f%.dart}"
  echo ""
  echo "---- ${f} ----"
  # Guard the array expansion: under `set -u` on bash 3.2 (macOS), expanding an
  # empty array with "${arr[@]}" aborts as an unbound variable. The +-form makes
  # an empty TIMEOUT_BIN expand to nothing instead of erroring.
  #
  # The idle watchdog wraps the run: it streams output to the log (tee-like) and
  # kills the whole process group (returning 124) after IDLE_TIMEOUT seconds of
  # silence. The timeout-900 below remains the chatty-but-stuck wall-clock cap.
  IDLE_TIMEOUT="$IDLE_TIMEOUT" "$SCRIPT_DIR/idle_timeout.sh" \
    "$IDLE_TIMEOUT" "${OUT}/${base}.log.txt" -- \
    "${TIMEOUT_BIN[@]+"${TIMEOUT_BIN[@]}"}" flutter test "test/${f}" \
    --timeout 65s \
    --file-reporter "json:${OUT}/${base}.result.json"
  rc=$?
  # flutter test summary line looks like: "00:42 +45 ~2 -1: Some tests failed."
  summary="$(grep -oE '\+[0-9]+( ~[0-9]+)?( -[0-9]+)?' "${OUT}/${base}.log.txt" | tail -1)"
  note=""
  [ "$rc" = "124" ] && note=" (IDLE-KILLED after ${IDLE_TIMEOUT}s of no output)"
  echo "${base}: exit=${rc} ${summary:-<no summary>}${note}" | tee -a "$OUT/metrics.txt"
done

echo ""
echo "== done. metrics: ${OUT}/metrics.txt =="
echo ""
echo "== re-run this exact ID (copy-paste; e.g. in the sibling project) =="
echo "./test/run_base_tests.sh ${ID}"
