// GEN-119: auxiliary imports must always be emitted as `package:` URIs.
//
// Regression guard for the broken import line found in
// `tom_dist_ledger/lib/src/d4rt_bridges/tom_dist_ledger_bridges.b.dart`:
//
//     import 'lib/src/ledger_api/ledger_api.dart' as $aux_aux;
//
// A project-relative path where a package URI belongs — it resolves against
// the *generated file's* directory, so the import pointed at the
// non-existent `lib/src/d4rt_bridges/lib/src/ledger_api/ledger_api.dart`.
// The correct URI for the very same library was emitted a few lines above as
// `package:tom_dist_ledger/src/ledger_api/ledger_api.dart`.
//
// The chain: d4rtgen runs with `-s .`, so `workspacePath` is relative. The own
// package's `rootUri` in `.dart_tool/package_config.json` is `../`, which
// normalised against a relative workspace path collapses to a relative root.
// `_getFilePathForPackageUri` therefore handed back a relative path, and when
// the requested type turned out to live in a `part of` file (`DLLogLevel` in
// `call_callback.dart`) `_resolvePartOfToParent` derived the parent path
// relatively too. `_getPackageUri` returns its input unchanged whenever it
// cannot map a path back to a package, so a bare path entered the
// auxiliary-import map. The `$aux_aux` prefix is the fingerprint: both prefix
// factories fall back to the literal `aux` base name for a non-`package:` URI.
//
// The fix is at the root of the chain — package roots always resolve to
// absolute paths — plus a guard in the part-of resolver and a last-resort
// guard at the import writer, so a malformed URI can never reach the
// generated file again.
//
// NOTE ON TEST DESIGN: this file deliberately does NOT chdir. `dart test` runs
// test files as isolates inside one process and `Directory.current` is
// process-wide, so changing it here fails the `setUpAll` of every other test
// file that resolves fixtures relative to the cwd.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

/// Every `import '…';` URI a generated bridge file emits, in source order.
Iterable<String> importUrisOf(String generatedCode) => RegExp(
  r"""^import\s+'([^']+)'""",
  multiLine: true,
).allMatches(generatedCode).map((m) => m.group(1)!);

/// Writes a minimal package containing a library and a `part of` file.
///
/// When [withPubspec] is false the package has no `pubspec.yaml`, which is how
/// `_getPackageNameFromPath` is made to fail — the condition under which
/// `_getPackageUri` gives up and returns the raw path it was handed.
Directory writePartOfFixture({required bool withPubspec, required String tag}) {
  final dir = Directory.systemTemp.createTempSync('gen119_${tag}_');

  if (withPubspec) {
    File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
      'name: zom_partfix\n'
      'environment:\n'
      "  sdk: '>=3.0.0 <4.0.0'\n",
    );
  }

  Directory(p.join(dir.path, '.dart_tool')).createSync();
  File(p.join(dir.path, '.dart_tool', 'package_config.json')).writeAsStringSync(
    '{\n'
    '  "configVersion": 2,\n'
    '  "packages": [\n'
    '    {\n'
    '      "name": "zom_partfix",\n'
    '      "rootUri": "../",\n'
    '      "packageUri": "lib/",\n'
    '      "languageVersion": "3.0"\n'
    '    }\n'
    '  ]\n'
    '}\n',
  );

  final libDir = Directory(p.join(dir.path, 'lib'))..createSync();
  File(p.join(libDir.path, 'parent_lib.dart')).writeAsStringSync(
    'library;\n'
    "part 'child_part.dart';\n",
  );
  File(p.join(libDir.path, 'child_part.dart')).writeAsStringSync(
    "part of 'parent_lib.dart';\n"
    '\n'
    'enum ZomLevel { debug, info }\n',
  );

  return dir;
}

