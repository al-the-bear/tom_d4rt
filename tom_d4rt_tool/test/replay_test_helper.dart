/// Helper for running D4rt replay integration tests.
///
/// Provides bridge generation, binary compilation, and replay execution
/// within the `package:test` framework.
///
/// ## Architecture
///
/// Unlike D4rtTester (which generates a test runner with --test mode),
/// replay tests use the full d4rt binary with `-run-replay <file> -test`.
/// This validates the complete d4rt REPL chain including bridge registration.
///
/// ## Usage
///
/// ```dart
/// late ReplayTestHelper helper;
///
/// setUpAll(() async {
///   helper = ReplayTestHelper(projectPath: Directory.current.path);
///   await helper.prepare();
/// });
///
/// test('basics', () async {
///   final result = await helper.runReplay('test/replay/test_d4rt_basics.d4rt');
///   expect(result.exitCode, 0);
/// });
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// Result of running a replay test.
class ReplayResult {
  /// Process exit code (0 = pass, non-zero = fail).
  final int exitCode;

  /// Captured stdout.
  final String stdout;

  /// Captured stderr.
  final String stderr;

  /// Whether the process timed out.
  final bool timedOut;

  const ReplayResult({
    required this.exitCode,
    required this.stdout,
    required this.stderr,
    this.timedOut = false,
  });

  /// Whether the replay test passed.
  bool get success => !timedOut && exitCode == 0;

  /// Human-readable failure description.
  String get failureReason {
    if (timedOut) return 'Timed out';
    if (exitCode != 0) {
      final msg = stderr.isNotEmpty ? stderr : stdout;
      // Extract verification failures if present
      final failIdx = msg.indexOf('VERIFICATION FAILURES');
      if (failIdx >= 0) {
        return msg.substring(failIdx).trim();
      }
      // Include both stdout and stderr for diagnosis
      final combined = StringBuffer();
      combined.writeln('Exit code $exitCode');
      if (stderr.isNotEmpty) {
        combined.writeln('STDERR: ${_truncate(stderr, 400)}');
      }
      if (stdout.isNotEmpty) {
        combined.writeln('STDOUT: ${_truncate(stdout, 400)}');
      }
      return combined.toString().trim();
    }
    return '';
  }

  static String _truncate(String s, int maxLen) {
    return s.length > maxLen ? '${s.substring(0, maxLen)}...' : s;
  }
}

/// Helper that manages bridge generation, binary compilation,
/// and replay test execution for tom_dartscript_bridges tests.
class ReplayTestHelper {
  /// Absolute path to the tom_dartscript_bridges project.
  final String projectPath;

  /// Name of the compiled test binary (placed in bin/).
  final String binaryName;

  /// Path to the Dart SDK (for d4rtgen).
  /// If null, uses DART_SDK env var or tries to auto-detect.
  final String? dartSdkPath;

  ReplayTestHelper({
    required this.projectPath,
    this.binaryName = 'd4rt_test',
    this.dartSdkPath,
  });

  /// Absolute path to the compiled binary.
  String get binaryPath => p.join(projectPath, 'bin', binaryName);

  /// Whether [prepare] has been called successfully.
  bool get isPrepared => _prepared;
  bool _prepared = false;

  /// Mark as prepared without running generation or compilation.
  ///
  /// Use when the binary already exists (e.g. built by another test suite).
  void markPrepared() {
    _prepared = true;
  }

  /// Errors from preparation, if any.
  String? get preparationError => _preparationError;
  String? _preparationError;

  /// Prepare for replay tests: generate bridges and compile the d4rt binary.
  ///
  /// This is expensive (~1-3 minutes) and should be called once in `setUpAll`.
  /// Returns true on success.
  Future<bool> prepare({bool skipGeneration = false}) async {
    // Step 1: Generate bridges using d4rtgen
    if (!skipGeneration) {
      final genOk = await _generateBridges();
      if (!genOk) return false;
    }

    // Step 2: Compile d4rt binary
    final compileOk = await _compileBinary();
    if (!compileOk) return false;

    _prepared = true;
    return true;
  }

