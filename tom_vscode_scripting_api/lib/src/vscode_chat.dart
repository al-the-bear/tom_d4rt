/// VS Code Chat API
/// 
/// Wrapper for the vscode.chat namespace for creating chat participants
library;

import 'dart:async';
import 'dart:convert';
import 'vscode_adapter.dart';

/// Chat request handler callback
typedef ChatRequestHandler = Future<ChatResult?> Function(
  ChatRequest request,
  ChatContext context,
  ChatResponseStream stream,
);

/// Chat API - Create and manage chat participants
class VSCodeChat {
  final VSCodeAdapter _adapter;

  VSCodeChat(this._adapter);

  /// Internal handler for chat requests from VS Code
  /// This will be called by adding a case in bridge_server.dart
  static final Map<String, ChatRequestHandler> _handlers = {};

  /// Register a handler (called internally by createChatParticipant)
  void _registerHandler(String id, ChatRequestHandler handler) {
    _handlers[id] = handler;
  }

  /// Internal method to handle chat requests - should be called from bridge_server.dart
  static Future<Map<String, dynamic>?> handleChatRequest(Map<String, dynamic> params) async {
    final participantId = params['participantId'] as String;
    final handler = _handlers[participantId];
    
    if (handler == null) {
      throw Exception('No handler registered for participant: $participantId');
    }

    final request = ChatRequest.fromJson(params['request']);
    final context = ChatContext.fromJson(params['context']);
    final stream = ChatResponseStream(params['bridge'] as VSCodeAdapter, params['streamId'] as String);

    try {
      final result = await handler(request, context, stream);
      return result?.toJson();
    } catch (e) {
      await stream.error('Error processing chat request: $e');
      rethrow;
    }
  }

  /// Create a chat participant with a request handler
  /// 
  /// Example:
  /// ```dart
  /// final participant = await chat.createChatParticipant(
  ///   'myExtension.helper',
  ///   handler: (request, context, stream) async {
  ///     await stream.markdown('Hello from my participant!');
  ///     return ChatResult(metadata: {'completed': true});
  ///   },
  /// );
  /// ```
  Future<ChatParticipant> createChatParticipant(
    String id, {
    required ChatRequestHandler handler,
    String? description,
    String? fullName,
    int timeoutSeconds = 300,
  }) async {
    // Store the handler
    _registerHandler(id, handler);

    final result = await _adapter.sendRequest('executeScriptVce', {
      'script': '''
      // Create a map to track active chat streams
      if (typeof chatStreams === 'undefined') {
        globalThis.chatStreams = new Map();
      }

      const participant = vscode.chat.createChatParticipant('${id.replaceAll("'", "\\'")}', async (request, context, stream, token) => {
        try {
          // Generate unique stream ID
          const streamId = 'stream_' + Date.now() + '_' + Math.random();
          chatStreams.set(streamId, stream);

          // Send request to Dart handler
          const result = await bridge.sendRequest('handleChatRequest', {
            participantId: '${id.replaceAll("'", "\\'")}',
            streamId: streamId,
            request: {
              prompt: request.prompt,
              command: request.command || '',
              references: request.references || []
            },
            context: {
              history: context.history || []
            }
          });

          // Clean up stream
          chatStreams.delete(streamId);
          
          return result;
        } catch (error) {
          stream.error(error);
          throw error;
        }
      });

      ${description != null ? "participant.description = '${description.replaceAll("'", "\\'")}';": ''}
      ${fullName != null ? "participant.fullName = '${fullName.replaceAll("'", "\\'")}';": ''}

      return {
        id: participant.id,
        description: participant.description,
        fullName: participant.fullName
      };
    '''
    }, scriptName: 'createChatParticipant', timeout: Duration(seconds: timeoutSeconds));

    return ChatParticipant.fromJson(result);
  }
}

/// A chat participant
class ChatParticipant {
  final String id;
  final String? description;
  final String? fullName;

