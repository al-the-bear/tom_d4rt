/// D4rt test execution with in-memory bridge generation and subprocess runner.
///
/// Generates bridges using the bridge generator directly in-memory, then
/// spawns the generated test runner in a subprocess to execute D4rt scripts
/// with all bridges registered. Captures output and exceptions via structured
/// JSON and enforces a configurable timeout.
///
/// ## Architecture
///
/// ```
/// D4rtTester (test process)              Subprocess (generated test runner)
/// ───────────────────────                ──────────────────────────────────
/// 1. generateBridges(config)
///    → bridge files + test runner
///    (in-memory, same process)
///
/// 2. Process.start('dart',
///    ['run', 'bin/d4rtrun.b.dart',
///     '--test', scriptFile])             → _runTestScript(scriptFile)
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
/// 3. timeout? → process.kill()
///
/// 4. D4rtTestResult.fromTestProcess()
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
/// // Run a script file with bridge generation
/// final result = await tester.runScript(config, 'scripts/test_types.dart');
/// expect(result.success, isTrue);
///
/// // Evaluate with init script
/// final evalResult = await tester.runEval(
///   config,
///   'scripts/init.dart',
///   'scripts/eval_test.dart',
/// );
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;

import '../bridge_api.dart';
import '../bridge_config.dart';
import '../file_generators.dart';
import 'd4rt_test_result.dart';

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
  /// invoked as `dart run bin/<runnerExecutable>.dart --test ...`.
  /// Default: `'d4rtrun.b'`.
  final String runnerExecutable;

  D4rtTester({
    required this.projectPath,
    this.defaultTimeout = const Duration(seconds: 3),
    this.runnerExecutable = 'd4rtrun.b',
  });

  /// Generate bridges and run a D4rt script file, capturing results.
  ///
  /// 1. Runs the bridge generator in-memory with [config], producing bridge
  ///    files and the test runner into [projectPath].
  /// 2. Spawns the test runner in a subprocess with `--test <scriptFile>`.
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
    // Step 1: Generate bridges in-memory
    final genResult = await _generateBridges(config);
    if (!genResult.isSuccess) {
      return D4rtTestResult(
        timedOut: false,
        exceptions: genResult.errors,
        exitCode: -1,
      );
    }

    // Step 2: Spawn test runner subprocess
    final runnerPath = _resolveRunnerPath(config);
    return _runProcess(
      ['run', runnerPath, '--test', scriptFile],
      timeout ?? defaultTimeout,
    );
  }

  /// Generate bridges and evaluate an expression file, capturing results.
  ///
  /// 1. Runs the bridge generator in-memory with [config].
  /// 2. Spawns the test runner with `--test-eval <initScriptFile> <expressionFile>`.
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
    // Step 1: Generate bridges in-memory
    final genResult = await _generateBridges(config);
    if (!genResult.isSuccess) {
      return D4rtTestResult(
        timedOut: false,
        exceptions: genResult.errors,
        exitCode: -1,
      );
    }

    // Step 2: Spawn test runner subprocess
    final runnerPath = _resolveRunnerPath(config);
    return _runProcess(
      ['run', runnerPath, '--test-eval', initScriptFile, expressionFile],
      timeout ?? defaultTimeout,
    );
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

    return generateBridges(
      config: effectiveConfig,
      projectPath: projectPath,
    );
  }

  /// Resolve the test runner path for subprocess invocation.
  ///
  /// If the config already specifies a test runner path, use it.
  /// Otherwise use the default `bin/<runnerExecutable>.dart`.
  String _resolveRunnerPath(BridgeConfig config) {
    final runnerFile = config.testRunnerPath != null
        ? ensureBDartExtension(config.testRunnerPath!)
        : 'bin/$runnerExecutable.dart';
    return p.join(projectPath, runnerFile);
  }

  /// Spawn the test runner process with timeout handling.
  ///
  /// Starts `dart run <runnerPath> <args>` in [projectPath], collects
  /// stdout/stderr, and enforces [timeout]. If the process exceeds the
  /// timeout, it is killed with SIGKILL and [D4rtTestResult.timedOut]
  /// is set to `true`.
  Future<D4rtTestResult> _runProcess(
    List<String> args,
    Duration timeout,
  ) async {
    final process = await Process.start(
      'dart',
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
