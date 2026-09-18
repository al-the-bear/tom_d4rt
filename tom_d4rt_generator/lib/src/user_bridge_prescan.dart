/// Pre-scan of a project's hand-written `d4rt_user_bridges/` directory.
///
/// Both generation entry points — the `bridge_api.dart` pipeline and the v2
/// `d4rtgen_executor.dart` — must register user-bridge overrides *before*
/// modules are processed, otherwise the scanner only ever sees units from
/// the generated source files and every override is invisible.
///
/// That requirement used to be written out twice, ~60 identical lines each.
/// GEN-123 was a bug in one half of a rule duplicated five times; this
/// extraction exists so the user-bridge half cannot drift the same way.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart'
    show AnalysisContextCollectionImpl;
import 'package:path/path.dart' as p;

import 'analysis_paths.dart' show analysisIncludedPath;
import 'sdk_utils.dart' show getSdkPath;
import 'user_bridge_scanner.dart';
import 'user_proxy_relaxer_scanner.dart';

/// Resolves every `.dart` file under [projectDir]'s user-bridge directories
/// and returns a scanner carrying the overrides found.
///
/// User bridge files must live in one of:
/// - `lib/src/d4rt_user_bridges/` (package projects), or
/// - `lib/d4rt_user_bridges/` (console projects).
///
/// [projectDir] may be relative — `d4rtgen -s .` passes one — and is
/// absolutised before anything is derived from it. Every path that reaches
/// the analyzer must be absolute and normalized: that holds for
/// `includedPaths`, and equally for `contextFor` and `getResolvedLibrary`.
/// Deriving the scan directories from the absolutised root makes the
/// collected file paths absolute by construction rather than by remembering
/// to convert them at three later call sites.
///
/// [summaryPaths] / [sdkSummaryPath] forward the shared summary bundles so
/// that `D4UserBridge` and the overridden target types resolve against the
/// same `.sum` cache the downstream generator uses.
Future<UserBridgeScanner> preScanUserBridges(
  String projectDir, {
  List<String>? summaryPaths,
  String? sdkSummaryPath,
  bool verbose = false,
}) async {
  final scanner = UserBridgeScanner();
  final normalizedProjectDir = analysisIncludedPath(projectDir);

  final userBridgeDirs = [
    p.join(normalizedProjectDir, 'lib', 'src', 'd4rt_user_bridges'),
    p.join(normalizedProjectDir, 'lib', 'd4rt_user_bridges'),
  ];

  // Collect the files first; an analyzer context is only worth building if
  // there is something to resolve.
  final dartFiles = <String>[];
  for (final dirPath in userBridgeDirs) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;
    if (verbose) {
      print('  Scanning user bridges in $dirPath');
    }
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File) continue;
      if (!entity.path.endsWith('.dart')) continue;
      dartFiles.add(entity.path);
    }
  }

  if (dartFiles.isNotEmpty) {
    final hasSummaries =
        (summaryPaths != null && summaryPaths.isNotEmpty) ||
        sdkSummaryPath != null;
    final AnalysisContextCollection collection = hasSummaries
        ? AnalysisContextCollectionImpl(
            includedPaths: [normalizedProjectDir],
            sdkPath: sdkSummaryPath == null ? getSdkPath() : null,
            sdkSummaryPath: sdkSummaryPath,
            librarySummaryPaths: summaryPaths ?? const [],
          )
        : AnalysisContextCollection(
            includedPaths: [normalizedProjectDir],
            sdkPath: getSdkPath(),
          );

    for (final filePath in dartFiles) {
      try {
        final context = collection.contextFor(filePath);
        final result = await context.currentSession.getResolvedLibrary(
          filePath,
        );
        if (result is ResolvedLibraryResult) {
          scanner.scanLibrary(result.element, filePath);
        } else {
          // Never verbose-gate this. A user-bridge file that exists on disk
          // but does not resolve yields bridges silently missing every
          // override in it — strictly worse than failing outright.
          stderr.writeln(
            'Warning: Failed to resolve user bridge $filePath '
            '(analyzer result: ${result.runtimeType})',
          );
        }
      } catch (e) {
        stderr.writeln('Warning: Failed to resolve user bridge $filePath: $e');
      }
    }
  }

  final classCount = scanner.userBridges.length;
  final globalsCount = scanner.globalsUserBridges.length;
  if (classCount > 0 || globalsCount > 0) {
    print(
      '  USER-BRIDGE: pre-scanned $classCount class user bridges and '
      '$globalsCount globals user bridges from $normalizedProjectDir',
    );
  } else if (dartFiles.isNotEmpty) {
    // Files were present but yielded nothing. Under `> 0`-only reporting this
    // was indistinguishable from a project with no user bridges at all, which
    // is how a relative scan root silently dropped all four overrides in
    // d4rt_userbridges_sample without printing a single line.
    stderr.writeln(
      'Warning: ${dartFiles.length} user-bridge file(s) found under '
      '$normalizedProjectDir but no user bridges were registered',
    );
  }

  return scanner;
}

