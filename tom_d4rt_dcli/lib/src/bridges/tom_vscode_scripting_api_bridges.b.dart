// D4rt Bridge - Generated file, do not edit
// Sources: 13 files
// Generated: 2026-03-12T17:03:34.713599

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:tom_vscode_scripting_api/src/vscode.dart' as $tom_vscode_scripting_api_1;
import 'package:tom_vscode_scripting_api/src/vscode_adapter.dart' as $tom_vscode_scripting_api_2;
import 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart' as $tom_vscode_scripting_api_3;
import 'package:tom_vscode_scripting_api/src/vscode_chat.dart' as $tom_vscode_scripting_api_4;
import 'package:tom_vscode_scripting_api/src/vscode_commands.dart' as $tom_vscode_scripting_api_5;
import 'package:tom_vscode_scripting_api/src/vscode_extensions.dart' as $tom_vscode_scripting_api_6;
import 'package:tom_vscode_scripting_api/src/vscode_helper.dart' as $tom_vscode_scripting_api_7;
import 'package:tom_vscode_scripting_api/src/vscode_lm.dart' as $tom_vscode_scripting_api_8;
import 'package:tom_vscode_scripting_api/src/vscode_types.dart' as $tom_vscode_scripting_api_9;
import 'package:tom_vscode_scripting_api/src/vscode_window.dart' as $tom_vscode_scripting_api_10;
import 'package:tom_vscode_scripting_api/src/vscode_workspace.dart' as $tom_vscode_scripting_api_11;

/// Bridge class for tom_vscode_scripting_api module.
class TomVscodeScriptingApiBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createVSCodeAdapterBridge(),
      _createVSCodeBridgeResultBridge(),
      _createVSCodeBridgeClientBridge(),
      _createVSCodeBridgeAdapterBridge(),
      _createLazyVSCodeBridgeAdapterBridge(),
      _createVSCodeBridge(),
      _createVSCodeCommandsBridge(),
      _createVSCodeCommonCommandsBridge(),
      _createExtensionBridge(),
      _createVSCodeExtensionsBridge(),
      _createVSCodeLanguageModelBridge(),
      _createLanguageModelChatBridge(),
      _createLanguageModelChatMessageBridge(),
      _createLanguageModelChatResponseBridge(),
      _createLanguageModelToolResultBridge(),
      _createLanguageModelToolInformationBridge(),
      _createVSCodeWindowBridge(),
      _createVSCodeWorkspaceBridge(),
      _createVSCodeChatBridge(),
      _createChatParticipantBridge(),
      _createChatRequestBridge(),
      _createChatPromptReferenceBridge(),
      _createChatContextBridge(),
      _createChatResultBridge(),
      _createChatErrorDetailsBridge(),
      _createChatResponseStreamBridge(),
      _createHelperLoggingBridge(),
      _createVsCodeHelperBridge(),
      _createVsProgressBridge(),
      _createFileBatchBridge(),
      _createVSCodeUriBridge(),
      _createWorkspaceFolderBridge(),
      _createTextDocumentBridge(),
      _createPositionBridge(),
      _createRangeBridge(),
      _createSelectionBridge(),
      _createTextEditorBridge(),
      _createQuickPickItemBridge(),
      _createInputBoxOptionsBridge(),
      _createMessageOptionsBridge(),
      _createTerminalOptionsBridge(),
      _createFileSystemWatcherOptionsBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'VSCodeAdapter': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_adapter.dart',
      'VSCodeBridgeResult': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_bridge_client.dart',
      'VSCodeBridgeClient': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_bridge_client.dart',
      'VSCodeBridgeAdapter': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_bridge_adapter.dart',
      'LazyVSCodeBridgeAdapter': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_bridge_adapter.dart',
      'VSCode': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode.dart',
      'VSCodeCommands': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_commands.dart',
      'VSCodeCommonCommands': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_commands.dart',
      'Extension': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_extensions.dart',
      'VSCodeExtensions': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_extensions.dart',
      'VSCodeLanguageModel': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_lm.dart',
      'LanguageModelChat': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_lm.dart',
      'LanguageModelChatMessage': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_lm.dart',
      'LanguageModelChatResponse': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_lm.dart',
      'LanguageModelToolResult': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_lm.dart',
      'LanguageModelToolInformation': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_lm.dart',
      'VSCodeWindow': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_window.dart',
      'VSCodeWorkspace': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_workspace.dart',
      'VSCodeChat': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'ChatParticipant': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'ChatRequest': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'ChatPromptReference': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'ChatContext': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'ChatResult': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'ChatErrorDetails': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'ChatResponseStream': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_chat.dart',
      'HelperLogging': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_helper.dart',
      'VsCodeHelper': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_helper.dart',
      'VsProgress': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_helper.dart',
      'FileBatch': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_helper.dart',
      'VSCodeUri': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'WorkspaceFolder': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'TextDocument': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'Position': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'Range': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'Selection': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'TextEditor': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'QuickPickItem': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'InputBoxOptions': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'MessageOptions': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'TerminalOptions': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
      'FileSystemWatcherOptions': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_vscode_scripting_api-1.0.1\lib\src\vscode_types.dart',
    };
  }

    isAssignable: (v) => v is $tom_vscode_scripting_api_2.VSCodeAdapter,
    constructors: {
    },
    methods: {
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.VSCodeAdapter>(target, 'VSCodeAdapter');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        final scriptName = D4.getOptionalNamedArg<String?>(named, 'scriptName');
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(seconds: 60));
        return t.sendRequest(method, params, scriptName: scriptName, timeout: timeout);
      },
    },
    methodSignatures: {
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params, {String? scriptName, Duration timeout = const Duration(seconds: 60)})',
    },
  );
}

// =============================================================================
// VSCodeBridgeResult Bridge
// =============================================================================

