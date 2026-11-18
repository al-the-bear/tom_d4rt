// Writes tom_d4rt_ast's ghissues80 bundle fixtures:
//
//   dart run tool/write_ghissues80_fixtures.dart
//
// Bundles `../tom_d4rt_ast/test/runtime/fixtures/ghissues80_program.dart` -
// a type argument compared with a type literal that has type arguments,
// `T == List<String>` (GitHub #24) - parse-only and in resolving mode, to
// `ghissues80_parse_only.bundle.json` and `ghissues80_resolved.bundle.json`
// beside it. tom_d4rt_ast cannot depend on this package, so its test reads
// the JSON. Run again after a change to the program (it is a copy of
// tom_d4rt's `test/fixtures/ghissues80_program.dart`).

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _entry = 'package:ghissues80/program.dart';

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
    p.join(fixtures, 'ghissues80_program.dart'),
  ).readAsStringSync();
  final resolver = AstResolver();
  try {
    for (final (name, config) in [
      ('parse_only', const AstBundlerConfig()),
      ('resolved', const AstBundlerConfig(resolve: true)),
    ]) {
      final bundle = await AstBundler(
        explicitSources: {_entry: source},
        fileAccessValidator: (_) => false,
        config: config,
        resolver: resolver,
      ).createFromSource(source, sourcePath: _entry);
      final out = File(p.join(fixtures, 'ghissues80_$name.bundle.json'));
      out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
      print('Wrote ${out.path}: ${bundle.modules.length} module(s)');
    }
  } finally {
    await resolver.dispose();
  }
}
