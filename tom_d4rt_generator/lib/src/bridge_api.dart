/// Public API for D4rt Bridge Generation
///
/// Provides a simple API for programmatic bridge generation.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:path/path.dart' as p;
import 'package:tom_analyzer_shared/tom_analyzer_shared.dart'
    show runSummaryCacheStage;

import 'bridge_config.dart';
import 'bridge_generator.dart';
import 'build_config_loader.dart';
import 'd4rtgen_logging.dart';
import 'file_generators.dart';
import 'proxy_generator.dart';
import 'relaxer_generator.dart';
import 'summary_exclusion.dart' show filterSummariesForBridgedPackages;
import 'user_bridge_scanner.dart';

/// Result of a bridge generation operation.
class GenerationResult {
  /// Total number of classes generated across all modules.
  final int totalClasses;

  /// Total number of modules processed.
  final int totalModules;

  /// List of output files generated.
  final List<String> outputFiles;

  /// Configuration used for generation.
  final BridgeConfig config;

  /// Any errors encountered.
  final List<String> errors;

  const GenerationResult({
    required this.totalClasses,
    required this.totalModules,
    required this.outputFiles,
    required this.config,
    this.errors = const [],
  });

  /// Whether generation was successful (no errors).
  bool get isSuccess => errors.isEmpty;
}

