// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
<<<<<<< Updated upstream
// Generated: 2026-02-22T08:01:23.514816
=======
// Generated: 2026-03-12T17:03:57.021121
>>>>>>> Stashed changes

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

import 'package:d4_example/src/userbridge_override/my_list.dart' as $d4_example_1;

/// Bridge class for userbridge_override module.
class UserbridgeOverrideBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createMyListBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'MyList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\my_list.dart',
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
      interpreter.registerGlobalVariable('appName', appName, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\globals.dart');
    } catch (e) {
      errors.add('Failed to register variable "appName": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxRetries', maxRetries, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\globals.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxRetries": $e');
    }
    try {
      interpreter.registerGlobalVariable('version', version, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\globals.dart');
    } catch (e) {
      errors.add('Failed to register variable "version": $e');
    }
    interpreter.registerGlobalGetter('currentTime', () => currentTime, importPath, sourceUri: 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\globals.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (userbridge_override):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'greet': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'greet');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
        return greet(name);
      },
      'calculate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'calculate');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'calculate');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'calculate');
        final operation = D4.getNamedArgWithDefault<String>(named, 'operation', 'add');
        return calculate(a, b, operation: operation);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'greet': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\globals.dart',
      'calculate': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\globals.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'greet': 'String greet(String name)',
      'calculate': 'int calculate(int a, int b, {String operation = \'add\'})',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\globals.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\d4\lib\src\userbridge_override\my_list.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4_example/userbridge_override.dart';";
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
// MyList Bridge
// =============================================================================

BridgedClass _createMyListBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.MyList,
    name: 'MyList',
<<<<<<< Updated upstream
=======
    isAssignable: (v) => v is $d4_example_1.MyList,
>>>>>>> Stashed changes
    constructors: {
      '': (visitor, positional, named) {
        return $d4_example_1.MyList();
      },
    },
    getters: {
      'length': (visitor, target) => D4.validateTarget<$d4_example_1.MyList>(target, 'MyList').length,
      'isEmpty': (visitor, target) => D4.validateTarget<$d4_example_1.MyList>(target, 'MyList').isEmpty,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        D4.requireMinArgs(positional, 1, 'remove');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'remove');
        return t.remove(item);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        t.clear();
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.MyList>(target, 'MyList');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticMethods: {
      'empty': (visitor, positional, named, typeArgs) {
        return $d4_example_1.MyList.empty();
      },
      'from': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'from');
        if (positional.isEmpty) {
          throw ArgumentError('from: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<dynamic>(positional[0], 'items');
        return $d4_example_1.MyList.from(items);
      },
    },
    constructorSignatures: {
      '': 'MyList()',
    },
    methodSignatures: {
      'add': 'void add(T item)',
      'remove': 'bool remove(T item)',
      'clear': 'void clear()',
    },
    getterSignatures: {
      'length': 'int get length',
      'isEmpty': 'bool get isEmpty',
    },
    staticMethodSignatures: {
      'empty': 'MyList<T> empty()',
      'from': 'MyList<T> from(List<T> items)',
    },
  );
}

