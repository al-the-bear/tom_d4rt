// D4rt Bridge - Generated file, do not edit
// Sources: 34 files
// Generated: 2026-02-28T12:39:34.227427

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:math' as $dart_math;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/assertions.dart' as $flutter_1;
import 'package:flutter/src/foundation/basic_types.dart' as $flutter_2;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_3;
import 'package:flutter/src/gestures/arena.dart' as $flutter_4;
import 'package:flutter/src/gestures/binding.dart' as $flutter_5;
import 'package:flutter/src/gestures/constants.dart' as $flutter_6;
import 'package:flutter/src/gestures/converter.dart' as $flutter_7;
import 'package:flutter/src/gestures/debug.dart' as $flutter_8;
import 'package:flutter/src/gestures/drag.dart' as $flutter_9;
import 'package:flutter/src/gestures/drag_details.dart' as $flutter_10;
import 'package:flutter/src/gestures/eager.dart' as $flutter_11;
import 'package:flutter/src/gestures/events.dart' as $flutter_12;
import 'package:flutter/src/gestures/force_press.dart' as $flutter_13;
import 'package:flutter/src/gestures/gesture_details.dart' as $flutter_14;
import 'package:flutter/src/gestures/gesture_settings.dart' as $flutter_15;
import 'package:flutter/src/gestures/hit_test.dart' as $flutter_16;
import 'package:flutter/src/gestures/long_press.dart' as $flutter_17;
import 'package:flutter/src/gestures/lsq_solver.dart' as $flutter_18;
import 'package:flutter/src/gestures/monodrag.dart' as $flutter_19;
import 'package:flutter/src/gestures/multidrag.dart' as $flutter_20;
import 'package:flutter/src/gestures/multitap.dart' as $flutter_21;
import 'package:flutter/src/gestures/pointer_router.dart' as $flutter_22;
import 'package:flutter/src/gestures/pointer_signal_resolver.dart' as $flutter_23;
import 'package:flutter/src/gestures/recognizer.dart' as $flutter_24;
import 'package:flutter/src/gestures/resampler.dart' as $flutter_25;
import 'package:flutter/src/gestures/scale.dart' as $flutter_26;
import 'package:flutter/src/gestures/tap.dart' as $flutter_27;
import 'package:flutter/src/gestures/tap_and_drag.dart' as $flutter_28;
import 'package:flutter/src/gestures/team.dart' as $flutter_29;
import 'package:flutter/src/gestures/velocity_tracker.dart' as $flutter_30;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;
import 'package:flutter/src/foundation/binding.dart' as $aux_flutter;

/// Bridge class for flutter_gestures module.
class FlutterGesturesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createGestureArenaMemberBridge(),
      _createGestureArenaEntryBridge(),
      _createGestureArenaManagerBridge(),
      _createDiagnosticsNodeBridge(),
      _createDiagnosticPropertiesBuilderBridge(),
      _createMatrix4Bridge(),
      _createDeviceGestureSettingsBridge(),
      _createPointerEventBridge(),
      _createPointerDownEventBridge(),
      _createPointerUpEventBridge(),
      _createPointerSignalEventBridge(),
      _createPointerPanZoomStartEventBridge(),
      _createPointerCancelEventBridge(),
      _createHitTestTargetBridge(),
      _createHitTestEntryBridge(),
      _createHitTestResultBridge(),
      _createPointerRouterBridge(),
      _createPointerSignalResolverBridge(),
      _createSamplingClockBridge(),
      _createGestureBindingBridge(),
      _createFlutterErrorDetailsForPointerEventDispatcherBridge(),
      _createPointerEventConverterBridge(),
      _createVelocityBridge(),
      _createDragUpdateDetailsBridge(),
      _createDragEndDetailsBridge(),
      _createDragBridge(),
      _createEagerGestureRecognizerBridge(),
      _createForcePressDetailsBridge(),
      _createForcePressGestureRecognizerBridge(),
      _createPositionedGestureDetailsBridge(),
      _createLongPressDownDetailsBridge(),
      _createLongPressStartDetailsBridge(),
      _createLongPressMoveUpdateDetailsBridge(),
      _createLongPressEndDetailsBridge(),
      _createLongPressGestureRecognizerBridge(),
      _createPolynomialFitBridge(),
      _createLeastSquaresSolverBridge(),
      _createGestureArenaTeamBridge(),
      _createDragGestureRecognizerBridge(),
      _createVerticalDragGestureRecognizerBridge(),
      _createHorizontalDragGestureRecognizerBridge(),
      _createPanGestureRecognizerBridge(),
      _createMultiDragPointerStateBridge(),
      _createMultiDragGestureRecognizerBridge(),
      _createImmediateMultiDragGestureRecognizerBridge(),
      _createHorizontalMultiDragGestureRecognizerBridge(),
      _createVerticalMultiDragGestureRecognizerBridge(),
      _createDelayedMultiDragGestureRecognizerBridge(),
      _createTapDownDetailsBridge(),
      _createTapUpDetailsBridge(),
      _createDoubleTapGestureRecognizerBridge(),
      _createMultiTapGestureRecognizerBridge(),
      _createSerialTapDownDetailsBridge(),
      _createSerialTapCancelDetailsBridge(),
      _createSerialTapUpDetailsBridge(),
      _createSerialTapGestureRecognizerBridge(),
      _createPointerEventResamplerBridge(),
      _createScaleStartDetailsBridge(),
      _createScaleUpdateDetailsBridge(),
      _createScaleEndDetailsBridge(),
      _createScaleGestureRecognizerBridge(),
      _createTapDragDownDetailsBridge(),
      _createTapDragUpDetailsBridge(),
      _createTapDragStartDetailsBridge(),
      _createTapDragUpdateDetailsBridge(),
      _createTapDragEndDetailsBridge(),
      _createBaseTapAndDragGestureRecognizerBridge(),
      _createTapAndHorizontalDragGestureRecognizerBridge(),
      _createTapAndPanGestureRecognizerBridge(),
      _createVector3Bridge(),
      _createVector2Bridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'GestureArenaMember': 'package:flutter/src/gestures/arena.dart',
      'GestureArenaEntry': 'package:flutter/src/gestures/arena.dart',
      'GestureArenaManager': 'package:flutter/src/gestures/arena.dart',
      'DiagnosticsNode': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticPropertiesBuilder': 'package:flutter/src/foundation/diagnostics.dart',
      'Matrix4': 'package:vector_math/vector_math_64.dart',
      'DeviceGestureSettings': 'package:flutter/src/gestures/gesture_settings.dart',
      'PointerEvent': 'package:flutter/src/gestures/events.dart',
      'PointerDownEvent': 'package:flutter/src/gestures/events.dart',
      'PointerUpEvent': 'package:flutter/src/gestures/events.dart',
      'PointerSignalEvent': 'package:flutter/src/gestures/events.dart',
      'PointerPanZoomStartEvent': 'package:flutter/src/gestures/events.dart',
      'PointerCancelEvent': 'package:flutter/src/gestures/events.dart',
      'HitTestTarget': 'package:flutter/src/gestures/hit_test.dart',
      'HitTestEntry': 'package:flutter/src/gestures/hit_test.dart',
      'HitTestResult': 'package:flutter/src/gestures/hit_test.dart',
      'PointerRouter': 'package:flutter/src/gestures/pointer_router.dart',
      'PointerSignalResolver': 'package:flutter/src/gestures/pointer_signal_resolver.dart',
      'SamplingClock': 'package:flutter/src/gestures/binding.dart',
      'GestureBinding': 'package:flutter/src/gestures/binding.dart',
      'FlutterErrorDetailsForPointerEventDispatcher': 'package:flutter/src/gestures/binding.dart',
      'PointerEventConverter': 'package:flutter/src/gestures/converter.dart',
      'Velocity': 'package:flutter/src/gestures/velocity_tracker.dart',
      'DragUpdateDetails': 'package:flutter/src/gestures/drag_details.dart',
      'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart',
      'Drag': 'package:flutter/src/gestures/drag.dart',
      'EagerGestureRecognizer': 'package:flutter/src/gestures/eager.dart',
      'ForcePressDetails': 'package:flutter/src/gestures/force_press.dart',
      'ForcePressGestureRecognizer': 'package:flutter/src/gestures/force_press.dart',
      'PositionedGestureDetails': 'package:flutter/src/gestures/gesture_details.dart',
      'LongPressDownDetails': 'package:flutter/src/gestures/long_press.dart',
      'LongPressStartDetails': 'package:flutter/src/gestures/long_press.dart',
      'LongPressMoveUpdateDetails': 'package:flutter/src/gestures/long_press.dart',
      'LongPressEndDetails': 'package:flutter/src/gestures/long_press.dart',
      'LongPressGestureRecognizer': 'package:flutter/src/gestures/long_press.dart',
      'PolynomialFit': 'package:flutter/src/gestures/lsq_solver.dart',
      'LeastSquaresSolver': 'package:flutter/src/gestures/lsq_solver.dart',
      'GestureArenaTeam': 'package:flutter/src/gestures/team.dart',
      'DragGestureRecognizer': 'package:flutter/src/gestures/monodrag.dart',
      'VerticalDragGestureRecognizer': 'package:flutter/src/gestures/monodrag.dart',
      'HorizontalDragGestureRecognizer': 'package:flutter/src/gestures/monodrag.dart',
      'PanGestureRecognizer': 'package:flutter/src/gestures/monodrag.dart',
      'MultiDragPointerState': 'package:flutter/src/gestures/multidrag.dart',
      'MultiDragGestureRecognizer': 'package:flutter/src/gestures/multidrag.dart',
      'ImmediateMultiDragGestureRecognizer': 'package:flutter/src/gestures/multidrag.dart',
      'HorizontalMultiDragGestureRecognizer': 'package:flutter/src/gestures/multidrag.dart',
      'VerticalMultiDragGestureRecognizer': 'package:flutter/src/gestures/multidrag.dart',
      'DelayedMultiDragGestureRecognizer': 'package:flutter/src/gestures/multidrag.dart',
      'TapDownDetails': 'package:flutter/src/gestures/tap.dart',
      'TapUpDetails': 'package:flutter/src/gestures/tap.dart',
      'DoubleTapGestureRecognizer': 'package:flutter/src/gestures/multitap.dart',
      'MultiTapGestureRecognizer': 'package:flutter/src/gestures/multitap.dart',
      'SerialTapDownDetails': 'package:flutter/src/gestures/multitap.dart',
      'SerialTapCancelDetails': 'package:flutter/src/gestures/multitap.dart',
      'SerialTapUpDetails': 'package:flutter/src/gestures/multitap.dart',
      'SerialTapGestureRecognizer': 'package:flutter/src/gestures/multitap.dart',
      'PointerEventResampler': 'package:flutter/src/gestures/resampler.dart',
      'ScaleStartDetails': 'package:flutter/src/gestures/scale.dart',
      'ScaleUpdateDetails': 'package:flutter/src/gestures/scale.dart',
      'ScaleEndDetails': 'package:flutter/src/gestures/scale.dart',
      'ScaleGestureRecognizer': 'package:flutter/src/gestures/scale.dart',
      'TapDragDownDetails': 'package:flutter/src/gestures/tap_and_drag.dart',
      'TapDragUpDetails': 'package:flutter/src/gestures/tap_and_drag.dart',
      'TapDragStartDetails': 'package:flutter/src/gestures/tap_and_drag.dart',
      'TapDragUpdateDetails': 'package:flutter/src/gestures/tap_and_drag.dart',
      'TapDragEndDetails': 'package:flutter/src/gestures/tap_and_drag.dart',
      'BaseTapAndDragGestureRecognizer': 'package:flutter/src/gestures/tap_and_drag.dart',
      'TapAndHorizontalDragGestureRecognizer': 'package:flutter/src/gestures/tap_and_drag.dart',
      'TapAndPanGestureRecognizer': 'package:flutter/src/gestures/tap_and_drag.dart',
      'Vector3': 'package:vector_math/vector_math_64.dart',
      'Vector2': 'package:vector_math/vector_math_64.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_4.GestureDisposition>(
        name: 'GestureDisposition',
        values: $flutter_4.GestureDisposition.values,
      ),
      BridgedEnumDefinition<$flutter_24.DragStartBehavior>(
        name: 'DragStartBehavior',
        values: $flutter_24.DragStartBehavior.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'GestureDisposition': 'package:flutter/src/gestures/arena.dart',
      'DragStartBehavior': 'package:flutter/src/gestures/recognizer.dart',
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
      interpreter.registerGlobalVariable('degrees2Radians', $vector_math_1.degrees2Radians, importPath, sourceUri: 'package:vector_math/src/vector_math_64/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "degrees2Radians": $e');
    }
    try {
      interpreter.registerGlobalVariable('radians2Degrees', $vector_math_1.radians2Degrees, importPath, sourceUri: 'package:vector_math/src/vector_math_64/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "radians2Degrees": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPressTimeout', $flutter_6.kPressTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPressTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kHoverTapTimeout', $flutter_6.kHoverTapTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kHoverTapTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kHoverTapSlop', $flutter_6.kHoverTapSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kHoverTapSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kLongPressTimeout', $flutter_6.kLongPressTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kLongPressTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapTimeout', $flutter_6.kDoubleTapTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapMinTime', $flutter_6.kDoubleTapMinTime, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapMinTime": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapTouchSlop', $flutter_6.kDoubleTapTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapSlop', $flutter_6.kDoubleTapSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kZoomControlsTimeout', $flutter_6.kZoomControlsTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kZoomControlsTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kTouchSlop', $flutter_6.kTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPagingTouchSlop', $flutter_6.kPagingTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPagingTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPanSlop', $flutter_6.kPanSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPanSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kScaleSlop', $flutter_6.kScaleSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kScaleSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowTouchSlop', $flutter_6.kWindowTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMinFlingVelocity', $flutter_6.kMinFlingVelocity, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMinFlingVelocity": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMaxFlingVelocity', $flutter_6.kMaxFlingVelocity, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMaxFlingVelocity": $e');
    }
    try {
      interpreter.registerGlobalVariable('kJumpTapTimeout', $flutter_6.kJumpTapTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kJumpTapTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrecisePointerHitSlop', $flutter_6.kPrecisePointerHitSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrecisePointerHitSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrecisePointerPanSlop', $flutter_6.kPrecisePointerPanSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrecisePointerPanSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrecisePointerScaleSlop', $flutter_6.kPrecisePointerScaleSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrecisePointerScaleSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintHitTestResults', $flutter_8.debugPrintHitTestResults, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintHitTestResults": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintMouseHoverEvents', $flutter_8.debugPrintMouseHoverEvents, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintMouseHoverEvents": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintGestureArenaDiagnostics', $flutter_8.debugPrintGestureArenaDiagnostics, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintGestureArenaDiagnostics": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintRecognizerCallbacksTrace', $flutter_8.debugPrintRecognizerCallbacksTrace, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintRecognizerCallbacksTrace": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintResamplingMargin', $flutter_8.debugPrintResamplingMargin, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintResamplingMargin": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDefaultMouseScrollToScaleFactor', $flutter_26.kDefaultMouseScrollToScaleFactor, importPath, sourceUri: 'package:flutter/src/gestures/scale.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDefaultMouseScrollToScaleFactor": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDefaultTrackpadScrollToScaleFactor', $flutter_26.kDefaultTrackpadScrollToScaleFactor, importPath, sourceUri: 'package:flutter/src/gestures/scale.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDefaultTrackpadScrollToScaleFactor": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_gestures):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'relativeError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'relativeError');
        final calculated = D4.getRequiredArg<dynamic>(positional, 0, 'calculated', 'relativeError');
        final correct = D4.getRequiredArg<dynamic>(positional, 1, 'correct', 'relativeError');
        return $vector_math_1.relativeError(calculated, correct);
      },
      'absoluteError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'absoluteError');
        final calculated = D4.getRequiredArg<dynamic>(positional, 0, 'calculated', 'absoluteError');
        final correct = D4.getRequiredArg<dynamic>(positional, 1, 'correct', 'absoluteError');
        return $vector_math_1.absoluteError(calculated, correct);
      },
      'setRotationMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'setRotationMatrix');
        final rotationMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'rotationMatrix', 'setRotationMatrix');
        final forwardDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'forwardDirection', 'setRotationMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'upDirection', 'setRotationMatrix');
        return $vector_math_1.setRotationMatrix(rotationMatrix, forwardDirection, upDirection);
      },
      'setModelMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'setModelMatrix');
        final modelMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'modelMatrix', 'setModelMatrix');
        final forwardDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'forwardDirection', 'setModelMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'upDirection', 'setModelMatrix');
        final tx = D4.getRequiredArg<double>(positional, 3, 'tx', 'setModelMatrix');
        final ty = D4.getRequiredArg<double>(positional, 4, 'ty', 'setModelMatrix');
        final tz = D4.getRequiredArg<double>(positional, 5, 'tz', 'setModelMatrix');
        return $vector_math_1.setModelMatrix(modelMatrix, forwardDirection, upDirection, tx, ty, tz);
      },
      'setViewMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'setViewMatrix');
        final viewMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'viewMatrix', 'setViewMatrix');
        final cameraPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'cameraPosition', 'setViewMatrix');
        final cameraFocusPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'cameraFocusPosition', 'setViewMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 3, 'upDirection', 'setViewMatrix');
        return $vector_math_1.setViewMatrix(viewMatrix, cameraPosition, cameraFocusPosition, upDirection);
      },
      'makeViewMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'makeViewMatrix');
        final cameraPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'cameraPosition', 'makeViewMatrix');
        final cameraFocusPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'cameraFocusPosition', 'makeViewMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'upDirection', 'makeViewMatrix');
        return $vector_math_1.makeViewMatrix(cameraPosition, cameraFocusPosition, upDirection);
      },
      'setPerspectiveMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 5, 'setPerspectiveMatrix');
        final perspectiveMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'perspectiveMatrix', 'setPerspectiveMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 1, 'fovYRadians', 'setPerspectiveMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 2, 'aspectRatio', 'setPerspectiveMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 3, 'zNear', 'setPerspectiveMatrix');
        final zFar = D4.getRequiredArg<double>(positional, 4, 'zFar', 'setPerspectiveMatrix');
        return $vector_math_1.setPerspectiveMatrix(perspectiveMatrix, fovYRadians, aspectRatio, zNear, zFar);
      },
      'makePerspectiveMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'makePerspectiveMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 0, 'fovYRadians', 'makePerspectiveMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 1, 'aspectRatio', 'makePerspectiveMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 2, 'zNear', 'makePerspectiveMatrix');
        final zFar = D4.getRequiredArg<double>(positional, 3, 'zFar', 'makePerspectiveMatrix');
        return $vector_math_1.makePerspectiveMatrix(fovYRadians, aspectRatio, zNear, zFar);
      },
      'setInfiniteMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'setInfiniteMatrix');
        final infiniteMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'infiniteMatrix', 'setInfiniteMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 1, 'fovYRadians', 'setInfiniteMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 2, 'aspectRatio', 'setInfiniteMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 3, 'zNear', 'setInfiniteMatrix');
        return $vector_math_1.setInfiniteMatrix(infiniteMatrix, fovYRadians, aspectRatio, zNear);
      },
      'makeInfiniteMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'makeInfiniteMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 0, 'fovYRadians', 'makeInfiniteMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 1, 'aspectRatio', 'makeInfiniteMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 2, 'zNear', 'makeInfiniteMatrix');
        return $vector_math_1.makeInfiniteMatrix(fovYRadians, aspectRatio, zNear);
      },
      'setFrustumMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 7, 'setFrustumMatrix');
        final perspectiveMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'perspectiveMatrix', 'setFrustumMatrix');
        final left = D4.getRequiredArg<double>(positional, 1, 'left', 'setFrustumMatrix');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'setFrustumMatrix');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'setFrustumMatrix');
        final top = D4.getRequiredArg<double>(positional, 4, 'top', 'setFrustumMatrix');
        final near = D4.getRequiredArg<double>(positional, 5, 'near', 'setFrustumMatrix');
        final far = D4.getRequiredArg<double>(positional, 6, 'far', 'setFrustumMatrix');
        return $vector_math_1.setFrustumMatrix(perspectiveMatrix, left, right, bottom, top, near, far);
      },
      'makeFrustumMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'makeFrustumMatrix');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'makeFrustumMatrix');
        final right = D4.getRequiredArg<double>(positional, 1, 'right', 'makeFrustumMatrix');
        final bottom = D4.getRequiredArg<double>(positional, 2, 'bottom', 'makeFrustumMatrix');
        final top = D4.getRequiredArg<double>(positional, 3, 'top', 'makeFrustumMatrix');
        final near = D4.getRequiredArg<double>(positional, 4, 'near', 'makeFrustumMatrix');
        final far = D4.getRequiredArg<double>(positional, 5, 'far', 'makeFrustumMatrix');
        return $vector_math_1.makeFrustumMatrix(left, right, bottom, top, near, far);
      },
      'setOrthographicMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 7, 'setOrthographicMatrix');
        final orthographicMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'orthographicMatrix', 'setOrthographicMatrix');
        final left = D4.getRequiredArg<double>(positional, 1, 'left', 'setOrthographicMatrix');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'setOrthographicMatrix');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'setOrthographicMatrix');
        final top = D4.getRequiredArg<double>(positional, 4, 'top', 'setOrthographicMatrix');
        final near = D4.getRequiredArg<double>(positional, 5, 'near', 'setOrthographicMatrix');
        final far = D4.getRequiredArg<double>(positional, 6, 'far', 'setOrthographicMatrix');
        return $vector_math_1.setOrthographicMatrix(orthographicMatrix, left, right, bottom, top, near, far);
      },
      'makeOrthographicMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'makeOrthographicMatrix');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'makeOrthographicMatrix');
        final right = D4.getRequiredArg<double>(positional, 1, 'right', 'makeOrthographicMatrix');
        final bottom = D4.getRequiredArg<double>(positional, 2, 'bottom', 'makeOrthographicMatrix');
        final top = D4.getRequiredArg<double>(positional, 3, 'top', 'makeOrthographicMatrix');
        final near = D4.getRequiredArg<double>(positional, 4, 'near', 'makeOrthographicMatrix');
        final far = D4.getRequiredArg<double>(positional, 5, 'far', 'makeOrthographicMatrix');
        return $vector_math_1.makeOrthographicMatrix(left, right, bottom, top, near, far);
      },
      'makePlaneProjection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'makePlaneProjection');
        final planeNormal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'planeNormal', 'makePlaneProjection');
        final planePoint = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'planePoint', 'makePlaneProjection');
        return $vector_math_1.makePlaneProjection(planeNormal, planePoint);
      },
      'makePlaneReflection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'makePlaneReflection');
        final planeNormal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'planeNormal', 'makePlaneReflection');
        final planePoint = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'planePoint', 'makePlaneReflection');
        return $vector_math_1.makePlaneReflection(planeNormal, planePoint);
      },
      'unproject': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 9, 'unproject');
        final cameraMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'cameraMatrix', 'unproject');
        final viewportX = D4.getRequiredArg<num>(positional, 1, 'viewportX', 'unproject');
        final viewportWidth = D4.getRequiredArg<num>(positional, 2, 'viewportWidth', 'unproject');
        final viewportY = D4.getRequiredArg<num>(positional, 3, 'viewportY', 'unproject');
        final viewportHeight = D4.getRequiredArg<num>(positional, 4, 'viewportHeight', 'unproject');
        final pickX = D4.getRequiredArg<num>(positional, 5, 'pickX', 'unproject');
        final pickY = D4.getRequiredArg<num>(positional, 6, 'pickY', 'unproject');
        final pickZ = D4.getRequiredArg<num>(positional, 7, 'pickZ', 'unproject');
        final pickWorld = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 8, 'pickWorld', 'unproject');
        return $vector_math_1.unproject(cameraMatrix, viewportX, viewportWidth, viewportY, viewportHeight, pickX, pickY, pickZ, pickWorld);
      },
      'pickRay': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 9, 'pickRay');
        final cameraMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'cameraMatrix', 'pickRay');
        final viewportX = D4.getRequiredArg<num>(positional, 1, 'viewportX', 'pickRay');
        final viewportWidth = D4.getRequiredArg<num>(positional, 2, 'viewportWidth', 'pickRay');
        final viewportY = D4.getRequiredArg<num>(positional, 3, 'viewportY', 'pickRay');
        final viewportHeight = D4.getRequiredArg<num>(positional, 4, 'viewportHeight', 'pickRay');
        final pickX = D4.getRequiredArg<num>(positional, 5, 'pickX', 'pickRay');
        final pickY = D4.getRequiredArg<num>(positional, 6, 'pickY', 'pickRay');
        final rayNear = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 7, 'rayNear', 'pickRay');
        final rayFar = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 8, 'rayFar', 'pickRay');
        return $vector_math_1.pickRay(cameraMatrix, viewportX, viewportWidth, viewportY, viewportHeight, pickX, pickY, rayNear, rayFar);
      },
      'degrees': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'degrees');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'degrees');
        return $vector_math_1.degrees(radians);
      },
      'radians': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'radians');
        final degrees = D4.getRequiredArg<double>(positional, 0, 'degrees', 'radians');
        return $vector_math_1.radians(degrees);
      },
      'mix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'mix');
        final min = D4.getRequiredArg<double>(positional, 0, 'min', 'mix');
        final max = D4.getRequiredArg<double>(positional, 1, 'max', 'mix');
        final a = D4.getRequiredArg<double>(positional, 2, 'a', 'mix');
        return $vector_math_1.mix(min, max, a);
      },
      'smoothStep': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'smoothStep');
        final edge0 = D4.getRequiredArg<double>(positional, 0, 'edge0', 'smoothStep');
        final edge1 = D4.getRequiredArg<double>(positional, 1, 'edge1', 'smoothStep');
        final amount = D4.getRequiredArg<double>(positional, 2, 'amount', 'smoothStep');
        return $vector_math_1.smoothStep(edge0, edge1, amount);
      },
      'catmullRom': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 5, 'catmullRom');
        final edge0 = D4.getRequiredArg<double>(positional, 0, 'edge0', 'catmullRom');
        final edge1 = D4.getRequiredArg<double>(positional, 1, 'edge1', 'catmullRom');
        final edge2 = D4.getRequiredArg<double>(positional, 2, 'edge2', 'catmullRom');
        final edge3 = D4.getRequiredArg<double>(positional, 3, 'edge3', 'catmullRom');
        final amount = D4.getRequiredArg<double>(positional, 4, 'amount', 'catmullRom');
        return $vector_math_1.catmullRom(edge0, edge1, edge2, edge3, amount);
      },
      'dot2': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'dot2');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'x', 'dot2');
        final y = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'y', 'dot2');
        return $vector_math_1.dot2(x, y);
      },
      'dot3': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'dot3');
        final x = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'x', 'dot3');
        final y = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'y', 'dot3');
        return $vector_math_1.dot3(x, y);
      },
      'cross3': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'cross3');
        final x = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'x', 'cross3');
        final y = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'y', 'cross3');
        final out = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'out', 'cross3');
        return $vector_math_1.cross3(x, y, out);
      },
      'cross2': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'cross2');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'x', 'cross2');
        final y = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'y', 'cross2');
        return $vector_math_1.cross2(x, y);
      },
      'cross2A': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'cross2A');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'cross2A');
        final y = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'y', 'cross2A');
        final out = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'out', 'cross2A');
        return $vector_math_1.cross2A(x, y, out);
      },
      'cross2B': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'cross2B');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'x', 'cross2B');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'cross2B');
        final out = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'out', 'cross2B');
        return $vector_math_1.cross2B(x, y, out);
      },
      'buildPlaneVectors': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'buildPlaneVectors');
        final planeNormal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'planeNormal', 'buildPlaneVectors');
        final u = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'u', 'buildPlaneVectors');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'v', 'buildPlaneVectors');
        return $vector_math_1.buildPlaneVectors(planeNormal, u, v);
      },
      'debugAssertAllGesturesVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllGesturesVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllGesturesVarsUnset');
        return $flutter_8.debugAssertAllGesturesVarsUnset(reason);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'relativeError': 'package:vector_math/src/vector_math_64/error_helpers.dart',
      'absoluteError': 'package:vector_math/src/vector_math_64/error_helpers.dart',
      'setRotationMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'setModelMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'setViewMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'makeViewMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'setPerspectiveMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'makePerspectiveMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'setInfiniteMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'makeInfiniteMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'setFrustumMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'makeFrustumMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'setOrthographicMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'makeOrthographicMatrix': 'package:vector_math/src/vector_math_64/opengl.dart',
      'makePlaneProjection': 'package:vector_math/src/vector_math_64/opengl.dart',
      'makePlaneReflection': 'package:vector_math/src/vector_math_64/opengl.dart',
      'unproject': 'package:vector_math/src/vector_math_64/opengl.dart',
      'pickRay': 'package:vector_math/src/vector_math_64/opengl.dart',
      'degrees': 'package:vector_math/src/vector_math_64/utilities.dart',
      'radians': 'package:vector_math/src/vector_math_64/utilities.dart',
      'mix': 'package:vector_math/src/vector_math_64/utilities.dart',
      'smoothStep': 'package:vector_math/src/vector_math_64/utilities.dart',
      'catmullRom': 'package:vector_math/src/vector_math_64/utilities.dart',
      'dot2': 'package:vector_math/src/vector_math_64/vector.dart',
      'dot3': 'package:vector_math/src/vector_math_64/vector.dart',
      'cross3': 'package:vector_math/src/vector_math_64/vector.dart',
      'cross2': 'package:vector_math/src/vector_math_64/vector.dart',
      'cross2A': 'package:vector_math/src/vector_math_64/vector.dart',
      'cross2B': 'package:vector_math/src/vector_math_64/vector.dart',
      'buildPlaneVectors': 'package:vector_math/src/vector_math_64/vector.dart',
      'debugAssertAllGesturesVarsUnset': 'package:flutter/src/gestures/debug.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'relativeError': 'double relativeError(dynamic calculated, dynamic correct)',
      'absoluteError': 'double absoluteError(dynamic calculated, dynamic correct)',
      'setRotationMatrix': 'void setRotationMatrix(Matrix4 rotationMatrix, Vector3 forwardDirection, Vector3 upDirection)',
      'setModelMatrix': 'void setModelMatrix(Matrix4 modelMatrix, Vector3 forwardDirection, Vector3 upDirection, double tx, double ty, double tz)',
      'setViewMatrix': 'void setViewMatrix(Matrix4 viewMatrix, Vector3 cameraPosition, Vector3 cameraFocusPosition, Vector3 upDirection)',
      'makeViewMatrix': 'Matrix4 makeViewMatrix(Vector3 cameraPosition, Vector3 cameraFocusPosition, Vector3 upDirection)',
      'setPerspectiveMatrix': 'void setPerspectiveMatrix(Matrix4 perspectiveMatrix, double fovYRadians, double aspectRatio, double zNear, double zFar)',
      'makePerspectiveMatrix': 'Matrix4 makePerspectiveMatrix(double fovYRadians, double aspectRatio, double zNear, double zFar)',
      'setInfiniteMatrix': 'void setInfiniteMatrix(Matrix4 infiniteMatrix, double fovYRadians, double aspectRatio, double zNear)',
      'makeInfiniteMatrix': 'Matrix4 makeInfiniteMatrix(double fovYRadians, double aspectRatio, double zNear)',
      'setFrustumMatrix': 'void setFrustumMatrix(Matrix4 perspectiveMatrix, double left, double right, double bottom, double top, double near, double far)',
      'makeFrustumMatrix': 'Matrix4 makeFrustumMatrix(double left, double right, double bottom, double top, double near, double far)',
      'setOrthographicMatrix': 'void setOrthographicMatrix(Matrix4 orthographicMatrix, double left, double right, double bottom, double top, double near, double far)',
      'makeOrthographicMatrix': 'Matrix4 makeOrthographicMatrix(double left, double right, double bottom, double top, double near, double far)',
      'makePlaneProjection': 'Matrix4 makePlaneProjection(Vector3 planeNormal, Vector3 planePoint)',
      'makePlaneReflection': 'Matrix4 makePlaneReflection(Vector3 planeNormal, Vector3 planePoint)',
      'unproject': 'bool unproject(Matrix4 cameraMatrix, num viewportX, num viewportWidth, num viewportY, num viewportHeight, num pickX, num pickY, num pickZ, Vector3 pickWorld)',
      'pickRay': 'bool pickRay(Matrix4 cameraMatrix, num viewportX, num viewportWidth, num viewportY, num viewportHeight, num pickX, num pickY, Vector3 rayNear, Vector3 rayFar)',
      'degrees': 'double degrees(double radians)',
      'radians': 'double radians(double degrees)',
      'mix': 'double mix(double min, double max, double a)',
      'smoothStep': 'double smoothStep(double edge0, double edge1, double amount)',
      'catmullRom': 'double catmullRom(double edge0, double edge1, double edge2, double edge3, double amount)',
      'dot2': 'double dot2(Vector2 x, Vector2 y)',
      'dot3': 'double dot3(Vector3 x, Vector3 y)',
      'cross3': 'void cross3(Vector3 x, Vector3 y, Vector3 out)',
      'cross2': 'double cross2(Vector2 x, Vector2 y)',
      'cross2A': 'void cross2A(double x, Vector2 y, Vector2 out)',
      'cross2B': 'void cross2B(Vector2 x, double y, Vector2 out)',
      'buildPlaneVectors': 'void buildPlaneVectors(Vector3 planeNormal, Vector3 u, Vector3 v)',
      'debugAssertAllGesturesVarsUnset': 'bool debugAssertAllGesturesVarsUnset(String reason)',
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
      'package:flutter/src/gestures/arena.dart',
      'package:flutter/src/gestures/binding.dart',
      'package:flutter/src/gestures/constants.dart',
      'package:flutter/src/gestures/converter.dart',
      'package:flutter/src/gestures/debug.dart',
      'package:flutter/src/gestures/drag.dart',
      'package:flutter/src/gestures/drag_details.dart',
      'package:flutter/src/gestures/eager.dart',
      'package:flutter/src/gestures/events.dart',
      'package:flutter/src/gestures/force_press.dart',
      'package:flutter/src/gestures/gesture_details.dart',
      'package:flutter/src/gestures/gesture_settings.dart',
      'package:flutter/src/gestures/hit_test.dart',
      'package:flutter/src/gestures/long_press.dart',
      'package:flutter/src/gestures/lsq_solver.dart',
      'package:flutter/src/gestures/monodrag.dart',
      'package:flutter/src/gestures/multidrag.dart',
      'package:flutter/src/gestures/multitap.dart',
      'package:flutter/src/gestures/pointer_router.dart',
      'package:flutter/src/gestures/pointer_signal_resolver.dart',
      'package:flutter/src/gestures/recognizer.dart',
      'package:flutter/src/gestures/resampler.dart',
      'package:flutter/src/gestures/scale.dart',
      'package:flutter/src/gestures/tap.dart',
      'package:flutter/src/gestures/tap_and_drag.dart',
      'package:flutter/src/gestures/team.dart',
      'package:flutter/src/gestures/velocity_tracker.dart',
      'package:vector_math/src/vector_math_64/constants.dart',
      'package:vector_math/src/vector_math_64/error_helpers.dart',
      'package:vector_math/src/vector_math_64/opengl.dart',
      'package:vector_math/src/vector_math_64/utilities.dart',
      'package:vector_math/src/vector_math_64/vector.dart',
      'package:vector_math/vector_math_64.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    final imports = StringBuffer();
    imports.writeln("import 'package:flutter/gestures.dart';");
    imports.writeln("import 'package:vector_math/vector_math.dart';");
    return imports.toString();
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [
      'package:vector_math/vector_math.dart',
    ];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'GestureDisposition',
    'DragStartBehavior',
  ];

}

