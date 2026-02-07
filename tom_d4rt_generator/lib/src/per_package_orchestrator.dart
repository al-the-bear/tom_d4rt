/// Per-package bridge generation for build.yaml scope deduplication.
///
/// This module provides orchestration logic for generating per-package
/// bridge files and delegating barrel files, eliminating duplicate code
/// when the same package is re-exported by multiple barrels.
library;

import 'dart:io' as io;

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'bridge_generator.dart';
import 'file_generators.dart' show ensureBDartExtension;
import 'file_writer.dart';
import 'user_bridge_scanner.dart';

/// Information about a source package and its elements.
class PackageInfo {
  /// The package name (e.g., 'tom_basics').
  final String packageName;

  /// Source file paths belonging to this package.
  final Set<String> sourceFiles;

  /// Export info for filtering elements.
  final Map<String, ExportInfo> exportInfo;

  /// Map of source file -> barrel file URI that exports it.
  /// Multiple source files may be exported by different barrel files.
  final Map<String, String> sourceFileToBarrel;
  
  /// Whether to generate bridging code for deprecated elements.
  /// If any contributing module has this enabled, it will be true.
  bool generateDeprecatedElements;

  PackageInfo({
    required this.packageName,
    required this.sourceFiles,
    required this.exportInfo,
    Map<String, String>? sourceFileToBarrel,
    this.generateDeprecatedElements = false,
  }) : sourceFileToBarrel = sourceFileToBarrel ?? {};
  
  /// Returns all unique barrel file URIs that export classes in this package.
  Set<String> get barrelFiles => sourceFileToBarrel.values.toSet();
}

/// Information about which packages a barrel needs.
class BarrelPackageMapping {
  /// The module name (e.g., 'tom_core_server').
  final String moduleName;

  /// The barrel import path.
  final String barrelImport;

  /// The output path for the barrel bridge file.
  final String outputPath;

  /// Package names this barrel needs bridges for.
  final Set<String> requiredPackages;

  BarrelPackageMapping({
    required this.moduleName,
    required this.barrelImport,
    required this.outputPath,
    required this.requiredPackages,
  });
}

/// Orchestrates per-package bridge generation.
///
/// This orchestrator implements a two-phase generation approach:
/// 1. Scan user bridge files from the build package's d4rt_user_bridges folder
/// 2. Collect all source files from all modules and group by source package
/// 3. Generate per-package bridge files containing deduplicated bridge code
/// 4. Generate delegating barrel files that import and combine per-package files
///
/// This eliminates duplicate code when the same package is re-exported
/// by multiple barrel files within a single build.yaml scope.
class PerPackageBridgeOrchestrator {
  final BridgeConfig config;
  final String projectRoot;
  final FileWriter fileWriter;
  final String buildPackageName;

  /// Optional callback for emitting warnings.
  void Function(String)? onWarning;

  /// Map of package name -> source files for that package.
  final Map<String, PackageInfo> _packageInfoMap = {};

  /// Map of module name -> packages it needs.
  final Map<String, BarrelPackageMapping> _barrelMappings = {};

  /// Shared user bridge scanner populated from build package's user bridge files.
  final UserBridgeScanner _userBridgeScanner = UserBridgeScanner();

  /// Aggregated exclusions from all modules.
  /// These are applied globally when generating per-package bridges.
  final Set<String> _globalExcludeClasses = {};
  final Set<String> _globalExcludeFunctions = {};
  final Set<String> _globalExcludeVariables = {};
  final Set<String> _globalExcludeSourcePatterns = {};
  
  /// Global class lookup for cross-package inheritance resolution.
  /// Built by [buildGlobalClassLookup] before generating bridges.
  /// Key is class name, value is ClassInfo.
  final Map<String, ClassInfo> _globalClassLookup = {};
  
  /// Counter for deprecated elements skipped during generation.
  int skippedDeprecatedCount = 0;

  PerPackageBridgeOrchestrator({
    required this.config,
    required this.projectRoot,
    required this.fileWriter,
    required this.buildPackageName,
    this.onWarning,
  }) {
    // Set up warning callback for user bridge scanner
    _userBridgeScanner.onWarning = (msg) {
      onWarning?.call('Warning: $msg');
    };
  }

  /// Returns the user bridge scanner for access by generators.
  UserBridgeScanner get userBridgeScanner => _userBridgeScanner;

