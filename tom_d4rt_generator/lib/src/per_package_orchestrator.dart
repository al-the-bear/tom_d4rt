/// Per-package bridge generation for build.yaml scope deduplication.
///
/// This module provides orchestration logic for generating per-package
/// bridge files and delegating barrel files, eliminating duplicate code
/// when the same package is re-exported by multiple barrels.
library;

import 'dart:io' as io;

import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'bridge_generator.dart';
import 'file_writer.dart';

/// Information about a source package and its elements.
class PackageInfo {
  /// The package name (e.g., 'tom_basics').
  final String packageName;

  /// Source file paths belonging to this package.
  final Set<String> sourceFiles;

  /// Export info for filtering elements.
  final Map<String, ExportInfo> exportInfo;

  PackageInfo({
    required this.packageName,
    required this.sourceFiles,
    required this.exportInfo,
  });
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
/// 1. Collect all source files from all modules and group by source package
/// 2. Generate per-package bridge files containing deduplicated bridge code
/// 3. Generate delegating barrel files that import and combine per-package files
///
/// This eliminates duplicate code when the same package is re-exported
/// by multiple barrel files within a single build.yaml scope.
class PerPackageBridgeOrchestrator {
  final BridgeConfig config;
  final String projectRoot;
  final FileWriter fileWriter;
  final String buildPackageName;

  /// Map of package name -> source files for that package.
  final Map<String, PackageInfo> _packageInfoMap = {};

  /// Map of module name -> packages it needs.
  final Map<String, BarrelPackageMapping> _barrelMappings = {};

  PerPackageBridgeOrchestrator({
    required this.config,
    required this.projectRoot,
    required this.fileWriter,
    required this.buildPackageName,
  });

  /// Collects source files from all modules and groups them by source package.
  Future<void> collectPackageInfo() async {
    for (final module in config.modules) {
      final sourceImport = module.barrelImport ?? module.barrelFiles.first;

      final generator = BridgeGenerator(
        workspacePath: projectRoot,
        packageName: config.name,
        sourceImport: sourceImport,
        helpersImport: config.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
      );

      // Resolve barrel files
      final barrelFiles = <String>[];
      for (final f in module.barrelFiles) {
        if (f.startsWith('package:')) {
          final resolved = await generator.resolvePackageUri(f);
          if (resolved != null) barrelFiles.add(resolved);
        } else {
          barrelFiles.add(p.join(projectRoot, f));
        }
      }

      // Parse exports to get source files
      final exports = await generator.parseExportFiles(
        barrelFiles,
        followAllReExports: module.followAllReExports,
        skipReExports: module.skipReExports,
        followReExports: module.followReExports,
      );

      // Group source files by package
      final requiredPackages = <String>{};
      for (final sourceFile in exports.keys) {
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
        _packageInfoMap[pkgName]!.exportInfo[sourceFile] = exports[sourceFile]!;
      }

      // Record which packages this barrel needs
      _barrelMappings[module.name] = BarrelPackageMapping(
        moduleName: module.name,
        barrelImport: sourceImport,
        outputPath: module.outputPath,
        requiredPackages: requiredPackages,
      );
    }
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

      // Generate file name: package_tom_basics_bridges.dart
      final fileName = 'package_${pkgName.replaceAll('-', '_')}_bridges.dart';
      final outputPath = p.join(libraryPath, fileName);

      final generator = BridgeGenerator(
        workspacePath: projectRoot,
        packageName: config.name,
        sourceImport: 'package:$pkgName/$pkgName.dart',
        helpersImport: config.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
      );

      // Generate bridges for this package's source files
      final result = await generator.generateBridgesWithWriter(
        sourceFiles: pkgInfo.sourceFiles.toList(),
        outputFileId: FileId(buildPackageName, outputPath),
        moduleName: 'package_$pkgName',
        exportInfo: pkgInfo.exportInfo,
        fileWriter: fileWriter,
      );

      // Only include packages that have actual content
      final hasContent = result.classesGenerated > 0 ||
          result.globalFunctionsGenerated > 0 ||
          result.globalVariablesGenerated > 0;
      if (hasContent) {
        generatedFiles[pkgName] = outputPath;
      }
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
    buffer.writeln('// ignore_for_file: unused_import');
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
