// D4rt Bridge - Generated file, do not edit
// Sources: 5 files
// Generated: 2026-03-08T15:43:32.115315

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/basic_types.dart' as $flutter_1;
import 'package:flutter/src/foundation/binding.dart' as $flutter_2;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_3;
import 'package:flutter/src/scheduler/binding.dart' as $flutter_4;
import 'package:flutter/src/scheduler/debug.dart' as $flutter_5;
import 'package:flutter/src/scheduler/priority.dart' as $flutter_6;
import 'package:flutter/src/scheduler/service_extensions.dart' as $flutter_7;
import 'package:flutter/src/scheduler/ticker.dart' as $flutter_8;

/// Bridge class for flutter_scheduler module.
class FlutterSchedulerBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createPriorityBridge(),
      _createPerformanceModeRequestHandleBridge(),
      _createSchedulerBindingBridge(),
      _createTickerProviderBridge(),
      _createTickerBridge(),
      _createTickerFutureBridge(),
      _createTickerCanceledBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Priority': 'package:flutter/src/scheduler/priority.dart',
      'PerformanceModeRequestHandle': 'package:flutter/src/scheduler/binding.dart',
      'SchedulerBinding': 'package:flutter/src/scheduler/binding.dart',
      'TickerProvider': 'package:flutter/src/scheduler/ticker.dart',
      'Ticker': 'package:flutter/src/scheduler/ticker.dart',
      'TickerFuture': 'package:flutter/src/scheduler/ticker.dart',
      'TickerCanceled': 'package:flutter/src/scheduler/ticker.dart',
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

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
      'FrameCallback',
      'TaskCallback',
      'SchedulingStrategy',
      '_PerformanceModeCleanupCallback',
      'TimingsCallback',
      'AsyncCallback',
      'AsyncValueGetter',
      'AsyncValueSetter',
      'ServiceExtensionCallback',
      'TickerCallback',
      'VoidCallback',
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_4.SchedulerPhase>(
        name: 'SchedulerPhase',
        values: $flutter_4.SchedulerPhase.values,
      ),
      BridgedEnumDefinition<$flutter_7.SchedulerServiceExtensions>(
        name: 'SchedulerServiceExtensions',
        values: $flutter_7.SchedulerServiceExtensions.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'SchedulerPhase': 'package:flutter/src/scheduler/binding.dart',
      'SchedulerServiceExtensions': 'package:flutter/src/scheduler/service_extensions.dart',
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

    // Register function typedefs for type resolution
    final typedefs = functionTypedefs();
    for (final name in typedefs) {
      interpreter.registerFunctionTypedef(name, importPath);
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
      interpreter.registerGlobalVariable('debugPrintBeginFrameBanner', $flutter_5.debugPrintBeginFrameBanner, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintBeginFrameBanner": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintEndFrameBanner', $flutter_5.debugPrintEndFrameBanner, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintEndFrameBanner": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintScheduleFrameStacks', $flutter_5.debugPrintScheduleFrameStacks, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintScheduleFrameStacks": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugTracePostFrameCallbacks', $flutter_5.debugTracePostFrameCallbacks, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugTracePostFrameCallbacks": $e');
    }
    interpreter.registerGlobalGetter('timeDilation', () => $flutter_4.timeDilation, importPath, sourceUri: 'package:flutter/src/scheduler/binding.dart');
    interpreter.registerGlobalSetter('timeDilation', (v) => $flutter_4.timeDilation = v as double, importPath, sourceUri: 'package:flutter/src/scheduler/binding.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_scheduler):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'defaultSchedulingStrategy': (visitor, positional, named, typeArgs) {
        final priority = D4.getRequiredNamedArg<int>(named, 'priority', 'defaultSchedulingStrategy');
        final scheduler = D4.getRequiredNamedArg<$flutter_4.SchedulerBinding>(named, 'scheduler', 'defaultSchedulingStrategy');
        return $flutter_4.defaultSchedulingStrategy(priority: priority, scheduler: scheduler);
      },
      'debugAssertAllSchedulerVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllSchedulerVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllSchedulerVarsUnset');
        return $flutter_5.debugAssertAllSchedulerVarsUnset(reason);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'defaultSchedulingStrategy': 'package:flutter/src/scheduler/binding.dart',
      'debugAssertAllSchedulerVarsUnset': 'package:flutter/src/scheduler/debug.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'defaultSchedulingStrategy': 'bool defaultSchedulingStrategy({required int priority, required SchedulerBinding scheduler})',
      'debugAssertAllSchedulerVarsUnset': 'bool debugAssertAllSchedulerVarsUnset(String reason)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:flutter/src/scheduler/binding.dart',
      'package:flutter/src/scheduler/debug.dart',
      'package:flutter/src/scheduler/priority.dart',
      'package:flutter/src/scheduler/service_extensions.dart',
      'package:flutter/src/scheduler/ticker.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:flutter/scheduler.dart';";
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
    'SchedulerPhase',
    'SchedulerServiceExtensions',
  ];

}