BridgedClass _createVSCodeBridgeResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.VSCodeBridgeResult,
    name: 'VSCodeBridgeResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.VSCodeBridgeResult,
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'VSCodeBridgeResult');
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final stackTrace = D4.getOptionalNamedArg<String?>(named, 'stackTrace');
        final exception = D4.getOptionalNamedArg<String?>(named, 'exception');
        final exceptionStackTrace = D4.getOptionalNamedArg<String?>(named, 'exceptionStackTrace');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        if (!named.containsKey('value')) {
          return $tom_vscode_scripting_api_3.VSCodeBridgeResult(success: success, output: output, error: error, stackTrace: stackTrace, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration);
        }
        if (named.containsKey('value')) {
          final value = D4.getRequiredNamedArg<dynamic>(named, 'value', 'VSCodeBridgeResult');
          return $tom_vscode_scripting_api_3.VSCodeBridgeResult(success: success, output: output, error: error, stackTrace: stackTrace, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration, value: value);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'success': (visitor, positional, named) {
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final exception = D4.getOptionalNamedArg<String?>(named, 'exception');
        final exceptionStackTrace = D4.getOptionalNamedArg<String?>(named, 'exceptionStackTrace');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        if (!named.containsKey('value')) {
          return $tom_vscode_scripting_api_3.VSCodeBridgeResult.success(output: output, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration);
        }
        if (named.containsKey('value')) {
          final value = D4.getRequiredNamedArg<dynamic>(named, 'value', 'VSCodeBridgeResult');
          return $tom_vscode_scripting_api_3.VSCodeBridgeResult.success(output: output, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration, value: value);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'failure': (visitor, positional, named) {
        final error = D4.getRequiredNamedArg<String>(named, 'error', 'VSCodeBridgeResult');
        final stackTrace = D4.getOptionalNamedArg<String?>(named, 'stackTrace');
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        return $tom_vscode_scripting_api_3.VSCodeBridgeResult.failure(error: error, stackTrace: stackTrace, output: output, duration: duration);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').success,
      'value': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').value,
      'output': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').output,
      'error': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').error,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').stackTrace,
      'exception': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').exception,
      'exceptionStackTrace': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').exceptionStackTrace,
      'duration': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').duration,
      'hasException': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').hasException,
    },
    constructorSignatures: {
      '': 'const VSCodeBridgeResult({required bool success, dynamic value, String output = \'\', String? error, String? stackTrace, String? exception, String? exceptionStackTrace, required Duration duration})',
      'success': 'factory VSCodeBridgeResult.success({dynamic value, String output = \'\', String? exception, String? exceptionStackTrace, required Duration duration})',
      'failure': 'factory VSCodeBridgeResult.failure({required String error, String? stackTrace, String output = \'\', required Duration duration})',
    },
    getterSignatures: {
      'success': 'bool get success',
      'value': 'dynamic get value',
      'output': 'String get output',
      'error': 'String? get error',
      'stackTrace': 'String? get stackTrace',
      'exception': 'String? get exception',
      'exceptionStackTrace': 'String? get exceptionStackTrace',
      'duration': 'Duration get duration',
      'hasException': 'bool get hasException',
    },
  );
}

// =============================================================================
// VSCodeBridgeClient Bridge
// =============================================================================

BridgedClass _createVSCodeBridgeClientBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.VSCodeBridgeClient,
    name: 'VSCodeBridgeClient',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.VSCodeBridgeClient,
    constructors: {
      '': (visitor, positional, named) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        final connectTimeout = D4.getNamedArgWithDefault<Duration>(named, 'connectTimeout', const Duration(seconds: 5));
        final requestTimeout = D4.getNamedArgWithDefault<Duration>(named, 'requestTimeout', const Duration(seconds: 30));
        if (!named.containsKey('port')) {
          return $tom_vscode_scripting_api_3.VSCodeBridgeClient(host: host, connectTimeout: connectTimeout, requestTimeout: requestTimeout);
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'VSCodeBridgeClient');
          return $tom_vscode_scripting_api_3.VSCodeBridgeClient(host: host, connectTimeout: connectTimeout, requestTimeout: requestTimeout, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'host': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').host,
      'port': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').port,
      'connectTimeout': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').connectTimeout,
      'requestTimeout': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').requestTimeout,
      'isConnected': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').isConnected,
    },
    methods: {
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        return t.connect();
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        return t.disconnect();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        return t.sendRequest(method, params);
      },
      'executeExpression': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeExpression');
        final expression = D4.getRequiredArg<String>(positional, 0, 'expression', 'executeExpression');
        return t.executeExpression(expression);
      },
      'executeScriptFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeScriptFile');
        final filePath = D4.getRequiredArg<String>(positional, 0, 'filePath', 'executeScriptFile');
        return t.executeScriptFile(filePath);
      },
      'executeScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeScript');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'executeScript');
        return t.executeScript(code);
      },
    },
    staticMethods: {
      'isAvailable': (visitor, positional, named, typeArgs) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        if (!named.containsKey('port')) {
          return $tom_vscode_scripting_api_3.VSCodeBridgeClient.isAvailable(host: host);
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'isAvailable');
          return $tom_vscode_scripting_api_3.VSCodeBridgeClient.isAvailable(host: host, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    constructorSignatures: {
      '': 'VSCodeBridgeClient({String host = \'127.0.0.1\', int port = defaultVSCodeBridgePort, Duration connectTimeout = const Duration(seconds: 5), Duration requestTimeout = const Duration(seconds: 30)})',
    },
    methodSignatures: {
      'connect': 'Future<bool> connect()',
      'disconnect': 'Future<void> disconnect()',
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params)',
      'executeExpression': 'Future<VSCodeBridgeResult> executeExpression(String expression)',
      'executeScriptFile': 'Future<VSCodeBridgeResult> executeScriptFile(String filePath)',
      'executeScript': 'Future<VSCodeBridgeResult> executeScript(String code)',
    },
    getterSignatures: {
      'host': 'String get host',
      'port': 'int get port',
      'connectTimeout': 'Duration get connectTimeout',
      'requestTimeout': 'Duration get requestTimeout',
      'isConnected': 'bool get isConnected',
    },
    staticMethodSignatures: {
      'isAvailable': 'Future<bool> isAvailable({String host = \'127.0.0.1\', int port = defaultVSCodeBridgePort})',
    },
  );
}

// =============================================================================
// VSCodeBridgeAdapter Bridge
// =============================================================================

