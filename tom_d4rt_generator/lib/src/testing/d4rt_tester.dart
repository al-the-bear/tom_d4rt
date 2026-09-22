/// D4rt test execution with in-memory bridge generation and subprocess runner.
///
/// Generates bridges using the bridge generator directly in-memory, then
/// compiles the test runner to a native binary and uses it to execute D4rt
/// scripts with all bridges registered. Captures output and exceptions via
/// structured JSON and enforces a configurable timeout.
///
/// ## Architecture
///
/// ```
/// D4rtTester (test process)              Subprocess (compiled d4 binary)
/// ───────────────────────                ──────────────────────────────────
/// 1. delete bin/d4 (verify regeneration)
///
/// 2. generateBridges(config)
///    → bridge files + test runner
///    (in-memory, same process)
///
/// 3. dart compile exe bin/d4rtrun.b.dart -o bin/d4
///
/// 4. bin/d4 --test scriptFile            → _runTestScript(scriptFile)
///                                            │
///                                            ├─ runZonedGuarded(
///                                            │    () { d4rt.execute(source) },
///                                            │    onError: capture exceptions,
///                                            │    zoneSpec: capture print(),
///                                            │  )
///                                            │
///    ← stdout: ###D4RT_TEST_RESULT###    ← _emitTestResult(output, exceptions)
///      {"output":"...","exceptions":[]}
///
/// 5. timeout? → process.kill()
///
/// 6. D4rtTestResult.fromTestProcess()
///      → .success / .timedOut / .exceptions / .processOutput
/// ```
///
/// ## Usage
///
/// ```dart
/// final tester = D4rtTester(projectPath: '/path/to/project');
///
/// final config = BridgeConfig.fromJson({...});
///
/// // Prepare bridges and compile binary once in setUpAll
/// setUpAll(() async {
///   final ok = await tester.prepareBridges(config);
///   expect(ok, isTrue);
/// });
///
/// // Run scripts using the compiled binary
/// test('feature X', () async {
///   final result = await tester.runScriptOnly(config, 'test/x.dart');
///   expect(result.success, isTrue);
/// });
/// ```
library;

import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../bridge_api.dart';
import '../bridge_config.dart';
import 'd4rt_test_result.dart';
import 'package_resolution.dart';

/// Runs D4rt scripts and evaluations with in-memory bridge generation
/// and subprocess-based test execution.
///
/// The test flow is:
/// 1. **Bridge generation** — runs the bridge generator in-memory (same
///    process) to produce bridge files and a test runner in [projectPath].
/// 2. **Subprocess execution** — spawns `dart run bin/<runner>.dart --test`
///    in the project directory. The generated test runner registers all
///    bridges, executes the D4rt script inside `runZonedGuarded` with a
///    `ZoneSpecification` to capture `print()` output and unhandled
///    exceptions, then emits structured JSON.
/// 3. **Result parsing** — parses the JSON output into a [D4rtTestResult]
///    with timeout detection.
///
/// This class is designed for use in the bridge generator's own tests,
/// where bridge generation and execution must both be verified end-to-end.
class D4rtTester {
  /// Path to the project directory.
  ///
  /// This must be a project with a valid `pubspec.yaml` and resolved
  /// dependencies. Bridge files and the test runner are generated into
  /// this directory based on the [BridgeConfig] paths.
  final String projectPath;

  /// Default timeout for test execution.
  ///
  /// If a script takes longer than this, the subprocess is killed and
  /// [D4rtTestResult.timedOut] is set to `true`. Default: 3 seconds.
  final Duration defaultTimeout;

  /// The test runner filename (without `.dart` extension).
  ///
  /// The bridge generator produces `bin/<runnerExecutable>.dart` which is
  /// compiled to [compiledBinaryName].
  /// Default: `'d4rtrun.b'`.
  final String runnerExecutable;

  /// The compiled binary name (without path).
  ///
  /// The test runner is compiled to `bin/<compiledBinaryName>` and used
  /// for all script executions. Default: `'d4'`.
  final String compiledBinaryName;

  D4rtTester({
    required this.projectPath,
    this.defaultTimeout = const Duration(seconds: 3),
    this.runnerExecutable = 'd4rtrun.b',
    this.compiledBinaryName = 'd4',
  });

  /// Path to the compiled binary.
  String get _binaryPath => p.join(projectPath, 'bin', compiledBinaryName);

