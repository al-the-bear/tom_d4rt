/// D4rt test execution via subprocess with timeout support.
///
/// Spawns the generated test runner (`d4rtrun.b`) in a new process,
/// captures all output and exceptions via structured JSON, and enforces
/// a configurable timeout.
///
/// ## Usage
///
/// ```dart
/// final tester = D4rtTester(projectPath: '/path/to/project');
///
/// // Run a script file
/// final result = await tester.runScript('scripts/test_types.dart');
/// expect(result.success, isTrue);
///
/// // Evaluate with init script
/// final evalResult = await tester.runEval(
///   'scripts/init.dart',
///   'scripts/eval_test.dart',
/// );
/// ```
library;

import 'dart:io';

import 'd4rt_test_result.dart';

/// Runs D4rt scripts and evaluations in a subprocess with timeout support.
///
/// Uses the project's generated test runner (`dart run :d4rtrun.b --test ...`)
/// to execute D4rt scripts in an isolated process. The test runner captures
/// all output via `runZonedGuarded` with a `ZoneSpecification` and reports
/// results as structured JSON.
///
/// This class is designed for use in unit tests and integration tests where
/// you need to verify that D4rt scripts execute correctly with generated
/// bridge registrations.
class D4rtTester {
  /// Path to the project containing the generated d4rtrun.b.dart test runner.
  final String projectPath;

  /// Default timeout for test execution.
  ///
  /// If a script takes longer than this, the process is killed and
  /// [D4rtTestResult.timedOut] is set to `true`.
  final Duration defaultTimeout;

  /// The package executable name to run (default: 'd4rtrun.b').
  ///
  /// This corresponds to the generated `bin/d4rtrun.b.dart` file,
  /// invoked as `dart run :d4rtrun.b`.
  final String runnerExecutable;

  D4rtTester({
    required this.projectPath,
    this.defaultTimeout = const Duration(seconds: 3),
    this.runnerExecutable = 'd4rtrun.b',
  });

  /// Run a D4rt script file and capture results.
  ///
  /// The [scriptFile] path is relative to [projectPath] or absolute.
  /// The [timeout] overrides [defaultTimeout] for this execution.
  ///
  /// The test runner uses `runZonedGuarded` with a `ZoneSpecification` to
  /// capture all `print()` output and unhandled exceptions. Results are
  /// returned as a structured [D4rtTestResult].
  ///
  /// Example:
  /// ```dart
  /// final result = await tester.runScript('scripts/test_cli_api.dart');
  /// expect(result.success, isTrue);
  /// expect(result.processOutput, contains('All verifications passed'));
  /// ```
  Future<D4rtTestResult> runScript(
    String scriptFile, {
    Duration? timeout,
  }) async {
    return _runProcess(
      ['run', ':$runnerExecutable', '--test', scriptFile],
      timeout ?? defaultTimeout,
    );
  }

  /// Evaluate an expression file after initializing with an init script.
  ///
  /// The [initScriptFile] sets up the D4rt environment (imports, bridge
  /// registrations, etc.). The [expressionFile] contains the expression(s)
  /// to evaluate using `eval()`.
  ///
  /// Both paths are relative to [projectPath] or absolute.
  ///
  /// Example:
  /// ```dart
  /// final result = await tester.runEval(
  ///   'scripts/init.dart',
  ///   'scripts/eval_expressions.dart',
  /// );
  /// expect(result.success, isTrue);
  /// ```
  Future<D4rtTestResult> runEval(
    String initScriptFile,
    String expressionFile, {
    Duration? timeout,
  }) async {
    return _runProcess(
      [
        'run',
        ':$runnerExecutable',
        '--test-eval',
        initScriptFile,
        expressionFile,
      ],
      timeout ?? defaultTimeout,
    );
  }

  /// Spawn the test runner process with timeout handling.
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
