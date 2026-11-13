// ghissues22 — `whereType<T>()` keeps exactly the elements that are a `T`,
// as `x is T` decides.
//
// Measured 2026-11-10 on this tree (1.245.0):
//
//   class A {}  class B extends A {}
//   final List<Object> xs = [1, 'a', 2.5, B(), A()];
//   xs.whereType<int>().toList()       // [1, a, 2.5, <instance of B>, <instance of A>]
//   xs.whereType<A>().length           // 5 (Dart: 2)
//   xs.toSet().whereType<int>().length // 5 (Dart: 1)
//
// The stdlib bridges' `whereType` adapters called the native `whereType()`
// without the call's type argument - `whereType<dynamic>()` - on List, Set,
// Iterable, Runes, the dart:collection sets and the typed-data lists (GEN-127;
// in the Flutter corpus `entries.whereType<CupertinoMenuDivider>()` counted
// every entry). They now filter with `InterpreterVisitor.whereTypeFilter`,
// which asks the `is` operator's own question of each element. Found on the
// way: `E.a is E` threw for a script enum (`is` had no arm for one) - GHI22-5.
// The same in tom_d4rt_ast (test/runtime/ghissues22_where_type_test.dart).
//
// `cast<T>()` checks its elements against T through the same machinery:
// ghissues30_strict_cast_test.dart.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

mixin Gh22Marker {}

abstract class Gh22Shape {}

class _Square implements Gh22Shape {}

D4rt _interpreter() => D4rt()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Gh22Marker,
      name: 'Gh22Marker',
      isAbstract: true,
      canBeUsedAsMixin: true,
      isAssignable: (v) => v is Gh22Marker,
    ),
    'package:g/g.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Gh22Shape,
      name: 'Gh22Shape',
      isAbstract: true,
      isAssignable: (v) => v is Gh22Shape,
    ),
    'package:g/g.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _Square,
      name: 'Gh22Square',
      constructors: {'': (visitor, positional, named) => _Square()},
      isAssignable: (v) => v is _Square,
    ),
    'package:g/g.dart',
  );

Object? _run(String body) => _interpreter().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        "import 'dart:typed_data';\n"
        "import 'package:g/g.dart';\n"
        'class A {}\n'
        'class B extends A {}\n'
        'class Marked with Gh22Marker {}\n'
        'main() {\n'
        "  final List<Object> xs = [1, 'a', 2.5, B(), A(), Marked(), "
        'Gh22Square()];\n'
        '  return $body;\n'
        '}\n',
  },
);

void main() {
  group('ghissues22: whereType<T>() keeps the T elements', () {
    test('GHI22-1: on a List, by int, num, String, an interpreted class and '
        'its subclass [2026-11-10]', () {
      expect(
        _run(
          '[xs.whereType<int>().toList(), xs.whereType<num>().length, '
          'xs.whereType<String>().toList(), xs.whereType<A>().length, '
          'xs.whereType<B>().length, xs.whereType<Object>().length, '
          'xs.whereType<bool>().isEmpty]',
        ),
        [
          [1],
          2,
          ['a'],
          2,
          1,
          7,
          true,
        ],
      );
    });

    test('GHI22-2: by a bridged class and a bridged mixin [2026-11-10]', () {
      expect(
        _run(
          '[xs.whereType<Gh22Shape>().length, '
          'xs.whereType<Gh22Marker>().length, '
          'xs.whereType<Marked>().length]',
        ),
        [1, 1, 1],
      );
    });

    test('GHI22-3: on a Set, a lazy Iterable and the result of where '
        '[2026-11-10]', () {
      expect(
        _run(
          '[xs.toSet().whereType<int>().length, '
          'xs.where((x) => x is! String).whereType<A>().length, '
          'xs.map((x) => x).whereType<String>().toList()]',
        ),
        [
          1,
          2,
          ['a'],
        ],
      );
    });

    test('GHI22-4: on a typed-data list and on Runes [2026-11-10]', () {
      expect(
        _run(
          '[Uint8List.fromList([1, 2, 3]).whereType<int>().length, '
          "'ab'.runes.whereType<int>().toList(), "
          "'ab'.runes.whereType<String>().length]",
        ),
        [
          3,
          [97, 98],
          0,
        ],
      );
    });

    test('GHI22-5: `is` and whereType on a script enum [2026-11-10]', () {
      expect(
        D4rt().execute(
          source:
              'enum E { a, b }\n'
              'main() => [E.a is E, 1 is E, '
              '<Object>[E.a, 1, E.b].whereType<E>().length];\n',
        ),
        [true, false, 2],
      );
    });

    test('GHI22-6: without a type argument every element stays '
        '[2026-11-10]', () {
      expect(
        D4rt().execute(
          source:
              'main() { final List<Object?> xs = [1, null, "a"]; '
              'final Iterable<Object?> all = xs.whereType(); '
              'return all.length; }',
        ),
        3,
      );
    });
  });
}