BridgedClass _createVSCodeBridgeAdapterBridge() {
  return BridgedClass(
    nativeType: VSCodeBridgeAdapter,
    name: 'VSCodeBridgeAdapter',
    isAssignable: (v) => v is LazyVSCodeBridgeAdapter,
    constructors: {
      '': (visitor, positional, named) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        final onStatusMessageRaw = named['onStatusMessage'];
        final onErrorMessageRaw = named['onErrorMessage'];
        if (!named.containsKey('port')) {
          return LazyVSCodeBridgeAdapter(host: host, onStatusMessage: onStatusMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onStatusMessageRaw, [p0]); }, onErrorMessage: onErrorMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onErrorMessageRaw, [p0]); });
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'LazyVSCodeBridgeAdapter');
          return LazyVSCodeBridgeAdapter(host: host, onStatusMessage: onStatusMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onStatusMessageRaw, [p0]); }, onErrorMessage: onErrorMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onErrorMessageRaw, [p0]); }, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onStatusMessage': (visitor, target) => D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').onStatusMessage,
      'onErrorMessage': (visitor, target) => D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').onErrorMessage,
      'host': (visitor, target) => D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').host,
      'port': (visitor, target) => D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').port,
      'isConnected': (visitor, target) => D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').isConnected,
    },
    methods: {
      'setHostPort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 2, 'setHostPort');
        final host = D4.getRequiredArg<String>(positional, 0, 'host', 'setHostPort');
        final port = D4.getRequiredArg<int>(positional, 1, 'port', 'setHostPort');
        return t.setHostPort(host, port);
      },
      'setPort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 1, 'setPort');
        final port = D4.getRequiredArg<int>(positional, 0, 'port', 'setPort');
        return t.setPort(port);
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        return t.connect();
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        return t.disconnect();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        final scriptName = D4.getOptionalNamedArg<String?>(named, 'scriptName');
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(seconds: 60));
        return t.sendRequest(method, params, scriptName: scriptName, timeout: timeout);
      },
    },
    constructorSignatures: {
      '': 'LazyVSCodeBridgeAdapter({String host = \'127.0.0.1\', int port = defaultVSCodeBridgePort, void Function(String)? onStatusMessage, void Function(String)? onErrorMessage})',
    },
    methodSignatures: {
      'setHostPort': 'Future<void> setHostPort(String host, int port)',
      'setPort': 'Future<void> setPort(int port)',
      'connect': 'Future<bool> connect()',
      'disconnect': 'Future<void> disconnect()',
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params, {String? scriptName, Duration timeout = const Duration(seconds: 60)})',
    },
    getterSignatures: {
      'onStatusMessage': 'void Function(String message)? get onStatusMessage',
      'onErrorMessage': 'void Function(String message)? get onErrorMessage',
      'host': 'String get host',
      'port': 'int get port',
      'isConnected': 'bool get isConnected',
    },
  );
}

// =============================================================================
// VSCode Bridge
// =============================================================================

BridgedClass _createVSCodeBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_1.VSCode,
    name: 'VSCode',
        D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode').workspace = D4.extractBridgedArg<$tom_vscode_scripting_api_11.VSCodeWorkspace>(value, 'workspace'),
      'window': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode').window = D4.extractBridgedArg<$tom_vscode_scripting_api_10.VSCodeWindow>(value, 'window'),
      'commands': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode').commands = D4.extractBridgedArg<$tom_vscode_scripting_api_5.VSCodeCommands>(value, 'commands'),
      'extensions': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode').extensions = D4.extractBridgedArg<$tom_vscode_scripting_api_6.VSCodeExtensions>(value, 'extensions'),
      'lm': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode').lm = D4.extractBridgedArg<$tom_vscode_scripting_api_8.VSCodeLanguageModel>(value, 'lm'),
      'chat': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode').chat = D4.extractBridgedArg<$tom_vscode_scripting_api_4.VSCodeChat>(value, 'chat'),
    },
    methods: {
      'getVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.getVersion(timeoutSeconds: timeoutSeconds);
      },
      'getEnv': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.getEnv(timeoutSeconds: timeoutSeconds);
      },
      'openExternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode');
        D4.requireMinArgs(positional, 1, 'openExternal');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'openExternal');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.openExternal(uri, timeoutSeconds: timeoutSeconds);
      },
      'copyToClipboard': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode');
        D4.requireMinArgs(positional, 1, 'copyToClipboard');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'copyToClipboard');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.copyToClipboard(text, timeoutSeconds: timeoutSeconds);
      },
      'readFromClipboard': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_1.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.readFromClipboard(timeoutSeconds: timeoutSeconds);
      },
    },
    staticGetters: {
      'instance': (visitor) => $tom_vscode_scripting_api_1.VSCode.instance,
      'isInitialized': (visitor) => $tom_vscode_scripting_api_1.VSCode.isInitialized,
    },
    staticMethods: {
      'initialize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'initialize');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_2.VSCodeAdapter>(positional, 0, 'adapter', 'initialize');
        return $tom_vscode_scripting_api_1.VSCode.initialize(adapter);
      },
    },
    methodSignatures: {
      'getVersion': 'Future<String> getVersion({int timeoutSeconds = 10})',
      'getEnv': 'Future<Map<String, dynamic>> getEnv({int timeoutSeconds = 10})',
      'openExternal': 'Future<bool> openExternal(String uri, {int timeoutSeconds = 30})',
      'copyToClipboard': 'Future<void> copyToClipboard(String text, {int timeoutSeconds = 10})',
      'readFromClipboard': 'Future<String> readFromClipboard({int timeoutSeconds = 10})',
    },
    getterSignatures: {
      'workspace': 'VSCodeWorkspace get workspace',
      'window': 'VSCodeWindow get window',
      'commands': 'VSCodeCommands get commands',
      'extensions': 'VSCodeExtensions get extensions',
      'lm': 'VSCodeLanguageModel get lm',
      'chat': 'VSCodeChat get chat',
      'adapter': 'VSCodeAdapter get adapter',
    },
    setterSignatures: {
      'workspace': 'set workspace(dynamic value)',
      'window': 'set window(dynamic value)',
      'commands': 'set commands(dynamic value)',
      'extensions': 'set extensions(dynamic value)',
      'lm': 'set lm(dynamic value)',
      'chat': 'set chat(dynamic value)',
    },
    staticMethodSignatures: {
      'initialize': 'void initialize(VSCodeAdapter adapter)',
    },
    staticGetterSignatures: {
      'instance': 'VSCode get instance',
      'isInitialized': 'bool get isInitialized',
    },
  );
}

// =============================================================================
// VSCodeCommands Bridge
// =============================================================================

