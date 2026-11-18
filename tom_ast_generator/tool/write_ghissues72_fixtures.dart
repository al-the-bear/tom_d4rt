// Writes tom_d4rt_ast's ghissues72 bundle fixture:
//
//   dart run tool/write_ghissues72_fixtures.dart
//
// Bundles the program of tom_d4rt's
// `test/ghissues72_generic_instance_runtime_type_test.dart` - an interpreted
// generic instance's `runtimeType` with its type arguments - and writes its
// JSON to `../tom_d4rt_ast/test/runtime/fixtures/ghissues72_runtime_type.bundle.json`.
// tom_d4rt_ast cannot depend on this package, so its test reads the JSON. Run
// again after changing the program below.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _source = r'''
class Box<T> {}
class Pair<A, B> {}
class Plain {}
class N<T extends num> {}

Object printed() => [
  Box<int>().runtimeType.toString(),
  '${Box<String>().runtimeType}',
  Pair<int, String?>().runtimeType.toString(),
  Box<List<int>>().runtimeType.toString(),
  N<int>().runtimeType.toString(),
];

Object compared() {
  final m = <Type, String>{};
  m[Box<int>().runtimeType] = 'int box';
  return [
    Box<int>().runtimeType == Box<int>().runtimeType,
    Box<int>().runtimeType == Box<String>().runtimeType,
    Box<int>().runtimeType == Box,
    N<int>().runtimeType == N<num>().runtimeType,
    Box<int>().runtimeType is Type,
    m[Box<int>().runtimeType],
    m[Box<String>().runtimeType],
    {Box<int>().runtimeType, Box<int>().runtimeType, Box<String>().runtimeType}
        .length,
    Box<int>().runtimeType.hashCode == Box<int>().runtimeType.hashCode,
  ];
}

Object raw() => [
  Plain().runtimeType == Plain,
  Plain().runtimeType.toString(),
  Box().runtimeType == Box,
  Box<dynamic>().runtimeType == Box,
  N().runtimeType == N,
  Box().runtimeType.toString(),
];
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
        'ghissues72_runtime_type.bundle.json',
      ),
    ),
  );
  out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
  print('Wrote ${out.path}');
}
