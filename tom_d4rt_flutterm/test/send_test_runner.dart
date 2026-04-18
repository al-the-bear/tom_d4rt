/// Test runner that builds AST bundles from test scripts and sends them
/// to the tom_d4rt_flutterm_app via HTTP.
///
/// Scripts are located in:
///   test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/
///
/// Each script must contain a `dynamic build(BuildContext context)` function
/// that returns a Widget.
///
/// The app captures print() output from scripts and returns it in the response.
///
/// Usage in tests:
/// ```dart
/// test('my test', () async {
///   final result = await SendTestRunner.send('painting/color_test.dart');
///   expect(result.success, isTrue);
///   expect(result.widgetType, contains('Container'));
/// });
/// ```
///
/// Run with: flutter test test/send_test_runner.dart
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt_flutterm/tom_d4rt_flutterm.dart';

/// Result of sending a D4rt script to the test app.
class SendResult {
  /// Whether the build succeeded.
  final bool success;

  /// The runtime type of the built widget (on success).
  final String? widgetType;

  /// Error message (on failure).
  final String? error;

  /// Captured print() output from the script.
  final List<String> output;

  /// HTTP status code.
  final int statusCode;

  /// Flutter framework errors captured after layout/paint (e.g. RenderBox
  /// overflow, constraint violations).  Non-empty means a red error screen
  /// was rendered even though the D4rt build itself may have succeeded.
  final List<String> frameworkErrors;

  /// User judgment from the test app UI ('good' or 'needs rewrite').
  final String? judgment;

  const SendResult({
    required this.success,
    this.widgetType,
    this.error,
    required this.output,
    required this.statusCode,
    this.frameworkErrors = const [],
    this.judgment,
  });

  /// Whether a Flutter red error screen was detected after layout/paint.
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
  /// Whether all interactions succeeded.
  final bool success;

  /// Captured output from interactions.
  final List<String> output;

  /// Errors from failed interactions.
  final List<String> errors;

  /// HTTP status code.
  final int statusCode;

  const InteractResult({
    required this.success,
    required this.output,
    required this.errors,
    required this.statusCode,
  });

  @override
  String toString() {
    if (success) {
      return 'InteractResult(success, output: $output)';
    }
    return 'InteractResult(failed, errors: $errors, output: $output)';
  }
}

/// Test runner for sending D4rt scripts to the test app.
///
/// Provides both static methods for individual script execution and
/// a test that runs all scripts in the scripts directory.
class SendTestRunner {
  /// Default HTTP port for the test app.
  static const int defaultPort = 4247;

  /// Default HTTP host for the test app.
  static const String defaultHost = 'localhost';

  /// Scripts directory relative to package root.
  static const String scriptsPath =
      'test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts';

  /// Test app directory relative to package root.
  static const String testAppPath = 'test/tom_d4rt_flutterm_app';

  static FlutterD4rt? _d4rt;
  static HttpClient? _client;
  static Process? _testAppProcess;
  static bool _startedByRunner = false;
  static bool _bridgesRegenerated = false;
  static const String _forceBridgeRegenEnv = 'D4RT_FORCE_BRIDGE_REGEN';
  static const String _skipBridgeRegenEnv = 'D4RT_SKIP_BRIDGE_REGEN';
  static const int _processLogTailLimit = 200;

  static final List<String> _testAppStdoutTail = <String>[];
  static final List<String> _testAppStderrTail = <String>[];
  static int? _lastTestAppExitCode;

