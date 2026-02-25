// D4rt Bridge - Generated file, do not edit
// Sources: 10 files
// Generated: 2026-02-15T00:34:41.764770

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:io';

import 'package:tom_basics_network/src/http_retry.dart' as $tom_basics_network_1;
import 'package:tom_basics_network/src/server_discovery.dart' as $tom_basics_network_2;
import 'package:tom_dist_ledger/src/ledger_api/cleanup_handler.dart' as $tom_dist_ledger_1;
import 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart' as $tom_dist_ledger_2;
import 'package:tom_dist_ledger/src/ledger_api/ledger_base.dart' as $tom_dist_ledger_3;
import 'package:tom_dist_ledger/src/ledger_api/ledger_types.dart' as $tom_dist_ledger_4;
import 'package:tom_dist_ledger/src/ledger_client/remote_ledger_client.dart' as $tom_dist_ledger_5;
import 'package:tom_dist_ledger/src/ledger_local/file_ledger.dart' as $tom_dist_ledger_6;

/// Bridge class for tom_dist_ledger module.
class TomDistLedgerBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createCleanupHandlerBridge(),
      _createCallFrameBridge(),
      _createTempResourceBridge(),
      _createLedgerDataBridge(),
      _createHeartbeatResultBridge(),
      _createHeartbeatErrorBridge(),
      _createOperationBridge(),
      _createLedgerBridge(),
      _createLocalOperationBridge(),
      _createLocalLedgerBridge(),
      _createLedgerCallbackBridge(),
      _createOperationCallbackBridge(),
      _createCallCallbackBridge(),
      _createOperationFailedInfoBridge(),
      _createOperationFailedExceptionBridge(),
      _createCallLifecycleBridge(),
      _createCallBridge(),
      _createSpawnedCallBridge(),
      _createSyncResultBridge(),
      _createOperationHelperBridge(),
      _createLedgerServerBridge(),
      _createRemoteLedgerClientBridge(),
      _createRemoteLedgerExceptionBridge(),
      _createRemoteOperationBridge(),
      _createRetryExhaustedExceptionBridge(),
      _createRetryConfigBridge(),
      _createDiscoveredServerBridge(),
      _createDiscoveryOptionsBridge(),
      _createDiscoveryFailedExceptionBridge(),
      _createServerDiscoveryBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'CleanupHandler': 'package:tom_dist_ledger/src/ledger_api/cleanup_handler.dart',
      'CallFrame': 'package:tom_dist_ledger/src/ledger_local/file_ledger.dart',
      'TempResource': 'package:tom_dist_ledger/src/ledger_local/file_ledger.dart',
      'LedgerData': 'package:tom_dist_ledger/src/ledger_local/file_ledger.dart',
      'HeartbeatResult': 'package:tom_dist_ledger/src/ledger_local/file_ledger.dart',
      'HeartbeatError': 'package:tom_dist_ledger/src/ledger_api/ledger_types.dart',
      'Operation': 'package:tom_dist_ledger/src/ledger_api/ledger_base.dart',
      'Ledger': 'package:tom_dist_ledger/src/ledger_api/ledger_base.dart',
      'LocalOperation': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'LocalLedger': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'LedgerCallback': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'OperationCallback': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'CallCallback': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'OperationFailedInfo': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'OperationFailedException': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'CallLifecycle': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'Call': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'SpawnedCall': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'SyncResult': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'OperationHelper': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'LedgerServer': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'RemoteLedgerClient': 'package:tom_dist_ledger/src/ledger_client/remote_ledger_client.dart',
      'RemoteLedgerException': 'package:tom_dist_ledger/src/ledger_client/remote_ledger_client.dart',
      'RemoteOperation': 'package:tom_dist_ledger/src/ledger_client/remote_ledger_client.dart',
      'RetryExhaustedException': 'package:tom_basics_network/src/http_retry.dart',
      'RetryConfig': 'package:tom_basics_network/src/http_retry.dart',
      'DiscoveredServer': 'package:tom_basics_network/src/server_discovery.dart',
      'DiscoveryOptions': 'package:tom_basics_network/src/server_discovery.dart',
      'DiscoveryFailedException': 'package:tom_basics_network/src/server_discovery.dart',
      'ServerDiscovery': 'package:tom_basics_network/src/server_discovery.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$tom_dist_ledger_6.FrameState>(
        name: 'FrameState',
        values: $tom_dist_ledger_6.FrameState.values,
      ),
      BridgedEnumDefinition<$tom_dist_ledger_6.OperationState>(
        name: 'OperationState',
        values: $tom_dist_ledger_6.OperationState.values,
      ),
      BridgedEnumDefinition<$tom_dist_ledger_4.HeartbeatErrorType>(
        name: 'HeartbeatErrorType',
        values: $tom_dist_ledger_4.HeartbeatErrorType.values,
      ),
      BridgedEnumDefinition<$tom_dist_ledger_2.DLLogLevel>(
        name: 'DLLogLevel',
        values: $tom_dist_ledger_2.DLLogLevel.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'FrameState': 'package:tom_dist_ledger/src/ledger_local/file_ledger.dart',
      'OperationState': 'package:tom_dist_ledger/src/ledger_local/file_ledger.dart',
      'HeartbeatErrorType': 'package:tom_dist_ledger/src/ledger_api/ledger_types.dart',
      'DLLogLevel': 'package:tom_dist_ledger/src/ledger_api/call_callback.dart',
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
      BridgedExtensionDefinition(
        name: 'DLLogLevelExtension',
        onTypeName: 'DLLogLevel',
        getters: {
          'name': (visitor, target) => (target as $tom_dist_ledger_2.DLLogLevel).name,
        },
      ),
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
      'DLLogLevelExtension': 'package:tom_dist_ledger/src/ledger_api/call_callback.dart',
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

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }

    // Register bridged extensions with source URIs for deduplication
    final extensions = bridgedExtensions();
    final extSources = extensionSourceUris();
    for (final extDef in extensions) {
      final extKey = extDef.name ?? '<unnamed>@${extDef.onTypeName}';
      interpreter.registerBridgedExtension(extDef, importPath, sourceUri: extSources[extKey]);
    }
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('kDefaultRetryDelaysMs', $tom_basics_network_1.kDefaultRetryDelaysMs, importPath, sourceUri: 'package:tom_basics_network/src/http_retry.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDefaultRetryDelaysMs": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (tom_dist_ledger):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'withRetry': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withRetry');
        if (positional.isEmpty) {
          throw ArgumentError('withRetry: Missing required argument "operation" at position 0');
        }
        final operationRaw = positional[0];
        final operation = () { return D4.callInterpreterCallback(visitor, operationRaw, []) as Future<dynamic>; };
        final config = D4.getNamedArgWithDefault<$tom_basics_network_1.RetryConfig>(named, 'config', $tom_basics_network_1.RetryConfig.defaultConfig);
        final shouldRetryRaw = named['shouldRetry'];
        final shouldRetry = shouldRetryRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor, shouldRetryRaw, [p0]) as bool; };
        return $tom_basics_network_1.withRetry<dynamic>(operation, config: config, shouldRetry: shouldRetry);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'withRetry': 'package:tom_basics_network/src/http_retry.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'withRetry': 'Future<T> withRetry(Future<T> Function() operation, {RetryConfig config = RetryConfig.defaultConfig, bool Function(Object error)? shouldRetry})',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:tom_basics_network/src/http_retry.dart',
      'package:tom_basics_network/src/server_discovery.dart',
      'package:tom_dist_ledger/src/ledger_api/call_callback.dart',
      'package:tom_dist_ledger/src/ledger_api/cleanup_handler.dart',
      'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
      'package:tom_dist_ledger/src/ledger_api/ledger_base.dart',
      'package:tom_dist_ledger/src/ledger_api/ledger_types.dart',
      'package:tom_dist_ledger/src/ledger_client/remote_ledger_client.dart',
      'package:tom_dist_ledger/src/ledger_local/file_ledger.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    final imports = StringBuffer();
    imports.writeln("import 'package:tom_dist_ledger/tom_dist_ledger.dart';");
    imports.writeln("import 'package:tom_basics_network/tom_basics_network.dart';");
    return imports.toString();
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [
      'package:tom_basics_network/tom_basics_network.dart',
    ];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'FrameState',
    'OperationState',
    'HeartbeatErrorType',
    'DLLogLevel',
  ];

}

// =============================================================================
// CleanupHandler Bridge
// =============================================================================

BridgedClass _createCleanupHandlerBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_1.CleanupHandler,
    name: 'CleanupHandler',
    constructors: {
    },
    methods: {
      'register': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_1.CleanupHandler>(target, 'CleanupHandler');
        D4.requireMinArgs(positional, 1, 'register');
        if (positional.isEmpty) {
          throw ArgumentError('register: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.register(() { return D4.callInterpreterCallback(visitor, callbackRaw, []) as Future<void>; });
      },
      'unregister': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_1.CleanupHandler>(target, 'CleanupHandler');
        D4.requireMinArgs(positional, 1, 'unregister');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'unregister');
        t.unregister(id);
        return null;
      },
      'cleanup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_1.CleanupHandler>(target, 'CleanupHandler');
        return t.cleanup();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_1.CleanupHandler>(target, 'CleanupHandler');
        t.dispose();
        return null;
      },
    },
    staticGetters: {
      'instance': (visitor) => $tom_dist_ledger_1.CleanupHandler.instance,
    },
    methodSignatures: {
      'register': 'int register(CleanupCallback callback)',
      'unregister': 'void unregister(int id)',
      'cleanup': 'Future<void> cleanup()',
      'dispose': 'void dispose()',
    },
    staticGetterSignatures: {
      'instance': 'CleanupHandler get instance',
    },
  );
}

// =============================================================================
// CallFrame Bridge
// =============================================================================

BridgedClass _createCallFrameBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_6.CallFrame,
    name: 'CallFrame',
    constructors: {
      '': (visitor, positional, named) {
        final participantId = D4.getRequiredNamedArg<String>(named, 'participantId', 'CallFrame');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'CallFrame');
        final pid = D4.getRequiredNamedArg<int>(named, 'pid', 'CallFrame');
        final startTime = D4.getRequiredNamedArg<DateTime>(named, 'startTime', 'CallFrame');
        final lastHeartbeat = D4.getOptionalNamedArg<DateTime?>(named, 'lastHeartbeat');
        final state = D4.getOptionalNamedArg<$tom_dist_ledger_6.FrameState?>(named, 'state');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final resources = D4.coerceListOrNull<String>(named['resources'], 'resources');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        return $tom_dist_ledger_6.CallFrame(participantId: participantId, callId: callId, pid: pid, startTime: startTime, lastHeartbeat: lastHeartbeat, state: state, description: description, resources: resources, failOnCrash: failOnCrash);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CallFrame');
        if (positional.isEmpty) {
          throw ArgumentError('CallFrame: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_dist_ledger_6.CallFrame.fromJson(json);
      },
    },
    getters: {
      'participantId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').participantId,
      'callId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').callId,
      'pid': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').pid,
      'startTime': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').startTime,
      'lastHeartbeat': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').lastHeartbeat,
      'state': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').state,
      'description': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').description,
      'resources': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').resources,
      'failOnCrash': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').failOnCrash,
      'heartbeatAgeMs': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').heartbeatAgeMs,
    },
    setters: {
      'lastHeartbeat': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').lastHeartbeat = value as DateTime,
      'state': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame').state = value as $tom_dist_ledger_6.FrameState,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame');
        return t.toJson();
      },
      'isStale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame');
        final timeoutMs = D4.getNamedArgWithDefault<int>(named, 'timeoutMs', 10000);
        return t.isStale(timeoutMs: timeoutMs);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_6.CallFrame>(target, 'CallFrame');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'CallFrame({required String participantId, required String callId, required int pid, required DateTime startTime, DateTime? lastHeartbeat, FrameState? state, String? description, List<String>? resources, bool failOnCrash = true})',
      'fromJson': 'factory CallFrame.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'isStale': 'bool isStale({int timeoutMs = 10000})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'participantId': 'String get participantId',
      'callId': 'String get callId',
      'pid': 'int get pid',
      'startTime': 'DateTime get startTime',
      'lastHeartbeat': 'DateTime get lastHeartbeat',
      'state': 'FrameState get state',
      'description': 'String? get description',
      'resources': 'List<String> get resources',
      'failOnCrash': 'bool get failOnCrash',
      'heartbeatAgeMs': 'int get heartbeatAgeMs',
    },
    setterSignatures: {
      'lastHeartbeat': 'set lastHeartbeat(dynamic value)',
      'state': 'set state(dynamic value)',
    },
  );
}

// =============================================================================
// TempResource Bridge
// =============================================================================

