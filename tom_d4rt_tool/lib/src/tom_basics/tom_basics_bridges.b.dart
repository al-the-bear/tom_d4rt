// D4rt Bridge - Generated file, do not edit
// Sources: 4 files
// Generated: 2026-02-15T00:34:30.404717

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:tom_basics/src/exception_base.dart' as $tom_basics_1;
import 'package:tom_basics/src/logging/logging.dart' as $tom_basics_2;
import 'package:tom_basics/src/runtime/platform_environment_runtime.dart' as $tom_basics_3;
import 'package:tom_basics/src/runtime/platform_neutral.dart' as $tom_basics_4;

/// Bridge class for tom_basics module.
class TomBasicsBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createTomBaseExceptionBridge(),
      _createTomLogLevelBridge(),
      _createTomLoggerBridge(),
      _createTomLoggableBridge(),
      _createTomLogOutputBridge(),
      _createTomConsoleLogOutputBridge(),
      _createTomPlatformUtilsBridge(),
      _createTomFallbackPlatformUtilsBridge(),
      _createTomEnvironmentBridge(),
      _createTomPlatformBridge(),
      _createTomRuntimeBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'TomBaseException': 'package:tom_basics/src/exception_base.dart',
      'TomLogLevel': 'package:tom_basics/src/logging/logging.dart',
      'TomLogger': 'package:tom_basics/src/logging/logging.dart',
      'TomLoggable': 'package:tom_basics/src/logging/logging.dart',
      'TomLogOutput': 'package:tom_basics/src/logging/logging.dart',
      'TomConsoleLogOutput': 'package:tom_basics/src/logging/logging.dart',
      'TomPlatformUtils': 'package:tom_basics/src/runtime/platform_neutral.dart',
      'TomFallbackPlatformUtils': 'package:tom_basics/src/runtime/platform_neutral.dart',
      'TomEnvironment': 'package:tom_basics/src/runtime/platform_environment_runtime.dart',
      'TomPlatform': 'package:tom_basics/src/runtime/platform_environment_runtime.dart',
      'TomRuntime': 'package:tom_basics/src/runtime/platform_environment_runtime.dart',
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

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
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
      interpreter.registerGlobalVariable('tomLog', $tom_basics_2.tomLog, importPath, sourceUri: 'package:tom_basics/src/logging/logging.dart');
    } catch (e) {
      errors.add('Failed to register variable "tomLog": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformWeb', $tom_basics_3.platformWeb, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformWeb": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformMacos', $tom_basics_3.platformMacos, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformMacos": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformWindows', $tom_basics_3.platformWindows, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformWindows": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformAndroid', $tom_basics_3.platformAndroid, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformAndroid": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformIos', $tom_basics_3.platformIos, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformIos": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformLinux', $tom_basics_3.platformLinux, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformLinux": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformFuchsia', $tom_basics_3.platformFuchsia, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformFuchsia": $e');
    }
    try {
      interpreter.registerGlobalVariable('defaultTomEnvironment', $tom_basics_3.defaultTomEnvironment, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultTomEnvironment": $e');
    }
    try {
      interpreter.registerGlobalVariable('noTomEnvironment', $tom_basics_3.noTomEnvironment, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "noTomEnvironment": $e');
    }
    try {
      interpreter.registerGlobalVariable('noTomPlatform', $tom_basics_3.noTomPlatform, importPath, sourceUri: 'package:tom_basics/src/runtime/platform_environment_runtime.dart');
    } catch (e) {
      errors.add('Failed to register variable "noTomPlatform": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (tom_basics):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'limited': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'limited');
        final o = D4.getRequiredArg<Object?>(positional, 0, 'o', 'limited');
        final maxLength = D4.getRequiredArg<dynamic>(positional, 1, 'maxLength', 'limited');
        return $tom_basics_2.limited(o, maxLength);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'limited': 'package:tom_basics/src/logging/logging.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'limited': 'String limited(Object? o, dynamic maxLength)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:tom_basics/src/exception_base.dart',
      'package:tom_basics/src/logging/logging.dart',
      'package:tom_basics/src/runtime/platform_environment_runtime.dart',
      'package:tom_basics/src/runtime/platform_neutral.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:tom_basics/tom_basics.dart';";
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

}

// =============================================================================
// TomBaseException Bridge
// =============================================================================

BridgedClass _createTomBaseExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_basics_1.TomBaseException,
    name: 'TomBaseException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomBaseException');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'TomBaseException');
        final defaultUserMessage = D4.getRequiredArg<String>(positional, 1, 'defaultUserMessage', 'TomBaseException');
        final requestUuid = D4.getOptionalNamedArg<String?>(named, 'requestUuid');
        final parameters = D4.coerceMapOrNull<String, Object?>(named['parameters'], 'parameters');
        final rootException = D4.getOptionalNamedArg<Object?>(named, 'rootException');
        final stack = D4.getOptionalNamedArg<Object?>(named, 'stack');
        final uuid = D4.getOptionalNamedArg<String?>(named, 'uuid');
        return $tom_basics_1.TomBaseException(key, defaultUserMessage, requestUuid: requestUuid, parameters: parameters, rootException: rootException, stack: stack, uuid: uuid);
      },
    },
    getters: {
      'uuid': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').uuid,
      'requestUuid': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').requestUuid,
      'timeStamp': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').timeStamp,
      'key': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').key,
      'defaultUserMessage': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').defaultUserMessage,
      'parameters': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').parameters,
      'stack': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stack,
      'rootException': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').rootException,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stackTrace,
    },
    setters: {
      'uuid': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').uuid = value as String,
      'requestUuid': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').requestUuid = value as String?,
      'timeStamp': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').timeStamp = value as DateTime,
      'key': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').key = value as String,
      'defaultUserMessage': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').defaultUserMessage = value as String,
      'parameters': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').parameters = value == null ? null : (value as Map).cast<String, Object?>(),
      'stack': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stack = value as Object?,
      'rootException': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').rootException = value as Object?,
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException').stackTrace = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_1.TomBaseException>(target, 'TomBaseException');
        final depth = D4.getOptionalArgWithDefault<int>(positional, 0, 'depth', -1);
        t.printStackTrace(depth);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TomBaseException(String key, String defaultUserMessage, {String? requestUuid, Map<String, Object?>? parameters, Object? rootException, Object? stack, String? uuid})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace([int depth = -1])',
    },
    getterSignatures: {
      'uuid': 'String get uuid',
      'requestUuid': 'String? get requestUuid',
      'timeStamp': 'DateTime get timeStamp',
      'key': 'String get key',
      'defaultUserMessage': 'String get defaultUserMessage',
      'parameters': 'Map<String, Object?>? get parameters',
      'stack': 'Object? get stack',
      'rootException': 'Object? get rootException',
      'stackTrace': 'String get stackTrace',
    },
    setterSignatures: {
      'uuid': 'set uuid(dynamic value)',
      'requestUuid': 'set requestUuid(dynamic value)',
      'timeStamp': 'set timeStamp(dynamic value)',
      'key': 'set key(dynamic value)',
      'defaultUserMessage': 'set defaultUserMessage(dynamic value)',
      'parameters': 'set parameters(dynamic value)',
      'stack': 'set stack(dynamic value)',
      'rootException': 'set rootException(dynamic value)',
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// TomLogLevel Bridge
// =============================================================================

BridgedClass _createTomLogLevelBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLogLevel,
    name: 'TomLogLevel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomLogLevel');
        final levelPattern = D4.getRequiredArg<int>(positional, 0, 'levelPattern', 'TomLogLevel');
        return $tom_basics_2.TomLogLevel(levelPattern);
      },
    },
    getters: {
      'levelPattern': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel').levelPattern,
    },
    setters: {
      'levelPattern': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel').levelPattern = value as int,
    },
    methods: {
      'matches': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        D4.requireMinArgs(positional, 1, 'matches');
        final messageLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'messageLevel', 'matches');
        return t.matches(messageLevel);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        final other = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogLevel>(target, 'TomLogLevel');
        final other = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'other', 'operator-');
        return t - other;
      },
    },
    staticGetters: {
      'trace': (visitor) => $tom_basics_2.TomLogLevel.trace,
      'debug': (visitor) => $tom_basics_2.TomLogLevel.debug,
      'traffic': (visitor) => $tom_basics_2.TomLogLevel.traffic,
      'info': (visitor) => $tom_basics_2.TomLogLevel.info,
      'warn': (visitor) => $tom_basics_2.TomLogLevel.warn,
      'status': (visitor) => $tom_basics_2.TomLogLevel.status,
      'error': (visitor) => $tom_basics_2.TomLogLevel.error,
      'severe': (visitor) => $tom_basics_2.TomLogLevel.severe,
      'fatal': (visitor) => $tom_basics_2.TomLogLevel.fatal,
      'all': (visitor) => $tom_basics_2.TomLogLevel.all,
      'development': (visitor) => $tom_basics_2.TomLogLevel.development,
      'extended': (visitor) => $tom_basics_2.TomLogLevel.extended,
      'errors': (visitor) => $tom_basics_2.TomLogLevel.errors,
      'production': (visitor) => $tom_basics_2.TomLogLevel.production,
      'still': (visitor) => $tom_basics_2.TomLogLevel.still,
      'silent': (visitor) => $tom_basics_2.TomLogLevel.silent,
      'off': (visitor) => $tom_basics_2.TomLogLevel.off,
      'none': (visitor) => $tom_basics_2.TomLogLevel.none,
    },
    staticMethods: {
      'byName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'byName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'byName');
        return $tom_basics_2.TomLogLevel.byName(name);
      },
    },
    staticSetters: {
      'trace': (visitor, value) => 
        $tom_basics_2.TomLogLevel.trace = value as $tom_basics_2.TomLogLevel,
      'debug': (visitor, value) => 
        $tom_basics_2.TomLogLevel.debug = value as $tom_basics_2.TomLogLevel,
      'traffic': (visitor, value) => 
        $tom_basics_2.TomLogLevel.traffic = value as $tom_basics_2.TomLogLevel,
      'info': (visitor, value) => 
        $tom_basics_2.TomLogLevel.info = value as $tom_basics_2.TomLogLevel,
      'warn': (visitor, value) => 
        $tom_basics_2.TomLogLevel.warn = value as $tom_basics_2.TomLogLevel,
      'status': (visitor, value) => 
        $tom_basics_2.TomLogLevel.status = value as $tom_basics_2.TomLogLevel,
      'error': (visitor, value) => 
        $tom_basics_2.TomLogLevel.error = value as $tom_basics_2.TomLogLevel,
      'severe': (visitor, value) => 
        $tom_basics_2.TomLogLevel.severe = value as $tom_basics_2.TomLogLevel,
      'fatal': (visitor, value) => 
        $tom_basics_2.TomLogLevel.fatal = value as $tom_basics_2.TomLogLevel,
      'all': (visitor, value) => 
        $tom_basics_2.TomLogLevel.all = value as $tom_basics_2.TomLogLevel,
      'development': (visitor, value) => 
        $tom_basics_2.TomLogLevel.development = value as $tom_basics_2.TomLogLevel,
      'extended': (visitor, value) => 
        $tom_basics_2.TomLogLevel.extended = value as $tom_basics_2.TomLogLevel,
      'errors': (visitor, value) => 
        $tom_basics_2.TomLogLevel.errors = value as $tom_basics_2.TomLogLevel,
      'production': (visitor, value) => 
        $tom_basics_2.TomLogLevel.production = value as $tom_basics_2.TomLogLevel,
      'still': (visitor, value) => 
        $tom_basics_2.TomLogLevel.still = value as $tom_basics_2.TomLogLevel,
      'silent': (visitor, value) => 
        $tom_basics_2.TomLogLevel.silent = value as $tom_basics_2.TomLogLevel,
      'off': (visitor, value) => 
        $tom_basics_2.TomLogLevel.off = value as $tom_basics_2.TomLogLevel,
      'none': (visitor, value) => 
        $tom_basics_2.TomLogLevel.none = value as $tom_basics_2.TomLogLevel,
    },
    constructorSignatures: {
      '': 'TomLogLevel(int levelPattern)',
    },
    methodSignatures: {
      'matches': 'bool matches(TomLogLevel messageLevel)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'levelPattern': 'int get levelPattern',
    },
    setterSignatures: {
      'levelPattern': 'set levelPattern(dynamic value)',
    },
    staticMethodSignatures: {
      'byName': 'TomLogLevel? byName(String name)',
    },
    staticGetterSignatures: {
      'trace': 'TomLogLevel get trace',
      'debug': 'TomLogLevel get debug',
      'traffic': 'TomLogLevel get traffic',
      'info': 'TomLogLevel get info',
      'warn': 'TomLogLevel get warn',
      'status': 'TomLogLevel get status',
      'error': 'TomLogLevel get error',
      'severe': 'TomLogLevel get severe',
      'fatal': 'TomLogLevel get fatal',
      'all': 'TomLogLevel get all',
      'development': 'TomLogLevel get development',
      'extended': 'TomLogLevel get extended',
      'errors': 'TomLogLevel get errors',
      'production': 'TomLogLevel get production',
      'still': 'TomLogLevel get still',
      'silent': 'TomLogLevel get silent',
      'off': 'TomLogLevel get off',
      'none': 'TomLogLevel get none',
    },
    staticSetterSignatures: {
      'trace': 'set trace(dynamic value)',
      'debug': 'set debug(dynamic value)',
      'traffic': 'set traffic(dynamic value)',
      'info': 'set info(dynamic value)',
      'warn': 'set warn(dynamic value)',
      'status': 'set status(dynamic value)',
      'error': 'set error(dynamic value)',
      'severe': 'set severe(dynamic value)',
      'fatal': 'set fatal(dynamic value)',
      'all': 'set all(dynamic value)',
      'development': 'set development(dynamic value)',
      'extended': 'set extended(dynamic value)',
      'errors': 'set errors(dynamic value)',
      'production': 'set production(dynamic value)',
      'still': 'set still(dynamic value)',
      'silent': 'set silent(dynamic value)',
      'off': 'set off(dynamic value)',
      'none': 'set none(dynamic value)',
    },
  );
}

