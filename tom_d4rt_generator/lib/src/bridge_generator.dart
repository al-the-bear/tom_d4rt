/// Bridge Generator for D4rt BridgedClass implementations.
///
/// Analyzes Dart source files and generates corresponding
/// BridgedClass registrations for use with D4rt interpreter.
library;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:glob/glob.dart' as glob_pkg;
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as p;

import 'file_writer.dart';
import 'user_bridge_scanner.dart';

// =============================================================================
// BRIDGE GENERATOR
// =============================================================================

/// Result of bridge generation.
class BridgeGeneratorResult {
  /// Number of classes that had bridges generated.
  final int classesGenerated;

  /// Number of global functions bridged.
  final int globalFunctionsGenerated;

  /// Number of global variables bridged.
  final int globalVariablesGenerated;

  /// Output files that were written.
  final List<String> outputFiles;

  /// Errors encountered during generation.
  final List<String> errors;

  /// Warnings (non-fatal issues).
  final List<String> warnings;

  const BridgeGeneratorResult({
    required this.classesGenerated,
    this.globalFunctionsGenerated = 0,
    this.globalVariablesGenerated = 0,
    required this.outputFiles,
    this.errors = const [],
    this.warnings = const [],
  });
}

/// Information about a class member for bridging.
class MemberInfo {
  final String name;
  final String returnType;
  final Set<String> returnTypeImportUris; // All import URIs for the return type
  final Map<String, String>
  returnTypeToUri; // Map type name -> import URI for prefixing
  final bool isGetter;
  final bool isSetter;
  final bool isMethod;
  final bool isStatic;
  final bool isOperator;
  final List<ParameterInfo> parameters;

  const MemberInfo({
    required this.name,
    required this.returnType,
    this.returnTypeImportUris = const {},
    this.returnTypeToUri = const {},
    this.isGetter = false,
    this.isSetter = false,
    this.isMethod = false,
    this.isStatic = false,
    this.isOperator = false,
    this.parameters = const [],
  });
}

/// Warning about external types used in class parameters.
/// These types may need wrapper classes for proper bridge support.
class ExternalTypeWarning {
  /// The class containing the external type.
  final String className;

  /// The parameter or field name with the external type.
  final String memberName;

  /// The external type that needs wrapping.
  final String externalType;

  /// The package the external type comes from.
  final String? packageName;

  /// Whether this type is used in a default value.
  final bool isDefaultValue;

  const ExternalTypeWarning({
    required this.className,
    required this.memberName,
    required this.externalType,
    this.packageName,
    this.isDefaultValue = false,
  });

  @override
  String toString() {
    final defaultNote = isDefaultValue ? ' (in default value)' : '';
    final pkg = packageName != null ? ' from $packageName' : '';
    return '$className.$memberName uses external type $externalType$pkg$defaultNote';
  }
}

/// Information about an export directive from a barrel file.
class ExportInfo {
  /// The absolute path to the exported source file.
  final String sourcePath;

  /// Symbols hidden from the export (from `hide` clause).
  final List<String>? hideClause;

  /// Symbols shown from the export (from `show` clause).
  final List<String>? showClause;

  const ExportInfo({
    required this.sourcePath,
    this.hideClause,
    this.showClause,
  });

  /// Whether a class name is exported (not hidden).
  bool isClassExported(String className) {
    if (showClause != null) {
      return showClause!.contains(className);
    }
    if (hideClause != null) {
      return !hideClause!.contains(className);
    }
    return true;
  }
}

/// Information about a top-level function for bridging.
class GlobalFunctionInfo {
  final String name;
  final String returnType;
  final List<ParameterInfo> parameters;
  final String sourceFile;

  const GlobalFunctionInfo({
    required this.name,
    required this.returnType,
    required this.parameters,
    required this.sourceFile,
  });
}

/// Information about a top-level variable for bridging.
class GlobalVariableInfo {
  final String name;
  final String type;
  final bool isFinal;
  final bool isConst;
  final bool isGetter;
  final String sourceFile;

  const GlobalVariableInfo({
    required this.name,
    required this.type,
    required this.isFinal,
    required this.isConst,
    this.isGetter = false,
    required this.sourceFile,
  });
}

/// Information about an enum for bridging.
class EnumInfo {
  /// The name of the enum.
  final String name;

  /// The names of the enum values.
  final List<String> values;

  /// The source file containing this enum.
  final String sourceFile;

  /// Whether this enum has members (methods, getters, etc.).
  final bool hasMembers;

  const EnumInfo({
    required this.name,
    required this.values,
    required this.sourceFile,
    this.hasMembers = false,
  });
}

/// Information about a function type signature.
/// Used to generate wrappers for function-type parameters.
class FunctionTypeInfo {
  /// Return type of the function (e.g., 'void', 'String', 'Widget')
  final String returnType;

  /// Whether the return type is nullable
  final bool returnTypeNullable;

  /// List of positional parameter types
  final List<String> positionalParamTypes;

  /// Map of named parameter name to type
  final Map<String, String> namedParamTypes;

  /// Whether named parameters are required (name -> isRequired)
  final Map<String, bool> namedParamRequired;

  const FunctionTypeInfo({
    required this.returnType,
    this.returnTypeNullable = false,
    this.positionalParamTypes = const [],
    this.namedParamTypes = const {},
    this.namedParamRequired = const {},
  });

  /// Whether the function returns void
  bool get isVoid => returnType == 'void';

  /// Total number of parameters
  int get paramCount => positionalParamTypes.length + namedParamTypes.length;

  /// Whether this function has any parameters
  bool get hasParams => paramCount > 0;
}

/// Information about a method parameter.
class ParameterInfo {
  final String name;
  final String type;
  final Set<String>
      typeImportUris; // All import URIs for this type (including generic args)
  final Map<String, String>
      typeToUri; // Map type name -> import URI for prefixing
  final bool isRequired;
  final bool isNamed;
  final String? defaultValue;

  /// Whether this type is a function type alias (typedef for a function type).
  /// Function types can't be passed from D4rt scripts, so we use dynamic.
  final bool isFunctionTypeAlias;

  /// Detailed function type info if this parameter is a function type.
  /// Used to generate proper wrappers for InterpretedFunction.
  final FunctionTypeInfo? functionTypeInfo;

  const ParameterInfo({
    required this.name,
    required this.type,
    this.typeImportUris = const {},
    this.typeToUri = const {},
    this.isRequired = true,
    this.isNamed = false,
    this.defaultValue,
    this.isFunctionTypeAlias = false,
    this.functionTypeInfo,
  });

  /// Whether this parameter is a function type that can be wrapped
  bool get isFunctionType => functionTypeInfo != null;
}

/// Information about a constructor.
class ConstructorInfo {
  final String? name; // null for default constructor
  final List<ParameterInfo> parameters;
  final bool isFactory;
  final bool isConst;

  const ConstructorInfo({
    this.name,
    required this.parameters,
    this.isFactory = false,
    this.isConst = false,
  });
}

/// Parsed class information for bridge generation.
class ClassInfo {
  final String name;
  final String? superclass;
  final bool isAbstract;
  final List<ConstructorInfo> constructors;
  final List<MemberInfo> members;
  final String sourceFile;

  /// Maps generic type parameter names to their bounds.
  /// E.g., for `class TomList<E extends TomObject>`, this is `{'E': 'TomObject'}`.
  /// Type parameters without bounds map to `null` (treated as `dynamic`).
  final Map<String, String?> typeParameters;

  const ClassInfo({
    required this.name,
    required this.sourceFile,
    this.superclass,
    this.isAbstract = false,
    this.constructors = const [],
    this.members = const [],
    this.typeParameters = const {},
  });

  /// Gets all getters (instance and static).
  List<MemberInfo> get getters => members.where((m) => m.isGetter).toList();

  /// Gets all setters (instance and static).
  List<MemberInfo> get setters => members.where((m) => m.isSetter).toList();

  /// Gets all methods (instance and static).
  List<MemberInfo> get methods => members.where((m) => m.isMethod).toList();

  /// Gets instance getters.
  List<MemberInfo> get instanceGetters =>
      members.where((m) => m.isGetter && !m.isStatic).toList();

  /// Gets instance setters.
  List<MemberInfo> get instanceSetters =>
      members.where((m) => m.isSetter && !m.isStatic).toList();

  /// Gets instance methods.
  List<MemberInfo> get instanceMethods =>
      members.where((m) => m.isMethod && !m.isStatic).toList();

  /// Gets instance operators.
  List<MemberInfo> get instanceOperators =>
      members.where((m) => m.isOperator && !m.isStatic).toList();

  /// Gets static members.
  List<MemberInfo> get staticMembers =>
      members.where((m) => m.isStatic).toList();

  /// Gets all instance getters including inherited ones from superclasses.
  List<MemberInfo> allInstanceGetters(Map<String, ClassInfo> classLookup) {
    final result = <String, MemberInfo>{};
    _collectInheritedMembers(
      classLookup,
      (cls) => cls.instanceGetters,
      result,
    );
    return result.values.toList();
  }

  /// Gets all instance setters including inherited ones from superclasses.
  List<MemberInfo> allInstanceSetters(Map<String, ClassInfo> classLookup) {
    final result = <String, MemberInfo>{};
    _collectInheritedMembers(
      classLookup,
      (cls) => cls.instanceSetters,
      result,
    );
    return result.values.toList();
  }

  /// Gets all instance methods including inherited ones from superclasses.
  List<MemberInfo> allInstanceMethods(Map<String, ClassInfo> classLookup) {
    final result = <String, MemberInfo>{};
    _collectInheritedMembers(
      classLookup,
      (cls) => cls.instanceMethods,
      result,
    );
    return result.values.toList();
  }

  /// Gets all instance operators including inherited ones from superclasses.
  List<MemberInfo> allInstanceOperators(Map<String, ClassInfo> classLookup) {
    final result = <String, MemberInfo>{};
    _collectInheritedMembers(
      classLookup,
      (cls) => cls.instanceOperators,
      result,
    );
    return result.values.toList();
  }

  /// Collects members from this class and all superclasses.
  /// Child class members override parent class members with same name.
  void _collectInheritedMembers(
    Map<String, ClassInfo> classLookup,
    List<MemberInfo> Function(ClassInfo) memberSelector,
    Map<String, MemberInfo> result,
  ) {
    // First collect from superclass (if any)
    if (superclass != null && classLookup.containsKey(superclass)) {
      classLookup[superclass]!._collectInheritedMembers(
        classLookup,
        memberSelector,
        result,
      );
    }
    // Then add/override with this class's members
    for (final member in memberSelector(this)) {
      result[member.name] = member;
    }
  }
}

/// Information about an external type dependency.
class ExternalTypeDependency {
  /// The type name (e.g., 'TomLogger').
  final String typeName;

  /// The package URI (e.g., 'package:tom_core_kernel/tom_core_kernel.dart').
  final String packageUri;

  /// The class that uses this type.
  final String referencedBy;

  /// How the type is used (parameter, return type, field).
  final String usageContext;

  const ExternalTypeDependency({
    required this.typeName,
    required this.packageUri,
    required this.referencedBy,
    required this.usageContext,
  });

  @override
  String toString() =>
      '$typeName from $packageUri (used by $referencedBy in $usageContext)';

  @override
  bool operator ==(Object other) =>
      other is ExternalTypeDependency &&
      other.typeName == typeName &&
      other.packageUri == packageUri;

  @override
  int get hashCode => Object.hash(typeName, packageUri);
}

/// Generates D4rt BridgedClass implementations from Dart source files.
class BridgeGenerator {
  /// Workspace root path.
  final String workspacePath;

  /// Package name for imports (e.g., 'tom_build').
  final String? packageName;

  /// Import path for helper functions.
  final String helpersImport;

  /// Barrel file import path for source code (e.g., 'src/tom/tom.dart').
  /// If provided, this import is used in the generated file for accessing classes.
  final String? sourceImport;

  /// Whether to generate read-only bridges.
  final bool readOnly;

  /// Whether to skip private members.
  final bool skipPrivate;

  /// Whether to output verbose information.
  final bool verbose;

  /// External types that require wrapper classes (detected during generation).
  final List<ExternalTypeWarning> externalTypeWarnings = [];

  /// Non-wrappable defaults encountered during generation.
  /// Each entry contains context about where the non-wrappable default was found.
  final List<String> _nonWrappableDefaultWarnings = [];

  /// Missing exports encountered during generation.
  /// Tracks types that are used but not exported from the barrel file.
  final List<String> _missingExportWarnings = [];

  /// Set of class/enum names that are exported from the barrel file.
  /// Built during bridge file generation from the export info.
  Set<String> _exportedTypeNames = {};

  /// Cached analysis context collection for resolved analysis.
  AnalysisContextCollection? _analysisContext;

  /// Class lookup map for resolving superclass inheritance.
  /// Built during bridge file generation.
  Map<String, ClassInfo> _classLookup = {};

  /// External type dependencies collected during parsing.
  final Set<ExternalTypeDependency> _externalDependencies = {};

  /// Packages to follow for external type dependencies.
  /// Format: package names without 'package:' prefix (e.g., ['tom_core_kernel', 'tom_core_server'])
  List<String> followPackages = [];

  /// User bridge scanner for detecting UserBridge override classes.
  final UserBridgeScanner _userBridgeScanner = UserBridgeScanner();

  /// Expose user bridge scanner for testing.
  UserBridgeScanner get userBridgeScanner => _userBridgeScanner;

  /// Gets or creates the analysis context collection.
  AnalysisContextCollection _getAnalysisContext() {
    // Ensure workspacePath is absolute for the analyzer
    final absoluteWorkspacePath = p.isAbsolute(workspacePath)
        ? workspacePath
        : p.normalize(p.join(Directory.current.path, workspacePath));
    return _analysisContext ??= AnalysisContextCollection(
      includedPaths: [absoluteWorkspacePath],
    );
  }

  /// Cache for resolved package paths.
  final Map<String, String?> _packagePathCache = {};

  /// Resolves a package name to its root directory path.
  ///
  /// Uses `.dart_tool/package_config.json` for reliable resolution,
  /// falling back to sibling directories and pubspec.yaml path dependencies.
  ///
  /// Returns the package root directory path (without /lib), or null if not found.
  Future<String?> _resolvePackagePath(String packageName) async {
    // Check cache first
    if (_packagePathCache.containsKey(packageName)) {
      return _packagePathCache[packageName];
    }

    String? result;

    // Try to read from .dart_tool/package_config.json (most reliable)
    final packageConfigFile = File('$workspacePath/.dart_tool/package_config.json');
    if (packageConfigFile.existsSync()) {
      try {
        final content = await packageConfigFile.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        final packages = json['packages'] as List<dynamic>?;
        if (packages != null) {
          for (final pkg in packages) {
            if (pkg['name'] == packageName) {
              var rootUri = pkg['rootUri'] as String;
              // rootUri is relative to .dart_tool directory
              if (rootUri.startsWith('../')) {
                rootUri = p.normalize(
                  p.join(workspacePath, '.dart_tool', rootUri),
                );
              } else if (rootUri.startsWith('file://')) {
                rootUri = Uri.parse(rootUri).toFilePath();
              }
              result = rootUri;
              break;
            }
          }
        }
      } catch (e) {
        if (verbose) print('Error reading package_config.json: $e');
      }
    }

    // Fallback: Check sibling directories (common in monorepo)
    if (result == null) {
      final workspaceParent = p.dirname(workspacePath);
      final siblingPackage = Directory('$workspaceParent/$packageName');
      if (siblingPackage.existsSync()) {
        result = siblingPackage.path;
      }
    }

    // Fallback: Check pubspec.yaml path dependencies
    if (result == null) {
      final pubspecFile = File('$workspacePath/pubspec.yaml');
      if (pubspecFile.existsSync()) {
        final content = await pubspecFile.readAsString();
        // Simple regex to find path dependencies
        final pathMatch = RegExp(
          '$packageName:\\s*path:\\s*([^\\n]+)',
          multiLine: true,
        ).firstMatch(content);
        if (pathMatch != null) {
          final pathValue = pathMatch.group(1)!.trim();
          final resolvedPath = p.normalize(p.join(workspacePath, pathValue));
          if (Directory(resolvedPath).existsSync()) {
            result = resolvedPath;
          }
        }
      }
    }

    _packagePathCache[packageName] = result;
    return result;
  }

  /// Checks if a file path matches any of the glob patterns.
  ///
  /// [filePath] - The file path to check
  /// [patterns] - List of glob patterns (e.g., '**/*_bridge.dart', 'src/**')
  ///
  /// Returns true if the file matches any pattern.
  bool _matchesGlobPattern(String filePath, List<String> patterns) {
    for (final pattern in patterns) {
      final glob = glob_pkg.Glob(pattern);
      if (glob.matches(filePath)) {
        return true;
      }
    }
    return false;
  }

  /// Creates a bridge generator.
  BridgeGenerator({
    required this.workspacePath,
    this.packageName,
    this.helpersImport = 'package:tom_d4rt/tom_d4rt.dart',
    this.sourceImport,
    this.readOnly = false,
    this.skipPrivate = true,
    this.verbose = false,
    this.followPackages = const [],
  });

  /// Finds the file containing a specific class.
  Future<String?> findFileForClass(String className) async {
    // Search in lib/ directory
    final libDir = Directory('$workspacePath/lib');
    if (!libDir.existsSync()) return null;

    final dartFiles = libDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    for (final file in dartFiles) {
      final content = await file.readAsString();
      // Quick check before full parse
      if (content.contains('class $className ') ||
          content.contains('class $className{') ||
          content.contains('class $className<')) {
        // Verify with parser
        final classes = await _parseFile(file.path);
        if (classes.any((c) => c.name == className)) {
          return file.path;
        }
      }
    }

    return null;
  }

  /// Finds files matching a glob pattern.
  Future<List<String>> findFilesMatching(String pattern) async {
    final results = <String>[];
    final baseDir = Directory(workspacePath);

    // Simple glob support: *.dart, **/*.dart
    if (pattern.contains('*')) {
      final isRecursive = pattern.contains('**');
      final filePattern = pattern.replaceAll('**/', '').replaceAll('*', '');

      final files = baseDir
          .listSync(recursive: isRecursive)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'));

      for (final file in files) {
        if (filePattern.isEmpty || file.path.contains(filePattern)) {
          results.add(file.path);
        }
      }
    }

    return results;
  }