BridgedClass _createVSCodeCommandsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_5.VSCodeCommands,
    name: 'VSCodeCommands',
    isAssignable: (v) => v is VSCodeCommonCommands,
    constructors: {
      '': (visitor, positional, named) {
        return VSCodeCommonCommands();
      },
    },
    staticGetters: {
      'openFile': (visitor) => VSCodeCommonCommands.openFile,
      'openFolder': (visitor) => VSCodeCommonCommands.openFolder,
      'newUntitledFile': (visitor) => VSCodeCommonCommands.newUntitledFile,
      'saveFile': (visitor) => VSCodeCommonCommands.saveFile,
      'saveAllFiles': (visitor) => VSCodeCommonCommands.saveAllFiles,
      'closeActiveEditor': (visitor) => VSCodeCommonCommands.closeActiveEditor,
      'showCommands': (visitor) => VSCodeCommonCommands.showCommands,
      'quickOpen': (visitor) => VSCodeCommonCommands.quickOpen,
      'goToFile': (visitor) => VSCodeCommonCommands.goToFile,
      'goToSymbol': (visitor) => VSCodeCommonCommands.goToSymbol,
      'goToLine': (visitor) => VSCodeCommonCommands.goToLine,
      'findInFiles': (visitor) => VSCodeCommonCommands.findInFiles,
      'replaceInFiles': (visitor) => VSCodeCommonCommands.replaceInFiles,
      'toggleTerminal': (visitor) => VSCodeCommonCommands.toggleTerminal,
      'newTerminal': (visitor) => VSCodeCommonCommands.newTerminal,
      'toggleSidebar': (visitor) => VSCodeCommonCommands.toggleSidebar,
      'togglePanel': (visitor) => VSCodeCommonCommands.togglePanel,
      'formatDocument': (visitor) => VSCodeCommonCommands.formatDocument,
      'organizeImports': (visitor) => VSCodeCommonCommands.organizeImports,
      'renameSymbol': (visitor) => VSCodeCommonCommands.renameSymbol,
      'goToDefinition': (visitor) => VSCodeCommonCommands.goToDefinition,
      'goToReferences': (visitor) => VSCodeCommonCommands.goToReferences,
      'showHover': (visitor) => VSCodeCommonCommands.showHover,
      'commentLine': (visitor) => VSCodeCommonCommands.commentLine,
      'copyLineDown': (visitor) => VSCodeCommonCommands.copyLineDown,
      'moveLineDown': (visitor) => VSCodeCommonCommands.moveLineDown,
      'deleteLine': (visitor) => VSCodeCommonCommands.deleteLine,
      'reloadWindow': (visitor) => VSCodeCommonCommands.reloadWindow,
      'showExtensions': (visitor) => VSCodeCommonCommands.showExtensions,
      'installExtension': (visitor) => VSCodeCommonCommands.installExtension,
    },
    constructorSignatures: {
      '': 'VSCodeCommonCommands()',
    },
    staticGetterSignatures: {
      'openFile': 'String get openFile',
      'openFolder': 'String get openFolder',
      'newUntitledFile': 'String get newUntitledFile',
      'saveFile': 'String get saveFile',
      'saveAllFiles': 'String get saveAllFiles',
      'closeActiveEditor': 'String get closeActiveEditor',
      'showCommands': 'String get showCommands',
      'quickOpen': 'String get quickOpen',
      'goToFile': 'String get goToFile',
      'goToSymbol': 'String get goToSymbol',
      'goToLine': 'String get goToLine',
      'findInFiles': 'String get findInFiles',
      'replaceInFiles': 'String get replaceInFiles',
      'toggleTerminal': 'String get toggleTerminal',
      'newTerminal': 'String get newTerminal',
      'toggleSidebar': 'String get toggleSidebar',
      'togglePanel': 'String get togglePanel',
      'formatDocument': 'String get formatDocument',
      'organizeImports': 'String get organizeImports',
      'renameSymbol': 'String get renameSymbol',
      'goToDefinition': 'String get goToDefinition',
      'goToReferences': 'String get goToReferences',
      'showHover': 'String get showHover',
      'commentLine': 'String get commentLine',
      'copyLineDown': 'String get copyLineDown',
      'moveLineDown': 'String get moveLineDown',
      'deleteLine': 'String get deleteLine',
      'reloadWindow': 'String get reloadWindow',
      'showExtensions': 'String get showExtensions',
      'installExtension': 'String get installExtension',
    },
  );
}

// =============================================================================
// Extension Bridge
// =============================================================================

BridgedClass _createExtensionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.Extension,
    name: 'Extension',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.VSCodeExtensions,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeExtensions');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_2.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeExtensions');
        return $tom_vscode_scripting_api_6.VSCodeExtensions(adapter);
      },
    },
    methods: {
      'getAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getAll(timeoutSeconds: timeoutSeconds);
      },
      'getExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtension');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtension');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtension(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'isInstalled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'isInstalled');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'isInstalled');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.isInstalled(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionExports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionExports');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionExports');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.getExtensionExports(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'activateExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'activateExtension');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'activateExtension');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return t.activateExtension(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionVersion');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionVersion');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionVersion(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionDisplayName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionDisplayName');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionDisplayName');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionDisplayName(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionDescription');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionDescription');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionDescription(extensionId, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeExtensions(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'getAll': 'Future<List<Extension>> getAll({int timeoutSeconds = 60})',
      'getExtension': 'Future<Extension?> getExtension(String extensionId, {int timeoutSeconds = 60})',
      'isInstalled': 'Future<bool> isInstalled(String extensionId, {int timeoutSeconds = 60})',
      'getExtensionExports': 'Future<dynamic> getExtensionExports(String extensionId, {int timeoutSeconds = 120})',
      'activateExtension': 'Future<bool> activateExtension(String extensionId, {int timeoutSeconds = 180})',
      'getExtensionVersion': 'Future<String?> getExtensionVersion(String extensionId, {int timeoutSeconds = 60})',
      'getExtensionDisplayName': 'Future<String?> getExtensionDisplayName(String extensionId, {int timeoutSeconds = 60})',
      'getExtensionDescription': 'Future<String?> getExtensionDescription(String extensionId, {int timeoutSeconds = 60})',
    },
  );
}

// =============================================================================
// VSCodeLanguageModel Bridge
// =============================================================================

BridgedClass _createVSCodeLanguageModelBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_8.VSCodeLanguageModel,
    name: 'VSCodeLanguageModel',
    isAssignable: (v) => v is $tom_vscode_scripting_api_8.LanguageModelChat,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'LanguageModelChat');
        final vendor = D4.getRequiredNamedArg<String>(named, 'vendor', 'LanguageModelChat');
        final family = D4.getRequiredNamedArg<String>(named, 'family', 'LanguageModelChat');
        final version = D4.getRequiredNamedArg<String>(named, 'version', 'LanguageModelChat');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'LanguageModelChat');
        final maxInputTokens = D4.getRequiredNamedArg<int>(named, 'maxInputTokens', 'LanguageModelChat');
        return $tom_vscode_scripting_api_8.LanguageModelChat(id: id, vendor: vendor, family: family, version: version, name: name, maxInputTokens: maxInputTokens);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChat');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChat: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_8.LanguageModelChat.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat').id,
      'vendor': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat').vendor,
      'family': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat').family,
      'version': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat').version,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat').name,
      'maxInputTokens': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat').maxInputTokens,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat');
        return t.toJson();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_2.VSCodeAdapter>(positional, 0, 'adapter', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "messages" at position 1');
        }
        final messages = D4.coerceList<$tom_vscode_scripting_api_8.LanguageModelChatMessage>(positional[1], 'messages');
        final modelOptions = D4.coerceMapOrNull<String, dynamic>(named['modelOptions'], 'modelOptions');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return t.sendRequest(adapter, messages, modelOptions: modelOptions, timeoutSeconds: timeoutSeconds);
      },
      'countTokens': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChat>(target, 'LanguageModelChat');
        D4.requireMinArgs(positional, 2, 'countTokens');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_2.VSCodeAdapter>(positional, 0, 'adapter', 'countTokens');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'countTokens');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.countTokens(adapter, text, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChat({required String id, required String vendor, required String family, required String version, required String name, required int maxInputTokens})',
      'fromJson': 'factory LanguageModelChat.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'sendRequest': 'Future<LanguageModelChatResponse> sendRequest(VSCodeAdapter adapter, List<LanguageModelChatMessage> messages, {Map<String, dynamic>? modelOptions, int timeoutSeconds = 300})',
      'countTokens': 'Future<int> countTokens(VSCodeAdapter adapter, String text, {int timeoutSeconds = 120})',
    },
    getterSignatures: {
      'id': 'String get id',
      'vendor': 'String get vendor',
      'family': 'String get family',
      'version': 'String get version',
      'name': 'String get name',
      'maxInputTokens': 'int get maxInputTokens',
    },
  );
}

