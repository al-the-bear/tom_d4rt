// D4rt Bridge - Generated file, do not edit
// Source: C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_extensions.dart
// Generated: 2026-03-12T17:06:46.326923

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4_example/test_extensions.dart' as $d4_example_1;

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
      'ItemProcessor': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_extensions.dart',
      'TestPoint': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_extensions.dart',
    };
  }

        final transform = (dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, transformRaw, [p0])); };
        return processItems<dynamic, dynamic>(items, transform);
      },
      'filterItems': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'filterItems');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'filterItems');
        final predicateRaw = named['predicate'];
        final predicate = predicateRaw == null ? null : (dynamic p0) { return D4.callInterpreterCallback(visitor!, predicateRaw, [p0]) as bool; };
        return filterItems<dynamic>(items, predicate: predicate);
      },
      'promptUser': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'promptUser');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'promptUser');
        final customPromptRaw = named['customPrompt'];
        final customPrompt = customPromptRaw == null ? null : (String p0, String? p1, bool p2) { return D4.callInterpreterCallback(visitor, customPromptRaw, [p0, p1, p2]) as String; };
        final defaultValue = D4.getOptionalNamedArg<String?>(named, 'defaultValue');
        final required = D4.getNamedArgWithDefault<bool>(named, 'required', true);
        return promptUser(message, customPrompt: customPrompt, defaultValue: defaultValue, required: required);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'processItems': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_extensions.dart',
      'filterItems': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_extensions.dart',
      'promptUser': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_extensions.dart',
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
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\test_extensions.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4_example/test_extensions.dart';";
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
// ItemProcessor Bridge
// =============================================================================

BridgedClass _createItemProcessorBridge() {
  return BridgedClass(
    nativeType: ItemProcessor,
    name: 'ItemProcessor',
        return ItemProcessor((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, transformRaw, [p0])); });
      },
      'identity': (visitor, positional, named) {
        return ItemProcessor.identity();
      },
    },
    getters: {
      'transform': (visitor, target) => D4.validateTarget<ItemProcessor>(target, 'ItemProcessor').transform,
    },
    methods: {
      'process': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ItemProcessor>(target, 'ItemProcessor');
        D4.requireMinArgs(positional, 1, 'process');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'process');
        return t.process(item);
      },
      'processAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ItemProcessor>(target, 'ItemProcessor');
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
    nativeType: $d4_example_1.TestPoint,
    name: 'TestPoint',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TestPoint');
        final x = D4.getRequiredArg<int>(positional, 0, 'x', 'TestPoint');
        final y = D4.getRequiredArg<int>(positional, 1, 'y', 'TestPoint');
        return $d4_example_1.TestPoint(x, y);
      },
      'origin': (visitor, positional, named) {
        return $d4_example_1.TestPoint.origin();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$d4_example_1.TestPoint>(target, 'TestPoint').x,
      'y': (visitor, target) => D4.validateTarget<$d4_example_1.TestPoint>(target, 'TestPoint').y,
      'distanceFromOrigin': (visitor, target) => D4.validateTarget<$d4_example_1.TestPoint>(target, 'TestPoint').distanceFromOrigin,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.TestPoint>(target, 'TestPoint');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.TestPoint>(target, 'TestPoint');
        final other = D4.getRequiredArg<$d4_example_1.TestPoint>(positional, 0, 'other', 'operator+');
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

