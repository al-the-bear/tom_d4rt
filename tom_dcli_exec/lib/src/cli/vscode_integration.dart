/// VS Code Integration for D4rt REPL
///
/// Provides VS Code bridge commands and utilities for D4rt-based CLI tools.
library;

import 'package:tom_vscode_scripting_api/script_globals.dart';

import 'repl_state.dart';

export 'package:tom_vscode_scripting_api/script_globals.dart';

/// Mixin providing VS Code integration for D4rt REPL tools.
///
/// Add this mixin to your REPL class and override [hasVSCodeIntegration] to return true.
/// Call [initVSCodeIntegration] in [createReplState] and [handleVSCodeCommands] in 
/// [handleAdditionalCommands].
mixin VSCodeIntegrationMixin {
  /// The lazy VS Code adapter for deferred connection.
  LazyVSCodeBridgeAdapter? _lazyAdapter;

  /// VS Code server port (default: 19900)
  int vscodePort = defaultVSCodeBridgePort;

  /// Initialize VS Code integration with lazy adapter.
  /// Call this in [createReplState].
  void initVSCodeIntegration({
    void Function(String)? onStatusMessage,
    void Function(String)? onErrorMessage,
  }) {
    _lazyAdapter = LazyVSCodeBridgeAdapter(
      port: vscodePort,
      onStatusMessage: onStatusMessage ?? (msg) => print('<green>✓</green> $msg'),
      onErrorMessage: onErrorMessage ?? (msg) => print('<red>✗</red> $msg'),
    );
    // Initialize VSCode with lazy adapter - will auto-connect when first used
    VSCode.initialize(_lazyAdapter!);
  }

  /// Check VS Code availability and print status.
  /// Call this in [onReplStartup].
  Future<void> checkVSCodeAvailability() async {
    try {
      final available = await VSCodeBridgeClient.isAvailable(port: vscodePort);
      if (available) {
        print('  <green>**VS Code server is available on port $vscodePort**</green>');
      } else {
        _printVSCodeHint();
      }
    } catch (_) {
      _printVSCodeHint();
    }
  }

  void _printVSCodeHint() {
    print('  <cyan>**VS Code:**</cyan> <yellow>**connect**</yellow> [<host>]:[<port>]  |  <yellow>**is-available**</yellow> [<host>]:[<port>]  |  Default-Port: **$vscodePort**');
  }

  /// Returns the VS Code integration help section.
  String getVSCodeIntegrationHelp() {
    return '''
<cyan>**VS Code Integration**</cyan>
  <yellow>**connect**</yellow> [host:port]  Connect to VS Code server *(default: 19900)*
  <yellow>**disconnect**</yellow>           Disconnect from VS Code
  <yellow>**is-available**</yellow> [port]  Check if VS Code server is available
  <yellow>**.vscode**</yellow> <file>       Execute Dart file in VS Code bridge
  <yellow>**vscode**</yellow> <expression>  Evaluate expression in VS Code bridge
  <yellow>**.start-vscode-eval**</yellow>   Start multiline VS Code eval mode
  <yellow>**.start-vscode-script**</yellow> Start multiline VS Code script mode''';
  }

  /// Handle VS Code commands.
  /// Returns true if the command was handled.
  Future<bool> handleVSCodeCommands(
    ReplState state,
    String line, {
    bool silent = false,
  }) async {
    // VS Code integration commands
    if (line == 'connect' || line.startsWith('connect ')) {
      await _handleConnectCommand(state, line, silent);
      return true;
    }

    if (line == 'disconnect') {
      await _handleDisconnectCommand(state, silent);
      return true;
    }

    if (line == 'is-available' || line.startsWith('is-available ')) {
      await _handleIsAvailableCommand(state, line, silent);
      return true;
    }

    // VS Code execution commands
    if (line.startsWith('.vscode ')) {
      await _handleVscodeFileCommand(state, line, silent);
      return true;
    }

    if (line.startsWith('vscode ')) {
      await _handleVscodeExpressionCommand(state, line, silent);
      return true;
    }

    if (line == '.start-vscode-eval') {
      state.multilineMode = MultilineMode.vscodeEval;
      if (!silent) print('(entering VS Code eval mode - type .end to execute)');
      return true;
    }

    if (line == '.start-vscode-script') {
      state.multilineMode = MultilineMode.vscodeScript;
      if (!silent) print('(entering VS Code script mode - type .end to execute)');
      return true;
    }

    return false;
  }

  /// Handle VS Code multiline mode endings.
  /// Returns true if the mode was handled.
  Future<bool> handleVSCodeMultilineEnd(
    ReplState state,
    MultilineMode mode,
    String code, {
    bool silent = false,
  }) async {
    if (mode == MultilineMode.vscodeEval) {
      await _executeInVscode(state, silent, script: code, isEvalMode: true);
      return true;
    }

    if (mode == MultilineMode.vscodeScript) {
      await _executeInVscode(state, silent, script: code, isEvalMode: false);
      return true;
    }

    return false;
  }

  /// Handle the 'connect' command.
  Future<void> _handleConnectCommand(ReplState state, String line, bool silent) async {
    if (_lazyAdapter == null) {
      if (!silent) state.writeError('No VS Code adapter configured.');
      return;
    }

    // Parse optional host:port argument
    final parts = line.split(' ');
    String host = '127.0.0.1';
    int port = vscodePort;

    if (parts.length > 1) {
      final hostPort = parts[1];
      if (hostPort.contains(':')) {
        final colonIndex = hostPort.lastIndexOf(':');
        host = hostPort.substring(0, colonIndex);
        final portStr = hostPort.substring(colonIndex + 1);
        final parsed = int.tryParse(portStr);
        if (parsed == null) {
          if (!silent) state.writeError('Invalid port: $portStr');
          return;
        }
        port = parsed;
      } else {
        final parsed = int.tryParse(hostPort);
        if (parsed != null) {
          port = parsed;
        } else {
          host = hostPort;
        }
      }
    }

    await _lazyAdapter!.setHostPort(host, port);
    await _lazyAdapter!.connect();
  }

  /// Handle the 'disconnect' command.
  Future<void> _handleDisconnectCommand(ReplState state, bool silent) async {
    if (_lazyAdapter == null || !_lazyAdapter!.isConnected) {
      if (!silent) state.writeMuted('Not connected to VS Code.');
      return;
    }

    await _lazyAdapter!.disconnect();
    if (!silent) state.writeSuccess('Disconnected from VS Code.');
  }

  /// Handle the 'is-available' command.
  Future<void> _handleIsAvailableCommand(ReplState state, String line, bool silent) async {
    int port = vscodePort;

    if (line.length > 12) {
      final parsed = int.tryParse(line.substring(13).trim());
      if (parsed != null) port = parsed;
    }

    try {
      final available = await VSCodeBridgeClient.isAvailable(port: port);

      if (!silent) {
        if (available) {
          state.writeSuccess('VS Code server is available on port $port');
        } else {
          state.writeMuted('VS Code server is not available on port $port');
        }
      }
    } catch (e) {
      if (!silent) state.writeError('Check failed: $e');
    }
  }

  /// Handle the '.vscode `<file>`' command - execute file in VS Code bridge.
  Future<void> _handleVscodeFileCommand(ReplState state, String line, bool silent) async {
    final filePath = line.substring(8).trim();
    if (filePath.isEmpty) {
      if (!silent) state.writeError('Usage: .vscode <filepath>');
      return;
    }

    await _executeInVscode(state, silent, filePath: filePath);
  }

  /// Handle the 'vscode `<expression>`' command - evaluate expression in VS Code bridge.
  Future<void> _handleVscodeExpressionCommand(ReplState state, String line, bool silent) async {
    final expression = line.substring(7).trim();
    if (expression.isEmpty) {
      if (!silent) state.writeError('Usage: vscode <expression>');
      return;
    }

    await _executeInVscode(state, silent, expression: expression);
  }

  /// Execute code in VS Code bridge.
  Future<void> _executeInVscode(
    ReplState state,
    bool silent, {
    String? filePath,
    String? expression,
    String? script,
    bool isEvalMode = false,
  }) async {
    try {
      final client = VSCodeBridgeClient(port: vscodePort);

      // Connect if not already connected
      if (!await client.connect()) {
        if (!silent) state.writeError('Could not connect to VS Code bridge on port $vscodePort');
        return;
      }

      VSCodeBridgeResult result;

      if (filePath != null) {
        // Execute file
        result = await client.executeScriptFile(filePath);
      } else if (expression != null) {
        // Evaluate expression
        result = await client.executeExpression(expression);
      } else if (script != null) {
        if (isEvalMode) {
          // Eval mode - evaluate as expression
          result = await client.executeExpression(script);
        } else {
          // Script mode - execute as complete script
          result = await client.executeScript(script);
        }
      } else {
        if (!silent) state.writeError('Nothing to execute');
        return;
      }

      if (!silent) {
        if (result.success) {
          // Print output if any
          if (result.output.isNotEmpty) {
            print(result.output);
          }
          // Print value if any
          if (result.value != null) {
            print(result.value);
          }
          // Note exceptions that were caught
          if (result.hasException) {
            state.writeWarning('Exception during execution: ${result.exception}');
          }
        } else {
          state.writeError(result.error ?? 'Unknown error');
          if (result.stackTrace != null) {
            state.writeMuted(result.stackTrace!);
          }
        }
      }

      await client.disconnect();
    } catch (e) {
      if (!silent) state.writeError('VS Code execution failed: $e');
    }
  }
}