// =============================================================================
// LanguageModelChatMessage Bridge
// =============================================================================

BridgedClass _createLanguageModelChatMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_8.LanguageModelChatMessage,
    name: 'LanguageModelChatMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_8.LanguageModelChatResponse,
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'LanguageModelChatResponse');
        if (!named.containsKey('streamParts') || named['streamParts'] == null) {
          throw ArgumentError('LanguageModelChatResponse: Missing required named argument "streamParts"');
        }
        final streamParts = D4.coerceList<String>(named['streamParts'], 'streamParts');
        return $tom_vscode_scripting_api_8.LanguageModelChatResponse(text: text, streamParts: streamParts);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatResponse');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChatResponse: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_8.LanguageModelChatResponse.fromJson(json);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChatResponse>(target, 'LanguageModelChatResponse').text,
      'streamParts': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChatResponse>(target, 'LanguageModelChatResponse').streamParts,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelChatResponse>(target, 'LanguageModelChatResponse');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChatResponse({required String text, required List<String> streamParts})',
      'fromJson': 'factory LanguageModelChatResponse.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'text': 'String get text',
      'streamParts': 'List<String> get streamParts',
    },
  );
}

// =============================================================================
// LanguageModelToolResult Bridge
// =============================================================================

BridgedClass _createLanguageModelToolResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_8.LanguageModelToolResult,
    name: 'LanguageModelToolResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_8.LanguageModelToolInformation,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'LanguageModelToolInformation');
        final description = D4.getRequiredNamedArg<String>(named, 'description', 'LanguageModelToolInformation');
        if (!named.containsKey('inputSchema') || named['inputSchema'] == null) {
          throw ArgumentError('LanguageModelToolInformation: Missing required named argument "inputSchema"');
        }
        final inputSchema = D4.coerceMap<String, dynamic>(named['inputSchema'], 'inputSchema');
        return $tom_vscode_scripting_api_8.LanguageModelToolInformation(name: name, description: description, inputSchema: inputSchema);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelToolInformation');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelToolInformation: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_8.LanguageModelToolInformation.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').name,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').description,
      'inputSchema': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').inputSchema,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_8.LanguageModelToolInformation>(target, 'LanguageModelToolInformation');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelToolInformation({required String name, required String description, required Map<String, dynamic> inputSchema})',
      'fromJson': 'factory LanguageModelToolInformation.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String get description',
      'inputSchema': 'Map<String, dynamic> get inputSchema',
    },
  );
}

// =============================================================================
// VSCodeWindow Bridge
// =============================================================================

BridgedClass _createVSCodeWindowBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_10.VSCodeWindow,
    name: 'VSCodeWindow',
    isAssignable: (v) => v is $tom_vscode_scripting_api_11.VSCodeWorkspace,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeWorkspace');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_2.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeWorkspace');
        return $tom_vscode_scripting_api_11.VSCodeWorkspace(adapter);
      },
    },
    methods: {
      'getWorkspaceFolders': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.getWorkspaceFolders(timeoutSeconds: timeoutSeconds);
      },
      'getWorkspaceFolder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'getWorkspaceFolder');
        final uri = D4.getRequiredArg<$tom_vscode_scripting_api_9.VSCodeUri>(positional, 0, 'uri', 'getWorkspaceFolder');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.getWorkspaceFolder(uri, timeoutSeconds: timeoutSeconds);
      },
      'openTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'openTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'openTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.openTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'saveTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'saveTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'saveTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.saveTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'findFiles': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'findFiles');
        final include = D4.getRequiredArg<String>(positional, 0, 'include', 'findFiles');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.findFiles(include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'findFilePaths': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        final include = D4.getRequiredNamedArg<String>(named, 'include', 'findFilePaths');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.findFilePaths(include: include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'getConfiguration': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'getConfiguration');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'getConfiguration');
        final scope = D4.getOptionalNamedArg<String?>(named, 'scope');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getConfiguration(section, scope: scope, timeoutSeconds: timeoutSeconds);
      },
      'updateConfiguration': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 3, 'updateConfiguration');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'updateConfiguration');
        final key = D4.getRequiredArg<String>(positional, 1, 'key', 'updateConfiguration');
        final value = D4.getRequiredArg<dynamic>(positional, 2, 'value', 'updateConfiguration');
        final global = D4.getNamedArgWithDefault<bool>(named, 'global', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.updateConfiguration(section, key, value, global: global, timeoutSeconds: timeoutSeconds);
      },
      'getRootPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        return t.getRootPath();
      },
      'getWorkspaceName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        return t.getWorkspaceName();
      },
      'readFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'readFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readFile');
        return t.readFile(path);
      },
      'writeFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 2, 'writeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'writeFile');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'writeFile');
        return t.writeFile(path, content);
      },
      'deleteFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'deleteFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'deleteFile');
        return t.deleteFile(path);
      },
      'fileExists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'fileExists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'fileExists');
        return t.fileExists(path);
      },
    },
    constructorSignatures: {
      '': 'VSCodeWorkspace(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'getWorkspaceFolders': 'Future<List<WorkspaceFolder>> getWorkspaceFolders({int timeoutSeconds = 30})',
      'getWorkspaceFolder': 'Future<WorkspaceFolder?> getWorkspaceFolder(VSCodeUri uri, {int timeoutSeconds = 30})',
      'openTextDocument': 'Future<TextDocument?> openTextDocument(String path, {int timeoutSeconds = 60})',
      'saveTextDocument': 'Future<bool> saveTextDocument(String path, {int timeoutSeconds = 60})',
      'findFiles': 'Future<List<VSCodeUri>> findFiles(String include, {String? exclude, int? maxResults, int timeoutSeconds = 60})',
      'findFilePaths': 'Future<List<String>> findFilePaths({required String include, String? exclude, int? maxResults, int timeoutSeconds = 60})',
      'getConfiguration': 'Future<dynamic> getConfiguration(String section, {String? scope, int timeoutSeconds = 60})',
      'updateConfiguration': 'Future<bool> updateConfiguration(String section, String key, dynamic value, {bool global = false, int timeoutSeconds = 60})',
      'getRootPath': 'Future<String?> getRootPath()',
      'getWorkspaceName': 'Future<String?> getWorkspaceName()',
      'readFile': 'Future<String> readFile(String path)',
      'writeFile': 'Future<bool> writeFile(String path, String content)',
      'deleteFile': 'Future<bool> deleteFile(String path)',
      'fileExists': 'Future<bool> fileExists(String path)',
    },
  );
}