// =============================================================================
// GestureArenaMember Bridge
// =============================================================================

BridgedClass _createGestureArenaMemberBridge() {
  return BridgedClass(
    nativeType: $flutter_4.GestureArenaMember,
    name: 'GestureArenaMember',
    constructors: {
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaMember>(target, 'GestureArenaMember');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaMember>(target, 'GestureArenaMember');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
    },
  );
}

// =============================================================================
// GestureArenaEntry Bridge
// =============================================================================

BridgedClass _createGestureArenaEntryBridge() {
  return BridgedClass(
    nativeType: $flutter_4.GestureArenaEntry,
    name: 'GestureArenaEntry',
    constructors: {
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaEntry>(target, 'GestureArenaEntry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_4.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
    },
    methodSignatures: {
      'resolve': 'void resolve(GestureDisposition disposition)',
    },
  );
}

// =============================================================================
// GestureArenaManager Bridge
// =============================================================================

BridgedClass _createGestureArenaManagerBridge() {
  return BridgedClass(
    nativeType: $flutter_4.GestureArenaManager,
    name: 'GestureArenaManager',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_4.GestureArenaManager();
      },
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 2, 'add');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'add');
        final member = D4.getRequiredArg<$flutter_4.GestureArenaMember>(positional, 1, 'member', 'add');
        return t.add(pointer, member);
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 1, 'close');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'close');
        t.close(pointer);
        return null;
      },
      'sweep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 1, 'sweep');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'sweep');
        t.sweep(pointer);
        return null;
      },
      'hold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 1, 'hold');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'hold');
        t.hold(pointer);
        return null;
      },
      'release': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 1, 'release');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'release');
        t.release(pointer);
        return null;
      },
    },
    constructorSignatures: {
      '': 'GestureArenaManager()',
    },
    methodSignatures: {
      'add': 'GestureArenaEntry add(int pointer, GestureArenaMember member)',
      'close': 'void close(int pointer)',
      'sweep': 'void sweep(int pointer)',
      'hold': 'void hold(int pointer)',
      'release': 'void release(int pointer)',
    },
  );
}

// =============================================================================
// DiagnosticsNode Bridge
// =============================================================================

BridgedClass _createDiagnosticsNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_3.DiagnosticsNode,
    name: 'DiagnosticsNode',
    constructors: {
      'message': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticsNode');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DiagnosticsNode');
        final style = D4.getNamedArgWithDefault<$flutter_3.DiagnosticsTreeStyle>(named, 'style', $flutter_3.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'level', $flutter_3.DiagnosticLevel.info);
        final allowWrap = D4.getNamedArgWithDefault<bool>(named, 'allowWrap', true);
        return $flutter_3.DiagnosticsNode.message(message, style: style, level: level, allowWrap: allowWrap);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode').allowTruncate,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_3.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticsNode>(target, 'DiagnosticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
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
        final nodes = D4.coerceListOrNull<$flutter_3.DiagnosticsNode>(positional[0], 'nodes');
        final parent = D4.getRequiredArg<$flutter_3.DiagnosticsNode?>(positional, 1, 'parent', 'toJsonList');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 2, 'delegate', 'toJsonList');
        return $flutter_3.DiagnosticsNode.toJsonList(nodes, parent, delegate);
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
// DiagnosticPropertiesBuilder Bridge
// =============================================================================

BridgedClass _createDiagnosticPropertiesBuilderBridge() {
  return BridgedClass(
    nativeType: $flutter_3.DiagnosticPropertiesBuilder,
    name: 'DiagnosticPropertiesBuilder',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_3.DiagnosticPropertiesBuilder();
      },
      'fromProperties': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticPropertiesBuilder');
        if (positional.isEmpty) {
          throw ArgumentError('DiagnosticPropertiesBuilder: Missing required argument "properties" at position 0');
        }
        final properties = D4.coerceList<$flutter_3.DiagnosticsNode>(positional[0], 'properties');
        return $flutter_3.DiagnosticPropertiesBuilder.fromProperties(properties);
      },
    },
    getters: {
      'properties': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').properties,
      'defaultDiagnosticsTreeStyle': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_3.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription,
    },
    setters: {
      'defaultDiagnosticsTreeStyle': (visitor, target, value) => 
        D4.validateTarget<$flutter_3.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle = value as $flutter_3.DiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target, value) => 
        D4.validateTarget<$flutter_3.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription = value as String?,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder');
        D4.requireMinArgs(positional, 1, 'add');
        final property = D4.getRequiredArg<$flutter_3.DiagnosticsNode>(positional, 0, 'property', 'add');
        t.add(property);
        return null;
      },
    },
    constructorSignatures: {
      '': 'DiagnosticPropertiesBuilder()',
      'fromProperties': 'DiagnosticPropertiesBuilder.fromProperties(List<DiagnosticsNode> properties)',
    },
    methodSignatures: {
      'add': 'void add(DiagnosticsNode property)',
    },
    getterSignatures: {
      'properties': 'List<DiagnosticsNode> get properties',
      'defaultDiagnosticsTreeStyle': 'DiagnosticsTreeStyle get defaultDiagnosticsTreeStyle',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
    },
    setterSignatures: {
      'defaultDiagnosticsTreeStyle': 'set defaultDiagnosticsTreeStyle(dynamic value)',
      'emptyBodyDescription': 'set emptyBodyDescription(dynamic value)',
    },
  );
}

// =============================================================================
// Matrix4 Bridge
// =============================================================================

BridgedClass _createMatrix4Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Matrix4,
    name: 'Matrix4',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 16, 'Matrix4');
        final arg0 = D4.getRequiredArg<double>(positional, 0, 'arg0', 'Matrix4');
        final arg1 = D4.getRequiredArg<double>(positional, 1, 'arg1', 'Matrix4');
        final arg2 = D4.getRequiredArg<double>(positional, 2, 'arg2', 'Matrix4');
        final arg3 = D4.getRequiredArg<double>(positional, 3, 'arg3', 'Matrix4');
        final arg4 = D4.getRequiredArg<double>(positional, 4, 'arg4', 'Matrix4');
        final arg5 = D4.getRequiredArg<double>(positional, 5, 'arg5', 'Matrix4');
        final arg6 = D4.getRequiredArg<double>(positional, 6, 'arg6', 'Matrix4');
        final arg7 = D4.getRequiredArg<double>(positional, 7, 'arg7', 'Matrix4');
        final arg8 = D4.getRequiredArg<double>(positional, 8, 'arg8', 'Matrix4');
        final arg9 = D4.getRequiredArg<double>(positional, 9, 'arg9', 'Matrix4');
        final arg10 = D4.getRequiredArg<double>(positional, 10, 'arg10', 'Matrix4');
        final arg11 = D4.getRequiredArg<double>(positional, 11, 'arg11', 'Matrix4');
        final arg12 = D4.getRequiredArg<double>(positional, 12, 'arg12', 'Matrix4');
        final arg13 = D4.getRequiredArg<double>(positional, 13, 'arg13', 'Matrix4');
        final arg14 = D4.getRequiredArg<double>(positional, 14, 'arg14', 'Matrix4');
        final arg15 = D4.getRequiredArg<double>(positional, 15, 'arg15', 'Matrix4');
        return $vector_math_1.Matrix4(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        if (positional.isEmpty) {
          throw ArgumentError('Matrix4: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<double>(positional[0], 'values');
        return $vector_math_1.Matrix4.fromList(values);
      },
      'zero': (visitor, positional, named) {
        return $vector_math_1.Matrix4.zero();
      },
      'identity': (visitor, positional, named) {
        return $vector_math_1.Matrix4.identity();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final other = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'other', 'Matrix4');
        return $vector_math_1.Matrix4.copy(other);
      },
      'inverted': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final other = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'other', 'Matrix4');
        return $vector_math_1.Matrix4.inverted(other);
      },
      'columns': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Matrix4');
        final arg0 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg0', 'Matrix4');
        final arg1 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'arg1', 'Matrix4');
        final arg2 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 2, 'arg2', 'Matrix4');
        final arg3 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 3, 'arg3', 'Matrix4');
        return $vector_math_1.Matrix4.columns(arg0, arg1, arg2, arg3);
      },
      'outer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix4');
        final u = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'u', 'Matrix4');
        final v = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'v', 'Matrix4');
        return $vector_math_1.Matrix4.outer(u, v);
      },
      'rotationX': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'Matrix4');
        return $vector_math_1.Matrix4.rotationX(radians);
      },
      'rotationY': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'Matrix4');
        return $vector_math_1.Matrix4.rotationY(radians);
      },
      'rotationZ': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'Matrix4');
        return $vector_math_1.Matrix4.rotationZ(radians);
      },
      'translation': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final translation = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'translation', 'Matrix4');
        return $vector_math_1.Matrix4.translation(translation);
      },
      'translationValues': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Matrix4');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Matrix4');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Matrix4');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'Matrix4');
        return $vector_math_1.Matrix4.translationValues(x, y, z);
      },
      'diagonal3': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final scale = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'scale', 'Matrix4');
        return $vector_math_1.Matrix4.diagonal3(scale);
      },
      'diagonal3Values': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Matrix4');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Matrix4');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Matrix4');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'Matrix4');
        return $vector_math_1.Matrix4.diagonal3Values(x, y, z);
      },
      'skewX': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'Matrix4');
        return $vector_math_1.Matrix4.skewX(alpha);
      },
      'skewY': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final beta = D4.getRequiredArg<double>(positional, 0, 'beta', 'Matrix4');
        return $vector_math_1.Matrix4.skewY(beta);
      },
      'skew': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix4');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'Matrix4');
        final beta = D4.getRequiredArg<double>(positional, 1, 'beta', 'Matrix4');
        return $vector_math_1.Matrix4.skew(alpha, beta);
      },
      'fromFloat64List': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix4');
        final m4storage = D4.getRequiredArg<Float64List>(positional, 0, '_m4storage', 'Matrix4');
        return $vector_math_1.Matrix4.fromFloat64List(m4storage);
      },
      'fromBuffer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix4');
        final buffer = D4.getRequiredArg<ByteBuffer>(positional, 0, 'buffer', 'Matrix4');
        final offset = D4.getRequiredArg<int>(positional, 1, 'offset', 'Matrix4');
        return $vector_math_1.Matrix4.fromBuffer(buffer, offset);
      },
      'compose': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Matrix4');
        final translation = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'translation', 'Matrix4');
        final rotation = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 1, 'rotation', 'Matrix4');
        final scale = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'scale', 'Matrix4');
        return $vector_math_1.Matrix4.compose(translation, rotation, scale);
      },
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').storage,
      'dimension': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').dimension,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').hashCode,
      'row0': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row0,
      'row1': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row1,
      'row2': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row2,
      'row3': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row3,
      'right': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').right,
      'up': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').up,
      'forward': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').forward,
    },
    setters: {
      'row0': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row0 = value as dynamic,
      'row1': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row1 = value as dynamic,
      'row2': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row2 = value as dynamic,
      'row3': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row3 = value as dynamic,
    },
    methods: {
      'index': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'index');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'index');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'index');
        return t.index(row, col);
      },
      'entry': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'entry');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'entry');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'entry');
        return t.entry(row, col);
      },
      'setEntry': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 3, 'setEntry');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'setEntry');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'setEntry');
        final v = D4.getRequiredArg<double>(positional, 2, 'v', 'setEntry');
        t.setEntry(row, col, v);
        return null;
      },
      'splatDiagonal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'splatDiagonal');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'splatDiagonal');
        t.splatDiagonal(arg);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 16, 'setValues');
        final arg0 = D4.getRequiredArg<double>(positional, 0, 'arg0', 'setValues');
        final arg1 = D4.getRequiredArg<double>(positional, 1, 'arg1', 'setValues');
        final arg2 = D4.getRequiredArg<double>(positional, 2, 'arg2', 'setValues');
        final arg3 = D4.getRequiredArg<double>(positional, 3, 'arg3', 'setValues');
        final arg4 = D4.getRequiredArg<double>(positional, 4, 'arg4', 'setValues');
        final arg5 = D4.getRequiredArg<double>(positional, 5, 'arg5', 'setValues');
        final arg6 = D4.getRequiredArg<double>(positional, 6, 'arg6', 'setValues');
        final arg7 = D4.getRequiredArg<double>(positional, 7, 'arg7', 'setValues');
        final arg8 = D4.getRequiredArg<double>(positional, 8, 'arg8', 'setValues');
        final arg9 = D4.getRequiredArg<double>(positional, 9, 'arg9', 'setValues');
        final arg10 = D4.getRequiredArg<double>(positional, 10, 'arg10', 'setValues');
        final arg11 = D4.getRequiredArg<double>(positional, 11, 'arg11', 'setValues');
        final arg12 = D4.getRequiredArg<double>(positional, 12, 'arg12', 'setValues');
        final arg13 = D4.getRequiredArg<double>(positional, 13, 'arg13', 'setValues');
        final arg14 = D4.getRequiredArg<double>(positional, 14, 'arg14', 'setValues');
        final arg15 = D4.getRequiredArg<double>(positional, 15, 'arg15', 'setValues');
        t.setValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        return null;
      },
      'setColumns': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 4, 'setColumns');
        final arg0 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg0', 'setColumns');
        final arg1 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'arg1', 'setColumns');
        final arg2 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 2, 'arg2', 'setColumns');
        final arg3 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 3, 'arg3', 'setColumns');
        t.setColumns(arg0, arg1, arg2, arg3);
        return null;
      },
      'setFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setFrom');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'setFrom');
        t.setFrom(arg);
        return null;
      },
      'setFromTranslationRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'setFromTranslationRotation');
        final arg0 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg0', 'setFromTranslationRotation');
        final arg1 = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 1, 'arg1', 'setFromTranslationRotation');
        t.setFromTranslationRotation(arg0, arg1);
        return null;
      },
      'setFromTranslationRotationScale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 3, 'setFromTranslationRotationScale');
        final translation = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'translation', 'setFromTranslationRotationScale');
        final rotation = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 1, 'rotation', 'setFromTranslationRotationScale');
        final scale = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'scale', 'setFromTranslationRotationScale');
        t.setFromTranslationRotationScale(translation, rotation, scale);
        return null;
      },
      'setUpper2x2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setUpper2x2');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'setUpper2x2');
        t.setUpper2x2(arg);
        return null;
      },
      'setDiagonal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setDiagonal');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'setDiagonal');
        t.setDiagonal(arg);
        return null;
      },
      'setOuter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'setOuter');
        final u = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'u', 'setOuter');
        final v = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'v', 'setOuter');
        t.setOuter(u, v);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.toString();
      },
      'setRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'setRow');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'setRow');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'arg', 'setRow');
        t.setRow(row, arg);
        return null;
      },
      'getRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'getRow');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'getRow');
        return t.getRow(row);
      },
      'setColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'setColumn');
        final column = D4.getRequiredArg<int>(positional, 0, 'column', 'setColumn');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'arg', 'setColumn');
        t.setColumn(column, arg);
        return null;
      },
      'getColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'getColumn');
        final column = D4.getRequiredArg<int>(positional, 0, 'column', 'getColumn');
        return t.getColumn(column);
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.clone();
      },
      'copyInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'copyInto');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'copyInto');
        return t.copyInto(arg);
      },
      'translate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'translate');
        final x = D4.getRequiredArg<dynamic>(positional, 0, 'x', 'translate');
        final y = D4.getOptionalArgWithDefault<double>(positional, 1, 'y', 0.0);
        final z = D4.getOptionalArgWithDefault<double>(positional, 2, 'z', 0.0);
        t.translate(x, y, z);
        return null;
      },
      'translateByDouble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 4, 'translateByDouble');
        final tx = D4.getRequiredArg<double>(positional, 0, 'tx', 'translateByDouble');
        final ty = D4.getRequiredArg<double>(positional, 1, 'ty', 'translateByDouble');
        final tz = D4.getRequiredArg<double>(positional, 2, 'tz', 'translateByDouble');
        final tw = D4.getRequiredArg<double>(positional, 3, 'tw', 'translateByDouble');
        t.translateByDouble(tx, ty, tz, tw);
        return null;
      },
      'translateByVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'translateByVector3');
        final v3 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'v3', 'translateByVector3');
        t.translateByVector3(v3);
        return null;
      },
      'translateByVector4': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'translateByVector4');
        final v4 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'v4', 'translateByVector4');
        t.translateByVector4(v4);
        return null;
      },
      'leftTranslate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'leftTranslate');
        final x = D4.getRequiredArg<dynamic>(positional, 0, 'x', 'leftTranslate');
        final y = D4.getOptionalArgWithDefault<double>(positional, 1, 'y', 0.0);
        final z = D4.getOptionalArgWithDefault<double>(positional, 2, 'z', 0.0);
        t.leftTranslate(x, y, z);
        return null;
      },
      'leftTranslateByDouble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 4, 'leftTranslateByDouble');
        final tx = D4.getRequiredArg<double>(positional, 0, 'tx', 'leftTranslateByDouble');
        final ty = D4.getRequiredArg<double>(positional, 1, 'ty', 'leftTranslateByDouble');
        final tz = D4.getRequiredArg<double>(positional, 2, 'tz', 'leftTranslateByDouble');
        final tw = D4.getRequiredArg<double>(positional, 3, 'tw', 'leftTranslateByDouble');
        t.leftTranslateByDouble(tx, ty, tz, tw);
        return null;
      },
      'leftTranslateByVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'leftTranslateByVector3');
        final v3 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'v3', 'leftTranslateByVector3');
        t.leftTranslateByVector3(v3);
        return null;
      },
      'leftTranslateByVector4': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'leftTranslateByVector4');
        final v4 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'v4', 'leftTranslateByVector4');
        t.leftTranslateByVector4(v4);
        return null;
      },
      'rotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'rotate');
        final axis = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'axis', 'rotate');
        final angle = D4.getRequiredArg<double>(positional, 1, 'angle', 'rotate');
        t.rotate(axis, angle);
        return null;
      },
      'rotateX': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'rotateX');
        final angle = D4.getRequiredArg<double>(positional, 0, 'angle', 'rotateX');
        t.rotateX(angle);
        return null;
      },
      'rotateY': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'rotateY');
        final angle = D4.getRequiredArg<double>(positional, 0, 'angle', 'rotateY');
        t.rotateY(angle);
        return null;
      },
      'rotateZ': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'rotateZ');
        final angle = D4.getRequiredArg<double>(positional, 0, 'angle', 'rotateZ');
        t.rotateZ(angle);
        return null;
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'scale');
        final x = D4.getRequiredArg<dynamic>(positional, 0, 'x', 'scale');
        final y = D4.getOptionalArg<double?>(positional, 1, 'y');
        final z = D4.getOptionalArg<double?>(positional, 2, 'z');
        t.scale(x, y, z);
        return null;
      },
      'scaleByDouble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 4, 'scaleByDouble');
        final sx = D4.getRequiredArg<double>(positional, 0, 'sx', 'scaleByDouble');
        final sy = D4.getRequiredArg<double>(positional, 1, 'sy', 'scaleByDouble');
        final sz = D4.getRequiredArg<double>(positional, 2, 'sz', 'scaleByDouble');
        final sw = D4.getRequiredArg<double>(positional, 3, 'sw', 'scaleByDouble');
        t.scaleByDouble(sx, sy, sz, sw);
        return null;
      },
      'scaleByVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'scaleByVector3');
        final v3 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'v3', 'scaleByVector3');
        t.scaleByVector3(v3);
        return null;
      },
      'scaleByVector4': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'scaleByVector4');
        final v4 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'v4', 'scaleByVector4');
        t.scaleByVector4(v4);
        return null;
      },
      'scaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'scaled');
        final x = D4.getRequiredArg<dynamic>(positional, 0, 'x', 'scaled');
        final y = D4.getOptionalArg<double?>(positional, 1, 'y');
        final z = D4.getOptionalArg<double?>(positional, 2, 'z');
        return t.scaled(x, y, z);
      },
      'scaledByDouble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 4, 'scaledByDouble');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'scaledByDouble');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'scaledByDouble');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'scaledByDouble');
        final t_ = D4.getRequiredArg<double>(positional, 3, 't', 'scaledByDouble');
        return t.scaledByDouble(x, y, z, t_);
      },
      'scaledByVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'scaledByVector3');
        final v3 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'v3', 'scaledByVector3');
        return t.scaledByVector3(v3);
      },
      'scaledByVector4': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'scaledByVector4');
        final v4 = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'v4', 'scaledByVector4');
        return t.scaledByVector4(v4);
      },
      'setZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        t.setZero();
        return null;
      },
      'setIdentity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        t.setIdentity();
        return null;
      },
      'transposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.transposed();
      },
      'transpose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        t.transpose();
        return null;
      },
      'absolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.absolute();
      },
      'determinant': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.determinant();
      },
      'dotRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'dotRow');
        final i = D4.getRequiredArg<int>(positional, 0, 'i', 'dotRow');
        final v = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'v', 'dotRow');
        return t.dotRow(i, v);
      },
      'dotColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 2, 'dotColumn');
        final j = D4.getRequiredArg<int>(positional, 0, 'j', 'dotColumn');
        final v = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'v', 'dotColumn');
        return t.dotColumn(j, v);
      },
      'trace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.trace();
      },
      'infinityNorm': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.infinityNorm();
      },
      'relativeError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'relativeError');
        final correct = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'correct', 'relativeError');
        return t.relativeError(correct);
      },
      'absoluteError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'absoluteError');
        final correct = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'correct', 'absoluteError');
        return t.absoluteError(correct);
      },
      'getTranslation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.getTranslation();
      },
      'setTranslation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setTranslation');
        final t_ = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 't', 'setTranslation');
        t.setTranslation(t_);
        return null;
      },
      'setTranslationRaw': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 3, 'setTranslationRaw');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'setTranslationRaw');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'setTranslationRaw');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'setTranslationRaw');
        t.setTranslationRaw(x, y, z);
        return null;
      },
      'getRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.getRotation();
      },
      'copyRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'copyRotation');
        final rotation = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'rotation', 'copyRotation');
        t.copyRotation(rotation);
        return null;
      },
      'setRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setRotation');
        final r = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'r', 'setRotation');
        t.setRotation(r);
        return null;
      },
      'getNormalMatrix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.getNormalMatrix();
      },
      'getMaxScaleOnAxis': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.getMaxScaleOnAxis();
      },
      'transposeRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        t.transposeRotation();
        return null;
      },
      'invert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.invert();
      },
      'copyInverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'copyInverse');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'copyInverse');
        return t.copyInverse(arg);
      },
      'invertRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.invertRotation();
      },
      'setRotationX': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setRotationX');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'setRotationX');
        t.setRotationX(radians);
        return null;
      },
      'setRotationY': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setRotationY');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'setRotationY');
        t.setRotationY(radians);
        return null;
      },
      'setRotationZ': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'setRotationZ');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'setRotationZ');
        t.setRotationZ(radians);
        return null;
      },
      'scaleAdjoint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'scaleAdjoint');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scaleAdjoint');
        t.scaleAdjoint(scale);
        return null;
      },
      'absoluteRotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'absoluteRotate');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'absoluteRotate');
        return t.absoluteRotate(arg);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'add');
        final o = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'o', 'add');
        t.add(o);
        return null;
      },
      'sub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'sub');
        final o = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'o', 'sub');
        t.sub(o);
        return null;
      },
      'negate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        t.negate();
        return null;
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'multiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'multiply');
        t.multiply(arg);
        return null;
      },
      'multiplied': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'multiplied');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'multiplied');
        return t.multiplied(arg);
      },
      'transposeMultiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'transposeMultiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'transposeMultiply');
        t.transposeMultiply(arg);
        return null;
      },
      'multiplyTranspose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'multiplyTranspose');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'multiplyTranspose');
        t.multiplyTranspose(arg);
        return null;
      },
      'decompose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 3, 'decompose');
        final translation = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'translation', 'decompose');
        final rotation = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 1, 'rotation', 'decompose');
        final scale = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'scale', 'decompose');
        t.decompose(translation, rotation, scale);
        return null;
      },
      'rotate3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'rotate3');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'rotate3');
        return t.rotate3(arg);
      },
      'rotated3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'rotated3');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'rotated3');
        final out = D4.getOptionalArg<$vector_math_1.Vector3?>(positional, 1, 'out');
        return t.rotated3(arg, out);
      },
      'transform3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'transform3');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'transform3');
        return t.transform3(arg);
      },
      'transformed3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'transformed3');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'transformed3');
        final out = D4.getOptionalArg<$vector_math_1.Vector3?>(positional, 1, 'out');
        return t.transformed3(arg, out);
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'transform');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'transform');
        return t.transform(arg);
      },
      'perspectiveTransform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'perspectiveTransform');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'perspectiveTransform');
        return t.perspectiveTransform(arg);
      },
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'transformed');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'transformed');
        final out = D4.getOptionalArg<$vector_math_1.Vector4?>(positional, 1, 'out');
        return t.transformed(arg, out);
      },
      'copyIntoArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'copyIntoArray');
        if (positional.isEmpty) {
          throw ArgumentError('copyIntoArray: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<num>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        t.copyIntoArray(array, offset);
        return null;
      },
      'copyFromArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'copyFromArray');
        if (positional.isEmpty) {
          throw ArgumentError('copyFromArray: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        t.copyFromArray(array, offset);
        return null;
      },
      'applyToVector3Array': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        D4.requireMinArgs(positional, 1, 'applyToVector3Array');
        if (positional.isEmpty) {
          throw ArgumentError('applyToVector3Array: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        return t.applyToVector3Array(array, offset);
      },
      'isIdentity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.isIdentity();
      },
      'isZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        return t.isZero();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4');
        final other = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticMethods: {
      'solve2': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'solve2');
        final A = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'A', 'solve2');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'x', 'solve2');
        final b = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'b', 'solve2');
        return $vector_math_1.Matrix4.solve2(A, x, b);
      },
      'solve3': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'solve3');
        final A = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'A', 'solve3');
        final x = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'x', 'solve3');
        final b = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'b', 'solve3');
        return $vector_math_1.Matrix4.solve3(A, x, b);
      },
      'solve': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'solve');
        final A = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'A', 'solve');
        final x = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'x', 'solve');
        final b = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 2, 'b', 'solve');
        return $vector_math_1.Matrix4.solve(A, x, b);
      },
      'tryInvert': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'tryInvert');
        final other = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'other', 'tryInvert');
        return $vector_math_1.Matrix4.tryInvert(other);
      },
    },
    constructorSignatures: {
      '': 'factory Matrix4(double arg0, double arg1, double arg2, double arg3, double arg4, double arg5, double arg6, double arg7, double arg8, double arg9, double arg10, double arg11, double arg12, double arg13, double arg14, double arg15)',
      'fromList': 'factory Matrix4.fromList(List<double> values)',
      'zero': 'Matrix4.zero()',
      'identity': 'factory Matrix4.identity()',
      'copy': 'factory Matrix4.copy(Matrix4 other)',
      'inverted': 'factory Matrix4.inverted(Matrix4 other)',
      'columns': 'factory Matrix4.columns(Vector4 arg0, Vector4 arg1, Vector4 arg2, Vector4 arg3)',
      'outer': 'factory Matrix4.outer(Vector4 u, Vector4 v)',
      'rotationX': 'factory Matrix4.rotationX(double radians)',
      'rotationY': 'factory Matrix4.rotationY(double radians)',
      'rotationZ': 'factory Matrix4.rotationZ(double radians)',
      'translation': 'factory Matrix4.translation(Vector3 translation)',
      'translationValues': 'factory Matrix4.translationValues(double x, double y, double z)',
      'diagonal3': 'factory Matrix4.diagonal3(Vector3 scale)',
      'diagonal3Values': 'factory Matrix4.diagonal3Values(double x, double y, double z)',
      'skewX': 'factory Matrix4.skewX(double alpha)',
      'skewY': 'factory Matrix4.skewY(double beta)',
      'skew': 'factory Matrix4.skew(double alpha, double beta)',
      'fromFloat64List': 'Matrix4.fromFloat64List(Float64List _m4storage)',
      'fromBuffer': 'Matrix4.fromBuffer(ByteBuffer buffer, int offset)',
      'compose': 'factory Matrix4.compose(Vector3 translation, Quaternion rotation, Vector3 scale)',
    },
    methodSignatures: {
      'index': 'int index(int row, int col)',
      'entry': 'double entry(int row, int col)',
      'setEntry': 'void setEntry(int row, int col, double v)',
      'splatDiagonal': 'void splatDiagonal(double arg)',
      'setValues': 'void setValues(double arg0, double arg1, double arg2, double arg3, double arg4, double arg5, double arg6, double arg7, double arg8, double arg9, double arg10, double arg11, double arg12, double arg13, double arg14, double arg15)',
      'setColumns': 'void setColumns(Vector4 arg0, Vector4 arg1, Vector4 arg2, Vector4 arg3)',
      'setFrom': 'void setFrom(Matrix4 arg)',
      'setFromTranslationRotation': 'void setFromTranslationRotation(Vector3 arg0, Quaternion arg1)',
      'setFromTranslationRotationScale': 'void setFromTranslationRotationScale(Vector3 translation, Quaternion rotation, Vector3 scale)',
      'setUpper2x2': 'void setUpper2x2(Matrix2 arg)',
      'setDiagonal': 'void setDiagonal(Vector4 arg)',
      'setOuter': 'void setOuter(Vector4 u, Vector4 v)',
      'toString': 'String toString()',
      'setRow': 'void setRow(int row, Vector4 arg)',
      'getRow': 'Vector4 getRow(int row)',
      'setColumn': 'void setColumn(int column, Vector4 arg)',
      'getColumn': 'Vector4 getColumn(int column)',
      'clone': 'Matrix4 clone()',
      'copyInto': 'Matrix4 copyInto(Matrix4 arg)',
      'translate': 'void translate(dynamic x, [double y = 0.0, double z = 0.0])',
      'translateByDouble': 'void translateByDouble(double tx, double ty, double tz, double tw)',
      'translateByVector3': 'void translateByVector3(Vector3 v3)',
      'translateByVector4': 'void translateByVector4(Vector4 v4)',
      'leftTranslate': 'void leftTranslate(dynamic x, [double y = 0.0, double z = 0.0])',
      'leftTranslateByDouble': 'void leftTranslateByDouble(double tx, double ty, double tz, double tw)',
      'leftTranslateByVector3': 'void leftTranslateByVector3(Vector3 v3)',
      'leftTranslateByVector4': 'void leftTranslateByVector4(Vector4 v4)',
      'rotate': 'void rotate(Vector3 axis, double angle)',
      'rotateX': 'void rotateX(double angle)',
      'rotateY': 'void rotateY(double angle)',
      'rotateZ': 'void rotateZ(double angle)',
      'scale': 'void scale(dynamic x, [double? y, double? z])',
      'scaleByDouble': 'void scaleByDouble(double sx, double sy, double sz, double sw)',
      'scaleByVector3': 'void scaleByVector3(Vector3 v3)',
      'scaleByVector4': 'void scaleByVector4(Vector4 v4)',
      'scaled': 'Matrix4 scaled(dynamic x, [double? y, double? z])',
      'scaledByDouble': 'Matrix4 scaledByDouble(double x, double y, double z, double t)',
      'scaledByVector3': 'Matrix4 scaledByVector3(Vector3 v3)',
      'scaledByVector4': 'Matrix4 scaledByVector4(Vector4 v4)',
      'setZero': 'void setZero()',
      'setIdentity': 'void setIdentity()',
      'transposed': 'Matrix4 transposed()',
      'transpose': 'void transpose()',
      'absolute': 'Matrix4 absolute()',
      'determinant': 'double determinant()',
      'dotRow': 'double dotRow(int i, Vector4 v)',
      'dotColumn': 'double dotColumn(int j, Vector4 v)',
      'trace': 'double trace()',
      'infinityNorm': 'double infinityNorm()',
      'relativeError': 'double relativeError(Matrix4 correct)',
      'absoluteError': 'double absoluteError(Matrix4 correct)',
      'getTranslation': 'Vector3 getTranslation()',
      'setTranslation': 'void setTranslation(Vector3 t)',
      'setTranslationRaw': 'void setTranslationRaw(double x, double y, double z)',
      'getRotation': 'Matrix3 getRotation()',
      'copyRotation': 'void copyRotation(Matrix3 rotation)',
      'setRotation': 'void setRotation(Matrix3 r)',
      'getNormalMatrix': 'Matrix3 getNormalMatrix()',
      'getMaxScaleOnAxis': 'double getMaxScaleOnAxis()',
      'transposeRotation': 'void transposeRotation()',
      'invert': 'double invert()',
      'copyInverse': 'double copyInverse(Matrix4 arg)',
      'invertRotation': 'double invertRotation()',
      'setRotationX': 'void setRotationX(double radians)',
      'setRotationY': 'void setRotationY(double radians)',
      'setRotationZ': 'void setRotationZ(double radians)',
      'scaleAdjoint': 'void scaleAdjoint(double scale)',
      'absoluteRotate': 'Vector3 absoluteRotate(Vector3 arg)',
      'add': 'void add(Matrix4 o)',
      'sub': 'void sub(Matrix4 o)',
      'negate': 'void negate()',
      'multiply': 'void multiply(Matrix4 arg)',
      'multiplied': 'Matrix4 multiplied(Matrix4 arg)',
      'transposeMultiply': 'void transposeMultiply(Matrix4 arg)',
      'multiplyTranspose': 'void multiplyTranspose(Matrix4 arg)',
      'decompose': 'void decompose(Vector3 translation, Quaternion rotation, Vector3 scale)',
      'rotate3': 'Vector3 rotate3(Vector3 arg)',
      'rotated3': 'Vector3 rotated3(Vector3 arg, [Vector3? out])',
      'transform3': 'Vector3 transform3(Vector3 arg)',
      'transformed3': 'Vector3 transformed3(Vector3 arg, [Vector3? out])',
      'transform': 'Vector4 transform(Vector4 arg)',
      'perspectiveTransform': 'Vector3 perspectiveTransform(Vector3 arg)',
      'transformed': 'Vector4 transformed(Vector4 arg, [Vector4? out])',
      'copyIntoArray': 'void copyIntoArray(List<num> array, [int offset = 0])',
      'copyFromArray': 'void copyFromArray(List<double> array, [int offset = 0])',
      'applyToVector3Array': 'List<double> applyToVector3Array(List<double> array, [int offset = 0])',
      'isIdentity': 'bool isIdentity()',
      'isZero': 'bool isZero()',
    },
    getterSignatures: {
      'storage': 'Float64List get storage',
      'dimension': 'int get dimension',
      'hashCode': 'int get hashCode',
      'row0': 'Vector4 get row0',
      'row1': 'Vector4 get row1',
      'row2': 'Vector4 get row2',
      'row3': 'Vector4 get row3',
      'right': 'Vector3 get right',
      'up': 'Vector3 get up',
      'forward': 'Vector3 get forward',
    },
    setterSignatures: {
      'row0': 'set row0(Vector4 value)',
      'row1': 'set row1(Vector4 value)',
      'row2': 'set row2(Vector4 value)',
      'row3': 'set row3(Vector4 value)',
    },
    staticMethodSignatures: {
      'solve2': 'void solve2(Matrix4 A, Vector2 x, Vector2 b)',
      'solve3': 'void solve3(Matrix4 A, Vector3 x, Vector3 b)',
      'solve': 'void solve(Matrix4 A, Vector4 x, Vector4 b)',
      'tryInvert': 'Matrix4? tryInvert(Matrix4 other)',
    },
  );
}

