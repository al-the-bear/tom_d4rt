// ghissues73 — a write into a collection the script created with
// written type arguments is checked against them, as Dart's run-time check
// does: `(<String>[] as dynamic).add(1)` throws
// `type 'int' is not a subtype of type 'String' of 'value'`. Every
// expectation is native Dart 3.13's, except where noted: four writes Dart
// refuses for the ARGUMENT's static type (an untyped `[1]`, a closure typed
// `() => String`, a `Map<String, String>` literal, a `List<MapEntry<..>>`)
// are refused here for the element they would store, with that element in
// the message.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _program = r'''
class P {}
class Q extends P {}

String t(void Function() f) {
  try {
    f();
    return 'ok';
  } on TypeError catch (e) {
    return 'TypeError: $e';
  }
}

Object rejected() {
  final l = <String>['a'];
  final s = <int>{};
  final m = <String, int>{};
  final p = <P>[];
  return [
    t(() => (l as dynamic).add(1)),
    t(() => (l as dynamic).insert(0, 1)),
    t(() => (l as dynamic)[0] = 1),
    t(() => (l as dynamic).add(null)),
    t(() => (l as dynamic).addAll(<Object>['s'])),
    t(() => (s as dynamic).add('x')),
    t(() => (m as dynamic)['k'] = 'v'),
    t(() => (m as dynamic)[1] = 2),
    t(() => (p as dynamic).add('x')),
    t(() {
      final x = <String>['a'];
      (x as dynamic)..[0] = 5;
    }),
  ];
}

Object rejectedByValue() {
  final l = <String>[];
  final m = <String, int>{};
  return [
    t(() => (l as dynamic).addAll([1])),
    t(() => (m as dynamic).putIfAbsent('a', () => 'v')),
    t(() => (m as dynamic).addAll({'b': 'v'})),
    t(() => (m as dynamic).addEntries([MapEntry('z', 'bad')])),
  ];
}

Object accepted() {
  final l = <String>['a'];
  final n = <String?>[];
  final p = <P>[];
  final m = <String, int>{};
  final u = [];
  final um = {};
  (u as dynamic).add(1);
  um[1] = 'x';
  l.add('b');
  (l as dynamic).addAll(['c']);
  l[0] = 'z';
  (n as dynamic).add(null);
  (p as dynamic).add(Q());
  m['k'] = 1;
  m.putIfAbsent('j', () => 2);
  m.update('k', (v) => v + 1);
  final d = <double>[];
  d.add(1);
  return ['$l', '$n', p.length, '$m', '$u', '$um', '$d'];
}
''';

Object? _run(String entry) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {'package:p/main.dart': '$_program\nObject main() => $entry();\n'},
);

void main() {
  group('ghissues73: writes into a written collection', () {
    test('GH73-1: a wrongly typed element is refused as in Dart, with '
        'its message [2026-11-18]', () {
      expect(_run('rejected'), [
        "TypeError: type 'int' is not a subtype of type 'String' of 'value'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'element'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'value'",
        "TypeError: type 'Null' is not a subtype of type 'String' of 'value'",
        "TypeError: type 'List<Object>' is not a subtype of type 'Iterable<String>' of 'iterable'",
        "TypeError: type 'String' is not a subtype of type 'int' of 'key'",
        "TypeError: type 'String' is not a subtype of type 'int' of 'value'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'key'",
        "TypeError: type 'String' is not a subtype of type 'P' of 'value'",
        "TypeError: type 'int' is not a subtype of type 'String' of 'value'",
      ]);
    });

    test('GH73-2: an argument whose static type Dart refuses is refused for '
        'the element it would store [2026-11-18]', () {
      final results = (_run('rejectedByValue') as List).cast<String>();
      expect(results, hasLength(4));
      expect(results, everyElement(startsWith('TypeError: ')));
    });

    test('GH73-3: correct writes, untyped collections and an int into a '
        'double list (widened) are accepted [2026-11-18]', () {
      expect(_run('accepted'), [
        '[z, b, c]',
        '[null]',
        1,
        '{k: 2, j: 2}',
        '[1]',
        '{1: x}',
        '[1.0]',
      ]);
    });
  });
}
