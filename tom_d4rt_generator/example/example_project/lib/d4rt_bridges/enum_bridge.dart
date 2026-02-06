// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/example_project/lib/test_classes/enum_classes.dart
// Generated: 2026-02-06T08:25:32.161948

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Enum module.
class EnumBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$pkg.Status>(
        name: 'Status',
        values: $pkg.Status.values,
      ),
      BridgedEnumDefinition<$pkg.Priority>(
        name: 'Priority',
        values: $pkg.Priority.values,
      ),
      BridgedEnumDefinition<$pkg.Color>(
        name: 'Color',
        values: $pkg.Color.values,
      ),
      BridgedEnumDefinition<$pkg.HttpMethod>(
        name: 'HttpMethod',
        values: $pkg.HttpMethod.values,
      ),
      BridgedEnumDefinition<$pkg.DayOfWeek>(
        name: 'DayOfWeek',
        values: $pkg.DayOfWeek.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'Status': 'package:d4rt_generator_example/test_classes/enum_classes.dart',
      'Priority': 'package:d4rt_generator_example/test_classes/enum_classes.dart',
      'Color': 'package:d4rt_generator_example/test_classes/enum_classes.dart',
      'HttpMethod': 'package:d4rt_generator_example/test_classes/enum_classes.dart',
      'DayOfWeek': 'package:d4rt_generator_example/test_classes/enum_classes.dart',
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
      'package:d4rt_generator_example/test_classes/enum_classes.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_generator_example/test_classes.dart';";
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'Status',
    'Priority',
    'Color',
    'HttpMethod',
    'DayOfWeek',
  ];

}

