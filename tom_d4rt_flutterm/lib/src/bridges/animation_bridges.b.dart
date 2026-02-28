// D4rt Bridge - Generated file, do not edit
// Sources: 11 files
// Generated: 2026-02-28T15:11:21.718153

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/animation/animation.dart' as $flutter_1;
import 'package:flutter/src/animation/animation_controller.dart' as $flutter_2;
import 'package:flutter/src/animation/animation_style.dart' as $flutter_3;
import 'package:flutter/src/animation/animations.dart' as $flutter_4;
import 'package:flutter/src/animation/curves.dart' as $flutter_5;
import 'package:flutter/src/animation/listener_helpers.dart' as $flutter_6;
import 'package:flutter/src/animation/tween.dart' as $flutter_7;
import 'package:flutter/src/animation/tween_sequence.dart' as $flutter_8;
import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_9;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_10;
import 'package:flutter/src/physics/simulation.dart' as $flutter_11;
import 'package:flutter/src/physics/spring_simulation.dart' as $flutter_12;
import 'package:flutter/src/physics/tolerance.dart' as $flutter_13;
import 'package:flutter/src/scheduler/ticker.dart' as $flutter_14;

/// Bridge class for flutter_animation module.
class FlutterAnimationBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createTickerProviderBridge(),
      _createTickerFutureBridge(),
      _createTickerCanceledBridge(),
      _createAnimationBridge(),
      _createCurveBridge(),
      _createAnimatableBridge(),
      _createSimulationBridge(),
      _createSpringDescriptionBridge(),
      _createAnimationControllerBridge(),
      _createAnimationStyleBridge(),
      _createAlwaysStoppedAnimationBridge(),
      _createAnimationWithParentMixinBridge(),
      _createProxyAnimationBridge(),
      _createReverseAnimationBridge(),
      _createCurvedAnimationBridge(),
      _createTrainHoppingAnimationBridge(),
      _createCompoundAnimationBridge(),
      _createAnimationMeanBridge(),
      _createAnimationMaxBridge(),
      _createAnimationMinBridge(),
      _createAnimationLazyListenerMixinBridge(),
      _createAnimationEagerListenerMixinBridge(),
      _createAnimationLocalListenersMixinBridge(),
      _createAnimationLocalStatusListenersMixinBridge(),
      _createTweenSequenceBridge(),
      _createFlippedTweenSequenceBridge(),
      _createTweenSequenceItemBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'TickerProvider': 'package:flutter/src/scheduler/ticker.dart',
      'TickerFuture': 'package:flutter/src/scheduler/ticker.dart',
      'TickerCanceled': 'package:flutter/src/scheduler/ticker.dart',
      'Animation': 'package:flutter/src/animation/animation.dart',
      'Curve': 'package:flutter/src/animation/curves.dart',
      'Animatable': 'package:flutter/src/animation/tween.dart',
      'Simulation': 'package:flutter/src/physics/simulation.dart',
      'SpringDescription': 'package:flutter/src/physics/spring_simulation.dart',
      'AnimationController': 'package:flutter/src/animation/animation_controller.dart',
      'AnimationStyle': 'package:flutter/src/animation/animation_style.dart',
      'AlwaysStoppedAnimation': 'package:flutter/src/animation/animations.dart',
      'AnimationWithParentMixin': 'package:flutter/src/animation/animations.dart',
      'ProxyAnimation': 'package:flutter/src/animation/animations.dart',
      'ReverseAnimation': 'package:flutter/src/animation/animations.dart',
      'CurvedAnimation': 'package:flutter/src/animation/animations.dart',
      'TrainHoppingAnimation': 'package:flutter/src/animation/animations.dart',
      'CompoundAnimation': 'package:flutter/src/animation/animations.dart',
      'AnimationMean': 'package:flutter/src/animation/animations.dart',
      'AnimationMax': 'package:flutter/src/animation/animations.dart',
      'AnimationMin': 'package:flutter/src/animation/animations.dart',
      'AnimationLazyListenerMixin': 'package:flutter/src/animation/listener_helpers.dart',
      'AnimationEagerListenerMixin': 'package:flutter/src/animation/listener_helpers.dart',
      'AnimationLocalListenersMixin': 'package:flutter/src/animation/listener_helpers.dart',
      'AnimationLocalStatusListenersMixin': 'package:flutter/src/animation/listener_helpers.dart',
      'TweenSequence': 'package:flutter/src/animation/tween_sequence.dart',
      'FlippedTweenSequence': 'package:flutter/src/animation/tween_sequence.dart',
      'TweenSequenceItem': 'package:flutter/src/animation/tween_sequence.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_2.AnimationBehavior>(
        name: 'AnimationBehavior',
        values: $flutter_2.AnimationBehavior.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'AnimationBehavior': 'package:flutter/src/animation/animation_controller.dart',
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
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('kAlwaysCompleteAnimation', $flutter_4.kAlwaysCompleteAnimation, importPath, sourceUri: 'package:flutter/src/animation/animations.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAlwaysCompleteAnimation": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAlwaysDismissedAnimation', $flutter_4.kAlwaysDismissedAnimation, importPath, sourceUri: 'package:flutter/src/animation/animations.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAlwaysDismissedAnimation": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_animation):\n${errors.join("\n")}');
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
      'package:flutter/src/animation/animation.dart',
      'package:flutter/src/animation/animation_controller.dart',
      'package:flutter/src/animation/animation_style.dart',
      'package:flutter/src/animation/animations.dart',
      'package:flutter/src/animation/curves.dart',
      'package:flutter/src/animation/listener_helpers.dart',
      'package:flutter/src/animation/tween.dart',
      'package:flutter/src/animation/tween_sequence.dart',
      'package:flutter/src/physics/simulation.dart',
      'package:flutter/src/physics/spring_simulation.dart',
      'package:flutter/src/scheduler/ticker.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:flutter/animation.dart';";
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
    'AnimationBehavior',
  ];

}

