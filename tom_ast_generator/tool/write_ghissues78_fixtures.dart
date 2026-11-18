// Writes tom_d4rt_ast's ghissues78 bundle fixture:
//
//   dart run tool/write_ghissues78_fixtures.dart
//
// Bundles GitHub #22's repro - a function annotated `@m.useResult` through a
// prefixed import of package:meta (a stand-in source for it) - to
// `../tom_d4rt_ast/test/runtime/fixtures/ghissues78_prefixed_annotation.bundle.json`.
// tom_d4rt_ast cannot depend on this package, so its test reads the JSON.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _entry = 'package:p/main.dart';

const _repro = '''
import 'package:meta/meta.dart' as m;
@m.useResult
int f() => 1;
int main() => f();
''';

const _metaStub = '''
class UseResult {
  const UseResult();
}
const useResult = UseResult();
''';

Future<void> main() async {
  final bundle = await AstBundler(
    explicitSources: {_entry: _repro, 'package:meta/meta.dart': _metaStub},
    fileAccessValidator: (_) => false,
  ).createFromSource(_repro, sourcePath: _entry);
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
        'ghissues78_prefixed_annotation.bundle.json',
      ),
    ),
  );
  out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
  print('Wrote ${out.path}: ${bundle.modules.length} module(s)');
}
