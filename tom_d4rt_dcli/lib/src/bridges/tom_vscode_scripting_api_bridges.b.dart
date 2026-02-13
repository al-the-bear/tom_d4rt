// D4rt Bridge - Generated file, do not edit
// Sources: 12 files
// Generated: 2026-02-13T17:59:18.906455

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:tom_vscode_scripting_api/script_globals.dart' as $pkg;

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
      'VSCodeAdapter': 'package:tom_vscode_scripting_api/src/vscode_adapter.dart',
      'VSCodeBridgeResult': 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart',
      'VSCodeBridgeClient': 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart',
      'VSCodeBridgeAdapter': 'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart',
      'LazyVSCodeBridgeAdapter': 'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart',
      'VSCode': 'package:tom_vscode_scripting_api/src/vscode.dart',
      'VSCodeCommands': 'package:tom_vscode_scripting_api/src/vscode_commands.dart',
      'VSCodeCommonCommands': 'package:tom_vscode_scripting_api/src/vscode_commands.dart',
      'Extension': 'package:tom_vscode_scripting_api/src/vscode_extensions.dart',
      'VSCodeExtensions': 'package:tom_vscode_scripting_api/src/vscode_extensions.dart',
      'VSCodeLanguageModel': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelChat': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelChatMessage': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelChatResponse': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelToolResult': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelToolInformation': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'VSCodeWindow': 'package:tom_vscode_scripting_api/src/vscode_window.dart',
      'VSCodeWorkspace': 'package:tom_vscode_scripting_api/src/vscode_workspace.dart',
      'VSCodeChat': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatParticipant': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatRequest': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatPromptReference': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatContext': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatResult': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatErrorDetails': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatResponseStream': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'HelperLogging': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'VsCodeHelper': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'VsProgress': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'FileBatch': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'VSCodeUri': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'WorkspaceFolder': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'TextDocument': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'Position': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'Range': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'Selection': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'TextEditor': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'QuickPickItem': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'InputBoxOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'MessageOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'TerminalOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'FileSystemWatcherOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
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
      'package:tom_vscode_scripting_api/src/vscode.dart',
      'package:tom_vscode_scripting_api/src/vscode_adapter.dart',
      'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart',
      'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart',
      'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'package:tom_vscode_scripting_api/src/vscode_commands.dart',
      'package:tom_vscode_scripting_api/src/vscode_extensions.dart',
      'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'package:tom_vscode_scripting_api/src/vscode_window.dart',
      'package:tom_vscode_scripting_api/src/vscode_workspace.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:tom_vscode_scripting_api/script_globals.dart';";
  }

}

// =============================================================================
// VSCodeAdapter Bridge
// =============================================================================

BridgedClass _createVSCodeAdapterBridge() {
  return BridgedClass(
    nativeType: $pkg.VSCodeAdapter,
    name: 'VSCodeAdapter',
    constructors: {
    },
    methods: {
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeAdapter>(target, 'VSCodeAdapter');
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
    nativeType: $pkg.VSCodeBridgeResult,
    name: 'VSCodeBridgeResult',
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<dynamic>(named, 'success', 'VSCodeBridgeResult');
        final value = D4.getOptionalNamedArg<dynamic>(named, 'value');
        final output = D4.getNamedArgWithDefault<dynamic>(named, 'output', '');
        final error = D4.getOptionalNamedArg<dynamic>(named, 'error');
        final stackTrace = D4.getOptionalNamedArg<dynamic>(named, 'stackTrace');
        final exception = D4.getOptionalNamedArg<dynamic>(named, 'exception');
        final exceptionStackTrace = D4.getOptionalNamedArg<dynamic>(named, 'exceptionStackTrace');
        final duration = D4.getRequiredNamedArg<dynamic>(named, 'duration', 'VSCodeBridgeResult');
        return $pkg.VSCodeBridgeResult(success: success, value: value, output: output, error: error, stackTrace: stackTrace, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration);
      },
      'success': (visitor, positional, named) {
        final value = D4.getOptionalNamedArg<dynamic>(named, 'value');
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final exception = D4.getOptionalNamedArg<String?>(named, 'exception');
        final exceptionStackTrace = D4.getOptionalNamedArg<String?>(named, 'exceptionStackTrace');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        return $pkg.VSCodeBridgeResult.success(value: value, output: output, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration);
      },
      'failure': (visitor, positional, named) {
        final error = D4.getRequiredNamedArg<String>(named, 'error', 'VSCodeBridgeResult');
        final stackTrace = D4.getOptionalNamedArg<String?>(named, 'stackTrace');
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        return $pkg.VSCodeBridgeResult.failure(error: error, stackTrace: stackTrace, output: output, duration: duration);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').success,
      'value': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').value,
      'output': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').output,
      'error': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').error,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').stackTrace,
      'exception': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').exception,
      'exceptionStackTrace': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').exceptionStackTrace,
      'duration': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').duration,
      'hasException': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').hasException,
    },
    constructorSignatures: {
      '': 'const VSCodeBridgeResult({required dynamic success, dynamic value, dynamic output = \'\', dynamic error, dynamic stackTrace, dynamic exception, dynamic exceptionStackTrace, required dynamic duration})',
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
    nativeType: $pkg.VSCodeBridgeClient,
    name: 'VSCodeBridgeClient',
    constructors: {
      '': (visitor, positional, named) {
        final host = D4.getNamedArgWithDefault<dynamic>(named, 'host', '127.0.0.1');
        final connectTimeout = D4.getNamedArgWithDefault<dynamic>(named, 'connectTimeout', const Duration(seconds: 5));
        final requestTimeout = D4.getNamedArgWithDefault<dynamic>(named, 'requestTimeout', const Duration(seconds: 30));
        if (!named.containsKey('port')) {
          return $pkg.VSCodeBridgeClient(host: host, connectTimeout: connectTimeout, requestTimeout: requestTimeout);
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<dynamic>(named, 'port', 'VSCodeBridgeClient');
          return $pkg.VSCodeBridgeClient(host: host, connectTimeout: connectTimeout, requestTimeout: requestTimeout, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'host': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').host,
      'port': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').port,
      'connectTimeout': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').connectTimeout,
      'requestTimeout': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').requestTimeout,
      'isConnected': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').isConnected,
    },
    methods: {
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        return t.connect();
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        return t.disconnect();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        return t.sendRequest(method, params);
      },
      'executeExpression': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeExpression');
        final expression = D4.getRequiredArg<String>(positional, 0, 'expression', 'executeExpression');
        return t.executeExpression(expression);
      },
      'executeScriptFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeScriptFile');
        final filePath = D4.getRequiredArg<String>(positional, 0, 'filePath', 'executeScriptFile');
        return t.executeScriptFile(filePath);
      },
      'executeScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeScript');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'executeScript');
        return t.executeScript(code);
      },
    },
    staticMethods: {
      'isAvailable': (visitor, positional, named, typeArgs) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        if (!named.containsKey('port')) {
          return $pkg.VSCodeBridgeClient.isAvailable(host: host);
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'isAvailable');
          return $pkg.VSCodeBridgeClient.isAvailable(host: host, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    constructorSignatures: {
      '': 'VSCodeBridgeClient({dynamic host = \'127.0.0.1\', dynamic port = defaultVSCodeBridgePort, dynamic connectTimeout = const Duration(seconds: 5), dynamic requestTimeout = const Duration(seconds: 30)})',
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
    nativeType: $pkg.VSCodeBridgeAdapter,
    name: 'VSCodeBridgeAdapter',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeBridgeAdapter');
        final client = D4.getRequiredArg<dynamic>(positional, 0, 'client', 'VSCodeBridgeAdapter');
        return $pkg.VSCodeBridgeAdapter(client);
      },
    },
    getters: {
      'client': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter').client,
      'isConnected': (visitor, target) => D4.validateTarget<$pkg.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter').isConnected,
    },
    methods: {
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter');
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
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter');
        return t.disconnect();
      },
    },
    constructorSignatures: {
      '': 'VSCodeBridgeAdapter(dynamic client)',
    },
    methodSignatures: {
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params, {String? scriptName, Duration timeout = const Duration(seconds: 60)})',
      'disconnect': 'Future<void> disconnect()',
    },
    getterSignatures: {
      'client': 'VSCodeBridgeClient get client',
      'isConnected': 'bool get isConnected',
    },
  );
}

// =============================================================================
// LazyVSCodeBridgeAdapter Bridge
// =============================================================================

BridgedClass _createLazyVSCodeBridgeAdapterBridge() {
  return BridgedClass(
    nativeType: $pkg.LazyVSCodeBridgeAdapter,
    name: 'LazyVSCodeBridgeAdapter',
    constructors: {
      '': (visitor, positional, named) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        final onStatusMessage = D4.getOptionalNamedArg<dynamic>(named, 'onStatusMessage');
        final onErrorMessage = D4.getOptionalNamedArg<dynamic>(named, 'onErrorMessage');
        if (!named.containsKey('port')) {
          return $pkg.LazyVSCodeBridgeAdapter(host: host, onStatusMessage: onStatusMessage, onErrorMessage: onErrorMessage);
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'LazyVSCodeBridgeAdapter');
          return $pkg.LazyVSCodeBridgeAdapter(host: host, onStatusMessage: onStatusMessage, onErrorMessage: onErrorMessage, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onStatusMessage': (visitor, target) => D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').onStatusMessage,
      'onErrorMessage': (visitor, target) => D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').onErrorMessage,
      'host': (visitor, target) => D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').host,
      'port': (visitor, target) => D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').port,
      'isConnected': (visitor, target) => D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').isConnected,
    },
    methods: {
      'setHostPort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 2, 'setHostPort');
        final host = D4.getRequiredArg<String>(positional, 0, 'host', 'setHostPort');
        final port = D4.getRequiredArg<int>(positional, 1, 'port', 'setHostPort');
        return t.setHostPort(host, port);
      },
      'setPort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 1, 'setPort');
        final port = D4.getRequiredArg<int>(positional, 0, 'port', 'setPort');
        return t.setPort(port);
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        return t.connect();
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        return t.disconnect();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
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
      '': 'LazyVSCodeBridgeAdapter({String host = \'127.0.0.1\', int port = defaultVSCodeBridgePort, dynamic onStatusMessage, dynamic onErrorMessage})',
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
    nativeType: $pkg.VSCode,
    name: 'VSCode',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.VSCode();
      },
    },
    getters: {
      'workspace': (visitor, target) => D4.validateTarget<$pkg.VSCode>(target, 'VSCode').workspace,
      'window': (visitor, target) => D4.validateTarget<$pkg.VSCode>(target, 'VSCode').window,
      'commands': (visitor, target) => D4.validateTarget<$pkg.VSCode>(target, 'VSCode').commands,
      'extensions': (visitor, target) => D4.validateTarget<$pkg.VSCode>(target, 'VSCode').extensions,
      'lm': (visitor, target) => D4.validateTarget<$pkg.VSCode>(target, 'VSCode').lm,
      'chat': (visitor, target) => D4.validateTarget<$pkg.VSCode>(target, 'VSCode').chat,
      'adapter': (visitor, target) => D4.validateTarget<$pkg.VSCode>(target, 'VSCode').adapter,
    },
    setters: {
      'workspace': (visitor, target, value) => 
        D4.validateTarget<$pkg.VSCode>(target, 'VSCode').workspace = value as dynamic,
      'window': (visitor, target, value) => 
        D4.validateTarget<$pkg.VSCode>(target, 'VSCode').window = value as dynamic,
      'commands': (visitor, target, value) => 
        D4.validateTarget<$pkg.VSCode>(target, 'VSCode').commands = value as dynamic,
      'extensions': (visitor, target, value) => 
        D4.validateTarget<$pkg.VSCode>(target, 'VSCode').extensions = value as dynamic,
      'lm': (visitor, target, value) => 
        D4.validateTarget<$pkg.VSCode>(target, 'VSCode').lm = value as dynamic,
      'chat': (visitor, target, value) => 
        D4.validateTarget<$pkg.VSCode>(target, 'VSCode').chat = value as dynamic,
    },
    methods: {
      'getVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.getVersion(timeoutSeconds: timeoutSeconds);
      },
      'getEnv': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.getEnv(timeoutSeconds: timeoutSeconds);
      },
      'openExternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCode>(target, 'VSCode');
        D4.requireMinArgs(positional, 1, 'openExternal');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'openExternal');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.openExternal(uri, timeoutSeconds: timeoutSeconds);
      },
      'copyToClipboard': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCode>(target, 'VSCode');
        D4.requireMinArgs(positional, 1, 'copyToClipboard');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'copyToClipboard');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.copyToClipboard(text, timeoutSeconds: timeoutSeconds);
      },
      'readFromClipboard': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.readFromClipboard(timeoutSeconds: timeoutSeconds);
      },
    },
    staticGetters: {
      'instance': (visitor) => $pkg.VSCode.instance,
      'isInitialized': (visitor) => $pkg.VSCode.isInitialized,
    },
    staticMethods: {
      'initialize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'initialize');
        final adapter = D4.getRequiredArg<$pkg.VSCodeAdapter>(positional, 0, 'adapter', 'initialize');
        return $pkg.VSCode.initialize(adapter);
      },
    },
    constructorSignatures: {
      '': 'VSCode()',
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
    nativeType: $pkg.VSCodeCommands,
    name: 'VSCodeCommands',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeCommands');
        final adapter = D4.getRequiredArg<dynamic>(positional, 0, '_adapter', 'VSCodeCommands');
        return $pkg.VSCodeCommands(adapter);
      },
    },
    methods: {
      'executeCommand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeCommands>(target, 'VSCodeCommands');
        D4.requireMinArgs(positional, 1, 'executeCommand');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'executeCommand');
        final args = D4.coerceListOrNull<dynamic>(named['args'], 'args');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.executeCommand(command, args: args, timeoutSeconds: timeoutSeconds);
      },
      'getCommands': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeCommands>(target, 'VSCodeCommands');
        final filterInternal = D4.getNamedArgWithDefault<bool>(named, 'filterInternal', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getCommands(filterInternal: filterInternal, timeoutSeconds: timeoutSeconds);
      },
      'registerCommand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeCommands>(target, 'VSCodeCommands');
        D4.requireMinArgs(positional, 2, 'registerCommand');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'registerCommand');
        final handlerScript = D4.getRequiredArg<String>(positional, 1, 'handlerScript', 'registerCommand');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.registerCommand(command, handlerScript, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeCommands(dynamic _adapter)',
    },
    methodSignatures: {
      'executeCommand': 'Future<dynamic> executeCommand(String command, {List<dynamic>? args, int timeoutSeconds = 120})',
      'getCommands': 'Future<List<String>> getCommands({bool filterInternal = false, int timeoutSeconds = 60})',
      'registerCommand': 'Future<bool> registerCommand(String command, String handlerScript, {int timeoutSeconds = 120})',
    },
  );
}