  /// Parses export barrel files to extract the list of exported source files.
  ///
  /// Scans the given barrel files (e.g., `lib/tom_build.dart`) and extracts
  /// all `export '...'` directives to build a list of source files to bridge.
  /// Recursively follows re-exported barrel files.
  ///
  /// [followReExports] - List of external package names to follow re-exports from.
  /// When a barrel file exports from an external package that's in this list,
  /// the generator will resolve the package path and include those exports.
  ///
  /// Returns a map of source file paths to their export info (hide/show clauses).
  Future<Map<String, ExportInfo>> parseExportFiles(
    List<String> barrelFiles, {
    Set<String>? visited,
    List<String>? followReExports,
  }) async {
    visited ??= <String>{};
    followReExports ??= const [];
    final exports = <String, ExportInfo>{};
    final exportPattern = RegExp(
      r'''export\s+['"]([^'"]+)['"]\s*(hide\s+[^;]+|show\s+[^;]+)?;''',
      multiLine: true,
    );

    for (final barrelPath in barrelFiles) {
      // Normalize path for comparison
      final normalizedPath = p.normalize(barrelPath);
      if (visited.contains(normalizedPath)) continue;
      visited.add(normalizedPath);

      final file = File(normalizedPath);
      if (!file.existsSync()) {
        if (verbose) print('Warning: Barrel file not found: $normalizedPath');
        continue;
      }

      final content = await file.readAsString();

      for (final match in exportPattern.allMatches(content)) {
        final exportPath = match.group(1)!;
        final hideShow = match.group(2)?.trim();

        // Handle package: exports
        String absolutePath;
        if (exportPath.startsWith('package:')) {
          // Extract package name from export path
          final packageMatch = RegExp(r'^package:([^/]+)/(.+)$').firstMatch(exportPath);
          if (packageMatch == null) continue;
          
          final exportPackageName = packageMatch.group(1)!;
          final exportRelativePath = packageMatch.group(2)!;
          
          // Check if this is the current package
          if (packageName != null && exportPackageName == packageName) {
            // Convert package: to relative path for current package
            absolutePath = '$workspacePath/lib/$exportRelativePath';
          } else if (followReExports.contains(exportPackageName)) {
            // Follow re-exports from configured external packages
            final externalPackagePath = await _resolvePackagePath(exportPackageName);
            if (externalPackagePath == null) {
              if (verbose) {
                print('Warning: Could not resolve package path for $exportPackageName');
              }
              continue;
            }
            absolutePath = '$externalPackagePath/lib/$exportRelativePath';
          } else {
            // External package not in followReExports, skip
            continue;
          }
        } else if (exportPath.startsWith('dart:')) {
          continue; // Skip dart: exports
        } else {
          // Relative path
          final barrelDir = p.dirname(normalizedPath);
          absolutePath = p.normalize(p.join(barrelDir, exportPath));
        }

        // Check if this is another barrel file (re-exports other files)
        final exportFile = File(absolutePath);
        if (exportFile.existsSync()) {
          final exportContent = await exportFile.readAsString();
          if (exportPattern.hasMatch(exportContent)) {
            // This file is a barrel - recursively parse it
            final nestedExports = await parseExportFiles([
              absolutePath,
            ], visited: visited, followReExports: followReExports);
            exports.addAll(nestedExports);
          }
          // Always add the file itself to exports (it may contain its own code)
          // even if it's a barrel file that re-exports other files
          exports[absolutePath] = ExportInfo(
            sourcePath: absolutePath,
            hideClause: hideShow?.startsWith('hide') == true
                ? hideShow!
                      .substring(5)
                      .split(',')
                      .map((s) => s.trim())
                      .toList()
                : null,
            showClause: hideShow?.startsWith('show') == true
                ? hideShow!
                      .substring(5)
                      .split(',')
                      .map((s) => s.trim())
                      .toList()
                : null,
          );
        }
      }
    }

    return exports;
  }