// =============================================================================
// TomLogger Bridge
// =============================================================================

BridgedClass _createTomLoggerBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLogger,
    name: 'TomLogger',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_2.TomLogger();
      },
    },
    getters: {
      'logLevel': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger').logLevel,
      'logOutput': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger').logOutput,
    },
    setters: {
      'logOutput': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger').logOutput = value as $tom_basics_2.TomLogOutput,
    },
    methods: {
      'setLogLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'setLogLevel');
        final l = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'l', 'setLogLevel');
        t.setLogLevel(l);
        return null;
      },
      'pushLogLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'pushLogLevel');
        final l = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'l', 'pushLogLevel');
        t.pushLogLevel(l);
        return null;
      },
      'popLogLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        t.popLogLevel();
        return null;
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'info');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'info');
        t.info(s);
        return null;
      },
      'warn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'warn');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'warn');
        t.warn(s);
        return null;
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'error');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'error');
        t.error(s);
        return null;
      },
      'debug': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'debug');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'debug');
        t.debug(s);
        return null;
      },
      'trace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'trace');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'trace');
        t.trace(s);
        return null;
      },
      'traffic': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'traffic');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'traffic');
        t.traffic(s);
        return null;
      },
      'severe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'severe');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'severe');
        t.severe(s);
        return null;
      },
      'fatal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'fatal');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'fatal');
        t.fatal(s);
        return null;
      },
      'status': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'status');
        final s = D4.getRequiredArg<Object>(positional, 0, 's', 'status');
        t.status(s);
        return null;
      },
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 3, 'output');
        final messageLogLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'messageLogLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 1, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 2, 'message', 'output');
        t.output(messageLogLevel, level, message);
        return null;
      },
      'addNameLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 2, 'addNameLevel');
        final t_ = D4.getRequiredArg<String>(positional, 0, 't', 'addNameLevel');
        final tll = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'tll', 'addNameLevel');
        t.addNameLevel(t_, tll);
        return null;
      },
      'getNameLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'getNameLevel');
        final t_ = D4.getRequiredArg<String>(positional, 0, 't', 'getNameLevel');
        return t.getNameLevel(t_);
      },
      'removeNameLevel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'removeNameLevel');
        final t_ = D4.getRequiredArg<String>(positional, 0, 't', 'removeNameLevel');
        t.removeNameLevel(t_);
        return null;
      },
      'setLogLevelByName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'setLogLevelByName');
        final levelName = D4.getRequiredArg<String>(positional, 0, 'levelName', 'setLogLevelByName');
        t.setLogLevelByName(levelName);
        return null;
      },
      'setLogLevelExceptions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        D4.requireMinArgs(positional, 1, 'setLogLevelExceptions');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'setLogLevelExceptions');
        t.setLogLevelExceptions(pattern);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogger>(target, 'TomLogger');
        return t.toString();
      },
    },
    staticGetters: {
      'INFO': (visitor) => $tom_basics_2.TomLogger.INFO,
      'ERROR': (visitor) => $tom_basics_2.TomLogger.ERROR,
      'WARN': (visitor) => $tom_basics_2.TomLogger.WARN,
      'DEBUG': (visitor) => $tom_basics_2.TomLogger.DEBUG,
      'TRACE': (visitor) => $tom_basics_2.TomLogger.TRACE,
      'TRAFFIC': (visitor) => $tom_basics_2.TomLogger.TRAFFIC,
      'SEVERE': (visitor) => $tom_basics_2.TomLogger.SEVERE,
      'FATAL': (visitor) => $tom_basics_2.TomLogger.FATAL,
      'STATUS': (visitor) => $tom_basics_2.TomLogger.STATUS,
      'globalSettingDetermineCaller': (visitor) => $tom_basics_2.TomLogger.globalSettingDetermineCaller,
      'fallback': (visitor) => $tom_basics_2.TomLogger.fallback,
      'globalSettingInfoEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingInfoEnabled,
      'globalSettingWarnEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingWarnEnabled,
      'globalSettingErrorEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingErrorEnabled,
      'globalSettingDebugEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingDebugEnabled,
      'globalSettingTraceEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingTraceEnabled,
      'globalSettingTrafficEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingTrafficEnabled,
      'globalSettingSevereEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingSevereEnabled,
      'globalSettingFatalEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingFatalEnabled,
      'globalSettingStatusEnabled': (visitor) => $tom_basics_2.TomLogger.globalSettingStatusEnabled,
    },
    staticSetters: {
      'globalSettingDetermineCaller': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingDetermineCaller = value as bool,
      'globalSettingInfoEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingInfoEnabled = value as bool,
      'globalSettingWarnEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingWarnEnabled = value as bool,
      'globalSettingErrorEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingErrorEnabled = value as bool,
      'globalSettingDebugEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingDebugEnabled = value as bool,
      'globalSettingTraceEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingTraceEnabled = value as bool,
      'globalSettingTrafficEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingTrafficEnabled = value as bool,
      'globalSettingSevereEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingSevereEnabled = value as bool,
      'globalSettingFatalEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingFatalEnabled = value as bool,
      'globalSettingStatusEnabled': (visitor, value) => 
        $tom_basics_2.TomLogger.globalSettingStatusEnabled = value as bool,
    },
    constructorSignatures: {
      '': 'TomLogger()',
    },
    methodSignatures: {
      'setLogLevel': 'void setLogLevel(TomLogLevel l)',
      'pushLogLevel': 'void pushLogLevel(TomLogLevel l)',
      'popLogLevel': 'void popLogLevel()',
      'info': 'void info(Object s)',
      'warn': 'void warn(Object s)',
      'error': 'void error(Object s)',
      'debug': 'void debug(Object s)',
      'trace': 'void trace(Object s)',
      'traffic': 'void traffic(Object s)',
      'severe': 'void severe(Object s)',
      'fatal': 'void fatal(Object s)',
      'status': 'void status(Object s)',
      'output': 'void output(TomLogLevel messageLogLevel, String level, Object message)',
      'addNameLevel': 'void addNameLevel(String t, TomLogLevel tll)',
      'getNameLevel': 'TomLogLevel? getNameLevel(String t)',
      'removeNameLevel': 'void removeNameLevel(String t)',
      'setLogLevelByName': 'void setLogLevelByName(String levelName)',
      'setLogLevelExceptions': 'void setLogLevelExceptions(String pattern)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'logLevel': 'TomLogLevel get logLevel',
      'logOutput': 'TomLogOutput get logOutput',
    },
    setterSignatures: {
      'logOutput': 'set logOutput(dynamic value)',
    },
    staticGetterSignatures: {
      'INFO': 'String get INFO',
      'ERROR': 'String get ERROR',
      'WARN': 'String get WARN',
      'DEBUG': 'String get DEBUG',
      'TRACE': 'String get TRACE',
      'TRAFFIC': 'String get TRAFFIC',
      'SEVERE': 'String get SEVERE',
      'FATAL': 'String get FATAL',
      'STATUS': 'String get STATUS',
      'globalSettingDetermineCaller': 'bool get globalSettingDetermineCaller',
      'fallback': 'Type get fallback',
      'globalSettingInfoEnabled': 'bool get globalSettingInfoEnabled',
      'globalSettingWarnEnabled': 'bool get globalSettingWarnEnabled',
      'globalSettingErrorEnabled': 'bool get globalSettingErrorEnabled',
      'globalSettingDebugEnabled': 'bool get globalSettingDebugEnabled',
      'globalSettingTraceEnabled': 'bool get globalSettingTraceEnabled',
      'globalSettingTrafficEnabled': 'bool get globalSettingTrafficEnabled',
      'globalSettingSevereEnabled': 'bool get globalSettingSevereEnabled',
      'globalSettingFatalEnabled': 'bool get globalSettingFatalEnabled',
      'globalSettingStatusEnabled': 'bool get globalSettingStatusEnabled',
    },
    staticSetterSignatures: {
      'globalSettingDetermineCaller': 'set globalSettingDetermineCaller(dynamic value)',
      'globalSettingInfoEnabled': 'set globalSettingInfoEnabled(dynamic value)',
      'globalSettingWarnEnabled': 'set globalSettingWarnEnabled(dynamic value)',
      'globalSettingErrorEnabled': 'set globalSettingErrorEnabled(dynamic value)',
      'globalSettingDebugEnabled': 'set globalSettingDebugEnabled(dynamic value)',
      'globalSettingTraceEnabled': 'set globalSettingTraceEnabled(dynamic value)',
      'globalSettingTrafficEnabled': 'set globalSettingTrafficEnabled(dynamic value)',
      'globalSettingSevereEnabled': 'set globalSettingSevereEnabled(dynamic value)',
      'globalSettingFatalEnabled': 'set globalSettingFatalEnabled(dynamic value)',
      'globalSettingStatusEnabled': 'set globalSettingStatusEnabled(dynamic value)',
    },
  );
}

