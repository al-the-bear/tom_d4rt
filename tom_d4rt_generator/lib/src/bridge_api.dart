/// Public API for D4rt Bridge Generation
///
/// Provides a simple API for programmatic bridge generation.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_build_base/tom_build_base.dart' show PubCacheIntegrity;
import 'package:tom_analyzer_shared/tom_analyzer_shared.dart'
    show runSummaryCacheStage;

import 'bridge_config.dart';
import 'bridge_generator.dart';
import 'build_config_loader.dart';
import 'd4rtgen_logging.dart';
import 'file_generators.dart';
import 'proxy_generator.dart';
import 'relaxer_generator.dart';
import 'user_bridge_prescan.dart' show preScanUserBridges;

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

  /// Non-fatal notes about the configuration this run used.
  ///
  /// Carried on the result as well as printed, so a test can assert on them
  /// without capturing stdout.
  final List<String> warnings;

  const GenerationResult({
    required this.totalClasses,
    required this.totalModules,
    required this.outputFiles,
    required this.config,
    this.errors = const [],
    this.warnings = const [],
  });

  /// Whether generation was successful (no errors).
  bool get isSuccess => errors.isEmpty;
}

/// Options a `d4rtgen:` block may set that ONLY the build_runner builder reads.
///
/// The builder (`lib/builder.dart`, via `PerPackageBridgeOrchestrator`) is a
/// third generation pipeline beside the CLI and this API, and it takes its
/// configuration from the same `d4rtgen:` block. An option it alone consults is
/// therefore accepted and silently ignored everywhere else — which reads as
/// "configured" to anyone looking at the file.
///
/// Maps the option name to what reads it, so the warning can say why.
const builderOnlyOptions = <String, String>{
  'libraryPath':
      'the per-package output directory, read only by '
      'PerPackageBridgeOrchestrator when build_runner drives generation',
};

