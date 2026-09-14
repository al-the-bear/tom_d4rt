/// Test setup helper for tom_ast_generator generator tests.
///
/// This helper implements the astgen test pipeline:
/// 1. Generate bridges (via [generateBridges] API)
/// 2. Post-process: safety-net replace `package:tom_d4rt/` → `package:tom_d4rt_exec/`
/// 3. Compile the d4 binary
///
/// The d4 binary depends on `tom_d4rt_exec` which internally handles
/// source parsing via `AstConverter` (analyzer → SAstNode mirror AST).
///
/// Usage in tests:
/// ```dart
/// setUpAll(() async {
///   config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
///   tester = D4rtTester(projectPath: projectPath);
///   final ok = await AstgenTestSetup.prepareBridges(tester, config);
///   expect(ok, isTrue);
/// });
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt_generator/src/bridge_api.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

/// Helper class for preparing bridges in the tom_ast_generator context.
///
/// The key difference from ExecTestSetup: the d4 binary does NOT have
/// analyzer as a dependency. Instead, source parsing is delegated to
/// the ast_convert binary (compiled from tom_ast_generator/bin/ast_convert.dart).
class AstgenTestSetup {
  AstgenTestSetup._();

  /// Approximate start-time of the current test-suite VM.
  ///
  /// Cached lazily on first access. Used by [prepareBridges] to decide
  /// whether the `.d4.ready` sentinel produced by a sibling test process
  /// is younger than this process — i.e. "fresh enough to reuse".
  static final DateTime _suiteStartTime = DateTime.now();

  /// Prepare bridges for the d4 project: generate, post-process, compile d4.
  ///
  /// Returns `true` if all steps succeed, `false` otherwise.
  /// On failure, error details are printed to stderr.
  ///
  /// D4RT-TESTER-BUSY: `dart test` runs each test file in its own VM and
  /// may execute multiple suites in parallel. `prepareBridges` writes to
  /// `bin/<d4>` via `dart compile exe`, so two parallel callers race on
  /// the same output path and the late-comer fails with
  /// `ProcessException: Text file busy`.
  ///
  /// To eliminate the race we (a) serialize callers via an exclusive
  /// file lock on `bin/.d4-prepare.lock`, and (b) skip duplicated work
  /// when a sibling test process in the same `dart test` invocation
  /// already produced a fresh binary (detected via the `bin/.d4.ready`
  /// sentinel being newer than [_suiteStartTime]).
  static Future<bool> prepareBridges(
    D4rtTester tester,
    BridgeConfig config,
  ) async {
    final projectPath = tester.projectPath;
    final binDir = Directory(p.join(projectPath, 'bin'));
    await binDir.create(recursive: true);

    final lockFile = File(p.join(binDir.path, '.d4-prepare.lock'));
    final lockHandle = await lockFile.open(mode: FileMode.write);
    try {
      await lockHandle.lock(FileLock.blockingExclusive);
      return await _prepareBridgesLocked(tester, config);
    } finally {
      try {
        await lockHandle.unlock();
      } catch (_) {
        /* best effort */
      }
      await lockHandle.close();
    }
  }