// =============================================================================
// TickerProvider Bridge
// =============================================================================

BridgedClass _createTickerProviderBridge() {
  return BridgedClass(
    nativeType: $flutter_14.TickerProvider,
    name: 'TickerProvider',
    constructors: {
    },
    methods: {
      'createTicker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerProvider>(target, 'TickerProvider');
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
// TickerFuture Bridge
// =============================================================================

BridgedClass _createTickerFutureBridge() {
  return BridgedClass(
    nativeType: $flutter_14.TickerFuture,
    name: 'TickerFuture',
    constructors: {
      'complete': (visitor, positional, named) {
        return $flutter_14.TickerFuture.complete();
      },
    },
    getters: {
      'orCancel': (visitor, target) => D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture').orCancel,
    },
    methods: {
      'whenCompleteOrCancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenCompleteOrCancel');
        if (positional.isEmpty) {
          throw ArgumentError('whenCompleteOrCancel: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.whenCompleteOrCancel(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'asStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        return t.asStream();
      },
      'catchError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'catchError');
        final onError = D4.getRequiredArg<Function>(positional, 0, 'onError', 'catchError');
        final testRaw = named['test'];
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((void p0) { return D4.callInterpreterCallback(visitor, onValueRaw, [null]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor, onTimeoutRaw, []) as FutureOr<void>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenComplete');
        if (positional.isEmpty) {
          throw ArgumentError('whenComplete: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.whenComplete(() { return D4.callInterpreterCallback(visitor, actionRaw, []) as dynamic; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
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
    nativeType: $flutter_14.TickerCanceled,
    name: 'TickerCanceled',
    constructors: {
      '': (visitor, positional, named) {
        final ticker = D4.getOptionalArg<$flutter_14.Ticker?>(positional, 0, 'ticker');
        return $flutter_14.TickerCanceled(ticker);
      },
    },
    getters: {
      'ticker': (visitor, target) => D4.validateTarget<$flutter_14.TickerCanceled>(target, 'TickerCanceled').ticker,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerCanceled>(target, 'TickerCanceled');
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

// =============================================================================
// Animation Bridge
// =============================================================================

BridgedClass _createAnimationBridge() {
  return BridgedClass(
    nativeType: $flutter_1.Animation,
    name: 'Animation',
    constructors: {
      'fromValueListenable': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animation');
        final listenable = D4.getRequiredArg<$flutter_9.ValueListenable<dynamic>>(positional, 0, 'listenable', 'Animation');
        final transformerRaw = named['transformer'];
        return $flutter_1.Animation.fromValueListenable(listenable, transformer: transformerRaw == null ? null : (dynamic p0) { return D4.callInterpreterCallback(visitor, transformerRaw, [p0]) as dynamic; });
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_1.Animation>(target, 'Animation').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_1.Animation>(target, 'Animation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_1.Animation>(target, 'Animation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_1.Animation>(target, 'Animation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_1.Animation>(target, 'Animation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_1.Animation>(target, 'Animation').isForwardOrCompleted,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        return t.toStringDetails();
      },
    },
    constructorSignatures: {
      'fromValueListenable': 'factory Animation.fromValueListenable(ValueListenable<T> listenable, {ValueListenableTransformer<T>? transformer})',
    },
    methodSignatures: {
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
      'addStatusListener': 'void addStatusListener(AnimationStatusListener listener)',
      'removeStatusListener': 'void removeStatusListener(AnimationStatusListener listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'T get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
    },
  );
}

// =============================================================================
// Curve Bridge
// =============================================================================

BridgedClass _createCurveBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Curve,
    name: 'Curve',
    constructors: {
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.Curve>(target, 'Curve').flipped,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve>(target, 'Curve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve>(target, 'Curve');
        return t.toString();
      },
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
    },
  );
}

// =============================================================================
// Animatable Bridge
// =============================================================================

BridgedClass _createAnimatableBridge() {
  return BridgedClass(
    nativeType: $flutter_7.Animatable,
    name: 'Animatable',
    constructors: {
      'fromCallback': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animatable');
        if (positional.isEmpty) {
          throw ArgumentError('Animatable: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return $flutter_7.Animatable.fromCallback((double p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as dynamic; });
      },
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
    },
    constructorSignatures: {
      'fromCallback': 'const factory Animatable.fromCallback(AnimatableCallback<T> callback)',
    },
    methodSignatures: {
      'transform': 'T transform(double t)',
      'evaluate': 'T evaluate(Animation<double> animation)',
      'animate': 'Animation<T> animate(Animation<double> parent)',
      'chain': 'Animatable<T> chain(Animatable<double> parent)',
    },
  );
}

// =============================================================================
// Simulation Bridge
// =============================================================================

BridgedClass _createSimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_11.Simulation,
    name: 'Simulation',
    constructors: {
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation').tolerance,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation').tolerance = value as $flutter_13.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation');
        return t.toString();
      },
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

// =============================================================================
// SpringDescription Bridge
// =============================================================================

BridgedClass _createSpringDescriptionBridge() {
  return BridgedClass(
    nativeType: $flutter_12.SpringDescription,
    name: 'SpringDescription',
    constructors: {
      '': (visitor, positional, named) {
        final mass = D4.getRequiredNamedArg<double>(named, 'mass', 'SpringDescription');
        final stiffness = D4.getRequiredNamedArg<double>(named, 'stiffness', 'SpringDescription');
        final damping = D4.getRequiredNamedArg<double>(named, 'damping', 'SpringDescription');
        return $flutter_12.SpringDescription(mass: mass, stiffness: stiffness, damping: damping);
      },
      'withDampingRatio': (visitor, positional, named) {
        final mass = D4.getRequiredNamedArg<double>(named, 'mass', 'SpringDescription');
        final stiffness = D4.getRequiredNamedArg<double>(named, 'stiffness', 'SpringDescription');
        final ratio = D4.getNamedArgWithDefault<double>(named, 'ratio', 1.0);
        return $flutter_12.SpringDescription.withDampingRatio(mass: mass, stiffness: stiffness, ratio: ratio);
      },
      'withDurationAndBounce': (visitor, positional, named) {
        final duration = D4.getNamedArgWithDefault<Duration>(named, 'duration', const Duration(milliseconds: 500));
        final bounce = D4.getNamedArgWithDefault<double>(named, 'bounce', 0.0);
        return $flutter_12.SpringDescription.withDurationAndBounce(duration: duration, bounce: bounce);
      },
    },
    getters: {
      'mass': (visitor, target) => D4.validateTarget<$flutter_12.SpringDescription>(target, 'SpringDescription').mass,
      'stiffness': (visitor, target) => D4.validateTarget<$flutter_12.SpringDescription>(target, 'SpringDescription').stiffness,
      'damping': (visitor, target) => D4.validateTarget<$flutter_12.SpringDescription>(target, 'SpringDescription').damping,
      'duration': (visitor, target) => D4.validateTarget<$flutter_12.SpringDescription>(target, 'SpringDescription').duration,
      'bounce': (visitor, target) => D4.validateTarget<$flutter_12.SpringDescription>(target, 'SpringDescription').bounce,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.SpringDescription>(target, 'SpringDescription');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const SpringDescription({required double mass, required double stiffness, required double damping})',
      'withDampingRatio': 'SpringDescription.withDampingRatio({required double mass, required double stiffness, double ratio = 1.0})',
      'withDurationAndBounce': 'factory SpringDescription.withDurationAndBounce({Duration duration = const Duration(milliseconds: 500), double bounce = 0.0})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'mass': 'double get mass',
      'stiffness': 'double get stiffness',
      'damping': 'double get damping',
      'duration': 'Duration get duration',
      'bounce': 'double get bounce',
    },
  );
}

// =============================================================================
// AnimationController Bridge
// =============================================================================

BridgedClass _createAnimationControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_2.AnimationController,
    name: 'AnimationController',
    constructors: {
      '': (visitor, positional, named) {
        final value = D4.getOptionalNamedArg<double?>(named, 'value');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseDuration = D4.getOptionalNamedArg<Duration?>(named, 'reverseDuration');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final lowerBound = D4.getNamedArgWithDefault<double>(named, 'lowerBound', 0.0);
        final upperBound = D4.getNamedArgWithDefault<double>(named, 'upperBound', 1.0);
        final animationBehavior = D4.getNamedArgWithDefault<$flutter_2.AnimationBehavior>(named, 'animationBehavior', $flutter_2.AnimationBehavior.normal);
        final vsync = D4.getRequiredNamedArg<$flutter_14.TickerProvider>(named, 'vsync', 'AnimationController');
        return $flutter_2.AnimationController(value: value, duration: duration, reverseDuration: reverseDuration, debugLabel: debugLabel, lowerBound: lowerBound, upperBound: upperBound, animationBehavior: animationBehavior, vsync: vsync);
      },
      'unbounded': (visitor, positional, named) {
        final value = D4.getNamedArgWithDefault<double>(named, 'value', 0.0);
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseDuration = D4.getOptionalNamedArg<Duration?>(named, 'reverseDuration');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final vsync = D4.getRequiredNamedArg<$flutter_14.TickerProvider>(named, 'vsync', 'AnimationController');
        final animationBehavior = D4.getNamedArgWithDefault<$flutter_2.AnimationBehavior>(named, 'animationBehavior', $flutter_2.AnimationBehavior.preserve);
        return $flutter_2.AnimationController.unbounded(value: value, duration: duration, reverseDuration: reverseDuration, debugLabel: debugLabel, vsync: vsync, animationBehavior: animationBehavior);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').isForwardOrCompleted,
      'lowerBound': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').lowerBound,
      'upperBound': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').upperBound,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').debugLabel,
      'animationBehavior': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').animationBehavior,
      'view': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').view,
      'duration': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').duration,
      'reverseDuration': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').reverseDuration,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').velocity,
      'lastElapsedDuration': (visitor, target) => D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').lastElapsedDuration,
    },
    setters: {
      'duration': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').duration = value as Duration?,
      'reverseDuration': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').reverseDuration = value as Duration?,
      'value': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').value = value as dynamic,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        return t.toStringDetails();
      },
      'resync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'resync');
        final vsync = D4.getRequiredArg<$flutter_14.TickerProvider>(positional, 0, 'vsync', 'resync');
        t.resync(vsync);
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        t.reset();
        return null;
      },
      'forward': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        final from = D4.getOptionalNamedArg<double?>(named, 'from');
        return t.forward(from: from);
      },
      'reverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        final from = D4.getOptionalNamedArg<double?>(named, 'from');
        return t.reverse(from: from);
      },
      'toggle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        final from = D4.getOptionalNamedArg<double?>(named, 'from');
        return t.toggle(from: from);
      },
      'animateTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateTo');
        final target_ = D4.getRequiredArg<double>(positional, 0, 'target', 'animateTo');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final curve = D4.getNamedArgWithDefault<$flutter_5.Curve>(named, 'curve', $flutter_5.Curves.linear);
        return t.animateTo(target_, duration: duration, curve: curve);
      },
      'animateBack': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateBack');
        final target_ = D4.getRequiredArg<double>(positional, 0, 'target', 'animateBack');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final curve = D4.getNamedArgWithDefault<$flutter_5.Curve>(named, 'curve', $flutter_5.Curves.linear);
        return t.animateBack(target_, duration: duration, curve: curve);
      },
      'repeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        final min = D4.getOptionalNamedArg<double?>(named, 'min');
        final max = D4.getOptionalNamedArg<double?>(named, 'max');
        final reverse = D4.getNamedArgWithDefault<bool>(named, 'reverse', false);
        final period = D4.getOptionalNamedArg<Duration?>(named, 'period');
        final count = D4.getOptionalNamedArg<int?>(named, 'count');
        return t.repeat(min: min, max: max, reverse: reverse, period: period, count: count);
      },
      'fling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        final velocity = D4.getNamedArgWithDefault<double>(named, 'velocity', 1.0);
        final springDescription = D4.getOptionalNamedArg<$flutter_12.SpringDescription?>(named, 'springDescription');
        final animationBehavior = D4.getOptionalNamedArg<$flutter_2.AnimationBehavior?>(named, 'animationBehavior');
        return t.fling(velocity: velocity, springDescription: springDescription, animationBehavior: animationBehavior);
      },
      'animateWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateWith');
        final simulation = D4.getRequiredArg<$flutter_11.Simulation>(positional, 0, 'simulation', 'animateWith');
        return t.animateWith(simulation);
      },
      'animateBackWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateBackWith');
        final simulation = D4.getRequiredArg<$flutter_11.Simulation>(positional, 0, 'simulation', 'animateBackWith');
        return t.animateBackWith(simulation);
      },
      'stop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        final canceled = D4.getNamedArgWithDefault<bool>(named, 'canceled', true);
        t.stop(canceled: canceled);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        (t as dynamic).dispose();
        return null;
      },
    },
    constructorSignatures: {
      '': 'AnimationController({double? value, Duration? duration, Duration? reverseDuration, String? debugLabel, double lowerBound = 0.0, double upperBound = 1.0, AnimationBehavior animationBehavior = AnimationBehavior.normal, required TickerProvider vsync})',
      'unbounded': 'AnimationController.unbounded({double value = 0.0, Duration? duration, Duration? reverseDuration, String? debugLabel, required TickerProvider vsync, AnimationBehavior animationBehavior = AnimationBehavior.preserve})',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
      'resync': 'void resync(TickerProvider vsync)',
      'reset': 'void reset()',
      'forward': 'TickerFuture forward({double? from})',
      'reverse': 'TickerFuture reverse({double? from})',
      'toggle': 'TickerFuture toggle({double? from})',
      'animateTo': 'TickerFuture animateTo(double target, {Duration? duration, Curve curve = Curves.linear})',
      'animateBack': 'TickerFuture animateBack(double target, {Duration? duration, Curve curve = Curves.linear})',
      'repeat': 'TickerFuture repeat({double? min, double? max, bool reverse = false, Duration? period, int? count})',
      'fling': 'TickerFuture fling({double velocity = 1.0, SpringDescription? springDescription, AnimationBehavior? animationBehavior})',
      'animateWith': 'TickerFuture animateWith(Simulation simulation)',
      'animateBackWith': 'TickerFuture animateBackWith(Simulation simulation)',
      'stop': 'void stop({bool canceled = true})',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'double get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'lowerBound': 'double get lowerBound',
      'upperBound': 'double get upperBound',
      'debugLabel': 'String? get debugLabel',
      'animationBehavior': 'AnimationBehavior get animationBehavior',
      'view': 'Animation<double> get view',
      'duration': 'Duration? get duration',
      'reverseDuration': 'Duration? get reverseDuration',
      'velocity': 'double get velocity',
      'lastElapsedDuration': 'Duration? get lastElapsedDuration',
    },
    setterSignatures: {
      'duration': 'set duration(dynamic value)',
      'reverseDuration': 'set reverseDuration(dynamic value)',
      'value': 'set value(double value)',
    },
  );
}