// =============================================================================
// VSCodeCommonCommands Bridge
// =============================================================================

BridgedClass _createVSCodeCommonCommandsBridge() {
  return BridgedClass(
    nativeType: $pkg.VSCodeCommonCommands,
    name: 'VSCodeCommonCommands',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.VSCodeCommonCommands();
      },
    },
    staticGetters: {
      'openFile': (visitor) => $pkg.VSCodeCommonCommands.openFile,
      'openFolder': (visitor) => $pkg.VSCodeCommonCommands.openFolder,
      'newUntitledFile': (visitor) => $pkg.VSCodeCommonCommands.newUntitledFile,
      'saveFile': (visitor) => $pkg.VSCodeCommonCommands.saveFile,
      'saveAllFiles': (visitor) => $pkg.VSCodeCommonCommands.saveAllFiles,
      'closeActiveEditor': (visitor) => $pkg.VSCodeCommonCommands.closeActiveEditor,
      'showCommands': (visitor) => $pkg.VSCodeCommonCommands.showCommands,
      'quickOpen': (visitor) => $pkg.VSCodeCommonCommands.quickOpen,
      'goToFile': (visitor) => $pkg.VSCodeCommonCommands.goToFile,
      'goToSymbol': (visitor) => $pkg.VSCodeCommonCommands.goToSymbol,
      'goToLine': (visitor) => $pkg.VSCodeCommonCommands.goToLine,
      'findInFiles': (visitor) => $pkg.VSCodeCommonCommands.findInFiles,
      'replaceInFiles': (visitor) => $pkg.VSCodeCommonCommands.replaceInFiles,
      'toggleTerminal': (visitor) => $pkg.VSCodeCommonCommands.toggleTerminal,
      'newTerminal': (visitor) => $pkg.VSCodeCommonCommands.newTerminal,
      'toggleSidebar': (visitor) => $pkg.VSCodeCommonCommands.toggleSidebar,
      'togglePanel': (visitor) => $pkg.VSCodeCommonCommands.togglePanel,
      'formatDocument': (visitor) => $pkg.VSCodeCommonCommands.formatDocument,
      'organizeImports': (visitor) => $pkg.VSCodeCommonCommands.organizeImports,
      'renameSymbol': (visitor) => $pkg.VSCodeCommonCommands.renameSymbol,
      'goToDefinition': (visitor) => $pkg.VSCodeCommonCommands.goToDefinition,
      'goToReferences': (visitor) => $pkg.VSCodeCommonCommands.goToReferences,
      'showHover': (visitor) => $pkg.VSCodeCommonCommands.showHover,
      'commentLine': (visitor) => $pkg.VSCodeCommonCommands.commentLine,
      'copyLineDown': (visitor) => $pkg.VSCodeCommonCommands.copyLineDown,
      'moveLineDown': (visitor) => $pkg.VSCodeCommonCommands.moveLineDown,
      'deleteLine': (visitor) => $pkg.VSCodeCommonCommands.deleteLine,
      'reloadWindow': (visitor) => $pkg.VSCodeCommonCommands.reloadWindow,
      'showExtensions': (visitor) => $pkg.VSCodeCommonCommands.showExtensions,
      'installExtension': (visitor) => $pkg.VSCodeCommonCommands.installExtension,
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
    nativeType: $pkg.Extension,
    name: 'Extension',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<dynamic>(named, 'id', 'Extension');
        final extensionUri = D4.getRequiredNamedArg<dynamic>(named, 'extensionUri', 'Extension');
        final extensionPath = D4.getRequiredNamedArg<dynamic>(named, 'extensionPath', 'Extension');
        final isActive = D4.getRequiredNamedArg<dynamic>(named, 'isActive', 'Extension');
        final packageJSON = D4.getRequiredNamedArg<dynamic>(named, 'packageJSON', 'Extension');
        final extensionKind = D4.getOptionalNamedArg<dynamic>(named, 'extensionKind');
        return $pkg.Extension(id: id, extensionUri: extensionUri, extensionPath: extensionPath, isActive: isActive, packageJSON: packageJSON, extensionKind: extensionKind);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Extension');
        if (positional.isEmpty) {
          throw ArgumentError('Extension: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.Extension.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$pkg.Extension>(target, 'Extension').id,
      'extensionUri': (visitor, target) => D4.validateTarget<$pkg.Extension>(target, 'Extension').extensionUri,
      'extensionPath': (visitor, target) => D4.validateTarget<$pkg.Extension>(target, 'Extension').extensionPath,
      'isActive': (visitor, target) => D4.validateTarget<$pkg.Extension>(target, 'Extension').isActive,
      'packageJSON': (visitor, target) => D4.validateTarget<$pkg.Extension>(target, 'Extension').packageJSON,
      'extensionKind': (visitor, target) => D4.validateTarget<$pkg.Extension>(target, 'Extension').extensionKind,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Extension>(target, 'Extension');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Extension({required dynamic id, required dynamic extensionUri, required dynamic extensionPath, required dynamic isActive, required dynamic packageJSON, dynamic extensionKind})',
      'fromJson': 'factory Extension.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'extensionUri': 'String get extensionUri',
      'extensionPath': 'String get extensionPath',
      'isActive': 'bool get isActive',
      'packageJSON': 'Map<String, dynamic> get packageJSON',
      'extensionKind': 'String? get extensionKind',
    },
  );
}

// =============================================================================
// VSCodeExtensions Bridge
// =============================================================================

BridgedClass _createVSCodeExtensionsBridge() {
  return BridgedClass(
    nativeType: $pkg.VSCodeExtensions,
    name: 'VSCodeExtensions',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeExtensions');
        final adapter = D4.getRequiredArg<dynamic>(positional, 0, '_adapter', 'VSCodeExtensions');
        return $pkg.VSCodeExtensions(adapter);
      },
    },
    methods: {
      'getAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getAll(timeoutSeconds: timeoutSeconds);
      },
      'getExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtension');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtension');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtension(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'isInstalled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'isInstalled');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'isInstalled');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.isInstalled(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionExports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionExports');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionExports');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.getExtensionExports(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'activateExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'activateExtension');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'activateExtension');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return t.activateExtension(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionVersion');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionVersion');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionVersion(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionDisplayName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionDisplayName');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionDisplayName');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionDisplayName(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionDescription');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionDescription');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionDescription(extensionId, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeExtensions(dynamic _adapter)',
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
    nativeType: $pkg.VSCodeLanguageModel,
    name: 'VSCodeLanguageModel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeLanguageModel');
        final adapter = D4.getRequiredArg<dynamic>(positional, 0, '_adapter', 'VSCodeLanguageModel');
        return $pkg.VSCodeLanguageModel(adapter);
      },
    },
    methods: {
      'selectChatModels': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        final vendor = D4.getOptionalNamedArg<String?>(named, 'vendor');
        final family = D4.getOptionalNamedArg<String?>(named, 'family');
        final id = D4.getOptionalNamedArg<String?>(named, 'id');
        final version = D4.getOptionalNamedArg<String?>(named, 'version');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.selectChatModels(vendor: vendor, family: family, id: id, version: version, timeoutSeconds: timeoutSeconds);
      },
      'invokeTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        D4.requireMinArgs(positional, 2, 'invokeTool');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeTool');
        if (positional.length <= 1) {
          throw ArgumentError('invokeTool: Missing required argument "options" at position 1');
        }
        final options = D4.coerceMap<String, dynamic>(positional[1], 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return t.invokeTool(name, options, timeoutSeconds: timeoutSeconds);
      },
      'registerTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        D4.requireMinArgs(positional, 2, 'registerTool');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerTool');
        if (positional.length <= 1) {
          throw ArgumentError('registerTool: Missing required argument "tool" at position 1');
        }
        final tool = D4.coerceMap<String, dynamic>(positional[1], 'tool');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.registerTool(name, tool, timeoutSeconds: timeoutSeconds);
      },
      'getTools': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getTools(timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeLanguageModel(dynamic _adapter)',
    },
    methodSignatures: {
      'selectChatModels': 'Future<List<LanguageModelChat>> selectChatModels({String? vendor, String? family, String? id, String? version, int timeoutSeconds = 60})',
      'invokeTool': 'Future<LanguageModelToolResult> invokeTool(String name, Map<String, dynamic> options, {int timeoutSeconds = 300})',
      'registerTool': 'Future<void> registerTool(String name, Map<String, dynamic> tool, {int timeoutSeconds = 120})',
      'getTools': 'Future<List<LanguageModelToolInformation>> getTools({int timeoutSeconds = 60})',
    },
  );
}

// =============================================================================
// LanguageModelChat Bridge
// =============================================================================