// =============================================================================
// DeviceGestureSettings Bridge
// =============================================================================

BridgedClass _createDeviceGestureSettingsBridge() {
  return BridgedClass(
    nativeType: $flutter_15.DeviceGestureSettings,
    name: 'DeviceGestureSettings',
    constructors: {
      '': (visitor, positional, named) {
        final touchSlop = D4.getOptionalNamedArg<double?>(named, 'touchSlop');
        return $flutter_15.DeviceGestureSettings(touchSlop: touchSlop);
      },
      'fromView': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DeviceGestureSettings');
        final view = D4.getRequiredArg<FlutterView>(positional, 0, 'view', 'DeviceGestureSettings');
        return $flutter_15.DeviceGestureSettings.fromView(view);
      },
    },
    getters: {
      'touchSlop': (visitor, target) => D4.validateTarget<$flutter_15.DeviceGestureSettings>(target, 'DeviceGestureSettings').touchSlop,
      'panSlop': (visitor, target) => D4.validateTarget<$flutter_15.DeviceGestureSettings>(target, 'DeviceGestureSettings').panSlop,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_15.DeviceGestureSettings>(target, 'DeviceGestureSettings').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.DeviceGestureSettings>(target, 'DeviceGestureSettings');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.DeviceGestureSettings>(target, 'DeviceGestureSettings');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const DeviceGestureSettings({double? touchSlop})',
      'fromView': 'factory DeviceGestureSettings.fromView(ui.FlutterView view)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'touchSlop': 'double? get touchSlop',
      'panSlop': 'double? get panSlop',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// PointerEvent Bridge
// =============================================================================

BridgedClass _createPointerEventBridge() {
  return BridgedClass(
    nativeType: $flutter_12.PointerEvent,
    name: 'PointerEvent',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final timeStamp = D4.getOptionalNamedArg<Duration?>(named, 'timeStamp');
        final pointer = D4.getOptionalNamedArg<int?>(named, 'pointer');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final device = D4.getOptionalNamedArg<int?>(named, 'device');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        final delta = D4.getOptionalNamedArg<Offset?>(named, 'delta');
        final buttons = D4.getOptionalNamedArg<int?>(named, 'buttons');
        final obscured = D4.getOptionalNamedArg<bool?>(named, 'obscured');
        final pressure = D4.getOptionalNamedArg<double?>(named, 'pressure');
        final pressureMin = D4.getOptionalNamedArg<double?>(named, 'pressureMin');
        final pressureMax = D4.getOptionalNamedArg<double?>(named, 'pressureMax');
        final distance = D4.getOptionalNamedArg<double?>(named, 'distance');
        final distanceMax = D4.getOptionalNamedArg<double?>(named, 'distanceMax');
        final size = D4.getOptionalNamedArg<double?>(named, 'size');
        final radiusMajor = D4.getOptionalNamedArg<double?>(named, 'radiusMajor');
        final radiusMinor = D4.getOptionalNamedArg<double?>(named, 'radiusMinor');
        final radiusMin = D4.getOptionalNamedArg<double?>(named, 'radiusMin');
        final radiusMax = D4.getOptionalNamedArg<double?>(named, 'radiusMax');
        final orientation = D4.getOptionalNamedArg<double?>(named, 'orientation');
        final tilt = D4.getOptionalNamedArg<double?>(named, 'tilt');
        final synthesized = D4.getOptionalNamedArg<bool?>(named, 'synthesized');
        final embedderId = D4.getOptionalNamedArg<int?>(named, 'embedderId');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerEvent>(target, 'PointerEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    staticMethods: {
      'transformPosition': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transformPosition');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformPosition');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'transformPosition');
        return $flutter_12.PointerEvent.transformPosition(transform, position);
      },
      'transformDeltaViaPositions': (visitor, positional, named, typeArgs) {
        final untransformedEndPosition = D4.getRequiredNamedArg<Offset>(named, 'untransformedEndPosition', 'transformDeltaViaPositions');
        final transformedEndPosition = D4.getOptionalNamedArg<Offset?>(named, 'transformedEndPosition');
        final untransformedDelta = D4.getRequiredNamedArg<Offset>(named, 'untransformedDelta', 'transformDeltaViaPositions');
        final transform = D4.getRequiredNamedArg<$vector_math_1.Matrix4?>(named, 'transform', 'transformDeltaViaPositions');
        return $flutter_12.PointerEvent.transformDeltaViaPositions(untransformedEndPosition: untransformedEndPosition, transformedEndPosition: transformedEndPosition, untransformedDelta: untransformedDelta, transform: transform);
      },
      'removePerspectiveTransform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removePerspectiveTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'removePerspectiveTransform');
        return $flutter_12.PointerEvent.removePerspectiveTransform(transform);
      },
    },
    methodSignatures: {
      'transformed': 'PointerEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'embedderId': 'int get embedderId',
      'timeStamp': 'Duration get timeStamp',
      'pointer': 'int get pointer',
      'kind': 'PointerDeviceKind get kind',
      'device': 'int get device',
      'position': 'Offset get position',
      'localPosition': 'Offset get localPosition',
      'delta': 'Offset get delta',
      'localDelta': 'Offset get localDelta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
      'pressure': 'double get pressure',
      'pressureMin': 'double get pressureMin',
      'pressureMax': 'double get pressureMax',
      'distance': 'double get distance',
      'distanceMin': 'double get distanceMin',
      'distanceMax': 'double get distanceMax',
      'size': 'double get size',
      'radiusMajor': 'double get radiusMajor',
      'radiusMinor': 'double get radiusMinor',
      'radiusMin': 'double get radiusMin',
      'radiusMax': 'double get radiusMax',
      'orientation': 'double get orientation',
      'tilt': 'double get tilt',
      'platformData': 'int get platformData',
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
    },
    staticMethodSignatures: {
      'transformPosition': 'Offset transformPosition(Matrix4? transform, Offset position)',
      'transformDeltaViaPositions': 'Offset transformDeltaViaPositions({required Offset untransformedEndPosition, Offset? transformedEndPosition, required Offset untransformedDelta, required Matrix4? transform})',
      'removePerspectiveTransform': 'Matrix4 removePerspectiveTransform(Matrix4 transform)',
    },
  );
}

// =============================================================================
// PointerDownEvent Bridge
// =============================================================================

BridgedClass _createPointerDownEventBridge() {
  return BridgedClass(
    nativeType: $flutter_12.PointerDownEvent,
    name: 'PointerDownEvent',
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final obscured = D4.getNamedArgWithDefault<bool>(named, 'obscured', false);
        final pressure = D4.getNamedArgWithDefault<double>(named, 'pressure', 1.0);
        final pressureMin = D4.getNamedArgWithDefault<double>(named, 'pressureMin', 1.0);
        final pressureMax = D4.getNamedArgWithDefault<double>(named, 'pressureMax', 1.0);
        final distanceMax = D4.getNamedArgWithDefault<double>(named, 'distanceMax', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 0.0);
        final radiusMajor = D4.getNamedArgWithDefault<double>(named, 'radiusMajor', 0.0);
        final radiusMinor = D4.getNamedArgWithDefault<double>(named, 'radiusMinor', 0.0);
        final radiusMin = D4.getNamedArgWithDefault<double>(named, 'radiusMin', 0.0);
        final radiusMax = D4.getNamedArgWithDefault<double>(named, 'radiusMax', 0.0);
        final orientation = D4.getNamedArgWithDefault<double>(named, 'orientation', 0.0);
        final tilt = D4.getNamedArgWithDefault<double>(named, 'tilt', 0.0);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        if (!named.containsKey('buttons')) {
          return $flutter_12.PointerDownEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId);
        }
        if (named.containsKey('buttons')) {
          final buttons = D4.getRequiredNamedArg<int>(named, 'buttons', 'PointerDownEvent');
          return $flutter_12.PointerDownEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId, buttons: buttons);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final timeStamp = D4.getOptionalNamedArg<Duration?>(named, 'timeStamp');
        final pointer = D4.getOptionalNamedArg<int?>(named, 'pointer');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final device = D4.getOptionalNamedArg<int?>(named, 'device');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        final delta = D4.getOptionalNamedArg<Offset?>(named, 'delta');
        final buttons = D4.getOptionalNamedArg<int?>(named, 'buttons');
        final obscured = D4.getOptionalNamedArg<bool?>(named, 'obscured');
        final pressure = D4.getOptionalNamedArg<double?>(named, 'pressure');
        final pressureMin = D4.getOptionalNamedArg<double?>(named, 'pressureMin');
        final pressureMax = D4.getOptionalNamedArg<double?>(named, 'pressureMax');
        final distance = D4.getOptionalNamedArg<double?>(named, 'distance');
        final distanceMax = D4.getOptionalNamedArg<double?>(named, 'distanceMax');
        final size = D4.getOptionalNamedArg<double?>(named, 'size');
        final radiusMajor = D4.getOptionalNamedArg<double?>(named, 'radiusMajor');
        final radiusMinor = D4.getOptionalNamedArg<double?>(named, 'radiusMinor');
        final radiusMin = D4.getOptionalNamedArg<double?>(named, 'radiusMin');
        final radiusMax = D4.getOptionalNamedArg<double?>(named, 'radiusMax');
        final orientation = D4.getOptionalNamedArg<double?>(named, 'orientation');
        final tilt = D4.getOptionalNamedArg<double?>(named, 'tilt');
        final synthesized = D4.getOptionalNamedArg<bool?>(named, 'synthesized');
        final embedderId = D4.getOptionalNamedArg<int?>(named, 'embedderId');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerDownEvent>(target, 'PointerDownEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerDownEvent({int viewId = 0, Duration timeStamp = Duration.zero, int pointer = 0, PointerDeviceKind kind = PointerDeviceKind.touch, int device = 0, Offset position = Offset.zero, int buttons = kPrimaryButton, bool obscured = false, double pressure = 1.0, double pressureMin = 1.0, double pressureMax = 1.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerDownEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerDownEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringFull': 'String toStringFull()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'embedderId': 'int get embedderId',
      'timeStamp': 'Duration get timeStamp',
      'pointer': 'int get pointer',
      'kind': 'PointerDeviceKind get kind',
      'device': 'int get device',
      'position': 'Offset get position',
      'localPosition': 'Offset get localPosition',
      'delta': 'Offset get delta',
      'localDelta': 'Offset get localDelta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
      'pressure': 'double get pressure',
      'pressureMin': 'double get pressureMin',
      'pressureMax': 'double get pressureMax',
      'distance': 'double get distance',
      'distanceMin': 'double get distanceMin',
      'distanceMax': 'double get distanceMax',
      'size': 'double get size',
      'radiusMajor': 'double get radiusMajor',
      'radiusMinor': 'double get radiusMinor',
      'radiusMin': 'double get radiusMin',
      'radiusMax': 'double get radiusMax',
      'orientation': 'double get orientation',
      'tilt': 'double get tilt',
      'platformData': 'int get platformData',
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
    },
  );
}

// =============================================================================
// PointerUpEvent Bridge
// =============================================================================

BridgedClass _createPointerUpEventBridge() {
  return BridgedClass(
    nativeType: $flutter_12.PointerUpEvent,
    name: 'PointerUpEvent',
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final buttons = D4.getNamedArgWithDefault<int>(named, 'buttons', 0);
        final obscured = D4.getNamedArgWithDefault<bool>(named, 'obscured', false);
        final pressure = D4.getNamedArgWithDefault<double>(named, 'pressure', 0.0);
        final pressureMin = D4.getNamedArgWithDefault<double>(named, 'pressureMin', 1.0);
        final pressureMax = D4.getNamedArgWithDefault<double>(named, 'pressureMax', 1.0);
        final distance = D4.getNamedArgWithDefault<double>(named, 'distance', 0.0);
        final distanceMax = D4.getNamedArgWithDefault<double>(named, 'distanceMax', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 0.0);
        final radiusMajor = D4.getNamedArgWithDefault<double>(named, 'radiusMajor', 0.0);
        final radiusMinor = D4.getNamedArgWithDefault<double>(named, 'radiusMinor', 0.0);
        final radiusMin = D4.getNamedArgWithDefault<double>(named, 'radiusMin', 0.0);
        final radiusMax = D4.getNamedArgWithDefault<double>(named, 'radiusMax', 0.0);
        final orientation = D4.getNamedArgWithDefault<double>(named, 'orientation', 0.0);
        final tilt = D4.getNamedArgWithDefault<double>(named, 'tilt', 0.0);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_12.PointerUpEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final timeStamp = D4.getOptionalNamedArg<Duration?>(named, 'timeStamp');
        final pointer = D4.getOptionalNamedArg<int?>(named, 'pointer');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final device = D4.getOptionalNamedArg<int?>(named, 'device');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final delta = D4.getOptionalNamedArg<Offset?>(named, 'delta');
        final buttons = D4.getOptionalNamedArg<int?>(named, 'buttons');
        final obscured = D4.getOptionalNamedArg<bool?>(named, 'obscured');
        final pressure = D4.getOptionalNamedArg<double?>(named, 'pressure');
        final pressureMin = D4.getOptionalNamedArg<double?>(named, 'pressureMin');
        final pressureMax = D4.getOptionalNamedArg<double?>(named, 'pressureMax');
        final distance = D4.getOptionalNamedArg<double?>(named, 'distance');
        final distanceMax = D4.getOptionalNamedArg<double?>(named, 'distanceMax');
        final size = D4.getOptionalNamedArg<double?>(named, 'size');
        final radiusMajor = D4.getOptionalNamedArg<double?>(named, 'radiusMajor');
        final radiusMinor = D4.getOptionalNamedArg<double?>(named, 'radiusMinor');
        final radiusMin = D4.getOptionalNamedArg<double?>(named, 'radiusMin');
        final radiusMax = D4.getOptionalNamedArg<double?>(named, 'radiusMax');
        final orientation = D4.getOptionalNamedArg<double?>(named, 'orientation');
        final tilt = D4.getOptionalNamedArg<double?>(named, 'tilt');
        final synthesized = D4.getOptionalNamedArg<bool?>(named, 'synthesized');
        final embedderId = D4.getOptionalNamedArg<int?>(named, 'embedderId');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, localPosition: localPosition, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerUpEvent>(target, 'PointerUpEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerUpEvent({int viewId = 0, Duration timeStamp = Duration.zero, int pointer = 0, PointerDeviceKind kind = PointerDeviceKind.touch, int device = 0, Offset position = Offset.zero, int buttons = 0, bool obscured = false, double pressure = 0.0, double pressureMin = 1.0, double pressureMax = 1.0, double distance = 0.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerUpEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerUpEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? localPosition, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringFull': 'String toStringFull()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'embedderId': 'int get embedderId',
      'timeStamp': 'Duration get timeStamp',
      'pointer': 'int get pointer',
      'kind': 'PointerDeviceKind get kind',
      'device': 'int get device',
      'position': 'Offset get position',
      'localPosition': 'Offset get localPosition',
      'delta': 'Offset get delta',
      'localDelta': 'Offset get localDelta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
      'pressure': 'double get pressure',
      'pressureMin': 'double get pressureMin',
      'pressureMax': 'double get pressureMax',
      'distance': 'double get distance',
      'distanceMin': 'double get distanceMin',
      'distanceMax': 'double get distanceMax',
      'size': 'double get size',
      'radiusMajor': 'double get radiusMajor',
      'radiusMinor': 'double get radiusMinor',
      'radiusMin': 'double get radiusMin',
      'radiusMax': 'double get radiusMax',
      'orientation': 'double get orientation',
      'tilt': 'double get tilt',
      'platformData': 'int get platformData',
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
    },
  );
}

// =============================================================================
// PointerSignalEvent Bridge
// =============================================================================

BridgedClass _createPointerSignalEventBridge() {
  return BridgedClass(
    nativeType: $flutter_12.PointerSignalEvent,
    name: 'PointerSignalEvent',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final timeStamp = D4.getOptionalNamedArg<Duration?>(named, 'timeStamp');
        final pointer = D4.getOptionalNamedArg<int?>(named, 'pointer');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final device = D4.getOptionalNamedArg<int?>(named, 'device');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        final delta = D4.getOptionalNamedArg<Offset?>(named, 'delta');
        final buttons = D4.getOptionalNamedArg<int?>(named, 'buttons');
        final obscured = D4.getOptionalNamedArg<bool?>(named, 'obscured');
        final pressure = D4.getOptionalNamedArg<double?>(named, 'pressure');
        final pressureMin = D4.getOptionalNamedArg<double?>(named, 'pressureMin');
        final pressureMax = D4.getOptionalNamedArg<double?>(named, 'pressureMax');
        final distance = D4.getOptionalNamedArg<double?>(named, 'distance');
        final distanceMax = D4.getOptionalNamedArg<double?>(named, 'distanceMax');
        final size = D4.getOptionalNamedArg<double?>(named, 'size');
        final radiusMajor = D4.getOptionalNamedArg<double?>(named, 'radiusMajor');
        final radiusMinor = D4.getOptionalNamedArg<double?>(named, 'radiusMinor');
        final radiusMin = D4.getOptionalNamedArg<double?>(named, 'radiusMin');
        final radiusMax = D4.getOptionalNamedArg<double?>(named, 'radiusMax');
        final orientation = D4.getOptionalNamedArg<double?>(named, 'orientation');
        final tilt = D4.getOptionalNamedArg<double?>(named, 'tilt');
        final synthesized = D4.getOptionalNamedArg<bool?>(named, 'synthesized');
        final embedderId = D4.getOptionalNamedArg<int?>(named, 'embedderId');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'respond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerSignalEvent>(target, 'PointerSignalEvent');
        final allowPlatformDefault = D4.getRequiredNamedArg<bool>(named, 'allowPlatformDefault', 'respond');
        t.respond(allowPlatformDefault: allowPlatformDefault);
        return null;
      },
    },
    methodSignatures: {
      'transformed': 'PointerEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'respond': 'void respond({required bool allowPlatformDefault})',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'embedderId': 'int get embedderId',
      'timeStamp': 'Duration get timeStamp',
      'pointer': 'int get pointer',
      'kind': 'PointerDeviceKind get kind',
      'device': 'int get device',
      'position': 'Offset get position',
      'localPosition': 'Offset get localPosition',
      'delta': 'Offset get delta',
      'localDelta': 'Offset get localDelta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
      'pressure': 'double get pressure',
      'pressureMin': 'double get pressureMin',
      'pressureMax': 'double get pressureMax',
      'distance': 'double get distance',
      'distanceMin': 'double get distanceMin',
      'distanceMax': 'double get distanceMax',
      'size': 'double get size',
      'radiusMajor': 'double get radiusMajor',
      'radiusMinor': 'double get radiusMinor',
      'radiusMin': 'double get radiusMin',
      'radiusMax': 'double get radiusMax',
      'orientation': 'double get orientation',
      'tilt': 'double get tilt',
      'platformData': 'int get platformData',
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
    },
  );
}

// =============================================================================
// PointerPanZoomStartEvent Bridge
// =============================================================================

BridgedClass _createPointerPanZoomStartEventBridge() {
  return BridgedClass(
    nativeType: $flutter_12.PointerPanZoomStartEvent,
    name: 'PointerPanZoomStartEvent',
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        return $flutter_12.PointerPanZoomStartEvent(viewId: viewId, timeStamp: timeStamp, device: device, pointer: pointer, position: position, embedderId: embedderId, synthesized: synthesized);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final timeStamp = D4.getOptionalNamedArg<Duration?>(named, 'timeStamp');
        final pointer = D4.getOptionalNamedArg<int?>(named, 'pointer');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final device = D4.getOptionalNamedArg<int?>(named, 'device');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        final delta = D4.getOptionalNamedArg<Offset?>(named, 'delta');
        final buttons = D4.getOptionalNamedArg<int?>(named, 'buttons');
        final obscured = D4.getOptionalNamedArg<bool?>(named, 'obscured');
        final pressure = D4.getOptionalNamedArg<double?>(named, 'pressure');
        final pressureMin = D4.getOptionalNamedArg<double?>(named, 'pressureMin');
        final pressureMax = D4.getOptionalNamedArg<double?>(named, 'pressureMax');
        final distance = D4.getOptionalNamedArg<double?>(named, 'distance');
        final distanceMax = D4.getOptionalNamedArg<double?>(named, 'distanceMax');
        final size = D4.getOptionalNamedArg<double?>(named, 'size');
        final radiusMajor = D4.getOptionalNamedArg<double?>(named, 'radiusMajor');
        final radiusMinor = D4.getOptionalNamedArg<double?>(named, 'radiusMinor');
        final radiusMin = D4.getOptionalNamedArg<double?>(named, 'radiusMin');
        final radiusMax = D4.getOptionalNamedArg<double?>(named, 'radiusMax');
        final orientation = D4.getOptionalNamedArg<double?>(named, 'orientation');
        final tilt = D4.getOptionalNamedArg<double?>(named, 'tilt');
        final synthesized = D4.getOptionalNamedArg<bool?>(named, 'synthesized');
        final embedderId = D4.getOptionalNamedArg<int?>(named, 'embedderId');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerPanZoomStartEvent({int viewId = 0, Duration timeStamp = Duration.zero, int device = 0, int pointer = 0, Offset position = Offset.zero, int embedderId = 0, bool synthesized = false})',
    },
    methodSignatures: {
      'transformed': 'PointerPanZoomStartEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerPanZoomStartEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringFull': 'String toStringFull()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'embedderId': 'int get embedderId',
      'timeStamp': 'Duration get timeStamp',
      'pointer': 'int get pointer',
      'kind': 'PointerDeviceKind get kind',
      'device': 'int get device',
      'position': 'Offset get position',
      'localPosition': 'Offset get localPosition',
      'delta': 'Offset get delta',
      'localDelta': 'Offset get localDelta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
      'pressure': 'double get pressure',
      'pressureMin': 'double get pressureMin',
      'pressureMax': 'double get pressureMax',
      'distance': 'double get distance',
      'distanceMin': 'double get distanceMin',
      'distanceMax': 'double get distanceMax',
      'size': 'double get size',
      'radiusMajor': 'double get radiusMajor',
      'radiusMinor': 'double get radiusMinor',
      'radiusMin': 'double get radiusMin',
      'radiusMax': 'double get radiusMax',
      'orientation': 'double get orientation',
      'tilt': 'double get tilt',
      'platformData': 'int get platformData',
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
    },
  );
}