// =============================================================================
// AnimationStyle Bridge
// =============================================================================

BridgedClass _createAnimationStyleBridge() {
  return BridgedClass(
    nativeType: $flutter_3.AnimationStyle,
    name: 'AnimationStyle',
    constructors: {
      '': (visitor, positional, named) {
        final curve = D4.getOptionalNamedArg<$flutter_5.Curve?>(named, 'curve');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseCurve = D4.getOptionalNamedArg<$flutter_5.Curve?>(named, 'reverseCurve');
        final reverseDuration = D4.getOptionalNamedArg<Duration?>(named, 'reverseDuration');
        return $flutter_3.AnimationStyle(curve: curve, duration: duration, reverseCurve: reverseCurve, reverseDuration: reverseDuration);
      },
    },
    getters: {
      'curve': (visitor, target) => D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle').curve,
      'duration': (visitor, target) => D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle').duration,
      'reverseCurve': (visitor, target) => D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle').reverseCurve,
      'reverseDuration': (visitor, target) => D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle').reverseDuration,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        final curve = D4.getOptionalNamedArg<$flutter_5.Curve?>(named, 'curve');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseCurve = D4.getOptionalNamedArg<$flutter_5.Curve?>(named, 'reverseCurve');
        final reverseDuration = D4.getOptionalNamedArg<Duration?>(named, 'reverseDuration');
        return t.copyWith(curve: curve, duration: duration, reverseCurve: reverseCurve, reverseDuration: reverseDuration);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_10.DiagnosticLevel>(named, 'minLevel', $flutter_10.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_10.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'noAnimation': (visitor) => $flutter_3.AnimationStyle.noAnimation,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_3.AnimationStyle?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_3.AnimationStyle?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_3.AnimationStyle.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const AnimationStyle({Curve? curve, Duration? duration, Curve? reverseCurve, Duration? reverseDuration})',
    },
    methodSignatures: {
      'copyWith': 'AnimationStyle copyWith({Curve? curve, Duration? duration, Curve? reverseCurve, Duration? reverseDuration})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'curve': 'Curve? get curve',
      'duration': 'Duration? get duration',
      'reverseCurve': 'Curve? get reverseCurve',
      'reverseDuration': 'Duration? get reverseDuration',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'AnimationStyle? lerp(AnimationStyle? a, AnimationStyle? b, double t)',
    },
    staticGetterSignatures: {
      'noAnimation': 'AnimationStyle get noAnimation',
    },
  );
}

// =============================================================================
// AlwaysStoppedAnimation Bridge
// =============================================================================

BridgedClass _createAlwaysStoppedAnimationBridge() {
  return BridgedClass(
    nativeType: $flutter_4.AlwaysStoppedAnimation,
    name: 'AlwaysStoppedAnimation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AlwaysStoppedAnimation');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'AlwaysStoppedAnimation');
        return $flutter_4.AlwaysStoppedAnimation(value);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isForwardOrCompleted,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        return t.toStringDetails();
      },
    },
    constructorSignatures: {
      '': 'const AlwaysStoppedAnimation(T value)',
    },
    methodSignatures: {
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
      'addStatusListener': 'void addStatusListener(AnimationStatusListener listener)',
      'removeStatusListener': 'void removeStatusListener(AnimationStatusListener listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'T get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
    },
  );
}

