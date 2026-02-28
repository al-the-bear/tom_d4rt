import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' show Color;

import 'package:flutter/material.dart';
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

  _BuildResult({
    required this.success,
    this.widgetType,
    this.error,
    required this.output,
  });

  Map<String, dynamic> toJson() => {
    'status': success ? 'success' : 'error',
    if (widgetType != null) 'widgetType': widgetType,
    if (error != null) 'error': error,
    'output': output,
  };
}

class _D4rtTestPageState extends State<D4rtTestPage> {
  final FlutterD4rt _d4rt = FlutterD4rt();
  HttpServer? _server;
  final List<String> _logs = [];
  Widget? _d4rtWidget;
  String? _lastError;

  // Pending build state
  AstBundle? _pendingBundle;
  Completer<_BuildResult>? _buildCompleter;
  List<String> _capturedOutput = [];

  static const int _serverPort = 4247;

  @override
  void initState() {
    super.initState();
    _startServer();
  }

  @override
  void dispose() {
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
  Future<void> _handleBuild(HttpRequest request) async {
    if (request.method != 'POST') {
      _respond(request, 405, {'error': 'Method not allowed. Use POST.'});
      return;
    }

    final body = await utf8.decoder.bind(request).join();
    _addLogEntry('Building widget (${body.length} bytes)');

    try {
      final bundle = AstBundle.fromJson(
        jsonDecode(body) as Map<String, dynamic>,
      );

      // Set up completer to wait for build result
      final completer = Completer<_BuildResult>();
      _buildCompleter = completer;
      _capturedOutput = [];

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
        onTimeout: () => _BuildResult(
          success: false,
          error: 'Build timed out after 10 seconds',
          output: _capturedOutput,
        ),
      );

      _addLogEntry(
        result.success
            ? 'Build completed: ${result.widgetType}'
            : 'Build failed: ${result.error}',
      );
      _scheduleLogRefresh();

      _respond(request, result.success ? 200 : 400, result.toJson());
    } on FormatException catch (e) {
      _log('JSON parse error: $e');
      _respond(request, 400, {'error': 'Invalid JSON: $e', 'output': []});
    }
  }

  /// Build the D4rt widget from a pending bundle using the current BuildContext.
  /// Captures print() output and completes the build completer.
  Widget _buildD4rtWidget(BuildContext context) {
    if (_pendingBundle != null) {
      final bundle = _pendingBundle!;
      _pendingBundle = null;

      // Capture print() output using runZoned
      final output = <String>[];
      runZoned(
        () {
          try {
            final widget = _d4rt.build<Widget>(bundle, context);
            _d4rtWidget = widget;
            _lastError = null;

            // Complete with success
            _buildCompleter?.complete(
              _BuildResult(
                success: true,
                widgetType: widget.runtimeType.toString(),
                output: output,
              ),
            );
          } on FlutterD4rtException catch (e) {
            _lastError = e.message;
            _buildCompleter?.complete(
              _BuildResult(success: false, error: e.message, output: output),
            );
          } catch (e) {
            _lastError = e.toString();
            _buildCompleter?.complete(
              _BuildResult(success: false, error: e.toString(), output: output),
            );
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
      _buildCompleter = null;
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
        title: const Text('D4rt Flutter Bridge Test'),
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

          // D4rt widget display area
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              margin: const EdgeInsets.all(8),
              child: _buildD4rtWidget(context),
            ),
          ),

          // Log panel
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Logs',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => setState(() => _logs.clear()),
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
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
                            color:
                                log.contains('error') || log.contains('Error')
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
            ),
          ),
        ],
      ),
    );
  }
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
