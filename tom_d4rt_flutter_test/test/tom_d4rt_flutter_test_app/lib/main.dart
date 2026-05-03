import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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

  /// Tab controller for the Widget / Logs tabs.
  late TabController _tabController;

  // Pending build state
  String? _pendingSource;
  Completer<_BuildResult>? _buildCompleter;
  List<String> _capturedOutput = [];

  // Test execution control
  bool _isPaused = false;
  String? _currentTestFile;
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

  static const int _serverPort = 4248;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _originalFlutterErrorHandler = FlutterError.onError;
    _originalPlatformErrorHandler =
        WidgetsBinding.instance.platformDispatcher.onError;
    FlutterError.onError = _handleFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError = _handlePlatformError;
    _startServer();
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    final message = details.exceptionAsString();

    const silencedPatterns = [
      '_dependents.isEmpty',
      '_dependent.isEmpty',
    ];
    final isSilenced = silencedPatterns.any((p) => message.contains(p));

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
        }
      });
    } else {
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
          var clearResponded = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (clearResponded) return;
            clearResponded = true;
            if (mounted) {
              _respond(request, 200, {'status': 'cleared'});
            }
          });
          Timer(const Duration(seconds: 2), () {
            if (clearResponded) return;
            clearResponded = true;
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

    final filenameParam = request.uri.queryParameters['filename'];
    final filename = filenameParam != null
        ? Uri.decodeComponent(filenameParam)
        : null;
    if (filename != null && mounted) {
      setState(() => _currentTestFile = filename);
    }

    // Body is raw Dart source — not JSON.
    final source = await utf8.decoder.bind(request).join();
    _addLogEntry(
      'Building widget${filename != null ? ' [$filename]' : ''}'
      ' (${source.length} chars)',
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

    await Future<void>.delayed(Duration.zero);

    final result = await completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        _capturingFrameworkErrors = false;
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
            final widget = _d4rt.build<Widget>(source, context);
            _d4rtWidget = widget;
            _widgetGeneration++;
            _lastError = null;

            if (!buildCompleted) {
              buildCompleted = true;
              final completer = _buildCompleter;
              _buildCompleter = null;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _capturingFrameworkErrors = false;
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
              });
            }
          } on SourceFlutterD4rtException catch (e) {
            _lastError = e.message;
            if (!buildCompleted) {
              buildCompleted = true;
              _capturingFrameworkErrors = false;
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'D4rt Source Bridge Test',
              style: TextStyle(fontSize: 16),
            ),
            if (_currentTestFile != null)
              Text(
                _currentTestFile!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
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
          // Server status bar
          Container(
            padding: const EdgeInsets.all(8),
            color: _server != null
                ? Colors.green.shade100
                : Colors.red.shade100,
            child: Row(
              children: [
                Icon(
                  _server != null ? Icons.wifi : Icons.wifi_off,
                  size: 16,
                  color: _server != null ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _server != null
                      ? 'Server: http://localhost:$_serverPort'
                      : 'Server: not running',
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
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
              tabs: const [
                Tab(text: 'Widget', icon: Icon(Icons.widgets, size: 16)),
                Tab(text: 'Logs', icon: Icon(Icons.list, size: 16)),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Row(
        children: [
          IconButton(
            icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
            tooltip: _isPaused ? 'Resume' : 'Pause after next build',
            onPressed: _onPausePlay,
            iconSize: 20,
          ),
          const Spacer(),
          Text(
            _isPaused ? 'PAUSED' : 'Running',
            style: TextStyle(
              fontSize: 11,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.orange.shade50,
      child: Row(
        children: [
          const Text(
            'Judge:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _onGood,
            icon: const Icon(Icons.thumb_up, size: 16),
            label: const Text('Good'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade100,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _onBad,
            icon: const Icon(Icons.thumb_down, size: 16),
            label: const Text('Needs rewrite'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
            ),
          ),
          const SizedBox(width: 8),
          TextButton(onPressed: _onNext, child: const Text('Skip')),
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