  /// Generates bridges from export barrel files.
  ///
  /// This is the preferred method as it automatically discovers which classes
  /// to bridge based on what's exported from the barrel files.
  ///
  /// [barrelFiles] - List of barrel file paths (e.g., `lib/tom_build.dart`)
  /// [outputPath] - Where to write the generated bridge file
  /// [moduleName] - Name for the generated bridge class
  /// [excludePatterns] - File path patterns to exclude (e.g., `_bridge.dart`)
  /// [excludeClasses] - Class names to exclude
  Future<BridgeGeneratorResult> generateBridgesFromExports({
    required List<String> barrelFiles,
    required String outputPath,
    String? moduleName,
    List<String>? excludePatterns,
    List<String>? excludeClasses,
  }) async {
    // Parse export files to get source files and their export info
    final exports = await parseExportFiles(barrelFiles);

    if (exports.isEmpty) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: ['No exports found in barrel files: ${barrelFiles.join(', ')}'],
        warnings: [],
      );
    }

    // Filter out files matching exclude patterns (glob patterns)
    // Always exclude generated bridge files to prevent circular references
    final defaultExcludes = ['**/*_bridges.dart', '**/d4rt_bridges.dart'];
    final allExcludePatterns = [...defaultExcludes, ...?excludePatterns];
    
    var sourceFiles = exports.keys.toList();
    sourceFiles = sourceFiles.where((path) {
      if (_matchesGlobPattern(path, allExcludePatterns)) {
        if (verbose) print('Excluding file by pattern: $path');
        return false;
      }
      return true;
    }).toList();

    // Generate bridges with export info for hide/show filtering
    return generateBridges(
      sourceFiles: sourceFiles,
      outputPath: outputPath,
      moduleName: moduleName,
      excludeClasses: excludeClasses,
      exportInfo: exports,
    );
  }

  /// Generates bridges from export barrel files using a [FileWriter].
  ///
  /// This variant is used by build_runner to write files via BuildStep
  /// instead of direct file system access.
  ///
  /// [barrelFiles] - List of barrel file paths (e.g., `lib/tom_build.dart`)
  /// [outputFileId] - FileId for the output bridge file
  /// [moduleName] - Name for the generated bridge class
  /// [excludePatterns] - File path patterns to exclude (e.g., `_bridge.dart`)
  /// [excludeClasses] - Class names to exclude
  /// [followReExports] - External package names to follow re-exports from
  /// [fileWriter] - The FileWriter to use for output
  Future<BridgeGeneratorResult> generateBridgesFromExportsWithWriter({
    required List<String> barrelFiles,
    required FileId outputFileId,
    String? moduleName,
    List<String>? excludePatterns,
    List<String>? excludeClasses,
    List<String>? followReExports,
    required FileWriter fileWriter,
  }) async {
    // Parse export files to get source files and their export info
    final exports = await parseExportFiles(
      barrelFiles,
      followReExports: followReExports,
    );

    if (exports.isEmpty) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: ['No exports found in barrel files: ${barrelFiles.join(', ')}'],
        warnings: [],
      );
    }

    // Filter out files matching exclude patterns (glob patterns)
    // Always exclude generated bridge files to prevent circular references
    final defaultExcludes = ['**/*_bridges.dart', '**/d4rt_bridges.dart'];
    final allExcludePatterns = [...defaultExcludes, ...?excludePatterns];

    var sourceFiles = exports.keys.toList();
    sourceFiles = sourceFiles.where((path) {
      if (_matchesGlobPattern(path, allExcludePatterns)) {
        if (verbose) print('Excluding file by pattern: $path');
        return false;
      }
      return true;
    }).toList();

    // Generate bridges with export info for hide/show filtering
    return generateBridgesWithWriter(
      sourceFiles: sourceFiles,
      outputFileId: outputFileId,
      moduleName: moduleName,
      excludeClasses: excludeClasses,
      exportInfo: exports,
      fileWriter: fileWriter,
    );
  }

  /// Generates bridges for the specified source files.
  Future<BridgeGeneratorResult> generateBridges({
    required List<String> sourceFiles,
    required String outputPath,
    String? classPattern,
    String? targetClassName,
    String? moduleName,
    List<String>? excludeClasses,
    Map<String, ExportInfo>? exportInfo,
  }) async {
    final allClasses = <ClassInfo>[];
    final errors = <String>[];
    final warnings = <String>[];

    // Parse all source files
    for (final sourcePath in sourceFiles) {
      try {
        final classes = await _parseFile(sourcePath);
        allClasses.addAll(classes);
      } catch (e) {
        errors.add('Failed to parse $sourcePath: $e');
      }
    }

    // Filter classes by pattern if specified
    var filteredClasses = allClasses;

    if (targetClassName != null) {
      filteredClasses = allClasses
          .where((c) => c.name == targetClassName)
          .toList();
    } else if (classPattern != null) {
      filteredClasses = allClasses
          .where((c) => _matchesPattern(c.name, classPattern))
          .toList();
    }

    // Filter by export info (hide/show clauses from barrel files)
    if (exportInfo != null) {
      filteredClasses = filteredClasses.where((c) {
        final info = exportInfo[c.sourceFile];
        if (info != null && !info.isClassExported(c.name)) {
          warnings.add(
            'Skipping hidden class ${c.name} (not exported from barrel)',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out explicitly excluded classes
    if (excludeClasses != null && excludeClasses.isNotEmpty) {
      final excludeSet = excludeClasses.toSet();
      filteredClasses = filteredClasses.where((c) {
        if (excludeSet.contains(c.name)) {
          warnings.add('Skipping excluded class ${c.name}');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out classes that extend D4UserBridge (they are helper classes, not to be bridged)
    filteredClasses = filteredClasses.where((c) {
      if (_userBridgeScanner.shouldExcludeClass(c.name)) {
        if (verbose) {
          print('Skipping D4UserBridge subclass ${c.name}');
        }
        return false;
      }
      return true;
    }).toList();

    // Check for external types and add warnings
    externalTypeWarnings.clear();
    for (final cls in filteredClasses) {
      _checkExternalTypes(cls, warnings);
    }

    // Collect external dependencies if followPackages is configured
    if (followPackages.isNotEmpty) {
      _externalDependencies.clear();
      _collectExternalDependencies(filteredClasses);

      if (_externalDependencies.isNotEmpty && verbose) {
        print('Resolving ${_externalDependencies.length} external type dependencies...');
      }

      // Resolve and add external classes
      final externalClasses = await _resolveExternalDependencies();
      if (externalClasses.isNotEmpty) {
        if (verbose) {
          print('Added ${externalClasses.length} classes from external packages');
        }
        filteredClasses.addAll(externalClasses);
      }
    }

    // Filter out abstract classes without factory constructors
    // Also deduplicate by class name (keep first occurrence)
    final bridgeableClasses = <ClassInfo>[];
    final seenClassNames = <String>{};
    for (final cls in filteredClasses) {
      if (cls.isAbstract && !cls.constructors.any((c) => c.isFactory)) {
        warnings.add(
          'Skipping abstract class ${cls.name} (no factory constructor)',
        );
        continue;
      }
      if (seenClassNames.contains(cls.name)) {
        warnings.add(
          'Skipping duplicate class ${cls.name} from ${cls.sourceFile}',
        );
        continue;
      }
      seenClassNames.add(cls.name);
      bridgeableClasses.add(cls);
    }

    // Build the set of exported type names from bridgeable classes
    // This is used to detect when a type is used but not exported from the barrel
    _exportedTypeNames = bridgeableClasses.map((c) => c.name).toSet();
    // Clear previous warnings since we're starting a new generation
    _missingExportWarnings.clear();

    if (bridgeableClasses.isEmpty) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: errors,
        warnings: warnings..add('No bridgeable classes found'),
      );
    }

    // Generate bridge code
    final outputFiles = <String>[];

    // Determine if output is a file or directory
    final isOutputDir =
        outputPath.endsWith('/') || Directory(outputPath).existsSync();

    if (isOutputDir) {
      // Ensure output directory exists
      final outDir = Directory(outputPath);
      if (!outDir.existsSync()) {
        await outDir.create(recursive: true);
      }

      // Generate one file per source file
      final classesPerFile = <String, List<ClassInfo>>{};
      for (final cls in bridgeableClasses) {
        classesPerFile.putIfAbsent(cls.sourceFile, () => []).add(cls);
      }

      for (final entry in classesPerFile.entries) {
        final sourceFile = entry.key;
        final classes = entry.value;
        final baseName = p.basenameWithoutExtension(sourceFile);
        final outFile =
            '${outputPath.endsWith('/') ? outputPath : '$outputPath/'}${baseName}_bridge.dart';

        // Parse globals from this source file
        final globals = await _parseGlobals([sourceFile]);
        final code = _generateBridgeFile(
          classes,
          sourceFile,
          moduleName,
          globalFunctions: globals.functions,
          globalVariables: globals.variables,
          enums: globals.enums,
        );
        await File(outFile).writeAsString(code);
        outputFiles.add(outFile);
      }
    } else {
      // Ensure parent directory exists
      final parentDir = Directory(p.dirname(outputPath));
      if (!parentDir.existsSync()) {
        await parentDir.create(recursive: true);
      }

      // Parse globals from all source files
      final globals = await _parseGlobals(sourceFiles);

      // Generate single output file
      final code = _generateBridgeFile(
        bridgeableClasses,
        sourceFiles.first,
        moduleName,
        globalFunctions: globals.functions,
        globalVariables: globals.variables,
        enums: globals.enums,
      );
      final outFile = outputPath.endsWith('.dart')
          ? outputPath
          : '$outputPath.dart';
      await File(outFile).writeAsString(code);
      outputFiles.add(outFile);
    }

    return BridgeGeneratorResult(
      classesGenerated: bridgeableClasses.length,
      globalFunctionsGenerated: 0, // TODO: count from globals
      globalVariablesGenerated: 0, // TODO: count from globals
      outputFiles: outputFiles,
      errors: errors,
      warnings: warnings..addAll(_nonWrappableDefaultWarnings)..addAll(_missingExportWarnings),
    );
  }

  /// Generates bridges for the specified source files using a [FileWriter].
  ///
  /// This variant is used by build_runner to write files via BuildStep
  /// instead of direct file system access.
  Future<BridgeGeneratorResult> generateBridgesWithWriter({
    required List<String> sourceFiles,
    required FileId outputFileId,
    String? classPattern,
    String? targetClassName,
    String? moduleName,
    List<String>? excludeClasses,
    Map<String, ExportInfo>? exportInfo,
    required FileWriter fileWriter,
  }) async {
    final allClasses = <ClassInfo>[];
    final errors = <String>[];
    final warnings = <String>[];

    // Parse all source files
    for (final sourcePath in sourceFiles) {
      try {
        final classes = await _parseFile(sourcePath);
        allClasses.addAll(classes);
      } catch (e) {
        errors.add('Failed to parse $sourcePath: $e');
      }
    }

    // Filter classes by pattern if specified
    var filteredClasses = allClasses;

    if (targetClassName != null) {
      filteredClasses =
          allClasses.where((c) => c.name == targetClassName).toList();
    } else if (classPattern != null) {
      filteredClasses =
          allClasses.where((c) => _matchesPattern(c.name, classPattern)).toList();
    }

    // Filter by export info (hide/show clauses from barrel files)
    if (exportInfo != null) {
      filteredClasses = filteredClasses.where((c) {
        final info = exportInfo[c.sourceFile];
        if (info != null && !info.isClassExported(c.name)) {
          warnings.add(
            'Skipping hidden class ${c.name} (not exported from barrel)',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out explicitly excluded classes
    if (excludeClasses != null && excludeClasses.isNotEmpty) {
      final excludeSet = excludeClasses.toSet();
      filteredClasses = filteredClasses.where((c) {
        if (excludeSet.contains(c.name)) {
          warnings.add('Skipping excluded class ${c.name}');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out classes that extend D4UserBridge (they are helper classes, not to be bridged)
    filteredClasses = filteredClasses.where((c) {
      if (_userBridgeScanner.shouldExcludeClass(c.name)) {
        if (verbose) {
          print('Skipping D4UserBridge subclass ${c.name}');
        }
        return false;
      }
      return true;
    }).toList();

    // Check for external types and add warnings
    externalTypeWarnings.clear();
    for (final cls in filteredClasses) {
      _checkExternalTypes(cls, warnings);
    }

    // Collect external dependencies if followPackages is configured
    if (followPackages.isNotEmpty) {
      _externalDependencies.clear();
      _collectExternalDependencies(filteredClasses);

      if (_externalDependencies.isNotEmpty && verbose) {
        print(
            'Resolving ${_externalDependencies.length} external type dependencies...');
      }

      // Resolve and add external classes
      final externalClasses = await _resolveExternalDependencies();
      if (externalClasses.isNotEmpty) {
        if (verbose) {
          print('Added ${externalClasses.length} classes from external packages');
        }
        filteredClasses.addAll(externalClasses);
      }
    }

    // Filter out abstract classes without factory constructors
    // Also deduplicate by class name (keep first occurrence)
    final bridgeableClasses = <ClassInfo>[];
    final seenClassNames = <String>{};
    for (final cls in filteredClasses) {
      if (cls.isAbstract && !cls.constructors.any((c) => c.isFactory)) {
        warnings.add(
          'Skipping abstract class ${cls.name} (no factory constructor)',
        );
        continue;
      }
      if (seenClassNames.contains(cls.name)) {
        warnings.add(
          'Skipping duplicate class ${cls.name} from ${cls.sourceFile}',
        );
        continue;
      }
      seenClassNames.add(cls.name);
      bridgeableClasses.add(cls);
    }

    // Build the set of exported type names from bridgeable classes
    // This is used to detect when a type is used but not exported from the barrel
    _exportedTypeNames = bridgeableClasses.map((c) => c.name).toSet();
    // Clear previous warnings since we're starting a new generation
    _missingExportWarnings.clear();

    if (bridgeableClasses.isEmpty) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: errors,
        warnings: warnings..add('No bridgeable classes found'),
      );
    }

    // Generate bridge code
    final outputFiles = <String>[];

    // Parse globals from all source files
    final globals = await _parseGlobals(sourceFiles);

    // Generate single output file content
    final code = _generateBridgeFile(
      bridgeableClasses,
      sourceFiles.first,
      moduleName,
      globalFunctions: globals.functions,
      globalVariables: globals.variables,
      enums: globals.enums,
    );

    // Write using the FileWriter
    await fileWriter.writeFile(outputFileId, code);
    outputFiles.add(fileWriter.absolutePath(outputFileId));

    return BridgeGeneratorResult(
      classesGenerated: bridgeableClasses.length,
      globalFunctionsGenerated: globals.functions.length,
      globalVariablesGenerated: globals.variables.length,
      outputFiles: outputFiles,
      errors: errors,
      warnings: warnings..addAll(_nonWrappableDefaultWarnings)..addAll(_missingExportWarnings),
    );
  }

  /// Known external packages that require wrapper classes when used in defaults.
  static const _complexExternalPackages = {
    'package:pdf/',
    'package:printing/',
    'package:flutter/',
    'package:http/',
    'package:htmltopdfwidgets/',
  };

  /// Checks a class for external types in constructor parameters.
  /// Adds warnings for types that may need wrapper classes.
  void _checkExternalTypes(ClassInfo cls, List<String> warnings) {
    for (final ctor in cls.constructors) {
      for (final param in ctor.parameters) {
        // Check if any type imports are from complex external packages
        for (final uri in param.typeImportUris) {
          for (final pkg in _complexExternalPackages) {
            if (uri.startsWith(pkg)) {
              final warning = ExternalTypeWarning(
                className: cls.name,
                memberName: param.name,
                externalType: param.type,
                packageName: pkg.replaceAll('package:', '').replaceAll('/', ''),
                isDefaultValue: param.defaultValue != null,
              );
              externalTypeWarnings.add(warning);

              // Only add to warnings list if it has a default value (problematic)
              if (param.defaultValue != null) {
                warnings.add(
                  '⚠️  EXTERNAL TYPE: $warning - consider wrapping in a local class',
                );
              }
              break;
            }
          }
        }
      }
    }
  }

  /// Collects external type dependencies from parsed classes.
  ///
  /// Scans all method parameters, return types, and field types to find
  /// types that come from packages in [followPackages].
  void _collectExternalDependencies(List<ClassInfo> classes) {
    for (final cls in classes) {
      // Check constructor parameters
      for (final ctor in cls.constructors) {
        for (final param in ctor.parameters) {
          _collectFromTypeUris(
            param.typeToUri,
            cls.name,
            'constructor parameter ${param.name}',
          );
        }
      }

      // Check members (methods, getters, setters)
      for (final member in cls.members) {
        // Check return type
        _collectFromTypeUris(
          member.returnTypeToUri,
          cls.name,
          '${member.isMethod ? 'method' : member.isGetter ? 'getter' : 'setter'} ${member.name} return type',
        );

        // Check method parameters
        for (final param in member.parameters) {
          _collectFromTypeUris(
            param.typeToUri,
            cls.name,
            'method ${member.name} parameter ${param.name}',
          );
        }
      }
    }
  }

  /// Helper to collect dependencies from type-to-URI mappings.
  void _collectFromTypeUris(
    Map<String, String> typeToUri,
    String className,
    String usageContext,
  ) {
    for (final entry in typeToUri.entries) {
      final typeName = entry.key;
      final uri = entry.value;

      // Skip dart: types - D4rt already bridges all dart:* libraries
      // See tom_d4rt/lib/src/stdlib/ for the full list:
      // - dart:core (String, int, List, Map, Set, Duration, DateTime, Uri, etc.)
      // - dart:async (Future, Stream, Completer, Timer, StreamController, etc.)
      // - dart:collection (HashMap, HashSet, LinkedList, Queue, etc.)
      // - dart:convert (json, utf8, base64, etc.)
      // - dart:io (File, Directory, Platform, Process, Socket, HttpClient, etc.)
      // - dart:math (Random, Point, Rectangle, etc.)
      // - dart:typed_data (Uint8List, ByteData, etc.)
      // - dart:isolate (Isolate, etc.)
      if (uri.startsWith('dart:')) continue;

      // Check if this is from a package we should follow
      for (final pkg in followPackages) {
        if (uri.startsWith('package:$pkg/')) {
          _externalDependencies.add(ExternalTypeDependency(
            typeName: typeName,
            packageUri: uri,
            referencedBy: className,
            usageContext: usageContext,
          ));
          break;
        }
      }
    }
  }

  /// Resolves external dependencies by finding their source files and parsing them.
  ///
  /// Returns a list of classes from external packages that need bridges.
  Future<List<ClassInfo>> _resolveExternalDependencies() async {
    if (_externalDependencies.isEmpty || followPackages.isEmpty) {
      return [];
    }

    final resolvedClasses = <ClassInfo>[];
    final processedTypes = <String>{};

    if (verbose) {
      print('Found ${_externalDependencies.length} external type dependencies to resolve');
    }

    for (final dep in _externalDependencies) {
      // Skip if already processed
      final key = '${dep.typeName}@${dep.packageUri}';
      if (processedTypes.contains(key)) continue;
      processedTypes.add(key);

      // Try to resolve the package path
      final packagePath = _resolvePackageUriToFilePath(dep.packageUri);
      if (packagePath == null) {
        if (verbose) {
          print('  Could not resolve path for ${dep.typeName} from ${dep.packageUri}');
        }
        continue;
      }

      // Parse the file to find the class
      try {
        final classes = await _parseFile(packagePath);
        final targetClass = classes.where((c) => c.name == dep.typeName).firstOrNull;
        if (targetClass != null) {
          // Check if it's already in our class lookup
          if (!_classLookup.containsKey(dep.typeName)) {
            if (verbose) {
              print('  ✓ Resolved ${dep.typeName} from $packagePath');
            }
            resolvedClasses.add(targetClass);
          }
        } else {
          if (verbose) {
            print('  Class ${dep.typeName} not found in $packagePath');
          }
        }
      } catch (e) {
        if (verbose) {
          print('  Error parsing ${dep.packageUri}: $e');
        }
      }
    }

    return resolvedClasses;
  }

  /// Resolves a package: URI to an absolute file path (synchronous version).
  ///
  /// This resolves a full package URI like `package:tom_core_kernel/src/foo.dart`
  /// to an absolute file path. Used for resolving external type dependencies.
  String? _resolvePackageUriToFilePath(String packageUri) {
    // Parse the package URI: package:tom_core_kernel/src/foo.dart
    if (!packageUri.startsWith('package:')) return null;

    final withoutPrefix = packageUri.substring('package:'.length);
    final slashIndex = withoutPrefix.indexOf('/');
    if (slashIndex == -1) return null;

    final packageName = withoutPrefix.substring(0, slashIndex);
    final relativePath = withoutPrefix.substring(slashIndex + 1);

    // Try to find the package in the workspace
    // First check sibling directories (common in monorepo)
    final workspaceParent = p.dirname(workspacePath);
    final siblingPackage = Directory('$workspaceParent/$packageName');
    if (siblingPackage.existsSync()) {
      return p.normalize('${siblingPackage.path}/lib/$relativePath');
    }

    // Check if it's a local path dependency in pubspec.yaml
    final pubspecFile = File('$workspacePath/pubspec.yaml');
    if (pubspecFile.existsSync()) {
      final content = pubspecFile.readAsStringSync();
      // Simple regex to find path dependencies
      final pathMatch = RegExp(
        '$packageName:\\s*path:\\s*([^\\n]+)',
        multiLine: true,
      ).firstMatch(content);
      if (pathMatch != null) {
        final pathValue = pathMatch.group(1)!.trim();
        final resolvedPath = p.normalize(
          p.join(workspacePath, pathValue, 'lib', relativePath),
        );
        if (File(resolvedPath).existsSync()) {
          return resolvedPath;
        }
      }
    }

    return null;
  }

  /// Parses a Dart file and extracts class information with resolved types.
  Future<List<ClassInfo>> _parseFile(String filePath) async {
    // Normalize the file path
    final absolutePath = p.isAbsolute(filePath)
        ? filePath
        : p.join(Directory.current.path, filePath);
    final normalizedPath = p.normalize(absolutePath);

    try {
      // Use resolved analysis to get type information
      final context = _getAnalysisContext().contextFor(normalizedPath);
      final result = await context.currentSession.getResolvedLibrary(
        normalizedPath,
      );

      if (result is ResolvedLibraryResult) {
        // Scan for user bridges in each unit
        for (final unit in result.units) {
          _userBridgeScanner.scanUnit(unit.unit, unit.path);
        }

        // Use the resolved visitor to extract classes with type URIs
        final visitor = _ResolvedClassVisitor(skipPrivate: skipPrivate);
        for (final unit in result.units) {
          visitor.setSourceFile(unit.path);
          unit.unit.visitChildren(visitor);
        }

        return visitor.classes
            .map(
              (c) => ClassInfo(
                name: c.name,
                sourceFile: normalizedPath,
                superclass: c.superclass,
                isAbstract: c.isAbstract,
                constructors: c.constructors,
                members: c.members,
                typeParameters: c.typeParameters,
              ),
            )
            .toList();
      }
    } catch (e) {
      if (verbose) {
        print('Warning: Could not resolve $filePath: $e');
        print('Falling back to syntactic parsing...');
      }
    }

    // Fallback to syntactic parsing (without type resolution)
    final content = await File(filePath).readAsString();
    final parseResult = parseString(
      content: content,
      featureSet: FeatureSet.latestLanguageVersion(),
    );

    // Scan for user bridges in syntactic parsing fallback
    _userBridgeScanner.scanUnit(parseResult.unit, filePath);

    final visitor = _ClassVisitor(skipPrivate: skipPrivate);
    parseResult.unit.visitChildren(visitor);

    return visitor.classes
        .map(
          (c) => ClassInfo(
            name: c.name,
            sourceFile: filePath,
            superclass: c.superclass,
            isAbstract: c.isAbstract,
            constructors: c.constructors,
            members: c.members,
            typeParameters: c.typeParameters,
          ),
        )
        .toList();
  }

  /// Parses global functions, variables, and enums from a list of source files.
  ///
  /// Returns a record with lists of global functions, variables, and enums.
  Future<({
    List<GlobalFunctionInfo> functions,
    List<GlobalVariableInfo> variables,
    List<EnumInfo> enums,
  })> _parseGlobals(List<String> sourceFiles) async {
    final functions = <GlobalFunctionInfo>[];
    final variables = <GlobalVariableInfo>[];
    final enums = <EnumInfo>[];

    for (final filePath in sourceFiles) {
      final absolutePath = p.isAbsolute(filePath)
          ? filePath
          : p.join(Directory.current.path, filePath);
      final normalizedPath = p.normalize(absolutePath);

      try {
        final context = _getAnalysisContext().contextFor(normalizedPath);
        final result = await context.currentSession.getResolvedLibrary(
          normalizedPath,
        );

        if (result is ResolvedLibraryResult) {
          final visitor = _ResolvedClassVisitor(skipPrivate: skipPrivate);
          for (final unit in result.units) {
            visitor.setSourceFile(unit.path);
            unit.unit.visitChildren(visitor);
          }
          functions.addAll(visitor.globalFunctions);
          variables.addAll(visitor.globalVariables);
          enums.addAll(visitor.enums);
        }
      } catch (e) {
        if (verbose) {
          print('Warning: Could not parse globals from $filePath: $e');
        }
      }
    }

    return (functions: functions, variables: variables, enums: enums);
  }

  /// Checks if a class name matches a pattern.
  bool _matchesPattern(String name, String pattern) {
    if (pattern.startsWith('*') && pattern.endsWith('*')) {
      // Contains: *Mode*
      final middle = pattern.substring(1, pattern.length - 1);
      return name.contains(middle);
    } else if (pattern.startsWith('*')) {
      // EndsWith: *Config
      final suffix = pattern.substring(1);
      return name.endsWith(suffix);
    } else if (pattern.endsWith('*')) {
      // StartsWith: Tom*
      final prefix = pattern.substring(0, pattern.length - 1);
      return name.startsWith(prefix);
    } else {
      // Exact match
      return name == pattern;
    }
  }

  /// Generates a sanitized import prefix from an import path.
  ///
  /// Uses a '$' prefix to avoid conflicts with local variables.
  /// Example: 'package:tom_build/src/tom/generation/placeholder_resolver.dart'
  /// becomes '$placeholder_resolver'.
  String _generateImportPrefix(String importPath) {
    // Get the filename without extension
    final filename = p.basenameWithoutExtension(importPath);
    // Convert to valid Dart identifier (replace non-alphanumeric with underscore)
    // Use '$' prefix to avoid conflicts with local variables
    return '\$${filename.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}';
  }

  /// Map of import path to prefix for external imports.
  /// This is populated during bridge file generation.
  Map<String, String> _importPrefixes = {};

  /// Prefixes a default value with its source file's import alias if needed.
  ///
  /// Identifier-like default values (e.g., `defaultVSCodeBridgePort`) need to be
  /// prefixed with the source file's import alias because the bridge file imports
  /// source files with prefixes.
  ///
  /// Returns the original value for:
  /// - Literals: `null`, `true`, `false`, numbers, strings
  /// - Empty collections: `const []`, `const {}`
  ///
  /// For complex defaults that can't be resolved (class static members, private symbols),
  /// returns null to indicate a TODO default should be used.
  String? _prefixDefaultValue(String defaultValue, String? sourceUri) {
    // Skip literals - these are safe
    if (defaultValue == 'null' ||
        defaultValue == 'true' ||
        defaultValue == 'false') {
      return defaultValue;
    }

    // String literals
    if (defaultValue.startsWith("'") || defaultValue.startsWith('"')) {
      return defaultValue;
    }

    // Numeric literals (including negative)
    if (RegExp(r'^-?\d').hasMatch(defaultValue)) {
      return defaultValue;
    }

    // Empty collections
    if (defaultValue == 'const []' ||
        defaultValue == '[]' ||
        defaultValue == 'const {}' ||
        defaultValue == '{}') {
      return defaultValue;
    }

    // Typed empty collections like const <String>[] or const <String, int>{}
    if (RegExp(r'^const\s*<[^>]+>\[\]$').hasMatch(defaultValue) ||
        RegExp(r'^const\s*<[^>]+>\{\}$').hasMatch(defaultValue)) {
      return defaultValue;
    }

    // All other cases are non-wrappable:
    // - Const collections with values
    // - Function calls
    // - Class static members (e.g., guestUsername from TomUser)
    // - Private identifiers
    // - Expressions with operators
    // - Any qualified identifiers (ClassName.member)
    return null;
  }

  /// Checks if a default value is wrappable (can be used directly in bridge code).
  bool _isWrappableDefault(String defaultValue) {
    return _prefixDefaultValue(defaultValue, null) != null;
  }

  /// Records a warning for a non-wrappable default value.
  /// 
  /// [context] describes where the default was found (e.g., "global function foo", "class Bar.method").
  /// [paramName] is the parameter name.
  /// [defaultValue] is the non-wrappable default value.
  void _recordNonWrappableDefault(String context, String paramName, String defaultValue) {
    final warning = 'Non-wrappable default in $context: parameter "$paramName" has default "$defaultValue"';
    _nonWrappableDefaultWarnings.add(warning);
    if (verbose) {
      print('WARNING: $warning');
    }
  }

  /// Records a warning for a type that is used but not exported from the barrel file.
  /// 
  /// [context] describes where the type was used.
  /// [typeName] is the missing type name.
  void _recordMissingExport(String context, String typeName) {
    // Avoid duplicates
    final warning = 'Missing export: Type "$typeName" used in $context is not exported from barrel file';
    if (!_missingExportWarnings.contains(warning)) {
      _missingExportWarnings.add(warning);
      if (verbose) {
        print('WARNING: $warning');
      }
    }
  }

  /// Checks if a type name is exported from the barrel file.
  /// Returns true if:
  /// - The exported type names set is empty (no barrel tracking)
  /// - The type is a primitive/built-in type
  /// - The type is in the exported set
  bool _isTypeExported(String typeName) {
    // If we're not tracking exports, assume all types are available
    if (_exportedTypeNames.isEmpty) {
      return true;
    }

    // Built-in types are always available
    const builtInTypes = {
      'int', 'double', 'num', 'String', 'bool', 'void', 'dynamic', 'Object',
      'List', 'Map', 'Set', 'Iterable', 'Future', 'Stream', 'Function',
      'Type', 'Symbol', 'Null', 'Never', 'Duration', 'DateTime', 'Uri',
      'BigInt', 'Comparable', 'Pattern', 'Match', 'RegExp', 'Runes',
      'StringBuffer', 'Error', 'Exception', 'StackTrace',
    };
    if (builtInTypes.contains(typeName)) {
      return true;
    }

    return _exportedTypeNames.contains(typeName);
  }

  /// Escapes a string for use in generated code.
  /// Escapes single quotes and backslashes.
  String _escapeString(String s) {
    return s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
  }

  /// Generates bridge file content for a list of classes.
  String _generateBridgeFile(
    List<ClassInfo> classes,
    String sourceFile,
    String? overrideModuleName, {
    List<GlobalFunctionInfo> globalFunctions = const [],
    List<GlobalVariableInfo> globalVariables = const [],
    List<EnumInfo> enums = const [],
  }) {
    final buffer = StringBuffer();

    // Build class lookup map for inheritance resolution
    _classLookup = {for (final cls in classes) cls.name: cls};

    // Collect all unique source files from the classes
    final allSourceFiles = classes.map((c) => c.sourceFile).toSet().toList()..sort();

    // Collect external type imports from resolved types
    // Filter out file:// URIs as those are local files covered by the source import
    final externalImports = _collectResolvedTypeImports(classes)
        .where((uri) => !uri.startsWith('file://') && !uri.startsWith('file:///'))
        .toSet();

    // Build import prefix map
    _importPrefixes = {};

    // Use prefixes for ALL external imports to be safe (prevents any future conflicts)
    for (final importPath in externalImports) {
      final prefix = _generateImportPrefix(importPath);
      _importPrefixes[importPath] = prefix;
    }

    // Header - list all source files
    buffer.writeln('// D4rt Bridge - Generated file, do not edit');
    if (allSourceFiles.length == 1) {
      buffer.writeln('// Source: $sourceFile');
    } else {
      buffer.writeln('// Sources: ${allSourceFiles.length} files');
    }
    buffer.writeln('// Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln();

    // Imports
    buffer.writeln("import 'package:tom_d4rt/d4rt.dart';");
    buffer.writeln("import '$helpersImport';");

    // Add external type imports with prefixes
    for (final importPath in externalImports.toList()..sort()) {
      final prefix = _importPrefixes[importPath]!;
      buffer.writeln("import '$importPath' as $prefix;");
    }
    buffer.writeln();

    // Import source files WITH a prefix for global functions
    // This allows us to call global functions as $source.functionName()
    const sourcePrefix = r'$source';
    if (sourceImport != null) {
      // Use explicit barrel file import (preferred)
      final detectedPackageName = packageName ?? _getPackageNameFromPath(sourceFile);
      if (detectedPackageName != null) {
        final sourceImportPath = 'package:$detectedPackageName/$sourceImport';
        buffer.writeln("import '$sourceImportPath' as $sourcePrefix;");
        // Register the prefix for global function resolution
        _importPrefixes[sourceImportPath] = sourcePrefix;
        // Also register each source file path to map to this prefix
        for (final srcFile in allSourceFiles) {
          final srcUri = _getPackageUri(srcFile);
          _importPrefixes[srcUri] = sourcePrefix;
        }
      }
    } else {
      // Import each source file individually with prefix
      for (final srcFile in allSourceFiles) {
        final detectedPackageName = packageName ?? _getPackageNameFromPath(srcFile);
        if (detectedPackageName != null) {
          final srcImportPath = 'package:$detectedPackageName/${_getRelativeImport(srcFile)}';
          buffer.writeln("import '$srcImportPath' as $sourcePrefix;");
          _importPrefixes[srcImportPath] = sourcePrefix;
          _importPrefixes[_getPackageUri(srcFile)] = sourcePrefix;
        } else {
          // Use relative import (fallback)
          buffer.writeln("import '${p.basename(srcFile)}' as $sourcePrefix;");
        }
      }
    }
    buffer.writeln();

    // Generate module bridge class - use override name if provided, otherwise derive from file
    final moduleName =
        overrideModuleName ?? _getModuleName(classes.first.sourceFile);
    // Capitalize module name for class name (e.g., "all" -> "All")
    final capitalizedModuleName = moduleName.isEmpty 
        ? moduleName 
        : '${moduleName[0].toUpperCase()}${moduleName.substring(1)}';
    buffer.writeln('/// Bridge class for $moduleName module.');
    buffer.writeln('class ${capitalizedModuleName}Bridge {');

    // bridgeClasses method
    buffer.writeln('  /// Returns all bridge class definitions.');
    buffer.writeln('  static List<BridgedClass> bridgeClasses() {');
    buffer.writeln('    return [');
    for (final cls in classes) {
      buffer.writeln('      _create${cls.name}Bridge(),');
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // Generate bridgedEnums method if there are enums
    if (enums.isNotEmpty) {
      buffer.writeln('  /// Returns all bridged enum definitions.');
      buffer.writeln('  static List<BridgedEnumDefinition> bridgedEnums() {');
      buffer.writeln('    return [');
      for (final enumInfo in enums) {
        // Get prefixed enum name for proper import reference
        final prefixedEnumName = _getPrefixedClassName(enumInfo.name, enumInfo.sourceFile);
        buffer.writeln('      BridgedEnumDefinition<$prefixedEnumName>(');
        buffer.writeln("        name: '${enumInfo.name}',");
        buffer.writeln('        values: $prefixedEnumName.values,');
        buffer.writeln('      ),');
      }
      buffer.writeln('    ];');
      buffer.writeln('  }');
      buffer.writeln();
    }

    // registerBridges method - accepts import path as parameter
    buffer.writeln('  /// Registers all bridges with an interpreter.');
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// [importPath] is the package import path that D4rt scripts will use',
    );
    buffer.writeln(
      "  /// to access these classes (e.g., 'package:tom_build/tom.dart').",
    );
    buffer.writeln(
      '  static void registerBridges(D4rt interpreter, String importPath) {',
    );
    buffer.writeln('    // Register bridged classes');
    buffer.writeln('    for (final bridge in bridgeClasses()) {');
    buffer.writeln(
      '      interpreter.registerBridgedClass(bridge, importPath);',
    );
    buffer.writeln('    }');
    // Register enums
    if (enums.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('    // Register bridged enums');
      buffer.writeln('    for (final enumDef in bridgedEnums()) {');
      buffer.writeln(
        '      interpreter.registerBridgedEnum(enumDef, importPath);',
      );
      buffer.writeln('    }');
    }
    // Register global variables
    if (globalVariables.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('    // Register global variables');
      buffer.writeln('    registerGlobalVariables(interpreter);');
    }
    // Register global functions
    if (globalFunctions.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('    // Register global functions');
      buffer.writeln('    for (final entry in globalFunctions().entries) {');
      buffer.writeln('      interpreter.registertopLevelFunction(entry.key, entry.value);');
      buffer.writeln('    }');
    }
    buffer.writeln('  }');
    buffer.writeln();

    // Get globals overrides if available
    final globalsUserBridge = _userBridgeScanner.globalsUserBridge;

    // Generate registerGlobalVariables method
    if (globalVariables.isNotEmpty) {
      final regularVariables = globalVariables.where((v) => !v.isGetter).toList();
      final getterVariables = globalVariables.where((v) => v.isGetter).toList();
      
      buffer.writeln('  /// Registers all global variables with the interpreter.');
      buffer.writeln('  static void registerGlobalVariables(D4rt interpreter) {');
      
      // Regular variables - evaluated at registration time
      for (final variable in regularVariables) {
        final override = globalsUserBridge?.getGlobalVariableOverride(variable.name);
        // Get prefixed variable name for proper import reference
        final prefixedVarName = _getPrefixedFunctionName(variable.name, variable.sourceFile);
        if (override != null) {
          buffer.writeln(
            "    interpreter.registerGlobalVariable('${variable.name}', ${globalsUserBridge!.userBridgeClassName}.$override());",
          );
        } else {
          buffer.writeln(
            "    interpreter.registerGlobalVariable('${variable.name}', $prefixedVarName);",
          );
        }
      }
      
      // Getter variables - evaluated lazily at runtime
      for (final variable in getterVariables) {
        final override = globalsUserBridge?.getGlobalGetterOverride(variable.name);
        // Get prefixed getter name for proper import reference
        final prefixedGetterName = _getPrefixedFunctionName(variable.name, variable.sourceFile);
        if (override != null) {
          buffer.writeln(
            "    interpreter.registerGlobalGetter('${variable.name}', ${globalsUserBridge!.userBridgeClassName}.$override());",
          );
        } else {
          buffer.writeln(
            "    interpreter.registerGlobalGetter('${variable.name}', () => $prefixedGetterName);",
          );
        }
      }
      buffer.writeln('  }');
      buffer.writeln();
    }

    // Generate globalFunctions method returning a map of wrappers
    if (globalFunctions.isNotEmpty) {
      buffer.writeln('  /// Returns a map of global function names to their native implementations.');
      buffer.writeln('  static Map<String, NativeFunctionImpl> globalFunctions() {');
      buffer.writeln('    return {');
      for (final func in globalFunctions) {
        // Check for function override
        final override = globalsUserBridge?.getGlobalFunctionOverride(func.name);
        if (override != null) {
          // Use the override method instead of generating
          buffer.writeln("      '${func.name}': ${globalsUserBridge!.userBridgeClassName}.$override,");
          continue;
        }
        
        // Get the prefixed function name
        final prefixedFuncName = _getPrefixedFunctionName(func.name, func.sourceFile);
        
        buffer.writeln("      '${func.name}': (visitor, positional, named, typeArgs) {");
        
        // Count required positional parameters
        final requiredPositionalCount = func.parameters.where((p) => !p.isNamed && p.isRequired).length;
        if (requiredPositionalCount > 0) {
          buffer.writeln("        D4.requireMinArgs(positional, $requiredPositionalCount, '${func.name}');");
        }
        
        // Generate argument extraction with proper D4 helpers
        var positionalIndex = 0;
        final argDeclarations = <String>[];
        final callArgs = <String>[];
        
        for (final param in func.parameters) {
          // Resolve the type using _getTypeArgument to handle generics and external types
          final resolvedType = _getTypeArgument(
            param.type,
            typeToUri: param.typeToUri,
          );
          
          if (param.isNamed) {
            // Named parameter handling
            if (param.isRequired) {
              argDeclarations.add("        final ${param.name} = D4.getRequiredNamedArg<$resolvedType>(named, '${param.name}', '${func.name}');");
            } else if (param.defaultValue != null) {
              // Optional with default - try to use the default value
              final prefixedDefault = _prefixDefaultValue(
                param.defaultValue!,
                _getPackageUri(func.sourceFile),
              );
              if (prefixedDefault != null) {
                argDeclarations.add("        final ${param.name} = D4.getNamedArgWithDefault<$resolvedType>(named, '${param.name}', $prefixedDefault);");
              } else {
                // Non-wrappable default - use TODO helper and record warning
                _recordNonWrappableDefault('global function ${func.name}', param.name, param.defaultValue!);
                argDeclarations.add("        // TODO: Non-wrappable default: ${param.defaultValue}");
                argDeclarations.add("        final ${param.name} = D4.getRequiredNamedArgTodoDefault<$resolvedType>(named, '${param.name}', '${func.name}', '${_escapeString(param.defaultValue!)}');");
              }
            } else {
              // Truly optional with no default - use nullable type
              final nullableType = resolvedType.endsWith('?') ? resolvedType : '$resolvedType?';
              argDeclarations.add("        final ${param.name} = D4.getOptionalNamedArg<$nullableType>(named, '${param.name}');");
            }
            callArgs.add('${param.name}: ${param.name}');
          } else {
            // Positional parameter
            if (param.isRequired) {
              // Required positional - use D4.getRequiredArg
              argDeclarations.add("        final ${param.name} = D4.getRequiredArg<$resolvedType>(positional, $positionalIndex, '${param.name}', '${func.name}');");
              callArgs.add(param.name);
            } else if (param.defaultValue != null) {
              // Optional positional with default
              final prefixedDefault = _prefixDefaultValue(
                param.defaultValue!,
                _getPackageUri(func.sourceFile),
              );
              if (prefixedDefault != null) {
                argDeclarations.add("        final ${param.name} = D4.getOptionalArgWithDefault<$resolvedType>(positional, $positionalIndex, '${param.name}', $prefixedDefault);");
              } else {
                // Non-wrappable default - use TODO helper and record warning
                _recordNonWrappableDefault('global function ${func.name}', param.name, param.defaultValue!);
                argDeclarations.add("        // TODO: Non-wrappable default: ${param.defaultValue}");
                argDeclarations.add("        final ${param.name} = D4.getRequiredArgTodoDefault<$resolvedType>(positional, $positionalIndex, '${param.name}', '${func.name}', '${_escapeString(param.defaultValue!)}');");
              }
              callArgs.add(param.name);
            } else {
              // Optional positional with no default - use nullable type
              final nullableType = resolvedType.endsWith('?') ? resolvedType : '$resolvedType?';
              argDeclarations.add("        final ${param.name} = positional.length > $positionalIndex ? positional[$positionalIndex] as $nullableType : null;");
              callArgs.add(param.name);
            }
            positionalIndex++;
          }
        }
        
        // Write declarations
        for (final decl in argDeclarations) {
          buffer.writeln(decl);
        }
        
        buffer.writeln('        return $prefixedFuncName(${callArgs.join(', ')});');
        buffer.writeln('      },');
      }
      buffer.writeln('    };');
      buffer.writeln('  }');
      buffer.writeln();
    }

    // getImportBlock method - returns import statements for D4rt scripts
    final detectedPackageName = packageName ?? _getPackageNameFromPath(sourceFile);
    if (detectedPackageName != null && sourceImport != null) {
      buffer.writeln('  /// Returns the import statement needed for D4rt scripts.');
      buffer.writeln('  ///');
      buffer.writeln('  /// Use this in your D4rt initialization script to make all');
      buffer.writeln('  /// bridged classes available to scripts.');
      buffer.writeln('  static String getImportBlock() {');
      buffer.writeln("    return \"import 'package:$detectedPackageName/$sourceImport';\";");
      buffer.writeln('  }');
      buffer.writeln();
    }

    // Generate GlobalBridge class if we have globals
    // Note: For now, we only generate the import block and document globals
    // Actual global function/variable bridging requires D4rt-level support
    // Generate lists of enum, function, and variable names if we have any
    if (enums.isNotEmpty || globalFunctions.isNotEmpty || globalVariables.isNotEmpty) {
      // Enum names list
      if (enums.isNotEmpty) {
        buffer.writeln('  /// Returns a list of bridged enum names.');
        buffer.writeln('  static List<String> get enumNames => [');
        for (final enumInfo in enums) {
          buffer.writeln("    '${enumInfo.name}',");
        }
        buffer.writeln('  ];');
        buffer.writeln();
      }

      buffer.writeln('  /// Returns D4rt script code that documents available global functions.');
      buffer.writeln('  ///');
      buffer.writeln('  /// These functions are available directly in D4rt scripts when');
      buffer.writeln('  /// the import block is included in the initialization script.');
      buffer.writeln('  static List<String> get globalFunctionNames => [');
      for (final func in globalFunctions) {
        buffer.writeln("    '${func.name}',");
      }
      buffer.writeln('  ];');
      buffer.writeln();
      buffer.writeln('  /// Returns a list of global variable names.');
      buffer.writeln('  static List<String> get globalVariableNames => [');
      for (final variable in globalVariables) {
        buffer.writeln("    '${variable.name}',");
      }
      buffer.writeln('  ];');
      buffer.writeln();

      // Generate getGlobalInitializationScript method
      buffer.writeln('  /// Returns D4rt script code to initialize global functions and variables.');
      buffer.writeln('  ///');
      buffer.writeln('  /// This script creates wrapper functions that delegate to the static methods');
      buffer.writeln('  /// in GlobalBridge, and mirrors global variables. Include this in your D4rt');
      buffer.writeln('  /// initialization script after registering bridges.');
      buffer.writeln('  ///');
      buffer.writeln('  /// Example:');
      buffer.writeln('  /// ```dart');
      buffer.writeln('  /// interpreter.execute(source: getGlobalInitializationScript());');
      buffer.writeln('  /// ```');
      buffer.writeln('  static String getGlobalInitializationScript() {');
      buffer.writeln("    return '''");

      // Generate wrapper functions for each global function
      for (final func in globalFunctions) {
        // Separate parameters by kind
        final requiredPositional = <String>[];
        final optionalPositional = <String>[];
        final namedParams = <String>[];

        for (final p in func.parameters) {
          if (p.isNamed) {
            // Named parameters go in {...}
            if (p.isRequired) {
              namedParams.add('required ${p.type} ${p.name}');
            } else {
              // Optional named - ensure nullable type
              final nullableType = p.type.endsWith('?') ? p.type : '${p.type}?';
              namedParams.add('$nullableType ${p.name}');
            }
          } else if (!p.isRequired) {
            // Optional positional - ensure nullable type
            final nullableType = p.type.endsWith('?') ? p.type : '${p.type}?';
            optionalPositional.add('$nullableType ${p.name}');
          } else {
            // Required positional
            requiredPositional.add('${p.type} ${p.name}');
          }
        }

        // Build parameter list with proper grouping
        final paramParts = <String>[];
        paramParts.addAll(requiredPositional);
        if (optionalPositional.isNotEmpty) {
          paramParts.add('[${optionalPositional.join(', ')}]');
        }
        if (namedParams.isNotEmpty) {
          paramParts.add('{${namedParams.join(', ')}}');
        }
        final params = paramParts.join(', ');

        // Build call arguments
        final callArgs = func.parameters.map((p) {
          if (p.isNamed) {
            return '${p.name}: ${p.name}';
          }
          return p.name;
        }).join(', ');

        buffer.writeln('${func.returnType} ${func.name}($params) => ${capitalizedModuleName}Bridge.${func.name}($callArgs);');
      }

      // Generate variable mirrors
      for (final variable in globalVariables) {
        buffer.writeln('${variable.type} get ${variable.name} => ${capitalizedModuleName}Bridge.${variable.name};');
        if (!variable.isFinal && !variable.isConst) {
          buffer.writeln('set ${variable.name}(${variable.type} value) => ${capitalizedModuleName}Bridge.${variable.name} = value;');
        }
      }

      buffer.writeln("''';");
      buffer.writeln('  }');
      buffer.writeln();
    }

    buffer.writeln('}');
    buffer.writeln();

    // Generate individual bridge functions
    final allWarnings = <String>[];
    for (final cls in classes) {
      final warnings = _generateClassBridge(buffer, cls);
      allWarnings.addAll(warnings);
      buffer.writeln();
    }

    // Print any warnings
    if (allWarnings.isNotEmpty) {
      for (final warning in allWarnings) {
        // ignore: avoid_print
        print('Warning: $warning');
      }
    }

    return buffer.toString();
  }

  /// Gets a module name from a file path.
  String _getModuleName(String filePath) {
    final baseName = p.basenameWithoutExtension(filePath);
    // Convert snake_case to PascalCase
    return baseName
        .split('_')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join();
  }

  /// Gets relative import path from a source file.
  String _getRelativeImport(String filePath) {
    // Extract path after lib/
    final libIndex = filePath.indexOf('/lib/');
    if (libIndex >= 0) {
      return filePath.substring(libIndex + 5);
    }
    return p.basename(filePath);
  }

  /// Gets the prefixed class name if the source file has a prefix, otherwise returns the plain name.
  String _getPrefixedClassName(String className, String sourceFile) {
    // Convert source file path to package URI
    final uri = _getPackageUri(sourceFile);
    final prefix = _importPrefixes[uri];
    if (prefix != null) {
      return '$prefix.$className';
    }
    return className;
  }

  /// Gets the prefixed function name if the source file has a prefix, otherwise returns the plain name.
  String _getPrefixedFunctionName(String funcName, String sourceFile) {
    // Convert source file path to package URI
    final uri = _getPackageUri(sourceFile);
    final prefix = _importPrefixes[uri];
    if (prefix != null) {
      return '$prefix.$funcName';
    }
    return funcName;
  }

  /// Converts a source file path to a package URI.
  String _getPackageUri(String sourceFile) {
    // Convert path like /path/to/package/lib/src/foo/bar.dart
    // to package:package_name/src/foo/bar.dart
    final libIndex = sourceFile.indexOf('/lib/');
    if (libIndex != -1) {
      final pkgName = _getPackageNameFromPath(sourceFile) ?? packageName;
      if (pkgName != null) {
        final relativePath = sourceFile.substring(libIndex + 5); // Skip '/lib/'
        return 'package:$pkgName/$relativePath';
      }
    }
    return sourceFile;
  }

  /// Detects the package name from a file path by looking at pubspec.yaml.
  ///
  /// Given /path/to/tom_core_kernel/lib/src/foo.dart, returns 'tom_core_kernel'.
  String? _getPackageNameFromPath(String filePath) {
    final libIndex = filePath.indexOf('/lib/');
    if (libIndex == -1) return null;
    
    // Path up to /lib/
    final packageDir = filePath.substring(0, libIndex);
    final pubspecPath = '$packageDir/pubspec.yaml';
    
    try {
      final pubspecFile = File(pubspecPath);
      if (pubspecFile.existsSync()) {
        final content = pubspecFile.readAsStringSync();
        // Simple regex to extract package name
        final nameMatch = RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(content);
        if (nameMatch != null) {
          return nameMatch.group(1);
        }
      }
    } catch (_) {
      // Ignore errors, fall back to null
    }
    
    return null;
  }

  /// Generates a bridge function for a single class.
  /// Returns list of warnings for skipped members.
  List<String> _generateClassBridge(StringBuffer buffer, ClassInfo cls) {
    final warnings = <String>[];
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
    final userBridge = _userBridgeScanner.getUserBridgeFor(cls.name);
    
    buffer.writeln(
      '// =============================================================================',
    );
    buffer.writeln('// ${cls.name} Bridge');
    buffer.writeln(
      '// =============================================================================',
    );
    buffer.writeln();
    buffer.writeln('BridgedClass _create${cls.name}Bridge() {');
    buffer.writeln('  return BridgedClass(');
    buffer.writeln('    nativeType: $prefixedName,');
    buffer.writeln("    name: '${cls.name}',");
    
    // Use nativeNames from UserBridge if available
    if (userBridge != null && userBridge.hasNativeNames) {
      buffer.writeln('    nativeNames: ${userBridge.userBridgeClassName}.nativeNames,');
    }

    // Constructors
    buffer.writeln('    constructors: {');
    for (final ctor in cls.constructors) {
      final ctorName = ctor.name ?? '';
      
      // Check for constructor override
      final ctorOverride = userBridge?.getConstructorOverride(ctorName);
      if (ctorOverride != null) {
        buffer.writeln(
          "      '$ctorName': ${userBridge!.userBridgeClassName}.$ctorOverride,",
        );
        continue;
      }
      
      // Try generating into temp buffer first
      final tempBuffer = StringBuffer();
      tempBuffer.writeln("      '$ctorName': (visitor, positional, named) {");
      if (_generateConstructorBody(
        tempBuffer,
        cls,
        ctor,
        prefixedName,
        warnings: warnings,
      )) {
        tempBuffer.writeln('      },');
        buffer.write(tempBuffer.toString());
      }
      // If false, constructor is skipped (warning already added)
    }
    buffer.writeln('    },');

    // Getters (including inherited)
    final instanceGetters = cls.allInstanceGetters(_classLookup);
    if (instanceGetters.isNotEmpty) {
      buffer.writeln('    getters: {');
      for (final getter in instanceGetters) {
        // Check for getter override
        final getterOverride = userBridge?.getGetterOverride(getter.name);
        if (getterOverride != null) {
          buffer.writeln(
            "      '${getter.name}': ${userBridge!.userBridgeClassName}.$getterOverride,",
          );
        } else {
          buffer.writeln(
            "      '${getter.name}': (visitor, target) => "
            "D4.validateTarget<$prefixedName>(target, '${cls.name}').${getter.name},",
          );
        }
      }
      buffer.writeln('    },');
    }

    // Setters (unless readOnly) - including inherited
    final instanceSetters = cls.allInstanceSetters(_classLookup);
    if (!readOnly && instanceSetters.isNotEmpty) {
      buffer.writeln('    setters: {');
      for (final setter in instanceSetters) {
        // Check for setter override
        final setterOverride = userBridge?.getSetterOverride(setter.name);
        if (setterOverride != null) {
          buffer.writeln(
            "      '${setter.name}': ${userBridge!.userBridgeClassName}.$setterOverride,",
          );
        } else {
          // Use prefixed type for the cast
          final prefixedSetterType = _getTypeArgument(
            setter.returnType,
            typeToUri: setter.returnTypeToUri,
            classTypeParams: cls.typeParameters,
          );
          buffer.writeln("      '${setter.name}': (visitor, target, value) => ");
          buffer.writeln(
            "        D4.validateTarget<$prefixedName>(target, '${cls.name}').${setter.name} = value as $prefixedSetterType,",
          );
        }
      }
      buffer.writeln('    },');
    }

    // Methods and operators (including inherited)
    final instanceMethods = cls.allInstanceMethods(_classLookup);
    final instanceOperators = cls.allInstanceOperators(_classLookup);
    if (instanceMethods.isNotEmpty || instanceOperators.isNotEmpty) {
      buffer.writeln('    methods: {');
      
      // Regular methods
      for (final method in instanceMethods) {
        // Check for method override (including operators)
        final methodOverride = userBridge?.getMethodOverride(method.name) ??
            userBridge?.getOperatorOverride(method.name);
        if (methodOverride != null) {
          buffer.writeln(
            "      '${method.name}': ${userBridge!.userBridgeClassName}.$methodOverride,",
          );
          continue;
        }
        
        // Try generating into temp buffer first
        final tempBuffer = StringBuffer();
        tempBuffer.writeln(
          "      '${method.name}': (visitor, target, positional, named) {",
        );
        if (_generateMethodBody(
          tempBuffer,
          cls,
          method,
          warnings: warnings,
        )) {
          tempBuffer.writeln('      },');
          buffer.write(tempBuffer.toString());
        }
        // If false, method is skipped (warning already added)
      }
      
      // Operators
      for (final operator in instanceOperators) {
        // Check for operator override
        final operatorOverride = userBridge?.getOperatorOverride(operator.name);
        if (operatorOverride != null) {
          buffer.writeln(
            "      '${operator.name}': ${userBridge!.userBridgeClassName}.$operatorOverride,",
          );
          continue;
        }
        
        // Generate operator body
        _generateOperatorBody(buffer, cls, operator);
      }
      
      buffer.writeln('    },');
    }

    // Static members - separate getters from methods
    final staticMembers = cls.staticMembers;
    final staticGetters = staticMembers.where((m) => m.isGetter).toList();
    final staticMethods = staticMembers.where((m) => m.isMethod).toList();

    // Static getters use (visitor) signature for property access
    if (staticGetters.isNotEmpty) {
      buffer.writeln('    staticGetters: {');
      for (final getter in staticGetters) {
        // Check for static getter override
        final staticGetterOverride = userBridge?.getStaticGetterOverride(getter.name);
        if (staticGetterOverride != null) {
          buffer.writeln(
            "      '${getter.name}': ${userBridge!.userBridgeClassName}.$staticGetterOverride,",
          );
        } else {
          // Use prefixedName for static access
          buffer.writeln(
            "      '${getter.name}': (visitor) => "
            "$prefixedName.${getter.name},",
          );
        }
      }
      buffer.writeln('    },');
    }

    // Static methods use (visitor, positional, named) signature for method calls
    if (staticMethods.isNotEmpty) {
      buffer.writeln('    staticMethods: {');
      for (final method in staticMethods) {
        // Check for static method override
        final staticMethodOverride = userBridge?.getStaticMethodOverride(method.name);
        if (staticMethodOverride != null) {
          buffer.writeln(
            "      '${method.name}': ${userBridge!.userBridgeClassName}.$staticMethodOverride,",
          );
          continue;
        }
        
        // Try generating into temp buffer first
        final tempBuffer = StringBuffer();
        tempBuffer.writeln(
          "      '${method.name}': (visitor, positional, named) {",
        );
        if (_generateStaticMethodBody(
          tempBuffer,
          cls,
          method,
          warnings: warnings,
        )) {
          tempBuffer.writeln('      },');
          buffer.write(tempBuffer.toString());
        }
        // If false, static method is skipped (warning already added)
      }
      buffer.writeln('    },');
    }

    buffer.writeln('  );');
    buffer.writeln('}');
    return warnings;
  }

  /// Generates constructor body code.
  /// Returns false if the constructor cannot be bridged.
  bool _generateConstructorBody(
    StringBuffer buffer,
    ClassInfo cls,
    ConstructorInfo ctor,
    String prefixedName, {
    List<String>? warnings,
  }) {
    final params = ctor.parameters;
    final positionalParams = params.where((p) => !p.isNamed).toList();
    final namedParams = params.where((p) => p.isNamed).toList();

    // Required positional args validation
    final requiredCount = positionalParams.where((p) => p.isRequired).length;
    if (requiredCount > 0) {
      buffer.writeln(
        "        D4.requireMinArgs(positional, $requiredCount, '${cls.name}');",
      );
    }

    // Map to store custom call expressions for function-type parameters
    final callExpressions = <String, String>{};

    // Extract positional parameters
    final sourceUri = _getPackageUri(cls.sourceFile);
    for (var i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      if (!_generatePositionalParamExtraction(
        buffer,
        param,
        i,
        cls.name,
        sourceUri: sourceUri,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
        callExpressions: callExpressions,
      )) {
        return false; // Can't bridge this constructor
      }
    }

    // Extract named parameters
    for (final param in namedParams) {
      if (!_generateNamedParamExtraction(
        buffer,
        param,
        cls.name,
        sourceUri: sourceUri,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
        callExpressions: callExpressions,
      )) {
        return false; // Can't bridge this constructor
      }
    }

    // Constructor call - use prefixed name for the constructor
    final ctorCall = ctor.name != null
        ? '$prefixedName.${ctor.name}'
        : prefixedName;
    final args = <String>[];
    for (final param in positionalParams) {
      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      args.add(callExpr ?? _getSafeLocalName(param.name));
    }
    for (final param in namedParams) {
      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      final argValue = callExpr ?? _getSafeLocalName(param.name);
      args.add('${param.name}: $argValue');
    }
    buffer.writeln('        return $ctorCall(${args.join(', ')});');
    return true;
  }

  /// Generates method body code.
  /// Returns false if the method cannot be bridged.
  bool _generateMethodBody(
    StringBuffer buffer,
    ClassInfo cls,
    MemberInfo method, {
    List<String>? warnings,
  }) {
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
    buffer.writeln(
      "        final t = D4.validateTarget<$prefixedName>(target, '${cls.name}');",
    );

    final positionalParams = method.parameters
        .where((p) => !p.isNamed)
        .toList();
    final namedParams = method.parameters.where((p) => p.isNamed).toList();

    // Required positional args validation
    final requiredCount = positionalParams.where((p) => p.isRequired).length;
    if (requiredCount > 0) {
      buffer.writeln(
        "        D4.requireMinArgs(positional, $requiredCount, '${method.name}');",
      );
    }

    // Map to store custom call expressions for function-type parameters
    final callExpressions = <String, String>{};

    // Extract positional parameters
    final sourceUri = _getPackageUri(cls.sourceFile);
    for (var i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      if (!_generatePositionalParamExtraction(
        buffer,
        param,
        i,
        method.name,
        sourceUri: sourceUri,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
        callExpressions: callExpressions,
      )) {
        return false;
      }
    }

    // Extract named parameters
    for (final param in namedParams) {
      if (!_generateNamedParamExtraction(
        buffer,
        param,
        method.name,
        sourceUri: sourceUri,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
        callExpressions: callExpressions,
      )) {
        return false;
      }
    }

    // Method call
    final args = <String>[];
    for (final param in positionalParams) {
      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      args.add(callExpr ?? _getSafeLocalName(param.name));
    }
    for (final param in namedParams) {
      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      final argValue = callExpr ?? _getSafeLocalName(param.name);
      args.add('${param.name}: $argValue');
    }

    final isVoid = method.returnType == 'void';
    if (isVoid) {
      buffer.writeln('        t.${method.name}(${args.join(', ')});');
      buffer.writeln('        return null;');
    } else {
      buffer.writeln('        return t.${method.name}(${args.join(', ')});');
    }
    return true;
  }

  /// Generates operator bridge code.
  /// Operators are special methods that use operator syntax.
  void _generateOperatorBody(
    StringBuffer buffer,
    ClassInfo cls,
    MemberInfo operator,
  ) {
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
    final operatorName = operator.name;
    
    buffer.writeln(
      "      '$operatorName': (visitor, target, positional, named) {",
    );
    buffer.writeln(
      "        final t = D4.validateTarget<$prefixedName>(target, '${cls.name}');",
    );
    
    // Handle different operator arities
    if (operatorName == '[]') {
      // Index getter: target[index]
      // Get the parameter type for index operator
      if (operator.parameters.isNotEmpty) {
        final indexParam = operator.parameters.first;
        final indexType = _getTypeArgument(
          indexParam.type,
          typeToUri: indexParam.typeToUri,
          classTypeParams: cls.typeParameters,
        );
        buffer.writeln("        final index = D4.getRequiredArg<$indexType>(positional, 0, 'index', 'operator[]');");
        buffer.writeln("        return t[index];");
      } else {
        buffer.writeln("        return t[positional[0]];");
      }
    } else if (operatorName == '[]=') {
      // Index setter: target[index] = value
      if (operator.parameters.length >= 2) {
        final indexParam = operator.parameters[0];
        final valueParam = operator.parameters[1];
        final indexType = _getTypeArgument(
          indexParam.type,
          typeToUri: indexParam.typeToUri,
          classTypeParams: cls.typeParameters,
        );
        final valueType = _getTypeArgument(
          valueParam.type,
          typeToUri: valueParam.typeToUri,
          classTypeParams: cls.typeParameters,
        );
        buffer.writeln("        final index = D4.getRequiredArg<$indexType>(positional, 0, 'index', 'operator[]=');");
        buffer.writeln("        final value = D4.getRequiredArg<$valueType>(positional, 1, 'value', 'operator[]=');");
        buffer.writeln("        t[index] = value;");
      } else {
        buffer.writeln("        t[positional[0]] = positional[1];");
      }
      buffer.writeln("        return null;");
    } else if (operatorName == '~') {
      // Unary bitwise NOT operator: ~target
      buffer.writeln("        return ~t;");
    } else if (operatorName == '-' && operator.parameters.isEmpty) {
      // Unary negation operator: -target
      buffer.writeln("        return -t;");
    } else {
      // Binary operators: target op operand
      // All binary operators (+, -, *, /, ~/, %, &, |, ^, <<, >>, >>>, <, >, <=, >=, ==)
      if (operator.parameters.isNotEmpty) {
        final operandParam = operator.parameters.first;
        final operandType = _getTypeArgument(
          operandParam.type,
          typeToUri: operandParam.typeToUri,
          classTypeParams: cls.typeParameters,
        );
        buffer.writeln("        final other = D4.getRequiredArg<$operandType>(positional, 0, 'other', 'operator$operatorName');");
        buffer.writeln("        return t $operatorName other;");
      } else {
        buffer.writeln("        return t $operatorName positional[0];");
      }
    }
    
    buffer.writeln('      },');
  }

  /// Generates static method body code.
  /// Returns false if the method cannot be bridged.
  bool _generateStaticMethodBody(
    StringBuffer buffer,
    ClassInfo cls,
    MemberInfo method, {
    List<String>? warnings,
  }) {
    final positionalParams = method.parameters
        .where((p) => !p.isNamed)
        .toList();
    final namedParams = method.parameters.where((p) => p.isNamed).toList();

    // Required positional args validation
    final requiredCount = positionalParams.where((p) => p.isRequired).length;
    if (requiredCount > 0) {
      buffer.writeln(
        "        D4.requireMinArgs(positional, $requiredCount, '${method.name}');",
      );
    }

    // Extract positional parameters
    final sourceUri = _getPackageUri(cls.sourceFile);
    for (var i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      if (!_generatePositionalParamExtraction(
        buffer,
        param,
        i,
        method.name,
        sourceUri: sourceUri,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
      )) {
        return false;
      }
    }

    // Extract named parameters
    for (final param in namedParams) {
      if (!_generateNamedParamExtraction(
        buffer,
        param,
        method.name,
        sourceUri: sourceUri,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
      )) {
        return false;
      }
    }

    // Static method call
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
    final args = <String>[];
    for (final param in positionalParams) {
      args.add(_getSafeLocalName(param.name));
    }
    for (final param in namedParams) {
      final localName = _getSafeLocalName(param.name);
      args.add('${param.name}: $localName');
    }

    buffer.writeln(
      '        return $prefixedName.${method.name}(${args.join(', ')});',
    );
    return true;
  }

  /// Generates extraction code for a positional parameter.
  /// Returns false if the parameter cannot be bridged (e.g., required function type).
  /// 
  /// If [callExpressions] is provided and this is a function-type parameter,
  /// the wrapper expression will be stored in the map. Otherwise the local
  /// variable name will be stored.
  bool _generatePositionalParamExtraction(
    StringBuffer buffer,
    ParameterInfo param,
    int index,
    String contextName, {
    String? sourceUri,
    List<String>? warnings,
    Map<String, String?> classTypeParams = const {},
    Map<String, String>? callExpressions,
  }) {
    final isNullable = param.type.endsWith('?');
    final localName = _getSafeLocalName(param.name);

    // Check for List types - need coercion
    if (_isListType(param.type)) {
      final elementType = _getListElementType(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
      );

      // Check if element type is a function typedef - can't bridge those properly
      final rawElementType = _extractListElementType(param.type);
      if (_isFunctionTypeName(rawElementType)) {
        final localName = _getSafeLocalName(param.name);
        warnings?.add(
          'TODO: $contextName: parameter "${param.name}" '
          'has unbridgeable function type List<$rawElementType>',
        );
        // Generate TODO code that throws at runtime, but define variable for compilation
        buffer.writeln(
          "        // TODO: Unbridgeable function type List<$rawElementType>",
        );
        buffer.writeln(
          "        throw UnimplementedError('$contextName: Parameter \"${param.name}\" has unbridgeable function type List<$rawElementType>. Bridge cannot handle function types in collections.');",
        );
        // Define dummy variable so code compiles (unreachable due to throw)
        // ignore: dead_code
        buffer.writeln(
          "        // ignore: dead_code",
        );
        buffer.writeln(
          "        final $localName = <dynamic>[];",
        );
        return true;
      }

      final coerceMethod = isNullable ? 'D4.coerceListOrNull' : 'D4.coerceList';
      if (param.isRequired) {
        buffer.writeln("        if (positional.length <= $index) {");
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$elementType>(positional[$index], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(param.defaultValue!)) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
          );
          buffer.writeln(
            "        final $localName = positional.length > $index && positional[$index] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$elementType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for List - record warning
          _recordNonWrappableDefault(contextName, param.name, param.defaultValue!);
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln("        if (positional.length <= $index || positional[$index] == null) {");
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$elementType>(positional[$index], '${param.name}');",
          );
        }
      } else {
        buffer.writeln("        final $localName = positional.length > $index");
        buffer.writeln(
          "            ? D4.coerceListOrNull<$elementType>(positional[$index], '${param.name}')",
        );
        buffer.writeln("            : null;");
      }
      return true;
    }

    // Check for Map types - need coercion
    if (_isMapType(param.type)) {
      final (keyType, valueType) = _getMapTypeArgs(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
      );
      final coerceMethod = isNullable ? 'D4.coerceMapOrNull' : 'D4.coerceMap';
      if (param.isRequired) {
        buffer.writeln("        if (positional.length <= $index) {");;
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$keyType, $valueType>(positional[$index], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(param.defaultValue!)) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
          );
          buffer.writeln(
            "        final $localName = positional.length > $index && positional[$index] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$keyType, $valueType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for Map - record warning
          _recordNonWrappableDefault(contextName, param.name, param.defaultValue!);
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln("        if (positional.length <= $index || positional[$index] == null) {");
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$keyType, $valueType>(positional[$index], '${param.name}');",
          );
        }
      } else {
        buffer.writeln("        final $localName = positional.length > $index");
        buffer.writeln(
          "            ? D4.coerceMapOrNull<$keyType, $valueType>(positional[$index], '${param.name}')",
        );
        buffer.writeln("            : null;");
      }
      return true;
    }

    // Check if the parameter type itself is a function typedef
    final baseType = param.type.replaceAll('?', '');
    if (_isFunctionTypeName(baseType)) {
      // Get function type info - try known aliases first, then parse
      var funcInfo = _knownFunctionTypeAliasInfo[baseType];
      funcInfo ??= _parseFunctionType(baseType);
      
      if (funcInfo == null) {
        // Could not parse function type - fall back to warning
        warnings?.add(
          'TODO: $contextName: parameter "${param.name}" '
          'has unparseable function type ${param.type}',
        );
        buffer.writeln(
          "        // TODO: Unparseable function type ${param.type}",
        );
        buffer.writeln(
          "        throw UnimplementedError('$contextName: Parameter \"${param.name}\" has unparseable function type ${param.type}.');",
        );
        buffer.writeln(
          "        // ignore: dead_code",
        );
        buffer.writeln(
          "        final $localName = null;",
        );
        return true;
      }
      
      // Generate extraction of raw InterpretedFunction value
      final rawVarName = '${localName}_raw';
      if (param.isRequired) {
        buffer.writeln("        if (positional.length <= $index) {");
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $rawVarName = positional[$index];",
        );
      } else {
        buffer.writeln(
          "        final $rawVarName = positional.length > $index ? positional[$index] : null;",
        );
      }
      
      // Generate wrapper expression and store in callExpressions map
      final wrapperExpr = _generateFunctionWrapper(
        callbackVarName: rawVarName,
        funcInfo: funcInfo,
        isNullable: isNullable || !param.isRequired,
      );
      
      if (callExpressions != null) {
        callExpressions[param.name] = wrapperExpr;
      } else {
        // If no callExpressions map, generate as local variable (for backwards compat)
        buffer.writeln("        final $localName = $wrapperExpr;");
      }
      return true;
    }

    // Standard extraction for other types
    final typeArg = _getTypeArgument(
      param.type,
      typeToUri: param.typeToUri,
      classTypeParams: classTypeParams,
    );
    if (param.isRequired) {
      buffer.writeln(
        "        final $localName = D4.getRequiredArg<$typeArg>"
        "(positional, $index, '${param.name}', '$contextName');",
      );
    } else if (param.defaultValue != null) {
      final prefixedDefault = _prefixDefaultValue(
        param.defaultValue!,
        sourceUri,
      );
      if (prefixedDefault != null) {
        // Wrappable default - use normal optional arg with default
        buffer.writeln(
          "        final $localName = D4.getOptionalArgWithDefault<$typeArg>"
          "(positional, $index, '${param.name}', $prefixedDefault);",
        );
      } else {
        // Non-wrappable default - use TODO helper and record warning
        _recordNonWrappableDefault(contextName, param.name, param.defaultValue!);
        buffer.writeln(
          "        // TODO: Non-wrappable default: ${param.defaultValue}",
        );
        buffer.writeln(
          "        final $localName = D4.getRequiredArgTodoDefault<$typeArg>"
          "(positional, $index, '${param.name}', '$contextName', '${_escapeString(param.defaultValue!)}');",
        );
      }
    } else {
      buffer.writeln(
        "        final $localName = D4.getOptionalArg<$typeArg>"
        "(positional, $index, '${param.name}');",
      );
    }
    return true;
  }

  /// Gets a typed default value for List/Map types.
  /// Transforms `const []` to `const <Type>[]` and `const {}` to `const <K, V>{}`.
  String _getTypedDefaultValue(
    String defaultValue,
    String fullType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
  }) {
    if (_isListType(fullType)) {
      final elementType = _getListElementType(
        fullType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
      );
      if (defaultValue == 'const []' || defaultValue == '[]') {
        return 'const <$elementType>[]';
      }
    } else if (_isMapType(fullType)) {
      final (keyType, valueType) = _getMapTypeArgs(
        fullType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
      );
      if (defaultValue == 'const {}' || defaultValue == '{}') {
        return 'const <$keyType, $valueType>{}';
      }
    }
    return defaultValue;
  }

  /// Reserved parameter names in BridgedClass closures.
  /// Parameters with these names need to be renamed to avoid shadowing.
  static const _reservedNames = {
    'target',
    'visitor',
    'positional',
    'named',
    't',
  };

  /// Gets a safe local variable name for a parameter.
  /// Renames reserved names by appending an underscore.
  String _getSafeLocalName(String paramName) {
    if (_reservedNames.contains(paramName)) {
      return '${paramName}_';
    }
    return paramName;
  }

  /// Generates extraction code for a named parameter.
  /// Handles List and Map types with coercion helpers.
  /// Returns false if this parameter cannot be bridged (e.g., required function type).
  /// 
  /// If [callExpressions] is provided and this is a function-type parameter,
  /// the wrapper expression will be stored in the map. Otherwise the local
  /// variable name will be stored.
  bool _generateNamedParamExtraction(
    StringBuffer buffer,
    ParameterInfo param,
    String contextName, {
    String? sourceUri,
    List<String>? warnings,
    Map<String, String?> classTypeParams = const {},
    Map<String, String>? callExpressions,
  }) {
    final isNullable = param.type.endsWith('?');
    final localName = _getSafeLocalName(param.name);

    // Check for List types - need coercion
    if (_isListType(param.type)) {
      final rawElementType = _extractListElementType(param.type);
      final isFunctionElement = _isFunctionTypeName(rawElementType);

      // If element type is a function typedef, we can't bridge it properly
      if (isFunctionElement) {
        warnings?.add(
          'TODO: $contextName: parameter "${param.name}" '
          'has unbridgeable type List<$rawElementType>',
        );
        // Generate TODO code that throws at runtime, but define variable for compilation
        buffer.writeln(
          "        // TODO: Unbridgeable function type List<$rawElementType>",
        );
        buffer.writeln(
          "        throw UnimplementedError('$contextName: Parameter \"${param.name}\" has unbridgeable function type List<$rawElementType>. Bridge cannot handle function types in collections.');",
        );
        // Define dummy variable so code compiles (unreachable due to throw)
        buffer.writeln(
          "        // ignore: dead_code",
        );
        buffer.writeln(
          "        final $localName = <dynamic>[];",
        );
        return true;
      }

      final elementType = _getListElementType(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
      );
      final coerceMethod = isNullable ? 'D4.coerceListOrNull' : 'D4.coerceList';
      if (param.isRequired) {
        buffer.writeln(
          "        if (!named.containsKey('${param.name}') || named['${param.name}'] == null) {",
        );
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$elementType>(named['${param.name}'], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(param.defaultValue!)) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
          );
          buffer.writeln(
            "        final $localName = named.containsKey('${param.name}') && named['${param.name}'] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$elementType>(named['${param.name}'], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for List - record warning
          _recordNonWrappableDefault(contextName, param.name, param.defaultValue!);
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln(
            "        if (!named.containsKey('${param.name}') || named['${param.name}'] == null) {",
          );
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$elementType>(named['${param.name}'], '${param.name}');",
          );
        }
      } else {
        buffer.writeln(
          "        final $localName = D4.coerceListOrNull<$elementType>(named['${param.name}'], '${param.name}');",
        );
      }
      return true;
    }

    // Check if the parameter type itself is a function typedef
    final baseType = param.type.replaceAll('?', '');
    if (_isFunctionTypeName(baseType)) {
      // Get function type info - try known aliases first, then parse
      var funcInfo = _knownFunctionTypeAliasInfo[baseType];
      funcInfo ??= _parseFunctionType(baseType);
      
      if (funcInfo == null) {
        // Could not parse function type - fall back to warning
        warnings?.add(
          'TODO: $contextName: parameter "${param.name}" '
          'has unparseable function type ${param.type}',
        );
        buffer.writeln(
          "        // TODO: Unparseable function type ${param.type}",
        );
        buffer.writeln(
          "        throw UnimplementedError('$contextName: Parameter \"${param.name}\" has unparseable function type ${param.type}.');",
        );
        buffer.writeln(
          "        // ignore: dead_code",
        );
        buffer.writeln(
          "        final $localName = null;",
        );
        return true;
      }
      
      // Generate extraction of raw InterpretedFunction value
      final rawVarName = '${localName}_raw';
      if (param.isRequired) {
        buffer.writeln(
          "        if (!named.containsKey('${param.name}') || named['${param.name}'] == null) {",
        );
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $rawVarName = named['${param.name}'];",
        );
      } else {
        buffer.writeln(
          "        final $rawVarName = named['${param.name}'];",
        );
      }
      
      // Generate wrapper expression and store in callExpressions map
      final wrapperExpr = _generateFunctionWrapper(
        callbackVarName: rawVarName,
        funcInfo: funcInfo,
        isNullable: isNullable || !param.isRequired,
      );
      
      if (callExpressions != null) {
        callExpressions[param.name] = wrapperExpr;
      } else {
        // If no callExpressions map, generate as local variable (for backwards compat)
        buffer.writeln("        final $localName = $wrapperExpr;");
      }
      return true;
    }

    // Check for Map types - need coercion
    if (_isMapType(param.type)) {
      final (keyType, valueType) = _getMapTypeArgs(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
      );
      final coerceMethod = isNullable ? 'D4.coerceMapOrNull' : 'D4.coerceMap';
      if (param.isRequired) {
        buffer.writeln(
          "        if (!named.containsKey('${param.name}') || named['${param.name}'] == null) {",
        );
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(param.defaultValue!)) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
          );
          buffer.writeln(
            "        final $localName = named.containsKey('${param.name}') && named['${param.name}'] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$keyType, $valueType>(named['${param.name}'], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for Map - record warning
          _recordNonWrappableDefault(contextName, param.name, param.defaultValue!);
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln(
            "        if (!named.containsKey('${param.name}') || named['${param.name}'] == null) {",
          );
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
          );
        }
      } else {
        buffer.writeln(
          "        final $localName = D4.coerceMapOrNull<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
        );
      }
      return true;
    }

    // Standard extraction for other types
    final helperMethod = param.isRequired
        ? 'D4.getRequiredNamedArg'
        : (param.defaultValue != null
              ? 'D4.getNamedArgWithDefault'
              : 'D4.getOptionalNamedArg');
    final typeArg = _getTypeArgument(
      param.type,
      typeToUri: param.typeToUri,
      classTypeParams: classTypeParams,
    );
    if (param.defaultValue != null) {
      final prefixedDefault = _prefixDefaultValue(
        param.defaultValue!,
        sourceUri,
      );
      if (prefixedDefault != null) {
        // Wrappable default - use normal named arg with default
        buffer.writeln(
          "        final $localName = $helperMethod<$typeArg>"
          "(named, '${param.name}', $prefixedDefault);",
        );
      } else {
        // Non-wrappable default - use TODO helper and record warning
        _recordNonWrappableDefault(contextName, param.name, param.defaultValue!);
        buffer.writeln(
          "        // TODO: Non-wrappable default: ${param.defaultValue}",
        );
        buffer.writeln(
          "        final $localName = D4.getRequiredNamedArgTodoDefault<$typeArg>"
          "(named, '${param.name}', '$contextName', '${_escapeString(param.defaultValue!)}');",
        );
      }
    } else {
      buffer.writeln(
        "        final $localName = $helperMethod<$typeArg>"
        "(named, '${param.name}'${param.isRequired ? ", '$contextName'" : ''});",
      );
    }
    return true;
  }

  /// Gets the type argument for helper functions.
  ///
  /// Resolves type parameters to concrete types:
  /// - Single-letter type parameters (T, R, E, etc.) become `Object`
  /// - Generic types like `List<T>` become `List<Object>`
  /// - Nullable types have their `?` suffix stripped for helper type arg
  /// - External types are prefixed with their import prefix
  /// - Function types and function typedefs are simplified to `dynamic`
  ///
  /// If [typeToUri] is non-empty, external types will be prefixed.
  /// If [classTypeParams] is provided, generic type parameters will be resolved
  /// to their bounds (e.g., E -> TomObject).
  String _getTypeArgument(
    String type, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
  }) {
    // Handle nullable types first - strip the ?
    var baseType = type;
    var isNullable = false;
    if (baseType.endsWith('?')) {
      baseType = baseType.substring(0, baseType.length - 1);
      isNullable = true;
    }

    // Handle function types and known function typedefs - use dynamic
    if (_isFunctionTypeName(baseType)) {
      return 'dynamic';
    }

    // Handle generic type parameters (T, R, E, K, V, S, etc.)
    // Use the bound type from class context if available, otherwise dynamic
    if (_isGenericTypeParameter(baseType)) {
      final bound = classTypeParams[baseType];
      if (bound != null) {
        // Use the bound type (e.g., E -> TomObject)
        // Recursively resolve in case the bound itself needs prefixing
        return _getTypeArgument(bound, typeToUri: typeToUri, classTypeParams: classTypeParams);
      }
      return 'dynamic';
    }

    // Handle generic types with type arguments like List<T>, Map<K, V>
    if (baseType.contains('<')) {
      return _resolveGenericTypeWithPrefixes(baseType, typeToUri, classTypeParams: classTypeParams);
    }

    // Strip any existing prefix from source (e.g., jwt.JWTKey -> JWTKey)
    // The source code may have prefixed types, but we need to apply our own prefixes
    var unprefixedType = baseType;
    if (baseType.contains('.') && !baseType.contains('<')) {
      // This looks like a prefixed type - extract just the class name
      final parts = baseType.split('.');
      unprefixedType = parts.last;
    }

    // Check if this type needs a prefix
    final uri = typeToUri[unprefixedType];
    if (uri != null) {
      final prefix = _importPrefixes[uri];
      if (prefix != null) {
        // Check if this type is exported from the barrel file
        if (!_isTypeExported(unprefixedType)) {
          // Type is not exported - record warning and use dynamic
          _recordMissingExport('type argument', unprefixedType);
          return 'dynamic';
        }
        final result = '$prefix.$unprefixedType';
        return isNullable ? '$result?' : result;
      }
    }

    return type;
  }

  /// Resolves generic types with import prefixes.
  String _resolveGenericTypeWithPrefixes(
    String type,
    Map<String, String> typeToUri, {
    Map<String, String?> classTypeParams = const {},
  }) {
    final openBracket = type.indexOf('<');
    if (openBracket == -1) return type;

    final baseType = type.substring(0, openBracket);
    final argsStr = type.substring(openBracket + 1, type.length - 1);

    // Prefix the base type if needed
    String prefixedBase = baseType;
    final baseUri = typeToUri[baseType];
    if (baseUri != null) {
      final prefix = _importPrefixes[baseUri];
      if (prefix != null) {
        prefixedBase = '$prefix.$baseType';
      }
    }

    // Parse and resolve type arguments with prefixes
    final resolvedArgs = _resolveTypeArgumentsWithPrefixes(
      argsStr,
      typeToUri,
      classTypeParams: classTypeParams,
    );

    return '$prefixedBase<$resolvedArgs>';
  }

  /// Resolves type arguments with import prefixes.
  /// [classTypeParams] contains the class's generic type parameter bounds.
  String _resolveTypeArgumentsWithPrefixes(
    String argsStr,
    Map<String, String> typeToUri, {
    Map<String, String?> classTypeParams = const {},
  }) {
    final args = <String>[];
    var depth = 0;
    var start = 0;

    for (var i = 0; i < argsStr.length; i++) {
      final char = argsStr[i];
      if (char == '<') {
        depth++;
      } else if (char == '>') {
        depth--;
      } else if (char == ',' && depth == 0) {
        args.add(argsStr.substring(start, i).trim());
        start = i + 1;
      }
    }
    args.add(argsStr.substring(start).trim());

    // Resolve each argument with prefixes
    return args
        .map((arg) {
          var baseArg = arg.endsWith('?')
              ? arg.substring(0, arg.length - 1)
              : arg;
          if (_isGenericTypeParameter(baseArg)) {
            // Use bound from class type parameters if available
            final bound = classTypeParams[baseArg];
            if (bound != null) {
              // Recursively resolve the bound type
              return _getTypeArgument(bound, typeToUri: typeToUri, classTypeParams: classTypeParams);
            }
            return 'dynamic';
          }
          if (baseArg.contains('<')) {
            return _resolveGenericTypeWithPrefixes(arg, typeToUri, classTypeParams: classTypeParams);
          }
          // Check if this type needs a prefix
          final uri = typeToUri[baseArg];
          if (uri != null) {
            final prefix = _importPrefixes[uri];
            if (prefix != null) {
              return '$prefix.$baseArg';
            }
          }
          return arg;
        })
        .join(', ');
  }

  /// Checks if a type is a generic type parameter.
  bool _isGenericTypeParameter(String type) {
    // Single uppercase letter (T, R, E, K, V, S, etc.)
    if (type.length == 1 && type.toUpperCase() == type) {
      return true;
    }
    // Common multi-character type parameters
    const knownTypeParams = {'TValue', 'TKey', 'TResult', 'TElement'};
    return knownTypeParams.contains(type);
  }

  /// Checks if a type is a List type (e.g., List<String>, List<int>).
  bool _isListType(String type) {
    final baseType = type.endsWith('?')
        ? type.substring(0, type.length - 1)
        : type;
    return baseType.startsWith('List<') && baseType.endsWith('>');
  }

  /// Checks if a type is a Map type (e.g., Map<String, int>).
  bool _isMapType(String type) {
    final baseType = type.endsWith('?')
        ? type.substring(0, type.length - 1)
        : type;
    return baseType.startsWith('Map<') && baseType.endsWith('>');
  }

  /// Extracts the element type from a List type (e.g., List<String> -> String).
  /// If the element type is a function type alias, returns 'dynamic'.
  String _getListElementType(
    String listType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
  }) {
    var baseType = listType.endsWith('?')
        ? listType.substring(0, listType.length - 1)
        : listType;
    // Extract content between List< and >
    final elementType = baseType.substring(5, baseType.length - 1);

    // Check if element type is a known function type alias
    // These can't be passed from D4rt, so we use dynamic
    if (_isFunctionTypeName(elementType.replaceAll('?', ''))) {
      return 'dynamic';
    }

    return _getTypeArgument(elementType, typeToUri: typeToUri, classTypeParams: classTypeParams);
  }

  /// Extracts the raw element type from a List type without any prefixing.
  /// Used to check if the element is a function typedef.
  String _extractListElementType(String listType) {
    var baseType = listType.endsWith('?')
        ? listType.substring(0, listType.length - 1)
        : listType;
    // Extract content between List< and >
    return baseType.substring(5, baseType.length - 1).replaceAll('?', '');
  }

  /// Known function typedef names that can't be bridged.
  static const _knownFunctionTypeAliases = {
    'BridgeRegistrar', // void Function(D4rt)
    'D4rtEvaluator', // Future<dynamic> Function(...)
    'VoidCallback', // void Function()
    'ValueChanged', // void Function(T)
    'ValueGetter', // T Function()
    'ValueSetter', // void Function(T)
    'WidgetBuilder', // Widget Function(BuildContext)
  };

  /// Checks if a type name is a known function typedef.
  bool _isFunctionTypeName(String typeName) {
    // Check known function type aliases
    if (_knownFunctionTypeAliases.contains(typeName)) {
      return true;
    }
    // Also check for inline function types
    if (typeName.contains('Function(') || typeName.contains(') Function')) {
      return true;
    }
    return false;
  }

  /// Parses a function type string and extracts its signature.
  /// Returns null if the type cannot be parsed.
  ///
  /// Handles patterns like:
  /// - `void Function()`
  /// - `String Function(int, String)`
  /// - `void Function(int value)?`
  /// - `Widget Function(T)`
  /// - `String? Function(String)?`
  FunctionTypeInfo? _parseFunctionType(String typeStr) {
    // Remove trailing nullable marker for the function type itself
    var funcType = typeStr.trim();
    if (funcType.endsWith('?')) {
      funcType = funcType.substring(0, funcType.length - 1).trim();
    }

    // Check for inline function type pattern: ReturnType Function(Params)
    final funcMatch = RegExp(r'^(.+?)\s+Function\(([^)]*)\)$').firstMatch(funcType);
    if (funcMatch == null) {
      // Check known typedef aliases
      final aliasInfo = _knownFunctionTypeAliasInfo[typeStr.replaceAll('?', '')];
      if (aliasInfo != null) {
        return aliasInfo;
      }
      return null;
    }

    final returnTypeStr = funcMatch.group(1)!.trim();
    final paramsStr = funcMatch.group(2)!.trim();

    // Parse return type
    var returnType = returnTypeStr;
    var returnTypeNullable = false;
    if (returnType.endsWith('?')) {
      returnTypeNullable = true;
      returnType = returnType.substring(0, returnType.length - 1);
    }

    // Parse parameters
    final positionalParamTypes = <String>[];
    final namedParamTypes = <String, String>{};
    final namedParamRequired = <String, bool>{};

    if (paramsStr.isNotEmpty) {
      // Split parameters, handling nested generics
      final params = _splitFunctionParams(paramsStr);
      var inNamedSection = false;

      for (var param in params) {
        param = param.trim();
        if (param.isEmpty) continue;

        // Check for named parameters section
        if (param.startsWith('{')) {
          inNamedSection = true;
          param = param.substring(1).trim();
        }
        if (param.endsWith('}')) {
          param = param.substring(0, param.length - 1).trim();
        }

        if (inNamedSection) {
          // Named parameter: "required Type name" or "Type name" or "Type? name"
          final isRequired = param.startsWith('required ');
          if (isRequired) {
            param = param.substring(9).trim();
          }
          // Split "Type name" - last word is name, rest is type
          final parts = param.split(RegExp(r'\s+'));
          if (parts.length >= 2) {
            final name = parts.last;
            final type = parts.sublist(0, parts.length - 1).join(' ');
            namedParamTypes[name] = type;
            namedParamRequired[name] = isRequired;
          }
        } else {
          // Positional parameter: "Type" or "Type name"
          // We only need the type, so take everything except the last word if it looks like a name
          final parts = param.split(RegExp(r'\s+'));
          if (parts.length == 1) {
            positionalParamTypes.add(parts[0]);
          } else {
            // Last part might be a name (no < or > and not a keyword)
            final lastPart = parts.last;
            if (!lastPart.contains('<') && !lastPart.contains('>') && 
                !_isTypeKeyword(lastPart)) {
              positionalParamTypes.add(parts.sublist(0, parts.length - 1).join(' '));
            } else {
              positionalParamTypes.add(param);
            }
          }
        }
      }
    }

    return FunctionTypeInfo(
      returnType: returnType,
      returnTypeNullable: returnTypeNullable,
      positionalParamTypes: positionalParamTypes,
      namedParamTypes: namedParamTypes,
      namedParamRequired: namedParamRequired,
    );
  }

  /// Checks if a string is a type keyword (not a parameter name)
  bool _isTypeKeyword(String s) {
    return s == 'dynamic' || s == 'void' || s == 'Object' || 
           s == 'int' || s == 'double' || s == 'String' || s == 'bool' ||
           s == 'num' || s == 'Function' || s == 'Never';
  }

  /// Splits function parameters string handling nested generics
  List<String> _splitFunctionParams(String paramsStr) {
    final result = <String>[];
    var depth = 0;
    var current = StringBuffer();

    for (var i = 0; i < paramsStr.length; i++) {
      final char = paramsStr[i];
      if (char == '<' || char == '(' || char == '{') {
        depth++;
        current.write(char);
      } else if (char == '>' || char == ')' || char == '}') {
        depth--;
        current.write(char);
      } else if (char == ',' && depth == 0) {
        result.add(current.toString());
        current = StringBuffer();
      } else {
        current.write(char);
      }
    }
    if (current.isNotEmpty) {
      result.add(current.toString());
    }
    return result;
  }

  /// Known function typedef info for common aliases
  static final _knownFunctionTypeAliasInfo = <String, FunctionTypeInfo>{
    'VoidCallback': FunctionTypeInfo(returnType: 'void'),
    'ValueChanged': FunctionTypeInfo(returnType: 'void', positionalParamTypes: ['T']),
    'ValueGetter': FunctionTypeInfo(returnType: 'T'),
    'ValueSetter': FunctionTypeInfo(returnType: 'void', positionalParamTypes: ['T']),
  };

  /// Generates a wrapper that converts an InterpretedFunction to a native function.
  ///
  /// Example output for `void Function(int, String)`:
  /// ```dart
  /// (int p0, String p1) {
  ///   (callback as InterpretedFunction).call(visitor as InterpreterVisitor, [p0, p1]);
  /// }
  /// ```
  ///
  /// Example output for `String Function(int)?`:
  /// ```dart
  /// callback == null ? null : (int p0) {
  ///   return (callback as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as String;
  /// }
  /// ```
  String _generateFunctionWrapper({
    required String callbackVarName,
    required FunctionTypeInfo funcInfo,
    required bool isNullable,
  }) {
    // Generate parameter list for the wrapper function
    final paramList = <String>[];
    final argList = <String>[];

    for (var i = 0; i < funcInfo.positionalParamTypes.length; i++) {
      final paramType = funcInfo.positionalParamTypes[i];
      final paramName = 'p$i';
      paramList.add('$paramType $paramName');
      argList.add(paramName);
    }

    // Handle named parameters if any
    if (funcInfo.namedParamTypes.isNotEmpty) {
      final namedParams = <String>[];
      for (final entry in funcInfo.namedParamTypes.entries) {
        final isRequired = funcInfo.namedParamRequired[entry.key] ?? false;
        final prefix = isRequired ? 'required ' : '';
        namedParams.add('$prefix${entry.value} ${entry.key}');
      }
      paramList.add('{${namedParams.join(', ')}}');
      // Named args need to be passed as a map
    }

    final paramsStr = paramList.join(', ');
    final argsStr = argList.isNotEmpty ? '[${argList.join(', ')}]' : '[]';

    // Generate named args map if there are named parameters
    String namedArgsStr = '{}';
    if (funcInfo.namedParamTypes.isNotEmpty) {
      final namedArgEntries = funcInfo.namedParamTypes.keys
          .map((name) => "'$name': $name")
          .join(', ');
      namedArgsStr = '{$namedArgEntries}';
    }

    // Build the call expression
    String callExpr;
    if (funcInfo.namedParamTypes.isEmpty) {
      callExpr = '($callbackVarName as InterpretedFunction).call(visitor as InterpreterVisitor, $argsStr)';
    } else {
      callExpr = '($callbackVarName as InterpretedFunction).call(visitor as InterpreterVisitor, $argsStr, $namedArgsStr)';
    }

    // Build the wrapper body
    String wrapperBody;
    if (funcInfo.isVoid) {
      wrapperBody = '{ $callExpr; }';
    } else {
      final returnCast = funcInfo.returnTypeNullable 
          ? 'as ${funcInfo.returnType}?' 
          : 'as ${funcInfo.returnType}';
      wrapperBody = '{ return $callExpr $returnCast; }';
    }

    // Build complete wrapper
    final wrapper = '($paramsStr) $wrapperBody';

    if (isNullable) {
      return '$callbackVarName == null ? null : $wrapper';
    } else {
      return wrapper;
    }
  }

  /// Extracts the key and value types from a Map type.
  /// Returns a record with (keyType, valueType).
  (String, String) _getMapTypeArgs(
    String mapType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
  }) {
    var baseType = mapType.endsWith('?')
        ? mapType.substring(0, mapType.length - 1)
        : mapType;
    // Extract content between Map< and >
    final argsStr = baseType.substring(4, baseType.length - 1);

    // Parse the two type arguments (handling nested generics)
    var depth = 0;
    var splitIndex = -1;
    for (var i = 0; i < argsStr.length; i++) {
      final char = argsStr[i];
      if (char == '<') {
        depth++;
      } else if (char == '>') {
        depth--;
      } else if (char == ',' && depth == 0) {
        splitIndex = i;
        break;
      }
    }

    if (splitIndex == -1) {
      // Fallback: assume simple types
      return ('Object', 'Object');
    }

    final keyType = _getTypeArgument(
      argsStr.substring(0, splitIndex).trim(),
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
    );
    final valueType = _getTypeArgument(
      argsStr.substring(splitIndex + 1).trim(),
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
    );
    return (keyType, valueType);
  }

  /// Collects import URIs from resolved type information in classes.
  ///
  /// This uses the typeImportUris fields populated by the resolved analyzer,
  /// rather than a hardcoded type-to-import mapping.
  Set<String> _collectResolvedTypeImports(List<ClassInfo> classes) {
    final imports = <String>{};

    for (final cls in classes) {
      // Check constructor parameters
      for (final ctor in cls.constructors) {
        for (final param in ctor.parameters) {
          imports.addAll(param.typeImportUris);
        }
      }

      // Check member return types and parameters
      for (final member in cls.members) {
        imports.addAll(member.returnTypeImportUris);
        for (final param in member.parameters) {
          imports.addAll(param.typeImportUris);
        }
      }
    }

    return imports;
  }
}