BridgedClass _createTempResourceBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_6.TempResource,
    name: 'TempResource',
    constructors: {
      '': (visitor, positional, named) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'TempResource');
        final owner = D4.getRequiredNamedArg<int>(named, 'owner', 'TempResource');
        final registeredAt = D4.getRequiredNamedArg<DateTime>(named, 'registeredAt', 'TempResource');
        return $tom_dist_ledger_6.TempResource(path: path, owner: owner, registeredAt: registeredAt);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TempResource');
        if (positional.isEmpty) {
          throw ArgumentError('TempResource: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_dist_ledger_6.TempResource.fromJson(json);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.TempResource>(target, 'TempResource').path,
      'owner': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.TempResource>(target, 'TempResource').owner,
      'registeredAt': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.TempResource>(target, 'TempResource').registeredAt,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_6.TempResource>(target, 'TempResource');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_6.TempResource>(target, 'TempResource');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TempResource({required String path, required int owner, required DateTime registeredAt})',
      'fromJson': 'factory TempResource.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'path': 'String get path',
      'owner': 'int get owner',
      'registeredAt': 'DateTime get registeredAt',
    },
  );
}

// =============================================================================
// LedgerData Bridge
// =============================================================================

BridgedClass _createLedgerDataBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_6.LedgerData,
    name: 'LedgerData',
    constructors: {
      '': (visitor, positional, named) {
        final operationId = D4.getRequiredNamedArg<String>(named, 'operationId', 'LedgerData');
        final initiatorId = D4.getRequiredNamedArg<String>(named, 'initiatorId', 'LedgerData');
        final startTime = D4.getOptionalNamedArg<DateTime?>(named, 'startTime');
        final aborted = D4.getNamedArgWithDefault<bool>(named, 'aborted', false);
        final lastHeartbeat = D4.getOptionalNamedArg<DateTime?>(named, 'lastHeartbeat');
        final callFrames = D4.coerceListOrNull<$tom_dist_ledger_6.CallFrame>(named['callFrames'], 'callFrames');
        final tempResources = D4.coerceListOrNull<$tom_dist_ledger_6.TempResource>(named['tempResources'], 'tempResources');
        final operationState = D4.getOptionalNamedArg<$tom_dist_ledger_6.OperationState?>(named, 'operationState');
        final detectionTimestamp = D4.getOptionalNamedArg<DateTime?>(named, 'detectionTimestamp');
        final removalTimestamp = D4.getOptionalNamedArg<DateTime?>(named, 'removalTimestamp');
        return $tom_dist_ledger_6.LedgerData(operationId: operationId, initiatorId: initiatorId, startTime: startTime, aborted: aborted, lastHeartbeat: lastHeartbeat, callFrames: callFrames, tempResources: tempResources, operationState: operationState, detectionTimestamp: detectionTimestamp, removalTimestamp: removalTimestamp);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LedgerData');
        if (positional.isEmpty) {
          throw ArgumentError('LedgerData: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_dist_ledger_6.LedgerData.fromJson(json);
      },
    },
    getters: {
      'operationId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').operationId,
      'initiatorId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').initiatorId,
      'startTime': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').startTime,
      'aborted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').aborted,
      'lastHeartbeat': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').lastHeartbeat,
      'callFrames': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').callFrames,
      'tempResources': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').tempResources,
      'operationState': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').operationState,
      'detectionTimestamp': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').detectionTimestamp,
      'removalTimestamp': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').removalTimestamp,
      'isEmpty': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').isEmpty,
    },
    setters: {
      'aborted': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').aborted = value as bool,
      'lastHeartbeat': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').lastHeartbeat = value as DateTime,
      'operationState': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').operationState = value as $tom_dist_ledger_6.OperationState,
      'detectionTimestamp': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').detectionTimestamp = value as DateTime?,
      'removalTimestamp': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData').removalTimestamp = value as DateTime?,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_6.LedgerData>(target, 'LedgerData');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LedgerData({required String operationId, required String initiatorId, DateTime? startTime, bool aborted = false, DateTime? lastHeartbeat, List<CallFrame>? callFrames, List<TempResource>? tempResources, OperationState? operationState, DateTime? detectionTimestamp, DateTime? removalTimestamp})',
      'fromJson': 'factory LedgerData.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'operationId': 'String get operationId',
      'initiatorId': 'String get initiatorId',
      'startTime': 'DateTime get startTime',
      'aborted': 'bool get aborted',
      'lastHeartbeat': 'DateTime get lastHeartbeat',
      'callFrames': 'List<CallFrame> get callFrames',
      'tempResources': 'List<TempResource> get tempResources',
      'operationState': 'OperationState get operationState',
      'detectionTimestamp': 'DateTime? get detectionTimestamp',
      'removalTimestamp': 'DateTime? get removalTimestamp',
      'isEmpty': 'bool get isEmpty',
    },
    setterSignatures: {
      'aborted': 'set aborted(dynamic value)',
      'lastHeartbeat': 'set lastHeartbeat(dynamic value)',
      'operationState': 'set operationState(dynamic value)',
      'detectionTimestamp': 'set detectionTimestamp(dynamic value)',
      'removalTimestamp': 'set removalTimestamp(dynamic value)',
    },
  );
}

// =============================================================================
// HeartbeatResult Bridge
// =============================================================================

BridgedClass _createHeartbeatResultBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_6.HeartbeatResult,
    name: 'HeartbeatResult',
    constructors: {
      '': (visitor, positional, named) {
        final abortFlag = D4.getRequiredNamedArg<bool>(named, 'abortFlag', 'HeartbeatResult');
        final ledgerExists = D4.getRequiredNamedArg<bool>(named, 'ledgerExists', 'HeartbeatResult');
        final heartbeatUpdated = D4.getRequiredNamedArg<bool>(named, 'heartbeatUpdated', 'HeartbeatResult');
        final callFrameCount = D4.getRequiredNamedArg<int>(named, 'callFrameCount', 'HeartbeatResult');
        final tempResourceCount = D4.getRequiredNamedArg<int>(named, 'tempResourceCount', 'HeartbeatResult');
        final heartbeatAgeMs = D4.getRequiredNamedArg<int>(named, 'heartbeatAgeMs', 'HeartbeatResult');
        final isStale = D4.getRequiredNamedArg<bool>(named, 'isStale', 'HeartbeatResult');
        if (!named.containsKey('participants') || named['participants'] == null) {
          throw ArgumentError('HeartbeatResult: Missing required named argument "participants"');
        }
        final participants = D4.coerceList<String>(named['participants'], 'participants');
        final participantHeartbeatAges = named.containsKey('participantHeartbeatAges') && named['participantHeartbeatAges'] != null
            ? D4.coerceMap<String, int>(named['participantHeartbeatAges'], 'participantHeartbeatAges')
            : const <String, int>{};
        final staleParticipants = named.containsKey('staleParticipants') && named['staleParticipants'] != null
            ? D4.coerceList<String>(named['staleParticipants'], 'staleParticipants')
            : const <String>[];
        final dataBefore = D4.getOptionalNamedArg<$tom_dist_ledger_6.LedgerData?>(named, 'dataBefore');
        final dataAfter = D4.getOptionalNamedArg<$tom_dist_ledger_6.LedgerData?>(named, 'dataAfter');
        return $tom_dist_ledger_6.HeartbeatResult(abortFlag: abortFlag, ledgerExists: ledgerExists, heartbeatUpdated: heartbeatUpdated, callFrameCount: callFrameCount, tempResourceCount: tempResourceCount, heartbeatAgeMs: heartbeatAgeMs, isStale: isStale, participants: participants, participantHeartbeatAges: participantHeartbeatAges, staleParticipants: staleParticipants, dataBefore: dataBefore, dataAfter: dataAfter);
      },
      'noLedger': (visitor, positional, named) {
        return $tom_dist_ledger_6.HeartbeatResult.noLedger();
      },
    },
    getters: {
      'abortFlag': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').abortFlag,
      'ledgerExists': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').ledgerExists,
      'heartbeatUpdated': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').heartbeatUpdated,
      'callFrameCount': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').callFrameCount,
      'tempResourceCount': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').tempResourceCount,
      'heartbeatAgeMs': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').heartbeatAgeMs,
      'isStale': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').isStale,
      'participants': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').participants,
      'participantHeartbeatAges': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').participantHeartbeatAges,
      'staleParticipants': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').staleParticipants,
      'dataBefore': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').dataBefore,
      'dataAfter': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').dataAfter,
      'hasStaleChildren': (visitor, target) => D4.validateTarget<$tom_dist_ledger_6.HeartbeatResult>(target, 'HeartbeatResult').hasStaleChildren,
    },
    constructorSignatures: {
      '': 'HeartbeatResult({required bool abortFlag, required bool ledgerExists, required bool heartbeatUpdated, required int callFrameCount, required int tempResourceCount, required int heartbeatAgeMs, required bool isStale, required List<String> participants, Map<String, int> participantHeartbeatAges = const {}, List<String> staleParticipants = const [], LedgerData? dataBefore, LedgerData? dataAfter})',
      'noLedger': 'factory HeartbeatResult.noLedger()',
    },
    getterSignatures: {
      'abortFlag': 'bool get abortFlag',
      'ledgerExists': 'bool get ledgerExists',
      'heartbeatUpdated': 'bool get heartbeatUpdated',
      'callFrameCount': 'int get callFrameCount',
      'tempResourceCount': 'int get tempResourceCount',
      'heartbeatAgeMs': 'int get heartbeatAgeMs',
      'isStale': 'bool get isStale',
      'participants': 'List<String> get participants',
      'participantHeartbeatAges': 'Map<String, int> get participantHeartbeatAges',
      'staleParticipants': 'List<String> get staleParticipants',
      'dataBefore': 'LedgerData? get dataBefore',
      'dataAfter': 'LedgerData? get dataAfter',
      'hasStaleChildren': 'bool get hasStaleChildren',
    },
  );
}

// =============================================================================
// HeartbeatError Bridge
// =============================================================================

BridgedClass _createHeartbeatErrorBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_4.HeartbeatError,
    name: 'HeartbeatError',
    constructors: {
      '': (visitor, positional, named) {
        final type = D4.getRequiredNamedArg<$tom_dist_ledger_4.HeartbeatErrorType>(named, 'type', 'HeartbeatError');
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'HeartbeatError');
        final cause = D4.getOptionalNamedArg<Object?>(named, 'cause');
        return $tom_dist_ledger_4.HeartbeatError(type: type, message: message, cause: cause);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_dist_ledger_4.HeartbeatError>(target, 'HeartbeatError').type,
      'message': (visitor, target) => D4.validateTarget<$tom_dist_ledger_4.HeartbeatError>(target, 'HeartbeatError').message,
      'cause': (visitor, target) => D4.validateTarget<$tom_dist_ledger_4.HeartbeatError>(target, 'HeartbeatError').cause,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_4.HeartbeatError>(target, 'HeartbeatError');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const HeartbeatError({required HeartbeatErrorType type, required String message, Object? cause})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'HeartbeatErrorType get type',
      'message': 'String get message',
      'cause': 'Object? get cause',
    },
  );
}

// =============================================================================
// Operation Bridge
// =============================================================================