// =============================================================================
// Priority Bridge
// =============================================================================

BridgedClass _createPriorityBridge() {
  return BridgedClass(
    nativeType: $flutter_6.Priority,
    name: 'Priority',
    isAssignable: (v) => v is $flutter_6.Priority,
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_6.Priority>(target, 'Priority').value,
    },
    methods: {
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Priority>(target, 'Priority');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Priority>(target, 'Priority');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator-');
        return t - other;
      },
    },
    staticGetters: {
      'idle': (visitor) => $flutter_6.Priority.idle,
      'animation': (visitor) => $flutter_6.Priority.animation,
      'touch': (visitor) => $flutter_6.Priority.touch,
      'kMaxOffset': (visitor) => $flutter_6.Priority.kMaxOffset,
    },
    getterSignatures: {
      'value': 'int get value',
    },
    staticGetterSignatures: {
      'idle': 'Priority get idle',
      'animation': 'Priority get animation',
      'touch': 'Priority get touch',
      'kMaxOffset': 'int get kMaxOffset',
    },
  );
}

// =============================================================================
// PerformanceModeRequestHandle Bridge
// =============================================================================

BridgedClass _createPerformanceModeRequestHandleBridge() {
  return BridgedClass(
    nativeType: $flutter_4.PerformanceModeRequestHandle,
    name: 'PerformanceModeRequestHandle',
    isAssignable: (v) => v is $flutter_4.PerformanceModeRequestHandle,
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.PerformanceModeRequestHandle>(target, 'PerformanceModeRequestHandle');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'dispose': 'void dispose()',
    },
  );
}

// =============================================================================
// SchedulerBinding Bridge
// =============================================================================

