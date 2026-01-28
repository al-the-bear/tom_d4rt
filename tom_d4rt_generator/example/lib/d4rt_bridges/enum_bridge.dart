// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/lib/test_classes/enum_classes.dart
// Generated: 2026-01-28T18:18:49.244451

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

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes
    for (final bridge in bridgeClasses()) {
      interpreter.registerBridgedClass(bridge, importPath);
    }

    // Register bridged enums
    for (final enumDef in bridgedEnums()) {
      interpreter.registerBridgedEnum(enumDef, importPath);
    }
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

  /// Returns D4rt script code that documents available global functions.
  ///
  /// These functions are available directly in D4rt scripts when
  /// the import block is included in the initialization script.
  static List<String> get globalFunctionNames => [
  ];

  /// Returns a list of global variable names.
  static List<String> get globalVariableNames => [
  ];

  /// Returns D4rt script code to initialize global functions and variables.
  ///
  /// This script creates wrapper functions that delegate to the static methods
  /// in GlobalBridge, and mirrors global variables. Include this in your D4rt
  /// initialization script after registering bridges.
  ///
  /// Example:
  /// ```dart
  /// interpreter.execute(source: getGlobalInitializationScript());
  /// ```
  static String getGlobalInitializationScript() {
    return '''
''';
  }

}

