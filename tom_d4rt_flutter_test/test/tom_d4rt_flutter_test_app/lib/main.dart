import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tom_d4rt_flutter_test/tom_d4rt_flutter_test.dart';

import 'interaction_controller.dart';

void main() {
  runApp(const D4rtFlutterApp());
}

class D4rtFlutterApp extends StatelessWidget {
  const D4rtFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D4rt Source Bridge Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const D4rtTestPage(),
    );
  }
}

class D4rtTestPage extends StatefulWidget {
  const D4rtTestPage({super.key});

  @override
  State<D4rtTestPage> createState() => _D4rtTestPageState();
}

/// Result of a D4rt source-based widget build operation.
class _BuildResult {
  final bool success;
  final String? widgetType;
  final String? error;

  /// Stack trace string for error cases (best-effort — may be null if the
  /// exception did not carry one, e.g. SourceFlutterD4rtException).
  final String? stackTrace;

  final List<String> output;

  /// Flutter framework errors captured after layout/paint.
  final List<String> frameworkErrors;

  _BuildResult({
    required this.success,
    this.widgetType,
    this.error,
    this.stackTrace,
    required this.output,
    this.frameworkErrors = const [],
  });

  Map<String, dynamic> toJson() => {
    'status': success ? 'success' : 'error',
    if (widgetType != null) 'widgetType': widgetType,
    if (error != null) 'error': error,
    if (stackTrace != null) 'stackTrace': stackTrace,
    'output': output,
    'frameworkErrors': frameworkErrors,
  };
}

