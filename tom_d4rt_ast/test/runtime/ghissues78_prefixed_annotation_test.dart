// ghissues78/AST (GitHub #22) - a bundle holding a prefixed annotation name
// (`@m.useResult`, as Serverpod 4.1's generated code writes) reads and runs.
//
// The fixture `fixtures/ghissues78_prefixed_annotation.bundle.json` is the
// issue's repro bundled by tom_ast_generator
// (`tool/write_ghissues78_fixtures.dart` there). tom_ast_model 0.3.3 types
// `SAnnotation.name` as `SIdentifier?`, so the name keeps its
// SPrefixedIdentifier shape through JSON and the bytes; the interpreter
// ignores annotations, as before.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

AstBundle _bundle() => AstBundle.fromBytes(
  AstBundle.fromJson(
    jsonDecode(
          File(
            'test/runtime/fixtures/ghissues78_prefixed_annotation.bundle.json',
          ).readAsStringSync(),
        )
        as Map<String, dynamic>,
  ).toBytes(),
);

void main() {
  group('ghissues78/AST: a prefixed annotation name', () {
    test('GH78A-1: keeps its SPrefixedIdentifier shape through JSON and the '
        'bytes [2026-11-18]', () {
      final fn = _bundle().modules['package:p/main.dart']!.declarations
          .whereType<SFunctionDeclaration>()
          .firstWhere((d) => d.name?.name == 'f');
      final name = fn.metadata.single.name;
      expect(name, isA<SPrefixedIdentifier>());
      name as SPrefixedIdentifier;
      expect(name.prefix?.name, 'm');
      expect(name.identifier?.name, 'useResult');
    });

    test('GH78A-2: GitHub #22\'s repro runs [2026-11-18]', () {
      expect(D4rtRunner().executeBundle(_bundle()), 1);
    });
  });
}
