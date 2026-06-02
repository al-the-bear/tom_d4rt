#!/usr/bin/env bash
#
# Run tom_d4rt_flutter_test in an iOS Simulator on macOS.
#
# Usage:
#   ./run_simulator.sh            # use $FLUTTER_TARGET_DEVICE, else first booted
#                                 #   sim, else first available iPad sim
#   ./run_simulator.sh ipad       # force an iPad simulator
#   ./run_simulator.sh iphone     # force an iPhone simulator
#   ./run_simulator.sh <udid>     # force a specific simulator by UDID
#
# VS Code integration: the Flutter extension exports the device you pick in
# the status bar as $FLUTTER_TARGET_DEVICE for its integrated terminal, so
# running this script there with no argument follows your selection. The
# run_ipad.sh / run_iphone.sh wrappers just call this with a fixed kind.
#
# Before first run (or after editing any sample), refresh the bundled assets:
#   dart run tool/sync_samples_to_assets.dart
set -euo pipefail

cd "$(dirname "$0")"

KIND="${1:-}"

# Resolve a simulator UDID. Prefers, in order:
#   1. an explicit UDID argument,
#   2. the requested kind (ipad/iphone) among booted-or-available sims,
#   3. the VS Code-selected $FLUTTER_TARGET_DEVICE,
#   4. the first already-booted simulator,
#   5. the first available iPad, then any iOS simulator.
pick_device() {
  # Explicit UDID passed straight through.
  if [[ "$KIND" =~ ^[0-9A-Fa-f]{8}- ]]; then
    echo "$KIND"; return 0
  fi

  local pattern=""
  case "$KIND" in
    ipad)   pattern="iPad" ;;
    iphone) pattern="iPhone" ;;
    "")     : ;;
    *) echo "Unknown target '$KIND' (expected: ipad | iphone | <udid>)" >&2; exit 2 ;;
  esac

  local list booted
  list="$(xcrun simctl list devices available)"

  if [[ -n "$pattern" ]]; then
    # First booted match of the requested kind, else first available match.
    booted="$(echo "$list" | grep "$pattern" | grep '(Booted)' | head -1 || true)"
    [[ -z "$booted" ]] && booted="$(echo "$list" | grep "$pattern" | head -1 || true)"
    echo "$booted" | grep -oE '[0-9A-Fa-f-]{36}' | head -1
    return 0
  fi

  # No kind requested: honour the VS Code selection if it is a real sim.
  if [[ -n "${FLUTTER_TARGET_DEVICE:-}" ]] && \
     echo "$list" | grep -q "${FLUTTER_TARGET_DEVICE}"; then
    echo "$FLUTTER_TARGET_DEVICE"; return 0
  fi

  # Otherwise: first booted sim, else first available iPad, else any iOS sim.
  booted="$(echo "$list" | grep '(Booted)' | head -1 || true)"
  [[ -z "$booted" ]] && booted="$(echo "$list" | grep 'iPad' | head -1 || true)"
  [[ -z "$booted" ]] && booted="$(echo "$list" | grep -E 'iPhone|iPad' | head -1 || true)"
  echo "$booted" | grep -oE '[0-9A-Fa-f-]{36}' | head -1
}

UDID="$(pick_device || true)"
if [[ -z "${UDID:-}" ]]; then
  echo "No iOS simulator found. Open Xcode > Settings > Platforms and install" >&2
  echo "an iOS runtime, or create a simulator in Xcode > Window > Devices." >&2
  exit 1
fi

echo "==> Booting simulator $UDID (if not already booted)"
xcrun simctl bootstatus "$UDID" -b >/dev/null 2>&1 || true
open -a Simulator

echo "==> Refreshing bundled samples"
dart run tool/sync_samples_to_assets.dart

echo "==> flutter run -d $UDID"
exec flutter run -d "$UDID"
