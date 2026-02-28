// D4rt Bridge - Generated file, do not edit
// Sources: 6 files
// Generated: 2026-02-28T12:38:59.157604

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_1;
import 'package:flutter/src/scheduler/binding.dart' as $flutter_2;
import 'package:flutter/src/scheduler/debug.dart' as $flutter_3;
import 'package:flutter/src/scheduler/priority.dart' as $flutter_4;
import 'package:flutter/src/scheduler/service_extensions.dart' as $flutter_5;
import 'package:flutter/src/scheduler/ticker.dart' as $flutter_6;
import 'package:flutter/src/foundation/binding.dart' as $aux_flutter;

/// Bridge class for flutter_scheduler module.
class FlutterSchedulerBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createPriorityBridge(),
      _createPerformanceModeRequestHandleBridge(),
      _createSchedulerBindingBridge(),
      _createDiagnosticsNodeBridge(),
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
      'DiagnosticsNode': 'package:flutter/src/foundation/diagnostics.dart',
      'TickerProvider': 'package:flutter/src/scheduler/ticker.dart',
      'Ticker': 'package:flutter/src/scheduler/ticker.dart',
      'TickerFuture': 'package:flutter/src/scheduler/ticker.dart',
      'TickerCanceled': 'package:flutter/src/scheduler/ticker.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_2.SchedulerPhase>(
        name: 'SchedulerPhase',
        values: $flutter_2.SchedulerPhase.values,
      ),
      BridgedEnumDefinition<$flutter_5.SchedulerServiceExtensions>(
        name: 'SchedulerServiceExtensions',
        values: $flutter_5.SchedulerServiceExtensions.values,
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
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('debugPrintBeginFrameBanner', $flutter_3.debugPrintBeginFrameBanner, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintBeginFrameBanner": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintEndFrameBanner', $flutter_3.debugPrintEndFrameBanner, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintEndFrameBanner": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintScheduleFrameStacks', $flutter_3.debugPrintScheduleFrameStacks, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintScheduleFrameStacks": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugTracePostFrameCallbacks', $flutter_3.debugTracePostFrameCallbacks, importPath, sourceUri: 'package:flutter/src/scheduler/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugTracePostFrameCallbacks": $e');
    }
    interpreter.registerGlobalGetter('timeDilation', () => $flutter_2.timeDilation, importPath, sourceUri: 'package:flutter/src/scheduler/binding.dart');
    interpreter.registerGlobalSetter('timeDilation', (v) => $flutter_2.timeDilation = v as double, importPath, sourceUri: 'package:flutter/src/scheduler/binding.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_scheduler):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'defaultSchedulingStrategy': (visitor, positional, named, typeArgs) {
        final priority = D4.getRequiredNamedArg<int>(named, 'priority', 'defaultSchedulingStrategy');
        final scheduler = D4.getRequiredNamedArg<$flutter_2.SchedulerBinding>(named, 'scheduler', 'defaultSchedulingStrategy');
        return $flutter_2.defaultSchedulingStrategy(priority: priority, scheduler: scheduler);
      },
      'debugAssertAllSchedulerVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllSchedulerVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllSchedulerVarsUnset');
        return $flutter_3.debugAssertAllSchedulerVarsUnset(reason);
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
      'package:flutter/src/foundation/diagnostics.dart',
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
    nativeType: $flutter_4.Priority,
    name: 'Priority',
    constructors: {
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_4.Priority>(target, 'Priority').value,
    },
    methods: {
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Priority>(target, 'Priority');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Priority>(target, 'Priority');
        final other = D4.getRequiredArg<int>(positional, 0, 'other', 'operator-');
        return t - other;
      },
    },
    staticGetters: {
      'idle': (visitor) => $flutter_4.Priority.idle,
      'animation': (visitor) => $flutter_4.Priority.animation,
      'touch': (visitor) => $flutter_4.Priority.touch,
      'kMaxOffset': (visitor) => $flutter_4.Priority.kMaxOffset,
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
    nativeType: $flutter_2.PerformanceModeRequestHandle,
    name: 'PerformanceModeRequestHandle',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.PerformanceModeRequestHandle>(target, 'PerformanceModeRequestHandle');
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
    nativeType: $flutter_2.SchedulerBinding,
    name: 'SchedulerBinding',
    constructors: {
    },
    getters: {
      'lifecycleState': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').lifecycleState,
      'schedulingStrategy': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').schedulingStrategy,
      'transientCallbackCount': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').transientCallbackCount,
      'endOfFrame': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').endOfFrame,
      'hasScheduledFrame': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').hasScheduledFrame,
      'schedulerPhase': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').schedulerPhase,
      'framesEnabled': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').framesEnabled,
      'currentFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').currentFrameTimeStamp,
      'currentSystemFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').currentSystemFrameTimeStamp,
      'window': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').platformDispatcher,
    },
    setters: {
      'schedulingStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding').schedulingStrategy = value as $flutter_2.SchedulingStrategy,
    },
    methods: {
      'addTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'addTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'removeTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'removeTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'scheduleTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 2, 'scheduleTask');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        final priority = D4.getRequiredArg<$flutter_4.Priority>(positional, 1, 'priority', 'scheduleTask');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return t.scheduleTask(() { return D4.callInterpreterCallback(visitor, taskRaw, []) as FutureOr<Object>; }, priority, debugLabel: debugLabel, flow: flow);
      },
      'scheduleFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'scheduleFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final rescheduling = D4.getNamedArgWithDefault<bool>(named, 'rescheduling', false);
        final scheduleNewFrame = D4.getNamedArgWithDefault<bool>(named, 'scheduleNewFrame', true);
        return t.scheduleFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); }, rescheduling: rescheduling, scheduleNewFrame: scheduleNewFrame);
      },
      'cancelFrameCallbackWithId': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'cancelFrameCallbackWithId');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'cancelFrameCallbackWithId');
        t.cancelFrameCallbackWithId(id);
        return null;
      },
      'debugAssertNoTransientCallbacks': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTransientCallbacks');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTransientCallbacks');
        return t.debugAssertNoTransientCallbacks(reason);
      },
      'debugAssertNoPendingPerformanceModeRequests': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoPendingPerformanceModeRequests');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoPendingPerformanceModeRequests');
        return t.debugAssertNoPendingPerformanceModeRequests(reason);
      },
      'debugAssertNoTimeDilation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTimeDilation');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTimeDilation');
        return t.debugAssertNoTimeDilation(reason);
      },
      'addPersistentFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'addPersistentFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPersistentFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addPersistentFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'addPostFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'addPostFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPostFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final debugLabel = D4.getNamedArgWithDefault<String>(named, 'debugLabel', 'callback');
        t.addPostFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); }, debugLabel: debugLabel);
        return null;
      },
      'ensureVisualUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        t.ensureVisualUpdate();
        return null;
      },
      'scheduleFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        t.scheduleFrame();
        return null;
      },
      'scheduleForcedFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        t.scheduleForcedFrame();
        return null;
      },
      'scheduleWarmUpFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        t.scheduleWarmUpFrame();
        return null;
      },
      'resetEpoch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        t.resetEpoch();
        return null;
      },
      'handleBeginFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'handleBeginFrame');
        final rawTimeStamp = D4.getRequiredArg<Duration?>(positional, 0, 'rawTimeStamp', 'handleBeginFrame');
        t.handleBeginFrame(rawTimeStamp);
        return null;
      },
      'requestPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'requestPerformanceMode');
        final mode = D4.getRequiredArg<DartPerformanceMode>(positional, 0, 'mode', 'requestPerformanceMode');
        return t.requestPerformanceMode(mode);
      },
      'debugGetRequestedPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        return t.debugGetRequestedPerformanceMode();
      },
      'handleDrawFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        t.handleDrawFrame();
        return null;
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        return t.reassembleApplication();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.SchedulerBinding>(target, 'SchedulerBinding');
        return t.toString();
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_2.SchedulerBinding.instance,
    },
    staticMethods: {
      'debugPrintTransientCallbackRegistrationStack': (visitor, positional, named, typeArgs) {
        return $flutter_2.SchedulerBinding.debugPrintTransientCallbackRegistrationStack();
      },
    },
    methodSignatures: {
      'addTimingsCallback': 'void addTimingsCallback(TimingsCallback callback)',
      'removeTimingsCallback': 'void removeTimingsCallback(TimingsCallback callback)',
      'scheduleTask': 'Future<T> scheduleTask(TaskCallback<T> task, Priority priority, {String? debugLabel, Flow? flow})',
      'scheduleFrameCallback': 'int scheduleFrameCallback(FrameCallback callback, {bool rescheduling = false, bool scheduleNewFrame = true})',
      'cancelFrameCallbackWithId': 'void cancelFrameCallbackWithId(int id)',
      'debugAssertNoTransientCallbacks': 'bool debugAssertNoTransientCallbacks(String reason)',
      'debugAssertNoPendingPerformanceModeRequests': 'bool debugAssertNoPendingPerformanceModeRequests(String reason)',
      'debugAssertNoTimeDilation': 'bool debugAssertNoTimeDilation(String reason)',
      'addPersistentFrameCallback': 'void addPersistentFrameCallback(FrameCallback callback)',
      'addPostFrameCallback': 'void addPostFrameCallback(FrameCallback callback, {String debugLabel = \'callback\'})',
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
      'reassembleApplication': 'Future<void> reassembleApplication()',
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
// DiagnosticsNode Bridge
// =============================================================================

BridgedClass _createDiagnosticsNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_1.DiagnosticsNode,
    name: 'DiagnosticsNode',
    constructors: {
      'message': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticsNode');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DiagnosticsNode');
        final style = D4.getNamedArgWithDefault<$flutter_1.DiagnosticsTreeStyle>(named, 'style', $flutter_1.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_1.DiagnosticLevel>(named, 'level', $flutter_1.DiagnosticLevel.info);
        final allowWrap = D4.getNamedArgWithDefault<bool>(named, 'allowWrap', true);
        return $flutter_1.DiagnosticsNode.message(message, style: style, level: level, allowWrap: allowWrap);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode').allowTruncate,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_1.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_1.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_1.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_1.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_1.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_1.DiagnosticLevel>(named, 'minLevel', $flutter_1.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.DiagnosticsNode>(target, 'DiagnosticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_1.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_1.DiagnosticLevel>(named, 'minLevel', $flutter_1.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    staticMethods: {
      'toJsonList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'toJsonList');
        if (positional.isEmpty) {
          throw ArgumentError('toJsonList: Missing required argument "nodes" at position 0');
        }
        final nodes = D4.coerceListOrNull<$flutter_1.DiagnosticsNode>(positional[0], 'nodes');
        final parent = D4.getRequiredArg<$flutter_1.DiagnosticsNode?>(positional, 1, 'parent', 'toJsonList');
        final delegate = D4.getRequiredArg<$flutter_1.DiagnosticsSerializationDelegate>(positional, 2, 'delegate', 'toJsonList');
        return $flutter_1.DiagnosticsNode.toJsonList(nodes, parent, delegate);
      },
    },
    constructorSignatures: {
      'message': 'factory DiagnosticsNode.message(String message, {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info, bool allowWrap = true})',
    },
    methodSignatures: {
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'level': 'DiagnosticLevel get level',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'value': 'Object? get value',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'allowTruncate': 'bool get allowTruncate',
    },
    staticMethodSignatures: {
      'toJsonList': 'List<Map<String, Object?>> toJsonList(List<DiagnosticsNode>? nodes, DiagnosticsNode? parent, DiagnosticsSerializationDelegate delegate)',
    },
  );
}

