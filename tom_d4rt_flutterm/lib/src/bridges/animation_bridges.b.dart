// D4rt Bridge - Generated file, do not edit
// Sources: 11 files
// Generated: 2026-03-08T21:02:05.871445

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
import 'package:flutter/cupertino.dart' as $aux_flutter;

/// Bridge class for flutter_animation module.
class FlutterAnimationBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createTickerProviderBridge(),
      _createTickerFutureBridge(),
      _createTickerCanceledBridge(),
      _createAnimationBridge(),
      _createParametricCurveBridge(),
      _createCurveBridge(),
      _createSawToothBridge(),
      _createIntervalBridge(),
      _createSplitBridge(),
      _createThresholdBridge(),
      _createCubicBridge(),
      _createThreePointCubicBridge(),
      _createCurve2DBridge(),
      _createCurve2DSampleBridge(),
      _createCatmullRomSplineBridge(),
      _createCatmullRomCurveBridge(),
      _createFlippedCurveBridge(),
      _createElasticInCurveBridge(),
      _createElasticOutCurveBridge(),
      _createElasticInOutCurveBridge(),
      _createCurvesBridge(),
      _createAnimatableBridge(),
      _createTweenBridge(),
      _createReverseTweenBridge(),
      _createColorTweenBridge(),
      _createSizeTweenBridge(),
      _createRectTweenBridge(),
      _createIntTweenBridge(),
      _createStepTweenBridge(),
      _createConstantTweenBridge(),
      _createCurveTweenBridge(),
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
      'ParametricCurve': 'package:flutter/src/animation/curves.dart',
      'Curve': 'package:flutter/src/animation/curves.dart',
      'SawTooth': 'package:flutter/src/animation/curves.dart',
      'Interval': 'package:flutter/src/animation/curves.dart',
      'Split': 'package:flutter/src/animation/curves.dart',
      'Threshold': 'package:flutter/src/animation/curves.dart',
      'Cubic': 'package:flutter/src/animation/curves.dart',
      'ThreePointCubic': 'package:flutter/src/animation/curves.dart',
      'Curve2D': 'package:flutter/src/animation/curves.dart',
      'Curve2DSample': 'package:flutter/src/animation/curves.dart',
      'CatmullRomSpline': 'package:flutter/src/animation/curves.dart',
      'CatmullRomCurve': 'package:flutter/src/animation/curves.dart',
      'FlippedCurve': 'package:flutter/src/animation/curves.dart',
      'ElasticInCurve': 'package:flutter/src/animation/curves.dart',
      'ElasticOutCurve': 'package:flutter/src/animation/curves.dart',
      'ElasticInOutCurve': 'package:flutter/src/animation/curves.dart',
      'Curves': 'package:flutter/src/animation/curves.dart',
      'Animatable': 'package:flutter/src/animation/tween.dart',
      'Tween': 'package:flutter/src/animation/tween.dart',
      'ReverseTween': 'package:flutter/src/animation/tween.dart',
      'ColorTween': 'package:flutter/src/animation/tween.dart',
      'SizeTween': 'package:flutter/src/animation/tween.dart',
      'RectTween': 'package:flutter/src/animation/tween.dart',
      'IntTween': 'package:flutter/src/animation/tween.dart',
      'StepTween': 'package:flutter/src/animation/tween.dart',
      'ConstantTween': 'package:flutter/src/animation/tween.dart',
      'CurveTween': 'package:flutter/src/animation/tween.dart',
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
      'AnimationStatusListener',
      'ValueListenableTransformer',
      'AnimatableCallback',
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_1.AnimationStatus>(
        name: 'AnimationStatus',
        values: $flutter_1.AnimationStatus.values,
        getters: {
          'isDismissed': (visitor, target) => (target as $flutter_1.AnimationStatus).isDismissed,
          'isCompleted': (visitor, target) => (target as $flutter_1.AnimationStatus).isCompleted,
          'isAnimating': (visitor, target) => (target as $flutter_1.AnimationStatus).isAnimating,
          'isForwardOrCompleted': (visitor, target) => (target as $flutter_1.AnimationStatus).isForwardOrCompleted,
        },
      ),
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
      'AnimationStatus': 'package:flutter/src/animation/animation.dart',
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
    'AnimationStatus',
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
    isAssignable: (v) => v is $flutter_14.TickerProvider,
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
        return t.createTicker((Duration p0) { D4.callInterpreterCallback(visitor!, onTickRaw, [p0]); });
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
    isAssignable: (v) => v is $flutter_14.TickerFuture,
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
        t.whenCompleteOrCancel(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
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
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((void p0) { return D4.callInterpreterCallback(visitor!, onValueRaw, [null]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, onTimeoutRaw, []) as FutureOr<void>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenComplete');
        if (positional.isEmpty) {
          throw ArgumentError('whenComplete: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.whenComplete(() { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, actionRaw, [])); });
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
    isAssignable: (v) => v is $flutter_14.TickerCanceled,
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
    isAssignable: (v) => v is $flutter_1.Animation,
    constructors: {
      'fromValueListenable': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animation');
        final listenable = D4.getRequiredArg<$flutter_9.ValueListenable<dynamic>>(positional, 0, 'listenable', 'Animation');
        final transformerRaw = named['transformer'];
        return $flutter_1.Animation.fromValueListenable(listenable, transformer: transformerRaw == null ? null : (dynamic p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, transformerRaw, [p0])); });
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.Animation>(target, 'Animation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
// ParametricCurve Bridge
// =============================================================================

BridgedClass _createParametricCurveBridge() {
  return BridgedClass(
    nativeType: $flutter_5.ParametricCurve,
    name: 'ParametricCurve',
    isAssignable: (v) => v is $flutter_5.ParametricCurve,
    constructors: {
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ParametricCurve>(target, 'ParametricCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ParametricCurve>(target, 'ParametricCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ParametricCurve>(target, 'ParametricCurve');
        return t.toString();
      },
    },
    methodSignatures: {
      'transform': 'T transform(double t)',
      'transformInternal': 'T transformInternal(double t)',
      'toString': 'String toString()',
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
    isAssignable: (v) => v is $flutter_5.Curve,
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
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve>(target, 'Curve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve>(target, 'Curve');
        return t.toString();
      },
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
    },
  );
}

// =============================================================================
// SawTooth Bridge
// =============================================================================

BridgedClass _createSawToothBridge() {
  return BridgedClass(
    nativeType: $flutter_5.SawTooth,
    name: 'SawTooth',
    isAssignable: (v) => v is $flutter_5.SawTooth,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SawTooth');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'SawTooth');
        return $flutter_5.SawTooth(count);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.SawTooth>(target, 'SawTooth').flipped,
      'count': (visitor, target) => D4.validateTarget<$flutter_5.SawTooth>(target, 'SawTooth').count,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SawTooth>(target, 'SawTooth');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SawTooth>(target, 'SawTooth');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SawTooth>(target, 'SawTooth');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const SawTooth(int count)',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'count': 'int get count',
    },
  );
}

// =============================================================================
// Interval Bridge
// =============================================================================

BridgedClass _createIntervalBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Interval,
    name: 'Interval',
    isAssignable: (v) => v is $flutter_5.Interval,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Interval');
        final begin = D4.getRequiredArg<double>(positional, 0, 'begin', 'Interval');
        final end = D4.getRequiredArg<double>(positional, 1, 'end', 'Interval');
        final curve = D4.getNamedArgWithDefault<$flutter_5.Curve>(named, 'curve', $aux_flutter.Curves.linear);
        return $flutter_5.Interval(begin, end, curve: curve);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.Interval>(target, 'Interval').flipped,
      'begin': (visitor, target) => D4.validateTarget<$flutter_5.Interval>(target, 'Interval').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_5.Interval>(target, 'Interval').end,
      'curve': (visitor, target) => D4.validateTarget<$flutter_5.Interval>(target, 'Interval').curve,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Interval>(target, 'Interval');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Interval>(target, 'Interval');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Interval>(target, 'Interval');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Interval(double begin, double end, {Curve curve = Curves.linear})',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'begin': 'double get begin',
      'end': 'double get end',
      'curve': 'Curve get curve',
    },
  );
}

// =============================================================================
// Split Bridge
// =============================================================================

BridgedClass _createSplitBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Split,
    name: 'Split',
    isAssignable: (v) => v is $flutter_5.Split,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Split');
        final split = D4.getRequiredArg<double>(positional, 0, 'split', 'Split');
        final beginCurve = D4.getNamedArgWithDefault<$flutter_5.Curve>(named, 'beginCurve', $aux_flutter.Curves.linear);
        final endCurve = D4.getNamedArgWithDefault<$flutter_5.Curve>(named, 'endCurve', $aux_flutter.Curves.easeOutCubic);
        return $flutter_5.Split(split, beginCurve: beginCurve, endCurve: endCurve);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.Split>(target, 'Split').flipped,
      'split': (visitor, target) => D4.validateTarget<$flutter_5.Split>(target, 'Split').split,
      'beginCurve': (visitor, target) => D4.validateTarget<$flutter_5.Split>(target, 'Split').beginCurve,
      'endCurve': (visitor, target) => D4.validateTarget<$flutter_5.Split>(target, 'Split').endCurve,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Split>(target, 'Split');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Split>(target, 'Split');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Split>(target, 'Split');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Split(double split, {Curve beginCurve = Curves.linear, Curve endCurve = Curves.easeOutCubic})',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'split': 'double get split',
      'beginCurve': 'Curve get beginCurve',
      'endCurve': 'Curve get endCurve',
    },
  );
}

