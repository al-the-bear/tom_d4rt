/// VS Code Workspace API wrapper for Dart
library;

import 'dart:async';
import 'vscode_adapter.dart';
import 'vscode_types.dart';

/// Wrapper for vscode.workspace API
/// Provides access to workspace-related functionality
class VSCodeWorkspace {
  final VSCodeAdapter _adapter;

  VSCodeWorkspace(this._adapter);

  /// Get all workspace folders
  Future<List<WorkspaceFolder>> getWorkspaceFolders({int timeoutSeconds = 30}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const folders = context.vscode.workspace.workspaceFolders || [];
        return folders.map(f => ({
          uri: {
            scheme: f.uri.scheme,
            authority: f.uri.authority,
            path: f.uri.path,
            query: f.uri.query,
            fragment: f.uri.fragment,
            fsPath: f.uri.fsPath
          },
          name: f.name,
          index: f.index
        }));
      ''',
      'params': {},
    }, scriptName: 'getWorkspaceFolders', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      final folders = result['result'] as List;
      return folders.map((f) => WorkspaceFolder.fromJson(f)).toList();
    }
    return [];
  }

  /// Get workspace folder for a given URI
  Future<WorkspaceFolder?> getWorkspaceFolder(VSCodeUri uri, {int timeoutSeconds = 30}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uri = context.vscode.Uri.file(params.path);
        const folder = context.vscode.workspace.getWorkspaceFolder(uri);
        if (!folder) return null;
        return {
          uri: {
            scheme: folder.uri.scheme,
            authority: folder.uri.authority,
            path: folder.uri.path,
            query: folder.uri.query,
            fragment: folder.uri.fragment,
            fsPath: folder.uri.fsPath
          },
          name: folder.name,
          index: folder.index
        };
      ''',
      'params': {'path': uri.fsPath},
    }, scriptName: 'getWorkspaceFolder', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true && result['result'] != null) {
      return WorkspaceFolder.fromJson(result['result']);
    }
    return null;
  }

  /// Open a text document
  Future<TextDocument?> openTextDocument(String path, {int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uri = context.vscode.Uri.file(params.path);
        const doc = await context.vscode.workspace.openTextDocument(uri);
        return {
          uri: {
            scheme: doc.uri.scheme,
            authority: doc.uri.authority,
            path: doc.uri.path,
            query: doc.uri.query,
            fragment: doc.uri.fragment,
            fsPath: doc.uri.fsPath
          },
          fileName: doc.fileName,
          isUntitled: doc.isUntitled,
          languageId: doc.languageId,
          version: doc.version,
          isDirty: doc.isDirty,
          isClosed: doc.isClosed,
          lineCount: doc.lineCount
        };
      ''',
      'params': {'path': path},
    }, scriptName: 'openTextDocument', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return TextDocument.fromJson(result['result']);
    }
    return null;
  }

  /// Save a text document
  Future<bool> saveTextDocument(String path, {int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uri = context.vscode.Uri.file(params.path);
        const doc = await context.vscode.workspace.openTextDocument(uri);
        return await doc.save();
      ''',
      'params': {'path': path},
    }, scriptName: 'saveTextDocument', timeout: Duration(seconds: timeoutSeconds));

    return result['success'] == true && result['result'] == true;
  }

  /// Find files in the workspace
  Future<List<VSCodeUri>> findFiles(
    String include, {
    String? exclude,
    int? maxResults,
    int timeoutSeconds = 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uris = await context.vscode.workspace.findFiles(
          params.include,
          params.exclude,
          params.maxResults
        );
        return uris.map(uri => ({
          scheme: uri.scheme,
          authority: uri.authority,
          path: uri.path,
          query: uri.query,
          fragment: uri.fragment,
          fsPath: uri.fsPath
        }));
      ''',
      'params': {
        'include': include,
        'exclude': exclude,
        'maxResults': maxResults,
      },
    }, scriptName: 'findFiles', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      final uris = result['result'] as List;
      return uris.map((u) => VSCodeUri.fromJson(u)).toList();
    }
    return [];
  }

  /// Find files in the workspace (returns file paths as strings)
  Future<List<String>> findFilePaths({
    required String include,
    String? exclude,
    int? maxResults,
    int timeoutSeconds = 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const uris = await context.vscode.workspace.findFiles(
          params.include,
          params.exclude,
          params.maxResults
        );
        return uris.map(uri => uri.fsPath);
      ''',
      'params': {
        'include': include,
        'exclude': exclude,
        'maxResults': maxResults,
      },
    }, scriptName: 'findFilePaths', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return (result['result'] as List).cast<String>();
    }
    return [];
  }

  /// Get workspace configuration
  Future<dynamic> getConfiguration(String section, { String? scope, int timeoutSeconds = 60 } ) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const config = context.vscode.workspace.getConfiguration(
          params.section,
          params.scope ? context.vscode.Uri.file(params.scope) : undefined
        );
        const keys = config ? Object.keys(config) : [];
        const result = {};
        for (const key of keys) {
          try {
            const value = config.get(key);
            if (value !== undefined) {
              result[key] = value;
            }
          } catch (e) {
            // Skip invalid keys
          }
        }
        return result;
      ''',
      'params': {
        'section': section,
        if (scope != null) 'scope': scope,
      },
    }, scriptName: 'getConfiguration', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'];
    }
    return null;
  }

  /// Update workspace configuration
  Future<bool> updateConfiguration(
    String section,
    String key,
    dynamic value, {
    bool global = false,
    int timeoutSeconds = 60,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const config = context.vscode.workspace.getConfiguration(params.section);
        await config.update(
          params.key,
          params.value,
          params.global
        );
        return true;
      ''',
      'params': {
        'section': section,
        'key': key,
        'value': value,
        'global': global,
      },
    }, scriptName: 'updateConfiguration', timeout: Duration(seconds: timeoutSeconds));

    return result['success'] == true;
  }

  /// Get workspace root path
  Future<String?> getRootPath() async {
    final folders = await getWorkspaceFolders();
    return folders.isNotEmpty ? folders.first.uri.fsPath : null;
  }

  /// Get workspace name
  Future<String?> getWorkspaceName() async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        return context.vscode.workspace.name || null;
      ''',
      'params': {},
    }, scriptName: 'getWorkspaceName');

    if (result['success'] == true) {
      return result['result'] as String?;
    }
    return null;
  }

  /// Read file content
  Future<String> readFile(String path) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const fs = context.require('fs');
        return fs.readFileSync(params.path, 'utf8');
      ''',
      'params': {'path': path},
    }, scriptName: 'readFile');

    if (result['success'] == true) {
      return result['result'] as String? ?? '';
    }
    return '';
  }

  /// Write file content
  Future<bool> writeFile(String path, String content) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const fs = context.require('fs');
        const pathModule = context.require('path');
        const dir = pathModule.dirname(params.path);
        if (!fs.existsSync(dir)) {
          fs.mkdirSync(dir, { recursive: true });
        }
        fs.writeFileSync(params.path, params.content, 'utf8');
        return true;
      ''',
      'params': {'path': path, 'content': content},
    }, scriptName: 'writeFile');

    return result['success'] == true;
  }

  /// Delete file
  Future<bool> deleteFile(String path) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const fs = context.require('fs');
        if (fs.existsSync(params.path)) {
          fs.unlinkSync(params.path);
          return true;
        }
        return false;
      ''',
      'params': {'path': path},
    }, scriptName: 'deleteFile');

    return result['success'] == true && result['result'] == true;
  }

  /// Check if file exists
  Future<bool> fileExists(String path) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const fs = context.require('fs');
        return fs.existsSync(params.path);
      ''',
      'params': {'path': path},
    }, scriptName: 'fileExists');

    return result['success'] == true && result['result'] == true;
  }
}
