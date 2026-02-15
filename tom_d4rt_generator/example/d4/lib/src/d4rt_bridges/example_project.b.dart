// D4rt Bridge - Generated file, do not edit
// Sources: 7 files
// Generated: 2026-02-15T12:44:01.585305

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:d4_example/src/example_project/basic_classes.dart' as $d4_example_1;
import 'package:d4_example/src/example_project/callback_classes.dart' as $d4_example_2;
import 'package:d4_example/src/example_project/enum_classes.dart' as $d4_example_3;
import 'package:d4_example/src/example_project/generic_classes.dart' as $d4_example_4;
import 'package:d4_example/src/example_project/global_members.dart' as $d4_example_5;
import 'package:d4_example/src/example_project/inheritance_classes.dart' as $d4_example_6;
import 'package:d4_example/src/example_project/operator_classes.dart' as $d4_example_7;

/// Bridge class for example_project module.
class ExampleProjectBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createPersonBridge(),
      _createCalculatorBridge(),
      _createMathUtilsBridge(),
      _createResultBridge(),
      _createTaskSchedulerBridge(),
      _createAsyncServiceBridge(),
      _createEventEmitterBridge(),
      _createIdentifiableBridge(),
      _createEntityBridge(),
      _createBoxBridge(),
      _createRepositoryBridge(),
      _createPairBridge(),
      _createTransformerBridge(),
      _createShapeBridge(),
      _createCircleBridge(),
      _createRectangleBridge(),
      _createSerializableBridge(),
      _createCloneableBridge(),
      _createPointBridge(),
      _createColoredRectangleBridge(),
      _createVector2DBridge(),
      _createMatrixBridge(),
      _createDictionaryBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Person': 'package:d4_example/src/example_project/basic_classes.dart',
      'Calculator': 'package:d4_example/src/example_project/basic_classes.dart',
      'MathUtils': 'package:d4_example/src/example_project/basic_classes.dart',
      'Result': 'package:d4_example/src/example_project/callback_classes.dart',
      'TaskScheduler': 'package:d4_example/src/example_project/callback_classes.dart',
      'AsyncService': 'package:d4_example/src/example_project/callback_classes.dart',
      'EventEmitter': 'package:d4_example/src/example_project/callback_classes.dart',
      'Identifiable': 'package:d4_example/src/example_project/generic_classes.dart',
      'Entity': 'package:d4_example/src/example_project/generic_classes.dart',
      'Box': 'package:d4_example/src/example_project/generic_classes.dart',
      'Repository': 'package:d4_example/src/example_project/generic_classes.dart',
      'Pair': 'package:d4_example/src/example_project/generic_classes.dart',
      'Transformer': 'package:d4_example/src/example_project/generic_classes.dart',
      'Shape': 'package:d4_example/src/example_project/inheritance_classes.dart',
      'Circle': 'package:d4_example/src/example_project/inheritance_classes.dart',
      'Rectangle': 'package:d4_example/src/example_project/inheritance_classes.dart',
      'Serializable': 'package:d4_example/src/example_project/inheritance_classes.dart',
      'Cloneable': 'package:d4_example/src/example_project/inheritance_classes.dart',
      'Point': 'package:d4_example/src/example_project/inheritance_classes.dart',
      'ColoredRectangle': 'package:d4_example/src/example_project/inheritance_classes.dart',
      'Vector2D': 'package:d4_example/src/example_project/operator_classes.dart',
      'Matrix': 'package:d4_example/src/example_project/operator_classes.dart',
      'Dictionary': 'package:d4_example/src/example_project/operator_classes.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$d4_example_3.Status>(
        name: 'Status',
        values: $d4_example_3.Status.values,
      ),
      BridgedEnumDefinition<$d4_example_3.Priority>(
        name: 'Priority',
        values: $d4_example_3.Priority.values,
        getters: {
          'value': (visitor, target) => (target as $d4_example_3.Priority).value,
        },
        methods: {
          'compareTo': (visitor, target, positional, named, typeArgs) {
            final t = target as $d4_example_3.Priority;
            return Function.apply(t.compareTo, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          '<': (visitor, target, positional, named, typeArgs) {
            final t = target as $d4_example_3.Priority;
            return (t as dynamic) < positional[0];
          },
          '>': (visitor, target, positional, named, typeArgs) {
            final t = target as $d4_example_3.Priority;
            return (t as dynamic) > positional[0];
          },
        },
      ),
      BridgedEnumDefinition<$d4_example_3.Color>(
        name: 'Color',
        values: $d4_example_3.Color.values,
        getters: {
          'r': (visitor, target) => (target as $d4_example_3.Color).r,
          'g': (visitor, target) => (target as $d4_example_3.Color).g,
          'b': (visitor, target) => (target as $d4_example_3.Color).b,
          'hex': (visitor, target) => (target as $d4_example_3.Color).hex,
          'brightness': (visitor, target) => (target as $d4_example_3.Color).brightness,
          'isDark': (visitor, target) => (target as $d4_example_3.Color).isDark,
          'isLight': (visitor, target) => (target as $d4_example_3.Color).isLight,
          'inverted': (visitor, target) => (target as $d4_example_3.Color).inverted,
        },
      ),
      BridgedEnumDefinition<$d4_example_3.HttpMethod>(
        name: 'HttpMethod',
        values: $d4_example_3.HttpMethod.values,
        getters: {
          'value': (visitor, target) => (target as $d4_example_3.HttpMethod).value,
          'isIdempotent': (visitor, target) => (target as $d4_example_3.HttpMethod).isIdempotent,
          'hasBody': (visitor, target) => (target as $d4_example_3.HttpMethod).hasBody,
        },
      ),
      BridgedEnumDefinition<$d4_example_3.DayOfWeek>(
        name: 'DayOfWeek',
        values: $d4_example_3.DayOfWeek.values,
        getters: {
          'number': (visitor, target) => (target as $d4_example_3.DayOfWeek).number,
          'shortName': (visitor, target) => (target as $d4_example_3.DayOfWeek).shortName,
          'isWeekend': (visitor, target) => (target as $d4_example_3.DayOfWeek).isWeekend,
          'isWeekday': (visitor, target) => (target as $d4_example_3.DayOfWeek).isWeekday,
          'next': (visitor, target) => (target as $d4_example_3.DayOfWeek).next,
          'previous': (visitor, target) => (target as $d4_example_3.DayOfWeek).previous,
        },
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'Status': 'package:d4_example/src/example_project/enum_classes.dart',
      'Priority': 'package:d4_example/src/example_project/enum_classes.dart',
      'Color': 'package:d4_example/src/example_project/enum_classes.dart',
      'HttpMethod': 'package:d4_example/src/example_project/enum_classes.dart',
      'DayOfWeek': 'package:d4_example/src/example_project/enum_classes.dart',
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

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
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
      interpreter.registerGlobalVariable('appVersion', $d4_example_5.appVersion, importPath, sourceUri: 'package:d4_example/src/example_project/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "appVersion": $e');
    }
    try {
      interpreter.registerGlobalVariable('appName', $d4_example_5.appName, importPath, sourceUri: 'package:d4_example/src/example_project/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "appName": $e');
    }
    try {
      interpreter.registerGlobalVariable('defaultTimeout', $d4_example_5.defaultTimeout, importPath, sourceUri: 'package:d4_example/src/example_project/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('pi', $d4_example_5.pi, importPath, sourceUri: 'package:d4_example/src/example_project/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "pi": $e');
    }
    try {
      interpreter.registerGlobalVariable('globalCounter', $d4_example_5.globalCounter, importPath, sourceUri: 'package:d4_example/src/example_project/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "globalCounter": $e');
    }
    try {
      interpreter.registerGlobalVariable('registeredNames', $d4_example_5.registeredNames, importPath, sourceUri: 'package:d4_example/src/example_project/global_members.dart');
    } catch (e) {
      errors.add('Failed to register variable "registeredNames": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (example_project):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'greet': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'greet');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
        return $d4_example_5.greet(name);
      },
      'add': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return $d4_example_5.add(a, b);
      },
      'multiply': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'multiply');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'multiply');
        final factor = D4.getOptionalArgWithDefault<double>(positional, 1, 'factor', 1.0);
        return $d4_example_5.multiply(value, factor);
      },
      'circleArea': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'circleArea');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'circleArea');
        return $d4_example_5.circleArea(radius);
      },
      'formatMessage': (visitor, positional, named, typeArgs) {
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'formatMessage');
        final prefix = D4.getNamedArgWithDefault<String>(named, 'prefix', '');
        final suffix = D4.getNamedArgWithDefault<String>(named, 'suffix', '');
        return $d4_example_5.formatMessage(message: message, prefix: prefix, suffix: suffix);
      },
      'identity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return $d4_example_5.identity<dynamic>(value);
      },
      'makePair': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'makePair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'makePair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'makePair');
        final $result = $d4_example_5.makePair<dynamic, dynamic>(first, second);
        return InterpretedRecord([$result.$1, $result.$2], {});
      },
      'firstOrNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'firstOrNull');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'firstOrNull');
        return $d4_example_5.firstOrNull<dynamic>(items);
      },
      'findWhere': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'findWhere');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'findWhere');
        if (positional.length <= 1) {
          throw ArgumentError('findWhere: Missing required argument "predicate" at position 1');
        }
        final predicateRaw = positional[1];
        final predicate = (dynamic p0) { return D4.callInterpreterCallback(visitor, predicateRaw, [p0]) as bool; };
        return $d4_example_5.findWhere<dynamic>(items, predicate);
      },
      'mapList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mapList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'mapList');
        if (positional.length <= 1) {
          throw ArgumentError('mapList: Missing required argument "mapper" at position 1');
        }
        final mapperRaw = positional[1];
        final mapper = (dynamic p0) { return D4.callInterpreterCallback(visitor, mapperRaw, [p0]) as dynamic; };
        return $d4_example_5.mapList<dynamic, dynamic>(items, mapper);
      },
      'filterList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'filterList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'filterList');
        if (positional.length <= 1) {
          throw ArgumentError('filterList: Missing required argument "predicate" at position 1');
        }
        final predicateRaw = positional[1];
        final predicate = (dynamic p0) { return D4.callInterpreterCallback(visitor, predicateRaw, [p0]) as bool; };
        return $d4_example_5.filterList<dynamic>(items, predicate);
      },
      'reduceList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'reduceList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'reduceList');
        if (positional.length <= 1) {
          throw ArgumentError('reduceList: Missing required argument "combiner" at position 1');
        }
        final combinerRaw = positional[1];
        final combiner = (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combinerRaw, [p0, p1]) as dynamic; };
        return $d4_example_5.reduceList<dynamic>(items, combiner);
      },
      'sortItems': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sortItems');
        final sample = positional[0] as List;
        if (sample.isEmpty) return <dynamic>[];
        final firstElem = sample.first;
        if (firstElem is num) {
          return $d4_example_5.sortItems<num>((positional[0] as List).cast<num>());
        }
        if (firstElem is String) {
          return $d4_example_5.sortItems<String>((positional[0] as List).cast<String>());
        }
        if (firstElem is DateTime) {
          return $d4_example_5.sortItems<DateTime>((positional[0] as List).cast<DateTime>());
        }
        if (firstElem is Duration) {
          return $d4_example_5.sortItems<Duration>((positional[0] as List).cast<Duration>());
        }
        if (firstElem is BigInt) {
          return $d4_example_5.sortItems<BigInt>((positional[0] as List).cast<BigInt>());
        }
        throw ArgumentError('sortItems: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'minValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'minValue');
        final sample = positional[0];
        if (sample is num) {
          return $d4_example_5.minValue<num>(positional[0] as num, positional[1] as num);
        }
        if (sample is String) {
          return $d4_example_5.minValue<String>(positional[0] as String, positional[1] as String);
        }
        if (sample is DateTime) {
          return $d4_example_5.minValue<DateTime>(positional[0] as DateTime, positional[1] as DateTime);
        }
        if (sample is Duration) {
          return $d4_example_5.minValue<Duration>(positional[0] as Duration, positional[1] as Duration);
        }
        if (sample is BigInt) {
          return $d4_example_5.minValue<BigInt>(positional[0] as BigInt, positional[1] as BigInt);
        }
        throw ArgumentError('minValue: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'maxValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'maxValue');
        final sample = positional[0];
        if (sample is num) {
          return $d4_example_5.maxValue<num>(positional[0] as num, positional[1] as num);
        }
        if (sample is String) {
          return $d4_example_5.maxValue<String>(positional[0] as String, positional[1] as String);
        }
        if (sample is DateTime) {
          return $d4_example_5.maxValue<DateTime>(positional[0] as DateTime, positional[1] as DateTime);
        }
        if (sample is Duration) {
          return $d4_example_5.maxValue<Duration>(positional[0] as Duration, positional[1] as Duration);
        }
        if (sample is BigInt) {
          return $d4_example_5.maxValue<BigInt>(positional[0] as BigInt, positional[1] as BigInt);
        }
        throw ArgumentError('maxValue: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'delayedGreeting': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'delayedGreeting');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'delayedGreeting');
        final delayMs = D4.getRequiredArg<int>(positional, 1, 'delayMs', 'delayedGreeting');
        return $d4_example_5.delayedGreeting(name, delayMs);
      },
      'fetchData': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fetchData');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'fetchData');
        return $d4_example_5.fetchData(id);
      },
      'processAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processAsync');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'processAsync');
        if (positional.length <= 1) {
          throw ArgumentError('processAsync: Missing required argument "processor" at position 1');
        }
        final processorRaw = positional[1];
        final processor = (dynamic p0) { return D4.callInterpreterCallback(visitor, processorRaw, [p0]) as Future<dynamic>; };
        return $d4_example_5.processAsync<dynamic, dynamic>(items, processor);
      },
      'incrementCounter': (visitor, positional, named, typeArgs) {
        return $d4_example_5.incrementCounter();
      },
      'resetCounter': (visitor, positional, named, typeArgs) {
        return $d4_example_5.resetCounter();
      },
      'registerName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'registerName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerName');
        return $d4_example_5.registerName(name);
      },
      'getRegisteredNames': (visitor, positional, named, typeArgs) {
        return $d4_example_5.getRegisteredNames();
      },
      'clearNames': (visitor, positional, named, typeArgs) {
        return $d4_example_5.clearNames();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'greet': 'package:d4_example/src/example_project/global_members.dart',
      'add': 'package:d4_example/src/example_project/global_members.dart',
      'multiply': 'package:d4_example/src/example_project/global_members.dart',
      'circleArea': 'package:d4_example/src/example_project/global_members.dart',
      'formatMessage': 'package:d4_example/src/example_project/global_members.dart',
      'identity': 'package:d4_example/src/example_project/global_members.dart',
      'makePair': 'package:d4_example/src/example_project/global_members.dart',
      'firstOrNull': 'package:d4_example/src/example_project/global_members.dart',
      'findWhere': 'package:d4_example/src/example_project/global_members.dart',
      'mapList': 'package:d4_example/src/example_project/global_members.dart',
      'filterList': 'package:d4_example/src/example_project/global_members.dart',
      'reduceList': 'package:d4_example/src/example_project/global_members.dart',
      'sortItems': 'package:d4_example/src/example_project/global_members.dart',
      'minValue': 'package:d4_example/src/example_project/global_members.dart',
      'maxValue': 'package:d4_example/src/example_project/global_members.dart',
      'delayedGreeting': 'package:d4_example/src/example_project/global_members.dart',
      'fetchData': 'package:d4_example/src/example_project/global_members.dart',
      'processAsync': 'package:d4_example/src/example_project/global_members.dart',
      'incrementCounter': 'package:d4_example/src/example_project/global_members.dart',
      'resetCounter': 'package:d4_example/src/example_project/global_members.dart',
      'registerName': 'package:d4_example/src/example_project/global_members.dart',
      'getRegisteredNames': 'package:d4_example/src/example_project/global_members.dart',
      'clearNames': 'package:d4_example/src/example_project/global_members.dart',
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
      'package:d4_example/src/example_project/basic_classes.dart',
      'package:d4_example/src/example_project/callback_classes.dart',
      'package:d4_example/src/example_project/enum_classes.dart',
      'package:d4_example/src/example_project/generic_classes.dart',
      'package:d4_example/src/example_project/global_members.dart',
      'package:d4_example/src/example_project/inheritance_classes.dart',
      'package:d4_example/src/example_project/operator_classes.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4_example/example_project.dart';";
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

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'Status',
    'Priority',
    'Color',
    'HttpMethod',
    'DayOfWeek',
  ];

}

