// ghissues36 — a generic method call's type arguments reach the callee as
// written: with their `?` and their own type arguments.
//
// Measured 2026-11-11 on this tree (1.255.0):
//
//   [1, null].whereType<int?>().toList()      // [1]       (Dart: [1, null])
//   [null].cast<int>().first                  // null      (Dart: TypeError)
//   [['a']].cast<List<int>>().first           // [a]       (Dart: TypeError)
//
// `visitMethodInvocation` resolved each type argument with
// `_resolveTypeAnnotation`, which drops the `?` and erases nested arguments:
// `whereType<int?>` arrived as `int`, `cast<List<int>>` as the bare `List`.
// The call's type arguments now keep both (`NullableRuntimeType`,
// `AppliedRuntimeType`), and `valueHasRuntimeType` and the cast check read
// them. The same in tom_d4rt_ast
// (test/runtime/ghissues36_method_type_arguments_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String body) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        'bool isT<T>(Object? v) => v is T;\n'
        'List<T> keep<T>(List<Object?> xs) => xs.whereType<T>().toList();\n'
        'main() {\n'
        '  try {\n'
        '    return $body;\n'
        '  } on TypeError catch (e) {\n'
        "    return 'TypeError: \$e';\n"
        '  }\n'
        '}\n',
  },
);

void main() {
  group('GHI36: a type argument keeps its ? and its own type arguments', () {
    test('GHI36-1: whereType<int?> keeps null, whereType<int> drops it '
        '[2026-11-11]', () {
      expect(_run('[1, null, 2.5].whereType<int?>().toList()'), [1, null]);
      expect(_run('[1, null, 2.5].whereType<int>().toList()'), [1]);
      expect(_run('[1, null].toSet().whereType<int?>().length'), 2);
    });

    test('GHI36-2: cast<int> throws on a null element, cast<int?> does not '
        '[2026-11-11]', () {
      expect(_run('[null].cast<int>().first'), startsWith('TypeError'));
      expect(_run('[1, null].cast<int?>().toList()'), [1, null]);
      expect(
        _run("{'a': null}.cast<String, int>()['a']"),
        startsWith('TypeError'),
      );
      expect(_run("{'a': null}.cast<String, int?>()['a']"), isNull);
    });

    test('GHI36-3: cast<List<int>> checks the nested elements '
        '[2026-11-11]', () {
      expect(_run("[['a']].cast<List<int>>().first"), startsWith('TypeError'));
      expect(_run('[[1, 2]].cast<List<int>>().first'), [1, 2]);
      expect(_run('[[1, null]].cast<List<int?>>().first'), [1, null]);
      expect(
        _run('[[1, null]].cast<List<int>>().first'),
        startsWith('TypeError'),
      );
    });

    test('GHI36-4: a generic function sees the type argument as written '
        '[2026-11-11]', () {
      expect(_run('[isT<int?>(null), isT<int>(null), isT<int?>(1)]'), [
        true,
        false,
        true,
      ]);
      expect(_run('keep<int?>([1, null, "a"])'), [1, null]);
    });
  });
}