// =============================================================================
// VSCodeChat Bridge
// =============================================================================

BridgedClass _createVSCodeChatBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.VSCodeChat,
    name: 'VSCodeChat',
        return t.createChatParticipant(id, handler: ($tom_vscode_scripting_api_4.ChatRequest p0, $tom_vscode_scripting_api_4.ChatContext p1, $tom_vscode_scripting_api_4.ChatResponseStream p2) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0, p1, p2]) as Future<$tom_vscode_scripting_api_4.ChatResult>; }, description: description, fullName: fullName, timeoutSeconds: timeoutSeconds);
      },
    },
    staticMethods: {
      'handleChatRequest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'handleChatRequest');
        if (positional.isEmpty) {
          throw ArgumentError('handleChatRequest: Missing required argument "params" at position 0');
        }
        final params = D4.coerceMap<String, dynamic>(positional[0], 'params');
        return $tom_vscode_scripting_api_4.VSCodeChat.handleChatRequest(params);
      },
    },
    constructorSignatures: {
      '': 'VSCodeChat(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'createChatParticipant': 'Future<ChatParticipant> createChatParticipant(String id, {required ChatRequestHandler handler, String? description, String? fullName, int timeoutSeconds = 300})',
    },
    staticMethodSignatures: {
      'handleChatRequest': 'Future<Map<String, dynamic>?> handleChatRequest(Map<String, dynamic> params)',
    },
  );
}

// =============================================================================
// ChatParticipant Bridge
// =============================================================================

BridgedClass _createChatParticipantBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ChatParticipant,
    name: 'ChatParticipant',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ChatRequest,
    constructors: {
      '': (visitor, positional, named) {
        final prompt = D4.getRequiredNamedArg<String>(named, 'prompt', 'ChatRequest');
        final command = D4.getRequiredNamedArg<String>(named, 'command', 'ChatRequest');
        if (!named.containsKey('references') || named['references'] == null) {
          throw ArgumentError('ChatRequest: Missing required named argument "references"');
        }
        final references = D4.coerceList<$tom_vscode_scripting_api_4.ChatPromptReference>(named['references'], 'references');
        return $tom_vscode_scripting_api_4.ChatRequest(prompt: prompt, command: command, references: references);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatRequest');
        if (positional.isEmpty) {
          throw ArgumentError('ChatRequest: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_4.ChatRequest.fromJson(json);
      },
    },
    getters: {
      'prompt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ChatRequest>(target, 'ChatRequest').prompt,
      'command': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ChatRequest>(target, 'ChatRequest').command,
      'references': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ChatRequest>(target, 'ChatRequest').references,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ChatRequest>(target, 'ChatRequest');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatRequest({required String prompt, required String command, required List<ChatPromptReference> references})',
      'fromJson': 'factory ChatRequest.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'prompt': 'String get prompt',
      'command': 'String get command',
      'references': 'List<ChatPromptReference> get references',
    },
  );
}

// =============================================================================
// ChatPromptReference Bridge
// =============================================================================

BridgedClass _createChatPromptReferenceBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ChatPromptReference,
    name: 'ChatPromptReference',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ChatContext,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('history') || named['history'] == null) {
          throw ArgumentError('ChatContext: Missing required named argument "history"');
        }
        final history = D4.coerceList<dynamic>(named['history'], 'history');
        return $tom_vscode_scripting_api_4.ChatContext(history: history);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatContext');
        if (positional.isEmpty) {
          throw ArgumentError('ChatContext: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_4.ChatContext.fromJson(json);
      },
    },
    getters: {
      'history': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ChatContext>(target, 'ChatContext').history,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ChatContext>(target, 'ChatContext');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatContext({required List<dynamic> history})',
      'fromJson': 'factory ChatContext.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'history': 'List<dynamic> get history',
    },
  );
}

// =============================================================================
// ChatResult Bridge
// =============================================================================

BridgedClass _createChatResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ChatResult,
    name: 'ChatResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ChatErrorDetails,
    constructors: {
      '': (visitor, positional, named) {
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'ChatErrorDetails');
        final responseIsFiltered = D4.getOptionalNamedArg<bool?>(named, 'responseIsFiltered');
        return $tom_vscode_scripting_api_4.ChatErrorDetails(message: message, responseIsFiltered: responseIsFiltered);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ChatErrorDetails>(target, 'ChatErrorDetails').message,
      'responseIsFiltered': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ChatErrorDetails>(target, 'ChatErrorDetails').responseIsFiltered,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ChatErrorDetails>(target, 'ChatErrorDetails');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatErrorDetails({required String message, bool? responseIsFiltered})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'message': 'String get message',
      'responseIsFiltered': 'bool? get responseIsFiltered',
    },
  );
}

// =============================================================================
// ChatResponseStream Bridge
// =============================================================================

BridgedClass _createChatResponseStreamBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ChatResponseStream,
    name: 'ChatResponseStream',
    isAssignable: (v) => v is HelperLogging,
    constructors: {
      '': (visitor, positional, named) {
        return HelperLogging();
      },
    },
    staticGetters: {
      'debugLogging': (visitor) => HelperLogging.debugLogging,
    },
    staticSetters: {
      'debugLogging': (visitor, value) => 
        HelperLogging.debugLogging = D4.extractBridgedArg<bool>(value, 'debugLogging'),
    },
    constructorSignatures: {
      '': 'HelperLogging()',
    },
    staticGetterSignatures: {
      'debugLogging': 'bool get debugLogging',
    },
    staticSetterSignatures: {
      'debugLogging': 'set debugLogging(dynamic value)',
    },
  );
}