BridgedClass _createOperationBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_3.Operation,
    name: 'Operation',
    constructors: {
    },
    getters: {
      'operationId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').operationId,
      'participantId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').participantId,
      'isInitiator': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').isInitiator,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').sessionId,
      'startTime': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').startTime,
      'isAborted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').isAborted,
      'onAbort': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').onAbort,
      'onFailure': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').onFailure,
      'elapsedFormatted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').elapsedFormatted,
      'elapsedDuration': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').elapsedDuration,
      'startTimeIso': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').startTimeIso,
      'startTimeMs': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').startTimeMs,
      'pendingCallCount': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').pendingCallCount,
      'cachedData': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation').cachedData,
    },
    methods: {
      'startCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        return t.startCall(callback: callback, description: description, failOnCrash: failOnCrash);
      },
      'hasPendingCalls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        return t.hasPendingCalls();
      },
      'spawnCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        if (!named.containsKey('work') || named['work'] == null) {
          throw ArgumentError('spawnCall: Missing required named argument "work"');
        }
        final workRaw = named['work'];
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        return t.spawnCall(work: ($tom_dist_ledger_2.SpawnedCall<dynamic> p0, $tom_dist_ledger_3.Operation p1) { return D4.callInterpreterCallback(visitor, workRaw, [p0, p1]) as Future<dynamic>; }, callback: callback, description: description, failOnCrash: failOnCrash);
      },
      'sync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        D4.requireMinArgs(positional, 1, 'sync');
        if (positional.isEmpty) {
          throw ArgumentError('sync: Missing required argument "calls" at position 0');
        }
        final calls = D4.coerceList<$tom_dist_ledger_2.SpawnedCall<dynamic>>(positional[0], 'calls');
        final onOperationFailedRaw = named['onOperationFailed'];
        final onCompletionRaw = named['onCompletion'];
        return t.sync(calls, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onCompletion: onCompletionRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCompletionRaw, []) as Future<void>; });
      },
      'awaitCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        D4.requireMinArgs(positional, 1, 'awaitCall');
        final call = D4.getRequiredArg<$tom_dist_ledger_2.SpawnedCall<dynamic>>(positional, 0, 'call', 'awaitCall');
        final onOperationFailedRaw = named['onOperationFailed'];
        final onCompletionRaw = named['onCompletion'];
        return t.awaitCall(call, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onCompletion: onCompletionRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCompletionRaw, []) as Future<void>; });
      },
      'waitForCompletion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        D4.requireMinArgs(positional, 1, 'waitForCompletion');
        if (positional.isEmpty) {
          throw ArgumentError('waitForCompletion: Missing required argument "work" at position 0');
        }
        final workRaw = positional[0];
        final onOperationFailedRaw = named['onOperationFailed'];
        final onErrorRaw = named['onError'];
        return t.waitForCompletion(() { return D4.callInterpreterCallback(visitor, workRaw, []) as Future<dynamic>; }, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onError: onErrorRaw == null ? null : (Object p0, StackTrace p1) { return D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]) as Future<dynamic>; });
      },
      'leave': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        final cancelPendingCalls = D4.getNamedArgWithDefault<bool>(named, 'cancelPendingCalls', false);
        return t.leave(cancelPendingCalls: cancelPendingCalls);
      },
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        final level = D4.getNamedArgWithDefault<$tom_dist_ledger_2.DLLogLevel>(named, 'level', $tom_dist_ledger_2.DLLogLevel.info);
        return t.log(message, level: level);
      },
      'complete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        return t.complete();
      },
      'setAbortFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        D4.requireMinArgs(positional, 1, 'setAbortFlag');
        final value = D4.getRequiredArg<bool>(positional, 0, 'value', 'setAbortFlag');
        return t.setAbortFlag(value);
      },
      'checkAbort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        return t.checkAbort();
      },
      'triggerAbort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        t.triggerAbort();
        return null;
      },
      'startHeartbeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        final onErrorRaw = named['onError'];
        final onSuccessRaw = named['onSuccess'];
        t.startHeartbeat(onError: onErrorRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_4.HeartbeatError p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); }, onSuccess: onSuccessRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_6.HeartbeatResult p1) { D4.callInterpreterCallback(visitor, onSuccessRaw, [p0, p1]); });
        return null;
      },
      'createCallFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'createCallFrame');
        return t.createCallFrame(callId: callId);
      },
      'deleteCallFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'deleteCallFrame');
        return t.deleteCallFrame(callId: callId);
      },
      'registerTempResource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'registerTempResource');
        return t.registerTempResource(path: path);
      },
      'unregisterTempResource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Operation>(target, 'Operation');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'unregisterTempResource');
        return t.unregisterTempResource(path: path);
      },
    },
    methodSignatures: {
      'startCall': 'Future<Call<T>> startCall({CallCallback<T>? callback, String? description, bool failOnCrash = true})',
      'hasPendingCalls': 'bool hasPendingCalls()',
      'spawnCall': 'SpawnedCall<T> spawnCall({required Future<T> Function(SpawnedCall<T> call, Operation operation) work, CallCallback<T>? callback, String? description, bool failOnCrash = true})',
      'sync': 'Future<SyncResult> sync(List<SpawnedCall<dynamic>> calls, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<void> Function()? onCompletion})',
      'awaitCall': 'Future<SyncResult> awaitCall(SpawnedCall<T> call, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<void> Function()? onCompletion})',
      'waitForCompletion': 'Future<T> waitForCompletion(Future<T> Function() work, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<T> Function(Object error, StackTrace stackTrace)? onError})',
      'leave': 'FutureOr<void> leave({bool cancelPendingCalls = false})',
      'log': 'Future<void> log(String message, {DLLogLevel level = DLLogLevel.info})',
      'complete': 'Future<void> complete()',
      'setAbortFlag': 'Future<void> setAbortFlag(bool value)',
      'checkAbort': 'Future<bool> checkAbort()',
      'triggerAbort': 'void triggerAbort()',
      'startHeartbeat': 'void startHeartbeat({HeartbeatErrorCallback? onError, HeartbeatSuccessCallback? onSuccess})',
      'createCallFrame': 'Future<void> createCallFrame({required String callId})',
      'deleteCallFrame': 'Future<void> deleteCallFrame({required String callId})',
      'registerTempResource': 'Future<void> registerTempResource({required String path})',
      'unregisterTempResource': 'Future<void> unregisterTempResource({required String path})',
    },
    getterSignatures: {
      'operationId': 'String get operationId',
      'participantId': 'String get participantId',
      'isInitiator': 'bool get isInitiator',
      'sessionId': 'int get sessionId',
      'startTime': 'DateTime get startTime',
      'isAborted': 'bool get isAborted',
      'onAbort': 'Future<void> get onAbort',
      'onFailure': 'Future<OperationFailedInfo> get onFailure',
      'elapsedFormatted': 'String get elapsedFormatted',
      'elapsedDuration': 'Duration get elapsedDuration',
      'startTimeIso': 'String get startTimeIso',
      'startTimeMs': 'int get startTimeMs',
      'pendingCallCount': 'int get pendingCallCount',
      'cachedData': 'LedgerData? get cachedData',
    },
  );
}

// =============================================================================
// Ledger Bridge
// =============================================================================

BridgedClass _createLedgerBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_3.Ledger,
    name: 'Ledger',
    constructors: {
    },
    getters: {
      'participantId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger').participantId,
      'participantPid': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger').participantPid,
      'maxBackups': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger').maxBackups,
      'heartbeatInterval': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger').heartbeatInterval,
      'staleThreshold': (visitor, target) => D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger').staleThreshold,
    },
    methods: {
      'createOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.OperationCallback?>(named, 'callback');
        return t.createOperation(description: description, callback: callback);
      },
      'joinOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger');
        final operationId = D4.getRequiredNamedArg<String>(named, 'operationId', 'joinOperation');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.OperationCallback?>(named, 'callback');
        return t.joinOperation(operationId: operationId, callback: callback);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_3.Ledger>(target, 'Ledger');
        t.dispose();
        return null;
      },
    },
    staticMethods: {
      'connect': (visitor, positional, named, typeArgs) {
        final participantId = D4.getRequiredNamedArg<String>(named, 'participantId', 'connect');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        final serverUrl = D4.getOptionalNamedArg<String?>(named, 'serverUrl');
        final participantPid = D4.getOptionalNamedArg<int?>(named, 'participantPid');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.LedgerCallback?>(named, 'callback');
        final maxBackups = D4.getNamedArgWithDefault<int>(named, 'maxBackups', 20);
        final heartbeatInterval = D4.getNamedArgWithDefault<Duration>(named, 'heartbeatInterval', const Duration(seconds: 5));
        final staleThreshold = D4.getNamedArgWithDefault<Duration>(named, 'staleThreshold', const Duration(seconds: 15));
        return $tom_dist_ledger_3.Ledger.connect(participantId: participantId, basePath: basePath, serverUrl: serverUrl, participantPid: participantPid, callback: callback, maxBackups: maxBackups, heartbeatInterval: heartbeatInterval, staleThreshold: staleThreshold);
      },
    },
    methodSignatures: {
      'createOperation': 'Future<Operation> createOperation({String? description, OperationCallback? callback})',
      'joinOperation': 'Future<Operation> joinOperation({required String operationId, OperationCallback? callback})',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'participantId': 'String get participantId',
      'participantPid': 'int get participantPid',
      'maxBackups': 'int get maxBackups',
      'heartbeatInterval': 'Duration get heartbeatInterval',
      'staleThreshold': 'Duration get staleThreshold',
    },
    staticMethodSignatures: {
      'connect': 'Future<Ledger?> connect({required String participantId, String? basePath, String? serverUrl, int? participantPid, LedgerCallback? callback, int maxBackups = 20, Duration heartbeatInterval = const Duration(seconds: 5), Duration staleThreshold = const Duration(seconds: 15)})',
    },
  );
}

// =============================================================================
// LocalOperation Bridge
// =============================================================================