  ChatParticipant({
    required this.id,
    this.description,
    this.fullName,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) {
    return ChatParticipant(
      id: json['id'] as String,
      description: json['description'] as String?,
      fullName: json['fullName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (description != null) 'description': description,
      if (fullName != null) 'fullName': fullName,
    };
  }
}

/// A chat request from the user
class ChatRequest {
  final String prompt;
  final String command;
  final List<ChatPromptReference> references;

  ChatRequest({
    required this.prompt,
    required this.command,
    required this.references,
  });

  factory ChatRequest.fromJson(Map<String, dynamic> json) {
    return ChatRequest(
      prompt: json['prompt'] as String,
      command: json['command'] as String? ?? '',
      references: (json['references'] as List<dynamic>?)
              ?.map((r) => ChatPromptReference.fromJson(r))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
      'command': command,
      'references': references.map((r) => r.toJson()).toList(),
    };
  }
}

/// A reference in a chat prompt
class ChatPromptReference {
  final String id;
  final dynamic value;
  final String? modelDescription;

  ChatPromptReference({
    required this.id,
    required this.value,
    this.modelDescription,
  });

  factory ChatPromptReference.fromJson(Map<String, dynamic> json) {
    return ChatPromptReference(
      id: json['id'] as String,
      value: json['value'],
      modelDescription: json['modelDescription'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      if (modelDescription != null) 'modelDescription': modelDescription,
    };
  }
}

/// Context for a chat request including conversation history
class ChatContext {
  final List<dynamic> history;

  ChatContext({required this.history});

  factory ChatContext.fromJson(Map<String, dynamic> json) {
    return ChatContext(
      history: json['history'] as List<dynamic>? ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'history': history,
    };
  }
}

/// Result of handling a chat request
class ChatResult {
  final Map<String, dynamic>? metadata;
  final ChatErrorDetails? errorDetails;

  ChatResult({this.metadata, this.errorDetails});

  Map<String, dynamic> toJson() {
    return {
      if (metadata != null) 'metadata': metadata,
      if (errorDetails != null) 'errorDetails': errorDetails!.toJson(),
    };
  }
}

/// Error details for a failed chat request
class ChatErrorDetails {
  final String message;
  final bool? responseIsFiltered;

  ChatErrorDetails({required this.message, this.responseIsFiltered});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (responseIsFiltered != null) 'responseIsFiltered': responseIsFiltered,
    };
  }
}

/// A stream for sending responses back to the chat
class ChatResponseStream {
  final VSCodeAdapter _adapter;
  final String _streamId;

  ChatResponseStream(this._adapter, this._streamId);

  /// Send markdown text to the stream
  Future<void> markdown(String text) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const stream = chatStreams.get('$_streamId');
        if (stream) {
          stream.markdown('${text.replaceAll("'", "\\'")}');
        }
      '''
    }, scriptName: 'ChatResponseStream.markdown');
  }

  /// Send an anchor (link) to the stream
  Future<void> anchor(String uri, {String? title}) async {
    final titleParam = title != null ? "'${title.replaceAll("'", "\\'")}'" : 'undefined';
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const stream = chatStreams.get('$_streamId');
        if (stream) {
          stream.anchor(vscode.Uri.parse('${uri.replaceAll("'", "\\'")}'), $titleParam);
        }
      '''
    }, scriptName: 'ChatResponseStream.anchor');
  }

  /// Send a button to the stream
  Future<void> button(String command, {String? title, List<dynamic>? arguments}) async {
    final titleParam = title != null ? "'${title.replaceAll("'", "\\'")}'" : 'undefined';
    final argsParam = arguments != null ? jsonEncode(arguments) : '[]';
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const stream = chatStreams.get('$_streamId');
        if (stream) {
          stream.button({
            command: '${command.replaceAll("'", "\\'")}',
            title: $titleParam,
            arguments: $argsParam
          });
        }
      '''
    }, scriptName: 'ChatResponseStream.button');
  }

  /// Send a file tree to the stream
  Future<void> filetree(List<String> files, {String? baseUri}) async {
    final filesJson = jsonEncode(files);
    final baseUriParam = baseUri != null ? "vscode.Uri.parse('${baseUri.replaceAll("'", "\\'")}')," : '';
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const stream = chatStreams.get('$_streamId');
        if (stream) {
          const files = $filesJson.map(f => vscode.Uri.file(f));
          stream.filetree(files, $baseUriParam);
        }
      '''
    }, scriptName: 'ChatResponseStream.filetree');
  }

  /// Send progress to the stream
  Future<void> progress(String value) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const stream = chatStreams.get('$_streamId');
        if (stream) {
          stream.progress('${value.replaceAll("'", "\\'")}');
        }
      '''
    }, scriptName: 'ChatResponseStream.progress');
  }

  /// Push a reference to the stream
  Future<void> reference(String uri, {String? title}) async {
    final titleParam = title != null ? "'${title.replaceAll("'", "\\'")}'" : 'undefined';
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const stream = chatStreams.get('$_streamId');
        if (stream) {
          stream.reference(vscode.Uri.parse('${uri.replaceAll("'", "\\'")}'), $titleParam);
        }
      '''
    }, scriptName: 'ChatResponseStream.reference');
  }

  /// Push an error to the stream
  Future<void> error(String message) async {
    await _adapter.sendRequest('executeScriptVce', {
      'script': '''
        const stream = chatStreams.get('$_streamId');
        if (stream) {
          stream.error(new Error('${message.replaceAll("'", "\\'")}'));
        }
      '''
    }, scriptName: 'ChatResponseStream.error');
  }
}