// =============================================================================
// TomLoggable Bridge
// =============================================================================

BridgedClass _createTomLoggableBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLoggable,
    name: 'TomLoggable',
    constructors: {
    },
    getters: {
      'logRepresentation': (visitor, target) => D4.validateTarget<$tom_basics_2.TomLoggable>(target, 'TomLoggable').logRepresentation,
    },
    getterSignatures: {
      'logRepresentation': 'String get logRepresentation',
    },
  );
}

// =============================================================================
// TomLogOutput Bridge
// =============================================================================

BridgedClass _createTomLogOutputBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomLogOutput,
    name: 'TomLogOutput',
    constructors: {
    },
    methods: {
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogOutput>(target, 'TomLogOutput');
        D4.requireMinArgs(positional, 7, 'output');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'output');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 3, 'message', 'output');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'output');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'output');
        final origin = D4.getRequiredArg<String?>(positional, 6, 'origin', 'output');
        t.output(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
        return null;
      },
      'convertToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomLogOutput>(target, 'TomLogOutput');
        D4.requireMinArgs(positional, 1, 'convertToString');
        final message = D4.getRequiredArg<Object>(positional, 0, 'message', 'convertToString');
        return t.convertToString(message);
      },
    },
    staticGetters: {
      'globalSettingRemoteLogEndpoint': (visitor) => $tom_basics_2.TomLogOutput.globalSettingRemoteLogEndpoint,
    },
    staticSetters: {
      'globalSettingRemoteLogEndpoint': (visitor, value) => 
        $tom_basics_2.TomLogOutput.globalSettingRemoteLogEndpoint = value as String,
    },
    methodSignatures: {
      'output': 'void output(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, Object message, String isolateName, DateTime timeStamp, String? origin)',
      'convertToString': 'String convertToString(Object message)',
    },
    staticGetterSignatures: {
      'globalSettingRemoteLogEndpoint': 'String get globalSettingRemoteLogEndpoint',
    },
    staticSetterSignatures: {
      'globalSettingRemoteLogEndpoint': 'set globalSettingRemoteLogEndpoint(dynamic value)',
    },
  );
}

