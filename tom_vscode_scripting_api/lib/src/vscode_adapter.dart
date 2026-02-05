/// Abstract adapter interface for VS Code communication
///
/// This abstraction allows the VS Code API wrappers to be decoupled from
/// the specific bridge implementation (VSCodeBridgeServer).
library;

/// Abstract interface for sending requests to VS Code
///
/// Implementations of this interface handle the actual communication
/// with the VS Code extension via their preferred transport mechanism.
///
/// The primary implementation is `VSCodeBridgeServer` in the
/// `tom_vscode_bridge` package.
abstract class VSCodeAdapter {
  /// Send a request to VS Code and wait for the response
  ///
  /// [method] - The JSON-RPC method to invoke
  /// [params] - The parameters to send with the request
  /// [scriptName] - Optional name for logging/debugging purposes
  /// [timeout] - Maximum time to wait for response
  ///
  /// Returns a Map containing the response data.
  /// Typically includes 'success' and 'result' fields.
  Future<Map<String, dynamic>> sendRequest(
    String method,
    Map<String, dynamic> params, {
    String? scriptName,
    Duration timeout = const Duration(seconds: 60),
  });
}