  /// Generate bridges once for a project without running any script.
  ///
  /// This method:
  /// 1. **Deletes** the existing binary to verify regeneration
  /// 2. **Generates** bridges using the in-memory generator
  /// 3. **Compiles** the test runner to a native binary
  ///
  /// Use this in `setUpAll` to prepare once, then call [runScriptOnly]
  /// for each test script.
  ///
  /// Returns `true` if generation and compilation succeeded, `false` otherwise.
  /// On failure, the errors are stored and can be retrieved from subsequent
  /// [runScriptOnly] calls (which will return a failed result immediately).
  ///
  /// Example:
  /// ```dart
  /// setUpAll(() async {
  ///   final ok = await tester.prepareBridges(config);
  ///   expect(ok, isTrue, reason: 'Bridge generation failed');
  /// });
  ///
  /// test('feature X', () async {
  ///   final result = await tester.runScriptOnly(config, 'test/x.dart');
  ///   _expectSuccess(result, 'feature X');
  /// });
  /// ```
  Future<bool> prepareBridges(BridgeConfig config) async {
    // Step 0: Make sure the project still resolves. Checking only that a
    // package config exists is not enough: a project that stopped resolving
    // keeps its last config, and generation then fails on a downstream symptom
    // — once an analyzer "API break" that was really a config naming a version
    // the pub cache no longer had. Pub's own message names the cause.
    // SCE144: a project directory that is not there at all.
    //
    // `resolveIfUnresolved` runs `dart pub get` with this path as its working
    // directory, and `Process.run` does not return a non-zero exit code for a
    // missing cwd — it THROWS `ProcessException: No such file or directory`,
    // straight out of `prepareBridges`. The caller's `expect` is never reached,
    // so neither the fixture's resolved versions NOR the withheld-case count
    // reaches the reader: the one route out of here that produces no diagnosis
    // whatsoever. A renamed or moved fixture, or a suite run from the wrong
    // directory, lands exactly here.
    if (!Directory(projectPath).existsSync()) {
      _lastGenerationErrors = _withFixtureContext([
        'no such project directory: $projectPath',
        'The fixture this suite prepares is missing. Check the path, and that '
            'the suite is being run from its package root.',
      ]);
      return false;
    }

    final unresolved = await resolveIfUnresolved(projectPath);
    if (unresolved != null) {
      _lastGenerationErrors = _withFixtureContext([unresolved]);
      return false;
    }

    // Step 1: Delete existing binary to verify it gets regenerated
    final binaryFile = File(_binaryPath);
    if (binaryFile.existsSync()) {
      binaryFile.deleteSync();
    }

    // Step 2: Generate bridges
    final genResult = await _generateBridges(config);
    if (!genResult.isSuccess) {
      _lastGenerationErrors = _withFixtureContext(genResult.errors);
      return false;
    }

    // Step 3: Compile the test runner — once per `dart test` invocation,
    // not once per suite. See [_ensureSuiteBinary].
    final runnerPath = _resolveRunnerPath();
    final compileErrors = await _ensureSuiteBinary(runnerPath, genResult);
    if (compileErrors != null) {
      _lastGenerationErrors = _withFixtureContext(compileErrors);
      return false;
    }

    _lastGenerationErrors = null;
    return true;
  }

  // ───────────────────────────────────────────────────────────────────
  // sce41: the shared runner binary
  // ───────────────────────────────────────────────────────────────────
  //
  // Two suites prepare the SAME `example/d4` project — `d4rt_tester_test.dart`
  // and `d4rt_coverage_test.dart` — so the heaviest work in the package's
  // suite was being done twice. They keep DISTINCT binary names on purpose
  // (Cluster M #34): `dart compile exe -o bin/d4` in one suite's setUpAll
  // races against `Process.start(bin/d4)` in the other suite's tests, and the
  // symptom is ETXTBSY. That constraint is kept — what is shared is the
  // COMPILE, not the binary.
  //
  // The two generated runner sources differ only in comments (the
  // `// Generated:` line, and usage lines naming the file), so one compilation
  // serves both. Each suite then copies the shared artifact to its own name.
  //
  // `dart test` runs each file in its own process, so the cache has to be on
  // disk. It is keyed by the CONTENT of everything that goes into the binary —
  // the runner source and every generated bridge file — so a stale binary
  // cannot survive a generator change. Nothing about this reuses an artifact
  // across a change; it only avoids repeating identical work.

