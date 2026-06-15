#!/usr/bin/env bash
# Run the D4rt Flutter sample on an iPad simulator.
#
# Boots the first available iPad simulator (override by passing a device id as
# an argument) and launches the app on it. Like iOS, samples come from bundled
# assets, so no workspace filesystem is required at runtime.
set -euo pipefail
cd "$(dirname "$0")"
dart run tool/sync_samples_to_assets.dart

if [ "$#" -gt 0 ]; then
  flutter run -d "$@"
  exit 0
fi

# Find a booted iPad simulator, otherwise boot the first available one.
ipad_udid="$(xcrun simctl list devices booted | grep -i ipad | head -1 | \
  sed -E 's/.*\(([0-9A-Fa-f-]+)\).*/\1/' || true)"
if [ -z "${ipad_udid}" ]; then
  ipad_udid="$(xcrun simctl list devices available | grep -i ipad | head -1 | \
    sed -E 's/.*\(([0-9A-Fa-f-]+)\).*/\1/' || true)"
  if [ -z "${ipad_udid}" ]; then
    echo "No iPad simulator found. Create one in Xcode > Devices & Simulators."
    exit 1
  fi
  xcrun simctl boot "${ipad_udid}"
  open -a Simulator
fi

flutter run -d "${ipad_udid}"
