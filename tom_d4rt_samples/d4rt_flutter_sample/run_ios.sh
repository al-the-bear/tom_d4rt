#!/usr/bin/env bash
# Run the D4rt Flutter sample on an iOS device or simulator.
#
# Samples ship as bundled assets, so the interpreter needs no filesystem
# access — this is exactly the case the asset path exists for. Pass a specific
# device id as an argument, or let Flutter pick the booted iOS device.
set -euo pipefail
cd "$(dirname "$0")"
dart run tool/sync_samples_to_assets.dart
if [ "$#" -gt 0 ]; then
  flutter run -d "$@"
else
  flutter run -d ios
fi
