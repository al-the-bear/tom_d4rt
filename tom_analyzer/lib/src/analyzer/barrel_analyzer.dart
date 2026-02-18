import 'package:tom_analyzer_model/tom_analyzer_model.dart';

import 'analyzer_runner.dart';

/// Resolves barrel files and delegates to [TomAnalyzer].
class BarrelAnalyzer {
  final TomAnalyzer analyzer;

  BarrelAnalyzer({TomAnalyzer? analyzer}) : analyzer = analyzer ?? TomAnalyzer();

  Future<AnalysisResult> analyze({
    required String barrelPath,
    String? workspaceRoot,
  }) {
    // TODO: Follow export directives transitively and merge results.
    return analyzer.analyzeBarrel(barrelPath: barrelPath, workspaceRoot: workspaceRoot);
  }
}
