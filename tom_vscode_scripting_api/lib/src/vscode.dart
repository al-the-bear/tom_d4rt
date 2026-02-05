/// Main VS Code API wrapper - combines all API namespaces
library;

import 'dart:async';
import 'vscode_adapter.dart';
import 'vscode_workspace.dart';
import 'vscode_window.dart';
import 'vscode_commands.dart';
import 'vscode_extensions.dart';
import 'vscode_lm.dart';
import 'vscode_chat.dart';

/// Main VS Code API wrapper class
/// Provides unified access to all VS Code APIs through Dart
/// 
/// Usage:
/// ```dart
/// final vscode = VSCode(adapter);
/// 
/// // Show message
/// await vscode.window.showInformationMessage('Hello from Dart!');
/// 
/// // Get workspace folders
/// final folders = await vscode.workspace.getWorkspaceFolders();
/// 
/// // Execute command
/// await vscode.commands.executeCommand('workbench.action.files.save');
/// ```
class VSCode {
  static VSCodeAdapter? _adapter;
  static VSCode? _vsCode;

  late final VSCodeWorkspace workspace;
  late final VSCodeWindow window;
  late final VSCodeCommands commands;
  late final VSCodeExtensions extensions;
  late final VSCodeLanguageModel lm;
  late final VSCodeChat chat;

  /// Get the adapter instance (for advanced use cases)
  VSCodeAdapter get adapter {
    if (_adapter == null) {
      throw StateError('VSCode not initialized. Call VSCode.initialize() first.');
    }
    return _adapter!;
  }

  /// Private constructor
  VSCode._internal(VSCodeAdapter adapter) {
    workspace = VSCodeWorkspace(adapter);
    window = VSCodeWindow(adapter);
    commands = VSCodeCommands(adapter);
    extensions = VSCodeExtensions(adapter);
    lm = VSCodeLanguageModel(adapter);
    chat = VSCodeChat(adapter);
  }

  /// Get the singleton instance
  /// Throws if not initialized
  static VSCode get instance {
    if (_vsCode == null) {
      throw StateError('VSCode not initialized. Call VSCode.initialize() first.');
    }
    return _vsCode!;
  }

  /// Initialize the static VSCode instance with an adapter
  static void initialize(VSCodeAdapter adapter) {
    _adapter = adapter;
    _vsCode = VSCode._internal(adapter);
  }

  /// Check if VSCode is initialized
  static bool get isInitialized => _vsCode != null;

  /// Get VS Code version
  Future<String> getVersion({int timeoutSeconds = 10}) async {
    final result = await adapter.sendRequest('executeScriptVce', {
      'script': '''
        return context.vscode.version;
      ''',
      'params': {},
    }, scriptName: 'getVersion', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'] ?? 'unknown';
    }
    return 'unknown';
  }

  /// Get environment information
  Future<Map<String, dynamic>> getEnv({int timeoutSeconds = 10}) async {
    final result = await adapter.sendRequest('executeScriptVce', {
      'script': '''
        return {
          appName: context.vscode.env.appName,
          appRoot: context.vscode.env.appRoot,
          language: context.vscode.env.language,
          machineId: context.vscode.env.machineId,
          sessionId: context.vscode.env.sessionId,
          remoteName: context.vscode.env.remoteName,
          shell: context.vscode.env.shell,
          uiKind: context.vscode.env.uiKind
        };
      ''',
      'params': {},
    }, scriptName: 'getEnv', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'] ?? {};
    }
    return {};
  }

  /// Open external URI (like browser)
  Future<bool> openExternal(String uri, {int timeoutSeconds = 30}) async {
    final result = await adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uri = context.vscode.Uri.parse(params.uri);
        const success = await context.vscode.env.openExternal(uri);
        return success;
      ''',
      'params': {'uri': uri},
    }, scriptName: 'openExternal', timeout: Duration(seconds: timeoutSeconds));

    return result['success'] == true && result['result'] == true;
  }

  /// Copy to clipboard
  Future<void> copyToClipboard(String text, {int timeoutSeconds = 10}) async {
    await adapter.sendRequest('executeScriptVce', {
      'script': '''
        await context.vscode.env.clipboard.writeText(params.text);
      ''',
      'params': {'text': text},
    }, scriptName: 'copyToClipboard', timeout: Duration(seconds: timeoutSeconds));
  }

  /// Read from clipboard
  Future<String> readFromClipboard({int timeoutSeconds = 10}) async {
    final result = await adapter.sendRequest('executeScriptVce', {
      'script': '''
        return await context.vscode.env.clipboard.readText();
      ''',
      'params': {},
    }, scriptName: 'readFromClipboard', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'] ?? '';
    }
    return '';
  }
}