  /// The body of [prepareBridges] that runs while the exclusive
  /// `bin/.d4-prepare.lock` is held.
  static Future<bool> _prepareBridgesLocked(
    D4rtTester tester,
    BridgeConfig config,
  ) async {
    final projectPath = tester.projectPath;
    final binaryPath = p.join(projectPath, 'bin', tester.compiledBinaryName);
    final binary = File(binaryPath);
    final sentinel = File(p.join(projectPath, 'bin', '.d4.ready'));

    // Reuse-if-fresh: a sibling test process in the same `dart test`
    // invocation may have already produced an up-to-date binary while we
    // were blocked on the lock. The sentinel's mtime > our suite-start
    // time means "produced after this VM started", i.e. by a sibling we
    // started racing against (not a stale leftover from a previous run).
    if (binary.existsSync() && sentinel.existsSync()) {
      try {
        final sentinelMtime = sentinel.lastModifiedSync();
        if (sentinelMtime.isAfter(_suiteStartTime)) {
          return true;
        }
      } catch (_) {
        /* fall through to full rebuild */
      }
    }

    // Step 1: Delete existing d4 binary (we hold the exclusive lock).
    if (binary.existsSync()) binary.deleteSync();

    // Step 2: Generate bridges
    final effectiveConfig = config.copyWith(
      generateTestRunner: true,
      testRunnerPath: 'bin/${tester.runnerExecutable}.dart',
    );
    final result = await generateBridges(
      config: effectiveConfig,
      projectPath: projectPath,
    );

    if (!result.isSuccess) {
      lastFailure =
          'bridge generation failed in $projectPath: ${result.errors}\n'
          'fixture resolved: ${resolvedInterpreterVersions(projectPath)}';
      stderr.writeln('BRIDGE GENERATION ERRORS: ${result.errors}');
      return false;
    }

    // Step 3: Post-process generated files — replace hardcoded tom_d4rt imports
    final bridgeDir = Directory(p.join(projectPath, 'lib'));
    await _postProcessDirectory(bridgeDir);

    final binDir = Directory(p.join(projectPath, 'bin'));
    await _postProcessDirectory(binDir);

    // Step 4: Compile the d4 binary
    final runnerPath = p.join('bin', '${tester.runnerExecutable}.dart');
    final compileResult = await Process.run('dart', [
      'compile',
      'exe',
      runnerPath,
      '-o',
      binaryPath,
    ], workingDirectory: projectPath);

    if (compileResult.exitCode != 0) {
      // SCD127: the resolved versions FIRST, because that is the line that
      // ends the investigation. A compile failure here is far more often a
      // frozen fixture lock than a defect in the generated code, and the
      // compiler's own output says nothing about which versions it was given.
      lastFailure =
          '`dart compile exe $runnerPath` failed in $projectPath\n'
                  'fixture resolved: ${resolvedInterpreterVersions(projectPath)}\n'
                  'If a tom_* version above is older than the working tree, the fixture '
                  'lock is frozen: run `dart pub upgrade` in $projectPath.\n'
                  '${compileResult.stderr}'
              .trim();
      stderr.writeln('D4 COMPILATION FAILED:');
      stderr.writeln(compileResult.stdout);
      stderr.writeln(compileResult.stderr);
      return false;
    }

    lastFailure = null;

    // Mark the compile as done for siblings still racing against us.
    try {
      sentinel.writeAsStringSync(DateTime.now().toIso8601String());
    } catch (_) {
      /* sentinel is an optimisation; skip on failure */
    }
    return true;
  }

  /// Why the last [prepareBridges] call returned false, or null if it did not.
  ///
  /// SCD127: the diagnosis has to travel with the BOOLEAN, because that is what
  /// the caller asserts on. `prepareBridges` already wrote the compiler's stderr,
  /// and the `expect` that consumed its result said only "Bridge generation
  /// failed for dart_overview" — so the one fact that explained everything, the
  /// fixture's resolved versions, never reached the reader. It cost twenty
  /// minutes of bisection to recover and is one line of data.
  static String? lastFailure;

  /// The `tom_*` packages [projectPath]'s lock resolved, as one line.
  ///
  /// The FIXTURE's lock, not this package's. `example/d4` is its own package
  /// with its own gitignored lock while it path-resolves `tom_d4rt_exec` from
  /// the working tree, so it can freeze at a version that no longer compiles
  /// against HEAD — which is exactly what happened at tom_d4rt_ast 0.19.0,
  /// whose exports lacked `ConvertStdlib`, `CollectionStdlib`,
  /// `TypedDataStdlib` and `Logger`.
  ///
  /// Best-effort by design: this runs on a path that has already failed, so a
  /// missing or unparseable lock must degrade to a note rather than throw and
  /// replace the real diagnosis with its own.
  static String resolvedInterpreterVersions(String projectPath) {
    final lock = File(p.join(projectPath, 'pubspec.lock'));
    if (!lock.existsSync()) {
      return 'no pubspec.lock in $projectPath — the fixture was never resolved';
    }
    try {
      final entry = RegExp(
        r'^  (tom_\w+):\n(?:.*\n)*?    source: (\S+)\n    version: "([^"]+)"',
        multiLine: true,
      );
      final found = [
        for (final m in entry.allMatches(lock.readAsStringSync()))
          '${m.group(1)} ${m.group(3)} (${m.group(2)})',
      ];
      if (found.isEmpty) return 'no tom_* packages in ${lock.path}';
      return found.join(', ');
    } catch (e) {
      return 'could not read ${lock.path}: $e';
    }
  }

  /// Recursively post-process all `.b.dart` files in a directory.
  static Future<void> _postProcessDirectory(Directory dir) async {
    if (!dir.existsSync()) return;

    await for (final entity in dir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.b.dart')) {
        await _postProcessFile(entity);
      }
    }
  }

  /// Replace `package:tom_d4rt/` imports with `package:tom_d4rt_exec/` in a file.
  static Future<void> _postProcessFile(File file) async {
    var content = await file.readAsString();
    final updated = content.replaceAll(
      "package:tom_d4rt/",
      "package:tom_d4rt_exec/",
    );
    if (updated != content) {
      await file.writeAsString(updated);
    }
  }
}
