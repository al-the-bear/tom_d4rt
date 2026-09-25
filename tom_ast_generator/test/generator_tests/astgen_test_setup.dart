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
  /// whether the `.d4.ready` sentinel produced by a sibling suite is younger
  /// than this suite — i.e. "fresh enough to reuse".
  ///
  /// SCE190: [prepareBridges] reads it on ENTRY, before waiting for the lock.
  /// A lazy `static final` is initialised at first read, and the first read
  /// used to sit inside the locked body — which never mattered while the lock
  /// excluded nothing. Once it did, the waiting suite stamped its "start" AFTER
  /// the holder had written the sentinel, judged the fresh binary stale, and
  /// deleted and recompiled `bin/d4` while the holder's scripts were running
  /// it: exit -9, or `dartaotruntime` refusing a half-written executable.
  static final DateTime _suiteStartTime = DateTime.now();

  /// Prepare bridges for the d4 project: generate, post-process, compile d4.
  ///
  /// Returns `true` if all steps succeed, `false` otherwise.
  /// On failure, error details are printed to stderr.
  ///
  /// D4RT-TESTER-BUSY: `dart test` may execute several suites at once, and
  /// `prepareBridges` rewrites the shared bridge tree and writes `bin/<d4>`
  /// via `dart compile exe`, so two parallel callers race on the same output
  /// and the late-comer fails with `ProcessException: Text file busy` — or,
  /// worse, compiles a half-rewritten bridge file.
  ///
  /// To eliminate the race we (a) serialize callers on the lock file
  /// `.dart_tool/astgen_prepare_bridges.lock`, and (b) skip duplicated work when a sibling
  /// suite in the same `dart test` invocation already produced a fresh binary
  /// (detected via the `bin/.d4.ready` sentinel being newer than
  /// [_suiteStartTime]).
  ///
  /// SCE190: the lock is an `O_EXCL` create, not `RandomAccessFile.lock`.
  /// This comment used to say `dart test` runs each file "in its own VM"; it
  /// runs them as ISOLATES of one process, and a POSIX record lock belongs to
  /// the process, so both suites acquired `FileLock.blockingExclusive` at the
  /// same moment. Measured 2026-09-25: two probe suites printed the same pid
  /// and held the "exclusive" lock simultaneously for three seconds. The lock
  /// had never excluded anything within one run.
  static Future<bool> prepareBridges(D4rtTester tester, BridgeConfig config) {
    final startedAt = _suiteStartTime;
    return exclusive(
      // A new path on purpose: the fcntl version created
      // `bin/.d4-prepare.lock` and never deleted it, so a leftover would read
      // as a held lock for up to [staleLockAfter] on any host that ran the
      // old helper. Under `.dart_tool/`, which is gitignored, a lock a
      // crashed run leaves behind never shows up as a stray file.
      p.join(tester.projectPath, '.dart_tool', 'astgen_prepare_bridges.lock'),
      () => _prepareBridgesLocked(tester, config, startedAt),
    );
  }

  /// A lock held only while it has anything to hold, older than which it is
  /// taken to belong to a holder that died without releasing it.
  static const Duration staleLockAfter = Duration(minutes: 10);

  /// Run [body] while holding the lock file at [lockPath] — an exclusive
  /// create, polled, released in `finally`. Kept textually in step with
  /// `ExecTestSetup.exclusive` and the generator's `withFixtureLock`, which
  /// this package cannot import until the generator carrying it is published.
  static Future<T> exclusive<T>(
    String lockPath,
    Future<T> Function() body, {
    Duration poll = const Duration(milliseconds: 200),
  }) async {
    final lock = File(lockPath);
    lock.parent.createSync(recursive: true);
    while (true) {
      try {
        lock.createSync(exclusive: true);
        break;
      } on FileSystemException {
        try {
          final age = DateTime.now().difference(lock.lastModifiedSync());
          if (age > staleLockAfter) {
            lock.deleteSync();
            continue;
          }
        } on FileSystemException {
          // Released between the create and the stat: try again at once.
          continue;
        }
        await Future<void>.delayed(poll);
      }
    }
    try {
      return await body();
    } finally {
      if (lock.existsSync()) lock.deleteSync();
    }
  }

  /// The body of [prepareBridges] that runs while the exclusive
  /// `.dart_tool/astgen_prepare_bridges.lock` is held.
  static Future<bool> _prepareBridgesLocked(
    D4rtTester tester,
    BridgeConfig config,
    DateTime startedAt,
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
        if (sentinelMtime.isAfter(startedAt)) {
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
