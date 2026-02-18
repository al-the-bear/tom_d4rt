part of 'model.dart';

/// Information about a Dart package in the analysis graph.
class PackageInfo extends ContainerElement {
  @override
  final String id;

  @override
  final String name;

  @override
  final String? documentation;

  @override
  final List<AnnotationInfo> annotations;

  @override
  final bool isDeprecated;

  final String? version;
  final String rootPath;
  final List<LibraryInfo> libraries;
  final Map<String, PackageInfo> dependencies;
  final Map<String, PackageInfo> devDependencies;
  final bool isRoot;
  final Map<String, dynamic>? pubspecMetadata;
  late final AnalysisResult analysisResult;
  bool _analysisResultAttached = false;

  PackageInfo({
    required this.id,
    required this.name,
    required this.rootPath,
    AnalysisResult? analysisResult,
    this.documentation,
    this.annotations = const [],
    this.isDeprecated = false,
    this.version,
    this.libraries = const [],
    this.dependencies = const {},
    this.devDependencies = const {},
    this.isRoot = false,
    this.pubspecMetadata,
  }) {
    if (analysisResult != null) {
      this.analysisResult = analysisResult;
      _analysisResultAttached = true;
    }
  }

  void attachAnalysisResult(AnalysisResult result) {
    if (_analysisResultAttached) {
      return;
    }
    analysisResult = result;
    _analysisResultAttached = true;
  }
}