  /// Run a replay file and return the result.
  ///
  /// [replayFile] is relative to [projectPath] or absolute.
  /// [timeout] defaults to 30 seconds.
  Future<ReplayResult> runReplay(
    String replayFile, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (!_prepared) {
      return const ReplayResult(
        exitCode: -1,
        stdout: '',
        stderr: 'ReplayTestHelper.prepare() was not called or failed',
      );
    }

    final absolutePath = p.isAbsolute(replayFile)
        ? replayFile
        : p.join(projectPath, replayFile);

    final process = await Process.start(
      binaryPath,
      ['-run-replay', absolutePath, '-test'],
      workingDirectory: projectPath,
    );

    final stdoutBuf = StringBuffer();
    final stderrBuf = StringBuffer();

    final stdoutFuture = process.stdout
        .transform(const SystemEncoding().decoder)
        .forEach(stdoutBuf.write);
    final stderrFuture = process.stderr
        .transform(const SystemEncoding().decoder)
        .forEach(stderrBuf.write);

    var timedOut = false;

    final exitCode = await process.exitCode.timeout(
      timeout,
      onTimeout: () {
        timedOut = true;
        process.kill(ProcessSignal.sigkill);
        return -1;
      },
    );

    await Future.wait([
      stdoutFuture.catchError((_) {}),
      stderrFuture.catchError((_) {}),
    ]);

    return ReplayResult(
      exitCode: exitCode,
      stdout: stdoutBuf.toString(),
      stderr: stderrBuf.toString(),
      timedOut: timedOut,
    );
  }

  /// Generate bridges using d4rtgen.
  Future<bool> _generateBridges() async {
    // Resolve the generator project path
    final generatorPath = p.normalize(
      p.join(projectPath, '../../xternal/tom_module_d4rt/tom_d4rt_generator'),
    );

    // Resolve DART_SDK
    final sdk = dartSdkPath ??
        Platform.environment['DART_SDK'] ??
        _autoDetectDartSdk();

    if (sdk == null) {
      _preparationError =
          'DART_SDK not set and could not be auto-detected. '
          'Set DART_SDK environment variable or pass dartSdkPath.';
      return false;
    }

    final result = await Process.run(
      'dart',
      ['run', 'bin/d4rtgen.dart', '--project', projectPath],
      workingDirectory: generatorPath,
      environment: {'DART_SDK': sdk},
    );

    if (result.exitCode != 0) {
      _preparationError =
          'Bridge generation failed (exit ${result.exitCode}):\n'
          '${result.stderr}\n${result.stdout}';
      return false;
    }

    return true;
  }

  /// Compile the d4rt binary.
  Future<bool> _compileBinary() async {
    // Delete existing test binary
    final binFile = File(binaryPath);
    if (binFile.existsSync()) {
      binFile.deleteSync();
    }

    final result = await Process.run(
      'dart',
      ['compile', 'exe', 'bin/d4rt.dart', '-o', binaryPath],
      workingDirectory: projectPath,
    );

    if (result.exitCode != 0) {
      _preparationError =
          'Binary compilation failed (exit ${result.exitCode}):\n'
          '${result.stderr}';
      return false;
    }

    if (!File(binaryPath).existsSync()) {
      _preparationError = 'Compiled binary not found at $binaryPath';
      return false;
    }

    return true;
  }

  /// Try to auto-detect the Dart SDK path.
  String? _autoDetectDartSdk() {
    // Try Flutter SDK's bundled Dart
    final flutterPaths = [
      p.join(Platform.environment['HOME'] ?? '', 'Desktop/development/flutter/bin/cache/dart-sdk'),
      p.join(Platform.environment['HOME'] ?? '', '.flutter/bin/cache/dart-sdk'),
      '/usr/local/flutter/bin/cache/dart-sdk',
    ];
    for (final path in flutterPaths) {
      if (Directory(path).existsSync()) return path;
    }

    // Try standalone Dart SDK via `which dart`
    try {
      final result = Process.runSync('which', ['dart']);
      if (result.exitCode == 0) {
        // dart binary -> bin/dart -> SDK root
        final dartBin = (result.stdout as String).trim();
        final sdkPath = p.dirname(p.dirname(dartBin));
        if (Directory(p.join(sdkPath, 'lib')).existsSync()) {
          return sdkPath;
        }
      }
    } catch (_) {}

    return null;
  }

  /// Clean up the test binary.
  void cleanup() {
    final binFile = File(binaryPath);
    if (binFile.existsSync()) {
      binFile.deleteSync();
    }
  }
}
