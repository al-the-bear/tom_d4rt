#!/usr/bin/env bash
#
# Corpus check: resolves every corpus script with the analyzer and reports
# the errors Dart would report - a name a script never imported, a type
# mismatch, a missing member - which the interpreter, parsing without
# resolution, runs anyway (ghissues68, GitHub #18 option 3).
#
# Run it by hand before a corpus verification run; nothing schedules it.
# It needs the companion app's packages (`flutter pub get` in
# test/tom_d4rt_flutter_ast_app) and finds the Dart SDK from DART_SDK or the
# dart / flutter on PATH.
#
# Usage:
#   ./test/run_corpus_check.sh            # every corpus folder
#   ./test/run_corpus_check.sh <path>...  # some folders or files
#
# The checker is tom_ast_generator's tool/resolve_check.dart, run from the
# working tree beside this package (the twins resolve the published
# tom_ast_generator; the checker does not need to). It resolves the scripts
# in the companion app's package configuration, sharing one analysis context,
# and leaves the app's `analyzer: exclude` of the corpus out of its view only.
#
# Exit: 0 when no error is left, 1 when some script has one, 2 on a usage
# error. The last line is the summary (files, errors, filtered, seconds).

set -euo pipefail

here="$(cd "$(dirname "$0")/.." && pwd)"
app="$here/test/tom_d4rt_flutter_ast_app"
scripts="$app/test/send_ast_via_http_scripts"
generator="$here/../tom_ast_generator"

if [[ ! -f "$app/.dart_tool/package_config.json" ]]; then
  echo "run_corpus_check: run 'flutter pub get' in $app first" >&2
  exit 2
fi

# Absolute paths: the checker runs from tom_ast_generator.
targets=()
for target in "$@"; do
  if [[ ! -e "$target" ]]; then
    echo "run_corpus_check: no such file or folder: $target" >&2
    exit 2
  fi
  targets+=("$(cd "$(dirname "$target")" && pwd)/$(basename "$target")")
done
if [[ ${#targets[@]} -eq 0 ]]; then
  targets=("$scripts")
fi

cd "$generator"
exec dart run tool/resolve_check.dart --project "$app" "${targets[@]}"