BridgedClass _createLanguageModelChatBridge() {
  return BridgedClass(
    nativeType: $pkg.LanguageModelChat,
    name: 'LanguageModelChat',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<dynamic>(named, 'id', 'LanguageModelChat');
        final vendor = D4.getRequiredNamedArg<dynamic>(named, 'vendor', 'LanguageModelChat');
        final family = D4.getRequiredNamedArg<dynamic>(named, 'family', 'LanguageModelChat');
        final version = D4.getRequiredNamedArg<dynamic>(named, 'version', 'LanguageModelChat');
        final name = D4.getRequiredNamedArg<dynamic>(named, 'name', 'LanguageModelChat');
        final maxInputTokens = D4.getRequiredNamedArg<dynamic>(named, 'maxInputTokens', 'LanguageModelChat');
        return $pkg.LanguageModelChat(id: id, vendor: vendor, family: family, version: version, name: name, maxInputTokens: maxInputTokens);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChat');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChat: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.LanguageModelChat.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat').id,
      'vendor': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat').vendor,
      'family': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat').family,
      'version': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat').version,
      'name': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat').name,
      'maxInputTokens': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat').maxInputTokens,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat');
        return t.toJson();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final adapter = D4.getRequiredArg<$pkg.VSCodeAdapter>(positional, 0, 'adapter', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "messages" at position 1');
        }
        final messages = D4.coerceList<$pkg.LanguageModelChatMessage>(positional[1], 'messages');
        final modelOptions = D4.coerceMapOrNull<String, dynamic>(named['modelOptions'], 'modelOptions');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return t.sendRequest(adapter, messages, modelOptions: modelOptions, timeoutSeconds: timeoutSeconds);
      },
      'countTokens': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LanguageModelChat>(target, 'LanguageModelChat');
        D4.requireMinArgs(positional, 2, 'countTokens');
        final adapter = D4.getRequiredArg<$pkg.VSCodeAdapter>(positional, 0, 'adapter', 'countTokens');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'countTokens');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.countTokens(adapter, text, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChat({required dynamic id, required dynamic vendor, required dynamic family, required dynamic version, required dynamic name, required dynamic maxInputTokens})',
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
    nativeType: $pkg.LanguageModelChatMessage,
    name: 'LanguageModelChatMessage',
    constructors: {
      '': (visitor, positional, named) {
        final role = D4.getRequiredNamedArg<dynamic>(named, 'role', 'LanguageModelChatMessage');
        final content = D4.getRequiredNamedArg<dynamic>(named, 'content', 'LanguageModelChatMessage');
        final name = D4.getOptionalNamedArg<dynamic>(named, 'name');
        return $pkg.LanguageModelChatMessage(role: role, content: content, name: name);
      },
      'user': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatMessage');
        final content = D4.getRequiredArg<String>(positional, 0, 'content', 'LanguageModelChatMessage');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        return $pkg.LanguageModelChatMessage.user(content, name: name);
      },
      'assistant': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatMessage');
        final content = D4.getRequiredArg<String>(positional, 0, 'content', 'LanguageModelChatMessage');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        return $pkg.LanguageModelChatMessage.assistant(content, name: name);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatMessage');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChatMessage: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.LanguageModelChatMessage.fromJson(json);
      },
    },
    getters: {
      'role': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChatMessage>(target, 'LanguageModelChatMessage').role,
      'content': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChatMessage>(target, 'LanguageModelChatMessage').content,
      'name': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChatMessage>(target, 'LanguageModelChatMessage').name,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LanguageModelChatMessage>(target, 'LanguageModelChatMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChatMessage({required dynamic role, required dynamic content, dynamic name})',
      'user': 'factory LanguageModelChatMessage.user(String content, {String? name})',
      'assistant': 'factory LanguageModelChatMessage.assistant(String content, {String? name})',
      'fromJson': 'factory LanguageModelChatMessage.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'role': 'String get role',
      'content': 'String get content',
      'name': 'String? get name',
    },
  );
}

// =============================================================================
// LanguageModelChatResponse Bridge
// =============================================================================

BridgedClass _createLanguageModelChatResponseBridge() {
  return BridgedClass(
    nativeType: $pkg.LanguageModelChatResponse,
    name: 'LanguageModelChatResponse',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<dynamic>(named, 'text', 'LanguageModelChatResponse');
        final streamParts = D4.getRequiredNamedArg<dynamic>(named, 'streamParts', 'LanguageModelChatResponse');
        return $pkg.LanguageModelChatResponse(text: text, streamParts: streamParts);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatResponse');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChatResponse: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.LanguageModelChatResponse.fromJson(json);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChatResponse>(target, 'LanguageModelChatResponse').text,
      'streamParts': (visitor, target) => D4.validateTarget<$pkg.LanguageModelChatResponse>(target, 'LanguageModelChatResponse').streamParts,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LanguageModelChatResponse>(target, 'LanguageModelChatResponse');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChatResponse({required dynamic text, required dynamic streamParts})',
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
    nativeType: $pkg.LanguageModelToolResult,
    name: 'LanguageModelToolResult',
    constructors: {
      '': (visitor, positional, named) {
        final content = D4.getRequiredNamedArg<dynamic>(named, 'content', 'LanguageModelToolResult');
        return $pkg.LanguageModelToolResult(content: content);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelToolResult');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelToolResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.LanguageModelToolResult.fromJson(json);
      },
    },
    getters: {
      'content': (visitor, target) => D4.validateTarget<$pkg.LanguageModelToolResult>(target, 'LanguageModelToolResult').content,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LanguageModelToolResult>(target, 'LanguageModelToolResult');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelToolResult({required dynamic content})',
      'fromJson': 'factory LanguageModelToolResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'content': 'List<dynamic> get content',
    },
  );
}

// =============================================================================
// LanguageModelToolInformation Bridge
// =============================================================================

BridgedClass _createLanguageModelToolInformationBridge() {
  return BridgedClass(
    nativeType: $pkg.LanguageModelToolInformation,
    name: 'LanguageModelToolInformation',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<dynamic>(named, 'name', 'LanguageModelToolInformation');
        final description = D4.getRequiredNamedArg<dynamic>(named, 'description', 'LanguageModelToolInformation');
        final inputSchema = D4.getRequiredNamedArg<dynamic>(named, 'inputSchema', 'LanguageModelToolInformation');
        return $pkg.LanguageModelToolInformation(name: name, description: description, inputSchema: inputSchema);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelToolInformation');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelToolInformation: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.LanguageModelToolInformation.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').name,
      'description': (visitor, target) => D4.validateTarget<$pkg.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').description,
      'inputSchema': (visitor, target) => D4.validateTarget<$pkg.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').inputSchema,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LanguageModelToolInformation>(target, 'LanguageModelToolInformation');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelToolInformation({required dynamic name, required dynamic description, required dynamic inputSchema})',
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
    nativeType: $pkg.VSCodeWindow,
    name: 'VSCodeWindow',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeWindow');
        final adapter = D4.getRequiredArg<dynamic>(positional, 0, '_adapter', 'VSCodeWindow');
        return $pkg.VSCodeWindow(adapter);
      },
    },
    methods: {
      'showInformationMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showInformationMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showInformationMessage');
        final items = D4.coerceListOrNull<String>(named['items'], 'items');
        final options = D4.getOptionalNamedArg<$pkg.MessageOptions?>(named, 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 5 * 60);
        return t.showInformationMessage(message, items: items, options: options, timeoutSeconds: timeoutSeconds);
      },
      'showWarningMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showWarningMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showWarningMessage');
        final items = D4.coerceListOrNull<String>(named['items'], 'items');
        final options = D4.getOptionalNamedArg<$pkg.MessageOptions?>(named, 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 5 * 60);
        return t.showWarningMessage(message, items: items, options: options, timeoutSeconds: timeoutSeconds);
      },
      'showErrorMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showErrorMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showErrorMessage');
        final items = D4.coerceListOrNull<String>(named['items'], 'items');
        final options = D4.getOptionalNamedArg<$pkg.MessageOptions?>(named, 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 5 * 60);
        return t.showErrorMessage(message, items: items, options: options, timeoutSeconds: timeoutSeconds);
      },
      'showQuickPick': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showQuickPick');
        if (positional.isEmpty) {
          throw ArgumentError('showQuickPick: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<String>(positional[0], 'items');
        final placeHolder = D4.getOptionalNamedArg<String?>(named, 'placeHolder');
        final canPickMany = D4.getNamedArgWithDefault<bool>(named, 'canPickMany', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return t.showQuickPick(items, placeHolder: placeHolder, canPickMany: canPickMany, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'showInputBox': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        final prompt = D4.getOptionalNamedArg<String?>(named, 'prompt');
        final placeHolder = D4.getOptionalNamedArg<String?>(named, 'placeHolder');
        final value = D4.getOptionalNamedArg<String?>(named, 'value');
        final password = D4.getNamedArgWithDefault<bool>(named, 'password', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return t.showInputBox(prompt: prompt, placeHolder: placeHolder, value: value, password: password, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'getActiveTextEditor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        return t.getActiveTextEditor();
      },
      'showTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'showTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10 * 60);
        return t.showTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'createOutputChannel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'createOutputChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'createOutputChannel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.createOutputChannel(name, timeoutSeconds: timeoutSeconds);
      },
      'appendToOutputChannel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 2, 'appendToOutputChannel');
        final channelName = D4.getRequiredArg<String>(positional, 0, 'channelName', 'appendToOutputChannel');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'appendToOutputChannel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.appendToOutputChannel(channelName, text, timeoutSeconds: timeoutSeconds);
      },
      'showOutputChannel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showOutputChannel');
        final channelName = D4.getRequiredArg<String>(positional, 0, 'channelName', 'showOutputChannel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.showOutputChannel(channelName, timeoutSeconds: timeoutSeconds);
      },
      'createTerminal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final shellPath = D4.getOptionalNamedArg<String?>(named, 'shellPath');
        final shellArgs = D4.coerceListOrNull<String>(named['shellArgs'], 'shellArgs');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.createTerminal(name: name, shellPath: shellPath, shellArgs: shellArgs, timeoutSeconds: timeoutSeconds);
      },
      'sendTextToTerminal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 2, 'sendTextToTerminal');
        final terminalName = D4.getRequiredArg<String>(positional, 0, 'terminalName', 'sendTextToTerminal');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'sendTextToTerminal');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.sendTextToTerminal(terminalName, text, timeoutSeconds: timeoutSeconds);
      },
      'showTerminal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showTerminal');
        final terminalName = D4.getRequiredArg<String>(positional, 0, 'terminalName', 'showTerminal');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.showTerminal(terminalName, timeoutSeconds: timeoutSeconds);
      },
      'setStatusBarMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'setStatusBarMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'setStatusBarMessage');
        final timeout = D4.getOptionalNamedArg<int?>(named, 'timeout');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.setStatusBarMessage(message, timeout: timeout, timeoutSeconds: timeoutSeconds);
      },
      'showSaveDialog': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        final defaultUri = D4.getOptionalNamedArg<String?>(named, 'defaultUri');
        final filters = D4.coerceMapOrNull<String, List<String>>(named['filters'], 'filters');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        return t.showSaveDialog(defaultUri: defaultUri, filters: filters, title: title, timeoutSeconds: timeoutSeconds);
      },
      'showOpenDialog': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWindow>(target, 'VSCodeWindow');
        final canSelectFiles = D4.getNamedArgWithDefault<bool>(named, 'canSelectFiles', true);
        final canSelectFolders = D4.getNamedArgWithDefault<bool>(named, 'canSelectFolders', false);
        final canSelectMany = D4.getNamedArgWithDefault<bool>(named, 'canSelectMany', false);
        final defaultUri = D4.getOptionalNamedArg<String?>(named, 'defaultUri');
        final filters = D4.coerceMapOrNull<String, List<String>>(named['filters'], 'filters');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        return t.showOpenDialog(canSelectFiles: canSelectFiles, canSelectFolders: canSelectFolders, canSelectMany: canSelectMany, defaultUri: defaultUri, filters: filters, title: title, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeWindow(dynamic _adapter)',
    },
    methodSignatures: {
      'showInformationMessage': 'Future<String?> showInformationMessage(String message, {List<String>? items, MessageOptions? options, int timeoutSeconds = 5 * 60})',
      'showWarningMessage': 'Future<String?> showWarningMessage(String message, {List<String>? items, MessageOptions? options, int timeoutSeconds = 5 * 60})',
      'showErrorMessage': 'Future<String?> showErrorMessage(String message, {List<String>? items, MessageOptions? options, int timeoutSeconds = 5 * 60})',
      'showQuickPick': 'Future<String?> showQuickPick(List<String> items, {String? placeHolder, bool canPickMany = false, int timeoutSeconds = 30 * 60, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'showInputBox': 'Future<String?> showInputBox({String? prompt, String? placeHolder, String? value, bool password = false, int timeoutSeconds = 30 * 60, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'getActiveTextEditor': 'Future<TextEditor?> getActiveTextEditor()',
      'showTextDocument': 'Future<TextEditor?> showTextDocument(String path, {int timeoutSeconds = 10 * 60})',
      'createOutputChannel': 'Future<String> createOutputChannel(String name, {int timeoutSeconds = 30})',
      'appendToOutputChannel': 'Future<void> appendToOutputChannel(String channelName, String text, {int timeoutSeconds = 30})',
      'showOutputChannel': 'Future<void> showOutputChannel(String channelName, {int timeoutSeconds = 30})',
      'createTerminal': 'Future<String> createTerminal({String? name, String? shellPath, List<String>? shellArgs, int timeoutSeconds = 120})',
      'sendTextToTerminal': 'Future<void> sendTextToTerminal(String terminalName, String text, {int timeoutSeconds = 120})',
      'showTerminal': 'Future<void> showTerminal(String terminalName, {int timeoutSeconds = 120})',
      'setStatusBarMessage': 'Future<void> setStatusBarMessage(String message, {int? timeout, int timeoutSeconds = 120})',
      'showSaveDialog': 'Future<String?> showSaveDialog({String? defaultUri, Map<String, List<String>>? filters, String? title, int timeoutSeconds = 30 * 60})',
      'showOpenDialog': 'Future<List<String>> showOpenDialog({bool canSelectFiles = true, bool canSelectFolders = false, bool canSelectMany = false, String? defaultUri, Map<String, List<String>>? filters, String? title, int timeoutSeconds = 30 * 60})',
    },
  );
}