// =============================================================================
// VsCodeHelper Bridge
// =============================================================================

BridgedClass _createVsCodeHelperBridge() {
  return BridgedClass(
    nativeType: VsCodeHelper,
    name: 'VsCodeHelper',
    isAssignable: (v) => v is $tom_vscode_scripting_api_7.VsProgress,
    constructors: {
    },
    getters: {
      'channelName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.VsProgress>(target, 'VsProgress').channelName,
    },
    methods: {
      'report': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VsProgress>(target, 'VsProgress');
        D4.requireMinArgs(positional, 1, 'report');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'report');
        return t.report(message);
      },
      'complete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VsProgress>(target, 'VsProgress');
        return t.complete();
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VsProgress>(target, 'VsProgress');
        D4.requireMinArgs(positional, 1, 'error');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'error');
        return t.error(message);
      },
    },
    staticMethods: {
      'create': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'create');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'create');
        return $tom_vscode_scripting_api_7.VsProgress.create(name);
      },
    },
    methodSignatures: {
      'report': 'Future<void> report(String message)',
      'complete': 'Future<void> complete()',
      'error': 'Future<void> error(String message)',
    },
    getterSignatures: {
      'channelName': 'String get channelName',
    },
    staticMethodSignatures: {
      'create': 'Future<VsProgress> create(String name)',
    },
  );
}

// =============================================================================
// FileBatch Bridge
// =============================================================================

BridgedClass _createFileBatchBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_7.FileBatch,
    name: 'FileBatch',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.VSCodeUri,
    constructors: {
      '': (visitor, positional, named) {
        final scheme = D4.getRequiredNamedArg<String>(named, 'scheme', 'VSCodeUri');
        final authority = D4.getNamedArgWithDefault<String>(named, 'authority', '');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'VSCodeUri');
        final query = D4.getNamedArgWithDefault<String>(named, 'query', '');
        final fragment = D4.getNamedArgWithDefault<String>(named, 'fragment', '');
        final fsPath = D4.getRequiredNamedArg<String>(named, 'fsPath', 'VSCodeUri');
        return $tom_vscode_scripting_api_9.VSCodeUri(scheme: scheme, authority: authority, path: path, query: query, fragment: fragment, fsPath: fsPath);
      },
      'file': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeUri');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'VSCodeUri');
        return $tom_vscode_scripting_api_9.VSCodeUri.file(path);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeUri');
        if (positional.isEmpty) {
          throw ArgumentError('VSCodeUri: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.VSCodeUri.fromJson(json);
      },
    },
    getters: {
      'scheme': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri').scheme,
      'authority': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri').authority,
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri').path,
      'query': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri').query,
      'fragment': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri').fragment,
      'fsPath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri').fsPath,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.VSCodeUri>(target, 'VSCodeUri');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'VSCodeUri({required String scheme, String authority = \'\', required String path, String query = \'\', String fragment = \'\', required String fsPath})',
      'file': 'factory VSCodeUri.file(String path)',
      'fromJson': 'factory VSCodeUri.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'scheme': 'String get scheme',
      'authority': 'String get authority',
      'path': 'String get path',
      'query': 'String get query',
      'fragment': 'String get fragment',
      'fsPath': 'String get fsPath',
    },
  );
}

// =============================================================================
// WorkspaceFolder Bridge
// =============================================================================

BridgedClass _createWorkspaceFolderBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.WorkspaceFolder,
    name: 'WorkspaceFolder',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.TextDocument,
    constructors: {
      '': (visitor, positional, named) {
        final uri = D4.getRequiredNamedArg<$tom_vscode_scripting_api_9.VSCodeUri>(named, 'uri', 'TextDocument');
        final fileName = D4.getRequiredNamedArg<String>(named, 'fileName', 'TextDocument');
        final isUntitled = D4.getRequiredNamedArg<bool>(named, 'isUntitled', 'TextDocument');
        final languageId = D4.getRequiredNamedArg<String>(named, 'languageId', 'TextDocument');
        final version = D4.getRequiredNamedArg<int>(named, 'version', 'TextDocument');
        final isDirty = D4.getRequiredNamedArg<bool>(named, 'isDirty', 'TextDocument');
        final isClosed = D4.getRequiredNamedArg<bool>(named, 'isClosed', 'TextDocument');
        final lineCount = D4.getRequiredNamedArg<int>(named, 'lineCount', 'TextDocument');
        return $tom_vscode_scripting_api_9.TextDocument(uri: uri, fileName: fileName, isUntitled: isUntitled, languageId: languageId, version: version, isDirty: isDirty, isClosed: isClosed, lineCount: lineCount);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextDocument');
        if (positional.isEmpty) {
          throw ArgumentError('TextDocument: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.TextDocument.fromJson(json);
      },
    },
    getters: {
      'uri': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').uri,
      'fileName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').fileName,
      'isUntitled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').isUntitled,
      'languageId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').languageId,
      'version': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').version,
      'isDirty': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').isDirty,
      'isClosed': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').isClosed,
      'lineCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument').lineCount,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.TextDocument>(target, 'TextDocument');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TextDocument({required VSCodeUri uri, required String fileName, required bool isUntitled, required String languageId, required int version, required bool isDirty, required bool isClosed, required int lineCount})',
      'fromJson': 'factory TextDocument.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'uri': 'VSCodeUri get uri',
      'fileName': 'String get fileName',
      'isUntitled': 'bool get isUntitled',
      'languageId': 'String get languageId',
      'version': 'int get version',
      'isDirty': 'bool get isDirty',
      'isClosed': 'bool get isClosed',
      'lineCount': 'int get lineCount',
    },
  );
}

// =============================================================================
// Position Bridge
// =============================================================================

BridgedClass _createPositionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.Position,
    name: 'Position',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.Range,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Range');
        final start = D4.getRequiredArg<$tom_vscode_scripting_api_9.Position>(positional, 0, 'start', 'Range');
        final end = D4.getRequiredArg<$tom_vscode_scripting_api_9.Position>(positional, 1, 'end', 'Range');
        return $tom_vscode_scripting_api_9.Range(start, end);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Range');
        if (positional.isEmpty) {
          throw ArgumentError('Range: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.Range.fromJson(json);
      },
    },
    getters: {
      'start': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.Range>(target, 'Range').start,
      'end': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.Range>(target, 'Range').end,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.Range>(target, 'Range');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Range(Position start, Position end)',
      'fromJson': 'factory Range.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'start': 'Position get start',
      'end': 'Position get end',
    },
  );
}

// =============================================================================
// Selection Bridge
// =============================================================================

