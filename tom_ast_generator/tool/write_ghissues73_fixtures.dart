// Writes tom_d4rt_ast's ghissues73 bundle fixture:
//
//   dart run tool/write_ghissues73_fixtures.dart
//
// Bundles the program of tom_d4rt's
// `test/ghissues73_written_collection_writes_test.dart` - writes into a
// written collection checked against its type arguments - to
// `../tom_d4rt_ast/test/runtime/fixtures/ghissues73_writes.bundle.json`.
// tom_d4rt_ast cannot depend on this package, so its test reads the JSON.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _source = r'''
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

Future<void> main() async {
  const entry = 'package:p/main.dart';
  final bundle = await AstBundler(
    explicitSources: const {entry: _source},
    fileAccessValidator: (_) => false,
  ).createFromSource(_source, sourcePath: entry);
  final out = File(
    p.normalize(
      p.join(
        p.dirname(Platform.script.toFilePath()),
        '..',
        '..',
        'tom_d4rt_ast',
        'test',
        'runtime',
        'fixtures',
        'ghissues73_writes.bundle.json',
      ),
    ),
  );
  out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
  print('Wrote ${out.path}');
}
