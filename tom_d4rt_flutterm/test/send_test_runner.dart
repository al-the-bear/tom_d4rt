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

  const SendResult({
    required this.success,
    this.widgetType,
    this.error,
    required this.output,
    required this.statusCode,
    this.frameworkErrors = const [],
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

  /// Initialize the test runner (call in setUpAll).
  ///
  /// This will:
  /// 1. Kill any existing test app process on the port
  /// 2. Start a new test app process
  /// 3. Wait for it to be ready
  static Future<void> setUp({
    bool startApp = true,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    _d4rt = FlutterD4rt();
    _client = HttpClient();

    if (startApp) {
      await _startTestApp(timeout: timeout);
    }
  }

  /// Tear down the test runner (call in tearDownAll).
  ///
  /// This will kill the test app process if it was started by setUp.
  ///
  /// Note: You may see a "Shell subprocess crashed with SIGTERM" error from
  /// Flutter's test framework. This is expected when killing external processes
  /// spawned during flutter test and does not indicate an actual problem.
  static Future<void> tearDown() async {
    _client?.close();
    _client = null;
    _d4rt = null;

    try {
      await _killTestApp();
    } catch (_) {
      // Ignore errors during shutdown - the port cleanup will be attempted anyway
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
    // Kill any existing process first
    await _killExistingProcess();

    // Start the test app
    final packageRoot = Directory.current.path;
    final appDir = p.join(packageRoot, testAppPath);

    _testAppProcess = await Process.start(
      'flutter',
      ['run', '-d', 'linux'],
      workingDirectory: appDir,
      // Don't inherit stdio to avoid crash when killing process
    );

    // Drain stdout and stderr to prevent blocking
    // ignore: unawaited_futures
    _testAppProcess!.stdout.drain<void>();
    // ignore: unawaited_futures
    _testAppProcess!.stderr.drain<void>();

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
    }

    // Also kill any orphaned processes on the port
    await _killExistingProcess();
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
  static Future<SendResult> send(
    String scriptPath, {
    String host = defaultHost,
    int port = defaultPort,
    bool clearFirst = true,
  }) async {
    final packageRoot = Directory.current.path;
    final fullPath = p.join(packageRoot, scriptsPath, scriptPath);
    final file = File(fullPath);

    if (!file.existsSync()) {
      throw StateError('Script not found: $fullPath');
    }

    // Clear UI first if requested
    if (clearFirst) {
      await _httpGet(client, '/clear', host: host, port: port);
    }

    // Build bundle from script source
    final source = await file.readAsString();
    final bundle = await d4rt.interpreter.createBundleFromSource(source);
    final bundleJson = jsonEncode(bundle.toJson());

    // Send bundle to app
    final response = await _httpPost(
      client,
      '/build',
      bundleJson,
      host: host,
      port: port,
    );

    final status = response['status'] as String;
    final output = (response['output'] as List?)?.cast<String>() ?? [];
    final httpStatus = response['_httpStatus'] as int? ?? 200;
    final frameworkErrors =
        (response['frameworkErrors'] as List?)?.cast<String>() ?? [];

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
      );
    } else {
      return SendResult(
        success: false,
        error: response['error'] as String?,
        output: output,
        statusCode: httpStatus,
        frameworkErrors: frameworkErrors,
      );
    }
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

    for (final script in scripts) {
      final relativePath = SendTestRunner.getRelativePath(script);
      print('\n--- Running: $relativePath ---');

      final result = await SendTestRunner.send(relativePath);

      // Display captured output from the script
      if (result.output.isNotEmpty) {
        print('  Script output:');
        for (final line in result.output) {
          print('    > $line');
        }
      }

      if (result.success) {
        print('  ✓ Widget rendered: ${result.widgetType}');
        passedCount++;
      } else {
        print('  ✗ Build failed: ${result.error}');
        failedCount++;
        fail('Script $relativePath failed: ${result.error}');
      }
    }

    print('\n${'=' * 60}');
    if (failedCount == 0) {
      print('All ${scripts.length} scripts executed successfully!');
    } else {
      print('Results: $passedCount passed, $failedCount failed');
    }
    print('${'=' * 60}\n');
  });
}
