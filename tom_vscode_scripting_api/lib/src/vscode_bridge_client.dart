/// VS Code Bridge Client for Tom CLI
///
/// Provides socket-based communication with the VS Code VS Code Bridge.
/// Used to execute D4rt commands in the VS Code environment where the
/// VS Code Bridge has access to VS Code APIs.
///
/// ## Connection
/// Connects to the VS Code Bridge socket server (default port 19900).
/// The server must be started from VS Code using the Command Palette:
/// - "DS: Start Tom CLI Integration Server"
///
/// ## Protocol
/// Uses length-prefix framing with JSON-RPC 2.0:
/// - [4 bytes BE uint32][JSON-RPC 2.0 payload]
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Default port for VS Code VS Code Bridge
const int defaultVSCodeBridgePort = 19900;

/// Result of a VS Code bridge command execution.
class VSCodeBridgeResult {
  /// Whether the execution was successful.
  final bool success;

  /// The result value (if successful).
  final dynamic value;

  /// Output from the execution (logs on error).
  final String output;

  /// Error message (if failed).
  final String? error;

  /// Stack trace (if failed).
  final String? stackTrace;

  /// Exception message if one was caught internally during successful execution.
  final String? exception;

  /// Exception stack trace if one was caught internally.
  final String? exceptionStackTrace;

  /// Execution duration.
  final Duration duration;

  const VSCodeBridgeResult({
    required this.success,
    this.value,
    this.output = '',
    this.error,
    this.stackTrace,
    this.exception,
    this.exceptionStackTrace,
    required this.duration,
  });

  /// Whether an exception was caught internally during execution.
  bool get hasException => exception != null;

  /// Creates a successful result.
  factory VSCodeBridgeResult.success({
    dynamic value,
    String output = '',
    String? exception,
    String? exceptionStackTrace,
    required Duration duration,
  }) {
    return VSCodeBridgeResult(
      success: true,
      value: value,
      output: output,
      exception: exception,
      exceptionStackTrace: exceptionStackTrace,
      duration: duration,
    );
  }

  /// Creates a failure result with optional logs and stack trace.
  factory VSCodeBridgeResult.failure({
    required String error,
    String? stackTrace,
    String output = '',
    required Duration duration,
  }) {
    return VSCodeBridgeResult(
      success: false,
      error: error,
      stackTrace: stackTrace,
      output: output,
      duration: duration,
    );
  }
}

/// Client for communicating with VS Code VS Code Bridge.
///
/// Example:
/// ```dart
/// final client = VSCodeBridgeClient();
/// if (await client.connect()) {
///   final result = await client.executeExpression('VSCode.showMessage("Hello")');
///   print(result.output);
///   await client.disconnect();
/// }
/// ```
class VSCodeBridgeClient {
  /// The host to connect to.
  final String host;
  
  /// The port to connect to.
  final int port;

  /// Connection timeout.
  final Duration connectTimeout;

  /// Request timeout.
  final Duration requestTimeout;

  Socket? _socket;
  int _messageId = 0;
  final Map<String, Completer<Map<String, dynamic>>> _pendingRequests = {};
  final List<int> _buffer = [];

  /// Creates a VS Code bridge client.
  /// 
  /// [host] - The host to connect to (default: '127.0.0.1').
  /// [port] - The port to connect to (default: 19900).
  VSCodeBridgeClient({
    this.host = '127.0.0.1',
    this.port = defaultVSCodeBridgePort,
    this.connectTimeout = const Duration(seconds: 5),
    this.requestTimeout = const Duration(seconds: 30),
  });

  /// Whether the client is connected.
  bool get isConnected => _socket != null;