  /// Name of the artifact shared by every suite preparing this project.
  static const _sharedBinaryName = 'd4_shared.b';

  String get _sharedBinaryPath => p.join(projectPath, 'bin', _sharedBinaryName);

  String get _sharedStampPath => '$_sharedBinaryPath.stamp';

  String get _sharedLockPath => '$_sharedBinaryPath.lock';

  /// A content hash of everything the compiled binary is built from.
  ///
  /// The `// Generated:` line carries a timestamp and the generator version
  /// and is excluded: it changes on every generation without changing what is
  /// compiled, and including it would defeat the cache entirely.
  String _artifactKey(String runnerPath, List<String> generatedFiles) {
    // FNV-1a, 64-bit. A content hash, not a security one — the question it
    // answers is "is this the same input as last time", and adding a crypto
    // dependency to a test helper to answer it would not be proportionate.
    var hash = 0xcbf29ce484222325;
    void mix(String text) {
      for (final unit in text.codeUnits) {
        hash ^= unit;
        hash = (hash * 0x100000001b3) & 0xFFFFFFFFFFFFFFFF;
      }
      hash ^= 0x0a;
      hash = (hash * 0x100000001b3) & 0xFFFFFFFFFFFFFFFF;
    }

    // The `// Generated:` line carries a timestamp and the generator version:
    // it changes on every generation without changing what is compiled, and
    // counting it would defeat the cache entirely.
    String normalise(String text) => text
        .split('\n')
        .where((line) => !line.trimLeft().startsWith('// Generated:'))
        .join('\n');

    final absoluteRunner = p.isAbsolute(runnerPath)
        ? runnerPath
        : p.join(projectPath, runnerPath);

    // THE RUNNER IS HASHED BY BODY, NOT BY NAME, and this is the whole reason
    // the artifact can be shared. Each suite owns a differently-named runner
    // (Cluster M #34), and the generator writes that name into the file's
    // usage comments — so two runners that compile to identical programs
    // differ textually. Keying on that would give every suite its own key,
    // each would rebuild the shared binary, and the two suites would trade it
    // back and forth: strictly worse than compiling their own. Measured
    // exactly that way before this normalisation was added.
    final runnerStem = p.basenameWithoutExtension(absoluteRunner);
    final runnerFile = File(absoluteRunner);
    mix('<runner>');
    mix(
      runnerFile.existsSync()
          ? normalise(
              runnerFile.readAsStringSync().replaceAll(runnerStem, '<runner>'),
            )
          : '<absent>',
    );

    // Generated bridges ARE hashed by name as well as content: a rename is a
    // change in what the binary contains, and two files with identical bodies
    // under different names are different output.
    // The generator lists the test runner among its outputs, under the
    // suite-specific name. It is hashed above, name-normalised, so including
    // it here as well would reintroduce exactly the per-suite key this
    // normalisation exists to remove — measured: the two suites then traded
    // the shared binary back and forth, recompiling on every run.
    final sorted = [
      ...generatedFiles.where(
        (f) => p.canonicalize(f) != p.canonicalize(absoluteRunner),
      ),
    ]..sort();
    for (final path in sorted) {
      final file = File(path);
      // A listed file that is missing is itself a distinguishing fact, and
      // recording it is what stops two different states hashing alike.
      mix(p.basename(path));
      mix(file.existsSync() ? normalise(file.readAsStringSync()) : '<absent>');
    }

    // Dart's ints are SIGNED 64-bit, so masking cannot clear the sign bit and
    // `toRadixString` would render a negative key with a leading `-`. Printing
    // it as two unsigned 32-bit halves keeps the stamp file a plain 16-digit
    // hex string, which is what anyone reading it expects to find.
    final high = (hash >> 32).toUnsigned(32);
    final low = hash.toUnsigned(32);
    return high.toRadixString(16).padLeft(8, '0') +
        low.toRadixString(16).padLeft(8, '0');
  }

  /// The content key for the given inputs, for tests.
  ///
  /// The key is what makes "a stale binary is never reused" true, so it is the
  /// part worth pinning directly: asserting on the shared binary itself would
  /// mean asserting on state that other suites in the same `dart test` run are
  /// legitimately allowed to rebuild, which is how a guard becomes flaky.
  @visibleForTesting
  String artifactKeyForTesting(
    String runnerPath,
    List<String> generatedFiles,
  ) => _artifactKey(runnerPath, generatedFiles);

