// GEN-121: analyse the generated bridge file for real, instead of asserting a
// property that stands in for analysing it.
//
// scc69 asked for a gate that "regenerates one small consumer into a temp dir
// and runs `dart analyze` on the *output file itself* (bypassing the project's
// exclude)". What shipped in `gen119_auxiliary_import_uri_test.dart` was a
// PROXY: every emitted import URI must be absolute. That proxy catches the one
// defect that shipped, and it is cheap enough to run over the whole fixture
// corpus — so it stays. What it cannot catch is everything else the analyzer
// would find, and GEN-120 proved that gap was not hypothetical: a duplicate key
// in `extensionSourceUris()` sailed past it.
//
// WHY THE STANDALONE ANALYSE WAS THOUGHT UNVIABLE, AND WHAT ACTUALLY FIXES IT
//
// Analysing an emitted file on its own really is all noise — measured, not
// assumed: a bridge generated from `test/fixtures/` and analysed where it lands
// reports 38 issues, every one of them a missing `package:` target or an
// identifier that the missing import would have defined. Two things are needed
// to turn that into signal, and only the first is obvious:
//
//   1. A `.dart_tool/package_config.json` next to the output, naming every
//      package the emitted file imports. This one is synthesised by copying the
//      generator's OWN resolved config — its entries are absolute `file://`
//      roots, so they resolve from anywhere — and appending the fixture package.
//
//   2. The fixture must be a real package whose types the generator can address
//      by `package:` URI. The corpus under `test/fixtures/` is not: those files
//      live outside any package `lib/`, so the generator cannot emit an import
//      for the very types it bridges, and the output is undefined-identifier
//      noise no package_config can fix. Hence the purpose-built package below.
//
// WHY THE FIXTURE LIVES IN `Directory.systemTemp` AND NOT UNDER THE REPO
//
// Not merely convention. An ancestor `pubspec.yaml`/package config in the
// workspace tree hijacks resolution for anything nested inside it: the same
// fixture, byte-identical, reports four `URI_DOES_NOT_EXIST` errors under
// `<ws-root>/ztmp/` and zero in `Directory.systemTemp`. A gate placed inside the
// tree would have been permanently, invisibly red.
//
// WARNINGS ARE FATAL UNLESS ALLOWLISTED
//
// scc72 asked for "zero errors; warnings as a reviewable allowlist rather than a
// hard failure". The allowlist is what makes warnings reviewable — but an
// unlisted warning must still fail, because `equal_keys_in_map` (the GEN-120
// defect) is a WARNING, not an error. A gate that only failed on errors would
// have been blind to the very defect that motivated it. The allowlist is
// currently empty: this fixture analyses completely clean.
//
// NOTE ON TEST DESIGN: like the GEN-119 and GEN-120 suites, this file
// deliberately does NOT chdir. `dart test` runs test files as isolates inside
// one process and `Directory.current` is process-wide.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

/// Diagnostics whose severity does not fail the gate.
///
/// `INFO` covers lints, which depend on the ambient SDK's default rule set and
/// on an `analysis_options.yaml` this synthetic package deliberately does not
/// have. Gating on them would make the suite fail on an SDK bump rather than on
/// a generator regression.
const _nonFatalSeverities = {'INFO'};

/// Analyzer warning codes that are known, reviewed, and accepted.
///
/// Deliberately empty. An entry here is a standing statement that a generated
/// file may carry that warning forever, so each addition wants a comment saying
/// who reviewed it and why it cannot be fixed at the generator.
const _allowedWarningCodes = <String>{};

/// One diagnostic line of `dart analyze --format=machine`.
///
/// The machine format is `SEVERITY|TYPE|CODE|FILE|LINE|COL|LENGTH|MESSAGE`.
class Diagnostic {
  Diagnostic({
    required this.severity,
    required this.code,
    required this.line,
    required this.message,
  });

  final String severity;
  final String code;
  final String line;
  final String message;

  static Diagnostic? tryParse(String raw) {
    final parts = raw.split('|');
    if (parts.length < 8) return null;
    return Diagnostic(
      severity: parts[0],
      code: parts[2],
      line: parts[4],
      // The message may itself contain `|`; rejoin whatever follows.
      message: parts.sublist(7).join('|'),
    );
  }

  @override
  String toString() => '$severity $code (line $line): $message';
}

