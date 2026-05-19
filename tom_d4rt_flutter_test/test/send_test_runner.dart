/// Test runner that reads Dart source scripts from disk and sends them to the
/// tom_d4rt_flutter_test_app via HTTP for execution by the source-based
/// [SourceFlutterD4rt] interpreter.
///
/// Scripts live in:
///   test/tom_d4rt_flutter_test_app/test/send_source_via_http_scripts/
///
/// Each script must contain a `dynamic build(BuildContext context)` function
/// that returns a Widget.
///
/// The app captures `print()` output from scripts and returns it in the
/// HTTP response.
///
/// Usage in tests:
/// ```dart
/// test('my test', () async {
///   final result = await SendTestRunner.send('painting/color_test.dart');
///   expect(result.success, isTrue);
///   expect(result.widgetType, contains('Container'));
/// });
/// ```
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

/// Result of sending a D4rt source script to the test app.
class SendResult {
  /// Whether the build succeeded.
  final bool success;

  /// The runtime type of the built widget (on success).
  final String? widgetType;

  /// Error message (on failure).
  final String? error;

  /// Stack trace from the exception (on failure, if available).
  final String? stackTrace;

  /// Captured print() output from the script.
  final List<String> output;

  /// HTTP status code.
  final int statusCode;

  /// Flutter framework errors captured after layout/paint.
  final List<String> frameworkErrors;

  /// User judgment from the test app UI ('good' or 'needs rewrite').
  final String? judgment;

  const SendResult({
    required this.success,
    this.widgetType,
    this.error,
    this.stackTrace,
    required this.output,
    required this.statusCode,
    this.frameworkErrors = const [],
    this.judgment,
  });

  bool get hasFrameworkErrors => frameworkErrors.isNotEmpty;

  @override
  String toString() {
    final fwErrors = frameworkErrors.isNotEmpty
        ? ', frameworkErrors: ${frameworkErrors.length}'
        : '';
    if (success) {
      return 'SendResult(success, widgetType: $widgetType, '
          'output: $output$fwErrors)';
    }
    return 'SendResult(failed, error: $error, output: $output$fwErrors)';
  }
}

/// Result of sending interaction commands to the test app.
class InteractResult {
  final bool success;
  final List<String> output;
  final List<String> errors;
  final int statusCode;

  const InteractResult({
    required this.success,
    required this.output,
    required this.errors,
    required this.statusCode,
  });

  @override
  String toString() {
    if (success) return 'InteractResult(success, output: $output)';
    return 'InteractResult(failed, errors: $errors, output: $output)';
  }
}

/// Test runner for sending D4rt source scripts to the source-based test app.
///
/// Uses port 4248 (one above the AST-based app at 4247) so both apps can run
/// simultaneously without conflicts.
class SendTestRunner {
  /// Default HTTP port for the source-based test app.
  static const int defaultPort = 4248;

  /// Default HTTP host.
  static const String defaultHost = 'localhost';

  /// Scripts directory relative to package root.
  ///
  /// Points to the shared corpus in tom_d4rt_flutter_ast so both the AST-based
  /// and source-based test suites run exactly the same scripts.
  static const String scriptsPath =
      '../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts';

  /// Test app directory relative to package root.
  static const String testAppPath = 'test/tom_d4rt_flutter_test_app';

  static HttpClient? _client;
  static Process? _testAppProcess;
  static bool _startedByRunner = false;
  /// Set when a transport error is observed; the next [send] call will
  /// recycle the test app before doing anything else. Decoupling recycle
  /// from the catch path keeps the failed test inside flutter_test's per-test
  /// 30s budget — the recycle (which can take ~10s) runs against the next
  /// test's budget instead of cascading into "did not complete".
  static bool _appNeedsRecycle = false;
  static const int _processLogTailLimit = 200;

  static final List<String> _testAppStdoutTail = <String>[];
  static final List<String> _testAppStderrTail = <String>[];
  static int? _lastTestAppExitCode;