  /// Runs [body] with the shared-artifact lock held, if it can be taken.
  ///
  /// `dart test` gives each file its own process, so this has to be an
  /// inter-process lock; exclusive file creation is the portable way to get
  /// one. Failing to take it is NOT an error: the fallback is for this suite
  /// to compile its own binary, which is exactly what every suite did before
  /// this existed. Waiting forever would turn a contended cache into a hang,
  /// which is worse than the duplicated work it exists to avoid.
  Future<T> _withSharedLock<T>(Future<T> Function(bool held) body) async {
    final lock = File(_sharedLockPath);
    final deadline = DateTime.now().add(const Duration(minutes: 5));
    var held = false;
    while (DateTime.now().isBefore(deadline)) {
      try {
        lock.parent.createSync(recursive: true);
        lock.createSync(exclusive: true);
        held = true;
        break;
      } on FileSystemException {
        // A lock left behind by a killed process would otherwise block every
        // later run until someone deleted it by hand.
        try {
          final age = DateTime.now().difference(lock.lastModifiedSync());
          if (age > const Duration(minutes: 10)) {
            lock.deleteSync();
            continue;
          }
        } on FileSystemException {
          // It vanished under us — that is the holder releasing it.
        }
        await Future<void>.delayed(const Duration(milliseconds: 200));
      }
    }
    try {
      return await body(held);
    } finally {
      if (held) {
        try {
          lock.deleteSync();
        } on FileSystemException {
          // Already gone; nothing to release.
        }
      }
    }
  }

  /// Compiles [runnerPath] to [output]. Returns errors, or null on success.
  Future<List<String>?> _compileTo(String runnerPath, String output) async {
    final result = await Process.run('dart', [
      'compile',
      'exe',
      runnerPath,
      '-o',
      output,
    ], workingDirectory: projectPath);
    if (result.exitCode != 0) {
      return ['Failed to compile test runner:', result.stderr.toString()];
    }
    if (!File(output).existsSync()) {
      return ['Compiled binary not found at $output'];
    }
    return null;
  }

  /// Puts a current binary at [_binaryPath], compiling the shared artifact
  /// only when no current one exists. Returns errors, or null on success.
  Future<List<String>?> _ensureSuiteBinary(
    String runnerPath,
    GenerationResult genResult,
  ) async {
    final key = _artifactKey(runnerPath, genResult.outputFiles);

    return _withSharedLock<List<String>?>((held) async {
      if (!held) {
        // Could not serialise with peers. Build this suite's own binary, which
        // is exactly what every suite did before the shared artifact existed.
        // Writing to the shared path unlocked could clobber it while a peer is
        // copying from it — duplicated work is the safe failure here.
        return _compileTo(runnerPath, _binaryPath);
      }

      final shared = File(_sharedBinaryPath);
      final stamp = File(_sharedStampPath);
      final current =
          shared.existsSync() &&
          stamp.existsSync() &&
          stamp.readAsStringSync().trim() == key;

      if (!current) {
        // Stale or absent: rebuild. The stamp is written only AFTER the binary
        // exists, so an interrupted compile leaves no stamp and the next run
        // rebuilds rather than trusting a partial artifact.
        final errors = await _compileTo(runnerPath, _sharedBinaryPath);
        if (errors != null) return errors;
        stamp.writeAsStringSync(key);
      }

      // The copy happens INSIDE the lock: otherwise a peer whose key differs
      // could begin overwriting the shared binary while this read is in
      // flight, and the suite would run a half-written executable.
      try {
        shared.copySync(_binaryPath);
      } on FileSystemException catch (e) {
        return ['Failed to place the runner binary at $_binaryPath: $e'];
      }
      // `copySync` does not carry the execute bit.
      final chmod = await Process.run('chmod', ['+x', _binaryPath]);
      if (chmod.exitCode != 0) {
        return ['Failed to make $_binaryPath executable: ${chmod.stderr}'];
      }
      return null;
    });
  }

  /// Run a D4rt script file **without** regenerating bridges.
  ///
  /// Requires [prepareBridges] to have been called first. If bridges
  /// were not prepared (or preparation failed), returns a failed
  /// [D4rtTestResult] with an appropriate error message.
  ///
  /// Uses the compiled binary for execution (much faster than dart run).
  Future<D4rtTestResult> runScriptOnly(
    BridgeConfig config,
    String scriptFile, {
    Duration? timeout,
  }) async {
    if (_lastGenerationErrors != null) {
      return D4rtTestResult(
        timedOut: false,
        exceptions: _lastGenerationErrors!,
        exitCode: -1,
      );
    }

    return _runBinary(['--test', scriptFile], timeout ?? defaultTimeout);
  }

