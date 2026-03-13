// D4rt Bridge - Generated file, do not edit
// Sources: 7 files
// Generated: 2026-03-12T17:06:46.823549

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
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
      'Person': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'Calculator': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'MathUtils': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'Result': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'TaskScheduler': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'AsyncService': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'EventEmitter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'Identifiable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Entity': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Box': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Repository': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Pair': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Transformer': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'Shape': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Circle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Rectangle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Serializable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Cloneable': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Point': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'ColoredRectangle': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'Vector2D': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\operator_classes.dart',
      'Matrix': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\operator_classes.dart',
      'Dictionary': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\operator_classes.dart',
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
      'greet': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'add': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'multiply': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'circleArea': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'formatMessage': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'identity': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'makePair': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'firstOrNull': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'findWhere': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'mapList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'filterList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'reduceList': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'sortItems': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'minValue': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'maxValue': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'delayedGreeting': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'fetchData': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'processAsync': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'incrementCounter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'resetCounter': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'registerName': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'getRegisteredNames': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'clearNames': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
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
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\basic_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\callback_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\enum_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\generic_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\global_members.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\inheritance_classes.dart',
      'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_generator\example\d4\lib\src\example_project\operator_classes.dart',
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
        return t.transform((dynamic p0) { return D4.callInterpreterCallback(visitor, transformerRaw, [p0]) as dynamic; });
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
    isAssignable: (v) => v is Transformer,
    constructors: {
      '': (visitor, positional, named) {
        return Transformer();
      },
    },
    methods: {
      'identity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'identity');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'identity');
        return t.identity(value);
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'cast');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'cast');
        return t.cast(value);
      },
      'singleton': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'singleton');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'singleton');
        return t.singleton(value);
      },
      'pair': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 2, 'pair');
        final first = D4.getRequiredArg<dynamic>(positional, 0, 'first', 'pair');
        final second = D4.getRequiredArg<dynamic>(positional, 1, 'second', 'pair');
        return t.pair(first, second);
      },
      'idOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Transformer>(target, 'Transformer');
        D4.requireMinArgs(positional, 1, 'idOf');
        final item = D4.getRequiredArg<$d4_example_3.Identifiable>(positional, 0, 'item', 'idOf');
        return t.idOf(item);
      },
    },
    staticMethods: {
      'repeat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'repeat');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'repeat');
        final count = D4.getRequiredArg<int>(positional, 1, 'count', 'repeat');
        return Transformer.repeat(value, count);
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
    nativeType: Shape,
    name: 'Shape',
    isAssignable: (v) => v is Circle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Circle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Circle');
        return Circle(radius);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<Circle>(target, 'Circle').name,
      'radius': (visitor, target) => D4.validateTarget<Circle>(target, 'Circle').radius,
      'diameter': (visitor, target) => D4.validateTarget<Circle>(target, 'Circle').diameter,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Circle>(target, 'Circle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Circle>(target, 'Circle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Circle>(target, 'Circle');
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
    nativeType: Rectangle,
    name: 'Rectangle',
    isAssignable: (v) => v is Serializable,
    constructors: {
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Serializable>(target, 'Serializable');
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
    nativeType: Cloneable,
    name: 'Cloneable',
    isAssignable: (v) => v is $d4_example_4.Point,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Point');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Point');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Point');
        return $d4_example_4.Point(x, y);
      },
      'origin': (visitor, positional, named) {
        return $d4_example_4.Point.origin();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$d4_example_4.Point>(target, 'Point').x,
      'y': (visitor, target) => D4.validateTarget<$d4_example_4.Point>(target, 'Point').y,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Point>(target, 'Point');
        return t.toJson();
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Point>(target, 'Point');
        return t.clone();
      },
      'distanceTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Point>(target, 'Point');
        D4.requireMinArgs(positional, 1, 'distanceTo');
        final other = D4.getRequiredArg<$d4_example_4.Point>(positional, 0, 'other', 'distanceTo');
        return t.distanceTo(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Point>(target, 'Point');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$d4_example_4.Point>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_4.Point>(target, 'Point');
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
        return $d4_example_4.Point.fromJson(json);
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
    nativeType: ColoredRectangle,
    name: 'ColoredRectangle',
    isAssignable: (v) => v is $d4_example_5.Vector2D,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2D');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2D');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2D');
        return $d4_example_5.Vector2D(x, y);
      },
      'zero': (visitor, positional, named) {
        return $d4_example_5.Vector2D.zero();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D').x,
      'y': (visitor, target) => D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D').y,
      'magnitude': (visitor, target) => D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D').magnitude,
      'hashCode': (visitor, target) => D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D').hashCode,
    },
    methods: {
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
        return t.normalize();
      },
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$d4_example_5.Vector2D>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<$d4_example_5.Vector2D>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$d4_example_5.Vector2D>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4_example_5.Vector2D>(target, 'Vector2D');
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
    nativeType: $d4_example_5.Matrix,
    name: 'Matrix',
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

