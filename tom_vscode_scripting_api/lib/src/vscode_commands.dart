/// VS Code Commands API wrapper for Dart
library;

import 'dart:async';
import 'vscode_adapter.dart';

/// Wrapper for vscode.commands API
/// Provides access to VS Code command system
class VSCodeCommands {
  final VSCodeAdapter _adapter;

  VSCodeCommands(this._adapter);

  /// Execute a VS Code command
  /// Returns the result of the command execution (can be any type)
  Future<dynamic> executeCommand(String command, {List<dynamic>? args, int timeoutSeconds = 120}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const result = await context.vscode.commands.executeCommand(
          params.command,
          ...(params.args || [])
        );
        return result;
      ''',
      'params': {
        'command': command,
        'args': ?args,
      },
    }, scriptName: 'executeCommand', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'];
    }
    return null;
  }

  /// Get all registered commands
  Future<List<String>> getCommands({bool filterInternal = false, int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const commands = await context.vscode.commands.getCommands(params.filterInternal);
        return commands;
      ''',
      'params': {
        'filterInternal': filterInternal,
      },
    }, scriptName: 'getCommands', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return (result['result'] as List).cast<String>();
    }
    return [];
  }

  /// Register a command (requires command to be defined on TypeScript side)
  /// This is a helper that creates a command registration on the TS side
  /// Returns true if successful
  Future<bool> registerCommand(
    String command,
    String handlerScript,
    {int timeoutSeconds = 120}
  ) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        // Register command with handler
        const disposable = context.vscode.commands.registerCommand(
          params.command,
          async (...args) => {
            // Execute handler script with args
            const AsyncFunction = Object.getPrototypeOf(async function(){}).constructor;
            const handler = new AsyncFunction('params', 'context', 'args', params.handlerScript);
            return await handler(params, context, args);
          }
        );
        // Store disposable for cleanup (simplified)
        return true;
      ''',
      'params': {
        'command': command,
        'handlerScript': handlerScript,
      },
    }, scriptName: 'registerCommand', timeout: Duration(seconds: timeoutSeconds));

    return result['success'] == true;
  }
}

/// Common VS Code commands
class VSCodeCommonCommands {
  /// Open a file
  static const String openFile = 'vscode.open';

  /// Open folder
  static const String openFolder = 'vscode.openFolder';

  /// New untitled file
  static const String newUntitledFile = 'workbench.action.files.newUntitledFile';

  /// Save file
  static const String saveFile = 'workbench.action.files.save';

  /// Save all files
  static const String saveAllFiles = 'workbench.action.files.saveAll';

  /// Close active editor
  static const String closeActiveEditor = 'workbench.action.closeActiveEditor';

  /// Show all commands
  static const String showCommands = 'workbench.action.showCommands';

  /// Quick open
  static const String quickOpen = 'workbench.action.quickOpen';

  /// Go to file
  static const String goToFile = 'workbench.action.quickOpen';

  /// Go to symbol in workspace
  static const String goToSymbol = 'workbench.action.showAllSymbols';

  /// Go to line
  static const String goToLine = 'workbench.action.gotoLine';

  /// Find in files
  static const String findInFiles = 'workbench.action.findInFiles';

  /// Replace in files
  static const String replaceInFiles = 'workbench.action.replaceInFiles';

  /// Toggle terminal
  static const String toggleTerminal = 'workbench.action.terminal.toggleTerminal';

  /// New terminal
  static const String newTerminal = 'workbench.action.terminal.new';

  /// Toggle sidebar
  static const String toggleSidebar = 'workbench.action.toggleSidebarVisibility';

  /// Toggle panel
  static const String togglePanel = 'workbench.action.togglePanel';

  /// Format document
  static const String formatDocument = 'editor.action.formatDocument';

  /// Organize imports
  static const String organizeImports = 'editor.action.organizeImports';

  /// Rename symbol
  static const String renameSymbol = 'editor.action.rename';

  /// Go to definition
  static const String goToDefinition = 'editor.action.revealDefinition';

  /// Go to references
  static const String goToReferences = 'editor.action.goToReferences';

  /// Show hover
  static const String showHover = 'editor.action.showHover';

  /// Comment line
  static const String commentLine = 'editor.action.commentLine';

  /// Copy line down
  static const String copyLineDown = 'editor.action.copyLinesDownAction';

  /// Move line down
  static const String moveLineDown = 'editor.action.moveLinesDownAction';

  /// Delete line
  static const String deleteLine = 'editor.action.deleteLines';

  /// Reload window
  static const String reloadWindow = 'workbench.action.reloadWindow';

  /// Show extensions
  static const String showExtensions = 'workbench.extensions.action.showExtensionsOnRunningBrowser';

  /// Install extension
  static const String installExtension = 'workbench.extensions.installExtension';
}