// =============================================================================
// TomConsoleLogOutput Bridge
// =============================================================================

BridgedClass _createTomConsoleLogOutputBridge() {
  return BridgedClass(
    nativeType: $tom_basics_2.TomConsoleLogOutput,
    name: 'TomConsoleLogOutput',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_2.TomConsoleLogOutput();
      },
    },
    getters: {
      'useExtendedFormat': (visitor, target) => D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput').useExtendedFormat,
    },
    setters: {
      'useExtendedFormat': (visitor, target, value) => 
        D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput').useExtendedFormat = value as bool,
    },
    methods: {
      'output': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput');
        D4.requireMinArgs(positional, 6, 'output');
        final loggerLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 0, 'loggerLevel', 'output');
        final logLevel = D4.getRequiredArg<$tom_basics_2.TomLogLevel>(positional, 1, 'logLevel', 'output');
        final level = D4.getRequiredArg<String>(positional, 2, 'level', 'output');
        final message = D4.getRequiredArg<Object>(positional, 3, 'message', 'output');
        final isolateName = D4.getRequiredArg<String>(positional, 4, 'isolateName', 'output');
        final timeStamp = D4.getRequiredArg<DateTime>(positional, 5, 'timeStamp', 'output');
        final origin = D4.getOptionalArg<String?>(positional, 6, 'origin');
        t.output(loggerLevel, logLevel, level, message, isolateName, timeStamp, origin);
        return null;
      },
      'convertToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_2.TomConsoleLogOutput>(target, 'TomConsoleLogOutput');
        D4.requireMinArgs(positional, 1, 'convertToString');
        final message = D4.getRequiredArg<Object>(positional, 0, 'message', 'convertToString');
        return t.convertToString(message);
      },
    },
    staticGetters: {
      'globalSettingStderrLogLevel': (visitor) => $tom_basics_2.TomConsoleLogOutput.globalSettingStderrLogLevel,
      'globalSettingStdoutLogLevel': (visitor) => $tom_basics_2.TomConsoleLogOutput.globalSettingStdoutLogLevel,
    },
    staticSetters: {
      'globalSettingStderrLogLevel': (visitor, value) => 
        $tom_basics_2.TomConsoleLogOutput.globalSettingStderrLogLevel = value as $tom_basics_2.TomLogLevel,
      'globalSettingStdoutLogLevel': (visitor, value) => 
        $tom_basics_2.TomConsoleLogOutput.globalSettingStdoutLogLevel = value as $tom_basics_2.TomLogLevel,
    },
    constructorSignatures: {
      '': 'TomConsoleLogOutput()',
    },
    methodSignatures: {
      'output': 'void output(TomLogLevel loggerLevel, TomLogLevel logLevel, String level, Object message, String isolateName, DateTime timeStamp, [String? origin])',
      'convertToString': 'String convertToString(Object message)',
    },
    getterSignatures: {
      'useExtendedFormat': 'bool get useExtendedFormat',
    },
    setterSignatures: {
      'useExtendedFormat': 'set useExtendedFormat(dynamic value)',
    },
    staticGetterSignatures: {
      'globalSettingStderrLogLevel': 'TomLogLevel get globalSettingStderrLogLevel',
      'globalSettingStdoutLogLevel': 'TomLogLevel get globalSettingStdoutLogLevel',
    },
    staticSetterSignatures: {
      'globalSettingStderrLogLevel': 'set globalSettingStderrLogLevel(dynamic value)',
      'globalSettingStdoutLogLevel': 'set globalSettingStdoutLogLevel(dynamic value)',
    },
  );
}