// =============================================================================
// VSCodeWorkspace Bridge
// =============================================================================

BridgedClass _createVSCodeWorkspaceBridge() {
  return BridgedClass(
    nativeType: $pkg.VSCodeWorkspace,
    name: 'VSCodeWorkspace',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeWorkspace');
        final adapter = D4.getRequiredArg<dynamic>(positional, 0, '_adapter', 'VSCodeWorkspace');
        return $pkg.VSCodeWorkspace(adapter);
      },
    },
    methods: {
      'getWorkspaceFolders': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.getWorkspaceFolders(timeoutSeconds: timeoutSeconds);
      },
      'getWorkspaceFolder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'getWorkspaceFolder');
        final uri = D4.getRequiredArg<$pkg.VSCodeUri>(positional, 0, 'uri', 'getWorkspaceFolder');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.getWorkspaceFolder(uri, timeoutSeconds: timeoutSeconds);
      },
      'openTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'openTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'openTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.openTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'saveTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'saveTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'saveTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.saveTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'findFiles': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'findFiles');
        final include = D4.getRequiredArg<String>(positional, 0, 'include', 'findFiles');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.findFiles(include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'findFilePaths': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        final include = D4.getRequiredNamedArg<String>(named, 'include', 'findFilePaths');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.findFilePaths(include: include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'getConfiguration': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'getConfiguration');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'getConfiguration');
        final scope = D4.getOptionalNamedArg<String?>(named, 'scope');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getConfiguration(section, scope: scope, timeoutSeconds: timeoutSeconds);
      },
      'updateConfiguration': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 3, 'updateConfiguration');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'updateConfiguration');
        final key = D4.getRequiredArg<String>(positional, 1, 'key', 'updateConfiguration');
        final value = D4.getRequiredArg<dynamic>(positional, 2, 'value', 'updateConfiguration');
        final global = D4.getNamedArgWithDefault<bool>(named, 'global', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.updateConfiguration(section, key, value, global: global, timeoutSeconds: timeoutSeconds);
      },
      'getRootPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        return t.getRootPath();
      },
      'getWorkspaceName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        return t.getWorkspaceName();
      },
      'readFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'readFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readFile');
        return t.readFile(path);
      },
      'writeFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 2, 'writeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'writeFile');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'writeFile');
        return t.writeFile(path, content);
      },
      'deleteFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'deleteFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'deleteFile');
        return t.deleteFile(path);
      },
      'fileExists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'fileExists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'fileExists');
        return t.fileExists(path);
      },
    },
    constructorSignatures: {
      '': 'VSCodeWorkspace(dynamic _adapter)',
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
    nativeType: $pkg.VSCodeChat,
    name: 'VSCodeChat',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeChat');
        final adapter = D4.getRequiredArg<dynamic>(positional, 0, '_adapter', 'VSCodeChat');
        return $pkg.VSCodeChat(adapter);
      },
    },
    methods: {
      'createChatParticipant': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeChat>(target, 'VSCodeChat');
        D4.requireMinArgs(positional, 1, 'createChatParticipant');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'createChatParticipant');
        final handler = D4.getRequiredNamedArg<dynamic>(named, 'handler', 'createChatParticipant');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final fullName = D4.getOptionalNamedArg<String?>(named, 'fullName');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return t.createChatParticipant(id, handler: handler, description: description, fullName: fullName, timeoutSeconds: timeoutSeconds);
      },
    },
    staticMethods: {
      'handleChatRequest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'handleChatRequest');
        if (positional.isEmpty) {
          throw ArgumentError('handleChatRequest: Missing required argument "params" at position 0');
        }
        final params = D4.coerceMap<String, dynamic>(positional[0], 'params');
        return $pkg.VSCodeChat.handleChatRequest(params);
      },
    },
    constructorSignatures: {
      '': 'VSCodeChat(dynamic _adapter)',
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
    nativeType: $pkg.ChatParticipant,
    name: 'ChatParticipant',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<dynamic>(named, 'id', 'ChatParticipant');
        final description = D4.getOptionalNamedArg<dynamic>(named, 'description');
        final fullName = D4.getOptionalNamedArg<dynamic>(named, 'fullName');
        return $pkg.ChatParticipant(id: id, description: description, fullName: fullName);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatParticipant');
        if (positional.isEmpty) {
          throw ArgumentError('ChatParticipant: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.ChatParticipant.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$pkg.ChatParticipant>(target, 'ChatParticipant').id,
      'description': (visitor, target) => D4.validateTarget<$pkg.ChatParticipant>(target, 'ChatParticipant').description,
      'fullName': (visitor, target) => D4.validateTarget<$pkg.ChatParticipant>(target, 'ChatParticipant').fullName,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatParticipant>(target, 'ChatParticipant');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatParticipant({required dynamic id, dynamic description, dynamic fullName})',
      'fromJson': 'factory ChatParticipant.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'description': 'String? get description',
      'fullName': 'String? get fullName',
    },
  );
}

// =============================================================================
// ChatRequest Bridge
// =============================================================================

BridgedClass _createChatRequestBridge() {
  return BridgedClass(
    nativeType: $pkg.ChatRequest,
    name: 'ChatRequest',
    constructors: {
      '': (visitor, positional, named) {
        final prompt = D4.getRequiredNamedArg<dynamic>(named, 'prompt', 'ChatRequest');
        final command = D4.getRequiredNamedArg<dynamic>(named, 'command', 'ChatRequest');
        final references = D4.getRequiredNamedArg<dynamic>(named, 'references', 'ChatRequest');
        return $pkg.ChatRequest(prompt: prompt, command: command, references: references);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatRequest');
        if (positional.isEmpty) {
          throw ArgumentError('ChatRequest: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.ChatRequest.fromJson(json);
      },
    },
    getters: {
      'prompt': (visitor, target) => D4.validateTarget<$pkg.ChatRequest>(target, 'ChatRequest').prompt,
      'command': (visitor, target) => D4.validateTarget<$pkg.ChatRequest>(target, 'ChatRequest').command,
      'references': (visitor, target) => D4.validateTarget<$pkg.ChatRequest>(target, 'ChatRequest').references,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatRequest>(target, 'ChatRequest');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatRequest({required dynamic prompt, required dynamic command, required dynamic references})',
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
    nativeType: $pkg.ChatPromptReference,
    name: 'ChatPromptReference',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<dynamic>(named, 'id', 'ChatPromptReference');
        final value = D4.getRequiredNamedArg<dynamic>(named, 'value', 'ChatPromptReference');
        final modelDescription = D4.getOptionalNamedArg<dynamic>(named, 'modelDescription');
        return $pkg.ChatPromptReference(id: id, value: value, modelDescription: modelDescription);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatPromptReference');
        if (positional.isEmpty) {
          throw ArgumentError('ChatPromptReference: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.ChatPromptReference.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$pkg.ChatPromptReference>(target, 'ChatPromptReference').id,
      'value': (visitor, target) => D4.validateTarget<$pkg.ChatPromptReference>(target, 'ChatPromptReference').value,
      'modelDescription': (visitor, target) => D4.validateTarget<$pkg.ChatPromptReference>(target, 'ChatPromptReference').modelDescription,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatPromptReference>(target, 'ChatPromptReference');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatPromptReference({required dynamic id, required dynamic value, dynamic modelDescription})',
      'fromJson': 'factory ChatPromptReference.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'value': 'dynamic get value',
      'modelDescription': 'String? get modelDescription',
    },
  );
}

// =============================================================================
// ChatContext Bridge
// =============================================================================

BridgedClass _createChatContextBridge() {
  return BridgedClass(
    nativeType: $pkg.ChatContext,
    name: 'ChatContext',
    constructors: {
      '': (visitor, positional, named) {
        final history = D4.getRequiredNamedArg<dynamic>(named, 'history', 'ChatContext');
        return $pkg.ChatContext(history: history);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatContext');
        if (positional.isEmpty) {
          throw ArgumentError('ChatContext: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.ChatContext.fromJson(json);
      },
    },
    getters: {
      'history': (visitor, target) => D4.validateTarget<$pkg.ChatContext>(target, 'ChatContext').history,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatContext>(target, 'ChatContext');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatContext({required dynamic history})',
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
    nativeType: $pkg.ChatResult,
    name: 'ChatResult',
    constructors: {
      '': (visitor, positional, named) {
        final metadata = D4.getOptionalNamedArg<dynamic>(named, 'metadata');
        final errorDetails = D4.getOptionalNamedArg<dynamic>(named, 'errorDetails');
        return $pkg.ChatResult(metadata: metadata, errorDetails: errorDetails);
      },
    },
    getters: {
      'metadata': (visitor, target) => D4.validateTarget<$pkg.ChatResult>(target, 'ChatResult').metadata,
      'errorDetails': (visitor, target) => D4.validateTarget<$pkg.ChatResult>(target, 'ChatResult').errorDetails,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResult>(target, 'ChatResult');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatResult({dynamic metadata, dynamic errorDetails})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'metadata': 'Map<String, dynamic>? get metadata',
      'errorDetails': 'ChatErrorDetails? get errorDetails',
    },
  );
}

// =============================================================================
// ChatErrorDetails Bridge
// =============================================================================

BridgedClass _createChatErrorDetailsBridge() {
  return BridgedClass(
    nativeType: $pkg.ChatErrorDetails,
    name: 'ChatErrorDetails',
    constructors: {
      '': (visitor, positional, named) {
        final message = D4.getRequiredNamedArg<dynamic>(named, 'message', 'ChatErrorDetails');
        final responseIsFiltered = D4.getOptionalNamedArg<dynamic>(named, 'responseIsFiltered');
        return $pkg.ChatErrorDetails(message: message, responseIsFiltered: responseIsFiltered);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.ChatErrorDetails>(target, 'ChatErrorDetails').message,
      'responseIsFiltered': (visitor, target) => D4.validateTarget<$pkg.ChatErrorDetails>(target, 'ChatErrorDetails').responseIsFiltered,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatErrorDetails>(target, 'ChatErrorDetails');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatErrorDetails({required dynamic message, dynamic responseIsFiltered})',
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
    nativeType: $pkg.ChatResponseStream,
    name: 'ChatResponseStream',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ChatResponseStream');
        final adapter = D4.getRequiredArg<dynamic>(positional, 0, '_adapter', 'ChatResponseStream');
        final streamId = D4.getRequiredArg<dynamic>(positional, 1, '_streamId', 'ChatResponseStream');
        return $pkg.ChatResponseStream(adapter, streamId);
      },
    },
    methods: {
      'markdown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'markdown');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'markdown');
        return t.markdown(text);
      },
      'anchor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'anchor');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'anchor');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        return t.anchor(uri, title: title);
      },
      'button': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'button');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'button');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final arguments = D4.coerceListOrNull<dynamic>(named['arguments'], 'arguments');
        return t.button(command, title: title, arguments: arguments);
      },
      'filetree': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'filetree');
        if (positional.isEmpty) {
          throw ArgumentError('filetree: Missing required argument "files" at position 0');
        }
        final files = D4.coerceList<String>(positional[0], 'files');
        final baseUri = D4.getOptionalNamedArg<String?>(named, 'baseUri');
        return t.filetree(files, baseUri: baseUri);
      },
      'progress': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'progress');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'progress');
        return t.progress(value);
      },
      'reference': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'reference');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'reference');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        return t.reference(uri, title: title);
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'error');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'error');
        return t.error(message);
      },
    },
    constructorSignatures: {
      '': 'ChatResponseStream(dynamic _adapter, dynamic _streamId)',
    },
    methodSignatures: {
      'markdown': 'Future<void> markdown(String text)',
      'anchor': 'Future<void> anchor(String uri, {String? title})',
      'button': 'Future<void> button(String command, {String? title, List<dynamic>? arguments})',
      'filetree': 'Future<void> filetree(List<String> files, {String? baseUri})',
      'progress': 'Future<void> progress(String value)',
      'reference': 'Future<void> reference(String uri, {String? title})',
      'error': 'Future<void> error(String message)',
    },
  );
}