// =============================================================================
// Person Bridge
// =============================================================================

BridgedClass _createPersonBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.Person,
    name: 'Person',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Person');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Person');
        final age = D4.getRequiredArg<int>(positional, 1, 'age', 'Person');
        return $d4_example_1.Person(name, age);
      },
      'guest': (visitor, positional, named) {
        return $d4_example_1.Person.guest();
      },
      'withAge': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Person');
        final age = D4.getRequiredArg<int>(positional, 0, 'age', 'Person');
        return $d4_example_1.Person.withAge(age);
      },
      'fromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Person');
        final data = D4.getRequiredArg<String>(positional, 0, 'data', 'Person');
        return $d4_example_1.Person.fromString(data);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_1.Person>(target, 'Person').name,
      'age': (visitor, target) => D4.validateTarget<$d4_example_1.Person>(target, 'Person').age,
    },
    setters: {
      'age': (visitor, target, value) => 
        D4.validateTarget<$d4_example_1.Person>(target, 'Person').age = value as int,
    },
    methods: {
      'greet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.Person>(target, 'Person');
        return t.greet();
      },
      'greetWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.Person>(target, 'Person');
        final prefix = D4.getNamedArgWithDefault<String>(named, 'prefix', 'Hi');
        return t.greetWith(prefix: prefix);
      },
    },
    staticGetters: {
      'instanceCount': (visitor) => $d4_example_1.Person.instanceCount,
    },
    staticMethods: {
      'createDefault': (visitor, positional, named, typeArgs) {
        return $d4_example_1.Person.createDefault();
      },
    },
    staticSetters: {
      'instanceCount': (visitor, value) => 
        $d4_example_1.Person.instanceCount = value as int,
    },
    constructorSignatures: {
      '': 'Person(String name, int age)',
      'guest': 'Person.guest()',
      'withAge': 'Person.withAge(int age)',
      'fromString': 'factory Person.fromString(String data)',
    },
    methodSignatures: {
      'greet': 'String greet()',
      'greetWith': 'String greetWith({String prefix = \'Hi\'})',
    },
    getterSignatures: {
      'name': 'String get name',
      'age': 'int get age',
    },
    setterSignatures: {
      'age': 'set age(dynamic value)',
    },
    staticMethodSignatures: {
      'createDefault': 'Person createDefault()',
    },
    staticGetterSignatures: {
      'instanceCount': 'int get instanceCount',
    },
    staticSetterSignatures: {
      'instanceCount': 'set instanceCount(dynamic value)',
    },
  );
}