// =============================================================================
// TomPlatformUtils Bridge
// =============================================================================

BridgedClass _createTomPlatformUtilsBridge() {
  return BridgedClass(
    nativeType: $tom_basics_4.TomPlatformUtils,
    name: 'TomPlatformUtils',
    constructors: {
    },
    methods: {
      'isDesktop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isDesktop();
      },
      'isMobile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isMobile();
      },
      'isWeb': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isWeb();
      },
      'isWindows': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isWindows();
      },
      'isLinux': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isLinux();
      },
      'isMacOs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isMacOs();
      },
      'isFuchsia': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isFuchsia();
      },
      'isAndroid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isAndroid();
      },
      'isIos': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.isIos();
      },
      'outError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        D4.requireMinArgs(positional, 1, 'outError');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'outError');
        t.outError(s);
        return null;
      },
      'out': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        D4.requireMinArgs(positional, 1, 'out');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'out');
        t.out(s);
        return null;
      },
      'httpClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.httpClient();
      },
      'getTomEnvVars': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.getTomEnvVars();
      },
      'getBrowserLocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.getBrowserLocation();
      },
      'getIsolateName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomPlatformUtils>(target, 'TomPlatformUtils');
        return t.getIsolateName();
      },
    },
    staticGetters: {
      'envVars': (visitor) => $tom_basics_4.TomPlatformUtils.envVars,
      'current': (visitor) => $tom_basics_4.TomPlatformUtils.current,
    },
    staticMethods: {
      'setCurrentPlatform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setCurrentPlatform');
        final newCurrent = D4.getRequiredArg<$tom_basics_4.TomPlatformUtils>(positional, 0, 'newCurrent', 'setCurrentPlatform');
        return $tom_basics_4.TomPlatformUtils.setCurrentPlatform(newCurrent);
      },
    },
    staticSetters: {
      'envVars': (visitor, value) => 
        $tom_basics_4.TomPlatformUtils.envVars = (value as Map).cast<String, String>(),
    },
    methodSignatures: {
      'isDesktop': 'bool isDesktop()',
      'isMobile': 'bool isMobile()',
      'isWeb': 'bool isWeb()',
      'isWindows': 'bool isWindows()',
      'isLinux': 'bool isLinux()',
      'isMacOs': 'bool isMacOs()',
      'isFuchsia': 'bool isFuchsia()',
      'isAndroid': 'bool isAndroid()',
      'isIos': 'bool isIos()',
      'outError': 'void outError(String s)',
      'out': 'void out(String s)',
      'httpClient': 'Client httpClient()',
      'getTomEnvVars': 'Map<String, String> getTomEnvVars()',
      'getBrowserLocation': 'String? getBrowserLocation()',
      'getIsolateName': 'String getIsolateName()',
    },
    staticMethodSignatures: {
      'setCurrentPlatform': 'void setCurrentPlatform(TomPlatformUtils newCurrent)',
    },
    staticGetterSignatures: {
      'envVars': 'Map<String, String> get envVars',
      'current': 'TomPlatformUtils get current',
    },
    staticSetterSignatures: {
      'envVars': 'set envVars(dynamic value)',
    },
  );
}