  /// Attempts to connect to the VS Code bridge.
  ///
  /// Returns true if connection was successful.
  Future<bool> connect() async {
    if (isConnected) return true;

    try {
      _socket = await Socket.connect(
        host,
        port,
        timeout: connectTimeout,
      );

      _socket!.listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      return true;
    } on SocketException {
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Disconnects from the VS Code bridge.
  Future<void> disconnect() async {
    if (_socket != null) {
      await _socket!.close();
      _socket = null;
    }
    _pendingRequests.clear();
    _buffer.clear();
  }

  /// Checks if the VS Code bridge is available.
  ///
  /// Attempts a quick connection and immediately disconnects.
  /// 
  /// [host] - The host to check (default: '127.0.0.1').
  /// [port] - The port to check (default: 19900).
  static Future<bool> isAvailable({
    String host = '127.0.0.1',
    int port = defaultVSCodeBridgePort,
  }) async {
    try {
      final socket = await Socket.connect(
        host,
        port,
        timeout: const Duration(seconds: 2),
      );
      await socket.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Sends a JSON-RPC request to the bridge.
  Future<Map<String, dynamic>> sendRequest(
    String method,
    Map<String, dynamic> params,
  ) async {
    if (!isConnected) {
      throw StateError('Not connected to VS Code bridge');
    }

    final id = 'tom-${_messageId++}';
    final request = {
      'jsonrpc': '2.0',
      'id': id,
      'method': method,
      'params': params,
    };

    final completer = Completer<Map<String, dynamic>>();
    _pendingRequests[id] = completer;

    // Encode with length prefix
    final jsonBytes = utf8.encode(jsonEncode(request));
    final lengthBytes = ByteData(4)..setUint32(0, jsonBytes.length, Endian.big);
    _socket!.add(lengthBytes.buffer.asUint8List());
    _socket!.add(jsonBytes);

    // Wait for response with timeout
    try {
      return await completer.future.timeout(requestTimeout);
    } on TimeoutException {
      _pendingRequests.remove(id);
      throw TimeoutException('Request timed out', requestTimeout);
    }
  }

  /// Executes a D4rt expression via VS Code bridge.
  ///
  /// The expression is evaluated and its value is returned.
  /// Uses the server's 'executeExpressionVcb' method with D4rt's eval().
  Future<VSCodeBridgeResult> executeExpression(String expression) async {
    final stopwatch = Stopwatch()..start();

    try {
      final response = await sendRequest('executeExpressionVcb', {
        'expression': expression,
        'params': {},
      });

      stopwatch.stop();

      if (response['success'] == true) {
        // Success: logs came via real-time notifications, include exception info if present
        return VSCodeBridgeResult.success(
          value: response['result'],
          exception: response['exception']?.toString(),
          exceptionStackTrace: response['exceptionStackTrace']?.toString(),
          duration: stopwatch.elapsed,
        );
      } else {
        // Failure: include logs and stack trace for debugging
        final logs = response['logs'];
        final output = logs is List ? logs.join('\n') : (logs?.toString() ?? '');
        return VSCodeBridgeResult.failure(
          error: response['error']?.toString() ?? 'Unknown error',
          stackTrace: response['stackTrace']?.toString(),
          output: output,
          duration: stopwatch.elapsed,
        );
      }
    } catch (e, stackTrace) {
      stopwatch.stop();
      return VSCodeBridgeResult.failure(
        error: e.toString(),
        stackTrace: stackTrace.toString(),
        duration: stopwatch.elapsed,
      );
    }
  }

  /// Executes a D4rt script file via VS Code bridge.
  Future<VSCodeBridgeResult> executeScriptFile(String filePath) async {
    final stopwatch = Stopwatch()..start();

    try {
      final response = await sendRequest('executeFileVcb', {
        'filePath': filePath,
        'params': {},
      });

      stopwatch.stop();

      // Include logs for debugging
      final logs = response['logs'];
      final output = logs is List ? logs.join('\n') : (logs?.toString() ?? '');
      if (response['success'] == true) {
        // Success: logs came via real-time notifications, include exception info if present
        return VSCodeBridgeResult.success(
          value: response['result'],
          exception: response['exception']?.toString(),
          exceptionStackTrace: response['exceptionStackTrace']?.toString(),
          output: output,
          duration: stopwatch.elapsed,
        );
      } else {
        // Failure: include stack trace and logs for debugging
        return VSCodeBridgeResult.failure(
          error: response['error']?.toString() ?? 'Unknown error',
          stackTrace: response['stackTrace']?.toString(),
          output: output,
          duration: stopwatch.elapsed,
        );
      }
    } catch (e, stackTrace) {
      stopwatch.stop();
      return VSCodeBridgeResult.failure(
        error: e.toString(),
        stackTrace: stackTrace.toString(),
        duration: stopwatch.elapsed,
      );
    }
  }

  /// Executes D4rt script code via VS Code bridge.
  Future<VSCodeBridgeResult> executeScript(String code) async {
    final stopwatch = Stopwatch()..start();

    try {
      final response = await sendRequest('executeScriptVcb', {
        'script': code,
        'params': {},
      });

      stopwatch.stop();

      if (response['success'] == true) {
        // Success: logs came via real-time notifications, include exception info if present
        return VSCodeBridgeResult.success(
          value: response['result'],
          exception: response['exception']?.toString(),
          exceptionStackTrace: response['exceptionStackTrace']?.toString(),
          duration: stopwatch.elapsed,
        );
      } else {
        // Failure: include stack trace and logs for debugging
        final logs = response['logs'];
        final output = logs is List ? logs.join('\n') : (logs?.toString() ?? '');
        return VSCodeBridgeResult.failure(
          error: response['error']?.toString() ?? 'Unknown error',
          stackTrace: response['stackTrace']?.toString(),
          output: output,
          duration: stopwatch.elapsed,
        );
      }
    } catch (e, stackTrace) {
      stopwatch.stop();
      return VSCodeBridgeResult.failure(
        error: e.toString(),
        stackTrace: stackTrace.toString(),
        duration: stopwatch.elapsed,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Private Methods
  // ---------------------------------------------------------------------------

  void _onData(List<int> data) {
    _buffer.addAll(data);
    _processBuffer();
  }

  void _processBuffer() {
    // Need at least 4 bytes for length prefix
    while (_buffer.length >= 4) {
      final lengthBytes = Uint8List.fromList(_buffer.sublist(0, 4));
      final length = ByteData.sublistView(lengthBytes).getUint32(0, Endian.big);

      // Check if we have the full message
      if (_buffer.length < 4 + length) {
        break;
      }

      // Extract message
      final messageBytes = _buffer.sublist(4, 4 + length);
      _buffer.removeRange(0, 4 + length);

      // Parse JSON
      try {
        final json = jsonDecode(utf8.decode(messageBytes));
        _handleResponse(json as Map<String, dynamic>);
      } catch (e) {
        // Ignore malformed messages
      }
    }
  }

  void _handleResponse(Map<String, dynamic> response) {
    // Handle log notifications (no id means it's a notification)
    final id = response['id']?.toString();
    if (id == null) {
      // This is a notification, e.g., log messages
      final method = response['method'];
      if (method == 'log') {
        final message = response['params']?['message'];
        if (message != null) {
          // Print log messages in real-time
          print('[VS Code] $message');
        }
      }
      return;
    }

    if (_pendingRequests.containsKey(id)) {
      final completer = _pendingRequests.remove(id)!;
      if (response.containsKey('error')) {
        completer.complete({
          'success': false,
          'error': response['error'],
        });
      } else {
        final result = response['result'];
        // Handle both direct result and wrapped result (from executeScript)
        if (result is Map<String, dynamic>) {
          completer.complete(result);
        } else {
          completer.complete({
            'success': true,
            'result': result,
          });
        }
      }
    }
  }

  void _onError(Object error) {
    // Complete all pending requests with error
    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.completeError(error);
      }
    }
    _pendingRequests.clear();
  }

  void _onDone() {
    _socket = null;
    // Complete all pending requests with connection closed error
    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.completeError(StateError('Connection closed'));
      }
    }
    _pendingRequests.clear();
  }
}