// =============================================================================
// Calculator Bridge
// =============================================================================

BridgedClass _createCalculatorBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.Calculator,
    name: 'Calculator',
    constructors: {
      '': (visitor, positional, named) {
        final precision = D4.getOptionalArgWithDefault<int>(positional, 0, 'precision', 2);
        return $d4_example_1.Calculator(precision);
      },
    },
    getters: {
      'precision': (visitor, target) => D4.validateTarget<$d4_example_1.Calculator>(target, 'Calculator').precision,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 2, 'add');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'add');
        final b = D4.getRequiredArg<int>(positional, 1, 'b', 'add');
        return t.add(a, b);
      },
      'addOptional': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.Calculator>(target, 'Calculator');
        D4.requireMinArgs(positional, 1, 'addOptional');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'addOptional');
        final b = D4.getOptionalArgWithDefault<int>(positional, 1, 'b', 0);
        final c = D4.getOptionalArgWithDefault<int>(positional, 2, 'c', 0);
        return t.addOptional(a, b, c);
      },
      'calculate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_1.Calculator>(target, 'Calculator');
        final value = D4.getRequiredNamedArg<double>(named, 'value', 'calculate');
        final multiplier = D4.getNamedArgWithDefault<double>(named, 'multiplier', 1.0);
        return t.calculate(value: value, multiplier: multiplier);
      },
    },
    staticMethods: {
      'format': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'format');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'format');
        final decimals = D4.getOptionalNamedArg<int?>(named, 'decimals');
        return $d4_example_1.Calculator.format(value, decimals: decimals);
      },
    },
    constructorSignatures: {
      '': 'Calculator([int precision = 2])',
    },
    methodSignatures: {
      'add': 'int add(int a, int b)',
      'addOptional': 'int addOptional(int a, [int b = 0, int c = 0])',
      'calculate': 'double calculate({required double value, double multiplier = 1.0})',
    },
    getterSignatures: {
      'precision': 'int get precision',
    },
    staticMethodSignatures: {
      'format': 'String format(double value, {int? decimals})',
    },
  );
}

