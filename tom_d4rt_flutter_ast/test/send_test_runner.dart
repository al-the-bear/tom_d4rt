/// Test runner that builds AST bundles from test scripts and sends them
/// to the tom_d4rt_flutter_ast_app via HTTP.
///
/// Scripts are located in:
///   test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/
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
// Host-side analyzer front-end: parses script source into an AstBundle.
// This is the one allowed coupling to the analyzer toolchain — it lives only
// in the test driver. The runtime (FlutterD4rt / tom_d4rt_ast) executes the
// resulting bundle with no analyzer dependency.
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

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
  ///
  /// Kept `const` so parameter-default expressions (e.g. `int port =
  /// defaultPort`) continue to compile. Runtime binding / connection
  /// sites should use [port] (the env-var-overridable value) instead.
  static const int defaultPort = 4247;

  /// Env-var name for overriding [defaultPort] at runtime. Set when the
  /// kernel-zombie wedge described in
  /// `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` §U28
  /// (TODO #10/#11) traps the default port and a host reboot isn't
  /// possible — point both runner and test app at a fresh port
  /// (e.g. `TOM_D4RT_AST_TEST_PORT=14247`).
  static const String portEnvVar = 'TOM_D4RT_AST_TEST_PORT';

  /// Effective HTTP port. Resolves [portEnvVar] once at class
  /// initialization, falling back to [defaultPort]. Use this for all
  /// runtime port operations (HTTP bind/connect, lsof/grep matches,
  /// log messages).
  static final int port =
      int.tryParse(Platform.environment[portEnvVar] ?? '') ?? defaultPort;

  /// Default HTTP host for the test app.
  static const String defaultHost = 'localhost';

  /// Scripts directory relative to package root.
  static const String scriptsPath =
      'test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts';

  /// Test app directory relative to package root.
  static const String testAppPath = 'test/tom_d4rt_flutter_ast_app';

  static FlutterD4rt? _d4rt;
  /// Host-side source→bundle compiler, lazily built from the [FlutterD4rt]
  /// runner's bridged-library set so that bridged Flutter/dart imports are
  /// skipped during bundling (handled natively at runtime).
  static AstBundler? _bundler;
  static HttpClient? _client;
  static Process? _testAppProcess;
  static bool _startedByRunner = false;
  /// Set when a transport error is observed; the next [send] call will
  /// recycle the test app before doing anything else. Decoupling recycle
  /// from the catch path keeps the failed test inside flutter_test's per-test
  /// 30s budget — the recycle (which can take ~10s) runs against the next
  /// test's budget instead of cascading into "did not complete".
  static bool _appNeedsRecycle = false;

  /// Public API to request a test-app recycle before the next [send] /
  /// [sendAndInteract] call.
  ///
  /// Use this in a `setUp` hook for tests where the interpreter / test app
  /// is known to accumulate state across `/clear → /build` cycles in a way
  /// that exceeds the per-build budget — most notably the **interactive
  /// static-demo suite** (cluster C, TODO #7+#8 of
  /// `testlog_20260525-1059-issue-analysis/error_analysis.md`). The first
  /// `material/show{dialog,bottomsheet,menu,datepicker,timepicker}_test.dart`
  /// build in a freshly-started test app completes in ~3 s; subsequent
  /// builds of any similarly-large script in the same test-app process
  /// time out at the test app's internal 30 s budget. Marking the
  /// recycle flag at the start of every interactive test makes each test
  /// run against a freshly-launched test app, paying ~5-10 s of process
  /// spin-up to gain a deterministic ~3 s build.
  ///
  /// See `interpreter_unfixable.md` §U28 for the underlying flutter_ast
  /// state-accumulation issue and the reason this workaround was chosen
  /// over deeper interpreter fixes.
  static void requestRecycle() {
    _appNeedsRecycle = true;
  }

  static bool _bridgesRegenerated = false;
  static const String _forceBridgeRegenEnv = 'D4RT_FORCE_BRIDGE_REGEN';
  static const String _skipBridgeRegenEnv = 'D4RT_SKIP_BRIDGE_REGEN';
  static const int _processLogTailLimit = 200;

  static final List<String> _testAppStdoutTail = <String>[];
  static final List<String> _testAppStderrTail = <String>[];
  static int? _lastTestAppExitCode;

  /// Name of the currently-active test suite (e.g. `essential_classes_test.dart`).
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
  /// 3. Start a brand-new test app process.
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
  ///     `interpreter_unfixable.md` §U28 TODO #10/#11.
  ///
  /// The new flow always launches a fresh app, after first reaping any
  /// stale process bound to the target port. `_startedByRunner` is set
  /// to `true` unconditionally so [tearDown] always kills the app it
  /// owns. The +5-10 s/file startup cost is the price of guaranteed
  /// cleanup; the alternative (orphans accumulating into UE zombies)
  /// has cost the project many hours of wasted sweeps.
  static Future<void> setUp({
    bool startApp = true,
    bool regenerateBridges = true,
    // 1401-TODO #11 (H2) — bumped from 60s to 120s. Mirror of TODO #10
    // for the AST harness. In the 1401 sweep `interactive_tests_test`
    // (the last suite in the 14-suite chain) failed `setUpAll` with
    // "Test app failed to start within 120 seconds" — by the end of the
    // sweep, the cumulative dyld/filesystem cache pressure plus stale
    // port-binds from the previous 13 suites prevented the new test
    // app from coming up in time. The interactive suite already passes
    // an explicit 120s, but this raises the default for any other
    // caller that uses the bare setUp(). See TEST-side TODO #10 for
    // the two-mode (recoverable slow port release vs unrecoverable
    // kernel zombie) analysis.
    Duration timeout = const Duration(seconds: 120),
    String? suite,
  }) async {
    _d4rt = FlutterD4rt();
    // Drop any cached bundler so it rebuilds from the fresh runner's
    // bridged-library set.
    _bundler = null;
    _client = HttpClient();
    _startedByRunner = false;
    _vmServiceUri = null;
    _devToolsUri = null;
    _currentSuite = suite ?? _detectSuiteName();

    if (regenerateBridges) {
      await _ensureBridgesRegenerated();
    }

    if (startApp) {
      // Always reap any prior test_app first — covers orphans from a
      // SIGKILL'd parent or a wedged-but-still-bound prior invocation.
      // `_killExistingProcess` is best-effort and is safe to run when
      // the port is already free.
      await _killExistingProcess();
      await _waitForPortFree(timeout: const Duration(seconds: 10));
      try {
        await _startTestApp(timeout: timeout);
      } catch (_) {
        // Belt-and-braces: if the first launch fails (e.g. a slow
        // kernel reclaim of the just-killed port), retry once after a
        // second kill sweep.
        await _killExistingProcess();
        await _waitForPortFree(timeout: const Duration(seconds: 10));
        await _startTestApp(timeout: timeout);
      }
      _startedByRunner = true;
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
    final keepAlive = _profileMode;
    final shouldStopApp = _startedByRunner && !keepAlive;
    final liveProcess = _testAppProcess;

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

    // Wait for app to be ready.
    // AOT builds are an order of magnitude slower than debug builds; floor
    // the timeout at 5 minutes in profile mode regardless of caller default.
    final effectiveTimeout = profileMode && timeout < const Duration(minutes: 5)
        ? const Duration(minutes: 5)
        : timeout;
    final deadline = DateTime.now().add(effectiveTimeout);
    var ready = false;

    while (DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(seconds: 2));
      try {
        // Try to connect to health endpoint
        final tempClient = HttpClient();
        try {
          final request = await tempClient.get(
            defaultHost,
            port,
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
        'Test app failed to start within '
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
  /// Recycle the test app process: kill the wedged instance and start a fresh
  /// one. Used by [send] when an HTTP transport call times out, indicating the
  /// app's Dart event loop is stuck (a script's dispose chain blocked the
  /// platform message queue, etc.). Without recycling, the next send() would
  /// hit the same wedge and the cascade would continue.
  ///
  /// No-op if the runner did not start the app itself (in that case the user
  /// is responsible for managing the process).
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
    // process that does NOT receive a propagated signal. We must reap it
    // explicitly via the LISTEN socket on [defaultPort], then wait for
    // the kernel to release the bind before launching a replacement.
    await _killExistingProcess();
    // 1401-TODO #11 (H2) — bumped from 10s to 20s. Mirror of TEST-side
    // TODO #10. The kernel can take several seconds to fully reclaim
    // the TCP bind after SIGKILL of a wedged Flutter wrapper + its
    // desktop child; 20s doubles the safety margin while still staying
    // well below the test-level 30s budget.
    await _waitForPortFree(timeout: const Duration(seconds: 20));
    _testAppProcess = null;
    // ignore: avoid_print
    print('[recycle] starting fresh test app');
    // 1401-TODO #11 (H2) — bumped from 60s to 120s, matching the
    // [setUp] default. See setUp's comment for the sweep-end cumulative
    // dyld/port-bind pressure rationale.
    await _startTestApp(timeout: const Duration(seconds: 120));
    // /health is synchronous and only proves the HTTP server is up; it does
    // not exercise the widget tree. Confirm the new app's event loop is
    // actually responsive by doing a real /clear roundtrip — that proves
    // setState/Timer/post-frame are all healthy.
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
      // ack that will never come, blowing past flutter_test's 30s budget.
      // Speed matters more than cleanliness here; the orphaned desktop
      // child is reaped by [_killExistingProcess] right after.
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
  static Future<SendResult> send(
    String scriptPath, {
    String host = defaultHost,
    int port = 0,
    bool clearFirst = true,
    bool includeSource = false,
    Duration? waitBeforeClear,
    // Step 9 follow-up: per-script override for the /build HTTP timeout
    // (default 25 s). Slow scripts whose bundle build legitimately needs
    // more than 25 s on a loaded host (e.g. gestures/least_squares_solver
    // at ~2300 lines) can raise this; the host test must also raise its
    // own dart-test wrapper timeout so the wrapper does not fire first.
    Duration? httpBuildTimeout,
  }) async {
    // §U28 / TODO #1404 port-override: `port = 0` is the sentinel meaning
    // "use the env-var-resolved [SendTestRunner.port]". Lets callers that
    // pass no `port` automatically pick up `TOM_D4RT_AST_TEST_PORT`.
    if (port == 0) port = SendTestRunner.port;
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

    // Clear UI first if requested
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
        // while we're collecting diagnostics, after which our orphaned future
        // continues running but the next test has already entered send() and
        // checked the flag. Setting first guarantees the flag is visible.
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
    final bundler = _bundler ??= AstBundler(
      bridgedLibraries: d4rt.interpreter.bridgedLibraryUris,
    );
    var bundle = await bundler.createFromSource(source);

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

    // Send bundle to app (pass filename + suite for display in test app UI).
    final encodedPath = Uri.encodeComponent(scriptPath);
    final suiteQuery = _currentSuite != null
        ? '&suite=${Uri.encodeComponent(_currentSuite!)}'
        : '';
    // testlog_20260528-2206 TODO #5 — thread the caller-supplied
    // `httpBuildTimeout` into the test_app via a `&buildBudgetMs=N`
    // query param. The test_app's `_handleBuild` defaults to its
    // own 30 s build-completer budget; when this param is present
    // it uses that value instead. Lets slow scripts like
    // `retest/widgets/app_kit_view_test.dart` (an AppKit-native-view
    // embedding demo that legitimately needs >30 s to build on
    // macOS) opt into a longer budget without changing the global
    // default. Only emitted when the caller explicitly passes a
    // non-null `httpBuildTimeout` — typical scripts unaffected.
    final buildBudgetQuery = httpBuildTimeout != null
        ? '&buildBudgetMs=${httpBuildTimeout.inMilliseconds}'
        : '';
    final buildUrl = '/build?filename=$encodedPath$suiteQuery$buildBudgetQuery';
    late final Map<String, dynamic> response;
    final httpStopwatch = Stopwatch()..start();
    try {
      response = await _httpPost(
        client,
        buildUrl,
        bundleJson,
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
        operation: 'POST $buildUrl',
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
    // Cluster J TODO #18 — test-app per-stage timings.
    final appMetric =
        (response['_buildMetric'] as Map?)?.cast<String, dynamic>();

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
      appMetric: appMetric,
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
    bool includeSource = false,
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
      includeSource: includeSource,
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

  /// Check if the test app is running.
  static Future<bool> isAppRunning({
    String host = defaultHost,
    int port = 0,
  }) async {
    if (port == 0) port = SendTestRunner.port;
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
    // Cluster J TODO #18 — optional per-stage build timings returned by
    // the test app in the `_buildMetric` response field. Null means the
    // milestone wasn't reached on this build (transport_error before any
    // stage, or the timing fields weren't returned). All times are
    // millisecond offsets from the test app's Stopwatch start at the
    // top of `_handleBuild`.
    Map<String, dynamic>? appMetric,
  }) {
    final appStages = _formatAppMetric(appMetric);
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
      'outputLines=$outputLines frameworkErrors=$frameworkErrorCount'
      '$appStages',
    );
  }

  /// Format the optional `_buildMetric` map (see TODO #18) as a suffix
  /// for the `[METRIC]` line. Returns an empty string when the response
  /// didn't carry one, so the existing METRIC shape is unchanged on
  /// transport-error rows (where the test app never replied).
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

// Bucket-2 cascade fix: every HTTP helper enforces a hard timeout. Without
// these caps, a wedged test-app event loop (e.g. after a script disposed
// dozens of AutofillGroups, blocking the dispose chain) made the harness
// hang indefinitely — flutter_test's per-test 30s timeout then killed each
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
          'App server must be running on port ${SendTestRunner.port}',
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