  /// [errors], with the fixture's resolved `tom_*` versions in front.
  ///
  /// SCE144. THE DIAGNOSIS TRAVELS WITH THE ERRORS, because that is what the
  /// caller reads. Every consumer asserts on the BOOL and prints
  /// [lastGenerationErrors]; the compiler's own output says nothing about which
  /// versions it was handed, and the fixture drives its own gitignored lock
  /// while path-resolving a sibling from the working tree — so it can freeze at
  /// a version that no longer compiles against HEAD. SCD127 measured the cost
  /// of the missing line in the sibling copy of this pipeline: twenty minutes
  /// of bisection for one line of data.
  ///
  /// FIRST, not appended. The resolved versions are the line that ends the
  /// investigation, and a reader scanning a wall of compiler output stops at
  /// the top.
  List<String> _withFixtureContext(List<String> errors) => [
    'fixture resolved: ${resolvedFixtureVersions(projectPath)}',
    'If a tom_* version above is older than the working tree, the fixture '
        'lock is frozen: run `dart pub upgrade` in $projectPath.',
    ...errors,
  ];

  /// The `tom_*` packages [projectPath]'s lock resolved, as one line.
  ///
  /// The FIXTURE's lock, not the calling package's. `example/d4` is its own
  /// package with its own gitignored lock while it path-resolves the
  /// interpreter from the working tree, so it can freeze at a version that no
  /// longer compiles against HEAD — which is what happened at tom_d4rt_ast
  /// 0.19.0, whose exports lacked `ConvertStdlib`, `CollectionStdlib`,
  /// `TypedDataStdlib` and `Logger`.
  ///
  /// Best-effort BY DESIGN: this runs on a path that has already failed, so a
  /// missing or unparseable lock must degrade to a note rather than throw and
  /// replace the real diagnosis with its own.
  ///
  /// Public and static so the two test-local copies of this pipeline
  /// (`tom_d4rt_exec`'s `ExecTestSetup`, `tom_ast_generator`'s
  /// `AstgenTestSetup`) can delegate here rather than keep a third and fourth
  /// transcription — once they resolve a release carrying it. Measured
  /// 2026-09-22: both resolve tom_d4rt_generator 1.28.0 hosted against a
  /// working tree well past it, so until that publish they must duplicate
  /// (DGUC6), and each says so where it does.
  static String resolvedFixtureVersions(String projectPath) {
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

  /// Errors from the last [prepareBridges] call, or `null` if successful.
  List<String>? _lastGenerationErrors;

  /// Public accessor for errors from the last [prepareBridges] call.
  /// Returns `null` if generation was successful.
  List<String>? get lastGenerationErrors => _lastGenerationErrors;

  /// Generate bridges and run a D4rt script file, capturing results.
  ///
  /// 1. Runs the bridge generator in-memory with [config], producing bridge
  ///    files and the test runner into [projectPath].
  /// 2. Compiles and runs the test runner with `--test <scriptFile>`.
  /// 3. Returns a [D4rtTestResult] with captured output, exceptions, and
  ///    timeout status.
  ///
  /// The [scriptFile] path is relative to [projectPath] or absolute.
  /// The [timeout] overrides [defaultTimeout] for this execution.
  ///
  /// If bridge generation fails, returns a [D4rtTestResult] with the
  /// generation errors in [D4rtTestResult.exceptions].
  ///
  /// Example:
  /// ```dart
  /// final result = await tester.runScript(
  ///   config,
  ///   'scripts/test_cli_api.dart',
  ///   timeout: Duration(seconds: 5),
  /// );
  /// expect(result.success, isTrue);
  /// expect(result.processOutput, contains('All verifications passed'));
  /// ```
  Future<D4rtTestResult> runScript(
    BridgeConfig config,
    String scriptFile, {
    Duration? timeout,
  }) async {
    // Generate and compile bridges
    final ok = await prepareBridges(config);
    if (!ok) {
      return D4rtTestResult(
        timedOut: false,
        exceptions: _lastGenerationErrors!,
        exitCode: -1,
      );
    }

    // Run using compiled binary
    return _runBinary(['--test', scriptFile], timeout ?? defaultTimeout);
  }

  /// Generate bridges and evaluate an expression file, capturing results.
  ///
  /// 1. Runs the bridge generator in-memory with [config].
  /// 2. Compiles and runs the test runner with `--test-eval <initScriptFile> <expressionFile>`.
  ///    The init script sets up the D4rt environment (imports, variables),
  ///    then the expression file is evaluated using `eval()`.
  /// 3. Returns a [D4rtTestResult].
  ///
  /// Both file paths are relative to [projectPath] or absolute.
  ///
  /// Example:
  /// ```dart
  /// final result = await tester.runEval(
  ///   config,
  ///   'scripts/init.dart',
  ///   'scripts/eval_expressions.dart',
  /// );
  /// expect(result.success, isTrue);
  /// ```
  Future<D4rtTestResult> runEval(
    BridgeConfig config,
    String initScriptFile,
    String expressionFile, {
    Duration? timeout,
  }) async {
    // Generate and compile bridges
    final ok = await prepareBridges(config);
    if (!ok) {
      return D4rtTestResult(
        timedOut: false,
        exceptions: _lastGenerationErrors!,
        exitCode: -1,
      );
    }

    // Run using compiled binary
    return _runBinary([
      '--test-eval',
      initScriptFile,
      expressionFile,
    ], timeout ?? defaultTimeout);
  }

  /// Run bridge generation in-memory using the generator API.
  ///
  /// Ensures the test runner is generated regardless of [config] settings
  /// by using [BridgeConfig.copyWith] to enable test runner generation.
  /// The generated test runner includes `--test` and `--test-eval` modes
  /// with `runZonedGuarded` + `ZoneSpecification` for output capture.
  Future<GenerationResult> _generateBridges(BridgeConfig config) async {
    // Ensure test runner generation is enabled
    final runnerPath = 'bin/$runnerExecutable.dart';
    final effectiveConfig = config.copyWith(
      generateTestRunner: true,
      testRunnerPath: runnerPath,
    );

    return generateBridges(config: effectiveConfig, projectPath: projectPath);
  }

  /// Resolve the test runner path for subprocess compilation.
  ///
  /// Must mirror [_generateBridges], which **always** emits the runner at
  /// `bin/<runnerExecutable>.dart` (overriding any `testRunnerPath` from the
  /// config). Reading the original `config.testRunnerPath` here would point
  /// the compile step at a filename that was never generated — e.g. the
  /// `buildkit.yaml` default `bin/d4rtrun.b.dart` while generation produced
  /// `bin/d4rtrun_tester.b.dart` for a suite that overrides [runnerExecutable]
  /// to run in parallel. The runner name is owned by [runnerExecutable].
  String _resolveRunnerPath() {
    return p.join(projectPath, 'bin', '$runnerExecutable.dart');
  }

  /// Run the compiled binary with arguments and timeout handling.
  ///
  /// Executes `bin/<compiledBinaryName> <args>` in [projectPath], collects
  /// stdout/stderr, and enforces [timeout]. If the process exceeds the
  /// timeout, it is killed with SIGKILL and [D4rtTestResult.timedOut]
  /// is set to `true`.
  Future<D4rtTestResult> _runBinary(List<String> args, Duration timeout) async {
    final process = await Process.start(
      _binaryPath,
      args,
      workingDirectory: projectPath,
    );

    final stdoutBuf = StringBuffer();
    final stderrBuf = StringBuffer();

    // Collect stdout and stderr
    final stdoutFuture = process.stdout
        .transform(const SystemEncoding().decoder)
        .forEach(stdoutBuf.write);
    final stderrFuture = process.stderr
        .transform(const SystemEncoding().decoder)
        .forEach(stderrBuf.write);

    var timedOut = false;

    // Wait for process with timeout
    final exitCode = await process.exitCode.timeout(
      timeout,
      onTimeout: () {
        timedOut = true;
        process.kill(ProcessSignal.sigkill);
        return -1;
      },
    );

    // Wait for output streams to finish
    await Future.wait([
      stdoutFuture.catchError((_) {}),
      stderrFuture.catchError((_) {}),
    ]);

    return D4rtTestResult.fromTestProcess(
      exitCode: exitCode,
      stdout: stdoutBuf.toString(),
      stderr: stderrBuf.toString(),
      timedOut: timedOut,
    );
  }
}