// =============================================================================
// MathUtils Bridge
// =============================================================================

BridgedClass _createMathUtilsBridge() {
  return BridgedClass(
    nativeType: $d4_example_1.MathUtils,
    name: 'MathUtils',
    constructors: {
    },
    staticGetters: {
      'pi': (visitor) => $d4_example_1.MathUtils.pi,
      'e': (visitor) => $d4_example_1.MathUtils.e,
    },
    staticMethods: {
      'circleArea': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'circleArea');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'circleArea');
        return $d4_example_1.MathUtils.circleArea(radius);
      },
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'square');
        return $d4_example_1.MathUtils.square(x);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'cube');
        return $d4_example_1.MathUtils.cube(x);
      },
    },
    staticMethodSignatures: {
      'circleArea': 'double circleArea(double radius)',
      'square': 'double square(double x)',
      'cube': 'double cube(double x)',
    },
    staticGetterSignatures: {
      'pi': 'double get pi',
      'e': 'double get e',
    },
  );
}

// =============================================================================
// Result Bridge
// =============================================================================

BridgedClass _createResultBridge() {
  return BridgedClass(
    nativeType: $d4_example_2.Result,
    name: 'Result',
    constructors: {
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Result');
        return $d4_example_2.Result.success(value);
      },
      'failure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final error = D4.getRequiredArg<String?>(positional, 0, 'error', 'Result');
        return $d4_example_2.Result.failure(error);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$d4_example_2.Result>(target, 'Result').value,
      'error': (visitor, target) => D4.validateTarget<$d4_example_2.Result>(target, 'Result').error,
      'isSuccess': (visitor, target) => D4.validateTarget<$d4_example_2.Result>(target, 'Result').isSuccess,
      'isFailure': (visitor, target) => D4.validateTarget<$d4_example_2.Result>(target, 'Result').isFailure,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.Result>(target, 'Result');
        return t.toString();
      },
    },
    constructorSignatures: {
      'success': 'Result.success(T? value)',
      'failure': 'Result.failure(String? error)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'value': 'T? get value',
      'error': 'String? get error',
      'isSuccess': 'bool get isSuccess',
      'isFailure': 'bool get isFailure',
    },
  );
}

// =============================================================================
// TaskScheduler Bridge
// =============================================================================