// =============================================================================
// Threshold Bridge
// =============================================================================

BridgedClass _createThresholdBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Threshold,
    name: 'Threshold',
    isAssignable: (v) => v is $flutter_5.Threshold,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Threshold');
        final threshold = D4.getRequiredArg<double>(positional, 0, 'threshold', 'Threshold');
        return $flutter_5.Threshold(threshold);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.Threshold>(target, 'Threshold').flipped,
      'threshold': (visitor, target) => D4.validateTarget<$flutter_5.Threshold>(target, 'Threshold').threshold,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Threshold>(target, 'Threshold');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Threshold>(target, 'Threshold');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Threshold>(target, 'Threshold');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Threshold(double threshold)',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'threshold': 'double get threshold',
    },
  );
}

// =============================================================================
// Cubic Bridge
// =============================================================================

BridgedClass _createCubicBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Cubic,
    name: 'Cubic',
    isAssignable: (v) => v is $flutter_5.Cubic,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Cubic');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'Cubic');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'Cubic');
        final c = D4.getRequiredArg<double>(positional, 2, 'c', 'Cubic');
        final d = D4.getRequiredArg<double>(positional, 3, 'd', 'Cubic');
        return $flutter_5.Cubic(a, b, c, d);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic').flipped,
      'a': (visitor, target) => D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic').a,
      'b': (visitor, target) => D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic').b,
      'c': (visitor, target) => D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic').c,
      'd': (visitor, target) => D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic').d,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Cubic>(target, 'Cubic');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Cubic(double a, double b, double c, double d)',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'a': 'double get a',
      'b': 'double get b',
      'c': 'double get c',
      'd': 'double get d',
    },
  );
}

// =============================================================================
// ThreePointCubic Bridge
// =============================================================================

BridgedClass _createThreePointCubicBridge() {
  return BridgedClass(
    nativeType: $flutter_5.ThreePointCubic,
    name: 'ThreePointCubic',
    isAssignable: (v) => v is $flutter_5.ThreePointCubic,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'ThreePointCubic');
        final a1 = D4.getRequiredArg<Offset>(positional, 0, 'a1', 'ThreePointCubic');
        final b1 = D4.getRequiredArg<Offset>(positional, 1, 'b1', 'ThreePointCubic');
        final midpoint = D4.getRequiredArg<Offset>(positional, 2, 'midpoint', 'ThreePointCubic');
        final a2 = D4.getRequiredArg<Offset>(positional, 3, 'a2', 'ThreePointCubic');
        final b2 = D4.getRequiredArg<Offset>(positional, 4, 'b2', 'ThreePointCubic');
        return $flutter_5.ThreePointCubic(a1, b1, midpoint, a2, b2);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic').flipped,
      'a1': (visitor, target) => D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic').a1,
      'b1': (visitor, target) => D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic').b1,
      'midpoint': (visitor, target) => D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic').midpoint,
      'a2': (visitor, target) => D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic').a2,
      'b2': (visitor, target) => D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic').b2,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ThreePointCubic>(target, 'ThreePointCubic');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ThreePointCubic(Offset a1, Offset b1, Offset midpoint, Offset a2, Offset b2)',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'a1': 'Offset get a1',
      'b1': 'Offset get b1',
      'midpoint': 'Offset get midpoint',
      'a2': 'Offset get a2',
      'b2': 'Offset get b2',
    },
  );
}

// =============================================================================
// Curve2D Bridge
// =============================================================================

BridgedClass _createCurve2DBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Curve2D,
    name: 'Curve2D',
    isAssignable: (v) => v is $flutter_5.Curve2D,
    constructors: {
    },
    getters: {
      'samplingSeed': (visitor, target) => D4.validateTarget<$flutter_5.Curve2D>(target, 'Curve2D').samplingSeed,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve2D>(target, 'Curve2D');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve2D>(target, 'Curve2D');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve2D>(target, 'Curve2D');
        return t.toString();
      },
      'generateSamples': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve2D>(target, 'Curve2D');
        final start = D4.getNamedArgWithDefault<double>(named, 'start', 0.0);
        final end = D4.getNamedArgWithDefault<double>(named, 'end', 1.0);
        final tolerance = D4.getNamedArgWithDefault<double>(named, 'tolerance', 1e-10);
        return t.generateSamples(start: start, end: end, tolerance: tolerance);
      },
      'findInverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve2D>(target, 'Curve2D');
        D4.requireMinArgs(positional, 1, 'findInverse');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'findInverse');
        return t.findInverse(x);
      },
    },
    methodSignatures: {
      'transform': 'Offset transform(double t)',
      'transformInternal': 'Offset transformInternal(double t)',
      'toString': 'String toString()',
      'generateSamples': 'Iterable<Curve2DSample> generateSamples({double start = 0.0, double end = 1.0, double tolerance = 1e-10})',
      'findInverse': 'double findInverse(double x)',
    },
    getterSignatures: {
      'samplingSeed': 'int get samplingSeed',
    },
  );
}

// =============================================================================
// Curve2DSample Bridge
// =============================================================================

BridgedClass _createCurve2DSampleBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Curve2DSample,
    name: 'Curve2DSample',
    isAssignable: (v) => v is $flutter_5.Curve2DSample,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Curve2DSample');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'Curve2DSample');
        final value = D4.getRequiredArg<Offset>(positional, 1, 'value', 'Curve2DSample');
        return $flutter_5.Curve2DSample(t_, value);
      },
    },
    getters: {
      't': (visitor, target) => D4.validateTarget<$flutter_5.Curve2DSample>(target, 'Curve2DSample').t,
      'value': (visitor, target) => D4.validateTarget<$flutter_5.Curve2DSample>(target, 'Curve2DSample').value,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Curve2DSample>(target, 'Curve2DSample');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Curve2DSample(double t, Offset value)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      't': 'double get t',
      'value': 'Offset get value',
    },
  );
}