// =============================================================================
// TomFallbackPlatformUtils Bridge
// =============================================================================

BridgedClass _createTomFallbackPlatformUtilsBridge() {
  return BridgedClass(
    nativeType: $tom_basics_4.TomFallbackPlatformUtils,
    name: 'TomFallbackPlatformUtils',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_4.TomFallbackPlatformUtils();
      },
    },
    methods: {
      'isDesktop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isDesktop();
      },
      'isMobile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isMobile();
      },
      'isWeb': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isWeb();
      },
      'isWindows': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isWindows();
      },
      'isLinux': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isLinux();
      },
      'isMacOs': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isMacOs();
      },
      'isFuchsia': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isFuchsia();
      },
      'isAndroid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isAndroid();
      },
      'isIos': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.isIos();
      },
      'outError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        D4.requireMinArgs(positional, 1, 'outError');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'outError');
        t.outError(s);
        return null;
      },
      'out': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        D4.requireMinArgs(positional, 1, 'out');
        final s = D4.getRequiredArg<String>(positional, 0, 's', 'out');
        t.out(s);
        return null;
      },
      'httpClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.httpClient();
      },
      'getTomEnvVars': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.getTomEnvVars();
      },
      'getBrowserLocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.getBrowserLocation();
      },
      'getIsolateName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_4.TomFallbackPlatformUtils>(target, 'TomFallbackPlatformUtils');
        return t.getIsolateName();
      },
    },
    constructorSignatures: {
      '': 'TomFallbackPlatformUtils()',
    },
    methodSignatures: {
      'isDesktop': 'bool isDesktop()',
      'isMobile': 'bool isMobile()',
      'isWeb': 'bool isWeb()',
      'isWindows': 'bool isWindows()',
      'isLinux': 'bool isLinux()',
      'isMacOs': 'bool isMacOs()',
      'isFuchsia': 'bool isFuchsia()',
      'isAndroid': 'bool isAndroid()',
      'isIos': 'bool isIos()',
      'outError': 'void outError(String s)',
      'out': 'void out(String s)',
      'httpClient': 'Client httpClient()',
      'getTomEnvVars': 'Map<String, String> getTomEnvVars()',
      'getBrowserLocation': 'String? getBrowserLocation()',
      'getIsolateName': 'String getIsolateName()',
    },
  );
}