// =============================================================================
// PointerCancelEvent Bridge
// =============================================================================

BridgedClass _createPointerCancelEventBridge() {
  return BridgedClass(
    nativeType: $flutter_12.PointerCancelEvent,
    name: 'PointerCancelEvent',
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final buttons = D4.getNamedArgWithDefault<int>(named, 'buttons', 0);
        final obscured = D4.getNamedArgWithDefault<bool>(named, 'obscured', false);
        final pressureMin = D4.getNamedArgWithDefault<double>(named, 'pressureMin', 1.0);
        final pressureMax = D4.getNamedArgWithDefault<double>(named, 'pressureMax', 1.0);
        final distance = D4.getNamedArgWithDefault<double>(named, 'distance', 0.0);
        final distanceMax = D4.getNamedArgWithDefault<double>(named, 'distanceMax', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 0.0);
        final radiusMajor = D4.getNamedArgWithDefault<double>(named, 'radiusMajor', 0.0);
        final radiusMinor = D4.getNamedArgWithDefault<double>(named, 'radiusMinor', 0.0);
        final radiusMin = D4.getNamedArgWithDefault<double>(named, 'radiusMin', 0.0);
        final radiusMax = D4.getNamedArgWithDefault<double>(named, 'radiusMax', 0.0);
        final orientation = D4.getNamedArgWithDefault<double>(named, 'orientation', 0.0);
        final tilt = D4.getNamedArgWithDefault<double>(named, 'tilt', 0.0);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_12.PointerCancelEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, buttons: buttons, obscured: obscured, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final timeStamp = D4.getOptionalNamedArg<Duration?>(named, 'timeStamp');
        final pointer = D4.getOptionalNamedArg<int?>(named, 'pointer');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final device = D4.getOptionalNamedArg<int?>(named, 'device');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        final delta = D4.getOptionalNamedArg<Offset?>(named, 'delta');
        final buttons = D4.getOptionalNamedArg<int?>(named, 'buttons');
        final obscured = D4.getOptionalNamedArg<bool?>(named, 'obscured');
        final pressure = D4.getOptionalNamedArg<double?>(named, 'pressure');
        final pressureMin = D4.getOptionalNamedArg<double?>(named, 'pressureMin');
        final pressureMax = D4.getOptionalNamedArg<double?>(named, 'pressureMax');
        final distance = D4.getOptionalNamedArg<double?>(named, 'distance');
        final distanceMax = D4.getOptionalNamedArg<double?>(named, 'distanceMax');
        final size = D4.getOptionalNamedArg<double?>(named, 'size');
        final radiusMajor = D4.getOptionalNamedArg<double?>(named, 'radiusMajor');
        final radiusMinor = D4.getOptionalNamedArg<double?>(named, 'radiusMinor');
        final radiusMin = D4.getOptionalNamedArg<double?>(named, 'radiusMin');
        final radiusMax = D4.getOptionalNamedArg<double?>(named, 'radiusMax');
        final orientation = D4.getOptionalNamedArg<double?>(named, 'orientation');
        final tilt = D4.getOptionalNamedArg<double?>(named, 'tilt');
        final synthesized = D4.getOptionalNamedArg<bool?>(named, 'synthesized');
        final embedderId = D4.getOptionalNamedArg<int?>(named, 'embedderId');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.PointerCancelEvent>(target, 'PointerCancelEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerCancelEvent({int viewId = 0, Duration timeStamp = Duration.zero, int pointer = 0, PointerDeviceKind kind = PointerDeviceKind.touch, int device = 0, Offset position = Offset.zero, int buttons = 0, bool obscured = false, double pressureMin = 1.0, double pressureMax = 1.0, double distance = 0.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerCancelEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerCancelEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringFull': 'String toStringFull()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'embedderId': 'int get embedderId',
      'timeStamp': 'Duration get timeStamp',
      'pointer': 'int get pointer',
      'kind': 'PointerDeviceKind get kind',
      'device': 'int get device',
      'position': 'Offset get position',
      'localPosition': 'Offset get localPosition',
      'delta': 'Offset get delta',
      'localDelta': 'Offset get localDelta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
      'pressure': 'double get pressure',
      'pressureMin': 'double get pressureMin',
      'pressureMax': 'double get pressureMax',
      'distance': 'double get distance',
      'distanceMin': 'double get distanceMin',
      'distanceMax': 'double get distanceMax',
      'size': 'double get size',
      'radiusMajor': 'double get radiusMajor',
      'radiusMinor': 'double get radiusMinor',
      'radiusMin': 'double get radiusMin',
      'radiusMax': 'double get radiusMax',
      'orientation': 'double get orientation',
      'tilt': 'double get tilt',
      'platformData': 'int get platformData',
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
    },
  );
}

// =============================================================================
// HitTestTarget Bridge
// =============================================================================

BridgedClass _createHitTestTargetBridge() {
  return BridgedClass(
    nativeType: $flutter_16.HitTestTarget,
    name: 'HitTestTarget',
    constructors: {
    },
    methods: {
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.HitTestTarget>(target, 'HitTestTarget');
        D4.requireMinArgs(positional, 2, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        final entry = D4.getRequiredArg<$flutter_16.HitTestEntry<$flutter_16.HitTestTarget>>(positional, 1, 'entry', 'handleEvent');
        t.handleEvent(event, entry);
        return null;
      },
    },
    methodSignatures: {
      'handleEvent': 'void handleEvent(PointerEvent event, HitTestEntry<HitTestTarget> entry)',
    },
  );
}

// =============================================================================
// HitTestEntry Bridge
// =============================================================================

BridgedClass _createHitTestEntryBridge() {
  return BridgedClass(
    nativeType: $flutter_16.HitTestEntry,
    name: 'HitTestEntry',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HitTestEntry');
        final target_ = D4.getRequiredArg<$flutter_16.HitTestTarget>(positional, 0, 'target', 'HitTestEntry');
        return $flutter_16.HitTestEntry(target_);
      },
    },
    getters: {
      'target': (visitor, target) => D4.validateTarget<$flutter_16.HitTestEntry>(target, 'HitTestEntry').target,
      'transform': (visitor, target) => D4.validateTarget<$flutter_16.HitTestEntry>(target, 'HitTestEntry').transform,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.HitTestEntry>(target, 'HitTestEntry');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'HitTestEntry(T target)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'target': 'T get target',
      'transform': 'Matrix4? get transform',
    },
  );
}

// =============================================================================
// HitTestResult Bridge
// =============================================================================

BridgedClass _createHitTestResultBridge() {
  return BridgedClass(
    nativeType: $flutter_16.HitTestResult,
    name: 'HitTestResult',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_16.HitTestResult();
      },
      'wrap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HitTestResult');
        final result = D4.getRequiredArg<$flutter_16.HitTestResult>(positional, 0, 'result', 'HitTestResult');
        return $flutter_16.HitTestResult.wrap(result);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$flutter_16.HitTestResult>(target, 'HitTestResult').path,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.HitTestResult>(target, 'HitTestResult');
        D4.requireMinArgs(positional, 1, 'add');
        final entry = D4.getRequiredArg<$flutter_16.HitTestEntry>(positional, 0, 'entry', 'add');
        t.add(entry);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.HitTestResult>(target, 'HitTestResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'HitTestResult()',
      'wrap': 'HitTestResult.wrap(HitTestResult result)',
    },
    methodSignatures: {
      'add': 'void add(HitTestEntry entry)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'path': 'Iterable<HitTestEntry> get path',
    },
  );
}

// =============================================================================
// PointerRouter Bridge
// =============================================================================

BridgedClass _createPointerRouterBridge() {
  return BridgedClass(
    nativeType: $flutter_22.PointerRouter,
    name: 'PointerRouter',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_22.PointerRouter();
      },
    },
    getters: {
      'debugGlobalRouteCount': (visitor, target) => D4.validateTarget<$flutter_22.PointerRouter>(target, 'PointerRouter').debugGlobalRouteCount,
    },
    methods: {
      'addRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 2, 'addRoute');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'addRoute');
        if (positional.length <= 1) {
          throw ArgumentError('addRoute: Missing required argument "route" at position 1');
        }
        final routeRaw = positional[1];
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 2, 'transform');
        t.addRoute(pointer, ($flutter_12.PointerEvent p0) { D4.callInterpreterCallback(visitor, routeRaw, [p0]); }, transform);
        return null;
      },
      'removeRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 2, 'removeRoute');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'removeRoute');
        if (positional.length <= 1) {
          throw ArgumentError('removeRoute: Missing required argument "route" at position 1');
        }
        final routeRaw = positional[1];
        t.removeRoute(pointer, ($flutter_12.PointerEvent p0) { D4.callInterpreterCallback(visitor, routeRaw, [p0]); });
        return null;
      },
      'addGlobalRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 1, 'addGlobalRoute');
        if (positional.isEmpty) {
          throw ArgumentError('addGlobalRoute: Missing required argument "route" at position 0');
        }
        final routeRaw = positional[0];
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.addGlobalRoute(($flutter_12.PointerEvent p0) { D4.callInterpreterCallback(visitor, routeRaw, [p0]); }, transform);
        return null;
      },
      'removeGlobalRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 1, 'removeGlobalRoute');
        if (positional.isEmpty) {
          throw ArgumentError('removeGlobalRoute: Missing required argument "route" at position 0');
        }
        final routeRaw = positional[0];
        t.removeGlobalRoute(($flutter_12.PointerEvent p0) { D4.callInterpreterCallback(visitor, routeRaw, [p0]); });
        return null;
      },
      'route': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 1, 'route');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'route');
        t.route(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'PointerRouter()',
    },
    methodSignatures: {
      'addRoute': 'void addRoute(int pointer, PointerRoute route, [Matrix4? transform])',
      'removeRoute': 'void removeRoute(int pointer, PointerRoute route)',
      'addGlobalRoute': 'void addGlobalRoute(PointerRoute route, [Matrix4? transform])',
      'removeGlobalRoute': 'void removeGlobalRoute(PointerRoute route)',
      'route': 'void route(PointerEvent event)',
    },
    getterSignatures: {
      'debugGlobalRouteCount': 'int get debugGlobalRouteCount',
    },
  );
}

// =============================================================================
// PointerSignalResolver Bridge
// =============================================================================

BridgedClass _createPointerSignalResolverBridge() {
  return BridgedClass(
    nativeType: $flutter_23.PointerSignalResolver,
    name: 'PointerSignalResolver',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_23.PointerSignalResolver();
      },
    },
    methods: {
      'register': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PointerSignalResolver>(target, 'PointerSignalResolver');
        D4.requireMinArgs(positional, 2, 'register');
        final event = D4.getRequiredArg<$flutter_12.PointerSignalEvent>(positional, 0, 'event', 'register');
        if (positional.length <= 1) {
          throw ArgumentError('register: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.register(event, ($flutter_12.PointerSignalEvent p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PointerSignalResolver>(target, 'PointerSignalResolver');
        D4.requireMinArgs(positional, 1, 'resolve');
        final event = D4.getRequiredArg<$flutter_12.PointerSignalEvent>(positional, 0, 'event', 'resolve');
        t.resolve(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'PointerSignalResolver()',
    },
    methodSignatures: {
      'register': 'void register(PointerSignalEvent event, PointerSignalResolvedCallback callback)',
      'resolve': 'void resolve(PointerSignalEvent event)',
    },
  );
}

// =============================================================================
// SamplingClock Bridge
// =============================================================================

BridgedClass _createSamplingClockBridge() {
  return BridgedClass(
    nativeType: $flutter_5.SamplingClock,
    name: 'SamplingClock',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_5.SamplingClock();
      },
    },
    methods: {
      'now': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SamplingClock>(target, 'SamplingClock');
        return t.now();
      },
      'stopwatch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SamplingClock>(target, 'SamplingClock');
        return t.stopwatch();
      },
    },
    constructorSignatures: {
      '': 'SamplingClock()',
    },
    methodSignatures: {
      'now': 'DateTime now()',
      'stopwatch': 'Stopwatch stopwatch()',
    },
  );
}

// =============================================================================
// GestureBinding Bridge
// =============================================================================

BridgedClass _createGestureBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_5.GestureBinding,
    name: 'GestureBinding',
    constructors: {
    },
    getters: {
      'pointerRouter': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').pointerRouter,
      'gestureArena': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').gestureArena,
      'pointerSignalResolver': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').pointerSignalResolver,
      'samplingClock': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').samplingClock,
      'resamplingEnabled': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').resamplingEnabled,
      'samplingOffset': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').samplingOffset,
      'window': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').platformDispatcher,
    },
    setters: {
      'resamplingEnabled': (visitor, target, value) => 
        D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').resamplingEnabled = value as bool,
      'samplingOffset': (visitor, target, value) => 
        D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding').samplingOffset = value as Duration,
    },
    methods: {
      'cancelPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 1, 'cancelPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'cancelPointer');
        t.cancelPointer(pointer);
        return null;
      },
      'handlePointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 1, 'handlePointerEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handlePointerEvent');
        t.handlePointerEvent(event);
        return null;
      },
      'hitTestInView': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 3, 'hitTestInView');
        final result = D4.getRequiredArg<$flutter_16.HitTestResult>(positional, 0, 'result', 'hitTestInView');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTestInView');
        final viewId = D4.getRequiredArg<int>(positional, 2, 'viewId', 'hitTestInView');
        t.hitTestInView(result, position, viewId);
        return null;
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final result = D4.getRequiredArg<$flutter_16.HitTestResult>(positional, 0, 'result', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        t.hitTest(result, position);
        return null;
      },
      'dispatchEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 2, 'dispatchEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'dispatchEvent');
        final hitTestResult = D4.getRequiredArg<$flutter_16.HitTestResult?>(positional, 1, 'hitTestResult', 'dispatchEvent');
        t.dispatchEvent(event, hitTestResult);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 2, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        final entry = D4.getRequiredArg<$flutter_16.HitTestEntry>(positional, 1, 'entry', 'handleEvent');
        t.handleEvent(event, entry);
        return null;
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        return t.reassembleApplication();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureBinding>(target, 'GestureBinding');
        return t.toString();
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_5.GestureBinding.instance,
    },
    methodSignatures: {
      'cancelPointer': 'void cancelPointer(int pointer)',
      'handlePointerEvent': 'void handlePointerEvent(PointerEvent event)',
      'hitTestInView': 'void hitTestInView(HitTestResult result, Offset position, int viewId)',
      'hitTest': 'void hitTest(HitTestResult result, Offset position)',
      'dispatchEvent': 'void dispatchEvent(PointerEvent event, HitTestResult? hitTestResult)',
      'handleEvent': 'void handleEvent(PointerEvent event, HitTestEntry entry)',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'pointerRouter': 'PointerRouter get pointerRouter',
      'gestureArena': 'GestureArenaManager get gestureArena',
      'pointerSignalResolver': 'PointerSignalResolver get pointerSignalResolver',
      'samplingClock': 'SamplingClock get samplingClock',
      'resamplingEnabled': 'bool get resamplingEnabled',
      'samplingOffset': 'Duration get samplingOffset',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
    },
    setterSignatures: {
      'resamplingEnabled': 'set resamplingEnabled(dynamic value)',
      'samplingOffset': 'set samplingOffset(dynamic value)',
    },
    staticGetterSignatures: {
      'instance': 'GestureBinding get instance',
    },
  );
}

// =============================================================================
// FlutterErrorDetailsForPointerEventDispatcher Bridge
// =============================================================================

BridgedClass _createFlutterErrorDetailsForPointerEventDispatcherBridge() {
  return BridgedClass(
    nativeType: $flutter_5.FlutterErrorDetailsForPointerEventDispatcher,
    name: 'FlutterErrorDetailsForPointerEventDispatcher',
    constructors: {
      '': (visitor, positional, named) {
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'FlutterErrorDetailsForPointerEventDispatcher');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final library = D4.getNamedArgWithDefault<String?>(named, 'library', 'Flutter framework');
        final context = D4.getOptionalNamedArg<$flutter_3.DiagnosticsNode?>(named, 'context');
        final event = D4.getOptionalNamedArg<$flutter_12.PointerEvent?>(named, 'event');
        final hitTestEntry = D4.getOptionalNamedArg<$flutter_16.HitTestEntry<$flutter_16.HitTestTarget>?>(named, 'hitTestEntry');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        return $flutter_5.FlutterErrorDetailsForPointerEventDispatcher(exception: exception, stack: stack, library: library, context: context, event: event, hitTestEntry: hitTestEntry, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_3.DiagnosticsNode>; }, silent: silent);
      },
    },
    getters: {
      'event': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').event,
      'hitTestEntry': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').hitTestEntry,
      'exception': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').exception,
      'stack': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').stack,
      'library': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').library,
      'context': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').context,
      'stackFilter': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').stackFilter,
      'informationCollector': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').informationCollector,
      'silent': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').silent,
      'summary': (visitor, target) => D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').summary,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        final context = D4.getOptionalNamedArg<$flutter_3.DiagnosticsNode?>(named, 'context');
        final exception = D4.getOptionalNamedArg<Object?>(named, 'exception');
        final informationCollectorRaw = named['informationCollector'];
        final library = D4.getOptionalNamedArg<String?>(named, 'library');
        final silent = D4.getOptionalNamedArg<bool?>(named, 'silent');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final stackFilterRaw = named['stackFilter'];
        return t.copyWith(context: context, exception: exception, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_3.DiagnosticsNode>; }, library: library, silent: silent, stack: stack, stackFilter: stackFilterRaw == null ? null : (Iterable<String> p0) { return D4.callInterpreterCallback(visitor, stackFilterRaw, [p0]) as Iterable<String>; });
      },
      'exceptionAsString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        return t.exceptionAsString();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const FlutterErrorDetailsForPointerEventDispatcher({required Object exception, StackTrace? stack, String? library = \'Flutter framework\', DiagnosticsNode? context, PointerEvent? event, HitTestEntry<HitTestTarget>? hitTestEntry, Iterable<DiagnosticsNode> Function()? informationCollector, bool silent = false})',
    },
    methodSignatures: {
      'copyWith': 'FlutterErrorDetails copyWith({DiagnosticsNode? context, Object? exception, Iterable<DiagnosticsNode> Function()? informationCollector, String? library, bool? silent, StackTrace? stack, Iterable<String> Function(Iterable<String>)? stackFilter})',
      'exceptionAsString': 'String exceptionAsString()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'event': 'PointerEvent? get event',
      'hitTestEntry': 'HitTestEntry? get hitTestEntry',
      'exception': 'Object get exception',
      'stack': 'StackTrace? get stack',
      'library': 'String? get library',
      'context': 'DiagnosticsNode? get context',
      'stackFilter': 'Iterable<String> Function(Iterable<String>)? get stackFilter',
      'informationCollector': 'Iterable<DiagnosticsNode> Function()? get informationCollector',
      'silent': 'bool get silent',
      'summary': 'DiagnosticsNode get summary',
    },
  );
}

// =============================================================================
// PointerEventConverter Bridge
// =============================================================================

BridgedClass _createPointerEventConverterBridge() {
  return BridgedClass(
    nativeType: $flutter_7.PointerEventConverter,
    name: 'PointerEventConverter',
    constructors: {
    },
    staticMethods: {
      'expand': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'expand');
        final data = D4.getRequiredArg<Iterable<PointerData>>(positional, 0, 'data', 'expand');
        if (positional.length <= 1) {
          throw ArgumentError('expand: Missing required argument "devicePixelRatioForView" at position 1');
        }
        final devicePixelRatioForViewRaw = positional[1];
        final devicePixelRatioForView = (int p0) { return D4.callInterpreterCallback(visitor, devicePixelRatioForViewRaw, [p0]) as double?; };
        return $flutter_7.PointerEventConverter.expand(data, devicePixelRatioForView);
      },
    },
    staticMethodSignatures: {
      'expand': 'Iterable<PointerEvent> expand(Iterable<ui.PointerData> data, DevicePixelRatioGetter devicePixelRatioForView)',
    },
  );
}

// =============================================================================
// Velocity Bridge
// =============================================================================

BridgedClass _createVelocityBridge() {
  return BridgedClass(
    nativeType: $flutter_30.Velocity,
    name: 'Velocity',
    constructors: {
      '': (visitor, positional, named) {
        final pixelsPerSecond = D4.getRequiredNamedArg<Offset>(named, 'pixelsPerSecond', 'Velocity');
        return $flutter_30.Velocity(pixelsPerSecond: pixelsPerSecond);
      },
    },
    getters: {
      'pixelsPerSecond': (visitor, target) => D4.validateTarget<$flutter_30.Velocity>(target, 'Velocity').pixelsPerSecond,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_30.Velocity>(target, 'Velocity').hashCode,
    },
    methods: {
      'clampMagnitude': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.Velocity>(target, 'Velocity');
        D4.requireMinArgs(positional, 2, 'clampMagnitude');
        final minValue = D4.getRequiredArg<double>(positional, 0, 'minValue', 'clampMagnitude');
        final maxValue = D4.getRequiredArg<double>(positional, 1, 'maxValue', 'clampMagnitude');
        return t.clampMagnitude(minValue, maxValue);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.Velocity>(target, 'Velocity');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.Velocity>(target, 'Velocity');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_30.Velocity>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.Velocity>(target, 'Velocity');
        final other = D4.getRequiredArg<$flutter_30.Velocity>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.Velocity>(target, 'Velocity');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_30.Velocity.zero,
    },
    constructorSignatures: {
      '': 'const Velocity({required Offset pixelsPerSecond})',
    },
    methodSignatures: {
      'clampMagnitude': 'Velocity clampMagnitude(double minValue, double maxValue)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'pixelsPerSecond': 'Offset get pixelsPerSecond',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'zero': 'Velocity get zero',
    },
  );
}

// =============================================================================
// DragUpdateDetails Bridge
// =============================================================================

BridgedClass _createDragUpdateDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_10.DragUpdateDetails,
    name: 'DragUpdateDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'DragUpdateDetails');
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
        final primaryDelta = D4.getOptionalNamedArg<double?>(named, 'primaryDelta');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_10.DragUpdateDetails(globalPosition: globalPosition, localPosition: localPosition, sourceTimeStamp: sourceTimeStamp, delta: delta, primaryDelta: primaryDelta, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails').localPosition,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails').sourceTimeStamp,
      'delta': (visitor, target) => D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails').delta,
      'primaryDelta': (visitor, target) => D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails').primaryDelta,
      'kind': (visitor, target) => D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails').kind,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.DragUpdateDetails>(target, 'DragUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'DragUpdateDetails({required Offset globalPosition, Offset? localPosition, Duration? sourceTimeStamp, Offset delta = Offset.zero, double? primaryDelta, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'sourceTimeStamp': 'Duration? get sourceTimeStamp',
      'delta': 'Offset get delta',
      'primaryDelta': 'double? get primaryDelta',
      'kind': 'PointerDeviceKind? get kind',
    },
  );
}

// =============================================================================
// DragEndDetails Bridge
// =============================================================================

BridgedClass _createDragEndDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_10.DragEndDetails,
    name: 'DragEndDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final velocity = D4.getNamedArgWithDefault<$flutter_30.Velocity>(named, 'velocity', $flutter_30.Velocity.zero);
        final primaryVelocity = D4.getOptionalNamedArg<double?>(named, 'primaryVelocity');
        return $flutter_10.DragEndDetails(globalPosition: globalPosition, localPosition: localPosition, velocity: velocity, primaryVelocity: primaryVelocity);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_10.DragEndDetails>(target, 'DragEndDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_10.DragEndDetails>(target, 'DragEndDetails').localPosition,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_10.DragEndDetails>(target, 'DragEndDetails').velocity,
      'primaryVelocity': (visitor, target) => D4.validateTarget<$flutter_10.DragEndDetails>(target, 'DragEndDetails').primaryVelocity,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.DragEndDetails>(target, 'DragEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.DragEndDetails>(target, 'DragEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.DragEndDetails>(target, 'DragEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'DragEndDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Velocity velocity = Velocity.zero, double? primaryVelocity})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'velocity': 'Velocity get velocity',
      'primaryVelocity': 'double? get primaryVelocity',
    },
  );
}

// =============================================================================
// Drag Bridge
// =============================================================================

BridgedClass _createDragBridge() {
  return BridgedClass(
    nativeType: $flutter_9.Drag,
    name: 'Drag',
    constructors: {
    },
    methods: {
      'update': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.Drag>(target, 'Drag');
        D4.requireMinArgs(positional, 1, 'update');
        final details = D4.getRequiredArg<$flutter_10.DragUpdateDetails>(positional, 0, 'details', 'update');
        t.update(details);
        return null;
      },
      'end': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.Drag>(target, 'Drag');
        D4.requireMinArgs(positional, 1, 'end');
        final details = D4.getRequiredArg<$flutter_10.DragEndDetails>(positional, 0, 'details', 'end');
        t.end(details);
        return null;
      },
      'cancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.Drag>(target, 'Drag');
        t.cancel();
        return null;
      },
    },
    methodSignatures: {
      'update': 'void update(DragUpdateDetails details)',
      'end': 'void end(DragEndDetails details)',
      'cancel': 'void cancel()',
    },
  );
}

// =============================================================================
// EagerGestureRecognizer Bridge
// =============================================================================

BridgedClass _createEagerGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_11.EagerGestureRecognizer,
    name: 'EagerGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_11.EagerGestureRecognizer(supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_11.EagerGestureRecognizer(supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').allowedButtonsFilter,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'EagerGestureRecognizer({Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
    },
  );
}

// =============================================================================
// ForcePressDetails Bridge
// =============================================================================

BridgedClass _createForcePressDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_13.ForcePressDetails,
    name: 'ForcePressDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'ForcePressDetails');
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final pressure = D4.getRequiredNamedArg<double>(named, 'pressure', 'ForcePressDetails');
        return $flutter_13.ForcePressDetails(globalPosition: globalPosition, localPosition: localPosition, pressure: pressure);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressDetails>(target, 'ForcePressDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressDetails>(target, 'ForcePressDetails').localPosition,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressDetails>(target, 'ForcePressDetails').pressure,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressDetails>(target, 'ForcePressDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressDetails>(target, 'ForcePressDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressDetails>(target, 'ForcePressDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ForcePressDetails({required Offset globalPosition, Offset? localPosition, required double pressure})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'pressure': 'double get pressure',
    },
  );
}

// =============================================================================
// ForcePressGestureRecognizer Bridge
// =============================================================================

BridgedClass _createForcePressGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_13.ForcePressGestureRecognizer,
    name: 'ForcePressGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final startPressure = D4.getNamedArgWithDefault<double>(named, 'startPressure', 0.4);
        final peakPressure = D4.getNamedArgWithDefault<double>(named, 'peakPressure', 0.85);
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('interpolation') && !named.containsKey('allowedButtonsFilter')) {
          return $flutter_13.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('interpolation') && !named.containsKey('allowedButtonsFilter')) {
          final interpolationRaw = named['interpolation'];
          final interpolation = (double p0, double p1, double p2) { return D4.callInterpreterCallback(visitor, interpolationRaw, [p0, p1, p2]) as double; };
          return $flutter_13.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices, interpolation: interpolation);
        }
        if (!named.containsKey('interpolation') && named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_13.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        if (named.containsKey('interpolation') && named.containsKey('allowedButtonsFilter')) {
          final interpolationRaw = named['interpolation'];
          final interpolation = (double p0, double p1, double p2) { return D4.callInterpreterCallback(visitor, interpolationRaw, [p0, p1, p2]) as double; };
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_13.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices, interpolation: interpolation, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onStart': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onUpdate,
      'onPeak': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onPeak,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onEnd,
      'startPressure': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').startPressure,
      'peakPressure': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').peakPressure,
      'interpolation': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').interpolation,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').allowedButtonsFilter,
    },
    setters: {
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onStart = value as $flutter_13.GestureForcePressStartCallback?,
      'onUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onUpdate = value as $flutter_13.GestureForcePressUpdateCallback?,
      'onPeak': (visitor, target, value) => 
        D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onPeak = value as $flutter_13.GestureForcePressPeakCallback?,
      'onEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onEnd = value as $flutter_13.GestureForcePressEndCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'ForcePressGestureRecognizer({double startPressure = 0.4, double peakPressure = 0.85, double Function(double, double, double) interpolation = _inverseLerp, Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'onStart': 'GestureForcePressStartCallback? get onStart',
      'onUpdate': 'GestureForcePressUpdateCallback? get onUpdate',
      'onPeak': 'GestureForcePressPeakCallback? get onPeak',
      'onEnd': 'GestureForcePressEndCallback? get onEnd',
      'startPressure': 'double get startPressure',
      'peakPressure': 'double get peakPressure',
      'interpolation': 'GestureForceInterpolation get interpolation',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
    },
    setterSignatures: {
      'onStart': 'set onStart(dynamic value)',
      'onUpdate': 'set onUpdate(dynamic value)',
      'onPeak': 'set onPeak(dynamic value)',
      'onEnd': 'set onEnd(dynamic value)',
    },
  );
}

// =============================================================================
// PositionedGestureDetails Bridge
// =============================================================================

BridgedClass _createPositionedGestureDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_14.PositionedGestureDetails,
    name: 'PositionedGestureDetails',
    constructors: {
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_14.PositionedGestureDetails>(target, 'PositionedGestureDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_14.PositionedGestureDetails>(target, 'PositionedGestureDetails').localPosition,
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
    },
  );
}

// =============================================================================
// LongPressDownDetails Bridge
// =============================================================================

BridgedClass _createLongPressDownDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_17.LongPressDownDetails,
    name: 'LongPressDownDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_17.LongPressDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressDownDetails>(target, 'LongPressDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressDownDetails>(target, 'LongPressDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_17.LongPressDownDetails>(target, 'LongPressDownDetails').kind,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressDownDetails>(target, 'LongPressDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressDownDetails>(target, 'LongPressDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressDownDetails>(target, 'LongPressDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressDownDetails({Offset globalPosition = Offset.zero, Offset? localPosition, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind? get kind',
    },
  );
}

// =============================================================================
// LongPressStartDetails Bridge
// =============================================================================

BridgedClass _createLongPressStartDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_17.LongPressStartDetails,
    name: 'LongPressStartDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        return $flutter_17.LongPressStartDetails(globalPosition: globalPosition, localPosition: localPosition);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressStartDetails>(target, 'LongPressStartDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressStartDetails>(target, 'LongPressStartDetails').localPosition,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressStartDetails>(target, 'LongPressStartDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressStartDetails>(target, 'LongPressStartDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressStartDetails>(target, 'LongPressStartDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressStartDetails({Offset globalPosition = Offset.zero, Offset? localPosition})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
    },
  );
}

// =============================================================================
// LongPressMoveUpdateDetails Bridge
// =============================================================================

BridgedClass _createLongPressMoveUpdateDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_17.LongPressMoveUpdateDetails,
    name: 'LongPressMoveUpdateDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final offsetFromOrigin = D4.getNamedArgWithDefault<Offset>(named, 'offsetFromOrigin', $dart_ui.Offset.zero);
        final localOffsetFromOrigin = D4.getOptionalNamedArg<Offset?>(named, 'localOffsetFromOrigin');
        return $flutter_17.LongPressMoveUpdateDetails(globalPosition: globalPosition, localPosition: localPosition, offsetFromOrigin: offsetFromOrigin, localOffsetFromOrigin: localOffsetFromOrigin);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').localPosition,
      'offsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_17.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').offsetFromOrigin,
      'localOffsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_17.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').localOffsetFromOrigin,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressMoveUpdateDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Offset offsetFromOrigin = Offset.zero, Offset? localOffsetFromOrigin})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'offsetFromOrigin': 'Offset get offsetFromOrigin',
      'localOffsetFromOrigin': 'Offset get localOffsetFromOrigin',
    },
  );
}

// =============================================================================
// LongPressEndDetails Bridge
// =============================================================================

BridgedClass _createLongPressEndDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_17.LongPressEndDetails,
    name: 'LongPressEndDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final velocity = D4.getNamedArgWithDefault<$flutter_30.Velocity>(named, 'velocity', $flutter_30.Velocity.zero);
        return $flutter_17.LongPressEndDetails(globalPosition: globalPosition, localPosition: localPosition, velocity: velocity);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressEndDetails>(target, 'LongPressEndDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressEndDetails>(target, 'LongPressEndDetails').localPosition,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_17.LongPressEndDetails>(target, 'LongPressEndDetails').velocity,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressEndDetails>(target, 'LongPressEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressEndDetails>(target, 'LongPressEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressEndDetails>(target, 'LongPressEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressEndDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Velocity velocity = Velocity.zero})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'velocity': 'Velocity get velocity',
    },
  );
}

// =============================================================================
// LongPressGestureRecognizer Bridge
// =============================================================================

BridgedClass _createLongPressGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_17.LongPressGestureRecognizer,
    name: 'LongPressGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final postAcceptSlopTolerance = D4.getNamedArgWithDefault<double?>(named, 'postAcceptSlopTolerance', null);
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_17.LongPressGestureRecognizer(duration: duration, postAcceptSlopTolerance: postAcceptSlopTolerance, supportedDevices: supportedDevices, debugOwner: debugOwner, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; });
      },
    },
    getters: {
      'onLongPressDown': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressDown,
      'onLongPressCancel': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressCancel,
      'onLongPress': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPress,
      'onLongPressStart': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressStart,
      'onLongPressMoveUpdate': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressMoveUpdate,
      'onLongPressUp': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressUp,
      'onLongPressEnd': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressEnd,
      'onSecondaryLongPressDown': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressDown,
      'onSecondaryLongPressCancel': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressCancel,
      'onSecondaryLongPress': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPress,
      'onSecondaryLongPressStart': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressStart,
      'onSecondaryLongPressMoveUpdate': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressMoveUpdate,
      'onSecondaryLongPressUp': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressUp,
      'onSecondaryLongPressEnd': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressEnd,
      'onTertiaryLongPressDown': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressDown,
      'onTertiaryLongPressCancel': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressCancel,
      'onTertiaryLongPress': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPress,
      'onTertiaryLongPressStart': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressStart,
      'onTertiaryLongPressMoveUpdate': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressMoveUpdate,
      'onTertiaryLongPressUp': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressUp,
      'onTertiaryLongPressEnd': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressEnd,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').debugDescription,
      'deadline': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').deadline,
      'preAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').preAcceptSlopTolerance,
      'postAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').postAcceptSlopTolerance,
      'state': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').state,
      'primaryPointer': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').primaryPointer,
      'initialPosition': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').initialPosition,
      'team': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').allowedButtonsFilter,
    },
    setters: {
      'onLongPressDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressDown = value as $flutter_17.GestureLongPressDownCallback?,
      'onLongPressCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressCancel = value as $flutter_17.GestureLongPressCancelCallback?,
      'onLongPress': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPress = value as dynamic,
      'onLongPressStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressStart = value as $flutter_17.GestureLongPressStartCallback?,
      'onLongPressMoveUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressMoveUpdate = value as $flutter_17.GestureLongPressMoveUpdateCallback?,
      'onLongPressUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressUp = value as $flutter_17.GestureLongPressUpCallback?,
      'onLongPressEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressEnd = value as $flutter_17.GestureLongPressEndCallback?,
      'onSecondaryLongPressDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressDown = value as $flutter_17.GestureLongPressDownCallback?,
      'onSecondaryLongPressCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressCancel = value as $flutter_17.GestureLongPressCancelCallback?,
      'onSecondaryLongPress': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPress = value as dynamic,
      'onSecondaryLongPressStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressStart = value as $flutter_17.GestureLongPressStartCallback?,
      'onSecondaryLongPressMoveUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressMoveUpdate = value as $flutter_17.GestureLongPressMoveUpdateCallback?,
      'onSecondaryLongPressUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressUp = value as $flutter_17.GestureLongPressUpCallback?,
      'onSecondaryLongPressEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressEnd = value as $flutter_17.GestureLongPressEndCallback?,
      'onTertiaryLongPressDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressDown = value as $flutter_17.GestureLongPressDownCallback?,
      'onTertiaryLongPressCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressCancel = value as $flutter_17.GestureLongPressCancelCallback?,
      'onTertiaryLongPress': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPress = value as dynamic,
      'onTertiaryLongPressStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressStart = value as $flutter_17.GestureLongPressStartCallback?,
      'onTertiaryLongPressMoveUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressMoveUpdate = value as $flutter_17.GestureLongPressMoveUpdateCallback?,
      'onTertiaryLongPressUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressUp = value as $flutter_17.GestureLongPressUpCallback?,
      'onTertiaryLongPressEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressEnd = value as $flutter_17.GestureLongPressEndCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'LongPressGestureRecognizer({Duration? duration, double? postAcceptSlopTolerance = null, Set<PointerDeviceKind>? supportedDevices, Object? debugOwner, AllowedButtonsFilter? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'dispose': 'void dispose()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'onLongPressDown': 'GestureLongPressDownCallback? get onLongPressDown',
      'onLongPressCancel': 'GestureLongPressCancelCallback? get onLongPressCancel',
      'onLongPress': 'GestureLongPressCallback? get onLongPress',
      'onLongPressStart': 'GestureLongPressStartCallback? get onLongPressStart',
      'onLongPressMoveUpdate': 'GestureLongPressMoveUpdateCallback? get onLongPressMoveUpdate',
      'onLongPressUp': 'GestureLongPressUpCallback? get onLongPressUp',
      'onLongPressEnd': 'GestureLongPressEndCallback? get onLongPressEnd',
      'onSecondaryLongPressDown': 'GestureLongPressDownCallback? get onSecondaryLongPressDown',
      'onSecondaryLongPressCancel': 'GestureLongPressCancelCallback? get onSecondaryLongPressCancel',
      'onSecondaryLongPress': 'GestureLongPressCallback? get onSecondaryLongPress',
      'onSecondaryLongPressStart': 'GestureLongPressStartCallback? get onSecondaryLongPressStart',
      'onSecondaryLongPressMoveUpdate': 'GestureLongPressMoveUpdateCallback? get onSecondaryLongPressMoveUpdate',
      'onSecondaryLongPressUp': 'GestureLongPressUpCallback? get onSecondaryLongPressUp',
      'onSecondaryLongPressEnd': 'GestureLongPressEndCallback? get onSecondaryLongPressEnd',
      'onTertiaryLongPressDown': 'GestureLongPressDownCallback? get onTertiaryLongPressDown',
      'onTertiaryLongPressCancel': 'GestureLongPressCancelCallback? get onTertiaryLongPressCancel',
      'onTertiaryLongPress': 'GestureLongPressCallback? get onTertiaryLongPress',
      'onTertiaryLongPressStart': 'GestureLongPressStartCallback? get onTertiaryLongPressStart',
      'onTertiaryLongPressMoveUpdate': 'GestureLongPressMoveUpdateCallback? get onTertiaryLongPressMoveUpdate',
      'onTertiaryLongPressUp': 'GestureLongPressUpCallback? get onTertiaryLongPressUp',
      'onTertiaryLongPressEnd': 'GestureLongPressEndCallback? get onTertiaryLongPressEnd',
      'debugDescription': 'String get debugDescription',
      'deadline': 'Duration? get deadline',
      'preAcceptSlopTolerance': 'double? get preAcceptSlopTolerance',
      'postAcceptSlopTolerance': 'double? get postAcceptSlopTolerance',
      'state': 'GestureRecognizerState get state',
      'primaryPointer': 'int? get primaryPointer',
      'initialPosition': 'OffsetPair? get initialPosition',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
    },
    setterSignatures: {
      'onLongPressDown': 'set onLongPressDown(dynamic value)',
      'onLongPressCancel': 'set onLongPressCancel(dynamic value)',
      'onLongPress': 'set onLongPress(dynamic value)',
      'onLongPressStart': 'set onLongPressStart(dynamic value)',
      'onLongPressMoveUpdate': 'set onLongPressMoveUpdate(dynamic value)',
      'onLongPressUp': 'set onLongPressUp(dynamic value)',
      'onLongPressEnd': 'set onLongPressEnd(dynamic value)',
      'onSecondaryLongPressDown': 'set onSecondaryLongPressDown(dynamic value)',
      'onSecondaryLongPressCancel': 'set onSecondaryLongPressCancel(dynamic value)',
      'onSecondaryLongPress': 'set onSecondaryLongPress(dynamic value)',
      'onSecondaryLongPressStart': 'set onSecondaryLongPressStart(dynamic value)',
      'onSecondaryLongPressMoveUpdate': 'set onSecondaryLongPressMoveUpdate(dynamic value)',
      'onSecondaryLongPressUp': 'set onSecondaryLongPressUp(dynamic value)',
      'onSecondaryLongPressEnd': 'set onSecondaryLongPressEnd(dynamic value)',
      'onTertiaryLongPressDown': 'set onTertiaryLongPressDown(dynamic value)',
      'onTertiaryLongPressCancel': 'set onTertiaryLongPressCancel(dynamic value)',
      'onTertiaryLongPress': 'set onTertiaryLongPress(dynamic value)',
      'onTertiaryLongPressStart': 'set onTertiaryLongPressStart(dynamic value)',
      'onTertiaryLongPressMoveUpdate': 'set onTertiaryLongPressMoveUpdate(dynamic value)',
      'onTertiaryLongPressUp': 'set onTertiaryLongPressUp(dynamic value)',
      'onTertiaryLongPressEnd': 'set onTertiaryLongPressEnd(dynamic value)',
    },
  );
}

// =============================================================================
// PolynomialFit Bridge
// =============================================================================

BridgedClass _createPolynomialFitBridge() {
  return BridgedClass(
    nativeType: $flutter_18.PolynomialFit,
    name: 'PolynomialFit',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PolynomialFit');
        final degree = D4.getRequiredArg<int>(positional, 0, 'degree', 'PolynomialFit');
        return $flutter_18.PolynomialFit(degree);
      },
    },
    getters: {
      'coefficients': (visitor, target) => D4.validateTarget<$flutter_18.PolynomialFit>(target, 'PolynomialFit').coefficients,
      'confidence': (visitor, target) => D4.validateTarget<$flutter_18.PolynomialFit>(target, 'PolynomialFit').confidence,
    },
    setters: {
      'confidence': (visitor, target, value) => 
        D4.validateTarget<$flutter_18.PolynomialFit>(target, 'PolynomialFit').confidence = value as double,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.PolynomialFit>(target, 'PolynomialFit');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'PolynomialFit(int degree)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'coefficients': 'List<double> get coefficients',
      'confidence': 'double get confidence',
    },
    setterSignatures: {
      'confidence': 'set confidence(dynamic value)',
    },
  );
}

// =============================================================================
// LeastSquaresSolver Bridge
// =============================================================================

BridgedClass _createLeastSquaresSolverBridge() {
  return BridgedClass(
    nativeType: $flutter_18.LeastSquaresSolver,
    name: 'LeastSquaresSolver',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'LeastSquaresSolver');
        if (positional.isEmpty) {
          throw ArgumentError('LeastSquaresSolver: Missing required argument "x" at position 0');
        }
        final x = D4.coerceList<double>(positional[0], 'x');
        if (positional.length <= 1) {
          throw ArgumentError('LeastSquaresSolver: Missing required argument "y" at position 1');
        }
        final y = D4.coerceList<double>(positional[1], 'y');
        if (positional.length <= 2) {
          throw ArgumentError('LeastSquaresSolver: Missing required argument "w" at position 2');
        }
        final w = D4.coerceList<double>(positional[2], 'w');
        return $flutter_18.LeastSquaresSolver(x, y, w);
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$flutter_18.LeastSquaresSolver>(target, 'LeastSquaresSolver').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_18.LeastSquaresSolver>(target, 'LeastSquaresSolver').y,
      'w': (visitor, target) => D4.validateTarget<$flutter_18.LeastSquaresSolver>(target, 'LeastSquaresSolver').w,
    },
    methods: {
      'solve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LeastSquaresSolver>(target, 'LeastSquaresSolver');
        D4.requireMinArgs(positional, 1, 'solve');
        final degree = D4.getRequiredArg<int>(positional, 0, 'degree', 'solve');
        return t.solve(degree);
      },
    },
    constructorSignatures: {
      '': 'LeastSquaresSolver(List<double> x, List<double> y, List<double> w)',
    },
    methodSignatures: {
      'solve': 'PolynomialFit? solve(int degree)',
    },
    getterSignatures: {
      'x': 'List<double> get x',
      'y': 'List<double> get y',
      'w': 'List<double> get w',
    },
  );
}

// =============================================================================
// GestureArenaTeam Bridge
// =============================================================================

BridgedClass _createGestureArenaTeamBridge() {
  return BridgedClass(
    nativeType: $flutter_29.GestureArenaTeam,
    name: 'GestureArenaTeam',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_29.GestureArenaTeam();
      },
    },
    getters: {
      'captain': (visitor, target) => D4.validateTarget<$flutter_29.GestureArenaTeam>(target, 'GestureArenaTeam').captain,
    },
    setters: {
      'captain': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.GestureArenaTeam>(target, 'GestureArenaTeam').captain = value as $flutter_4.GestureArenaMember?,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.GestureArenaTeam>(target, 'GestureArenaTeam');
        D4.requireMinArgs(positional, 2, 'add');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'add');
        final member = D4.getRequiredArg<$flutter_4.GestureArenaMember>(positional, 1, 'member', 'add');
        return t.add(pointer, member);
      },
    },
    constructorSignatures: {
      '': 'GestureArenaTeam()',
    },
    methodSignatures: {
      'add': 'GestureArenaEntry add(int pointer, GestureArenaMember member)',
    },
    getterSignatures: {
      'captain': 'GestureArenaMember? get captain',
    },
    setterSignatures: {
      'captain': 'set captain(dynamic value)',
    },
  );
}

// =============================================================================
// DragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_19.DragGestureRecognizer,
    name: 'DragGestureRecognizer',
    constructors: {
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').lastPosition,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').globalDistanceMoved,
      'team': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').debugDescription,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').multitouchDragStrategy = value as $flutter_24.MultitouchDragStrategy,
      'onDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onDown = value as $flutter_10.GestureDragDownCallback?,
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onStart = value as $flutter_10.GestureDragStartCallback?,
      'onUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onUpdate = value as $flutter_10.GestureDragUpdateCallback?,
      'onEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onEnd = value as $flutter_19.GestureDragEndCallback?,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onCancel = value as $flutter_19.GestureDragCancelCallback?,
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingDistance = value as double?,
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingVelocity = value as double?,
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').maxFlingVelocity = value as double?,
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').onlyAcceptDragOnThreshold = value as bool,
      'velocityTrackerBuilder': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer').velocityTrackerBuilder = value as $flutter_19.GestureVelocityTrackerBuilder,
    },
    methods: {
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'DragGestureRecognizer({Object? debugOwner, DragStartBehavior dragStartBehavior = DragStartBehavior.start, MultitouchDragStrategy multitouchDragStrategy = MultitouchDragStrategy.latestPointer, VelocityTracker Function(PointerEvent) velocityTrackerBuilder = _defaultBuilder, bool onlyAcceptDragOnThreshold = false, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'multitouchDragStrategy': 'MultitouchDragStrategy get multitouchDragStrategy',
      'onDown': 'GestureDragDownCallback? get onDown',
      'onStart': 'GestureDragStartCallback? get onStart',
      'onUpdate': 'GestureDragUpdateCallback? get onUpdate',
      'onEnd': 'GestureDragEndCallback? get onEnd',
      'onCancel': 'GestureDragCancelCallback? get onCancel',
      'minFlingDistance': 'double? get minFlingDistance',
      'minFlingVelocity': 'double? get minFlingVelocity',
      'maxFlingVelocity': 'double? get maxFlingVelocity',
      'onlyAcceptDragOnThreshold': 'bool get onlyAcceptDragOnThreshold',
      'velocityTrackerBuilder': 'GestureVelocityTrackerBuilder get velocityTrackerBuilder',
      'lastPosition': 'OffsetPair get lastPosition',
      'globalDistanceMoved': 'double get globalDistanceMoved',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'multitouchDragStrategy': 'set multitouchDragStrategy(dynamic value)',
      'onDown': 'set onDown(dynamic value)',
      'onStart': 'set onStart(dynamic value)',
      'onUpdate': 'set onUpdate(dynamic value)',
      'onEnd': 'set onEnd(dynamic value)',
      'onCancel': 'set onCancel(dynamic value)',
      'minFlingDistance': 'set minFlingDistance(dynamic value)',
      'minFlingVelocity': 'set minFlingVelocity(dynamic value)',
      'maxFlingVelocity': 'set maxFlingVelocity(dynamic value)',
      'onlyAcceptDragOnThreshold': 'set onlyAcceptDragOnThreshold(dynamic value)',
      'velocityTrackerBuilder': 'set velocityTrackerBuilder(dynamic value)',
    },
  );
}

// =============================================================================
// VerticalDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createVerticalDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_19.VerticalDragGestureRecognizer,
    name: 'VerticalDragGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_19.VerticalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_19.VerticalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').lastPosition,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').globalDistanceMoved,
      'team': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').debugDescription,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').multitouchDragStrategy = value as $flutter_24.MultitouchDragStrategy,
      'onDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onDown = value as $flutter_10.GestureDragDownCallback?,
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onStart = value as $flutter_10.GestureDragStartCallback?,
      'onUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onUpdate = value as $flutter_10.GestureDragUpdateCallback?,
      'onEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onEnd = value as $flutter_19.GestureDragEndCallback?,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onCancel = value as $flutter_19.GestureDragCancelCallback?,
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingDistance = value as double?,
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingVelocity = value as double?,
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').maxFlingVelocity = value as double?,
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onlyAcceptDragOnThreshold = value as bool,
      'velocityTrackerBuilder': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').velocityTrackerBuilder = value as $flutter_19.GestureVelocityTrackerBuilder,
    },
    methods: {
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
    },
    constructorSignatures: {
      '': 'VerticalDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'multitouchDragStrategy': 'MultitouchDragStrategy get multitouchDragStrategy',
      'onDown': 'void Function(DragDownDetails)? get onDown',
      'onStart': 'void Function(DragStartDetails)? get onStart',
      'onUpdate': 'void Function(DragUpdateDetails)? get onUpdate',
      'onEnd': 'void Function(DragEndDetails)? get onEnd',
      'onCancel': 'void Function()? get onCancel',
      'minFlingDistance': 'double? get minFlingDistance',
      'minFlingVelocity': 'double? get minFlingVelocity',
      'maxFlingVelocity': 'double? get maxFlingVelocity',
      'onlyAcceptDragOnThreshold': 'bool get onlyAcceptDragOnThreshold',
      'velocityTrackerBuilder': 'VelocityTracker Function(PointerEvent) get velocityTrackerBuilder',
      'lastPosition': 'OffsetPair get lastPosition',
      'globalDistanceMoved': 'double get globalDistanceMoved',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'multitouchDragStrategy': 'set multitouchDragStrategy(dynamic value)',
      'onDown': 'set onDown(dynamic value)',
      'onStart': 'set onStart(dynamic value)',
      'onUpdate': 'set onUpdate(dynamic value)',
      'onEnd': 'set onEnd(dynamic value)',
      'onCancel': 'set onCancel(dynamic value)',
      'minFlingDistance': 'set minFlingDistance(dynamic value)',
      'minFlingVelocity': 'set minFlingVelocity(dynamic value)',
      'maxFlingVelocity': 'set maxFlingVelocity(dynamic value)',
      'onlyAcceptDragOnThreshold': 'set onlyAcceptDragOnThreshold(dynamic value)',
      'velocityTrackerBuilder': 'set velocityTrackerBuilder(dynamic value)',
    },
  );
}

// =============================================================================
// HorizontalDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createHorizontalDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_19.HorizontalDragGestureRecognizer,
    name: 'HorizontalDragGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_19.HorizontalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_19.HorizontalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').lastPosition,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').globalDistanceMoved,
      'team': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').debugDescription,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').multitouchDragStrategy = value as $flutter_24.MultitouchDragStrategy,
      'onDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onDown = value as $flutter_10.GestureDragDownCallback?,
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onStart = value as $flutter_10.GestureDragStartCallback?,
      'onUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onUpdate = value as $flutter_10.GestureDragUpdateCallback?,
      'onEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onEnd = value as $flutter_19.GestureDragEndCallback?,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onCancel = value as $flutter_19.GestureDragCancelCallback?,
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingDistance = value as double?,
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingVelocity = value as double?,
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').maxFlingVelocity = value as double?,
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onlyAcceptDragOnThreshold = value as bool,
      'velocityTrackerBuilder': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').velocityTrackerBuilder = value as $flutter_19.GestureVelocityTrackerBuilder,
    },
    methods: {
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
    },
    constructorSignatures: {
      '': 'HorizontalDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'multitouchDragStrategy': 'MultitouchDragStrategy get multitouchDragStrategy',
      'onDown': 'void Function(DragDownDetails)? get onDown',
      'onStart': 'void Function(DragStartDetails)? get onStart',
      'onUpdate': 'void Function(DragUpdateDetails)? get onUpdate',
      'onEnd': 'void Function(DragEndDetails)? get onEnd',
      'onCancel': 'void Function()? get onCancel',
      'minFlingDistance': 'double? get minFlingDistance',
      'minFlingVelocity': 'double? get minFlingVelocity',
      'maxFlingVelocity': 'double? get maxFlingVelocity',
      'onlyAcceptDragOnThreshold': 'bool get onlyAcceptDragOnThreshold',
      'velocityTrackerBuilder': 'VelocityTracker Function(PointerEvent) get velocityTrackerBuilder',
      'lastPosition': 'OffsetPair get lastPosition',
      'globalDistanceMoved': 'double get globalDistanceMoved',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'multitouchDragStrategy': 'set multitouchDragStrategy(dynamic value)',
      'onDown': 'set onDown(dynamic value)',
      'onStart': 'set onStart(dynamic value)',
      'onUpdate': 'set onUpdate(dynamic value)',
      'onEnd': 'set onEnd(dynamic value)',
      'onCancel': 'set onCancel(dynamic value)',
      'minFlingDistance': 'set minFlingDistance(dynamic value)',
      'minFlingVelocity': 'set minFlingVelocity(dynamic value)',
      'maxFlingVelocity': 'set maxFlingVelocity(dynamic value)',
      'onlyAcceptDragOnThreshold': 'set onlyAcceptDragOnThreshold(dynamic value)',
      'velocityTrackerBuilder': 'set velocityTrackerBuilder(dynamic value)',
    },
  );
}

// =============================================================================
// PanGestureRecognizer Bridge
// =============================================================================

BridgedClass _createPanGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_19.PanGestureRecognizer,
    name: 'PanGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_19.PanGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_19.PanGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').lastPosition,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').globalDistanceMoved,
      'team': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').debugDescription,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').multitouchDragStrategy = value as $flutter_24.MultitouchDragStrategy,
      'onDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onDown = value as $flutter_10.GestureDragDownCallback?,
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onStart = value as $flutter_10.GestureDragStartCallback?,
      'onUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onUpdate = value as $flutter_10.GestureDragUpdateCallback?,
      'onEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onEnd = value as $flutter_19.GestureDragEndCallback?,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onCancel = value as $flutter_19.GestureDragCancelCallback?,
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingDistance = value as double?,
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingVelocity = value as double?,
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').maxFlingVelocity = value as double?,
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').onlyAcceptDragOnThreshold = value as bool,
      'velocityTrackerBuilder': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer').velocityTrackerBuilder = value as $flutter_19.GestureVelocityTrackerBuilder,
    },
    methods: {
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_30.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
    },
    constructorSignatures: {
      '': 'PanGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'multitouchDragStrategy': 'MultitouchDragStrategy get multitouchDragStrategy',
      'onDown': 'void Function(DragDownDetails)? get onDown',
      'onStart': 'void Function(DragStartDetails)? get onStart',
      'onUpdate': 'void Function(DragUpdateDetails)? get onUpdate',
      'onEnd': 'void Function(DragEndDetails)? get onEnd',
      'onCancel': 'void Function()? get onCancel',
      'minFlingDistance': 'double? get minFlingDistance',
      'minFlingVelocity': 'double? get minFlingVelocity',
      'maxFlingVelocity': 'double? get maxFlingVelocity',
      'onlyAcceptDragOnThreshold': 'bool get onlyAcceptDragOnThreshold',
      'velocityTrackerBuilder': 'VelocityTracker Function(PointerEvent) get velocityTrackerBuilder',
      'lastPosition': 'OffsetPair get lastPosition',
      'globalDistanceMoved': 'double get globalDistanceMoved',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'multitouchDragStrategy': 'set multitouchDragStrategy(dynamic value)',
      'onDown': 'set onDown(dynamic value)',
      'onStart': 'set onStart(dynamic value)',
      'onUpdate': 'set onUpdate(dynamic value)',
      'onEnd': 'set onEnd(dynamic value)',
      'onCancel': 'set onCancel(dynamic value)',
      'minFlingDistance': 'set minFlingDistance(dynamic value)',
      'minFlingVelocity': 'set minFlingVelocity(dynamic value)',
      'maxFlingVelocity': 'set maxFlingVelocity(dynamic value)',
      'onlyAcceptDragOnThreshold': 'set onlyAcceptDragOnThreshold(dynamic value)',
      'velocityTrackerBuilder': 'set velocityTrackerBuilder(dynamic value)',
    },
  );
}

// =============================================================================
// MultiDragPointerState Bridge
// =============================================================================

BridgedClass _createMultiDragPointerStateBridge() {
  return BridgedClass(
    nativeType: $flutter_20.MultiDragPointerState,
    name: 'MultiDragPointerState',
    constructors: {
    },
    getters: {
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragPointerState>(target, 'MultiDragPointerState').gestureSettings,
      'initialPosition': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragPointerState>(target, 'MultiDragPointerState').initialPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragPointerState>(target, 'MultiDragPointerState').kind,
      'pendingDelta': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragPointerState>(target, 'MultiDragPointerState').pendingDelta,
    },
    getterSignatures: {
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'initialPosition': 'Offset get initialPosition',
      'kind': 'PointerDeviceKind get kind',
      'pendingDelta': 'Offset? get pendingDelta',
    },
  );
}

// =============================================================================
// MultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.MultiDragGestureRecognizer,
    name: 'MultiDragGestureRecognizer',
    constructors: {
    },
    getters: {
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').onStart,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').debugDescription,
    },
    setters: {
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').onStart = value as $flutter_20.GestureMultiDragStartCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'onStart': 'GestureMultiDragStartCallback? get onStart',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'onStart': 'set onStart(dynamic value)',
    },
  );
}

// =============================================================================
// ImmediateMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createImmediateMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.ImmediateMultiDragGestureRecognizer,
    name: 'ImmediateMultiDragGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_20.ImmediateMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; });
      },
    },
    getters: {
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').onStart,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').debugDescription,
    },
    setters: {
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').onStart = value as $flutter_20.GestureMultiDragStartCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'ImmediateMultiDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int)? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
    },
    getterSignatures: {
      'onStart': 'Drag? Function(Offset)? get onStart',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'onStart': 'set onStart(dynamic value)',
    },
  );
}

// =============================================================================
// HorizontalMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createHorizontalMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.HorizontalMultiDragGestureRecognizer,
    name: 'HorizontalMultiDragGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_20.HorizontalMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; });
      },
    },
    getters: {
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').onStart,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').debugDescription,
    },
    setters: {
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').onStart = value as $flutter_20.GestureMultiDragStartCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'HorizontalMultiDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int)? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
    },
    getterSignatures: {
      'onStart': 'Drag? Function(Offset)? get onStart',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'onStart': 'set onStart(dynamic value)',
    },
  );
}

// =============================================================================
// VerticalMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createVerticalMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.VerticalMultiDragGestureRecognizer,
    name: 'VerticalMultiDragGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_20.VerticalMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; });
      },
    },
    getters: {
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').onStart,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').debugDescription,
    },
    setters: {
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').onStart = value as $flutter_20.GestureMultiDragStartCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'VerticalMultiDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int)? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
    },
    getterSignatures: {
      'onStart': 'Drag? Function(Offset)? get onStart',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'onStart': 'set onStart(dynamic value)',
    },
  );
}

// =============================================================================
// DelayedMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createDelayedMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.DelayedMultiDragGestureRecognizer,
    name: 'DelayedMultiDragGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        if (!named.containsKey('delay')) {
          return $flutter_20.DelayedMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; });
        }
        if (named.containsKey('delay')) {
          final delay = D4.getRequiredNamedArg<Duration>(named, 'delay', 'DelayedMultiDragGestureRecognizer');
          return $flutter_20.DelayedMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; }, delay: delay);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').onStart,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').debugDescription,
      'delay': (visitor, target) => D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').delay,
    },
    setters: {
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').onStart = value as $flutter_20.GestureMultiDragStartCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'DelayedMultiDragGestureRecognizer({Duration delay = kLongPressTimeout, Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int)? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
    },
    getterSignatures: {
      'onStart': 'Drag? Function(Offset)? get onStart',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'delay': 'Duration get delay',
    },
    setterSignatures: {
      'onStart': 'set onStart(dynamic value)',
    },
  );
}

// =============================================================================
// TapDownDetails Bridge
// =============================================================================