/// Generate D4rt bridges for a project.
///
/// Generates bridges from a [BridgeConfig] or from a buildkit.yaml file path.
///
/// Either [config] or [configPath] must be provided.
///
/// When using [config], specify [projectPath] to set the project root directory
/// for resolving relative paths in the config. Defaults to [Directory.current].
///
/// Example using config object:
/// ```dart
/// final config = BridgeConfig.fromJson({...});
/// final result = await generateBridges(
///   config: config,
///   projectPath: '/path/to/project',
/// );
/// ```
///
/// Example using config file:
/// ```dart
/// final result = await generateBridges(
///   configPath: '/path/to/project/buildkit.yaml',
/// );
/// ```
Future<GenerationResult> generateBridges({
  BridgeConfig? config,
  String? configPath,
  String? projectPath,
}) async {
  if (config == null && configPath == null) {
    throw ArgumentError('Either config or configPath must be provided');
  }

  if (config != null && configPath != null) {
    throw ArgumentError('Only one of config or configPath should be provided');
  }

  // Resolve project directory: explicit projectPath > configPath parent > cwd
  final projectDir =
      projectPath ??
      (configPath != null ? p.dirname(configPath) : Directory.current.path);
  final bridgeConfig =
      config ?? BuildConfigLoader.loadFromTomBuildYaml(projectDir);
  if (bridgeConfig == null) {
    throw ArgumentError('No d4rtgen configuration found in $projectDir');
  }

  // Ensure package_config.json exists — required for resolving package: URIs
  // in barrel files. Run `dart pub get` if missing.
  final packageConfig = File(
    p.join(projectDir, '.dart_tool', 'package_config.json'),
  );
  if (!packageConfig.existsSync()) {
    final pubGetResult = await Process.run('dart', [
      'pub',
      'get',
    ], workingDirectory: projectDir);
    if (pubGetResult.exitCode != 0) {
      return GenerationResult(
        totalClasses: 0,
        totalModules: 0,
        outputFiles: [],
        config: bridgeConfig,
        errors: ['dart pub get failed in $projectDir: ${pubGetResult.stderr}'],
      );
    }
  }

  // Log invocation at project level (once per generateBridges call)
  logD4rtgenInvocation(
    source: 'API',
    details:
        'project: ${bridgeConfig.name}, modules: ${bridgeConfig.modules.length}, projectDir: $projectDir',
    includeStackTrace: true,
  );

  // Summary-cache stage (shared with tom_reflection_generator via
  // <workspace>/.tom/analyzer-cache/). Generates or loads `.sum`
  // bundles for hosted/SDK dependencies so BridgeGenerator and the
  // proxy generator can skip re-scanning those packages from sources.
  // Failures here are non-fatal — we simply fall back to the classic
  // source-based analyzer context.
  //
  // Bridge generation needs full AST (default-parameter expressions,
  // annotation arguments, doc comments, token-level positions). `.sum`
  // bundles only contain the element model — no AST — so we filter
  // out summaries whose package is itself being bridged AND whose
  // packages get followed via `export` directives from the barrels
  // (e.g. flutter/foundation re-exports package:meta/meta.dart). Every
  // other dependency (dart:core/ui via SDK summary, vector_math only
  // as a type dependency, etc.) still resolves from summaries, which
  // is where the real parse-time savings live.
  List<String>? summaryPaths;
  String? sdkSummaryPath;
  try {
    final cacheResult = await runSummaryCacheStage(projectDir);
    // EXPERIMENTAL: bypass filter so bridged packages route through
    // summaries (element-mode extraction). Toggle via env var.
    final useSummariesForBridged =
        Platform.environment['TOM_D4RT_BRIDGE_USE_SUMMARIES'] == '1';
    if (useSummariesForBridged) {
      summaryPaths = cacheResult?.summaryPaths;
      sdkSummaryPath = cacheResult?.sdkSummaryPath;
      print(
        '  SUMMARY-FILTER: BYPASSED (TOM_D4RT_BRIDGE_USE_SUMMARIES=1) \u2014 '
        'all packages read from summaries where available',
      );
    } else {
      final filtered = await filterSummariesForBridgedPackages(
        projectDir: projectDir,
        summaryPaths: cacheResult?.summaryPaths,
        sdkSummaryPath: cacheResult?.sdkSummaryPath,
        bridgeConfig: bridgeConfig,
      );
      summaryPaths = filtered.summaryPaths;
      sdkSummaryPath = filtered.sdkSummaryPath;
    }
  } catch (e) {
    // Never fail bridge generation because of the cache. Report and move on.
    print('  Warning: summary-cache stage failed: $e');
  }

  var totalClasses = 0;
  final outputFiles = <String>[];
  final errors = <String>[];
  final effectivePackageName =
      BuildConfigLoader.getPackageName(projectDir) ?? bridgeConfig.name;

  try {
    // GEN-083b: Pre-scan user bridges from the build project's
    // d4rt_user_bridges directory so method/getter/setter/operator
    // overrides are registered before any module's BridgeGenerator
    // starts emitting code. Mirrors what v2/d4rtgen_executor does —
    // this path (generateBridges) previously only populated the
    // scanner from Flutter source files, which meant user bridges
    // living in the build project were invisible.
    final sharedUserBridgeScanner = _preScanUserBridges(projectDir);

    // GEN-076: Track class names and source files across modules to prevent
    // duplicate registrations. Only deduplicates when BOTH name AND source match,
    // so different classes with the same name (e.g., dart:ui vs Flutter) are kept.
    final globallyGeneratedClasses = <String, String>{};

    // GEN-079: Collect class lookup across modules for relaxer generation.
    final globalClassLookup = <String, ClassInfo>{};

    // GEN-079: Collect generic extraction sites and GEN-075 classes
    // across all modules for relaxer generation.
    final allExtractionSites = <GenericExtractionSite>[];
    final allGen075Classes = <String>{};

    // Generate bridges for each module
    for (final module in bridgeConfig.modules) {
      // Determine sourceImport: use barrelImport if provided, otherwise first barrel file
      final sourceImport = module.barrelImport ?? module.barrelFiles.first;

      // Build list of barrel imports for getImportBlock() generation.
      // The barrel imports are used by D4rt scripts (not by the bridge code itself,
      // which imports directly from source files).
      final sourceImports = module.barrelFiles
          .where((f) => f.startsWith('package:'))
          .toList();

      final generator = BridgeGenerator(
        workspacePath: projectDir,
        packageName: bridgeConfig.name,
        sourceImport: sourceImport,
        sourceImports: sourceImports,
        helpersImport:
            bridgeConfig.helpersImport ?? 'package:tom_d4rt/tom_d4rt.dart',
        d4rtImport: bridgeConfig.d4rtImport ?? 'package:tom_d4rt/d4rt.dart',
        recursiveBoundTypes: bridgeConfig.recursiveBoundTypes.isNotEmpty
            ? bridgeConfig.recursiveBoundTypes
                  .map(RecursiveBoundType.fromString)
                  .toList()
            : null, // Use defaults if not configured
        userBridgeScanner: sharedUserBridgeScanner,
        librarySummaryPaths: summaryPaths,
        sdkSummaryPath: sdkSummaryPath,
      );

      // Resolve barrel files - if they're package: or dart: URIs, pass as-is; otherwise join with projectDir
      final barrelFiles = module.barrelFiles.map((f) {
        if (f.startsWith('package:') || f.startsWith('dart:')) {
          return f; // Package or dart URI - generator will resolve it
        }
        return p.join(projectDir, f);
      }).toList();

      final normalizedOutputPath = ensureBDartExtension(module.outputPath);
      final result = await generator.generateBridgesFromExports(
        barrelFiles: barrelFiles,
        outputPath: p.join(projectDir, normalizedOutputPath),
        moduleName: module.name,
        excludePatterns: module.excludePatterns,
        excludeClasses: module.excludeClasses,
        excludeEnums: module.excludeEnums,
        excludeFunctions: module.excludeFunctions,
        excludeVariables: module.excludeVariables,
        excludeSourcePatterns: module.excludeSourcePatterns,
        // GEN-080: Forward re-export filtering params from config (matching executor)
        followAllReExports: module.followAllReExports,
        skipReExports: module.skipReExports.isNotEmpty
            ? module.skipReExports
            : null,
        followReExports: module.followReExports.isNotEmpty
            ? module.followReExports
            : null,
        importShowClause: module.importShowClause,
        importHideClause: module.importHideClause,
        // GEN-076: Pass already-generated class sources for cross-module dedup
        skipClassSources: globallyGeneratedClasses.isNotEmpty
            ? globallyGeneratedClasses
            : null,
      );

      totalClasses += result.classesGenerated;
      outputFiles.add(p.join(projectDir, normalizedOutputPath));
      errors.addAll(result.errors);
      // GEN-076: Accumulate generated class sources for next module
      globallyGeneratedClasses.addAll(result.generatedClassSources);
      // GEN-079: Accumulate class lookup for relaxer generation
      globalClassLookup.addAll(generator.classLookup);
      // GEN-079: Accumulate generic extraction sites and GEN-075 classes
      allExtractionSites.addAll(generator.genericExtractionSites);
      allGen075Classes.addAll(generator.gen075Classes);
      // DEBUG: Temporary logging for GEN-076
      print(
        '  GEN-076: Module ${module.name} generated ${result.generatedClassSources.length} classes, '
        'global total: ${globallyGeneratedClasses.length}',
      );
    }

    // Generate barrel file if requested
    if (bridgeConfig.generateBarrel && bridgeConfig.barrelPath != null) {
      final barrelPath = p.join(
        projectDir,
        ensureBDartExtension(bridgeConfig.barrelPath!),
      );
      await _generateBarrelFile(barrelPath, bridgeConfig);
      outputFiles.add(barrelPath);
    }

    // Generate dartscript file if requested
    if (bridgeConfig.generateDartscript &&
        bridgeConfig.dartscriptPath != null) {
      final dartscriptPath = p.join(
        projectDir,
        ensureBDartExtension(bridgeConfig.dartscriptPath!),
      );
      await _generateDartscriptFile(
        dartscriptPath,
        bridgeConfig,
        packageName: effectivePackageName,
      );
      outputFiles.add(dartscriptPath);
    }

    // Generate test runner file if requested
    if (bridgeConfig.generateTestRunner &&
        bridgeConfig.testRunnerPath != null) {
      final testRunnerPath = p.join(
        projectDir,
        ensureBDartExtension(bridgeConfig.testRunnerPath!),
      );
      await _generateTestRunnerFile(
        testRunnerPath,
        bridgeConfig,
        packageName: effectivePackageName,
      );
      outputFiles.add(testRunnerPath);
    }

    // Generate proxy classes if requested (GEN-083)
    if (bridgeConfig.generateProxies && bridgeConfig.proxyClasses.isNotEmpty) {
      final proxyResult = await generateProxies(
        config: bridgeConfig,
        projectPath: projectDir,
        librarySummaryPaths: summaryPaths,
        sdkSummaryPath: sdkSummaryPath,
      );
      if (proxyResult.outputFile != null) {
        outputFiles.add(proxyResult.outputFile!);
      }
      errors.addAll(proxyResult.errors);
      if (proxyResult.proxies.isNotEmpty) {
        print(
          '  GEN-083: Generated ${proxyResult.proxies.length} proxy classes'
          ' → ${proxyResult.outputFile}',
        );
      }
    }

    // Generate relaxer wrappers (GEN-079) — always runs, output path
    // auto-derived from first module when not explicitly configured.
    {
      final relaxerResult = await generateRelaxers(
        config: bridgeConfig,
        projectPath: projectDir,
        globalClassLookup: globalClassLookup,
        genericExtractionSites: allExtractionSites,
        gen075Classes: allGen075Classes,
      );
      if (relaxerResult.outputFile != null) {
        outputFiles.add(relaxerResult.outputFile!);
      }
      errors.addAll(relaxerResult.errors);
      if (relaxerResult.wrapperClassesGenerated > 0) {
        print(
          '  GEN-079: Generated ${relaxerResult.wrapperClassesGenerated} relaxer wrappers'
          ' (${relaxerResult.factoryFunctionsGenerated} factories)'
          ' → ${relaxerResult.outputFile}',
        );
      }
      for (final warning in relaxerResult.warnings) {
        print('  GEN-079 WARNING: $warning');
      }
    }
  } catch (e) {
    errors.add(e.toString());
  }

  return GenerationResult(
    totalClasses: totalClasses,
    totalModules: bridgeConfig.modules.length,
    outputFiles: outputFiles,
    config: bridgeConfig,
    errors: errors,
  );
}