  /// Initialize the test runner (call in setUpAll).
  ///
  /// If the test app is not already running on [defaultPort], starts it
  /// automatically from [testAppPath].
  static Future<void> setUp({
    bool startApp = true,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    _client = HttpClient();
    _startedByRunner = false;

    if (startApp) {
      final alreadyRunning = await isAppRunning();
      if (!alreadyRunning) {
        try {
          await _startTestApp(timeout: timeout);
        } catch (_) {
          await _killExistingProcess();
          await _startTestApp(timeout: timeout);
        }
        _startedByRunner = true;
      }
    }
  }

  /// Tear down the test runner (call in tearDownAll).
  ///
  /// Kills the test app only if it was started by [setUp].
  static Future<void> tearDown() async {
    final shouldStopApp = _startedByRunner;
    _client?.close();
    _client = null;
    _startedByRunner = false;

    if (shouldStopApp) {
      try {
        await _killTestApp();
      } catch (_) {
        // ignore — process may already be gone
      }
    }
  }

  /// Kill any existing test app process listening on [defaultPort].
  ///
  /// SIGKILL is mandatory — when an app's Dart event loop is wedged (e.g.
  /// after a script disposed dozens of AutofillGroups, blocking the platform
  /// message queue), SIGTERM queues against the dead loop and never fires.
  /// We also restrict lsof to TCP LISTEN sockets so we don't accidentally
  /// kill the harness or the test process itself if either has an
  /// established connection on the port.
  static Future<void> _killExistingProcess() async {
    for (var attempt = 0; attempt < 5; attempt++) {
      List<int> pids;
      try {
        final result = await Process.run('lsof', [
          '-t',
          '-i',
          ':$defaultPort',
          '-sTCP:LISTEN',
        ]);
        pids = result.stdout
            .toString()
            .trim()
            .split('\n')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .map(int.tryParse)
            .whereType<int>()
            .toList();
      } catch (_) {
        return;
      }
      if (pids.isEmpty) {
        return;
      }
      for (final pid in pids) {
        try {
          Process.killPid(pid, ProcessSignal.sigkill);
        } catch (_) {
          // Process may have already died between lsof and killPid.
        }
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
  }

  /// Block until [defaultPort] has no LISTEN socket, or [timeout] elapses.
  /// After SIGKILL the kernel still needs a moment to reclaim the bind, and
  /// `flutter run` will fail if it tries to bind too early.
  static Future<void> _waitForPortFree({required Duration timeout}) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      try {
        final result = await Process.run('lsof', [
          '-t',
          '-i',
          ':$defaultPort',
          '-sTCP:LISTEN',
        ]);
        if (result.stdout.toString().trim().isEmpty) {
          return;
        }
      } catch (_) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
  }

  /// Start the test app Flutter process and wait until it is ready.
  static Future<void> _startTestApp({required Duration timeout}) async {
    final packageRoot = Directory.current.path;
    final appDir = p.join(packageRoot, testAppPath);
    final flutterExecutable = await _resolveFlutterExecutable();

    final device = Platform.isMacOS
        ? 'macos'
        : Platform.isWindows
        ? 'windows'
        : 'linux';

    _testAppProcess = await Process.start(
      flutterExecutable,
      ['run', '-d', device],
      workingDirectory: appDir,
    );

    _lastTestAppExitCode = null;
    _testAppStdoutTail.clear();
    _testAppStderrTail.clear();

    _captureProcessStream(_testAppProcess!.stdout, _testAppStdoutTail);
    _captureProcessStream(_testAppProcess!.stderr, _testAppStderrTail);

    // ignore: unawaited_futures
    _testAppProcess!.exitCode.then((code) {
      _lastTestAppExitCode = code;
      _appendProcessTail(
        _testAppStderrTail,
        '[process] test app exited with code $code',
      );
    });

    final deadline = DateTime.now().add(timeout);
    var ready = false;
    while (DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(seconds: 2));
      try {
        final tempClient = HttpClient();
        try {
          final request = await tempClient.get(defaultHost, defaultPort, '/health');
          final response = await request.close();
          if (response.statusCode == 200) {
            ready = true;
            break;
          }
        } finally {
          tempClient.close();
        }
      } catch (_) {
        // Not ready yet — keep waiting.
      }
    }

    if (!ready) {
      await _killTestApp();
      throw StateError(
        'Source test app failed to start within ${timeout.inSeconds} seconds',
      );
    }
  }

  static Future<String> _resolveFlutterExecutable() async {
    final fromEnv = Platform.environment['FLUTTER_BIN'];
    if (fromEnv != null && fromEnv.isNotEmpty && File(fromEnv).existsSync()) {
      return fromEnv;
    }
    try {
      final which = await Process.run('which', ['flutter']);
      if (which.exitCode == 0) {
        final resolved = (which.stdout as String).trim();
        if (resolved.isNotEmpty) return resolved;
      }
    } catch (_) {
      // fall through
    }
    const fallback = '/srv/flutter/flutter/bin/flutter';
    if (File(fallback).existsSync()) return fallback;
    throw StateError(
      'Flutter executable not found. Set FLUTTER_BIN or ensure "flutter" '
      'is available in PATH.',
    );
  }

  /// Recycle the test app process: kill the wedged instance and start a fresh
  /// one. Used by [send] when an HTTP transport call times out, indicating the
  /// app's Dart event loop is stuck. Without recycling, the next send() would
  /// hit the same wedge and the cascade would continue.
  ///
  /// No-op if the runner did not start the app itself.
  static Future<void> _recycleTestApp() async {
    if (!_startedByRunner) {
      return;
    }
    // ignore: avoid_print
    print('[recycle] killing wedged test app (pid=${_testAppProcess?.pid})');
    try {
      await _killTestApp();
    } catch (_) {
      // Process may already be gone — proceed to restart.
    }
    // Belt-and-braces: _killTestApp kills the `flutter` wrapper, but the
    // wrapper's spawned linux/macos/windows desktop app is a separate
    // process that does NOT receive a propagated signal. Reap it via the
    // LISTEN socket on [defaultPort], then wait for the kernel to release
    // the bind before launching a replacement.
    await _killExistingProcess();
    await _waitForPortFree(timeout: const Duration(seconds: 10));
    _testAppProcess = null;
    // ignore: avoid_print
    print('[recycle] starting fresh test app');
    await _startTestApp(timeout: const Duration(seconds: 60));
    // /health is synchronous and only proves the HTTP server is up; it does
    // not exercise the widget tree. Confirm the new app's event loop is
    // actually responsive by doing a real /clear roundtrip.
    // ignore: avoid_print
    print('[recycle] verifying /clear roundtrip');
    await _httpGet(
      client,
      '/clear',
      host: defaultHost,
      port: defaultPort,
      timeout: const Duration(seconds: 8),
    );
    // ignore: avoid_print
    print('[recycle] ready');
  }

  static Future<void> _killTestApp() async {
    if (_testAppProcess != null) {
      // SIGKILL the wrapper directly — graceful 'q' is unreliable when the
      // app's Dart event loop is wedged: the wrapper sits waiting for an
      // ack that will never come. The orphaned desktop child is reaped by
      // [_killExistingProcess] right after.
      try {
        _testAppProcess!.kill(ProcessSignal.sigkill);
      } catch (_) {
        // Already exiting.
      }
      try {
        _lastTestAppExitCode = await _testAppProcess!.exitCode.timeout(
          const Duration(seconds: 3),
          onTimeout: () => -1,
        );
      } catch (_) {
        _lastTestAppExitCode = -1;
      }
      _testAppProcess = null;
    }
    // Reap any spawned-but-orphaned desktop process still bound to the port.
    // SIGKILL on the `flutter` wrapper does NOT propagate to the linux/macos/
    // windows desktop app it spawned — they're separate processes. Without
    // this cleanup, the app keeps running, stays bound to [defaultPort], and
    // the next test run's isAppRunning() returns true → _startedByRunner
    // stays false → _recycleTestApp becomes a no-op for the entire run.
    await _killExistingProcess();
  }

  /// Get the HttpClient instance (must call setUp first).
  static HttpClient get client {
    if (_client == null) {
      throw StateError('SendTestRunner.setUp() must be called first');
    }
    return _client!;
  }

  /// Send a Dart source script to the test app and return the build result.
  ///
  /// [scriptPath] is relative to [scriptsPath], e.g.
  /// `'painting/color_test.dart'`.
  ///
  /// The body is the raw Dart source — NOT JSON-encoded.
  static Future<SendResult> send(
    String scriptPath, {
    String host = defaultHost,
    int port = defaultPort,
    bool clearFirst = true,
    Duration? waitBeforeClear,
    // Step 9 follow-up: per-script override for the /build HTTP timeout
    // (default 25 s). Slow scripts whose bundle build legitimately needs
    // more than 25 s on a loaded host (e.g. gestures/least_squares_solver
    // at ~2300 lines) can raise this; the host test must also raise its
    // own dart-test wrapper timeout so the wrapper does not fire first.
    Duration? httpBuildTimeout,
  }) async {
    final packageRoot = Directory.current.path;
    final fullPath = p.join(packageRoot, scriptsPath, scriptPath);
    final file = File(fullPath);
    final totalStopwatch = Stopwatch()..start();
    var sourceChars = 0;
    var clearDuration = Duration.zero;
    var httpDuration = Duration.zero;

    if (!file.existsSync()) {
      throw StateError('Script not found: $fullPath');
    }

    // Bucket-2 cascade fix: if a previous script wedged the test app, recycle
    // it now (before /clear) so this test runs against a fresh process. The
    // previous script's test() already failed within its own 30s budget, so
    // the recycle's cost is paid once — by this test, which then also has its
    // full 30s budget for the actual work.
    if (_appNeedsRecycle) {
      _appNeedsRecycle = false;
      try {
        await _recycleTestApp();
      } catch (error, stackTrace) {
        // Recycle didn't produce a healthy app — re-arm the flag so the
        // next test tries again, and surface the failure to flutter_test.
        _appNeedsRecycle = true;
        // ignore: avoid_print
        print('[recycle] FAILED: $error');
        Error.throwWithStackTrace(
          StateError('Test app recycle failed: $error'),
          stackTrace,
        );
      }
    }

    if (clearFirst) {
      if (waitBeforeClear != null) {
        await Future<void>.delayed(waitBeforeClear);
      }
      final clearStopwatch = Stopwatch()..start();
      try {
        await _httpGet(client, '/clear', host: host, port: port);
        clearDuration = clearStopwatch.elapsed;
      } catch (error, stackTrace) {
        clearDuration = clearStopwatch.elapsed;
        // Bucket-2 cascade fix: set the recycle flag IMMEDIATELY, before any
        // slow diagnostics work. flutter_test's per-test 30s timeout can fire
        // while we're collecting diagnostics; setting first guarantees the
        // next test sees the flag even when our catch handler is racing with
        // flutter_test's test-level timeout.
        _appNeedsRecycle = true;
        final diagnostics = await _buildSendDiagnostics(
          operation: 'GET /clear',
          scriptPath: scriptPath,
          error: error,
          stackTrace: stackTrace,
          host: host,
          port: port,
        );
        _printSendMetrics(
          scriptPath: scriptPath,
          sourceChars: sourceChars,
          clearDuration: clearDuration,
          httpDuration: httpDuration,
          totalDuration: totalStopwatch.elapsed,
          status: 'clear_failed',
          httpStatus: null,
          outputLines: 0,
          frameworkErrorCount: 0,
        );
        throw StateError(diagnostics);
      }
    }

    // Read script source from disk
    final source = await file.readAsString();
    sourceChars = source.length;

    // POST raw source to /build (not JSON).
    final encodedPath = Uri.encodeComponent(scriptPath);
    late final Map<String, dynamic> response;
    final httpStopwatch = Stopwatch()..start();
    try {
      response = await _httpPostSource(
        client,
        '/build?filename=$encodedPath',
        source,
        host: host,
        port: port,
        timeout: httpBuildTimeout ?? _httpBuildTimeout,
      );
      httpDuration = httpStopwatch.elapsed;
    } catch (error, stackTrace) {
      httpDuration = httpStopwatch.elapsed;
      // Bucket-2 cascade fix: set the recycle flag IMMEDIATELY, before any
      // slow diagnostics work. flutter_test's per-test 30s timeout can fire
      // while we're collecting diagnostics; setting first guarantees the
      // next test sees the flag even when our catch handler is racing with
      // flutter_test's test-level timeout.
      _appNeedsRecycle = true;
      final diagnostics = await _buildSendDiagnostics(
        operation: 'POST /build?filename=$encodedPath',
        scriptPath: scriptPath,
        error: error,
        stackTrace: stackTrace,
        host: host,
        port: port,
      );
      _printSendMetrics(
        scriptPath: scriptPath,
        sourceChars: sourceChars,
        clearDuration: clearDuration,
        httpDuration: httpDuration,
        totalDuration: totalStopwatch.elapsed,
        status: 'transport_error',
        httpStatus: null,
        outputLines: 0,
        frameworkErrorCount: 0,
      );
      throw StateError(diagnostics);
    }

    final status = response['status'] as String;
    final output = (response['output'] as List?)?.cast<String>() ?? [];
    final httpStatus = response['_httpStatus'] as int? ?? 200;
    final frameworkErrors =
        (response['frameworkErrors'] as List?)?.cast<String>() ?? [];
    final judgment = response['judgment'] as String?;
    final remoteStackTrace = response['stackTrace'] as String?;

    _printSendMetrics(
      scriptPath: scriptPath,
      sourceChars: sourceChars,
      clearDuration: clearDuration,
      httpDuration: httpDuration,
      totalDuration: totalStopwatch.elapsed,
      status: status,
      httpStatus: httpStatus,
      outputLines: output.length,
      frameworkErrorCount: frameworkErrors.length,
    );

    if (frameworkErrors.isNotEmpty) {
      // ignore: avoid_print
      print(
        '\n  ⚠️  FRAMEWORK ERROR in $scriptPath '
        '(${frameworkErrors.length} error(s)):',
      );
      for (final err in frameworkErrors) {
        final short = err.length > 200 ? '${err.substring(0, 200)}…' : err;
        // ignore: avoid_print
        print('       $short');
      }
    }

    if (status == 'success') {
      return SendResult(
        success: true,
        widgetType: response['widgetType'] as String?,
        output: output,
        statusCode: httpStatus,
        frameworkErrors: frameworkErrors,
        judgment: judgment,
      );
    } else {
      final errorMsg = response['error'] as String?;
      if (errorMsg != null) {
        // ignore: avoid_print
        print('\n  ✗ BUILD ERROR in $scriptPath:');
        // Print each line of the error message so registration error lists are
        // fully visible even when the test framework truncates the reason string.
        for (final line in errorMsg.split('\n')) {
          // ignore: avoid_print
          print('    $line');
        }
      }
      if (remoteStackTrace != null) {
        // ignore: avoid_print
        print('\n  Stack trace (remote):');
        final stLines = remoteStackTrace.split('\n');
        final limit = stLines.length > 30 ? 30 : stLines.length;
        for (final line in stLines.take(limit)) {
          // ignore: avoid_print
          print('    $line');
        }
        if (stLines.length > 30) {
          // ignore: avoid_print
          print('    … ${stLines.length - 30} more line(s)');
        }
      }
      return SendResult(
        success: false,
        error: errorMsg,
        stackTrace: remoteStackTrace,
        output: output,
        statusCode: httpStatus,
        frameworkErrors: frameworkErrors,
        judgment: judgment,
      );
    }
  }

  /// Send a script and then interact with it.
  ///
  /// Convenience method that combines [send] and [interact].
  /// The [interactDelay] allows the overlay to appear before interaction.
  static Future<({SendResult build, InteractResult? interact})> sendAndInteract(
    String scriptPath, {
    required List<Map<String, dynamic>> actions,
    Duration interactDelay = const Duration(milliseconds: 300),
    String host = defaultHost,
    int port = defaultPort,
    bool clearFirst = true,
  }) async {
    final buildResult = await send(
      scriptPath,
      host: host,
      port: port,
      clearFirst: clearFirst,
    );

    if (!buildResult.success) {
      return (build: buildResult, interact: null);
    }

    // Wait for overlay to appear (dialog, menu, bottom sheet use microtask)
    await Future<void>.delayed(interactDelay);

    final interactResult = await interact(
      actions,
      host: host,
      port: port,
    );

    return (build: buildResult, interact: interactResult);
  }

  /// Send interaction commands to the test app.
  static Future<InteractResult> interact(
    List<Map<String, dynamic>> actions, {
    String host = defaultHost,
    int port = defaultPort,
  }) async {
    final body = jsonEncode({'actions': actions});
    try {
      final response = await _httpPost(
        client,
        '/interact',
        body,
        host: host,
        port: port,
      );
      final success = response['success'] as bool? ?? false;
      final output = (response['output'] as List?)?.cast<String>() ?? [];
      final errors = (response['errors'] as List?)?.cast<String>() ?? [];
      final httpStatus = response['_httpStatus'] as int? ?? 200;
      return InteractResult(
        success: success,
        output: output,
        errors: errors,
        statusCode: httpStatus,
      );
    } catch (error, stackTrace) {
      // ignore: avoid_print
      print('Interact error: $error\n$stackTrace');
      return InteractResult(
        success: false,
        output: [],
        errors: ['Transport error: $error'],
        statusCode: 500,
      );
    }
  }

  /// Check if the test app is running on [defaultPort].
  static Future<bool> isAppRunning({
    String host = defaultHost,
    int port = defaultPort,
  }) async {
    try {
      final httpClient = _client ?? HttpClient();
      final response = await _httpGet(
        httpClient,
        '/health',
        host: host,
        port: port,
      );
      return response['status'] == 'ok';
    } catch (_) {
      return false;
    }
  }

  /// Clear the test app UI.
  static Future<void> clearApp({
    String host = defaultHost,
    int port = defaultPort,
  }) async {
    await _httpGet(client, '/clear', host: host, port: port);
  }

  /// Get the app logs.
  static Future<List<String>> getAppLogs({
    String host = defaultHost,
    int port = defaultPort,
  }) async {
    final response = await _httpGet(client, '/logs', host: host, port: port);
    return (response['logs'] as List?)?.cast<String>() ?? [];
  }

  /// Get the scripts directory.
  static Directory getScriptsDirectory() {
    final packageRoot = Directory.current.path;
    return Directory(p.join(packageRoot, scriptsPath));
  }

  /// Find all Dart script files in the scripts directory (recursively).
  static List<File> findAllScripts() {
    final scriptsDir = getScriptsDirectory();
    if (!scriptsDir.existsSync()) {
      throw StateError('Scripts directory not found: ${scriptsDir.path}');
    }
    return scriptsDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));
  }

  /// Get a script path relative to [scriptsPath].
  static String getRelativePath(File script) {
    final scriptsDir = getScriptsDirectory();
    return p.relative(script.path, from: scriptsDir.path);
  }

  static void _captureProcessStream(
    Stream<List<int>> stream,
    List<String> sink,
  ) {
    // ignore: unawaited_futures
    utf8.decoder.bind(stream).transform(const LineSplitter()).listen((line) {
      _appendProcessTail(sink, line);
    });
  }

  static void _appendProcessTail(List<String> sink, String line) {
    sink.add(line);
    if (sink.length > _processLogTailLimit) {
      sink.removeRange(0, sink.length - _processLogTailLimit);
    }
  }

  static Future<String> _buildSendDiagnostics({
    required String operation,
    required String scriptPath,
    required Object error,
    required StackTrace stackTrace,
    required String host,
    required int port,
  }) async {
    final buffer = StringBuffer()
      ..writeln('Transport failure while running "$scriptPath"')
      ..writeln('Operation: $operation')
      ..writeln('Error: $error')
      ..writeln('')
      ..writeln('Stack trace:')
      ..writeln(stackTrace);

    final process = _testAppProcess;
    if (process == null) {
      buffer
        ..writeln('')
        ..writeln(
          'Runner app process: not managed by SendTestRunner (external app).',
        );
    } else if (_lastTestAppExitCode == null) {
      buffer
        ..writeln('')
        ..writeln(
          'Runner app process: still running (no exit code observed).',
        );
    } else {
      buffer
        ..writeln('')
        ..writeln(
          'Runner app process: exited with code $_lastTestAppExitCode',
        );
    }

    final remoteLogs = await _tryFetchRemoteAppLogs(host: host, port: port);
    if (remoteLogs.isNotEmpty) {
      buffer
        ..writeln('')
        ..writeln('Recent app /logs tail:');
      for (final line in remoteLogs) {
        buffer.writeln('  $line');
      }
    }

    if (_testAppStdoutTail.isNotEmpty) {
      buffer
        ..writeln('')
        ..writeln('Captured app STDOUT tail:');
      for (final line in _testAppStdoutTail) {
        buffer.writeln('  $line');
      }
    }
    if (_testAppStderrTail.isNotEmpty) {
      buffer
        ..writeln('')
        ..writeln('Captured app STDERR tail:');
      for (final line in _testAppStderrTail) {
        buffer.writeln('  $line');
      }
    }

    return buffer.toString();
  }

  static void _printSendMetrics({
    required String scriptPath,
    required int sourceChars,
    required Duration clearDuration,
    required Duration httpDuration,
    required Duration totalDuration,
    required String status,
    required int? httpStatus,
    required int outputLines,
    required int frameworkErrorCount,
  }) {
    // ignore: avoid_print
    print(
      '[METRIC] script=$scriptPath sourceChars=$sourceChars '
      'clearMs=${clearDuration.inMilliseconds} '
      'httpMs=${httpDuration.inMilliseconds} '
      'totalMs=${totalDuration.inMilliseconds} '
      'status=$status httpStatus=${httpStatus ?? -1} '
      'outputLines=$outputLines frameworkErrors=$frameworkErrorCount',
    );
  }

  static Future<List<String>> _tryFetchRemoteAppLogs({
    required String host,
    required int port,
  }) async {
    try {
      final tempClient = HttpClient();
      try {
        final response = await _httpGet(
          tempClient,
          '/logs',
          host: host,
          port: port,
        );
        final logs = (response['logs'] as List?)?.cast<String>() ?? const [];
        if (logs.length <= 40) return logs;
        return logs.sublist(logs.length - 40);
      } finally {
        tempClient.close();
      }
    } catch (_) {
      return const [];
    }
  }
}

