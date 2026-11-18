// Writes tom_d4rt_ast's ghissues79 bundle fixtures:
//
//   dart run tool/write_ghissues79_fixtures.dart
//
// Bundles GitHub #23's two files - tom_d4rt's
// `test/fixtures/ghissues79/main.dart` and `protocol.dart` (a constructor
// tear-off through an import prefix, `generated.Protocol.new`) - the way the
// issue runs them: parse-only and in resolving mode. Writes
// `ghissues79_parse_only.bundle.json` and `ghissues79_resolved.bundle.json` to
// `../tom_d4rt_ast/test/runtime/fixtures/`. tom_d4rt_ast cannot depend on this
// package, so its test reads the JSON.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _entry = 'package:p/main.dart';

Future<void> main() async {
  final here = p.dirname(Platform.script.toFilePath());
  String read(String file) => File(
    p.join(
      here,
      '..',
      '..',
      'tom_d4rt',
      'test',
      'fixtures',
      'ghissues79',
      file,
    ),
  ).readAsStringSync();
  final sources = {
    _entry: read('main.dart'),
    'package:p/protocol.dart': read('protocol.dart'),
  };
  final fixtures = p.normalize(
    p.join(here, '..', '..', 'tom_d4rt_ast', 'test', 'runtime', 'fixtures'),
  );
  final resolver = AstResolver();
  try {
    for (final (name, config) in [
      ('parse_only', const AstBundlerConfig()),
      ('resolved', const AstBundlerConfig(resolve: true)),
    ]) {
      final bundle = await AstBundler(
        explicitSources: sources,
        fileAccessValidator: (_) => false,
        config: config,
        resolver: resolver,
      ).createFromSource(sources[_entry]!, sourcePath: _entry);
      final out = File(p.join(fixtures, 'ghissues79_$name.bundle.json'));
      out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
      print('Wrote ${out.path}: ${bundle.modules.length} module(s)');
    }
  } finally {
    await resolver.dispose();
  }
}
