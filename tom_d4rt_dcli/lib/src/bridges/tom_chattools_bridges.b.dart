// D4rt Bridge - Generated file, do not edit
// Sources: 7 files
// Generated: 2026-02-15T12:30:05.603163

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:tom_chattools/src/api/chat/chat_api.dart' as $tom_chattools_1;
import 'package:tom_chattools/src/api/chat/chat_config.dart' as $tom_chattools_2;
import 'package:tom_chattools/src/api/chat/chat_message.dart' as $tom_chattools_3;
import 'package:tom_chattools/src/api/chat/chat_receiver.dart' as $tom_chattools_4;
import 'package:tom_chattools/src/api/chat/chat_response.dart' as $tom_chattools_5;
import 'package:tom_chattools/src/api/chat/chat_settings.dart' as $tom_chattools_6;
import 'package:tom_chattools/src/telegram/telegram_config.dart' as $tom_chattools_7;

/// Bridge class for tom_chattools module.
class TomChattoolsBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createChatConfigBridge(),
      _createChatMessageBridge(),
      _createChatSenderBridge(),
      _createChatAttachmentBridge(),
      _createChatResponseBridge(),
      _createChatReceiverBridge(),
      _createChatReceiverInfoBridge(),
      _createChatSettingsBridge(),
      _createChatApiBridge(),
      _createChatMessageFilterBridge(),
      _createTelegramChatConfigBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'ChatConfig': 'package:tom_chattools/src/api/chat/chat_config.dart',
      'ChatMessage': 'package:tom_chattools/src/api/chat/chat_message.dart',
      'ChatSender': 'package:tom_chattools/src/api/chat/chat_message.dart',
      'ChatAttachment': 'package:tom_chattools/src/api/chat/chat_message.dart',
      'ChatResponse': 'package:tom_chattools/src/api/chat/chat_response.dart',
      'ChatReceiver': 'package:tom_chattools/src/api/chat/chat_receiver.dart',
      'ChatReceiverInfo': 'package:tom_chattools/src/api/chat/chat_receiver.dart',
      'ChatSettings': 'package:tom_chattools/src/api/chat/chat_settings.dart',
      'ChatApi': 'package:tom_chattools/src/api/chat/chat_api.dart',
      'ChatMessageFilter': 'package:tom_chattools/src/api/chat/chat_api.dart',
      'TelegramChatConfig': 'package:tom_chattools/src/telegram/telegram_config.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$tom_chattools_3.ChatMessageType>(
        name: 'ChatMessageType',
        values: $tom_chattools_3.ChatMessageType.values,
      ),
      BridgedEnumDefinition<$tom_chattools_3.ChatAttachmentType>(
        name: 'ChatAttachmentType',
        values: $tom_chattools_3.ChatAttachmentType.values,
      ),
      BridgedEnumDefinition<$tom_chattools_5.ChatResponseStatus>(
        name: 'ChatResponseStatus',
        values: $tom_chattools_5.ChatResponseStatus.values,
      ),
      BridgedEnumDefinition<$tom_chattools_4.ChatReceiverType>(
        name: 'ChatReceiverType',
        values: $tom_chattools_4.ChatReceiverType.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'ChatMessageType': 'package:tom_chattools/src/api/chat/chat_message.dart',
      'ChatAttachmentType': 'package:tom_chattools/src/api/chat/chat_message.dart',
      'ChatResponseStatus': 'package:tom_chattools/src/api/chat/chat_response.dart',
      'ChatReceiverType': 'package:tom_chattools/src/api/chat/chat_receiver.dart',
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {};
  }

  /// Returns a map of global function names to their canonical source URIs.
  static Map<String, String> globalFunctionSourceUris() {
    return {};
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {};
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:tom_chattools/src/api/chat/chat_api.dart',
      'package:tom_chattools/src/api/chat/chat_config.dart',
      'package:tom_chattools/src/api/chat/chat_message.dart',
      'package:tom_chattools/src/api/chat/chat_receiver.dart',
      'package:tom_chattools/src/api/chat/chat_response.dart',
      'package:tom_chattools/src/api/chat/chat_settings.dart',
      'package:tom_chattools/src/telegram/telegram_config.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:tom_chattools/tom_chattools.dart';";
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'ChatMessageType',
    'ChatAttachmentType',
    'ChatResponseStatus',
    'ChatReceiverType',
  ];

}

