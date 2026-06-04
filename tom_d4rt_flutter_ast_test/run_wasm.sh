#!/usr/bin/env bash
#
# Run tom_d4rt_flutter_ast_test in a browser (Chrome) compiled to WebAssembly.
#
# This is the strongest form of the headline web target: instead of the
# dart2js JavaScript output used by run_web.sh, the app is compiled to WASM
# (dart2wasm + the skwasm renderer). It proves the analyzer-free AST runtime
# works on the most constrained web target, where neither `dart:io` nor the
# analyzer is available. The app loads pre-compiled AstBundle JSON from assets
# and renders it via FlutterD4rt.
#
# Before first run (or after editing any sample), recompile the bundles:
#   flutter test tool/compile_samples_to_bundles.dart
#
# KNOWN LIMITATION (verified 2026-06-04, Flutter stable / dart2wasm):
#   `flutter build web --wasm` currently crashes the dart2wasm compiler with a
#   "Stack Overflow" in DummyValuesCollector.prepareDummyValue
#   (package:dart2wasm/translator.dart). dart2wasm recurses while synthesizing
#   dummy values for the deeply/mutually-recursive type graph of the full
#   Flutter-Material bridge surface that this app links in. This is a compiler
#   limitation, not a defect in this app or script — the dart2js path
#   (run_web.sh) builds and runs cleanly. A `--wasm` dry run only checks
#   JS-interop / dart:html usage and will pass even though codegen fails.
#   Re-test with newer Flutter/dart2wasm releases; remove this note once it
#   compiles.
set -euo pipefail
cd "$(dirname "$0")"

echo "==> Recompiling sample bundles"
flutter test tool/compile_samples_to_bundles.dart

# --wasm selects the dart2wasm + skwasm pipeline instead of dart2js.
# --no-tree-shake-icons is required: the interpreter constructs IconData at
# runtime (non-const), so the icon tree-shaker cannot prove which glyphs are
# used. Harmless in debug, mandatory for any release `flutter build web --wasm`.
echo "==> flutter run -d chrome --wasm"
exec flutter run -d chrome --wasm --no-tree-shake-icons "$@"