  /// Initialize the test runner (call in setUpAll).
  ///
  /// This will:
  /// 1. Reuse a running test app when available
  /// 2. Otherwise, start a new test app process
  /// 3. Wait for it to be ready
  static Future<void> setUp({
    bool startApp = true,
    bool regenerateBridges = true,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    _d4rt = FlutterD4rt();
    _client = HttpClient();
    _startedByRunner = false;

    if (regenerateBridges) {
      await _ensureBridgesRegenerated();
    }

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

  static Future<void> _ensureBridgesRegenerated() async {
    if (_bridgesRegenerated) {
      return;
    }

    if (_isEnvEnabled(_skipBridgeRegenEnv)) {
      // Keep setUpAll output clean so operational status lines do not get
      // indexed as test issues in summary reports.
      _bridgesRegenerated = true;
      return;
    }

    final staleness = _isEnvEnabled(_forceBridgeRegenEnv)
        ? (stale: true, reason: 'forced via $_forceBridgeRegenEnv')
        : await _evaluateBridgeStaleness();
    if (!staleness.stale) {
      _bridgesRegenerated = true;
      return;
    }

    final packageRoot = Directory.current.path;
    final dartExecutable = await _resolveDartExecutable();
    final result = await Process.run(dartExecutable, [
      'run',
      'tool/regenerate_bridges.dart',
    ], workingDirectory: packageRoot);

    if (result.exitCode != 0) {
      final output = [
        if ((result.stdout as String).trim().isNotEmpty)
          'stdout:\n${result.stdout}',
        if ((result.stderr as String).trim().isNotEmpty)
          'stderr:\n${result.stderr}',
      ].join('\n');
      throw StateError('Bridge regeneration failed before tests.\n$output');
    }

    _bridgesRegenerated = true;
  }

  static bool _isEnvEnabled(String key) {
    final value = Platform.environment[key];
    if (value == null) {
      return false;
    }
    final normalized = value.trim().toLowerCase();
    return normalized == '1' ||
        normalized == 'true' ||
        normalized == 'yes' ||
        normalized == 'on';
  }

  static Future<({bool stale, String reason})>
  _evaluateBridgeStaleness() async {
    final packageRoot = Directory.current.path;
    final bridgesDir = Directory(p.join(packageRoot, 'lib', 'src', 'bridges'));
    if (!bridgesDir.existsSync()) {
      return (
        stale: true,
        reason: 'bridges directory missing: ${bridgesDir.path}',
      );
    }

    final outputs = bridgesDir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.b.dart'))
        .toList();
    if (outputs.isEmpty) {
      return (
        stale: true,
        reason: 'no generated bridge outputs found in ${bridgesDir.path}',
      );
    }

    File oldestOutputFile = outputs.first;
    DateTime oldestOutput = oldestOutputFile.lastModifiedSync();
    for (final output in outputs.skip(1)) {
      final modified = output.lastModifiedSync();
      if (modified.isBefore(oldestOutput)) {
        oldestOutput = modified;
        oldestOutputFile = output;
      }
    }

    final inputCandidates = <({File file, String label})>[
      (
        file: File(p.join(packageRoot, 'buildkit.yaml')),
        label: 'buildkit.yaml',
      ),
      (
        file: File(p.join(packageRoot, 'tool', 'regenerate_bridges.dart')),
        label: 'tool/regenerate_bridges.dart',
      ),
    ].where((candidate) => candidate.file.existsSync());

    if (inputCandidates.isEmpty) {
      return (
        stale: true,
        reason:
            'bridge freshness inputs missing (buildkit.yaml + regenerate script)',
      );
    }

    DateTime newestInput = DateTime.fromMillisecondsSinceEpoch(0);
    String newestInputLabel = 'none';
    for (final input in inputCandidates) {
      final modified = input.file.lastModifiedSync();
      if (modified.isAfter(newestInput)) {
        newestInput = modified;
        newestInputLabel = input.label;
      }
    }

    final generatorRoot = await _resolveLocalPackageRoot(
      packageName: 'tom_d4rt_generator',
    );
    if (generatorRoot != null && generatorRoot.existsSync()) {
      final generatorNewest = _newestGeneratorInput(generatorRoot);
      if (generatorNewest != null &&
          generatorNewest.modified.isAfter(newestInput)) {
        newestInput = generatorNewest.modified;
        newestInputLabel = p.relative(
          generatorNewest.file.path,
          from: packageRoot,
        );
      }
    }

    if (oldestOutput.isBefore(newestInput)) {
      return (
        stale: true,
        reason:
            'newer input $newestInputLabel (${_fmtTimestamp(newestInput)}) '
            'than oldest output '
            '${p.relative(oldestOutputFile.path, from: packageRoot)} '
            '(${_fmtTimestamp(oldestOutput)})',
      );
    }

    return (
      stale: false,
      reason:
          'all bridge outputs are up-to-date; newest input $newestInputLabel '
          '(${_fmtTimestamp(newestInput)}), oldest output '
          '${p.relative(oldestOutputFile.path, from: packageRoot)} '
          '(${_fmtTimestamp(oldestOutput)})',
    );
  }

  static Future<Directory?> _resolveLocalPackageRoot({
    required String packageName,
  }) async {
    final packageRoot = Directory.current.path;
    final packageConfig = File(
      p.join(packageRoot, '.dart_tool', 'package_config.json'),
    );
    if (!packageConfig.existsSync()) {
      return null;
    }

    try {
      final decoded =
          jsonDecode(await packageConfig.readAsString())
              as Map<String, dynamic>;
      final packages = decoded['packages'];
      if (packages is! List) {
        return null;
      }

      for (final entry in packages.whereType<Map<String, dynamic>>()) {
        if (entry['name'] != packageName) {
          continue;
        }
        final rootUriRaw = entry['rootUri'];
        if (rootUriRaw is! String || rootUriRaw.isEmpty) {
          return null;
        }

        final uri = Uri.parse(rootUriRaw);
        if (uri.scheme == 'file') {
          return Directory(uri.toFilePath());
        }

        final resolvedPath = p.normalize(p.join(packageRoot, uri.toFilePath()));
        return Directory(resolvedPath);
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  static ({DateTime modified, File file})? _newestGeneratorInput(
    Directory generatorRoot,
  ) {
    ({DateTime modified, File file})? newest;

    void considerFile(File file) {
      if (!file.existsSync()) {
        return;
      }
      final modified = file.lastModifiedSync();
      if (newest == null || modified.isAfter(newest!.modified)) {
        newest = (modified: modified, file: file);
      }
    }

    considerFile(File(p.join(generatorRoot.path, 'pubspec.yaml')));
    considerFile(File(p.join(generatorRoot.path, 'buildkit.yaml')));

    for (final subDirName in ['lib', 'tool']) {
      final subDir = Directory(p.join(generatorRoot.path, subDirName));
      if (!subDir.existsSync()) {
        continue;
      }
      for (final entity in subDir.listSync(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is File && entity.path.endsWith('.dart')) {
          considerFile(entity);
        }
      }
    }

    return newest;
  }

  static String _fmtTimestamp(DateTime value) => value.toIso8601String();

  static Future<String> _resolveDartExecutable() async {
    final fromEnv = Platform.environment['DART_BIN'];
    if (fromEnv != null && fromEnv.isNotEmpty && File(fromEnv).existsSync()) {
      return fromEnv;
    }

    try {
      final which = await Process.run('which', ['dart']);
      if (which.exitCode == 0) {
        final resolved = (which.stdout as String).trim();
        if (resolved.isNotEmpty) {
          return resolved;
        }
      }
    } catch (_) {
      // Fall through to Flutter-adjacent dart resolution.
    }

    final flutterExecutable = await _resolveFlutterExecutable();
    final flutterBinDir = p.dirname(flutterExecutable);
    final dartSibling = p.join(flutterBinDir, 'dart');
    if (File(dartSibling).existsSync()) {
      return dartSibling;
    }

    throw StateError(
      'Dart executable not found. Set DART_BIN or ensure "dart" '
      'is available in PATH.',
    );
  }

  /// Tear down the test runner (call in tearDownAll).
  ///
  /// This will kill the test app process only if it was started by setUp.
  ///
  /// Note: You may see a "Shell subprocess crashed with SIGTERM" error from
  /// Flutter's test framework. This is expected when killing external processes
  /// spawned during flutter test and does not indicate an actual problem.
  static Future<void> tearDown() async {
    final shouldStopApp = _startedByRunner;

    _client?.close();
    _client = null;
    _d4rt = null;
    _startedByRunner = false;

    if (shouldStopApp) {
      try {
        await _killTestApp();
      } catch (_) {
        // Ignore errors during shutdown - process may already be gone.
      }
    }
  }

  /// Kill any existing test app process on the port.
  static Future<void> _killExistingProcess() async {
    try {
      // Find process using port
      final result = await Process.run('lsof', ['-t', '-i', ':$defaultPort']);
      final pids = result.stdout
          .toString()
          .trim()
          .split('\n')
          .where((s) => s.isNotEmpty);

      for (final pidStr in pids) {
        final pid = int.tryParse(pidStr);
        if (pid != null) {
          Process.killPid(pid, ProcessSignal.sigterm);
        }
      }

      // Wait briefly for processes to die
      if (pids.isNotEmpty) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }
    } catch (_) {
      // Ignore errors - process may not exist
    }
  }

  /// Start the test app process.
  static Future<void> _startTestApp({required Duration timeout}) async {
    // Start the test app
    final packageRoot = Directory.current.path;
    final appDir = p.join(packageRoot, testAppPath);
    final flutterExecutable = await _resolveFlutterExecutable();

    // Use the current platform's desktop device
    final device = Platform.isMacOS
        ? 'macos'
        : Platform.isWindows
        ? 'windows'
        : 'linux';

    _testAppProcess = await Process.start(
      flutterExecutable,
      ['run', '-d', device],
      workingDirectory: appDir,
      // Don't inherit stdio to avoid crash when killing process
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

    // Wait for app to be ready
    final deadline = DateTime.now().add(timeout);
    var ready = false;

    while (DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(seconds: 2));
      try {
        // Try to connect to health endpoint
        final tempClient = HttpClient();
        try {
          final request = await tempClient.get(
            defaultHost,
            defaultPort,
            '/health',
          );
          final response = await request.close();
          if (response.statusCode == 200) {
            ready = true;
            break;
          }
        } finally {
          tempClient.close();
        }
      } catch (_) {
        // Not ready yet, keep waiting
      }
    }

    if (!ready) {
      await _killTestApp();
      throw StateError(
        'Test app failed to start within ${timeout.inSeconds} seconds',
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
        if (resolved.isNotEmpty) {
          return resolved;
        }
      }
    } catch (_) {
      // Fall through to known workspace default path.
    }

    const fallback = '/srv/flutter/flutter/bin/flutter';
    if (File(fallback).existsSync()) {
      return fallback;
    }

    throw StateError(
      'Flutter executable not found. Set FLUTTER_BIN or ensure "flutter" '
      'is available in PATH.',
    );
  }

  /// Kill the test app process.
  static Future<void> _killTestApp() async {
    if (_testAppProcess != null) {
      // Try graceful shutdown first by sending 'q' to stdin
      try {
        _testAppProcess!.stdin.writeln('q');
        await _testAppProcess!.stdin.flush();
      } catch (_) {
        // Ignore if stdin is closed
      }

      // Wait for graceful exit
      final exitCode = await _testAppProcess!.exitCode.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Forceful kill if graceful exit times out
          _testAppProcess!.kill(ProcessSignal.sigterm);
          return -1;
        },
      );

      // If still not dead, force kill
      if (exitCode == -1) {
        await Future<void>.delayed(const Duration(seconds: 2));
        _testAppProcess!.kill(ProcessSignal.sigkill);
      }

      _testAppProcess = null;
      _lastTestAppExitCode = exitCode;
    }
  }

  /// Get the FlutterD4rt instance.
  static FlutterD4rt get d4rt {
    if (_d4rt == null) {
      throw StateError('SendTestRunner.setUp() must be called first');
    }
    return _d4rt!;
  }

  /// Get the HttpClient instance.
  static HttpClient get client {
    if (_client == null) {
      throw StateError('SendTestRunner.setUp() must be called first');
    }
    return _client!;
  }

  /// Send a script to the test app and return the result.
  ///
  /// [scriptPath] is the path relative to the scripts directory, e.g.,
  /// 'color_test.dart' or 'painting/border_test.dart'.
  ///
  /// The test app must be running on [host]:[port].
  ///
  /// If [clearFirst] is true (default), clears the app UI before sending.
  ///
  /// If [includeSource] is true, the original Dart source code is included
  /// in the bundle alongside the compiled AST. Disabled by default.
  /// Default per-script timeout. If a script does not return a response
  /// within this window, the test app is force-killed and restarted before
  /// either retrying (once) or failing the test with a helpful diagnostic.
  static const Duration defaultScriptTimeout = Duration(seconds: 30);

  /// Send a script to the test app, enforcing a per-call timeout.
  ///
  /// Each call is attempted at most twice: on the first timeout the test
  /// app is force-killed and restarted, then the send is retried. On a
  /// second timeout the app is restarted again (to leave a clean slate
  /// for the next test) and a [TimeoutException] is thrown carrying the
  /// script path, attempt count, and captured app output so the failing
  /// test report explains what happened.
  static Future<SendResult> send(
    String scriptPath, {
    String host = defaultHost,
    int port = defaultPort,
    bool clearFirst = true,
    bool includeSource = false,
    Duration timeout = defaultScriptTimeout,
  }) async {
    const maxAttempts = 2;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await _sendOnce(
          scriptPath,
          host: host,
          port: port,
          clearFirst: clearFirst,
          includeSource: includeSource,
        ).timeout(timeout);
      } on TimeoutException {
        final stdoutTail = _tailSnapshot(_testAppStdoutTail);
        final stderrTail = _tailSnapshot(_testAppStderrTail);
        // ignore: avoid_print
        print(
          '\n  ⏱️  TIMEOUT on $scriptPath after ${timeout.inSeconds}s '
          '(attempt $attempt/$maxAttempts) — restarting test app…',
        );
        _printSendMetrics(
          scriptPath: scriptPath,
          sourceBytes: 0,
          sourceChars: 0,
          bundleJsonBytes: 0,
          clearDuration: Duration.zero,
          readDuration: Duration.zero,
          bundleDuration: Duration.zero,
          httpDuration: timeout,
          totalDuration: timeout,
          status: attempt == maxAttempts ? 'timeout_final' : 'timeout_retry',
          httpStatus: null,
          outputLines: 0,
          frameworkErrorCount: 0,
        );
        try {
          await _restartTestApp();
        } catch (restartError) {
          // ignore: avoid_print
          print('  ⚠️  Test app restart failed: $restartError');
        }
        if (attempt == maxAttempts) {
          throw TimeoutException(
            'Script "$scriptPath" timed out twice at '
            '${timeout.inSeconds}s. Test app was restarted between '
            'attempts and again after the final timeout; moving on.\n'
            '--- tail of test app stdout ---\n'
            '${stdoutTail.isEmpty ? '(empty)' : stdoutTail}\n'
            '--- tail of test app stderr ---\n'
            '${stderrTail.isEmpty ? '(empty)' : stderrTail}',
            timeout,
          );
        }
      }
    }
    // Unreachable: loop either returns or throws.
    throw StateError('SendTestRunner.send: unreachable');
  }