BridgedClass _createTapDownDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_27.TapDownDetails,
    name: 'TapDownDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_27.TapDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_27.TapDownDetails>(target, 'TapDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_27.TapDownDetails>(target, 'TapDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_27.TapDownDetails>(target, 'TapDownDetails').kind,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.TapDownDetails>(target, 'TapDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.TapDownDetails>(target, 'TapDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.TapDownDetails>(target, 'TapDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDownDetails({Offset globalPosition = Offset.zero, Offset? localPosition, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind? get kind',
    },
  );
}

// =============================================================================
// TapUpDetails Bridge
// =============================================================================

BridgedClass _createTapUpDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_27.TapUpDetails,
    name: 'TapUpDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getRequiredNamedArg<PointerDeviceKind>(named, 'kind', 'TapUpDetails');
        return $flutter_27.TapUpDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_27.TapUpDetails>(target, 'TapUpDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_27.TapUpDetails>(target, 'TapUpDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_27.TapUpDetails>(target, 'TapUpDetails').kind,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.TapUpDetails>(target, 'TapUpDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.TapUpDetails>(target, 'TapUpDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.TapUpDetails>(target, 'TapUpDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapUpDetails({Offset globalPosition = Offset.zero, Offset? localPosition, required PointerDeviceKind kind})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind get kind',
    },
  );
}

// =============================================================================
// DoubleTapGestureRecognizer Bridge
// =============================================================================

BridgedClass _createDoubleTapGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_21.DoubleTapGestureRecognizer,
    name: 'DoubleTapGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_21.DoubleTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_21.DoubleTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onDoubleTapDown': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapDown,
      'onDoubleTap': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTap,
      'onDoubleTapCancel': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapCancel,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').debugDescription,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').allowedButtonsFilter,
    },
    setters: {
      'onDoubleTapDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapDown = value as dynamic,
      'onDoubleTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTap = value as $flutter_21.GestureDoubleTapCallback?,
      'onDoubleTapCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapCancel = value as dynamic,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'DoubleTapGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'onDoubleTapDown': 'GestureTapDownCallback? get onDoubleTapDown',
      'onDoubleTap': 'GestureDoubleTapCallback? get onDoubleTap',
      'onDoubleTapCancel': 'GestureTapCancelCallback? get onDoubleTapCancel',
      'debugDescription': 'String get debugDescription',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
    },
    setterSignatures: {
      'onDoubleTapDown': 'set onDoubleTapDown(dynamic value)',
      'onDoubleTap': 'set onDoubleTap(dynamic value)',
      'onDoubleTapCancel': 'set onDoubleTapCancel(dynamic value)',
    },
  );
}

// =============================================================================
// MultiTapGestureRecognizer Bridge
// =============================================================================

BridgedClass _createMultiTapGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_21.MultiTapGestureRecognizer,
    name: 'MultiTapGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final longTapDelay = D4.getNamedArgWithDefault<Duration>(named, 'longTapDelay', Duration.zero);
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_21.MultiTapGestureRecognizer(longTapDelay: longTapDelay, debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_21.MultiTapGestureRecognizer(longTapDelay: longTapDelay, debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapUp,
      'onTap': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTap,
      'onTapCancel': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapCancel,
      'longTapDelay': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').longTapDelay,
      'onLongTapDown': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onLongTapDown,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').debugDescription,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').allowedButtonsFilter,
    },
    setters: {
      'onTapDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapDown = value as $flutter_21.GestureMultiTapDownCallback?,
      'onTapUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapUp = value as $flutter_21.GestureMultiTapUpCallback?,
      'onTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTap = value as $flutter_21.GestureMultiTapCallback?,
      'onTapCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapCancel = value as $flutter_21.GestureMultiTapCancelCallback?,
      'longTapDelay': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').longTapDelay = value as Duration,
      'onLongTapDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onLongTapDown = value as $flutter_21.GestureMultiTapDownCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'MultiTapGestureRecognizer({Duration longTapDelay = Duration.zero, Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'onTapDown': 'GestureMultiTapDownCallback? get onTapDown',
      'onTapUp': 'GestureMultiTapUpCallback? get onTapUp',
      'onTap': 'GestureMultiTapCallback? get onTap',
      'onTapCancel': 'GestureMultiTapCancelCallback? get onTapCancel',
      'longTapDelay': 'Duration get longTapDelay',
      'onLongTapDown': 'GestureMultiTapDownCallback? get onLongTapDown',
      'debugDescription': 'String get debugDescription',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
    },
    setterSignatures: {
      'onTapDown': 'set onTapDown(dynamic value)',
      'onTapUp': 'set onTapUp(dynamic value)',
      'onTap': 'set onTap(dynamic value)',
      'onTapCancel': 'set onTapCancel(dynamic value)',
      'longTapDelay': 'set longTapDelay(dynamic value)',
      'onLongTapDown': 'set onLongTapDown(dynamic value)',
    },
  );
}

// =============================================================================
// SerialTapDownDetails Bridge
// =============================================================================

BridgedClass _createSerialTapDownDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_21.SerialTapDownDetails,
    name: 'SerialTapDownDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getRequiredNamedArg<PointerDeviceKind>(named, 'kind', 'SerialTapDownDetails');
        final buttons = D4.getNamedArgWithDefault<int>(named, 'buttons', 0);
        final count = D4.getNamedArgWithDefault<int>(named, 'count', 1);
        return $flutter_21.SerialTapDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, buttons: buttons, count: count);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails').kind,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails').buttons,
      'count': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails').count,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapDownDetails>(target, 'SerialTapDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'SerialTapDownDetails({Offset globalPosition = Offset.zero, Offset? localPosition, required PointerDeviceKind kind, int buttons = 0, int count = 1})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind get kind',
      'buttons': 'int get buttons',
      'count': 'int get count',
    },
  );
}

// =============================================================================
// SerialTapCancelDetails Bridge
// =============================================================================

BridgedClass _createSerialTapCancelDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_21.SerialTapCancelDetails,
    name: 'SerialTapCancelDetails',
    constructors: {
      '': (visitor, positional, named) {
        final count = D4.getNamedArgWithDefault<int>(named, 'count', 1);
        return $flutter_21.SerialTapCancelDetails(count: count);
      },
    },
    getters: {
      'count': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapCancelDetails>(target, 'SerialTapCancelDetails').count,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapCancelDetails>(target, 'SerialTapCancelDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapCancelDetails>(target, 'SerialTapCancelDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapCancelDetails>(target, 'SerialTapCancelDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'SerialTapCancelDetails({int count = 1})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'count': 'int get count',
    },
  );
}

// =============================================================================
// SerialTapUpDetails Bridge
// =============================================================================

BridgedClass _createSerialTapUpDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_21.SerialTapUpDetails,
    name: 'SerialTapUpDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final count = D4.getNamedArgWithDefault<int>(named, 'count', 1);
        return $flutter_21.SerialTapUpDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, count: count);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapUpDetails>(target, 'SerialTapUpDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapUpDetails>(target, 'SerialTapUpDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapUpDetails>(target, 'SerialTapUpDetails').kind,
      'count': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapUpDetails>(target, 'SerialTapUpDetails').count,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapUpDetails>(target, 'SerialTapUpDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapUpDetails>(target, 'SerialTapUpDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapUpDetails>(target, 'SerialTapUpDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'SerialTapUpDetails({Offset globalPosition = Offset.zero, Offset? localPosition, PointerDeviceKind? kind, int count = 1})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind? get kind',
      'count': 'int get count',
    },
  );
}

// =============================================================================
// SerialTapGestureRecognizer Bridge
// =============================================================================

BridgedClass _createSerialTapGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_21.SerialTapGestureRecognizer,
    name: 'SerialTapGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_21.SerialTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_21.SerialTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onSerialTapDown': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapDown,
      'onSerialTapCancel': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapCancel,
      'onSerialTapUp': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapUp,
      'isTrackingPointer': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').isTrackingPointer,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').debugDescription,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').allowedButtonsFilter,
    },
    setters: {
      'onSerialTapDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapDown = value as $flutter_21.GestureSerialTapDownCallback?,
      'onSerialTapCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapCancel = value as $flutter_21.GestureSerialTapCancelCallback?,
      'onSerialTapUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapUp = value as $flutter_21.GestureSerialTapUpCallback?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'SerialTapGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'onSerialTapDown': 'GestureSerialTapDownCallback? get onSerialTapDown',
      'onSerialTapCancel': 'GestureSerialTapCancelCallback? get onSerialTapCancel',
      'onSerialTapUp': 'GestureSerialTapUpCallback? get onSerialTapUp',
      'isTrackingPointer': 'bool get isTrackingPointer',
      'debugDescription': 'String get debugDescription',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
    },
    setterSignatures: {
      'onSerialTapDown': 'set onSerialTapDown(dynamic value)',
      'onSerialTapCancel': 'set onSerialTapCancel(dynamic value)',
      'onSerialTapUp': 'set onSerialTapUp(dynamic value)',
    },
  );
}

// =============================================================================
// PointerEventResampler Bridge
// =============================================================================

BridgedClass _createPointerEventResamplerBridge() {
  return BridgedClass(
    nativeType: $flutter_25.PointerEventResampler,
    name: 'PointerEventResampler',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_25.PointerEventResampler();
      },
    },
    getters: {
      'hasPendingEvents': (visitor, target) => D4.validateTarget<$flutter_25.PointerEventResampler>(target, 'PointerEventResampler').hasPendingEvents,
      'isTracked': (visitor, target) => D4.validateTarget<$flutter_25.PointerEventResampler>(target, 'PointerEventResampler').isTracked,
      'isDown': (visitor, target) => D4.validateTarget<$flutter_25.PointerEventResampler>(target, 'PointerEventResampler').isDown,
    },
    methods: {
      'addEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PointerEventResampler>(target, 'PointerEventResampler');
        D4.requireMinArgs(positional, 1, 'addEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'addEvent');
        t.addEvent(event);
        return null;
      },
      'sample': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PointerEventResampler>(target, 'PointerEventResampler');
        D4.requireMinArgs(positional, 3, 'sample');
        final sampleTime = D4.getRequiredArg<Duration>(positional, 0, 'sampleTime', 'sample');
        final nextSampleTime = D4.getRequiredArg<Duration>(positional, 1, 'nextSampleTime', 'sample');
        if (positional.length <= 2) {
          throw ArgumentError('sample: Missing required argument "callback" at position 2');
        }
        final callbackRaw = positional[2];
        t.sample(sampleTime, nextSampleTime, ($flutter_12.PointerEvent p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'stop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PointerEventResampler>(target, 'PointerEventResampler');
        D4.requireMinArgs(positional, 1, 'stop');
        if (positional.isEmpty) {
          throw ArgumentError('stop: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.stop(($flutter_12.PointerEvent p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
    },
    constructorSignatures: {
      '': 'PointerEventResampler()',
    },
    methodSignatures: {
      'addEvent': 'void addEvent(PointerEvent event)',
      'sample': 'void sample(Duration sampleTime, Duration nextSampleTime, HandleEventCallback callback)',
      'stop': 'void stop(HandleEventCallback callback)',
    },
    getterSignatures: {
      'hasPendingEvents': 'bool get hasPendingEvents',
      'isTracked': 'bool get isTracked',
      'isDown': 'bool get isDown',
    },
  );
}

// =============================================================================
// ScaleStartDetails Bridge
// =============================================================================

BridgedClass _createScaleStartDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_26.ScaleStartDetails,
    name: 'ScaleStartDetails',
    constructors: {
      '': (visitor, positional, named) {
        final focalPoint = D4.getNamedArgWithDefault<Offset>(named, 'focalPoint', $dart_ui.Offset.zero);
        final localFocalPoint = D4.getOptionalNamedArg<Offset?>(named, 'localFocalPoint');
        final pointerCount = D4.getNamedArgWithDefault<int>(named, 'pointerCount', 0);
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_26.ScaleStartDetails(focalPoint: focalPoint, localFocalPoint: localFocalPoint, pointerCount: pointerCount, sourceTimeStamp: sourceTimeStamp, kind: kind);
      },
    },
    getters: {
      'focalPoint': (visitor, target) => D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails').focalPoint,
      'localFocalPoint': (visitor, target) => D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails').localFocalPoint,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails').pointerCount,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails').sourceTimeStamp,
      'kind': (visitor, target) => D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails').kind,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleStartDetails>(target, 'ScaleStartDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ScaleStartDetails({Offset focalPoint = Offset.zero, Offset? localFocalPoint, int pointerCount = 0, Duration? sourceTimeStamp, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'focalPoint': 'Offset get focalPoint',
      'localFocalPoint': 'Offset get localFocalPoint',
      'pointerCount': 'int get pointerCount',
      'sourceTimeStamp': 'Duration? get sourceTimeStamp',
      'kind': 'PointerDeviceKind? get kind',
    },
  );
}

// =============================================================================
// ScaleUpdateDetails Bridge
// =============================================================================

BridgedClass _createScaleUpdateDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_26.ScaleUpdateDetails,
    name: 'ScaleUpdateDetails',
    constructors: {
      '': (visitor, positional, named) {
        final focalPoint = D4.getNamedArgWithDefault<Offset>(named, 'focalPoint', $dart_ui.Offset.zero);
        final localFocalPoint = D4.getOptionalNamedArg<Offset?>(named, 'localFocalPoint');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final horizontalScale = D4.getNamedArgWithDefault<double>(named, 'horizontalScale', 1.0);
        final verticalScale = D4.getNamedArgWithDefault<double>(named, 'verticalScale', 1.0);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0.0);
        final pointerCount = D4.getNamedArgWithDefault<int>(named, 'pointerCount', 0);
        final focalPointDelta = D4.getNamedArgWithDefault<Offset>(named, 'focalPointDelta', $dart_ui.Offset.zero);
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        return $flutter_26.ScaleUpdateDetails(focalPoint: focalPoint, localFocalPoint: localFocalPoint, scale: scale, horizontalScale: horizontalScale, verticalScale: verticalScale, rotation: rotation, pointerCount: pointerCount, focalPointDelta: focalPointDelta, sourceTimeStamp: sourceTimeStamp);
      },
    },
    getters: {
      'focalPointDelta': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').focalPointDelta,
      'focalPoint': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').focalPoint,
      'localFocalPoint': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').localFocalPoint,
      'scale': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').scale,
      'horizontalScale': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').horizontalScale,
      'verticalScale': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').verticalScale,
      'rotation': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').rotation,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').pointerCount,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').sourceTimeStamp,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleUpdateDetails>(target, 'ScaleUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ScaleUpdateDetails({Offset focalPoint = Offset.zero, Offset? localFocalPoint, double scale = 1.0, double horizontalScale = 1.0, double verticalScale = 1.0, double rotation = 0.0, int pointerCount = 0, Offset focalPointDelta = Offset.zero, Duration? sourceTimeStamp})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'focalPointDelta': 'Offset get focalPointDelta',
      'focalPoint': 'Offset get focalPoint',
      'localFocalPoint': 'Offset get localFocalPoint',
      'scale': 'double get scale',
      'horizontalScale': 'double get horizontalScale',
      'verticalScale': 'double get verticalScale',
      'rotation': 'double get rotation',
      'pointerCount': 'int get pointerCount',
      'sourceTimeStamp': 'Duration? get sourceTimeStamp',
    },
  );
}

// =============================================================================
// ScaleEndDetails Bridge
// =============================================================================

BridgedClass _createScaleEndDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_26.ScaleEndDetails,
    name: 'ScaleEndDetails',
    constructors: {
      '': (visitor, positional, named) {
        final velocity = D4.getNamedArgWithDefault<$flutter_30.Velocity>(named, 'velocity', $flutter_30.Velocity.zero);
        final scaleVelocity = D4.getNamedArgWithDefault<double>(named, 'scaleVelocity', 0);
        final pointerCount = D4.getNamedArgWithDefault<int>(named, 'pointerCount', 0);
        return $flutter_26.ScaleEndDetails(velocity: velocity, scaleVelocity: scaleVelocity, pointerCount: pointerCount);
      },
    },
    getters: {
      'velocity': (visitor, target) => D4.validateTarget<$flutter_26.ScaleEndDetails>(target, 'ScaleEndDetails').velocity,
      'scaleVelocity': (visitor, target) => D4.validateTarget<$flutter_26.ScaleEndDetails>(target, 'ScaleEndDetails').scaleVelocity,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_26.ScaleEndDetails>(target, 'ScaleEndDetails').pointerCount,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleEndDetails>(target, 'ScaleEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleEndDetails>(target, 'ScaleEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleEndDetails>(target, 'ScaleEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ScaleEndDetails({Velocity velocity = Velocity.zero, double scaleVelocity = 0, int pointerCount = 0})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'velocity': 'Velocity get velocity',
      'scaleVelocity': 'double get scaleVelocity',
      'pointerCount': 'int get pointerCount',
    },
  );
}

// =============================================================================
// ScaleGestureRecognizer Bridge
// =============================================================================

BridgedClass _createScaleGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_26.ScaleGestureRecognizer,
    name: 'ScaleGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        final dragStartBehavior = D4.getNamedArgWithDefault<$flutter_24.DragStartBehavior>(named, 'dragStartBehavior', $flutter_24.DragStartBehavior.down);
        final trackpadScrollCausesScale = D4.getNamedArgWithDefault<bool>(named, 'trackpadScrollCausesScale', false);
        if (!named.containsKey('allowedButtonsFilter') && !named.containsKey('trackpadScrollToScaleFactor')) {
          return $flutter_26.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale);
        }
        if (named.containsKey('allowedButtonsFilter') && !named.containsKey('trackpadScrollToScaleFactor')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          return $flutter_26.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale, allowedButtonsFilter: allowedButtonsFilter);
        }
        if (!named.containsKey('allowedButtonsFilter') && named.containsKey('trackpadScrollToScaleFactor')) {
          final trackpadScrollToScaleFactor = D4.getRequiredNamedArg<Offset>(named, 'trackpadScrollToScaleFactor', 'ScaleGestureRecognizer');
          return $flutter_26.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale, trackpadScrollToScaleFactor: trackpadScrollToScaleFactor);
        }
        if (named.containsKey('allowedButtonsFilter') && named.containsKey('trackpadScrollToScaleFactor')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = (int p0) { return D4.callInterpreterCallback(visitor, allowedButtonsFilterRaw, [p0]) as bool; };
          final trackpadScrollToScaleFactor = D4.getRequiredNamedArg<Offset>(named, 'trackpadScrollToScaleFactor', 'ScaleGestureRecognizer');
          return $flutter_26.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale, allowedButtonsFilter: allowedButtonsFilter, trackpadScrollToScaleFactor: trackpadScrollToScaleFactor);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').dragStartBehavior,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onEnd,
      'trackpadScrollCausesScale': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollCausesScale,
      'trackpadScrollToScaleFactor': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollToScaleFactor,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').pointerCount,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').allowedButtonsFilter,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'onStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onStart = value as $flutter_26.GestureScaleStartCallback?,
      'onUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onUpdate = value as $flutter_26.GestureScaleUpdateCallback?,
      'onEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onEnd = value as $flutter_26.GestureScaleEndCallback?,
      'trackpadScrollCausesScale': (visitor, target, value) => 
        D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollCausesScale = value as bool,
      'trackpadScrollToScaleFactor': (visitor, target, value) => 
        D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollToScaleFactor = value as Offset,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'ScaleGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior, DragStartBehavior dragStartBehavior = DragStartBehavior.down, bool trackpadScrollCausesScale = false, Offset trackpadScrollToScaleFactor = kDefaultTrackpadScrollToScaleFactor})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'onStart': 'GestureScaleStartCallback? get onStart',
      'onUpdate': 'GestureScaleUpdateCallback? get onUpdate',
      'onEnd': 'GestureScaleEndCallback? get onEnd',
      'trackpadScrollCausesScale': 'bool get trackpadScrollCausesScale',
      'trackpadScrollToScaleFactor': 'Offset get trackpadScrollToScaleFactor',
      'pointerCount': 'int get pointerCount',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'onStart': 'set onStart(dynamic value)',
      'onUpdate': 'set onUpdate(dynamic value)',
      'onEnd': 'set onEnd(dynamic value)',
      'trackpadScrollCausesScale': 'set trackpadScrollCausesScale(dynamic value)',
      'trackpadScrollToScaleFactor': 'set trackpadScrollToScaleFactor(dynamic value)',
    },
  );
}

// =============================================================================
// TapDragDownDetails Bridge
// =============================================================================

BridgedClass _createTapDragDownDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapDragDownDetails,
    name: 'TapDragDownDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'TapDragDownDetails');
        final localPosition = D4.getRequiredNamedArg<Offset>(named, 'localPosition', 'TapDragDownDetails');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragDownDetails');
        return $flutter_28.TapDragDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragDownDetails>(target, 'TapDragDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragDownDetails>(target, 'TapDragDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.TapDragDownDetails>(target, 'TapDragDownDetails').kind,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.TapDragDownDetails>(target, 'TapDragDownDetails').consecutiveTapCount,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragDownDetails>(target, 'TapDragDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragDownDetails>(target, 'TapDragDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragDownDetails>(target, 'TapDragDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragDownDetails({required Offset globalPosition, required Offset localPosition, PointerDeviceKind? kind, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind? get kind',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
  );
}

// =============================================================================
// TapDragUpDetails Bridge
// =============================================================================

BridgedClass _createTapDragUpDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapDragUpDetails,
    name: 'TapDragUpDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'TapDragUpDetails');
        final localPosition = D4.getRequiredNamedArg<Offset>(named, 'localPosition', 'TapDragUpDetails');
        final kind = D4.getRequiredNamedArg<PointerDeviceKind>(named, 'kind', 'TapDragUpDetails');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragUpDetails');
        return $flutter_28.TapDragUpDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpDetails>(target, 'TapDragUpDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpDetails>(target, 'TapDragUpDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpDetails>(target, 'TapDragUpDetails').kind,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpDetails>(target, 'TapDragUpDetails').consecutiveTapCount,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragUpDetails>(target, 'TapDragUpDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragUpDetails>(target, 'TapDragUpDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragUpDetails>(target, 'TapDragUpDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragUpDetails({required Offset globalPosition, required Offset localPosition, required PointerDeviceKind kind, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind get kind',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
  );
}

// =============================================================================
// TapDragStartDetails Bridge
// =============================================================================

BridgedClass _createTapDragStartDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapDragStartDetails,
    name: 'TapDragStartDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'TapDragStartDetails');
        final localPosition = D4.getRequiredNamedArg<Offset>(named, 'localPosition', 'TapDragStartDetails');
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragStartDetails');
        return $flutter_28.TapDragStartDetails(globalPosition: globalPosition, localPosition: localPosition, sourceTimeStamp: sourceTimeStamp, kind: kind, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails').localPosition,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails').sourceTimeStamp,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails').kind,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails').consecutiveTapCount,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragStartDetails>(target, 'TapDragStartDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragStartDetails({required Offset globalPosition, required Offset localPosition, Duration? sourceTimeStamp, PointerDeviceKind? kind, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'sourceTimeStamp': 'Duration? get sourceTimeStamp',
      'kind': 'PointerDeviceKind? get kind',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
  );
}

// =============================================================================
// TapDragUpdateDetails Bridge
// =============================================================================

BridgedClass _createTapDragUpdateDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapDragUpdateDetails,
    name: 'TapDragUpdateDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'TapDragUpdateDetails');
        final localPosition = D4.getRequiredNamedArg<Offset>(named, 'localPosition', 'TapDragUpdateDetails');
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
        final primaryDelta = D4.getOptionalNamedArg<double?>(named, 'primaryDelta');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final offsetFromOrigin = D4.getRequiredNamedArg<Offset>(named, 'offsetFromOrigin', 'TapDragUpdateDetails');
        final localOffsetFromOrigin = D4.getRequiredNamedArg<Offset>(named, 'localOffsetFromOrigin', 'TapDragUpdateDetails');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragUpdateDetails');
        return $flutter_28.TapDragUpdateDetails(globalPosition: globalPosition, localPosition: localPosition, sourceTimeStamp: sourceTimeStamp, delta: delta, primaryDelta: primaryDelta, kind: kind, offsetFromOrigin: offsetFromOrigin, localOffsetFromOrigin: localOffsetFromOrigin, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').localPosition,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').sourceTimeStamp,
      'delta': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').delta,
      'primaryDelta': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').primaryDelta,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').kind,
      'offsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').offsetFromOrigin,
      'localOffsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').localOffsetFromOrigin,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').consecutiveTapCount,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragUpdateDetails>(target, 'TapDragUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragUpdateDetails({required Offset globalPosition, required Offset localPosition, Duration? sourceTimeStamp, Offset delta = Offset.zero, double? primaryDelta, PointerDeviceKind? kind, required Offset offsetFromOrigin, required Offset localOffsetFromOrigin, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'sourceTimeStamp': 'Duration? get sourceTimeStamp',
      'delta': 'Offset get delta',
      'primaryDelta': 'double? get primaryDelta',
      'kind': 'PointerDeviceKind? get kind',
      'offsetFromOrigin': 'Offset get offsetFromOrigin',
      'localOffsetFromOrigin': 'Offset get localOffsetFromOrigin',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
  );
}

// =============================================================================
// TapDragEndDetails Bridge
// =============================================================================

BridgedClass _createTapDragEndDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapDragEndDetails,
    name: 'TapDragEndDetails',
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final velocity = D4.getNamedArgWithDefault<$flutter_30.Velocity>(named, 'velocity', $flutter_30.Velocity.zero);
        final primaryVelocity = D4.getOptionalNamedArg<double?>(named, 'primaryVelocity');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragEndDetails');
        return $flutter_28.TapDragEndDetails(globalPosition: globalPosition, localPosition: localPosition, velocity: velocity, primaryVelocity: primaryVelocity, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails').localPosition,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails').velocity,
      'primaryVelocity': (visitor, target) => D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails').primaryVelocity,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails').consecutiveTapCount,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDragEndDetails>(target, 'TapDragEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragEndDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Velocity velocity = Velocity.zero, double? primaryVelocity, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'velocity': 'Velocity get velocity',
      'primaryVelocity': 'double? get primaryVelocity',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
  );
}

// =============================================================================
// BaseTapAndDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createBaseTapAndDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_28.BaseTapAndDragGestureRecognizer,
    name: 'BaseTapAndDragGestureRecognizer',
    constructors: {
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragUpdateThrottleFrequency,
      'maxConsecutiveTap': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').maxConsecutiveTap,
      'eagerVictoryOnDrag': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').eagerVictoryOnDrag,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapUp,
      'onDragStart': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragStart,
      'onDragUpdate': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragUpdate,
      'onDragEnd': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onCancel,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').allowedButtonsFilter,
      'currentDown': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').currentDown,
      'currentUp': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').currentUp,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').consecutiveTapCount,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragUpdateThrottleFrequency = value as Duration?,
      'maxConsecutiveTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').maxConsecutiveTap = value as int?,
      'eagerVictoryOnDrag': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').eagerVictoryOnDrag = value as bool,
      'onTapDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapDown = value as $flutter_28.GestureTapDragDownCallback?,
      'onTapUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapUp = value as $flutter_28.GestureTapDragUpCallback?,
      'onDragStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragStart = value as $flutter_28.GestureTapDragStartCallback?,
      'onDragUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragUpdate = value as $flutter_28.GestureTapDragUpdateCallback?,
      'onDragEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragEnd = value as $flutter_28.GestureTapDragEndCallback?,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onCancel = value as $flutter_28.GestureCancelCallback?,
      'onTapTrackStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapTrackStart = value as void Function()?,
      'onTapTrackReset': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapTrackReset = value as void Function()?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'BaseTapAndDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, bool Function(int) allowedButtonsFilter = _defaultButtonAcceptBehavior, bool eagerVictoryOnDrag = true})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleEvent': 'void handleEvent(PointerEvent event)',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'dragUpdateThrottleFrequency': 'Duration? get dragUpdateThrottleFrequency',
      'maxConsecutiveTap': 'int? get maxConsecutiveTap',
      'eagerVictoryOnDrag': 'bool get eagerVictoryOnDrag',
      'onTapDown': 'GestureTapDragDownCallback? get onTapDown',
      'onTapUp': 'GestureTapDragUpCallback? get onTapUp',
      'onDragStart': 'GestureTapDragStartCallback? get onDragStart',
      'onDragUpdate': 'GestureTapDragUpdateCallback? get onDragUpdate',
      'onDragEnd': 'GestureTapDragEndCallback? get onDragEnd',
      'onCancel': 'GestureCancelCallback? get onCancel',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'currentDown': 'PointerDownEvent? get currentDown',
      'currentUp': 'PointerUpEvent? get currentUp',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'dragUpdateThrottleFrequency': 'set dragUpdateThrottleFrequency(dynamic value)',
      'maxConsecutiveTap': 'set maxConsecutiveTap(dynamic value)',
      'eagerVictoryOnDrag': 'set eagerVictoryOnDrag(dynamic value)',
      'onTapDown': 'set onTapDown(dynamic value)',
      'onTapUp': 'set onTapUp(dynamic value)',
      'onDragStart': 'set onDragStart(dynamic value)',
      'onDragUpdate': 'set onDragUpdate(dynamic value)',
      'onDragEnd': 'set onDragEnd(dynamic value)',
      'onCancel': 'set onCancel(dynamic value)',
      'onTapTrackStart': 'set onTapTrackStart(void Function()? value)',
      'onTapTrackReset': 'set onTapTrackReset(void Function()? value)',
    },
  );
}

// =============================================================================
// TapAndHorizontalDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createTapAndHorizontalDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapAndHorizontalDragGestureRecognizer,
    name: 'TapAndHorizontalDragGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        return $flutter_28.TapAndHorizontalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
      },
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragUpdateThrottleFrequency,
      'maxConsecutiveTap': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').maxConsecutiveTap,
      'eagerVictoryOnDrag': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').eagerVictoryOnDrag,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapUp,
      'onDragStart': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragStart,
      'onDragUpdate': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragUpdate,
      'onDragEnd': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onCancel,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').allowedButtonsFilter,
      'currentDown': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').currentDown,
      'currentUp': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').currentUp,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').consecutiveTapCount,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragUpdateThrottleFrequency = value as Duration?,
      'maxConsecutiveTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').maxConsecutiveTap = value as int?,
      'eagerVictoryOnDrag': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').eagerVictoryOnDrag = value as bool,
      'onTapDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapDown = value as $flutter_28.GestureTapDragDownCallback?,
      'onTapUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapUp = value as $flutter_28.GestureTapDragUpCallback?,
      'onDragStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragStart = value as $flutter_28.GestureTapDragStartCallback?,
      'onDragUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragUpdate = value as $flutter_28.GestureTapDragUpdateCallback?,
      'onDragEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragEnd = value as $flutter_28.GestureTapDragEndCallback?,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onCancel = value as $flutter_28.GestureCancelCallback?,
      'onTapTrackStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapTrackStart = value as void Function()?,
      'onTapTrackReset': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapTrackReset = value as void Function()?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TapAndHorizontalDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'dragUpdateThrottleFrequency': 'Duration? get dragUpdateThrottleFrequency',
      'maxConsecutiveTap': 'int? get maxConsecutiveTap',
      'eagerVictoryOnDrag': 'bool get eagerVictoryOnDrag',
      'onTapDown': 'void Function(TapDragDownDetails)? get onTapDown',
      'onTapUp': 'void Function(TapDragUpDetails)? get onTapUp',
      'onDragStart': 'void Function(TapDragStartDetails)? get onDragStart',
      'onDragUpdate': 'void Function(TapDragUpdateDetails)? get onDragUpdate',
      'onDragEnd': 'void Function(TapDragEndDetails)? get onDragEnd',
      'onCancel': 'void Function()? get onCancel',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'currentDown': 'PointerDownEvent? get currentDown',
      'currentUp': 'PointerUpEvent? get currentUp',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'dragUpdateThrottleFrequency': 'set dragUpdateThrottleFrequency(dynamic value)',
      'maxConsecutiveTap': 'set maxConsecutiveTap(dynamic value)',
      'eagerVictoryOnDrag': 'set eagerVictoryOnDrag(dynamic value)',
      'onTapDown': 'set onTapDown(dynamic value)',
      'onTapUp': 'set onTapUp(dynamic value)',
      'onDragStart': 'set onDragStart(dynamic value)',
      'onDragUpdate': 'set onDragUpdate(dynamic value)',
      'onDragEnd': 'set onDragEnd(dynamic value)',
      'onCancel': 'set onCancel(dynamic value)',
      'onTapTrackStart': 'set onTapTrackStart(void Function()? value)',
      'onTapTrackReset': 'set onTapTrackReset(void Function()? value)',
    },
  );
}