// =============================================================================
// AnimationWithParentMixin Bridge
// =============================================================================

BridgedClass _createAnimationWithParentMixinBridge() {
  return BridgedClass(
    nativeType: $flutter_4.AnimationWithParentMixin,
    name: 'AnimationWithParentMixin',
    constructors: {
    },
    getters: {
      'parent': (visitor, target) => D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin').parent,
      'status': (visitor, target) => D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin').status,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
    },
    methodSignatures: {
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
      'addStatusListener': 'void addStatusListener(AnimationStatusListener listener)',
      'removeStatusListener': 'void removeStatusListener(AnimationStatusListener listener)',
    },
    getterSignatures: {
      'parent': 'Animation<T> get parent',
      'status': 'AnimationStatus get status',
    },
  );
}

// =============================================================================
// ProxyAnimation Bridge
// =============================================================================

BridgedClass _createProxyAnimationBridge() {
  return BridgedClass(
    nativeType: $flutter_4.ProxyAnimation,
    name: 'ProxyAnimation',
    constructors: {
      '': (visitor, positional, named) {
        final animation = D4.getOptionalArg<$flutter_1.Animation<double>?>(positional, 0, 'animation');
        return $flutter_4.ProxyAnimation(animation);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').isForwardOrCompleted,
      'parent': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').parent,
      'isListening': (visitor, target) => D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').isListening,
    },
    setters: {
      'parent': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').parent = value as dynamic,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        return t.toStringDetails();
      },
    },
    constructorSignatures: {
      '': 'ProxyAnimation([Animation<double>? animation])',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'double get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'parent': 'Animation<double>? get parent',
      'isListening': 'bool get isListening',
    },
    setterSignatures: {
      'parent': 'set parent(Animation<double>? value)',
    },
  );
}

