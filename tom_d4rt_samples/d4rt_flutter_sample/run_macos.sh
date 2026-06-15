#!/usr/bin/env bash
# Run the D4rt Flutter sample on macOS desktop.
# Re-bundles the example/ scripts into assets first so edits show up.
set -euo pipefail
cd "$(dirname "$0")"
dart run tool/sync_samples_to_assets.dart
flutter run -d macos "$@"
