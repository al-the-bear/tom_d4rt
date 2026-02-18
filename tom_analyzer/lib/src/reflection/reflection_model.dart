import 'package:tom_analyzer_model/tom_analyzer_model.dart';

/// Bridge model between static analysis and reflection output.
class ReflectionModel {
  final AnalysisResult analysisResult;
  final String rootPackage;
  final List<String> libraries;
  final List<String> classes;
  final List<String> enums;
  final List<String> mixins;
  final List<String> extensions;
  final List<String> extensionTypes;
  final List<String> typeAliases;
  final List<String> functions;

  ReflectionModel(
    this.analysisResult, {
    required this.rootPackage,
    required this.libraries,
    required this.classes,
    required this.enums,
    required this.mixins,
    required this.extensions,
    required this.extensionTypes,
    required this.typeAliases,
    required this.functions,
  });

  factory ReflectionModel.fromAnalysis(AnalysisResult analysisResult) {
    final libraries = analysisResult.libraries.values
        .map((lib) => lib.uri.toString())
        .toList()
      ..sort();

    List<String> collect<T>(Iterable<T> items, String Function(T) selector) {
      final values = items.map(selector).toList()..sort();
      return values;
    }

    return ReflectionModel(
      analysisResult,
      rootPackage: analysisResult.rootPackage.name,
      libraries: libraries,
      classes: collect(analysisResult.allClasses, (c) => c.qualifiedName),
      enums: collect(analysisResult.allEnums, (e) => e.qualifiedName),
      mixins: collect(analysisResult.allMixins, (m) => m.qualifiedName),
      extensions: collect(analysisResult.allExtensions, (e) => e.qualifiedName),
      extensionTypes:
          collect(analysisResult.allExtensionTypes, (e) => e.qualifiedName),
      typeAliases: collect(analysisResult.allTypeAliases, (t) => t.qualifiedName),
      functions: collect(analysisResult.allFunctions, (f) => f.qualifiedName),
    );
  }
}