// =============================================================================
// ReverseAnimation Bridge
// =============================================================================

BridgedClass _createReverseAnimationBridge() {
  return BridgedClass(
    nativeType: $flutter_4.ReverseAnimation,
    name: 'ReverseAnimation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReverseAnimation');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'ReverseAnimation');
        return $flutter_4.ReverseAnimation(parent);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').isForwardOrCompleted,
      'parent': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').parent,
      'isListening': (visitor, target) => D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        return t.toStringDetails();
      },
    },
    constructorSignatures: {
      '': 'ReverseAnimation(Animation<double> parent)',
    },
    methodSignatures: {
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'double get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'parent': 'Animation<double> get parent',
      'isListening': 'bool get isListening',
    },
  );
}

// =============================================================================
// CurvedAnimation Bridge
// =============================================================================

BridgedClass _createCurvedAnimationBridge() {
  return BridgedClass(
    nativeType: $flutter_4.CurvedAnimation,
    name: 'CurvedAnimation',
    constructors: {
      '': (visitor, positional, named) {
        final parent = D4.getRequiredNamedArg<$flutter_1.Animation<double>>(named, 'parent', 'CurvedAnimation');
        final curve = D4.getRequiredNamedArg<$flutter_5.Curve>(named, 'curve', 'CurvedAnimation');
        final reverseCurve = D4.getOptionalNamedArg<$flutter_5.Curve?>(named, 'reverseCurve');
        return $flutter_4.CurvedAnimation(parent: parent, curve: curve, reverseCurve: reverseCurve);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').isForwardOrCompleted,
      'parent': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').parent,
      'curve': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').curve,
      'reverseCurve': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').reverseCurve,
      'isDisposed': (visitor, target) => D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').isDisposed,
    },
    setters: {
      'curve': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').curve = value as $flutter_5.Curve,
      'reverseCurve': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').reverseCurve = value as $flutter_5.Curve?,
      'isDisposed': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').isDisposed = value as bool,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        return t.toStringDetails();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        (t as dynamic).dispose();
        return null;
      },
    },
    constructorSignatures: {
      '': 'CurvedAnimation({required Animation<double> parent, required Curve curve, Curve? reverseCurve})',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'double get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'parent': 'Animation<double> get parent',
      'curve': 'Curve get curve',
      'reverseCurve': 'Curve? get reverseCurve',
      'isDisposed': 'bool get isDisposed',
    },
    setterSignatures: {
      'curve': 'set curve(dynamic value)',
      'reverseCurve': 'set reverseCurve(dynamic value)',
      'isDisposed': 'set isDisposed(dynamic value)',
    },
  );
}