  /// Scans user bridge files from the build package's d4rt_user_bridges folder.
  ///
  /// User bridge files should be placed in:
  /// - `lib/src/d4rt_user_bridges/` for package projects
  /// - `lib/d4rt_user_bridges/` for console projects
  ///
  /// Classes extending D4UserBridge must have @D4rtUserBridge or
  /// @D4rtGlobalsUserBridge annotation, otherwise a warning is emitted.
  Future<void> scanUserBridges() async {
    // Try lib/src/d4rt_user_bridges first, then lib/d4rt_user_bridges
    final userBridgeDirs = [
      p.join(projectRoot, 'lib', 'src', 'd4rt_user_bridges'),
      p.join(projectRoot, 'lib', 'd4rt_user_bridges'),
    ];

    for (final dirPath in userBridgeDirs) {
      final dir = io.Directory(dirPath);
      if (!dir.existsSync()) continue;

      onWarning?.call('Scanning user bridges in $dirPath');

      await for (final entity in dir.list(recursive: true)) {
        if (entity is! io.File) continue;
        if (!entity.path.endsWith('.dart')) continue;

        try {
          final content = await entity.readAsString();
          final parseResult = parseString(
            content: content,
            featureSet: FeatureSet.latestLanguageVersion(),
          );
          _userBridgeScanner.scanUnit(parseResult.unit, entity.path);
        } catch (e) {
          onWarning?.call('Warning: Failed to parse user bridge ${entity.path}: $e');
        }
      }
    }

    // Report what was found
    final classCount = _userBridgeScanner.userBridges.length;
    final globalsCount = _userBridgeScanner.globalsUserBridges.length;
    if (classCount > 0 || globalsCount > 0) {
      onWarning?.call(
        'Found $classCount class user bridges and $globalsCount globals user bridges',
      );
    }
  }

  /// Collects source files from all modules and groups them by source package.
  /// Also collects all exclusions from all modules to apply globally.
  Future<void> collectPackageInfo() async {
    for (final module in config.modules) {
      // Collect exclusions from all modules
      _globalExcludeClasses.addAll(module.excludeClasses);
      _globalExcludeFunctions.addAll(module.excludeFunctions);
      _globalExcludeVariables.addAll(module.excludeVariables);
      _globalExcludeSourcePatterns.addAll(module.excludeSourcePatterns);

      final sourceImport = module.barrelImport ?? module.barrelFiles.first;

      final generator = BridgeGenerator(
        workspacePath: projectRoot,
        packageName: config.name,
        sourceImport: sourceImport,
        helpersImport: config.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
      );

      // Resolve barrel files and track which one is which
      final resolvedBarrels = <String, String>{}; // resolved path -> original URI
      for (final f in module.barrelFiles) {
        if (f.startsWith('package:')) {
          final resolved = await generator.resolvePackageUri(f);
          if (resolved != null) resolvedBarrels[resolved] = f;
        } else {
          final resolved = p.join(projectRoot, f);
          resolvedBarrels[resolved] = f;
        }
      }

      // Parse exports from each barrel file separately to track origin
      final allExports = <String, ExportInfo>{};
      final sourceFileToBarrel = <String, String>{}; // source file -> barrel URI
      
      for (final entry in resolvedBarrels.entries) {
        final resolvedPath = entry.key;
        final barrelUri = entry.value;
        
        final exports = await generator.parseExportFiles(
          [resolvedPath],
          followAllReExports: module.followAllReExports,
          skipReExports: module.skipReExports,
          followReExports: module.followReExports,
        );
        
        for (final sourceFile in exports.keys) {
          // Track which barrel exports this source file
          // Prefer barrels from the same package as the source file
          final sourcePackage = _extractPackageName(sourceFile);
          final barrelPackage = _extractPackageNameFromUri(barrelUri);
          final existingBarrel = sourceFileToBarrel[sourceFile];
          
          if (existingBarrel == null) {
            // Not yet tracked - use this barrel
            sourceFileToBarrel[sourceFile] = barrelUri;
          } else if (sourcePackage != null && barrelPackage == sourcePackage) {
            // This barrel is from the same package as the source file - prefer it
            final existingBarrelPackage = _extractPackageNameFromUri(existingBarrel);
            if (existingBarrelPackage != sourcePackage) {
              // Existing barrel is from a different package - override with same-package barrel
              sourceFileToBarrel[sourceFile] = barrelUri;
            }
          }
          allExports[sourceFile] = exports[sourceFile]!;
        }
      }

      // Group source files by package
      final requiredPackages = <String>{};
      for (final sourceFile in allExports.keys) {
        final pkgName = _extractPackageName(sourceFile);
        if (pkgName == null) continue;

        requiredPackages.add(pkgName);

        _packageInfoMap.putIfAbsent(
          pkgName,
          () => PackageInfo(
            packageName: pkgName,
            sourceFiles: {},
            exportInfo: {},
          ),
        );

        _packageInfoMap[pkgName]!.sourceFiles.add(sourceFile);
        _packageInfoMap[pkgName]!.exportInfo[sourceFile] = allExports[sourceFile]!;
        
        // If any module enables deprecated generation, enable it for the package
        if (module.generateDeprecatedElements) {
          _packageInfoMap[pkgName]!.generateDeprecatedElements = true;
        }
        
        // Track which barrel this source file came from
        // Prefer barrels from the same package as the source file (not re-exporting packages)
        if (sourceFileToBarrel.containsKey(sourceFile)) {
          final barrelUri = sourceFileToBarrel[sourceFile]!;
          final existingBarrel = _packageInfoMap[pkgName]!.sourceFileToBarrel[sourceFile];
          
          // Only set if not already tracked, or if this barrel is from the same package
          if (existingBarrel == null) {
            _packageInfoMap[pkgName]!.sourceFileToBarrel[sourceFile] = barrelUri;
          } else if (barrelUri.startsWith('package:$pkgName/') && 
                     !existingBarrel.startsWith('package:$pkgName/')) {
            // Prefer barrel from same package over re-exporting package
            _packageInfoMap[pkgName]!.sourceFileToBarrel[sourceFile] = barrelUri;
          }
        }
      }

      // Record which packages this barrel needs
      _barrelMappings[module.name] = BarrelPackageMapping(
        moduleName: module.name,
        barrelImport: sourceImport,
        outputPath: ensureBDartExtension(module.outputPath),
        requiredPackages: requiredPackages,
      );
    }
  }