// =============================================================================
// RESOLVED AST VISITOR (WITH TYPE RESOLUTION)
// =============================================================================

/// AST visitor that extracts class information with resolved type URIs.
///
/// This visitor uses the resolved AST to get the actual import URIs for types,
/// allowing proper import generation in bridge files.
class _ResolvedClassVisitor extends RecursiveAstVisitor<void> {
  final bool skipPrivate;
  final List<_ParsedClass> classes = [];
  final List<GlobalFunctionInfo> globalFunctions = [];
  final List<GlobalVariableInfo> globalVariables = [];
  final List<EnumInfo> enums = [];
  String? currentSourceFile;

  _ResolvedClassVisitor({this.skipPrivate = true});

  /// Sets the current source file for global element tracking.
  void setSourceFile(String path) {
    currentSourceFile = path;
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    final enumName = node.name.lexeme;

    // Skip private enums if configured
    if (skipPrivate && enumName.startsWith('_')) return;

    // Collect enum value names
    final values = node.constants.map((c) => c.name.lexeme).toList();

    // Check if enum has members (methods, getters, fields)
    final hasMembers = node.members.isNotEmpty;

    enums.add(
      EnumInfo(
        name: enumName,
        values: values,
        sourceFile: currentSourceFile ?? '',
        hasMembers: hasMembers,
      ),
    );

    super.visitEnumDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    // Only process top-level functions (skip local functions inside methods/functions)
    // Top-level functions have CompilationUnit as their parent
    if (node.parent is! CompilationUnit) return;

    // Skip private functions
    final name = node.name.lexeme;
    if (skipPrivate && name.startsWith('_')) return;

    // Handle top-level getters as global variables
    if (node.isGetter) {
      final returnType = node.returnType?.toSource() ?? 'dynamic';
      globalVariables.add(
        GlobalVariableInfo(
          name: name,
          type: returnType,
          isFinal: false,
          isConst: false,
          isGetter: true,
          sourceFile: currentSourceFile ?? '',
        ),
      );
      return;
    }

    // Skip setters (they don't make sense as standalone globals)
    if (node.isSetter) return;

    final returnType = node.returnType?.toSource() ?? 'dynamic';
    final params = node.functionExpression.parameters;
    final parameters =
        params != null ? _parseParameters(params) : <ParameterInfo>[];

    globalFunctions.add(
      GlobalFunctionInfo(
        name: name,
        returnType: returnType,
        parameters: parameters,
        sourceFile: currentSourceFile ?? '',
      ),
    );

    super.visitFunctionDeclaration(node);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    for (final variable in node.variables.variables) {
      final name = variable.name.lexeme;

      // Skip private variables
      if (skipPrivate && name.startsWith('_')) continue;

      final type = node.variables.type?.toSource() ?? 'dynamic';
      final isFinal = node.variables.isFinal;
      final isConst = node.variables.isConst;

      globalVariables.add(
        GlobalVariableInfo(
          name: name,
          type: type,
          isFinal: isFinal,
          isConst: isConst,
          sourceFile: currentSourceFile ?? '',
        ),
      );
    }

    super.visitTopLevelVariableDeclaration(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final className = node.name.lexeme;

    // Skip private classes if configured
    if (skipPrivate && className.startsWith('_')) return;

    final constructors = <ConstructorInfo>[];
    final members = <MemberInfo>[];

    // Extract superclass
    String? superclass;
    if (node.extendsClause != null) {
      superclass = node.extendsClause!.superclass.name.lexeme;
    }

    // Visit class members
    for (final member in node.members) {
      if (member is ConstructorDeclaration) {
        final ctorInfo = _parseConstructor(member);
        if (ctorInfo != null) constructors.add(ctorInfo);
      } else if (member is MethodDeclaration) {
        final methodInfo = _parseMethod(member);
        if (methodInfo != null) members.add(methodInfo);
      } else if (member is FieldDeclaration) {
        final fieldInfos = _parseField(member);
        members.addAll(fieldInfos);
      }
    }

    // Parse generic type parameters and their bounds
    final typeParams = <String, String?>{};
    if (node.typeParameters != null) {
      for (final typeParam in node.typeParameters!.typeParameters) {
        final paramName = typeParam.name.lexeme;
        final bound = typeParam.bound?.type?.element?.name;
        typeParams[paramName] = bound;
      }
    }

    classes.add(
      _ParsedClass(
        name: className,
        superclass: superclass,
        isAbstract: node.abstractKeyword != null,
        constructors: constructors,
        members: members,
        typeParameters: typeParams,
      ),
    );

    super.visitClassDeclaration(node);
  }

  /// Collects all import URIs from a type annotation, including generic type arguments.
  /// Returns a record with the set of URIs, a map from type name to URI, and whether
  /// the type is a function type alias.
  ({
    Set<String> uris,
    Map<String, String> typeToUri,
    bool isFunctionTypeAlias,
  }) _collectTypeInfo(TypeAnnotation? typeAnnotation) {
    final uris = <String>{};
    final typeToUri = <String, String>{};
    final functionTypeAliases = <String>{};
    if (typeAnnotation == null) {
      return (uris: uris, typeToUri: typeToUri, isFunctionTypeAlias: false);
    }

    _collectInfoFromDartType(
      typeAnnotation.type,
      uris,
      typeToUri,
      functionTypeAliases: functionTypeAliases,
    );

    // Check if the main type is a function type alias
    final typeName = typeAnnotation.type?.alias?.element.name;
    final isFunctionTypeAlias =
        typeName != null && functionTypeAliases.contains(typeName);

    return (
      uris: uris,
      typeToUri: typeToUri,
      isFunctionTypeAlias: isFunctionTypeAlias,
    );
  }

  /// Recursively collects URIs and type-to-URI mappings from a DartType.
  /// Also detects function types and type aliases that resolve to function types.
  void _collectInfoFromDartType(
    DartType? dartType,
    Set<String> uris,
    Map<String, String> typeToUri, {
    Set<String>? functionTypeAliases,
  }) {
    if (dartType == null) return;

    // Check for function types (including type aliases that resolve to function types)
    if (dartType is FunctionType) {
      // If this came from a type alias, track it
      final alias = dartType.alias;
      if (alias != null) {
        final aliasName = alias.element.name;
        if (aliasName != null) {
          functionTypeAliases?.add(aliasName);
          final library = alias.element.library;
          final uri = library.identifier;
          if (!uri.startsWith('dart:core')) {
            uris.add(uri);
            typeToUri[aliasName] = uri;
          }
        }
      }
      // Don't recurse into function type parameters/return - we'll use dynamic
      return;
    }

    if (dartType is InterfaceType) {
      final element = dartType.element;
      final library = element.library;
      final uri = library.identifier;

      // Don't add imports for dart:core types (String, int, bool, etc.)
      if (!uri.startsWith('dart:core')) {
        uris.add(uri);
        final name = element.name;
        if (name != null) {
          typeToUri[name] = uri;
        }
      }

      // Recursively collect from type arguments
      for (final typeArg in dartType.typeArguments) {
        _collectInfoFromDartType(
          typeArg,
          uris,
          typeToUri,
          functionTypeAliases: functionTypeAliases,
        );
      }
    }

    // Handle TypeParameterType (generic type parameters like T, E, K, V)
    if (dartType is TypeParameterType) {
      // These are handled by _isGenericTypeParameter - no import needed
      return;
    }
  }

  /// Parses a constructor declaration with resolved types.
  ConstructorInfo? _parseConstructor(ConstructorDeclaration node) {
    final name = node.name?.lexeme;
    if (skipPrivate && name != null && name.startsWith('_')) return null;

    final parameters = _parseParameters(node.parameters);

    return ConstructorInfo(
      name: name,
      parameters: parameters,
      isFactory: node.factoryKeyword != null,
      isConst: node.constKeyword != null,
    );
  }

  /// Parses a method declaration with resolved types.
  MemberInfo? _parseMethod(MethodDeclaration node) {
    final name = node.name.lexeme;

    if (skipPrivate && name.startsWith('_')) return null;

    // Skip methods with type parameters - D4rt can't handle generic methods
    if (node.typeParameters != null &&
        node.typeParameters!.typeParameters.isNotEmpty) {
      return null;
    }

    final returnType = node.returnType?.toSource() ?? 'dynamic';
    final typeInfo = _collectTypeInfo(node.returnType);
    final isStatic = node.isStatic;
    final isGetter = node.isGetter;
    final isSetter = node.isSetter;
    final isOperator = node.isOperator;

    List<ParameterInfo> parameters = [];
    if (node.parameters != null) {
      parameters = _parseParameters(node.parameters!);
    }

    return MemberInfo(
      name: name,
      returnType: returnType,
      returnTypeImportUris: typeInfo.uris,
      returnTypeToUri: typeInfo.typeToUri,
      isGetter: isGetter,
      isSetter: isSetter,
      isMethod: !isGetter && !isSetter && !isOperator,
      isStatic: isStatic,
      isOperator: isOperator,
      parameters: parameters,
    );
  }

  /// Parses a field declaration with resolved types.
  List<MemberInfo> _parseField(FieldDeclaration node) {
    final results = <MemberInfo>[];
    final isStatic = node.isStatic;
    final typeInfo = _collectTypeInfo(node.fields.type);

    for (final variable in node.fields.variables) {
      final name = variable.name.lexeme;

      if (skipPrivate && name.startsWith('_')) continue;

      final type = node.fields.type?.toSource() ?? 'dynamic';
      final isFinal = node.fields.isFinal;
      final isConst = node.fields.isConst;

      // Add getter
      results.add(
        MemberInfo(
          name: name,
          returnType: type,
          returnTypeImportUris: typeInfo.uris,
          returnTypeToUri: typeInfo.typeToUri,
          isGetter: true,
          isStatic: isStatic,
        ),
      );

      // Add setter if not final/const
      if (!isFinal && !isConst) {
        results.add(
          MemberInfo(
            name: name,
            returnType: type,
            returnTypeImportUris: typeInfo.uris,
            returnTypeToUri: typeInfo.typeToUri,
            isSetter: true,
            isStatic: isStatic,
          ),
        );
      }
    }

    return results;
  }

  /// Parses function parameters with resolved types.
  List<ParameterInfo> _parseParameters(FormalParameterList params) {
    final results = <ParameterInfo>[];

    for (final param in params.parameters) {
      String name;
      String type;
      Set<String> typeImportUris;
      Map<String, String> typeToUri;
      bool isRequired;
      bool isNamed;
      String? defaultValue;

      if (param is SimpleFormalParameter) {
        name = param.name?.lexeme ?? '';
        type = param.type?.toSource() ?? 'dynamic';
        final typeInfo = _collectTypeInfo(param.type);
        typeImportUris = typeInfo.uris;
        typeToUri = typeInfo.typeToUri;
        isRequired = param.isRequired;
        isNamed = param.isNamed;
      } else if (param is DefaultFormalParameter) {
        final innerParam = param.parameter;
        if (innerParam is SimpleFormalParameter) {
          name = innerParam.name?.lexeme ?? '';
          type = innerParam.type?.toSource() ?? 'dynamic';
          final typeInfo = _collectTypeInfo(innerParam.type);
          typeImportUris = typeInfo.uris;
          typeToUri = typeInfo.typeToUri;
        } else if (innerParam is FieldFormalParameter) {
          name = innerParam.name.lexeme;
          // For this.x syntax, get type from resolved element if no explicit type
          if (innerParam.type != null) {
            type = innerParam.type!.toSource();
            final typeInfo = _collectTypeInfo(innerParam.type);
            typeImportUris = typeInfo.uris;
            typeToUri = typeInfo.typeToUri;
          } else {
            final resolvedType = innerParam.declaredFragment?.element.type;
            if (resolvedType != null) {
              type = resolvedType.getDisplayString();
              typeImportUris = <String>{};
              typeToUri = <String, String>{};
              _collectInfoFromDartType(resolvedType, typeImportUris, typeToUri);
            } else {
              type = 'dynamic';
              typeImportUris = <String>{};
              typeToUri = <String, String>{};
            }
          }
        } else if (innerParam is SuperFormalParameter) {
          // Handle super.x syntax inside optional parameters
          name = innerParam.name.lexeme;
          if (innerParam.type != null) {
            type = innerParam.type!.toSource();
            final typeInfo = _collectTypeInfo(innerParam.type);
            typeImportUris = typeInfo.uris;
            typeToUri = typeInfo.typeToUri;
          } else {
            final resolvedType = innerParam.declaredFragment?.element.type;
            if (resolvedType != null) {
              type = resolvedType.getDisplayString();
              typeImportUris = <String>{};
              typeToUri = <String, String>{};
              _collectInfoFromDartType(resolvedType, typeImportUris, typeToUri);
            } else {
              type = 'dynamic';
              typeImportUris = <String>{};
              typeToUri = <String, String>{};
            }
          }
          // Get default from explicit override or from super constructor parameter
          final element = innerParam.declaredFragment?.element;
          if (element != null && element.defaultValueCode != null) {
            defaultValue = element.defaultValueCode;
          }
        } else {
          continue;
        }
        isRequired = param.isRequired;
        isNamed = param.isNamed;
        // Use explicit default if provided, otherwise keep the one from super
        if (param.defaultValue != null) {
          defaultValue = param.defaultValue!.toSource();
        }
      } else if (param is FieldFormalParameter) {
        name = param.name.lexeme;
        // For this.x syntax, get type from resolved element if no explicit type
        if (param.type != null) {
          type = param.type!.toSource();
          final typeInfo = _collectTypeInfo(param.type);
          typeImportUris = typeInfo.uris;
          typeToUri = typeInfo.typeToUri;
        } else {
          final resolvedType = param.declaredFragment?.element.type;
          if (resolvedType != null) {
            type = resolvedType.getDisplayString();
            typeImportUris = <String>{};
            typeToUri = <String, String>{};
            _collectInfoFromDartType(resolvedType, typeImportUris, typeToUri);
          } else {
            type = 'dynamic';
            typeImportUris = <String>{};
            typeToUri = <String, String>{};
          }
        }
        isRequired = param.isRequired;
        isNamed = param.isNamed;
      } else if (param is SuperFormalParameter) {
        // Handle super.x syntax for inherited parameters
        name = param.name.lexeme;
        if (param.type != null) {
          type = param.type!.toSource();
          final typeInfo = _collectTypeInfo(param.type);
          typeImportUris = typeInfo.uris;
          typeToUri = typeInfo.typeToUri;
        } else {
          final resolvedType = param.declaredFragment?.element.type;
          if (resolvedType != null) {
            type = resolvedType.getDisplayString();
            typeImportUris = <String>{};
            typeToUri = <String, String>{};
            _collectInfoFromDartType(resolvedType, typeImportUris, typeToUri);
          } else {
            type = 'dynamic';
            typeImportUris = <String>{};
            typeToUri = <String, String>{};
          }
        }
        isRequired = param.isRequired;
        isNamed = param.isNamed;
        // Get default value from super constructor parameter if available
        final element = param.declaredFragment?.element;
        if (element != null) {
          defaultValue = element.defaultValueCode;
        }
      } else {
        continue;
      }

      results.add(
        ParameterInfo(
          name: name,
          type: type,
          typeImportUris: typeImportUris,
          typeToUri: typeToUri,
          isRequired: isRequired,
          isNamed: isNamed,
          defaultValue: defaultValue,
        ),
      );
    }

    return results;
  }
}

// =============================================================================
// SYNTACTIC AST VISITOR (FALLBACK)
// =============================================================================

/// Temporary class info during parsing.
class _ParsedClass {
  String name;
  String? superclass;
  bool isAbstract;
  List<ConstructorInfo> constructors;
  List<MemberInfo> members;