BridgedClass _createTaskSchedulerBridge() {
  return BridgedClass(
    nativeType: $d4_example_2.TaskScheduler,
    name: 'TaskScheduler',
    constructors: {
      '': (visitor, positional, named) {
        return $d4_example_2.TaskScheduler();
      },
    },
    methods: {
      'addTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 1, 'addTask');
        if (positional.isEmpty) {
          throw ArgumentError('addTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        t.addTask(() { D4.callInterpreterCallback(visitor, taskRaw, []); });
        return null;
      },
      'runAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.TaskScheduler>(target, 'TaskScheduler');
        t.runAll();
        return null;
      },
      'runWithHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 3, 'runWithHandler');
        if (positional.isEmpty) {
          throw ArgumentError('runWithHandler: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        if (positional.length <= 1) {
          throw ArgumentError('runWithHandler: Missing required argument "onSuccess" at position 1');
        }
        final onSuccessRaw = positional[1];
        if (positional.length <= 2) {
          throw ArgumentError('runWithHandler: Missing required argument "onError" at position 2');
        }
        final onErrorRaw = positional[2];
        t.runWithHandler(() { return D4.callInterpreterCallback(visitor, taskRaw, []) as dynamic; }, (dynamic p0) { D4.callInterpreterCallback(visitor, onSuccessRaw, [p0]); }, (Object p0) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0]); });
        return null;
      },
      'mapValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'mapValues');
        if (positional.isEmpty) {
          throw ArgumentError('mapValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('mapValues: Missing required argument "mapper" at position 1');
        }
        final mapperRaw = positional[1];
        return t.mapValues(values, (dynamic p0) { return D4.callInterpreterCallback(visitor, mapperRaw, [p0]) as dynamic; });
      },
      'filterValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'filterValues');
        if (positional.isEmpty) {
          throw ArgumentError('filterValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('filterValues: Missing required argument "predicate" at position 1');
        }
        final predicateRaw = positional[1];
        return t.filterValues(values, (dynamic p0) { return D4.callInterpreterCallback(visitor, predicateRaw, [p0]) as bool; });
      },
      'reduceValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'reduceValues');
        if (positional.isEmpty) {
          throw ArgumentError('reduceValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('reduceValues: Missing required argument "combiner" at position 1');
        }
        final combinerRaw = positional[1];
        return t.reduceValues(values, (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combinerRaw, [p0, p1]) as dynamic; });
      },
    },
    staticMethods: {
      'generate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'generate');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'generate');
        if (positional.length <= 1) {
          throw ArgumentError('generate: Missing required argument "generator" at position 1');
        }
        final generatorRaw = positional[1];
        final generator = (int p0) { return D4.callInterpreterCallback(visitor, generatorRaw, [p0]) as dynamic; };
        return $d4_example_2.TaskScheduler.generate(count, generator);
      },
    },
    constructorSignatures: {
      '': 'TaskScheduler()',
    },
    methodSignatures: {
      'addTask': 'void addTask(void Function() task)',
      'runAll': 'void runAll()',
      'runWithHandler': 'void runWithHandler(T Function() task, void Function(T) onSuccess, void Function(Object) onError)',
      'mapValues': 'List<R> mapValues(List<T> values, R Function(T) mapper)',
      'filterValues': 'List<T> filterValues(List<T> values, bool Function(T) predicate)',
      'reduceValues': 'T reduceValues(List<T> values, T Function(T, T) combiner)',
    },
    staticMethodSignatures: {
      'generate': 'List<T> generate(int count, T Function(int) generator)',
    },
  );
}

// =============================================================================
// AsyncService Bridge
// =============================================================================

BridgedClass _createAsyncServiceBridge() {
  return BridgedClass(
    nativeType: $d4_example_2.AsyncService,
    name: 'AsyncService',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AsyncService');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'AsyncService');
        final delayMs = D4.getOptionalArgWithDefault<int>(positional, 1, '_delayMs', 10);
        return $d4_example_2.AsyncService(name, delayMs);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_2.AsyncService>(target, 'AsyncService').name,
    },
    methods: {
      'fetchData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.AsyncService>(target, 'AsyncService');
        return t.fetchData();
      },
      'fetchById': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.AsyncService>(target, 'AsyncService');
        D4.requireMinArgs(positional, 1, 'fetchById');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'fetchById');
        return t.fetchById(id);
      },
      'fetchWithProgress': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.AsyncService>(target, 'AsyncService');
        D4.requireMinArgs(positional, 1, 'fetchWithProgress');
        if (positional.isEmpty) {
          throw ArgumentError('fetchWithProgress: Missing required argument "onProgress" at position 0');
        }
        final onProgressRaw = positional[0];
        return t.fetchWithProgress((int p0) { D4.callInterpreterCallback(visitor, onProgressRaw, [p0]); });
      },
      'tryFetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.AsyncService>(target, 'AsyncService');
        D4.requireMinArgs(positional, 1, 'tryFetch');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'tryFetch');
        return t.tryFetch(id);
      },
    },
    staticMethods: {
      'create': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'create');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'create');
        return $d4_example_2.AsyncService.create(name);
      },
    },
    constructorSignatures: {
      '': 'AsyncService(String name, [int _delayMs = 10])',
    },
    methodSignatures: {
      'fetchData': 'Future<String> fetchData()',
      'fetchById': 'Future<String> fetchById(String id)',
      'fetchWithProgress': 'Future<String> fetchWithProgress(void Function(int) onProgress)',
      'tryFetch': 'Future<Result<String>> tryFetch(String id)',
    },
    getterSignatures: {
      'name': 'String get name',
    },
    staticMethodSignatures: {
      'create': 'Future<AsyncService> create(String name)',
    },
  );
}

// =============================================================================
// EventEmitter Bridge
// =============================================================================

BridgedClass _createEventEmitterBridge() {
  return BridgedClass(
    nativeType: $d4_example_2.EventEmitter,
    name: 'EventEmitter',
    constructors: {
      '': (visitor, positional, named) {
        return $d4_example_2.EventEmitter();
      },
    },
    methods: {
      'on': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 2, 'on');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'on');
        if (positional.length <= 1) {
          throw ArgumentError('on: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.on(event, (String p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'emit');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'emit');
        t.emit(event);
        return null;
      },
      'off': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 2, 'off');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'off');
        if (positional.length <= 1) {
          throw ArgumentError('off: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.off(event, (String p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'once': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 2, 'once');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'once');
        if (positional.length <= 1) {
          throw ArgumentError('once: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.once(event, (String p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'listenerCount': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_2.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'listenerCount');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'listenerCount');
        return t.listenerCount(event);
      },
    },
    constructorSignatures: {
      '': 'EventEmitter()',
    },
    methodSignatures: {
      'on': 'void on(String event, EventCallback callback)',
      'emit': 'void emit(String event)',
      'off': 'void off(String event, EventCallback callback)',
      'once': 'void once(String event, EventCallback callback)',
      'listenerCount': 'int listenerCount(String event)',
    },
  );
}

// =============================================================================
// Identifiable Bridge
// =============================================================================

