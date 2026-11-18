// ghissues80 - a type argument compared with a type literal that has type
// arguments (GitHub #24): `T == List<String>` is true when T is
// `List<String>`.
//
// `test/fixtures/ghissues80_program.dart` is valid Dart: imported here for
// native Dart's answers, and its text run by the interpreter. Each test
// compares the two. The AST twin runs bundles of the same program
// (tom_d4rt_ast/test/runtime/ghissues80_applied_type_equality_test.dart).
//
// A class with type arguments as an expression (`List<String>`, `Box<int>`)
// is an AppliedRuntimeType; applied types, nullable types and the written
// collection types compare by structure.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'fixtures/ghissues80_program.dart' as native;

final _source = File(
  'test/fixtures/ghissues80_program.dart',
).readAsStringSync();

Object? _run(String name) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {'package:p/main.dart': _source},
  name: name,
);

List<String> _strings(Object? value) => [for (final e in value as List) '$e'];

void main() {
  group('ghissues80: applied type equality, side by side with native Dart', () {
    test('GH80-1: the issue, T == List<String> [2026-11-18]', () {
      expect(_strings(_run('issue')), _strings(native.issue()));
      expect(_strings(native.issue()), ['true', 'true']);
    });

    test('GH80-2: the unequal controls stay false [2026-11-18]', () {
      expect(_strings(_run('controls')), _strings(native.controls()));
    });

    test('GH80-3: equal applied types, their hash and their names '
        '[2026-11-18]', () {
      expect(_strings(_run('equalities')), _strings(native.equalities()));
    });

    test('GH80-4: constructor tear-offs of an applied class [2026-11-18]', () {
      expect(_strings(_run('tearOffs')), _strings(native.tearOffs()));
    });
  });
}
