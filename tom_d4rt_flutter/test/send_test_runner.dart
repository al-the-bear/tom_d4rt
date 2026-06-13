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
  ///
  /// Kept `const` so parameter-default expressions (`int port =
  /// defaultPort`) continue to compile. Runtime binding / connection
  /// sites use [port] (the env-var-overridable value).
  static const int defaultPort = 4248;

  /// Env-var name for overriding [defaultPort] at runtime. Set when the
  /// kernel-zombie wedge described in
  /// `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` §U28
  /// (TODO #10/#11) traps the default port and a host reboot isn't
  /// possible — point both runner and test app at a fresh port
  /// (e.g. `TOM_D4RT_TEST_TEST_PORT=14248`).
  static const String portEnvVar = 'TOM_D4RT_TEST_TEST_PORT';

  /// Effective HTTP port. Resolves [portEnvVar] once at class
  /// initialization, falling back to [defaultPort].
  static final int port =
      int.tryParse(Platform.environment[portEnvVar] ?? '') ?? defaultPort;

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

  /// 1944 TODO B.7 (2026-05-31): public mirror of the AST sibling's
  /// `SendTestRunner.requestRecycle()` API. Sets `_appNeedsRecycle`
  /// so the next [send] call recycles the test_app process before
  /// dispatching the build. Used by host-file test/* files to opt
  /// individual large-bundle scripts out of the §U28 cumulative-
  /// declaration-state accumulation cliff (see
  /// `interpreter_unfixable.md` §U28 for the architectural root
  /// cause and the deferred deep fix). Pattern: call this at the
  /// start of an individual test's body before
  /// `SendTestRunner.send(...)` to force a fresh test_app for
  /// THAT one test.
  static void requestRecycle() {
    _appNeedsRecycle = true;
  }

  static const int _processLogTailLimit = 200;

  static final List<String> _testAppStdoutTail = <String>[];
  static final List<String> _testAppStderrTail = <String>[];
  static int? _lastTestAppExitCode;

  /// Name of the currently-active test suite (e.g. `secondary_classes_test.dart`).
  /// Detected from [Platform.script] in [setUp] and forwarded on every
  /// `/build` request so the app can display it in its header.
  static String? _currentSuite;

  static String? _detectSuiteName() {
    try {
      final segs = Platform.script.pathSegments;
      if (segs.isEmpty) return null;
      final last = segs.last;
      return last.isEmpty ? null : last;
    } catch (_) {
      return null;
    }
  }

  /// Dart VM Service URI captured from the test app's stdout. Populated when
  /// the app announces it during startup, typically in --profile mode.
  static String? _vmServiceUri;

  /// Flutter DevTools URI captured from the test app's stdout (CPU profiler,
  /// timeline, memory views).
  static String? _devToolsUri;

  static final RegExp _vmServiceUriPattern = RegExp(
    r'(?:Dart VM Service|VM Service).*?available at:\s*(http://\S+)',
  );
  static final RegExp _devToolsUriPattern = RegExp(
    r'(?:Flutter DevTools|DevTools).*?available at:\s*(http://\S+)',
  );

  /// True when env var `D4RT_PROFILE` is set. Launches the test app with
  /// `--profile` and keeps the app process running after [tearDown] so the
  /// human can attach DevTools via the URLs printed during startup.
  static bool get _profileMode {
    final v = Platform.environment['D4RT_PROFILE']?.toLowerCase();
    return v == '1' || v == 'true' || v == 'yes';
  }

  static void _scanForProfilerUris(String line) {
    if (_vmServiceUri == null) {
      final m = _vmServiceUriPattern.firstMatch(line);
      if (m != null) {
        _vmServiceUri = m.group(1);
        _printProfilerBanner('Dart VM Service: $_vmServiceUri');
      }
    }
    if (_devToolsUri == null) {
      final m = _devToolsUriPattern.firstMatch(line);
      if (m != null) {
        _devToolsUri = m.group(1);
        _printProfilerBanner('Flutter DevTools: $_devToolsUri');
      }
    }
  }

  static void _printProfilerBanner(String message) {
    // ignore: avoid_print
    print('');
    // ignore: avoid_print
    print('=================================================================');
    // ignore: avoid_print
    print('[D4RT_PROFILE] $message');
    // ignore: avoid_print
    print('=================================================================');
  }

  /// Initialize the test runner (call in setUpAll).
  ///
  /// This will:
  /// 1. Kill any leftover test app process holding the target port (so a
  ///    crashed / SIGKILL'd prior invocation cannot leak its app into
  ///    this run).
  /// 2. Wait for the port to be free.
  /// 3. Start a brand-new test app process from [testAppPath].
  /// 4. Wait for it to be ready.
  ///
  /// **Reuse semantics removed (20260528-2x — "only one instance"
  /// guarantee):** earlier versions reused an existing healthy app on
  /// the port to save the ~5-10 s startup cost across multiple
  /// `flutter test` invocations. That optimization was load-bearing on
  /// the assumption that the prior invocation's `tearDown` ran cleanly,
  /// which doesn't hold when:
  ///   * the parent `flutter test` is SIGKILL'd (timeout budget, user
  ///     interrupt) → `tearDownAll` never executes → orphan app survives;
  ///   * the test_app event loop wedges → orphan keeps the LISTEN socket;
  ///   * on macOS, an orphaned-then-wedged child transitions to state
  ///     `UE` (uninterruptible kernel exit) and becomes immortal — see
  ///     `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` §U28
  ///     TODO #10/#11.
  ///
  /// The new flow always launches a fresh app, after first reaping any
  /// stale process bound to the target port. `_startedByRunner` is set
  /// to `true` unconditionally so [tearDown] always kills the app it
  /// owns. The +5-10 s/file startup cost is the price of guaranteed
  /// cleanup.
  static Future<void> setUp({
    bool startApp = true,
    // 1401-TODO #10 (H1) — bumped from 60s to 120s. In the 1401 sweep
    // baseline the source test app's `setUpAll` failed for 5 cascading
    // suites (crashing/timeout/blocking/gii/gir) with "Source test app
    // failed to start within 60 seconds" because the prior suite's
    // wedged app held the port long enough that the next suite's
    // launcher exceeded its budget. 120s gives the host headroom for
    // dyld/filesystem cache pressure and kernel port-bind release
    // after a hard SIGKILL of the wedged process.
    Duration timeout = const Duration(seconds: 120),
    String? suite,
  }) async {
    _client = HttpClient();
    _startedByRunner = false;
    _vmServiceUri = null;
    _devToolsUri = null;
    _currentSuite = suite ?? _detectSuiteName();

    if (startApp) {
      // Always reap any prior test_app first — covers orphans from a
      // SIGKILL'd parent or a wedged-but-still-bound prior invocation.
      await _killExistingProcess();
      await _waitForPortFree(timeout: const Duration(seconds: 10));
      try {
        await _startTestApp(timeout: timeout);
      } catch (_) {
        await _killExistingProcess();
        await _waitForPortFree(timeout: const Duration(seconds: 10));
        await _startTestApp(timeout: timeout);
      }
      _startedByRunner = true;
    }
  }

  /// Tear down the test runner (call in tearDownAll).
  ///
  /// Kills the test app only if it was started by [setUp]. When env var
  /// `D4RT_PROFILE` is set, the kill is suppressed so the human can attach
  /// DevTools to the still-running app via the URLs printed at startup.
  static Future<void> tearDown() async {
    final keepAlive = _profileMode;
    final shouldStopApp = _startedByRunner && !keepAlive;
    final liveProcess = _testAppProcess;

    _client?.close();
    _client = null;
    _startedByRunner = false;

    if (shouldStopApp) {
      try {
        await _killTestApp();
      } catch (_) {
        // ignore — process may already be gone
      }
    } else if (keepAlive && liveProcess != null) {
      _printProfilerBanner(
        'KEEP-ALIVE: test app (pid=${liveProcess.pid}) left running. '
        'Attach DevTools via the URL(s) above. '
        'Kill manually when done: kill -9 ${liveProcess.pid}',
      );
      // Detach our handle so any later cleanup in this dart test session
      // (e.g. a stray recycle) does not SIGKILL the still-useful process.
      _testAppProcess = null;
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
          ':$port',
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
          ':$port',
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

    final profileMode = _profileMode;
    final args = <String>['run', '-d', device, if (profileMode) '--profile'];

    if (profileMode) {
      _printProfilerBanner(
        'Launching test app in --profile mode '
        '(AOT build may take 1–3 minutes on first run)',
      );
    }

    _testAppProcess = await Process.start(
      flutterExecutable,
      args,
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

    // AOT builds are an order of magnitude slower than debug builds; floor
    // the timeout at 5 minutes in profile mode regardless of caller default.
    final effectiveTimeout = profileMode && timeout < const Duration(minutes: 5)
        ? const Duration(minutes: 5)
        : timeout;
    final start = DateTime.now();
    final deadline = start.add(effectiveTimeout);
    var ready = false;
    var probes = 0;
    var lastHeartbeat = start;

    // Probe /health *immediately* and then poll at a short cadence: the app
    // usually answers within a few seconds, so waiting a full 2s before the
    // first probe (and 2s between probes) just adds dead time. A fast app is
    // now picked up within ~0.5s of becoming ready.
    //
    // While we wait, emit a heartbeat every few seconds. The boot phase is
    // otherwise silent (no test events, no app output once the VM-service
    // banner has printed), which makes a perfectly healthy ~20s launch look
    // like a wedged run — and, on a loaded host, a boot longer than the
    // runner's idle-output watchdog window would be killed as a false stall.
    // The heartbeat both reassures a human watcher and keeps the watchdog fed.
    while (DateTime.now().isBefore(deadline)) {
      probes++;
      try {
        final tempClient = HttpClient();
        try {
          final request = await tempClient.get(defaultHost, port, '/health');
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
      final now = DateTime.now();
      if (now.difference(lastHeartbeat) >= const Duration(seconds: 3)) {
        lastHeartbeat = now;
        // ignore: avoid_print
        print(
          '[test-app] waiting for /health on port $port '
          '(${now.difference(start).inSeconds}s elapsed, $probes probes)…',
        );
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }

    if (!ready) {
      await _killTestApp();
      throw StateError(
        'Source test app failed to start within '
        '${effectiveTimeout.inSeconds} seconds',
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
    if (_profileMode) {
      // ignore: avoid_print
      print(
        '[recycle] suppressed: D4RT_PROFILE is set, keeping the wedged app '
        'alive for inspection. Subsequent sends will likely fail.',
      );
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
    // 1401-TODO #10 (H1) — bumped from 10s to 20s. The kernel can take
    // several seconds to fully reclaim the TCP bind after SIGKILL of
    // a wedged Flutter wrapper + its desktop child; 20s is still well
    // below the test-level 30s budget but doubles the safety margin.
    await _waitForPortFree(timeout: const Duration(seconds: 20));
    _testAppProcess = null;
    // ignore: avoid_print
    print('[recycle] starting fresh test app');
    // 1401-TODO #10 (H1) — bumped from 60s to 120s, matching the
    // [setUp] default. See setUp's comment for the cascade-failure
    // rationale.
    await _startTestApp(timeout: const Duration(seconds: 120));
    // /health is synchronous and only proves the HTTP server is up; it does
    // not exercise the widget tree. Confirm the new app's event loop is
    // actually responsive by doing a real /clear roundtrip.
    // ignore: avoid_print
    print('[recycle] verifying /clear roundtrip');
    await _httpGet(
      client,
      '/clear',
      host: defaultHost,
      port: port,
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
    int port = 0,
    bool clearFirst = true,
    Duration? waitBeforeClear,
    // Step 9 follow-up: per-script override for the /build HTTP timeout
    // (default 25 s). Slow scripts whose bundle build legitimately needs
    // more than 25 s on a loaded host (e.g. gestures/least_squares_solver
    // at ~2300 lines) can raise this; the host test must also raise its
    // own dart-test wrapper timeout so the wrapper does not fire first.
    Duration? httpBuildTimeout,
  }) async {
    // §U28 / TODO #1404 port-override: `port = 0` means "use the
    // env-var-resolved [SendTestRunner.port]". Lets callers that pass
    // no `port` automatically pick up `TOM_D4RT_TEST_TEST_PORT`.
    if (port == 0) port = SendTestRunner.port;
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
        // A /clear that times out means the app's event loop is wedged — a
        // prior build's runaway interpret is still churning. Handle it the
        // same way as a /build build-timeout: kill the process NOW so it stops
        // burning CPU and so _buildSendDiagnostics' /logs probe fails fast
        // instead of hanging on the dead-locked app. The deferred recycle then
        // boots a fresh app at the start of the next test.
        await _killExistingProcess();
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
    final suiteQuery = _currentSuite != null
        ? '&suite=${Uri.encodeComponent(_currentSuite!)}'
        : '';
    // testlog_20260528-2206 TODO #5 — mirror of flutter_ast. Thread the
    // caller-supplied `httpBuildTimeout` into the test_app via a
    // `&buildBudgetMs=N` query param so slow scripts can opt into a
    // longer per-request build-completer budget. The test_app's
    // `_handleBuild` defaults to its own 30 s budget when the param
    // is absent.
    final buildBudgetQuery = httpBuildTimeout != null
        ? '&buildBudgetMs=${httpBuildTimeout.inMilliseconds}'
        : '';
    final buildUrl = '/build?filename=$encodedPath$suiteQuery$buildBudgetQuery';
    late final Map<String, dynamic> response;
    final httpStopwatch = Stopwatch()..start();
    try {
      response = await _httpPostSource(
        client,
        buildUrl,
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
      // A client-side /build timeout means the app is still churning the
      // runaway interpret (the server hasn't returned). Same wedge as a
      // server-side build-timeout 400: kill the process NOW so it stops
      // burning CPU and the /logs probe below fails fast instead of hanging.
      await _killExistingProcess();
      final diagnostics = await _buildSendDiagnostics(
        operation: 'POST $buildUrl',
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
    // Cluster J TODO #18 — test-app per-stage timings.
    final appMetric =
        (response['_buildMetric'] as Map?)?.cast<String, dynamic>();

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
      appMetric: appMetric,
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
      // A build-timeout is fundamentally different from a normal D4rt
      // compile/runtime failure. The server's build budget fires on the
      // HTTP-handler's `completer.future.timeout`, but the runaway
      // `_d4rt.build()` it was waiting on is STILL churning inside the app's
      // single event loop. The app is therefore wedged: every subsequent
      // request queues behind that interpret and times out identically — the
      // "Build timed out" cascade that stalls a whole file for minutes. A
      // plain compile/runtime error also returns 400 but does so promptly and
      // leaves the app responsive, so we key off the timeout signal
      // specifically rather than reacting to every non-200.
      final isBuildTimeout =
          httpStatus == 400 && (errorMsg?.contains('Build timed out') ?? false);
      if (isBuildTimeout) {
        // Kill the wedged process NOW so its runaway interpret stops burning
        // CPU between tests — a SIGKILL is cheap (~<1 s) and safe to pay on
        // this already-failed test's clock. The expensive ~20 s reboot is
        // deferred to the next test via _appNeedsRecycle: _recycleTestApp()
        // runs at the very start of the next send() (before that test builds
        // anything), so the boot cost lands on the next test's fresh per-test
        // budget instead of this one's already-exhausted ~45 s.
        // ignore: avoid_print
        print(
          '[recycle] build-timeout in $scriptPath — app event loop is wedged; '
          'killing it now, restarting before the next test (no cascade)',
        );
        await _killExistingProcess();
        _appNeedsRecycle = true;
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
    int port = 0,
    bool clearFirst = true,
    // 20260524 §6 todo #20: passthrough so interactive tests can absorb
    // cold-start contention on large bundles (the showdialog / showmenu /
    // showdatepicker / showtimepicker static demos all bundle to ~800 KB+
    // AST and exceed the default 25 s cap on a fresh app start).
    Duration? httpBuildTimeout,
  }) async {
    if (port == 0) port = SendTestRunner.port;
    final buildResult = await send(
      scriptPath,
      host: host,
      port: port,
      clearFirst: clearFirst,
      httpBuildTimeout: httpBuildTimeout,
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
    int port = 0,
  }) async {
    if (port == 0) port = SendTestRunner.port;
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
    int port = 0,
  }) async {
    if (port == 0) port = SendTestRunner.port;
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
    int port = 0,
  }) async {
    if (port == 0) port = SendTestRunner.port;
    await _httpGet(client, '/clear', host: host, port: port);
  }

  /// Get the app logs.
  static Future<List<String>> getAppLogs({
    String host = defaultHost,
    int port = 0,
  }) async {
    if (port == 0) port = SendTestRunner.port;
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
      _scanForProfilerUris(line);
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
    // Cluster J TODO #18 — per-stage test-app timings.
    Map<String, dynamic>? appMetric,
  }) {
    final appStages = _formatAppMetric(appMetric);
    // ignore: avoid_print
    print(
      '[METRIC] script=$scriptPath testFile=${_currentSuite ?? '<unknown>'} '
      'sourceChars=$sourceChars '
      'clearMs=${clearDuration.inMilliseconds} '
      'httpMs=${httpDuration.inMilliseconds} '
      'totalMs=${totalDuration.inMilliseconds} '
      'status=$status httpStatus=${httpStatus ?? -1} '
      'outputLines=$outputLines frameworkErrors=$frameworkErrorCount'
      '$appStages',
    );
  }

  /// Mirror of flutter_ast's `_formatAppMetric` — formats the test-app
  /// `_buildMetric` map as a suffix for the `[METRIC]` line. Empty
  /// string when null (preserves the existing METRIC shape on
  /// transport-error rows).
  static String _formatAppMetric(Map<String, dynamic>? m) {
    if (m == null) return '';
    int? i(String key) {
      final v = m[key];
      if (v is int) return v;
      if (v is num) return v.toInt();
      return null;
    }
    return ' appBodyMs=${i('bodyMs') ?? -1}'
        ' appParseMs=${i('parseMs') ?? -1}'
        ' appSetStateMs=${i('setStateMs') ?? -1}'
        ' appInterpretStartMs=${i('interpretStartMs') ?? -1}'
        ' appInterpretEndMs=${i('interpretEndMs') ?? -1}'
        ' appFirstFrameMs=${i('firstFrameMs') ?? -1}'
        ' appPumpEndMs=${i('pumpEndMs') ?? -1}';
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
// 55s sits just under the outer `flutter test --timeout 60s` (5s headroom), so
// the inner cap no longer pre-empts the outer timeout. The previous 25s value
// fired first and recorded heavy-but-progressing builds as transport failures
// on a loaded host; at 55s a slow build gets nearly the full minute, while a
// genuinely wedged transport still fails before the outer 60s elapses.
const Duration _httpBuildTimeout = Duration(seconds: 55);

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
          'App server must be running on port ${SendTestRunner.port}. '
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