BridgedClass _createIdentifiableBridge() {
  return BridgedClass(
    nativeType: $d4_example_4.Identifiable,
    name: 'Identifiable',
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$d4_example_4.Identifiable>(target, 'Identifiable').id,
    },
    getterSignatures: {
      'id': 'String get id',
    },
  );
}

// =============================================================================
// Entity Bridge
// =============================================================================

BridgedClass _createEntityBridge() {
  return BridgedClass(
    nativeType: $d4_example_4.Entity,
    name: 'Entity',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Entity');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'Entity');
        final name = D4.getRequiredArg<String>(positional, 1, 'name', 'Entity');
        return $d4_example_4.Entity(id, name);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$d4_example_4.Entity>(target, 'Entity').id,
      'name': (visitor, target) => D4.validateTarget<$d4_example_4.Entity>(target, 'Entity').name,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Entity>(target, 'Entity');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Entity(String id, String name)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'String get id',
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Box Bridge
// =============================================================================

BridgedClass _createBoxBridge() {
  return BridgedClass(
    nativeType: $d4_example_4.Box,
    name: 'Box',
    constructors: {
      '': (visitor, positional, named) {
        final value = D4.getOptionalArg<dynamic>(positional, 0, 'value');
        return $d4_example_4.Box(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$d4_example_4.Box>(target, 'Box').value,
      'isEmpty': (visitor, target) => D4.validateTarget<$d4_example_4.Box>(target, 'Box').isEmpty,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<$d4_example_4.Box>(target, 'Box').value = value as dynamic,
    },
    methods: {
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Box>(target, 'Box');
        t.clear();
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Box>(target, 'Box');
        D4.requireMinArgs(positional, 1, 'transform');
        if (positional.isEmpty) {
          throw ArgumentError('transform: Missing required argument "transformer" at position 0');
        }
        final transformerRaw = positional[0];
        return t.transform((dynamic p0) { return D4.callInterpreterCallback(visitor, transformerRaw, [p0]) as dynamic; });
      },
    },
    staticMethods: {
      'filled': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'filled');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'filled');
        return $d4_example_4.Box.filled(value);
      },
      'identity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return $d4_example_4.Box.identity(value);
      },
    },
    constructorSignatures: {
      '': 'Box([T? value])',
    },
    methodSignatures: {
      'clear': 'void clear()',
      'transform': 'R transform(R Function(T) transformer)',
    },
    getterSignatures: {
      'value': 'T? get value',
      'isEmpty': 'bool get isEmpty',
    },
    setterSignatures: {
      'value': 'set value(dynamic value)',
    },
    staticMethodSignatures: {
      'filled': 'Box<E> filled(E value)',
      'identity': 'U identity(U value)',
    },
  );
}

// =============================================================================
// Repository Bridge
// =============================================================================

BridgedClass _createRepositoryBridge() {
  return BridgedClass(
    nativeType: $d4_example_4.Repository,
    name: 'Repository',
    constructors: {
      '': (visitor, positional, named) {
        return $d4_example_4.Repository();
      },
    },
    getters: {
      'count': (visitor, target) => D4.validateTarget<$d4_example_4.Repository>(target, 'Repository').count,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'add');
        final item = D4.getRequiredArg<$d4_example_4.Identifiable>(positional, 0, 'item', 'add');
        t.add(item);
        return null;
      },
      'getById': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'getById');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'getById');
        return t.getById(id);
      },
      'getAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Repository>(target, 'Repository');
        return t.getAll();
      },
      'findWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'findWhere');
        if (positional.isEmpty) {
          throw ArgumentError('findWhere: Missing required argument "predicate" at position 0');
        }
        final predicateRaw = positional[0];
        return t.findWhere(($d4_example_4.Identifiable p0) { return D4.callInterpreterCallback(visitor, predicateRaw, [p0]) as bool; });
      },
      'mapAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'mapAll');
        if (positional.isEmpty) {
          throw ArgumentError('mapAll: Missing required argument "mapper" at position 0');
        }
        final mapperRaw = positional[0];
        return t.mapAll(($d4_example_4.Identifiable p0) { return D4.callInterpreterCallback(visitor, mapperRaw, [p0]) as dynamic; });
      },
    },
    staticMethods: {
      'fromList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromList');
        if (positional.isEmpty) {
          throw ArgumentError('fromList: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<$d4_example_4.Identifiable>(positional[0], 'items');
        return $d4_example_4.Repository.fromList(items);
      },
    },
    constructorSignatures: {
      '': 'Repository()',
    },
    methodSignatures: {
      'add': 'void add(T item)',
      'getById': 'T? getById(String id)',
      'getAll': 'List<T> getAll()',
      'findWhere': 'T? findWhere(bool Function(T) predicate)',
      'mapAll': 'List<R> mapAll(R Function(T) mapper)',
    },
    getterSignatures: {
      'count': 'int get count',
    },
    staticMethodSignatures: {
      'fromList': 'Repository<E> fromList(List<E> items)',
    },
  );
}

// =============================================================================
// Pair Bridge
// =============================================================================

BridgedClass _createPairBridge() {
  return BridgedClass(
    nativeType: $d4_example_4.Pair,
    name: 'Pair',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Pair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'Pair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'Pair');
        return $d4_example_4.Pair(first, second);
      },
    },
    getters: {
      'first': (visitor, target) => D4.validateTarget<$d4_example_4.Pair>(target, 'Pair').first,
      'second': (visitor, target) => D4.validateTarget<$d4_example_4.Pair>(target, 'Pair').second,
    },
    methods: {
      'swap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Pair>(target, 'Pair');
        return t.swap();
      },
      'mapBoth': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 2, 'mapBoth');
        if (positional.isEmpty) {
          throw ArgumentError('mapBoth: Missing required argument "mapFirst" at position 0');
        }
        final mapFirstRaw = positional[0];
        if (positional.length <= 1) {
          throw ArgumentError('mapBoth: Missing required argument "mapSecond" at position 1');
        }
        final mapSecondRaw = positional[1];
        return t.mapBoth((dynamic p0) { return D4.callInterpreterCallback(visitor, mapFirstRaw, [p0]) as dynamic; }, (dynamic p0) { return D4.callInterpreterCallback(visitor, mapSecondRaw, [p0]) as dynamic; });
      },
      'withFirst': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 1, 'withFirst');
        final newFirst = D4.getRequiredArg<dynamic>(positional, 0, 'newFirst', 'withFirst');
        return t.withFirst(newFirst);
      },
      'withSecond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 1, 'withSecond');
        final newSecond = D4.getRequiredArg<dynamic>(positional, 0, 'newSecond', 'withSecond');
        return t.withSecond(newSecond);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Pair>(target, 'Pair');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Pair(K first, V second)',
    },
    methodSignatures: {
      'swap': 'Pair<V, K> swap()',
      'mapBoth': 'Pair<K2, V2> mapBoth(K2 Function(K) mapFirst, V2 Function(V) mapSecond)',
      'withFirst': 'Pair<K3, V> withFirst(K3 newFirst)',
      'withSecond': 'Pair<K, V3> withSecond(V3 newSecond)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'first': 'K get first',
      'second': 'V get second',
    },
  );
}

