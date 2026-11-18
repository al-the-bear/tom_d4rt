// REPO-WIDE GUARD (tom_d4rt_ast) — this tree's copy of ghissues80's program is tom_d4rt's.
// ghissues80/AST - a type argument compared with a type literal that has
// type arguments (GitHub #24), `T == List<String>`, in the analyzer-free
// tree.
//
// The mirror of `tom_d4rt/test/ghissues80_applied_type_equality_test.dart`.
// `fixtures/ghissues80_program.dart` (a copy of tom_d4rt's) is imported here
// for native Dart's answers; its bundles, parse-only and resolved
// (`fixtures/ghissues80_parse_only.bundle.json`,
// `fixtures/ghissues80_resolved.bundle.json`, tom_ast_generator's
// `tool/write_ghissues80_fixtures.dart`), are run by the interpreter through
// toBytes / fromBytes. Each test compares the two.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

import '../sibling_trees.dart';
import 'fixtures/ghissues80_program.dart' as native;

AstBundle _bundle(String mode) => AstBundle.fromBytes(
  AstBundle.fromJson(
    jsonDecode(
          File(
            'test/runtime/fixtures/ghissues80_$mode.bundle.json',
          ).readAsStringSync(),
        )
        as Map<String, dynamic>,
  ).toBytes(),
);

List<String> _strings(Object? value) => [for (final e in value as List) '$e'];

void main() {
  requirePackage(
    'tom_d4rt_ast',
    subject:
        'tom_d4rt/test/fixtures/ghissues80_program.dart, the program these '
        'bundles are a copy of',
  );

  test('GH80A-0: the bundled program is the tom_d4rt fixture [2026-11-18]', () {
    expect(
      File('test/runtime/fixtures/ghissues80_program.dart').readAsStringSync(),
      File(
        '../tom_d4rt/test/fixtures/ghissues80_program.dart',
      ).readAsStringSync(),
      reason:
          'copy tom_d4rt\'s program here and run '
          'tom_ast_generator/tool/write_ghissues80_fixtures.dart',
    );
  });

  for (final mode in ['parse_only', 'resolved']) {
    group('ghissues80/AST ($mode): applied type equality, side by side with '
        'native Dart', () {
      final bundle = _bundle(mode);
      List<String> run(String name) =>
          _strings(D4rtRunner().executeBundle(bundle, name: name));

      test('GH80A-1: the issue, T == List<String> [2026-11-18]', () {
        expect(run('issue'), _strings(native.issue()));
        expect(_strings(native.issue()), ['true', 'true']);
      });

      test('GH80A-2: the unequal controls stay false [2026-11-18]', () {
        expect(run('controls'), _strings(native.controls()));
      });

      test('GH80A-3: equal applied types, their hash and their names '
          '[2026-11-18]', () {
        expect(run('equalities'), _strings(native.equalities()));
      });

      test('GH80A-4: constructor tear-offs of an applied class '
          '[2026-11-18]', () {
        expect(run('tearOffs'), _strings(native.tearOffs()));
      });
    });
  }
}