// =============================================================================
// TickerProvider Bridge
// =============================================================================

BridgedClass _createTickerProviderBridge() {
  return BridgedClass(
    nativeType: $flutter_6.TickerProvider,
    name: 'TickerProvider',
    constructors: {
    },
    methods: {
      'createTicker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerProvider>(target, 'TickerProvider');
        D4.requireMinArgs(positional, 1, 'createTicker');
        if (positional.isEmpty) {
          throw ArgumentError('createTicker: Missing required argument "onTick" at position 0');
        }
        final onTickRaw = positional[0];
        return t.createTicker((Duration p0) { D4.callInterpreterCallback(visitor, onTickRaw, [p0]); });
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
    nativeType: $flutter_6.Ticker,
    name: 'Ticker',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Ticker');
        if (positional.isEmpty) {
          throw ArgumentError('Ticker: Missing required argument "_onTick" at position 0');
        }
        final onTickRaw = positional[0];
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        return $flutter_6.Ticker((Duration p0) { D4.callInterpreterCallback(visitor, onTickRaw, [p0]); }, debugLabel: debugLabel);
      },
    },
    getters: {
      'forceFrames': (visitor, target) => D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker').forceFrames,
      'muted': (visitor, target) => D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker').muted,
      'isTicking': (visitor, target) => D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker').isTicking,
      'isActive': (visitor, target) => D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker').isActive,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker').debugLabel,
    },
    setters: {
      'forceFrames': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker').forceFrames = value as bool,
      'muted': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker').muted = value as dynamic,
    },
    methods: {
      'start': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker');
        return t.start();
      },
      'describeForError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker');
        D4.requireMinArgs(positional, 1, 'describeForError');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'describeForError');
        return t.describeForError(name);
      },
      'stop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker');
        final canceled = D4.getNamedArgWithDefault<bool>(named, 'canceled', false);
        t.stop(canceled: canceled);
        return null;
      },
      'absorbTicker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker');
        D4.requireMinArgs(positional, 1, 'absorbTicker');
        final originalTicker = D4.getRequiredArg<$flutter_6.Ticker>(positional, 0, 'originalTicker', 'absorbTicker');
        t.absorbTicker(originalTicker);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Ticker>(target, 'Ticker');
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
      'absorbTicker': 'void absorbTicker(Ticker originalTicker)',
      'dispose': 'void dispose()',
      'toString': 'String toString({bool debugIncludeStack = false})',
    },
    getterSignatures: {
      'forceFrames': 'bool get forceFrames',
      'muted': 'bool get muted',
      'isTicking': 'bool get isTicking',
      'isActive': 'bool get isActive',
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
    nativeType: $flutter_6.TickerFuture,
    name: 'TickerFuture',
    constructors: {
      'complete': (visitor, positional, named) {
        return $flutter_6.TickerFuture.complete();
      },
    },
    getters: {
      'orCancel': (visitor, target) => D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture').orCancel,
    },
    methods: {
      'whenCompleteOrCancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenCompleteOrCancel');
        if (positional.isEmpty) {
          throw ArgumentError('whenCompleteOrCancel: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.whenCompleteOrCancel(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'asStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture');
        return t.asStream();
      },
      'catchError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'catchError');
        final onError = D4.getRequiredArg<Function>(positional, 0, 'onError', 'catchError');
        final testRaw = named['test'];
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((void p0) { return D4.callInterpreterCallback(visitor, onValueRaw, [null]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onTimeoutRaw, []) as FutureOr<void>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenComplete');
        if (positional.isEmpty) {
          throw ArgumentError('whenComplete: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.whenComplete(() { return D4.callInterpreterCallback(visitor, actionRaw, []) as dynamic; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerFuture>(target, 'TickerFuture');
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
    nativeType: $flutter_6.TickerCanceled,
    name: 'TickerCanceled',
    constructors: {
      '': (visitor, positional, named) {
        final ticker = D4.getOptionalArg<$flutter_6.Ticker?>(positional, 0, 'ticker');
        return $flutter_6.TickerCanceled(ticker);
      },
    },
    getters: {
      'ticker': (visitor, target) => D4.validateTarget<$flutter_6.TickerCanceled>(target, 'TickerCanceled').ticker,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.TickerCanceled>(target, 'TickerCanceled');
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