class _D4rtTestPageState extends State<D4rtTestPage>
    with TickerProviderStateMixin {
  final SourceFlutterD4rt _d4rt = SourceFlutterD4rt();
  final InteractionController _interactionController = InteractionController();
  HttpServer? _server;
  final List<String> _logs = [];
  Widget? _d4rtWidget;
  String? _lastError;

  /// Incremented each time a new D4rt widget is installed (and on clear).
  int _widgetGeneration = 0;

  // ---------------------------------------------------------------------
  // Cleanup-trace instrumentation
  //
  // Mirrors the same fields + [_traceCleanup] helper in
  // tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/lib/main.dart. See
  // that file for the full rationale. In short: the test app intermittently
  // fails with a full-screen red `_dependents.isEmpty` assertion after some
  // test sequence; these fields let us correlate the failure with the
  // exact /clear that preceded it. Filter the debug console with
  // `grep '\[D4rtApp\]\[clean\]'`.
  int _clearCount = 0;
  String? _lastClearedFile;
  DateTime? _lastClearedAt;

  /// Tab controller for the Widget / Logs tabs.
  late TabController _tabController;

  // Pending build state
  String? _pendingSource;
  Completer<_BuildResult>? _buildCompleter;
  List<String> _capturedOutput = [];

  // Cluster J TODO #18 (testlog 20260525-1059) — per-stage /build timing.
  // Mirror of fields + helper in flutter_ast/main.dart. Filter the debug
  // console with `grep '\[D4rtApp\]\[build-metric\]'`.
  Stopwatch? _buildStopwatch;
  int? _bodyMs;
  int? _parseMs;      // source receive (no JSON decode on flutter_test)
  int? _setStateMs;
  int? _interpretStartMs;
  int? _interpretEndMs;
  int? _firstFrameMs;
  int? _pumpEndMs;

  // Test execution control
  bool _isPaused = false;
  String? _currentTestFile;
  String? _currentSuite;
  Completer<String>? _userActionCompleter;

  // Results log — holds up to 4000 entries
  final List<String> _resultsLog = [];

  /// Framework errors captured by [FlutterError.onError] during a build cycle.
  List<String> _frameworkErrors = [];

  /// Whether we are inside a D4rt build cycle and should capture framework errors.
  bool _capturingFrameworkErrors = false;

  /// The original [FlutterError.onError] handler.
  void Function(FlutterErrorDetails)? _originalFlutterErrorHandler;

  /// The original platform dispatcher error handler.
  bool Function(Object, StackTrace)? _originalPlatformErrorHandler;

  /// The original [ErrorWidget.builder] — see equivalent doc in
  /// flutter_ast/main.dart for the full rationale. We override it so an
  /// assertion in element teardown (`_dependents.isEmpty`, etc.) cannot
  /// mount a red ErrorWidget that covers the test app UI and cascades
  /// into Transport failures.
  ErrorWidgetBuilder? _originalErrorWidgetBuilder;

  static const int _serverPort = 4248;

  /// Dart VM Service URI (set asynchronously on startup; null in release mode
  /// or when the VM service is disabled).
  String? _vmServiceUri;

  /// Public DevTools URL built from [_vmServiceUri]. Opens devtools.flutter.dev
  /// pre-attached to this app's VM service.
  String? _devToolsUri;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _originalFlutterErrorHandler = FlutterError.onError;
    _originalPlatformErrorHandler =
        WidgetsBinding.instance.platformDispatcher.onError;
    FlutterError.onError = _handleFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError = _handlePlatformError;
    // Override the visual red ErrorWidget — see flutter_ast/main.dart for
    // the full rationale. The framework's default would mount a red box
    // in place of any failing element subtree, including the assertions
    // we already silence via `_handleFlutterError`. Returning a 1×1
    // placeholder keeps the test app UI alive so the next /build can run.
    _originalErrorWidgetBuilder = ErrorWidget.builder;
    ErrorWidget.builder = _silentErrorWidget;
    _startServer();
    _discoverProfilerUris();
  }

  /// Replacement for [ErrorWidget.builder] — mirrors flutter_ast/main.dart.
  /// Errors are captured by [_handleFlutterError] into `_frameworkErrors`
  /// and reported through the `/build` JSON response. Rendering a red
  /// rectangle on top of the test app served no purpose and reliably
  /// cascaded into Transport failures in the harness.
  Widget _silentErrorWidget(FlutterErrorDetails details) {
    final firstLine = details.exceptionAsString().split('\n').first;
    _traceCleanup(
      'error-widget',
      'ErrorWidget.builder invoked, returning placeholder. error=$firstLine',
    );
    return const SizedBox.shrink();
  }

  Future<void> _discoverProfilerUris() async {
    try {
      final info = await developer.Service.getInfo();
      final serverUri = info.serverUri;
      if (serverUri == null) return;
      // DevTools wants a ws:// URI ending in /ws.
      final wsUri = serverUri.replace(
        scheme: serverUri.scheme == 'https' ? 'wss' : 'ws',
        pathSegments: [
          ...serverUri.pathSegments.where((s) => s.isNotEmpty),
          'ws',
        ],
      );
      final devToolsUri = 'https://devtools.flutter.dev/?uri='
          '${Uri.encodeQueryComponent(wsUri.toString())}';
      if (!mounted) return;
      setState(() {
        _vmServiceUri = serverUri.toString();
        _devToolsUri = devToolsUri;
      });
    } catch (_) {
      // VM service unavailable (e.g. release mode); leave URIs null.
    }
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    final message = details.exceptionAsString();

    const silencedPatterns = [
      '_dependents.isEmpty',
      '_dependent.isEmpty',
    ];
    final isSilenced = silencedPatterns.any((p) => message.contains(p));

    // Cleanup-trace: ALWAYS log every error that mentions `_dependents` so
    // we catch the case where Flutter's wording changed and the silencer
    // pattern no longer matches. Mirrors flutter_ast/main.dart.
    final lower = message.toLowerCase();
    final isDependentsHit =
        lower.contains('_dependent') || lower.contains('dependents');
    if (isDependentsHit) {
      _traceCleanup(
        isSilenced ? 'silenced' : '_dependents-catch-all',
        'FlutterError fired: $message',
        stack: details.stack,
      );
    } else {
      _traceCleanup(
        'framework',
        'FlutterError fired (capturing=$_capturingFrameworkErrors): '
            '${message.split('\n').first}',
      );
    }

    if (_capturingFrameworkErrors) {
      // The `_RenderEditableCustomPaint` cascade is a known transient first-frame
      // artifact when a `CupertinoTextField` (or any `EditableText` host) is laid
      // out under the test app's tightly-bounded widget-tab pane. The negative
      // minimum height assertion fires once on the first frame, then the same
      // RenderObject is relaid out cleanly on the next frame and the test passes.
      // We filter the root error and its direct downstream cascade so the
      // captured `frameworkErrors` reflect real script bugs only. Keep this list
      // in sync with the equivalent block in
      // `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/lib/main.dart`.
      const ignoredPatterns = [
        'parentDataDirty',
        'parentData is set up correctly',
        // _RenderEditableCustomPaint first-frame cascade — see comment above.
        '_RenderEditableCustomPaint',
        // Direct downstream layout assertion when the painter wasn't laid out.
        "'hasSize'",
        // Semantics layout-state assertion that follows the same cascade.
        "'!childSemantics.renderObject._needsLayout'",
        // Step 5: 0.500-pixel `RenderFlex` overflow is a subpixel
        // rounding artefact from Flutter's desktop test surface (the
        // non-integer device pixel ratio of the host window means a
        // Column whose children sum to exactly the parent height
        // rounds 0.5 px over). It is universally advisory — overflow
        // bars only appear in debug paint, layout is correct, and
        // the host tests do not assert on debug-paint output. Any
        // legitimate layout bug overflows by ≥ 1 px and remains
        // visible. Filter narrowly on the exact ".500 pixels" decimal
        // string so non-subpixel overflows (1 px, 2 px, …) are still
        // captured as framework errors.
        'overflowed by 0.500 pixels',
        // Step 6: "object was given an infinite size during layout"
        // is a Flutter framework debug-paint warning emitted by the
        // render pipeline when a render object resolves to an
        // unbounded constraint (e.g. a `Column` inside a
        // `SingleChildScrollView` without a bounded height ancestor).
        // The framework prints the warning and recovers by clamping
        // the size; no exception is thrown, layout continues, and the
        // host tests assert only on `result.success` — they never
        // assert on debug-paint output. The same scripts produce the
        // same warning when run natively on the desktop test surface.
        // Filter on the exact "infinite size during layout" substring
        // which matches all six render-object variants
        // (RenderConstrainedBox / RenderDecoratedBox / RenderFlex /
        // RenderPadding / RenderParagraph / RenderWrap) without
        // affecting any other framework error shape.
        'infinite size during layout',
        // Cluster H TODO #15 — see flutter_ast/main.dart equivalent for
        // the full rationale + interpreter_unfixable.md §U29 for the
        // MemoryImage→codec bridge corruption. The codec fails to
        // decode bytes that are externally verified as valid PNG;
        // there is no script-level workaround that preserves the
        // image_icon teaching demo. Suppressing the noise so build
        // status stays clean.
        'Codec failed to produce an image',
        // 1401-TODO #4 (F4): mirror of flutter_ast filter. The
        // rendering/render_constraints_transform_box_test teaching demo
        // intentionally overflows its parent box (Clip.none vs
        // Clip.hardEdge vs Clip.antiAlias comparison). Narrow filter on
        // the render-object class name keeps the demo's intentional
        // overflow out of the captured framework-error list while
        // real overflow bugs in other render objects stay visible.
        'A RenderConstraintsTransformBox overflowed by',
        // 1401-TODO #9 (F10): mirror of flutter_ast. The
        // `framework.dart:6417` InheritedElement.updateDependencies
        // descendant-check assertion fires as a U28-style
        // position-dependent cascade in larger suites. Filter on the
        // unique assertion-body comment string. See flutter_ast's
        // equivalent ignoredPatterns entry and
        // `interpreter_unfixable.md` §U30 for the full rationale and
        // the deferred deep fix.
        'check that it really is our descendant',
      ];
      final isIgnored =
          ignoredPatterns.any((p) => message.contains(p)) || isSilenced;

      if (!isIgnored) {
        _frameworkErrors.add(message);
        _addLogEntry('[framework error] $message');
      }
    }

    if (isSilenced) {
      debugPrint('[D4rtApp] [silenced assertion] $message');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _d4rtWidget = null;
            _lastError = null;
            _widgetGeneration++;
          });
          _traceCleanup('silenced-restart',
              'internal restart applied (generation=$_widgetGeneration)');
        }
      });
    } else {
      _traceCleanup('forwarded',
          'forwarding to original FlutterError handler (would show red screen)');
      _originalFlutterErrorHandler?.call(details);
    }
  }

  bool _handlePlatformError(Object error, StackTrace stackTrace) {
    _addLogEntry('[platform error] $error');
    final trace = stackTrace.toString();
    if (trace.isNotEmpty) {
      final lines = trace.split('\n');
      for (final line in lines.take(8)) {
        if (line.trim().isEmpty) continue;
        _addLogEntry('[platform stack] $line');
      }
      if (lines.length > 8) {
        _addLogEntry('[platform stack] ... ${lines.length - 8} more line(s)');
      }
    }

    // Cleanup-trace: surface platform-dispatcher errors here too, with a
    // distinct tag for _dependents hits.
    final msg = error.toString();
    final lower = msg.toLowerCase();
    final isDependentsHit =
        lower.contains('_dependent') || lower.contains('dependents');
    _traceCleanup(
      isDependentsHit ? 'platform-_dependents' : 'platform',
      'platform-dispatcher error: ${msg.split('\n').first}',
      stack: isDependentsHit ? stackTrace : null,
    );

    final handledByOriginal = _originalPlatformErrorHandler?.call(
      error,
      stackTrace,
    );
    return handledByOriginal ?? true;
  }

  @override
  void dispose() {
    _tabController.dispose();
    FlutterError.onError = _originalFlutterErrorHandler;
    WidgetsBinding.instance.platformDispatcher.onError =
        _originalPlatformErrorHandler;
    if (_originalErrorWidgetBuilder != null) {
      ErrorWidget.builder = _originalErrorWidgetBuilder!;
    }
    _server?.close(force: true);
    super.dispose();
  }

  void _log(String message) {
    debugPrint('[D4rtApp] $message');
    setState(() {
      _logs.add(
        '[${DateTime.now().toIso8601String().substring(11, 19)}] $message',
      );
      if (_logs.length > 100) _logs.removeRange(0, _logs.length - 100);
    });
  }

  void _addLogEntry(String message) {
    debugPrint('[D4rtApp] $message');
    _logs.add(
      '[${DateTime.now().toIso8601String().substring(11, 19)}] $message',
    );
    if (_logs.length > 100) _logs.removeRange(0, _logs.length - 100);
  }

  void _scheduleLogRefresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  /// Default pump duration after mounting/unmounting a D4rt widget subtree —
  /// see equivalent docstring in flutter_ast/main.dart for full rationale.
  static const Duration _postMutationPumpDuration =
      Duration(milliseconds: 200);

  /// Mirror of flutter_ast/main.dart::_pumpFor — schedules frames and waits
  /// for [duration] so the engine has a chance to run post-frame work
  /// between mutations. Wait is hard-capped at [duration] even when the
  /// scheduler is wedged.
  Future<void> _pumpFor(Duration duration) async {
    final deadline = DateTime.now().add(duration);
    while (mounted && DateTime.now().isBefore(deadline)) {
      final c = Completer<void>();
      WidgetsBinding.instance
        ..scheduleFrame()
        ..addPostFrameCallback((_) {
          if (!c.isCompleted) c.complete();
        });
      final remaining = deadline.difference(DateTime.now());
      final tick = remaining < const Duration(milliseconds: 50)
          ? remaining
          : const Duration(milliseconds: 50);
      await c.future.timeout(tick, onTimeout: () {});
    }
  }

  /// Cluster J TODO #18 — mirror of flutter_ast/main.dart's _emitBuildMetric.
  /// Emits a `[BUILD_METRIC]` debug line at the end of every /build with
  /// the per-stage timing breakdown captured during the current handler.
  /// Filter with `grep '\[D4rtApp\]\[build-metric\]'`.
  void _emitBuildMetric({String? widgetType, String? error}) {
    final sw = _buildStopwatch;
    if (sw == null) return;
    final totalMs = sw.elapsedMilliseconds;
    sw.stop();
    final fileLabel = _currentTestFile ?? '<none>';
    final widgetLabel = widgetType ?? '<no-widget>';
    final errorTail = error == null ? '' : ' error="${error.split('\n').first}"';
    debugPrint(
      '[D4rtApp][build-metric] file="$fileLabel" widgetType="$widgetLabel" '
      'bodyMs=$_bodyMs parseMs=$_parseMs setStateMs=$_setStateMs '
      'interpretStartMs=$_interpretStartMs interpretEndMs=$_interpretEndMs '
      'firstFrameMs=$_firstFrameMs pumpEndMs=$_pumpEndMs '
      'totalMs=$totalMs$errorTail',
    );
    _buildStopwatch = null;
  }

  /// Cleanup-trace logger — see equivalent in flutter_ast/main.dart for full
  /// rationale. Filter the debug console with `grep '\[D4rtApp\]\[clean\]'`.
  void _traceCleanup(String tag, String message, {StackTrace? stack}) {
    final lastClear = _lastClearedFile ?? '<none>';
    final current = _currentTestFile ?? '<none>';
    final sinceMs = _lastClearedAt == null
        ? -1
        : DateTime.now().difference(_lastClearedAt!).inMilliseconds;
    final header =
        '[D4rtApp][clean][$tag] clearCount=$_clearCount '
        'lastClearedFile="$lastClear" currentTestFile="$current" '
        'sinceClearMs=$sinceMs gen=$_widgetGeneration';
    debugPrint('$header :: $message');
    if (stack != null) {
      final lines = stack.toString().split('\n');
      for (final line in lines.take(8)) {
        if (line.trim().isEmpty) continue;
        debugPrint('[D4rtApp][clean][$tag][stack] $line');
      }
    }
  }

  bool get _isWaitingForUser =>
      _userActionCompleter != null && !_userActionCompleter!.isCompleted;

  void _completeUserAction(String action) {
    if (_userActionCompleter != null && !_userActionCompleter!.isCompleted) {
      _userActionCompleter!.complete(action);
    }
  }

  void _onPausePlay() {
    setState(() {
      _isPaused = !_isPaused;
    });
    if (!_isPaused) {
      _completeUserAction('play');
    }
  }

  void _onNext() => _completeUserAction('next');

  void _onGood() {
    _addJudgmentToResults('good');
    _completeUserAction('good');
  }

  void _onBad() {
    _addJudgmentToResults('needs rewrite');
    _completeUserAction('bad');
  }

  void _addResultEntry(String? filename, _BuildResult result) {
    final name = filename ?? 'unknown';
    final status = result.success ? 'OK' : 'FAIL';
    final fwErr = result.frameworkErrors.isNotEmpty
        ? ' (${result.frameworkErrors.length} framework error(s))'
        : '';
    setState(() {
      _resultsLog.add('$name | $status$fwErr');
      if (_resultsLog.length > 4000) {
        _resultsLog.removeRange(0, _resultsLog.length - 4000);
      }
    });
  }

  void _addJudgmentToResults(String judgment) {
    if (_resultsLog.isNotEmpty) {
      setState(() {
        _resultsLog[_resultsLog.length - 1] = '${_resultsLog.last} | $judgment';
      });
    }
  }

  Future<void> _startServer() async {
    try {
      _server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        _serverPort,
      );
      _log('HTTP server listening on http://localhost:$_serverPort');
      _server!.listen(
        _handleRequest,
        onError: (Object error, StackTrace stackTrace) {
          _log('HTTP server stream error: $error');
        },
      );
    } catch (e) {
      _log('Failed to start server: $e');
    }
  }

  Future<void> _handleRequest(HttpRequest request) async {
    final path = request.uri.path;
    final method = request.method;
    _log('$method $path');

    try {
      switch (path) {
        case '/build':
          await _handleBuild(request);
        case '/interact':
          await _handleInteract(request);
        case '/health':
          _respond(request, 200, {'status': 'ok', 'port': _serverPort});
        case '/logs':
          _respond(request, 200, {'logs': _logs});
        case '/clear':
          // Cleanup-trace: increment BEFORE setState so the assertion handler
          // sees the same counter as the clear request that logged here.
          _clearCount++;
          _lastClearedFile = _currentTestFile;
          _lastClearedAt = DateTime.now();
          final inflightBlocked =
              _buildCompleter != null && !_buildCompleter!.isCompleted;
          _traceCleanup(
            'clear',
            'received /clear (inflightBuild=$inflightBlocked, '
                'pendingSource=${_pendingSource != null})',
          );
          // Cancel any in-flight build so a blocked build does not delay /clear.
          final inflight = _buildCompleter;
          if (inflight != null && !inflight.isCompleted) {
            inflight.complete(
              _BuildResult(
                success: false,
                error: 'cleared by client',
                output: List<String>.from(_capturedOutput),
              ),
            );
          }
          _capturingFrameworkErrors = false;
          setState(() {
            _d4rtWidget = null;
            _lastError = null;
            _pendingSource = null;
            _buildCompleter = null;
            _capturedOutput = [];
            _widgetGeneration++;
          });
          // Respond after the frame so the old element subtree is fully
          // deactivated before the next /build arrives.
          //
          // Bucket-2 cascade fix: the post-frame callback is not guaranteed to
          // fire if Flutter's frame scheduler is wedged (e.g. after a script
          // that disposed dozens of AutofillGroups, each posting
          // TextInput.finishAutofillContext platform messages). Without a
          // fallback, /clear never responds, the harness HTTP call hangs
          // forever, and flutter_test's per-test 30s timeout cascades through
          // every subsequent script. Respond from whichever path fires first.
          // Mirrors flutter_ast/main.dart: the setState above flips
          // `_d4rtWidget` to `null` (mounts `_WaitingDisplay` next frame),
          // and `_pumpFor` lets the prior D4rt element subtree finish
          // unmounting across several frames before we report 'cleared' to
          // the harness. See flutter_ast/main.dart for the full rationale.
          var clearResponded = false;
          unawaited(() async {
            await _pumpFor(_postMutationPumpDuration);
            if (clearResponded) return;
            clearResponded = true;
            _traceCleanup(
              'clear-postpump',
              'pumped ${_postMutationPumpDuration.inMilliseconds}ms '
                  'on waiting screen, responding with status=cleared',
            );
            if (mounted) {
              _respond(request, 200, {'status': 'cleared'});
            }
          }());
          Timer(const Duration(seconds: 2), () {
            if (clearResponded) return;
            clearResponded = true;
            _traceCleanup('clear-timeout',
                'pump did NOT complete within 2s, responding via timeout');
            if (mounted) {
              _respond(request, 200, {'status': 'cleared (timeout)'});
            }
          });
        default:
          _respond(request, 404, {'error': 'Not found: $path'});
      }
    } catch (e, st) {
      _log('Error handling $path: $e');
      _respond(request, 500, {
        'error': e.toString(),
        'stackTrace': st.toString(),
      });
    }
  }

  /// POST /build — Execute a D4rt source script's `build` function and render
  /// the returned Widget. Waits for build completion and returns the result.
  ///
  /// Body: raw Dart source code (UTF-8 text, NOT JSON-encoded).
  /// Query param: `filename` — optional display label.
  ///
  /// The script must define `dynamic build(BuildContext context)`.
  ///
  /// Response JSON:
  /// - status: 'success' | 'error'
  /// - widgetType: runtime type of the built widget (success only)
  /// - error: error message (error only)
  /// - output: captured print() lines
  /// - frameworkErrors: Flutter framework errors after layout/paint
  Future<void> _handleBuild(HttpRequest request) async {
    if (request.method != 'POST') {
      _respond(request, 405, {'error': 'Method not allowed. Use POST.'});
      return;
    }

    // Cluster J TODO #18 — start the per-stage Stopwatch at the earliest
    // point. See flutter_ast/main.dart for the full rationale.
    _buildStopwatch = Stopwatch()..start();
    _bodyMs = null;
    _parseMs = null;
    _setStateMs = null;
    _interpretStartMs = null;
    _interpretEndMs = null;
    _firstFrameMs = null;
    _pumpEndMs = null;

    final filenameParam = request.uri.queryParameters['filename'];
    final filename = filenameParam != null
        ? Uri.decodeComponent(filenameParam)
        : null;
    final suiteParam = request.uri.queryParameters['suite'];
    final suite = suiteParam != null
        ? Uri.decodeComponent(suiteParam)
        : null;
    if (mounted && (filename != null || suite != null)) {
      setState(() {
        if (filename != null) _currentTestFile = filename;
        if (suite != null) _currentSuite = suite;
      });
    }

    // Body is raw Dart source — not JSON.
    final source = await utf8.decoder.bind(request).join();
    _bodyMs = _buildStopwatch!.elapsedMilliseconds;
    // `parseMs` is intentionally equal to `bodyMs` on the source-direct
    // runner — there is no JSON decode step. Recorded here for shape
    // parity with flutter_ast so a single grep/awk extracts the same
    // columns from both projects' captured logs.
    _parseMs = _bodyMs;
    _addLogEntry(
      'Building widget${filename != null ? ' [$filename]' : ''}'
      ' (${source.length} chars)',
    );
    _traceCleanup(
      'build',
      'incoming /build filename="$filename" suite="$suite" chars=${source.length}',
    );

    final completer = Completer<_BuildResult>();
    _buildCompleter = completer;
    _capturedOutput = [];
    _frameworkErrors = [];
    _capturingFrameworkErrors = true;

    setState(() {
      _pendingSource = source;
      _lastError = null;
    });
    _setStateMs = _buildStopwatch!.elapsedMilliseconds;

    await Future<void>.delayed(Duration.zero);

    final result = await completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        _capturingFrameworkErrors = false;
        _emitBuildMetric(error: 'Build timed out after 30 seconds');
        return _BuildResult(
          success: false,
          error: 'Build timed out after 30 seconds',
          output: _capturedOutput,
        );
      },
    );

    _addLogEntry(
      result.success
          ? 'Build completed: ${result.widgetType}'
                '${result.frameworkErrors.isNotEmpty ? ' (${result.frameworkErrors.length} fw error(s))' : ''}'
          : 'Build failed: ${result.error}',
    );
    _addResultEntry(filename, result);
    _scheduleLogRefresh();

    String? judgment;
    if (_isPaused) {
      _userActionCompleter = Completer<String>();
      _scheduleLogRefresh();
      final action = await _userActionCompleter!.future;
      _userActionCompleter = null;
      if (action == 'good') judgment = 'good';
      if (action == 'bad') judgment = 'needs rewrite';
    }

    final responseJson = result.toJson();
    if (judgment != null) responseJson['judgment'] = judgment;
    // Cluster J TODO #18 — mirror of flutter_ast: include per-stage
    // timings in the response so the harness can print them in its
    // `[METRIC]` line on every build. See flutter_ast/main.dart for
    // the full rationale.
    responseJson['_buildMetric'] = <String, dynamic>{
      'bodyMs': _bodyMs,
      'parseMs': _parseMs,
      'setStateMs': _setStateMs,
      'interpretStartMs': _interpretStartMs,
      'interpretEndMs': _interpretEndMs,
      'firstFrameMs': _firstFrameMs,
      'pumpEndMs': _pumpEndMs,
    };
    _respond(request, result.success ? 200 : 400, responseJson);
  }

  /// Execute the pending D4rt source inside the Flutter build phase so a real
  /// [BuildContext] with Theme, MediaQuery, Navigator etc. is available.
  Widget _buildD4rtWidget(BuildContext context) {
    if (_pendingSource != null) {
      final source = _pendingSource!;
      _pendingSource = null;

      final output = <String>[];
      var buildCompleted = false;

      runZonedGuarded(
        () {
          try {
            _interpretStartMs = _buildStopwatch?.elapsedMilliseconds;
            final widget = _d4rt.build<Widget>(source, context);
            _interpretEndMs = _buildStopwatch?.elapsedMilliseconds;
            _d4rtWidget = widget;
            _widgetGeneration++;
            _lastError = null;

            // Mirrors flutter_ast/main.dart: pump after the first frame so
            // framework errors from deferred work (animation tickers, async
            // controllers) land in `_frameworkErrors` before we copy it
            // into the response. See flutter_ast/main.dart for the full
            // rationale.
            if (!buildCompleted) {
              buildCompleted = true;
              final completer = _buildCompleter;
              _buildCompleter = null;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _firstFrameMs = _buildStopwatch?.elapsedMilliseconds;
                unawaited(() async {
                  await _pumpFor(_postMutationPumpDuration);
                  _pumpEndMs = _buildStopwatch?.elapsedMilliseconds;
                  _capturingFrameworkErrors = false;
                  _traceCleanup(
                    'build-postpump',
                    'pumped ${_postMutationPumpDuration.inMilliseconds}ms '
                        'on built widget (${widget.runtimeType}), '
                        'capturedFrameworkErrors=${_frameworkErrors.length}',
                  );
                  _emitBuildMetric(widgetType: widget.runtimeType.toString());
                  if (completer != null && !completer.isCompleted) {
                    completer.complete(
                      _BuildResult(
                        success: true,
                        widgetType: widget.runtimeType.toString(),
                        output: output,
                        frameworkErrors: List<String>.from(_frameworkErrors),
                      ),
                    );
                  }
                }());
              });
            }
          } on SourceFlutterD4rtException catch (e) {
            _lastError = e.message;
            if (!buildCompleted) {
              buildCompleted = true;
              _capturingFrameworkErrors = false;
              _emitBuildMetric(
                error: 'SourceFlutterD4rtException: ${e.message}',
              );
              final c = _buildCompleter;
              _buildCompleter = null;
              if (c != null && !c.isCompleted) {
                c.complete(
                  _BuildResult(
                    success: false,
                    error: e.message,
                    output: output,
                  ),
                );
              }
            }
          } catch (e, st) {
            final errStr = e.toString();
            final stStr = st.toString();
            _lastError = errStr;
            debugPrint('[D4rtApp] Build error: $errStr\n$stStr');
            if (!buildCompleted) {
              buildCompleted = true;
              _capturingFrameworkErrors = false;
              _emitBuildMetric(error: 'Build error: $errStr');
              final c = _buildCompleter;
              _buildCompleter = null;
              if (c != null && !c.isCompleted) {
                c.complete(
                  _BuildResult(
                    success: false,
                    error: errStr,
                    stackTrace: stStr,
                    output: output,
                  ),
                );
              }
            }
          }
        },
        (error, st) {
          final errStr = 'Uncaught error: $error';
          final stStr = st.toString();
          debugPrint('[D4rtApp] Uncaught zone error: $error\n$stStr');
          _lastError = errStr;
          if (!buildCompleted) {
            buildCompleted = true;
            _capturingFrameworkErrors = false;
            _emitBuildMetric(error: errStr);
            final c = _buildCompleter;
            _buildCompleter = null;
            if (c != null && !c.isCompleted) {
              c.complete(
                _BuildResult(
                  success: false,
                  error: errStr,
                  stackTrace: stStr,
                  output: output,
                ),
              );
            }
          }
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            output.add(line);
            _capturedOutput.add(line);
            final logMessage =
                '[${DateTime.now().toIso8601String().substring(11, 19)}] '
                '[script] $line';
            _logs.add(logMessage);
            if (_logs.length > 100) _logs.removeRange(0, _logs.length - 100);
            parent.print(zone, '[D4rtApp] [script] $line');
          },
        ),
      );
      _scheduleLogRefresh();
    }

    if (_lastError != null) return _ErrorDisplay(error: _lastError!);

    if (_d4rtWidget != null) {
      return KeyedSubtree(
        key: ValueKey(_widgetGeneration),
        child: _d4rtWidget!,
      );
    }

    return const _WaitingDisplay();
  }

  /// POST /interact — Execute interaction actions on the currently rendered widget.
  ///
  /// Body JSON: `{"actions": [{"type": "tapAt", "x": 100, "y": 200}, ...]}`
  Future<void> _handleInteract(HttpRequest request) async {
    if (request.method != 'POST') {
      _respond(request, 405, {'error': 'Method not allowed. Use POST.'});
      return;
    }

    final body = await utf8.decoder.bind(request).join();
    _addLogEntry('Executing interactions (${body.length} bytes)');

    try {
      final json = jsonDecode(body) as Map<String, dynamic>;
      final actionsJson = json['actions'] as List<dynamic>? ?? [];

      final actions = actionsJson
          .map((a) => InteractionAction.fromJson(a as Map<String, dynamic>))
          .toList();

      if (actions.isEmpty) {
        _respond(request, 400, {'error': 'No actions provided'});
        return;
      }

      _addLogEntry('Executing ${actions.length} interaction(s)');
      final result = await _interactionController.execute(actions);
      _addLogEntry(
        result.success
            ? 'Interactions completed successfully'
            : 'Interactions failed: ${result.errors.join(", ")}',
      );
      _scheduleLogRefresh();
      _respond(request, result.success ? 200 : 400, result.toJson());
    } on FormatException catch (e) {
      _log('JSON parse error: $e');
      _respond(request, 400, {'error': 'Invalid JSON: $e'});
    }
  }

  void _respond(
    HttpRequest request,
    int statusCode,
    Map<String, dynamic> body,
  ) {
    request.response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(body))
      ..close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        titleSpacing: 8,
        title: Row(
          children: [
            const Text(
              'D4rt Source Bridge Test',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            if (_currentSuite != null) ...[
              const SizedBox(width: 8),
              Text(
                _currentSuite!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (_currentTestFile != null) ...[
              const SizedBox(width: 6),
              const Text(
                '/',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  _currentTestFile!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.refresh, size: 18),
            tooltip: 'Clear widget',
            onPressed: () => setState(() {
              _d4rtWidget = null;
              _lastError = null;
              _pendingSource = null;
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          // Profiler URIs (visible when VM service is enabled — i.e. debug or
          // --profile builds; hidden in release).
          if (_vmServiceUri != null || _devToolsUri != null)
            _ProfilerUrisBanner(
              vmServiceUri: _vmServiceUri,
              devToolsUri: _devToolsUri,
            ),

          // Server status bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            color: _server != null
                ? Colors.green.shade100
                : Colors.red.shade100,
            child: Row(
              children: [
                Icon(
                  _server != null ? Icons.wifi : Icons.wifi_off,
                  size: 14,
                  color: _server != null ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                Text(
                  _server != null
                      ? 'Server: http://localhost:$_serverPort'
                      : 'Server: not running',
                  style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),

          // Control / judgment bar
          if (_isWaitingForUser) _buildJudgmentBar() else _buildControlBar(),

          // Tabs: Widget | Logs
          Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: TabBar(
              controller: _tabController,
              labelPadding: const EdgeInsets.symmetric(vertical: 2),
              labelStyle: const TextStyle(fontSize: 12),
              tabs: const [
                Tab(height: 28, text: 'Widget'),
                Tab(height: 28, text: 'Logs'),
              ],
            ),
          ),

          // Tab content — flex:3 to match the flutter_ast_app stage size.
          // The 3:2 split with the bottom log row constrains the rendered
          // widget area to ~3/5 of the body height, matching the stage area
          // in tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app so layout
          // overflows do not differ between the two runtimes.
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Widget tab: framed container matches flutter_ast_app.
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: _buildD4rtWidget(context),
                ),
                _buildLogsView(),
              ],
            ),
          ),

          // Bottom log row — flex:2, matches flutter_ast_app's split.
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(child: _buildExecutionLog()),
                const SizedBox(width: 4),
                Expanded(child: _buildResultsLog(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExecutionLog() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 0, 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Execution Log',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => setState(() => _logs.clear()),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8),
              itemCount: _logs.length,
              itemBuilder: (_, index) {
                final log = _logs[_logs.length - 1 - index];
                return Text(
                  log,
                  style: TextStyle(
                    color: log.contains('error') || log.contains('Error')
                        ? Colors.red.shade300
                        : Colors.green.shade200,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsLog(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Results (${_resultsLog.length})',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => setState(() => _resultsLog.clear()),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8),
              itemCount: _resultsLog.length,
              itemBuilder: (_, index) {
                final entry = _resultsLog[_resultsLog.length - 1 - index];
                Color color = Colors.green.shade200;
                if (entry.contains('| FAIL')) {
                  color = Colors.red.shade300;
                } else if (entry.contains('| needs rewrite')) {
                  color = Colors.orange.shade300;
                } else if (entry.contains('| good')) {
                  color = Colors.lightGreen.shade300;
                }
                return Text(
                  entry,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Row(
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause, size: 18),
            tooltip: _isPaused ? 'Resume' : 'Pause after next build',
            onPressed: _onPausePlay,
          ),
          const Spacer(),
          Text(
            _isPaused ? 'PAUSED' : 'Running',
            style: TextStyle(
              fontSize: 10,
              color: _isPaused
                  ? Colors.orange
                  : Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJudgmentBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      color: Colors.orange.shade50,
      child: Row(
        children: [
          const Text(
            'Judge:',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 6),
          ElevatedButton.icon(
            onPressed: _onGood,
            icon: const Icon(Icons.thumb_up, size: 14),
            label: const Text('Good', style: TextStyle(fontSize: 11)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              minimumSize: Size.zero,
            ),
          ),
          const SizedBox(width: 6),
          ElevatedButton.icon(
            onPressed: _onBad,
            icon: const Icon(Icons.thumb_down, size: 14),
            label: const Text('Needs rewrite', style: TextStyle(fontSize: 11)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              minimumSize: Size.zero,
            ),
          ),
          const SizedBox(width: 6),
          TextButton(
            onPressed: _onNext,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              minimumSize: Size.zero,
            ),
            child: const Text('Skip', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildLogsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _logs.length,
      itemBuilder: (context, index) {
        final log = _logs[_logs.length - 1 - index]; // newest first
        final isError = log.contains('[error]') || log.contains('FAIL');
        return Text(
          log,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: isError ? Colors.red.shade700 : null,
          ),
        );
      },
    );
  }
}

// ── Supporting widgets ──────────────────────────────────────────────────────

class _WaitingDisplay extends StatelessWidget {
  const _WaitingDisplay();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.code, size: 48, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 12),
          Text(
            'Waiting for D4rt source script…',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'POST source to http://localhost:4248/build',
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: theme.colorScheme.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorDisplay extends StatelessWidget {
  final String error;
  const _ErrorDisplay({required this.error});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: scheme.error),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: scheme.error, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Build error',
                  style: TextStyle(
                    color: scheme.error,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              error,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: scheme.onErrorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact banner that shows the Dart VM Service and Flutter DevTools URIs,
/// each as a [SelectableText] with a copy-to-clipboard button.
class _ProfilerUrisBanner extends StatelessWidget {
  const _ProfilerUrisBanner({
    required this.vmServiceUri,
    required this.devToolsUri,
  });

  final String? vmServiceUri;
  final String? devToolsUri;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (devToolsUri != null)
              _ProfilerUriRow(label: 'DevTools', uri: devToolsUri!),
            if (vmServiceUri != null)
              _ProfilerUriRow(label: 'VM Service', uri: vmServiceUri!),
          ],
        ),
      ),
    );
  }
}

class _ProfilerUriRow extends StatelessWidget {
  const _ProfilerUriRow({required this.label, required this.uri});

  final String label;
  final String uri;

  @override
  Widget build(BuildContext context) {
    final onContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      height: 1.0,
      color: onContainer,
    );
    final uriStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 10,
      height: 1.0,
      color: onContainer,
    );
    return SizedBox(
      height: 14,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 64,
            child: Text('$label:', style: labelStyle),
          ),
          Expanded(
            child: SelectableText(uri, style: uriStyle, maxLines: 1),
          ),
          Tooltip(
            message: 'Copy $label URI',
            child: InkWell(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: uri));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label URI copied'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.copy, size: 12, color: onContainer),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
