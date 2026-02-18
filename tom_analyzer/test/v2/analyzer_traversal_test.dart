/// Traversal tests for the v2 analyzer and reflector tools.
///
/// Tests tool definitions, executor construction, and command execution
/// via the v2 ToolRunner/CommandExecutor framework.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_analyzer/src/v2/analyzer_tool.dart';
import 'package:tom_analyzer/src/v2/analyzer_executor.dart';
import 'package:tom_analyzer/src/v2/reflector_tool.dart';
import 'package:tom_analyzer/src/v2/reflector_executor.dart';

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
  String? analyzerConfig,
  String? reflectorConfig,
}) async {
  final tempDir = await Directory.systemTemp.createTemp('traversal_test_');
  
  // Create pubspec.yaml
  await File(p.join(tempDir.path, 'pubspec.yaml')).writeAsString('''
name: test_project
version: 1.0.0
environment:
  sdk: ^3.0.0
''');
  
  // Create buildkit.yaml if config provided
  if (analyzerConfig != null || reflectorConfig != null) {
    final sections = <String>[];
    if (analyzerConfig != null) sections.add(analyzerConfig);
    if (reflectorConfig != null) sections.add(reflectorConfig);
    await File(p.join(tempDir.path, 'buildkit.yaml'))
        .writeAsString(sections.join('\n'));
  }
  
  return tempDir;
}

void main() {
  // ===========================================================================
  // Analyzer Tool Definition
  // ===========================================================================

  group('ANZ-TOOL: Analyzer ToolDefinition', () {
    test('ANZ-TOOL-1: has correct name and mode', () {
      expect(analyzerTool.name, equals('tom_analyzer'));
      expect(analyzerTool.mode, equals(ToolMode.singleCommand));
    });

    test('ANZ-TOOL-2: has project traversal enabled', () {
      expect(analyzerTool.features.projectTraversal, isTrue);
      expect(analyzerTool.features.recursiveScan, isTrue);
    });

    test('ANZ-TOOL-3: has expected global options', () {
      final optionNames =
          analyzerTool.globalOptions.map((o) => o.name).toList();
      expect(optionNames, contains('barrel'));
      expect(optionNames, contains('output'));
      expect(optionNames, contains('format'));
    });

    test('ANZ-TOOL-4: has version info', () {
      expect(analyzerTool.version, isNotNull);
      expect(analyzerTool.version, isNotEmpty);
    });
  });

  // ===========================================================================
  // Reflector Tool Definition
  // ===========================================================================

  group('REF-TOOL: Reflector ToolDefinition', () {
    test('REF-TOOL-1: has correct name and mode', () {
      expect(reflectorTool.name, equals('tom_reflector'));
      expect(reflectorTool.mode, equals(ToolMode.singleCommand));
    });

    test('REF-TOOL-2: has project traversal enabled', () {
      expect(reflectorTool.features.projectTraversal, isTrue);
      expect(reflectorTool.features.recursiveScan, isTrue);
    });

    test('REF-TOOL-3: has expected global options', () {
      final optionNames =
          reflectorTool.globalOptions.map((o) => o.name).toList();
      expect(optionNames, contains('entry'));
      expect(optionNames, contains('barrel'));
      expect(optionNames, contains('output'));
    });

    test('REF-TOOL-4: entry option is multi-valued', () {
      final entryOpt =
          reflectorTool.globalOptions.firstWhere((o) => o.name == 'entry');
      expect(entryOpt.type, equals(OptionType.multiOption));
    });
  });

  // ===========================================================================
  // Analyzer Executor Construction
  // ===========================================================================

  group('ANZ-EXE: Analyzer Executor', () {
    test('ANZ-EXE-1: createAnalyzerExecutors returns default executor', () {
      final executors = createAnalyzerExecutors();
      expect(executors, contains('default'));
      expect(executors['default'], isA<AnalyzerExecutor>());
    });

    test('ANZ-EXE-2: skips project without buildkit.yaml config', () async {
      final tempDir = await createTempProject(); // No buildkit.yaml
      try {
        final executor = AnalyzerExecutor();
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

    test('ANZ-EXE-3: skips project without analyzer section', () async {
      final tempDir = await createTempProject(
        analyzerConfig: 'other_tool:\n  key: value',
      );
      try {
        final executor = AnalyzerExecutor();
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

    test('ANZ-EXE-4: lists project in listOnly mode', () async {
      final tempDir = await createTempProject(
        analyzerConfig: 'analyzer:\n  barrel: lib/barrel.dart',
      );
      try {
        final executor = AnalyzerExecutor();
        final context = createTestContext(
          path: tempDir.path,
          executionRoot: tempDir.parent.path,
        );

        final result =
            await executor.execute(context, const CliArgs(listOnly: true));

        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });

  // ===========================================================================
  // Reflector Executor Construction
  // ===========================================================================

  group('REF-EXE: Reflector Executor', () {
    test('REF-EXE-1: createReflectorExecutors returns default executor', () {
      final executors = createReflectorExecutors();
      expect(executors, contains('default'));
      expect(executors['default'], isA<ReflectorExecutor>());
    });

    test('REF-EXE-2: skips project without buildkit.yaml config', () async {
      final tempDir = await createTempProject(); // No buildkit.yaml
      try {
        final executor = ReflectorExecutor();
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

    test('REF-EXE-3: skips project without reflector section', () async {
      final tempDir = await createTempProject(
        reflectorConfig: 'other_tool:\n  key: value',
      );
      try {
        final executor = ReflectorExecutor();
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

    test('REF-EXE-4: lists project in listOnly mode', () async {
      final tempDir = await createTempProject(
        reflectorConfig: 'reflector:\n  entry:\n    - lib/src/entry.dart',
      );
      try {
        final executor = ReflectorExecutor();
        final context = createTestContext(
          path: tempDir.path,
          executionRoot: tempDir.parent.path,
        );

        final result =
            await executor.execute(context, const CliArgs(listOnly: true));

        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });

  // ===========================================================================
  // ToolRunner Integration
  // ===========================================================================

  group('ANZ-RUN: Analyzer ToolRunner integration', () {
    test('ANZ-RUN-1: --help exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: analyzerTool,
        executors: createAnalyzerExecutors(),
        output: output,
      );

      final result = await runner.run(['--help']);
      expect(result.success, isTrue);
      expect(output.toString(), contains('tom_analyzer'));
      expect(output.toString(), contains('--help'));
    });

    test('ANZ-RUN-2: --version exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: analyzerTool,
        executors: createAnalyzerExecutors(),
        output: output,
      );

      final result = await runner.run(['--version']);
      expect(result.success, isTrue);
    });

    test('ANZ-RUN-3: --list scans projects', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: analyzerTool,
        executors: createAnalyzerExecutors(),
        output: output,
      );

      // Run in a temp dir with no projects — should succeed with 0 projects
      final tempDir = await Directory.systemTemp.createTemp('analyzer_list_');
      try {
        final result = await runner
            .run(['--list', '--scan', tempDir.path, '--not-recursive']);
        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });

  group('REF-RUN: Reflector ToolRunner integration', () {
    test('REF-RUN-1: --help exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: reflectorTool,
        executors: createReflectorExecutors(),
        output: output,
      );

      final result = await runner.run(['--help']);
      expect(result.success, isTrue);
      expect(output.toString(), contains('tom_reflector'));
      expect(output.toString(), contains('--help'));
    });

    test('REF-RUN-2: --version exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: reflectorTool,
        executors: createReflectorExecutors(),
        output: output,
      );

      final result = await runner.run(['--version']);
      expect(result.success, isTrue);
    });
  });
}