// =============================================================================
// ChatConfig Bridge
// =============================================================================

BridgedClass _createChatConfigBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_2.ChatConfig,
    name: 'ChatConfig',
    constructors: {
    },
    getters: {
      'platform': (visitor, target) => D4.validateTarget<$tom_chattools_2.ChatConfig>(target, 'ChatConfig').platform,
    },
    methods: {
      'createApi': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_2.ChatConfig>(target, 'ChatConfig');
        D4.requireMinArgs(positional, 1, 'createApi');
        final settings = D4.getRequiredArg<$tom_chattools_6.ChatSettings>(positional, 0, 'settings', 'createApi');
        return t.createApi(settings);
      },
    },
    methodSignatures: {
      'createApi': 'ChatApi createApi(ChatSettings settings)',
    },
    getterSignatures: {
      'platform': 'String get platform',
    },
  );
}

// =============================================================================
// ChatMessage Bridge
// =============================================================================

BridgedClass _createChatMessageBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_3.ChatMessage,
    name: 'ChatMessage',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'ChatMessage');
        final text = D4.getOptionalNamedArg<String?>(named, 'text');
        final sender = D4.getRequiredNamedArg<$tom_chattools_3.ChatSender>(named, 'sender', 'ChatMessage');
        final timestamp = D4.getRequiredNamedArg<DateTime>(named, 'timestamp', 'ChatMessage');
        final type = D4.getNamedArgWithDefault<$tom_chattools_3.ChatMessageType>(named, 'type', $tom_chattools_3.ChatMessageType.text);
        final platformMessageId = D4.getOptionalNamedArg<String?>(named, 'platformMessageId');
        final replyToMessageId = D4.getOptionalNamedArg<String?>(named, 'replyToMessageId');
        final attachments = named.containsKey('attachments') && named['attachments'] != null
            ? D4.coerceList<$tom_chattools_3.ChatAttachment>(named['attachments'], 'attachments')
            : const <$tom_chattools_3.ChatAttachment>[];
        final rawData = D4.coerceMapOrNull<String, dynamic>(named['rawData'], 'rawData');
        return $tom_chattools_3.ChatMessage(id: id, text: text, sender: sender, timestamp: timestamp, type: type, platformMessageId: platformMessageId, replyToMessageId: replyToMessageId, attachments: attachments, rawData: rawData);
      },
      'text': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatMessage');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'ChatMessage');
        return $tom_chattools_3.ChatMessage.text(text);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').id,
      'text': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').text,
      'sender': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').sender,
      'timestamp': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').timestamp,
      'type': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').type,
      'platformMessageId': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').platformMessageId,
      'replyToMessageId': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').replyToMessageId,
      'attachments': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').attachments,
      'rawData': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage').rawData,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_3.ChatMessage>(target, 'ChatMessage');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ChatMessage({required String id, String? text, required ChatSender sender, required DateTime timestamp, ChatMessageType type = ChatMessageType.text, String? platformMessageId, String? replyToMessageId, List<ChatAttachment> attachments = const [], Map<String, dynamic>? rawData})',
      'text': 'factory ChatMessage.text(String text)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'String get id',
      'text': 'String? get text',
      'sender': 'ChatSender get sender',
      'timestamp': 'DateTime get timestamp',
      'type': 'ChatMessageType get type',
      'platformMessageId': 'String? get platformMessageId',
      'replyToMessageId': 'String? get replyToMessageId',
      'attachments': 'List<ChatAttachment> get attachments',
      'rawData': 'Map<String, dynamic>? get rawData',
    },
  );
}

// =============================================================================
// ChatSender Bridge
// =============================================================================

BridgedClass _createChatSenderBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_3.ChatSender,
    name: 'ChatSender',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'ChatSender');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final username = D4.getOptionalNamedArg<String?>(named, 'username');
        final isSelf = D4.getNamedArgWithDefault<bool>(named, 'isSelf', false);
        return $tom_chattools_3.ChatSender(id: id, name: name, username: username, isSelf: isSelf);
      },
      'self': (visitor, positional, named) {
        return $tom_chattools_3.ChatSender.self();
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatSender>(target, 'ChatSender').id,
      'name': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatSender>(target, 'ChatSender').name,
      'username': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatSender>(target, 'ChatSender').username,
      'isSelf': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatSender>(target, 'ChatSender').isSelf,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_3.ChatSender>(target, 'ChatSender');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ChatSender({required String id, String? name, String? username, bool isSelf = false})',
      'self': 'const ChatSender.self()',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'String get id',
      'name': 'String? get name',
      'username': 'String? get username',
      'isSelf': 'bool get isSelf',
    },
  );
}

