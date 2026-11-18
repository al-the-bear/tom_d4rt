// ghissues71 — three defects that kept Slang's pure-Dart package closure
// (GitHub al-the-bear/tom_d4rt#21) from loading. Every expectation is what
// native Dart 3.13 answers for the same program.
//
// 1. Deferred imports: `loadLibrary()` completes, and a member read before
//    it throws `Deferred library <prefix> was not loaded.`, as the VM does
//    (Slang imports every non-base locale `deferred as l_<locale>`).
// 2. A library's `_` members are not part of the interface another library
//    implements (string_scanner's `SpanScanner implements LineScanner`).
// 3. `dart:collection`'s `MapView` is bridged and can be extended (path's
//    `PathMap extends MapView<String?, V>`).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String main, [Map<String, String> more = const {}]) =>
    D4rt().execute(
      library: 'package:p/main.dart',
      sources: {'package:p/main.dart': main, ...more},
    );

const _z = {
  'package:p/z.dart': '''
String f() => 'zf';
const v = 7;
class C { String get n => 'c'; }
''',
};

void main() {
  group('ghissues71: deferred imports', () {
    test('GH71-1: loadLibrary completes and the members resolve '
        '[2026-11-18]', () async {
      final result =
          await (_run('''
import 'z.dart' deferred as z;
Future<Object> main() async {
  await z.loadLibrary();
  return [z.f(), z.v, z.C().n];
}
''', _z)
              as Future);
      expect(result, ['zf', 7, 'c']);
    });

    test('GH71-2: a member read before loadLibrary throws as in Dart, '
        'callable or not [2026-11-18]', () {
      for (final body in ['z.f()', 'z.v', 'z.C()']) {
        expect(
          () => _run(
            "import 'z.dart' deferred as z;\nObject main() => $body;",
            _z,
          ),
          throwsA(
            isA<DeferredLibraryNotLoadedD4rtException>().having(
              (e) => e.message,
              'message',
              'Deferred library z was not loaded.',
            ),
          ),
          reason: body,
        );
      }
    });

    test('GH71-3: the script can catch it, and a library importing '
        'deferred loads it itself [2026-11-18]', () async {
      expect(
        _run('''
import 'z.dart' deferred as z;
Object main() {
  try {
    return z.f();
  } catch (e) {
    return '\$e'.contains('Deferred library z was not loaded.');
  }
}
''', _z),
        isTrue,
      );
      final result =
          await (_run("import 'y.dart';\nFuture<Object> main() => g();", {
                ..._z,
                'package:p/y.dart': '''
import 'z.dart' deferred as z;
Future<String> g() async {
  await z.loadLibrary();
  return z.f();
}
''',
              })
              as Future);
      expect(result, 'zf');
    });
  });

  group('ghissues71: another library\'s private interface members', () {
    test('GH71-4: a class implementing another library\'s interface need '
        'not implement its _ members [2026-11-18]', () {
      expect(
        _run(
          "import 'i.dart';\n"
          'class B implements A { int get x => 2; }\n'
          'Object main() => B().x;',
          {'package:p/i.dart': 'class A { int get x => 1; void _hidden() {} }'},
        ),
        2,
      );
    });

    test('GH71-5: in its own library it must, as Dart requires '
        '[2026-11-18]', () {
      expect(
        () => _run(
          'class A { int get x => 1; void _hidden() {} }\n'
          'class B implements A { int get x => 2; }\n'
          'Object main() => B().x;',
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("interface method '_hidden'"),
          ),
        ),
      );
    });
  });

  group('ghissues71: MapView', () {
    const pathMap = '''
import 'dart:collection';
class PathMap<V> extends MapView<String?, V> {
  PathMap() : super({});
}
''';

    test('GH71-6: a class extending MapView reads and writes the wrapped '
        'map [2026-11-18]', () {
      expect(
        _run('''
$pathMap
Object main() {
  final m = PathMap<int>();
  m['a'] = 1;
  m.putIfAbsent('b', () => 2);
  return [m['a'], m.length, m.keys.toList(), m.containsKey('b'), '\$m'];
}
'''),
        [
          1,
          2,
          ['a', 'b'],
          true,
          '{a: 1, b: 2}',
        ],
      );
    });

    test('GH71-7: MapView and UnmodifiableMapView by themselves, and is '
        '[2026-11-18]', () {
      expect(
        _run('''
$pathMap
Object main() {
  final source = {'k': 2};
  final view = MapView(source);
  view['j'] = 3;
  final m = PathMap<int>();
  return [
    source,
    view is Map,
    UnmodifiableMapView(source) is MapView,
    m is MapView,
    m is Map,
    m is Map<String?, int>,
  ];
}
'''),
        [
          {'k': 2, 'j': 3},
          true,
          true,
          true,
          true,
          true,
        ],
      );
      // Not as Dart: `m is Map<int, int>` is true here for an EMPTY PathMap
      // (Dart: false). The interpreter answers an untyped map's type
      // arguments from its entries, and an empty one passes (Lim-13).
    });
  });
}