BridgedClass _createLocalOperationBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.LocalOperation,
    name: 'LocalOperation',
    constructors: {
    },
    getters: {
      'sessionId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').sessionId,
      'operationId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').operationId,
      'participantId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').participantId,
      'pid': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').pid,
      'isInitiator': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').isInitiator,
      'startTime': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').startTime,
      'cachedData': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').cachedData,
      'lastChangeTimestamp': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').lastChangeTimestamp,
      'isAborted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').isAborted,
      'onAbort': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').onAbort,
      'onFailure': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').onFailure,
      'elapsedFormatted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').elapsedFormatted,
      'elapsedDuration': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').elapsedDuration,
      'startTimeIso': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').startTimeIso,
      'startTimeMs': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').startTimeMs,
      'stalenessThresholdMs': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').stalenessThresholdMs,
      'pendingCallCount': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').pendingCallCount,
    },
    setters: {
      'stalenessThresholdMs': (visitor, target, value) => 
        D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation').stalenessThresholdMs = value as dynamic,
    },
    methods: {
      'startCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        return t.startCall(callback: callback, description: description, failOnCrash: failOnCrash);
      },
      'spawnCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        if (!named.containsKey('work') || named['work'] == null) {
          throw ArgumentError('spawnCall: Missing required named argument "work"');
        }
        final workRaw = named['work'];
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        return t.spawnCall(work: ($tom_dist_ledger_2.SpawnedCall<dynamic> p0, $tom_dist_ledger_3.Operation p1) { return D4.callInterpreterCallback(visitor, workRaw, [p0, p1]) as Future<dynamic>; }, callback: callback, description: description, failOnCrash: failOnCrash);
      },
      'hasPendingCalls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.hasPendingCalls();
      },
      'getPendingSpawnedCalls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.getPendingSpawnedCalls();
      },
      'getPendingCalls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.getPendingCalls();
      },
      'leave': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final cancelPendingCalls = D4.getNamedArgWithDefault<bool>(named, 'cancelPendingCalls', false);
        t.leave(cancelPendingCalls: cancelPendingCalls);
        return null;
      },
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        final level = D4.getNamedArgWithDefault<$tom_dist_ledger_2.DLLogLevel>(named, 'level', $tom_dist_ledger_2.DLLogLevel.info);
        return t.log(message, level: level);
      },
      'complete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.complete();
      },
      'setAbortFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'setAbortFlag');
        final value = D4.getRequiredArg<bool>(positional, 0, 'value', 'setAbortFlag');
        return t.setAbortFlag(value);
      },
      'checkAbort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.checkAbort();
      },
      'triggerAbort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        t.triggerAbort();
        return null;
      },
      'waitForCompletion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'waitForCompletion');
        if (positional.isEmpty) {
          throw ArgumentError('waitForCompletion: Missing required argument "work" at position 0');
        }
        final workRaw = positional[0];
        final onOperationFailedRaw = named['onOperationFailed'];
        final onErrorRaw = named['onError'];
        return t.waitForCompletion(() { return D4.callInterpreterCallback(visitor, workRaw, []) as Future<dynamic>; }, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onError: onErrorRaw == null ? null : (Object p0, StackTrace p1) { return D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]) as Future<dynamic>; });
      },
      'startHeartbeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final interval = D4.getNamedArgWithDefault<Duration>(named, 'interval', const Duration(milliseconds: 4500));
        final jitterMs = D4.getNamedArgWithDefault<int>(named, 'jitterMs', 500);
        final onErrorRaw = named['onError'];
        final onSuccessRaw = named['onSuccess'];
        t.startHeartbeat(interval: interval, jitterMs: jitterMs, onError: onErrorRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_4.HeartbeatError p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); }, onSuccess: onSuccessRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_6.HeartbeatResult p1) { D4.callInterpreterCallback(visitor, onSuccessRaw, [p0, p1]); });
        return null;
      },
      'stopHeartbeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        t.stopHeartbeat();
        return null;
      },
      'sync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'sync');
        if (positional.isEmpty) {
          throw ArgumentError('sync: Missing required argument "calls" at position 0');
        }
        final calls = D4.coerceList<$tom_dist_ledger_2.SpawnedCall>(positional[0], 'calls');
        final onOperationFailedRaw = named['onOperationFailed'];
        final onCompletionRaw = named['onCompletion'];
        return t.sync(calls, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onCompletion: onCompletionRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCompletionRaw, []) as Future<void>; });
      },
      'execFileResultWorker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final executable = D4.getRequiredNamedArg<String>(named, 'executable', 'execFileResultWorker');
        if (!named.containsKey('arguments') || named['arguments'] == null) {
          throw ArgumentError('execFileResultWorker: Missing required named argument "arguments"');
        }
        final arguments = D4.coerceList<String>(named['arguments'], 'arguments');
        final resultFilePath = D4.getRequiredNamedArg<String>(named, 'resultFilePath', 'execFileResultWorker');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final deserializerRaw = named['deserializer'];
        final deleteResultFile = D4.getNamedArgWithDefault<bool>(named, 'deleteResultFile', true);
        final pollInterval = D4.getNamedArgWithDefault<Duration>(named, 'pollInterval', const Duration(milliseconds: 100));
        final timeout = D4.getOptionalNamedArg<Duration?>(named, 'timeout');
        final onStdoutRaw = named['onStdout'];
        final onStderrRaw = named['onStderr'];
        final onExitRaw = named['onExit'];
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        return t.execFileResultWorker(executable: executable, arguments: arguments, resultFilePath: resultFilePath, workingDirectory: workingDirectory, description: description, deserializer: deserializerRaw == null ? null : (String p0) { return D4.callInterpreterCallback(visitor, deserializerRaw, [p0]) as dynamic; }, deleteResultFile: deleteResultFile, pollInterval: pollInterval, timeout: timeout, onStdout: onStdoutRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onStdoutRaw, [p0]); }, onStderr: onStderrRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onStderrRaw, [p0]); }, onExit: onExitRaw == null ? null : (int p0) { D4.callInterpreterCallback(visitor, onExitRaw, [p0]); }, failOnCrash: failOnCrash, callback: callback);
      },
      'execStdioWorker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final executable = D4.getRequiredNamedArg<String>(named, 'executable', 'execStdioWorker');
        if (!named.containsKey('arguments') || named['arguments'] == null) {
          throw ArgumentError('execStdioWorker: Missing required named argument "arguments"');
        }
        final arguments = D4.coerceList<String>(named['arguments'], 'arguments');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final deserializerRaw = named['deserializer'];
        final onStderrRaw = named['onStderr'];
        final onExitRaw = named['onExit'];
        final timeout = D4.getOptionalNamedArg<Duration?>(named, 'timeout');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        return t.execStdioWorker(executable: executable, arguments: arguments, workingDirectory: workingDirectory, description: description, deserializer: deserializerRaw == null ? null : (String p0) { return D4.callInterpreterCallback(visitor, deserializerRaw, [p0]) as dynamic; }, onStderr: onStderrRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onStderrRaw, [p0]); }, onExit: onExitRaw == null ? null : (int p0) { D4.callInterpreterCallback(visitor, onExitRaw, [p0]); }, timeout: timeout, failOnCrash: failOnCrash, callback: callback);
      },
      'awaitCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'awaitCall');
        final call = D4.getRequiredArg<$tom_dist_ledger_2.SpawnedCall<dynamic>>(positional, 0, 'call', 'awaitCall');
        final onOperationFailedRaw = named['onOperationFailed'];
        final onCompletionRaw = named['onCompletion'];
        return t.awaitCall(call, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onCompletion: onCompletionRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCompletionRaw, []) as Future<void>; });
      },
      'debugLog': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'debugLog');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'debugLog');
        return t.debugLog(message);
      },
      'getOperationState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.getOperationState();
      },
      'setOperationState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'setOperationState');
        final state = D4.getRequiredArg<$tom_dist_ledger_6.OperationState>(positional, 0, 'state', 'setOperationState');
        return t.setOperationState(state);
      },
      'heartbeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.heartbeat();
      },
      'logMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final depth = D4.getRequiredNamedArg<int>(named, 'depth', 'logMessage');
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'logMessage');
        return t.logMessage(depth: depth, message: message);
      },
      'createCallFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'createCallFrame');
        return t.createCallFrame(callId: callId);
      },
      'deleteCallFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'deleteCallFrame');
        return t.deleteCallFrame(callId: callId);
      },
      'registerTempResource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'registerTempResource');
        return t.registerTempResource(path: path);
      },
      'unregisterTempResource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'unregisterTempResource');
        return t.unregisterTempResource(path: path);
      },
      'retrieveAndLockOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.retrieveAndLockOperation();
      },
      'unlockOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        return t.unlockOperation();
      },
      'writeAndUnlockOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        D4.requireMinArgs(positional, 1, 'writeAndUnlockOperation');
        final data = D4.getRequiredArg<$tom_dist_ledger_6.LedgerData>(positional, 0, 'data', 'writeAndUnlockOperation');
        return t.writeAndUnlockOperation(data);
      },
      'execServerRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalOperation>(target, 'LocalOperation');
        if (!named.containsKey('work') || named['work'] == null) {
          throw ArgumentError('execServerRequest: Missing required named argument "work"');
        }
        final workRaw = named['work'];
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final timeout = D4.getOptionalNamedArg<Duration?>(named, 'timeout');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        return t.execServerRequest(work: () { return D4.callInterpreterCallback(visitor, workRaw, []) as Future<dynamic>; }, description: description, timeout: timeout, failOnCrash: failOnCrash, callback: callback);
      },
    },
    methodSignatures: {
      'startCall': 'Future<Call<T>> startCall({CallCallback<T>? callback, String? description, bool failOnCrash = true})',
      'spawnCall': 'SpawnedCall<T> spawnCall({required Future<T> Function(SpawnedCall<T> call, Operation operation) work, CallCallback<T>? callback, String? description, bool failOnCrash = true})',
      'hasPendingCalls': 'bool hasPendingCalls()',
      'getPendingSpawnedCalls': 'List<SpawnedCall> getPendingSpawnedCalls()',
      'getPendingCalls': 'List<Call<dynamic>> getPendingCalls()',
      'leave': 'void leave({bool cancelPendingCalls = false})',
      'log': 'Future<void> log(String message, {DLLogLevel level = DLLogLevel.info})',
      'complete': 'Future<void> complete()',
      'setAbortFlag': 'Future<void> setAbortFlag(bool value)',
      'checkAbort': 'Future<bool> checkAbort()',
      'triggerAbort': 'void triggerAbort()',
      'waitForCompletion': 'Future<T> waitForCompletion(Future<T> Function() work, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<T> Function(Object error, StackTrace stackTrace)? onError})',
      'startHeartbeat': 'void startHeartbeat({Duration interval = const Duration(milliseconds: 4500), int jitterMs = 500, HeartbeatErrorCallback? onError, HeartbeatSuccessCallback? onSuccess})',
      'stopHeartbeat': 'void stopHeartbeat()',
      'sync': 'Future<SyncResult> sync(List<SpawnedCall> calls, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<void> Function()? onCompletion})',
      'execFileResultWorker': 'SpawnedCall<T> execFileResultWorker({required String executable, required List<String> arguments, required String resultFilePath, String? workingDirectory, String? description, T Function(String content)? deserializer, bool deleteResultFile = true, Duration pollInterval = const Duration(milliseconds: 100), Duration? timeout, void Function(String line)? onStdout, void Function(String line)? onStderr, void Function(int exitCode)? onExit, bool failOnCrash = true, CallCallback<T>? callback})',
      'execStdioWorker': 'SpawnedCall<T> execStdioWorker({required String executable, required List<String> arguments, String? workingDirectory, String? description, T Function(String content)? deserializer, void Function(String line)? onStderr, void Function(int exitCode)? onExit, Duration? timeout, bool failOnCrash = true, CallCallback<T>? callback})',
      'awaitCall': 'Future<SyncResult> awaitCall(SpawnedCall<T> call, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<void> Function()? onCompletion})',
      'debugLog': 'Future<void> debugLog(String message)',
      'getOperationState': 'Future<OperationState?> getOperationState()',
      'setOperationState': 'Future<void> setOperationState(OperationState state)',
      'heartbeat': 'Future<HeartbeatResult?> heartbeat()',
      'logMessage': 'Future<void> logMessage({required int depth, required String message})',
      'createCallFrame': 'Future<void> createCallFrame({required String callId})',
      'deleteCallFrame': 'Future<void> deleteCallFrame({required String callId})',
      'registerTempResource': 'Future<void> registerTempResource({required String path})',
      'unregisterTempResource': 'Future<void> unregisterTempResource({required String path})',
      'retrieveAndLockOperation': 'Future<LedgerData?> retrieveAndLockOperation()',
      'unlockOperation': 'Future<void> unlockOperation()',
      'writeAndUnlockOperation': 'Future<void> writeAndUnlockOperation(LedgerData data)',
      'execServerRequest': 'SpawnedCall<T> execServerRequest({required Future<T> Function() work, String? description, Duration? timeout, bool failOnCrash = true, CallCallback<T>? callback})',
    },
    getterSignatures: {
      'sessionId': 'int get sessionId',
      'operationId': 'String get operationId',
      'participantId': 'String get participantId',
      'pid': 'int get pid',
      'isInitiator': 'bool get isInitiator',
      'startTime': 'DateTime get startTime',
      'cachedData': 'LedgerData? get cachedData',
      'lastChangeTimestamp': 'DateTime? get lastChangeTimestamp',
      'isAborted': 'bool get isAborted',
      'onAbort': 'Future<void> get onAbort',
      'onFailure': 'Future<OperationFailedInfo> get onFailure',
      'elapsedFormatted': 'String get elapsedFormatted',
      'elapsedDuration': 'Duration get elapsedDuration',
      'startTimeIso': 'String get startTimeIso',
      'startTimeMs': 'int get startTimeMs',
      'stalenessThresholdMs': 'int get stalenessThresholdMs',
      'pendingCallCount': 'int get pendingCallCount',
    },
    setterSignatures: {
      'stalenessThresholdMs': 'set stalenessThresholdMs(int value)',
    },
  );
}

// =============================================================================
// LocalLedger Bridge
// =============================================================================

BridgedClass _createLocalLedgerBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.LocalLedger,
    name: 'LocalLedger',
    constructors: {
      '': (visitor, positional, named) {
        final basePath = D4.getRequiredNamedArg<String>(named, 'basePath', 'LocalLedger');
        final participantId = D4.getRequiredNamedArg<String>(named, 'participantId', 'LocalLedger');
        final participantPid = D4.getOptionalNamedArg<int?>(named, 'participantPid');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.LedgerCallback?>(named, 'callback');
        final maxBackups = D4.getNamedArgWithDefault<int>(named, 'maxBackups', 20);
        final heartbeatInterval = D4.getNamedArgWithDefault<Duration>(named, 'heartbeatInterval', const Duration(seconds: 5));
        final staleThreshold = D4.getNamedArgWithDefault<Duration>(named, 'staleThreshold', const Duration(seconds: 15));
        final lockTimeout = D4.getNamedArgWithDefault<Duration>(named, 'lockTimeout', const Duration(seconds: 2));
        final lockRetryInterval = D4.getNamedArgWithDefault<Duration>(named, 'lockRetryInterval', const Duration(milliseconds: 50));
        final maxLockRetryInterval = D4.getNamedArgWithDefault<Duration>(named, 'maxLockRetryInterval', const Duration(milliseconds: 500));
        return $tom_dist_ledger_2.LocalLedger(basePath: basePath, participantId: participantId, participantPid: participantPid, callback: callback, maxBackups: maxBackups, heartbeatInterval: heartbeatInterval, staleThreshold: staleThreshold, lockTimeout: lockTimeout, lockRetryInterval: lockRetryInterval, maxLockRetryInterval: maxLockRetryInterval);
      },
    },
    getters: {
      'participantId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').participantId,
      'participantPid': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').participantPid,
      'maxBackups': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').maxBackups,
      'heartbeatInterval': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').heartbeatInterval,
      'staleThreshold': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').staleThreshold,
      'basePath': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').basePath,
      'callback': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').callback,
      'lockTimeout': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').lockTimeout,
      'lockRetryInterval': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').lockRetryInterval,
      'maxLockRetryInterval': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger').maxLockRetryInterval,
    },
    methods: {
      'createOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.OperationCallback?>(named, 'callback');
        return t.createOperation(description: description, callback: callback);
      },
      'joinOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger');
        final operationId = D4.getRequiredNamedArg<String>(named, 'operationId', 'joinOperation');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.OperationCallback?>(named, 'callback');
        return t.joinOperation(operationId: operationId, callback: callback);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LocalLedger>(target, 'LocalLedger');
        t.dispose();
        return null;
      },
    },
    constructorSignatures: {
      '': 'LocalLedger({required String basePath, required String participantId, int? participantPid, LedgerCallback? callback, int maxBackups = 20, Duration heartbeatInterval = const Duration(seconds: 5), Duration staleThreshold = const Duration(seconds: 15), Duration lockTimeout = const Duration(seconds: 2), Duration lockRetryInterval = const Duration(milliseconds: 50), Duration maxLockRetryInterval = const Duration(milliseconds: 500)})',
    },
    methodSignatures: {
      'createOperation': 'Future<LocalOperation> createOperation({String? description, OperationCallback? callback})',
      'joinOperation': 'Future<LocalOperation> joinOperation({required String operationId, OperationCallback? callback})',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'participantId': 'String get participantId',
      'participantPid': 'int get participantPid',
      'maxBackups': 'int get maxBackups',
      'heartbeatInterval': 'Duration get heartbeatInterval',
      'staleThreshold': 'Duration get staleThreshold',
      'basePath': 'String get basePath',
      'callback': 'LedgerCallback? get callback',
      'lockTimeout': 'Duration get lockTimeout',
      'lockRetryInterval': 'Duration get lockRetryInterval',
      'maxLockRetryInterval': 'Duration get maxLockRetryInterval',
    },
  );
}