BridgedClass _createSelectionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.Selection,
    name: 'Selection',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.TextEditor,
    constructors: {
      '': (visitor, positional, named) {
        final document = D4.getRequiredNamedArg<$tom_vscode_scripting_api_9.TextDocument>(named, 'document', 'TextEditor');
        final selection = D4.getRequiredNamedArg<$tom_vscode_scripting_api_9.Selection>(named, 'selection', 'TextEditor');
        if (!named.containsKey('selections') || named['selections'] == null) {
          throw ArgumentError('TextEditor: Missing required named argument "selections"');
        }
        final selections = D4.coerceList<$tom_vscode_scripting_api_9.Selection>(named['selections'], 'selections');
        final visibleRanges = D4.getOptionalNamedArg<$tom_vscode_scripting_api_9.Range?>(named, 'visibleRanges');
        return $tom_vscode_scripting_api_9.TextEditor(document: document, selection: selection, selections: selections, visibleRanges: visibleRanges);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextEditor');
        if (positional.isEmpty) {
          throw ArgumentError('TextEditor: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.TextEditor.fromJson(json);
      },
    },
    getters: {
      'document': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextEditor>(target, 'TextEditor').document,
      'selection': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextEditor>(target, 'TextEditor').selection,
      'selections': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextEditor>(target, 'TextEditor').selections,
      'visibleRanges': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.TextEditor>(target, 'TextEditor').visibleRanges,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.TextEditor>(target, 'TextEditor');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TextEditor({required TextDocument document, required Selection selection, required List<Selection> selections, Range? visibleRanges})',
      'fromJson': 'factory TextEditor.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'document': 'TextDocument get document',
      'selection': 'Selection get selection',
      'selections': 'List<Selection> get selections',
      'visibleRanges': 'Range? get visibleRanges',
    },
  );
}

// =============================================================================
// QuickPickItem Bridge
// =============================================================================

BridgedClass _createQuickPickItemBridge() {
  return BridgedClass(
    nativeType: QuickPickItem,
    name: 'QuickPickItem',
    isAssignable: (v) => v is InputBoxOptions,
    constructors: {
      '': (visitor, positional, named) {
        final prompt = D4.getOptionalNamedArg<String?>(named, 'prompt');
        final placeHolder = D4.getOptionalNamedArg<String?>(named, 'placeHolder');
        final value = D4.getOptionalNamedArg<String?>(named, 'value');
        final password = D4.getNamedArgWithDefault<bool>(named, 'password', false);
        return InputBoxOptions(prompt: prompt, placeHolder: placeHolder, value: value, password: password);
      },
    },
    getters: {
      'prompt': (visitor, target) => D4.validateTarget<InputBoxOptions>(target, 'InputBoxOptions').prompt,
      'placeHolder': (visitor, target) => D4.validateTarget<InputBoxOptions>(target, 'InputBoxOptions').placeHolder,
      'value': (visitor, target) => D4.validateTarget<InputBoxOptions>(target, 'InputBoxOptions').value,
      'password': (visitor, target) => D4.validateTarget<InputBoxOptions>(target, 'InputBoxOptions').password,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<InputBoxOptions>(target, 'InputBoxOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'InputBoxOptions({String? prompt, String? placeHolder, String? value, bool password = false})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'prompt': 'String? get prompt',
      'placeHolder': 'String? get placeHolder',
      'value': 'String? get value',
      'password': 'bool get password',
    },
  );
}

// =============================================================================
// MessageOptions Bridge
// =============================================================================

BridgedClass _createMessageOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.MessageOptions,
    name: 'MessageOptions',
    isAssignable: (v) => v is TerminalOptions,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final shellPath = D4.getOptionalNamedArg<String?>(named, 'shellPath');
        final shellArgs = D4.coerceListOrNull<String>(named['shellArgs'], 'shellArgs');
        final cwd = D4.getOptionalNamedArg<String?>(named, 'cwd');
        final env = D4.coerceMapOrNull<String, String>(named['env'], 'env');
        return TerminalOptions(name: name, shellPath: shellPath, shellArgs: shellArgs, cwd: cwd, env: env);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<TerminalOptions>(target, 'TerminalOptions').name,
      'shellPath': (visitor, target) => D4.validateTarget<TerminalOptions>(target, 'TerminalOptions').shellPath,
      'shellArgs': (visitor, target) => D4.validateTarget<TerminalOptions>(target, 'TerminalOptions').shellArgs,
      'cwd': (visitor, target) => D4.validateTarget<TerminalOptions>(target, 'TerminalOptions').cwd,
      'env': (visitor, target) => D4.validateTarget<TerminalOptions>(target, 'TerminalOptions').env,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TerminalOptions>(target, 'TerminalOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TerminalOptions({String? name, String? shellPath, List<String>? shellArgs, String? cwd, Map<String, String>? env})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String? get name',
      'shellPath': 'String? get shellPath',
      'shellArgs': 'List<String>? get shellArgs',
      'cwd': 'String? get cwd',
      'env': 'Map<String, String>? get env',
    },
  );
}

// =============================================================================
// FileSystemWatcherOptions Bridge
// =============================================================================

BridgedClass _createFileSystemWatcherOptionsBridge() {
  return BridgedClass(
    nativeType: FileSystemWatcherOptions,
    name: 'FileSystemWatcherOptions',
    isAssignable: (v) => v is FileSystemWatcherOptions,
    constructors: {
      '': (visitor, positional, named) {
        final ignoreCreateEvents = D4.getNamedArgWithDefault<bool>(named, 'ignoreCreateEvents', false);
        final ignoreChangeEvents = D4.getNamedArgWithDefault<bool>(named, 'ignoreChangeEvents', false);
        final ignoreDeleteEvents = D4.getNamedArgWithDefault<bool>(named, 'ignoreDeleteEvents', false);
        return FileSystemWatcherOptions(ignoreCreateEvents: ignoreCreateEvents, ignoreChangeEvents: ignoreChangeEvents, ignoreDeleteEvents: ignoreDeleteEvents);
      },
    },
    getters: {
      'ignoreCreateEvents': (visitor, target) => D4.validateTarget<FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreCreateEvents,
      'ignoreChangeEvents': (visitor, target) => D4.validateTarget<FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreChangeEvents,
      'ignoreDeleteEvents': (visitor, target) => D4.validateTarget<FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreDeleteEvents,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'FileSystemWatcherOptions({bool ignoreCreateEvents = false, bool ignoreChangeEvents = false, bool ignoreDeleteEvents = false})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'ignoreCreateEvents': 'bool get ignoreCreateEvents',
      'ignoreChangeEvents': 'bool get ignoreChangeEvents',
      'ignoreDeleteEvents': 'bool get ignoreDeleteEvents',
    },
  );
}

