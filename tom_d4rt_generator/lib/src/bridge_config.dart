/// D4rt Bridge Configuration
///
/// Represents the configuration for generating D4rt bridges from a JSON file.
library;

import 'dart:convert';
import 'dart:io';

/// Configuration for a single module within a project.
class ModuleConfig {
  /// The name of the module.
  final String name;
  
  /// List of barrel files to process for this module.
  final List<String> barrelFiles;
  
  /// Output path for the generated bridge file.
  final String outputPath;
  
  /// Optional import path for the barrel file.
  final String? barrelImport;
  
  /// Patterns to exclude from processing.
  final List<String> excludePatterns;
  
  /// Specific class names to exclude from processing.
  final List<String> excludeClasses;
  
  /// Specific enum names to exclude from processing.
  final List<String> excludeEnums;
  
  /// Specific global function names to exclude from processing.
  final List<String> excludeFunctions;
  
  /// Specific global variable names to exclude from processing.
  final List<String> excludeVariables;
  
  /// List of external packages to follow re-exports from.
  /// 
  /// When a barrel file re-exports from an external package (e.g.,
  /// `export 'package:tom_basics/tom_basics.dart';`), the generator
  /// normally skips these. Adding package names to this list enables
  /// following re-exports from those packages and generating bridges
  /// for their exported classes.
  /// 
  /// Example: `['tom_basics', 'tom_crypto']`
  final List<String> followReExports;

  const ModuleConfig({
    required this.name,
    required this.barrelFiles,
    required this.outputPath,
    this.barrelImport,
    this.excludePatterns = const [],
    this.excludeClasses = const [],
    this.excludeEnums = const [],
    this.excludeFunctions = const [],
    this.excludeVariables = const [],
    this.followReExports = const [],
  });

  factory ModuleConfig.fromJson(Map<String, dynamic> json) {
    return ModuleConfig(
      name: json['name'] as String,
      barrelFiles: (json['barrelFiles'] as List).cast<String>(),
      outputPath: json['outputPath'] as String,
      barrelImport: json['barrelImport'] as String?,
      excludePatterns: (json['excludePatterns'] as List?)?.cast<String>() ?? [],
      excludeClasses: (json['excludeClasses'] as List?)?.cast<String>() ?? [],
      excludeEnums: (json['excludeEnums'] as List?)?.cast<String>() ?? [],
      excludeFunctions: (json['excludeFunctions'] as List?)?.cast<String>() ?? [],
      excludeVariables: (json['excludeVariables'] as List?)?.cast<String>() ?? [],
      followReExports: (json['followReExports'] as List?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'barrelFiles': barrelFiles,
      'outputPath': outputPath,
      if (barrelImport != null) 'barrelImport': barrelImport,
      if (excludePatterns.isNotEmpty) 'excludePatterns': excludePatterns,
      if (excludeClasses.isNotEmpty) 'excludeClasses': excludeClasses,
      if (excludeEnums.isNotEmpty) 'excludeEnums': excludeEnums,
      if (excludeFunctions.isNotEmpty) 'excludeFunctions': excludeFunctions,
      if (excludeVariables.isNotEmpty) 'excludeVariables': excludeVariables,
      if (followReExports.isNotEmpty) 'followReExports': followReExports,
    };
  }
}

/// Complete bridge configuration for a project.
class BridgeConfig {
  final String name;
  final List<ModuleConfig> modules;
  final String? helpersImport;
  final bool generateBarrel;
  final String? barrelPath;
  final bool generateDartscript;
  final String? dartscriptPath;
  final String? registrationClass;

  const BridgeConfig({
    required this.name,
    required this.modules,
    this.helpersImport,
    this.generateBarrel = true,
    this.barrelPath,
    this.generateDartscript = true,
    this.dartscriptPath,
    this.registrationClass,
  });

  factory BridgeConfig.fromJson(Map<String, dynamic> json) {
    return BridgeConfig(
      name: json['name'] as String,
      modules: (json['modules'] as List)
          .map((m) => ModuleConfig.fromJson(m as Map<String, dynamic>))
          .toList(),
      helpersImport: json['helpersImport'] as String?,
      generateBarrel: json['generateBarrel'] as bool? ?? true,
      barrelPath: json['barrelPath'] as String?,
      generateDartscript: json['generateDartscript'] as bool? ?? true,
      dartscriptPath: json['dartscriptPath'] as String?,
      registrationClass: json['registrationClass'] as String?,
    );
  }

  /// Load configuration from a JSON file.
  static BridgeConfig fromFile(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw FileSystemException('Configuration file not found', filePath);
    }

    final content = file.readAsStringSync();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return BridgeConfig.fromJson(json);
  }

  /// Find all d4rt_bridging.json files in a directory.
  static List<String> findConfigFiles(String directory, {bool recursive = false}) {
    final dir = Directory(directory);
    if (!dir.existsSync()) {
      return [];
    }

    final results = <String>[];
    
    for (final entity in dir.listSync(recursive: recursive, followLinks: false)) {
      if (entity is File && entity.path.endsWith('d4rt_bridging.json')) {
        results.add(entity.path);
      }
    }

    return results;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modules': modules.map((m) => m.toJson()).toList(),
      if (helpersImport != null) 'helpersImport': helpersImport,
      'generateBarrel': generateBarrel,
      if (barrelPath != null) 'barrelPath': barrelPath,
      'generateDartscript': generateDartscript,
      if (dartscriptPath != null) 'dartscriptPath': dartscriptPath,
      if (registrationClass != null) 'registrationClass': registrationClass,
    };
  }
}
