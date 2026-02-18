/// Tom Analyzer v2 — Command executor.
///
/// Wraps the existing analysis logic to work with the v2 ToolRunner framework.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart' show TomBuildConfig, hasTomBuildConfig;
import 'package:tom_build_base/tom_build_base_v2.dart';

import 'package:tom_analyzer/tom_analyzer.dart';

const _toolKey = 'tom_analyzer';

// =============================================================================
// Analyzer Executor
// =============================================================================

/// Default executor for the tom_analyzer tool (single-command).
class AnalyzerExecutor extends CommandExecutor {
  @override
  Future<ItemResult> execute(CommandContext context, CliArgs args) async {
    // Skip projects without tom_analyzer config
    if (!hasTomBuildConfig(context.path, _toolKey)) {
      return ItemResult.success(path: context.path, name: context.name);
    }

    // Handle --list mode
    if (args.listOnly) {
      final relativePath = p.relative(context.path, from: context.executionRoot);
      print('  $relativePath');
      return ItemResult.success(path: context.path, name: context.name);
    }

    final barrelOverride = args.extraOptions['barrel'] as String?;
    final outputPath = args.extraOptions['output'] as String?;
    final outputFormat = args.extraOptions['format'] as String?;

    try {
      final success = await _processProject(
        projectPath: context.path,
        executionRoot: context.executionRoot,
        barrelOverride: barrelOverride,
        outputPath: outputPath,
        outputFormat: outputFormat,
        verbose: args.verbose,
      );

      return success
          ? ItemResult.success(path: context.path, name: context.name)
          : ItemResult.failure(
              path: context.path,
              name: context.name,
              error: 'Analysis failed',
            );
    } catch (e, stack) {
      stderr.writeln('Error processing ${context.path}: $e');
      if (args.verbose) stderr.writeln(stack);
      return ItemResult.failure(
        path: context.path,
        name: context.name,
        error: '$e',
      );
    }
  }
}

/// Process a single project.
Future<bool> _processProject({
  required String projectPath,
  required String executionRoot,
  String? barrelOverride,
  String? outputPath,
  String? outputFormat,
  required bool verbose,
}) async {
  // Load config from buildkit.yaml tom_analyzer: section
  final buildConfig = TomBuildConfig.load(dir: projectPath, toolKey: _toolKey);
  var config = TomAnalyzerConfig.fromMap(buildConfig?.toolOptions ?? {});

  if (barrelOverride != null) {
    config = config.applyOverrides(barrels: [barrelOverride]);
  }

  final barrel = config.barrels.isNotEmpty ? config.barrels.first : null;
  if (barrel == null) {
    stderr.writeln('[$projectPath] Missing barrel in buildkit.yaml.');
    return false;
  }

  config = config.applyOverrides(
    outputFile: outputPath,
    outputFormat: outputFormat,
    workspaceRoot: config.workspaceRoot ?? projectPath,
  );

  // Resolve barrel path relative to project directory
  final resolvedBarrel = p.isAbsolute(barrel)
      ? barrel
      : p.join(projectPath, barrel);

  final analyzer = TomAnalyzer();
  final analysis = await analyzer.analyzeBarrel(
    barrelPath: resolvedBarrel,
    workspaceRoot: config.workspaceRoot,
    followReExports: config.followReExports,
    followReExportPackages: config.followReExportPackages,
    skipReExports: config.skipReExports,
  );

  final content = config.outputFormat == 'json'
      ? JsonSerializer.encode(analysis)
      : YamlSerializer.encode(analysis);

  if (config.outputFile != null) {
    await File(config.outputFile!).writeAsString(content);
    if (verbose) {
      final displayPath = p.relative(projectPath, from: executionRoot);
      print('  $displayPath -> ${config.outputFile}');
    }
  } else {
    stdout.writeln(content);
  }
  return true;
}

// =============================================================================
// Factory
// =============================================================================

/// Create executor map for the analyzer tool.
Map<String, CommandExecutor> createAnalyzerExecutors() {
  return {
    'default': AnalyzerExecutor(),
  };
}