// =============================================================================
// TrainHoppingAnimation Bridge
// =============================================================================

BridgedClass _createTrainHoppingAnimationBridge() {
  return BridgedClass(
    nativeType: $flutter_4.TrainHoppingAnimation,
    name: 'TrainHoppingAnimation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TrainHoppingAnimation');
        final currentTrain = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, '_currentTrain', 'TrainHoppingAnimation');
        final nextTrain = D4.getRequiredArg<$flutter_1.Animation<double>?>(positional, 1, '_nextTrain', 'TrainHoppingAnimation');
        final onSwitchedTrainRaw = named['onSwitchedTrain'];
        return $flutter_4.TrainHoppingAnimation(currentTrain, nextTrain, onSwitchedTrain: onSwitchedTrainRaw == null ? null : () { D4.callInterpreterCallback(visitor, onSwitchedTrainRaw, []); });
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isForwardOrCompleted,
      'currentTrain': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').currentTrain,
      'onSwitchedTrain': (visitor, target) => D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').onSwitchedTrain,
    },
    setters: {
      'onSwitchedTrain': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').onSwitchedTrain = value as dynamic,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        return t.toStringDetails();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        (t as dynamic).dispose();
        return null;
      },
    },
    constructorSignatures: {
      '': 'TrainHoppingAnimation(Animation<double> _currentTrain, Animation<double>? _nextTrain, {void Function()? onSwitchedTrain})',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'double get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'currentTrain': 'Animation<double>? get currentTrain',
      'onSwitchedTrain': 'VoidCallback? get onSwitchedTrain',
    },
    setterSignatures: {
      'onSwitchedTrain': 'set onSwitchedTrain(dynamic value)',
    },
  );
}

