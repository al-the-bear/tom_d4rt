#!/usr/bin/env bash
#
# Run tom_d4rt_flutter_ast_test as a native macOS desktop app.
#
# Before first run (or after editing any sample), recompile the bundles:
#   flutter test tool/compile_samples_to_bundles.dart
set -euo pipefail
cd "$(dirname "$0")"

echo "==> Recompiling sample bundles"
flutter test tool/compile_samples_to_bundles.dart

echo "==> flutter run -d macos"
exec flutter run -d macos "$@"
