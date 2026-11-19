// Writes tom_d4rt_ast's resolved-bundle fixtures:
//
//   dart run tool/write_resolved_bundle_fixture.dart
//
// Bundles each `<name>.dart.txt` of [_fixtures] in
// `../tom_d4rt_ast/test/runtime/fixtures/` in resolving mode, with a
// declaration stub for the host library it imports, and writes the bundle's
// JSON - static facts table included - beside it as `<name>.bundle.json`:
//
// * `ghissues70_map_cases`: GitHub #18's map cases (ghissues70);
// * `ghissues75_operator_cases`: extension operators, index operators and
//   setters (ghissues75).
//
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
Set<String> sameSet() => throw UnimplementedError();
''';

const _fixtures = ['ghissues70_map_cases', 'ghissues75_operator_cases'];

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
  final resolver = AstResolver();
  try {
    for (final name in _fixtures) {
      await _write(fixtures, name, resolver);
    }
  } finally {
    await resolver.dispose();
  }
}

Future<void> _write(String fixtures, String name, AstResolver resolver) async {
  final source = File(p.join(fixtures, '$name.dart.txt')).readAsStringSync();
  {
    final bundle = await AstBundler(
      bridgedLibraries: {_native},
      explicitSources: {_entry: source},
      declarationStubs: {_native: _stub},
      fileAccessValidator: (_) => false,
      config: const AstBundlerConfig(resolve: true),
      resolver: resolver,
    ).createFromSource(source, sourcePath: _entry);
    final facts = bundle.facts;
    if (facts == null) {
      stderr.writeln(
        'write_resolved_bundle_fixture: no static facts recorded for $name',
      );
      exitCode = 1;
      return;
    }
    final out = File(p.join(fixtures, '$name.bundle.json'));
    out.writeAsStringSync('${jsonEncode(bundle.toJson())}\n');
    print(
      'Wrote ${out.path}: ${facts.factCount} facts, '
      '${facts.types.length} types',
    );
  }
}