// =============================================================================
// TomEnvironment Bridge
// =============================================================================

BridgedClass _createTomEnvironmentBridge() {
  return BridgedClass(
    nativeType: $tom_basics_3.TomEnvironment,
    name: 'TomEnvironment',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomEnvironment');
        final env = D4.getRequiredArg<String>(positional, 0, 'env', 'TomEnvironment');
        final parent = D4.getOptionalNamedArg<$tom_basics_3.TomEnvironment?>(named, 'parent');
        final initializerRaw = named['initializer'];
        final isTest = D4.getNamedArgWithDefault<bool>(named, 'isTest', false);
        final isDevelopment = D4.getNamedArgWithDefault<bool>(named, 'isDevelopment', false);
        return $tom_basics_3.TomEnvironment(env, parent: parent, initializer: initializerRaw == null ? null : ($tom_basics_3.TomEnvironment p0) { D4.callInterpreterCallback(visitor, initializerRaw, [p0]); }, isTest: isTest, isDevelopment: isDevelopment);
      },
    },
    getters: {
      'parent': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').parent,
      'env': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').env,
      'initializer': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').initializer,
      'isTest': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').isTest,
      'isDevelopment': (visitor, target) => D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment').isDevelopment,
    },
    methods: {
      'initialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment');
        t.initialize();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomEnvironment>(target, 'TomEnvironment');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TomEnvironment(String env, {TomEnvironment? parent, void Function(TomEnvironment)? initializer, bool isTest = false, bool isDevelopment = false})',
    },
    methodSignatures: {
      'initialize': 'void initialize()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'parent': 'TomEnvironment? get parent',
      'env': 'String get env',
      'initializer': 'void Function(TomEnvironment)? get initializer',
      'isTest': 'bool get isTest',
      'isDevelopment': 'bool get isDevelopment',
    },
  );
}

