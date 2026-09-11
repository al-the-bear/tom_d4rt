// `d4rtgen --dry-run` / `-n`: report what a run would write, write nothing.
//
// The flag used to be parsed (tom_build_base accepts it for every tool) and
// then ignored: `d4rtgen -n` regenerated every `*.b.dart` in place, exactly
// like a normal run. An operator reaching for `-n` to inspect a package whose
// regeneration is deliberately frozen was the person it hurt most.
//
// These tests drive the real CLI path — `ToolRunner` with `d4rtgenTool` and
// its executor, as `bin/d4rtgen.dart` does — over a small package created in
// this package's directory (the scanner refuses scan roots outside the
// workspace), and assert on the tree itself: its snapshot before and after.

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_executor.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_tool.dart';

/// Writes a resolvable package `dryfix` under [root] whose d4rtgen config
/// produces a module bridge, its relaxers, a barrel and a test runner.
///
/// Not `zom_`-prefixed, although it is a test project: the workspace's
/// traversal filters drop `zom_*` projects, so the scan would find nothing and
/// every assertion below would hold vacuously.
void _writePackage(Directory root) {
  String at(String rel) => p.join(root.path, rel);
  File(at('pubspec.yaml'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      "name: dryfix\nenvironment:\n  sdk: '>=3.0.0 <4.0.0'\n",
    );
  File(at('.dart_tool/package_config.json'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      '{"configVersion": 2, "packages": [{"name": "dryfix", '
      '"rootUri": "../", "packageUri": "lib/", "languageVersion": "3.0"}]}',
    );
  File(at('lib/dryfix.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync("export 'src/greeter.dart';\n");
  File(at('lib/src/greeter.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      'class Greeter {\n'
      '  Greeter(this.name);\n'
      '  final String name;\n'
      "  String greet() => 'Hello, \$name';\n"
      '}\n',
    );
  File(at('buildkit.yaml')).writeAsStringSync(
    'd4rtgen:\n'
    '  name: dryfix\n'
    '  modules:\n'
    '    - name: dryfix\n'
    '      barrelFiles:\n'
    '        - lib/dryfix.dart\n'
    '      outputPath: lib/src/d4rt_bridges/dryfix_bridges.b.dart\n'
    '  generateBarrel: true\n'
    '  barrelPath: lib/d4rt_bridges.b.dart\n'
    '  generateTestRunner: true\n'
    '  testRunnerPath: bin/d4rtrun.b.dart\n',
  );
}

/// Every file and directory under [root] outside `.dart_tool/`, with file
/// contents — so any write, new file or new directory changes it. Relative
/// paths keep the filter from matching the fixture's own location.
String _snapshot(Directory root) {
  final entries =
      root
          .listSync(recursive: true)
          .where(
            (e) => !p
                .split(p.relative(e.path, from: root.path))
                .contains('.dart_tool'),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  return entries
      .map(
        (e) => e is File
            ? 'F ${p.relative(e.path, from: root.path)}\n${e.readAsStringSync()}'
            : 'D ${p.relative(e.path, from: root.path)}',
      )
      .join('\n');
}

List<String> _generatedFiles(Directory root) =>
    root
        .listSync(recursive: true)
        .whereType<File>()
        .map((f) => p.relative(f.path, from: root.path))
        .where((rel) => rel.endsWith('.b.dart'))
        .where((rel) => !p.split(rel).contains('.dart_tool'))
        .toList()
      ..sort();

/// Runs d4rtgen over [scanRoot] with [flags], returning the run's success and
/// everything it printed.
Future<({bool success, String printed})> _d4rtgen(
  Directory scanRoot,
  List<String> flags,
) async {
  final printed = StringBuffer();
  final result = await runZoned(
    () => ToolRunner(
      tool: d4rtgenTool,
      executors: createD4rtgenExecutors(),
      output: printed,
    ).run([...flags, '--scan', scanRoot.path]),
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => printed.writeln(line),
    ),
  );
  return (success: result.success, printed: printed.toString());
}

void main() {
  late Directory scanRoot;
  late Directory package;

  setUp(() {
    scanRoot = Directory.current.createTempSync('d4rtgen_dry_');
    package = Directory(p.join(scanRoot.path, 'dryfix'));
    _writePackage(package);
  });

  tearDown(() => scanRoot.deleteSync(recursive: true));

  group('D4G-DRY: d4rtgen --dry-run writes nothing', () {
    test('D4G-DRY-1: -n on a package with no bridges creates none, and lists '
        'every file it would create [2026-09-11] (PASS)', () async {
      final before = _snapshot(package);

      final run = await _d4rtgen(scanRoot, ['-n']);

      expect(run.success, isTrue, reason: run.printed);
      expect(_generatedFiles(package), isEmpty, reason: 'dry run wrote files');
      expect(_snapshot(package), before, reason: 'dry run changed the tree');
      for (final path in [
        'lib/src/d4rt_bridges/dryfix_bridges.b.dart',
        'lib/src/d4rt_bridges/relaxers.b.dart',
        'lib/d4rt_bridges.b.dart',
        'bin/d4rtrun.b.dart',
      ]) {
        expect(run.printed, contains(path));
      }
      expect(run.printed, contains('would create'));
      expect(run.printed, contains('nothing was written'));
    }, timeout: const Timeout(Duration(minutes: 5)));

    test('D4G-DRY-2: --dry-run on a generated package leaves the committed '
        'bridges untouched and says which would change [2026-09-11] (PASS)',
        () async {
      final real = await _d4rtgen(scanRoot, const []);
      expect(real.success, isTrue, reason: real.printed);
      expect(_generatedFiles(package), hasLength(4));

      // A source change the committed bridges were not regenerated for.
      File(p.join(package.path, 'lib/src/greeter.dart')).writeAsStringSync(
        'class Greeter {\n'
        '  Greeter(this.name);\n'
        '  final String name;\n'
        "  String greet() => 'Hello, \$name';\n"
        "  String wave() => 'o/';\n"
        '}\n',
      );
      final before = _snapshot(package);

      final run = await _d4rtgen(scanRoot, ['--dry-run']);

      expect(run.success, isTrue, reason: run.printed);
      expect(_snapshot(package), before, reason: 'dry run changed the tree');
      expect(
        run.printed,
        matches(
          RegExp(r'would change\s+lib/src/d4rt_bridges/dryfix_bridges\.b\.dart'),
        ),
      );
      expect(
        run.printed,
        matches(RegExp(r'unchanged\s+lib/d4rt_bridges\.b\.dart')),
      );
    }, timeout: const Timeout(Duration(minutes: 5)));

    test('D4G-DRY-3: d4rtgen advertises --dry-run [2026-09-11] (PASS)',
        () async {
      expect(d4rtgenTool.features.dryRun, isTrue);
      final help = StringBuffer();
      await ToolRunner(
        tool: d4rtgenTool,
        executors: createD4rtgenExecutors(),
        output: help,
      ).run(['--help']);
      expect(help.toString(), contains('--dry-run'));
    });
  });
}
