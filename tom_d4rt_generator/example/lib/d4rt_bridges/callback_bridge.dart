// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/lib/test_classes/callback_classes.dart
// Generated: 2026-01-28T16:16:12.700394

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

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes
    for (final bridge in bridgeClasses()) {
      interpreter.registerBridgedClass(bridge, importPath);
    }
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
        if (positional.length <= 0) {
          throw ArgumentError('addTask: Missing required argument "task" at position 0');
        }
        final task_raw = positional[0];
        t.addTask(() { (task_raw as InterpretedFunction).call(visitor as InterpreterVisitor, []); });
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
        if (positional.length <= 0) {
          throw ArgumentError('runWithHandler: Missing required argument "task" at position 0');
        }
        final task_raw = positional[0];
        if (positional.length <= 1) {
          throw ArgumentError('runWithHandler: Missing required argument "onSuccess" at position 1');
        }
        final onSuccess_raw = positional[1];
        if (positional.length <= 2) {
          throw ArgumentError('runWithHandler: Missing required argument "onError" at position 2');
        }
        final onError_raw = positional[2];
        t.runWithHandler(() { return (task_raw as InterpretedFunction).call(visitor as InterpreterVisitor, []) as dynamic; }, (dynamic p0) { (onSuccess_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]); }, (Object p0) { (onError_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]); });
        return null;
      },
      'mapValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'mapValues');
        if (positional.length <= 0) {
          throw ArgumentError('mapValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('mapValues: Missing required argument "mapper" at position 1');
        }
        final mapper_raw = positional[1];
        return t.mapValues(values, (dynamic p0) { return (mapper_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as dynamic; });
      },
      'filterValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'filterValues');
        if (positional.length <= 0) {
          throw ArgumentError('filterValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('filterValues: Missing required argument "predicate" at position 1');
        }
        final predicate_raw = positional[1];
        return t.filterValues(values, (dynamic p0) { return (predicate_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as bool; });
      },
      'reduceValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TaskScheduler>(target, 'TaskScheduler');
        D4.requireMinArgs(positional, 2, 'reduceValues');
        if (positional.length <= 0) {
          throw ArgumentError('reduceValues: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<dynamic>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('reduceValues: Missing required argument "combiner" at position 1');
        }
        final combiner_raw = positional[1];
        return t.reduceValues(values, (dynamic p0, dynamic p1) { return (combiner_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0, p1]) as dynamic; });
      },
    },
    staticMethods: {
      'generate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'generate');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'generate');
        if (positional.length <= 1) {
          throw ArgumentError('generate: Missing required argument "generator" at position 1');
        }
        final generator_raw = positional[1];
        final generator = (int p0) { return (generator_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]) as dynamic; };
        return $pkg.TaskScheduler.generate(count, generator);
      },
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
        final _delayMs = D4.getOptionalArgWithDefault<int>(positional, 1, '_delayMs', 10);
        return $pkg.AsyncService(name, _delayMs);
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
        if (positional.length <= 0) {
          throw ArgumentError('fetchWithProgress: Missing required argument "onProgress" at position 0');
        }
        final onProgress_raw = positional[0];
        return t.fetchWithProgress((int p0) { (onProgress_raw as InterpretedFunction).call(visitor as InterpreterVisitor, [p0]); });
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
        final callback = D4.getRequiredArg<dynamic>(positional, 1, 'callback', 'on');
        t.on(event, callback);
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
        final callback = D4.getRequiredArg<dynamic>(positional, 1, 'callback', 'off');
        t.off(event, callback);
        return null;
      },
      'once': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 2, 'once');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'once');
        final callback = D4.getRequiredArg<dynamic>(positional, 1, 'callback', 'once');
        t.once(event, callback);
        return null;
      },
      'listenerCount': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.EventEmitter>(target, 'EventEmitter');
        D4.requireMinArgs(positional, 1, 'listenerCount');
        final event = D4.getRequiredArg<String>(positional, 0, 'event', 'listenerCount');
        return t.listenerCount(event);
      },
    },
  );
}