// =============================================================================
// LedgerCallback Bridge
// =============================================================================

BridgedClass _createLedgerCallbackBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.LedgerCallback,
    name: 'LedgerCallback',
    constructors: {
      '': (visitor, positional, named) {
        final onBackupCreatedRaw = named['onBackupCreated'];
        final onLogLineRaw = named['onLogLine'];
        final onGlobalHeartbeatErrorRaw = named['onGlobalHeartbeatError'];
        return $tom_dist_ledger_2.LedgerCallback(onBackupCreated: onBackupCreatedRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onBackupCreatedRaw, [p0]); }, onLogLine: onLogLineRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onLogLineRaw, [p0]); }, onGlobalHeartbeatError: onGlobalHeartbeatErrorRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_4.HeartbeatError p1) { D4.callInterpreterCallback(visitor, onGlobalHeartbeatErrorRaw, [p0, p1]); });
      },
      'onBackup': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LedgerCallback');
        if (positional.isEmpty) {
          throw ArgumentError('LedgerCallback: Missing required argument "onBackup" at position 0');
        }
        final onBackupRaw = positional[0];
        return $tom_dist_ledger_2.LedgerCallback.onBackup((String p0) { D4.callInterpreterCallback(visitor, onBackupRaw, [p0]); });
      },
    },
    getters: {
      'onBackupCreated': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LedgerCallback>(target, 'LedgerCallback').onBackupCreated,
      'onLogLine': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LedgerCallback>(target, 'LedgerCallback').onLogLine,
      'onGlobalHeartbeatError': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LedgerCallback>(target, 'LedgerCallback').onGlobalHeartbeatError,
    },
    constructorSignatures: {
      '': 'const LedgerCallback({void Function(String)? onBackupCreated, void Function(String)? onLogLine, void Function(Operation, HeartbeatError)? onGlobalHeartbeatError})',
      'onBackup': 'factory LedgerCallback.onBackup(void Function(String path) onBackup)',
    },
    getterSignatures: {
      'onBackupCreated': 'void Function(String path)? get onBackupCreated',
      'onLogLine': 'void Function(String line)? get onLogLine',
      'onGlobalHeartbeatError': 'void Function(Operation operation, HeartbeatError error)? get onGlobalHeartbeatError',
    },
  );
}

// =============================================================================
// OperationCallback Bridge
// =============================================================================

BridgedClass _createOperationCallbackBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.OperationCallback,
    name: 'OperationCallback',
    constructors: {
      '': (visitor, positional, named) {
        final onHeartbeatSuccessRaw = named['onHeartbeatSuccess'];
        final onHeartbeatErrorRaw = named['onHeartbeatError'];
        final onAbortRaw = named['onAbort'];
        final onFailureRaw = named['onFailure'];
        return $tom_dist_ledger_2.OperationCallback(onHeartbeatSuccess: onHeartbeatSuccessRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_6.HeartbeatResult p1) { D4.callInterpreterCallback(visitor, onHeartbeatSuccessRaw, [p0, p1]); }, onHeartbeatError: onHeartbeatErrorRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_4.HeartbeatError p1) { D4.callInterpreterCallback(visitor, onHeartbeatErrorRaw, [p0, p1]); }, onAbort: onAbortRaw == null ? null : ($tom_dist_ledger_3.Operation p0) { D4.callInterpreterCallback(visitor, onAbortRaw, [p0]); }, onFailure: onFailureRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_2.OperationFailedInfo p1) { D4.callInterpreterCallback(visitor, onFailureRaw, [p0, p1]); });
      },
      'onError': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OperationCallback');
        if (positional.isEmpty) {
          throw ArgumentError('OperationCallback: Missing required argument "onError" at position 0');
        }
        final onErrorRaw = positional[0];
        return $tom_dist_ledger_2.OperationCallback.onError(($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_4.HeartbeatError p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); });
      },
      'onFailure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OperationCallback');
        if (positional.isEmpty) {
          throw ArgumentError('OperationCallback: Missing required argument "onFailure" at position 0');
        }
        final onFailureRaw = positional[0];
        return $tom_dist_ledger_2.OperationCallback.onFailure(($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_2.OperationFailedInfo p1) { D4.callInterpreterCallback(visitor, onFailureRaw, [p0, p1]); });
      },
    },
    getters: {
      'onHeartbeatSuccess': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationCallback>(target, 'OperationCallback').onHeartbeatSuccess,
      'onHeartbeatError': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationCallback>(target, 'OperationCallback').onHeartbeatError,
      'onAbort': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationCallback>(target, 'OperationCallback').onAbort,
      'onFailure': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationCallback>(target, 'OperationCallback').onFailure,
    },
    constructorSignatures: {
      '': 'const OperationCallback({void Function(Operation, HeartbeatResult)? onHeartbeatSuccess, void Function(Operation, HeartbeatError)? onHeartbeatError, void Function(Operation)? onAbort, void Function(Operation, OperationFailedInfo)? onFailure})',
      'onError': 'factory OperationCallback.onError(void Function(Operation operation, HeartbeatError error) onError)',
      'onFailure': 'factory OperationCallback.onFailure(void Function(Operation operation, OperationFailedInfo info) onFailure)',
    },
    getterSignatures: {
      'onHeartbeatSuccess': 'void Function(Operation operation, HeartbeatResult result)? get onHeartbeatSuccess',
      'onHeartbeatError': 'void Function(Operation operation, HeartbeatError error)? get onHeartbeatError',
      'onAbort': 'void Function(Operation operation)? get onAbort',
      'onFailure': 'void Function(Operation operation, OperationFailedInfo info)? get onFailure',
    },
  );
}

// =============================================================================
// CallCallback Bridge
// =============================================================================

BridgedClass _createCallCallbackBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.CallCallback,
    name: 'CallCallback',
    constructors: {
      '': (visitor, positional, named) {
        final onCleanupRaw = named['onCleanup'];
        final onCompletionRaw = named['onCompletion'];
        final onCallCrashedRaw = named['onCallCrashed'];
        final onOperationFailedRaw = named['onOperationFailed'];
        return $tom_dist_ledger_2.CallCallback(onCleanup: onCleanupRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCleanupRaw, []) as Future<void>; }, onCompletion: onCompletionRaw == null ? null : (dynamic p0) { return D4.callInterpreterCallback(visitor, onCompletionRaw, [p0]) as Future<void>; }, onCallCrashed: onCallCrashedRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCallCrashedRaw, []) as Future<dynamic>; }, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; });
      },
      'cleanup': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CallCallback');
        if (positional.isEmpty) {
          throw ArgumentError('CallCallback: Missing required argument "onCleanup" at position 0');
        }
        final onCleanupRaw = positional[0];
        return $tom_dist_ledger_2.CallCallback.cleanup(() { return D4.callInterpreterCallback(visitor, onCleanupRaw, []) as Future<void>; });
      },
    },
    getters: {
      'onCleanup': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.CallCallback>(target, 'CallCallback').onCleanup,
      'onCompletion': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.CallCallback>(target, 'CallCallback').onCompletion,
      'onCallCrashed': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.CallCallback>(target, 'CallCallback').onCallCrashed,
      'onOperationFailed': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.CallCallback>(target, 'CallCallback').onOperationFailed,
    },
    constructorSignatures: {
      '': 'CallCallback({Future<void> Function()? onCleanup, Future<void> Function(T)? onCompletion, Future<T?> Function()? onCallCrashed, Future<void> Function(OperationFailedInfo)? onOperationFailed})',
      'cleanup': 'factory CallCallback.cleanup(Future<void> Function() onCleanup)',
    },
    getterSignatures: {
      'onCleanup': 'Future<void> Function()? get onCleanup',
      'onCompletion': 'Future<void> Function(T result)? get onCompletion',
      'onCallCrashed': 'Future<T?> Function()? get onCallCrashed',
      'onOperationFailed': 'Future<void> Function(OperationFailedInfo info)? get onOperationFailed',
    },
  );
}

// =============================================================================
// OperationFailedInfo Bridge
// =============================================================================

BridgedClass _createOperationFailedInfoBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.OperationFailedInfo,
    name: 'OperationFailedInfo',
    constructors: {
      '': (visitor, positional, named) {
        final operationId = D4.getRequiredNamedArg<String>(named, 'operationId', 'OperationFailedInfo');
        final failedAt = D4.getRequiredNamedArg<DateTime>(named, 'failedAt', 'OperationFailedInfo');
        final reason = D4.getOptionalNamedArg<String?>(named, 'reason');
        final crashedCallIds = named.containsKey('crashedCallIds') && named['crashedCallIds'] != null
            ? D4.coerceList<String>(named['crashedCallIds'], 'crashedCallIds')
            : const <String>[];
        return $tom_dist_ledger_2.OperationFailedInfo(operationId: operationId, failedAt: failedAt, reason: reason, crashedCallIds: crashedCallIds);
      },
    },
    getters: {
      'operationId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationFailedInfo>(target, 'OperationFailedInfo').operationId,
      'failedAt': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationFailedInfo>(target, 'OperationFailedInfo').failedAt,
      'reason': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationFailedInfo>(target, 'OperationFailedInfo').reason,
      'crashedCallIds': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationFailedInfo>(target, 'OperationFailedInfo').crashedCallIds,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.OperationFailedInfo>(target, 'OperationFailedInfo');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'OperationFailedInfo({required String operationId, required DateTime failedAt, String? reason, List<String> crashedCallIds = const []})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'operationId': 'String get operationId',
      'failedAt': 'DateTime get failedAt',
      'reason': 'String? get reason',
      'crashedCallIds': 'List<String> get crashedCallIds',
    },
  );
}

// =============================================================================
// OperationFailedException Bridge
// =============================================================================

BridgedClass _createOperationFailedExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.OperationFailedException,
    name: 'OperationFailedException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OperationFailedException');
        final info = D4.getRequiredArg<$tom_dist_ledger_2.OperationFailedInfo>(positional, 0, 'info', 'OperationFailedException');
        return $tom_dist_ledger_2.OperationFailedException(info);
      },
    },
    getters: {
      'info': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.OperationFailedException>(target, 'OperationFailedException').info,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.OperationFailedException>(target, 'OperationFailedException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'OperationFailedException(OperationFailedInfo info)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'info': 'OperationFailedInfo get info',
    },
  );
}

// =============================================================================
// CallLifecycle Bridge
// =============================================================================

BridgedClass _createCallLifecycleBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.CallLifecycle,
    name: 'CallLifecycle',
    constructors: {
    },
    methods: {
      'endCallInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.CallLifecycle>(target, 'CallLifecycle');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'endCallInternal');
        final result = D4.getOptionalNamedArg<dynamic>(named, 'result');
        return t.endCallInternal(callId: callId, result: result);
      },
      'failCallInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.CallLifecycle>(target, 'CallLifecycle');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'failCallInternal');
        final error = D4.getRequiredNamedArg<Object>(named, 'error', 'failCallInternal');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return t.failCallInternal(callId: callId, error: error, stackTrace: stackTrace);
      },
    },
    methodSignatures: {
      'endCallInternal': 'Future<void> endCallInternal({required String callId, T? result})',
      'failCallInternal': 'Future<void> failCallInternal({required String callId, required Object error, StackTrace? stackTrace})',
    },
  );
}

// =============================================================================
// Call Bridge
// =============================================================================

BridgedClass _createCallBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.Call,
    name: 'Call',
    constructors: {
      'internal': (visitor, positional, named) {
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'Call');
        final operation = D4.getRequiredNamedArg<$tom_dist_ledger_2.CallLifecycle>(named, 'operation', 'Call');
        final startedAt = D4.getRequiredNamedArg<DateTime>(named, 'startedAt', 'Call');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        return $tom_dist_ledger_2.Call.internal(callId: callId, operation: operation, startedAt: startedAt, description: description);
      },
    },
    getters: {
      'callId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.Call>(target, 'Call').callId,
      'description': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.Call>(target, 'Call').description,
      'startedAt': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.Call>(target, 'Call').startedAt,
      'isCompleted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.Call>(target, 'Call').isCompleted,
    },
    methods: {
      'end': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.Call>(target, 'Call');
        final result = D4.getOptionalArg<dynamic>(positional, 0, 'result');
        return t.end(result);
      },
      'fail': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.Call>(target, 'Call');
        D4.requireMinArgs(positional, 1, 'fail');
        final error = D4.getRequiredArg<Object>(positional, 0, 'error', 'fail');
        final stackTrace = D4.getOptionalArg<StackTrace?>(positional, 1, 'stackTrace');
        return t.fail(error, stackTrace);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.Call>(target, 'Call');
        return t.toString();
      },
    },
    constructorSignatures: {
      'internal': 'Call.internal({required String callId, required CallLifecycle operation, required DateTime startedAt, String? description})',
    },
    methodSignatures: {
      'end': 'Future<void> end([T? result])',
      'fail': 'Future<void> fail(Object error, [StackTrace? stackTrace])',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'callId': 'String get callId',
      'description': 'String? get description',
      'startedAt': 'DateTime get startedAt',
      'isCompleted': 'bool get isCompleted',
    },
  );
}