// =============================================================================
// CompoundAnimation Bridge
// =============================================================================

BridgedClass _createCompoundAnimationBridge() {
  return BridgedClass(
    nativeType: $flutter_4.CompoundAnimation,
    name: 'CompoundAnimation',
    constructors: {
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').first,
      'next': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').next,
      'isListening': (visitor, target) => D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        return t.toStringDetails();
      },
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'T get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'first': 'Animation<T> get first',
      'next': 'Animation<T> get next',
      'isListening': 'bool get isListening',
    },
  );
}

// =============================================================================
// AnimationMean Bridge
// =============================================================================

BridgedClass _createAnimationMeanBridge() {
  return BridgedClass(
    nativeType: $flutter_4.AnimationMean,
    name: 'AnimationMean',
    constructors: {
      '': (visitor, positional, named) {
        final left = D4.getRequiredNamedArg<$flutter_1.Animation<double>>(named, 'left', 'AnimationMean');
        final right = D4.getRequiredNamedArg<$flutter_1.Animation<double>>(named, 'right', 'AnimationMean');
        return $flutter_4.AnimationMean(left: left, right: right);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').first,
      'next': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').next,
      'isListening': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        t.didStopListening();
        return null;
      },
    },
    constructorSignatures: {
      '': 'AnimationMean({required Animation<double> left, required Animation<double> right})',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
      'didStartListening': 'void didStartListening()',
      'didStopListening': 'void didStopListening()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'double get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'first': 'Animation<double> get first',
      'next': 'Animation<double> get next',
      'isListening': 'bool get isListening',
    },
  );
}

// =============================================================================
// AnimationMax Bridge
// =============================================================================

BridgedClass _createAnimationMaxBridge() {
  return BridgedClass(
    nativeType: $flutter_4.AnimationMax,
    name: 'AnimationMax',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AnimationMax');
        final first = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 0, 'first', 'AnimationMax');
        final next = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 1, 'next', 'AnimationMax');
        return $flutter_4.AnimationMax(first, next);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').first,
      'next': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').next,
      'isListening': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        t.didStopListening();
        return null;
      },
    },
    constructorSignatures: {
      '': 'AnimationMax(Animation<T> first, Animation<T> next)',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
      'didStartListening': 'void didStartListening()',
      'didStopListening': 'void didStopListening()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'T get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'first': 'Animation<T> get first',
      'next': 'Animation<T> get next',
      'isListening': 'bool get isListening',
    },
  );
}

// =============================================================================
// AnimationMin Bridge
// =============================================================================

BridgedClass _createAnimationMinBridge() {
  return BridgedClass(
    nativeType: $flutter_4.AnimationMin,
    name: 'AnimationMin',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AnimationMin');
        final first = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 0, 'first', 'AnimationMin');
        final next = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 1, 'next', 'AnimationMin');
        return $flutter_4.AnimationMin(first, next);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').status,
      'value': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').value,
      'isDismissed': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').first,
      'next': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').next,
      'isListening': (visitor, target) => D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_7.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        t.didStopListening();
        return null;
      },
    },
    constructorSignatures: {
      '': 'AnimationMin(Animation<T> first, Animation<T> next)',
    },
    methodSignatures: {
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
      'addStatusListener': 'void addStatusListener(void Function(AnimationStatus) listener)',
      'removeStatusListener': 'void removeStatusListener(void Function(AnimationStatus) listener)',
      'drive': 'Animation<U> drive(Animatable<U> child)',
      'toString': 'String toString()',
      'toStringDetails': 'String toStringDetails()',
      'didStartListening': 'void didStartListening()',
      'didStopListening': 'void didStopListening()',
    },
    getterSignatures: {
      'status': 'AnimationStatus get status',
      'value': 'T get value',
      'isDismissed': 'bool get isDismissed',
      'isCompleted': 'bool get isCompleted',
      'isAnimating': 'bool get isAnimating',
      'isForwardOrCompleted': 'bool get isForwardOrCompleted',
      'first': 'Animation<T> get first',
      'next': 'Animation<T> get next',
      'isListening': 'bool get isListening',
    },
  );
}

