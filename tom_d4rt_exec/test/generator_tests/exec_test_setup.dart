/// Test setup helper for tom_d4rt_exec generator tests.
///
/// When a `BridgeConfig` specifies `d4rtImport: package:tom_d4rt_exec/d4rt.dart`,
/// the generator already produces the correct import. This helper performs
/// a safety-net post-process to ensure tom_d4rt_exec imports are used.
///
/// This helper wraps the standard [D4rtTester] flow:
/// 1. Generate bridges (via [generateBridges] API)
/// 2. Post-process: safety-net replace `package:tom_d4rt/` → `package:tom_d4rt_exec/`
/// 3. Compile the d4 binary
///
/// Usage in tests:
/// ```dart
/// setUpAll(() async {
///   config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
///   tester = D4rtTester(projectPath: projectPath);
///   final ok = await ExecTestSetup.prepareBridges(tester, config);
///   expect(ok, isTrue);
/// });
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt_generator/src/bridge_api.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

/// Helper class for preparing bridges in the tom_d4rt_exec context.
///
/// Works around the generator's hardcoded `package:tom_d4rt/d4rt.dart` import
/// by performing sed-like post-processing after bridge generation.
class ExecTestSetup {
  ExecTestSetup._();

  /// Prepare bridges for the d4 project: generate, post-process, compile.
  ///
  /// Returns `true` if all steps succeed, `false` otherwise.
  /// On failure, error details are printed to stderr.
  ///
  /// SERIALISED ACROSS SUITES (sce190). `d4rt_tester_test.dart` and
  /// `d4rt_coverage_test.dart` both prepare the SAME `example/d4` project,
  /// and `dart test` runs them concurrently. Cluster K #32 gave them distinct
  /// runner and binary names, which fixed ETXTBSY, but both still regenerate
  /// and post-process the shared `lib/src/d4rt_bridges/` tree — so one suite
  /// could analyze or compile it while the other was rewriting it. Measured
  /// both ways it fails: a full run lost `d4rt_tester_test`'s setUpAll to an
  /// analyzer link error ("Missing library: package:_fe_analyzer_shared/...",
  /// a file that was never absent), and one of three paired runs compiled a
  /// binary whose `dcli_bridges.b.dart` cast a script callback to a Dart
  /// function type — six cases red, none of them about their subject. That is
  /// the unattributed extra failure sce190 was filed over.
  ///
  /// The whole pipeline is inside [exclusive]: generation alone is not enough,
  /// because the compile reads the tree the other suite may be rewriting.
  static Future<bool> prepareBridges(D4rtTester tester, BridgeConfig config) =>
      exclusive(
        p.join(tester.projectPath, '.dart_tool', 'exec_prepare_bridges.lock'),
        () => _prepareBridges(tester, config),
      );

  /// A lock held only while it has anything to hold, older than which it is
  /// taken to belong to a holder that died without releasing it.
  static const Duration staleLockAfter = Duration(minutes: 10);

  /// Run [body] while holding the lock file at [lockPath].
  ///
  /// An `O_EXCL` create rather than `RandomAccessFile.lock`, deliberately:
  /// `dart test` runs suites as ISOLATES of one process, and POSIX record
  /// locks belong to the process, so two isolates would both "acquire" an
  /// fcntl lock. Exclusive creation fails for the second caller wherever it
  /// runs — another isolate, another `dart test`, another tool.
  ///
  /// Kept textually in step with `AstgenTestSetup.exclusive` and the
  /// generator's `withFixtureLock` (tom_d4rt_generator 1.44.0), which this
  /// package cannot import until that release is what it resolves.
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

  static Future<bool> _prepareBridges(
    D4rtTester tester,
    BridgeConfig config,
  ) async {
    final projectPath = tester.projectPath;

    // Step 1: Delete existing binary (same as D4rtTester.prepareBridges)
    final binaryPath = p.join(projectPath, 'bin', tester.compiledBinaryName);
    final binary = File(binaryPath);
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

    // Also post-process the generated runner in bin/
    final binDir = Directory(p.join(projectPath, 'bin'));
    await _postProcessDirectory(binDir);

    // Step 3: Compile the binary
    final runnerPath = p.join('bin', '${tester.runnerExecutable}.dart');
    final compileResult = await Process.run('dart', [
      'compile',
      'exe',
      runnerPath,
      '-o',
      binaryPath,
    ], workingDirectory: projectPath);

    if (compileResult.exitCode != 0) {
      // SCE144, carrying SCD127's fix across to this copy: the resolved
      // versions FIRST, because that is the line that ends the investigation.
      // A compile failure here is far more often a frozen fixture lock than a
      // defect in the generated code, and the compiler's own output says
      // nothing about which versions it was given.
      lastFailure =
          '`dart compile exe $runnerPath` failed in $projectPath\n'
                  'fixture resolved: ${resolvedInterpreterVersions(projectPath)}\n'
                  'If a tom_* version above is older than the working tree, the fixture '
                  'lock is frozen: run `dart pub upgrade` in $projectPath.\n'
                  '${compileResult.stderr}'
              .trim();
      stderr.writeln('COMPILATION FAILED:');
      stderr.writeln(compileResult.stdout);
      stderr.writeln(compileResult.stderr);
      return false;
    }

    lastFailure = null;
    return true;
  }

  /// Why the last [prepareBridges] call returned false, or null if it did not.
  ///
  /// SCD127, carried here by SCE144: the diagnosis has to travel with the
  /// BOOLEAN, because that is what the caller asserts on. `prepareBridges`
  /// already wrote the compiler's stderr, and the `expect` that consumed its
  /// result said only "Bridge generation/compilation failed for dart_overview"
  /// — so the one fact that explained everything, the fixture's resolved
  /// versions, never reached the reader. It cost twenty minutes of bisection to
  /// recover in the sibling copy and is one line of data.
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
  ///
  /// THIS IS THE THIRD TRANSCRIPTION OF THE SAME TWENTY LINES, and it is
  /// deliberate rather than overlooked. `D4rtTester.resolvedFixtureVersions`
  /// is the canonical copy and is public precisely so this one can be deleted
  /// in favour of it — but this package resolves `tom_d4rt_generator` **hosted**
  /// (1.28.0, measured 2026-09-22) against a working tree well past it, so
  /// delegating today would compile against a release that does not carry the
  /// method (DGUC6). Collapse the copies when a generator publish raises this
  /// package's floor past the release carrying SCE144; `tom_ast_generator`'s
  /// `AstgenTestSetup` holds the fourth copy and converges on the same event.
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
  ///
  /// Replaces `package:tom_d4rt/` with `package:tom_d4rt_exec/` in import
  /// statements. Only modifies `.b.dart` files (generated code).
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