void main() {
  // d4rtgen is invoked as `d4rtgen -s .` from the consumer's project root, so
  // what matters is that `workspacePath` is *relative*. Passing a relative
  // path to the fixture reproduces that without touching the process cwd.
  late Directory resolvableFixture;
  late Directory unresolvableFixture;

  setUpAll(() {
    resolvableFixture = writePartOfFixture(
      withPubspec: true,
      tag: 'resolvable',
    );
    unresolvableFixture = writePartOfFixture(
      withPubspec: false,
      tag: 'unresolvable',
    );
  });

  tearDownAll(() {
    for (final dir in [resolvableFixture, unresolvableFixture]) {
      try {
        dir.deleteSync(recursive: true);
      } catch (_) {}
    }
  });

  BridgeGenerator generatorFor(Directory fixture, {String? packageName}) =>
      BridgeGenerator(
        workspacePath: p.relative(fixture.path),
        packageName: packageName,
      );

  group('GEN-119: auxiliary import URI resolution', () {
    test(
      'G-GEN119-01: package roots are absolute even for a relative '
      'workspacePath [2026-08-03] (FAIL)',
      () {
        final root = generatorFor(
          resolvableFixture,
          packageName: 'zom_partfix',
        ).packageRootForTesting('zom_partfix');

        expect(root, isNotNull, reason: 'fixture package must resolve');
        expect(
          p.isAbsolute(root!),
          isTrue,
          reason:
              'A relative package root propagates into every path derived '
              'from it. `_getPackageUri` maps a path back to a package URI by '
              'scanning for a `/lib/` segment, which a path that *starts* '
              'with `lib/` does not have — so it silently returns the bare '
              'path. Root was: $root',
        );
      },
    );

    test(
      'G-GEN119-02: a part-of file resolves to its parent as a package URI '
      '[2026-08-03] (PASS)',
      () {
        final parent = generatorFor(
          resolvableFixture,
          packageName: 'zom_partfix',
        ).partOfParentUriForTesting('package:zom_partfix/child_part.dart');

        expect(
          parent,
          equals('package:zom_partfix/parent_lib.dart'),
          reason:
              'Part files are not independently importable, so GEN-060 '
              'rewrites them to the parent library. The rewrite must stay a '
              'package URI.',
        );
      },
    );

    test(
      'G-GEN119-03: a parent that cannot be mapped back to a package keeps '
      'the original URI instead of degrading to a bare path [2026-08-03] '
      '(FAIL)',
      () {
        // No pubspec.yaml and no packageName, so `_getPackageUri` cannot name
        // the package and hands the raw file path straight back. That is the
        // exact failure mode that produced the `$aux_aux` line; the resolver
        // must not propagate it.
        const uri = 'package:zom_partfix/child_part.dart';
        final resolved = generatorFor(
          unresolvableFixture,
        ).partOfParentUriForTesting(uri);

        expect(
          resolved.startsWith('package:') || resolved.startsWith('dart:'),
          isTrue,
          reason: '$uri resolved to a non-importable URI: $resolved',
        );
        expect(
          resolved,
          equals(uri),
          reason:
              'When the parent cannot be expressed as a package URI the safe '
              'answer is the part file\'s own URI, which is importable.',
        );
      },
    );
  });

  // FIX step 2 of scc69: a regen smoke gate. The defect shipped because the
  // consumer's `analysis_options.yaml` excludes `lib/src/d4rt_bridges/**`, so
  // `dart analyze` reported the project clean while the generated file held an
  // import that resolved nowhere. Analysing the emitted file standalone is not
  // viable — without a package_config every `package:` import would fail too —
  // so the gate asserts the property that actually separates good output from
  // bad: every emitted import URI must be absolute (`package:` / `dart:`),
  // because the generated file's own directory is never the resolution base.
  group('GEN-119: regen smoke gate over the fixture corpus', () {
    late String outputDir;

    setUpAll(() {
      outputDir = Directory.systemTemp
          .createTempSync('gen119_regen_smoke_gate_')
          .path;
    });

    tearDownAll(() {
      try {
        Directory(outputDir).deleteSync(recursive: true);
      } catch (_) {}
    });

    // `user_proxy_relaxer_source.dart` is the only fixture in the corpus that
    // reaches the auxiliary-import writer at all (it pulls in
    // `package:tom_d4rt/src/generator/d4.dart` as `$aux_tom_d4rt`), so it is
    // what makes this gate non-vacuous — G-GEN119-05 pins that fact so the
    // gate cannot quietly stop testing anything. The rest exercise the primary
    // import writer.
    const auxBearingFixture = 'user_proxy_relaxer_source.dart';

    Future<String> generate(String fixture) async {
      final fixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
      final generator = BridgeGenerator(
        workspacePath: fixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: false,
      );

      final result = await generator.generateBridges(
        sourceFiles: [p.join(fixturesDir, fixture)],
        outputPath: p.join(outputDir, 'smoke_$fixture'),
        moduleName: 'smoke',
      );

      expect(result.outputFiles, isNotEmpty, reason: 'no output for $fixture');
      return File(result.outputFiles.first).readAsString();
    }

    for (final fixture in const [
      auxBearingFixture,
      'default_values_source.dart',
      'cross_file_reference_source.dart',
      'flutter_patterns_source.dart',
      'type_alias_source.dart',
    ]) {
      test(
        'G-GEN119-04[$fixture]: every emitted import is a package: or dart: '
        'URI [2026-08-03] (PASS)',
        () async {
          final uris = importUrisOf(await generate(fixture)).toList();
          expect(uris, isNotEmpty, reason: 'expected an import block');

          final bad = uris
              .where((u) => !u.startsWith('package:') && !u.startsWith('dart:'))
              .toList();
          expect(
            bad,
            isEmpty,
            reason:
                "Non-absolute imports resolve against the generated file's "
                'own directory, which is never the package root. Offenders: '
                '$bad',
          );
        },
      );
    }

    test(
      'G-GEN119-05: the smoke gate actually exercises the auxiliary-import '
      'writer [2026-08-03] (PASS)',
      () async {
        final auxImports = RegExp(
          r"""^import\s+'([^']+)'\s+as\s+(\$aux_\w+);""",
          multiLine: true,
        ).allMatches(await generate(auxBearingFixture));

        expect(
          auxImports,
          isNotEmpty,
          reason:
              'G-GEN119-04 only gates the auxiliary-import writer while some '
              'fixture still drives it. If this fails, the corpus stopped '
              'producing $auxBearingFixture-style auxiliary imports and '
              'G-GEN119-04 has become vacuous — add a fixture that emits one '
              'rather than deleting this test.',
        );
      },
    );
  });
}