BridgedClass _createSchedulerBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_4.SchedulerBinding,
    name: 'SchedulerBinding',
    isAssignable: (v) => v is $flutter_4.SchedulerBinding,
    constructors: {
    },
    getters: {
      'lifecycleState': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').lifecycleState,
      'schedulingStrategy': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').schedulingStrategy,
      'transientCallbackCount': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').transientCallbackCount,
      'endOfFrame': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').endOfFrame,
      'hasScheduledFrame': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').hasScheduledFrame,
      'schedulerPhase': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').schedulerPhase,
      'framesEnabled': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').framesEnabled,
      'currentFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').currentFrameTimeStamp,
      'currentSystemFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').currentSystemFrameTimeStamp,
      'window': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').platformDispatcher,
      'locked': (visitor, target) => D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').locked,
    },
    setters: {
      'schedulingStrategy': (visitor, target, value) {
        final schedulingStrategyRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'schedulingStrategy');
        D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding').schedulingStrategy = ({required int priority, required $flutter_4.SchedulerBinding scheduler}) { return D4.callInterpreterCallback(visitor!, schedulingStrategyRaw, [], {'priority': priority, 'scheduler': scheduler}) as bool; };
      },
    },
    methods: {
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.initInstances();
        return null;
      },
      'addTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'addTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'removeTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'removeTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'handleAppLifecycleStateChanged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'handleAppLifecycleStateChanged');
        final state = D4.getRequiredArg<AppLifecycleState>(positional, 0, 'state', 'handleAppLifecycleStateChanged');
        t.handleAppLifecycleStateChanged(state);
        return null;
      },
      'scheduleTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 2, 'scheduleTask');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        final priority = D4.getRequiredArg<$flutter_6.Priority>(positional, 1, 'priority', 'scheduleTask');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return t.scheduleTask(() { return D4.callInterpreterCallback(visitor!, taskRaw, []) as FutureOr<Object>; }, priority, debugLabel: debugLabel, flow: flow);
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        (t as dynamic).unlocked();
        return null;
      },
      'scheduleFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'scheduleFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final rescheduling = D4.getNamedArgWithDefault<bool>(named, 'rescheduling', false);
        final scheduleNewFrame = D4.getNamedArgWithDefault<bool>(named, 'scheduleNewFrame', true);
        return t.scheduleFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); }, rescheduling: rescheduling, scheduleNewFrame: scheduleNewFrame);
      },
      'cancelFrameCallbackWithId': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'cancelFrameCallbackWithId');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'cancelFrameCallbackWithId');
        t.cancelFrameCallbackWithId(id);
        return null;
      },
      'debugAssertNoTransientCallbacks': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTransientCallbacks');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTransientCallbacks');
        return t.debugAssertNoTransientCallbacks(reason);
      },
      'debugAssertNoPendingPerformanceModeRequests': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoPendingPerformanceModeRequests');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoPendingPerformanceModeRequests');
        return t.debugAssertNoPendingPerformanceModeRequests(reason);
      },
      'debugAssertNoTimeDilation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTimeDilation');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTimeDilation');
        return t.debugAssertNoTimeDilation(reason);
      },
      'addPersistentFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'addPersistentFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPersistentFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addPersistentFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'addPostFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'addPostFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPostFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final debugLabel = D4.getNamedArgWithDefault<String>(named, 'debugLabel', 'callback');
        t.addPostFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); }, debugLabel: debugLabel);
        return null;
      },
      'ensureFrameCallbacksRegistered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.ensureFrameCallbacksRegistered();
        return null;
      },
      'ensureVisualUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.ensureVisualUpdate();
        return null;
      },
      'scheduleFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.scheduleFrame();
        return null;
      },
      'scheduleForcedFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.scheduleForcedFrame();
        return null;
      },
      'scheduleWarmUpFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.scheduleWarmUpFrame();
        return null;
      },
      'resetEpoch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.resetEpoch();
        return null;
      },
      'handleBeginFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'handleBeginFrame');
        final rawTimeStamp = D4.getRequiredArg<Duration?>(positional, 0, 'rawTimeStamp', 'handleBeginFrame');
        t.handleBeginFrame(rawTimeStamp);
        return null;
      },
      'requestPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'requestPerformanceMode');
        final mode = D4.getRequiredArg<DartPerformanceMode>(positional, 0, 'mode', 'requestPerformanceMode');
        return t.requestPerformanceMode(mode);
      },
      'debugGetRequestedPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        return t.debugGetRequestedPerformanceMode();
      },
      'handleDrawFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        t.handleDrawFrame();
        return null;
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'lockEvents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'lockEvents');
        if (positional.isEmpty) {
          throw ArgumentError('lockEvents: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.lockEvents(() { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        return t.reassembleApplication();
      },
      'performReassemble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        return t.performReassemble();
      },
      'registerSignalServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerSignalServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerSignalServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerSignalServiceExtension(name: name, callback: () { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
        return null;
      },
      'registerBoolServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerBoolServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerBoolServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerBoolServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerBoolServiceExtension(name: name, getter: () { return D4.callInterpreterCallback(visitor!, getterRaw, []) as Future<bool>; }, setter: (bool p0) { return D4.callInterpreterCallback(visitor!, setterRaw, [p0]) as Future<void>; });
        return null;
      },
      'registerNumericServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerNumericServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerNumericServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerNumericServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerNumericServiceExtension(name: name, getter: () { return D4.callInterpreterCallback(visitor!, getterRaw, []) as Future<double>; }, setter: (double p0) { return D4.callInterpreterCallback(visitor!, setterRaw, [p0]) as Future<void>; });
        return null;
      },
      'postEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 2, 'postEvent');
        final eventKind = D4.getRequiredArg<String>(positional, 0, 'eventKind', 'postEvent');
        if (positional.length <= 1) {
          throw ArgumentError('postEvent: Missing required argument "eventData" at position 1');
        }
        final eventData = D4.coerceMap<String, dynamic>(positional[1], 'eventData');
        t.postEvent(eventKind, eventData);
        return null;
      },
      'registerStringServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerStringServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerStringServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerStringServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerStringServiceExtension(name: name, getter: () { return D4.callInterpreterCallback(visitor!, getterRaw, []) as Future<String>; }, setter: (String p0) { return D4.callInterpreterCallback(visitor!, setterRaw, [p0]) as Future<void>; });
        return null;
      },
      'registerServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: (Map<String, String> p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as Future<Map<String, dynamic>>; });
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SchedulerBinding>(target, 'SchedulerBinding');
        return t.toString();
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_4.SchedulerBinding.instance,
    },
    staticMethods: {
      'debugPrintTransientCallbackRegistrationStack': (visitor, positional, named, typeArgs) {
        return $flutter_4.SchedulerBinding.debugPrintTransientCallbackRegistrationStack();
      },
    },
    methodSignatures: {
      'initInstances': 'void initInstances()',
      'addTimingsCallback': 'void addTimingsCallback(TimingsCallback callback)',
      'removeTimingsCallback': 'void removeTimingsCallback(TimingsCallback callback)',
      'initServiceExtensions': 'void initServiceExtensions()',
      'handleAppLifecycleStateChanged': 'void handleAppLifecycleStateChanged(AppLifecycleState state)',
      'scheduleTask': 'Future<T> scheduleTask(TaskCallback<T> task, Priority priority, {String? debugLabel, Flow? flow})',
      'unlocked': 'void unlocked()',
      'scheduleFrameCallback': 'int scheduleFrameCallback(FrameCallback callback, {bool rescheduling = false, bool scheduleNewFrame = true})',
      'cancelFrameCallbackWithId': 'void cancelFrameCallbackWithId(int id)',
      'debugAssertNoTransientCallbacks': 'bool debugAssertNoTransientCallbacks(String reason)',
      'debugAssertNoPendingPerformanceModeRequests': 'bool debugAssertNoPendingPerformanceModeRequests(String reason)',
      'debugAssertNoTimeDilation': 'bool debugAssertNoTimeDilation(String reason)',
      'addPersistentFrameCallback': 'void addPersistentFrameCallback(FrameCallback callback)',
      'addPostFrameCallback': 'void addPostFrameCallback(FrameCallback callback, {String debugLabel = \'callback\'})',
      'ensureFrameCallbacksRegistered': 'void ensureFrameCallbacksRegistered()',
      'ensureVisualUpdate': 'void ensureVisualUpdate()',
      'scheduleFrame': 'void scheduleFrame()',
      'scheduleForcedFrame': 'void scheduleForcedFrame()',
      'scheduleWarmUpFrame': 'void scheduleWarmUpFrame()',
      'resetEpoch': 'void resetEpoch()',
      'handleBeginFrame': 'void handleBeginFrame(Duration? rawTimeStamp)',
      'requestPerformanceMode': 'PerformanceModeRequestHandle? requestPerformanceMode(DartPerformanceMode mode)',
      'debugGetRequestedPerformanceMode': 'DartPerformanceMode? debugGetRequestedPerformanceMode()',
      'handleDrawFrame': 'void handleDrawFrame()',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'lockEvents': 'Future<void> lockEvents(Future<void> Function() callback)',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'performReassemble': 'Future<void> performReassemble()',
      'registerSignalServiceExtension': 'void registerSignalServiceExtension({required String name, required Future<void> Function() callback})',
      'registerBoolServiceExtension': 'void registerBoolServiceExtension({required String name, required Future<bool> Function() getter, required Future<void> Function(bool) setter})',
      'registerNumericServiceExtension': 'void registerNumericServiceExtension({required String name, required Future<double> Function() getter, required Future<void> Function(double) setter})',
      'postEvent': 'void postEvent(String eventKind, Map<String, dynamic> eventData)',
      'registerStringServiceExtension': 'void registerStringServiceExtension({required String name, required Future<String> Function() getter, required Future<void> Function(String) setter})',
      'registerServiceExtension': 'void registerServiceExtension({required String name, required Future<Map<String, dynamic>> Function(Map<String, String>) callback})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'lifecycleState': 'AppLifecycleState? get lifecycleState',
      'schedulingStrategy': 'SchedulingStrategy get schedulingStrategy',
      'transientCallbackCount': 'int get transientCallbackCount',
      'endOfFrame': 'Future<void> get endOfFrame',
      'hasScheduledFrame': 'bool get hasScheduledFrame',
      'schedulerPhase': 'SchedulerPhase get schedulerPhase',
      'framesEnabled': 'bool get framesEnabled',
      'currentFrameTimeStamp': 'Duration get currentFrameTimeStamp',
      'currentSystemFrameTimeStamp': 'Duration get currentSystemFrameTimeStamp',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
      'locked': 'bool get locked',
    },
    setterSignatures: {
      'schedulingStrategy': 'set schedulingStrategy(dynamic value)',
    },
    staticMethodSignatures: {
      'debugPrintTransientCallbackRegistrationStack': 'void debugPrintTransientCallbackRegistrationStack()',
    },
    staticGetterSignatures: {
      'instance': 'SchedulerBinding get instance',
    },
  );
}