// =============================================================================
// HelperLogging Bridge
// =============================================================================

BridgedClass _createHelperLoggingBridge() {
  return BridgedClass(
    nativeType: $pkg.HelperLogging,
    name: 'HelperLogging',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.HelperLogging();
      },
    },
    staticGetters: {
      'debugLogging': (visitor) => $pkg.HelperLogging.debugLogging,
    },
    staticSetters: {
      'debugLogging': (visitor, value) => 
        $pkg.HelperLogging.debugLogging = value as bool,
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
    nativeType: $pkg.VsCodeHelper,
    name: 'VsCodeHelper',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.VsCodeHelper();
      },
    },
    staticMethods: {
      'getVSCode': (visitor, positional, named, typeArgs) {
        return $pkg.VsCodeHelper.getVSCode();
      },
      'setVSCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setVSCode');
        final vscode = D4.getRequiredArg<$pkg.VSCode>(positional, 0, 'vscode', 'setVSCode');
        return $pkg.VsCodeHelper.setVSCode(vscode);
      },
      'initialize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'initialize');
        final adapter = D4.getRequiredArg<$pkg.VSCodeAdapter>(positional, 0, 'adapter', 'initialize');
        return $pkg.VsCodeHelper.initialize(adapter);
      },
      'getWindowId': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $pkg.VsCodeHelper.getWindowId(timeoutSeconds: timeoutSeconds);
      },
      'generateTimestampId': (visitor, positional, named, typeArgs) {
        return $pkg.VsCodeHelper.generateTimestampId();
      },
      'showInfo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showInfo');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showInfo');
        final choices = D4.coerceListOrNull<String>(named['choices'], 'choices');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.showInfo(message, choices: choices, timeoutSeconds: timeoutSeconds);
      },
      'showWarning': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showWarning');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showWarning');
        final choices = D4.coerceListOrNull<String>(named['choices'], 'choices');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.showWarning(message, choices: choices, timeoutSeconds: timeoutSeconds);
      },
      'showError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showError');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showError');
        final choices = D4.coerceListOrNull<String>(named['choices'], 'choices');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.showError(message, choices: choices, timeoutSeconds: timeoutSeconds);
      },
      'quickPick': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'quickPick');
        if (positional.isEmpty) {
          throw ArgumentError('quickPick: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<String>(positional[0], 'items');
        final placeholder = D4.getOptionalNamedArg<String?>(named, 'placeholder');
        final canPickMany = D4.getNamedArgWithDefault<bool>(named, 'canPickMany', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 1800);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return $pkg.VsCodeHelper.quickPick(items, placeholder: placeholder, canPickMany: canPickMany, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'inputBox': (visitor, positional, named, typeArgs) {
        final prompt = D4.getOptionalNamedArg<String?>(named, 'prompt');
        final placeholder = D4.getOptionalNamedArg<String?>(named, 'placeholder');
        final defaultValue = D4.getOptionalNamedArg<String?>(named, 'defaultValue');
        final password = D4.getNamedArgWithDefault<bool>(named, 'password', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 1800);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return $pkg.VsCodeHelper.inputBox(prompt: prompt, placeholder: placeholder, defaultValue: defaultValue, password: password, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'getWorkspaceRoot': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $pkg.VsCodeHelper.getWorkspaceRoot(timeoutSeconds: timeoutSeconds);
      },
      'getWorkspaceFolders': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $pkg.VsCodeHelper.getWorkspaceFolders(timeoutSeconds: timeoutSeconds);
      },
      'getActiveTextEditor': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $pkg.VsCodeHelper.getActiveTextEditor(timeoutSeconds: timeoutSeconds);
      },
      'findFiles': (visitor, positional, named, typeArgs) {
        final include = D4.getRequiredNamedArg<String>(named, 'include', 'findFiles');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.findFiles(include: include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'readFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.readFile(path, timeoutSeconds: timeoutSeconds);
      },
      'writeFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'writeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'writeFile');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'writeFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.writeFile(path, content, timeoutSeconds: timeoutSeconds);
      },
      'createFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'createFile');
        final content = D4.getNamedArgWithDefault<String>(named, 'content', '');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.createFile(path, content: content, timeoutSeconds: timeoutSeconds);
      },
      'deleteFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'deleteFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.deleteFile(path, timeoutSeconds: timeoutSeconds);
      },
      'fileExists': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fileExists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'fileExists');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $pkg.VsCodeHelper.fileExists(path, timeoutSeconds: timeoutSeconds);
      },
      'executeCommand': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'executeCommand');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'executeCommand');
        final args = D4.coerceListOrNull<dynamic>(named['args'], 'args');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.executeCommand(command, args: args, timeoutSeconds: timeoutSeconds);
      },
      'setStatus': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setStatus');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'setStatus');
        final timeout = D4.getOptionalNamedArg<int?>(named, 'timeout');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.setStatus(message, timeout: timeout, timeoutSeconds: timeoutSeconds);
      },
      'createOutput': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createOutput');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'createOutput');
        final initialContent = D4.getOptionalNamedArg<String?>(named, 'initialContent');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.createOutput(name, initialContent: initialContent, timeoutSeconds: timeoutSeconds);
      },
      'appendOutput': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'appendOutput');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'appendOutput');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'appendOutput');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.appendOutput(channel, text, timeoutSeconds: timeoutSeconds);
      },
      'copyToClipboard': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'copyToClipboard');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'copyToClipboard');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return $pkg.VsCodeHelper.copyToClipboard(text, timeoutSeconds: timeoutSeconds);
      },
      'readClipboard': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return $pkg.VsCodeHelper.readClipboard(timeoutSeconds: timeoutSeconds);
      },
      'openFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'openFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'openFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 600);
        return $pkg.VsCodeHelper.openFile(path, timeoutSeconds: timeoutSeconds);
      },
      'getConfig': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getConfig');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'getConfig');
        final key = D4.getOptionalNamedArg<String?>(named, 'key');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.getConfig(section, key: key, timeoutSeconds: timeoutSeconds);
      },
      'setConfig': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'setConfig');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'setConfig');
        final key = D4.getRequiredArg<String>(positional, 1, 'key', 'setConfig');
        final value = D4.getRequiredArg<dynamic>(positional, 2, 'value', 'setConfig');
        final global = D4.getNamedArgWithDefault<bool>(named, 'global', true);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.setConfig(section, key, value, global: global, timeoutSeconds: timeoutSeconds);
      },
      'runPubGet': (visitor, positional, named, typeArgs) {
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.runPubGet(workingDirectory: workingDirectory, timeoutSeconds: timeoutSeconds);
      },
      'runPubUpgrade': (visitor, positional, named, typeArgs) {
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.runPubUpgrade(workingDirectory: workingDirectory, timeoutSeconds: timeoutSeconds);
      },
      'addDependency': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addDependency');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'addDependency');
        final version = D4.getOptionalNamedArg<String?>(named, 'version');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.addDependency(name, version: version, timeoutSeconds: timeoutSeconds);
      },
      'getDiagnostics': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getDiagnostics');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'getDiagnostics');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.getDiagnostics(uri, timeoutSeconds: timeoutSeconds);
      },
      'formatDocument': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'formatDocument');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'formatDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.formatDocument(uri, timeoutSeconds: timeoutSeconds);
      },
      'organizeImports': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'organizeImports');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'organizeImports');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.organizeImports(uri, timeoutSeconds: timeoutSeconds);
      },
      'hotReload': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.hotReload(timeoutSeconds: timeoutSeconds);
      },
      'hotRestart': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 240);
        return $pkg.VsCodeHelper.hotRestart(timeoutSeconds: timeoutSeconds);
      },
      'getFlutterDevices': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.getFlutterDevices(timeoutSeconds: timeoutSeconds);
      },
      'runFlutterApp': (visitor, positional, named, typeArgs) {
        final deviceId = D4.getOptionalNamedArg<String?>(named, 'deviceId');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 420);
        return $pkg.VsCodeHelper.runFlutterApp(deviceId: deviceId, timeoutSeconds: timeoutSeconds);
      },
      'askCopilot': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'askCopilot');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'askCopilot');
        final context = D4.getOptionalNamedArg<String?>(named, 'context');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.askCopilot(prompt, context: context, timeoutSeconds: timeoutSeconds);
      },
      'askCopilotChat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'askCopilotChat');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'askCopilotChat');
        final requestId = D4.getOptionalNamedArg<String?>(named, 'requestId');
        final pollIntervalSeconds = D4.getNamedArgWithDefault<int>(named, 'pollIntervalSeconds', 10);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 7200);
        final customResponseInstructions = D4.getNamedArgWithDefault<bool>(named, 'customResponseInstructions', false);
        return $pkg.VsCodeHelper.askCopilotChat(prompt, requestId: requestId, pollIntervalSeconds: pollIntervalSeconds, timeoutSeconds: timeoutSeconds, customResponseInstructions: customResponseInstructions);
      },
      'askModel': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'askModel');
        final modelId = D4.getRequiredArg<String>(positional, 0, 'modelId', 'askModel');
        final prompt = D4.getRequiredArg<String>(positional, 1, 'prompt', 'askModel');
        final context = D4.getOptionalNamedArg<String?>(named, 'context');
        final vendor = D4.getNamedArgWithDefault<String>(named, 'vendor', 'copilot');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.askModel(modelId, prompt, context: context, vendor: vendor, timeoutSeconds: timeoutSeconds);
      },
      'getCopilotSuggestion': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'getCopilotSuggestion');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'getCopilotSuggestion');
        final instruction = D4.getRequiredArg<String>(positional, 1, 'instruction', 'getCopilotSuggestion');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.getCopilotSuggestion(code, instruction, timeoutSeconds: timeoutSeconds);
      },
      'explainCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'explainCode');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'explainCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.explainCode(code, timeoutSeconds: timeoutSeconds);
      },
      'reviewCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'reviewCode');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'reviewCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.reviewCode(code, timeoutSeconds: timeoutSeconds);
      },
      'generateTests': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'generateTests');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'generateTests');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.generateTests(code, timeoutSeconds: timeoutSeconds);
      },
      'fixCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'fixCode');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'fixCode');
        final error = D4.getRequiredArg<String>(positional, 1, 'error', 'fixCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.fixCode(code, error, timeoutSeconds: timeoutSeconds);
      },
      'selectCopilotModel': (visitor, positional, named, typeArgs) {
        final family = D4.getOptionalNamedArg<String?>(named, 'family');
        final vendor = D4.getOptionalNamedArg<String?>(named, 'vendor');
        final id = D4.getOptionalNamedArg<String?>(named, 'id');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.selectCopilotModel(family: family, vendor: vendor, id: id, timeoutSeconds: timeoutSeconds);
      },
      'getCopilotModels': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.getCopilotModels(timeoutSeconds: timeoutSeconds);
      },
      'replaceText': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'replaceText');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'replaceText');
        final startLine = D4.getRequiredArg<int>(positional, 1, 'startLine', 'replaceText');
        final startChar = D4.getRequiredArg<int>(positional, 2, 'startChar', 'replaceText');
        final endLine = D4.getRequiredArg<int>(positional, 3, 'endLine', 'replaceText');
        final endChar = D4.getRequiredArg<int>(positional, 4, 'endChar', 'replaceText');
        final text = D4.getRequiredArg<String>(positional, 5, 'text', 'replaceText');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.replaceText(uri, startLine, startChar, endLine, endChar, text, timeoutSeconds: timeoutSeconds);
      },
      'insertSnippet': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'insertSnippet');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'insertSnippet');
        final line = D4.getRequiredArg<int>(positional, 1, 'line', 'insertSnippet');
        final character = D4.getRequiredArg<int>(positional, 2, 'character', 'insertSnippet');
        final snippet = D4.getRequiredArg<String>(positional, 3, 'snippet', 'insertSnippet');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.insertSnippet(uri, line, character, snippet, timeoutSeconds: timeoutSeconds);
      },
      'applyWorkspaceEdit': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'applyWorkspaceEdit');
        if (positional.isEmpty) {
          throw ArgumentError('applyWorkspaceEdit: Missing required argument "edits" at position 0');
        }
        final edits = D4.coerceList<Map<String, dynamic>>(positional[0], 'edits');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.applyWorkspaceEdit(edits, timeoutSeconds: timeoutSeconds);
      },
      'getSelection': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.getSelection(timeoutSeconds: timeoutSeconds);
      },
      'setSelection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'setSelection');
        final startLine = D4.getRequiredArg<int>(positional, 0, 'startLine', 'setSelection');
        final startChar = D4.getRequiredArg<int>(positional, 1, 'startChar', 'setSelection');
        final endLine = D4.getRequiredArg<int>(positional, 2, 'endLine', 'setSelection');
        final endChar = D4.getRequiredArg<int>(positional, 3, 'endChar', 'setSelection');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.setSelection(startLine, startChar, endLine, endChar, timeoutSeconds: timeoutSeconds);
      },
      'getCursorPosition': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $pkg.VsCodeHelper.getCursorPosition(timeoutSeconds: timeoutSeconds);
      },
      'getProjectFiles': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getProjectFiles');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'getProjectFiles');
        final excludeTests = D4.getNamedArgWithDefault<bool>(named, 'excludeTests', true);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.getProjectFiles(pattern, excludeTests: excludeTests, timeoutSeconds: timeoutSeconds);
      },
      'getGitRoot': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.getGitRoot(timeoutSeconds: timeoutSeconds);
      },
      'getProjectType': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $pkg.VsCodeHelper.getProjectType(timeoutSeconds: timeoutSeconds);
      },
      'searchInWorkspace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'searchInWorkspace');
        final query = D4.getRequiredArg<String>(positional, 0, 'query', 'searchInWorkspace');
        final includePattern = D4.getOptionalNamedArg<String?>(named, 'includePattern');
        final excludePattern = D4.getOptionalNamedArg<String?>(named, 'excludePattern');
        final isRegex = D4.getNamedArgWithDefault<bool>(named, 'isRegex', false);
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.searchInWorkspace(query, includePattern: includePattern, excludePattern: excludePattern, isRegex: isRegex, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'replaceInWorkspace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'replaceInWorkspace');
        final query = D4.getRequiredArg<String>(positional, 0, 'query', 'replaceInWorkspace');
        final replacement = D4.getRequiredArg<String>(positional, 1, 'replacement', 'replaceInWorkspace');
        final includePattern = D4.getOptionalNamedArg<String?>(named, 'includePattern');
        final excludePattern = D4.getOptionalNamedArg<String?>(named, 'excludePattern');
        final isRegex = D4.getNamedArgWithDefault<bool>(named, 'isRegex', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.replaceInWorkspace(query, replacement, includePattern: includePattern, excludePattern: excludePattern, isRegex: isRegex, timeoutSeconds: timeoutSeconds);
      },
      'runTests': (visitor, positional, named, typeArgs) {
        final uri = D4.getOptionalNamedArg<String?>(named, 'uri');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 420);
        return $pkg.VsCodeHelper.runTests(uri: uri, timeoutSeconds: timeoutSeconds);
      },
      'runTestsWithCoverage': (visitor, positional, named, typeArgs) {
        final uri = D4.getOptionalNamedArg<String?>(named, 'uri');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 600);
        return $pkg.VsCodeHelper.runTestsWithCoverage(uri: uri, timeoutSeconds: timeoutSeconds);
      },
      'getTestResults': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 240);
        return $pkg.VsCodeHelper.getTestResults(timeoutSeconds: timeoutSeconds);
      },
      'startDebugging': (visitor, positional, named, typeArgs) {
        final config = D4.coerceMapOrNull<String, dynamic>(named['config'], 'config');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $pkg.VsCodeHelper.startDebugging(config: config, timeoutSeconds: timeoutSeconds);
      },
      'stopDebugging': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.stopDebugging(timeoutSeconds: timeoutSeconds);
      },
      'setBreakpoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setBreakpoint');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'setBreakpoint');
        final line = D4.getRequiredArg<int>(positional, 1, 'line', 'setBreakpoint');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.setBreakpoint(uri, line, timeoutSeconds: timeoutSeconds);
      },
      'removeBreakpoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'removeBreakpoint');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'removeBreakpoint');
        final line = D4.getRequiredArg<int>(positional, 1, 'line', 'removeBreakpoint');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.removeBreakpoint(uri, line, timeoutSeconds: timeoutSeconds);
      },
      'getBreakpoints': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $pkg.VsCodeHelper.getBreakpoints(timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VsCodeHelper()',
    },
    staticMethodSignatures: {
      'getVSCode': 'VSCode getVSCode()',
      'setVSCode': 'void setVSCode(VSCode vscode)',
      'initialize': 'void initialize(VSCodeAdapter adapter)',
      'getWindowId': 'Future<String> getWindowId({int timeoutSeconds = 30})',
      'generateTimestampId': 'String generateTimestampId()',
      'showInfo': 'Future<String?> showInfo(String message, {List<String>? choices, int timeoutSeconds = 300})',
      'showWarning': 'Future<String?> showWarning(String message, {List<String>? choices, int timeoutSeconds = 300})',
      'showError': 'Future<String?> showError(String message, {List<String>? choices, int timeoutSeconds = 300})',
      'quickPick': 'Future<String?> quickPick(List<String> items, {String? placeholder, bool canPickMany = false, int timeoutSeconds = 1800, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'inputBox': 'Future<String?> inputBox({String? prompt, String? placeholder, String? defaultValue, bool password = false, int timeoutSeconds = 1800, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'getWorkspaceRoot': 'Future<String?> getWorkspaceRoot({int timeoutSeconds = 30})',
      'getWorkspaceFolders': 'Future<List<dynamic>?> getWorkspaceFolders({int timeoutSeconds = 30})',
      'getActiveTextEditor': 'Future<dynamic> getActiveTextEditor({int timeoutSeconds = 30})',
      'findFiles': 'Future<List<String>> findFiles({required String include, String? exclude, int? maxResults, int timeoutSeconds = 60})',
      'readFile': 'Future<String> readFile(String path, {int timeoutSeconds = 60})',
      'writeFile': 'Future<bool> writeFile(String path, String content, {int timeoutSeconds = 60})',
      'createFile': 'Future<bool> createFile(String path, {String content = \'\', int timeoutSeconds = 60})',
      'deleteFile': 'Future<bool> deleteFile(String path, {int timeoutSeconds = 60})',
      'fileExists': 'Future<bool> fileExists(String path, {int timeoutSeconds = 30})',
      'executeCommand': 'Future<dynamic> executeCommand(String command, {List<dynamic>? args, int timeoutSeconds = 120})',
      'setStatus': 'Future<void> setStatus(String message, {int? timeout, int timeoutSeconds = 120})',
      'createOutput': 'Future<String> createOutput(String name, {String? initialContent, int timeoutSeconds = 60})',
      'appendOutput': 'Future<void> appendOutput(String channel, String text, {int timeoutSeconds = 60})',
      'copyToClipboard': 'Future<void> copyToClipboard(String text, {int timeoutSeconds = 10})',
      'readClipboard': 'Future<String> readClipboard({int timeoutSeconds = 10})',
      'openFile': 'Future<void> openFile(String path, {int timeoutSeconds = 600})',
      'getConfig': 'Future<dynamic> getConfig(String section, {String? key, int timeoutSeconds = 60})',
      'setConfig': 'Future<bool> setConfig(String section, String key, dynamic value, {bool global = true, int timeoutSeconds = 60})',
      'runPubGet': 'Future<bool> runPubGet({String? workingDirectory, int timeoutSeconds = 300})',
      'runPubUpgrade': 'Future<bool> runPubUpgrade({String? workingDirectory, int timeoutSeconds = 300})',
      'addDependency': 'Future<bool> addDependency(String name, {String? version, int timeoutSeconds = 180})',
      'getDiagnostics': 'Future<List<Map<String, dynamic>>> getDiagnostics(String uri, {int timeoutSeconds = 120})',
      'formatDocument': 'Future<bool> formatDocument(String uri, {int timeoutSeconds = 180})',
      'organizeImports': 'Future<bool> organizeImports(String uri, {int timeoutSeconds = 180})',
      'hotReload': 'Future<bool> hotReload({int timeoutSeconds = 180})',
      'hotRestart': 'Future<bool> hotRestart({int timeoutSeconds = 240})',
      'getFlutterDevices': 'Future<List<Map<String, dynamic>>> getFlutterDevices({int timeoutSeconds = 180})',
      'runFlutterApp': 'Future<bool> runFlutterApp({String? deviceId, int timeoutSeconds = 420})',
      'askCopilot': 'Future<String> askCopilot(String prompt, {String? context, int timeoutSeconds = 300})',
      'askCopilotChat': 'Future<Map<String, dynamic>> askCopilotChat(String prompt, {String? requestId, int pollIntervalSeconds = 10, int timeoutSeconds = 7200, bool customResponseInstructions = false})',
      'askModel': 'Future<String> askModel(String modelId, String prompt, {String? context, String vendor = \'copilot\', int timeoutSeconds = 300})',
      'getCopilotSuggestion': 'Future<String> getCopilotSuggestion(String code, String instruction, {int timeoutSeconds = 300})',
      'explainCode': 'Future<String> explainCode(String code, {int timeoutSeconds = 300})',
      'reviewCode': 'Future<String> reviewCode(String code, {int timeoutSeconds = 300})',
      'generateTests': 'Future<String> generateTests(String code, {int timeoutSeconds = 300})',
      'fixCode': 'Future<String> fixCode(String code, String error, {int timeoutSeconds = 300})',
      'selectCopilotModel': 'Future<LanguageModelChat?> selectCopilotModel({String? family, String? vendor, String? id, int timeoutSeconds = 120})',
      'getCopilotModels': 'Future<List<LanguageModelChat>> getCopilotModels({int timeoutSeconds = 120})',
      'replaceText': 'Future<bool> replaceText(String uri, int startLine, int startChar, int endLine, int endChar, String text, {int timeoutSeconds = 180})',
      'insertSnippet': 'Future<bool> insertSnippet(String uri, int line, int character, String snippet, {int timeoutSeconds = 180})',
      'applyWorkspaceEdit': 'Future<bool> applyWorkspaceEdit(List<Map<String, dynamic>> edits, {int timeoutSeconds = 180})',
      'getSelection': 'Future<Selection?> getSelection({int timeoutSeconds = 60})',
      'setSelection': 'Future<bool> setSelection(int startLine, int startChar, int endLine, int endChar, {int timeoutSeconds = 120})',
      'getCursorPosition': 'Future<Position?> getCursorPosition({int timeoutSeconds = 60})',
      'getProjectFiles': 'Future<List<String>> getProjectFiles(String pattern, {bool excludeTests = true, int timeoutSeconds = 120})',
      'getGitRoot': 'Future<String?> getGitRoot({int timeoutSeconds = 120})',
      'getProjectType': 'Future<String> getProjectType({int timeoutSeconds = 120})',
      'searchInWorkspace': 'Future<List<Map<String, dynamic>>> searchInWorkspace(String query, {String? includePattern, String? excludePattern, bool isRegex = false, int? maxResults, int timeoutSeconds = 180})',
      'replaceInWorkspace': 'Future<bool> replaceInWorkspace(String query, String replacement, {String? includePattern, String? excludePattern, bool isRegex = false, int timeoutSeconds = 180})',
      'runTests': 'Future<Map<String, dynamic>> runTests({String? uri, int timeoutSeconds = 420})',
      'runTestsWithCoverage': 'Future<Map<String, dynamic>> runTestsWithCoverage({String? uri, int timeoutSeconds = 600})',
      'getTestResults': 'Future<List<Map<String, dynamic>>> getTestResults({int timeoutSeconds = 240})',
      'startDebugging': 'Future<bool> startDebugging({Map<String, dynamic>? config, int timeoutSeconds = 300})',
      'stopDebugging': 'Future<bool> stopDebugging({int timeoutSeconds = 180})',
      'setBreakpoint': 'Future<bool> setBreakpoint(String uri, int line, {int timeoutSeconds = 180})',
      'removeBreakpoint': 'Future<bool> removeBreakpoint(String uri, int line, {int timeoutSeconds = 180})',
      'getBreakpoints': 'Future<List<Map<String, dynamic>>> getBreakpoints({int timeoutSeconds = 180})',
    },
  );
}

