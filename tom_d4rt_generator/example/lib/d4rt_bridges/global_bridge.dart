// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/lib/test_classes/global_members.dart
// Generated: 2026-01-28T18:18:48.862179

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

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes
    for (final bridge in bridgeClasses()) {
      interpreter.registerBridgedClass(bridge, importPath);
    }

    // Register global variables
    registerGlobalVariables(interpreter);

    // Register global functions
    for (final entry in globalFunctions().entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value);
    }
  }

  /// Registers all global variables with the interpreter.
  static void registerGlobalVariables(D4rt interpreter) {
    interpreter.registerGlobalVariable('appVersion', $pkg.appVersion);
    interpreter.registerGlobalVariable('appName', $pkg.appName);
    interpreter.registerGlobalVariable('defaultTimeout', $pkg.defaultTimeout);
    interpreter.registerGlobalVariable('pi', $pkg.pi);
    interpreter.registerGlobalVariable('globalCounter', $pkg.globalCounter);
    interpreter.registerGlobalVariable('registeredNames', $pkg.registeredNames);
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
        final predicate = D4.getRequiredArg<dynamic>(positional, 1, 'predicate', 'findWhere');
        return $pkg.findWhere<dynamic>(items, predicate);
      },
      'mapList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mapList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'mapList');
        final mapper = D4.getRequiredArg<dynamic>(positional, 1, 'mapper', 'mapList');
        return $pkg.mapList<dynamic, dynamic>(items, mapper);
      },
      'filterList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'filterList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'filterList');
        final predicate = D4.getRequiredArg<dynamic>(positional, 1, 'predicate', 'filterList');
        return $pkg.filterList<dynamic>(items, predicate);
      },
      'reduceList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'reduceList');
        final items = D4.getRequiredArg<List<dynamic>>(positional, 0, 'items', 'reduceList');
        final combiner = D4.getRequiredArg<dynamic>(positional, 1, 'combiner', 'reduceList');
        return $pkg.reduceList<dynamic>(items, combiner);
      },
      'sortItems': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sortItems');
        final _sample = positional[0] as List;
        if (_sample.isEmpty) return <dynamic>[];
        final _first = _sample.first;
        if (_first is num) {
          return $pkg.sortItems<num>((positional[0] as List).cast<num>());
        }
        if (_first is String) {
          return $pkg.sortItems<String>((positional[0] as List).cast<String>());
        }
        if (_first is DateTime) {
          return $pkg.sortItems<DateTime>((positional[0] as List).cast<DateTime>());
        }
        throw ArgumentError('sortItems: Unsupported type for recursive bound. Supported types: num, String, DateTime. Got: ${_sample.runtimeType}');
      },
      'minValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'minValue');
        final _sample = positional[0];
        if (_sample is num) {
          return $pkg.minValue<num>(positional[0] as num, positional[1] as num);
        }
        if (_sample is String) {
          return $pkg.minValue<String>(positional[0] as String, positional[1] as String);
        }
        if (_sample is DateTime) {
          return $pkg.minValue<DateTime>(positional[0] as DateTime, positional[1] as DateTime);
        }
        throw ArgumentError('minValue: Unsupported type for recursive bound. Supported types: num, String, DateTime. Got: ${_sample.runtimeType}');
      },
      'maxValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'maxValue');
        final _sample = positional[0];
        if (_sample is num) {
          return $pkg.maxValue<num>(positional[0] as num, positional[1] as num);
        }
        if (_sample is String) {
          return $pkg.maxValue<String>(positional[0] as String, positional[1] as String);
        }
        if (_sample is DateTime) {
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
        final processor = D4.getRequiredArg<dynamic>(positional, 1, 'processor', 'processAsync');
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

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_generator_example/test_classes.dart';";
  }

  /// Returns D4rt script code that documents available global functions.
  ///
  /// These functions are available directly in D4rt scripts when
  /// the import block is included in the initialization script.
  static List<String> get globalFunctionNames => [
    'greet',
    'add',
    'multiply',
    'circleArea',
    'formatMessage',
    'identity',
    'makePair',
    'firstOrNull',
    'findWhere',
    'mapList',
    'filterList',
    'reduceList',
    'sortItems',
    'minValue',
    'maxValue',
    'delayedGreeting',
    'fetchData',
    'processAsync',
    'incrementCounter',
    'resetCounter',
    'registerName',
    'getRegisteredNames',
    'clearNames',
  ];

  /// Returns a list of global variable names.
  static List<String> get globalVariableNames => [
    'appVersion',
    'appName',
    'defaultTimeout',
    'pi',
    'globalCounter',
    'registeredNames',
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
String greet(String name) => GlobalBridge.greet(name);
int add(int a, int b) => GlobalBridge.add(a, b);
double multiply(double value, [double? factor]) => GlobalBridge.multiply(value, factor);
double circleArea(double radius) => GlobalBridge.circleArea(radius);
String formatMessage({required String message, String? prefix, String? suffix}) => GlobalBridge.formatMessage(message: message, prefix: prefix, suffix: suffix);
T identity(T value) => GlobalBridge.identity(value);
(A, B) makePair(A first, B second) => GlobalBridge.makePair(first, second);
T? firstOrNull(List<T> items) => GlobalBridge.firstOrNull(items);
T? findWhere(List<T> items, bool Function(T) predicate) => GlobalBridge.findWhere(items, predicate);
List<R> mapList(List<T> items, R Function(T) mapper) => GlobalBridge.mapList(items, mapper);
List<T> filterList(List<T> items, bool Function(T) predicate) => GlobalBridge.filterList(items, predicate);
T reduceList(List<T> items, T Function(T, T) combiner) => GlobalBridge.reduceList(items, combiner);
List<T> sortItems(List<T> items) => GlobalBridge.sortItems(items);
T minValue(T a, T b) => GlobalBridge.minValue(a, b);
T maxValue(T a, T b) => GlobalBridge.maxValue(a, b);
Future<String> delayedGreeting(String name, int delayMs) => GlobalBridge.delayedGreeting(name, delayMs);
Future<Map<String, dynamic>> fetchData(String id) => GlobalBridge.fetchData(id);
Future<List<R>> processAsync(List<T> items, Future<R> Function(T) processor) => GlobalBridge.processAsync(items, processor);
int incrementCounter() => GlobalBridge.incrementCounter();
void resetCounter() => GlobalBridge.resetCounter();
bool registerName(String name) => GlobalBridge.registerName(name);
List<String> getRegisteredNames() => GlobalBridge.getRegisteredNames();
void clearNames() => GlobalBridge.clearNames();
String get appVersion => GlobalBridge.appVersion;
String get appName => GlobalBridge.appName;
int get defaultTimeout => GlobalBridge.defaultTimeout;
double get pi => GlobalBridge.pi;
int get globalCounter => GlobalBridge.globalCounter;
set globalCounter(int value) => GlobalBridge.globalCounter = value;
List<String> get registeredNames => GlobalBridge.registeredNames;
''';
  }

}