  /// Builds the global class lookup for cross-package inheritance resolution.
  /// 
  /// This parses all source files from all packages and builds a map of
  /// class name -> ClassInfo. This allows inheritance resolution across
  /// packages (e.g., TomException extends TomBaseException from tom_basics).
  /// 
  /// Call this after [collectPackageInfo] and before [generatePerPackageFiles].
  Future<void> buildGlobalClassLookup() async {
    _globalClassLookup.clear();
    
    for (final entry in _packageInfoMap.entries) {
      final pkgName = entry.key;
      final pkgInfo = entry.value;
      
      // Get barrel files for this package
      final barrelFiles = pkgInfo.barrelFiles;
      final ownPackageBarrels = barrelFiles
          .where((b) => b.startsWith('package:$pkgName/'))
          .toList();
      
      final sourceImports = ownPackageBarrels.isNotEmpty
          ? ownPackageBarrels
          : ['package:$pkgName/$pkgName.dart'];

      final generator = BridgeGenerator(
        workspacePath: projectRoot,
        packageName: config.name,
        sourceImports: sourceImports,
        sourceFileToBarrel: pkgInfo.sourceFileToBarrel,
        helpersImport: config.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
        userBridgeScanner: _userBridgeScanner,
      );
      
      // Parse all classes from this package's source files
      for (final sourceFile in pkgInfo.sourceFiles) {
        try {
          final classes = await generator.parseFile(sourceFile);
          for (final cls in classes) {
            // Add to global lookup (later packages may override earlier ones)
            _globalClassLookup[cls.name] = cls;
          }
        } catch (e) {
          onWarning?.call('Warning: Failed to parse $sourceFile for class lookup: $e');
        }
      }
    }
    
    onWarning?.call('Built global class lookup with ${_globalClassLookup.length} classes');
  }

