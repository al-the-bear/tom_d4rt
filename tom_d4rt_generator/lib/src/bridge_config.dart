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
  
  /// Glob patterns for source URIs to exclude.
  ///
  /// These patterns are matched against the source URI of classes, enums,
  /// functions, and variables (e.g., `package:dcli/src/shell/shell.dart`).
  ///
  /// Patterns may also include element selectors after '#', to exclude only
  /// specific symbols from a source file:
  /// - `package:dcli_core/src/functions/backup.dart#backupFile,restoreFile`
  /// - `package:dcli_core/src/util/file.dart#*Temp*`
  ///
  /// Example patterns:
  /// - `package:dcli/src/shell/**` - exclude all files in dcli's shell folder
  /// - `package:*/src/internal/*` - exclude internal folders from any package
  /// - `package:some_pkg/**` - exclude entire package
  final List<String> excludeSourcePatterns;
  
  /// Whether to follow all re-exports from external packages by default.
  /// 
  /// When true (default), the generator will follow `export 'package:...'`
  /// directives and generate bridges for classes in those packages.
  /// Use [skipReExports] to exclude specific packages from being followed.
  /// 
  /// When false, only packages listed in [followReExports] will be followed.
  final bool followAllReExports;
  
  /// List of external packages to skip when following re-exports.
  /// 
  /// Only used when [followAllReExports] is true. Package names in this list
  /// will not be followed even if they appear in export directives.
  /// 
  /// Example: `['some_large_package', 'internal_only']`
  final List<String> skipReExports;
  
  /// List of external packages to follow re-exports from.
  /// 
  /// Only used when [followAllReExports] is false.
  /// When a barrel file re-exports from an external package (e.g.,
  /// `export 'package:tom_basics/tom_basics.dart';`), only packages
  /// in this list will be followed for generating bridges.
  /// 
  /// Example: `['tom_basics', 'tom_crypto']`
  final List<String> followReExports;
  
  /// Optional show clause for the generated import statement.
  /// 
  /// When specified, the generated import in getImportBlock() will include
  /// `show ClassName1, ClassName2, ...` to limit what symbols are visible
  /// to D4rt scripts from this module.
  /// 
  /// Example: `['TomService', 'TomEnvironment']`
  final List<String> importShowClause;
  
  /// Optional hide clause for the generated import statement.
  /// 
  /// When specified, the generated import in getImportBlock() will include
  /// `hide functionName, ClassName, ...` to exclude specific symbols
  /// from being visible to D4rt scripts from this module.
  /// 
  /// This is useful for resolving duplicate global function/variable names
  /// when multiple modules export the same symbol.
  /// 
  /// Example: `['prettyJson', 'mergeMapsOneSided']`
  final List<String> importHideClause;
  
  /// Whether to generate bridges for deprecated elements.
  /// 
  /// When false (default), classes, methods, functions, and variables
  /// marked with @deprecated or @Deprecated() are skipped during generation.
  /// A summary of skipped elements is printed at the end of generation.
  /// 
  /// When true, deprecated elements are included in the generated bridges.
  /// The generated file will include `deprecated_member_use` in ignore_for_file.
  final bool generateDeprecatedElements;

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
    this.excludeSourcePatterns = const [],
    this.followAllReExports = true,
    this.skipReExports = const [],
    this.followReExports = const [],
    this.importShowClause = const [],
    this.importHideClause = const [],
    this.generateDeprecatedElements = false,
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
      excludeSourcePatterns: (json['excludeSourcePatterns'] as List?)?.cast<String>() ?? [],
      followAllReExports: json['followAllReExports'] as bool? ?? true,
      skipReExports: (json['skipReExports'] as List?)?.cast<String>() ?? [],
      followReExports: (json['followReExports'] as List?)?.cast<String>() ?? [],
      importShowClause: (json['importShowClause'] as List?)?.cast<String>() ?? [],
      importHideClause: (json['importHideClause'] as List?)?.cast<String>() ?? [],
      generateDeprecatedElements: json['generateDeprecatedElements'] as bool? ?? false,
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
      if (excludeSourcePatterns.isNotEmpty) 'excludeSourcePatterns': excludeSourcePatterns,
      if (!followAllReExports) 'followAllReExports': followAllReExports,
      if (skipReExports.isNotEmpty) 'skipReExports': skipReExports,
      if (followReExports.isNotEmpty) 'followReExports': followReExports,
      if (importShowClause.isNotEmpty) 'importShowClause': importShowClause,
      if (importHideClause.isNotEmpty) 'importHideClause': importHideClause,
      if (generateDeprecatedElements) 'generateDeprecatedElements': generateDeprecatedElements,
    };
  }
}