// =============================================================================
// ChatAttachment Bridge
// =============================================================================

BridgedClass _createChatAttachmentBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_3.ChatAttachment,
    name: 'ChatAttachment',
    constructors: {
      '': (visitor, positional, named) {
        final type = D4.getRequiredNamedArg<$tom_chattools_3.ChatAttachmentType>(named, 'type', 'ChatAttachment');
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'ChatAttachment');
        final mimeType = D4.getOptionalNamedArg<String?>(named, 'mimeType');
        final fileName = D4.getOptionalNamedArg<String?>(named, 'fileName');
        final fileSize = D4.getOptionalNamedArg<int?>(named, 'fileSize');
        final caption = D4.getOptionalNamedArg<String?>(named, 'caption');
        return $tom_chattools_3.ChatAttachment(type: type, url: url, mimeType: mimeType, fileName: fileName, fileSize: fileSize, caption: caption);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatAttachment>(target, 'ChatAttachment').type,
      'url': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatAttachment>(target, 'ChatAttachment').url,
      'mimeType': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatAttachment>(target, 'ChatAttachment').mimeType,
      'fileName': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatAttachment>(target, 'ChatAttachment').fileName,
      'fileSize': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatAttachment>(target, 'ChatAttachment').fileSize,
      'caption': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatAttachment>(target, 'ChatAttachment').caption,
    },
    constructorSignatures: {
      '': 'const ChatAttachment({required ChatAttachmentType type, required String url, String? mimeType, String? fileName, int? fileSize, String? caption})',
    },
    getterSignatures: {
      'type': 'ChatAttachmentType get type',
      'url': 'String get url',
      'mimeType': 'String? get mimeType',
      'fileName': 'String? get fileName',
      'fileSize': 'int? get fileSize',
      'caption': 'String? get caption',
    },
  );
}

// =============================================================================
// ChatResponse Bridge
// =============================================================================