// =============================================================================
// CatmullRomSpline Bridge
// =============================================================================

BridgedClass _createCatmullRomSplineBridge() {
  return BridgedClass(
    nativeType: $flutter_5.CatmullRomSpline,
    name: 'CatmullRomSpline',
    isAssignable: (v) => v is $flutter_5.CatmullRomSpline,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatmullRomSpline');
        if (positional.isEmpty) {
          throw ArgumentError('CatmullRomSpline: Missing required argument "controlPoints" at position 0');
        }
        final controlPoints = D4.coerceList<Offset>(positional[0], 'controlPoints');
        final tension = D4.getNamedArgWithDefault<double>(named, 'tension', 0.0);
        final startHandle = D4.getOptionalNamedArg<Offset?>(named, 'startHandle');
        final endHandle = D4.getOptionalNamedArg<Offset?>(named, 'endHandle');
        return $flutter_5.CatmullRomSpline(controlPoints, tension: tension, startHandle: startHandle, endHandle: endHandle);
      },
      'precompute': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatmullRomSpline');
        if (positional.isEmpty) {
          throw ArgumentError('CatmullRomSpline: Missing required argument "controlPoints" at position 0');
        }
        final controlPoints = D4.coerceList<Offset>(positional[0], 'controlPoints');
        final tension = D4.getNamedArgWithDefault<double>(named, 'tension', 0.0);
        final startHandle = D4.getOptionalNamedArg<Offset?>(named, 'startHandle');
        final endHandle = D4.getOptionalNamedArg<Offset?>(named, 'endHandle');
        return $flutter_5.CatmullRomSpline.precompute(controlPoints, tension: tension, startHandle: startHandle, endHandle: endHandle);
      },
    },
    getters: {
      'samplingSeed': (visitor, target) => D4.validateTarget<$flutter_5.CatmullRomSpline>(target, 'CatmullRomSpline').samplingSeed,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomSpline>(target, 'CatmullRomSpline');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomSpline>(target, 'CatmullRomSpline');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomSpline>(target, 'CatmullRomSpline');
        return t.toString();
      },
      'generateSamples': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomSpline>(target, 'CatmullRomSpline');
        final start = D4.getNamedArgWithDefault<double>(named, 'start', 0.0);
        final end = D4.getNamedArgWithDefault<double>(named, 'end', 1.0);
        final tolerance = D4.getNamedArgWithDefault<double>(named, 'tolerance', 1e-10);
        return t.generateSamples(start: start, end: end, tolerance: tolerance);
      },
      'findInverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomSpline>(target, 'CatmullRomSpline');
        D4.requireMinArgs(positional, 1, 'findInverse');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'findInverse');
        return t.findInverse(x);
      },
    },
    constructorSignatures: {
      '': 'CatmullRomSpline(List<Offset> controlPoints, {double tension = 0.0, Offset? startHandle, Offset? endHandle})',
      'precompute': 'CatmullRomSpline.precompute(List<Offset> controlPoints, {double tension = 0.0, Offset? startHandle, Offset? endHandle})',
    },
    methodSignatures: {
      'transform': 'Offset transform(double t)',
      'transformInternal': 'Offset transformInternal(double t)',
      'toString': 'String toString()',
      'generateSamples': 'Iterable<Curve2DSample> generateSamples({double start = 0.0, double end = 1.0, double tolerance = 1e-10})',
      'findInverse': 'double findInverse(double x)',
    },
    getterSignatures: {
      'samplingSeed': 'int get samplingSeed',
    },
  );
}

// =============================================================================
// CatmullRomCurve Bridge
// =============================================================================

BridgedClass _createCatmullRomCurveBridge() {
  return BridgedClass(
    nativeType: $flutter_5.CatmullRomCurve,
    name: 'CatmullRomCurve',
    isAssignable: (v) => v is $flutter_5.CatmullRomCurve,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatmullRomCurve');
        if (positional.isEmpty) {
          throw ArgumentError('CatmullRomCurve: Missing required argument "controlPoints" at position 0');
        }
        final controlPoints = D4.coerceList<Offset>(positional[0], 'controlPoints');
        final tension = D4.getNamedArgWithDefault<double>(named, 'tension', 0.0);
        return $flutter_5.CatmullRomCurve(controlPoints, tension: tension);
      },
      'precompute': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatmullRomCurve');
        if (positional.isEmpty) {
          throw ArgumentError('CatmullRomCurve: Missing required argument "controlPoints" at position 0');
        }
        final controlPoints = D4.coerceList<Offset>(positional[0], 'controlPoints');
        final tension = D4.getNamedArgWithDefault<double>(named, 'tension', 0.0);
        return $flutter_5.CatmullRomCurve.precompute(controlPoints, tension: tension);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.CatmullRomCurve>(target, 'CatmullRomCurve').flipped,
      'controlPoints': (visitor, target) => D4.validateTarget<$flutter_5.CatmullRomCurve>(target, 'CatmullRomCurve').controlPoints,
      'tension': (visitor, target) => D4.validateTarget<$flutter_5.CatmullRomCurve>(target, 'CatmullRomCurve').tension,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomCurve>(target, 'CatmullRomCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomCurve>(target, 'CatmullRomCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.CatmullRomCurve>(target, 'CatmullRomCurve');
        return t.toString();
      },
    },
    staticMethods: {
      'validateControlPoints': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'validateControlPoints');
        if (positional.isEmpty) {
          throw ArgumentError('validateControlPoints: Missing required argument "controlPoints" at position 0');
        }
        final controlPoints = D4.coerceListOrNull<Offset>(positional[0], 'controlPoints');
        final tension = D4.getNamedArgWithDefault<double>(named, 'tension', 0.0);
        final reasons = D4.coerceListOrNull<String>(named['reasons'], 'reasons');
        return $flutter_5.CatmullRomCurve.validateControlPoints(controlPoints, tension: tension, reasons: reasons);
      },
    },
    constructorSignatures: {
      '': 'CatmullRomCurve(List<Offset> controlPoints, {double tension = 0.0})',
      'precompute': 'CatmullRomCurve.precompute(List<Offset> controlPoints, {double tension = 0.0})',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'controlPoints': 'List<Offset> get controlPoints',
      'tension': 'double get tension',
    },
    staticMethodSignatures: {
      'validateControlPoints': 'bool validateControlPoints(List<Offset>? controlPoints, {double tension = 0.0, List<String>? reasons})',
    },
  );
}

// =============================================================================
// FlippedCurve Bridge
// =============================================================================

BridgedClass _createFlippedCurveBridge() {
  return BridgedClass(
    nativeType: $flutter_5.FlippedCurve,
    name: 'FlippedCurve',
    isAssignable: (v) => v is $flutter_5.FlippedCurve,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlippedCurve');
        final curve = D4.getRequiredArg<$flutter_5.Curve>(positional, 0, 'curve', 'FlippedCurve');
        return $flutter_5.FlippedCurve(curve);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.FlippedCurve>(target, 'FlippedCurve').flipped,
      'curve': (visitor, target) => D4.validateTarget<$flutter_5.FlippedCurve>(target, 'FlippedCurve').curve,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlippedCurve>(target, 'FlippedCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlippedCurve>(target, 'FlippedCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlippedCurve>(target, 'FlippedCurve');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const FlippedCurve(Curve curve)',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'curve': 'Curve get curve',
    },
  );
}