  static String _tailSnapshot(List<String> tail) {
    if (tail.isEmpty) return '';
    final start = tail.length > 30 ? tail.length - 30 : 0;
    return tail.sublist(start).join('\n');
  }

  /// Force-kill the current test app process (SIGKILL) and start a fresh
  /// one. Used after a script timeout where graceful shutdown via stdin
  /// 'q' is unreliable because the app is blocked executing the script.
  static Future<void> _restartTestApp({
    Duration startTimeout = const Duration(seconds: 60),
  }) async {
    await _forceKillTestApp();
    await _killExistingProcess();
    await _startTestApp(timeout: startTimeout);
    _startedByRunner = true;
  }

  /// Hard-kill the current test app (SIGKILL) without waiting for the
  /// graceful stdin-'q' handshake. The app is assumed hung.
  static Future<void> _forceKillTestApp() async {
    final proc = _testAppProcess;
    if (proc == null) return;
    try {
      proc.kill(ProcessSignal.sigkill);
      await proc.exitCode.timeout(
        const Duration(seconds: 5),
        onTimeout: () => -9,
      );
    } catch (_) {
      // Ignore — the process may already be dead.
    }
    _testAppProcess = null;
  }

  static Future<SendResult> _sendOnce(
    String scriptPath, {
    String host = defaultHost,
    int port = defaultPort,
    bool clearFirst = true,
    bool includeSource = false,
  }) async {
    final packageRoot = Directory.current.path;
    final fullPath = p.join(packageRoot, scriptsPath, scriptPath);
    final file = File(fullPath);
    final totalStopwatch = Stopwatch()..start();
    var sourceBytes = 0;
    var sourceChars = 0;
    var bundleJsonBytes = 0;
    var clearDuration = Duration.zero;
    var readDuration = Duration.zero;
    var bundleDuration = Duration.zero;
    var httpDuration = Duration.zero;

    if (!file.existsSync()) {
      throw StateError('Script not found: $fullPath');
    }

    // Clear UI first if requested
    if (clearFirst) {
      final clearStopwatch = Stopwatch()..start();
      try {
        await _httpGet(client, '/clear', host: host, port: port);
        clearDuration = clearStopwatch.elapsed;
      } catch (error, stackTrace) {
        clearDuration = clearStopwatch.elapsed;
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
          sourceBytes: sourceBytes,
          sourceChars: sourceChars,
          bundleJsonBytes: bundleJsonBytes,
          clearDuration: clearDuration,
          readDuration: readDuration,
          bundleDuration: bundleDuration,
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

    // Build bundle from script source
    final readStopwatch = Stopwatch()..start();
    final source = await file.readAsString();
    sourceBytes = await file.length();
    sourceChars = source.length;
    readDuration = readStopwatch.elapsed;

    final bundleStopwatch = Stopwatch()..start();
    var bundle = await d4rt.interpreter.createBundleFromSource(source);

    // Optionally include source code alongside the AST
    if (includeSource) {
      bundle = AstBundle(
        entryPointUri: bundle.entryPointUri,
        modules: bundle.modules,
        sources: {bundle.entryPointUri: source},
      );
    }

    final bundleJson = jsonEncode(bundle.toJson());
    bundleJsonBytes = utf8.encode(bundleJson).length;
    bundleDuration = bundleStopwatch.elapsed;

    // Send bundle to app (pass filename for display in test app UI)
    final encodedPath = Uri.encodeComponent(scriptPath);
    late final Map<String, dynamic> response;
    final httpStopwatch = Stopwatch()..start();
    try {
      response = await _httpPost(
        client,
        '/build?filename=$encodedPath',
        bundleJson,
        host: host,
        port: port,
      );
      httpDuration = httpStopwatch.elapsed;
    } catch (error, stackTrace) {
      httpDuration = httpStopwatch.elapsed;
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
        sourceBytes: sourceBytes,
        sourceChars: sourceChars,
        bundleJsonBytes: bundleJsonBytes,
        clearDuration: clearDuration,
        readDuration: readDuration,
        bundleDuration: bundleDuration,
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

    _printSendMetrics(
      scriptPath: scriptPath,
      sourceBytes: sourceBytes,
      sourceChars: sourceChars,
      bundleJsonBytes: bundleJsonBytes,
      clearDuration: clearDuration,
      readDuration: readDuration,
      bundleDuration: bundleDuration,
      httpDuration: httpDuration,
      totalDuration: totalStopwatch.elapsed,
      status: status,
      httpStatus: httpStatus,
      outputLines: output.length,
      frameworkErrorCount: frameworkErrors.length,
    );

    // Log framework errors (red error screens) prominently so they are
    // visible in test output even when the D4rt build itself succeeded.
    if (frameworkErrors.isNotEmpty) {
      // ignore: avoid_print
      print(
        '\n  ⚠️  FRAMEWORK ERROR in $scriptPath '
        '(${frameworkErrors.length} error(s)):',
      );
      for (final err in frameworkErrors) {
        // Truncate very long messages for readability
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
      return SendResult(
        success: false,
        error: response['error'] as String?,
        output: output,
        statusCode: httpStatus,
        frameworkErrors: frameworkErrors,
        judgment: judgment,
      );
    }
  }

  /// Send interaction commands to the test app.
  ///
  /// This sends a list of actions to be executed on the currently rendered
  /// widget. Useful for interacting with dialogs, menus, bottom sheets, etc.
  ///
  /// Example:
  /// ```dart
  /// await SendTestRunner.send('material/showdialog_test.dart');
  /// // Wait for dialog to appear
  /// final result = await SendTestRunner.interact([
  ///   {'type': 'waitFrames', 'frames': 10},
  ///   {'type': 'tapText', 'text': 'OK'},
  /// ]);
  /// expect(result.success, isTrue);
  /// ```
  ///
  /// Supported action types:
  /// - `waitFrames`: Wait for N frames (default: 1)
  /// - `waitMillis`: Wait for N milliseconds (default: 100)
  /// - `tapAt`: Tap at screen position (x, y)
  /// - `tapText`: Find and tap widget containing text
  /// - `tapType`: Find and tap widget by type name
  /// - `tapIcon`: Find and tap Icon widget by icon name
  /// - `dismiss`: Tap in corner to dismiss modal overlay
  /// - `drag`: Drag from (startX, startY) to (endX, endY) over duration ms
  /// - `dragVertical`: Drag vertically from center by distance px
  /// - `back`: Press back button / pop navigation
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
    bool includeSource = false,
  }) async {
    final buildResult = await send(
      scriptPath,
      host: host,
      port: port,
      clearFirst: clearFirst,
      includeSource: includeSource,
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

  /// Check if the test app is running.
  static Future<bool> isAppRunning({
    String host = defaultHost,
    int port = defaultPort,
  }) async {
    try {
      final response = await _httpGet(
        client,
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

  /// Find all script files in the scripts directory (recursively).
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

  /// Get the relative path of a script file from the scripts directory.
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
        ..writeln('Runner app process: not managed by SendTestRunner')
        ..writeln('  (likely connected to an externally started app).');
    } else if (_lastTestAppExitCode == null) {
      buffer
        ..writeln('')
        ..writeln('Runner app process: still running (no exit code observed).');
    } else {
      buffer
        ..writeln('')
        ..writeln('Runner app process: exited with code $_lastTestAppExitCode');
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
    required int sourceBytes,
    required int sourceChars,
    required int bundleJsonBytes,
    required Duration clearDuration,
    required Duration readDuration,
    required Duration bundleDuration,
    required Duration httpDuration,
    required Duration totalDuration,
    required String status,
    required int? httpStatus,
    required int outputLines,
    required int frameworkErrorCount,
  }) {
    // ignore: avoid_print
    print(
      '[METRIC] script=$scriptPath '
      'sourceBytes=$sourceBytes sourceChars=$sourceChars '
      'bundleJsonBytes=$bundleJsonBytes '
      'clearMs=${clearDuration.inMilliseconds} '
      'readMs=${readDuration.inMilliseconds} '
      'bundleMs=${bundleDuration.inMilliseconds} '
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
        if (logs.length <= 40) {
          return logs;
        }
        return logs.sublist(logs.length - 40);
      } finally {
        tempClient.close();
      }
    } catch (_) {
      return const [];
    }
  }
}

// Private HTTP helpers

Future<Map<String, dynamic>> _httpGet(
  HttpClient client,
  String path, {
  required String host,
  required int port,
}) async {
  final request = await client.getUrl(Uri.parse('http://$host:$port$path'));
  final response = await request.close();
  final body = await utf8.decoder.bind(response).join();
  final json = jsonDecode(body) as Map<String, dynamic>;
  json['_httpStatus'] = response.statusCode;
  return json;
}

Future<Map<String, dynamic>> _httpPost(
  HttpClient client,
  String path,
  String body, {
  required String host,
  required int port,
}) async {
  final request = await client.postUrl(Uri.parse('http://$host:$port$path'));
  request.headers.contentType = ContentType.json;
  request.write(body);
  final response = await request.close();
  final responseBody = await utf8.decoder.bind(response).join();
  final json = jsonDecode(responseBody) as Map<String, dynamic>;
  json['_httpStatus'] = response.statusCode;
  return json;
}

// =============================================================================
// Main test that runs all scripts
// =============================================================================

void main() {
  setUpAll(() async {
    // Don't start app automatically - user should start it manually
    // for this test since it's for interactive debugging
    await SendTestRunner.setUp(startApp: false);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  test('send all test scripts to app', () async {
    // Check server is running
    final isRunning = await SendTestRunner.isAppRunning();
    expect(
      isRunning,
      isTrue,
      reason:
          'App server must be running on port ${SendTestRunner.defaultPort}',
    );

    // Find all .dart scripts (recursively)
    final scripts = SendTestRunner.findAllScripts();

    expect(
      scripts,
      isNotEmpty,
      reason:
          'No test scripts found in ${SendTestRunner.getScriptsDirectory().path}',
    );

    print('\n${'=' * 60}');
    print('Found ${scripts.length} test script(s):');
    for (final script in scripts) {
      print('  - ${SendTestRunner.getRelativePath(script)}');
    }
    print('${'=' * 60}\n');

    // Run each script
    var passedCount = 0;
    var failedCount = 0;
    final failedScripts = <String>[];

    for (final script in scripts) {
      final relativePath = SendTestRunner.getRelativePath(script);
      print('\n--- Running: $relativePath ---');

      try {
        final result = await SendTestRunner.send(
          relativePath,
          includeSource: true,
        );

        // Display captured output from the script
        if (result.output.isNotEmpty) {
          print('  Script output:');
          for (final line in result.output) {
            print('    > $line');
          }
        }

        if (result.success) {
          final jLabel = result.judgment != null ? ' [${result.judgment}]' : '';
          print('  ✓ Widget rendered: ${result.widgetType}$jLabel');
          passedCount++;
        } else {
          final jLabel = result.judgment != null ? ' [${result.judgment}]' : '';
          print('  ✗ Build failed: ${result.error}$jLabel');
          failedCount++;
          failedScripts.add('$relativePath: ${result.error}');
        }
      } catch (e) {
        print('  ✗ Exception: $e');
        failedCount++;
        failedScripts.add('$relativePath: EXCEPTION - $e');
      }
    }

    print('\n${'=' * 60}');
    if (failedCount == 0) {
      print('All ${scripts.length} scripts executed successfully!');
    } else {
      print(
        'Results: $passedCount passed, $failedCount failed '
        'out of ${scripts.length}',
      );
      print('\nFailed scripts:');
      for (final s in failedScripts) {
        print('  ✗ $s');
      }
    }
    print('${'=' * 60}\n');

    if (failedCount > 0) {
      fail('$failedCount of ${scripts.length} scripts failed');
    }
  });
}