/// Runs `dart analyze` over [directory] and returns the parsed diagnostics.
Future<List<Diagnostic>> analyzeDirectory(String directory) async {
  // `Platform.resolvedExecutable` is the Dart binary running this suite, so the
  // gate analyses with the same SDK the generator was tested against rather
  // than whatever `dart` happens to be first on PATH.
  final result = await Process.run(Platform.resolvedExecutable, [
    'analyze',
    '--format=machine',
    directory,
  ]);

  // Exit codes: 0 none, 1 usage/crash, 2 warnings only, 3 errors present.
  if (result.exitCode == 1) {
    fail(
      'dart analyze could not run (exit 1).\n'
      'stdout: ${result.stdout}\nstderr: ${result.stderr}',
    );
  }

  return const LineSplitter()
      .convert(result.stdout as String)
      .where((l) => l.trim().isNotEmpty)
      .map(Diagnostic.tryParse)
      .whereType<Diagnostic>()
      .toList();
}

/// Diagnostics from [all] that the gate treats as failures.
List<Diagnostic> fatalDiagnostics(List<Diagnostic> all) => all
    .where((d) => !_nonFatalSeverities.contains(d.severity))
    .where(
      (d) => !(d.severity == 'WARNING' && _allowedWarningCodes.contains(d.code)),
    )
    .toList();

/// A generated-bridge package that can be analysed standalone.
class GatePackage {
  GatePackage(this.root);

  final Directory root;

  String get generatedFilePath =>
      p.join(root.path, 'lib', 'zom_analyzegate_bridges.dart');

  String readGenerated() => File(generatedFilePath).readAsStringSync();

  void writeGenerated(String source) =>
      File(generatedFilePath).writeAsStringSync(source);
}

/// Builds the fixture package and generates its bridge into `lib/`.
///
/// The sources are chosen so the emitted file exercises the two code paths that
/// have actually shipped defects: cross-file `package:` imports (GEN-119) and a
/// `part of`-declared extension feeding `extensionSourceUris()` (GEN-120).
Future<GatePackage> buildGatePackage(String generatorRoot) async {
  final root = Directory.systemTemp.createTempSync('gen121_gate_');

  File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync(
    'name: zom_analyzegate\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n",
  );

  final libDir = Directory(p.join(root.path, 'lib'))..createSync();
  File(p.join(libDir.path, 'model.dart')).writeAsStringSync('''
library;

part 'level_part.dart';

class Counter {
  Counter(this.value);

  int value;

  int bump(int by) => value += by;

  String get label => 'c\$value';
}
''');
  File(p.join(libDir.path, 'level_part.dart')).writeAsStringSync('''
part of 'model.dart';

enum ZomLevel { debug, info }

extension ZomLevelExtension on ZomLevel {
  String get label => name.toUpperCase();

  bool isAtLeast(ZomLevel other) => index >= other.index;
}
''');
  // Importing the parent library is what wakes GEN-049 import discovery, the
  // second of the two paths that collect a part-declared extension.
  File(p.join(libDir.path, 'consumer.dart')).writeAsStringSync('''
import 'model.dart';

class ZomUser {
  ZomUser(this.level);

  final ZomLevel level;

  String describe() => level.label;
}
''');

  _writePackageConfig(root: root, generatorRoot: generatorRoot);

  final generator = BridgeGenerator(
    workspacePath: root.path,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    packageName: 'zom_analyzegate',
  );
  final result = await generator.generateBridges(
    sourceFiles: [
      p.join(libDir.path, 'model.dart'),
      p.join(libDir.path, 'consumer.dart'),
    ],
    outputPath: p.join(libDir.path, 'zom_analyzegate_bridges.dart'),
    moduleName: 'gate',
  );

  expect(result.errors, isEmpty, reason: 'fixture must generate cleanly');
  return GatePackage(root);
}

/// Writes a `package_config.json` that resolves both `tom_d4rt` and the fixture.
void _writePackageConfig({
  required Directory root,
  required String generatorRoot,
}) {
  final ownConfigFile = File(
    p.join(generatorRoot, '.dart_tool', 'package_config.json'),
  );
  if (!ownConfigFile.existsSync()) {
    fail(
      'Cannot synthesise a package config: the generator package has no '
      'resolved .dart_tool/package_config.json at ${ownConfigFile.path}. '
      'This suite reads it to borrow the resolved location of tom_d4rt, and '
      'expects the process cwd to be the generator package root. Run '
      '`dart pub get` in tom_d4rt_generator.',
    );
  }

  final ownConfig =
      jsonDecode(ownConfigFile.readAsStringSync()) as Map<String, dynamic>;
  final packages = [
    // Entries carry absolute `file://` roots, so they stay valid when copied
    // into a config that lives somewhere else entirely.
    ...(ownConfig['packages'] as List).cast<Map<String, dynamic>>(),
    {
      'name': 'zom_analyzegate',
      'rootUri': root.uri.toString(),
      'packageUri': 'lib/',
      'languageVersion': '3.0',
    },
  ];

  Directory(p.join(root.path, '.dart_tool')).createSync(recursive: true);
  File(
    p.join(root.path, '.dart_tool', 'package_config.json'),
  ).writeAsStringSync(
    const JsonEncoder.withIndent(
      '  ',
    ).convert({'configVersion': 2, 'packages': packages}),
  );
}