// =============================================================================
// ElasticInCurve Bridge
// =============================================================================

BridgedClass _createElasticInCurveBridge() {
  return BridgedClass(
    nativeType: $flutter_5.ElasticInCurve,
    name: 'ElasticInCurve',
    isAssignable: (v) => v is $flutter_5.ElasticInCurve,
    constructors: {
      '': (visitor, positional, named) {
        final period = D4.getOptionalArgWithDefault<double>(positional, 0, 'period', 0.4);
        return $flutter_5.ElasticInCurve(period);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.ElasticInCurve>(target, 'ElasticInCurve').flipped,
      'period': (visitor, target) => D4.validateTarget<$flutter_5.ElasticInCurve>(target, 'ElasticInCurve').period,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticInCurve>(target, 'ElasticInCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticInCurve>(target, 'ElasticInCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticInCurve>(target, 'ElasticInCurve');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ElasticInCurve([double period = 0.4])',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'period': 'double get period',
    },
  );
}

// =============================================================================
// ElasticOutCurve Bridge
// =============================================================================

BridgedClass _createElasticOutCurveBridge() {
  return BridgedClass(
    nativeType: $flutter_5.ElasticOutCurve,
    name: 'ElasticOutCurve',
    isAssignable: (v) => v is $flutter_5.ElasticOutCurve,
    constructors: {
      '': (visitor, positional, named) {
        final period = D4.getOptionalArgWithDefault<double>(positional, 0, 'period', 0.4);
        return $flutter_5.ElasticOutCurve(period);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.ElasticOutCurve>(target, 'ElasticOutCurve').flipped,
      'period': (visitor, target) => D4.validateTarget<$flutter_5.ElasticOutCurve>(target, 'ElasticOutCurve').period,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticOutCurve>(target, 'ElasticOutCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticOutCurve>(target, 'ElasticOutCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticOutCurve>(target, 'ElasticOutCurve');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ElasticOutCurve([double period = 0.4])',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'period': 'double get period',
    },
  );
}

// =============================================================================
// ElasticInOutCurve Bridge
// =============================================================================

BridgedClass _createElasticInOutCurveBridge() {
  return BridgedClass(
    nativeType: $flutter_5.ElasticInOutCurve,
    name: 'ElasticInOutCurve',
    isAssignable: (v) => v is $flutter_5.ElasticInOutCurve,
    constructors: {
      '': (visitor, positional, named) {
        final period = D4.getOptionalArgWithDefault<double>(positional, 0, 'period', 0.4);
        return $flutter_5.ElasticInOutCurve(period);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$flutter_5.ElasticInOutCurve>(target, 'ElasticInOutCurve').flipped,
      'period': (visitor, target) => D4.validateTarget<$flutter_5.ElasticInOutCurve>(target, 'ElasticInOutCurve').period,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticInOutCurve>(target, 'ElasticInOutCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticInOutCurve>(target, 'ElasticInOutCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ElasticInOutCurve>(target, 'ElasticInOutCurve');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ElasticInOutCurve([double period = 0.4])',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'transformInternal': 'double transformInternal(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'flipped': 'Curve get flipped',
      'period': 'double get period',
    },
  );
}

// =============================================================================
// Curves Bridge
// =============================================================================

BridgedClass _createCurvesBridge() {
  return BridgedClass(
    nativeType: $flutter_5.Curves,
    name: 'Curves',
    isAssignable: (v) => v is $flutter_5.Curves,
    constructors: {
    },
    staticGetters: {
      'linear': (visitor) => $flutter_5.Curves.linear,
      'decelerate': (visitor) => $flutter_5.Curves.decelerate,
      'fastLinearToSlowEaseIn': (visitor) => $flutter_5.Curves.fastLinearToSlowEaseIn,
      'fastEaseInToSlowEaseOut': (visitor) => $flutter_5.Curves.fastEaseInToSlowEaseOut,
      'ease': (visitor) => $flutter_5.Curves.ease,
      'easeIn': (visitor) => $flutter_5.Curves.easeIn,
      'easeInToLinear': (visitor) => $flutter_5.Curves.easeInToLinear,
      'easeInSine': (visitor) => $flutter_5.Curves.easeInSine,
      'easeInQuad': (visitor) => $flutter_5.Curves.easeInQuad,
      'easeInCubic': (visitor) => $flutter_5.Curves.easeInCubic,
      'easeInQuart': (visitor) => $flutter_5.Curves.easeInQuart,
      'easeInQuint': (visitor) => $flutter_5.Curves.easeInQuint,
      'easeInExpo': (visitor) => $flutter_5.Curves.easeInExpo,
      'easeInCirc': (visitor) => $flutter_5.Curves.easeInCirc,
      'easeInBack': (visitor) => $flutter_5.Curves.easeInBack,
      'easeOut': (visitor) => $flutter_5.Curves.easeOut,
      'linearToEaseOut': (visitor) => $flutter_5.Curves.linearToEaseOut,
      'easeOutSine': (visitor) => $flutter_5.Curves.easeOutSine,
      'easeOutQuad': (visitor) => $flutter_5.Curves.easeOutQuad,
      'easeOutCubic': (visitor) => $flutter_5.Curves.easeOutCubic,
      'easeOutQuart': (visitor) => $flutter_5.Curves.easeOutQuart,
      'easeOutQuint': (visitor) => $flutter_5.Curves.easeOutQuint,
      'easeOutExpo': (visitor) => $flutter_5.Curves.easeOutExpo,
      'easeOutCirc': (visitor) => $flutter_5.Curves.easeOutCirc,
      'easeOutBack': (visitor) => $flutter_5.Curves.easeOutBack,
      'easeInOut': (visitor) => $flutter_5.Curves.easeInOut,
      'easeInOutSine': (visitor) => $flutter_5.Curves.easeInOutSine,
      'easeInOutQuad': (visitor) => $flutter_5.Curves.easeInOutQuad,
      'easeInOutCubic': (visitor) => $flutter_5.Curves.easeInOutCubic,
      'easeInOutCubicEmphasized': (visitor) => $flutter_5.Curves.easeInOutCubicEmphasized,
      'easeInOutQuart': (visitor) => $flutter_5.Curves.easeInOutQuart,
      'easeInOutQuint': (visitor) => $flutter_5.Curves.easeInOutQuint,
      'easeInOutExpo': (visitor) => $flutter_5.Curves.easeInOutExpo,
      'easeInOutCirc': (visitor) => $flutter_5.Curves.easeInOutCirc,
      'easeInOutBack': (visitor) => $flutter_5.Curves.easeInOutBack,
      'fastOutSlowIn': (visitor) => $flutter_5.Curves.fastOutSlowIn,
      'slowMiddle': (visitor) => $flutter_5.Curves.slowMiddle,
      'bounceIn': (visitor) => $flutter_5.Curves.bounceIn,
      'bounceOut': (visitor) => $flutter_5.Curves.bounceOut,
      'bounceInOut': (visitor) => $flutter_5.Curves.bounceInOut,
      'elasticIn': (visitor) => $flutter_5.Curves.elasticIn,
      'elasticOut': (visitor) => $flutter_5.Curves.elasticOut,
      'elasticInOut': (visitor) => $flutter_5.Curves.elasticInOut,
    },
    staticGetterSignatures: {
      'linear': 'Curve get linear',
      'decelerate': 'Curve get decelerate',
      'fastLinearToSlowEaseIn': 'Cubic get fastLinearToSlowEaseIn',
      'fastEaseInToSlowEaseOut': 'ThreePointCubic get fastEaseInToSlowEaseOut',
      'ease': 'Cubic get ease',
      'easeIn': 'Cubic get easeIn',
      'easeInToLinear': 'Cubic get easeInToLinear',
      'easeInSine': 'Cubic get easeInSine',
      'easeInQuad': 'Cubic get easeInQuad',
      'easeInCubic': 'Cubic get easeInCubic',
      'easeInQuart': 'Cubic get easeInQuart',
      'easeInQuint': 'Cubic get easeInQuint',
      'easeInExpo': 'Cubic get easeInExpo',
      'easeInCirc': 'Cubic get easeInCirc',
      'easeInBack': 'Cubic get easeInBack',
      'easeOut': 'Cubic get easeOut',
      'linearToEaseOut': 'Cubic get linearToEaseOut',
      'easeOutSine': 'Cubic get easeOutSine',
      'easeOutQuad': 'Cubic get easeOutQuad',
      'easeOutCubic': 'Cubic get easeOutCubic',
      'easeOutQuart': 'Cubic get easeOutQuart',
      'easeOutQuint': 'Cubic get easeOutQuint',
      'easeOutExpo': 'Cubic get easeOutExpo',
      'easeOutCirc': 'Cubic get easeOutCirc',
      'easeOutBack': 'Cubic get easeOutBack',
      'easeInOut': 'Cubic get easeInOut',
      'easeInOutSine': 'Cubic get easeInOutSine',
      'easeInOutQuad': 'Cubic get easeInOutQuad',
      'easeInOutCubic': 'Cubic get easeInOutCubic',
      'easeInOutCubicEmphasized': 'ThreePointCubic get easeInOutCubicEmphasized',
      'easeInOutQuart': 'Cubic get easeInOutQuart',
      'easeInOutQuint': 'Cubic get easeInOutQuint',
      'easeInOutExpo': 'Cubic get easeInOutExpo',
      'easeInOutCirc': 'Cubic get easeInOutCirc',
      'easeInOutBack': 'Cubic get easeInOutBack',
      'fastOutSlowIn': 'Cubic get fastOutSlowIn',
      'slowMiddle': 'Cubic get slowMiddle',
      'bounceIn': 'Curve get bounceIn',
      'bounceOut': 'Curve get bounceOut',
      'bounceInOut': 'Curve get bounceInOut',
      'elasticIn': 'ElasticInCurve get elasticIn',
      'elasticOut': 'ElasticOutCurve get elasticOut',
      'elasticInOut': 'ElasticInOutCurve get elasticInOut',
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
    isAssignable: (v) => v is $flutter_7.Animatable,
    constructors: {
      'fromCallback': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animatable');
        if (positional.isEmpty) {
          throw ArgumentError('Animatable: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return $flutter_7.Animatable.fromCallback((double p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [p0])); });
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
// Tween Bridge
// =============================================================================

BridgedClass _createTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.Tween,
    name: 'Tween',
    isAssignable: (v) => v is $flutter_7.Tween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Object?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Object?>(named, 'end');
        return $flutter_7.Tween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.Tween>(target, 'Tween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.Tween>(target, 'Tween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.Tween>(target, 'Tween').begin = D4.extractBridgedArgOrNull<Object?>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.Tween>(target, 'Tween').end = D4.extractBridgedArgOrNull<Object?>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.Tween>(target, 'Tween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Tween({T? begin, T? end})',
    },
    methodSignatures: {
      'transform': 'T transform(double t)',
      'evaluate': 'T evaluate(Animation<double> animation)',
      'animate': 'Animation<T> animate(Animation<double> parent)',
      'chain': 'Animatable<T> chain(Animatable<double> parent)',
      'lerp': 'T lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'T? get begin',
      'end': 'T? get end',
    },
    setterSignatures: {
      'begin': 'set begin(dynamic value)',
      'end': 'set end(dynamic value)',
    },
  );
}

// =============================================================================
// ReverseTween Bridge
// =============================================================================

BridgedClass _createReverseTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.ReverseTween,
    name: 'ReverseTween',
    isAssignable: (v) => v is $flutter_7.ReverseTween,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReverseTween');
        final parent = D4.getRequiredArg<$flutter_7.Tween<Object?>>(positional, 0, 'parent', 'ReverseTween');
        return $flutter_7.ReverseTween(parent);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween').end,
      'parent': (visitor, target) => D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween').parent,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween').begin = D4.extractBridgedArg<Object?>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween').end = D4.extractBridgedArg<Object?>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ReverseTween>(target, 'ReverseTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ReverseTween(Tween<T> parent)',
    },
    methodSignatures: {
      'transform': 'T transform(double t)',
      'evaluate': 'T evaluate(Animation<double> animation)',
      'animate': 'Animation<T> animate(Animation<double> parent)',
      'chain': 'Animatable<T> chain(Animatable<double> parent)',
      'lerp': 'T lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'T get begin',
      'end': 'T get end',
      'parent': 'Tween<T> get parent',
    },
    setterSignatures: {
      'begin': 'set begin(T value)',
      'end': 'set end(T value)',
    },
  );
}

// =============================================================================
// ColorTween Bridge
// =============================================================================

BridgedClass _createColorTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.ColorTween,
    name: 'ColorTween',
    isAssignable: (v) => v is $flutter_7.ColorTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Color?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Color?>(named, 'end');
        return $flutter_7.ColorTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween').begin = D4.extractBridgedArgOrNull<Color>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween').end = D4.extractBridgedArgOrNull<Color>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ColorTween>(target, 'ColorTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ColorTween({Color? begin, Color? end})',
    },
    methodSignatures: {
      'transform': 'Color? transform(double t)',
      'evaluate': 'Color? evaluate(Animation<double> animation)',
      'animate': 'Animation<Color?> animate(Animation<double> parent)',
      'chain': 'Animatable<Color?> chain(Animatable<double> parent)',
      'lerp': 'Color? lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'Color? get begin',
      'end': 'Color? get end',
    },
    setterSignatures: {
      'begin': 'set begin(Color? value)',
      'end': 'set end(Color? value)',
    },
  );
}

// =============================================================================
// SizeTween Bridge
// =============================================================================

BridgedClass _createSizeTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.SizeTween,
    name: 'SizeTween',
    isAssignable: (v) => v is $flutter_7.SizeTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Size?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Size?>(named, 'end');
        return $flutter_7.SizeTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween').begin = D4.extractBridgedArgOrNull<Size>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween').end = D4.extractBridgedArgOrNull<Size>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SizeTween>(target, 'SizeTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'SizeTween({Size? begin, Size? end})',
    },
    methodSignatures: {
      'transform': 'Size? transform(double t)',
      'evaluate': 'Size? evaluate(Animation<double> animation)',
      'animate': 'Animation<Size?> animate(Animation<double> parent)',
      'chain': 'Animatable<Size?> chain(Animatable<double> parent)',
      'lerp': 'Size? lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'Size? get begin',
      'end': 'Size? get end',
    },
    setterSignatures: {
      'begin': 'set begin(Size? value)',
      'end': 'set end(Size? value)',
    },
  );
}

// =============================================================================
// RectTween Bridge
// =============================================================================

BridgedClass _createRectTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.RectTween,
    name: 'RectTween',
    isAssignable: (v) => v is $flutter_7.RectTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Rect?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Rect?>(named, 'end');
        return $flutter_7.RectTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween').begin = D4.extractBridgedArgOrNull<Rect>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween').end = D4.extractBridgedArgOrNull<Rect>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.RectTween>(target, 'RectTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'RectTween({Rect? begin, Rect? end})',
    },
    methodSignatures: {
      'transform': 'Rect? transform(double t)',
      'evaluate': 'Rect? evaluate(Animation<double> animation)',
      'animate': 'Animation<Rect?> animate(Animation<double> parent)',
      'chain': 'Animatable<Rect?> chain(Animatable<double> parent)',
      'lerp': 'Rect? lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'Rect? get begin',
      'end': 'Rect? get end',
    },
    setterSignatures: {
      'begin': 'set begin(Rect? value)',
      'end': 'set end(Rect? value)',
    },
  );
}