// =============================================================================
// TomPlatform Bridge
// =============================================================================

BridgedClass _createTomPlatformBridge() {
  return BridgedClass(
    nativeType: $tom_basics_3.TomPlatform,
    name: 'TomPlatform',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomPlatform');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TomPlatform');
        return $tom_basics_3.TomPlatform(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform').name,
    },
    methods: {
      'setInitializer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform');
        D4.requireMinArgs(positional, 1, 'setInitializer');
        if (positional.isEmpty) {
          throw ArgumentError('setInitializer: Missing required argument "initializer" at position 0');
        }
        final initializerRaw = positional[0];
        t.setInitializer(($tom_basics_3.TomPlatform p0, $tom_basics_3.TomEnvironment? p1) { D4.callInterpreterCallback(visitor, initializerRaw, [p0, p1]); });
        return null;
      },
      'initializePlatform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform');
        D4.requireMinArgs(positional, 1, 'initializePlatform');
        final env = D4.getRequiredArg<$tom_basics_3.TomEnvironment?>(positional, 0, 'env', 'initializePlatform');
        t.initializePlatform(env);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_basics_3.TomPlatform>(target, 'TomPlatform');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TomPlatform(String name)',
    },
    methodSignatures: {
      'setInitializer': 'void setInitializer(void Function(TomPlatform, TomEnvironment?) initializer)',
      'initializePlatform': 'void initializePlatform(TomEnvironment? env)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// TomRuntime Bridge
// =============================================================================

BridgedClass _createTomRuntimeBridge() {
  return BridgedClass(
    nativeType: $tom_basics_3.TomRuntime,
    name: 'TomRuntime',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_basics_3.TomRuntime();
      },
    },
    staticMethods: {
      'printReport': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.printReport();
      },
      'getEnvironments': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getEnvironments();
      },
      'addEnvironment': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addEnvironment');
        final env = D4.getRequiredArg<$tom_basics_3.TomEnvironment>(positional, 0, 'env', 'addEnvironment');
        return $tom_basics_3.TomRuntime.addEnvironment(env);
      },
      'setRootEnvironment': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setRootEnvironment');
        final env = D4.getRequiredArg<$tom_basics_3.TomEnvironment>(positional, 0, 'env', 'setRootEnvironment');
        return $tom_basics_3.TomRuntime.setRootEnvironment(env);
      },
      'setCurrentEnvironment': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setCurrentEnvironment');
        final name = D4.getRequiredArg<String?>(positional, 0, 'name', 'setCurrentEnvironment');
        final fallback = D4.getOptionalArgWithDefault<String>(positional, 1, 'fallback', "defaultRoot");
        return $tom_basics_3.TomRuntime.setCurrentEnvironment(name, fallback);
      },
      'getCurrentEnvironment': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getCurrentEnvironment();
      },
      'getEnvironmentHierarchy': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getEnvironmentHierarchy();
      },
      'getRoot': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getRoot();
      },
      'addPlatform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addPlatform');
        final platform = D4.getRequiredArg<$tom_basics_3.TomPlatform>(positional, 0, 'platform', 'addPlatform');
        return $tom_basics_3.TomRuntime.addPlatform(platform);
      },
      'getPlatforms': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getPlatforms();
      },
      'getCurrentPlatform': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.getCurrentPlatform();
      },
      'setCurrentPlatform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setCurrentPlatform');
        final platform = D4.getRequiredArg<$tom_basics_3.TomPlatform>(positional, 0, 'platform', 'setCurrentPlatform');
        return $tom_basics_3.TomRuntime.setCurrentPlatform(platform);
      },
      'initializePlatform': (visitor, positional, named, typeArgs) {
        return $tom_basics_3.TomRuntime.initializePlatform();
      },
    },
    constructorSignatures: {
      '': 'TomRuntime()',
    },
    staticMethodSignatures: {
      'printReport': 'String printReport()',
      'getEnvironments': 'List<TomEnvironment> getEnvironments()',
      'addEnvironment': 'TomEnvironment addEnvironment(TomEnvironment env)',
      'setRootEnvironment': 'void setRootEnvironment(TomEnvironment env)',
      'setCurrentEnvironment': 'void setCurrentEnvironment(String? name, [String fallback = "defaultRoot"])',
      'getCurrentEnvironment': 'TomEnvironment getCurrentEnvironment()',
      'getEnvironmentHierarchy': 'List<TomEnvironment> getEnvironmentHierarchy()',
      'getRoot': 'TomEnvironment getRoot()',
      'addPlatform': 'TomPlatform addPlatform(TomPlatform platform)',
      'getPlatforms': 'List<TomPlatform> getPlatforms()',
      'getCurrentPlatform': 'TomPlatform? getCurrentPlatform()',
      'setCurrentPlatform': 'void setCurrentPlatform(TomPlatform platform)',
      'initializePlatform': 'void initializePlatform()',
    },
  );
}