// =============================================================================
// Transformer Bridge
// =============================================================================

BridgedClass _createTransformerBridge() {
  return BridgedClass(
    nativeType: $d4_example_4.Transformer,
    name: 'Transformer',
    constructors: {
      '': (visitor, positional, named) {
        return $d4_example_4.Transformer();
      },
    },
    methods: {
      'identity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return t.identity(value);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'cast');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'cast');
        return t.cast(value);
      },
      'singleton': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'singleton');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'singleton');
        return t.singleton(value);
      },
      'pair': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 2, 'pair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'pair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'pair');
        return t.pair(first, second);
      },
      'idOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'idOf');
        final item = D4.getRequiredArg<$d4_example_4.Identifiable>(positional, 0, 'item', 'idOf');
        return t.idOf(item);
      },
    },
    staticMethods: {
      'repeat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'repeat');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'repeat');
        final count = D4.getRequiredArg<int>(positional, 1, 'count', 'repeat');
        return $d4_example_4.Transformer.repeat(value, count);
      },
    },
    constructorSignatures: {
      '': 'Transformer()',
    },
    methodSignatures: {
      'identity': 'T identity(T value)',
      'cast': 'R cast(T value)',
      'singleton': 'List<T> singleton(T value)',
      'pair': 'Pair<A, B> pair(A first, B second)',
      'idOf': 'String idOf(T item)',
    },
    staticMethodSignatures: {
      'repeat': 'List<E> repeat(E value, int count)',
    },
  );
}

// =============================================================================
// Shape Bridge
// =============================================================================

BridgedClass _createShapeBridge() {
  return BridgedClass(
    nativeType: $d4_example_6.Shape,
    name: 'Shape',
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_6.Shape>(target, 'Shape').name,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Shape>(target, 'Shape');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Shape>(target, 'Shape');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Shape>(target, 'Shape');
        return t.describe();
      },
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// Circle Bridge
// =============================================================================

BridgedClass _createCircleBridge() {
  return BridgedClass(
    nativeType: $d4_example_6.Circle,
    name: 'Circle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Circle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Circle');
        return $d4_example_6.Circle(radius);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_6.Circle>(target, 'Circle').name,
      'radius': (visitor, target) => D4.validateTarget<$d4_example_6.Circle>(target, 'Circle').radius,
      'diameter': (visitor, target) => D4.validateTarget<$d4_example_6.Circle>(target, 'Circle').diameter,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Circle>(target, 'Circle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Circle>(target, 'Circle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Circle>(target, 'Circle');
        return t.describe();
      },
    },
    constructorSignatures: {
      '': 'Circle(double radius)',
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'name': 'String get name',
      'radius': 'double get radius',
      'diameter': 'double get diameter',
    },
  );
}

// =============================================================================
// Rectangle Bridge
// =============================================================================

BridgedClass _createRectangleBridge() {
  return BridgedClass(
    nativeType: $d4_example_6.Rectangle,
    name: 'Rectangle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Rectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Rectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'Rectangle');
        return $d4_example_6.Rectangle(width, height);
      },
      'square': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Rectangle');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'Rectangle');
        return $d4_example_6.Rectangle.square(side);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_6.Rectangle>(target, 'Rectangle').name,
      'width': (visitor, target) => D4.validateTarget<$d4_example_6.Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) => D4.validateTarget<$d4_example_6.Rectangle>(target, 'Rectangle').height,
      'isSquare': (visitor, target) => D4.validateTarget<$d4_example_6.Rectangle>(target, 'Rectangle').isSquare,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Rectangle>(target, 'Rectangle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Rectangle>(target, 'Rectangle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Rectangle>(target, 'Rectangle');
        return t.describe();
      },
    },
    constructorSignatures: {
      '': 'Rectangle(double width, double height)',
      'square': 'Rectangle.square(double side)',
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'name': 'String get name',
      'width': 'double get width',
      'height': 'double get height',
      'isSquare': 'bool get isSquare',
    },
  );
}

// =============================================================================
// Serializable Bridge
// =============================================================================

BridgedClass _createSerializableBridge() {
  return BridgedClass(
    nativeType: $d4_example_6.Serializable,
    name: 'Serializable',
    constructors: {
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Serializable>(target, 'Serializable');
        return t.toJson();
      },
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
  );
}

// =============================================================================
// Cloneable Bridge
// =============================================================================

BridgedClass _createCloneableBridge() {
  return BridgedClass(
    nativeType: $d4_example_6.Cloneable,
    name: 'Cloneable',
    constructors: {
    },
    methods: {
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Cloneable>(target, 'Cloneable');
        return t.clone();
      },
    },
    methodSignatures: {
      'clone': 'T clone()',
    },
  );
}

// =============================================================================
// Point Bridge
// =============================================================================