BridgedClass _createChatResponseBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_5.ChatResponse,
    name: 'ChatResponse',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('messages') || named['messages'] == null) {
          throw ArgumentError('ChatResponse: Missing required named argument "messages"');
        }
        final messages = D4.coerceList<$tom_chattools_3.ChatMessage>(named['messages'], 'messages');
        final success = D4.getNamedArgWithDefault<bool>(named, 'success', true);
        final status = D4.getNamedArgWithDefault<$tom_chattools_5.ChatResponseStatus>(named, 'status', $tom_chattools_5.ChatResponseStatus.ok);
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final waitDuration = D4.getNamedArgWithDefault<Duration>(named, 'waitDuration', Duration.zero);
        final hasMore = D4.getNamedArgWithDefault<bool>(named, 'hasMore', false);
        final metadata = D4.coerceMapOrNull<String, dynamic>(named['metadata'], 'metadata');
        return $tom_chattools_5.ChatResponse(messages: messages, success: success, status: status, error: error, waitDuration: waitDuration, hasMore: hasMore, metadata: metadata);
      },
      'empty': (visitor, positional, named) {
        return $tom_chattools_5.ChatResponse.empty();
      },
      'error': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatResponse');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ChatResponse');
        final status = D4.getOptionalNamedArg<$tom_chattools_5.ChatResponseStatus?>(named, 'status');
        return $tom_chattools_5.ChatResponse.error(message, status: status);
      },
      'timeout': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatResponse');
        final waitDuration = D4.getRequiredArg<Duration>(positional, 0, 'waitDuration', 'ChatResponse');
        return $tom_chattools_5.ChatResponse.timeout(waitDuration);
      },
    },
    getters: {
      'messages': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').messages,
      'success': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').success,
      'status': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').status,
      'error': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').error,
      'waitDuration': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').waitDuration,
      'hasMore': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').hasMore,
      'metadata': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').metadata,
      'hasMessages': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').hasMessages,
      'count': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').count,
      'first': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').first,
      'last': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').last,
      'textContent': (visitor, target) => D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse').textContent,
    },
    methods: {
      'fromSender': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse');
        D4.requireMinArgs(positional, 1, 'fromSender');
        final senderId = D4.getRequiredArg<String>(positional, 0, 'senderId', 'fromSender');
        return t.fromSender(senderId);
      },
      'ofType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse');
        D4.requireMinArgs(positional, 1, 'ofType');
        final type = D4.getRequiredArg<$tom_chattools_3.ChatMessageType>(positional, 0, 'type', 'ofType');
        return t.ofType(type);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_5.ChatResponse>(target, 'ChatResponse');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ChatResponse({required List<ChatMessage> messages, bool success = true, ChatResponseStatus status = ChatResponseStatus.ok, String? error, Duration waitDuration = Duration.zero, bool hasMore = false, Map<String, dynamic>? metadata})',
      'empty': 'const ChatResponse.empty()',
      'error': 'factory ChatResponse.error(String message, {ChatResponseStatus? status})',
      'timeout': 'factory ChatResponse.timeout(Duration waitDuration)',
    },
    methodSignatures: {
      'fromSender': 'List<ChatMessage> fromSender(String senderId)',
      'ofType': 'List<ChatMessage> ofType(ChatMessageType type)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'messages': 'List<ChatMessage> get messages',
      'success': 'bool get success',
      'status': 'ChatResponseStatus get status',
      'error': 'String? get error',
      'waitDuration': 'Duration get waitDuration',
      'hasMore': 'bool get hasMore',
      'metadata': 'Map<String, dynamic>? get metadata',
      'hasMessages': 'bool get hasMessages',
      'count': 'int get count',
      'first': 'ChatMessage? get first',
      'last': 'ChatMessage? get last',
      'textContent': 'List<String> get textContent',
    },
  );
}

// =============================================================================
// ChatReceiver Bridge
// =============================================================================

BridgedClass _createChatReceiverBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_4.ChatReceiver,
    name: 'ChatReceiver',
    constructors: {
      'id': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatReceiver');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'ChatReceiver');
        return $tom_chattools_4.ChatReceiver.id(id);
      },
      'username': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatReceiver');
        final username = D4.getRequiredArg<String>(positional, 0, 'username', 'ChatReceiver');
        return $tom_chattools_4.ChatReceiver.username(username);
      },
      'phone': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatReceiver');
        final phone = D4.getRequiredArg<String>(positional, 0, 'phone', 'ChatReceiver');
        return $tom_chattools_4.ChatReceiver.phone(phone);
      },
      'group': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatReceiver');
        final groupId = D4.getRequiredArg<String>(positional, 0, 'groupId', 'ChatReceiver');
        return $tom_chattools_4.ChatReceiver.group(groupId);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiver>(target, 'ChatReceiver').type,
      'value': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiver>(target, 'ChatReceiver').value,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiver>(target, 'ChatReceiver').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_4.ChatReceiver>(target, 'ChatReceiver');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_4.ChatReceiver>(target, 'ChatReceiver');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      'id': 'const ChatReceiver.id(String id)',
      'username': 'const ChatReceiver.username(String username)',
      'phone': 'const ChatReceiver.phone(String phone)',
      'group': 'const ChatReceiver.group(String groupId)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'ChatReceiverType get type',
      'value': 'String get value',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ChatReceiverInfo Bridge
// =============================================================================