  /// Maps generic type parameter names to their bounds (e.g., {'E': 'TomObject'}).
  Map<String, String?> typeParameters;

  _ParsedClass({
    required this.name,
    this.superclass,
    this.isAbstract = false,
    this.constructors = const [],
    this.members = const [],
    this.typeParameters = const {},
  });
}

/// AST visitor to extract class information (syntactic only, no type resolution).
class _ClassVisitor extends RecursiveAstVisitor<void> {
  final bool skipPrivate;
  final List<_ParsedClass> classes = [];

  _ClassVisitor({this.skipPrivate = true});

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final className = node.name.lexeme;

    // Skip private classes if configured
    if (skipPrivate && className.startsWith('_')) return;

    final constructors = <ConstructorInfo>[];
    final members = <MemberInfo>[];

    // Extract superclass
    String? superclass;
    if (node.extendsClause != null) {
      superclass = node.extendsClause!.superclass.name.lexeme;
    }

    // Visit class members
    for (final member in node.members) {
      if (member is ConstructorDeclaration) {
        final ctorInfo = _parseConstructor(member);
        if (ctorInfo != null) constructors.add(ctorInfo);
      } else if (member is MethodDeclaration) {
        final methodInfo = _parseMethod(member);
        if (methodInfo != null) members.add(methodInfo);
      } else if (member is FieldDeclaration) {
        final fieldInfos = _parseField(member);
        members.addAll(fieldInfos);
      }
    }

