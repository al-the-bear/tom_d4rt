// Writes tom_d4rt_ast's resolved-bundle fixture (ghissues70):
//
//   dart run tool/write_resolved_bundle_fixture.dart
//
// Bundles `../tom_d4rt_ast/test/runtime/fixtures/ghissues70_map_cases.dart.txt`
// (GitHub #18's map cases) in resolving mode, with a declaration stub for
// the host library it imports, and writes the bundle's JSON - static facts
// table included - beside it as `ghissues70_map_cases.bundle.json`.
// tom_d4rt_ast cannot depend on this package, so its test reads the JSON.
// Run again after a change to the source, the facts or the bundle format.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

const _entry = 'package:map_repro/entry.dart';
const _native = 'package:map_repro/native.dart';

/// The host library, registered at run time; the resolver checks against it.
const _stub = '''
Map<String, int> sameMap() => throw UnimplementedError();
Map<String, int> emptyMap() => throw UnimplementedError();
''';

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
    p.join(fixtures, 'ghissues70_map_cases.dart.txt'),
  ).readAsStringSync();
  final resolver = AstResolver();
  try {
    final bundle = await AstBundler(
      bridgedLibraries: {_native},
      explicitSources: {_entry: source},
      declarationStubs: {_native: _stub},
      fileAccessValidator: (_) => false,
      config: const AstBundlerConfig(resolve: true),
      resolver: resolver,
    ).createFromSource(source, sourcePath: _entry);
    if (bundle is! ResolvedAstBundle) {
      stderr.writeln('write_resolved_bundle_fixture: no static facts recorded');
      exitCode = 1;
      return;
    }
    final out = File(p.join(fixtures, 'ghissues70_map_cases.bundle.json'));
    out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
    print(
      'Wrote ${out.path}: ${bundle.facts.factCount} facts, '
      '${bundle.facts.types.length} types',
    );
  } finally {
    await resolver.dispose();
  }
}