// =============================================================================
// IntTween Bridge
// =============================================================================

BridgedClass _createIntTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.IntTween,
    name: 'IntTween',
    isAssignable: (v) => v is $flutter_7.IntTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<int?>(named, 'begin');
        final end = D4.getOptionalNamedArg<int?>(named, 'end');
        return $flutter_7.IntTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween').begin = D4.extractBridgedArg<int>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween').end = D4.extractBridgedArg<int>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.IntTween>(target, 'IntTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'IntTween({int? begin, int? end})',
    },
    methodSignatures: {
      'transform': 'int transform(double t)',
      'evaluate': 'int evaluate(Animation<double> animation)',
      'animate': 'Animation<int> animate(Animation<double> parent)',
      'chain': 'Animatable<int> chain(Animatable<double> parent)',
      'lerp': 'int lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'int get begin',
      'end': 'int get end',
    },
    setterSignatures: {
      'begin': 'set begin(int value)',
      'end': 'set end(int value)',
    },
  );
}

// =============================================================================
// StepTween Bridge
// =============================================================================

BridgedClass _createStepTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.StepTween,
    name: 'StepTween',
    isAssignable: (v) => v is $flutter_7.StepTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<int?>(named, 'begin');
        final end = D4.getOptionalNamedArg<int?>(named, 'end');
        return $flutter_7.StepTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween').begin = D4.extractBridgedArg<int>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween').end = D4.extractBridgedArg<int>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.StepTween>(target, 'StepTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'StepTween({int? begin, int? end})',
    },
    methodSignatures: {
      'transform': 'int transform(double t)',
      'evaluate': 'int evaluate(Animation<double> animation)',
      'animate': 'Animation<int> animate(Animation<double> parent)',
      'chain': 'Animatable<int> chain(Animatable<double> parent)',
      'lerp': 'int lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'int get begin',
      'end': 'int get end',
    },
    setterSignatures: {
      'begin': 'set begin(int value)',
      'end': 'set end(int value)',
    },
  );
}

