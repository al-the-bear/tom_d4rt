// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/al_the_bear/inhouse/second_wind/enterprise_flutter/tom_agent_container/tom_ai/d4rt/tom_d4rt_generator/example/d4/lib/test_part_of_files.dart
// Generated: 2026-02-26T19:16:14.649831

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4_example/test_part_of_files.dart' as $d4_example_1;

/// Bridge class for test_part_of_files module.
class TestPartOfFilesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createPartOfTestServiceBridge(),
      _createPartCallbackBridge(),
      _createPartDataBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'PartOfTestService': 'package:d4_example/test_part_of_files.dart',
      'PartCallback': 'package:d4_example/test_part_of_files.dart',
      'PartData': 'package:d4_example/test_part_of_files.dart',
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
      'package:d4_example/test_part_of_files.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4_example/test_part_of_files.dart';";
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
// PartOfTestService Bridge
// =============================================================================

BridgedClass _createPartOfTestServiceBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.PartOfTestService,
    name: 'PartOfTestService',
    constructors: {
      '': (visitor, positional, named) {
        final callback = D4.getOptionalNamedArg<$d4_example_1.PartCallback?>(named, 'callback');
        final data = D4.getRequiredNamedArg<$d4_example_1.PartData>(named, 'data', 'PartOfTestService');
        return $d4_example_1.PartOfTestService(callback: callback, data: data);
      },
    },
    getters: {
      'callback': (visitor, target) => D4.validateTarget<$d4_example_1.PartOfTestService>(target, 'PartOfTestService').callback,
      'data': (visitor, target) => D4.validateTarget<$d4_example_1.PartOfTestService>(target, 'PartOfTestService').data,
    },
    methods: {
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.PartOfTestService>(target, 'PartOfTestService');
        t.execute();
        return null;
      },
    },
    constructorSignatures: {
      '': 'PartOfTestService({PartCallback? callback, required PartData data})',
    },
    methodSignatures: {
      'execute': 'void execute()',
    },
    getterSignatures: {
      'callback': 'PartCallback? get callback',
      'data': 'PartData get data',
    },
  );
}

// =============================================================================
// PartCallback Bridge
// =============================================================================

BridgedClass _createPartCallbackBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.PartCallback,
    name: 'PartCallback',
    constructors: {
      '': (visitor, positional, named) {
        final onDataRaw = named['onData'];
        final onErrorRaw = named['onError'];
        return $d4_example_1.PartCallback(onData: onDataRaw == null ? null : ($d4_example_1.PartData p0) { D4.callInterpreterCallback(visitor, onDataRaw, [p0]); }, onError: onErrorRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0]); });
      },
      'dataOnly': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PartCallback');
        if (positional.isEmpty) {
          throw ArgumentError('PartCallback: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        return $d4_example_1.PartCallback.dataOnly(($d4_example_1.PartData p0) { D4.callInterpreterCallback(visitor, handlerRaw, [p0]); });
      },
    },
    getters: {
      'onData': (visitor, target) => D4.validateTarget<$d4_example_1.PartCallback>(target, 'PartCallback').onData,
      'onError': (visitor, target) => D4.validateTarget<$d4_example_1.PartCallback>(target, 'PartCallback').onError,
    },
    constructorSignatures: {
      '': 'const PartCallback({void Function(PartData)? onData, void Function(String)? onError})',
      'dataOnly': 'factory PartCallback.dataOnly(void Function(PartData data) handler)',
    },
    getterSignatures: {
      'onData': 'void Function(PartData data)? get onData',
      'onError': 'void Function(String error)? get onError',
    },
  );
}

// =============================================================================
// PartData Bridge
// =============================================================================

BridgedClass _createPartDataBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.PartData,
    name: 'PartData',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'PartData');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'PartData');
        final value = D4.getRequiredArg<int>(positional, 1, 'value', 'PartData');
        return $d4_example_1.PartData(name, value);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_1.PartData>(target, 'PartData').name,
      'value': (visitor, target) => D4.validateTarget<$d4_example_1.PartData>(target, 'PartData').value,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.PartData>(target, 'PartData');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const PartData(String name, int value)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'value': 'int get value',
    },
  );
}