BridgedClass _createPointBridge() {
  return BridgedClass(
    nativeType: $d4_example_6.Point,
    name: 'Point',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Point');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Point');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Point');
        return $d4_example_6.Point(x, y);
      },
      'origin': (visitor, positional, named) {
        return $d4_example_6.Point.origin();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$d4_example_6.Point>(target, 'Point').x,
      'y': (visitor, target) => D4.validateTarget<$d4_example_6.Point>(target, 'Point').y,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Point>(target, 'Point');
        return t.toJson();
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Point>(target, 'Point');
        return t.clone();
      },
      'distanceTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Point>(target, 'Point');
        D4.requireMinArgs(positional, 1, 'distanceTo');
        final other = D4.getRequiredArg<$d4_example_6.Point>(positional, 0, 'other', 'distanceTo');
        return t.distanceTo(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Point>(target, 'Point');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$d4_example_6.Point>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.Point>(target, 'Point');
        return t.toString();
      },
    },
    staticMethods: {
      'fromJson': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromJson');
        if (positional.isEmpty) {
          throw ArgumentError('fromJson: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $d4_example_6.Point.fromJson(json);
      },
    },
    constructorSignatures: {
      '': 'Point(double x, double y)',
      'origin': 'Point.origin()',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'clone': 'Point clone()',
      'distanceTo': 'double distanceTo(Point other)',
      'add': 'Point add(Point other)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
    },
    staticMethodSignatures: {
      'fromJson': 'Point fromJson(Map<String, dynamic> json)',
    },
  );
}

// =============================================================================
// ColoredRectangle Bridge
// =============================================================================

BridgedClass _createColoredRectangleBridge() {
  return BridgedClass(
    nativeType: $d4_example_6.ColoredRectangle,
    name: 'ColoredRectangle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ColoredRectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'ColoredRectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'ColoredRectangle');
        final color = D4.getRequiredArg<String>(positional, 2, 'color', 'ColoredRectangle');
        return $d4_example_6.ColoredRectangle(width, height, color);
      },
      'red': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColoredRectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'ColoredRectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'ColoredRectangle');
        return $d4_example_6.ColoredRectangle.red(width, height);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle').name,
      'width': (visitor, target) => D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle').width,
      'height': (visitor, target) => D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle').height,
      'isSquare': (visitor, target) => D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle').isSquare,
      'color': (visitor, target) => D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle').color,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle');
        return t.describe();
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_6.ColoredRectangle>(target, 'ColoredRectangle');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ColoredRectangle(double width, double height, String color)',
      'red': 'ColoredRectangle.red(double width, double height)',
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String get name',
      'width': 'double get width',
      'height': 'double get height',
      'isSquare': 'bool get isSquare',
      'color': 'String get color',
    },
  );
}

// =============================================================================
// Vector2D Bridge
// =============================================================================

BridgedClass _createVector2DBridge() {
  return BridgedClass(
    nativeType: $d4_example_7.Vector2D,
    name: 'Vector2D',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2D');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2D');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2D');
        return $d4_example_7.Vector2D(x, y);
      },
      'zero': (visitor, positional, named) {
        return $d4_example_7.Vector2D.zero();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D').x,
      'y': (visitor, target) => D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D').y,
      'magnitude': (visitor, target) => D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D').magnitude,
      'hashCode': (visitor, target) => D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D').hashCode,
    },
    methods: {
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        return t.normalize();
      },
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$d4_example_7.Vector2D>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<$d4_example_7.Vector2D>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$d4_example_7.Vector2D>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const Vector2D(double x, double y)',
      'zero': 'const Vector2D.zero()',
    },
    methodSignatures: {
      'normalize': 'Vector2D normalize()',
      'dot': 'double dot(Vector2D other)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
      'magnitude': 'double get magnitude',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Matrix Bridge
// =============================================================================

BridgedClass _createMatrixBridge() {
  return BridgedClass(
    nativeType: $d4_example_7.Matrix,
    name: 'Matrix',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix');
        final rows = D4.getRequiredArg<int>(positional, 0, 'rows', 'Matrix');
        final cols = D4.getRequiredArg<int>(positional, 1, 'cols', 'Matrix');
        return $d4_example_7.Matrix(rows, cols);
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix');
        if (positional.isEmpty) {
          throw ArgumentError('Matrix: Missing required argument "data" at position 0');
        }
        final data = D4.coerceList<List<double>>(positional[0], 'data');
        return $d4_example_7.Matrix.fromList(data);
      },
      'identity': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix');
        final size = D4.getRequiredArg<int>(positional, 0, 'size', 'Matrix');
        return $d4_example_7.Matrix.identity(size);
      },
    },
    getters: {
      'rows': (visitor, target) => D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix').rows,
      'cols': (visitor, target) => D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix').cols,
    },
    methods: {
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix');
        D4.requireMinArgs(positional, 2, 'get');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'get');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'get');
        return t.get(row, col);
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix');
        D4.requireMinArgs(positional, 3, 'set');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'set');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'set');
        final value = D4.getRequiredArg<double>(positional, 2, 'value', 'set');
        t.set(row, col, value);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix');
        return t.toString();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix');
        final other = D4.getRequiredArg<$d4_example_7.Matrix>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Matrix>(target, 'Matrix');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
    },
    constructorSignatures: {
      '': 'Matrix(int rows, int cols)',
      'fromList': 'Matrix.fromList(List<List<double>> data)',
      'identity': 'factory Matrix.identity(int size)',
    },
    methodSignatures: {
      'get': 'double get(int row, int col)',
      'set': 'void set(int row, int col, double value)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'rows': 'int get rows',
      'cols': 'int get cols',
    },
  );
}

// =============================================================================
// Dictionary Bridge
// =============================================================================

BridgedClass _createDictionaryBridge() {
  return BridgedClass(
    nativeType: $d4_example_7.Dictionary,
    name: 'Dictionary',
    constructors: {
      '': (visitor, positional, named) {
        return $d4_example_7.Dictionary();
      },
    },
    getters: {
      'keys': (visitor, target) => D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary').keys,
      'values': (visitor, target) => D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary').values,
      'length': (visitor, target) => D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary').length,
    },
    methods: {
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary');
        D4.requireMinArgs(positional, 1, 'remove');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'remove');
        return t.remove(key);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary');
        return t.toString();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_7.Dictionary>(target, 'Dictionary');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    constructorSignatures: {
      '': 'Dictionary()',
    },
    methodSignatures: {
      'containsKey': 'bool containsKey(K key)',
      'remove': 'V? remove(K key)',
      'clear': 'void clear()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'keys': 'Iterable<K> get keys',
      'values': 'Iterable<V> get values',
      'length': 'int get length',
    },
  );
}