// =============================================================================
// ConstantTween Bridge
// =============================================================================

BridgedClass _createConstantTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.ConstantTween,
    name: 'ConstantTween',
    isAssignable: (v) => v is $flutter_7.ConstantTween,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConstantTween');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'ConstantTween');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $flutter_7.ConstantTween<double>(value);
          case int _: return $flutter_7.ConstantTween<int>(value);
          case String _: return $flutter_7.ConstantTween<String>(value);
          case bool _: return $flutter_7.ConstantTween<bool>(value);
          case $flutter_14.TickerProvider _: return $flutter_7.ConstantTween<$flutter_14.TickerProvider>(value);
          case $flutter_14.TickerFuture _: return $flutter_7.ConstantTween<$flutter_14.TickerFuture>(value);
          case $flutter_14.TickerCanceled _: return $flutter_7.ConstantTween<$flutter_14.TickerCanceled>(value);
          case $flutter_1.Animation _: return $flutter_7.ConstantTween<$flutter_1.Animation>(value);
          case $flutter_5.ParametricCurve _: return $flutter_7.ConstantTween<$flutter_5.ParametricCurve>(value);
          case $flutter_5.Curve _: return $flutter_7.ConstantTween<$flutter_5.Curve>(value);
          case $flutter_5.SawTooth _: return $flutter_7.ConstantTween<$flutter_5.SawTooth>(value);
          case $flutter_5.Interval _: return $flutter_7.ConstantTween<$flutter_5.Interval>(value);
          case $flutter_5.Split _: return $flutter_7.ConstantTween<$flutter_5.Split>(value);
          case $flutter_5.Threshold _: return $flutter_7.ConstantTween<$flutter_5.Threshold>(value);
          case $flutter_5.Cubic _: return $flutter_7.ConstantTween<$flutter_5.Cubic>(value);
          case $flutter_5.ThreePointCubic _: return $flutter_7.ConstantTween<$flutter_5.ThreePointCubic>(value);
          case $flutter_5.Curve2D _: return $flutter_7.ConstantTween<$flutter_5.Curve2D>(value);
          case $flutter_5.Curve2DSample _: return $flutter_7.ConstantTween<$flutter_5.Curve2DSample>(value);
          case $flutter_5.CatmullRomSpline _: return $flutter_7.ConstantTween<$flutter_5.CatmullRomSpline>(value);
          case $flutter_5.CatmullRomCurve _: return $flutter_7.ConstantTween<$flutter_5.CatmullRomCurve>(value);
          case $flutter_5.FlippedCurve _: return $flutter_7.ConstantTween<$flutter_5.FlippedCurve>(value);
          case $flutter_5.ElasticInCurve _: return $flutter_7.ConstantTween<$flutter_5.ElasticInCurve>(value);
          case $flutter_5.ElasticOutCurve _: return $flutter_7.ConstantTween<$flutter_5.ElasticOutCurve>(value);
          case $flutter_5.ElasticInOutCurve _: return $flutter_7.ConstantTween<$flutter_5.ElasticInOutCurve>(value);
          case $flutter_5.Curves _: return $flutter_7.ConstantTween<$flutter_5.Curves>(value);
          case $flutter_7.Animatable _: return $flutter_7.ConstantTween<$flutter_7.Animatable>(value);
          case $flutter_7.Tween _: return $flutter_7.ConstantTween<$flutter_7.Tween>(value);
          case $flutter_7.ReverseTween _: return $flutter_7.ConstantTween<$flutter_7.ReverseTween>(value);
          case $flutter_7.ColorTween _: return $flutter_7.ConstantTween<$flutter_7.ColorTween>(value);
          case $flutter_7.SizeTween _: return $flutter_7.ConstantTween<$flutter_7.SizeTween>(value);
          case $flutter_7.RectTween _: return $flutter_7.ConstantTween<$flutter_7.RectTween>(value);
          case $flutter_7.IntTween _: return $flutter_7.ConstantTween<$flutter_7.IntTween>(value);
          case $flutter_7.StepTween _: return $flutter_7.ConstantTween<$flutter_7.StepTween>(value);
          case $flutter_7.CurveTween _: return $flutter_7.ConstantTween<$flutter_7.CurveTween>(value);
          case $flutter_11.Simulation _: return $flutter_7.ConstantTween<$flutter_11.Simulation>(value);
          case $flutter_12.SpringDescription _: return $flutter_7.ConstantTween<$flutter_12.SpringDescription>(value);
          case $flutter_2.AnimationController _: return $flutter_7.ConstantTween<$flutter_2.AnimationController>(value);
          case $flutter_3.AnimationStyle _: return $flutter_7.ConstantTween<$flutter_3.AnimationStyle>(value);
          case $flutter_4.AlwaysStoppedAnimation _: return $flutter_7.ConstantTween<$flutter_4.AlwaysStoppedAnimation>(value);
          case $flutter_4.AnimationWithParentMixin _: return $flutter_7.ConstantTween<$flutter_4.AnimationWithParentMixin>(value);
          case $flutter_4.ProxyAnimation _: return $flutter_7.ConstantTween<$flutter_4.ProxyAnimation>(value);
          case $flutter_4.ReverseAnimation _: return $flutter_7.ConstantTween<$flutter_4.ReverseAnimation>(value);
          case $flutter_4.CurvedAnimation _: return $flutter_7.ConstantTween<$flutter_4.CurvedAnimation>(value);
          case $flutter_4.TrainHoppingAnimation _: return $flutter_7.ConstantTween<$flutter_4.TrainHoppingAnimation>(value);
          case $flutter_4.CompoundAnimation _: return $flutter_7.ConstantTween<$flutter_4.CompoundAnimation>(value);
          case $flutter_4.AnimationMean _: return $flutter_7.ConstantTween<$flutter_4.AnimationMean>(value);
          case $flutter_4.AnimationMax _: return $flutter_7.ConstantTween<$flutter_4.AnimationMax>(value);
          case $flutter_4.AnimationMin _: return $flutter_7.ConstantTween<$flutter_4.AnimationMin>(value);
          case $flutter_6.AnimationLazyListenerMixin _: return $flutter_7.ConstantTween<$flutter_6.AnimationLazyListenerMixin>(value);
          case $flutter_6.AnimationEagerListenerMixin _: return $flutter_7.ConstantTween<$flutter_6.AnimationEagerListenerMixin>(value);
          case $flutter_6.AnimationLocalListenersMixin _: return $flutter_7.ConstantTween<$flutter_6.AnimationLocalListenersMixin>(value);
          case $flutter_6.AnimationLocalStatusListenersMixin _: return $flutter_7.ConstantTween<$flutter_6.AnimationLocalStatusListenersMixin>(value);
          case $flutter_8.TweenSequence _: return $flutter_7.ConstantTween<$flutter_8.TweenSequence>(value);
          case $flutter_8.FlippedTweenSequence _: return $flutter_7.ConstantTween<$flutter_8.FlippedTweenSequence>(value);
          case $flutter_8.TweenSequenceItem _: return $flutter_7.ConstantTween<$flutter_8.TweenSequenceItem>(value);
          default: return $flutter_7.ConstantTween(value);
        }
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween').begin = value as dynamic,
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween').end = value as dynamic,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ConstantTween>(target, 'ConstantTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConstantTween(T value)',
    },
    methodSignatures: {
      'transform': 'T transform(double t)',
      'evaluate': 'T evaluate(Animation<double> animation)',
      'animate': 'Animation<T> animate(Animation<double> parent)',
      'chain': 'Animatable<T> chain(Animatable<double> parent)',
      'lerp': 'T lerp(double t)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'begin': 'T get begin',
      'end': 'T get end',
    },
    setterSignatures: {
      'begin': 'set begin(T value)',
      'end': 'set end(T value)',
    },
  );
}