BridgedClass _createChatReceiverInfoBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_4.ChatReceiverInfo,
    name: 'ChatReceiverInfo',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'ChatReceiverInfo');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final firstName = D4.getOptionalNamedArg<String?>(named, 'firstName');
        final lastName = D4.getOptionalNamedArg<String?>(named, 'lastName');
        final username = D4.getOptionalNamedArg<String?>(named, 'username');
        final phone = D4.getOptionalNamedArg<String?>(named, 'phone');
        final photoUrl = D4.getOptionalNamedArg<String?>(named, 'photoUrl');
        final isBot = D4.getNamedArgWithDefault<bool>(named, 'isBot', false);
        final rawData = D4.coerceMapOrNull<String, dynamic>(named['rawData'], 'rawData');
        return $tom_chattools_4.ChatReceiverInfo(id: id, name: name, firstName: firstName, lastName: lastName, username: username, phone: phone, photoUrl: photoUrl, isBot: isBot, rawData: rawData);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').id,
      'name': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').name,
      'firstName': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').firstName,
      'lastName': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').lastName,
      'username': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').username,
      'phone': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').phone,
      'photoUrl': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').photoUrl,
      'isBot': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').isBot,
      'rawData': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo').rawData,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_4.ChatReceiverInfo>(target, 'ChatReceiverInfo');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ChatReceiverInfo({required String id, String? name, String? firstName, String? lastName, String? username, String? phone, String? photoUrl, bool isBot = false, Map<String, dynamic>? rawData})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'String get id',
      'name': 'String? get name',
      'firstName': 'String? get firstName',
      'lastName': 'String? get lastName',
      'username': 'String? get username',
      'phone': 'String? get phone',
      'photoUrl': 'String? get photoUrl',
      'isBot': 'bool get isBot',
      'rawData': 'Map<String, dynamic>? get rawData',
    },
  );
}

// =============================================================================
// ChatSettings Bridge
// =============================================================================

BridgedClass _createChatSettingsBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_6.ChatSettings,
    name: 'ChatSettings',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatSettings');
        if (positional.isEmpty) {
          throw ArgumentError('ChatSettings: Missing required argument "settings" at position 0');
        }
        final settings = D4.coerceMap<String, String>(positional[0], 'settings');
        final pollingTimeout = D4.getNamedArgWithDefault<Duration>(named, 'pollingTimeout', const Duration(seconds: 2));
        final usePolling = D4.getNamedArgWithDefault<bool>(named, 'usePolling', true);
        return $tom_chattools_6.ChatSettings(settings, pollingTimeout: pollingTimeout, usePolling: usePolling);
      },
      'telegram': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatSettings');
        final token = D4.getRequiredArg<String>(positional, 0, 'token', 'ChatSettings');
        final pollingTimeout = D4.getNamedArgWithDefault<Duration>(named, 'pollingTimeout', const Duration(seconds: 2));
        final usePolling = D4.getNamedArgWithDefault<bool>(named, 'usePolling', true);
        return $tom_chattools_6.ChatSettings.telegram(token, pollingTimeout: pollingTimeout, usePolling: usePolling);
      },
    },
    getters: {
      'settings': (visitor, target) => D4.validateTarget<$tom_chattools_6.ChatSettings>(target, 'ChatSettings').settings,
      'pollingTimeout': (visitor, target) => D4.validateTarget<$tom_chattools_6.ChatSettings>(target, 'ChatSettings').pollingTimeout,
      'usePolling': (visitor, target) => D4.validateTarget<$tom_chattools_6.ChatSettings>(target, 'ChatSettings').usePolling,
      'detectedPlatform': (visitor, target) => D4.validateTarget<$tom_chattools_6.ChatSettings>(target, 'ChatSettings').detectedPlatform,
    },
    methods: {
      'has': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_6.ChatSettings>(target, 'ChatSettings');
        D4.requireMinArgs(positional, 1, 'has');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'has');
        return t.has(key);
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_6.ChatSettings>(target, 'ChatSettings');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
    },
    staticGetters: {
      'telegramToken': (visitor) => $tom_chattools_6.ChatSettings.telegramToken,
      'whatsappToken': (visitor) => $tom_chattools_6.ChatSettings.whatsappToken,
      'signalPhone': (visitor) => $tom_chattools_6.ChatSettings.signalPhone,
    },
    constructorSignatures: {
      '': 'const ChatSettings(Map<String, String> settings, {Duration pollingTimeout = const Duration(seconds: 2), bool usePolling = true})',
      'telegram': 'factory ChatSettings.telegram(String token, {Duration pollingTimeout = const Duration(seconds: 2), bool usePolling = true})',
    },
    methodSignatures: {
      'has': 'bool has(String key)',
    },
    getterSignatures: {
      'settings': 'Map<String, String> get settings',
      'pollingTimeout': 'Duration get pollingTimeout',
      'usePolling': 'bool get usePolling',
      'detectedPlatform': 'String? get detectedPlatform',
    },
    staticGetterSignatures: {
      'telegramToken': 'String get telegramToken',
      'whatsappToken': 'String get whatsappToken',
      'signalPhone': 'String get signalPhone',
    },
  );
}

