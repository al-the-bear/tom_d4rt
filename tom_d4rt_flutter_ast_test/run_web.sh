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

# --no-tree-shake-icons is required: the interpreter constructs IconData at
# runtime (non-const), so the release icon tree-shaker cannot prove which
# glyphs are used. Harmless in debug, mandatory for `flutter build web`.
echo "==> flutter run -d chrome"
exec flutter run -d chrome --no-tree-shake-icons "$@"