// =============================================================================
// CurveTween Bridge
// =============================================================================

BridgedClass _createCurveTweenBridge() {
  return BridgedClass(
    nativeType: $flutter_7.CurveTween,
    name: 'CurveTween',
    isAssignable: (v) => v is $flutter_7.CurveTween,
    constructors: {
      '': (visitor, positional, named) {
        final curve = D4.getRequiredNamedArg<$flutter_5.Curve>(named, 'curve', 'CurveTween');
        return $flutter_7.CurveTween(curve: curve);
      },
    },
    getters: {
      'curve': (visitor, target) => D4.validateTarget<$flutter_7.CurveTween>(target, 'CurveTween').curve,
    },
    setters: {
      'curve': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.CurveTween>(target, 'CurveTween').curve = D4.extractBridgedArg<$flutter_5.Curve>(value, 'curve'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_7.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.CurveTween>(target, 'CurveTween');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'CurveTween({required Curve curve})',
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
      'evaluate': 'double evaluate(Animation<double> animation)',
      'animate': 'Animation<double> animate(Animation<double> parent)',
      'chain': 'Animatable<double> chain(Animatable<double> parent)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'curve': 'Curve get curve',
    },
    setterSignatures: {
      'curve': 'set curve(dynamic value)',
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
    isAssignable: (v) => v is $flutter_11.Simulation,
    constructors: {
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation').tolerance,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_11.Simulation>(target, 'Simulation').tolerance = D4.extractBridgedArg<$flutter_13.Tolerance>(value, 'tolerance'),
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
    isAssignable: (v) => v is $flutter_12.SpringDescription,
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
    isAssignable: (v) => v is $flutter_2.AnimationController,
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
        D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').duration = D4.extractBridgedArgOrNull<Duration>(value, 'duration'),
      'reverseDuration': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').reverseDuration = D4.extractBridgedArgOrNull<Duration>(value, 'reverseDuration'),
      'value': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController').value = D4.extractBridgedArg<double>(value, 'value'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
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
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_3.AnimationStyle,
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
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_10.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
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
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    isAssignable: (v) => v is $flutter_4.AlwaysStoppedAnimation,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AlwaysStoppedAnimation');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'AlwaysStoppedAnimation');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return $flutter_4.AlwaysStoppedAnimation<double>(value);
          case int _: return $flutter_4.AlwaysStoppedAnimation<int>(value);
          case String _: return $flutter_4.AlwaysStoppedAnimation<String>(value);
          case bool _: return $flutter_4.AlwaysStoppedAnimation<bool>(value);
          case $flutter_14.TickerProvider _: return $flutter_4.AlwaysStoppedAnimation<$flutter_14.TickerProvider>(value);
          case $flutter_14.TickerFuture _: return $flutter_4.AlwaysStoppedAnimation<$flutter_14.TickerFuture>(value);
          case $flutter_14.TickerCanceled _: return $flutter_4.AlwaysStoppedAnimation<$flutter_14.TickerCanceled>(value);
          case $flutter_1.Animation _: return $flutter_4.AlwaysStoppedAnimation<$flutter_1.Animation>(value);
          case $flutter_5.ParametricCurve _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.ParametricCurve>(value);
          case $flutter_5.Curve _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Curve>(value);
          case $flutter_5.SawTooth _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.SawTooth>(value);
          case $flutter_5.Interval _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Interval>(value);
          case $flutter_5.Split _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Split>(value);
          case $flutter_5.Threshold _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Threshold>(value);
          case $flutter_5.Cubic _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Cubic>(value);
          case $flutter_5.ThreePointCubic _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.ThreePointCubic>(value);
          case $flutter_5.Curve2D _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Curve2D>(value);
          case $flutter_5.Curve2DSample _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Curve2DSample>(value);
          case $flutter_5.CatmullRomSpline _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.CatmullRomSpline>(value);
          case $flutter_5.CatmullRomCurve _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.CatmullRomCurve>(value);
          case $flutter_5.FlippedCurve _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.FlippedCurve>(value);
          case $flutter_5.ElasticInCurve _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.ElasticInCurve>(value);
          case $flutter_5.ElasticOutCurve _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.ElasticOutCurve>(value);
          case $flutter_5.ElasticInOutCurve _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.ElasticInOutCurve>(value);
          case $flutter_5.Curves _: return $flutter_4.AlwaysStoppedAnimation<$flutter_5.Curves>(value);
          case $flutter_7.Animatable _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.Animatable>(value);
          case $flutter_7.Tween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.Tween>(value);
          case $flutter_7.ReverseTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.ReverseTween>(value);
          case $flutter_7.ColorTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.ColorTween>(value);
          case $flutter_7.SizeTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.SizeTween>(value);
          case $flutter_7.RectTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.RectTween>(value);
          case $flutter_7.IntTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.IntTween>(value);
          case $flutter_7.StepTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.StepTween>(value);
          case $flutter_7.ConstantTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.ConstantTween>(value);
          case $flutter_7.CurveTween _: return $flutter_4.AlwaysStoppedAnimation<$flutter_7.CurveTween>(value);
          case $flutter_11.Simulation _: return $flutter_4.AlwaysStoppedAnimation<$flutter_11.Simulation>(value);
          case $flutter_12.SpringDescription _: return $flutter_4.AlwaysStoppedAnimation<$flutter_12.SpringDescription>(value);
          case $flutter_2.AnimationController _: return $flutter_4.AlwaysStoppedAnimation<$flutter_2.AnimationController>(value);
          case $flutter_3.AnimationStyle _: return $flutter_4.AlwaysStoppedAnimation<$flutter_3.AnimationStyle>(value);
          case $flutter_4.AnimationWithParentMixin _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.AnimationWithParentMixin>(value);
          case $flutter_4.ProxyAnimation _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.ProxyAnimation>(value);
          case $flutter_4.ReverseAnimation _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.ReverseAnimation>(value);
          case $flutter_4.CurvedAnimation _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.CurvedAnimation>(value);
          case $flutter_4.TrainHoppingAnimation _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.TrainHoppingAnimation>(value);
          case $flutter_4.CompoundAnimation _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.CompoundAnimation>(value);
          case $flutter_4.AnimationMean _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.AnimationMean>(value);
          case $flutter_4.AnimationMax _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.AnimationMax>(value);
          case $flutter_4.AnimationMin _: return $flutter_4.AlwaysStoppedAnimation<$flutter_4.AnimationMin>(value);
          case $flutter_6.AnimationLazyListenerMixin _: return $flutter_4.AlwaysStoppedAnimation<$flutter_6.AnimationLazyListenerMixin>(value);
          case $flutter_6.AnimationEagerListenerMixin _: return $flutter_4.AlwaysStoppedAnimation<$flutter_6.AnimationEagerListenerMixin>(value);
          case $flutter_6.AnimationLocalListenersMixin _: return $flutter_4.AlwaysStoppedAnimation<$flutter_6.AnimationLocalListenersMixin>(value);
          case $flutter_6.AnimationLocalStatusListenersMixin _: return $flutter_4.AlwaysStoppedAnimation<$flutter_6.AnimationLocalStatusListenersMixin>(value);
          case $flutter_8.TweenSequence _: return $flutter_4.AlwaysStoppedAnimation<$flutter_8.TweenSequence>(value);
          case $flutter_8.FlippedTweenSequence _: return $flutter_4.AlwaysStoppedAnimation<$flutter_8.FlippedTweenSequence>(value);
          case $flutter_8.TweenSequenceItem _: return $flutter_4.AlwaysStoppedAnimation<$flutter_8.TweenSequenceItem>(value);
          default: return $flutter_4.AlwaysStoppedAnimation(value);
        }
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
    isAssignable: (v) => v is $flutter_4.AnimationWithParentMixin,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
    isAssignable: (v) => v is $flutter_4.ProxyAnimation,
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
        D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation').parent = D4.extractBridgedArgOrNull<$flutter_1.Animation<double>>(value, 'parent'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
        return null;
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
      'didStartListening': 'void didStartListening()',
      'didStopListening': 'void didStopListening()',
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_4.ReverseAnimation,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
        return null;
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
      'didStartListening': 'void didStartListening()',
      'didStopListening': 'void didStopListening()',
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_4.CurvedAnimation,
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
        D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').curve = D4.extractBridgedArg<$flutter_5.Curve>(value, 'curve'),
      'reverseCurve': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').reverseCurve = D4.extractBridgedArgOrNull<$flutter_5.Curve>(value, 'reverseCurve'),
      'isDisposed': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation').isDisposed = D4.extractBridgedArg<bool>(value, 'isDisposed'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
    isAssignable: (v) => v is $flutter_4.TrainHoppingAnimation,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TrainHoppingAnimation');
        final currentTrain = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, '_currentTrain', 'TrainHoppingAnimation');
        final nextTrain = D4.getRequiredArg<$flutter_1.Animation<double>?>(positional, 1, '_nextTrain', 'TrainHoppingAnimation');
        final onSwitchedTrainRaw = named['onSwitchedTrain'];
        return $flutter_4.TrainHoppingAnimation(currentTrain, nextTrain, onSwitchedTrain: onSwitchedTrainRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSwitchedTrainRaw, []); });
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
      'onSwitchedTrain': (visitor, target, value) {
        final onSwitchedTrainRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSwitchedTrain');
        D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation').onSwitchedTrain = onSwitchedTrainRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSwitchedTrainRaw, []); };
      },
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
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
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_4.CompoundAnimation,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
        return null;
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
      'didStartListening': 'void didStartListening()',
      'didStopListening': 'void didStopListening()',
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_4.AnimationMean,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
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
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_4.AnimationMax,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
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
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_4.AnimationMin,
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
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
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
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
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
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_6.AnimationLazyListenerMixin,
    constructors: {
    },
    getters: {
      'isListening': (visitor, target) => D4.validateTarget<$flutter_6.AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin').isListening,
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
        t.didUnregisterListener();
        return null;
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
        t.didStopListening();
        return null;
      },
    },
    methodSignatures: {
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'didStartListening': 'void didStartListening()',
      'didStopListening': 'void didStopListening()',
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
    isAssignable: (v) => v is $flutter_6.AnimationEagerListenerMixin,
    constructors: {
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationEagerListenerMixin>(target, 'AnimationEagerListenerMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationEagerListenerMixin>(target, 'AnimationEagerListenerMixin');
        t.didUnregisterListener();
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationEagerListenerMixin>(target, 'AnimationEagerListenerMixin');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
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
    isAssignable: (v) => v is $flutter_6.AnimationLocalListenersMixin,
    constructors: {
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        t.didUnregisterListener();
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        t.notifyListeners();
        return null;
      },
    },
    methodSignatures: {
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
      'clearListeners': 'void clearListeners()',
      'notifyListeners': 'void notifyListeners()',
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
    isAssignable: (v) => v is $flutter_6.AnimationLocalStatusListenersMixin,
    constructors: {
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        t.didUnregisterListener();
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        D4.requireMinArgs(positional, 1, 'notifyStatusListeners');
        final status = D4.getRequiredArg<$flutter_1.AnimationStatus>(positional, 0, 'status', 'notifyStatusListeners');
        t.notifyStatusListeners(status);
        return null;
      },
    },
    methodSignatures: {
      'didRegisterListener': 'void didRegisterListener()',
      'didUnregisterListener': 'void didUnregisterListener()',
      'addStatusListener': 'void addStatusListener(AnimationStatusListener listener)',
      'removeStatusListener': 'void removeStatusListener(AnimationStatusListener listener)',
      'clearStatusListeners': 'void clearStatusListeners()',
      'notifyStatusListeners': 'void notifyStatusListeners(AnimationStatus status)',
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
    isAssignable: (v) => v is $flutter_8.TweenSequence,
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
    isAssignable: (v) => v is $flutter_8.FlippedTweenSequence,
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
    isAssignable: (v) => v is $flutter_8.TweenSequenceItem,
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

