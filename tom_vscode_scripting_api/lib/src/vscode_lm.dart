/// VS Code Language Model (Copilot) API
/// 
/// Wrapper for the vscode.lm namespace providing access to language models
/// including GitHub Copilot
library;

import 'dart:async';
import 'vscode_adapter.dart';

/// Language Model API - Access to GitHub Copilot and other language models
class VSCodeLanguageModel {
  final VSCodeAdapter _adapter;

  VSCodeLanguageModel(this._adapter);

  /// Select chat models matching the given criteria
  /// 
  /// Example:
  /// ```dart
  /// final models = await lm.selectChatModels(vendor: 'copilot');
  /// ```
  Future<List<LanguageModelChat>> selectChatModels({
    String? vendor,
    String? family,
    String? id,
    String? version,
    int timeoutSeconds = 60,
  }) async {
    final selector = <String, dynamic>{};
    if (vendor != null) selector['vendor'] = vendor;
    if (family != null) selector['family'] = family;
    if (id != null) selector['id'] = id;
    if (version != null) selector['version'] = version;

    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const models = await context.vscode.lm.selectChatModels(params.selector);
        return models;
      ''',
      'params': {'selector': selector},
    }, scriptName: 'selectChatModels', timeout: Duration(seconds: timeoutSeconds));

    if (result['success'] == true && result['result'] is List) {
      return (result['result'] as List)
          .map((m) => LanguageModelChat.fromJson(m as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Invoke a registered tool
  Future<LanguageModelToolResult> invokeTool(
    String name,
    Map<String, dynamic> options, {
    int timeoutSeconds = 300,
  }) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const result = await context.vscode.lm.invokeTool(params.name, params.options);
        return result;
      ''',
      'params': {'name': name, 'options': options},
    }, scriptName: 'invokeTool', timeout: Duration(seconds: timeoutSeconds));
    return LanguageModelToolResult.fromJson(result);
  }

  /// Register a language model tool
  Future<void> registerTool(String name, Map<String, dynamic> tool, {int timeoutSeconds = 120}) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        await context.vscode.lm.registerTool(params.name, params.tool);
      ''',
      'params': {'name': name, 'tool': tool},
    }, scriptName: 'registerTool', timeout: Duration(seconds: timeoutSeconds));
  }

  /// Get list of available tools
  Future<List<LanguageModelToolInformation>> getTools({int timeoutSeconds = 60}) async {
    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const tools = await context.vscode.lm.tools;
        return tools;
      ''',
      'params': {},
    }, scriptName: 'getTools', timeout: Duration(seconds: timeoutSeconds));
    if (result['success'] == true && result['result'] is List) {
      return (result['result'] as List)
          .map((t) => LanguageModelToolInformation.fromJson(t as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

/// Represents a language model for chat requests
class LanguageModelChat {
  final String id;
  final String vendor;
  final String family;
  final String version;
  final String name;
  final int maxInputTokens;

  LanguageModelChat({
    required this.id,
    required this.vendor,
    required this.family,
    required this.version,
    required this.name,
    required this.maxInputTokens,
  });

  factory LanguageModelChat.fromJson(Map<String, dynamic> json) {
    return LanguageModelChat(
      id: json['id'] as String,
      vendor: json['vendor'] as String,
      family: json['family'] as String,
      version: json['version'] as String,
      name: json['name'] as String,
      maxInputTokens: json['maxInputTokens'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor': vendor,
      'family': family,
      'version': version,
      'name': name,
      'maxInputTokens': maxInputTokens,
    };
  }

  /// Send a chat request to this model
  Future<LanguageModelChatResponse> sendRequest(
    VSCodeAdapter adapter,
    List<LanguageModelChatMessage> messages, {
    Map<String, dynamic>? modelOptions,
    int timeoutSeconds = 300,
  }) async {
    final result = await adapter.sendRequest('executeScriptVce', {
      'script': '''
        const models = await context.vscode.lm.selectChatModels({id: params.modelId});
        if (models.length === 0) throw new Error('Model not found');
        const response = await models[0].sendRequest(params.messages, params.options);
        let text = '';
        for await (const part of response.stream) {
          if (part && part.text) text += part.text;
        }
        return {text, stream: [text]};
      ''',
      'params': {
        'modelId': id,
        'messages': messages.map((m) => m.toJson()).toList(),
        'options': modelOptions ?? {},
      },
    }, scriptName: 'LanguageModelChat.sendRequest', timeout: Duration(seconds: timeoutSeconds));
    return LanguageModelChatResponse.fromJson(result);
  }

  /// Count tokens in text
  Future<int> countTokens(
    VSCodeAdapter adapter,
    String text, {
    int timeoutSeconds = 120,
  }) async {
    final result = await adapter.sendRequest('executeScriptVce', {
      'script': '''
        const models = await context.vscode.lm.selectChatModels({id: params.modelId});
        if (models.length === 0) throw new Error('Model not found');
        const count = await models[0].countTokens(params.text);
        return count;
      ''',
      'params': {'modelId': id, 'text': text},
    }, scriptName: 'LanguageModelChat.countTokens', timeout: Duration(seconds: timeoutSeconds));
    return result as int;
  }
}

/// A message in a chat conversation
class LanguageModelChatMessage {
  final String role; // 'user' or 'assistant'
  final String content;
  final String? name;

  LanguageModelChatMessage({
    required this.role,
    required this.content,
    this.name,
  });

  factory LanguageModelChatMessage.user(String content, {String? name}) {
    return LanguageModelChatMessage(
      role: 'user',
      content: content,
      name: name,
    );
  }

  factory LanguageModelChatMessage.assistant(String content, {String? name}) {
    return LanguageModelChatMessage(
      role: 'assistant',
      content: content,
      name: name,
    );
  }

  factory LanguageModelChatMessage.fromJson(Map<String, dynamic> json) {
    return LanguageModelChatMessage(
      role: json['role'] as String,
      content: json['content'] as String,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      if (name != null) 'name': name,
    };
  }
}

/// Response from a language model chat request
class LanguageModelChatResponse {
  final String text;
  final List<String> streamParts;

  LanguageModelChatResponse({
    required this.text,
    required this.streamParts,
  });

  factory LanguageModelChatResponse.fromJson(Map<String, dynamic> json) {
    return LanguageModelChatResponse(
      text: json['text'] as String? ?? '',
      streamParts: (json['stream'] as List?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'stream': streamParts,
    };
  }
}

/// Tool result from language model
class LanguageModelToolResult {
  final List<dynamic> content;

  LanguageModelToolResult({required this.content});

  factory LanguageModelToolResult.fromJson(Map<String, dynamic> json) {
    return LanguageModelToolResult(
      content: json['content'] as List? ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'content': content};
  }
}

/// Information about a registered tool
class LanguageModelToolInformation {
  final String name;
  final String description;
  final Map<String, dynamic> inputSchema;

  LanguageModelToolInformation({
    required this.name,
    required this.description,
    required this.inputSchema,
  });

  factory LanguageModelToolInformation.fromJson(Map<String, dynamic> json) {
    return LanguageModelToolInformation(
      name: json['name'] as String,
      description: json['description'] as String,
      inputSchema: json['inputSchema'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'inputSchema': inputSchema,
    };
  }
}