// =============================================================================
// ChatApi Bridge
// =============================================================================

BridgedClass _createChatApiBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_1.ChatApi,
    name: 'ChatApi',
    constructors: {
    },
    getters: {
      'settings': (visitor, target) => D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi').settings,
      'isConnected': (visitor, target) => D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi').isConnected,
      'platform': (visitor, target) => D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi').platform,
      'onMessage': (visitor, target) => D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi').onMessage,
    },
    setters: {
      'settings': (visitor, target, value) => 
        D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi').settings = value as $tom_chattools_6.ChatSettings,
    },
    methods: {
      'initialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        return t.initialize();
      },
      'sendMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 2, 'sendMessage');
        final receiver = D4.getRequiredArg<$tom_chattools_4.ChatReceiver>(positional, 0, 'receiver', 'sendMessage');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'sendMessage');
        final parseMode = D4.getOptionalNamedArg<String?>(named, 'parseMode');
        return t.sendMessage(receiver, text, parseMode: parseMode);
      },
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 2, 'send');
        final receiver = D4.getRequiredArg<$tom_chattools_4.ChatReceiver>(positional, 0, 'receiver', 'send');
        final message = D4.getRequiredArg<$tom_chattools_3.ChatMessage>(positional, 1, 'message', 'send');
        return t.send(receiver, message);
      },
      'getMessages': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 1, 'getMessages');
        final receiver = D4.getRequiredArg<$tom_chattools_4.ChatReceiver>(positional, 0, 'receiver', 'getMessages');
        final maxWait = D4.getNamedArgWithDefault<Duration>(named, 'maxWait', const Duration(seconds: 30));
        final minWait = D4.getNamedArgWithDefault<Duration>(named, 'minWait', Duration.zero);
        final interval = D4.getNamedArgWithDefault<Duration>(named, 'interval', const Duration(seconds: 2));
        final filter = D4.getOptionalNamedArg<$tom_chattools_1.ChatMessageFilter?>(named, 'filter');
        return t.getMessages(receiver, maxWait: maxWait, minWait: minWait, interval: interval, filter: filter);
      },
      'getReceiverInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 1, 'getReceiverInfo');
        final receiver = D4.getRequiredArg<$tom_chattools_4.ChatReceiver>(positional, 0, 'receiver', 'getReceiverInfo');
        return t.getReceiverInfo(receiver);
      },
      'downloadAttachment': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 1, 'downloadAttachment');
        final attachment = D4.getRequiredArg<$tom_chattools_3.ChatAttachment>(positional, 0, 'attachment', 'downloadAttachment');
        return t.downloadAttachment(attachment);
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        return t.disconnect();
      },
    },
    staticMethods: {
      'connect': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'connect');
        final settings = D4.getRequiredArg<$tom_chattools_6.ChatSettings>(positional, 0, 'settings', 'connect');
        return $tom_chattools_1.ChatApi.connect(settings);
      },
    },
    methodSignatures: {
      'initialize': 'Future<void> initialize()',
      'sendMessage': 'Future<ChatMessage> sendMessage(ChatReceiver receiver, String text, {String? parseMode})',
      'send': 'Future<ChatMessage> send(ChatReceiver receiver, ChatMessage message)',
      'getMessages': 'Future<ChatResponse> getMessages(ChatReceiver receiver, {Duration maxWait = const Duration(seconds: 30), Duration minWait = Duration.zero, Duration interval = const Duration(seconds: 2), ChatMessageFilter? filter})',
      'getReceiverInfo': 'Future<ChatReceiverInfo?> getReceiverInfo(ChatReceiver receiver)',
      'downloadAttachment': 'Future<List<int>?> downloadAttachment(ChatAttachment attachment)',
      'disconnect': 'Future<void> disconnect()',
    },
    getterSignatures: {
      'settings': 'ChatSettings get settings',
      'isConnected': 'bool get isConnected',
      'platform': 'String get platform',
      'onMessage': 'Stream<ChatMessage> get onMessage',
    },
    setterSignatures: {
      'settings': 'set settings(dynamic value)',
    },
    staticMethodSignatures: {
      'connect': 'Future<ChatApi> connect(ChatSettings settings)',
    },
  );
}