void main() {
  late GatePackage gate;
  late String pristineSource;

  setUpAll(() async {
    gate = await buildGatePackage(Directory.current.path);
    pristineSource = gate.readGenerated();
  });

  // Every injection test mutates the one generated file in place. Tests within
  // a file run sequentially, so restoring here is enough to keep them isolated
  // — and it is far cheaper than giving each test its own analysed package.
  tearDown(() => gate.writeGenerated(pristineSource));

  tearDownAll(() {
    try {
      gate.root.deleteSync(recursive: true);
    } catch (_) {}
  });

  group('GEN-121: the generated bridge analyses clean', () {
    test(
      'G-GEN121-01: dart analyze reports no fatal diagnostic for the '
      'generated output [2026-08-03] (PASS)',
      () async {
        final fatal = fatalDiagnostics(await analyzeDirectory(gate.root.path));
        expect(
          fatal,
          isEmpty,
          reason:
              'The generated file must analyse clean when it is analysed '
              'directly, with no analysis_options.yaml able to exclude it. '
              'Offenders:\n${fatal.join('\n')}',
        );
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );

    test(
      'G-GEN121-02: the fixture exercises the emission paths that have '
      'shipped defects [2026-08-03] (PASS)',
      () {
        // Anti-vacuity guard. G-GEN121-01 passes just as happily over a file
        // that emitted nothing at all, so pin the payload it is meant to be
        // covering.
        expect(
          pristineSource,
          contains('extensionSourceUris'),
          reason: 'the GEN-120 defect lived in this map',
        );
        expect(
          pristineSource,
          contains("'ZomLevelExtension'"),
          reason: 'the part-declared extension must reach the output',
        );
        expect(
          pristineSource,
          contains('package:zom_analyzegate/model.dart'),
          reason:
              'cross-file package imports are the GEN-119 emission path; '
              'without one, G-GEN121-03 would prove nothing',
        );
        expect(
          pristineSource,
          contains("name: 'Counter'"),
          reason: 'a class bridge must be emitted',
        );
        expect(
          pristineSource,
          contains("'ZomLevel'"),
          reason: 'an enum bridge must be emitted',
        );
      },
    );
  });

  // These two tests are the reason the gate is worth its runtime. They assert
  // the gate DETECTS, by feeding it output that is known-bad. Without them a
  // silently-neutered gate — a package config that stopped resolving, a parse
  // change in the machine format — would keep reporting green forever.
  group('GEN-121: the gate detects the defects it exists to catch', () {
    test(
      'G-GEN121-03: a bare-path import is reported as an error [2026-08-03] '
      '(PASS)',
      () async {
        final broken = pristineSource.replaceFirst(
          RegExp(r"import 'package:zom_analyzegate/model\.dart'( as \$\w+)?;"),
          r"import 'lib/model.dart' as $aux_aux;",
        );
        expect(
          broken,
          isNot(equals(pristineSource)),
          reason:
              'the injection must actually apply — a no-op mutation would '
              'make this test assert nothing',
        );
        gate.writeGenerated(broken);

        final fatal = fatalDiagnostics(await analyzeDirectory(gate.root.path));
        expect(
          fatal.map((d) => d.code),
          contains('URI_DOES_NOT_EXIST'),
          reason:
              'This is the GEN-119 defect exactly: a project-relative path '
              "resolving against the generated file's own directory. The "
              'import-URI property assertions in the GEN-119 suite catch it '
              'too — this pins that the analyze gate independently does.',
        );
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );

    test(
      'G-GEN121-04: a duplicate map key is reported, proving warnings are '
      'fatal by default [2026-08-03] (PASS)',
      () async {
        const anchor = "'ZomLevelExtension':";
        final at = pristineSource.indexOf(anchor);
        expect(
          at,
          isNot(-1),
          reason: 'fixture must emit the extension source URI map',
        );
        final broken =
            '${pristineSource.substring(0, at)}'
            "'ZomLevelExtension': "
            "'package:zom_analyzegate/level_part.dart',\n      "
            '${pristineSource.substring(at)}';
        gate.writeGenerated(broken);

        final all = await analyzeDirectory(gate.root.path);
        final fatal = fatalDiagnostics(all);
        expect(
          fatal.map((d) => d.code),
          contains('EQUAL_KEYS_IN_MAP'),
          reason:
              'This is the GEN-120 defect, and the analyzer classes it as a '
              'WARNING rather than an error. If the gate ever stops failing '
              'on unallowlisted warnings it goes blind to the exact defect '
              'class that motivated it. All diagnostics:\n${all.join('\n')}',
        );
      },
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