// =============================================================================
// TickerProvider Bridge
// =============================================================================

BridgedClass _createTickerProviderBridge() {
  return BridgedClass(
    nativeType: $flutter_8.TickerProvider,
    name: 'TickerProvider',
    isAssignable: (v) => v is $flutter_8.TickerProvider,
    constructors: {
    },
    methods: {
      'createTicker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerProvider>(target, 'TickerProvider');
        D4.requireMinArgs(positional, 1, 'createTicker');
        if (positional.isEmpty) {
          throw ArgumentError('createTicker: Missing required argument "onTick" at position 0');
        }
        final onTickRaw = positional[0];
        return t.createTicker((Duration p0) { D4.callInterpreterCallback(visitor!, onTickRaw, [p0]); });
      },
    },
    methodSignatures: {
      'createTicker': 'Ticker createTicker(TickerCallback onTick)',
    },
  );
}

// =============================================================================
// Ticker Bridge
// =============================================================================

BridgedClass _createTickerBridge() {
  return BridgedClass(
    nativeType: $flutter_8.Ticker,
    name: 'Ticker',
    isAssignable: (v) => v is $flutter_8.Ticker,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Ticker');
        if (positional.isEmpty) {
          throw ArgumentError('Ticker: Missing required argument "_onTick" at position 0');
        }
        final onTickRaw = positional[0];
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        return $flutter_8.Ticker((Duration p0) { D4.callInterpreterCallback(visitor!, onTickRaw, [p0]); }, debugLabel: debugLabel);
      },
    },
    getters: {
      'forceFrames': (visitor, target) => D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').forceFrames,
      'muted': (visitor, target) => D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').muted,
      'isTicking': (visitor, target) => D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').isTicking,
      'isActive': (visitor, target) => D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').isActive,
      'scheduled': (visitor, target) => D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').scheduled,
      'shouldScheduleTick': (visitor, target) => D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').shouldScheduleTick,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').debugLabel,
    },
    setters: {
      'forceFrames': (visitor, target, value) => 
        D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').forceFrames = D4.extractBridgedArg<bool>(value, 'forceFrames'),
      'muted': (visitor, target, value) => 
        D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker').muted = D4.extractBridgedArg<bool>(value, 'muted'),
    },
    methods: {
      'start': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        return t.start();
      },
      'describeForError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        D4.requireMinArgs(positional, 1, 'describeForError');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'describeForError');
        return t.describeForError(name);
      },
      'stop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        final canceled = D4.getNamedArgWithDefault<bool>(named, 'canceled', false);
        t.stop(canceled: canceled);
        return null;
      },
      'scheduleTick': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        final rescheduling = D4.getNamedArgWithDefault<bool>(named, 'rescheduling', false);
        t.scheduleTick(rescheduling: rescheduling);
        return null;
      },
      'unscheduleTick': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        t.unscheduleTick();
        return null;
      },
      'absorbTicker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        D4.requireMinArgs(positional, 1, 'absorbTicker');
        final originalTicker = D4.getRequiredArg<$flutter_8.Ticker>(positional, 0, 'originalTicker', 'absorbTicker');
        t.absorbTicker(originalTicker);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Ticker>(target, 'Ticker');
        final debugIncludeStack = D4.getNamedArgWithDefault<bool>(named, 'debugIncludeStack', false);
        return t.toString(debugIncludeStack: debugIncludeStack);
      },
    },
    constructorSignatures: {
      '': 'Ticker(void Function(Duration) _onTick, {String? debugLabel})',
    },
    methodSignatures: {
      'start': 'TickerFuture start()',
      'describeForError': 'DiagnosticsNode describeForError(String name)',
      'stop': 'void stop({bool canceled = false})',
      'scheduleTick': 'void scheduleTick({bool rescheduling = false})',
      'unscheduleTick': 'void unscheduleTick()',
      'absorbTicker': 'void absorbTicker(Ticker originalTicker)',
      'dispose': 'void dispose()',
      'toString': 'String toString({bool debugIncludeStack = false})',
    },
    getterSignatures: {
      'forceFrames': 'bool get forceFrames',
      'muted': 'bool get muted',
      'isTicking': 'bool get isTicking',
      'isActive': 'bool get isActive',
      'scheduled': 'bool get scheduled',
      'shouldScheduleTick': 'bool get shouldScheduleTick',
      'debugLabel': 'String? get debugLabel',
    },
    setterSignatures: {
      'forceFrames': 'set forceFrames(dynamic value)',
      'muted': 'set muted(bool value)',
    },
  );
}

