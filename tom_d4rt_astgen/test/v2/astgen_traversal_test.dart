/// Traversal tests for the v2 astgen tool.
///
/// Tests tool definition, executor construction, and command execution
/// via the v2 ToolRunner/CommandExecutor framework.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_astgen/src/v2/astgen_tool.dart';
import 'package:tom_d4rt_astgen/src/v2/astgen_executor.dart';

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
Future<Directory> createTempProject({String? astgenConfig}) async {
  final tempDir = await Directory.systemTemp.createTemp('astgen_test_');

  // Create pubspec.yaml
  await File(p.join(tempDir.path, 'pubspec.yaml')).writeAsString('''
name: test_project
version: 1.0.0
environment:
  sdk: ^3.0.0
''');

  // Create buildkit.yaml if config provided
  if (astgenConfig != null) {
    await File(p.join(tempDir.path, 'buildkit.yaml'))
        .writeAsString(astgenConfig);
  }

  return tempDir;
}

void main() {
  // ===========================================================================
  // Astgen Tool Definition
  // ===========================================================================

  group('AST-TOOL: Astgen ToolDefinition', () {
    test('AST-TOOL-1: has correct name and mode', () {
      expect(astgenTool.name, equals('astgen'));
      expect(astgenTool.mode, equals(ToolMode.singleCommand));
    });

    test('AST-TOOL-2: has project traversal enabled', () {
      expect(astgenTool.features.projectTraversal, isTrue);
      expect(astgenTool.features.recursiveScan, isTrue);
    });

    test('AST-TOOL-3: has dry-run feature enabled', () {
      expect(astgenTool.features.dryRun, isTrue);
    });

    test('AST-TOOL-4: has expected global options', () {
      final optionNames = astgenTool.globalOptions.map((o) => o.name).toList();
      expect(optionNames, contains('show'));
    });

    test('AST-TOOL-5: has version info', () {
      expect(astgenTool.version, isNotNull);
      expect(astgenTool.version, isNotEmpty);
    });
  });

  // ===========================================================================
  // Astgen Executor Construction
  // ===========================================================================

  group('AST-EXE: Astgen Executor', () {
    test('AST-EXE-1: createAstgenExecutors returns default executor', () {
      final executors = createAstgenExecutors();
      expect(executors, contains('default'));
      expect(executors['default'], isA<AstgenExecutor>());
    });

    test('AST-EXE-2: skips project without buildkit.yaml config', () async {
      final tempDir = await createTempProject(); // No buildkit.yaml
      try {
        final executor = AstgenExecutor();
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

    test('AST-EXE-3: skips project without astgen section', () async {
      final tempDir = await createTempProject(
        astgenConfig: 'other_tool:\n  key: value',
      );
      try {
        final executor = AstgenExecutor();
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

    test('AST-EXE-4: lists project in listOnly mode', () async {
      final tempDir = await createTempProject(
        astgenConfig: '''
astgen:
  convert:
    - entrypoints: lib/*.dart
      output: output/
      root: .
''',
      );
      try {
        final executor = AstgenExecutor();
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

  group('AST-RUN: Astgen ToolRunner integration', () {
    test('AST-RUN-1: --help exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: astgenTool,
        executors: createAstgenExecutors(),
        output: output,
      );

      final result = await runner.run(['--help']);
      expect(result.success, isTrue);
      expect(output.toString(), contains('astgen'));
      expect(output.toString(), contains('--help'));
    });

    test('AST-RUN-2: --version exits successfully', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: astgenTool,
        executors: createAstgenExecutors(),
        output: output,
      );

      final result = await runner.run(['--version']);
      expect(result.success, isTrue);
    });

    test('AST-RUN-3: --list scans empty dir without error', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: astgenTool,
        executors: createAstgenExecutors(),
        output: output,
      );

      final tempDir = await Directory.systemTemp.createTemp('astgen_list_');
      try {
        final result = await runner
            .run(['--list', '--scan', tempDir.path, '--not-recursive']);
        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });

    test('AST-RUN-4: --dry-run flag is accepted', () async {
      final output = StringBuffer();
      final runner = ToolRunner(
        tool: astgenTool,
        executors: createAstgenExecutors(),
        output: output,
      );

      final tempDir = await Directory.systemTemp.createTemp('astgen_dry_');
      try {
        final result = await runner
            .run(['--dry-run', '--scan', tempDir.path, '--not-recursive']);
        expect(result.success, isTrue);
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });
}