/// Configuration for an imported bridge package.
/// 
/// This allows the generated dartscript.dart to import and call registration
/// methods from external bridge packages.
class ImportedBridgeConfig {
  /// The import path for the bridge package (e.g., 'package:tom_d4rt_dcli/dartscript.b.dart').
  final String import;
  
  /// The registration class name (e.g., 'TomD4rtDcliBridge').
  final String className;
  
  const ImportedBridgeConfig({
    required this.import,
    required this.className,
  });
  
  factory ImportedBridgeConfig.fromJson(Map<String, dynamic> json) {
    return ImportedBridgeConfig(
      import: json['import'] as String,
      className: json['class'] as String,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'import': import,
      'class': className,
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
  
  /// Central directory path for per-package bridge files.
  /// 
  /// When specified, the generator will create one file per source package
  /// in this directory (e.g., `lib/src/d4rt_bridges/package_tom_basics_bridges.b.dart`).
  /// The per-barrel bridge files will then delegate to these per-package files,
  /// eliminating duplicate code when the same package is re-exported by multiple barrels.
  final String? libraryPath;
  
  /// Whether to generate a test runner script (d4rtrun.b.dart).
  ///
  /// When true, generates an executable Dart script that can run D4rt scripts
  /// or expressions with all generated bridges pre-registered. Supports
  /// running files, evaluating expressions, and validating bridge registrations.
  final bool generateTestRunner;
  
  /// Output path for the generated test runner script.
  ///
  /// Example: `bin/d4rtrun.b.dart`
  final String? testRunnerPath;
  
  /// List of external bridge packages to import and register.
  /// 
  /// When specified, the generated dartscript.dart will import these packages
  /// and call their register() method before registering the local modules.
  /// This allows inheriting bridges from dependency packages.
  /// 
  /// Example in build.yaml:
  /// ```yaml
  /// importedBridges:
  ///   - import: package:tom_d4rt_dcli/dartscript.b.dart
  ///     class: TomD4rtDcliBridge
  /// ```
  final List<ImportedBridgeConfig> importedBridges;

  const BridgeConfig({
    required this.name,
    required this.modules,
    this.helpersImport,
    this.generateBarrel = true,
    this.barrelPath,
    this.generateDartscript = true,
    this.dartscriptPath,
    this.registrationClass,
    this.libraryPath,
    this.generateTestRunner = false,
    this.testRunnerPath,
    this.importedBridges = const [],
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
      libraryPath: json['libraryPath'] as String?,
      generateTestRunner: json['generateTestRunner'] as bool? ?? false,
      testRunnerPath: json['testRunnerPath'] as String?,
      importedBridges: (json['importedBridges'] as List?)
              ?.map((m) => ImportedBridgeConfig.fromJson(m as Map<String, dynamic>))
              .toList() ??
          const [],
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
      if (libraryPath != null) 'libraryPath': libraryPath,
      'generateTestRunner': generateTestRunner,
      if (testRunnerPath != null) 'testRunnerPath': testRunnerPath,
      if (importedBridges.isNotEmpty)
        'importedBridges': importedBridges.map((b) => b.toJson()).toList(),
    };
  }

  /// Creates a copy of this config with the given fields replaced.
  BridgeConfig copyWith({
    String? name,
    List<ModuleConfig>? modules,
    String? helpersImport,
    bool? generateBarrel,
    String? barrelPath,
    bool? generateDartscript,
    String? dartscriptPath,
    String? registrationClass,
    String? libraryPath,
    bool? generateTestRunner,
    String? testRunnerPath,
    List<ImportedBridgeConfig>? importedBridges,
  }) {
    return BridgeConfig(
      name: name ?? this.name,
      modules: modules ?? this.modules,
      helpersImport: helpersImport ?? this.helpersImport,
      generateBarrel: generateBarrel ?? this.generateBarrel,
      barrelPath: barrelPath ?? this.barrelPath,
      generateDartscript: generateDartscript ?? this.generateDartscript,
      dartscriptPath: dartscriptPath ?? this.dartscriptPath,
      registrationClass: registrationClass ?? this.registrationClass,
      libraryPath: libraryPath ?? this.libraryPath,
      generateTestRunner: generateTestRunner ?? this.generateTestRunner,
      testRunnerPath: testRunnerPath ?? this.testRunnerPath,
      importedBridges: importedBridges ?? this.importedBridges,
    );
  }
}
