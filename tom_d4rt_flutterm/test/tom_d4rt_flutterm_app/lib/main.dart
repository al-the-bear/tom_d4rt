import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tom_d4rt_flutterm/tom_d4rt_flutterm.dart';

void main() {
  runApp(const D4rtFlutterApp());
}

class D4rtFlutterApp extends StatelessWidget {
  const D4rtFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D4rt Flutter Bridge Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
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

/// Result of a D4rt widget build operation.
class _BuildResult {
  final bool success;
  final String? widgetType;
  final String? error;
  final List<String> output;

  /// Flutter framework errors captured after layout/paint (e.g. red error
  /// screens caused by RenderBox overflow, missing parents, etc.).
  final List<String> frameworkErrors;

  _BuildResult({
    required this.success,
    this.widgetType,
    this.error,
    required this.output,
    this.frameworkErrors = const [],
  });

  Map<String, dynamic> toJson() => {
    'status': success ? 'success' : 'error',
    if (widgetType != null) 'widgetType': widgetType,
    if (error != null) 'error': error,
    'output': output,
    'frameworkErrors': frameworkErrors,
  };
}

class _D4rtTestPageState extends State<D4rtTestPage>
    with TickerProviderStateMixin {
  final FlutterD4rt _d4rt = FlutterD4rt();
  HttpServer? _server;
  final List<String> _logs = [];
  Widget? _d4rtWidget;
  String? _lastError;

  /// Tab controller for the Widget / Source tabs.
  late TabController _tabController;

  // Pending build state
  AstBundle? _pendingBundle;
  Completer<_BuildResult>? _buildCompleter;
  List<String> _capturedOutput = [];

  // Test execution control
  bool _isPaused = false;
  String? _currentTestFile;
  Completer<String>? _userActionCompleter;

  // Results log (file + result + judgment) — holds up to 4000 entries
  final List<String> _resultsLog = [];

  /// Source code of the current script (extracted from the bundle).
  String? _currentSourceCode;

  /// Framework errors captured by [FlutterError.onError] during a build cycle.
  /// These indicate red error screens (ErrorWidget) rendered by Flutter.
  List<String> _frameworkErrors = [];

  /// Whether we are currently inside a D4rt build cycle and should capture
  /// framework errors.
  bool _capturingFrameworkErrors = false;

  /// The original [FlutterError.onError] handler, restored when not capturing.
  void Function(FlutterErrorDetails)? _originalFlutterErrorHandler;

  static const int _serverPort = 4247;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Store the original handler so we can still call it for logging.
    _originalFlutterErrorHandler = FlutterError.onError;
    // Install our custom handler that captures framework errors during builds.
    FlutterError.onError = _handleFlutterError;
    _startServer();
  }

  /// Custom handler for [FlutterError.onError].  When a D4rt build is in
  /// progress we capture the error message; otherwise we delegate to the
  /// original handler.
  void _handleFlutterError(FlutterErrorDetails details) {
    if (_capturingFrameworkErrors) {
      final message = details.exceptionAsString();

      // Filter out internal Flutter framework assertions that are not visible
      // red error screens (e.g. semantics parent-data bookkeeping).
      const ignoredPatterns = [
        'parentDataDirty',
        'parentData is set up correctly',
      ];
      final isIgnored = ignoredPatterns.any((p) => message.contains(p));

      if (!isIgnored) {
        _frameworkErrors.add(message);
        _addLogEntry('[framework error] $message');
      }
    }
    // Always forward to the original handler for logging/debug output.
    _originalFlutterErrorHandler?.call(details);
  }

