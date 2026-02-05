/// VS Code Extensions API wrapper for Dart
library;

import 'dart:async';
import 'vscode_adapter.dart';

/// Represents a VS Code extension
class Extension {
  final String id;
  final String extensionUri;
  final String extensionPath;
  final bool isActive;
  final Map<String, dynamic> packageJSON;
  final String? extensionKind;

  Extension({
    required this.id,
    required this.extensionUri,
    required this.extensionPath,
    required this.isActive,
    required this.packageJSON,
    this.extensionKind,
  });

  factory Extension.fromJson(Map<String, dynamic> json) {
    return Extension(
      id: json['id'],
      extensionUri: json['extensionUri'],
      extensionPath: json['extensionPath'],
      isActive: json['isActive'],
      packageJSON: json['packageJSON'],
      extensionKind: json['extensionKind'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'extensionUri': extensionUri,
      'extensionPath': extensionPath,
      'isActive': isActive,
      'packageJSON': packageJSON,
      'extensionKind': extensionKind,
    };
  }
}

/// Wrapper for vscode.extensions API
/// Provides access to VS Code extensions management
class VSCodeExtensions {
  final VSCodeAdapter _adapter;

  VSCodeExtensions(this._adapter);

  /// Get all extensions
  Future<List<Extension>> getAll({int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const extensions = context.vscode.extensions.all.map(ext => ({
          id: ext.id,
          extensionUri: ext.extensionUri.toString(),
          extensionPath: ext.extensionPath,
          isActive: ext.isActive,
          packageJSON: ext.packageJSON,
          extensionKind: ext.extensionKind ? ext.extensionKind.toString() : null
        }));
        return extensions;
      ''',
      'params': {},
    }, scriptName: 'getAllExtensions', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return (result['result'] as List)
          .map((e) => Extension.fromJson(e))
          .toList();
    }
    return [];
  }

  /// Get extension by ID
  Future<Extension?> getExtension(String extensionId, {int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const ext = context.vscode.extensions.getExtension(params.extensionId);
        if (!ext) return null;
        
        return {
          id: ext.id,
          extensionUri: ext.extensionUri.toString(),
          extensionPath: ext.extensionPath,
          isActive: ext.isActive,
          packageJSON: ext.packageJSON,
          extensionKind: ext.extensionKind ? ext.extensionKind.toString() : null
        };
      ''',
      'params': {
        'extensionId': extensionId,
      },
    }, scriptName: 'getExtension', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true && result['result'] != null) {
      return Extension.fromJson(result['result']);
    }
    return null;
  }

  /// Check if extension is installed
  Future<bool> isInstalled(String extensionId, {int timeoutSeconds = 60}) async {
    final ext = await getExtension(extensionId, timeoutSeconds: timeoutSeconds);
    return ext != null;
  }

  /// Get extension export (API) - returns dynamic as it depends on extension
  Future<dynamic> getExtensionExports(String extensionId, {int timeoutSeconds = 120}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const ext = context.vscode.extensions.getExtension(params.extensionId);
        if (!ext) return null;
        
        // Activate if not active
        if (!ext.isActive) {
          await ext.activate();
        }
        
        return ext.exports || null;
      ''',
      'params': {
        'extensionId': extensionId,
      },
    }, scriptName: 'getExtensionExports', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'];
    }
    return null;
  }

  /// Activate extension
  Future<bool> activateExtension(String extensionId, {int timeoutSeconds = 180}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const ext = context.vscode.extensions.getExtension(params.extensionId);
        if (!ext) return false;
        
        if (!ext.isActive) {
          await ext.activate();
        }
        
        return ext.isActive;
      ''',
      'params': {
        'extensionId': extensionId,
      },
    }, scriptName: 'activateExtension', timeout: Duration(seconds: timeoutSeconds));

    return result['success'] == true && result['result'] == true;
  }

  /// Get extension version
  Future<String?> getExtensionVersion(String extensionId, {int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const ext = context.vscode.extensions.getExtension(params.extensionId);
        if (!ext) return null;
        return ext.packageJSON.version || null;
      ''',
      'params': {
        'extensionId': extensionId,
      },
    }, scriptName: 'getExtensionVersion', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'] as String?;
    }
    return null;
  }

  /// Get extension display name
  Future<String?> getExtensionDisplayName(String extensionId, {int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const ext = context.vscode.extensions.getExtension(params.extensionId);
        if (!ext) return null;
        return ext.packageJSON.displayName || ext.packageJSON.name || null;
      ''',
      'params': {
        'extensionId': extensionId,
      },
    }, scriptName: 'getExtensionDisplayName', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'] as String?;
    }
    return null;
  }

  /// Get extension description
  Future<String?> getExtensionDescription(String extensionId, {int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const ext = context.vscode.extensions.getExtension(params.extensionId);
        if (!ext) return null;
        return ext.packageJSON.description || null;
      ''',
      'params': {
        'extensionId': extensionId,
      },
    }, scriptName: 'getExtensionDescription', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true) {
      return result['result'] as String?;
    }
    return null;
  }
}
