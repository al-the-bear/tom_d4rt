/// VS Code Bridge Adapter
///
/// Implementation of [VSCodeAdapter] that uses [VSCodeBridgeClient] for
/// socket-based communication with the VS Code Tom CLI Integration Server.
library;

import 'vscode_adapter.dart';
import 'vscode_bridge_client.dart';

/// Implementation of [VSCodeAdapter] using [VSCodeBridgeClient].
///
/// This adapter provides the bridge between the VS Code Scripting API
/// and the socket-based VS Code Bridge Client for CLI tools like d4rt.
///
/// Example:
/// ```dart
/// final client = VSCodeBridgeClient(port: 19900);
/// if (await client.connect()) {
///   final adapter = VSCodeBridgeAdapter(client);
///   VSCode.initialize(adapter);
///   // Now vscode globals are available
/// }
/// ```
class VSCodeBridgeAdapter implements VSCodeAdapter {
  /// The underlying bridge client.
  final VSCodeBridgeClient client;

  /// Creates a VS Code bridge adapter.
  ///
  /// The [client] must be connected before using this adapter.
  VSCodeBridgeAdapter(this.client);

  @override
  Future<Map<String, dynamic>> sendRequest(
    String method,
    Map<String, dynamic> params, {
    String? scriptName,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    if (!client.isConnected) {
      throw StateError('VSCodeBridgeClient is not connected');
    }

    // Use the client's sendRequest with the method and params
    final response = await client.sendRequest(method, params);
    return response;
  }

  /// Whether the underlying client is connected.
  bool get isConnected => client.isConnected;

  /// Disconnect the underlying client.
  Future<void> disconnect() async {
    await client.disconnect();
  }
}

/// A lazy-connecting adapter that auto-connects on first use.
///
/// This adapter defers connection until the first request is made.
/// Useful for CLI tools like d4rt where VS Code integration is optional
/// but should "just work" when needed.
///
/// Example:
/// ```dart
/// final adapter = LazyVSCodeBridgeAdapter(port: 19900);
/// VSCode.initialize(adapter);
/// // No connection yet...
/// 
/// // First use triggers auto-connect
/// await VSCode.instance.window.showInformationMessage('Hello!');
/// ```
class LazyVSCodeBridgeAdapter implements VSCodeAdapter {
  /// The host to connect to.
  String _host;
  
  /// The port to connect to.
  int _port;
  
  /// The underlying client, created on first connect.
  VSCodeBridgeClient? _client;
  
  /// Connection in progress (to avoid multiple simultaneous connects).
  Future<bool>? _connecting;
  
  /// Callback for connection status messages.
  final void Function(String message)? onStatusMessage;
  
  /// Callback for error messages.
  final void Function(String message)? onErrorMessage;

  /// Creates a lazy VS Code bridge adapter.
  ///
  /// [host] - The host to connect to (default: '127.0.0.1').
  /// [port] - The port to connect to (default: 19900).
  /// [onStatusMessage] - Optional callback for status messages.
  /// [onErrorMessage] - Optional callback for error messages.
  LazyVSCodeBridgeAdapter({
    String host = '127.0.0.1',
    int port = defaultVSCodeBridgePort,
    this.onStatusMessage,
    this.onErrorMessage,
  }) : _host = host, _port = port;

  /// Update the host and port for future connections.
  /// 
  /// If already connected to a different host/port, disconnects first.
  Future<void> setHostPort(String host, int port) async {
    if (_host != host || _port != port) {
      if (_client?.isConnected == true) {
        await disconnect();
      }
      _host = host;
      _port = port;
    }
  }
  
  /// Update the port for future connections.
  /// 
  /// If already connected to a different port, disconnects first.
  Future<void> setPort(int port) async {
    if (_port != port) {
      if (_client?.isConnected == true) {
        await disconnect();
      }
      _port = port;
    }
  }
  
  /// Get the current host.
  String get host => _host;
  
  /// Get the current port.
  int get port => _port;

  /// Whether the underlying client is connected.
  bool get isConnected => _client?.isConnected ?? false;

  /// Manually connect to the VS Code integration server.
  /// 
  /// Returns true if connected successfully.
  Future<bool> connect() async {
    if (_client?.isConnected == true) {
      return true;
    }
    
    // If a connection is in progress, wait for it
    if (_connecting != null) {
      return _connecting!;
    }
    
    _connecting = _doConnect();
    try {
      return await _connecting!;
    } finally {
      _connecting = null;
    }
  }
  
  Future<bool> _doConnect() async {
    // Check if server is available
    final available = await VSCodeBridgeClient.isAvailable(host: _host, port: _port);
    if (!available) {
      onErrorMessage?.call('No Tom VS Code CLI Integration Server found at $_host:$_port.');
      return false;
    }
    
    // Connect
    _client = VSCodeBridgeClient(host: _host, port: _port);
    final connected = await _client!.connect();
    
    if (connected) {
      onStatusMessage?.call('Connected to VS Code at $_host:$_port');
      return true;
    } else {
      onErrorMessage?.call('Failed to connect to VS Code at $_host:$_port');
      _client = null;
      return false;
    }
  }

  /// Disconnect the underlying client.
  Future<void> disconnect() async {
    if (_client != null) {
      await _client!.disconnect();
      _client = null;
    }
  }

  @override
  Future<Map<String, dynamic>> sendRequest(
    String method,
    Map<String, dynamic> params, {
    String? scriptName,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    // Auto-connect on first use
    if (!isConnected) {
      final connected = await connect();
      if (!connected) {
        throw StateError(
          'Cannot connect to VS Code integration server on port $_port. '
          'Make sure VS Code is running with the Tom CLI Integration Server started. '
          'Use the command palette: "DS: Start Tom CLI Integration Server"'
        );
      }
    }

    // Use the client's sendRequest
    final response = await _client!.sendRequest(method, params);
    return response;
  }
}
