// ghissues72/AST — an interpreted generic instance's `runtimeType` keeps its
// type arguments, run from a bundle. The fixture
// `fixtures/ghissues72_runtime_type.bundle.json` is tom_d4rt's
// `test/ghissues72_generic_instance_runtime_type_test.dart` program, bundled
// by tom_ast_generator (`tool/write_ghissues72_fixtures.dart` there) and run
// here through `toBytes` / `fromBytes`. Every expectation is native Dart
// 3.13's, except the one noted.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

Object? _run(String name) {
  final json =
      jsonDecode(
            File(
              'test/runtime/fixtures/ghissues72_runtime_type.bundle.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final bundle = AstBundle.fromBytes(AstBundle.fromJson(json).toBytes());
  return D4rtRunner().executeBundle(bundle, name: name);
}

void main() {
  group('ghissues72/AST: runtimeType of an interpreted generic instance', () {
    test('GH72A-1: prints with its type arguments [2026-11-18]', () {
      expect(_run('printed'), [
        'Box<int>',
        'Box<String>',
        'Pair<int, String?>',
        'Box<List<int>>',
        'N<int>',
      ]);
    });

    test('GH72A-2: equal for the same class and arguments only; a Type; '
        'a map and set key [2026-11-18]', () {
      expect(_run('compared'), [
        true,
        false,
        false,
        false,
        true,
        'int box',
        null,
        2,
        true,
      ]);
    });

    test('GH72A-3: a non-generic or raw instance answers with its class, as '
        'before [2026-11-18]', () {
      // Not as Dart: the last prints `Box<dynamic>` in Dart.
      expect(_run('raw'), [true, 'Plain', true, true, true, 'Box']);
    });
  });
}