// =============================================================================
// TickerFuture Bridge
// =============================================================================

BridgedClass _createTickerFutureBridge() {
  return BridgedClass(
    nativeType: $flutter_8.TickerFuture,
    name: 'TickerFuture',
    isAssignable: (v) => v is $flutter_8.TickerFuture,
    constructors: {
      'complete': (visitor, positional, named) {
        return $flutter_8.TickerFuture.complete();
      },
    },
    getters: {
      'orCancel': (visitor, target) => D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture').orCancel,
    },
    methods: {
      'whenCompleteOrCancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenCompleteOrCancel');
        if (positional.isEmpty) {
          throw ArgumentError('whenCompleteOrCancel: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.whenCompleteOrCancel(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'asStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture');
        return t.asStream();
      },
      'catchError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'catchError');
        final onError = D4.getRequiredArg<Function>(positional, 0, 'onError', 'catchError');
        final testRaw = named['test'];
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((void p0) { return D4.callInterpreterCallback(visitor!, onValueRaw, [null]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, onTimeoutRaw, []) as FutureOr<void>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenComplete');
        if (positional.isEmpty) {
          throw ArgumentError('whenComplete: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.whenComplete(() { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, actionRaw, [])); });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerFuture>(target, 'TickerFuture');
        return t.toString();
      },
    },
    constructorSignatures: {
      'complete': 'TickerFuture.complete()',
    },
    methodSignatures: {
      'whenCompleteOrCancel': 'void whenCompleteOrCancel(VoidCallback callback)',
      'asStream': 'Stream<void> asStream()',
      'catchError': 'Future<void> catchError(Function onError, {bool Function(Object)? test})',
      'then': 'Future<R> then(FutureOr<R> Function(void value) onValue, {Function? onError})',
      'timeout': 'Future<void> timeout(Duration timeLimit, {FutureOr<void> Function()? onTimeout})',
      'whenComplete': 'Future<void> whenComplete(dynamic Function() action)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'orCancel': 'Future<void> get orCancel',
    },
  );
}

// =============================================================================
// TickerCanceled Bridge
// =============================================================================

BridgedClass _createTickerCanceledBridge() {
  return BridgedClass(
    nativeType: $flutter_8.TickerCanceled,
    name: 'TickerCanceled',
    isAssignable: (v) => v is $flutter_8.TickerCanceled,
    constructors: {
      '': (visitor, positional, named) {
        final ticker = D4.getOptionalArg<$flutter_8.Ticker?>(positional, 0, 'ticker');
        return $flutter_8.TickerCanceled(ticker);
      },
    },
    getters: {
      'ticker': (visitor, target) => D4.validateTarget<$flutter_8.TickerCanceled>(target, 'TickerCanceled').ticker,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TickerCanceled>(target, 'TickerCanceled');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TickerCanceled([Ticker? ticker])',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'ticker': 'Ticker? get ticker',
    },
  );
}

