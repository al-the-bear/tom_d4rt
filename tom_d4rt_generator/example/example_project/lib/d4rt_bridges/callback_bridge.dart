// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/example_project/lib/test_classes/callback_classes.dart
// Generated: 2026-02-06T08:25:27.338797

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Callback module.
class CallbackBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createResultBridge(),
      _createTaskSchedulerBridge(),
      _createAsyncServiceBridge(),
      _createEventEmitterBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Result': 'package:d4rt_generator_example/test_classes/callback_classes.dart',
      'TaskScheduler': 'package:d4rt_generator_example/test_classes/callback_classes.dart',
      'AsyncService': 'package:d4rt_generator_example/test_classes/callback_classes.dart',
      'EventEmitter': 'package:d4rt_generator_example/test_classes/callback_classes.dart',
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
      'package:d4rt_generator_example/test_classes/callback_classes.dart',
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

// =============================================================================
// Result Bridge
// =============================================================================

BridgedClass _createResultBridge() {
  return BridgedClass(
    nativeType: $pkg.Result,
    name: 'Result',
    constructors: {
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'Result');
        return $pkg.Result.success(value);
      },
      'failure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Result');
        final error = D4.getRequiredArg<String?>(positional, 0, 'error', 'Result');
        return $pkg.Result.failure(error);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$pkg.Result>(target, 'Result').value,
      'error': (visitor, target) => D4.validateTarget<$pkg.Result>(target, 'Result').error,
      'isSuccess': (visitor, target) => D4.validateTarget<$pkg.Result>(target, 'Result').isSuccess,
      'isFailure': (visitor, target) => D4.validateTarget<$pkg.Result>(target, 'Result').isFailure,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Result>(target, 'Result');
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
    nativeType: $pkg.TaskScheduler,
    name: 'TaskScheduler',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.TaskScheduler();
      },
    },
    methods: {
      'addTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 1, 'addTask');
        if (positional.isEmpty) {
          throw ArgumentError('addTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        t.addTask(() { (taskRaw as InterpretedFunction).call(visitor, []); });
        return null;
      },
      'runAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        t.runAll();
        return null;
      },
      'runWithHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
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
        t.runWithHandler(() { return (taskRaw as InterpretedFunction).call(visitor, []) as dynamic; }, (dynamic p0) { (onSuccessRaw as InterpretedFunction).call(visitor, [p0]); }, (Object p0) { (onErrorRaw as InterpretedFunction).call(visitor, [p0]); });
        return null;
      },
      'mapValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'mapValues');
        if (positional.isEmpty) {
          throw ArgumentError('mapValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('mapValues: Missing required argument "mapper" at position 1');
        }
        final mapperRaw = positional[1];
        return t.mapValues(values, (dynamic p0) { return (mapperRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; });
      },
      'filterValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'filterValues');
        if (positional.isEmpty) {
          throw ArgumentError('filterValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('filterValues: Missing required argument "predicate" at position 1');
        }
        final predicateRaw = positional[1];
        return t.filterValues(values, (dynamic p0) { return (predicateRaw as InterpretedFunction).call(visitor, [p0]) as bool; });
      },
      'reduceValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'reduceValues');
        if (positional.isEmpty) {
          throw ArgumentError('reduceValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('reduceValues: Missing required argument "combiner" at position 1');
        }
        final combinerRaw = positional[1];
        return t.reduceValues(values, (dynamic p0, dynamic p1) { return (combinerRaw as InterpretedFunction).call(visitor, [p0, p1]) as dynamic; });
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
        final generator = (int p0) { return (generatorRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; };
        return $pkg.TaskScheduler.generate(count, generator);
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
    nativeType: $pkg.AsyncService,
    name: 'AsyncService',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AsyncService');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'AsyncService');
        final delayMs = D4.getOptionalArgWithDefault<int>(positional, 1, '_delayMs', 10);
        return $pkg.AsyncService(name, delayMs);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.AsyncService>(target, 'AsyncService').name,
    },
    methods: {
      'fetchData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AsyncService>(target, 'AsyncService');
        return t.fetchData();
      },
      'fetchById': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AsyncService>(target, 'AsyncService');
        D4.requireMinArgs(positional, 1, 'fetchById');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'fetchById');
        return t.fetchById(id);
      },
      'fetchWithProgress': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AsyncService>(target, 'AsyncService');
        D4.requireMinArgs(positional, 1, 'fetchWithProgress');
        if (positional.isEmpty) {
          throw ArgumentError('fetchWithProgress: Missing required argument "onProgress" at position 0');
        }
        final onProgressRaw = positional[0];
        return t.fetchWithProgress((int p0) { (onProgressRaw as InterpretedFunction).call(visitor, [p0]); });
      },
      'tryFetch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AsyncService>(target, 'AsyncService');
        D4.requireMinArgs(positional, 1, 'tryFetch');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'tryFetch');
        return t.tryFetch(id);
      },
    },
    staticMethods: {
      'create': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'create');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'create');
        return $pkg.AsyncService.create(name);
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
    nativeType: $pkg.EventEmitter,
    name: 'EventEmitter',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.EventEmitter();
      },
    },
    methods: {
      'on': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 2, 'on');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'on');
        if (positional.length <= 1) {
          throw ArgumentError('on: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.on(event, (String p0) { (callbackRaw as InterpretedFunction).call(visitor, [p0]); });
        return null;
      },
      'emit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'emit');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'emit');
        t.emit(event);
        return null;
      },
      'off': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 2, 'off');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'off');
        if (positional.length <= 1) {
          throw ArgumentError('off: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.off(event, (String p0) { (callbackRaw as InterpretedFunction).call(visitor, [p0]); });
        return null;
      },
      'once': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 2, 'once');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'once');
        if (positional.length <= 1) {
          throw ArgumentError('once: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.once(event, (String p0) { (callbackRaw as InterpretedFunction).call(visitor, [p0]); });
        return null;
      },
      'listenerCount': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EventEmitter>(target, 'EventEmitter');
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

