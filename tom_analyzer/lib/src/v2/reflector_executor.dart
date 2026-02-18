/// Tom Reflector v2 — Command executor.
///
/// Wraps the existing reflection generation logic to work with the v2
/// ToolRunner framework.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart' show TomBuildConfig, hasTomBuildConfig;
import 'package:tom_build_base/tom_build_base_v2.dart';

import 'package:tom_analyzer/tom_analyzer.dart';
import 'package:tom_analyzer/src/reflection/generator/generator.dart' as gen;

const _toolKey = 'tom_reflector';

// =============================================================================
// Reflector Executor
// =============================================================================

/// Default executor for the tom_reflector tool (single-command).
class ReflectorExecutor extends CommandExecutor {
  @override
  Future<ItemResult> execute(CommandContext context, CliArgs args) async {
    // Skip projects without tom_reflector config
    if (!hasTomBuildConfig(context.path, _toolKey)) {
      return ItemResult.success(path: context.path, name: context.name);
    }

    // Handle --list mode
    if (args.listOnly) {
      final relativePath = p.relative(context.path, from: context.executionRoot);
      print('  $relativePath');
      return ItemResult.success(path: context.path, name: context.name);
    }

    final entryPoints = args.extraOptions['entry'] as List<String>? ?? const [];
    final barrelOverride = args.extraOptions['barrel'] as String?;
    final outputPath = args.extraOptions['output'] as String?;

    try {
      final success = await _processProject(
        projectPath: context.path,
        executionRoot: context.executionRoot,
        entryPoints: entryPoints,
        barrelOverride: barrelOverride,
        outputPath: outputPath,
        verbose: args.verbose,
      );

      return success
          ? ItemResult.success(path: context.path, name: context.name)
          : ItemResult.failure(
              path: context.path,
              name: context.name,
              error: 'Reflection generation failed',
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

// =============================================================================
// Processing Logic
// =============================================================================

/// Process a single project.
Future<bool> _processProject({
  required String projectPath,
  required String executionRoot,
  List<String> entryPoints = const [],
  String? barrelOverride,
  String? outputPath,
  required bool verbose,
}) async {
  // Load config from buildkit.yaml tom_reflector: section
  final buildConfig = TomBuildConfig.load(dir: projectPath, toolKey: _toolKey);
  final toolOptions = buildConfig?.toolOptions ?? {};

  // New config-based mode (entry points)
  if (entryPoints.isNotEmpty) {
    return _runNewReflect(
      projectPath: projectPath,
      entryPoints: entryPoints,
      outputPath: outputPath,
      verbose: verbose,
    );
  }

  // Barrel-based mode (from CLI or config)
  final config = TomAnalyzerConfig.fromMap(toolOptions);
  final barrel = barrelOverride ??
      (config.barrels.isNotEmpty ? config.barrels.first : null);

  if (barrel == null) {
    stderr.writeln('[$projectPath] Missing barrel in buildkit.yaml.');
    return false;
  }

  return _runLegacyReflect(
    projectPath: projectPath,
    barrelPath: p.isAbsolute(barrel) ? barrel : p.join(projectPath, barrel),
    config: config,
    outputPath: outputPath,
    verbose: verbose,
    executionRoot: executionRoot,
  );
}

/// New reflection generation using ReflectionConfig and MultiEntryGenerator.
Future<bool> _runNewReflect({
  required String projectPath,
  required List<String> entryPoints,
  String? outputPath,
  required bool verbose,
}) async {
  final config = gen.ReflectionConfig(
    entryPoints: entryPoints,
    output: outputPath,
    defaults: gen.ReflectionDefaults(),
    filters: const [],
    dependencyConfig: gen.DependencyConfig(),
    coverageConfig: gen.CoverageConfig(),
  );

  final generator = gen.MultiEntryGenerator(config);
  final result = await generator.generate();

  if (!result.isSuccess) {
    stderr.writeln('Reflection generation failed:');
    for (final error in result.errors) {
      stderr.writeln('  $error');
    }
    return false;
  }

  for (final entry in result.generatedFiles.entries) {
    final file = File(entry.key);
    await file.parent.create(recursive: true);
    await file.writeAsString(entry.value);
    if (verbose) print('  Generated: ${entry.key}');
  }
  return true;
}

/// Legacy reflection generation using ReflectionModel.
Future<bool> _runLegacyReflect({
  required String projectPath,
  required String barrelPath,
  required TomAnalyzerConfig config,
  String? outputPath,
  required bool verbose,
  required String executionRoot,
}) async {
  final analyzer = TomAnalyzer();
  final analysis = await analyzer.analyzeBarrel(
    barrelPath: barrelPath,
    workspaceRoot: config.workspaceRoot ?? projectPath,
    followReExports: config.followReExports,
    followReExportPackages: config.followReExportPackages,
    skipReExports: config.skipReExports,
  );

  final model = ReflectionModel.fromAnalysis(analysis);
  final generator = ReflectionGenerator();
  final content = generator.generate(model);

  final resolvedOutput = _resolveReflectionOutput(
    barrelPath: barrelPath,
    outputFile: outputPath,
  );

  await File(resolvedOutput).writeAsString(content);
  final displayPath = p.relative(projectPath, from: executionRoot);
  if (verbose) {
    print('  $displayPath -> $resolvedOutput');
  } else {
    print('Generated: $resolvedOutput');
  }
  return true;
}

String _resolveReflectionOutput({
  required String barrelPath,
  String? outputFile,
}) {
  if (outputFile != null && outputFile.isNotEmpty) {
    return _ensureRdartExtension(outputFile);
  }
  final defaultPath = p.setExtension(barrelPath, '.r.dart');
  return _ensureRdartExtension(defaultPath);
}

String _ensureRdartExtension(String path) {
  return path.endsWith('.r.dart') ? path : '$path.r.dart';
}

// =============================================================================
// Factory
// =============================================================================

/// Create executor map for the reflector tool.
Map<String, CommandExecutor> createReflectorExecutors() {
  return {
    'default': ReflectorExecutor(),
  };
}
