/// Traversal tests for the v2 d4rtgen tool.
///
/// Tests tool definition, executor construction, and command execution
/// via the v2 ToolRunner/CommandExecutor framework.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_tool.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_executor.dart';

// =============================================================================
// Test Helpers
// =============================================================================

/// Create a [CommandContext] for testing.
CommandContext createTestContext({
  required String path,
  String executionRoot = '/workspace',
}) {
  return CommandContext(
    fsFolder: FsFolder(path: path),
    natures: [],
    executionRoot: executionRoot,
  );
}

/// Create a temporary project directory with optional buildkit.yaml.
Future<Directory> createTempProject({
  String? d4rtgenConfig,
  String packageName = 'test_project',
}) async {
  final tempDir = await Directory.systemTemp.createTemp('d4rtgen_test_');

  // Create pubspec.yaml
  await File(p.join(tempDir.path, 'pubspec.yaml')).writeAsString('''
name: $packageName
version: 1.0.0
environment:
  sdk: ^3.0.0
''');

  // Create buildkit.yaml if config provided
  if (d4rtgenConfig != null) {
    await File(
      p.join(tempDir.path, 'buildkit.yaml'),
    ).writeAsString(d4rtgenConfig);
  }

  return tempDir;
}

void main() {
  // ===========================================================================
  // D4rtgen Tool Definition
  // ===========================================================================

  group('D4G-TOOL: D4rtgen ToolDefinition', () {
    test('D4G-TOOL-1: has correct name and mode', () {
      expect(d4rtgenTool.name, equals('d4rtgen'));
      expect(d4rtgenTool.mode, equals(ToolMode.singleCommand));
    });

    test('D4G-TOOL-2: has project traversal enabled', () {
      expect(d4rtgenTool.features.projectTraversal, isTrue);
      expect(d4rtgenTool.features.recursiveScan, isTrue);
    });

    test('D4G-TOOL-3: has expected global options', () {
      final optionNames = d4rtgenTool.globalOptions.map((o) => o.name).toList();
      expect(optionNames, contains('show'));
      expect(optionNames, contains('dump-config'));
    });

    test('D4G-TOOL-4: show and dump-config are flags', () {
      final showOpt = d4rtgenTool.globalOptions.firstWhere(
        (o) => o.name == 'show',
      );
      final dumpOpt = d4rtgenTool.globalOptions.firstWhere(
        (o) => o.name == 'dump-config',
      );
      expect(showOpt.type, equals(OptionType.flag));
      expect(dumpOpt.type, equals(OptionType.flag));
    });

    test('D4G-TOOL-5: has version info', () {
      expect(d4rtgenTool.version, isNotNull);
      expect(d4rtgenTool.version, isNotEmpty);
    });
  });

  // ===========================================================================
  // D4rtgen Executor Construction
  // ===========================================================================

  group('D4G-EXE: D4rtgen Executor', () {
    test('D4G-EXE-1: createD4rtgenExecutors returns default executor', () {
      final executors = createD4rtgenExecutors();
      expect(executors, contains('default'));
      expect(executors['default'], isA<D4rtgenExecutor>());
    });

    test('D4G-EXE-2: skips project without buildkit.yaml config', () async {
      final tempDir = await createTempProject(); // No buildkit.yaml
      try {
        final executor = D4rtgenExecutor();
        final context = createTestContext(
          path: tempDir.path,
          executionRoot: tempDir.parent.path,
        );

        final result = await executor.execute(context, const CliArgs());

        // Should succeed silently (skip project)
        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });

    test('D4G-EXE-3: skips project without d4rtgen section', () async {
      final tempDir = await createTempProject(
        d4rtgenConfig: 'other_tool:\n  key: value',
      );
      try {
        final executor = D4rtgenExecutor();
        final context = createTestContext(
          path: tempDir.path,
          executionRoot: tempDir.parent.path,
        );

        final result = await executor.execute(context, const CliArgs());

        // Should succeed silently (skip project)
        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });

    test('D4G-EXE-4: lists project in listOnly mode', () async {
      final tempDir = await createTempProject(
        d4rtgenConfig: '''
d4rtgen:
  name: test_project
  modules:
    - name: core
      barrelFiles:
        - lib/core.dart
      outputPath: lib/src/bridges/core_bridges.b.dart
''',
      );
      try {
        final executor = D4rtgenExecutor();
        final context = createTestContext(
          path: tempDir.path,
          executionRoot: tempDir.parent.path,
        );

        final result = await executor.execute(
          context,
          const CliArgs(listOnly: true),
        );

        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });

    test(
      'D4G-EXE-5: test runner imports use pubspec package name, not d4rtgen name. [2026-02-27] (FAIL)',
      () async {
        final tempDir = await createTempProject(
          packageName: 'actual_pkg_name',
          d4rtgenConfig: '''
d4rtgen:
  name: logical_bridge_name
  generateTestRunner: true
  testRunnerPath: test/bridge_test_runner.b.dart
  modules:
    - name: core
      barrelFiles:
        - lib/core.dart
      outputPath: lib/src/bridges/core_bridges.b.dart
''',
        );
        try {
          await Directory(p.join(tempDir.path, 'lib')).create(recursive: true);
          await File(p.join(tempDir.path, 'lib/core.dart')).writeAsString('''
class CoreType {
  const CoreType();
}
''');

          final executor = D4rtgenExecutor();
          final context = createTestContext(
            path: tempDir.path,
            executionRoot: tempDir.parent.path,
          );

          final result = await executor.execute(context, const CliArgs());
          expect(result.success, isTrue);

          final runnerPath = p.join(
            tempDir.path,
            'test/bridge_test_runner.b.dart',
          );
          final runnerContent = await File(runnerPath).readAsString();

          expect(
            runnerContent,
            contains(
              "import 'package:actual_pkg_name/src/bridges/core_bridges.b.dart' as core_bridges;",
            ),
            reason:
                'Generated test runner must import local bridges using pubspec package name',
          );
        } finally {
          await tempDir.delete(recursive: true);
        }
      },
    );
  });

  // ===========================================================================
  // ToolRunner Integration
  // ===========================================================================

  group('D4G-RUN: D4rtgen ToolRunner integration', () {
    test('D4G-RUN-1: --help exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: d4rtgenTool,
        executors: createD4rtgenExecutors(),
        output: output,
      );

      final result = await runner.run(['--help']);
      expect(result.success, isTrue);
      expect(output.toString(), contains('d4rtgen'));
      expect(output.toString(), contains('--help'));
    });

    test('D4G-RUN-2: --version exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: d4rtgenTool,
        executors: createD4rtgenExecutors(),
        output: output,
      );

      final result = await runner.run(['--version']);
      expect(result.success, isTrue);
    });

    test('D4G-RUN-3: --list scans empty dir without error', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: d4rtgenTool,
        executors: createD4rtgenExecutors(),
        output: output,
      );

      final tempDir = await Directory.systemTemp.createTemp('d4rtgen_list_');
      try {
        final result = await runner.run([
          '--list',
          '--scan',
          tempDir.path,
          '--not-recursive',
        ]);
        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });

    test('D4G-RUN-4: --dump-config flag is accepted', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: d4rtgenTool,
        executors: createD4rtgenExecutors(),
        output: output,
      );

      final tempDir = await Directory.systemTemp.createTemp('d4rtgen_dump_');
      try {
        final result = await runner.run([
          '--dump-config',
          '--scan',
          tempDir.path,
          '--not-recursive',
        ]);
        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });
}