// =============================================================================
// TapAndPanGestureRecognizer Bridge
// =============================================================================

BridgedClass _createTapAndPanGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapAndPanGestureRecognizer,
    name: 'TapAndPanGestureRecognizer',
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.getOptionalNamedArg<Set<PointerDeviceKind>?>(named, 'supportedDevices');
        return $flutter_28.TapAndPanGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
      },
    },
    getters: {
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragUpdateThrottleFrequency,
      'maxConsecutiveTap': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').maxConsecutiveTap,
      'eagerVictoryOnDrag': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').eagerVictoryOnDrag,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapUp,
      'onDragStart': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragStart,
      'onDragUpdate': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragUpdate,
      'onDragEnd': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onCancel,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').team,
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').allowedButtonsFilter,
      'currentDown': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').currentDown,
      'currentUp': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').currentUp,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').consecutiveTapCount,
    },
    setters: {
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragStartBehavior = value as $flutter_24.DragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragUpdateThrottleFrequency = value as Duration?,
      'maxConsecutiveTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').maxConsecutiveTap = value as int?,
      'eagerVictoryOnDrag': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').eagerVictoryOnDrag = value as bool,
      'onTapDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapDown = value as $flutter_28.GestureTapDragDownCallback?,
      'onTapUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapUp = value as $flutter_28.GestureTapDragUpCallback?,
      'onDragStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragStart = value as $flutter_28.GestureTapDragStartCallback?,
      'onDragUpdate': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragUpdate = value as $flutter_28.GestureTapDragUpdateCallback?,
      'onDragEnd': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragEnd = value as $flutter_28.GestureTapDragEndCallback?,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onCancel = value as $flutter_28.GestureCancelCallback?,
      'onTapTrackStart': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapTrackStart = value as void Function()?,
      'onTapTrackReset': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapTrackReset = value as void Function()?,
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_12.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_12.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_12.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TapAndPanGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'dispose': 'void dispose()',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
    },
    getterSignatures: {
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'dragUpdateThrottleFrequency': 'Duration? get dragUpdateThrottleFrequency',
      'maxConsecutiveTap': 'int? get maxConsecutiveTap',
      'eagerVictoryOnDrag': 'bool get eagerVictoryOnDrag',
      'onTapDown': 'void Function(TapDragDownDetails)? get onTapDown',
      'onTapUp': 'void Function(TapDragUpDetails)? get onTapUp',
      'onDragStart': 'void Function(TapDragStartDetails)? get onDragStart',
      'onDragUpdate': 'void Function(TapDragUpdateDetails)? get onDragUpdate',
      'onDragEnd': 'void Function(TapDragEndDetails)? get onDragEnd',
      'onCancel': 'void Function()? get onCancel',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'bool Function(int) get allowedButtonsFilter',
      'currentDown': 'PointerDownEvent? get currentDown',
      'currentUp': 'PointerUpEvent? get currentUp',
      'consecutiveTapCount': 'int get consecutiveTapCount',
    },
    setterSignatures: {
      'dragStartBehavior': 'set dragStartBehavior(dynamic value)',
      'dragUpdateThrottleFrequency': 'set dragUpdateThrottleFrequency(dynamic value)',
      'maxConsecutiveTap': 'set maxConsecutiveTap(dynamic value)',
      'eagerVictoryOnDrag': 'set eagerVictoryOnDrag(dynamic value)',
      'onTapDown': 'set onTapDown(dynamic value)',
      'onTapUp': 'set onTapUp(dynamic value)',
      'onDragStart': 'set onDragStart(dynamic value)',
      'onDragUpdate': 'set onDragUpdate(dynamic value)',
      'onDragEnd': 'set onDragEnd(dynamic value)',
      'onCancel': 'set onCancel(dynamic value)',
      'onTapTrackStart': 'set onTapTrackStart(void Function()? value)',
      'onTapTrackReset': 'set onTapTrackReset(void Function()? value)',
    },
  );
}

// =============================================================================
// Vector3 Bridge
// =============================================================================

BridgedClass _createVector3Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Vector3,
    name: 'Vector3',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Vector3');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector3');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector3');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'Vector3');
        return $vector_math_1.Vector3(x, y, z);
      },
      'array': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector3');
        if (positional.isEmpty) {
          throw ArgumentError('Vector3: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        return $vector_math_1.Vector3.array(array, offset);
      },
      'zero': (visitor, positional, named) {
        return $vector_math_1.Vector3.zero();
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector3');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'Vector3');
        return $vector_math_1.Vector3.all(value);
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector3');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'Vector3');
        return $vector_math_1.Vector3.copy(other);
      },
      'fromFloat64List': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector3');
        final v3storage = D4.getRequiredArg<Float64List>(positional, 0, '_v3storage', 'Vector3');
        return $vector_math_1.Vector3.fromFloat64List(v3storage);
      },
      'fromBuffer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector3');
        final buffer = D4.getRequiredArg<ByteBuffer>(positional, 0, 'buffer', 'Vector3');
        final offset = D4.getRequiredArg<int>(positional, 1, 'offset', 'Vector3');
        return $vector_math_1.Vector3.fromBuffer(buffer, offset);
      },
      'random': (visitor, positional, named) {
        final rng = D4.getOptionalArg<$dart_math.Random?>(positional, 0, 'rng');
        return $vector_math_1.Vector3.random(rng);
      },
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').storage,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').hashCode,
      'length': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').length,
      'length2': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').length2,
      'isInfinite': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').isInfinite,
      'isNaN': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').isNaN,
      'xx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xx,
      'xy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xy,
      'xz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xz,
      'yx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yx,
      'yy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yy,
      'yz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yz,
      'zx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zx,
      'zy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zy,
      'zz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zz,
      'xxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxx,
      'xxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxy,
      'xxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxz,
      'xyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyx,
      'xyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyy,
      'xyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyz,
      'xzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzx,
      'xzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzy,
      'xzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzz,
      'yxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxx,
      'yxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxy,
      'yxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxz,
      'yyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyx,
      'yyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyy,
      'yyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyz,
      'yzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzx,
      'yzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzy,
      'yzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzz,
      'zxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxx,
      'zxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxy,
      'zxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxz,
      'zyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyx,
      'zyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyy,
      'zyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyz,
      'zzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzx,
      'zzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzy,
      'zzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzz,
      'xxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxxx,
      'xxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxxy,
      'xxxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxxz,
      'xxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxyx,
      'xxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxyy,
      'xxyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxyz,
      'xxzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxzx,
      'xxzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxzy,
      'xxzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xxzz,
      'xyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyxx,
      'xyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyxy,
      'xyxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyxz,
      'xyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyyx,
      'xyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyyy,
      'xyyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyyz,
      'xyzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyzx,
      'xyzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyzy,
      'xyzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyzz,
      'xzxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzxx,
      'xzxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzxy,
      'xzxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzxz,
      'xzyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzyx,
      'xzyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzyy,
      'xzyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzyz,
      'xzzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzzx,
      'xzzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzzy,
      'xzzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzzz,
      'yxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxxx,
      'yxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxxy,
      'yxxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxxz,
      'yxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxyx,
      'yxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxyy,
      'yxyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxyz,
      'yxzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxzx,
      'yxzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxzy,
      'yxzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxzz,
      'yyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyxx,
      'yyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyxy,
      'yyxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyxz,
      'yyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyyx,
      'yyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyyy,
      'yyyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyyz,
      'yyzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyzx,
      'yyzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyzy,
      'yyzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yyzz,
      'yzxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzxx,
      'yzxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzxy,
      'yzxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzxz,
      'yzyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzyx,
      'yzyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzyy,
      'yzyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzyz,
      'yzzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzzx,
      'yzzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzzy,
      'yzzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzzz,
      'zxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxxx,
      'zxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxxy,
      'zxxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxxz,
      'zxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxyx,
      'zxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxyy,
      'zxyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxyz,
      'zxzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxzx,
      'zxzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxzy,
      'zxzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxzz,
      'zyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyxx,
      'zyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyxy,
      'zyxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyxz,
      'zyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyyx,
      'zyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyyy,
      'zyyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyyz,
      'zyzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyzx,
      'zyzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyzy,
      'zyzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyzz,
      'zzxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzxx,
      'zzxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzxy,
      'zzxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzxz,
      'zzyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzyx,
      'zzyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzyy,
      'zzyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzyz,
      'zzzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzzx,
      'zzzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzzy,
      'zzzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zzzz,
      'r': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').r,
      'g': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').g,
      'b': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').b,
      's': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').s,
      't': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').t,
      'p': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').p,
      'x': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').x,
      'y': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').y,
      'z': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').z,
      'rr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rr,
      'rg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rg,
      'rb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rb,
      'gr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gr,
      'gg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gg,
      'gb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gb,
      'br': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').br,
      'bg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bg,
      'bb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bb,
      'rrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrr,
      'rrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrg,
      'rrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrb,
      'rgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgr,
      'rgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgg,
      'rgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgb,
      'rbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbr,
      'rbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbg,
      'rbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbb,
      'grr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grr,
      'grg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grg,
      'grb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grb,
      'ggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggr,
      'ggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggg,
      'ggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggb,
      'gbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbr,
      'gbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbg,
      'gbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbb,
      'brr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brr,
      'brg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brg,
      'brb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brb,
      'bgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgr,
      'bgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgg,
      'bgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgb,
      'bbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbr,
      'bbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbg,
      'bbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbb,
      'rrrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrrr,
      'rrrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrrg,
      'rrrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrrb,
      'rrgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrgr,
      'rrgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrgg,
      'rrgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrgb,
      'rrbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrbr,
      'rrbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrbg,
      'rrbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rrbb,
      'rgrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgrr,
      'rgrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgrg,
      'rgrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgrb,
      'rggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rggr,
      'rggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rggg,
      'rggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rggb,
      'rgbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgbr,
      'rgbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgbg,
      'rgbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgbb,
      'rbrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbrr,
      'rbrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbrg,
      'rbrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbrb,
      'rbgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbgr,
      'rbgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbgg,
      'rbgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbgb,
      'rbbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbbr,
      'rbbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbbg,
      'rbbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbbb,
      'grrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grrr,
      'grrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grrg,
      'grrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grrb,
      'grgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grgr,
      'grgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grgg,
      'grgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grgb,
      'grbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grbr,
      'grbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grbg,
      'grbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grbb,
      'ggrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggrr,
      'ggrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggrg,
      'ggrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggrb,
      'gggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gggr,
      'gggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gggg,
      'gggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gggb,
      'ggbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggbr,
      'ggbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggbg,
      'ggbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ggbb,
      'gbrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbrr,
      'gbrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbrg,
      'gbrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbrb,
      'gbgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbgr,
      'gbgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbgg,
      'gbgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbgb,
      'gbbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbbr,
      'gbbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbbg,
      'gbbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbbb,
      'brrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brrr,
      'brrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brrg,
      'brrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brrb,
      'brgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brgr,
      'brgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brgg,
      'brgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brgb,
      'brbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brbr,
      'brbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brbg,
      'brbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brbb,
      'bgrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgrr,
      'bgrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgrg,
      'bgrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgrb,
      'bggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bggr,
      'bggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bggg,
      'bggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bggb,
      'bgbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgbr,
      'bgbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgbg,
      'bgbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgbb,
      'bbrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbrr,
      'bbrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbrg,
      'bbrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbrb,
      'bbgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbgr,
      'bbgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbgg,
      'bbgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbgb,
      'bbbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbbr,
      'bbbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbbg,
      'bbbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bbbb,
      'ss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ss,
      'st': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').st,
      'sp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sp,
      'ts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ts,
      'tt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tt,
      'tp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tp,
      'ps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ps,
      'pt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pt,
      'pp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pp,
      'sss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sss,
      'sst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sst,
      'ssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ssp,
      'sts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sts,
      'stt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stt,
      'stp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stp,
      'sps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sps,
      'spt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spt,
      'spp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spp,
      'tss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tss,
      'tst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tst,
      'tsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tsp,
      'tts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tts,
      'ttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttt,
      'ttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttp,
      'tps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tps,
      'tpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tpt,
      'tpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tpp,
      'pss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pss,
      'pst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pst,
      'psp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').psp,
      'pts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pts,
      'ptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptt,
      'ptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptp,
      'pps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pps,
      'ppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ppt,
      'ppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ppp,
      'ssss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ssss,
      'ssst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ssst,
      'sssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sssp,
      'ssts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ssts,
      'sstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sstt,
      'sstp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sstp,
      'ssps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ssps,
      'sspt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sspt,
      'sspp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sspp,
      'stss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stss,
      'stst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stst,
      'stsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stsp,
      'stts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stts,
      'sttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sttt,
      'sttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sttp,
      'stps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stps,
      'stpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stpt,
      'stpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stpp,
      'spss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spss,
      'spst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spst,
      'spsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spsp,
      'spts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spts,
      'sptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sptt,
      'sptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sptp,
      'spps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spps,
      'sppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sppt,
      'sppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sppp,
      'tsss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tsss,
      'tsst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tsst,
      'tssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tssp,
      'tsts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tsts,
      'tstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tstt,
      'tstp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tstp,
      'tsps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tsps,
      'tspt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tspt,
      'tspp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tspp,
      'ttss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttss,
      'ttst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttst,
      'ttsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttsp,
      'ttts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttts,
      'tttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tttt,
      'tttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tttp,
      'ttps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttps,
      'ttpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttpt,
      'ttpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ttpp,
      'tpss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tpss,
      'tpst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tpst,
      'tpsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tpsp,
      'tpts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tpts,
      'tptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tptt,
      'tptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tptp,
      'tpps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tpps,
      'tppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tppt,
      'tppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tppp,
      'psss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').psss,
      'psst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').psst,
      'pssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pssp,
      'psts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').psts,
      'pstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pstt,
      'pstp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pstp,
      'psps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').psps,
      'pspt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pspt,
      'pspp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pspp,
      'ptss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptss,
      'ptst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptst,
      'ptsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptsp,
      'ptts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptts,
      'pttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pttt,
      'pttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pttp,
      'ptps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptps,
      'ptpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptpt,
      'ptpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ptpp,
      'ppss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ppss,
      'ppst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ppst,
      'ppsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ppsp,
      'ppts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ppts,
      'pptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pptt,
      'pptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pptp,
      'ppps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ppps,
      'pppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pppt,
      'pppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pppp,
    },
    setters: {
      'length': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').length = value as dynamic,
      'xy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xy = value as dynamic,
      'xz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xz = value as dynamic,
      'yx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yx = value as dynamic,
      'yz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yz = value as dynamic,
      'zx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zx = value as dynamic,
      'zy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zy = value as dynamic,
      'xyz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyz = value as dynamic,
      'xzy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzy = value as dynamic,
      'yxz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxz = value as dynamic,
      'yzx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzx = value as dynamic,
      'zxy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxy = value as dynamic,
      'zyx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyx = value as dynamic,
      'r': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').r = value as dynamic,
      'g': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').g = value as dynamic,
      'b': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').b = value as dynamic,
      's': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').s = value as dynamic,
      't': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').t = value as dynamic,
      'p': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').p = value as dynamic,
      'x': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').x = value as dynamic,
      'y': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').y = value as dynamic,
      'z': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').z = value as dynamic,
      'rg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rg = value as dynamic,
      'rb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rb = value as dynamic,
      'gr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gr = value as dynamic,
      'gb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gb = value as dynamic,
      'br': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').br = value as dynamic,
      'bg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bg = value as dynamic,
      'rgb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgb = value as dynamic,
      'rbg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbg = value as dynamic,
      'grb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grb = value as dynamic,
      'gbr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbr = value as dynamic,
      'brg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brg = value as dynamic,
      'bgr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgr = value as dynamic,
      'st': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').st = value as dynamic,
      'sp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sp = value as dynamic,
      'ts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ts = value as dynamic,
      'tp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tp = value as dynamic,
      'ps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ps = value as dynamic,
      'pt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pt = value as dynamic,
      'stp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stp = value as dynamic,
      'spt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spt = value as dynamic,
      'tsp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tsp = value as dynamic,
      'tps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tps = value as dynamic,
      'pst': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pst = value as dynamic,
      'pts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pts = value as dynamic,
    },
    methods: {
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 3, 'setValues');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'setValues');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'setValues');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'setValues');
        t.setValues(x, y, z);
        return null;
      },
      'setZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        t.setZero();
        return null;
      },
      'setFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'setFrom');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'setFrom');
        t.setFrom(other);
        return null;
      },
      'splat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'splat');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'splat');
        t.splat(arg);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        return t.toString();
      },
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        return t.normalize();
      },
      'normalizeLength': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        return t.normalizeLength();
      },
      'normalized': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        return t.normalized();
      },
      'normalizeInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'normalizeInto');
        final out = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'out', 'normalizeInto');
        return t.normalizeInto(out);
      },
      'distanceTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'distanceTo');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'distanceTo');
        return t.distanceTo(arg);
      },
      'distanceToSquared': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'distanceToSquared');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'distanceToSquared');
        return t.distanceToSquared(arg);
      },
      'angleTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'angleTo');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'angleTo');
        return t.angleTo(other);
      },
      'angleToSigned': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 2, 'angleToSigned');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'angleToSigned');
        final normal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'normal', 'angleToSigned');
        return t.angleToSigned(other, normal);
      },
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'postmultiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'postmultiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'postmultiply');
        t.postmultiply(arg);
        return null;
      },
      'cross': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'cross');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'cross');
        return t.cross(other);
      },
      'crossInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 2, 'crossInto');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'crossInto');
        final out = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'out', 'crossInto');
        return t.crossInto(other, out);
      },
      'reflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'reflect');
        final normal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'normal', 'reflect');
        t.reflect(normal);
        return null;
      },
      'reflected': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'reflected');
        final normal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'normal', 'reflected');
        return t.reflected(normal);
      },
      'applyProjection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'applyProjection');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'applyProjection');
        t.applyProjection(arg);
        return null;
      },
      'applyAxisAngle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 2, 'applyAxisAngle');
        final axis = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'axis', 'applyAxisAngle');
        final angle = D4.getRequiredArg<double>(positional, 1, 'angle', 'applyAxisAngle');
        t.applyAxisAngle(axis, angle);
        return null;
      },
      'applyQuaternion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'applyQuaternion');
        final arg = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'arg', 'applyQuaternion');
        t.applyQuaternion(arg);
        return null;
      },
      'applyMatrix3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'applyMatrix3');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'applyMatrix3');
        t.applyMatrix3(arg);
        return null;
      },
      'applyMatrix4': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'applyMatrix4');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'applyMatrix4');
        t.applyMatrix4(arg);
        return null;
      },
      'relativeError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'relativeError');
        final correct = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'correct', 'relativeError');
        return t.relativeError(correct);
      },
      'absoluteError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'absoluteError');
        final correct = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'correct', 'absoluteError');
        return t.absoluteError(correct);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'add');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'add');
        t.add(arg);
        return null;
      },
      'addScaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 2, 'addScaled');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'addScaled');
        final factor = D4.getRequiredArg<double>(positional, 1, 'factor', 'addScaled');
        t.addScaled(arg, factor);
        return null;
      },
      'sub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'sub');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'sub');
        t.sub(arg);
        return null;
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'multiply');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'multiply');
        t.multiply(arg);
        return null;
      },
      'divide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'divide');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'divide');
        t.divide(arg);
        return null;
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'scale');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'scale');
        t.scale(arg);
        return null;
      },
      'scaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'scaled');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'scaled');
        return t.scaled(arg);
      },
      'negate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        t.negate();
        return null;
      },
      'absolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        t.absolute();
        return null;
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'max', 'clamp');
        t.clamp(min, max);
        return null;
      },
      'clampScalar': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 2, 'clampScalar');
        final min = D4.getRequiredArg<double>(positional, 0, 'min', 'clampScalar');
        final max = D4.getRequiredArg<double>(positional, 1, 'max', 'clampScalar');
        t.clampScalar(min, max);
        return null;
      },
      'floor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        t.floor();
        return null;
      },
      'ceil': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        t.ceil();
        return null;
      },
      'round': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        t.round();
        return null;
      },
      'roundToZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        t.roundToZero();
        return null;
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        return t.clone();
      },
      'copyInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'copyInto');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'copyInto');
        return t.copyInto(arg);
      },
      'copyIntoArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'copyIntoArray');
        if (positional.isEmpty) {
          throw ArgumentError('copyIntoArray: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        t.copyIntoArray(array, offset);
        return null;
      },
      'copyFromArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        D4.requireMinArgs(positional, 1, 'copyFromArray');
        if (positional.isEmpty) {
          throw ArgumentError('copyFromArray: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        t.copyFromArray(array, offset);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticMethods: {
      'min': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'min');
        final a = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'a', 'min');
        final b = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'b', 'min');
        final result = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'result', 'min');
        return $vector_math_1.Vector3.min(a, b, result);
      },
      'max': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'max');
        final a = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'a', 'max');
        final b = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'b', 'max');
        final result = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'result', 'max');
        return $vector_math_1.Vector3.max(a, b, result);
      },
      'mix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'mix');
        final min = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'min', 'mix');
        final max = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'max', 'mix');
        final a = D4.getRequiredArg<double>(positional, 2, 'a', 'mix');
        final result = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 3, 'result', 'mix');
        return $vector_math_1.Vector3.mix(min, max, a, result);
      },
    },
    constructorSignatures: {
      '': 'factory Vector3(double x, double y, double z)',
      'array': 'factory Vector3.array(List<double> array, [int offset = 0])',
      'zero': 'Vector3.zero()',
      'all': 'factory Vector3.all(double value)',
      'copy': 'factory Vector3.copy(Vector3 other)',
      'fromFloat64List': 'Vector3.fromFloat64List(Float64List _v3storage)',
      'fromBuffer': 'Vector3.fromBuffer(ByteBuffer buffer, int offset)',
      'random': 'factory Vector3.random([math.Random? rng])',
    },
    methodSignatures: {
      'setValues': 'void setValues(double x, double y, double z)',
      'setZero': 'void setZero()',
      'setFrom': 'void setFrom(Vector3 other)',
      'splat': 'void splat(double arg)',
      'toString': 'String toString()',
      'normalize': 'double normalize()',
      'normalizeLength': 'double normalizeLength()',
      'normalized': 'Vector3 normalized()',
      'normalizeInto': 'Vector3 normalizeInto(Vector3 out)',
      'distanceTo': 'double distanceTo(Vector3 arg)',
      'distanceToSquared': 'double distanceToSquared(Vector3 arg)',
      'angleTo': 'double angleTo(Vector3 other)',
      'angleToSigned': 'double angleToSigned(Vector3 other, Vector3 normal)',
      'dot': 'double dot(Vector3 other)',
      'postmultiply': 'void postmultiply(Matrix3 arg)',
      'cross': 'Vector3 cross(Vector3 other)',
      'crossInto': 'Vector3 crossInto(Vector3 other, Vector3 out)',
      'reflect': 'void reflect(Vector3 normal)',
      'reflected': 'Vector3 reflected(Vector3 normal)',
      'applyProjection': 'void applyProjection(Matrix4 arg)',
      'applyAxisAngle': 'void applyAxisAngle(Vector3 axis, double angle)',
      'applyQuaternion': 'void applyQuaternion(Quaternion arg)',
      'applyMatrix3': 'void applyMatrix3(Matrix3 arg)',
      'applyMatrix4': 'void applyMatrix4(Matrix4 arg)',
      'relativeError': 'double relativeError(Vector3 correct)',
      'absoluteError': 'double absoluteError(Vector3 correct)',
      'add': 'void add(Vector3 arg)',
      'addScaled': 'void addScaled(Vector3 arg, double factor)',
      'sub': 'void sub(Vector3 arg)',
      'multiply': 'void multiply(Vector3 arg)',
      'divide': 'void divide(Vector3 arg)',
      'scale': 'void scale(double arg)',
      'scaled': 'Vector3 scaled(double arg)',
      'negate': 'void negate()',
      'absolute': 'void absolute()',
      'clamp': 'void clamp(Vector3 min, Vector3 max)',
      'clampScalar': 'void clampScalar(double min, double max)',
      'floor': 'void floor()',
      'ceil': 'void ceil()',
      'round': 'void round()',
      'roundToZero': 'void roundToZero()',
      'clone': 'Vector3 clone()',
      'copyInto': 'Vector3 copyInto(Vector3 arg)',
      'copyIntoArray': 'void copyIntoArray(List<double> array, [int offset = 0])',
      'copyFromArray': 'void copyFromArray(List<double> array, [int offset = 0])',
    },
    getterSignatures: {
      'storage': 'Float64List get storage',
      'hashCode': 'int get hashCode',
      'length': 'double get length',
      'length2': 'double get length2',
      'isInfinite': 'bool get isInfinite',
      'isNaN': 'bool get isNaN',
      'xx': 'Vector2 get xx',
      'xy': 'Vector2 get xy',
      'xz': 'Vector2 get xz',
      'yx': 'Vector2 get yx',
      'yy': 'Vector2 get yy',
      'yz': 'Vector2 get yz',
      'zx': 'Vector2 get zx',
      'zy': 'Vector2 get zy',
      'zz': 'Vector2 get zz',
      'xxx': 'Vector3 get xxx',
      'xxy': 'Vector3 get xxy',
      'xxz': 'Vector3 get xxz',
      'xyx': 'Vector3 get xyx',
      'xyy': 'Vector3 get xyy',
      'xyz': 'Vector3 get xyz',
      'xzx': 'Vector3 get xzx',
      'xzy': 'Vector3 get xzy',
      'xzz': 'Vector3 get xzz',
      'yxx': 'Vector3 get yxx',
      'yxy': 'Vector3 get yxy',
      'yxz': 'Vector3 get yxz',
      'yyx': 'Vector3 get yyx',
      'yyy': 'Vector3 get yyy',
      'yyz': 'Vector3 get yyz',
      'yzx': 'Vector3 get yzx',
      'yzy': 'Vector3 get yzy',
      'yzz': 'Vector3 get yzz',
      'zxx': 'Vector3 get zxx',
      'zxy': 'Vector3 get zxy',
      'zxz': 'Vector3 get zxz',
      'zyx': 'Vector3 get zyx',
      'zyy': 'Vector3 get zyy',
      'zyz': 'Vector3 get zyz',
      'zzx': 'Vector3 get zzx',
      'zzy': 'Vector3 get zzy',
      'zzz': 'Vector3 get zzz',
      'xxxx': 'Vector4 get xxxx',
      'xxxy': 'Vector4 get xxxy',
      'xxxz': 'Vector4 get xxxz',
      'xxyx': 'Vector4 get xxyx',
      'xxyy': 'Vector4 get xxyy',
      'xxyz': 'Vector4 get xxyz',
      'xxzx': 'Vector4 get xxzx',
      'xxzy': 'Vector4 get xxzy',
      'xxzz': 'Vector4 get xxzz',
      'xyxx': 'Vector4 get xyxx',
      'xyxy': 'Vector4 get xyxy',
      'xyxz': 'Vector4 get xyxz',
      'xyyx': 'Vector4 get xyyx',
      'xyyy': 'Vector4 get xyyy',
      'xyyz': 'Vector4 get xyyz',
      'xyzx': 'Vector4 get xyzx',
      'xyzy': 'Vector4 get xyzy',
      'xyzz': 'Vector4 get xyzz',
      'xzxx': 'Vector4 get xzxx',
      'xzxy': 'Vector4 get xzxy',
      'xzxz': 'Vector4 get xzxz',
      'xzyx': 'Vector4 get xzyx',
      'xzyy': 'Vector4 get xzyy',
      'xzyz': 'Vector4 get xzyz',
      'xzzx': 'Vector4 get xzzx',
      'xzzy': 'Vector4 get xzzy',
      'xzzz': 'Vector4 get xzzz',
      'yxxx': 'Vector4 get yxxx',
      'yxxy': 'Vector4 get yxxy',
      'yxxz': 'Vector4 get yxxz',
      'yxyx': 'Vector4 get yxyx',
      'yxyy': 'Vector4 get yxyy',
      'yxyz': 'Vector4 get yxyz',
      'yxzx': 'Vector4 get yxzx',
      'yxzy': 'Vector4 get yxzy',
      'yxzz': 'Vector4 get yxzz',
      'yyxx': 'Vector4 get yyxx',
      'yyxy': 'Vector4 get yyxy',
      'yyxz': 'Vector4 get yyxz',
      'yyyx': 'Vector4 get yyyx',
      'yyyy': 'Vector4 get yyyy',
      'yyyz': 'Vector4 get yyyz',
      'yyzx': 'Vector4 get yyzx',
      'yyzy': 'Vector4 get yyzy',
      'yyzz': 'Vector4 get yyzz',
      'yzxx': 'Vector4 get yzxx',
      'yzxy': 'Vector4 get yzxy',
      'yzxz': 'Vector4 get yzxz',
      'yzyx': 'Vector4 get yzyx',
      'yzyy': 'Vector4 get yzyy',
      'yzyz': 'Vector4 get yzyz',
      'yzzx': 'Vector4 get yzzx',
      'yzzy': 'Vector4 get yzzy',
      'yzzz': 'Vector4 get yzzz',
      'zxxx': 'Vector4 get zxxx',
      'zxxy': 'Vector4 get zxxy',
      'zxxz': 'Vector4 get zxxz',
      'zxyx': 'Vector4 get zxyx',
      'zxyy': 'Vector4 get zxyy',
      'zxyz': 'Vector4 get zxyz',
      'zxzx': 'Vector4 get zxzx',
      'zxzy': 'Vector4 get zxzy',
      'zxzz': 'Vector4 get zxzz',
      'zyxx': 'Vector4 get zyxx',
      'zyxy': 'Vector4 get zyxy',
      'zyxz': 'Vector4 get zyxz',
      'zyyx': 'Vector4 get zyyx',
      'zyyy': 'Vector4 get zyyy',
      'zyyz': 'Vector4 get zyyz',
      'zyzx': 'Vector4 get zyzx',
      'zyzy': 'Vector4 get zyzy',
      'zyzz': 'Vector4 get zyzz',
      'zzxx': 'Vector4 get zzxx',
      'zzxy': 'Vector4 get zzxy',
      'zzxz': 'Vector4 get zzxz',
      'zzyx': 'Vector4 get zzyx',
      'zzyy': 'Vector4 get zzyy',
      'zzyz': 'Vector4 get zzyz',
      'zzzx': 'Vector4 get zzzx',
      'zzzy': 'Vector4 get zzzy',
      'zzzz': 'Vector4 get zzzz',
      'r': 'double get r',
      'g': 'double get g',
      'b': 'double get b',
      's': 'double get s',
      't': 'double get t',
      'p': 'double get p',
      'x': 'double get x',
      'y': 'double get y',
      'z': 'double get z',
      'rr': 'Vector2 get rr',
      'rg': 'Vector2 get rg',
      'rb': 'Vector2 get rb',
      'gr': 'Vector2 get gr',
      'gg': 'Vector2 get gg',
      'gb': 'Vector2 get gb',
      'br': 'Vector2 get br',
      'bg': 'Vector2 get bg',
      'bb': 'Vector2 get bb',
      'rrr': 'Vector3 get rrr',
      'rrg': 'Vector3 get rrg',
      'rrb': 'Vector3 get rrb',
      'rgr': 'Vector3 get rgr',
      'rgg': 'Vector3 get rgg',
      'rgb': 'Vector3 get rgb',
      'rbr': 'Vector3 get rbr',
      'rbg': 'Vector3 get rbg',
      'rbb': 'Vector3 get rbb',
      'grr': 'Vector3 get grr',
      'grg': 'Vector3 get grg',
      'grb': 'Vector3 get grb',
      'ggr': 'Vector3 get ggr',
      'ggg': 'Vector3 get ggg',
      'ggb': 'Vector3 get ggb',
      'gbr': 'Vector3 get gbr',
      'gbg': 'Vector3 get gbg',
      'gbb': 'Vector3 get gbb',
      'brr': 'Vector3 get brr',
      'brg': 'Vector3 get brg',
      'brb': 'Vector3 get brb',
      'bgr': 'Vector3 get bgr',
      'bgg': 'Vector3 get bgg',
      'bgb': 'Vector3 get bgb',
      'bbr': 'Vector3 get bbr',
      'bbg': 'Vector3 get bbg',
      'bbb': 'Vector3 get bbb',
      'rrrr': 'Vector4 get rrrr',
      'rrrg': 'Vector4 get rrrg',
      'rrrb': 'Vector4 get rrrb',
      'rrgr': 'Vector4 get rrgr',
      'rrgg': 'Vector4 get rrgg',
      'rrgb': 'Vector4 get rrgb',
      'rrbr': 'Vector4 get rrbr',
      'rrbg': 'Vector4 get rrbg',
      'rrbb': 'Vector4 get rrbb',
      'rgrr': 'Vector4 get rgrr',
      'rgrg': 'Vector4 get rgrg',
      'rgrb': 'Vector4 get rgrb',
      'rggr': 'Vector4 get rggr',
      'rggg': 'Vector4 get rggg',
      'rggb': 'Vector4 get rggb',
      'rgbr': 'Vector4 get rgbr',
      'rgbg': 'Vector4 get rgbg',
      'rgbb': 'Vector4 get rgbb',
      'rbrr': 'Vector4 get rbrr',
      'rbrg': 'Vector4 get rbrg',
      'rbrb': 'Vector4 get rbrb',
      'rbgr': 'Vector4 get rbgr',
      'rbgg': 'Vector4 get rbgg',
      'rbgb': 'Vector4 get rbgb',
      'rbbr': 'Vector4 get rbbr',
      'rbbg': 'Vector4 get rbbg',
      'rbbb': 'Vector4 get rbbb',
      'grrr': 'Vector4 get grrr',
      'grrg': 'Vector4 get grrg',
      'grrb': 'Vector4 get grrb',
      'grgr': 'Vector4 get grgr',
      'grgg': 'Vector4 get grgg',
      'grgb': 'Vector4 get grgb',
      'grbr': 'Vector4 get grbr',
      'grbg': 'Vector4 get grbg',
      'grbb': 'Vector4 get grbb',
      'ggrr': 'Vector4 get ggrr',
      'ggrg': 'Vector4 get ggrg',
      'ggrb': 'Vector4 get ggrb',
      'gggr': 'Vector4 get gggr',
      'gggg': 'Vector4 get gggg',
      'gggb': 'Vector4 get gggb',
      'ggbr': 'Vector4 get ggbr',
      'ggbg': 'Vector4 get ggbg',
      'ggbb': 'Vector4 get ggbb',
      'gbrr': 'Vector4 get gbrr',
      'gbrg': 'Vector4 get gbrg',
      'gbrb': 'Vector4 get gbrb',
      'gbgr': 'Vector4 get gbgr',
      'gbgg': 'Vector4 get gbgg',
      'gbgb': 'Vector4 get gbgb',
      'gbbr': 'Vector4 get gbbr',
      'gbbg': 'Vector4 get gbbg',
      'gbbb': 'Vector4 get gbbb',
      'brrr': 'Vector4 get brrr',
      'brrg': 'Vector4 get brrg',
      'brrb': 'Vector4 get brrb',
      'brgr': 'Vector4 get brgr',
      'brgg': 'Vector4 get brgg',
      'brgb': 'Vector4 get brgb',
      'brbr': 'Vector4 get brbr',
      'brbg': 'Vector4 get brbg',
      'brbb': 'Vector4 get brbb',
      'bgrr': 'Vector4 get bgrr',
      'bgrg': 'Vector4 get bgrg',
      'bgrb': 'Vector4 get bgrb',
      'bggr': 'Vector4 get bggr',
      'bggg': 'Vector4 get bggg',
      'bggb': 'Vector4 get bggb',
      'bgbr': 'Vector4 get bgbr',
      'bgbg': 'Vector4 get bgbg',
      'bgbb': 'Vector4 get bgbb',
      'bbrr': 'Vector4 get bbrr',
      'bbrg': 'Vector4 get bbrg',
      'bbrb': 'Vector4 get bbrb',
      'bbgr': 'Vector4 get bbgr',
      'bbgg': 'Vector4 get bbgg',
      'bbgb': 'Vector4 get bbgb',
      'bbbr': 'Vector4 get bbbr',
      'bbbg': 'Vector4 get bbbg',
      'bbbb': 'Vector4 get bbbb',
      'ss': 'Vector2 get ss',
      'st': 'Vector2 get st',
      'sp': 'Vector2 get sp',
      'ts': 'Vector2 get ts',
      'tt': 'Vector2 get tt',
      'tp': 'Vector2 get tp',
      'ps': 'Vector2 get ps',
      'pt': 'Vector2 get pt',
      'pp': 'Vector2 get pp',
      'sss': 'Vector3 get sss',
      'sst': 'Vector3 get sst',
      'ssp': 'Vector3 get ssp',
      'sts': 'Vector3 get sts',
      'stt': 'Vector3 get stt',
      'stp': 'Vector3 get stp',
      'sps': 'Vector3 get sps',
      'spt': 'Vector3 get spt',
      'spp': 'Vector3 get spp',
      'tss': 'Vector3 get tss',
      'tst': 'Vector3 get tst',
      'tsp': 'Vector3 get tsp',
      'tts': 'Vector3 get tts',
      'ttt': 'Vector3 get ttt',
      'ttp': 'Vector3 get ttp',
      'tps': 'Vector3 get tps',
      'tpt': 'Vector3 get tpt',
      'tpp': 'Vector3 get tpp',
      'pss': 'Vector3 get pss',
      'pst': 'Vector3 get pst',
      'psp': 'Vector3 get psp',
      'pts': 'Vector3 get pts',
      'ptt': 'Vector3 get ptt',
      'ptp': 'Vector3 get ptp',
      'pps': 'Vector3 get pps',
      'ppt': 'Vector3 get ppt',
      'ppp': 'Vector3 get ppp',
      'ssss': 'Vector4 get ssss',
      'ssst': 'Vector4 get ssst',
      'sssp': 'Vector4 get sssp',
      'ssts': 'Vector4 get ssts',
      'sstt': 'Vector4 get sstt',
      'sstp': 'Vector4 get sstp',
      'ssps': 'Vector4 get ssps',
      'sspt': 'Vector4 get sspt',
      'sspp': 'Vector4 get sspp',
      'stss': 'Vector4 get stss',
      'stst': 'Vector4 get stst',
      'stsp': 'Vector4 get stsp',
      'stts': 'Vector4 get stts',
      'sttt': 'Vector4 get sttt',
      'sttp': 'Vector4 get sttp',
      'stps': 'Vector4 get stps',
      'stpt': 'Vector4 get stpt',
      'stpp': 'Vector4 get stpp',
      'spss': 'Vector4 get spss',
      'spst': 'Vector4 get spst',
      'spsp': 'Vector4 get spsp',
      'spts': 'Vector4 get spts',
      'sptt': 'Vector4 get sptt',
      'sptp': 'Vector4 get sptp',
      'spps': 'Vector4 get spps',
      'sppt': 'Vector4 get sppt',
      'sppp': 'Vector4 get sppp',
      'tsss': 'Vector4 get tsss',
      'tsst': 'Vector4 get tsst',
      'tssp': 'Vector4 get tssp',
      'tsts': 'Vector4 get tsts',
      'tstt': 'Vector4 get tstt',
      'tstp': 'Vector4 get tstp',
      'tsps': 'Vector4 get tsps',
      'tspt': 'Vector4 get tspt',
      'tspp': 'Vector4 get tspp',
      'ttss': 'Vector4 get ttss',
      'ttst': 'Vector4 get ttst',
      'ttsp': 'Vector4 get ttsp',
      'ttts': 'Vector4 get ttts',
      'tttt': 'Vector4 get tttt',
      'tttp': 'Vector4 get tttp',
      'ttps': 'Vector4 get ttps',
      'ttpt': 'Vector4 get ttpt',
      'ttpp': 'Vector4 get ttpp',
      'tpss': 'Vector4 get tpss',
      'tpst': 'Vector4 get tpst',
      'tpsp': 'Vector4 get tpsp',
      'tpts': 'Vector4 get tpts',
      'tptt': 'Vector4 get tptt',
      'tptp': 'Vector4 get tptp',
      'tpps': 'Vector4 get tpps',
      'tppt': 'Vector4 get tppt',
      'tppp': 'Vector4 get tppp',
      'psss': 'Vector4 get psss',
      'psst': 'Vector4 get psst',
      'pssp': 'Vector4 get pssp',
      'psts': 'Vector4 get psts',
      'pstt': 'Vector4 get pstt',
      'pstp': 'Vector4 get pstp',
      'psps': 'Vector4 get psps',
      'pspt': 'Vector4 get pspt',
      'pspp': 'Vector4 get pspp',
      'ptss': 'Vector4 get ptss',
      'ptst': 'Vector4 get ptst',
      'ptsp': 'Vector4 get ptsp',
      'ptts': 'Vector4 get ptts',
      'pttt': 'Vector4 get pttt',
      'pttp': 'Vector4 get pttp',
      'ptps': 'Vector4 get ptps',
      'ptpt': 'Vector4 get ptpt',
      'ptpp': 'Vector4 get ptpp',
      'ppss': 'Vector4 get ppss',
      'ppst': 'Vector4 get ppst',
      'ppsp': 'Vector4 get ppsp',
      'ppts': 'Vector4 get ppts',
      'pptt': 'Vector4 get pptt',
      'pptp': 'Vector4 get pptp',
      'ppps': 'Vector4 get ppps',
      'pppt': 'Vector4 get pppt',
      'pppp': 'Vector4 get pppp',
    },
    setterSignatures: {
      'length': 'set length(double value)',
      'xy': 'set xy(Vector2 value)',
      'xz': 'set xz(Vector2 value)',
      'yx': 'set yx(Vector2 value)',
      'yz': 'set yz(Vector2 value)',
      'zx': 'set zx(Vector2 value)',
      'zy': 'set zy(Vector2 value)',
      'xyz': 'set xyz(Vector3 value)',
      'xzy': 'set xzy(Vector3 value)',
      'yxz': 'set yxz(Vector3 value)',
      'yzx': 'set yzx(Vector3 value)',
      'zxy': 'set zxy(Vector3 value)',
      'zyx': 'set zyx(Vector3 value)',
      'r': 'set r(double value)',
      'g': 'set g(double value)',
      'b': 'set b(double value)',
      's': 'set s(double value)',
      't': 'set t(double value)',
      'p': 'set p(double value)',
      'x': 'set x(double value)',
      'y': 'set y(double value)',
      'z': 'set z(double value)',
      'rg': 'set rg(Vector2 value)',
      'rb': 'set rb(Vector2 value)',
      'gr': 'set gr(Vector2 value)',
      'gb': 'set gb(Vector2 value)',
      'br': 'set br(Vector2 value)',
      'bg': 'set bg(Vector2 value)',
      'rgb': 'set rgb(Vector3 value)',
      'rbg': 'set rbg(Vector3 value)',
      'grb': 'set grb(Vector3 value)',
      'gbr': 'set gbr(Vector3 value)',
      'brg': 'set brg(Vector3 value)',
      'bgr': 'set bgr(Vector3 value)',
      'st': 'set st(Vector2 value)',
      'sp': 'set sp(Vector2 value)',
      'ts': 'set ts(Vector2 value)',
      'tp': 'set tp(Vector2 value)',
      'ps': 'set ps(Vector2 value)',
      'pt': 'set pt(Vector2 value)',
      'stp': 'set stp(Vector3 value)',
      'spt': 'set spt(Vector3 value)',
      'tsp': 'set tsp(Vector3 value)',
      'tps': 'set tps(Vector3 value)',
      'pst': 'set pst(Vector3 value)',
      'pts': 'set pts(Vector3 value)',
    },
    staticMethodSignatures: {
      'min': 'void min(Vector3 a, Vector3 b, Vector3 result)',
      'max': 'void max(Vector3 a, Vector3 b, Vector3 result)',
      'mix': 'void mix(Vector3 min, Vector3 max, double a, Vector3 result)',
    },
  );
}

