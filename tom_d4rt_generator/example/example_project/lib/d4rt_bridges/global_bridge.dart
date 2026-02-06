// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/example_project/lib/test_classes/global_members.dart
// Generated: 2026-02-06T08:25:30.816629

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Global module.
class GlobalBridge {
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
      interpreter.registerGlobalVariable('appVersion', $pkg.appVersion, importPath, sourceUri: 'package:d4rt_generator_example/test_classes/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "appVersion": $e');
    }
    try {
      interpreter.registerGlobalVariable('appName', $pkg.appName, importPath, sourceUri: 'package:d4rt_generator_example/test_classes/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "appName": $e');
    }
    try {
      interpreter.registerGlobalVariable('defaultTimeout', $pkg.defaultTimeout, importPath, sourceUri: 'package:d4rt_generator_example/test_classes/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('pi', $pkg.pi, importPath, sourceUri: 'package:d4rt_generator_example/test_classes/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "pi": $e');
    }
    try {
      interpreter.registerGlobalVariable('globalCounter', $pkg.globalCounter, importPath, sourceUri: 'package:d4rt_generator_example/test_classes/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "globalCounter": $e');
    }
    try {
      interpreter.registerGlobalVariable('registeredNames', $pkg.registeredNames, importPath, sourceUri: 'package:d4rt_generator_example/test_classes/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "registeredNames": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (Global):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'greet': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'greet');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
        return $pkg.greet(name);
      },
      'add': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return $pkg.add(a, b);
      },
      'multiply': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'multiply');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'multiply');
        final factor = D4.getOptionalArgWithDefault<double>(positional, 1, 'factor', 1.0);
        return $pkg.multiply(value, factor);
      },
      'circleArea': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'circleArea');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'circleArea');
        return $pkg.circleArea(radius);
      },
      'formatMessage': (visitor, positional, named, typeArgs) {
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'formatMessage');
        final prefix = D4.getNamedArgWithDefault<String>(named, 'prefix', '');
        final suffix = D4.getNamedArgWithDefault<String>(named, 'suffix', '');
        return $pkg.formatMessage(message: message, prefix: prefix, suffix: suffix);
      },
      'identity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return $pkg.identity<dynamic>(value);
      },
      'makePair': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'makePair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'makePair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'makePair');
        return $pkg.makePair<dynamic, dynamic>(first, second);
      },
      'firstOrNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'firstOrNull');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'firstOrNull');
        return $pkg.firstOrNull<dynamic>(items);
      },
      'findWhere': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'findWhere');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'findWhere');
        final predicate = D4.getRequiredArg<bool Function(dynamic)>(positional, 1, 'predicate', 'findWhere');
        return $pkg.findWhere<dynamic>(items, predicate);
      },
      'mapList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mapList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'mapList');
        final mapper = D4.getRequiredArg<dynamic Function(dynamic)>(positional, 1, 'mapper', 'mapList');
        return $pkg.mapList<dynamic, dynamic>(items, mapper);
      },
      'filterList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'filterList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'filterList');
        final predicate = D4.getRequiredArg<bool Function(dynamic)>(positional, 1, 'predicate', 'filterList');
        return $pkg.filterList<dynamic>(items, predicate);
      },
      'reduceList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'reduceList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'reduceList');
        final combiner = D4.getRequiredArg<dynamic Function(dynamic, dynamic)>(positional, 1, 'combiner', 'reduceList');
        return $pkg.reduceList<dynamic>(items, combiner);
      },
      'sortItems': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sortItems');
        final sample = positional[0] as List;
        if (sample.isEmpty) return <dynamic>[];
        final firstElem = sample.first;
        if (firstElem is num) {
          return $pkg.sortItems<num>((positional[0] as List).cast<num>());
        }
        if (firstElem is String) {
          return $pkg.sortItems<String>((positional[0] as List).cast<String>());
        }
        if (firstElem is DateTime) {
          return $pkg.sortItems<DateTime>((positional[0] as List).cast<DateTime>());
        }
        throw ArgumentError('sortItems: Unsupported type for recursive bound. Supported types: num, String, DateTime. Got: ${_sample.runtimeType}');
      },
      'minValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'minValue');
        final sample = positional[0];
        if (sample is num) {
          return $pkg.minValue<num>(positional[0] as num, positional[1] as num);
        }
        if (sample is String) {
          return $pkg.minValue<String>(positional[0] as String, positional[1] as String);
        }
        if (sample is DateTime) {
          return $pkg.minValue<DateTime>(positional[0] as DateTime, positional[1] as DateTime);
        }
        throw ArgumentError('minValue: Unsupported type for recursive bound. Supported types: num, String, DateTime. Got: ${_sample.runtimeType}');
      },
      'maxValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'maxValue');
        final sample = positional[0];
        if (sample is num) {
          return $pkg.maxValue<num>(positional[0] as num, positional[1] as num);
        }
        if (sample is String) {
          return $pkg.maxValue<String>(positional[0] as String, positional[1] as String);
        }
        if (sample is DateTime) {
          return $pkg.maxValue<DateTime>(positional[0] as DateTime, positional[1] as DateTime);
        }
        throw ArgumentError('maxValue: Unsupported type for recursive bound. Supported types: num, String, DateTime. Got: ${_sample.runtimeType}');
      },
      'delayedGreeting': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'delayedGreeting');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'delayedGreeting');
        final delayMs = D4.getRequiredArg<int>(positional, 1, 'delayMs', 'delayedGreeting');
        return $pkg.delayedGreeting(name, delayMs);
      },
      'fetchData': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fetchData');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'fetchData');
        return $pkg.fetchData(id);
      },
      'processAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processAsync');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'processAsync');
        final processor = D4.getRequiredArg<Future<dynamic> Function(dynamic)>(positional, 1, 'processor', 'processAsync');
        return $pkg.processAsync<dynamic, dynamic>(items, processor);
      },
      'incrementCounter': (visitor, positional, named, typeArgs) {
        return $pkg.incrementCounter();
      },
      'resetCounter': (visitor, positional, named, typeArgs) {
        return $pkg.resetCounter();
      },
      'registerName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'registerName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerName');
        return $pkg.registerName(name);
      },
      'getRegisteredNames': (visitor, positional, named, typeArgs) {
        return $pkg.getRegisteredNames();
      },
      'clearNames': (visitor, positional, named, typeArgs) {
        return $pkg.clearNames();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'greet': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'add': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'multiply': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'circleArea': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'formatMessage': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'identity': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'makePair': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'firstOrNull': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'findWhere': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'mapList': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'filterList': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'reduceList': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'sortItems': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'minValue': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'maxValue': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'delayedGreeting': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'fetchData': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'processAsync': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'incrementCounter': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'resetCounter': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'registerName': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'getRegisteredNames': 'package:d4rt_generator_example/test_classes/global_members.dart',
      'clearNames': 'package:d4rt_generator_example/test_classes/global_members.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'greet': 'String greet(String name)',
      'add': 'int add(int a, int b)',
      'multiply': 'double multiply(double value, [double factor = 1.0])',
      'circleArea': 'double circleArea(double radius)',
      'formatMessage': 'String formatMessage({required String message, String prefix = \'\', String suffix = \'\'})',
      'identity': 'T identity(T value)',
      'makePair': '(A, B) makePair(A first, B second)',
      'firstOrNull': 'T? firstOrNull(List<T> items)',
      'findWhere': 'T? findWhere(List<T> items, bool Function(T) predicate)',
      'mapList': 'List<R> mapList(List<T> items, R Function(T) mapper)',
      'filterList': 'List<T> filterList(List<T> items, bool Function(T) predicate)',
      'reduceList': 'T reduceList(List<T> items, T Function(T, T) combiner)',
      'sortItems': 'List<T> sortItems(List<T> items)',
      'minValue': 'T minValue(T a, T b)',
      'maxValue': 'T maxValue(T a, T b)',
      'delayedGreeting': 'Future<String> delayedGreeting(String name, int delayMs)',
      'fetchData': 'Future<Map<String, dynamic>> fetchData(String id)',
      'processAsync': 'Future<List<R>> processAsync(List<T> items, Future<R> Function(T) processor)',
      'incrementCounter': 'int incrementCounter()',
      'resetCounter': 'void resetCounter()',
      'registerName': 'bool registerName(String name)',
      'getRegisteredNames': 'List<String> getRegisteredNames()',
      'clearNames': 'void clearNames()',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:d4rt_generator_example/test_classes/global_members.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_generator_example/test_classes.dart';";
  }

}