    // Parse generic type parameters and their bounds (syntactic only)
    final typeParams = <String, String?>{};
    if (node.typeParameters != null) {
      for (final typeParam in node.typeParameters!.typeParameters) {
        final paramName = typeParam.name.lexeme;
        // For syntactic parsing, get bound from token text
        final bound = typeParam.bound?.toSource().replaceFirst('extends ', '');
        typeParams[paramName] = bound;
      }
    }

    classes.add(
      _ParsedClass(
        name: className,
        superclass: superclass,
        isAbstract: node.abstractKeyword != null,
        constructors: constructors,
        members: members,
        typeParameters: typeParams,
      ),
    );

    super.visitClassDeclaration(node);
  }

  /// Parses a constructor declaration.
  ConstructorInfo? _parseConstructor(ConstructorDeclaration node) {
    // Skip private constructors
    final name = node.name?.lexeme;
    if (skipPrivate && name != null && name.startsWith('_')) return null;

    final parameters = _parseParameters(node.parameters);

    return ConstructorInfo(
      name: name,
      parameters: parameters,
      isFactory: node.factoryKeyword != null,
      isConst: node.constKeyword != null,
    );
  }

  /// Parses a method declaration.
  MemberInfo? _parseMethod(MethodDeclaration node) {
    final name = node.name.lexeme;

    // Skip private members
    if (skipPrivate && name.startsWith('_')) return null;

    // Skip methods with type parameters - D4rt can't handle generic methods
    if (node.typeParameters != null &&
        node.typeParameters!.typeParameters.isNotEmpty) {
      return null;
    }

    final returnType = node.returnType?.toSource() ?? 'dynamic';
    final isStatic = node.isStatic;
    final isGetter = node.isGetter;
    final isSetter = node.isSetter;
    final isOperator = node.isOperator;

    List<ParameterInfo> parameters = [];
    if (node.parameters != null) {
      parameters = _parseParameters(node.parameters!);
    }

    return MemberInfo(
      name: name,
      returnType: returnType,
      isGetter: isGetter,
      isSetter: isSetter,
      isMethod: !isGetter && !isSetter && !isOperator,
      isStatic: isStatic,
      isOperator: isOperator,
      parameters: parameters,
    );
  }