// =============================================================================
// Vector2 Bridge
// =============================================================================

BridgedClass _createVector2Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Vector2,
    name: 'Vector2',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2');
        return $vector_math_1.Vector2(x, y);
      },
      'array': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector2');
        if (positional.isEmpty) {
          throw ArgumentError('Vector2: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        return $vector_math_1.Vector2.array(array, offset);
      },
      'zero': (visitor, positional, named) {
        return $vector_math_1.Vector2.zero();
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector2');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'Vector2');
        return $vector_math_1.Vector2.all(value);
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector2');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'Vector2');
        return $vector_math_1.Vector2.copy(other);
      },
      'fromFloat64List': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector2');
        final v2storage = D4.getRequiredArg<Float64List>(positional, 0, '_v2storage', 'Vector2');
        return $vector_math_1.Vector2.fromFloat64List(v2storage);
      },
      'fromBuffer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2');
        final buffer = D4.getRequiredArg<ByteBuffer>(positional, 0, 'buffer', 'Vector2');
        final offset = D4.getRequiredArg<int>(positional, 1, 'offset', 'Vector2');
        return $vector_math_1.Vector2.fromBuffer(buffer, offset);
      },
      'random': (visitor, positional, named) {
        final rng = D4.getOptionalArg<$dart_math.Random?>(positional, 0, 'rng');
        return $vector_math_1.Vector2.random(rng);
      },
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').storage,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').hashCode,
      'length': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').length,
      'length2': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').length2,
      'isInfinite': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').isInfinite,
      'isNaN': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').isNaN,
      'xx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xx,
      'xy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xy,
      'yx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yx,
      'yy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yy,
      'xxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xxx,
      'xxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xxy,
      'xyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xyx,
      'xyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xyy,
      'yxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yxx,
      'yxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yxy,
      'yyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yyx,
      'yyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yyy,
      'xxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xxxx,
      'xxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xxxy,
      'xxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xxyx,
      'xxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xxyy,
      'xyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xyxx,
      'xyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xyxy,
      'xyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xyyx,
      'xyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xyyy,
      'yxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yxxx,
      'yxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yxxy,
      'yxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yxyx,
      'yxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yxyy,
      'yyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yyxx,
      'yyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yyxy,
      'yyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yyyx,
      'yyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yyyy,
      'r': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').r,
      'g': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').g,
      's': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').s,
      't': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').t,
      'x': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').x,
      'y': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').y,
      'rr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rr,
      'rg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rg,
      'gr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').gr,
      'gg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').gg,
      'rrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rrr,
      'rrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rrg,
      'rgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rgr,
      'rgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rgg,
      'grr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').grr,
      'grg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').grg,
      'ggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ggr,
      'ggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ggg,
      'rrrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rrrr,
      'rrrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rrrg,
      'rrgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rrgr,
      'rrgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rrgg,
      'rgrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rgrr,
      'rgrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rgrg,
      'rggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rggr,
      'rggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rggg,
      'grrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').grrr,
      'grrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').grrg,
      'grgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').grgr,
      'grgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').grgg,
      'ggrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ggrr,
      'ggrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ggrg,
      'gggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').gggr,
      'gggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').gggg,
      'ss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ss,
      'st': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').st,
      'ts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ts,
      'tt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tt,
      'sss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').sss,
      'sst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').sst,
      'sts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').sts,
      'stt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').stt,
      'tss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tss,
      'tst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tst,
      'tts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tts,
      'ttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ttt,
      'ssss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ssss,
      'ssst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ssst,
      'ssts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ssts,
      'sstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').sstt,
      'stss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').stss,
      'stst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').stst,
      'stts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').stts,
      'sttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').sttt,
      'tsss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tsss,
      'tsst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tsst,
      'tsts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tsts,
      'tstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tstt,
      'ttss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ttss,
      'ttst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ttst,
      'ttts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ttts,
      'tttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').tttt,
    },
    setters: {
      'length': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').length = value as dynamic,
      'xy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xy = value as dynamic,
      'yx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yx = value as dynamic,
      'r': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').r = value as dynamic,
      'g': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').g = value as dynamic,
      's': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').s = value as dynamic,
      't': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').t = value as dynamic,
      'x': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').x = value as dynamic,
      'y': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').y = value as dynamic,
      'rg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rg = value as dynamic,
      'gr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').gr = value as dynamic,
      'st': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').st = value as dynamic,
      'ts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ts = value as dynamic,
    },
    methods: {
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 2, 'setValues');
        final x = D4.getRequiredArg<double>(positional, 0, 'x_', 'setValues');
        final y = D4.getRequiredArg<double>(positional, 1, 'y_', 'setValues');
        t.setValues(x, y);
        return null;
      },
      'setZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        t.setZero();
        return null;
      },
      'setFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'setFrom');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'setFrom');
        t.setFrom(other);
        return null;
      },
      'splat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'splat');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'splat');
        t.splat(arg);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        return t.toString();
      },
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        return t.normalize();
      },
      'normalizeLength': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        return t.normalizeLength();
      },
      'normalized': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        return t.normalized();
      },
      'normalizeInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'normalizeInto');
        final out = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'out', 'normalizeInto');
        return t.normalizeInto(out);
      },
      'distanceTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'distanceTo');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'distanceTo');
        return t.distanceTo(arg);
      },
      'distanceToSquared': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'distanceToSquared');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'distanceToSquared');
        return t.distanceToSquared(arg);
      },
      'angleTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'angleTo');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'angleTo');
        return t.angleTo(other);
      },
      'angleToSigned': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'angleToSigned');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'angleToSigned');
        return t.angleToSigned(other);
      },
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'postmultiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'postmultiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'postmultiply');
        t.postmultiply(arg);
        return null;
      },
      'cross': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'cross');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'cross');
        return t.cross(other);
      },
      'scaleOrthogonalInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 2, 'scaleOrthogonalInto');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scaleOrthogonalInto');
        final out = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'out', 'scaleOrthogonalInto');
        return t.scaleOrthogonalInto(scale, out);
      },
      'reflect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'reflect');
        final normal = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'normal', 'reflect');
        t.reflect(normal);
        return null;
      },
      'reflected': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'reflected');
        final normal = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'normal', 'reflected');
        return t.reflected(normal);
      },
      'relativeError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'relativeError');
        final correct = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'correct', 'relativeError');
        return t.relativeError(correct);
      },
      'absoluteError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'absoluteError');
        final correct = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'correct', 'absoluteError');
        return t.absoluteError(correct);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'add');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'add');
        t.add(arg);
        return null;
      },
      'addScaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 2, 'addScaled');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'addScaled');
        final factor = D4.getRequiredArg<double>(positional, 1, 'factor', 'addScaled');
        t.addScaled(arg, factor);
        return null;
      },
      'sub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'sub');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'sub');
        t.sub(arg);
        return null;
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'multiply');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'multiply');
        t.multiply(arg);
        return null;
      },
      'divide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'divide');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'divide');
        t.divide(arg);
        return null;
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'scale');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'scale');
        t.scale(arg);
        return null;
      },
      'scaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'scaled');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'scaled');
        return t.scaled(arg);
      },
      'negate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        t.negate();
        return null;
      },
      'absolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        t.absolute();
        return null;
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'max', 'clamp');
        t.clamp(min, max);
        return null;
      },
      'clampScalar': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 2, 'clampScalar');
        final min = D4.getRequiredArg<double>(positional, 0, 'min', 'clampScalar');
        final max = D4.getRequiredArg<double>(positional, 1, 'max', 'clampScalar');
        t.clampScalar(min, max);
        return null;
      },
      'floor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        t.floor();
        return null;
      },
      'ceil': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        t.ceil();
        return null;
      },
      'round': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        t.round();
        return null;
      },
      'roundToZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        t.roundToZero();
        return null;
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        return t.clone();
      },
      'copyInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'copyInto');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'copyInto');
        return t.copyInto(arg);
      },
      'copyIntoArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'copyIntoArray');
        if (positional.isEmpty) {
          throw ArgumentError('copyIntoArray: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        t.copyIntoArray(array, offset);
        return null;
      },
      'copyFromArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        D4.requireMinArgs(positional, 1, 'copyFromArray');
        if (positional.isEmpty) {
          throw ArgumentError('copyFromArray: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        t.copyFromArray(array, offset);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticMethods: {
      'min': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'min');
        final a = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'a', 'min');
        final b = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'b', 'min');
        final result = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'result', 'min');
        return $vector_math_1.Vector2.min(a, b, result);
      },
      'max': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'max');
        final a = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'a', 'max');
        final b = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'b', 'max');
        final result = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'result', 'max');
        return $vector_math_1.Vector2.max(a, b, result);
      },
      'mix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'mix');
        final min = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'min', 'mix');
        final max = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'max', 'mix');
        final a = D4.getRequiredArg<double>(positional, 2, 'a', 'mix');
        final result = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 3, 'result', 'mix');
        return $vector_math_1.Vector2.mix(min, max, a, result);
      },
    },
    constructorSignatures: {
      '': 'factory Vector2(double x, double y)',
      'array': 'factory Vector2.array(List<double> array, [int offset = 0])',
      'zero': 'Vector2.zero()',
      'all': 'factory Vector2.all(double value)',
      'copy': 'factory Vector2.copy(Vector2 other)',
      'fromFloat64List': 'Vector2.fromFloat64List(Float64List _v2storage)',
      'fromBuffer': 'Vector2.fromBuffer(ByteBuffer buffer, int offset)',
      'random': 'factory Vector2.random([math.Random? rng])',
    },
    methodSignatures: {
      'setValues': 'void setValues(double x_, double y_)',
      'setZero': 'void setZero()',
      'setFrom': 'void setFrom(Vector2 other)',
      'splat': 'void splat(double arg)',
      'toString': 'String toString()',
      'normalize': 'double normalize()',
      'normalizeLength': 'double normalizeLength()',
      'normalized': 'Vector2 normalized()',
      'normalizeInto': 'Vector2 normalizeInto(Vector2 out)',
      'distanceTo': 'double distanceTo(Vector2 arg)',
      'distanceToSquared': 'double distanceToSquared(Vector2 arg)',
      'angleTo': 'double angleTo(Vector2 other)',
      'angleToSigned': 'double angleToSigned(Vector2 other)',
      'dot': 'double dot(Vector2 other)',
      'postmultiply': 'void postmultiply(Matrix2 arg)',
      'cross': 'double cross(Vector2 other)',
      'scaleOrthogonalInto': 'Vector2 scaleOrthogonalInto(double scale, Vector2 out)',
      'reflect': 'void reflect(Vector2 normal)',
      'reflected': 'Vector2 reflected(Vector2 normal)',
      'relativeError': 'double relativeError(Vector2 correct)',
      'absoluteError': 'double absoluteError(Vector2 correct)',
      'add': 'void add(Vector2 arg)',
      'addScaled': 'void addScaled(Vector2 arg, double factor)',
      'sub': 'void sub(Vector2 arg)',
      'multiply': 'void multiply(Vector2 arg)',
      'divide': 'void divide(Vector2 arg)',
      'scale': 'void scale(double arg)',
      'scaled': 'Vector2 scaled(double arg)',
      'negate': 'void negate()',
      'absolute': 'void absolute()',
      'clamp': 'void clamp(Vector2 min, Vector2 max)',
      'clampScalar': 'void clampScalar(double min, double max)',
      'floor': 'void floor()',
      'ceil': 'void ceil()',
      'round': 'void round()',
      'roundToZero': 'void roundToZero()',
      'clone': 'Vector2 clone()',
      'copyInto': 'Vector2 copyInto(Vector2 arg)',
      'copyIntoArray': 'void copyIntoArray(List<double> array, [int offset = 0])',
      'copyFromArray': 'void copyFromArray(List<double> array, [int offset = 0])',
    },
    getterSignatures: {
      'storage': 'Float64List get storage',
      'hashCode': 'int get hashCode',
      'length': 'double get length',
      'length2': 'double get length2',
      'isInfinite': 'bool get isInfinite',
      'isNaN': 'bool get isNaN',
      'xx': 'Vector2 get xx',
      'xy': 'Vector2 get xy',
      'yx': 'Vector2 get yx',
      'yy': 'Vector2 get yy',
      'xxx': 'Vector3 get xxx',
      'xxy': 'Vector3 get xxy',
      'xyx': 'Vector3 get xyx',
      'xyy': 'Vector3 get xyy',
      'yxx': 'Vector3 get yxx',
      'yxy': 'Vector3 get yxy',
      'yyx': 'Vector3 get yyx',
      'yyy': 'Vector3 get yyy',
      'xxxx': 'Vector4 get xxxx',
      'xxxy': 'Vector4 get xxxy',
      'xxyx': 'Vector4 get xxyx',
      'xxyy': 'Vector4 get xxyy',
      'xyxx': 'Vector4 get xyxx',
      'xyxy': 'Vector4 get xyxy',
      'xyyx': 'Vector4 get xyyx',
      'xyyy': 'Vector4 get xyyy',
      'yxxx': 'Vector4 get yxxx',
      'yxxy': 'Vector4 get yxxy',
      'yxyx': 'Vector4 get yxyx',
      'yxyy': 'Vector4 get yxyy',
      'yyxx': 'Vector4 get yyxx',
      'yyxy': 'Vector4 get yyxy',
      'yyyx': 'Vector4 get yyyx',
      'yyyy': 'Vector4 get yyyy',
      'r': 'double get r',
      'g': 'double get g',
      's': 'double get s',
      't': 'double get t',
      'x': 'double get x',
      'y': 'double get y',
      'rr': 'Vector2 get rr',
      'rg': 'Vector2 get rg',
      'gr': 'Vector2 get gr',
      'gg': 'Vector2 get gg',
      'rrr': 'Vector3 get rrr',
      'rrg': 'Vector3 get rrg',
      'rgr': 'Vector3 get rgr',
      'rgg': 'Vector3 get rgg',
      'grr': 'Vector3 get grr',
      'grg': 'Vector3 get grg',
      'ggr': 'Vector3 get ggr',
      'ggg': 'Vector3 get ggg',
      'rrrr': 'Vector4 get rrrr',
      'rrrg': 'Vector4 get rrrg',
      'rrgr': 'Vector4 get rrgr',
      'rrgg': 'Vector4 get rrgg',
      'rgrr': 'Vector4 get rgrr',
      'rgrg': 'Vector4 get rgrg',
      'rggr': 'Vector4 get rggr',
      'rggg': 'Vector4 get rggg',
      'grrr': 'Vector4 get grrr',
      'grrg': 'Vector4 get grrg',
      'grgr': 'Vector4 get grgr',
      'grgg': 'Vector4 get grgg',
      'ggrr': 'Vector4 get ggrr',
      'ggrg': 'Vector4 get ggrg',
      'gggr': 'Vector4 get gggr',
      'gggg': 'Vector4 get gggg',
      'ss': 'Vector2 get ss',
      'st': 'Vector2 get st',
      'ts': 'Vector2 get ts',
      'tt': 'Vector2 get tt',
      'sss': 'Vector3 get sss',
      'sst': 'Vector3 get sst',
      'sts': 'Vector3 get sts',
      'stt': 'Vector3 get stt',
      'tss': 'Vector3 get tss',
      'tst': 'Vector3 get tst',
      'tts': 'Vector3 get tts',
      'ttt': 'Vector3 get ttt',
      'ssss': 'Vector4 get ssss',
      'ssst': 'Vector4 get ssst',
      'ssts': 'Vector4 get ssts',
      'sstt': 'Vector4 get sstt',
      'stss': 'Vector4 get stss',
      'stst': 'Vector4 get stst',
      'stts': 'Vector4 get stts',
      'sttt': 'Vector4 get sttt',
      'tsss': 'Vector4 get tsss',
      'tsst': 'Vector4 get tsst',
      'tsts': 'Vector4 get tsts',
      'tstt': 'Vector4 get tstt',
      'ttss': 'Vector4 get ttss',
      'ttst': 'Vector4 get ttst',
      'ttts': 'Vector4 get ttts',
      'tttt': 'Vector4 get tttt',
    },
    setterSignatures: {
      'length': 'set length(double value)',
      'xy': 'set xy(Vector2 value)',
      'yx': 'set yx(Vector2 value)',
      'r': 'set r(double value)',
      'g': 'set g(double value)',
      's': 'set s(double value)',
      't': 'set t(double value)',
      'x': 'set x(double value)',
      'y': 'set y(double value)',
      'rg': 'set rg(Vector2 value)',
      'gr': 'set gr(Vector2 value)',
      'st': 'set st(Vector2 value)',
      'ts': 'set ts(Vector2 value)',
    },
    staticMethodSignatures: {
      'min': 'void min(Vector2 a, Vector2 b, Vector2 result)',
      'max': 'void max(Vector2 a, Vector2 b, Vector2 result)',
      'mix': 'void mix(Vector2 min, Vector2 max, double a, Vector2 result)',
    },
  );
}