// =============================================================================
// SpawnedCall Bridge
// =============================================================================

BridgedClass _createSpawnedCallBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.SpawnedCall,
    name: 'SpawnedCall',
    constructors: {
      '': (visitor, positional, named) {
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'SpawnedCall');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        return $tom_dist_ledger_2.SpawnedCall(callId: callId, description: description);
      },
    },
    getters: {
      'callId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').callId,
      'description': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').description,
      'isCompleted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').isCompleted,
      'isSuccess': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').isSuccess,
      'isFailed': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').isFailed,
      'isCancelled': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').isCancelled,
      'result': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').result,
      'resultOrNull': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').resultOrNull,
      'future': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').future,
      'error': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').error,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall').stackTrace,
    },
    methods: {
      'resultOr': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall');
        D4.requireMinArgs(positional, 1, 'resultOr');
        final defaultValue = D4.getRequiredArg<dynamic>(positional, 0, 'defaultValue', 'resultOr');
        return t.resultOr(defaultValue);
      },
      'cancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall');
        return t.cancel();
      },
      'kill': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall');
        final signal = D4.getOptionalArgWithDefault<ProcessSignal>(positional, 0, 'signal', ProcessSignal.sigterm);
        return t.kill(signal);
      },
      'await': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall');
        return t.await();
      },
      'complete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall');
        D4.requireMinArgs(positional, 1, 'complete');
        final result = D4.getRequiredArg<dynamic>(positional, 0, 'result', 'complete');
        t.complete(result);
        return null;
      },
      'fail': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall');
        D4.requireMinArgs(positional, 1, 'fail');
        final error = D4.getRequiredArg<Object>(positional, 0, 'error', 'fail');
        final stackTrace = D4.getOptionalArg<StackTrace?>(positional, 1, 'stackTrace');
        t.fail(error, stackTrace);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SpawnedCall>(target, 'SpawnedCall');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'SpawnedCall({required String callId, String? description})',
    },
    methodSignatures: {
      'resultOr': 'T resultOr(T defaultValue)',
      'cancel': 'Future<void> cancel()',
      'kill': 'bool kill([ProcessSignal signal = ProcessSignal.sigterm])',
      'await': 'Future<T> await()',
      'complete': 'void complete(T result)',
      'fail': 'void fail(Object error, [StackTrace? stackTrace])',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'callId': 'String get callId',
      'description': 'String? get description',
      'isCompleted': 'bool get isCompleted',
      'isSuccess': 'bool get isSuccess',
      'isFailed': 'bool get isFailed',
      'isCancelled': 'bool get isCancelled',
      'result': 'T get result',
      'resultOrNull': 'T? get resultOrNull',
      'future': 'Future<void> get future',
      'error': 'Object? get error',
      'stackTrace': 'StackTrace? get stackTrace',
    },
  );
}

// =============================================================================
// SyncResult Bridge
// =============================================================================

BridgedClass _createSyncResultBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.SyncResult,
    name: 'SyncResult',
    constructors: {
      '': (visitor, positional, named) {
        final successfulCalls = named.containsKey('successfulCalls') && named['successfulCalls'] != null
            ? D4.coerceList<$tom_dist_ledger_2.SpawnedCall<dynamic>>(named['successfulCalls'], 'successfulCalls')
            : const <$tom_dist_ledger_2.SpawnedCall<dynamic>>[];
        final failedCalls = named.containsKey('failedCalls') && named['failedCalls'] != null
            ? D4.coerceList<$tom_dist_ledger_2.SpawnedCall<dynamic>>(named['failedCalls'], 'failedCalls')
            : const <$tom_dist_ledger_2.SpawnedCall<dynamic>>[];
        final unknownCalls = named.containsKey('unknownCalls') && named['unknownCalls'] != null
            ? D4.coerceList<$tom_dist_ledger_2.SpawnedCall<dynamic>>(named['unknownCalls'], 'unknownCalls')
            : const <$tom_dist_ledger_2.SpawnedCall<dynamic>>[];
        final operationFailed = D4.getNamedArgWithDefault<bool>(named, 'operationFailed', false);
        return $tom_dist_ledger_2.SyncResult(successfulCalls: successfulCalls, failedCalls: failedCalls, unknownCalls: unknownCalls, operationFailed: operationFailed);
      },
    },
    getters: {
      'successfulCalls': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult').successfulCalls,
      'failedCalls': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult').failedCalls,
      'unknownCalls': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult').unknownCalls,
      'operationFailed': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult').operationFailed,
      'allSucceeded': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult').allSucceeded,
      'hasFailed': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult').hasFailed,
      'allResolved': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult').allResolved,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.SyncResult>(target, 'SyncResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'SyncResult({List<SpawnedCall<dynamic>> successfulCalls = const [], List<SpawnedCall<dynamic>> failedCalls = const [], List<SpawnedCall<dynamic>> unknownCalls = const [], bool operationFailed = false})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'successfulCalls': 'List<SpawnedCall> get successfulCalls',
      'failedCalls': 'List<SpawnedCall> get failedCalls',
      'unknownCalls': 'List<SpawnedCall> get unknownCalls',
      'operationFailed': 'bool get operationFailed',
      'allSucceeded': 'bool get allSucceeded',
      'hasFailed': 'bool get hasFailed',
      'allResolved': 'bool get allResolved',
    },
  );
}

// =============================================================================
// OperationHelper Bridge
// =============================================================================

BridgedClass _createOperationHelperBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.OperationHelper,
    name: 'OperationHelper',
    constructors: {
    },
    staticMethods: {
      'pollFile': (visitor, positional, named, typeArgs) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'pollFile');
        final delete = D4.getNamedArgWithDefault<bool>(named, 'delete', false);
        final deserializerRaw = named['deserializer'];
        final deserializer = deserializerRaw == null ? null : (String p0) { return D4.callInterpreterCallback(visitor, deserializerRaw, [p0]) as dynamic; };
        final pollInterval = D4.getNamedArgWithDefault<Duration>(named, 'pollInterval', const Duration(milliseconds: 100));
        final timeout = D4.getOptionalNamedArg<Duration?>(named, 'timeout');
        return $tom_dist_ledger_2.OperationHelper.pollFile(path: path, delete: delete, deserializer: deserializer, pollInterval: pollInterval, timeout: timeout);
      },
      'pollUntil': (visitor, positional, named, typeArgs) {
        if (!named.containsKey('check') || named['check'] == null) {
          throw ArgumentError('pollUntil: Missing required named argument "check"');
        }
        final checkRaw = named['check'];
        final check = () { return D4.callInterpreterCallback(visitor, checkRaw, []) as Future<dynamic>; };
        final pollInterval = D4.getNamedArgWithDefault<Duration>(named, 'pollInterval', const Duration(milliseconds: 100));
        final timeout = D4.getOptionalNamedArg<Duration?>(named, 'timeout');
        return $tom_dist_ledger_2.OperationHelper.pollUntil(check: check, pollInterval: pollInterval, timeout: timeout);
      },
      'pollFiles': (visitor, positional, named, typeArgs) {
        if (!named.containsKey('paths') || named['paths'] == null) {
          throw ArgumentError('pollFiles: Missing required named argument "paths"');
        }
        final paths = D4.coerceList<String>(named['paths'], 'paths');
        final delete = D4.getNamedArgWithDefault<bool>(named, 'delete', false);
        final deserializerRaw = named['deserializer'];
        final deserializer = deserializerRaw == null ? null : (String p0) { return D4.callInterpreterCallback(visitor, deserializerRaw, [p0]) as dynamic; };
        final pollInterval = D4.getNamedArgWithDefault<Duration>(named, 'pollInterval', const Duration(milliseconds: 100));
        final timeout = D4.getOptionalNamedArg<Duration?>(named, 'timeout');
        return $tom_dist_ledger_2.OperationHelper.pollFiles(paths: paths, delete: delete, deserializer: deserializer, pollInterval: pollInterval, timeout: timeout);
      },
    },
    staticMethodSignatures: {
      'pollFile': 'Future<T> Function() pollFile({required String path, bool delete = false, T Function(String content)? deserializer, Duration pollInterval = const Duration(milliseconds: 100), Duration? timeout})',
      'pollUntil': 'Future<T> Function() pollUntil({required Future<T?> Function() check, Duration pollInterval = const Duration(milliseconds: 100), Duration? timeout})',
      'pollFiles': 'Future<List<T>> Function() pollFiles({required List<String> paths, bool delete = false, T Function(String content)? deserializer, Duration pollInterval = const Duration(milliseconds: 100), Duration? timeout})',
    },
  );
}

// =============================================================================
// LedgerServer Bridge
// =============================================================================

BridgedClass _createLedgerServerBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_2.LedgerServer,
    name: 'LedgerServer',
    constructors: {
    },
    getters: {
      'port': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LedgerServer>(target, 'LedgerServer').port,
      'basePath': (visitor, target) => D4.validateTarget<$tom_dist_ledger_2.LedgerServer>(target, 'LedgerServer').basePath,
    },
    methods: {
      'stop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_2.LedgerServer>(target, 'LedgerServer');
        return t.stop();
      },
    },
    staticMethods: {
      'start': (visitor, positional, named, typeArgs) {
        final basePath = D4.getRequiredNamedArg<String>(named, 'basePath', 'start');
        final port = D4.getNamedArgWithDefault<int>(named, 'port', 19880);
        final address = D4.getOptionalNamedArg<InternetAddress?>(named, 'address');
        return $tom_dist_ledger_2.LedgerServer.start(basePath: basePath, port: port, address: address);
      },
    },
    methodSignatures: {
      'stop': 'Future<void> stop()',
    },
    getterSignatures: {
      'port': 'int get port',
      'basePath': 'String get basePath',
    },
    staticMethodSignatures: {
      'start': 'Future<LedgerServer> start({required String basePath, int port = 19880, InternetAddress? address})',
    },
  );
}

// =============================================================================
// RemoteLedgerClient Bridge
// =============================================================================

