// ghissues67 — a collection a script creates keeps its written type
// arguments.
//
// Found 2026-11-17 while measuring GitHub al-the-bear/tom_d4rt#18's map
// cases (Serverpod's `MapJsonExtension.toJson()` chooses `{}` or `[]` by its
// `K`). In both trees, and in the published releases, a collection written
// with type arguments kept none of them: `<String, int>{}` was a native
// `_Map<Object?, Object?>`, so its `runtimeType` said so, `<String>[] is
// List<int>` was true (an empty collection passed every element check), `as`
// let it through, and an extension's `K` bound `dynamic` where Dart binds
// `String`.
//
// The collection stays the native object it was (bridged code receives what
// it received before; a script class cannot be a native type argument), and
// the type arguments it was written with are recorded beside it
// (`recordWrittenCollectionTypeArguments`): list, set and map literals, and
// the `List` / `Set` / `Map` constructors (`Map<String, int>()`,
// `List<String>.empty()`, `.filled`, `.generate`). `is` / `as`, `runtimeType`
// and extension type-parameter binding read them. An untyped literal
// (`{'x': 7}`) still has none: Dart infers those (the B2 facts, ghissues68-70).
//
// Every expectation is native Dart's output (Dart 3.13.7, 2026-11-17).

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Runs [body] (statements ending in a `return`) after [declarations], each
/// element of the returned list rendered as Dart's `toString` renders it.
List<String> run(String body, {String declarations = ''}) {
  final result = D4rt().execute(
    source: '$declarations\ndynamic main() {\n$body\n}',
  );
  return [for (final value in result as List) '$value'];
}

const _extensions = '''
class P {}
extension KeyKind<K, V> on Map<K, V> { String keyKind() => K.toString(); }
extension EK<E> on List<E> { String ek() => E.toString(); }
extension MapJson<K, V> on Map<K, V> {
  Object toJson() => K == String ? <String, Object?>{} : <Object?>[];
}
''';

void main() {
  group('ghissues67: runtimeType', () {
    test('GH67-1: a literal\'s runtimeType names its written type arguments '
        '[2026-11-17]', () {
      expect(
        run('''
final m = <String, int>{};
return [
  <String>[].runtimeType, m.runtimeType, <String>{}.runtimeType,
  <int?>[].runtimeType, <List<int>>[].runtimeType,
  const <String>['a'].runtimeType,
  List<String>.empty(growable: true).runtimeType,
];
'''),
        [
          'List<String>',
          '_Map<String, int>',
          '_Set<String>',
          'List<int?>',
          'List<List<int>>',
          'List<String>',
          'List<String>',
        ],
      );
    });
    test('GH67-10: a written runtimeType compares like Dart\'s, and is a '
        'Type [2026-11-17]', () {
      expect(
        run('''
return [
  <String>[].runtimeType == <String>[].runtimeType,
  <String>[].runtimeType == <int>[].runtimeType,
  <String, int>{}.runtimeType == <String, int>{}.runtimeType,
  <String>[].runtimeType is Type,
];
'''),
        ['true', 'false', 'true', 'true'],
      );
    });
  });

  group('ghissues67: is and as', () {
    test('GH67-2: an empty collection is tested by its written type '
        '[2026-11-17]', () {
      expect(
        run('''
return [
  <String>[] is List<int>, <String, int>{} is Map<int, int>,
  <String>{} is Set<int>, <String>[] is List<String>,
  <String>[] is Iterable<int>, <String>[] is Iterable<String>,
];
'''),
        ['false', 'false', 'false', 'true', 'false', 'true'],
      );
    });

    test('GH67-3: covariance, nullability, nesting and top types follow '
        'Dart [2026-11-17]', () {
      expect(
        run('''
return [
  <num>[1] is List<int>, <int>[1] is List<num>, <int>[1] is List<int>,
  <int?>[] is List<int>, <int>[] is List<int?>,
  <List<int>>[] is List<List<num>>, <dynamic>[] is List<int>,
  <Object>[] is List<Object?>, const <String>['a'] is List<int>,
  List<int>.generate(2, (i) => i) is List<String>,
];
'''),
        [
          'false', 'true', 'true', //
          'false', 'true',
          'true', 'false',
          'true', 'false',
          'false',
        ],
      );
    });

    test('GH67-4: as refuses a collection whose written type does not fit, '
        'naming it [2026-11-17]', () {
      expect(
        () => D4rt().execute(
          source: 'dynamic main() => <String>[] as List<int>;',
        ),
        throwsA(
          predicate(
            (Object e) => '$e'.contains('value of type List<String>'),
            'a cast error naming List<String>',
          ),
        ),
      );
      expect(run('return [(<int>[1] as List<num>).length];'), ['1']);
    });

    test('GH67-5: a script class as a type argument [2026-11-17]', () {
      expect(
        run(
          'return [<P>[].ek(), <P>[] is List<P>, <P>[] is List<String>, '
          '<P>[].runtimeType];',
          declarations: _extensions,
        ),
        ['P', 'true', 'false', 'List<P>'],
      );
    });

    test('GH67-6: type parameters reify as Dart reifies them [2026-11-17]', () {
      expect(
        run(
          '''
return [
  Box<int>().make() is List<int>, Box<int>().make() is List<String>,
  Box<int>().make().runtimeType, Box().make() is List<int>,
  Box().make().runtimeType, f<int>() is List<int>, f<String>() is List<int>,
  Box<String>().map() is Map<String, String>,
  Box<String>().map() is Map<String, int>,
  <Dog>[] is List<Animal>, <Animal>[] is List<Dog>,
];
''',
          declarations: '''
class Box<T> { List<T> make() => <T>[]; Map<String, T> map() => <String, T>{}; }
List<T> f<T>() => <T>[];
class Animal {}
class Dog extends Animal {}
''',
        ),
        [
          'true', 'false', 'List<int>', 'false', 'List<dynamic>', //
          'true', 'false', 'true', 'false', 'true', 'false',
        ],
      );
    });
  });

  group('ghissues67: extension type parameters', () {
    test('GH67-7: K and E bind the written type arguments, literal or '
        'constructed [2026-11-17]', () {
      expect(
        run('''
final m = <String, int>{};
return [
  <String, int>{}.keyKind(), Map<String, int>().keyKind(), m.keyKind(),
  <String>[].ek(), List<String>.empty().ek(), List<String>.filled(1, 'a').ek(),
];
''', declarations: _extensions),
        ['String', 'String', 'String', 'String', 'String', 'String'],
      );
    });

    test('GH67-8: Serverpod\'s case - toJson() on an empty map chooses by '
        'its written K [2026-11-17]', () {
      expect(
        run('''
final Map<String, int> narrow = {};
final Map<dynamic, dynamic> wide = narrow;
return [<String, int>{}.toJson(), narrow.toJson(), wide.toJson()];
''', declarations: _extensions),
        ['{}', '{}', '[]'],
      );
    });

    test('GH67-9: an untyped literal has no written type arguments and '
        'still binds dynamic, as before (Lim-13) [2026-11-17]', () {
      // Dart infers `Map<String, int>` and binds `String`; the interpreter
      // has no static types. ghissues68-70 (B2 facts) close this.
      expect(run("return [{'x': 7}.keyKind()];", declarations: _extensions), [
        'dynamic',
      ]);
    });
  });
}
