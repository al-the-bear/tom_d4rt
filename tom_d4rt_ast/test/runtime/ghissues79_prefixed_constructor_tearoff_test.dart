// ghissues79/AST (GitHub #23) - `generated.Protocol.new`, a constructor
// tear-off of a class reached through an import prefix, along the issue's own
// path: AstBundler parse-only and in resolving mode -> toBytes / fromBytes ->
// D4rtRunner. It failed with `Undefined static member 'new' on class
// 'Protocol'` in both modes.
//
// The fixtures are tom_d4rt's `test/fixtures/ghissues79/` files, bundled by
// tom_ast_generator (`tool/write_ghissues79_fixtures.dart` there). The
// expected values are native Dart's, which
// `tom_d4rt/test/ghissues79_prefixed_constructor_tearoff_test.dart` checks by
// importing the same files.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

AstBundle _bundle(String mode) => AstBundle.fromBytes(
  AstBundle.fromJson(
    jsonDecode(
          File(
            'test/runtime/fixtures/ghissues79_$mode.bundle.json',
          ).readAsStringSync(),
        )
        as Map<String, dynamic>,
  ).toBytes(),
);

/// Native Dart's `extras()`.
const _extras = ['3', '5', 'int:4:n', 'int:6:unnamed', 'abc', '[1, 2]'];

void main() {
  for (final mode in ['parse_only', 'resolved']) {
    group('ghissues79/AST ($mode bundle): prefix.Class.new', () {
      test('GH79A-1: GitHub #23\'s repro answers [7, 7, 11, 11] '
          '[2026-11-18]', () {
        expect(D4rtRunner().executeBundle(_bundle(mode)), [7, 7, 11, 11]);
      });

      test('GH79A-2: a generative, an implicit, a named and a generic '
          'constructor, and a bridged class, through the prefix '
          '[2026-11-18]', () {
        final result = D4rtRunner().executeBundle(
          _bundle(mode),
          name: 'extras',
        );
        expect([for (final e in result as List) '$e'], _extras);
      });
    });
  }
}