/// Warnings for options [config] sets that this pipeline does not read.
///
/// Empty for every configuration in the workspace today: the check is here so
/// that setting one of these and believing it took effect stops being silent.
List<String> builderOnlyOptionWarnings(BridgeConfig config) {
  final set = <String, Object?>{
    if (config.libraryPath != null) 'libraryPath': config.libraryPath,
  };
  return [
    for (final entry in set.entries)
      "'${entry.key}' is set to '${entry.value}', but it has no effect here: "
          '${builderOnlyOptions[entry.key]}. Remove it, or run generation '
          'through build_runner.',
  ];
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
  bool verbose = false,
  bool runPubGet = true,
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
  // in barrel files. Run `dart pub get` if missing, when the caller allows it.
  //
  // [runPubGet] is what lets the `d4rtgen` CLI share this pipeline: a dry run
  // must not spawn a subprocess that writes to the package it is only
  // inspecting, and `checkBridgeFreshness` refuses an unresolved package for
  // the same reason rather than resolving it behind the caller's back.
  final packageConfig = File(
    p.join(projectDir, '.dart_tool', 'package_config.json'),
  );
  if (runPubGet && !packageConfig.existsSync()) {
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
        warnings: builderOnlyOptionWarnings(bridgeConfig),
      );
    }
  }

  // sce38: every path below opens an analysis context over this package's
  // resolved dependencies. A locked package the cache cannot supply produces
  // no resolution error — `dart pub get` reports success, because the lock is
  // satisfiable — and the analyzer then reports `Undefined name` at each use
  // site, which reads as an upstream rename. The generator swallows the
  // resulting link failures and silently drops the affected classes, so the
  // visible symptom is a bridge file missing types rather than anything
  // naming the cache.
  //
  // Checked after the resolve above, so a package this call just resolved is
  // measured in its resolved state.
  final cacheReport = PubCacheIntegrity.preflight(projectPath: projectDir);
  if (cacheReport != null) {
    return GenerationResult(
      totalClasses: 0,
      totalModules: 0,
      outputFiles: [],
      config: bridgeConfig,
      errors: [cacheReport],
      warnings: builderOnlyOptionWarnings(bridgeConfig),
    );
  }

  // Options only the build_runner builder reads. Always reported, not gated on
  // `verbose`: the whole defect is that setting one looks like configuring
  // something, and a warning nobody sees by default would not fix that.
  final warnings = builderOnlyOptionWarnings(bridgeConfig);
  for (final warning in warnings) {
    print('  Warning: $warning');
  }

  if (verbose) {
    print('  Project: ${bridgeConfig.name}');
    print('  Modules: ${bridgeConfig.modules.length}');
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
  // Phase 2 (summary-refactoring-plan): bridge generation now routes
  // every package through its `.sum` summary bundle via the element
  // walker (ElementModeExtractor). No filter-exclusion pass — every
  // dependency (including bridged packages) resolves from summaries.
  // Phase 6: the legacy AST walker (`_ResolvedClassVisitor`) and the
  // `useLegacyAstWalker` debug flag have been removed; element-mode
  // extraction is now the only code path.
  List<String>? summaryPaths;
  String? sdkSummaryPath;
  try {
    final cacheResult = await runSummaryCacheStage(projectDir);
    summaryPaths = cacheResult?.summaryPaths;
    sdkSummaryPath = cacheResult?.sdkSummaryPath;
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
    final sharedUserBridgeScanner = await preScanUserBridges(
      projectDir,
      summaryPaths: summaryPaths,
      sdkSummaryPath: sdkSummaryPath,
    );

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

    // Phase 4 / summary-refactoring-plan: hold a reference to the last
    // generator created so the proxy stage can reuse its already-loaded
    // analysis context (summary bundles) instead of constructing a second
    // [AnalysisContextCollectionImpl] over the same workspace.
    BridgeGenerator? lastGenerator;

    // Generate bridges for each module
    for (final module in bridgeConfig.modules) {
      if (verbose) {
        print('  Generating module: ${module.name}');
      }
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
        verbose: verbose,
        librarySummaryPaths: summaryPaths,
        sdkSummaryPath: sdkSummaryPath,
        // DGU3: forward the configurable type-mapping escape hatch and any
        // paired custom imports so buildkit.yaml can resolve awkward types
        // without patching the generator.
        typeMappings: bridgeConfig.typeMappings,
        additionalImports: bridgeConfig.additionalImports,
      );
      lastGenerator = generator;

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
        excludeConstructors: module.excludeConstructors,
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
      await _generateBarrelFile(barrelPath, bridgeConfig, verbose: verbose);
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
        verbose: verbose,
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
        verbose: verbose,
        testRunnerPath,
        bridgeConfig,
        packageName: effectivePackageName,
      );
      outputFiles.add(testRunnerPath);
    }

    // Generate proxy classes if requested (GEN-083)
    if (bridgeConfig.generateProxies && bridgeConfig.proxyClasses.isNotEmpty) {
      // Phase 4 / summary-refactoring-plan: reuse the analysis context
      // already built by the bridge-generation loop. When no modules were
      // processed (e.g., a proxy-only run), `lastGenerator` is null and
      // `generateProxies` will build its own summary-backed context from
      // [summaryPaths] / [sdkSummaryPath] as before.
      final proxyResult = await generateProxies(
        config: bridgeConfig,
        projectPath: projectDir,
        librarySummaryPaths: summaryPaths,
        sdkSummaryPath: sdkSummaryPath,
        analysisContext: lastGenerator?.getOrCreateAnalysisContext(),
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
    warnings: warnings,
  );
}

/// Generate barrel file that exports all bridge modules.
Future<void> _generateBarrelFile(
  String barrelPath,
  BridgeConfig config, {
  bool verbose = false,
}) async {
  if (verbose) print('  Generating barrel: $barrelPath');
  await File(barrelPath).writeAsString(generateBarrelFileContent(config));
}

/// Generate dartscript file with combined bridge registration.
Future<void> _generateDartscriptFile(
  String dartscriptPath,
  BridgeConfig config, {
  required String packageName,
  bool verbose = false,
}) async {
  if (verbose) print('  Generating dartscript: $dartscriptPath');
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
  bool verbose = false,
}) async {
  if (verbose) print('  Generating test runner: $testRunnerPath');
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