/// Generate barrel file that exports all bridge modules.
Future<void> _generateBarrelFile(String barrelPath, BridgeConfig config) async {
  await File(barrelPath).writeAsString(generateBarrelFileContent(config));
}

/// Generate dartscript file with combined bridge registration.
Future<void> _generateDartscriptFile(
  String dartscriptPath,
  BridgeConfig config, {
  required String packageName,
}) async {
  final normalizedDartscriptPath = config.dartscriptPath != null
      ? ensureBDartExtension(config.dartscriptPath!)
      : null;
  await File(dartscriptPath).writeAsString(
    generateDartscriptFileContent(
      config,
      dartscriptPath: normalizedDartscriptPath,
      packageName: packageName,
    ),
  );
}

/// Generate test runner file for testing bridges.
Future<void> _generateTestRunnerFile(
  String testRunnerPath,
  BridgeConfig config, {
  required String packageName,
}) async {
  final dir = File(testRunnerPath).parent;
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  final normalizedTestRunnerPath = config.testRunnerPath != null
      ? ensureBDartExtension(config.testRunnerPath!)
      : null;
  await File(testRunnerPath).writeAsString(
    generateTestRunnerContent(
      config,
      testRunnerPath: normalizedTestRunnerPath,
      packageName: packageName,
    ),
  );
}

