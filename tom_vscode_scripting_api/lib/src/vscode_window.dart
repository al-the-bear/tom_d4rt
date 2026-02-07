/// VS Code Window API wrapper for Dart
library;

import 'dart:async';
import 'vscode_adapter.dart';
import 'vscode_types.dart';

/// Wrapper for vscode.window API
/// Provides access to window-related functionality (UI, messages, editors, etc.)
class VSCodeWindow {
  final VSCodeAdapter _adapter;

  VSCodeWindow(this._adapter);

  /// Show information message
  Future<String?> showInformationMessage(
    String message, {
    List<String>? items,
    MessageOptions? options,
    int timeoutSeconds = 5 * 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        try {
          // Debug: log what we have access to
          console.log('[showInformationMessage] context.vscode:', typeof context.vscode);
          console.log('[showInformationMessage] context.vscode.window:', typeof context.vscode?.window);
          console.log('[showInformationMessage] showInformationMessage fn:', typeof context.vscode?.window?.showInformationMessage);
          console.log('[showInformationMessage] message:', params.message);
          
          const opts = params.options || {};
          const msgItems = params.items || [];
          
          // Call showInformationMessage - only pass opts if we have items or options
          let thenable;
          if (msgItems.length > 0 || Object.keys(opts).length > 0) {
            thenable = context.vscode.window.showInformationMessage(params.message, opts, ...msgItems);
          } else {
            thenable = context.vscode.window.showInformationMessage(params.message);
          }
          
          console.log('[showInformationMessage] thenable returned:', thenable);
          return { success: true, hasThenable: !!thenable };
        } catch (e) {
          console.error('[showInformationMessage] error:', e);
          return { success: false, error: e.message || String(e) };
        }
      ''',
      'params': {
        'message': message,
        'items': ?items,
        if (options != null) 'options': options.toJson(),
      },
    }, scriptName: 'showInformationMessage', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      // We don't wait for a selection; always return null to avoid blocking on UI interaction.
      return null;
    }
    return null;
  }

  /// Show warning message
  Future<String?> showWarningMessage(
    String message, {
    List<String>? items,
    MessageOptions? options,
    int timeoutSeconds = 5 * 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        try {
          const opts = params.options || {};
          const msgItems = params.items || [];
          // Call showWarningMessage - only pass opts if we have items or options
          if (msgItems.length > 0 || Object.keys(opts).length > 0) {
            context.vscode.window.showWarningMessage(params.message, opts, ...msgItems);
          } else {
            context.vscode.window.showWarningMessage(params.message);
          }
          return { success: true };
        } catch (e) {
          return { success: false, error: e.message || String(e) };
        }
      ''',
      'params': {
        'message': message,
        'items': ?items,
        if (options != null) 'options': options.toJson(),
      },
    }, scriptName: 'showWarningMessage', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return null;
    }
    return null;
  }

  /// Show error message
  Future<String?> showErrorMessage(
    String message, {
    List<String>? items,
    MessageOptions? options,
    int timeoutSeconds = 5 * 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        try {
          const opts = params.options || {};
          const msgItems = params.items || [];
          // Call showErrorMessage - only pass opts if we have items or options
          if (msgItems.length > 0 || Object.keys(opts).length > 0) {
            context.vscode.window.showErrorMessage(params.message, opts, ...msgItems);
          } else {
            context.vscode.window.showErrorMessage(params.message);
          }
          return { success: true };
        } catch (e) {
          return { success: false, error: e.message || String(e) };
        }
      ''',
      'params': {
        'message': message,
        'items': ?items,
        if (options != null) 'options': options.toJson(),
      },
    }, scriptName: 'showErrorMessage', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return null;
    }
    return null;
  }

  /// Show quick pick
  Future<String?> showQuickPick(
    List<String> items, {
    String? placeHolder,
    bool canPickMany = false,
    int timeoutSeconds = 30 * 60,
    String? fallbackValueOnTimeout,
    bool failOnTimeout = false,
  }) async {
    try {
      final result = await _adapter.sendRequest('executeScriptVce', {
        'script': '''
          const result = await context.vscode.window.showQuickPick(
            params.items,
            {
              placeHolder: params.placeHolder,
              canPickMany: params.canPickMany
            }
          );
          return result || null;
        ''',
        'params': {
          'items': items,
          'placeHolder': placeHolder,
          'canPickMany': canPickMany,
        },
      }, scriptName: 'showQuickPick', timeout: Duration(seconds: timeoutSeconds));

      if (result['success'] == true) {
        return result['result'] as String?;
      }
      return null;
    } on TimeoutException {
      if (failOnTimeout) {
        rethrow;
      }
      return fallbackValueOnTimeout;
    }
  }

  /// Show input box
  Future<String?> showInputBox({
    String? prompt,
    String? placeHolder,
    String? value,
    bool password = false,
    int timeoutSeconds = 30 * 60,
    String? fallbackValueOnTimeout,
    bool failOnTimeout = false,
  }) async {
    try {
      final result = await _adapter.sendRequest('executeScriptVce', {
        'script': '''
          const result = await context.vscode.window.showInputBox({
            prompt: params.prompt,
            placeHolder: params.placeHolder,
            value: params.value,
            password: params.password
          });
          return result || null;
        ''',
        'params': {
          'prompt': prompt,
          'placeHolder': placeHolder,
          'value': value,
          'password': password,
        },
      }, scriptName: 'showInputBox', timeout: Duration(seconds: timeoutSeconds));

      if (result['success'] == true) {
        return result['result'] as String?;
      }
      return null;
    } on TimeoutException {
      if (failOnTimeout) {
        rethrow;
      }
      return fallbackValueOnTimeout;
    }
  }

  /// Get active text editor
  Future<TextEditor?> getActiveTextEditor() async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const editor = context.vscode.window.activeTextEditor;
        if (!editor) return null;
        
        return {
          document: {
            uri: {
              scheme: editor.document.uri.scheme,
              authority: editor.document.uri.authority,
              path: editor.document.uri.path,
              query: editor.document.uri.query,
              fragment: editor.document.uri.fragment,
              fsPath: editor.document.uri.fsPath
            },
            fileName: editor.document.fileName,
            isUntitled: editor.document.isUntitled,
            languageId: editor.document.languageId,
            version: editor.document.version,
            isDirty: editor.document.isDirty,
            isClosed: editor.document.isClosed,
            lineCount: editor.document.lineCount
          },
          selection: {
            anchor: { line: editor.selection.anchor.line, character: editor.selection.anchor.character },
            active: { line: editor.selection.active.line, character: editor.selection.active.character },
            isReversed: editor.selection.isReversed
          },
          selections: editor.selections.map(s => ({
            anchor: { line: s.anchor.line, character: s.anchor.character },
            active: { line: s.active.line, character: s.active.character },
            isReversed: s.isReversed
          })),
          visibleRanges: editor.visibleRanges.map(r => ({
            start: { line: r.start.line, character: r.start.character },
            end: { line: r.end.line, character: r.end.character }
          }))
        };
      ''',
      'params': {},
    }, scriptName: 'getActiveTextEditor');

    if (result['success'] == true) {
      return TextEditor.fromJson(result['result']);
    }
    return null;
    
  }

  /// Show text document
  Future<TextEditor?> showTextDocument(String path, {int timeoutSeconds = 10 * 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uri = context.vscode.Uri.file(params.path);
        const doc = await context.vscode.workspace.openTextDocument(uri);
        const editor = await context.vscode.window.showTextDocument(doc);
        
        return {
          document: {
            uri: {
              scheme: editor.document.uri.scheme,
              authority: editor.document.uri.authority,
              path: editor.document.uri.path,
              query: editor.document.uri.query,
              fragment: editor.document.uri.fragment,
              fsPath: editor.document.uri.fsPath
            },
            fileName: editor.document.fileName,
            isUntitled: editor.document.isUntitled,
            languageId: editor.document.languageId,
            version: editor.document.version,
            isDirty: editor.document.isDirty,
            isClosed: editor.document.isClosed,
            lineCount: editor.document.lineCount
          },
          selection: {
            anchor: { line: editor.selection.anchor.line, character: editor.selection.anchor.character },
            active: { line: editor.selection.active.line, character: editor.selection.active.character },
            isReversed: editor.selection.isReversed
          },
          selections: editor.selections.map(s => ({
            anchor: { line: s.anchor.line, character: s.anchor.character },
            active: { line: s.active.line, character: s.active.character },
            isReversed: s.isReversed
          })),
          visibleRanges: []
        };
      ''',
      'params': {'path': path},
    }, scriptName: 'showTextDocument', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return TextEditor.fromJson(result['result']);
    }
    return null;
  }

  /// Create output channel
  Future<String> createOutputChannel(String name, {int timeoutSeconds = 30}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const channel = context.vscode.window.createOutputChannel(params.name);
        // Store channel reference (simplified - in real impl would need a registry)
        return params.name;
      ''',
      'params': {'name': name},
    }, scriptName: 'createOutputChannel', timeout: Duration(seconds: timeoutSeconds));

    return result['success'] == true ? name : '';
  }

  /// Append to output channel
  Future<void> appendToOutputChannel(String channelName, String text, {int timeoutSeconds = 30}) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        // In real implementation, would retrieve stored channel
        // For now, create new or use existing
        const channel = context.vscode.window.createOutputChannel(params.name);
        channel.append(params.text);
      ''',
      'params': {'name': channelName, 'text': text},
    }, scriptName: 'appendToOutputChannel', timeout: Duration(seconds: timeoutSeconds));
  }

  /// Show output channel
  Future<void> showOutputChannel(String channelName, {int timeoutSeconds = 30}) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const channel = context.vscode.window.createOutputChannel(params.name);
        channel.show();
      ''',
      'params': {'name': channelName},
    }, scriptName: 'showOutputChannel', timeout: Duration(seconds: timeoutSeconds));
  }

  /// Create terminal
  Future<String> createTerminal({
    String? name,
    String? shellPath,
    List<String>? shellArgs,
    int timeoutSeconds = 120,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const terminal = context.vscode.window.createTerminal({
          name: params.name,
          shellPath: params.shellPath,
          shellArgs: params.shellArgs
        });
        return params.name || 'Terminal';
      ''',
      'params': {
        'name': name,
        'shellPath': shellPath,
        'shellArgs': shellArgs,
      },
    }, scriptName: 'createTerminal', timeout: Duration(seconds: timeoutSeconds));

    return result['success'] == true ? (result['result'] ?? 'Terminal') : '';
  }

  /// Send text to terminal
  Future<void> sendTextToTerminal(String terminalName, String text, {int timeoutSeconds = 120}) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        // Find or create terminal
        let terminal = context.vscode.window.terminals.find(t => t.name === params.name);
        if (!terminal) {
          terminal = context.vscode.window.createTerminal(params.name);
        }
        terminal.sendText(params.text);
      ''',
      'params': {'name': terminalName, 'text': text},
    }, scriptName: 'sendTextToTerminal', timeout: Duration(seconds: timeoutSeconds));
  }

  /// Show terminal
  Future<void> showTerminal(String terminalName, {int timeoutSeconds = 120}) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const terminal = context.vscode.window.terminals.find(t => t.name === params.name);
        if (terminal) {
          terminal.show();
        }
      ''',
      'params': {'name': terminalName},
    }, scriptName: 'showTerminal', timeout: Duration(seconds: timeoutSeconds));
  }

  /// Set status bar message
  Future<void> setStatusBarMessage(String message, {int? timeout, int timeoutSeconds = 120}) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        if (params.timeout) {
          context.vscode.window.setStatusBarMessage(params.message, params.timeout);
        } else {
          context.vscode.window.setStatusBarMessage(params.message);
        }
      ''',
      'params': {
        'message': message,
        'timeout': ?timeout,
      },
    }, scriptName: 'setStatusBarMessage', timeout: Duration(seconds: timeoutSeconds));
  }

  /// Show save dialog
  Future<String?> showSaveDialog({
    String? defaultUri,
    Map<String, List<String>>? filters,
    String? title,
    int timeoutSeconds = 30 * 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uri = await context.vscode.window.showSaveDialog({
          defaultUri: params.defaultUri ? context.vscode.Uri.file(params.defaultUri) : undefined,
          filters: params.filters,
          title: params.title
        });
        return uri ? uri.fsPath : null;
      ''',
      'params': {
        'defaultUri': defaultUri,
        'filters': filters,
        'title': title,
      },
    }, scriptName: 'showSaveDialog', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'] as String?;
    }
    return null;
  }

  /// Show open dialog
  Future<List<String>> showOpenDialog({
    bool canSelectFiles = true,
    bool canSelectFolders = false,
    bool canSelectMany = false,
    String? defaultUri,
    Map<String, List<String>>? filters,
    String? title,
    int timeoutSeconds = 30 * 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uris = await context.vscode.window.showOpenDialog({
          canSelectFiles: params.canSelectFiles,
          canSelectFolders: params.canSelectFolders,
          canSelectMany: params.canSelectMany,
          defaultUri: params.defaultUri ? context.vscode.Uri.file(params.defaultUri) : undefined,
          filters: params.filters,
          title: params.title
        });
        return uris ? uris.map(uri => uri.fsPath) : [];
      ''',
      'params': {
        'canSelectFiles': canSelectFiles,
        'canSelectFolders': canSelectFolders,
        'canSelectMany': canSelectMany,
        'defaultUri': defaultUri,
        'filters': filters,
        'title': title,
      },
    }, scriptName: 'showOpenDialog', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return (result['result'] as List).cast<String>();
    }
    return [];
  }
}