BridgedClass _createRemoteLedgerClientBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_5.RemoteLedgerClient,
    name: 'RemoteLedgerClient',
    constructors: {
      '': (visitor, positional, named) {
        final serverUrl = D4.getRequiredNamedArg<String>(named, 'serverUrl', 'RemoteLedgerClient');
        final participantId = D4.getRequiredNamedArg<String>(named, 'participantId', 'RemoteLedgerClient');
        final participantPid = D4.getOptionalNamedArg<int?>(named, 'participantPid');
        final maxBackups = D4.getNamedArgWithDefault<int>(named, 'maxBackups', 20);
        final heartbeatInterval = D4.getNamedArgWithDefault<Duration>(named, 'heartbeatInterval', const Duration(seconds: 5));
        final staleThreshold = D4.getNamedArgWithDefault<Duration>(named, 'staleThreshold', const Duration(seconds: 15));
        return $tom_dist_ledger_5.RemoteLedgerClient(serverUrl: serverUrl, participantId: participantId, participantPid: participantPid, maxBackups: maxBackups, heartbeatInterval: heartbeatInterval, staleThreshold: staleThreshold);
      },
    },
    getters: {
      'participantId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient').participantId,
      'participantPid': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient').participantPid,
      'maxBackups': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient').maxBackups,
      'heartbeatInterval': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient').heartbeatInterval,
      'staleThreshold': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient').staleThreshold,
      'serverUrl': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient').serverUrl,
    },
    methods: {
      'createOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.OperationCallback?>(named, 'callback');
        return t.createOperation(description: description, callback: callback);
      },
      'joinOperation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient');
        final operationId = D4.getRequiredNamedArg<String>(named, 'operationId', 'joinOperation');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.OperationCallback?>(named, 'callback');
        return t.joinOperation(operationId: operationId, callback: callback);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerClient>(target, 'RemoteLedgerClient');
        t.dispose();
        return null;
      },
    },
    staticMethods: {
      'connect': (visitor, positional, named, typeArgs) {
        final participantId = D4.getRequiredNamedArg<String>(named, 'participantId', 'connect');
        final serverUrl = D4.getOptionalNamedArg<String?>(named, 'serverUrl');
        final participantPid = D4.getOptionalNamedArg<int?>(named, 'participantPid');
        final maxBackups = D4.getNamedArgWithDefault<int>(named, 'maxBackups', 20);
        final heartbeatInterval = D4.getNamedArgWithDefault<Duration>(named, 'heartbeatInterval', const Duration(seconds: 5));
        final staleThreshold = D4.getNamedArgWithDefault<Duration>(named, 'staleThreshold', const Duration(seconds: 15));
        final port = D4.getNamedArgWithDefault<int>(named, 'port', 19880);
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(milliseconds: 500));
        final scanSubnet = D4.getNamedArgWithDefault<bool>(named, 'scanSubnet', true);
        final loggerRaw = named['logger'];
        final logger = loggerRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, loggerRaw, [p0]); };
        return $tom_dist_ledger_5.RemoteLedgerClient.connect(participantId: participantId, serverUrl: serverUrl, participantPid: participantPid, maxBackups: maxBackups, heartbeatInterval: heartbeatInterval, staleThreshold: staleThreshold, port: port, timeout: timeout, scanSubnet: scanSubnet, logger: logger);
      },
      'discover': (visitor, positional, named, typeArgs) {
        final participantId = D4.getRequiredNamedArg<String>(named, 'participantId', 'discover');
        final participantPid = D4.getOptionalNamedArg<int?>(named, 'participantPid');
        final maxBackups = D4.getNamedArgWithDefault<int>(named, 'maxBackups', 20);
        final heartbeatInterval = D4.getNamedArgWithDefault<Duration>(named, 'heartbeatInterval', const Duration(seconds: 5));
        final staleThreshold = D4.getNamedArgWithDefault<Duration>(named, 'staleThreshold', const Duration(seconds: 15));
        final port = D4.getNamedArgWithDefault<int>(named, 'port', 19880);
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(milliseconds: 500));
        final scanSubnet = D4.getNamedArgWithDefault<bool>(named, 'scanSubnet', true);
        final loggerRaw = named['logger'];
        final logger = loggerRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, loggerRaw, [p0]); };
        return $tom_dist_ledger_5.RemoteLedgerClient.discover(participantId: participantId, participantPid: participantPid, maxBackups: maxBackups, heartbeatInterval: heartbeatInterval, staleThreshold: staleThreshold, port: port, timeout: timeout, scanSubnet: scanSubnet, logger: logger);
      },
    },
    constructorSignatures: {
      '': 'RemoteLedgerClient({required String serverUrl, required String participantId, int? participantPid, int maxBackups = 20, Duration heartbeatInterval = const Duration(seconds: 5), Duration staleThreshold = const Duration(seconds: 15)})',
    },
    methodSignatures: {
      'createOperation': 'Future<RemoteOperation> createOperation({String? description, OperationCallback? callback})',
      'joinOperation': 'Future<RemoteOperation> joinOperation({required String operationId, OperationCallback? callback})',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'participantId': 'String get participantId',
      'participantPid': 'int get participantPid',
      'maxBackups': 'int get maxBackups',
      'heartbeatInterval': 'Duration get heartbeatInterval',
      'staleThreshold': 'Duration get staleThreshold',
      'serverUrl': 'String get serverUrl',
    },
    staticMethodSignatures: {
      'connect': 'Future<RemoteLedgerClient?> connect({required String participantId, String? serverUrl, int? participantPid, int maxBackups = 20, Duration heartbeatInterval = const Duration(seconds: 5), Duration staleThreshold = const Duration(seconds: 15), int port = 19880, Duration timeout = const Duration(milliseconds: 500), bool scanSubnet = true, void Function(String message)? logger})',
      'discover': 'Future<RemoteLedgerClient?> discover({required String participantId, int? participantPid, int maxBackups = 20, Duration heartbeatInterval = const Duration(seconds: 5), Duration staleThreshold = const Duration(seconds: 15), int port = 19880, Duration timeout = const Duration(milliseconds: 500), bool scanSubnet = true, void Function(String message)? logger})',
    },
  );
}

// =============================================================================
// RemoteLedgerException Bridge
// =============================================================================

BridgedClass _createRemoteLedgerExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_5.RemoteLedgerException,
    name: 'RemoteLedgerException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RemoteLedgerException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'RemoteLedgerException');
        final statusCode = D4.getOptionalNamedArg<int?>(named, 'statusCode');
        return $tom_dist_ledger_5.RemoteLedgerException(message, statusCode: statusCode);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerException>(target, 'RemoteLedgerException').message,
      'statusCode': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerException>(target, 'RemoteLedgerException').statusCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteLedgerException>(target, 'RemoteLedgerException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'RemoteLedgerException(String message, {int? statusCode})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'statusCode': 'int? get statusCode',
    },
  );
}

// =============================================================================
// RemoteOperation Bridge
// =============================================================================

BridgedClass _createRemoteOperationBridge() {
  return BridgedClass(
    nativeType: $tom_dist_ledger_5.RemoteOperation,
    name: 'RemoteOperation',
    constructors: {
    },
    getters: {
      'sessionId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').sessionId,
      'operationId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').operationId,
      'participantId': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').participantId,
      'pid': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').pid,
      'isInitiator': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').isInitiator,
      'startTime': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').startTime,
      'isAborted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').isAborted,
      'onAbort': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').onAbort,
      'onFailure': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').onFailure,
      'elapsedFormatted': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').elapsedFormatted,
      'elapsedDuration': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').elapsedDuration,
      'startTimeIso': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').startTimeIso,
      'startTimeMs': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').startTimeMs,
      'pendingCallCount': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').pendingCallCount,
      'cachedData': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').cachedData,
      'localTempResources': (visitor, target) => D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation').localTempResources,
    },
    methods: {
      'startCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        return t.startCall(callback: callback, description: description, failOnCrash: failOnCrash);
      },
      'spawnCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        if (!named.containsKey('work') || named['work'] == null) {
          throw ArgumentError('spawnCall: Missing required named argument "work"');
        }
        final workRaw = named['work'];
        final callback = D4.getOptionalNamedArg<$tom_dist_ledger_2.CallCallback<dynamic>?>(named, 'callback');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final failOnCrash = D4.getNamedArgWithDefault<bool>(named, 'failOnCrash', true);
        return t.spawnCall(work: ($tom_dist_ledger_2.SpawnedCall<dynamic> p0, $tom_dist_ledger_3.Operation p1) { return D4.callInterpreterCallback(visitor, workRaw, [p0, p1]) as Future<dynamic>; }, callback: callback, description: description, failOnCrash: failOnCrash);
      },
      'endCallInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'endCallInternal');
        final result = D4.getOptionalNamedArg<dynamic>(named, 'result');
        return t.endCallInternal(callId: callId, result: result);
      },
      'failCallInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'failCallInternal');
        final error = D4.getRequiredNamedArg<Object>(named, 'error', 'failCallInternal');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return t.failCallInternal(callId: callId, error: error, stackTrace: stackTrace);
      },
      'hasPendingCalls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        return t.hasPendingCalls();
      },
      'getPendingSpawnedCalls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        return t.getPendingSpawnedCalls();
      },
      'getPendingCalls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        return t.getPendingCalls();
      },
      'sync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        D4.requireMinArgs(positional, 1, 'sync');
        if (positional.isEmpty) {
          throw ArgumentError('sync: Missing required argument "calls" at position 0');
        }
        final calls = D4.coerceList<$tom_dist_ledger_2.SpawnedCall>(positional[0], 'calls');
        final onOperationFailedRaw = named['onOperationFailed'];
        final onCompletionRaw = named['onCompletion'];
        return t.sync(calls, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onCompletion: onCompletionRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCompletionRaw, []) as Future<void>; });
      },
      'awaitCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        D4.requireMinArgs(positional, 1, 'awaitCall');
        final call = D4.getRequiredArg<$tom_dist_ledger_2.SpawnedCall<dynamic>>(positional, 0, 'call', 'awaitCall');
        final onOperationFailedRaw = named['onOperationFailed'];
        final onCompletionRaw = named['onCompletion'];
        return t.awaitCall(call, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onCompletion: onCompletionRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onCompletionRaw, []) as Future<void>; });
      },
      'waitForCompletion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        D4.requireMinArgs(positional, 1, 'waitForCompletion');
        if (positional.isEmpty) {
          throw ArgumentError('waitForCompletion: Missing required argument "work" at position 0');
        }
        final workRaw = positional[0];
        final onOperationFailedRaw = named['onOperationFailed'];
        final onErrorRaw = named['onError'];
        return t.waitForCompletion(() { return D4.callInterpreterCallback(visitor, workRaw, []) as Future<dynamic>; }, onOperationFailed: onOperationFailedRaw == null ? null : ($tom_dist_ledger_2.OperationFailedInfo p0) { return D4.callInterpreterCallback(visitor, onOperationFailedRaw, [p0]) as Future<void>; }, onError: onErrorRaw == null ? null : (Object p0, StackTrace p1) { return D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]) as Future<dynamic>; });
      },
      'leave': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final cancelPendingCalls = D4.getNamedArgWithDefault<bool>(named, 'cancelPendingCalls', false);
        return t.leave(cancelPendingCalls: cancelPendingCalls);
      },
      'log': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        D4.requireMinArgs(positional, 1, 'log');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'log');
        final level = D4.getNamedArgWithDefault<$tom_dist_ledger_2.DLLogLevel>(named, 'level', $tom_dist_ledger_2.DLLogLevel.info);
        return t.log(message, level: level);
      },
      'complete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        return t.complete();
      },
      'setAbortFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        D4.requireMinArgs(positional, 1, 'setAbortFlag');
        final value = D4.getRequiredArg<bool>(positional, 0, 'value', 'setAbortFlag');
        return t.setAbortFlag(value);
      },
      'checkAbort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        return t.checkAbort();
      },
      'triggerAbort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        t.triggerAbort();
        return null;
      },
      'createCallFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'createCallFrame');
        return t.createCallFrame(callId: callId);
      },
      'deleteCallFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final callId = D4.getRequiredNamedArg<String>(named, 'callId', 'deleteCallFrame');
        return t.deleteCallFrame(callId: callId);
      },
      'registerTempResource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'registerTempResource');
        return t.registerTempResource(path: path);
      },
      'unregisterTempResource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'unregisterTempResource');
        return t.unregisterTempResource(path: path);
      },
      'cleanupLocalTempResources': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        return t.cleanupLocalTempResources();
      },
      'startHeartbeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        final interval = D4.getNamedArgWithDefault<Duration>(named, 'interval', const Duration(milliseconds: 4500));
        final jitterMs = D4.getNamedArgWithDefault<int>(named, 'jitterMs', 500);
        final onErrorRaw = named['onError'];
        final onSuccessRaw = named['onSuccess'];
        t.startHeartbeat(interval: interval, jitterMs: jitterMs, onError: onErrorRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_4.HeartbeatError p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); }, onSuccess: onSuccessRaw == null ? null : ($tom_dist_ledger_3.Operation p0, $tom_dist_ledger_6.HeartbeatResult p1) { D4.callInterpreterCallback(visitor, onSuccessRaw, [p0, p1]); });
        return null;
      },
      'stopHeartbeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        t.stopHeartbeat();
        return null;
      },
      'heartbeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_dist_ledger_5.RemoteOperation>(target, 'RemoteOperation');
        return t.heartbeat();
      },
    },
    methodSignatures: {
      'startCall': 'Future<Call<T>> startCall({CallCallback<T>? callback, String? description, bool failOnCrash = true})',
      'spawnCall': 'SpawnedCall<T> spawnCall({required Future<T> Function(SpawnedCall<T> call, Operation operation) work, CallCallback<T>? callback, String? description, bool failOnCrash = true})',
      'endCallInternal': 'Future<void> endCallInternal({required String callId, T? result})',
      'failCallInternal': 'Future<void> failCallInternal({required String callId, required Object error, StackTrace? stackTrace})',
      'hasPendingCalls': 'bool hasPendingCalls()',
      'getPendingSpawnedCalls': 'List<SpawnedCall> getPendingSpawnedCalls()',
      'getPendingCalls': 'List<Call> getPendingCalls()',
      'sync': 'Future<SyncResult> sync(List<SpawnedCall> calls, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<void> Function()? onCompletion})',
      'awaitCall': 'Future<SyncResult> awaitCall(SpawnedCall<T> call, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<void> Function()? onCompletion})',
      'waitForCompletion': 'Future<T> waitForCompletion(Future<T> Function() work, {Future<void> Function(OperationFailedInfo info)? onOperationFailed, Future<T> Function(Object error, StackTrace stackTrace)? onError})',
      'leave': 'Future<void> leave({bool cancelPendingCalls = false})',
      'log': 'Future<void> log(String message, {DLLogLevel level = DLLogLevel.info})',
      'complete': 'Future<void> complete()',
      'setAbortFlag': 'Future<void> setAbortFlag(bool value)',
      'checkAbort': 'Future<bool> checkAbort()',
      'triggerAbort': 'void triggerAbort()',
      'createCallFrame': 'Future<void> createCallFrame({required String callId})',
      'deleteCallFrame': 'Future<void> deleteCallFrame({required String callId})',
      'registerTempResource': 'Future<void> registerTempResource({required String path})',
      'unregisterTempResource': 'Future<void> unregisterTempResource({required String path})',
      'cleanupLocalTempResources': 'Future<void> cleanupLocalTempResources()',
      'startHeartbeat': 'void startHeartbeat({Duration interval = const Duration(milliseconds: 4500), int jitterMs = 500, HeartbeatErrorCallback? onError, HeartbeatSuccessCallback? onSuccess})',
      'stopHeartbeat': 'void stopHeartbeat()',
      'heartbeat': 'Future<HeartbeatResult?> heartbeat()',
    },
    getterSignatures: {
      'sessionId': 'int get sessionId',
      'operationId': 'String get operationId',
      'participantId': 'String get participantId',
      'pid': 'int get pid',
      'isInitiator': 'bool get isInitiator',
      'startTime': 'DateTime get startTime',
      'isAborted': 'bool get isAborted',
      'onAbort': 'Future<void> get onAbort',
      'onFailure': 'Future<OperationFailedInfo> get onFailure',
      'elapsedFormatted': 'String get elapsedFormatted',
      'elapsedDuration': 'Duration get elapsedDuration',
      'startTimeIso': 'String get startTimeIso',
      'startTimeMs': 'int get startTimeMs',
      'pendingCallCount': 'int get pendingCallCount',
      'cachedData': 'LedgerData? get cachedData',
      'localTempResources': 'Set<String> get localTempResources',
    },
  );
}