  /// Generates per-package bridge files.
  ///
  /// Returns a map of package name -> generated file path.
  Future<Map<String, String>> generatePerPackageFiles() async {
    final libraryPath = config.libraryPath;
    if (libraryPath == null) {
      throw StateError('libraryPath must be set for per-package generation');
    }

    final generatedFiles = <String, String>{};

    for (final entry in _packageInfoMap.entries) {
      final pkgName = entry.key;
      final pkgInfo = entry.value;

      // Generate file name: package_tom_basics_bridges.b.dart
      final fileName = 'package_${pkgName.replaceAll('-', '_')}_bridges.b.dart';
      final outputPath = p.join(libraryPath, fileName);

      // Get all unique barrel files for this package
      // Filter to only include barrels from the same package, or if none,
      // use the package's own barrel as fallback
      final barrelFiles = pkgInfo.barrelFiles;
      final ownPackageBarrels = barrelFiles
          .where((b) => b.startsWith('package:$pkgName/'))
          .toList();
      
      final sourceImports = ownPackageBarrels.isNotEmpty
          ? ownPackageBarrels
          : ['package:$pkgName/$pkgName.dart'];

      final generator = BridgeGenerator(
        workspacePath: projectRoot,
        packageName: config.name,
        sourceImports: sourceImports,
        sourceFileToBarrel: pkgInfo.sourceFileToBarrel,
        helpersImport: config.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
        userBridgeScanner: _userBridgeScanner,
      );
      
      // Set per-package option for deprecated element generation
      generator.generateDeprecatedElements = pkgInfo.generateDeprecatedElements;
      
      // Pass global class lookup for cross-package inheritance resolution
      generator.externalClassLookup = Map.of(_globalClassLookup);

      // Generate bridges for this package's source files
      // Apply global exclusions collected from all modules
      final result = await generator.generateBridgesWithWriter(
        sourceFiles: pkgInfo.sourceFiles.toList(),
        outputFileId: FileId(buildPackageName, outputPath),
        moduleName: 'package_$pkgName',
        exportInfo: pkgInfo.exportInfo,
        fileWriter: fileWriter,
        excludeClasses: _globalExcludeClasses.toList(),
        excludeFunctions: _globalExcludeFunctions.toList(),
        excludeVariables: _globalExcludeVariables.toList(),
        excludeSourcePatterns: _globalExcludeSourcePatterns.toList(),
      );
      
      // Accumulate skipped deprecated count
      skippedDeprecatedCount += generator.skippedDeprecatedCount;

      // Only include packages that have actual content
      final hasContent = result.classesGenerated > 0 ||
          result.globalFunctionsGenerated > 0 ||
          result.globalVariablesGenerated > 0;
      if (hasContent) {
        generatedFiles[pkgName] = outputPath;
      }
    }
    
    // Report skipped deprecated elements if any
    if (skippedDeprecatedCount > 0) {
      onWarning?.call(
        'Generation of bridging code for deprecated elements is not enabled. '
        '$skippedDeprecatedCount element${skippedDeprecatedCount == 1 ? '' : 's'} skipped.',
      );
    }

    return generatedFiles;
  }

  /// Generates delegating barrel files.
  Future<void> generateDelegatingBarrelFiles(
    Map<String, String> packageFiles,
  ) async {
    for (final mapping in _barrelMappings.values) {
      final content = _generateDelegatingBarrelContent(mapping, packageFiles);
      await fileWriter.writeFile(
        FileId(buildPackageName, mapping.outputPath),
        content,
      );
    }
  }

