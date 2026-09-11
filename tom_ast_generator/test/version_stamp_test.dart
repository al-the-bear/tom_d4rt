// The version this package reports about itself must be the version it is.
//
// `AstgenVersionInfo.version` is written by `buildkit :versioner` into
// `lib/src/version.versioner.dart` and printed by `astgen --version`. Nothing ties it to
// `pubspec.yaml` except someone remembering to re-run the versioner after a
// bump — and when nobody did, the d4rt generator reported 1.12.1 through two
// releases, so a batch regeneration could not be attributed to a generator and
// had to be discarded. This test is the tie: a bump without a fresh stamp fails
// here, in the suite that runs before a publish.
//
// When it fails: `buildkit -v -p . :versioner` in this package, with the
// current BuildKit from `tom_binaries/tom/<platform>/`.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_ast_generator/src/version.versioner.dart';

void main() {
  test(
    'AG-STAMP-01: the version stamp matches pubspec.yaml [2026-09-11] (PASS)',
    () {
      final declared = RegExp(
        r'^version:\s*(\S+)',
        multiLine: true,
      ).firstMatch(File('pubspec.yaml').readAsStringSync())?.group(1);
      expect(declared, isNotNull, reason: 'pubspec.yaml declares no version');
      expect(
        AstgenVersionInfo.version,
        declared,
        reason:
            'lib/src/version.versioner.dart says ${AstgenVersionInfo.version} but '
            'pubspec.yaml says $declared — run `buildkit -v -p . :versioner`.',
      );
    },
  );
}