// ── Private HTTP helpers ─────────────────────────────────────────────────────

// Bucket-2 cascade fix: every HTTP helper enforces a hard timeout. Without
// these caps, a wedged test-app event loop made the harness hang
// indefinitely; flutter_test's per-test 30s timeout then killed each
// subsequent test in turn, cascading through the rest of the suite. With
// the timeouts the harness fails fast on transport, the catch sites in
// send() observe the failure, recycle the app, and the next script runs
// against a fresh process.
const Duration _httpClearTimeout = Duration(seconds: 5);
const Duration _httpBuildTimeout = Duration(seconds: 25);

Future<Map<String, dynamic>> _httpGet(
  HttpClient client,
  String path, {
  required String host,
  required int port,
  Duration timeout = _httpClearTimeout,
}) async {
  return Future<Map<String, dynamic>>(() async {
    final request = await client.getUrl(Uri.parse('http://$host:$port$path'));
    final response = await request.close();
    final body = await utf8.decoder.bind(response).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    json['_httpStatus'] = response.statusCode;
    return json;
  }).timeout(timeout);
}

/// POST with a JSON body (used for /interact).
Future<Map<String, dynamic>> _httpPost(
  HttpClient client,
  String path,
  String body, {
  required String host,
  required int port,
  Duration timeout = _httpBuildTimeout,
}) async {
  return Future<Map<String, dynamic>>(() async {
    final request = await client.postUrl(Uri.parse('http://$host:$port$path'));
    request.headers.contentType = ContentType.json;
    request.write(body);
    final response = await request.close();
    final responseBody = await utf8.decoder.bind(response).join();
    final json = jsonDecode(responseBody) as Map<String, dynamic>;
    json['_httpStatus'] = response.statusCode;
    return json;
  }).timeout(timeout);
}