// =============================================================================
// VsProgress Bridge
// =============================================================================

BridgedClass _createVsProgressBridge() {
  return BridgedClass(
    nativeType: $pkg.VsProgress,
    name: 'VsProgress',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.VsProgress();
      },
    },
    getters: {
      'channelName': (visitor, target) => D4.validateTarget<$pkg.VsProgress>(target, 'VsProgress').channelName,
    },
    methods: {
      'report': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VsProgress>(target, 'VsProgress');
        D4.requireMinArgs(positional, 1, 'report');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'report');
        return t.report(message);
      },
      'complete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VsProgress>(target, 'VsProgress');
        return t.complete();
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VsProgress>(target, 'VsProgress');
        D4.requireMinArgs(positional, 1, 'error');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'error');
        return t.error(message);
      },
    },
    staticMethods: {
      'create': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'create');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'create');
        return $pkg.VsProgress.create(name);
      },
    },
    constructorSignatures: {
      '': 'VsProgress()',
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
    nativeType: $pkg.FileBatch,
    name: 'FileBatch',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.FileBatch();
      },
    },
    getters: {
      'files': (visitor, target) => D4.validateTarget<$pkg.FileBatch>(target, 'FileBatch').files,
      'count': (visitor, target) => D4.validateTarget<$pkg.FileBatch>(target, 'FileBatch').count,
    },
    methods: {
      'process': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileBatch>(target, 'FileBatch');
        D4.requireMinArgs(positional, 1, 'process');
        if (positional.isEmpty) {
          throw ArgumentError('process: Missing required argument "processor" at position 0');
        }
        final processorRaw = positional[0];
        return t.process((String p0, String p1) { return (processorRaw as InterpretedFunction).call(visitor, [p0, p1]) as Future<dynamic>; });
      },
      'filter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileBatch>(target, 'FileBatch');
        D4.requireMinArgs(positional, 1, 'filter');
        if (positional.isEmpty) {
          throw ArgumentError('filter: Missing required argument "predicate" at position 0');
        }
        final predicateRaw = positional[0];
        return t.filter((String p0) { return (predicateRaw as InterpretedFunction).call(visitor, [p0]) as bool; });
      },
    },
    staticMethods: {
      'fromPattern': (visitor, positional, named, typeArgs) {
        final include = D4.getRequiredNamedArg<String>(named, 'include', 'fromPattern');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        return $pkg.FileBatch.fromPattern(include: include, exclude: exclude, maxResults: maxResults);
      },
    },
    constructorSignatures: {
      '': 'FileBatch()',
    },
    methodSignatures: {
      'process': 'Future<List<T>> process(Future<T> Function(String path, String content) processor)',
      'filter': 'Future<FileBatch> filter(bool Function(String path) predicate)',
    },
    getterSignatures: {
      'files': 'List<String> get files',
      'count': 'int get count',
    },
    staticMethodSignatures: {
      'fromPattern': 'Future<FileBatch> fromPattern({required String include, String? exclude, int? maxResults})',
    },
  );
}