// =============================================================================
// AnimationLazyListenerMixin Bridge
// =============================================================================

BridgedClass _createAnimationLazyListenerMixinBridge() {
  return BridgedClass(
    nativeType: $flutter_6.AnimationLazyListenerMixin,
    name: 'AnimationLazyListenerMixin',
    constructors: {
    },
    getters: {
      'isListening': (visitor, target) => D4.validateTarget<$flutter_6.AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin').isListening,
    },
    getterSignatures: {
      'isListening': 'bool get isListening',
    },
  );
}

// =============================================================================
// AnimationEagerListenerMixin Bridge
// =============================================================================

BridgedClass _createAnimationEagerListenerMixinBridge() {
  return BridgedClass(
    nativeType: $flutter_6.AnimationEagerListenerMixin,
    name: 'AnimationEagerListenerMixin',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationEagerListenerMixin>(target, 'AnimationEagerListenerMixin');
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
// AnimationLocalListenersMixin Bridge
// =============================================================================

BridgedClass _createAnimationLocalListenersMixinBridge() {
  return BridgedClass(
    nativeType: $flutter_6.AnimationLocalListenersMixin,
    name: 'AnimationLocalListenersMixin',
    constructors: {
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
    },
    methodSignatures: {
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
    },
  );
}

// =============================================================================
// AnimationLocalStatusListenersMixin Bridge
// =============================================================================

BridgedClass _createAnimationLocalStatusListenersMixinBridge() {
  return BridgedClass(
    nativeType: $flutter_6.AnimationLocalStatusListenersMixin,
    name: 'AnimationLocalStatusListenersMixin',
    constructors: {
    },
    methods: {
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
    },
    methodSignatures: {
      'addStatusListener': 'void addStatusListener(AnimationStatusListener listener)',
      'removeStatusListener': 'void removeStatusListener(AnimationStatusListener listener)',
    },
  );
}

// =============================================================================
// TweenSequence Bridge
// =============================================================================

BridgedClass _createTweenSequenceBridge() {
  return BridgedClass(
    nativeType: $flutter_8.TweenSequence,
    name: 'TweenSequence',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TweenSequence');
        if (positional.isEmpty) {
          throw ArgumentError('TweenSequence: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<$flutter_8.TweenSequenceItem<dynamic>>(positional[0], 'items');
        return $flutter_8.TweenSequence(items);
      },
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TweenSequence>(target, 'TweenSequence');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TweenSequence(List<TweenSequenceItem<T>> items)',
    },
    methodSignatures: {
      'transform': 'T transform(double t)',
      'evaluate': 'T evaluate(Animation<double> animation)',
      'animate': 'Animation<T> animate(Animation<double> parent)',
      'chain': 'Animatable<T> chain(Animatable<double> parent)',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// FlippedTweenSequence Bridge
// =============================================================================

BridgedClass _createFlippedTweenSequenceBridge() {
  return BridgedClass(
    nativeType: $flutter_8.FlippedTweenSequence,
    name: 'FlippedTweenSequence',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlippedTweenSequence');
        if (positional.isEmpty) {
          throw ArgumentError('FlippedTweenSequence: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<$flutter_8.TweenSequenceItem<double>>(positional[0], 'items');
        return $flutter_8.FlippedTweenSequence(items);
      },
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FlippedTweenSequence>(target, 'FlippedTweenSequence');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'FlippedTweenSequence(List<TweenSequenceItem<double>> items)',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'evaluate': 'double evaluate(Animation<double> animation)',
      'animate': 'Animation<double> animate(Animation<double> parent)',
      'chain': 'Animatable<double> chain(Animatable<double> parent)',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// TweenSequenceItem Bridge
// =============================================================================

BridgedClass _createTweenSequenceItemBridge() {
  return BridgedClass(
    nativeType: $flutter_8.TweenSequenceItem,
    name: 'TweenSequenceItem',
    constructors: {
      '': (visitor, positional, named) {
        final tween = D4.getRequiredNamedArg<$flutter_7.Animatable<dynamic>>(named, 'tween', 'TweenSequenceItem');
        final weight = D4.getRequiredNamedArg<double>(named, 'weight', 'TweenSequenceItem');
        return $flutter_8.TweenSequenceItem(tween: tween, weight: weight);
      },
    },
    getters: {
      'tween': (visitor, target) => D4.validateTarget<$flutter_8.TweenSequenceItem>(target, 'TweenSequenceItem').tween,
      'weight': (visitor, target) => D4.validateTarget<$flutter_8.TweenSequenceItem>(target, 'TweenSequenceItem').weight,
    },
    constructorSignatures: {
      '': 'const TweenSequenceItem({required Animatable<T> tween, required double weight})',
    },
    getterSignatures: {
      'tween': 'Animatable<T> get tween',
      'weight': 'double get weight',
    },
  );
}

