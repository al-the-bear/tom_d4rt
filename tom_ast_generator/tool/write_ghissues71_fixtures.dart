// Writes tom_d4rt_ast's ghissues71 bundle fixtures:
//
//   dart run tool/write_ghissues71_fixtures.dart
//
// Bundles the reductions of the three defects that kept Slang's package
// closure from loading (deferred imports, another library's private
// interface members, MapView as a superclass), each a small program with
// several entry functions, and writes their JSON to
// `../tom_d4rt_ast/test/runtime/fixtures/ghissues71_<name>.bundle.json`.
// tom_d4rt_ast cannot depend on this package, so its test reads the JSON;
// tom_d4rt's `test/ghissues71_slang_closure_test.dart` runs the same
// programs from source. Run again after changing a program below.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _fixtures = <String, Map<String, String>>{
  'deferred': {
    'package:p/main.dart': '''
import 'z.dart' deferred as z;
import 'y.dart';

Future<Object> loaded() async {
  await z.loadLibrary();
  return [z.f(), z.v, z.C().n];
}

Object callBefore() => z.f();

Object valueBefore() => z.v;

Object classBefore() => z.C();

Object caught() {
  try {
    return z.f();
  } catch (e) {
    return '\$e'.contains('Deferred library z was not loaded.');
  }
}

Future<Object> fromLibrary() => g();
''',
    'package:p/z.dart': '''
String f() => 'zf';
const v = 7;
class C { String get n => 'c'; }
''',
    'package:p/y.dart': '''
import 'z.dart' deferred as z;

Future<String> g() async {
  await z.loadLibrary();
  return z.f();
}
''',
  },
  'private': {
    'package:p/main.dart': '''
import 'i.dart';

class B implements A {
  int get x => 2;
}

Object main() => B().x;
''',
    'package:p/i.dart': '''
class A {
  int get x => 1;
  void _hidden() {}
}
''',
  },
  'private_same_library': {
    'package:p/main.dart': '''
class A {
  int get x => 1;
  void _hidden() {}
}

class B implements A {
  int get x => 2;
}

Object main() => B().x;
''',
  },
  'mapview': {
    'package:p/main.dart': '''
import 'dart:collection';

class PathMap<V> extends MapView<String?, V> {
  PathMap() : super({});
}

Object readWrite() {
  final m = PathMap<int>();
  m['a'] = 1;
  m.putIfAbsent('b', () => 2);
  return [m['a'], m.length, m.keys.toList(), m.containsKey('b'), '\$m'];
}

Object views() {
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
''',
  },
};

Future<void> main() async {
  final fixtures = p.normalize(
    p.join(
      p.dirname(Platform.script.toFilePath()),
      '..',
      '..',
      'tom_d4rt_ast',
      'test',
      'runtime',
      'fixtures',
    ),
  );
  for (final MapEntry(key: name, value: sources) in _fixtures.entries) {
    const entry = 'package:p/main.dart';
    final bundle = await AstBundler(
      explicitSources: sources,
      fileAccessValidator: (_) => false,
    ).createFromSource(sources[entry]!, sourcePath: entry);
    final out = File(p.join(fixtures, 'ghissues71_$name.bundle.json'));
    out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
    print('Wrote ${out.path}: ${bundle.modules.length} module(s)');
  }
}