// =============================================================================
// VSCodeUri Bridge
// =============================================================================

BridgedClass _createVSCodeUriBridge() {
  return BridgedClass(
    nativeType: $pkg.VSCodeUri,
    name: 'VSCodeUri',
    constructors: {
      '': (visitor, positional, named) {
        final scheme = D4.getRequiredNamedArg<dynamic>(named, 'scheme', 'VSCodeUri');
        final authority = D4.getNamedArgWithDefault<dynamic>(named, 'authority', '');
        final path = D4.getRequiredNamedArg<dynamic>(named, 'path', 'VSCodeUri');
        final query = D4.getNamedArgWithDefault<dynamic>(named, 'query', '');
        final fragment = D4.getNamedArgWithDefault<dynamic>(named, 'fragment', '');
        final fsPath = D4.getRequiredNamedArg<dynamic>(named, 'fsPath', 'VSCodeUri');
        return $pkg.VSCodeUri(scheme: scheme, authority: authority, path: path, query: query, fragment: fragment, fsPath: fsPath);
      },
      'file': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeUri');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'VSCodeUri');
        return $pkg.VSCodeUri.file(path);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeUri');
        if (positional.isEmpty) {
          throw ArgumentError('VSCodeUri: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.VSCodeUri.fromJson(json);
      },
    },
    getters: {
      'scheme': (visitor, target) => D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri').scheme,
      'authority': (visitor, target) => D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri').authority,
      'path': (visitor, target) => D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri').path,
      'query': (visitor, target) => D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri').query,
      'fragment': (visitor, target) => D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri').fragment,
      'fsPath': (visitor, target) => D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri').fsPath,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VSCodeUri>(target, 'VSCodeUri');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'VSCodeUri({required dynamic scheme, dynamic authority = \'\', required dynamic path, dynamic query = \'\', dynamic fragment = \'\', required dynamic fsPath})',
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
    nativeType: $pkg.WorkspaceFolder,
    name: 'WorkspaceFolder',
    constructors: {
      '': (visitor, positional, named) {
        final uri = D4.getRequiredNamedArg<dynamic>(named, 'uri', 'WorkspaceFolder');
        final name = D4.getRequiredNamedArg<dynamic>(named, 'name', 'WorkspaceFolder');
        final index = D4.getRequiredNamedArg<dynamic>(named, 'index', 'WorkspaceFolder');
        return $pkg.WorkspaceFolder(uri: uri, name: name, index: index);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WorkspaceFolder');
        if (positional.isEmpty) {
          throw ArgumentError('WorkspaceFolder: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.WorkspaceFolder.fromJson(json);
      },
    },
    getters: {
      'uri': (visitor, target) => D4.validateTarget<$pkg.WorkspaceFolder>(target, 'WorkspaceFolder').uri,
      'name': (visitor, target) => D4.validateTarget<$pkg.WorkspaceFolder>(target, 'WorkspaceFolder').name,
      'index': (visitor, target) => D4.validateTarget<$pkg.WorkspaceFolder>(target, 'WorkspaceFolder').index,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.WorkspaceFolder>(target, 'WorkspaceFolder');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'WorkspaceFolder({required dynamic uri, required dynamic name, required dynamic index})',
      'fromJson': 'factory WorkspaceFolder.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'uri': 'VSCodeUri get uri',
      'name': 'String get name',
      'index': 'int get index',
    },
  );
}

// =============================================================================
// TextDocument Bridge
// =============================================================================

BridgedClass _createTextDocumentBridge() {
  return BridgedClass(
    nativeType: $pkg.TextDocument,
    name: 'TextDocument',
    constructors: {
      '': (visitor, positional, named) {
        final uri = D4.getRequiredNamedArg<dynamic>(named, 'uri', 'TextDocument');
        final fileName = D4.getRequiredNamedArg<dynamic>(named, 'fileName', 'TextDocument');
        final isUntitled = D4.getRequiredNamedArg<dynamic>(named, 'isUntitled', 'TextDocument');
        final languageId = D4.getRequiredNamedArg<dynamic>(named, 'languageId', 'TextDocument');
        final version = D4.getRequiredNamedArg<dynamic>(named, 'version', 'TextDocument');
        final isDirty = D4.getRequiredNamedArg<dynamic>(named, 'isDirty', 'TextDocument');
        final isClosed = D4.getRequiredNamedArg<dynamic>(named, 'isClosed', 'TextDocument');
        final lineCount = D4.getRequiredNamedArg<dynamic>(named, 'lineCount', 'TextDocument');
        return $pkg.TextDocument(uri: uri, fileName: fileName, isUntitled: isUntitled, languageId: languageId, version: version, isDirty: isDirty, isClosed: isClosed, lineCount: lineCount);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextDocument');
        if (positional.isEmpty) {
          throw ArgumentError('TextDocument: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.TextDocument.fromJson(json);
      },
    },
    getters: {
      'uri': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').uri,
      'fileName': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').fileName,
      'isUntitled': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').isUntitled,
      'languageId': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').languageId,
      'version': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').version,
      'isDirty': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').isDirty,
      'isClosed': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').isClosed,
      'lineCount': (visitor, target) => D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument').lineCount,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TextDocument>(target, 'TextDocument');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TextDocument({required dynamic uri, required dynamic fileName, required dynamic isUntitled, required dynamic languageId, required dynamic version, required dynamic isDirty, required dynamic isClosed, required dynamic lineCount})',
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
    nativeType: $pkg.Position,
    name: 'Position',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Position');
        final line = D4.getRequiredArg<dynamic>(positional, 0, 'line', 'Position');
        final character = D4.getRequiredArg<dynamic>(positional, 1, 'character', 'Position');
        return $pkg.Position(line, character);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Position');
        if (positional.isEmpty) {
          throw ArgumentError('Position: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.Position.fromJson(json);
      },
    },
    getters: {
      'line': (visitor, target) => D4.validateTarget<$pkg.Position>(target, 'Position').line,
      'character': (visitor, target) => D4.validateTarget<$pkg.Position>(target, 'Position').character,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Position>(target, 'Position');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Position(dynamic line, dynamic character)',
      'fromJson': 'factory Position.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'line': 'int get line',
      'character': 'int get character',
    },
  );
}

// =============================================================================
// Range Bridge
// =============================================================================

BridgedClass _createRangeBridge() {
  return BridgedClass(
    nativeType: $pkg.Range,
    name: 'Range',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Range');
        final start = D4.getRequiredArg<dynamic>(positional, 0, 'start', 'Range');
        final end = D4.getRequiredArg<dynamic>(positional, 1, 'end', 'Range');
        return $pkg.Range(start, end);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Range');
        if (positional.isEmpty) {
          throw ArgumentError('Range: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.Range.fromJson(json);
      },
    },
    getters: {
      'start': (visitor, target) => D4.validateTarget<$pkg.Range>(target, 'Range').start,
      'end': (visitor, target) => D4.validateTarget<$pkg.Range>(target, 'Range').end,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Range>(target, 'Range');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Range(dynamic start, dynamic end)',
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
    nativeType: $pkg.Selection,
    name: 'Selection',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Selection');
        final anchor = D4.getRequiredArg<dynamic>(positional, 0, 'anchor', 'Selection');
        final active = D4.getRequiredArg<dynamic>(positional, 1, 'active', 'Selection');
        final isReversed = D4.getRequiredArg<dynamic>(positional, 2, 'isReversed', 'Selection');
        return $pkg.Selection(anchor, active, isReversed);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Selection');
        if (positional.isEmpty) {
          throw ArgumentError('Selection: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.Selection.fromJson(json);
      },
    },
    getters: {
      'start': (visitor, target) => D4.validateTarget<$pkg.Selection>(target, 'Selection').start,
      'end': (visitor, target) => D4.validateTarget<$pkg.Selection>(target, 'Selection').end,
      'anchor': (visitor, target) => D4.validateTarget<$pkg.Selection>(target, 'Selection').anchor,
      'active': (visitor, target) => D4.validateTarget<$pkg.Selection>(target, 'Selection').active,
      'isReversed': (visitor, target) => D4.validateTarget<$pkg.Selection>(target, 'Selection').isReversed,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Selection>(target, 'Selection');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Selection(dynamic anchor, dynamic active, dynamic isReversed)',
      'fromJson': 'factory Selection.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'start': 'Position get start',
      'end': 'Position get end',
      'anchor': 'Position get anchor',
      'active': 'Position get active',
      'isReversed': 'bool get isReversed',
    },
  );
}

// =============================================================================
// TextEditor Bridge
// =============================================================================

BridgedClass _createTextEditorBridge() {
  return BridgedClass(
    nativeType: $pkg.TextEditor,
    name: 'TextEditor',
    constructors: {
      '': (visitor, positional, named) {
        final document = D4.getRequiredNamedArg<dynamic>(named, 'document', 'TextEditor');
        final selection = D4.getRequiredNamedArg<dynamic>(named, 'selection', 'TextEditor');
        final selections = D4.getRequiredNamedArg<dynamic>(named, 'selections', 'TextEditor');
        final visibleRanges = D4.getOptionalNamedArg<dynamic>(named, 'visibleRanges');
        return $pkg.TextEditor(document: document, selection: selection, selections: selections, visibleRanges: visibleRanges);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextEditor');
        if (positional.isEmpty) {
          throw ArgumentError('TextEditor: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.TextEditor.fromJson(json);
      },
    },
    getters: {
      'document': (visitor, target) => D4.validateTarget<$pkg.TextEditor>(target, 'TextEditor').document,
      'selection': (visitor, target) => D4.validateTarget<$pkg.TextEditor>(target, 'TextEditor').selection,
      'selections': (visitor, target) => D4.validateTarget<$pkg.TextEditor>(target, 'TextEditor').selections,
      'visibleRanges': (visitor, target) => D4.validateTarget<$pkg.TextEditor>(target, 'TextEditor').visibleRanges,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TextEditor>(target, 'TextEditor');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TextEditor({required dynamic document, required dynamic selection, required dynamic selections, dynamic visibleRanges})',
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
    nativeType: $pkg.QuickPickItem,
    name: 'QuickPickItem',
    constructors: {
      '': (visitor, positional, named) {
        final label = D4.getRequiredNamedArg<dynamic>(named, 'label', 'QuickPickItem');
        final description = D4.getOptionalNamedArg<dynamic>(named, 'description');
        final detail = D4.getOptionalNamedArg<dynamic>(named, 'detail');
        final picked = D4.getNamedArgWithDefault<dynamic>(named, 'picked', false);
        return $pkg.QuickPickItem(label: label, description: description, detail: detail, picked: picked);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'QuickPickItem');
        if (positional.isEmpty) {
          throw ArgumentError('QuickPickItem: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.QuickPickItem.fromJson(json);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$pkg.QuickPickItem>(target, 'QuickPickItem').label,
      'description': (visitor, target) => D4.validateTarget<$pkg.QuickPickItem>(target, 'QuickPickItem').description,
      'detail': (visitor, target) => D4.validateTarget<$pkg.QuickPickItem>(target, 'QuickPickItem').detail,
      'picked': (visitor, target) => D4.validateTarget<$pkg.QuickPickItem>(target, 'QuickPickItem').picked,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.QuickPickItem>(target, 'QuickPickItem');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'QuickPickItem({required dynamic label, dynamic description, dynamic detail, dynamic picked = false})',
      'fromJson': 'factory QuickPickItem.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'label': 'String get label',
      'description': 'String? get description',
      'detail': 'String? get detail',
      'picked': 'bool get picked',
    },
  );
}

// =============================================================================
// InputBoxOptions Bridge
// =============================================================================

BridgedClass _createInputBoxOptionsBridge() {
  return BridgedClass(
    nativeType: $pkg.InputBoxOptions,
    name: 'InputBoxOptions',
    constructors: {
      '': (visitor, positional, named) {
        final prompt = D4.getOptionalNamedArg<dynamic>(named, 'prompt');
        final placeHolder = D4.getOptionalNamedArg<dynamic>(named, 'placeHolder');
        final value = D4.getOptionalNamedArg<dynamic>(named, 'value');
        final password = D4.getNamedArgWithDefault<dynamic>(named, 'password', false);
        return $pkg.InputBoxOptions(prompt: prompt, placeHolder: placeHolder, value: value, password: password);
      },
    },
    getters: {
      'prompt': (visitor, target) => D4.validateTarget<$pkg.InputBoxOptions>(target, 'InputBoxOptions').prompt,
      'placeHolder': (visitor, target) => D4.validateTarget<$pkg.InputBoxOptions>(target, 'InputBoxOptions').placeHolder,
      'value': (visitor, target) => D4.validateTarget<$pkg.InputBoxOptions>(target, 'InputBoxOptions').value,
      'password': (visitor, target) => D4.validateTarget<$pkg.InputBoxOptions>(target, 'InputBoxOptions').password,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InputBoxOptions>(target, 'InputBoxOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'InputBoxOptions({dynamic prompt, dynamic placeHolder, dynamic value, dynamic password = false})',
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
    nativeType: $pkg.MessageOptions,
    name: 'MessageOptions',
    constructors: {
      '': (visitor, positional, named) {
        final modal = D4.getNamedArgWithDefault<dynamic>(named, 'modal', false);
        final detail = D4.getOptionalNamedArg<dynamic>(named, 'detail');
        return $pkg.MessageOptions(modal: modal, detail: detail);
      },
    },
    getters: {
      'modal': (visitor, target) => D4.validateTarget<$pkg.MessageOptions>(target, 'MessageOptions').modal,
      'detail': (visitor, target) => D4.validateTarget<$pkg.MessageOptions>(target, 'MessageOptions').detail,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MessageOptions>(target, 'MessageOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'MessageOptions({dynamic modal = false, dynamic detail})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'modal': 'bool get modal',
      'detail': 'String? get detail',
    },
  );
}

// =============================================================================
// TerminalOptions Bridge
// =============================================================================

BridgedClass _createTerminalOptionsBridge() {
  return BridgedClass(
    nativeType: $pkg.TerminalOptions,
    name: 'TerminalOptions',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<dynamic>(named, 'name');
        final shellPath = D4.getOptionalNamedArg<dynamic>(named, 'shellPath');
        final shellArgs = D4.getOptionalNamedArg<dynamic>(named, 'shellArgs');
        final cwd = D4.getOptionalNamedArg<dynamic>(named, 'cwd');
        final env = D4.getOptionalNamedArg<dynamic>(named, 'env');
        return $pkg.TerminalOptions(name: name, shellPath: shellPath, shellArgs: shellArgs, cwd: cwd, env: env);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.TerminalOptions>(target, 'TerminalOptions').name,
      'shellPath': (visitor, target) => D4.validateTarget<$pkg.TerminalOptions>(target, 'TerminalOptions').shellPath,
      'shellArgs': (visitor, target) => D4.validateTarget<$pkg.TerminalOptions>(target, 'TerminalOptions').shellArgs,
      'cwd': (visitor, target) => D4.validateTarget<$pkg.TerminalOptions>(target, 'TerminalOptions').cwd,
      'env': (visitor, target) => D4.validateTarget<$pkg.TerminalOptions>(target, 'TerminalOptions').env,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TerminalOptions>(target, 'TerminalOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TerminalOptions({dynamic name, dynamic shellPath, dynamic shellArgs, dynamic cwd, dynamic env})',
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
    nativeType: $pkg.FileSystemWatcherOptions,
    name: 'FileSystemWatcherOptions',
    constructors: {
      '': (visitor, positional, named) {
        final ignoreCreateEvents = D4.getNamedArgWithDefault<dynamic>(named, 'ignoreCreateEvents', false);
        final ignoreChangeEvents = D4.getNamedArgWithDefault<dynamic>(named, 'ignoreChangeEvents', false);
        final ignoreDeleteEvents = D4.getNamedArgWithDefault<dynamic>(named, 'ignoreDeleteEvents', false);
        return $pkg.FileSystemWatcherOptions(ignoreCreateEvents: ignoreCreateEvents, ignoreChangeEvents: ignoreChangeEvents, ignoreDeleteEvents: ignoreDeleteEvents);
      },
    },
    getters: {
      'ignoreCreateEvents': (visitor, target) => D4.validateTarget<$pkg.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreCreateEvents,
      'ignoreChangeEvents': (visitor, target) => D4.validateTarget<$pkg.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreChangeEvents,
      'ignoreDeleteEvents': (visitor, target) => D4.validateTarget<$pkg.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreDeleteEvents,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'FileSystemWatcherOptions({dynamic ignoreCreateEvents = false, dynamic ignoreChangeEvents = false, dynamic ignoreDeleteEvents = false})',
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

