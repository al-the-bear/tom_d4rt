// D4rt Bridge - Generated file, do not edit
// Sources: 7 files
// Generated: 2026-03-12T17:03:42.361245

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:tom_chattools/src/api/chat/chat_api.dart' as $tom_chattools_1;
import 'package:tom_chattools/src/api/chat/chat_message.dart' as $tom_chattools_2;
import 'package:tom_chattools/src/api/chat/chat_receiver.dart' as $tom_chattools_3;
import 'package:tom_chattools/src/api/chat/chat_response.dart' as $tom_chattools_4;
import 'package:tom_chattools/src/api/chat/chat_settings.dart' as $tom_chattools_5;
import 'package:tom_chattools/src/api/chat/chat_config.dart' as $aux_tom_chattools;

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
      'ChatConfig': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_config.dart',
      'ChatMessage': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_message.dart',
      'ChatSender': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_message.dart',
      'ChatAttachment': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_message.dart',
      'ChatResponse': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_response.dart',
      'ChatReceiver': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_receiver.dart',
      'ChatReceiverInfo': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_receiver.dart',
      'ChatSettings': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_settings.dart',
      'ChatApi': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_api.dart',
      'ChatMessageFilter': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\api\chat\chat_api.dart',
      'TelegramChatConfig': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_chattools-1.0.2\lib\src\telegram\telegram_config.dart',
    };
  }

    isAssignable: (v) => v is ChatConfig,
    constructors: {
    },
    getters: {
      'platform': (visitor, target) => D4.validateTarget<ChatConfig>(target, 'ChatConfig').platform,
    },
    methods: {
      'createApi': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ChatConfig>(target, 'ChatConfig');
        D4.requireMinArgs(positional, 1, 'createApi');
        final settings = D4.getRequiredArg<$tom_chattools_5.ChatSettings>(positional, 0, 'settings', 'createApi');
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
    nativeType: $tom_chattools_2.ChatMessage,
    name: 'ChatMessage',
    isAssignable: (v) => v is $tom_chattools_2.ChatSender,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'ChatSender');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final username = D4.getOptionalNamedArg<String?>(named, 'username');
        final isSelf = D4.getNamedArgWithDefault<bool>(named, 'isSelf', false);
        return $tom_chattools_2.ChatSender(id: id, name: name, username: username, isSelf: isSelf);
      },
      'self': (visitor, positional, named) {
        return $tom_chattools_2.ChatSender.self();
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_chattools_2.ChatSender>(target, 'ChatSender').id,
      'name': (visitor, target) => D4.validateTarget<$tom_chattools_2.ChatSender>(target, 'ChatSender').name,
      'username': (visitor, target) => D4.validateTarget<$tom_chattools_2.ChatSender>(target, 'ChatSender').username,
      'isSelf': (visitor, target) => D4.validateTarget<$tom_chattools_2.ChatSender>(target, 'ChatSender').isSelf,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_2.ChatSender>(target, 'ChatSender');
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
    nativeType: $tom_chattools_2.ChatAttachment,
    name: 'ChatAttachment',
    isAssignable: (v) => v is $tom_chattools_4.ChatResponse,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('messages') || named['messages'] == null) {
          throw ArgumentError('ChatResponse: Missing required named argument "messages"');
        }
        final messages = D4.coerceList<$tom_chattools_2.ChatMessage>(named['messages'], 'messages');
        final success = D4.getNamedArgWithDefault<bool>(named, 'success', true);
        final status = D4.getNamedArgWithDefault<$tom_chattools_4.ChatResponseStatus>(named, 'status', $tom_chattools_4.ChatResponseStatus.ok);
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final waitDuration = D4.getNamedArgWithDefault<Duration>(named, 'waitDuration', Duration.zero);
        final hasMore = D4.getNamedArgWithDefault<bool>(named, 'hasMore', false);
        final metadata = D4.coerceMapOrNull<String, dynamic>(named['metadata'], 'metadata');
        return $tom_chattools_4.ChatResponse(messages: messages, success: success, status: status, error: error, waitDuration: waitDuration, hasMore: hasMore, metadata: metadata);
      },
      'empty': (visitor, positional, named) {
        return $tom_chattools_4.ChatResponse.empty();
      },
      'error': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatResponse');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ChatResponse');
        final status = D4.getOptionalNamedArg<$tom_chattools_4.ChatResponseStatus?>(named, 'status');
        return $tom_chattools_4.ChatResponse.error(message, status: status);
      },
      'timeout': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatResponse');
        final waitDuration = D4.getRequiredArg<Duration>(positional, 0, 'waitDuration', 'ChatResponse');
        return $tom_chattools_4.ChatResponse.timeout(waitDuration);
      },
    },
    getters: {
      'messages': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').messages,
      'success': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').success,
      'status': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').status,
      'error': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').error,
      'waitDuration': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').waitDuration,
      'hasMore': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').hasMore,
      'metadata': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').metadata,
      'hasMessages': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').hasMessages,
      'count': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').count,
      'first': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').first,
      'last': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').last,
      'textContent': (visitor, target) => D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse').textContent,
    },
    methods: {
      'fromSender': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse');
        D4.requireMinArgs(positional, 1, 'fromSender');
        final senderId = D4.getRequiredArg<String>(positional, 0, 'senderId', 'fromSender');
        return t.fromSender(senderId);
      },
      'ofType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse');
        D4.requireMinArgs(positional, 1, 'ofType');
        final type = D4.getRequiredArg<$tom_chattools_2.ChatMessageType>(positional, 0, 'type', 'ofType');
        return t.ofType(type);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_4.ChatResponse>(target, 'ChatResponse');
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
    nativeType: $tom_chattools_3.ChatReceiver,
    name: 'ChatReceiver',
    isAssignable: (v) => v is $tom_chattools_3.ChatReceiverInfo,
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
        return $tom_chattools_3.ChatReceiverInfo(id: id, name: name, firstName: firstName, lastName: lastName, username: username, phone: phone, photoUrl: photoUrl, isBot: isBot, rawData: rawData);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').id,
      'name': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').name,
      'firstName': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').firstName,
      'lastName': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').lastName,
      'username': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').username,
      'phone': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').phone,
      'photoUrl': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').photoUrl,
      'isBot': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').isBot,
      'rawData': (visitor, target) => D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo').rawData,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_3.ChatReceiverInfo>(target, 'ChatReceiverInfo');
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
    nativeType: $tom_chattools_5.ChatSettings,
    name: 'ChatSettings',
        D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi').settings = D4.extractBridgedArg<$tom_chattools_5.ChatSettings>(value, 'settings'),
    },
    methods: {
      'initialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        return t.initialize();
      },
      'sendMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 2, 'sendMessage');
        final receiver = D4.getRequiredArg<$tom_chattools_3.ChatReceiver>(positional, 0, 'receiver', 'sendMessage');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'sendMessage');
        final parseMode = D4.getOptionalNamedArg<String?>(named, 'parseMode');
        return t.sendMessage(receiver, text, parseMode: parseMode);
      },
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 2, 'send');
        final receiver = D4.getRequiredArg<$tom_chattools_3.ChatReceiver>(positional, 0, 'receiver', 'send');
        final message = D4.getRequiredArg<$tom_chattools_2.ChatMessage>(positional, 1, 'message', 'send');
        return t.send(receiver, message);
      },
      'getMessages': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 1, 'getMessages');
        final receiver = D4.getRequiredArg<$tom_chattools_3.ChatReceiver>(positional, 0, 'receiver', 'getMessages');
        final maxWait = D4.getNamedArgWithDefault<Duration>(named, 'maxWait', const Duration(seconds: 30));
        final minWait = D4.getNamedArgWithDefault<Duration>(named, 'minWait', Duration.zero);
        final interval = D4.getNamedArgWithDefault<Duration>(named, 'interval', const Duration(seconds: 2));
        final filter = D4.getOptionalNamedArg<$tom_chattools_1.ChatMessageFilter?>(named, 'filter');
        return t.getMessages(receiver, maxWait: maxWait, minWait: minWait, interval: interval, filter: filter);
      },
      'getReceiverInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 1, 'getReceiverInfo');
        final receiver = D4.getRequiredArg<$tom_chattools_3.ChatReceiver>(positional, 0, 'receiver', 'getReceiverInfo');
        return t.getReceiverInfo(receiver);
      },
      'downloadAttachment': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_chattools_1.ChatApi>(target, 'ChatApi');
        D4.requireMinArgs(positional, 1, 'downloadAttachment');
        final attachment = D4.getRequiredArg<$tom_chattools_2.ChatAttachment>(positional, 0, 'attachment', 'downloadAttachment');
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
        final settings = D4.getRequiredArg<$tom_chattools_5.ChatSettings>(positional, 0, 'settings', 'connect');
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
        final from = D4.coerceListOrNull<$tom_chattools_3.ChatReceiver>(named['from'], 'from');
        final types = D4.coerceListOrNull<$tom_chattools_2.ChatMessageType>(named['types'], 'types');
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
    nativeType: TelegramChatConfig,
    name: 'TelegramChatConfig',
    isAssignable: (v) => v is TelegramChatConfig,
    constructors: {
      '': (visitor, positional, named) {
        final token = D4.getRequiredNamedArg<String>(named, 'token', 'TelegramChatConfig');
        final usePolling = D4.getNamedArgWithDefault<bool>(named, 'usePolling', true);
        final pollingTimeout = D4.getNamedArgWithDefault<int>(named, 'pollingTimeout', 2);
        final allowedUpdates = D4.coerceListOrNull<String>(named['allowedUpdates'], 'allowedUpdates');
        return TelegramChatConfig(token: token, usePolling: usePolling, pollingTimeout: pollingTimeout, allowedUpdates: allowedUpdates);
      },
    },
    getters: {
      'platform': (visitor, target) => D4.validateTarget<TelegramChatConfig>(target, 'TelegramChatConfig').platform,
      'token': (visitor, target) => D4.validateTarget<TelegramChatConfig>(target, 'TelegramChatConfig').token,
      'usePolling': (visitor, target) => D4.validateTarget<TelegramChatConfig>(target, 'TelegramChatConfig').usePolling,
      'pollingTimeout': (visitor, target) => D4.validateTarget<TelegramChatConfig>(target, 'TelegramChatConfig').pollingTimeout,
      'allowedUpdates': (visitor, target) => D4.validateTarget<TelegramChatConfig>(target, 'TelegramChatConfig').allowedUpdates,
    },
    methods: {
      'createApi': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TelegramChatConfig>(target, 'TelegramChatConfig');
        D4.requireMinArgs(positional, 1, 'createApi');
        final settings = D4.getRequiredArg<$tom_chattools_5.ChatSettings>(positional, 0, 'settings', 'createApi');
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