/// POST raw Dart source as plain text (used for /build).
Future<Map<String, dynamic>> _httpPostSource(
  HttpClient client,
  String path,
  String source, {
  required String host,
  required int port,
  Duration timeout = _httpBuildTimeout,
}) async {
  return Future<Map<String, dynamic>>(() async {
    final request = await client.postUrl(Uri.parse('http://$host:$port$path'));
    request.headers.contentType =
        ContentType('text', 'plain', charset: 'utf-8');
    request.write(source);
    final response = await request.close();
    final responseBody = await utf8.decoder.bind(response).join();
    final json = jsonDecode(responseBody) as Map<String, dynamic>;
    json['_httpStatus'] = response.statusCode;
    return json;
  }).timeout(timeout);
}

// =============================================================================
// Main test that runs all scripts
// =============================================================================

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(startApp: false);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  test('send all source scripts to app', () async {
    final isRunning = await SendTestRunner.isAppRunning();
    expect(
      isRunning,
      isTrue,
      reason:
          'App server must be running on port ${SendTestRunner.defaultPort}. '
          'Start it with: cd test/tom_d4rt_flutter_test_app && flutter run -d linux',
    );

    final scripts = SendTestRunner.findAllScripts();
    expect(
      scripts,
      isNotEmpty,
      reason:
          'No test scripts found in ${SendTestRunner.getScriptsDirectory().path}',
    );

    // ignore: avoid_print
    print('\n${'=' * 60}');
    // ignore: avoid_print
    print('Found ${scripts.length} source script(s):');
    for (final script in scripts) {
      // ignore: avoid_print
      print('  - ${SendTestRunner.getRelativePath(script)}');
    }
    // ignore: avoid_print
    print('${'=' * 60}\n');

    var passedCount = 0;
    var failedCount = 0;
    final failedScripts = <String>[];

    for (final script in scripts) {
      final relativePath = SendTestRunner.getRelativePath(script);
      // ignore: avoid_print
      print('\n--- Running: $relativePath ---');

      try {
        final result = await SendTestRunner.send(relativePath);

        if (result.output.isNotEmpty) {
          // ignore: avoid_print
          print('  Script output:');
          for (final line in result.output) {
            // ignore: avoid_print
            print('    > $line');
          }
        }

        if (result.success) {
          final jLabel = result.judgment != null ? ' [${result.judgment}]' : '';
          // ignore: avoid_print
          print('  ✓ Widget rendered: ${result.widgetType}$jLabel');
          passedCount++;
        } else {
          final jLabel = result.judgment != null ? ' [${result.judgment}]' : '';
          // ignore: avoid_print
          print('  ✗ Build failed: ${result.error}$jLabel');
          failedCount++;
          failedScripts.add('$relativePath: ${result.error}');
        }
      } catch (e) {
        // ignore: avoid_print
        print('  ✗ Exception: $e');
        failedCount++;
        failedScripts.add('$relativePath: EXCEPTION - $e');
      }
    }

    // ignore: avoid_print
    print('\n${'=' * 60}');
    if (failedCount == 0) {
      // ignore: avoid_print
      print('All ${scripts.length} scripts executed successfully!');
    } else {
      // ignore: avoid_print
      print(
        'Results: $passedCount passed, $failedCount failed '
        'out of ${scripts.length}',
      );
      // ignore: avoid_print
      print('\nFailed scripts:');
      for (final s in failedScripts) {
        // ignore: avoid_print
        print('  ✗ $s');
      }
    }
    // ignore: avoid_print
    print('${'=' * 60}\n');

    if (failedCount > 0) {
      fail('$failedCount of ${scripts.length} scripts failed');
    }
  });
}