// =============================================================================
// RetryExhaustedException Bridge
// =============================================================================

BridgedClass _createRetryExhaustedExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_basics_network_1.RetryExhaustedException,
    name: 'RetryExhaustedException',
    constructors: {
      '': (visitor, positional, named) {
        final lastError = D4.getRequiredNamedArg<Object>(named, 'lastError', 'RetryExhaustedException');
        final lastStackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'lastStackTrace');
        final attempts = D4.getRequiredNamedArg<int>(named, 'attempts', 'RetryExhaustedException');
        return $tom_basics_network_1.RetryExhaustedException(lastError: lastError, lastStackTrace: lastStackTrace, attempts: attempts);
      },
    },
    getters: {
      'lastError': (visitor, target) => D4.validateTarget<$tom_basics_network_1.RetryExhaustedException>(target, 'RetryExhaustedException').lastError,
      'lastStackTrace': (visitor, target) => D4.validateTarget<$tom_basics_network_1.RetryExhaustedException>(target, 'RetryExhaustedException').lastStackTrace,
      'attempts': (visitor, target) => D4.validateTarget<$tom_basics_network_1.RetryExhaustedException>(target, 'RetryExhaustedException').attempts,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_network_1.RetryExhaustedException>(target, 'RetryExhaustedException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'RetryExhaustedException({required Object lastError, StackTrace? lastStackTrace, required int attempts})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'lastError': 'Object get lastError',
      'lastStackTrace': 'StackTrace? get lastStackTrace',
      'attempts': 'int get attempts',
    },
  );
}

// =============================================================================
// RetryConfig Bridge
// =============================================================================

BridgedClass _createRetryConfigBridge() {
  return BridgedClass(
    nativeType: $tom_basics_network_1.RetryConfig,
    name: 'RetryConfig',
    constructors: {
      '': (visitor, positional, named) {
        final onRetryRaw = named['onRetry'];
        if (!named.containsKey('retryDelaysMs')) {
          return $tom_basics_network_1.RetryConfig(onRetry: onRetryRaw == null ? null : (int p0, Object p1, Duration p2) { D4.callInterpreterCallback(visitor, onRetryRaw, [p0, p1, p2]); });
        }
        if (named.containsKey('retryDelaysMs')) {
          final retryDelaysMs = D4.coerceList<int>(named['retryDelaysMs'], 'retryDelaysMs');
          return $tom_basics_network_1.RetryConfig(onRetry: onRetryRaw == null ? null : (int p0, Object p1, Duration p2) { D4.callInterpreterCallback(visitor, onRetryRaw, [p0, p1, p2]); }, retryDelaysMs: retryDelaysMs);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'retryDelaysMs': (visitor, target) => D4.validateTarget<$tom_basics_network_1.RetryConfig>(target, 'RetryConfig').retryDelaysMs,
      'onRetry': (visitor, target) => D4.validateTarget<$tom_basics_network_1.RetryConfig>(target, 'RetryConfig').onRetry,
    },
    staticGetters: {
      'defaultConfig': (visitor) => $tom_basics_network_1.RetryConfig.defaultConfig,
    },
    constructorSignatures: {
      '': 'const RetryConfig({List<int> retryDelaysMs = kDefaultRetryDelaysMs, void Function(int, Object, Duration)? onRetry})',
    },
    getterSignatures: {
      'retryDelaysMs': 'List<int> get retryDelaysMs',
      'onRetry': 'void Function(int attempt, Object error, Duration nextDelay)? get onRetry',
    },
    staticGetterSignatures: {
      'defaultConfig': 'RetryConfig get defaultConfig',
    },
  );
}

// =============================================================================
// DiscoveredServer Bridge
// =============================================================================

BridgedClass _createDiscoveredServerBridge() {
  return BridgedClass(
    nativeType: $tom_basics_network_2.DiscoveredServer,
    name: 'DiscoveredServer',
    constructors: {
      '': (visitor, positional, named) {
        final serverUrl = D4.getRequiredNamedArg<String>(named, 'serverUrl', 'DiscoveredServer');
        if (!named.containsKey('status') || named['status'] == null) {
          throw ArgumentError('DiscoveredServer: Missing required named argument "status"');
        }
        final status = D4.coerceMap<String, dynamic>(named['status'], 'status');
        return $tom_basics_network_2.DiscoveredServer(serverUrl: serverUrl, status: status);
      },
    },
    getters: {
      'serverUrl': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveredServer>(target, 'DiscoveredServer').serverUrl,
      'status': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveredServer>(target, 'DiscoveredServer').status,
      'service': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveredServer>(target, 'DiscoveredServer').service,
      'version': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveredServer>(target, 'DiscoveredServer').version,
      'port': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveredServer>(target, 'DiscoveredServer').port,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_network_2.DiscoveredServer>(target, 'DiscoveredServer');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const DiscoveredServer({required String serverUrl, required Map<String, dynamic> status})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'serverUrl': 'String get serverUrl',
      'status': 'Map<String, dynamic> get status',
      'service': 'String? get service',
      'version': 'String? get version',
      'port': 'int? get port',
    },
  );
}

// =============================================================================
// DiscoveryOptions Bridge
// =============================================================================

BridgedClass _createDiscoveryOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_basics_network_2.DiscoveryOptions,
    name: 'DiscoveryOptions',
    constructors: {
      '': (visitor, positional, named) {
        final port = D4.getNamedArgWithDefault<int>(named, 'port', 19880);
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(milliseconds: 500));
        final scanSubnet = D4.getNamedArgWithDefault<bool>(named, 'scanSubnet', true);
        final maxConcurrent = D4.getNamedArgWithDefault<int>(named, 'maxConcurrent', 20);
        final statusPath = D4.getNamedArgWithDefault<String>(named, 'statusPath', '/status');
        final loggerRaw = named['logger'];
        final statusValidatorRaw = named['statusValidator'];
        return $tom_basics_network_2.DiscoveryOptions(port: port, timeout: timeout, scanSubnet: scanSubnet, maxConcurrent: maxConcurrent, statusPath: statusPath, logger: loggerRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, loggerRaw, [p0]); }, statusValidator: statusValidatorRaw == null ? null : (Map<String, dynamic> p0) { return D4.callInterpreterCallback(visitor, statusValidatorRaw, [p0]) as bool; });
      },
    },
    getters: {
      'port': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions').port,
      'timeout': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions').timeout,
      'scanSubnet': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions').scanSubnet,
      'maxConcurrent': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions').maxConcurrent,
      'statusPath': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions').statusPath,
      'logger': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions').logger,
      'statusValidator': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions').statusValidator,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_network_2.DiscoveryOptions>(target, 'DiscoveryOptions');
        final port = D4.getOptionalNamedArg<int?>(named, 'port');
        final timeout = D4.getOptionalNamedArg<Duration?>(named, 'timeout');
        final scanSubnet = D4.getOptionalNamedArg<bool?>(named, 'scanSubnet');
        final maxConcurrent = D4.getOptionalNamedArg<int?>(named, 'maxConcurrent');
        final statusPath = D4.getOptionalNamedArg<String?>(named, 'statusPath');
        final loggerRaw = named['logger'];
        final statusValidatorRaw = named['statusValidator'];
        return t.copyWith(port: port, timeout: timeout, scanSubnet: scanSubnet, maxConcurrent: maxConcurrent, statusPath: statusPath, logger: loggerRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, loggerRaw, [p0]); }, statusValidator: statusValidatorRaw == null ? null : (Map<String, dynamic> p0) { return D4.callInterpreterCallback(visitor, statusValidatorRaw, [p0]) as bool; });
      },
    },
    constructorSignatures: {
      '': 'const DiscoveryOptions({int port = 19880, Duration timeout = const Duration(milliseconds: 500), bool scanSubnet = true, int maxConcurrent = 20, String statusPath = \'/status\', void Function(String)? logger, bool Function(Map<String, dynamic>)? statusValidator})',
    },
    methodSignatures: {
      'copyWith': 'DiscoveryOptions copyWith({int? port, Duration? timeout, bool? scanSubnet, int? maxConcurrent, String? statusPath, void Function(String message)? logger, bool Function(Map<String, dynamic> status)? statusValidator})',
    },
    getterSignatures: {
      'port': 'int get port',
      'timeout': 'Duration get timeout',
      'scanSubnet': 'bool get scanSubnet',
      'maxConcurrent': 'int get maxConcurrent',
      'statusPath': 'String get statusPath',
      'logger': 'void Function(String message)? get logger',
      'statusValidator': 'bool Function(Map<String, dynamic> status)? get statusValidator',
    },
  );
}

// =============================================================================
// DiscoveryFailedException Bridge
// =============================================================================

BridgedClass _createDiscoveryFailedExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_basics_network_2.DiscoveryFailedException,
    name: 'DiscoveryFailedException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiscoveryFailedException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DiscoveryFailedException');
        return $tom_basics_network_2.DiscoveryFailedException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_basics_network_2.DiscoveryFailedException>(target, 'DiscoveryFailedException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_network_2.DiscoveryFailedException>(target, 'DiscoveryFailedException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'DiscoveryFailedException(String message)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String get message',
    },
  );
}

// =============================================================================
// ServerDiscovery Bridge
// =============================================================================

BridgedClass _createServerDiscoveryBridge() {
  return BridgedClass(
    nativeType: $tom_basics_network_2.ServerDiscovery,
    name: 'ServerDiscovery',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_network_2.ServerDiscovery();
      },
    },
    staticMethods: {
      'discover': (visitor, positional, named, typeArgs) {
        if (positional.length == 1) {
          final options = D4.getRequiredArg<$tom_basics_network_2.DiscoveryOptions>(positional, 0, 'options', 'discover');
          return $tom_basics_network_2.ServerDiscovery.discover(options);
        }
        if (positional.isEmpty) {
          return $tom_basics_network_2.ServerDiscovery.discover();
        }
        throw ArgumentError('Invalid argument count for discover');
      },
      'discoverOrThrow': (visitor, positional, named, typeArgs) {
        if (positional.length == 1) {
          final options = D4.getRequiredArg<$tom_basics_network_2.DiscoveryOptions>(positional, 0, 'options', 'discoverOrThrow');
          return $tom_basics_network_2.ServerDiscovery.discoverOrThrow(options);
        }
        if (positional.isEmpty) {
          return $tom_basics_network_2.ServerDiscovery.discoverOrThrow();
        }
        throw ArgumentError('Invalid argument count for discoverOrThrow');
      },
      'discoverAll': (visitor, positional, named, typeArgs) {
        if (positional.length == 1) {
          final options = D4.getRequiredArg<$tom_basics_network_2.DiscoveryOptions>(positional, 0, 'options', 'discoverAll');
          return $tom_basics_network_2.ServerDiscovery.discoverAll(options);
        }
        if (positional.isEmpty) {
          return $tom_basics_network_2.ServerDiscovery.discoverAll();
        }
        throw ArgumentError('Invalid argument count for discoverAll');
      },
      'getLocalIpAddresses': (visitor, positional, named, typeArgs) {
        return $tom_basics_network_2.ServerDiscovery.getLocalIpAddresses();
      },
      'getSubnetAddresses': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getSubnetAddresses');
        final ip = D4.getRequiredArg<String>(positional, 0, 'ip', 'getSubnetAddresses');
        return $tom_basics_network_2.ServerDiscovery.getSubnetAddresses(ip);
      },
    },
    constructorSignatures: {
      '': 'ServerDiscovery()',
    },
    staticMethodSignatures: {
      'discover': 'Future<DiscoveredServer?> discover([DiscoveryOptions options = const DiscoveryOptions()])',
      'discoverOrThrow': 'Future<DiscoveredServer> discoverOrThrow([DiscoveryOptions options = const DiscoveryOptions()])',
      'discoverAll': 'Future<List<DiscoveredServer>> discoverAll([DiscoveryOptions options = const DiscoveryOptions()])',
      'getLocalIpAddresses': 'Future<List<String>> getLocalIpAddresses()',
      'getSubnetAddresses': 'List<String> getSubnetAddresses(String ip)',
    },
  );
}

