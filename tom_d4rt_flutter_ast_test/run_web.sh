#!/usr/bin/env bash
#
# Run tom_d4rt_flutter_ast_test in a browser (Chrome).
#
# This is the headline target: it proves the analyzer-free AST runtime works
# on the web, where neither `dart:io` nor the analyzer is available. The app
# loads pre-compiled AstBundle JSON from assets and renders it via FlutterD4rt.
#
# Before first run (or after editing any sample), recompile the bundles:
#   flutter test tool/compile_samples_to_bundles.dart
set -euo pipefail
cd "$(dirname "$0")"

echo "==> Recompiling sample bundles"
flutter test tool/compile_samples_to_bundles.dart

# Note: --no-tree-shake-icons is a `flutter build` option and is rejected by
# `flutter run`. It is only needed for release builds (`flutter build web`),
# because the interpreter constructs IconData at runtime (non-const) and the
# release icon tree-shaker cannot prove which glyphs are used. `flutter run`
# is always a debug build, so no icon tree-shaking happens and the flag is
# unnecessary here.
echo "==> flutter run -d chrome"
exec flutter run -d chrome "$@"
