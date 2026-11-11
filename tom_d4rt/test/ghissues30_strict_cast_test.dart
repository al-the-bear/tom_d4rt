// ghissues30 — `cast<T>()` on a stdlib collection checks its elements against
// T, as Dart's cast views do.
//
// Measured 2026-11-10 on this tree (1.251.0):
//
//   [1, 'a'].cast<int>().toList()               // [1, a]   (Dart: TypeError)
//   {'a': 1, 'b': 'x'}.cast<String, int>()['b'] // x        (Dart: TypeError)
//
// The stdlib bridges' `cast` adapters called the native `cast<dynamic>()`
// without the call's type argument. They now return a checked view: an
// element read through it (or written into it) that is not a T throws a
// `TypeError` (d4rt's `D4rtTypeError`), lazily, as Dart does - `.first` of
// `[1, 'a'].cast<int>()` is still 1. The same in tom_d4rt_ast
// (test/runtime/ghissues30_strict_cast_test.dart).
//
// Lenient by design (decision of the todo): the check runs only for element
// types the interpreter can judge - the core scalars, `List` / `Map` contents,
// bridged and script classes and enums. Since ghissues36 a call's type
// argument keeps its `?` and its own type arguments, so a null element passes
// only a nullable type and a nested collection is judged by its contents
// (ghissues36_method_type_arguments_test.dart).
// GHI30-L pins the legitimate casts that must keep working.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

mixin Gh30Marker {}

abstract class Gh30Shape {}

class _Square implements Gh30Shape {}

D4rt _interpreter() => D4rt()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Gh30Marker,
      name: 'Gh30Marker',
      isAbstract: true,
      canBeUsedAsMixin: true,
      isAssignable: (v) => v is Gh30Marker,
    ),
    'package:g/g.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Gh30Shape,
      name: 'Gh30Shape',
      isAbstract: true,
      isAssignable: (v) => v is Gh30Shape,
    ),
    'package:g/g.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _Square,
      name: 'Gh30Square',
      constructors: {'': (visitor, positional, named) => _Square()},
      isAssignable: (v) => v is _Square,
    ),
    'package:g/g.dart',
  );

