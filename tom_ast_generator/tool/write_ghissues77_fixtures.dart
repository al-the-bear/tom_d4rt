// Writes tom_d4rt_ast's ghissues77 bundle fixture:
//
//   dart run tool/write_ghissues77_fixtures.dart
//
// Bundles `../tom_d4rt_ast/test/runtime/fixtures/ghissues77_program.dart` -
// dart:collection's bases and Iterable as superclasses and mixins of script
// classes, and the fixes Slang's closure needed after them (GitHub #21) - to
// `ghissues77_program.bundle.json` beside it. tom_d4rt_ast cannot depend on
// this package, so its test reads the JSON. Run again after a change to the
// program (it is a copy of tom_d4rt's `test/fixtures/ghissues77_program.dart`).

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _entry = 'package:ghissues77/program.dart';

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
  final source = File(
    p.join(fixtures, 'ghissues77_program.dart'),
  ).readAsStringSync();
  final bundle = await AstBundler(
    explicitSources: {_entry: source},
    fileAccessValidator: (_) => false,
  ).createFromSource(source, sourcePath: _entry);
  final out = File(p.join(fixtures, 'ghissues77_program.bundle.json'));
  out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
  print('Wrote ${out.path}: ${bundle.modules.length} module(s)');
}