/// GEN-083b: Pre-scan user bridge files from the build project's
/// `d4rt_user_bridges/` directory so class overrides (methods, setters,
/// getters, operators, constructors) are registered before modules
/// are processed.
///
/// User bridge files must live in:
/// - `lib/src/d4rt_user_bridges/` (package projects), or
/// - `lib/d4rt_user_bridges/` (console projects).
///
/// Without this pre-scan the scanner only sees units from Flutter source
/// files, so user bridges living in the build package are invisible —
/// see the `v2/d4rtgen_executor.dart` path for the equivalent logic.
UserBridgeScanner _preScanUserBridges(String projectDir) {
  final scanner = UserBridgeScanner();

  final userBridgeDirs = [
    p.join(projectDir, 'lib', 'src', 'd4rt_user_bridges'),
    p.join(projectDir, 'lib', 'd4rt_user_bridges'),
  ];

  for (final dirPath in userBridgeDirs) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;

    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File) continue;
      if (!entity.path.endsWith('.dart')) continue;

      try {
        final content = entity.readAsStringSync();
        final parseResult = parseString(
          content: content,
          featureSet: FeatureSet.latestLanguageVersion(),
        );
        scanner.scanUnit(parseResult.unit, entity.path);
      } catch (e) {
        stderr.writeln(
          'Warning: Failed to parse user bridge ${entity.path}: $e',
        );
      }
    }
  }

  final classCount = scanner.userBridges.length;
  final globalsCount = scanner.globalsUserBridges.length;
  if (classCount > 0 || globalsCount > 0) {
    print(
      '  USER-BRIDGE: pre-scanned $classCount class user bridges and '
      '$globalsCount globals user bridges from $projectDir',
    );
  }

  return scanner;
}

// Summary-exclusion helpers live in `summary_exclusion.dart` so both
// `bridge_api.dart` and `v2/d4rtgen_executor.dart` share the same
// filtering rules.
