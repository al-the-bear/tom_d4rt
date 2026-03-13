// D4rt Bridge - Generated file, do not edit
// Sources: 7 files
// Generated: 2026-03-12T17:02:30.914614

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';
import 'dart:async';

import 'package:d4_example/src/example_project/basic_classes.dart' as $d4_example_1;
import 'package:d4_example/src/example_project/callback_classes.dart' as $d4_example_2;
import 'package:d4_example/src/example_project/generic_classes.dart' as $d4_example_3;
import 'package:d4_example/src/example_project/inheritance_classes.dart' as $d4_example_4;
import 'package:d4_example/src/example_project/operator_classes.dart' as $d4_example_5;

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
      'Person': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'Calculator': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'MathUtils': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'Result': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'TaskScheduler': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'AsyncService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'EventEmitter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'Identifiable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Entity': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Box': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Repository': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Pair': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Transformer': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Shape': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Circle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Rectangle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Serializable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Cloneable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Point': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'ColoredRectangle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Vector2D': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\operator_classes.dart',
      'Matrix': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\operator_classes.dart',
      'Dictionary': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\operator_classes.dart',
    };
  }

        final predicate = (dynamic p0) { return D4.callInterpreterCallback(visitor!, predicateRaw, [p0]) as bool; };
        return findWhere<dynamic>(items, predicate);
      },
      'mapList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mapList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'mapList');
        if (positional.length <= 1) {
          throw ArgumentError('mapList: Missing required argument "mapper" at position 1');
        }
        final mapperRaw = positional[1];
        final mapper = (dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, mapperRaw, [p0])); };
        return mapList<dynamic, dynamic>(items, mapper);
      },
      'filterList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'filterList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'filterList');
        if (positional.length <= 1) {
          throw ArgumentError('filterList: Missing required argument "predicate" at position 1');
        }
        final predicateRaw = positional[1];
        final predicate = (dynamic p0) { return D4.callInterpreterCallback(visitor!, predicateRaw, [p0]) as bool; };
        return filterList<dynamic>(items, predicate);
      },
      'reduceList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'reduceList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'reduceList');
        if (positional.length <= 1) {
          throw ArgumentError('reduceList: Missing required argument "combiner" at position 1');
        }
        final combinerRaw = positional[1];
        final combiner = (dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combinerRaw, [p0, p1])); };
        return reduceList<dynamic>(items, combiner);
      },
      'sortItems': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sortItems');
        final sample = positional[0] as List;
        if (sample.isEmpty) return <dynamic>[];
        final firstElem = sample.first;
        if (firstElem is num) {
          return sortItems<num>((positional[0] as List).cast<num>());
        }
        if (firstElem is String) {
          return sortItems<String>((positional[0] as List).cast<String>());
        }
        if (firstElem is DateTime) {
          return sortItems<DateTime>((positional[0] as List).cast<DateTime>());
        }
        if (firstElem is Duration) {
          return sortItems<Duration>((positional[0] as List).cast<Duration>());
        }
        if (firstElem is BigInt) {
          return sortItems<BigInt>((positional[0] as List).cast<BigInt>());
        }
        throw ArgumentError('sortItems: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'minValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'minValue');
        final sample = positional[0];
        if (sample is num) {
          return minValue<num>(positional[0] as num, positional[1] as num);
        }
        if (sample is String) {
          return minValue<String>(positional[0] as String, positional[1] as String);
        }
        if (sample is DateTime) {
          return minValue<DateTime>(positional[0] as DateTime, positional[1] as DateTime);
        }
        if (sample is Duration) {
          return minValue<Duration>(positional[0] as Duration, positional[1] as Duration);
        }
        if (sample is BigInt) {
          return minValue<BigInt>(positional[0] as BigInt, positional[1] as BigInt);
        }
        throw ArgumentError('minValue: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'maxValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'maxValue');
        final sample = positional[0];
        if (sample is num) {
          return maxValue<num>(positional[0] as num, positional[1] as num);
        }
        if (sample is String) {
          return maxValue<String>(positional[0] as String, positional[1] as String);
        }
        if (sample is DateTime) {
          return maxValue<DateTime>(positional[0] as DateTime, positional[1] as DateTime);
        }
        if (sample is Duration) {
          return maxValue<Duration>(positional[0] as Duration, positional[1] as Duration);
        }
        if (sample is BigInt) {
          return maxValue<BigInt>(positional[0] as BigInt, positional[1] as BigInt);
        }
        throw ArgumentError('maxValue: Unsupported type for recursive bound. Supported types: num, String, DateTime, Duration, BigInt. Got: ${sample.runtimeType}');
      },
      'delayedGreeting': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'delayedGreeting');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'delayedGreeting');
        final delayMs = D4.getRequiredArg<int>(positional, 1, 'delayMs', 'delayedGreeting');
        return delayedGreeting(name, delayMs);
      },
      'fetchData': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fetchData');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'fetchData');
        return fetchData(id);
      },
      'processAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'processAsync');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'processAsync');
        if (positional.length <= 1) {
          throw ArgumentError('processAsync: Missing required argument "processor" at position 1');
        }
        final processorRaw = positional[1];
        final processor = (dynamic p0) { return D4.callInterpreterCallback(visitor!, processorRaw, [p0]) as Future<dynamic>; };
        return processAsync<dynamic, dynamic>(items, processor);
      },
      'incrementCounter': (visitor, positional, named, typeArgs) {
        return incrementCounter();
      },
      'resetCounter': (visitor, positional, named, typeArgs) {
        return resetCounter();
      },
      'registerName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'registerName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerName');
        return registerName(name);
      },
      'getRegisteredNames': (visitor, positional, named, typeArgs) {
        return getRegisteredNames();
      },
      'clearNames': (visitor, positional, named, typeArgs) {
        return clearNames();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'greet': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'add': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'multiply': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'circleArea': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'formatMessage': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'identity': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'makePair': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'firstOrNull': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'findWhere': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'mapList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'filterList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'reduceList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'sortItems': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'minValue': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'maxValue': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'delayedGreeting': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'fetchData': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'processAsync': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'incrementCounter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'resetCounter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'registerName': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'getRegisteredNames': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'clearNames': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
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
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\enum_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\global_members.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_ast_generator\example\d4\lib\src\example_project\operator_classes.dart',
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
    nativeType: Calculator,
    name: 'Calculator',
    isAssignable: (v) => v is MathUtils,
    constructors: {
    },
    staticGetters: {
      'pi': (visitor) => MathUtils.pi,
      'e': (visitor) => MathUtils.e,
    },
    staticMethods: {
      'circleArea': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'circleArea');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'circleArea');
        return MathUtils.circleArea(radius);
      },
      'square': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'square');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'square');
        return MathUtils.square(x);
      },
      'cube': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cube');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'cube');
        return MathUtils.cube(x);
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
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $d4_example_2.Result<double>.success(value);
          case int _: return $d4_example_2.Result<int>.success(value);
          case String _: return $d4_example_2.Result<String>.success(value);
          case bool _: return $d4_example_2.Result<bool>.success(value);
          case $d4_example_1.Person _: return $d4_example_2.Result<$d4_example_1.Person>.success(value);
          case Calculator _: return $d4_example_2.Result<Calculator>.success(value);
          case MathUtils _: return $d4_example_2.Result<MathUtils>.success(value);
          case TaskScheduler _: return $d4_example_2.Result<TaskScheduler>.success(value);
          case $d4_example_2.AsyncService _: return $d4_example_2.Result<$d4_example_2.AsyncService>.success(value);
          case EventEmitter _: return $d4_example_2.Result<EventEmitter>.success(value);
          case $d4_example_3.Identifiable _: return $d4_example_2.Result<$d4_example_3.Identifiable>.success(value);
          case Entity _: return $d4_example_2.Result<Entity>.success(value);
          case $d4_example_3.Box _: return $d4_example_2.Result<$d4_example_3.Box>.success(value);
          case $d4_example_3.Repository _: return $d4_example_2.Result<$d4_example_3.Repository>.success(value);
          case $d4_example_3.Pair _: return $d4_example_2.Result<$d4_example_3.Pair>.success(value);
          case Transformer _: return $d4_example_2.Result<Transformer>.success(value);
          case Shape _: return $d4_example_2.Result<Shape>.success(value);
          case Circle _: return $d4_example_2.Result<Circle>.success(value);
          case Rectangle _: return $d4_example_2.Result<Rectangle>.success(value);
          case Serializable _: return $d4_example_2.Result<Serializable>.success(value);
          case Cloneable _: return $d4_example_2.Result<Cloneable>.success(value);
          case $d4_example_4.Point _: return $d4_example_2.Result<$d4_example_4.Point>.success(value);
          case ColoredRectangle _: return $d4_example_2.Result<ColoredRectangle>.success(value);
          case $d4_example_5.Vector2D _: return $d4_example_2.Result<$d4_example_5.Vector2D>.success(value);
          case $d4_example_5.Matrix _: return $d4_example_2.Result<$d4_example_5.Matrix>.success(value);
          case Dictionary _: return $d4_example_2.Result<Dictionary>.success(value);
          default: return $d4_example_2.Result.success(value);
        }
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
    nativeType: TaskScheduler,
    name: 'TaskScheduler',
        t.runWithHandler(() { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, taskRaw, [])); }, (dynamic p0) { D4.callInterpreterCallback(visitor!, onSuccessRaw, [p0]); }, (Object p0) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0]); });
        return null;
      },
      'mapValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'mapValues');
        if (positional.isEmpty) {
          throw ArgumentError('mapValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('mapValues: Missing required argument "mapper" at position 1');
        }
        final mapperRaw = positional[1];
        return t.mapValues(values, (dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, mapperRaw, [p0])); });
      },
      'filterValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TaskScheduler>(target, 'TaskScheduler');
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
        final t = D4.validateTarget<TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'reduceValues');
        if (positional.isEmpty) {
          throw ArgumentError('reduceValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('reduceValues: Missing required argument "combiner" at position 1');
        }
        final combinerRaw = positional[1];
        return t.reduceValues(values, (dynamic p0, dynamic p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combinerRaw, [p0, p1])); });
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
        final generator = (int p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, generatorRaw, [p0])); };
        return TaskScheduler.generate(count, generator);
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
    nativeType: EventEmitter,
    name: 'EventEmitter',
    isAssignable: (v) => v is $d4_example_3.Identifiable,
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$d4_example_3.Identifiable>(target, 'Identifiable').id,
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
    nativeType: Entity,
    name: 'Entity',
    isAssignable: (v) => v is $d4_example_3.Box,
    constructors: {
      '': (visitor, positional, named) {
        final value = D4.getOptionalArg<dynamic>(positional, 0, 'value');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $d4_example_3.Box<double>(value);
          case int _: return $d4_example_3.Box<int>(value);
          case String _: return $d4_example_3.Box<String>(value);
          case bool _: return $d4_example_3.Box<bool>(value);
          case $d4_example_1.Person _: return $d4_example_3.Box<$d4_example_1.Person>(value);
          case Calculator _: return $d4_example_3.Box<Calculator>(value);
          case MathUtils _: return $d4_example_3.Box<MathUtils>(value);
          case $d4_example_2.Result _: return $d4_example_3.Box<$d4_example_2.Result>(value);
          case TaskScheduler _: return $d4_example_3.Box<TaskScheduler>(value);
          case $d4_example_2.AsyncService _: return $d4_example_3.Box<$d4_example_2.AsyncService>(value);
          case EventEmitter _: return $d4_example_3.Box<EventEmitter>(value);
          case $d4_example_3.Identifiable _: return $d4_example_3.Box<$d4_example_3.Identifiable>(value);
          case Entity _: return $d4_example_3.Box<Entity>(value);
          case $d4_example_3.Repository _: return $d4_example_3.Box<$d4_example_3.Repository>(value);
          case $d4_example_3.Pair _: return $d4_example_3.Box<$d4_example_3.Pair>(value);
          case Transformer _: return $d4_example_3.Box<Transformer>(value);
          case Shape _: return $d4_example_3.Box<Shape>(value);
          case Circle _: return $d4_example_3.Box<Circle>(value);
          case Rectangle _: return $d4_example_3.Box<Rectangle>(value);
          case Serializable _: return $d4_example_3.Box<Serializable>(value);
          case Cloneable _: return $d4_example_3.Box<Cloneable>(value);
          case $d4_example_4.Point _: return $d4_example_3.Box<$d4_example_4.Point>(value);
          case ColoredRectangle _: return $d4_example_3.Box<ColoredRectangle>(value);
          case $d4_example_5.Vector2D _: return $d4_example_3.Box<$d4_example_5.Vector2D>(value);
          case $d4_example_5.Matrix _: return $d4_example_3.Box<$d4_example_5.Matrix>(value);
          case Dictionary _: return $d4_example_3.Box<Dictionary>(value);
          default: return $d4_example_3.Box(value);
        }
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$d4_example_3.Box>(target, 'Box').value,
      'isEmpty': (visitor, target) => D4.validateTarget<$d4_example_3.Box>(target, 'Box').isEmpty,
    },
    setters: {
      'value': (visitor, target, value) => 
        D4.validateTarget<$d4_example_3.Box>(target, 'Box').value = D4.extractBridgedArgOrNull<dynamic>(value, 'value'),
    },
    methods: {
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_3.Box>(target, 'Box');
        t.clear();
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_3.Box>(target, 'Box');
        D4.requireMinArgs(positional, 1, 'transform');
        if (positional.isEmpty) {
          throw ArgumentError('transform: Missing required argument "transformer" at position 0');
        }
        final transformerRaw = positional[0];
        return t.transform((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, transformerRaw, [p0])); });
      },
    },
    staticMethods: {
      'filled': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'filled');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'filled');
        return $d4_example_3.Box.filled(value);
      },
      'identity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return $d4_example_3.Box.identity(value);
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
    nativeType: $d4_example_3.Repository,
    name: 'Repository',
        return t.findWhere(($d4_example_3.Identifiable p0) { return D4.callInterpreterCallback(visitor!, predicateRaw, [p0]) as bool; });
      },
      'mapAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_3.Repository>(target, 'Repository');
        D4.requireMinArgs(positional, 1, 'mapAll');
        if (positional.isEmpty) {
          throw ArgumentError('mapAll: Missing required argument "mapper" at position 0');
        }
        final mapperRaw = positional[0];
        return t.mapAll(($d4_example_3.Identifiable p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, mapperRaw, [p0])); });
      },
    },
    staticMethods: {
      'fromList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromList');
        if (positional.isEmpty) {
          throw ArgumentError('fromList: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<$d4_example_3.Identifiable>(positional[0], 'items');
        return $d4_example_3.Repository.fromList(items);
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
    nativeType: $d4_example_3.Pair,
    name: 'Pair',
        return t.mapBoth((dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, mapFirstRaw, [p0])); }, (dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, mapSecondRaw, [p0])); });
      },
      'withFirst': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_3.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 1, 'withFirst');
        final newFirst = D4.getRequiredArg<dynamic>(positional, 0, 'newFirst', 'withFirst');
        return t.withFirst(newFirst);
      },
      'withSecond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_3.Pair>(target, 'Pair');
        D4.requireMinArgs(positional, 1, 'withSecond');
        final newSecond = D4.getRequiredArg<dynamic>(positional, 0, 'newSecond', 'withSecond');
        return t.withSecond(newSecond);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_3.Pair>(target, 'Pair');
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
    nativeType: Transformer,
    name: 'Transformer',
    isAssignable: (v) => v is Shape,
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Shape>(target, 'Shape').name,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Shape>(target, 'Shape');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Shape>(target, 'Shape');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Shape>(target, 'Shape');
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
    nativeType: Circle,
    name: 'Circle',
    isAssignable: (v) => v is Rectangle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Rectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Rectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'Rectangle');
        return Rectangle(width, height);
      },
      'square': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Rectangle');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'Rectangle');
        return Rectangle.square(side);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').name,
      'width': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').height,
      'isSquare': (visitor, target) => D4.validateTarget<Rectangle>(target, 'Rectangle').isSquare,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Rectangle>(target, 'Rectangle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Rectangle>(target, 'Rectangle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Rectangle>(target, 'Rectangle');
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
    nativeType: Serializable,
    name: 'Serializable',
    isAssignable: (v) => v is Cloneable,
    constructors: {
    },
    methods: {
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Cloneable>(target, 'Cloneable');
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
    nativeType: $d4_example_4.Point,
    name: 'Point',
    isAssignable: (v) => v is ColoredRectangle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ColoredRectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'ColoredRectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'ColoredRectangle');
        final color = D4.getRequiredArg<String>(positional, 2, 'color', 'ColoredRectangle');
        return ColoredRectangle(width, height, color);
      },
      'red': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColoredRectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'ColoredRectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'ColoredRectangle');
        return ColoredRectangle.red(width, height);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle').name,
      'width': (visitor, target) => D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle').width,
      'height': (visitor, target) => D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle').height,
      'isSquare': (visitor, target) => D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle').isSquare,
      'color': (visitor, target) => D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle').color,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle');
        return t.describe();
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColoredRectangle>(target, 'ColoredRectangle');
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
    nativeType: $d4_example_5.Vector2D,
    name: 'Vector2D',
    isAssignable: (v) => v is $d4_example_5.Matrix,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix');
        final rows = D4.getRequiredArg<int>(positional, 0, 'rows', 'Matrix');
        final cols = D4.getRequiredArg<int>(positional, 1, 'cols', 'Matrix');
        return $d4_example_5.Matrix(rows, cols);
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix');
        if (positional.isEmpty) {
          throw ArgumentError('Matrix: Missing required argument "data" at position 0');
        }
        final data = D4.coerceList<List<double>>(positional[0], 'data');
        return $d4_example_5.Matrix.fromList(data);
      },
      'identity': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix');
        final size = D4.getRequiredArg<int>(positional, 0, 'size', 'Matrix');
        return $d4_example_5.Matrix.identity(size);
      },
    },
    getters: {
      'rows': (visitor, target) => D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix').rows,
      'cols': (visitor, target) => D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix').cols,
    },
    methods: {
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix');
        D4.requireMinArgs(positional, 2, 'get');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'get');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'get');
        return t.get(row, col);
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix');
        D4.requireMinArgs(positional, 3, 'set');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'set');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'set');
        final value = D4.getRequiredArg<double>(positional, 2, 'value', 'set');
        t.set(row, col, value);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix');
        return t.toString();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix');
        final other = D4.getRequiredArg<$d4_example_5.Matrix>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Matrix>(target, 'Matrix');
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
    nativeType: Dictionary,
    name: 'Dictionary',
    isAssignable: (v) => v is Dictionary,
    constructors: {
      '': (visitor, positional, named) {
        return Dictionary();
      },
    },
    getters: {
      'keys': (visitor, target) => D4.validateTarget<Dictionary>(target, 'Dictionary').keys,
      'values': (visitor, target) => D4.validateTarget<Dictionary>(target, 'Dictionary').values,
      'length': (visitor, target) => D4.validateTarget<Dictionary>(target, 'Dictionary').length,
    },
    methods: {
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dictionary>(target, 'Dictionary');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dictionary>(target, 'Dictionary');
        D4.requireMinArgs(positional, 1, 'remove');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'remove');
        return t.remove(key);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dictionary>(target, 'Dictionary');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dictionary>(target, 'Dictionary');
        return t.toString();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dictionary>(target, 'Dictionary');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Dictionary>(target, 'Dictionary');
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

