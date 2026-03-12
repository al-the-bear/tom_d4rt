// D4rt Bridge - Generated file, do not edit
// Sources: 11 files
// Generated: 2026-03-12T17:05:07.606354

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/animation/animation.dart' as $flutter_1;
import 'package:flutter/src/animation/animation_controller.dart' as $flutter_2;
import 'package:flutter/src/animation/animation_style.dart' as $flutter_3;
import 'package:flutter/src/animation/curves.dart' as $flutter_4;
import 'package:flutter/src/animation/tween.dart' as $flutter_5;
import 'package:flutter/src/animation/tween_sequence.dart' as $flutter_6;
import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_7;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_8;
import 'package:flutter/src/physics/simulation.dart' as $flutter_9;
import 'package:flutter/src/physics/spring_simulation.dart' as $flutter_10;
import 'package:flutter/src/physics/tolerance.dart' as $flutter_11;
import 'package:flutter/src/scheduler/ticker.dart' as $flutter_12;
import 'C:\flutter\packages\flutter\lib\src\animation\curves.dart' as $aux_aux;
import 'package:flutter/cupertino.dart' as $aux_flutter;
import 'package:flutter/src/animation/animations.dart' as $aux_flutter_3;

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
      'TickerProvider': 'C:\flutter\packages\flutter\lib\src\scheduler\ticker.dart',
      'TickerFuture': 'C:\flutter\packages\flutter\lib\src\scheduler\ticker.dart',
      'TickerCanceled': 'C:\flutter\packages\flutter\lib\src\scheduler\ticker.dart',
      'Animation': 'C:\flutter\packages\flutter\lib\src\animation\animation.dart',
      'ParametricCurve': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Curve': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'SawTooth': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Interval': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Split': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Threshold': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Cubic': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'ThreePointCubic': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Curve2D': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Curve2DSample': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'CatmullRomSpline': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'CatmullRomCurve': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'FlippedCurve': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'ElasticInCurve': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'ElasticOutCurve': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'ElasticInOutCurve': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Curves': 'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'Animatable': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'Tween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'ReverseTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'ColorTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'SizeTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'RectTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'IntTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'StepTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'ConstantTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'CurveTween': 'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'Simulation': 'C:\flutter\packages\flutter\lib\src\physics\simulation.dart',
      'SpringDescription': 'C:\flutter\packages\flutter\lib\src\physics\spring_simulation.dart',
      'AnimationController': 'C:\flutter\packages\flutter\lib\src\animation\animation_controller.dart',
      'AnimationStyle': 'C:\flutter\packages\flutter\lib\src\animation\animation_style.dart',
      'AlwaysStoppedAnimation': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'AnimationWithParentMixin': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'ProxyAnimation': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'ReverseAnimation': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'CurvedAnimation': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'TrainHoppingAnimation': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'CompoundAnimation': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'AnimationMean': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'AnimationMax': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'AnimationMin': 'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'AnimationLazyListenerMixin': 'C:\flutter\packages\flutter\lib\src\animation\listener_helpers.dart',
      'AnimationEagerListenerMixin': 'C:\flutter\packages\flutter\lib\src\animation\listener_helpers.dart',
      'AnimationLocalListenersMixin': 'C:\flutter\packages\flutter\lib\src\animation\listener_helpers.dart',
      'AnimationLocalStatusListenersMixin': 'C:\flutter\packages\flutter\lib\src\animation\listener_helpers.dart',
      'TweenSequence': 'C:\flutter\packages\flutter\lib\src\animation\tween_sequence.dart',
      'FlippedTweenSequence': 'C:\flutter\packages\flutter\lib\src\animation\tween_sequence.dart',
      'TweenSequenceItem': 'C:\flutter\packages\flutter\lib\src\animation\tween_sequence.dart',
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
      'AnimationStatus': 'C:\flutter\packages\flutter\lib\src\animation\animation.dart',
      'AnimationBehavior': 'C:\flutter\packages\flutter\lib\src\animation\animation_controller.dart',
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
      interpreter.registerGlobalVariable('kAlwaysCompleteAnimation', kAlwaysCompleteAnimation, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\animation\animations.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAlwaysCompleteAnimation": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAlwaysDismissedAnimation', kAlwaysDismissedAnimation, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\animation\animations.dart');
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
      'C:\flutter\packages\flutter\lib\src\animation\animation.dart',
      'C:\flutter\packages\flutter\lib\src\animation\animation_controller.dart',
      'C:\flutter\packages\flutter\lib\src\animation\animation_style.dart',
      'C:\flutter\packages\flutter\lib\src\animation\animations.dart',
      'C:\flutter\packages\flutter\lib\src\animation\curves.dart',
      'C:\flutter\packages\flutter\lib\src\animation\listener_helpers.dart',
      'C:\flutter\packages\flutter\lib\src\animation\tween.dart',
      'C:\flutter\packages\flutter\lib\src\animation\tween_sequence.dart',
      'C:\flutter\packages\flutter\lib\src\physics\simulation.dart',
      'C:\flutter\packages\flutter\lib\src\physics\spring_simulation.dart',
      'C:\flutter\packages\flutter\lib\src\scheduler\ticker.dart',
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
    nativeType: $flutter_12.TickerProvider,
    name: 'TickerProvider',
    isAssignable: (v) => v is $flutter_12.TickerProvider,
    constructors: {
    },
    methods: {
      'createTicker': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerProvider>(target, 'TickerProvider');
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
    nativeType: $flutter_12.TickerFuture,
    name: 'TickerFuture',
    isAssignable: (v) => v is $flutter_12.TickerFuture,
    constructors: {
      'complete': (visitor, positional, named) {
        return $flutter_12.TickerFuture.complete();
      },
    },
    getters: {
      'orCancel': (visitor, target) => D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture').orCancel,
    },
    methods: {
      'whenCompleteOrCancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenCompleteOrCancel');
        if (positional.isEmpty) {
          throw ArgumentError('whenCompleteOrCancel: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.whenCompleteOrCancel(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'asStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture');
        return t.asStream();
      },
      'catchError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'catchError');
        final onError = D4.getRequiredArg<Function>(positional, 0, 'onError', 'catchError');
        final testRaw = named['test'];
        return t.catchError(onError, test: testRaw == null ? null : (Object p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; });
      },
      'then': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'then');
        if (positional.isEmpty) {
          throw ArgumentError('then: Missing required argument "onValue" at position 0');
        }
        final onValueRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        return t.then((void p0) { return D4.callInterpreterCallback(visitor!, onValueRaw, [null]) as FutureOr<Object>; }, onError: onError);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : () { return D4.callInterpreterCallback(visitor!, onTimeoutRaw, []) as FutureOr<void>; });
      },
      'whenComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture');
        D4.requireMinArgs(positional, 1, 'whenComplete');
        if (positional.isEmpty) {
          throw ArgumentError('whenComplete: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.whenComplete(() { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, actionRaw, [])); });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.TickerFuture>(target, 'TickerFuture');
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
    nativeType: TickerCanceled,
    name: 'TickerCanceled',
    isAssignable: (v) => v is TickerCanceled,
    constructors: {
      '': (visitor, positional, named) {
        final ticker = D4.getOptionalArg<$flutter_12.Ticker?>(positional, 0, 'ticker');
        return TickerCanceled(ticker);
      },
    },
    getters: {
      'ticker': (visitor, target) => D4.validateTarget<TickerCanceled>(target, 'TickerCanceled').ticker,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TickerCanceled>(target, 'TickerCanceled');
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
        final listenable = D4.getRequiredArg<$flutter_7.ValueListenable<dynamic>>(positional, 0, 'listenable', 'Animation');
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
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
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
    nativeType: $aux_aux.ParametricCurve,
    name: 'ParametricCurve',
    isAssignable: (v) => v is $aux_aux.ParametricCurve,
    constructors: {
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ParametricCurve>(target, 'ParametricCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ParametricCurve>(target, 'ParametricCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ParametricCurve>(target, 'ParametricCurve');
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
    nativeType: $aux_aux.Curve,
    name: 'Curve',
    isAssignable: (v) => v is $aux_aux.Curve,
    constructors: {
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.Curve>(target, 'Curve').flipped,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve>(target, 'Curve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve>(target, 'Curve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve>(target, 'Curve');
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
    nativeType: $aux_aux.SawTooth,
    name: 'SawTooth',
    isAssignable: (v) => v is $aux_aux.SawTooth,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SawTooth');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'SawTooth');
        return $aux_aux.SawTooth(count);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.SawTooth>(target, 'SawTooth').flipped,
      'count': (visitor, target) => D4.validateTarget<$aux_aux.SawTooth>(target, 'SawTooth').count,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.SawTooth>(target, 'SawTooth');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.SawTooth>(target, 'SawTooth');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.SawTooth>(target, 'SawTooth');
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
    nativeType: $aux_aux.Interval,
    name: 'Interval',
    isAssignable: (v) => v is $aux_aux.Interval,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Interval');
        final begin = D4.getRequiredArg<double>(positional, 0, 'begin', 'Interval');
        final end = D4.getRequiredArg<double>(positional, 1, 'end', 'Interval');
        final curve = D4.getNamedArgWithDefault<$flutter_4.Curve>(named, 'curve', $aux_flutter.Curves.linear);
        return $aux_aux.Interval(begin, end, curve: curve);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.Interval>(target, 'Interval').flipped,
      'begin': (visitor, target) => D4.validateTarget<$aux_aux.Interval>(target, 'Interval').begin,
      'end': (visitor, target) => D4.validateTarget<$aux_aux.Interval>(target, 'Interval').end,
      'curve': (visitor, target) => D4.validateTarget<$aux_aux.Interval>(target, 'Interval').curve,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Interval>(target, 'Interval');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Interval>(target, 'Interval');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Interval>(target, 'Interval');
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
    nativeType: $aux_aux.Split,
    name: 'Split',
    isAssignable: (v) => v is $aux_aux.Split,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Split');
        final split = D4.getRequiredArg<double>(positional, 0, 'split', 'Split');
        final beginCurve = D4.getNamedArgWithDefault<$flutter_4.Curve>(named, 'beginCurve', $aux_flutter.Curves.linear);
        final endCurve = D4.getNamedArgWithDefault<$flutter_4.Curve>(named, 'endCurve', $aux_flutter.Curves.easeOutCubic);
        return $aux_aux.Split(split, beginCurve: beginCurve, endCurve: endCurve);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.Split>(target, 'Split').flipped,
      'split': (visitor, target) => D4.validateTarget<$aux_aux.Split>(target, 'Split').split,
      'beginCurve': (visitor, target) => D4.validateTarget<$aux_aux.Split>(target, 'Split').beginCurve,
      'endCurve': (visitor, target) => D4.validateTarget<$aux_aux.Split>(target, 'Split').endCurve,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Split>(target, 'Split');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Split>(target, 'Split');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Split>(target, 'Split');
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
    nativeType: $aux_aux.Threshold,
    name: 'Threshold',
    isAssignable: (v) => v is $aux_aux.Threshold,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Threshold');
        final threshold = D4.getRequiredArg<double>(positional, 0, 'threshold', 'Threshold');
        return $aux_aux.Threshold(threshold);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.Threshold>(target, 'Threshold').flipped,
      'threshold': (visitor, target) => D4.validateTarget<$aux_aux.Threshold>(target, 'Threshold').threshold,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Threshold>(target, 'Threshold');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Threshold>(target, 'Threshold');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Threshold>(target, 'Threshold');
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
    nativeType: $aux_aux.Cubic,
    name: 'Cubic',
    isAssignable: (v) => v is $aux_aux.Cubic,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Cubic');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'Cubic');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'Cubic');
        final c = D4.getRequiredArg<double>(positional, 2, 'c', 'Cubic');
        final d = D4.getRequiredArg<double>(positional, 3, 'd', 'Cubic');
        return $aux_aux.Cubic(a, b, c, d);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic').flipped,
      'a': (visitor, target) => D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic').a,
      'b': (visitor, target) => D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic').b,
      'c': (visitor, target) => D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic').c,
      'd': (visitor, target) => D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic').d,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Cubic>(target, 'Cubic');
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
    nativeType: $aux_aux.ThreePointCubic,
    name: 'ThreePointCubic',
    isAssignable: (v) => v is $aux_aux.ThreePointCubic,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'ThreePointCubic');
        final a1 = D4.getRequiredArg<Offset>(positional, 0, 'a1', 'ThreePointCubic');
        final b1 = D4.getRequiredArg<Offset>(positional, 1, 'b1', 'ThreePointCubic');
        final midpoint = D4.getRequiredArg<Offset>(positional, 2, 'midpoint', 'ThreePointCubic');
        final a2 = D4.getRequiredArg<Offset>(positional, 3, 'a2', 'ThreePointCubic');
        final b2 = D4.getRequiredArg<Offset>(positional, 4, 'b2', 'ThreePointCubic');
        return $aux_aux.ThreePointCubic(a1, b1, midpoint, a2, b2);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic').flipped,
      'a1': (visitor, target) => D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic').a1,
      'b1': (visitor, target) => D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic').b1,
      'midpoint': (visitor, target) => D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic').midpoint,
      'a2': (visitor, target) => D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic').a2,
      'b2': (visitor, target) => D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic').b2,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ThreePointCubic>(target, 'ThreePointCubic');
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
    nativeType: $aux_aux.Curve2D,
    name: 'Curve2D',
    isAssignable: (v) => v is $aux_aux.Curve2D,
    constructors: {
    },
    getters: {
      'samplingSeed': (visitor, target) => D4.validateTarget<$aux_aux.Curve2D>(target, 'Curve2D').samplingSeed,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve2D>(target, 'Curve2D');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve2D>(target, 'Curve2D');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve2D>(target, 'Curve2D');
        return t.toString();
      },
      'generateSamples': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve2D>(target, 'Curve2D');
        final start = D4.getNamedArgWithDefault<double>(named, 'start', 0.0);
        final end = D4.getNamedArgWithDefault<double>(named, 'end', 1.0);
        final tolerance = D4.getNamedArgWithDefault<double>(named, 'tolerance', 1e-10);
        return t.generateSamples(start: start, end: end, tolerance: tolerance);
      },
      'findInverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve2D>(target, 'Curve2D');
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
    nativeType: $aux_aux.Curve2DSample,
    name: 'Curve2DSample',
    isAssignable: (v) => v is $aux_aux.Curve2DSample,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Curve2DSample');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'Curve2DSample');
        final value = D4.getRequiredArg<Offset>(positional, 1, 'value', 'Curve2DSample');
        return $aux_aux.Curve2DSample(t_, value);
      },
    },
    getters: {
      't': (visitor, target) => D4.validateTarget<$aux_aux.Curve2DSample>(target, 'Curve2DSample').t,
      'value': (visitor, target) => D4.validateTarget<$aux_aux.Curve2DSample>(target, 'Curve2DSample').value,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.Curve2DSample>(target, 'Curve2DSample');
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
    nativeType: $aux_aux.CatmullRomSpline,
    name: 'CatmullRomSpline',
    isAssignable: (v) => v is $aux_aux.CatmullRomSpline,
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
        return $aux_aux.CatmullRomSpline(controlPoints, tension: tension, startHandle: startHandle, endHandle: endHandle);
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
        return $aux_aux.CatmullRomSpline.precompute(controlPoints, tension: tension, startHandle: startHandle, endHandle: endHandle);
      },
    },
    getters: {
      'samplingSeed': (visitor, target) => D4.validateTarget<$aux_aux.CatmullRomSpline>(target, 'CatmullRomSpline').samplingSeed,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomSpline>(target, 'CatmullRomSpline');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomSpline>(target, 'CatmullRomSpline');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomSpline>(target, 'CatmullRomSpline');
        return t.toString();
      },
      'generateSamples': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomSpline>(target, 'CatmullRomSpline');
        final start = D4.getNamedArgWithDefault<double>(named, 'start', 0.0);
        final end = D4.getNamedArgWithDefault<double>(named, 'end', 1.0);
        final tolerance = D4.getNamedArgWithDefault<double>(named, 'tolerance', 1e-10);
        return t.generateSamples(start: start, end: end, tolerance: tolerance);
      },
      'findInverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomSpline>(target, 'CatmullRomSpline');
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
    nativeType: $aux_aux.CatmullRomCurve,
    name: 'CatmullRomCurve',
    isAssignable: (v) => v is $aux_aux.CatmullRomCurve,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatmullRomCurve');
        if (positional.isEmpty) {
          throw ArgumentError('CatmullRomCurve: Missing required argument "controlPoints" at position 0');
        }
        final controlPoints = D4.coerceList<Offset>(positional[0], 'controlPoints');
        final tension = D4.getNamedArgWithDefault<double>(named, 'tension', 0.0);
        return $aux_aux.CatmullRomCurve(controlPoints, tension: tension);
      },
      'precompute': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatmullRomCurve');
        if (positional.isEmpty) {
          throw ArgumentError('CatmullRomCurve: Missing required argument "controlPoints" at position 0');
        }
        final controlPoints = D4.coerceList<Offset>(positional[0], 'controlPoints');
        final tension = D4.getNamedArgWithDefault<double>(named, 'tension', 0.0);
        return $aux_aux.CatmullRomCurve.precompute(controlPoints, tension: tension);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.CatmullRomCurve>(target, 'CatmullRomCurve').flipped,
      'controlPoints': (visitor, target) => D4.validateTarget<$aux_aux.CatmullRomCurve>(target, 'CatmullRomCurve').controlPoints,
      'tension': (visitor, target) => D4.validateTarget<$aux_aux.CatmullRomCurve>(target, 'CatmullRomCurve').tension,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomCurve>(target, 'CatmullRomCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomCurve>(target, 'CatmullRomCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.CatmullRomCurve>(target, 'CatmullRomCurve');
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
        return $aux_aux.CatmullRomCurve.validateControlPoints(controlPoints, tension: tension, reasons: reasons);
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
    nativeType: $aux_aux.FlippedCurve,
    name: 'FlippedCurve',
    isAssignable: (v) => v is $aux_aux.FlippedCurve,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlippedCurve');
        final curve = D4.getRequiredArg<$flutter_4.Curve>(positional, 0, 'curve', 'FlippedCurve');
        return $aux_aux.FlippedCurve(curve);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.FlippedCurve>(target, 'FlippedCurve').flipped,
      'curve': (visitor, target) => D4.validateTarget<$aux_aux.FlippedCurve>(target, 'FlippedCurve').curve,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.FlippedCurve>(target, 'FlippedCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.FlippedCurve>(target, 'FlippedCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.FlippedCurve>(target, 'FlippedCurve');
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
    nativeType: $aux_aux.ElasticInCurve,
    name: 'ElasticInCurve',
    isAssignable: (v) => v is $aux_aux.ElasticInCurve,
    constructors: {
      '': (visitor, positional, named) {
        final period = D4.getOptionalArgWithDefault<double>(positional, 0, 'period', 0.4);
        return $aux_aux.ElasticInCurve(period);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.ElasticInCurve>(target, 'ElasticInCurve').flipped,
      'period': (visitor, target) => D4.validateTarget<$aux_aux.ElasticInCurve>(target, 'ElasticInCurve').period,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticInCurve>(target, 'ElasticInCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticInCurve>(target, 'ElasticInCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticInCurve>(target, 'ElasticInCurve');
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
    nativeType: $aux_aux.ElasticOutCurve,
    name: 'ElasticOutCurve',
    isAssignable: (v) => v is $aux_aux.ElasticOutCurve,
    constructors: {
      '': (visitor, positional, named) {
        final period = D4.getOptionalArgWithDefault<double>(positional, 0, 'period', 0.4);
        return $aux_aux.ElasticOutCurve(period);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.ElasticOutCurve>(target, 'ElasticOutCurve').flipped,
      'period': (visitor, target) => D4.validateTarget<$aux_aux.ElasticOutCurve>(target, 'ElasticOutCurve').period,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticOutCurve>(target, 'ElasticOutCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticOutCurve>(target, 'ElasticOutCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticOutCurve>(target, 'ElasticOutCurve');
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
    nativeType: $aux_aux.ElasticInOutCurve,
    name: 'ElasticInOutCurve',
    isAssignable: (v) => v is $aux_aux.ElasticInOutCurve,
    constructors: {
      '': (visitor, positional, named) {
        final period = D4.getOptionalArgWithDefault<double>(positional, 0, 'period', 0.4);
        return $aux_aux.ElasticInOutCurve(period);
      },
    },
    getters: {
      'flipped': (visitor, target) => D4.validateTarget<$aux_aux.ElasticInOutCurve>(target, 'ElasticInOutCurve').flipped,
      'period': (visitor, target) => D4.validateTarget<$aux_aux.ElasticInOutCurve>(target, 'ElasticInOutCurve').period,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticInOutCurve>(target, 'ElasticInOutCurve');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'transformInternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticInOutCurve>(target, 'ElasticInOutCurve');
        D4.requireMinArgs(positional, 1, 'transformInternal');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transformInternal');
        return t.transformInternal(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$aux_aux.ElasticInOutCurve>(target, 'ElasticInOutCurve');
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
    nativeType: $aux_aux.Curves,
    name: 'Curves',
    isAssignable: (v) => v is $aux_aux.Curves,
    constructors: {
    },
    staticGetters: {
      'linear': (visitor) => $aux_aux.Curves.linear,
      'decelerate': (visitor) => $aux_aux.Curves.decelerate,
      'fastLinearToSlowEaseIn': (visitor) => $aux_aux.Curves.fastLinearToSlowEaseIn,
      'fastEaseInToSlowEaseOut': (visitor) => $aux_aux.Curves.fastEaseInToSlowEaseOut,
      'ease': (visitor) => $aux_aux.Curves.ease,
      'easeIn': (visitor) => $aux_aux.Curves.easeIn,
      'easeInToLinear': (visitor) => $aux_aux.Curves.easeInToLinear,
      'easeInSine': (visitor) => $aux_aux.Curves.easeInSine,
      'easeInQuad': (visitor) => $aux_aux.Curves.easeInQuad,
      'easeInCubic': (visitor) => $aux_aux.Curves.easeInCubic,
      'easeInQuart': (visitor) => $aux_aux.Curves.easeInQuart,
      'easeInQuint': (visitor) => $aux_aux.Curves.easeInQuint,
      'easeInExpo': (visitor) => $aux_aux.Curves.easeInExpo,
      'easeInCirc': (visitor) => $aux_aux.Curves.easeInCirc,
      'easeInBack': (visitor) => $aux_aux.Curves.easeInBack,
      'easeOut': (visitor) => $aux_aux.Curves.easeOut,
      'linearToEaseOut': (visitor) => $aux_aux.Curves.linearToEaseOut,
      'easeOutSine': (visitor) => $aux_aux.Curves.easeOutSine,
      'easeOutQuad': (visitor) => $aux_aux.Curves.easeOutQuad,
      'easeOutCubic': (visitor) => $aux_aux.Curves.easeOutCubic,
      'easeOutQuart': (visitor) => $aux_aux.Curves.easeOutQuart,
      'easeOutQuint': (visitor) => $aux_aux.Curves.easeOutQuint,
      'easeOutExpo': (visitor) => $aux_aux.Curves.easeOutExpo,
      'easeOutCirc': (visitor) => $aux_aux.Curves.easeOutCirc,
      'easeOutBack': (visitor) => $aux_aux.Curves.easeOutBack,
      'easeInOut': (visitor) => $aux_aux.Curves.easeInOut,
      'easeInOutSine': (visitor) => $aux_aux.Curves.easeInOutSine,
      'easeInOutQuad': (visitor) => $aux_aux.Curves.easeInOutQuad,
      'easeInOutCubic': (visitor) => $aux_aux.Curves.easeInOutCubic,
      'easeInOutCubicEmphasized': (visitor) => $aux_aux.Curves.easeInOutCubicEmphasized,
      'easeInOutQuart': (visitor) => $aux_aux.Curves.easeInOutQuart,
      'easeInOutQuint': (visitor) => $aux_aux.Curves.easeInOutQuint,
      'easeInOutExpo': (visitor) => $aux_aux.Curves.easeInOutExpo,
      'easeInOutCirc': (visitor) => $aux_aux.Curves.easeInOutCirc,
      'easeInOutBack': (visitor) => $aux_aux.Curves.easeInOutBack,
      'fastOutSlowIn': (visitor) => $aux_aux.Curves.fastOutSlowIn,
      'slowMiddle': (visitor) => $aux_aux.Curves.slowMiddle,
      'bounceIn': (visitor) => $aux_aux.Curves.bounceIn,
      'bounceOut': (visitor) => $aux_aux.Curves.bounceOut,
      'bounceInOut': (visitor) => $aux_aux.Curves.bounceInOut,
      'elasticIn': (visitor) => $aux_aux.Curves.elasticIn,
      'elasticOut': (visitor) => $aux_aux.Curves.elasticOut,
      'elasticInOut': (visitor) => $aux_aux.Curves.elasticInOut,
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
    nativeType: $flutter_5.Animatable,
    name: 'Animatable',
    isAssignable: (v) => v is $flutter_5.Animatable,
    constructors: {
      'fromCallback': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Animatable');
        if (positional.isEmpty) {
          throw ArgumentError('Animatable: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return $flutter_5.Animatable.fromCallback((double p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [p0])); });
      },
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Animatable>(target, 'Animatable');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
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
    nativeType: $flutter_5.Tween,
    name: 'Tween',
    isAssignable: (v) => v is $flutter_5.Tween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Object?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Object?>(named, 'end');
        return $flutter_5.Tween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<$flutter_5.Tween>(target, 'Tween').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_5.Tween>(target, 'Tween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<$flutter_5.Tween>(target, 'Tween').begin = D4.extractBridgedArgOrNull<Object?>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<$flutter_5.Tween>(target, 'Tween').end = D4.extractBridgedArgOrNull<Object?>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Tween>(target, 'Tween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.Tween>(target, 'Tween');
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
    nativeType: ReverseTween,
    name: 'ReverseTween',
    isAssignable: (v) => v is ReverseTween,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReverseTween');
        final parent = D4.getRequiredArg<$flutter_5.Tween<Object?>>(positional, 0, 'parent', 'ReverseTween');
        return ReverseTween(parent);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<ReverseTween>(target, 'ReverseTween').begin,
      'end': (visitor, target) => D4.validateTarget<ReverseTween>(target, 'ReverseTween').end,
      'parent': (visitor, target) => D4.validateTarget<ReverseTween>(target, 'ReverseTween').parent,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<ReverseTween>(target, 'ReverseTween').begin = D4.extractBridgedArg<Object?>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<ReverseTween>(target, 'ReverseTween').end = D4.extractBridgedArg<Object?>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseTween>(target, 'ReverseTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseTween>(target, 'ReverseTween');
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
    nativeType: ColorTween,
    name: 'ColorTween',
    isAssignable: (v) => v is ColorTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Color?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Color?>(named, 'end');
        return ColorTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<ColorTween>(target, 'ColorTween').begin,
      'end': (visitor, target) => D4.validateTarget<ColorTween>(target, 'ColorTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<ColorTween>(target, 'ColorTween').begin = D4.extractBridgedArgOrNull<Color>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<ColorTween>(target, 'ColorTween').end = D4.extractBridgedArgOrNull<Color>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColorTween>(target, 'ColorTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ColorTween>(target, 'ColorTween');
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
    nativeType: SizeTween,
    name: 'SizeTween',
    isAssignable: (v) => v is SizeTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Size?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Size?>(named, 'end');
        return SizeTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<SizeTween>(target, 'SizeTween').begin,
      'end': (visitor, target) => D4.validateTarget<SizeTween>(target, 'SizeTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<SizeTween>(target, 'SizeTween').begin = D4.extractBridgedArgOrNull<Size>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<SizeTween>(target, 'SizeTween').end = D4.extractBridgedArgOrNull<Size>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SizeTween>(target, 'SizeTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SizeTween>(target, 'SizeTween');
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
    nativeType: RectTween,
    name: 'RectTween',
    isAssignable: (v) => v is RectTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<Rect?>(named, 'begin');
        final end = D4.getOptionalNamedArg<Rect?>(named, 'end');
        return RectTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<RectTween>(target, 'RectTween').begin,
      'end': (visitor, target) => D4.validateTarget<RectTween>(target, 'RectTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<RectTween>(target, 'RectTween').begin = D4.extractBridgedArgOrNull<Rect>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<RectTween>(target, 'RectTween').end = D4.extractBridgedArgOrNull<Rect>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RectTween>(target, 'RectTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<RectTween>(target, 'RectTween');
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
    nativeType: IntTween,
    name: 'IntTween',
    isAssignable: (v) => v is IntTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<int?>(named, 'begin');
        final end = D4.getOptionalNamedArg<int?>(named, 'end');
        return IntTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<IntTween>(target, 'IntTween').begin,
      'end': (visitor, target) => D4.validateTarget<IntTween>(target, 'IntTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<IntTween>(target, 'IntTween').begin = D4.extractBridgedArg<int>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<IntTween>(target, 'IntTween').end = D4.extractBridgedArg<int>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntTween>(target, 'IntTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<IntTween>(target, 'IntTween');
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
    nativeType: StepTween,
    name: 'StepTween',
    isAssignable: (v) => v is StepTween,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getOptionalNamedArg<int?>(named, 'begin');
        final end = D4.getOptionalNamedArg<int?>(named, 'end');
        return StepTween(begin: begin, end: end);
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<StepTween>(target, 'StepTween').begin,
      'end': (visitor, target) => D4.validateTarget<StepTween>(target, 'StepTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<StepTween>(target, 'StepTween').begin = D4.extractBridgedArg<int>(value, 'begin'),
      'end': (visitor, target, value) => 
        D4.validateTarget<StepTween>(target, 'StepTween').end = D4.extractBridgedArg<int>(value, 'end'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StepTween>(target, 'StepTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<StepTween>(target, 'StepTween');
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
    nativeType: ConstantTween,
    name: 'ConstantTween',
    isAssignable: (v) => v is ConstantTween,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConstantTween');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'ConstantTween');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return ConstantTween<double>(value);
          case int _: return ConstantTween<int>(value);
          case String _: return ConstantTween<String>(value);
          case bool _: return ConstantTween<bool>(value);
          case $flutter_12.TickerProvider _: return ConstantTween<$flutter_12.TickerProvider>(value);
          case $flutter_12.TickerFuture _: return ConstantTween<$flutter_12.TickerFuture>(value);
          case TickerCanceled _: return ConstantTween<TickerCanceled>(value);
          case $flutter_1.Animation _: return ConstantTween<$flutter_1.Animation>(value);
          case $aux_aux.ParametricCurve _: return ConstantTween<$aux_aux.ParametricCurve>(value);
          case $aux_aux.Curve _: return ConstantTween<$aux_aux.Curve>(value);
          case $aux_aux.SawTooth _: return ConstantTween<$aux_aux.SawTooth>(value);
          case $aux_aux.Interval _: return ConstantTween<$aux_aux.Interval>(value);
          case $aux_aux.Split _: return ConstantTween<$aux_aux.Split>(value);
          case $aux_aux.Threshold _: return ConstantTween<$aux_aux.Threshold>(value);
          case $aux_aux.Cubic _: return ConstantTween<$aux_aux.Cubic>(value);
          case $aux_aux.ThreePointCubic _: return ConstantTween<$aux_aux.ThreePointCubic>(value);
          case $aux_aux.Curve2D _: return ConstantTween<$aux_aux.Curve2D>(value);
          case $aux_aux.Curve2DSample _: return ConstantTween<$aux_aux.Curve2DSample>(value);
          case $aux_aux.CatmullRomSpline _: return ConstantTween<$aux_aux.CatmullRomSpline>(value);
          case $aux_aux.CatmullRomCurve _: return ConstantTween<$aux_aux.CatmullRomCurve>(value);
          case $aux_aux.FlippedCurve _: return ConstantTween<$aux_aux.FlippedCurve>(value);
          case $aux_aux.ElasticInCurve _: return ConstantTween<$aux_aux.ElasticInCurve>(value);
          case $aux_aux.ElasticOutCurve _: return ConstantTween<$aux_aux.ElasticOutCurve>(value);
          case $aux_aux.ElasticInOutCurve _: return ConstantTween<$aux_aux.ElasticInOutCurve>(value);
          case $aux_aux.Curves _: return ConstantTween<$aux_aux.Curves>(value);
          case $flutter_5.Animatable _: return ConstantTween<$flutter_5.Animatable>(value);
          case $flutter_5.Tween _: return ConstantTween<$flutter_5.Tween>(value);
          case ReverseTween _: return ConstantTween<ReverseTween>(value);
          case ColorTween _: return ConstantTween<ColorTween>(value);
          case SizeTween _: return ConstantTween<SizeTween>(value);
          case RectTween _: return ConstantTween<RectTween>(value);
          case IntTween _: return ConstantTween<IntTween>(value);
          case StepTween _: return ConstantTween<StepTween>(value);
          case CurveTween _: return ConstantTween<CurveTween>(value);
          case $flutter_9.Simulation _: return ConstantTween<$flutter_9.Simulation>(value);
          case $flutter_10.SpringDescription _: return ConstantTween<$flutter_10.SpringDescription>(value);
          case AnimationController _: return ConstantTween<AnimationController>(value);
          case $flutter_3.AnimationStyle _: return ConstantTween<$flutter_3.AnimationStyle>(value);
          case AlwaysStoppedAnimation _: return ConstantTween<AlwaysStoppedAnimation>(value);
          case AnimationWithParentMixin _: return ConstantTween<AnimationWithParentMixin>(value);
          case ProxyAnimation _: return ConstantTween<ProxyAnimation>(value);
          case ReverseAnimation _: return ConstantTween<ReverseAnimation>(value);
          case CurvedAnimation _: return ConstantTween<CurvedAnimation>(value);
          case TrainHoppingAnimation _: return ConstantTween<TrainHoppingAnimation>(value);
          case CompoundAnimation _: return ConstantTween<CompoundAnimation>(value);
          case AnimationMean _: return ConstantTween<AnimationMean>(value);
          case AnimationMax _: return ConstantTween<AnimationMax>(value);
          case AnimationMin _: return ConstantTween<AnimationMin>(value);
          case AnimationLazyListenerMixin _: return ConstantTween<AnimationLazyListenerMixin>(value);
          case AnimationEagerListenerMixin _: return ConstantTween<AnimationEagerListenerMixin>(value);
          case AnimationLocalListenersMixin _: return ConstantTween<AnimationLocalListenersMixin>(value);
          case AnimationLocalStatusListenersMixin _: return ConstantTween<AnimationLocalStatusListenersMixin>(value);
          case TweenSequence _: return ConstantTween<TweenSequence>(value);
          case FlippedTweenSequence _: return ConstantTween<FlippedTweenSequence>(value);
          case $flutter_6.TweenSequenceItem _: return ConstantTween<$flutter_6.TweenSequenceItem>(value);
          default: return ConstantTween(value);
        }
      },
    },
    getters: {
      'begin': (visitor, target) => D4.validateTarget<ConstantTween>(target, 'ConstantTween').begin,
      'end': (visitor, target) => D4.validateTarget<ConstantTween>(target, 'ConstantTween').end,
    },
    setters: {
      'begin': (visitor, target, value) => 
        D4.validateTarget<ConstantTween>(target, 'ConstantTween').begin = value as dynamic,
      'end': (visitor, target, value) => 
        D4.validateTarget<ConstantTween>(target, 'ConstantTween').end = value as dynamic,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'lerp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConstantTween>(target, 'ConstantTween');
        D4.requireMinArgs(positional, 1, 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'lerp');
        return t.lerp(t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ConstantTween>(target, 'ConstantTween');
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
    nativeType: CurveTween,
    name: 'CurveTween',
    isAssignable: (v) => v is CurveTween,
    constructors: {
      '': (visitor, positional, named) {
        final curve = D4.getRequiredNamedArg<$flutter_4.Curve>(named, 'curve', 'CurveTween');
        return CurveTween(curve: curve);
      },
    },
    getters: {
      'curve': (visitor, target) => D4.validateTarget<CurveTween>(target, 'CurveTween').curve,
    },
    setters: {
      'curve': (visitor, target, value) => 
        D4.validateTarget<CurveTween>(target, 'CurveTween').curve = D4.extractBridgedArg<$flutter_4.Curve>(value, 'curve'),
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurveTween>(target, 'CurveTween');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurveTween>(target, 'CurveTween');
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
    nativeType: $flutter_9.Simulation,
    name: 'Simulation',
    isAssignable: (v) => v is $flutter_9.Simulation,
    constructors: {
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_9.Simulation>(target, 'Simulation').tolerance,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_9.Simulation>(target, 'Simulation').tolerance = D4.extractBridgedArg<$flutter_11.Tolerance>(value, 'tolerance'),
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.Simulation>(target, 'Simulation');
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
    nativeType: $flutter_10.SpringDescription,
    name: 'SpringDescription',
    isAssignable: (v) => v is $flutter_10.SpringDescription,
    constructors: {
      '': (visitor, positional, named) {
        final mass = D4.getRequiredNamedArg<double>(named, 'mass', 'SpringDescription');
        final stiffness = D4.getRequiredNamedArg<double>(named, 'stiffness', 'SpringDescription');
        final damping = D4.getRequiredNamedArg<double>(named, 'damping', 'SpringDescription');
        return $flutter_10.SpringDescription(mass: mass, stiffness: stiffness, damping: damping);
      },
      'withDampingRatio': (visitor, positional, named) {
        final mass = D4.getRequiredNamedArg<double>(named, 'mass', 'SpringDescription');
        final stiffness = D4.getRequiredNamedArg<double>(named, 'stiffness', 'SpringDescription');
        final ratio = D4.getNamedArgWithDefault<double>(named, 'ratio', 1.0);
        return $flutter_10.SpringDescription.withDampingRatio(mass: mass, stiffness: stiffness, ratio: ratio);
      },
      'withDurationAndBounce': (visitor, positional, named) {
        final duration = D4.getNamedArgWithDefault<Duration>(named, 'duration', const Duration(milliseconds: 500));
        final bounce = D4.getNamedArgWithDefault<double>(named, 'bounce', 0.0);
        return $flutter_10.SpringDescription.withDurationAndBounce(duration: duration, bounce: bounce);
      },
    },
    getters: {
      'mass': (visitor, target) => D4.validateTarget<$flutter_10.SpringDescription>(target, 'SpringDescription').mass,
      'stiffness': (visitor, target) => D4.validateTarget<$flutter_10.SpringDescription>(target, 'SpringDescription').stiffness,
      'damping': (visitor, target) => D4.validateTarget<$flutter_10.SpringDescription>(target, 'SpringDescription').damping,
      'duration': (visitor, target) => D4.validateTarget<$flutter_10.SpringDescription>(target, 'SpringDescription').duration,
      'bounce': (visitor, target) => D4.validateTarget<$flutter_10.SpringDescription>(target, 'SpringDescription').bounce,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.SpringDescription>(target, 'SpringDescription');
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
    nativeType: AnimationController,
    name: 'AnimationController',
    isAssignable: (v) => v is AnimationController,
    constructors: {
      '': (visitor, positional, named) {
        final value = D4.getOptionalNamedArg<double?>(named, 'value');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseDuration = D4.getOptionalNamedArg<Duration?>(named, 'reverseDuration');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final lowerBound = D4.getNamedArgWithDefault<double>(named, 'lowerBound', 0.0);
        final upperBound = D4.getNamedArgWithDefault<double>(named, 'upperBound', 1.0);
        final animationBehavior = D4.getNamedArgWithDefault<$flutter_2.AnimationBehavior>(named, 'animationBehavior', $flutter_2.AnimationBehavior.normal);
        final vsync = D4.getRequiredNamedArg<$flutter_12.TickerProvider>(named, 'vsync', 'AnimationController');
        return AnimationController(value: value, duration: duration, reverseDuration: reverseDuration, debugLabel: debugLabel, lowerBound: lowerBound, upperBound: upperBound, animationBehavior: animationBehavior, vsync: vsync);
      },
      'unbounded': (visitor, positional, named) {
        final value = D4.getNamedArgWithDefault<double>(named, 'value', 0.0);
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseDuration = D4.getOptionalNamedArg<Duration?>(named, 'reverseDuration');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final vsync = D4.getRequiredNamedArg<$flutter_12.TickerProvider>(named, 'vsync', 'AnimationController');
        final animationBehavior = D4.getNamedArgWithDefault<$flutter_2.AnimationBehavior>(named, 'animationBehavior', $flutter_2.AnimationBehavior.preserve);
        return AnimationController.unbounded(value: value, duration: duration, reverseDuration: reverseDuration, debugLabel: debugLabel, vsync: vsync, animationBehavior: animationBehavior);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').status,
      'value': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').value,
      'isDismissed': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').isForwardOrCompleted,
      'lowerBound': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').lowerBound,
      'upperBound': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').upperBound,
      'debugLabel': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').debugLabel,
      'animationBehavior': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').animationBehavior,
      'view': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').view,
      'duration': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').duration,
      'reverseDuration': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').reverseDuration,
      'velocity': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').velocity,
      'lastElapsedDuration': (visitor, target) => D4.validateTarget<AnimationController>(target, 'AnimationController').lastElapsedDuration,
    },
    setters: {
      'duration': (visitor, target, value) => 
        D4.validateTarget<AnimationController>(target, 'AnimationController').duration = D4.extractBridgedArgOrNull<Duration>(value, 'duration'),
      'reverseDuration': (visitor, target, value) => 
        D4.validateTarget<AnimationController>(target, 'AnimationController').reverseDuration = D4.extractBridgedArgOrNull<Duration>(value, 'reverseDuration'),
      'value': (visitor, target, value) => 
        D4.validateTarget<AnimationController>(target, 'AnimationController').value = D4.extractBridgedArg<double>(value, 'value'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        return t.toStringDetails();
      },
      'resync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'resync');
        final vsync = D4.getRequiredArg<$flutter_12.TickerProvider>(positional, 0, 'vsync', 'resync');
        t.resync(vsync);
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        t.reset();
        return null;
      },
      'forward': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        final from = D4.getOptionalNamedArg<double?>(named, 'from');
        return t.forward(from: from);
      },
      'reverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        final from = D4.getOptionalNamedArg<double?>(named, 'from');
        return t.reverse(from: from);
      },
      'toggle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        final from = D4.getOptionalNamedArg<double?>(named, 'from');
        return t.toggle(from: from);
      },
      'animateTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateTo');
        final target_ = D4.getRequiredArg<double>(positional, 0, 'target', 'animateTo');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final curve = D4.getNamedArgWithDefault<$flutter_4.Curve>(named, 'curve', $aux_aux.Curves.linear);
        return t.animateTo(target_, duration: duration, curve: curve);
      },
      'animateBack': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateBack');
        final target_ = D4.getRequiredArg<double>(positional, 0, 'target', 'animateBack');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final curve = D4.getNamedArgWithDefault<$flutter_4.Curve>(named, 'curve', $aux_aux.Curves.linear);
        return t.animateBack(target_, duration: duration, curve: curve);
      },
      'repeat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        final min = D4.getOptionalNamedArg<double?>(named, 'min');
        final max = D4.getOptionalNamedArg<double?>(named, 'max');
        final reverse = D4.getNamedArgWithDefault<bool>(named, 'reverse', false);
        final period = D4.getOptionalNamedArg<Duration?>(named, 'period');
        final count = D4.getOptionalNamedArg<int?>(named, 'count');
        return t.repeat(min: min, max: max, reverse: reverse, period: period, count: count);
      },
      'fling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        final velocity = D4.getNamedArgWithDefault<double>(named, 'velocity', 1.0);
        final springDescription = D4.getOptionalNamedArg<$flutter_10.SpringDescription?>(named, 'springDescription');
        final animationBehavior = D4.getOptionalNamedArg<$flutter_2.AnimationBehavior?>(named, 'animationBehavior');
        return t.fling(velocity: velocity, springDescription: springDescription, animationBehavior: animationBehavior);
      },
      'animateWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateWith');
        final simulation = D4.getRequiredArg<$flutter_9.Simulation>(positional, 0, 'simulation', 'animateWith');
        return t.animateWith(simulation);
      },
      'animateBackWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        D4.requireMinArgs(positional, 1, 'animateBackWith');
        final simulation = D4.getRequiredArg<$flutter_9.Simulation>(positional, 0, 'simulation', 'animateBackWith');
        return t.animateBackWith(simulation);
      },
      'stop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        final canceled = D4.getNamedArgWithDefault<bool>(named, 'canceled', true);
        t.stop(canceled: canceled);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        (t as dynamic).dispose();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationController>(target, 'AnimationController');
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
        final curve = D4.getOptionalNamedArg<$flutter_4.Curve?>(named, 'curve');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseCurve = D4.getOptionalNamedArg<$flutter_4.Curve?>(named, 'reverseCurve');
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
        final curve = D4.getOptionalNamedArg<$flutter_4.Curve?>(named, 'curve');
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final reverseCurve = D4.getOptionalNamedArg<$flutter_4.Curve?>(named, 'reverseCurve');
        final reverseDuration = D4.getOptionalNamedArg<Duration?>(named, 'reverseDuration');
        return t.copyWith(curve: curve, duration: duration, reverseCurve: reverseCurve, reverseDuration: reverseDuration);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_8.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_8.DiagnosticLevel>(named, 'minLevel', $flutter_8.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.AnimationStyle>(target, 'AnimationStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_8.DiagnosticsTreeStyle?>(named, 'style');
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
    nativeType: AlwaysStoppedAnimation,
    name: 'AlwaysStoppedAnimation',
    isAssignable: (v) => v is AlwaysStoppedAnimation,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AlwaysStoppedAnimation');
        final value = D4.getRequiredArg<dynamic>(positional, 0, 'value', 'AlwaysStoppedAnimation');
        // GEN-075: Preserve generic type parameter from runtime value
        switch (value) {
          case double _: return AlwaysStoppedAnimation<double>(value);
          case int _: return AlwaysStoppedAnimation<int>(value);
          case String _: return AlwaysStoppedAnimation<String>(value);
          case bool _: return AlwaysStoppedAnimation<bool>(value);
          case $flutter_12.TickerProvider _: return AlwaysStoppedAnimation<$flutter_12.TickerProvider>(value);
          case $flutter_12.TickerFuture _: return AlwaysStoppedAnimation<$flutter_12.TickerFuture>(value);
          case TickerCanceled _: return AlwaysStoppedAnimation<TickerCanceled>(value);
          case $flutter_1.Animation _: return AlwaysStoppedAnimation<$flutter_1.Animation>(value);
          case $aux_aux.ParametricCurve _: return AlwaysStoppedAnimation<$aux_aux.ParametricCurve>(value);
          case $aux_aux.Curve _: return AlwaysStoppedAnimation<$aux_aux.Curve>(value);
          case $aux_aux.SawTooth _: return AlwaysStoppedAnimation<$aux_aux.SawTooth>(value);
          case $aux_aux.Interval _: return AlwaysStoppedAnimation<$aux_aux.Interval>(value);
          case $aux_aux.Split _: return AlwaysStoppedAnimation<$aux_aux.Split>(value);
          case $aux_aux.Threshold _: return AlwaysStoppedAnimation<$aux_aux.Threshold>(value);
          case $aux_aux.Cubic _: return AlwaysStoppedAnimation<$aux_aux.Cubic>(value);
          case $aux_aux.ThreePointCubic _: return AlwaysStoppedAnimation<$aux_aux.ThreePointCubic>(value);
          case $aux_aux.Curve2D _: return AlwaysStoppedAnimation<$aux_aux.Curve2D>(value);
          case $aux_aux.Curve2DSample _: return AlwaysStoppedAnimation<$aux_aux.Curve2DSample>(value);
          case $aux_aux.CatmullRomSpline _: return AlwaysStoppedAnimation<$aux_aux.CatmullRomSpline>(value);
          case $aux_aux.CatmullRomCurve _: return AlwaysStoppedAnimation<$aux_aux.CatmullRomCurve>(value);
          case $aux_aux.FlippedCurve _: return AlwaysStoppedAnimation<$aux_aux.FlippedCurve>(value);
          case $aux_aux.ElasticInCurve _: return AlwaysStoppedAnimation<$aux_aux.ElasticInCurve>(value);
          case $aux_aux.ElasticOutCurve _: return AlwaysStoppedAnimation<$aux_aux.ElasticOutCurve>(value);
          case $aux_aux.ElasticInOutCurve _: return AlwaysStoppedAnimation<$aux_aux.ElasticInOutCurve>(value);
          case $aux_aux.Curves _: return AlwaysStoppedAnimation<$aux_aux.Curves>(value);
          case $flutter_5.Animatable _: return AlwaysStoppedAnimation<$flutter_5.Animatable>(value);
          case $flutter_5.Tween _: return AlwaysStoppedAnimation<$flutter_5.Tween>(value);
          case ReverseTween _: return AlwaysStoppedAnimation<ReverseTween>(value);
          case ColorTween _: return AlwaysStoppedAnimation<ColorTween>(value);
          case SizeTween _: return AlwaysStoppedAnimation<SizeTween>(value);
          case RectTween _: return AlwaysStoppedAnimation<RectTween>(value);
          case IntTween _: return AlwaysStoppedAnimation<IntTween>(value);
          case StepTween _: return AlwaysStoppedAnimation<StepTween>(value);
          case ConstantTween _: return AlwaysStoppedAnimation<ConstantTween>(value);
          case CurveTween _: return AlwaysStoppedAnimation<CurveTween>(value);
          case $flutter_9.Simulation _: return AlwaysStoppedAnimation<$flutter_9.Simulation>(value);
          case $flutter_10.SpringDescription _: return AlwaysStoppedAnimation<$flutter_10.SpringDescription>(value);
          case AnimationController _: return AlwaysStoppedAnimation<AnimationController>(value);
          case $flutter_3.AnimationStyle _: return AlwaysStoppedAnimation<$flutter_3.AnimationStyle>(value);
          case AnimationWithParentMixin _: return AlwaysStoppedAnimation<AnimationWithParentMixin>(value);
          case ProxyAnimation _: return AlwaysStoppedAnimation<ProxyAnimation>(value);
          case ReverseAnimation _: return AlwaysStoppedAnimation<ReverseAnimation>(value);
          case CurvedAnimation _: return AlwaysStoppedAnimation<CurvedAnimation>(value);
          case TrainHoppingAnimation _: return AlwaysStoppedAnimation<TrainHoppingAnimation>(value);
          case CompoundAnimation _: return AlwaysStoppedAnimation<CompoundAnimation>(value);
          case AnimationMean _: return AlwaysStoppedAnimation<AnimationMean>(value);
          case AnimationMax _: return AlwaysStoppedAnimation<AnimationMax>(value);
          case AnimationMin _: return AlwaysStoppedAnimation<AnimationMin>(value);
          case AnimationLazyListenerMixin _: return AlwaysStoppedAnimation<AnimationLazyListenerMixin>(value);
          case AnimationEagerListenerMixin _: return AlwaysStoppedAnimation<AnimationEagerListenerMixin>(value);
          case AnimationLocalListenersMixin _: return AlwaysStoppedAnimation<AnimationLocalListenersMixin>(value);
          case AnimationLocalStatusListenersMixin _: return AlwaysStoppedAnimation<AnimationLocalStatusListenersMixin>(value);
          case TweenSequence _: return AlwaysStoppedAnimation<TweenSequence>(value);
          case FlippedTweenSequence _: return AlwaysStoppedAnimation<FlippedTweenSequence>(value);
          case $flutter_6.TweenSequenceItem _: return AlwaysStoppedAnimation<$flutter_6.TweenSequenceItem>(value);
          default: return AlwaysStoppedAnimation(value);
        }
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').status,
      'value': (visitor, target) => D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation').isForwardOrCompleted,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AlwaysStoppedAnimation>(target, 'AlwaysStoppedAnimation');
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
    nativeType: AnimationWithParentMixin,
    name: 'AnimationWithParentMixin',
    isAssignable: (v) => v is AnimationWithParentMixin,
    constructors: {
    },
    getters: {
      'parent': (visitor, target) => D4.validateTarget<AnimationWithParentMixin>(target, 'AnimationWithParentMixin').parent,
      'status': (visitor, target) => D4.validateTarget<AnimationWithParentMixin>(target, 'AnimationWithParentMixin').status,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationWithParentMixin>(target, 'AnimationWithParentMixin');
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
    nativeType: ProxyAnimation,
    name: 'ProxyAnimation',
    isAssignable: (v) => v is ProxyAnimation,
    constructors: {
      '': (visitor, positional, named) {
        final animation = D4.getOptionalArg<$flutter_1.Animation<double>?>(positional, 0, 'animation');
        return ProxyAnimation(animation);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').status,
      'value': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').isForwardOrCompleted,
      'parent': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').parent,
      'isListening': (visitor, target) => D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').isListening,
    },
    setters: {
      'parent': (visitor, target, value) => 
        D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation').parent = D4.extractBridgedArgOrNull<$flutter_1.Animation<double>>(value, 'parent'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ProxyAnimation>(target, 'ProxyAnimation');
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
    nativeType: ReverseAnimation,
    name: 'ReverseAnimation',
    isAssignable: (v) => v is ReverseAnimation,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReverseAnimation');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'ReverseAnimation');
        return ReverseAnimation(parent);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').status,
      'value': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').isForwardOrCompleted,
      'parent': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').parent,
      'isListening': (visitor, target) => D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ReverseAnimation>(target, 'ReverseAnimation');
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
    nativeType: CurvedAnimation,
    name: 'CurvedAnimation',
    isAssignable: (v) => v is CurvedAnimation,
    constructors: {
      '': (visitor, positional, named) {
        final parent = D4.getRequiredNamedArg<$flutter_1.Animation<double>>(named, 'parent', 'CurvedAnimation');
        final curve = D4.getRequiredNamedArg<$flutter_4.Curve>(named, 'curve', 'CurvedAnimation');
        final reverseCurve = D4.getOptionalNamedArg<$flutter_4.Curve?>(named, 'reverseCurve');
        return CurvedAnimation(parent: parent, curve: curve, reverseCurve: reverseCurve);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').status,
      'value': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').isForwardOrCompleted,
      'parent': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').parent,
      'curve': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').curve,
      'reverseCurve': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').reverseCurve,
      'isDisposed': (visitor, target) => D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').isDisposed,
    },
    setters: {
      'curve': (visitor, target, value) => 
        D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').curve = D4.extractBridgedArg<$flutter_4.Curve>(value, 'curve'),
      'reverseCurve': (visitor, target, value) => 
        D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').reverseCurve = D4.extractBridgedArgOrNull<$flutter_4.Curve>(value, 'reverseCurve'),
      'isDisposed': (visitor, target, value) => 
        D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation').isDisposed = D4.extractBridgedArg<bool>(value, 'isDisposed'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
        return t.toStringDetails();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CurvedAnimation>(target, 'CurvedAnimation');
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
    nativeType: TrainHoppingAnimation,
    name: 'TrainHoppingAnimation',
    isAssignable: (v) => v is TrainHoppingAnimation,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TrainHoppingAnimation');
        final currentTrain = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, '_currentTrain', 'TrainHoppingAnimation');
        final nextTrain = D4.getRequiredArg<$flutter_1.Animation<double>?>(positional, 1, '_nextTrain', 'TrainHoppingAnimation');
        final onSwitchedTrainRaw = named['onSwitchedTrain'];
        return TrainHoppingAnimation(currentTrain, nextTrain, onSwitchedTrain: onSwitchedTrainRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSwitchedTrainRaw, []); });
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').status,
      'value': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').isForwardOrCompleted,
      'currentTrain': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').currentTrain,
      'onSwitchedTrain': (visitor, target) => D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').onSwitchedTrain,
    },
    setters: {
      'onSwitchedTrain': (visitor, target, value) {
        final onSwitchedTrainRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSwitchedTrain');
        D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation').onSwitchedTrain = onSwitchedTrainRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSwitchedTrainRaw, []); };
      },
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        return t.toStringDetails();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        (t as dynamic).dispose();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TrainHoppingAnimation>(target, 'TrainHoppingAnimation');
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
    nativeType: CompoundAnimation,
    name: 'CompoundAnimation',
    isAssignable: (v) => v is CompoundAnimation,
    constructors: {
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').status,
      'value': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').value,
      'isDismissed': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').first,
      'next': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').next,
      'isListening': (visitor, target) => D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CompoundAnimation>(target, 'CompoundAnimation');
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
    nativeType: AnimationMean,
    name: 'AnimationMean',
    isAssignable: (v) => v is AnimationMean,
    constructors: {
      '': (visitor, positional, named) {
        final left = D4.getRequiredNamedArg<$flutter_1.Animation<double>>(named, 'left', 'AnimationMean');
        final right = D4.getRequiredNamedArg<$flutter_1.Animation<double>>(named, 'right', 'AnimationMean');
        return AnimationMean(left: left, right: right);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').status,
      'value': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').value,
      'isDismissed': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').first,
      'next': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').next,
      'isListening': (visitor, target) => D4.validateTarget<AnimationMean>(target, 'AnimationMean').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMean>(target, 'AnimationMean');
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
    nativeType: AnimationMax,
    name: 'AnimationMax',
    isAssignable: (v) => v is AnimationMax,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AnimationMax');
        final first = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 0, 'first', 'AnimationMax');
        final next = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 1, 'next', 'AnimationMax');
        return AnimationMax(first, next);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').status,
      'value': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').value,
      'isDismissed': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').first,
      'next': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').next,
      'isListening': (visitor, target) => D4.validateTarget<AnimationMax>(target, 'AnimationMax').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMax>(target, 'AnimationMax');
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
    nativeType: AnimationMin,
    name: 'AnimationMin',
    isAssignable: (v) => v is AnimationMin,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AnimationMin');
        final first = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 0, 'first', 'AnimationMin');
        final next = D4.getRequiredArg<$flutter_1.Animation<num>>(positional, 1, 'next', 'AnimationMin');
        return AnimationMin(first, next);
      },
    },
    getters: {
      'status': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').status,
      'value': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').value,
      'isDismissed': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').isDismissed,
      'isCompleted': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').isCompleted,
      'isAnimating': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').isAnimating,
      'isForwardOrCompleted': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').isForwardOrCompleted,
      'first': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').first,
      'next': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').next,
      'isListening': (visitor, target) => D4.validateTarget<AnimationMin>(target, 'AnimationMin').isListening,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'drive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        D4.requireMinArgs(positional, 1, 'drive');
        final child = D4.getRequiredArg<$flutter_5.Animatable<dynamic>>(positional, 0, 'child', 'drive');
        return t.drive(child);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        return t.toString();
      },
      'toStringDetails': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        return t.toStringDetails();
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        t.didStopListening();
        return null;
      },
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        t.didUnregisterListener();
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        t.notifyListeners();
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationMin>(target, 'AnimationMin');
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
    nativeType: AnimationLazyListenerMixin,
    name: 'AnimationLazyListenerMixin',
    isAssignable: (v) => v is AnimationLazyListenerMixin,
    constructors: {
    },
    getters: {
      'isListening': (visitor, target) => D4.validateTarget<AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin').isListening,
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
        t.didUnregisterListener();
        return null;
      },
      'didStartListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
        t.didStartListening();
        return null;
      },
      'didStopListening': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLazyListenerMixin>(target, 'AnimationLazyListenerMixin');
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
    nativeType: AnimationEagerListenerMixin,
    name: 'AnimationEagerListenerMixin',
    isAssignable: (v) => v is AnimationEagerListenerMixin,
    constructors: {
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationEagerListenerMixin>(target, 'AnimationEagerListenerMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationEagerListenerMixin>(target, 'AnimationEagerListenerMixin');
        t.didUnregisterListener();
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationEagerListenerMixin>(target, 'AnimationEagerListenerMixin');
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
    nativeType: AnimationLocalListenersMixin,
    name: 'AnimationLocalListenersMixin',
    isAssignable: (v) => v is AnimationLocalListenersMixin,
    constructors: {
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        t.didUnregisterListener();
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'clearListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
        t.clearListeners();
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalListenersMixin>(target, 'AnimationLocalListenersMixin');
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
    nativeType: AnimationLocalStatusListenersMixin,
    name: 'AnimationLocalStatusListenersMixin',
    isAssignable: (v) => v is AnimationLocalStatusListenersMixin,
    constructors: {
    },
    methods: {
      'didRegisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        t.didRegisterListener();
        return null;
      },
      'didUnregisterListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        t.didUnregisterListener();
        return null;
      },
      'addStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        D4.requireMinArgs(positional, 1, 'addStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('addStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeStatusListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        D4.requireMinArgs(positional, 1, 'removeStatusListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeStatusListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeStatusListener(($flutter_1.AnimationStatus p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'clearStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
        t.clearStatusListeners();
        return null;
      },
      'notifyStatusListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnimationLocalStatusListenersMixin>(target, 'AnimationLocalStatusListenersMixin');
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
    nativeType: TweenSequence,
    name: 'TweenSequence',
    isAssignable: (v) => v is TweenSequence,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TweenSequence');
        if (positional.isEmpty) {
          throw ArgumentError('TweenSequence: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<$flutter_6.TweenSequenceItem<dynamic>>(positional[0], 'items');
        return TweenSequence(items);
      },
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TweenSequence>(target, 'TweenSequence');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TweenSequence>(target, 'TweenSequence');
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
    nativeType: FlippedTweenSequence,
    name: 'FlippedTweenSequence',
    isAssignable: (v) => v is FlippedTweenSequence,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FlippedTweenSequence');
        if (positional.isEmpty) {
          throw ArgumentError('FlippedTweenSequence: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<$flutter_6.TweenSequenceItem<double>>(positional[0], 'items');
        return FlippedTweenSequence(items);
      },
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(t_);
      },
      'evaluate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'evaluate');
        final animation = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'animation', 'evaluate');
        return t.evaluate(animation);
      },
      'animate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'animate');
        final parent = D4.getRequiredArg<$flutter_1.Animation<double>>(positional, 0, 'parent', 'animate');
        return t.animate(parent);
      },
      'chain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlippedTweenSequence>(target, 'FlippedTweenSequence');
        D4.requireMinArgs(positional, 1, 'chain');
        final parent = D4.getRequiredArg<$flutter_5.Animatable<double>>(positional, 0, 'parent', 'chain');
        return t.chain(parent);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FlippedTweenSequence>(target, 'FlippedTweenSequence');
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
    nativeType: $flutter_6.TweenSequenceItem,
    name: 'TweenSequenceItem',
    isAssignable: (v) => v is $flutter_6.TweenSequenceItem,
    constructors: {
      '': (visitor, positional, named) {
        final tween = D4.getRequiredNamedArg<$flutter_5.Animatable<dynamic>>(named, 'tween', 'TweenSequenceItem');
        final weight = D4.getRequiredNamedArg<double>(named, 'weight', 'TweenSequenceItem');
        return $flutter_6.TweenSequenceItem(tween: tween, weight: weight);
      },
    },
    getters: {
      'tween': (visitor, target) => D4.validateTarget<$flutter_6.TweenSequenceItem>(target, 'TweenSequenceItem').tween,
      'weight': (visitor, target) => D4.validateTarget<$flutter_6.TweenSequenceItem>(target, 'TweenSequenceItem').weight,
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

