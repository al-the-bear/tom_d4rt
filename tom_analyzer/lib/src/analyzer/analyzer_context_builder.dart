import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:path/path.dart' as p;

/// Builds analyzer contexts with normalized paths.
class AnalyzerContextBuilder {
  AnalysisContextCollection build({
    required String rootPath,
    List<String>? includedPaths,
    List<String>? excludedPaths,
    ResourceProvider? resourceProvider,
  }) {
    final normalizedRoot = _normalizePath(rootPath);
    final includes = (includedPaths == null || includedPaths.isEmpty)
        ? [normalizedRoot]
        : includedPaths.map(_normalizePath).toList();
    final excludes = (excludedPaths ?? const [])
        .map(_normalizePath)
        .toList(growable: false);

    return AnalysisContextCollection(
      includedPaths: includes,
      excludedPaths: excludes,
      resourceProvider: resourceProvider ?? PhysicalResourceProvider.INSTANCE,
    );
  }

  String _normalizePath(String path) => p.normalize(p.absolute(path));
}
