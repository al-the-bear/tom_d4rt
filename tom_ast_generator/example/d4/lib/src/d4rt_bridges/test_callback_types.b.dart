// D4rt Bridge - Generated file, do not edit
<<<<<<< Updated upstream
// Source: /srv/repos/al_the_bear/inhouse/second_wind/enterprise_flutter/tom_agent_container/tom/xternal/tom_module_d4rt/tom_ast_generator/example/d4/lib/test_callback_types.dart
// Generated: 2026-02-21T15:07:57.976735
=======
// Source: C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\test_callback_types.dart
// Generated: 2026-03-12T17:02:45.490302
>>>>>>> Stashed changes

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';
import 'dart:async';


/// Bridge class for test_callback_types module.
class TestCallbackTypesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createGenericCallbackServiceBridge(),
      _createCallbackTypeServiceBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'GenericCallbackService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\test_callback_types.dart',
      'CallbackTypeService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\test_callback_types.dart',
    };
  }

<<<<<<< Updated upstream
=======
  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
    };
  }

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
    ];
  }

>>>>>>> Stashed changes
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
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\test_callback_types.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4_example/test_callback_types.dart';";
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
// GenericCallbackService Bridge
// =============================================================================

BridgedClass _createGenericCallbackServiceBridge() {
  return BridgedClass(
    nativeType: GenericCallbackService,
    name: 'GenericCallbackService',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is GenericCallbackService,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return GenericCallbackService();
      },
    },
    methods: {
      'withConnection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<GenericCallbackService>(target, 'GenericCallbackService');
        D4.requireMinArgs(positional, 1, 'withConnection');
        if (positional.isEmpty) {
          throw ArgumentError('withConnection: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.withConnection((dynamic p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
      'transactional': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<GenericCallbackService>(target, 'GenericCallbackService');
        D4.requireMinArgs(positional, 1, 'transactional');
        if (positional.isEmpty) {
          throw ArgumentError('transactional: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.transactional((String p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
      'withBoundedType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<GenericCallbackService>(target, 'GenericCallbackService');
        D4.requireMinArgs(positional, 1, 'withBoundedType');
        if (positional.isEmpty) {
          throw ArgumentError('withBoundedType: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.withBoundedType((dynamic p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
    },
    constructorSignatures: {
      '': 'GenericCallbackService()',
    },
    methodSignatures: {
      'withConnection': 'FutureOr<T> withConnection(FutureOr<T> Function(dynamic connection) callback)',
      'transactional': 'Future<T> transactional(FutureOr<T> Function(String input) callback)',
      'withBoundedType': 'FutureOr<T> withBoundedType(FutureOr<T> Function(dynamic conn) callback)',
    },
  );
}

// =============================================================================
// CallbackTypeService Bridge
// =============================================================================

BridgedClass _createCallbackTypeServiceBridge() {
  return BridgedClass(
    nativeType: CallbackTypeService,
    name: 'CallbackTypeService',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is CallbackTypeService,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return CallbackTypeService();
      },
    },
    methods: {
      'withConnection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CallbackTypeService>(target, 'CallbackTypeService');
        D4.requireMinArgs(positional, 1, 'withConnection');
        if (positional.isEmpty) {
          throw ArgumentError('withConnection: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.withConnection((dynamic p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as FutureOr<Object>; });
      },
    },
    constructorSignatures: {
      '': 'CallbackTypeService()',
    },
    methodSignatures: {
      'withConnection': 'Future<String> withConnection(FutureOr<Object> Function(dynamic connection) callback)',
    },
  );
}