  @override
  void dispose() {
    _tabController.dispose();
    FlutterError.onError = _originalFlutterErrorHandler;
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

  /// Add a log entry without calling setState (safe to call during build).
  /// Use _scheduleLogRefresh() after to update the UI.
  void _addLogEntry(String message) {
    debugPrint('[D4rtApp] $message');
    _logs.add(
      '[${DateTime.now().toIso8601String().substring(11, 19)}] $message',
    );
    if (_logs.length > 100) _logs.removeRange(0, _logs.length - 100);
  }

  /// Schedule a setState to refresh the log UI after build completes.
  void _scheduleLogRefresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  /// Whether we are waiting for the user to click next/good/bad.
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
      // Resuming — complete any pending wait so the HTTP response is sent.
      _completeUserAction('play');
    }
  }

  void _onNext() {
    _completeUserAction('next');
  }

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
      _server!.listen(_handleRequest);
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
        case '/execute':
          await _handleExecute(request);
        case '/build':
          await _handleBuild(request);
        case '/health':
          _respond(request, 200, {'status': 'ok', 'port': _serverPort});
        case '/logs':
          _respond(request, 200, {'logs': _logs});
        case '/clear':
          setState(() {
            _d4rtWidget = null;
            _lastError = null;
            _pendingBundle = null;
            _buildCompleter = null;
            _capturedOutput = [];
          });
          _respond(request, 200, {'status': 'cleared'});
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

  /// POST /execute — Execute a D4rt bundle and return the result as JSON.
  ///
  /// Body: AstBundle JSON
  /// Query params: name (function to call, default: 'main')
  Future<void> _handleExecute(HttpRequest request) async {
    if (request.method != 'POST') {
      _respond(request, 405, {'error': 'Method not allowed. Use POST.'});
      return;
    }

    final body = await utf8.decoder.bind(request).join();
    final name = request.uri.queryParameters['name'] ?? 'main';

    _log('Executing bundle (name=$name, ${body.length} bytes)');

    try {
      final bundle = AstBundle.fromJson(
        jsonDecode(body) as Map<String, dynamic>,
      );
      final result = await _d4rt.executeAsync<Object?>(bundle, name: name);
      _log('Execution result: $result (${result.runtimeType})');
      _respond(request, 200, {
        'status': 'ok',
        'result': result?.toString(),
        'type': result?.runtimeType.toString(),
      });
    } on FlutterD4rtException catch (e) {
      _log('D4rt error: $e');
      _respond(request, 400, {'error': e.message});
    }
  }

  /// POST /build — Execute a D4rt bundle's `build` function and render the
  /// returned Widget. Waits for the build to complete and returns the result.
  ///
  /// Body: AstBundle JSON
  /// The bundle must contain a `dynamic build(BuildContext context)` function.
  ///
  /// Response includes:
  /// - status: 'success' or 'error'
  /// - widgetType: the runtime type of the built widget (on success)
  /// - error: error message (on error)
  /// - output: captured print() statements from the script
  /// - frameworkErrors: Flutter framework errors captured after layout/paint
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
      setState(() {
        _currentTestFile = filename;
      });
    }

    final body = await utf8.decoder.bind(request).join();
    _addLogEntry(
      'Building widget${filename != null ? ' [$filename]' : ''}'
      ' (${body.length} bytes)',
    );

    try {
      final bundle = AstBundle.fromJson(
        jsonDecode(body) as Map<String, dynamic>,
      );

      // Extract source code if included in the bundle
      if (bundle.sources != null && bundle.sources!.isNotEmpty) {
        _currentSourceCode = bundle.sources!.values.first;
      } else {
        _currentSourceCode = null;
      }

      // Set up completer to wait for build result (completed after frame).
      final completer = Completer<_BuildResult>();
      _buildCompleter = completer;
      _capturedOutput = [];
      _frameworkErrors = [];
      _capturingFrameworkErrors = true;

      // Trigger a rebuild — the actual build happens inside the Flutter
      // build method where we have a valid BuildContext.
      setState(() {
        _pendingBundle = bundle;
        _lastError = null;
      });

      // Yield to allow the frame to be scheduled and built
      await Future<void>.delayed(Duration.zero);

      // Wait for the build to complete (with timeout)
      final result = await completer.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          _capturingFrameworkErrors = false;
          return _BuildResult(
            success: false,
            error: 'Build timed out after 10 seconds',
            output: _capturedOutput,
          );
        },
      );

      _addLogEntry(
        result.success
            ? 'Build completed: ${result.widgetType}'
                  '${result.frameworkErrors.isNotEmpty ? ' (${result.frameworkErrors.length} framework error(s))' : ''}'
            : 'Build failed: ${result.error}',
      );
      _addResultEntry(filename, result);
      _scheduleLogRefresh();

      // If paused, wait for user action before responding.
      String? judgment;
      if (_isPaused) {
        _userActionCompleter = Completer<String>();
        _scheduleLogRefresh();
        final action = await _userActionCompleter!.future;
        _userActionCompleter = null;
        if (action == 'good') {
          judgment = 'good';
        } else if (action == 'bad') {
          judgment = 'needs rewrite';
        }
      }

      final responseJson = result.toJson();
      if (judgment != null) {
        responseJson['judgment'] = judgment;
      }
      _respond(request, result.success ? 200 : 400, responseJson);
    } on FormatException catch (e) {
      _capturingFrameworkErrors = false;
      _log('JSON parse error: $e');
      _respond(request, 400, {
        'error': 'Invalid JSON: $e',
        'output': [],
        'frameworkErrors': <String>[],
      });
    }
  }

  /// Build the D4rt widget from a pending bundle using the current BuildContext.
  /// Captures print() output and completes the build completer.
  /// Uses runZonedGuarded to protect against uncaught errors crashing the app.
  ///
  /// The completer is completed in a post-frame callback so that Flutter
  /// framework errors from layout/paint are captured before the HTTP response
  /// is sent.
  Widget _buildD4rtWidget(BuildContext context) {
    if (_pendingBundle != null) {
      final bundle = _pendingBundle!;
      _pendingBundle = null;

      // Capture print() output using runZonedGuarded for error protection
      final output = <String>[];
      var buildCompleted = false;

      runZonedGuarded(
        () {
          try {
            final widget = _d4rt.build<Widget>(bundle, context);
            _d4rtWidget = widget;
            _lastError = null;

            // Defer completion until after the frame (layout + paint) so that
            // framework errors (red error screens) are captured.
            if (!buildCompleted) {
              buildCompleted = true;
              final completer = _buildCompleter;
              _buildCompleter = null;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _capturingFrameworkErrors = false;
                completer?.complete(
                  _BuildResult(
                    success: true,
                    widgetType: widget.runtimeType.toString(),
                    output: output,
                    frameworkErrors: List<String>.from(_frameworkErrors),
                  ),
                );
              });
            }
          } on FlutterD4rtException catch (e) {
            _lastError = e.message;
            if (!buildCompleted) {
              buildCompleted = true;
              _capturingFrameworkErrors = false;
              _buildCompleter?.complete(
                _BuildResult(success: false, error: e.message, output: output),
              );
              _buildCompleter = null;
            }
          } catch (e, stackTrace) {
            _lastError = e.toString();
            debugPrint('[D4rtApp] Build error: $e\n$stackTrace');
            if (!buildCompleted) {
              buildCompleted = true;
              _capturingFrameworkErrors = false;
              _buildCompleter?.complete(
                _BuildResult(
                  success: false,
                  error: e.toString(),
                  output: output,
                ),
              );
              _buildCompleter = null;
            }
          }
        },
        (error, stackTrace) {
          // Uncaught async error handler - prevents app crash
          debugPrint('[D4rtApp] Uncaught error in D4rt execution: $error');
          debugPrint('[D4rtApp] Stack trace: $stackTrace');
          _lastError = 'Uncaught error: $error';
          if (!buildCompleted) {
            buildCompleted = true;
            _capturingFrameworkErrors = false;
            _buildCompleter?.complete(
              _BuildResult(
                success: false,
                error: 'Uncaught error: $error',
                output: output,
              ),
            );
            _buildCompleter = null;
          }
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            output.add(line);
            _capturedOutput.add(line);
            // Add to app logs (without setState - we're in build)
            // Use parent.print to avoid recursive capture
            final logMessage =
                '[${DateTime.now().toIso8601String().substring(11, 19)}] '
                '[script] $line';
            _logs.add(logMessage);
            if (_logs.length > 100) _logs.removeRange(0, _logs.length - 100);
            parent.print(zone, '[D4rtApp] [script] $line');
          },
        ),
      );
      // Schedule UI refresh to show captured logs
      _scheduleLogRefresh();
    }

    if (_lastError != null) {
      return _ErrorDisplay(error: _lastError!);
    }

    if (_d4rtWidget != null) {
      return _d4rtWidget!;
    }

    return const _WaitingDisplay();
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
              'D4rt Flutter Bridge Test',
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
              _pendingBundle = null;
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

          // Control bar
          _buildControlBar(),

          // Tab bar for Widget / Source views
          Container(
            color: Colors.grey.shade200,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.teal.shade800,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: Colors.teal,
              tabs: const [
                Tab(text: 'Widget', icon: Icon(Icons.widgets, size: 16)),
                Tab(text: 'Source', icon: Icon(Icons.code, size: 16)),
              ],
            ),
          ),

          // Tabbed content: Widget display + Source viewer
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 0: D4rt widget display area
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: _buildD4rtWidget(context),
                ),
                // Tab 1: Source code viewer
                _buildSourceViewer(),
              ],
            ),
          ),

          // Log panels (side by side)
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

  Widget _buildControlBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          IconButton(
            icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
            tooltip: _isPaused ? 'Resume' : 'Pause',
            color: _isPaused ? Colors.green : Colors.orange,
            onPressed: _onPausePlay,
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            tooltip: 'Play next',
            onPressed: _isWaitingForUser ? _onNext : null,
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.thumb_up, size: 16),
            label: const Text('Good'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade100,
              foregroundColor: Colors.green.shade800,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              minimumSize: Size.zero,
            ),
            onPressed: _isWaitingForUser ? _onGood : null,
          ),
          const SizedBox(width: 6),
          ElevatedButton.icon(
            icon: const Icon(Icons.thumb_down, size: 16),
            label: const Text('Bad'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red.shade800,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              minimumSize: Size.zero,
            ),
            onPressed: _isWaitingForUser ? _onBad : null,
          ),
          const Spacer(),
          if (_isWaitingForUser)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Waiting for input\u2026',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            )
          else if (!_isPaused)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Auto-running', style: TextStyle(fontSize: 11)),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Paused', style: TextStyle(fontSize: 11)),
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
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    final text = _resultsLog.join('\n');
                    Clipboard.setData(ClipboardData(text: text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Copied ${_resultsLog.length} result(s) to '
                          'clipboard',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.copy, size: 12, color: Colors.white54),
                      SizedBox(width: 4),
                      Text(
                        'Copy',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
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

  // ===========================================================================
  // Source Code Viewer
  // ===========================================================================

  Widget _buildSourceViewer() {
    if (_currentSourceCode == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.code_off, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No source available',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Source bundling is disabled or no script loaded yet',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
      );
    }

    final lines = _currentSourceCode!.split('\n');
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.code, size: 14, color: Colors.white54),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _currentTestFile ?? 'source',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${lines.length} lines',
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: _currentSourceCode!),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Source copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.copy, size: 12, color: Colors.white54),
                      SizedBox(width: 4),
                      Text(
                        'Copy',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Source code with line numbers and syntax highlighting
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: SelectableText.rich(
                TextSpan(
                  children: _buildHighlightedSource(lines),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds syntax-highlighted [TextSpan] children for the given source lines.
  List<TextSpan> _buildHighlightedSource(List<String> lines) {
    final spans = <TextSpan>[];
    final lineNumWidth = lines.length.toString().length;

    for (var i = 0; i < lines.length; i++) {
      // Line number (dim grey)
      final lineNum = '${(i + 1).toString().padLeft(lineNumWidth)}  ';
      spans.add(
        TextSpan(
          text: lineNum,
          style: const TextStyle(color: Color(0xFF5A5A5A)),
        ),
      );

      // Syntax-highlighted line content
      spans.addAll(_highlightLine(lines[i]));
      spans.add(const TextSpan(text: '\n'));
    }

    return spans;
  }

  /// Tokenizes and highlights a single line of Dart source code.
  static List<TextSpan> _highlightLine(String line) {
    if (line.isEmpty) return const [];

    final spans = <TextSpan>[];
    var pos = 0;

    while (pos < line.length) {
      // Single-line comment
      if (pos < line.length - 1 &&
          line[pos] == '/' &&
          line[pos + 1] == '/') {
        spans.add(
          TextSpan(
            text: line.substring(pos),
            style: const TextStyle(color: Color(0xFF6A9955)),
          ),
        );
        return spans;
      }

      // String literals (single and double quoted)
      if (line[pos] == "'" || line[pos] == '"') {
        final quote = line[pos];
        // Check for triple-quote
        if (pos + 2 < line.length &&
            line[pos + 1] == quote &&
            line[pos + 2] == quote) {
          // Triple-quoted string — consume to end of line (may span lines)
          final end = line.indexOf('$quote$quote$quote', pos + 3);
          final endPos = end >= 0 ? end + 3 : line.length;
          spans.add(
            TextSpan(
              text: line.substring(pos, endPos),
              style: const TextStyle(color: Color(0xFFCE9178)),
            ),
          );
          pos = endPos;
        } else {
          // Regular string — find matching close quote
          var end = pos + 1;
          while (end < line.length) {
            if (line[end] == '\\' && end + 1 < line.length) {
              end += 2; // skip escape sequence
            } else if (line[end] == quote) {
              end++;
              break;
            } else {
              end++;
            }
          }
          spans.add(
            TextSpan(
              text: line.substring(pos, end),
              style: const TextStyle(color: Color(0xFFCE9178)),
            ),
          );
          pos = end;
        }
        continue;
      }

      // Numbers
      if (_isDigit(line[pos]) ||
          (line[pos] == '.' &&
              pos + 1 < line.length &&
              _isDigit(line[pos + 1]))) {
        var end = pos;
        while (end < line.length &&
            (_isDigit(line[end]) || line[end] == '.')) {
          end++;
        }
        spans.add(
          TextSpan(
            text: line.substring(pos, end),
            style: const TextStyle(color: Color(0xFFB5CEA8)),
          ),
        );
        pos = end;
        continue;
      }

      // Annotations (@override, @required, etc.)
      if (line[pos] == '@') {
        var end = pos + 1;
        while (end < line.length && _isIdentChar(line[end])) {
          end++;
        }
        spans.add(
          TextSpan(
            text: line.substring(pos, end),
            style: const TextStyle(color: Color(0xFFDCDCAA)),
          ),
        );
        pos = end;
        continue;
      }

      // Identifiers and keywords
      if (_isIdentStart(line[pos])) {
        var end = pos + 1;
        while (end < line.length && _isIdentChar(line[end])) {
          end++;
        }
        final word = line.substring(pos, end);

        Color color;
        if (_keywords.contains(word)) {
          color = const Color(0xFF569CD6);
        } else if (_typeKeywords.contains(word)) {
          color = const Color(0xFF4EC9B0);
        } else if (_builtinConstants.contains(word)) {
          color = const Color(0xFF569CD6);
        } else {
          color = const Color(0xFFD4D4D4);
        }

        spans.add(TextSpan(text: word, style: TextStyle(color: color)));
        pos = end;
        continue;
      }

      // Punctuation and operators — default color
      spans.add(
        TextSpan(
          text: line[pos],
          style: const TextStyle(color: Color(0xFFD4D4D4)),
        ),
      );
      pos++;
    }

    return spans;
  }

  static bool _isDigit(String c) => c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  static bool _isIdentStart(String c) {
    final code = c.codeUnitAt(0);
    return (code >= 65 && code <= 90) ||
        (code >= 97 && code <= 122) ||
        c == '_' ||
        c == r'$';
  }

  static bool _isIdentChar(String c) => _isIdentStart(c) || _isDigit(c);

  static const _keywords = <String>{
    'abstract', 'as', 'assert', 'async', 'await', 'break', 'case', 'catch',
    'class', 'const', 'continue', 'covariant', 'default', 'deferred', 'do',
    'dynamic', 'else', 'enum', 'export', 'extends', 'extension', 'external',
    'factory', 'final', 'finally', 'for', 'Function', 'get', 'hide', 'if',
    'implements', 'import', 'in', 'interface', 'is', 'late', 'library',
    'mixin', 'new', 'on', 'operator', 'part', 'required', 'rethrow',
    'return', 'sealed', 'set', 'show', 'static', 'super', 'switch',
    'sync', 'this', 'throw', 'try', 'typedef', 'var', 'void', 'while',
    'with', 'yield',
  };

  static const _typeKeywords = <String>{
    'bool', 'double', 'int', 'num', 'String', 'List', 'Map', 'Set',
    'Future', 'Stream', 'Iterable', 'Object', 'Never', 'Null', 'Type',
    'Widget', 'BuildContext', 'State', 'StatelessWidget', 'StatefulWidget',
    'Key', 'Color', 'Size', 'Offset', 'Rect', 'EdgeInsets', 'TextStyle',
    'BoxDecoration', 'BorderRadius', 'Alignment', 'Container', 'Column',
    'Row', 'Expanded', 'SizedBox', 'Text', 'Icon', 'Padding', 'Center',
    'Scaffold', 'AppBar', 'MaterialApp',
  };

  static const _builtinConstants = <String>{
    'true', 'false', 'null',
  };
}

class _WaitingDisplay extends StatelessWidget {
  const _WaitingDisplay();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.widgets_outlined, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Waiting for D4rt widget...',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'POST a bundle to /build to render a widget',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Build Error',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.red),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