// =============================================================================
// ChatMessageFilter Bridge
// =============================================================================

BridgedClass _createChatMessageFilterBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_1.ChatMessageFilter,
    name: 'ChatMessageFilter',
    constructors: {
      '': (visitor, positional, named) {
        final from = D4.coerceListOrNull<$tom_chattools_4.ChatReceiver>(named['from'], 'from');
        final types = D4.coerceListOrNull<$tom_chattools_3.ChatMessageType>(named['types'], 'types');
        final after = D4.getOptionalNamedArg<DateTime?>(named, 'after');
        return $tom_chattools_1.ChatMessageFilter(from: from, types: types, after: after);
      },
    },
    getters: {
      'from': (visitor, target) => D4.validateTarget<$tom_chattools_1.ChatMessageFilter>(target, 'ChatMessageFilter').from,
      'types': (visitor, target) => D4.validateTarget<$tom_chattools_1.ChatMessageFilter>(target, 'ChatMessageFilter').types,
      'after': (visitor, target) => D4.validateTarget<$tom_chattools_1.ChatMessageFilter>(target, 'ChatMessageFilter').after,
    },
    constructorSignatures: {
      '': 'const ChatMessageFilter({List<ChatReceiver>? from, List<ChatMessageType>? types, DateTime? after})',
    },
    getterSignatures: {
      'from': 'List<ChatReceiver>? get from',
      'types': 'List<ChatMessageType>? get types',
      'after': 'DateTime? get after',
    },
  );
}

// =============================================================================
// TelegramChatConfig Bridge
// =============================================================================

BridgedClass _createTelegramChatConfigBridge() {
  return BridgedClass(
    nativeType: $tom_chattools_7.TelegramChatConfig,
    name: 'TelegramChatConfig',
    constructors: {
      '': (visitor, positional, named) {
        final token = D4.getRequiredNamedArg<String>(named, 'token', 'TelegramChatConfig');
        final usePolling = D4.getNamedArgWithDefault<bool>(named, 'usePolling', true);
        final pollingTimeout = D4.getNamedArgWithDefault<int>(named, 'pollingTimeout', 2);
        final allowedUpdates = D4.coerceListOrNull<String>(named['allowedUpdates'], 'allowedUpdates');
        return $tom_chattools_7.TelegramChatConfig(token: token, usePolling: usePolling, pollingTimeout: pollingTimeout, allowedUpdates: allowedUpdates);
      },
    },
    getters: {
      'platform': (visitor, target) => D4.validateTarget<$tom_chattools_7.TelegramChatConfig>(target, 'TelegramChatConfig').platform,
      'token': (visitor, target) => D4.validateTarget<$tom_chattools_7.TelegramChatConfig>(target, 'TelegramChatConfig').token,
      'usePolling': (visitor, target) => D4.validateTarget<$tom_chattools_7.TelegramChatConfig>(target, 'TelegramChatConfig').usePolling,
      'pollingTimeout': (visitor, target) => D4.validateTarget<$tom_chattools_7.TelegramChatConfig>(target, 'TelegramChatConfig').pollingTimeout,
      'allowedUpdates': (visitor, target) => D4.validateTarget<$tom_chattools_7.TelegramChatConfig>(target, 'TelegramChatConfig').allowedUpdates,
    },
    methods: {
      'createApi': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_7.TelegramChatConfig>(target, 'TelegramChatConfig');
        D4.requireMinArgs(positional, 1, 'createApi');
        final settings = D4.getRequiredArg<$tom_chattools_6.ChatSettings>(positional, 0, 'settings', 'createApi');
        return t.createApi(settings);
      },
    },
    constructorSignatures: {
      '': 'const TelegramChatConfig({required String token, bool usePolling = true, int pollingTimeout = 2, List<String>? allowedUpdates})',
    },
    methodSignatures: {
      'createApi': 'ChatApi createApi(ChatSettings settings)',
    },
    getterSignatures: {
      'platform': 'String get platform',
      'token': 'String get token',
      'usePolling': 'bool get usePolling',
      'pollingTimeout': 'int get pollingTimeout',
      'allowedUpdates': 'List<String>? get allowedUpdates',
    },
  );
}