  /// Generates content for a delegating barrel file.
  String _generateDelegatingBarrelContent(
    BarrelPackageMapping mapping,
    Map<String, String> packageFiles,
  ) {
    final buffer = StringBuffer();
    final capitalizedModuleName = _toPascalCase(mapping.moduleName);

    buffer.writeln('// D4rt Bridge - Generated file, do not edit');
    buffer.writeln('// Delegating barrel for ${mapping.moduleName}');
    buffer.writeln('// Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln();
    buffer.writeln('// ignore_for_file: unused_import, deprecated_member_use');
    buffer.writeln();
    buffer.writeln("import 'package:tom_d4rt/d4rt.dart';");
    buffer.writeln("import 'package:tom_d4rt/tom_d4rt.dart';");
    buffer.writeln();

    // Import per-package files
    final sortedPackages = mapping.requiredPackages.toList()..sort();
    for (final pkgName in sortedPackages) {
      final pkgFile = packageFiles[pkgName];
      if (pkgFile != null) {
        // Calculate relative import from outputPath to pkgFile
        final relPath = _relativeImportPath(mapping.outputPath, pkgFile);
        final alias = 'pkg_${pkgName.replaceAll('-', '_')}';
        buffer.writeln("import '$relPath' as $alias;");
      }
    }

    buffer.writeln();
    buffer.writeln('/// Bridge class for ${mapping.moduleName} module.');
    buffer.writeln('class ${capitalizedModuleName}Bridge {');

    // bridgeClasses()
    buffer.writeln('  /// Returns all bridge class definitions.');
    buffer.writeln('  static List<BridgedClass> bridgeClasses() {');
    buffer.writeln('    return [');
    for (final pkgName in sortedPackages) {
      if (packageFiles.containsKey(pkgName)) {
        final alias = 'pkg_${pkgName.replaceAll('-', '_')}';
        final pkgClassName = 'Package${_toPascalCase(pkgName)}Bridge';
        buffer.writeln('      ...$alias.$pkgClassName.bridgeClasses(),');
      }
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // classSourceUris()
    buffer.writeln('  /// Returns a map of class names to their canonical source URIs.');
    buffer.writeln('  ///');
    buffer.writeln('  /// Used for deduplication when the same class is exported through');
    buffer.writeln('  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).');
    buffer.writeln('  static Map<String, String> classSourceUris() {');
    buffer.writeln('    return {');
    for (final pkgName in sortedPackages) {
      if (packageFiles.containsKey(pkgName)) {
        final alias = 'pkg_${pkgName.replaceAll('-', '_')}';
        final pkgClassName = 'Package${_toPascalCase(pkgName)}Bridge';
        buffer.writeln('      ...$alias.$pkgClassName.classSourceUris(),');
      }
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // bridgedEnums()
    buffer.writeln('  /// Returns all bridged enum definitions.');
    buffer.writeln('  static List<BridgedEnumDefinition> bridgedEnums() {');
    buffer.writeln('    return [');
    for (final pkgName in sortedPackages) {
      if (packageFiles.containsKey(pkgName)) {
        final alias = 'pkg_${pkgName.replaceAll('-', '_')}';
        final pkgClassName = 'Package${_toPascalCase(pkgName)}Bridge';
        buffer.writeln('      ...$alias.$pkgClassName.bridgedEnums(),');
      }
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // globalFunctions()
    buffer.writeln('  /// Returns all global functions.');
    buffer.writeln('  static Map<String, NativeFunctionImpl> globalFunctions() {');
    buffer.writeln('    return {');
    for (final pkgName in sortedPackages) {
      if (packageFiles.containsKey(pkgName)) {
        final alias = 'pkg_${pkgName.replaceAll('-', '_')}';
        final pkgClassName = 'Package${_toPascalCase(pkgName)}Bridge';
        buffer.writeln('      ...$alias.$pkgClassName.globalFunctions(),');
      }
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // registerBridges()
    buffer.writeln(
      '  /// Register all bridges with the interpreter.',
    );
    buffer.writeln(
      '  static void registerBridges(D4rt interpreter, String importPath) {',
    );
    for (final pkgName in sortedPackages) {
      if (packageFiles.containsKey(pkgName)) {
        final alias = 'pkg_${pkgName.replaceAll('-', '_')}';
        final pkgClassName = 'Package${_toPascalCase(pkgName)}Bridge';
        buffer.writeln(
          '    $alias.$pkgClassName.registerBridges(interpreter, importPath);',
        );
      }
    }
    buffer.writeln('  }');
    buffer.writeln();

    // getImportBlock()
    buffer.writeln('  /// Returns the import block for scripts.');
    buffer.writeln('  static String getImportBlock() {');
    buffer.writeln("    return \"import '${mapping.barrelImport}';\\n\";");
    buffer.writeln('  }');

    buffer.writeln('}');

    return buffer.toString();
  }

  /// Extracts package name from a source file path.
  String? _extractPackageName(String sourceFile) {
    final libIndex = sourceFile.indexOf('/lib/');
    if (libIndex == -1) return null;

    // Look for pubspec.yaml to get accurate package name
    final packageDir = sourceFile.substring(0, libIndex);
    final pubspecPath = '$packageDir/pubspec.yaml';

    try {
      // Try reading pubspec.yaml
      final file = io.File(pubspecPath);
      if (file.existsSync()) {
        final content = file.readAsStringSync();
        final nameMatch =
            RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(content);
        if (nameMatch != null) {
          return nameMatch.group(1);
        }
      }
    } catch (_) {
      // Fall back to directory name
    }

    // Fall back to directory name
    return p.basename(packageDir);
  }
  
  /// Extracts package name from a package URI (e.g., 'package:dcli_core/dcli_core.dart' -> 'dcli_core').
  String? _extractPackageNameFromUri(String uri) {
    if (!uri.startsWith('package:')) return null;
    final match = RegExp(r'^package:([^/]+)/').firstMatch(uri);
    return match?.group(1);
  }

  /// Calculates relative import path from one file to another.
  String _relativeImportPath(String from, String to) {
    // Both paths should be lib/ relative
    final fromDir = p.dirname(from);
    final toFile = to;

    // Strip lib/ prefix for calculation
    final fromDirClean =
        fromDir.startsWith('lib/') ? fromDir.substring(4) : fromDir;
    final toFileClean =
        toFile.startsWith('lib/') ? toFile.substring(4) : toFile;

    // Calculate relative path
    return p.relative(toFileClean, from: fromDirClean);
  }

  /// Converts a snake_case or kebab-case string to PascalCase.
  String _toPascalCase(String input) {
    return input
        .split(RegExp(r'[_-]'))
        .map((part) => part.isEmpty
            ? ''
            : part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join();
  }
}