/// Runs `main` returning [body]; a `TypeError` the script raises comes back
/// as the string `TypeError: <message>`, so a test sees that the SCRIPT could
/// catch it.
Object? _run(String body) => _interpreter().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        "import 'dart:collection';\n"
        "import 'dart:typed_data';\n"
        "import 'package:g/g.dart';\n"
        'class A {}\n'
        'class B extends A {}\n'
        'class Marked with Gh30Marker {}\n'
        'class Circle implements Gh30Shape {}\n'
        'class Box<T> { Box(this.v); final T v; }\n'
        'enum E { a, b }\n'
        'typedef IntList = List<int>;\n'
        'List<T> castTo<T>(List xs) => xs.cast<T>();\n'
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
  group('GHI30: cast<T>() throws on an element that is not a T', () {
    test('GHI30-1: List.cast reads check each element [2026-11-10]', () {
      final r = _run("[1, 'a'].cast<int>().toList()");
      expect(r, startsWith('TypeError: '));
      expect(r, contains("'String'"));
      expect(r, contains("'int'"));
    });

    test('GHI30-2: the check is lazy - an element never read is never '
        'checked [2026-11-10]', () {
      // Chained, so the read goes through `visitPropertyAccess`, whose debug
      // line used to stringify (and so read) its target.
      expect(_run("[1, 'a'].cast<int>().first"), 1);
      expect(_run("[1, 'a'].cast<int>().length"), 2);
      expect(_run("[1, 'a'].cast<int>().elementAt(0)"), 1);
      expect(_run("[1, 'a'].cast<int>().take(1).toList()"), [1]);
      expect(_run("{1, 'a'}.cast<int>().first"), 1);
      expect(_run("{'a': 1, 'b': 'x'}.cast<String, int>().length"), 2);
    });

    test('GHI30-3: Set and Iterable casts check [2026-11-10]', () {
      expect(_run("{1, 'a'}.cast<int>().toList()"), startsWith('TypeError'));
      expect(
        _run("[1, 'a'].where((_) => true).cast<int>().toList()"),
        startsWith('TypeError'),
      );
      expect(_run("Runes('a').cast<String>().first"), startsWith('TypeError'));
    });

    test('GHI30-4: Map.cast checks values and keys [2026-11-10]', () {
      expect(_run("{'a': 1, 'b': 'x'}.cast<String, int>()['a']"), 1);
      expect(
        _run("{'a': 1, 'b': 'x'}.cast<String, int>()['b']"),
        startsWith('TypeError'),
      );
      expect(
        _run('{1: 1}.cast<String, int>().keys.toList()'),
        startsWith('TypeError'),
      );
      expect(
        _run("{'a': 'x'}.cast<String, int>().values.toList()"),
        startsWith('TypeError'),
      );
    });

    test('GHI30-5: dart:collection and typed-data casts check '
        '[2026-11-10]', () {
      for (final expr in [
        "HashSet<Object>.of([1, 'a']).cast<int>().toList()",
        "LinkedHashSet<Object>.of([1, 'a']).cast<int>().toList()",
        "(SplayTreeSet<Object>((x, y) => 0)..add('a')).cast<int>().toList()",
        "UnmodifiableListView<Object>([1, 'a']).cast<int>().toList()",
        "UnmodifiableSetView<Object>({1, 'a'}).cast<int>().toList()",
        "HashMap<String, Object>.of({'b': 'x'}).cast<String, int>()['b']",
        "LinkedHashMap<String, Object>.of({'b': 'x'}).cast<String, int>()['b']",
        "UnmodifiableMapView<String, Object>({'b': 'x'})"
            ".cast<String, int>()['b']",
        'Uint8List.fromList([1]).cast<String>().first',
      ]) {
        expect(_run(expr), startsWith('TypeError'), reason: expr);
      }
    });

    test('GHI30-6: writes through the view are checked and reach the source '
        '[2026-11-10]', () {
      expect(
        _run(
          '(() { final l = <Object>[1]; final c = l.cast<int>(); c.add(2); '
          'return l.length; })()',
        ),
        2,
      );
      expect(
        _run(
          "(() { final l = <Object>[1]; final dynamic c = l.cast<int>(); "
          "c.add('a'); return l.length; })()",
        ),
        startsWith('TypeError'),
      );
    });

    test('GHI30-7: a script class, enum and bridged class are judged '
        '[2026-11-10]', () {
      expect(_run('[B(), A()].cast<B>().toList()'), startsWith('TypeError'));
      expect(_run('[E.a, 1].cast<E>().toList()'), startsWith('TypeError'));
      expect(
        _run('[Gh30Square(), A()].cast<Gh30Shape>().toList()'),
        startsWith('TypeError'),
      );
      // A non-list element fails `cast<List<int>>()`; the nested contents are
      // checked too since ghissues36 (GHI36-3).
      expect(
        _run("[[1], 'a'].cast<List<int>>().toList()"),
        startsWith('TypeError'),
      );
    });
  });

  group('GHI30-L: legitimate casts keep working', () {
    // Each answers the element count; a TypeError here is a false error.
    const legitimate = <String>[
      '[1, 2].cast<int>()',
      '[1, 2.5].cast<num>()',
      "[1, 'a'].cast<Object>()",
      "[1, 'a'].cast<dynamic>()",
      "[1, 'a'].cast<Object?>()",
      '[1, null].cast<int?>()',
      '[1, null].cast<int>().take(1)',
      "['a', 'b'].cast<String>()",
      "['a'].cast<Pattern>()",
      "['a', 1].cast<Comparable>()",
      '[1, 2].cast<Comparable<num>>()',
      '[DateTime(2020), Duration.zero].cast<Comparable>()',
      '[B(), B()].cast<A>()',
      '[B()].cast<B>()',
      '[Marked()].cast<Gh30Marker>()',
      '[Gh30Square(), Circle()].cast<Gh30Shape>()',
      '[E.a, E.b].cast<E>()',
      '[E.a].cast<Enum>()',
      '[() => 1, print].cast<Function>()',
      '[() => 1].cast<int Function()>()',
      '[(1, 2)].cast<(int, int)>()',
      '[(1, 2)].cast<Record>()',
      '[[1, 2], [3]].cast<List<int>>()',
      '[[1, null]].cast<List<int?>>()',
      "[{'a': 1}].cast<Map<String, int>>()",
      "[{'a': 1}].cast<Map<String, dynamic>>()",
      '[[1]].cast<IntList>()',
      '[[1], {2}].cast<Iterable<int>>()',
      '[{1}].cast<Set<int>>()',
      '[Box<int>(1), Box(2)].cast<Box<int>>()',
      "[MapEntry('a', 1)].cast<MapEntry<String, int>>()",
      '[Future.value(1)].cast<Future<int>>()',
      '[1, 2].toSet().cast<int>()',
      '[1, 2].where((_) => true).cast<num>()',
      'castTo<int>([1, 2])',
      'Uint8List.fromList([1, 2]).cast<int>()',
    ];
    for (final expr in legitimate) {
      test('GHI30-L: $expr [2026-11-10]', () {
        expect(_run('$expr.toList().length'), isA<int>(), reason: expr);
      });
    }

    test('GHI30-L-map: a legitimate Map cast reads every entry '
        '[2026-11-10]', () {
      expect(
        _run(
          "{'a': 1, 'b': null}.cast<String, int?>().entries"
          ".map((e) => '\${e.key}=\${e.value}').join(',')",
        ),
        'a=1,b=null',
      );
      expect(
        _run("{'a': [1]}.cast<String, List<int>>().values.first.first"),
        1,
      );
    });
  });
}