/// Resolves every `.dart` file under [projectDir]'s user proxy / relaxer
/// directive directories and returns a scanner carrying the directives found.
///
/// sce47: `UserProxyRelaxerScanner` was fully implemented and unit-tested but
/// constructed NOWHERE under `lib/`, so `@D4rtUserProxy` / `@D4rtUserRelaxer`
/// had no effect on any generated output — two discovery designs existed in
/// the tree, one wired and undocumented (the `user_relaxers/` file
/// convention), one documented by its own annotations and unwired. This is
/// the folder pre-scan the module's header names as the missing wiring.
///
/// Directive files must live in one of:
/// - `lib/src/d4rt_user_proxies/` or `lib/d4rt_user_proxies/`
/// - `lib/src/d4rt_user_relaxers/` or `lib/d4rt_user_relaxers/`
///
/// The directories mirror `d4rt_user_bridges/` deliberately: an author who has
/// learned one convention has learned all three, and a scan of the whole
/// package would resolve every library in it on every run.
Future<UserProxyRelaxerScanner> preScanUserVariantDirectives(
  String projectDir, {
  List<String>? summaryPaths,
  String? sdkSummaryPath,
  bool verbose = false,
  void Function(String)? onWarning,
}) async {
  final scanner = UserProxyRelaxerScanner(onWarning: onWarning);
  final normalizedProjectDir = analysisIncludedPath(projectDir);

  final directiveDirs = [
    for (final leaf in ['d4rt_user_proxies', 'd4rt_user_relaxers']) ...[
      p.join(normalizedProjectDir, 'lib', 'src', leaf),
      p.join(normalizedProjectDir, 'lib', leaf),
    ],
  ];

  final dartFiles = <String>[];
  for (final dirPath in directiveDirs) {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) continue;
    if (verbose) {
      print('  Scanning user proxy/relaxer directives in $dirPath');
    }
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is! File) continue;
      if (!entity.path.endsWith('.dart')) continue;
      dartFiles.add(entity.path);
    }
  }

  if (dartFiles.isEmpty) return scanner;

  final hasSummaries =
      (summaryPaths != null && summaryPaths.isNotEmpty) ||
      sdkSummaryPath != null;
  final AnalysisContextCollection collection = hasSummaries
      ? AnalysisContextCollectionImpl(
          includedPaths: [normalizedProjectDir],
          sdkPath: sdkSummaryPath == null ? getSdkPath() : null,
          sdkSummaryPath: sdkSummaryPath,
          librarySummaryPaths: summaryPaths ?? const [],
        )
      : AnalysisContextCollection(
          includedPaths: [normalizedProjectDir],
          sdkPath: getSdkPath(),
        );

  for (final filePath in dartFiles) {
    try {
      final context = collection.contextFor(filePath);
      final result = await context.currentSession.getResolvedLibrary(filePath);
      if (result is ResolvedLibraryResult) {
        scanner.scanLibrary(result.element, filePath);
      } else {
        // Never verbose-gate this, for the reason the user-bridge scan gives:
        // a directive file that exists but does not resolve yields output
        // silently missing everything it declared, which is strictly worse
        // than failing outright.
        stderr.writeln(
          'Warning: Failed to resolve user proxy/relaxer directive $filePath '
          '(analyzer result: ${result.runtimeType})',
        );
      }
    } catch (e) {
      stderr.writeln(
        'Warning: Failed to resolve user proxy/relaxer directive $filePath: $e',
      );
    }
  }

  final proxies = scanner.proxyDirectives.length;
  final relaxers = scanner.relaxerDirectives.length;
  if (proxies > 0 || relaxers > 0) {
    print(
      '  USER-VARIANT: pre-scanned $proxies proxy and $relaxers relaxer '
      'directive(s) from $normalizedProjectDir',
    );
  } else {
    stderr.writeln(
      'Warning: ${dartFiles.length} user proxy/relaxer directive file(s) '
      'found under $normalizedProjectDir but no directives were registered',
    );
  }

  return scanner;
}