  /// Parses a field declaration.
  List<MemberInfo> _parseField(FieldDeclaration node) {
    final results = <MemberInfo>[];
    final isStatic = node.isStatic;

    for (final variable in node.fields.variables) {
      final name = variable.name.lexeme;

      // Skip private fields
      if (skipPrivate && name.startsWith('_')) continue;

      final type = node.fields.type?.toSource() ?? 'dynamic';
      final isFinal = node.fields.isFinal;
      final isConst = node.fields.isConst;

      // Add getter
      results.add(
        MemberInfo(
          name: name,
          returnType: type,
          isGetter: true,
          isStatic: isStatic,
        ),
      );

      // Add setter if not final/const
      if (!isFinal && !isConst) {
        results.add(
          MemberInfo(
            name: name,
            returnType: type,
            isSetter: true,
            isStatic: isStatic,
          ),
        );
      }
    }

    return results;
  }

  /// Parses function parameters.
  List<ParameterInfo> _parseParameters(FormalParameterList params) {
    final results = <ParameterInfo>[];

    for (final param in params.parameters) {
      String name;
      String type;
      bool isRequired;
      bool isNamed;
      String? defaultValue;

      if (param is SimpleFormalParameter) {
        name = param.name?.lexeme ?? '';
        type = param.type?.toSource() ?? 'dynamic';
        isRequired = param.isRequired;
        isNamed = param.isNamed;
      } else if (param is DefaultFormalParameter) {
        final innerParam = param.parameter;
        if (innerParam is SimpleFormalParameter) {
          name = innerParam.name?.lexeme ?? '';
          type = innerParam.type?.toSource() ?? 'dynamic';
        } else if (innerParam is FieldFormalParameter) {
          name = innerParam.name.lexeme;
          // For field formal parameters, type comes from field, use dynamic as fallback
          type = innerParam.type?.toSource() ?? 'dynamic';
        } else if (innerParam is SuperFormalParameter) {
          // Handle super.x syntax inside optional parameters
          name = innerParam.name.lexeme;
          type = innerParam.type?.toSource() ?? 'dynamic';
        } else {
          continue; // Skip complex parameters
        }
        isRequired = param.isRequired;
        isNamed = param.isNamed;
        defaultValue = param.defaultValue?.toSource();
      } else if (param is FieldFormalParameter) {
        name = param.name.lexeme;
        // For field formal parameters, type comes from field, use dynamic as fallback
        type = param.type?.toSource() ?? 'dynamic';
        isRequired = param.isRequired;
        isNamed = param.isNamed;
      } else if (param is SuperFormalParameter) {
        // Handle super.x syntax for inherited parameters
        name = param.name.lexeme;
        type = param.type?.toSource() ?? 'dynamic';
        isRequired = param.isRequired;
        isNamed = param.isNamed;
      } else {
        continue; // Skip unknown parameter types
      }

      results.add(
        ParameterInfo(
          name: name,
          type: type,
          isRequired: isRequired,
          isNamed: isNamed,
          defaultValue: defaultValue,
        ),
      );
    }

    return results;
  }
}
