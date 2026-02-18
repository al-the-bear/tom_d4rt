import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;

import 'package:tom_analyzer_model/tom_analyzer_model.dart';

import '../analyzer/analyzer_runner.dart';

/// build_runner builder that emits analysis output for Dart sources.
class AnalyzerBuilder implements Builder {
  final BuilderOptions options;

  AnalyzerBuilder(this.options);

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.analysis.yaml'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final config = TomAnalyzerConfig.fromMap(options.config);
    final barrels = config.barrels;
    final outputFormat = config.outputFormat;

    if (barrels.isNotEmpty && !barrels.contains(buildStep.inputId.path)) {
      return;
    }

    // Convert relative path to absolute path for analyzer
    final workspaceRoot = config.workspaceRoot ?? Directory.current.path;
    final absoluteBarrelPath = p.isAbsolute(buildStep.inputId.path)
        ? buildStep.inputId.path
        : p.join(workspaceRoot, buildStep.inputId.path);

    final analyzer = TomAnalyzer();
    final result = await analyzer.analyzeBarrel(
      barrelPath: absoluteBarrelPath,
      workspaceRoot: workspaceRoot,
      followReExports: config.followReExports,
      followReExportPackages: config.followReExportPackages,
      skipReExports: config.skipReExports,
    );

    final outputId = buildStep.inputId.changeExtension('.analysis.yaml');
    final content = outputFormat == 'json'
        ? JsonSerializer.encode(result)
        : YamlSerializer.encode(result);

    await buildStep.writeAsString(outputId, content);
  }
}

Builder tomAnalyzerBuilder(BuilderOptions options) => AnalyzerBuilder(options);
