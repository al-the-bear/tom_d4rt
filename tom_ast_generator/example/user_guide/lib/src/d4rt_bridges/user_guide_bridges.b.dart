// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-03-06T18:40:07.643096

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:user_guide_example/src/calculator.dart' as $user_guide_example_1;
import 'package:user_guide_example/src/greeter.dart' as $user_guide_example_2;

/// Bridge class for all module.
class AllBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createGreeterBridge(),
      _createCalculatorBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Greeter': 'package:user_guide_example/src/greeter.dart',
      'Calculator': 'package:user_guide_example/src/calculator.dart',
    };
  }

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
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
      'package:user_guide_example/src/calculator.dart',
      'package:user_guide_example/src/greeter.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:user_guide_example/user_guide_example.dart';";
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
// Greeter Bridge
// =============================================================================

BridgedClass _createGreeterBridge() {
  return BridgedClass(
    nativeType: $user_guide_example_2.Greeter,
    name: 'Greeter',
    isAssignable: (v) => v is $user_guide_example_2.Greeter,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Greeter');
        final greeting = D4.getRequiredArg<String>(positional, 0, 'greeting', 'Greeter');
        return $user_guide_example_2.Greeter(greeting);
      },
      'defaultGreeting': (visitor, positional, named) {
        return $user_guide_example_2.Greeter.defaultGreeting();
      },
    },
    getters: {
      'greeting': (visitor, target) => D4.validateTarget<$user_guide_example_2.Greeter>(target, 'Greeter').greeting,
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_guide_example_2.Greeter>(target, 'Greeter');
        D4.requireMinArgs(positional, 1, 'greet');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
        return t.greet(name);
      },
      'greetAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_guide_example_2.Greeter>(target, 'Greeter');
        D4.requireMinArgs(positional, 1, 'greetAll');
        if (positional.isEmpty) {
          throw ArgumentError('greetAll: Missing required argument "names" at position 0');
        }
        final names = D4.coerceList<String>(positional[0], 'names');
        return t.greetAll(names);
      },
    },
    constructorSignatures: {
      '': 'Greeter(String greeting)',
      'defaultGreeting': 'Greeter.defaultGreeting()',
    },
    methodSignatures: {
      'greet': 'String greet(String name)',
      'greetAll': 'String greetAll(List<String> names)',
    },
    getterSignatures: {
      'greeting': 'String get greeting',
    },
  );
}

// =============================================================================
// Calculator Bridge
// =============================================================================

BridgedClass _createCalculatorBridge() {
  return BridgedClass(
    nativeType: $user_guide_example_1.Calculator,
    name: 'Calculator',
    isAssignable: (v) => v is $user_guide_example_1.Calculator,
    constructors: {
      '': (visitor, positional, named) {
        return $user_guide_example_1.Calculator();
      },
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_guide_example_1.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return t.add(a, b);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_guide_example_1.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'subtract');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'subtract');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'subtract');
        return t.subtract(a, b);
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_guide_example_1.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'multiply');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'multiply');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'multiply');
        return t.multiply(a, b);
      },
      'divide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$user_guide_example_1.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'divide');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'divide');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'divide');
        final precision = D4.getNamedArgWithDefault<int>(named, 'precision', 2);
        return t.divide(a, b, precision: precision);
      },
    },
    staticMethods: {
      'quickAdd': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'quickAdd');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'quickAdd');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'quickAdd');
        return $user_guide_example_1.Calculator.quickAdd(a, b);
      },
    },
    constructorSignatures: {
      '': 'Calculator()',
    },
    methodSignatures: {
      'add': 'int add(int a, int b)',
      'subtract': 'int subtract(int a, int b)',
      'multiply': 'int multiply(int a, int b)',
      'divide': 'double divide(double a, double b, {int precision = 2})',
    },
    staticMethodSignatures: {
      'quickAdd': 'int quickAdd(int a, int b)',
    },
  );
}

