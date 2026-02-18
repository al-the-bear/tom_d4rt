import 'dart:io';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;

import 'package:tom_analyzer_model/tom_analyzer_model.dart';

import '../analyzer/analyzer_runner.dart';
import '../reflection/reflection_generator.dart';
import '../reflection/reflection_model.dart';

/// build_runner builder that emits reflection index output for Dart sources.
class ReflectionBuilder implements Builder {
  final BuilderOptions options;

  ReflectionBuilder(this.options);

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.r.dart'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final config = TomAnalyzerConfig.fromMap(options.config);
    final barrels = config.barrels;

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

    final model = ReflectionModel.fromAnalysis(result);
    final generator = ReflectionGenerator(
      includeDeprecatedMembers: config.includeDeprecatedMembers,
    );
    final content = generator.generate(model);

    final outputId = buildStep.inputId.changeExtension('.r.dart');
    await buildStep.writeAsString(outputId, content);
  }
}

Builder tomAnalyzerReflectionBuilder(BuilderOptions options) =>
    ReflectionBuilder(options);
