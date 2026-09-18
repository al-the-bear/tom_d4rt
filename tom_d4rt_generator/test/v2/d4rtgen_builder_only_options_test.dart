// A `d4rtgen:` option that only the build_runner builder reads is accepted and
// ignored everywhere else, which reads as "configured" to anyone looking at the
// file.
//
// `libraryPath` is the case: it is part of `BridgeConfig`, parses from a
// `d4rtgen:` block, and is consulted only by `lib/builder.dart` and
// `PerPackageBridgeOrchestrator` — the builder pipeline. tom_brain_procedure
// set it for months under a comment asserting "the generator always runs the
// per-package orchestrator", which was false for the CLI that package had
// moved to, and nothing said so.
//
// No configuration in this workspace sets it, so these tests are the only
// place the warning is exercised. That is the point: the check exists so the
// next package to set it is told, rather than finding out from output that
// never changed.

@Tags(['generation'])
library;

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_executor.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_tool.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// A resolvable package whose `d4rtgen:` block optionally sets [libraryPath].
void _writePackage(Directory root, {String? libraryPath}) {
  String at(String rel) => p.join(root.path, rel);
  File(at('pubspec.yaml'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      "name: optfix\nenvironment:\n  sdk: '>=3.0.0 <4.0.0'\n",
    );
  File(at('.dart_tool/package_config.json'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      '{"configVersion": 2, "packages": [{"name": "optfix", '
      '"rootUri": "../", "packageUri": "lib/", "languageVersion": "3.0"}]}',
    );
  File(at('lib/optfix.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync("export 'src/thing.dart';\n");
  File(at('lib/src/thing.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync('class Thing {\n  int get n => 1;\n}\n');
  File(at('buildkit.yaml')).writeAsStringSync(
    'd4rtgen:\n'
    '  name: optfix\n'
    '${libraryPath == null ? '' : '  libraryPath: $libraryPath\n'}'
    '  modules:\n'
    '    - name: optfix\n'
    '      barrelFiles:\n'
    '        - lib/optfix.dart\n'
    '      outputPath: lib/src/d4rt_bridges/optfix_bridges.b.dart\n',
  );
}

Directory _fixture(String tag) => Directory(
  p.join(
    Directory.current.path,
    '.dart_tool',
    'test_fixtures',
    '${tag}_${pid}_${DateTime.now().microsecondsSinceEpoch}',
  ),
)..createSync(recursive: true);

void main() {
  late Directory package;

  tearDown(() {
    if (package.existsSync()) package.deleteSync(recursive: true);
  });

  test('D4G-OPT-1: a config setting libraryPath is warned about, naming the '
      'option and what reads it [2026-09-18]', () async {
    package = _fixture('opt_set');
    _writePackage(package, libraryPath: 'lib/src/d4rt_library_bridges');

    final result = await generateBridges(
      configPath: p.join(package.path, 'buildkit.yaml'),
    );

    expect(result.warnings, hasLength(1));
    final warning = result.warnings.single;
    expect(warning, contains('libraryPath'));
    expect(
      warning,
      contains('no effect here'),
      reason: 'the warning must say the option did nothing',
    );
    expect(
      warning,
      contains('PerPackageBridgeOrchestrator'),
      reason: 'and name what does read it, so the reader can act',
    );
    expect(
      result.errors,
      isEmpty,
      reason: 'a builder-only option is a warning, not a failure',
    );
  }, timeout: const Timeout(Duration(minutes: 4)));

  test('D4G-OPT-2: a config that does not set it is not warned about '
      '[2026-09-18]', () async {
    // Anti-vacuity for D4G-OPT-1: a check that warned unconditionally would
    // satisfy it just as well.
    package = _fixture('opt_unset');
    _writePackage(package);

    final result = await generateBridges(
      configPath: p.join(package.path, 'buildkit.yaml'),
    );

    expect(result.warnings, isEmpty);
    expect(
      result.outputFiles,
      isNotEmpty,
      reason: 'a run that generated nothing proves nothing',
    );
  }, timeout: const Timeout(Duration(minutes: 4)));

  test(
    'D4G-OPT-3: the CLI surfaces the same warning [2026-09-18]',
    () async {
      // The CLI delegates to generateBridges, so one check covers both paths.
      // This pins that it still does: if the executor ever orchestrates its own
      // generation again, the warning stops reaching the CLI and this fails.
      package = _fixture('opt_cli');
      _writePackage(package, libraryPath: 'lib/src/d4rt_library_bridges');

      final printed = StringBuffer();
      await runZoned(
        () => ToolRunner(
          tool: d4rtgenTool,
          executors: createD4rtgenExecutors(),
          output: printed,
        ).run(['--scan', package.path, '--not-recursive']),
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) => printed.writeln(line),
        ),
      );

      expect(printed.toString(), contains('libraryPath'));
      expect(printed.toString(), contains('no effect here'));
    },
    timeout: const Timeout(Duration(minutes: 4)),
  );

  test('D4G-OPT-4: the table names what reads each option [2026-09-18]', () {
    expect(builderOnlyOptions, isNotEmpty);
    for (final entry in builderOnlyOptions.entries) {
      expect(
        entry.value.trim(),
        isNotEmpty,
        reason:
            '${entry.key} has no explanation, so its warning cannot say '
            'why the option did nothing',
      );
    }
  });
}
