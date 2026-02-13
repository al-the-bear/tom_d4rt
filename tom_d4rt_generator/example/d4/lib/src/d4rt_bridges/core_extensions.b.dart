// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/d4/lib/test_extensions.dart
// Generated: 2026-02-13T11:49:21.088560

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4_example/test_extensions.dart' as $pkg;

/// Bridge class for core_extensions module.
class CoreExtensionsBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createItemProcessorBridge(),
      _createTestPointBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'ItemProcessor': 'package:d4_example/test_extensions.dart',
      'TestPoint': 'package:d4_example/test_extensions.dart',
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
      BridgedExtensionDefinition(
        name: 'StringExtension',
        onTypeName: 'String',
        getters: {
          'reversed': (visitor, target) => (target as String).reversed,
          'isBlank': (visitor, target) => (target as String).isBlank,
          'isNotBlank': (visitor, target) => (target as String).isNotBlank,
          'inParens': (visitor, target) => (target as String).inParens,
        },
        methods: {
          'repeatWith': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.repeatWith, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedExtensionDefinition(
        name: 'IntExtension',
        onTypeName: 'int',
        getters: {
          'isEven': (visitor, target) => (target as int).isEven,
          'isOdd': (visitor, target) => (target as int).isOdd,
          'factorial': (visitor, target) => (target as int).factorial,
        },
        methods: {
          'clampTo': (visitor, target, positional, named, typeArgs) {
            final t = target as int;
            return Function.apply(t.clampTo, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
      'StringExtension': 'package:d4_example/test_extensions.dart',
      'IntExtension': 'package:d4_example/test_extensions.dart',
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

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'processItems': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processItems');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'processItems');
        if (positional.length <= 1) {
          throw ArgumentError('processItems: Missing required argument "transform" at position 1');
        }
        final transformRaw = positional[1];
        final transform = (dynamic p0) { return (transformRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; };
        return $pkg.processItems<dynamic, dynamic>(items, transform);
      },
      'filterItems': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'filterItems');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'filterItems');
        final predicateRaw = named['predicate'];
        final predicate = predicateRaw == null ? null : (dynamic p0) { return (predicateRaw as InterpretedFunction).call(visitor, [p0]) as bool; };
        return $pkg.filterItems<dynamic>(items, predicate: predicate);
      },
      'promptUser': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'promptUser');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'promptUser');
        final customPromptRaw = named['customPrompt'];
        final customPrompt = customPromptRaw == null ? null : (String p0, String? p1, bool p2) { return (customPromptRaw as InterpretedFunction).call(visitor, [p0, p1, p2]) as String; };
        final defaultValue = D4.getOptionalNamedArg<String?>(named, 'defaultValue');
        final required = D4.getNamedArgWithDefault<bool>(named, 'required', true);
        return $pkg.promptUser(message, customPrompt: customPrompt, defaultValue: defaultValue, required: required);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'processItems': 'package:d4_example/test_extensions.dart',
      'filterItems': 'package:d4_example/test_extensions.dart',
      'promptUser': 'package:d4_example/test_extensions.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'processItems': 'List<R> processItems(List<T> items, R Function(T item) transform)',
      'filterItems': 'List<T> filterItems(List<T> items, {bool Function(T item)? predicate})',
      'promptUser': 'String promptUser(String message, {String Function(String prompt, String? defaultValue, bool required)? customPrompt, String? defaultValue, bool required = true})',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:d4_example/test_extensions.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4_example/test_extensions.dart';";
  }

}

// =============================================================================
// ItemProcessor Bridge
// =============================================================================

BridgedClass _createItemProcessorBridge() {
  return BridgedClass(
    nativeType: $pkg.ItemProcessor,
    name: 'ItemProcessor',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ItemProcessor');
        if (positional.isEmpty) {
          throw ArgumentError('ItemProcessor: Missing required argument "transform" at position 0');
        }
        final transformRaw = positional[0];
        return $pkg.ItemProcessor((dynamic p0) { return (transformRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; });
      },
      'identity': (visitor, positional, named) {
        return $pkg.ItemProcessor.identity();
      },
    },
    getters: {
      'transform': (visitor, target) => D4.validateTarget<$pkg.ItemProcessor>(target, 'ItemProcessor').transform,
    },
    methods: {
      'process': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ItemProcessor>(target, 'ItemProcessor');
        D4.requireMinArgs(positional, 1, 'process');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'process');
        return t.process(item);
      },
      'processAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ItemProcessor>(target, 'ItemProcessor');
        D4.requireMinArgs(positional, 1, 'processAll');
        if (positional.isEmpty) {
          throw ArgumentError('processAll: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<dynamic>(positional[0], 'items');
        return t.processAll(items);
      },
    },
    constructorSignatures: {
      '': 'ItemProcessor(T Function(T) transform)',
      'identity': 'ItemProcessor.identity()',
    },
    methodSignatures: {
      'process': 'T process(T item)',
      'processAll': 'List<T> processAll(List<T> items)',
    },
    getterSignatures: {
      'transform': 'T Function(T) get transform',
    },
  );
}

// =============================================================================
// TestPoint Bridge
// =============================================================================

BridgedClass _createTestPointBridge() {
  return BridgedClass(
    nativeType: $pkg.TestPoint,
    name: 'TestPoint',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TestPoint');
        final x = D4.getRequiredArg<int>(positional, 0, 'x', 'TestPoint');
        final y = D4.getRequiredArg<int>(positional, 1, 'y', 'TestPoint');
        return $pkg.TestPoint(x, y);
      },
      'origin': (visitor, positional, named) {
        return $pkg.TestPoint.origin();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$pkg.TestPoint>(target, 'TestPoint').x,
      'y': (visitor, target) => D4.validateTarget<$pkg.TestPoint>(target, 'TestPoint').y,
      'distanceFromOrigin': (visitor, target) => D4.validateTarget<$pkg.TestPoint>(target, 'TestPoint').distanceFromOrigin,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TestPoint>(target, 'TestPoint');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TestPoint>(target, 'TestPoint');
        final other = D4.getRequiredArg<$pkg.TestPoint>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    constructorSignatures: {
      '': 'const TestPoint(int x, int y)',
      'origin': 'const TestPoint.origin()',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'int get x',
      'y': 'int get y',
      'distanceFromOrigin': 'double get distanceFromOrigin',
    },
  );
}

