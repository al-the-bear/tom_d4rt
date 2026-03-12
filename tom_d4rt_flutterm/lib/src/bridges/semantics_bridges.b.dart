// D4rt Bridge - Generated file, do not edit
// Sources: 12 files
// Generated: 2026-03-12T17:05:19.762600

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:math' as $dart_math;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/basic_types.dart' as $flutter_1;
import 'package:flutter/src/foundation/binding.dart' as $flutter_2;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_3;
import 'package:flutter/src/foundation/key.dart' as $flutter_4;
import 'package:flutter/src/semantics/binding.dart' as $flutter_5;
import 'package:flutter/src/semantics/semantics.dart' as $flutter_6;
import 'package:flutter/src/semantics/semantics_event.dart' as $flutter_7;
import 'package:flutter/src/services/text_editing.dart' as $flutter_8;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;
import 'package:flutter/src/foundation/change_notifier.dart' as $aux_flutter_2;

/// Bridge class for flutter_semantics module.
class FlutterSemanticsBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createSemanticsBindingBridge(),
      _createSemanticsHandleBridge(),
      _createAabb2Bridge(),
      _createAabb3Bridge(),
      _createColorsBridge(),
      _createFrustumBridge(),
      _createIntersectionResultBridge(),
      _createMatrix2Bridge(),
      _createMatrix3Bridge(),
      _createMatrix4Bridge(),
      _createObb3Bridge(),
      _createPlaneBridge(),
      _createQuadBridge(),
      _createQuaternionBridge(),
      _createRayBridge(),
      _createSphereBridge(),
      _createTriangleBridge(),
      _createVectorBridge(),
      _createVector2Bridge(),
      _createVector3Bridge(),
      _createVector4Bridge(),
      _createTextSelectionBridge(),
      _createSemanticsEventBridge(),
      _createAnnounceSemanticsEventBridge(),
      _createTooltipSemanticsEventBridge(),
      _createLongPressSemanticsEventBridge(),
      _createTapSemanticEventBridge(),
      _createFocusSemanticEventBridge(),
      _createSemanticsTagBridge(),
      _createChildSemanticsConfigurationsResultBridge(),
      _createChildSemanticsConfigurationsResultBuilderBridge(),
      _createCustomSemanticsActionBridge(),
      _createAttributedStringBridge(),
      _createAttributedStringPropertyBridge(),
      _createSemanticsLabelBuilderBridge(),
      _createSemanticsDataBridge(),
      _createSemanticsHintOverridesBridge(),
      _createSemanticsPropertiesBridge(),
      _createSemanticsNodeBridge(),
      _createSemanticsOwnerBridge(),
      _createSemanticsConfigurationBridge(),
      _createSemanticsSortKeyBridge(),
      _createOrdinalSortKeyBridge(),
      _createSemanticsServiceBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'SemanticsBinding': 'C:\flutter\packages\flutter\lib\src\semantics\binding.dart',
      'SemanticsHandle': 'C:\flutter\packages\flutter\lib\src\semantics\binding.dart',
      'Aabb2': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Aabb3': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Colors': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Frustum': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'IntersectionResult': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Matrix2': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Matrix3': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Matrix4': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Obb3': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Plane': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Quad': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Quaternion': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Ray': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Sphere': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Triangle': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Vector': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Vector2': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Vector3': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'Vector4': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'TextSelection': 'C:\flutter\packages\flutter\lib\src\services\text_editing.dart',
      'SemanticsEvent': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'AnnounceSemanticsEvent': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'TooltipSemanticsEvent': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'LongPressSemanticsEvent': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'TapSemanticEvent': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'FocusSemanticEvent': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'SemanticsTag': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'ChildSemanticsConfigurationsResult': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'ChildSemanticsConfigurationsResultBuilder': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'CustomSemanticsAction': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'AttributedString': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'AttributedStringProperty': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsLabelBuilder': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsData': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsHintOverrides': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsProperties': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsNode': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsOwner': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsConfiguration': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsSortKey': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'OrdinalSortKey': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'SemanticsService': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_service.dart',
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
      'VoidCallback',
      'ValueSetter',
      'AsyncCallback',
      'AsyncValueGetter',
      'AsyncValueSetter',
      'ServiceExtensionCallback',
      'MessageHandler',
      'PlatformMessageResponseCallback',
      'KeyEventCallback',
      'SystemUiChangeCallback',
      'SchedulingStrategy',
      'TimingsCallback',
      'TaskCallback',
      'FrameCallback',
      'RespondPointerEventCallback',
      'PointerRoute',
      'PointerSignalResolvedCallback',
      'InformationCollector',
      'IterableFilter',
      'DevicePixelRatioGetter',
      'GestureDragDownCallback',
      'GestureDragStartCallback',
      'GestureDragUpdateCallback',
      'AllowedButtonsFilter',
      'RecognizerCallback',
      'GestureForcePressStartCallback',
      'GestureForcePressPeakCallback',
      'GestureForcePressUpdateCallback',
      'GestureForcePressEndCallback',
      'GestureForceInterpolation',
      'GestureLongPressDownCallback',
      'GestureLongPressCancelCallback',
      'GestureLongPressCallback',
      'GestureLongPressUpCallback',
      'GestureLongPressStartCallback',
      'GestureLongPressMoveUpdateCallback',
      'GestureLongPressEndCallback',
      'GestureDragEndCallback',
      'GestureDragCancelCallback',
      'GestureVelocityTrackerBuilder',
      'GestureMultiDragStartCallback',
      'GestureTapDownCallback',
      'GestureTapUpCallback',
      'GestureTapCallback',
      'GestureTapMoveCallback',
      'GestureTapCancelCallback',
      'GestureDoubleTapCallback',
      'GestureMultiTapDownCallback',
      'GestureMultiTapUpCallback',
      'GestureMultiTapCallback',
      'GestureMultiTapCancelCallback',
      'GestureSerialTapDownCallback',
      'GestureSerialTapCancelCallback',
      'GestureSerialTapUpCallback',
      'HandleEventCallback',
      'GestureScaleStartCallback',
      'GestureScaleUpdateCallback',
      'GestureScaleEndCallback',
      'GestureTapDragDownCallback',
      'GestureTapDragUpCallback',
      'GestureTapDragStartCallback',
      'GestureTapDragUpdateCallback',
      'GestureTapDragEndCallback',
      'GestureCancelCallback',
      'PointerEnterEventListener',
      'PointerExitEventListener',
      'PointerHoverEventListener',
      'PointTransformer',
      'PlatformViewCreatedCallback',
      'UntilPredicate',
      'TextInputFormatFunction',
      'SemanticsNodeVisitor',
      'MoveCursorHandler',
      'SetSelectionHandler',
      'SetTextHandler',
      'ScrollToOffsetHandler',
      'SemanticsActionHandler',
      'SemanticsUpdateCallback',
      'ChildSemanticsConfigurationsDelegate',
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_7.Assertiveness>(
        name: 'Assertiveness',
        values: $flutter_7.Assertiveness.values,
      ),
      BridgedEnumDefinition<$flutter_6.AccessibilityFocusBlockType>(
        name: 'AccessibilityFocusBlockType',
        values: $flutter_6.AccessibilityFocusBlockType.values,
      ),
      BridgedEnumDefinition<$flutter_6.DebugSemanticsDumpOrder>(
        name: 'DebugSemanticsDumpOrder',
        values: $flutter_6.DebugSemanticsDumpOrder.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'Assertiveness': 'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'AccessibilityFocusBlockType': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'DebugSemanticsDumpOrder': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
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
      interpreter.registerGlobalVariable('debugSemanticsDisableAnimations', debugSemanticsDisableAnimations, importPath, sourceUri: 'C:\flutter\packages\flutter\lib\src\semantics\debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugSemanticsDisableAnimations": $e');
    }
    try {
      interpreter.registerGlobalVariable('degrees2Radians', degrees2Radians, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "degrees2Radians": $e');
    }
    try {
      interpreter.registerGlobalVariable('radians2Degrees', radians2Degrees, importPath, sourceUri: 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "radians2Degrees": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_semantics):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'relativeError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'relativeError');
        final calculated = D4.getRequiredArg<dynamic>(positional, 0, 'calculated', 'relativeError');
        final correct = D4.getRequiredArg<dynamic>(positional, 1, 'correct', 'relativeError');
        return relativeError(calculated, correct);
      },
      'absoluteError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'absoluteError');
        final calculated = D4.getRequiredArg<dynamic>(positional, 0, 'calculated', 'absoluteError');
        final correct = D4.getRequiredArg<dynamic>(positional, 1, 'correct', 'absoluteError');
        return absoluteError(calculated, correct);
      },
      'setRotationMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'setRotationMatrix');
        final rotationMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'rotationMatrix', 'setRotationMatrix');
        final forwardDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'forwardDirection', 'setRotationMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'upDirection', 'setRotationMatrix');
        return setRotationMatrix(rotationMatrix, forwardDirection, upDirection);
      },
      'setModelMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'setModelMatrix');
        final modelMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'modelMatrix', 'setModelMatrix');
        final forwardDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'forwardDirection', 'setModelMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'upDirection', 'setModelMatrix');
        final tx = D4.getRequiredArg<double>(positional, 3, 'tx', 'setModelMatrix');
        final ty = D4.getRequiredArg<double>(positional, 4, 'ty', 'setModelMatrix');
        final tz = D4.getRequiredArg<double>(positional, 5, 'tz', 'setModelMatrix');
        return setModelMatrix(modelMatrix, forwardDirection, upDirection, tx, ty, tz);
      },
      'setViewMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'setViewMatrix');
        final viewMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'viewMatrix', 'setViewMatrix');
        final cameraPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'cameraPosition', 'setViewMatrix');
        final cameraFocusPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'cameraFocusPosition', 'setViewMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 3, 'upDirection', 'setViewMatrix');
        return setViewMatrix(viewMatrix, cameraPosition, cameraFocusPosition, upDirection);
      },
      'makeViewMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'makeViewMatrix');
        final cameraPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'cameraPosition', 'makeViewMatrix');
        final cameraFocusPosition = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'cameraFocusPosition', 'makeViewMatrix');
        final upDirection = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'upDirection', 'makeViewMatrix');
        return makeViewMatrix(cameraPosition, cameraFocusPosition, upDirection);
      },
      'setPerspectiveMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 5, 'setPerspectiveMatrix');
        final perspectiveMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'perspectiveMatrix', 'setPerspectiveMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 1, 'fovYRadians', 'setPerspectiveMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 2, 'aspectRatio', 'setPerspectiveMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 3, 'zNear', 'setPerspectiveMatrix');
        final zFar = D4.getRequiredArg<double>(positional, 4, 'zFar', 'setPerspectiveMatrix');
        return setPerspectiveMatrix(perspectiveMatrix, fovYRadians, aspectRatio, zNear, zFar);
      },
      'makePerspectiveMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'makePerspectiveMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 0, 'fovYRadians', 'makePerspectiveMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 1, 'aspectRatio', 'makePerspectiveMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 2, 'zNear', 'makePerspectiveMatrix');
        final zFar = D4.getRequiredArg<double>(positional, 3, 'zFar', 'makePerspectiveMatrix');
        return makePerspectiveMatrix(fovYRadians, aspectRatio, zNear, zFar);
      },
      'setInfiniteMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'setInfiniteMatrix');
        final infiniteMatrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'infiniteMatrix', 'setInfiniteMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 1, 'fovYRadians', 'setInfiniteMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 2, 'aspectRatio', 'setInfiniteMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 3, 'zNear', 'setInfiniteMatrix');
        return setInfiniteMatrix(infiniteMatrix, fovYRadians, aspectRatio, zNear);
      },
      'makeInfiniteMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'makeInfiniteMatrix');
        final fovYRadians = D4.getRequiredArg<double>(positional, 0, 'fovYRadians', 'makeInfiniteMatrix');
        final aspectRatio = D4.getRequiredArg<double>(positional, 1, 'aspectRatio', 'makeInfiniteMatrix');
        final zNear = D4.getRequiredArg<double>(positional, 2, 'zNear', 'makeInfiniteMatrix');
        return makeInfiniteMatrix(fovYRadians, aspectRatio, zNear);
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
        return setFrustumMatrix(perspectiveMatrix, left, right, bottom, top, near, far);
      },
      'makeFrustumMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'makeFrustumMatrix');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'makeFrustumMatrix');
        final right = D4.getRequiredArg<double>(positional, 1, 'right', 'makeFrustumMatrix');
        final bottom = D4.getRequiredArg<double>(positional, 2, 'bottom', 'makeFrustumMatrix');
        final top = D4.getRequiredArg<double>(positional, 3, 'top', 'makeFrustumMatrix');
        final near = D4.getRequiredArg<double>(positional, 4, 'near', 'makeFrustumMatrix');
        final far = D4.getRequiredArg<double>(positional, 5, 'far', 'makeFrustumMatrix');
        return makeFrustumMatrix(left, right, bottom, top, near, far);
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
        return setOrthographicMatrix(orthographicMatrix, left, right, bottom, top, near, far);
      },
      'makeOrthographicMatrix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'makeOrthographicMatrix');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'makeOrthographicMatrix');
        final right = D4.getRequiredArg<double>(positional, 1, 'right', 'makeOrthographicMatrix');
        final bottom = D4.getRequiredArg<double>(positional, 2, 'bottom', 'makeOrthographicMatrix');
        final top = D4.getRequiredArg<double>(positional, 3, 'top', 'makeOrthographicMatrix');
        final near = D4.getRequiredArg<double>(positional, 4, 'near', 'makeOrthographicMatrix');
        final far = D4.getRequiredArg<double>(positional, 5, 'far', 'makeOrthographicMatrix');
        return makeOrthographicMatrix(left, right, bottom, top, near, far);
      },
      'makePlaneProjection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'makePlaneProjection');
        final planeNormal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'planeNormal', 'makePlaneProjection');
        final planePoint = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'planePoint', 'makePlaneProjection');
        return makePlaneProjection(planeNormal, planePoint);
      },
      'makePlaneReflection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'makePlaneReflection');
        final planeNormal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'planeNormal', 'makePlaneReflection');
        final planePoint = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'planePoint', 'makePlaneReflection');
        return makePlaneReflection(planeNormal, planePoint);
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
        return unproject(cameraMatrix, viewportX, viewportWidth, viewportY, viewportHeight, pickX, pickY, pickZ, pickWorld);
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
        return pickRay(cameraMatrix, viewportX, viewportWidth, viewportY, viewportHeight, pickX, pickY, rayNear, rayFar);
      },
      'degrees': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'degrees');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'degrees');
        return degrees(radians);
      },
      'radians': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'radians');
        final degrees = D4.getRequiredArg<double>(positional, 0, 'degrees', 'radians');
        return radians(degrees);
      },
      'mix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'mix');
        final min = D4.getRequiredArg<double>(positional, 0, 'min', 'mix');
        final max = D4.getRequiredArg<double>(positional, 1, 'max', 'mix');
        final a = D4.getRequiredArg<double>(positional, 2, 'a', 'mix');
        return mix(min, max, a);
      },
      'smoothStep': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'smoothStep');
        final edge0 = D4.getRequiredArg<double>(positional, 0, 'edge0', 'smoothStep');
        final edge1 = D4.getRequiredArg<double>(positional, 1, 'edge1', 'smoothStep');
        final amount = D4.getRequiredArg<double>(positional, 2, 'amount', 'smoothStep');
        return smoothStep(edge0, edge1, amount);
      },
      'catmullRom': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 5, 'catmullRom');
        final edge0 = D4.getRequiredArg<double>(positional, 0, 'edge0', 'catmullRom');
        final edge1 = D4.getRequiredArg<double>(positional, 1, 'edge1', 'catmullRom');
        final edge2 = D4.getRequiredArg<double>(positional, 2, 'edge2', 'catmullRom');
        final edge3 = D4.getRequiredArg<double>(positional, 3, 'edge3', 'catmullRom');
        final amount = D4.getRequiredArg<double>(positional, 4, 'amount', 'catmullRom');
        return catmullRom(edge0, edge1, edge2, edge3, amount);
      },
      'dot2': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'dot2');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'x', 'dot2');
        final y = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'y', 'dot2');
        return dot2(x, y);
      },
      'dot3': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'dot3');
        final x = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'x', 'dot3');
        final y = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'y', 'dot3');
        return dot3(x, y);
      },
      'cross3': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'cross3');
        final x = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'x', 'cross3');
        final y = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'y', 'cross3');
        final out = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'out', 'cross3');
        return cross3(x, y, out);
      },
      'cross2': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'cross2');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'x', 'cross2');
        final y = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'y', 'cross2');
        return cross2(x, y);
      },
      'cross2A': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'cross2A');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'cross2A');
        final y = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'y', 'cross2A');
        final out = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'out', 'cross2A');
        return cross2A(x, y, out);
      },
      'cross2B': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'cross2B');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'x', 'cross2B');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'cross2B');
        final out = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'out', 'cross2B');
        return cross2B(x, y, out);
      },
      'buildPlaneVectors': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'buildPlaneVectors');
        final planeNormal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'planeNormal', 'buildPlaneVectors');
        final u = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'u', 'buildPlaneVectors');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'v', 'buildPlaneVectors');
        return buildPlaneVectors(planeNormal, u, v);
      },
      'debugResetSemanticsIdCounter': (visitor, positional, named, typeArgs) {
        return debugResetSemanticsIdCounter();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'relativeError': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\error_helpers.dart',
      'absoluteError': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\error_helpers.dart',
      'setRotationMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'setModelMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'setViewMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'makeViewMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'setPerspectiveMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'makePerspectiveMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'setInfiniteMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'makeInfiniteMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'setFrustumMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'makeFrustumMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'setOrthographicMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'makeOrthographicMatrix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'makePlaneProjection': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'makePlaneReflection': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'unproject': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'pickRay': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'degrees': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\utilities.dart',
      'radians': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\utilities.dart',
      'mix': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\utilities.dart',
      'smoothStep': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\utilities.dart',
      'catmullRom': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\utilities.dart',
      'dot2': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'dot3': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'cross3': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'cross2': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'cross2A': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'cross2B': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'buildPlaneVectors': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'debugResetSemanticsIdCounter': 'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
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
      'debugResetSemanticsIdCounter': 'void debugResetSemanticsIdCounter()',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\constants.dart',
      'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\error_helpers.dart',
      'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\opengl.dart',
      'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\utilities.dart',
      'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\src\vector_math_64\vector.dart',
      'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\vector_math-2.2.0\lib\vector_math_64.dart',
      'C:\flutter\packages\flutter\lib\src\semantics\binding.dart',
      'C:\flutter\packages\flutter\lib\src\semantics\debug.dart',
      'C:\flutter\packages\flutter\lib\src\semantics\semantics.dart',
      'C:\flutter\packages\flutter\lib\src\semantics\semantics_event.dart',
      'C:\flutter\packages\flutter\lib\src\semantics\semantics_service.dart',
      'C:\flutter\packages\flutter\lib\src\services\text_editing.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:flutter/semantics.dart';";
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
    'Assertiveness',
    'AccessibilityFocusBlockType',
    'DebugSemanticsDumpOrder',
  ];

}

// =============================================================================
// SemanticsBinding Bridge
// =============================================================================

BridgedClass _createSemanticsBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_5.SemanticsBinding,
    name: 'SemanticsBinding',
    isAssignable: (v) => v is $flutter_5.SemanticsBinding,
    constructors: {
    },
    getters: {
      'semanticsEnabled': (visitor, target) => D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding').semanticsEnabled,
      'debugOutstandingSemanticsHandles': (visitor, target) => D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding').debugOutstandingSemanticsHandles,
      'accessibilityFeatures': (visitor, target) => D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding').accessibilityFeatures,
      'disableAnimations': (visitor, target) => D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding').disableAnimations,
      'window': (visitor, target) => D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding').platformDispatcher,
      'locked': (visitor, target) => D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding').locked,
    },
    methods: {
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        t.initInstances();
        return null;
      },
      'addSemanticsEnabledListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'addSemanticsEnabledListener');
        if (positional.isEmpty) {
          throw ArgumentError('addSemanticsEnabledListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addSemanticsEnabledListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeSemanticsEnabledListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'removeSemanticsEnabledListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeSemanticsEnabledListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeSemanticsEnabledListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'addSemanticsActionListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'addSemanticsActionListener');
        if (positional.isEmpty) {
          throw ArgumentError('addSemanticsActionListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addSemanticsActionListener((SemanticsActionEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeSemanticsActionListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'removeSemanticsActionListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeSemanticsActionListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeSemanticsActionListener((SemanticsActionEvent p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'ensureSemantics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        return t.ensureSemantics();
      },
      'performSemanticsAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'performSemanticsAction');
        final action = D4.getRequiredArg<SemanticsActionEvent>(positional, 0, 'action', 'performSemanticsAction');
        t.performSemanticsAction(action);
        return null;
      },
      'handleAccessibilityFeaturesChanged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        t.handleAccessibilityFeaturesChanged();
        return null;
      },
      'createSemanticsUpdateBuilder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        return t.createSemanticsUpdateBuilder();
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'lockEvents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'lockEvents');
        if (positional.isEmpty) {
          throw ArgumentError('lockEvents: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.lockEvents(() { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        (t as dynamic).unlocked();
        return null;
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        return t.reassembleApplication();
      },
      'performReassemble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        return t.performReassemble();
      },
      'registerSignalServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerSignalServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerSignalServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerSignalServiceExtension(name: name, callback: () { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
        return null;
      },
      'registerBoolServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
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
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
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
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
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
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
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
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: (Map<String, String> p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as Future<Map<String, dynamic>>; });
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        return t.toString();
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_5.SemanticsBinding.instance,
    },
    methodSignatures: {
      'initInstances': 'void initInstances()',
      'addSemanticsEnabledListener': 'void addSemanticsEnabledListener(VoidCallback listener)',
      'removeSemanticsEnabledListener': 'void removeSemanticsEnabledListener(VoidCallback listener)',
      'addSemanticsActionListener': 'void addSemanticsActionListener(ValueSetter<ui.SemanticsActionEvent> listener)',
      'removeSemanticsActionListener': 'void removeSemanticsActionListener(ValueSetter<ui.SemanticsActionEvent> listener)',
      'ensureSemantics': 'SemanticsHandle ensureSemantics()',
      'performSemanticsAction': 'void performSemanticsAction(ui.SemanticsActionEvent action)',
      'handleAccessibilityFeaturesChanged': 'void handleAccessibilityFeaturesChanged()',
      'createSemanticsUpdateBuilder': 'ui.SemanticsUpdateBuilder createSemanticsUpdateBuilder()',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'initServiceExtensions': 'void initServiceExtensions()',
      'lockEvents': 'Future<void> lockEvents(Future<void> Function() callback)',
      'unlocked': 'void unlocked()',
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
      'semanticsEnabled': 'bool get semanticsEnabled',
      'debugOutstandingSemanticsHandles': 'int get debugOutstandingSemanticsHandles',
      'accessibilityFeatures': 'ui.AccessibilityFeatures get accessibilityFeatures',
      'disableAnimations': 'bool get disableAnimations',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
      'locked': 'bool get locked',
    },
    staticGetterSignatures: {
      'instance': 'SemanticsBinding get instance',
    },
  );
}

// =============================================================================
// SemanticsHandle Bridge
// =============================================================================

BridgedClass _createSemanticsHandleBridge() {
  return BridgedClass(
    nativeType: $flutter_5.SemanticsHandle,
    name: 'SemanticsHandle',
    isAssignable: (v) => v is $flutter_5.SemanticsHandle,
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsHandle>(target, 'SemanticsHandle');
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
// Aabb2 Bridge
// =============================================================================

BridgedClass _createAabb2Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Aabb2,
    name: 'Aabb2',
    isAssignable: (v) => v is $vector_math_1.Aabb2,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Aabb2();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Aabb2');
        final other = D4.getRequiredArg<$vector_math_1.Aabb2>(positional, 0, 'other', 'Aabb2');
        return $vector_math_1.Aabb2.copy(other);
      },
      'minMax': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Aabb2');
        final min = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'min', 'Aabb2');
        final max = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'max', 'Aabb2');
        return $vector_math_1.Aabb2.minMax(min, max);
      },
      'centerAndHalfExtents': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Aabb2');
        final center = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'center', 'Aabb2');
        final halfExtents = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'halfExtents', 'Aabb2');
        return $vector_math_1.Aabb2.centerAndHalfExtents(center, halfExtents);
      },
      'fromBuffer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Aabb2');
        final buffer = D4.getRequiredArg<ByteBuffer>(positional, 0, 'buffer', 'Aabb2');
        final offset = D4.getRequiredArg<int>(positional, 1, 'offset', 'Aabb2');
        return $vector_math_1.Aabb2.fromBuffer(buffer, offset);
      },
    },
    getters: {
      'min': (visitor, target) => D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2').min,
      'max': (visitor, target) => D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2').max,
      'center': (visitor, target) => D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2').center,
    },
    methods: {
      'setCenterAndHalfExtents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 2, 'setCenterAndHalfExtents');
        final center = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'center', 'setCenterAndHalfExtents');
        final halfExtents = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'halfExtents', 'setCenterAndHalfExtents');
        t.setCenterAndHalfExtents(center, halfExtents);
        return null;
      },
      'copyCenterAndHalfExtents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 2, 'copyCenterAndHalfExtents');
        final center = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'center', 'copyCenterAndHalfExtents');
        final halfExtents = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'halfExtents', 'copyCenterAndHalfExtents');
        t.copyCenterAndHalfExtents(center, halfExtents);
        return null;
      },
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Aabb2>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 't', 'transform');
        t.transform(t_);
        return null;
      },
      'rotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'rotate');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 't', 'rotate');
        t.rotate(t_);
        return null;
      },
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 2, 'transformed');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 't', 'transformed');
        final out = D4.getRequiredArg<$vector_math_1.Aabb2>(positional, 1, 'out', 'transformed');
        return t.transformed(t_, out);
      },
      'rotated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 2, 'rotated');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 't', 'rotated');
        final out = D4.getRequiredArg<$vector_math_1.Aabb2>(positional, 1, 'out', 'rotated');
        return t.rotated(t_, out);
      },
      'hull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'hull');
        final other = D4.getRequiredArg<$vector_math_1.Aabb2>(positional, 0, 'other', 'hull');
        t.hull(other);
        return null;
      },
      'hullPoint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'hullPoint');
        final point = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'point', 'hullPoint');
        t.hullPoint(point);
        return null;
      },
      'containsAabb2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'containsAabb2');
        final other = D4.getRequiredArg<$vector_math_1.Aabb2>(positional, 0, 'other', 'containsAabb2');
        return t.containsAabb2(other);
      },
      'containsVector2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'containsVector2');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'containsVector2');
        return t.containsVector2(other);
      },
      'intersectsWithAabb2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'intersectsWithAabb2');
        final other = D4.getRequiredArg<$vector_math_1.Aabb2>(positional, 0, 'other', 'intersectsWithAabb2');
        return t.intersectsWithAabb2(other);
      },
      'intersectsWithVector2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb2>(target, 'Aabb2');
        D4.requireMinArgs(positional, 1, 'intersectsWithVector2');
        final other = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'other', 'intersectsWithVector2');
        return t.intersectsWithVector2(other);
      },
    },
    constructorSignatures: {
      '': 'Aabb2()',
      'copy': 'Aabb2.copy(Aabb2 other)',
      'minMax': 'Aabb2.minMax(Vector2 min, Vector2 max)',
      'centerAndHalfExtents': 'factory Aabb2.centerAndHalfExtents(Vector2 center, Vector2 halfExtents)',
      'fromBuffer': 'Aabb2.fromBuffer(ByteBuffer buffer, int offset)',
    },
    methodSignatures: {
      'setCenterAndHalfExtents': 'void setCenterAndHalfExtents(Vector2 center, Vector2 halfExtents)',
      'copyCenterAndHalfExtents': 'void copyCenterAndHalfExtents(Vector2 center, Vector2 halfExtents)',
      'copyFrom': 'void copyFrom(Aabb2 other)',
      'transform': 'void transform(Matrix3 t)',
      'rotate': 'void rotate(Matrix3 t)',
      'transformed': 'Aabb2 transformed(Matrix3 t, Aabb2 out)',
      'rotated': 'Aabb2 rotated(Matrix3 t, Aabb2 out)',
      'hull': 'void hull(Aabb2 other)',
      'hullPoint': 'void hullPoint(Vector2 point)',
      'containsAabb2': 'bool containsAabb2(Aabb2 other)',
      'containsVector2': 'bool containsVector2(Vector2 other)',
      'intersectsWithAabb2': 'bool intersectsWithAabb2(Aabb2 other)',
      'intersectsWithVector2': 'bool intersectsWithVector2(Vector2 other)',
    },
    getterSignatures: {
      'min': 'Vector2 get min',
      'max': 'Vector2 get max',
      'center': 'Vector2 get center',
    },
  );
}

// =============================================================================
// Aabb3 Bridge
// =============================================================================

BridgedClass _createAabb3Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Aabb3,
    name: 'Aabb3',
    isAssignable: (v) => v is $vector_math_1.Aabb3,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Aabb3();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Aabb3');
        final other = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 0, 'other', 'Aabb3');
        return $vector_math_1.Aabb3.copy(other);
      },
      'minMax': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Aabb3');
        final min = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'min', 'Aabb3');
        final max = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'max', 'Aabb3');
        return $vector_math_1.Aabb3.minMax(min, max);
      },
      'fromSphere': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Aabb3');
        final sphere = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'sphere', 'Aabb3');
        return $vector_math_1.Aabb3.fromSphere(sphere);
      },
      'fromTriangle': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Aabb3');
        final triangle = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'triangle', 'Aabb3');
        return $vector_math_1.Aabb3.fromTriangle(triangle);
      },
      'fromQuad': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Aabb3');
        final quad = D4.getRequiredArg<$vector_math_1.Quad>(positional, 0, 'quad', 'Aabb3');
        return $vector_math_1.Aabb3.fromQuad(quad);
      },
      'fromObb3': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Aabb3');
        final obb = D4.getRequiredArg<$vector_math_1.Obb3>(positional, 0, 'obb', 'Aabb3');
        return $vector_math_1.Aabb3.fromObb3(obb);
      },
      'fromRay': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Aabb3');
        final ray = D4.getRequiredArg<$vector_math_1.Ray>(positional, 0, 'ray', 'Aabb3');
        final limitMin = D4.getRequiredArg<double>(positional, 1, 'limitMin', 'Aabb3');
        final limitMax = D4.getRequiredArg<double>(positional, 2, 'limitMax', 'Aabb3');
        return $vector_math_1.Aabb3.fromRay(ray, limitMin, limitMax);
      },
      'centerAndHalfExtents': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Aabb3');
        final center = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'center', 'Aabb3');
        final halfExtents = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'halfExtents', 'Aabb3');
        return $vector_math_1.Aabb3.centerAndHalfExtents(center, halfExtents);
      },
      'fromBuffer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Aabb3');
        final buffer = D4.getRequiredArg<ByteBuffer>(positional, 0, 'buffer', 'Aabb3');
        final offset = D4.getRequiredArg<int>(positional, 1, 'offset', 'Aabb3');
        return $vector_math_1.Aabb3.fromBuffer(buffer, offset);
      },
    },
    getters: {
      'min': (visitor, target) => D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3').min,
      'max': (visitor, target) => D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3').max,
      'center': (visitor, target) => D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3').center,
    },
    methods: {
      'setCenterAndHalfExtents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 2, 'setCenterAndHalfExtents');
        final center = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'center', 'setCenterAndHalfExtents');
        final halfExtents = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'halfExtents', 'setCenterAndHalfExtents');
        t.setCenterAndHalfExtents(center, halfExtents);
        return null;
      },
      'setSphere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'setSphere');
        final sphere = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'sphere', 'setSphere');
        t.setSphere(sphere);
        return null;
      },
      'setTriangle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'setTriangle');
        final triangle = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'triangle', 'setTriangle');
        t.setTriangle(triangle);
        return null;
      },
      'setQuad': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'setQuad');
        final quad = D4.getRequiredArg<$vector_math_1.Quad>(positional, 0, 'quad', 'setQuad');
        t.setQuad(quad);
        return null;
      },
      'setObb3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'setObb3');
        final obb = D4.getRequiredArg<$vector_math_1.Obb3>(positional, 0, 'obb', 'setObb3');
        t.setObb3(obb);
        return null;
      },
      'setRay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 3, 'setRay');
        final ray = D4.getRequiredArg<$vector_math_1.Ray>(positional, 0, 'ray', 'setRay');
        final limitMin = D4.getRequiredArg<double>(positional, 1, 'limitMin', 'setRay');
        final limitMax = D4.getRequiredArg<double>(positional, 2, 'limitMax', 'setRay');
        t.setRay(ray, limitMin, limitMax);
        return null;
      },
      'copyCenterAndHalfExtents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 2, 'copyCenterAndHalfExtents');
        final center = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'center', 'copyCenterAndHalfExtents');
        final halfExtents = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'halfExtents', 'copyCenterAndHalfExtents');
        t.copyCenterAndHalfExtents(center, halfExtents);
        return null;
      },
      'copyCenter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'copyCenter');
        final center = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'center', 'copyCenter');
        t.copyCenter(center);
        return null;
      },
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 't', 'transform');
        t.transform(t_);
        return null;
      },
      'rotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'rotate');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 't', 'rotate');
        t.rotate(t_);
        return null;
      },
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 2, 'transformed');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 't', 'transformed');
        final out = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 1, 'out', 'transformed');
        return t.transformed(t_, out);
      },
      'rotated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 2, 'rotated');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 't', 'rotated');
        final out = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 1, 'out', 'rotated');
        return t.rotated(t_, out);
      },
      'getPN': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 3, 'getPN');
        final planeNormal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'planeNormal', 'getPN');
        final outP = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'outP', 'getPN');
        final outN = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'outN', 'getPN');
        t.getPN(planeNormal, outP, outN);
        return null;
      },
      'hull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'hull');
        final other = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 0, 'other', 'hull');
        t.hull(other);
        return null;
      },
      'hullPoint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'hullPoint');
        final point = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'point', 'hullPoint');
        t.hullPoint(point);
        return null;
      },
      'containsAabb3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'containsAabb3');
        final other = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 0, 'other', 'containsAabb3');
        return t.containsAabb3(other);
      },
      'containsSphere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'containsSphere');
        final other = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'other', 'containsSphere');
        return t.containsSphere(other);
      },
      'containsVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'containsVector3');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'containsVector3');
        return t.containsVector3(other);
      },
      'containsTriangle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'containsTriangle');
        final other = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'other', 'containsTriangle');
        return t.containsTriangle(other);
      },
      'intersectsWithAabb3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithAabb3');
        final other = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 0, 'other', 'intersectsWithAabb3');
        return t.intersectsWithAabb3(other);
      },
      'intersectsWithSphere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithSphere');
        final other = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'other', 'intersectsWithSphere');
        return t.intersectsWithSphere(other);
      },
      'intersectsWithVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithVector3');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'intersectsWithVector3');
        return t.intersectsWithVector3(other);
      },
      'intersectsWithTriangle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithTriangle');
        final other = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'other', 'intersectsWithTriangle');
        final epsilon = D4.getNamedArgWithDefault<double>(named, 'epsilon', 1e-3);
        final result = D4.getOptionalNamedArg<$vector_math_1.IntersectionResult?>(named, 'result');
        return t.intersectsWithTriangle(other, epsilon: epsilon, result: result);
      },
      'intersectsWithPlane': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithPlane');
        final other = D4.getRequiredArg<$vector_math_1.Plane>(positional, 0, 'other', 'intersectsWithPlane');
        final result = D4.getOptionalNamedArg<$vector_math_1.IntersectionResult?>(named, 'result');
        return t.intersectsWithPlane(other, result: result);
      },
      'intersectsWithQuad': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Aabb3>(target, 'Aabb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithQuad');
        final other = D4.getRequiredArg<$vector_math_1.Quad>(positional, 0, 'other', 'intersectsWithQuad');
        final result = D4.getOptionalNamedArg<$vector_math_1.IntersectionResult?>(named, 'result');
        return t.intersectsWithQuad(other, result: result);
      },
    },
    constructorSignatures: {
      '': 'Aabb3()',
      'copy': 'Aabb3.copy(Aabb3 other)',
      'minMax': 'Aabb3.minMax(Vector3 min, Vector3 max)',
      'fromSphere': 'factory Aabb3.fromSphere(Sphere sphere)',
      'fromTriangle': 'factory Aabb3.fromTriangle(Triangle triangle)',
      'fromQuad': 'factory Aabb3.fromQuad(Quad quad)',
      'fromObb3': 'factory Aabb3.fromObb3(Obb3 obb)',
      'fromRay': 'factory Aabb3.fromRay(Ray ray, double limitMin, double limitMax)',
      'centerAndHalfExtents': 'factory Aabb3.centerAndHalfExtents(Vector3 center, Vector3 halfExtents)',
      'fromBuffer': 'Aabb3.fromBuffer(ByteBuffer buffer, int offset)',
    },
    methodSignatures: {
      'setCenterAndHalfExtents': 'void setCenterAndHalfExtents(Vector3 center, Vector3 halfExtents)',
      'setSphere': 'void setSphere(Sphere sphere)',
      'setTriangle': 'void setTriangle(Triangle triangle)',
      'setQuad': 'void setQuad(Quad quad)',
      'setObb3': 'void setObb3(Obb3 obb)',
      'setRay': 'void setRay(Ray ray, double limitMin, double limitMax)',
      'copyCenterAndHalfExtents': 'void copyCenterAndHalfExtents(Vector3 center, Vector3 halfExtents)',
      'copyCenter': 'void copyCenter(Vector3 center)',
      'copyFrom': 'void copyFrom(Aabb3 other)',
      'transform': 'void transform(Matrix4 t)',
      'rotate': 'void rotate(Matrix4 t)',
      'transformed': 'Aabb3 transformed(Matrix4 t, Aabb3 out)',
      'rotated': 'Aabb3 rotated(Matrix4 t, Aabb3 out)',
      'getPN': 'void getPN(Vector3 planeNormal, Vector3 outP, Vector3 outN)',
      'hull': 'void hull(Aabb3 other)',
      'hullPoint': 'void hullPoint(Vector3 point)',
      'containsAabb3': 'bool containsAabb3(Aabb3 other)',
      'containsSphere': 'bool containsSphere(Sphere other)',
      'containsVector3': 'bool containsVector3(Vector3 other)',
      'containsTriangle': 'bool containsTriangle(Triangle other)',
      'intersectsWithAabb3': 'bool intersectsWithAabb3(Aabb3 other)',
      'intersectsWithSphere': 'bool intersectsWithSphere(Sphere other)',
      'intersectsWithVector3': 'bool intersectsWithVector3(Vector3 other)',
      'intersectsWithTriangle': 'bool intersectsWithTriangle(Triangle other, {double epsilon = 1e-3, IntersectionResult? result})',
      'intersectsWithPlane': 'bool intersectsWithPlane(Plane other, {IntersectionResult? result})',
      'intersectsWithQuad': 'bool intersectsWithQuad(Quad other, {IntersectionResult? result})',
    },
    getterSignatures: {
      'min': 'Vector3 get min',
      'max': 'Vector3 get max',
      'center': 'Vector3 get center',
    },
  );
}

// =============================================================================
// Colors Bridge
// =============================================================================

BridgedClass _createColorsBridge() {
  return BridgedClass(
    nativeType: Colors,
    name: 'Colors',
    isAssignable: (v) => v is Colors,
    constructors: {
    },
    staticGetters: {
      'transparent': (visitor) => Colors.transparent,
      'aliceBlue': (visitor) => Colors.aliceBlue,
      'antiqueWhite': (visitor) => Colors.antiqueWhite,
      'aqua': (visitor) => Colors.aqua,
      'aquamarine': (visitor) => Colors.aquamarine,
      'azure': (visitor) => Colors.azure,
      'beige': (visitor) => Colors.beige,
      'bisque': (visitor) => Colors.bisque,
      'black': (visitor) => Colors.black,
      'blanchedAlmond': (visitor) => Colors.blanchedAlmond,
      'blue': (visitor) => Colors.blue,
      'blueViolet': (visitor) => Colors.blueViolet,
      'brown': (visitor) => Colors.brown,
      'burlyWood': (visitor) => Colors.burlyWood,
      'cadetBlue': (visitor) => Colors.cadetBlue,
      'chartreuse': (visitor) => Colors.chartreuse,
      'chocolate': (visitor) => Colors.chocolate,
      'coral': (visitor) => Colors.coral,
      'cornflowerBlue': (visitor) => Colors.cornflowerBlue,
      'cornsilk': (visitor) => Colors.cornsilk,
      'crimson': (visitor) => Colors.crimson,
      'cyan': (visitor) => Colors.cyan,
      'darkBlue': (visitor) => Colors.darkBlue,
      'darkCyan': (visitor) => Colors.darkCyan,
      'darkGoldenrod': (visitor) => Colors.darkGoldenrod,
      'darkGray': (visitor) => Colors.darkGray,
      'darkGreen': (visitor) => Colors.darkGreen,
      'darkKhaki': (visitor) => Colors.darkKhaki,
      'darkMagenta': (visitor) => Colors.darkMagenta,
      'darkOliveGreen': (visitor) => Colors.darkOliveGreen,
      'darkOrange': (visitor) => Colors.darkOrange,
      'darkOrchid': (visitor) => Colors.darkOrchid,
      'darkRed': (visitor) => Colors.darkRed,
      'darkSalmon': (visitor) => Colors.darkSalmon,
      'darkSeaGreen': (visitor) => Colors.darkSeaGreen,
      'darkSlateBlue': (visitor) => Colors.darkSlateBlue,
      'darkSlateGray': (visitor) => Colors.darkSlateGray,
      'darkTurquoise': (visitor) => Colors.darkTurquoise,
      'darkViolet': (visitor) => Colors.darkViolet,
      'deepPink': (visitor) => Colors.deepPink,
      'deepSkyBlue': (visitor) => Colors.deepSkyBlue,
      'dimGray': (visitor) => Colors.dimGray,
      'dodgerBlue': (visitor) => Colors.dodgerBlue,
      'firebrick': (visitor) => Colors.firebrick,
      'floralWhite': (visitor) => Colors.floralWhite,
      'forestGreen': (visitor) => Colors.forestGreen,
      'fuchsia': (visitor) => Colors.fuchsia,
      'gainsboro': (visitor) => Colors.gainsboro,
      'ghostWhite': (visitor) => Colors.ghostWhite,
      'gold': (visitor) => Colors.gold,
      'goldenrod': (visitor) => Colors.goldenrod,
      'gray': (visitor) => Colors.gray,
      'green': (visitor) => Colors.green,
      'greenYellow': (visitor) => Colors.greenYellow,
      'honeydew': (visitor) => Colors.honeydew,
      'hotPink': (visitor) => Colors.hotPink,
      'indianRed': (visitor) => Colors.indianRed,
      'indigo': (visitor) => Colors.indigo,
      'ivory': (visitor) => Colors.ivory,
      'khaki': (visitor) => Colors.khaki,
      'lavender': (visitor) => Colors.lavender,
      'lavenderBlush': (visitor) => Colors.lavenderBlush,
      'lawnGreen': (visitor) => Colors.lawnGreen,
      'lemonChiffon': (visitor) => Colors.lemonChiffon,
      'lightBlue': (visitor) => Colors.lightBlue,
      'lightCoral': (visitor) => Colors.lightCoral,
      'lightCyan': (visitor) => Colors.lightCyan,
      'lightGoldenrodYellow': (visitor) => Colors.lightGoldenrodYellow,
      'lightGreen': (visitor) => Colors.lightGreen,
      'lightGray': (visitor) => Colors.lightGray,
      'lightPink': (visitor) => Colors.lightPink,
      'lightSalmon': (visitor) => Colors.lightSalmon,
      'lightSeaGreen': (visitor) => Colors.lightSeaGreen,
      'lightSkyBlue': (visitor) => Colors.lightSkyBlue,
      'lightSlateGray': (visitor) => Colors.lightSlateGray,
      'lightSteelBlue': (visitor) => Colors.lightSteelBlue,
      'lightYellow': (visitor) => Colors.lightYellow,
      'lime': (visitor) => Colors.lime,
      'limeGreen': (visitor) => Colors.limeGreen,
      'linen': (visitor) => Colors.linen,
      'magenta': (visitor) => Colors.magenta,
      'maroon': (visitor) => Colors.maroon,
      'mediumAquamarine': (visitor) => Colors.mediumAquamarine,
      'mediumBlue': (visitor) => Colors.mediumBlue,
      'mediumOrchid': (visitor) => Colors.mediumOrchid,
      'mediumPurple': (visitor) => Colors.mediumPurple,
      'mediumSeaGreen': (visitor) => Colors.mediumSeaGreen,
      'mediumSlateBlue': (visitor) => Colors.mediumSlateBlue,
      'mediumSpringGreen': (visitor) => Colors.mediumSpringGreen,
      'mediumTurquoise': (visitor) => Colors.mediumTurquoise,
      'mediumVioletRed': (visitor) => Colors.mediumVioletRed,
      'midnightBlue': (visitor) => Colors.midnightBlue,
      'mintCream': (visitor) => Colors.mintCream,
      'mistyRose': (visitor) => Colors.mistyRose,
      'moccasin': (visitor) => Colors.moccasin,
      'navajoWhite': (visitor) => Colors.navajoWhite,
      'navy': (visitor) => Colors.navy,
      'oldLace': (visitor) => Colors.oldLace,
      'olive': (visitor) => Colors.olive,
      'oliveDrab': (visitor) => Colors.oliveDrab,
      'orange': (visitor) => Colors.orange,
      'orangeRed': (visitor) => Colors.orangeRed,
      'orchid': (visitor) => Colors.orchid,
      'paleGoldenrod': (visitor) => Colors.paleGoldenrod,
      'paleGreen': (visitor) => Colors.paleGreen,
      'paleTurquoise': (visitor) => Colors.paleTurquoise,
      'paleVioletRed': (visitor) => Colors.paleVioletRed,
      'papayaWhip': (visitor) => Colors.papayaWhip,
      'peachPuff': (visitor) => Colors.peachPuff,
      'peru': (visitor) => Colors.peru,
      'pink': (visitor) => Colors.pink,
      'plum': (visitor) => Colors.plum,
      'powderBlue': (visitor) => Colors.powderBlue,
      'purple': (visitor) => Colors.purple,
      'red': (visitor) => Colors.red,
      'rosyBrown': (visitor) => Colors.rosyBrown,
      'royalBlue': (visitor) => Colors.royalBlue,
      'saddleBrown': (visitor) => Colors.saddleBrown,
      'salmon': (visitor) => Colors.salmon,
      'sandyBrown': (visitor) => Colors.sandyBrown,
      'seaGreen': (visitor) => Colors.seaGreen,
      'seaShell': (visitor) => Colors.seaShell,
      'sienna': (visitor) => Colors.sienna,
      'silver': (visitor) => Colors.silver,
      'skyBlue': (visitor) => Colors.skyBlue,
      'slateBlue': (visitor) => Colors.slateBlue,
      'slateGray': (visitor) => Colors.slateGray,
      'snow': (visitor) => Colors.snow,
      'springGreen': (visitor) => Colors.springGreen,
      'steelBlue': (visitor) => Colors.steelBlue,
      'tan': (visitor) => Colors.tan,
      'teal': (visitor) => Colors.teal,
      'thistle': (visitor) => Colors.thistle,
      'tomato': (visitor) => Colors.tomato,
      'turquoise': (visitor) => Colors.turquoise,
      'violet': (visitor) => Colors.violet,
      'wheat': (visitor) => Colors.wheat,
      'white': (visitor) => Colors.white,
      'whiteSmoke': (visitor) => Colors.whiteSmoke,
      'yellow': (visitor) => Colors.yellow,
      'yellowGreen': (visitor) => Colors.yellowGreen,
    },
    staticMethods: {
      'fromRgba': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 5, 'fromRgba');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'fromRgba');
        final g = D4.getRequiredArg<int>(positional, 1, 'g', 'fromRgba');
        final b = D4.getRequiredArg<int>(positional, 2, 'b', 'fromRgba');
        final a = D4.getRequiredArg<int>(positional, 3, 'a', 'fromRgba');
        final result = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 4, 'result', 'fromRgba');
        return Colors.fromRgba(r, g, b, a, result);
      },
      'fromHexString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'fromHexString');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'fromHexString');
        final result = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'result', 'fromHexString');
        return Colors.fromHexString(value, result);
      },
      'toHexString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'toHexString');
        final input = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'input', 'toHexString');
        final alpha = D4.getNamedArgWithDefault<bool>(named, 'alpha', false);
        final short = D4.getNamedArgWithDefault<bool>(named, 'short', false);
        return Colors.toHexString(input, alpha: alpha, short: short);
      },
      'alphaBlend': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'alphaBlend');
        final foreground = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'foreground', 'alphaBlend');
        final background = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'background', 'alphaBlend');
        final result = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 2, 'result', 'alphaBlend');
        return Colors.alphaBlend(foreground, background, result);
      },
      'toGrayscale': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'toGrayscale');
        final input = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'input', 'toGrayscale');
        final result = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'result', 'toGrayscale');
        return Colors.toGrayscale(input, result);
      },
      'linearToGamma': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'linearToGamma');
        final linearColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'linearColor', 'linearToGamma');
        final gammaColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'gammaColor', 'linearToGamma');
        final gamma = D4.getOptionalArgWithDefault<double>(positional, 2, 'gamma', 2.2);
        return Colors.linearToGamma(linearColor, gammaColor, gamma);
      },
      'gammaToLinear': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'gammaToLinear');
        final gammaColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'gammaColor', 'gammaToLinear');
        final linearColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'linearColor', 'gammaToLinear');
        final gamma = D4.getOptionalArgWithDefault<double>(positional, 2, 'gamma', 2.2);
        return Colors.gammaToLinear(gammaColor, linearColor, gamma);
      },
      'rgbToHsv': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'rgbToHsv');
        final rgbColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'rgbColor', 'rgbToHsv');
        final hsvColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'hsvColor', 'rgbToHsv');
        return Colors.rgbToHsv(rgbColor, hsvColor);
      },
      'hsvToRgb': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'hsvToRgb');
        final hsvColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'hsvColor', 'hsvToRgb');
        final rgbColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'rgbColor', 'hsvToRgb');
        return Colors.hsvToRgb(hsvColor, rgbColor);
      },
      'rgbToHsl': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'rgbToHsl');
        final rgbColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'rgbColor', 'rgbToHsl');
        final hslColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'hslColor', 'rgbToHsl');
        return Colors.rgbToHsl(rgbColor, hslColor);
      },
      'hslToRgb': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'hslToRgb');
        final hslColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'hslColor', 'hslToRgb');
        final rgbColor = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'rgbColor', 'hslToRgb');
        return Colors.hslToRgb(hslColor, rgbColor);
      },
    },
    staticMethodSignatures: {
      'fromRgba': 'void fromRgba(int r, int g, int b, int a, Vector4 result)',
      'fromHexString': 'void fromHexString(String value, Vector4 result)',
      'toHexString': 'String toHexString(Vector4 input, {bool alpha = false, bool short = false})',
      'alphaBlend': 'void alphaBlend(Vector4 foreground, Vector4 background, Vector4 result)',
      'toGrayscale': 'void toGrayscale(Vector4 input, Vector4 result)',
      'linearToGamma': 'void linearToGamma(Vector4 linearColor, Vector4 gammaColor, [double gamma = 2.2])',
      'gammaToLinear': 'void gammaToLinear(Vector4 gammaColor, Vector4 linearColor, [double gamma = 2.2])',
      'rgbToHsv': 'void rgbToHsv(Vector4 rgbColor, Vector4 hsvColor)',
      'hsvToRgb': 'void hsvToRgb(Vector4 hsvColor, Vector4 rgbColor)',
      'rgbToHsl': 'void rgbToHsl(Vector4 rgbColor, Vector4 hslColor)',
      'hslToRgb': 'void hslToRgb(Vector4 hslColor, Vector4 rgbColor)',
    },
    staticGetterSignatures: {
      'transparent': 'Vector4 get transparent',
      'aliceBlue': 'Vector4 get aliceBlue',
      'antiqueWhite': 'Vector4 get antiqueWhite',
      'aqua': 'Vector4 get aqua',
      'aquamarine': 'Vector4 get aquamarine',
      'azure': 'Vector4 get azure',
      'beige': 'Vector4 get beige',
      'bisque': 'Vector4 get bisque',
      'black': 'Vector4 get black',
      'blanchedAlmond': 'Vector4 get blanchedAlmond',
      'blue': 'Vector4 get blue',
      'blueViolet': 'Vector4 get blueViolet',
      'brown': 'Vector4 get brown',
      'burlyWood': 'Vector4 get burlyWood',
      'cadetBlue': 'Vector4 get cadetBlue',
      'chartreuse': 'Vector4 get chartreuse',
      'chocolate': 'Vector4 get chocolate',
      'coral': 'Vector4 get coral',
      'cornflowerBlue': 'Vector4 get cornflowerBlue',
      'cornsilk': 'Vector4 get cornsilk',
      'crimson': 'Vector4 get crimson',
      'cyan': 'Vector4 get cyan',
      'darkBlue': 'Vector4 get darkBlue',
      'darkCyan': 'Vector4 get darkCyan',
      'darkGoldenrod': 'Vector4 get darkGoldenrod',
      'darkGray': 'Vector4 get darkGray',
      'darkGreen': 'Vector4 get darkGreen',
      'darkKhaki': 'Vector4 get darkKhaki',
      'darkMagenta': 'Vector4 get darkMagenta',
      'darkOliveGreen': 'Vector4 get darkOliveGreen',
      'darkOrange': 'Vector4 get darkOrange',
      'darkOrchid': 'Vector4 get darkOrchid',
      'darkRed': 'Vector4 get darkRed',
      'darkSalmon': 'Vector4 get darkSalmon',
      'darkSeaGreen': 'Vector4 get darkSeaGreen',
      'darkSlateBlue': 'Vector4 get darkSlateBlue',
      'darkSlateGray': 'Vector4 get darkSlateGray',
      'darkTurquoise': 'Vector4 get darkTurquoise',
      'darkViolet': 'Vector4 get darkViolet',
      'deepPink': 'Vector4 get deepPink',
      'deepSkyBlue': 'Vector4 get deepSkyBlue',
      'dimGray': 'Vector4 get dimGray',
      'dodgerBlue': 'Vector4 get dodgerBlue',
      'firebrick': 'Vector4 get firebrick',
      'floralWhite': 'Vector4 get floralWhite',
      'forestGreen': 'Vector4 get forestGreen',
      'fuchsia': 'Vector4 get fuchsia',
      'gainsboro': 'Vector4 get gainsboro',
      'ghostWhite': 'Vector4 get ghostWhite',
      'gold': 'Vector4 get gold',
      'goldenrod': 'Vector4 get goldenrod',
      'gray': 'Vector4 get gray',
      'green': 'Vector4 get green',
      'greenYellow': 'Vector4 get greenYellow',
      'honeydew': 'Vector4 get honeydew',
      'hotPink': 'Vector4 get hotPink',
      'indianRed': 'Vector4 get indianRed',
      'indigo': 'Vector4 get indigo',
      'ivory': 'Vector4 get ivory',
      'khaki': 'Vector4 get khaki',
      'lavender': 'Vector4 get lavender',
      'lavenderBlush': 'Vector4 get lavenderBlush',
      'lawnGreen': 'Vector4 get lawnGreen',
      'lemonChiffon': 'Vector4 get lemonChiffon',
      'lightBlue': 'Vector4 get lightBlue',
      'lightCoral': 'Vector4 get lightCoral',
      'lightCyan': 'Vector4 get lightCyan',
      'lightGoldenrodYellow': 'Vector4 get lightGoldenrodYellow',
      'lightGreen': 'Vector4 get lightGreen',
      'lightGray': 'Vector4 get lightGray',
      'lightPink': 'Vector4 get lightPink',
      'lightSalmon': 'Vector4 get lightSalmon',
      'lightSeaGreen': 'Vector4 get lightSeaGreen',
      'lightSkyBlue': 'Vector4 get lightSkyBlue',
      'lightSlateGray': 'Vector4 get lightSlateGray',
      'lightSteelBlue': 'Vector4 get lightSteelBlue',
      'lightYellow': 'Vector4 get lightYellow',
      'lime': 'Vector4 get lime',
      'limeGreen': 'Vector4 get limeGreen',
      'linen': 'Vector4 get linen',
      'magenta': 'Vector4 get magenta',
      'maroon': 'Vector4 get maroon',
      'mediumAquamarine': 'Vector4 get mediumAquamarine',
      'mediumBlue': 'Vector4 get mediumBlue',
      'mediumOrchid': 'Vector4 get mediumOrchid',
      'mediumPurple': 'Vector4 get mediumPurple',
      'mediumSeaGreen': 'Vector4 get mediumSeaGreen',
      'mediumSlateBlue': 'Vector4 get mediumSlateBlue',
      'mediumSpringGreen': 'Vector4 get mediumSpringGreen',
      'mediumTurquoise': 'Vector4 get mediumTurquoise',
      'mediumVioletRed': 'Vector4 get mediumVioletRed',
      'midnightBlue': 'Vector4 get midnightBlue',
      'mintCream': 'Vector4 get mintCream',
      'mistyRose': 'Vector4 get mistyRose',
      'moccasin': 'Vector4 get moccasin',
      'navajoWhite': 'Vector4 get navajoWhite',
      'navy': 'Vector4 get navy',
      'oldLace': 'Vector4 get oldLace',
      'olive': 'Vector4 get olive',
      'oliveDrab': 'Vector4 get oliveDrab',
      'orange': 'Vector4 get orange',
      'orangeRed': 'Vector4 get orangeRed',
      'orchid': 'Vector4 get orchid',
      'paleGoldenrod': 'Vector4 get paleGoldenrod',
      'paleGreen': 'Vector4 get paleGreen',
      'paleTurquoise': 'Vector4 get paleTurquoise',
      'paleVioletRed': 'Vector4 get paleVioletRed',
      'papayaWhip': 'Vector4 get papayaWhip',
      'peachPuff': 'Vector4 get peachPuff',
      'peru': 'Vector4 get peru',
      'pink': 'Vector4 get pink',
      'plum': 'Vector4 get plum',
      'powderBlue': 'Vector4 get powderBlue',
      'purple': 'Vector4 get purple',
      'red': 'Vector4 get red',
      'rosyBrown': 'Vector4 get rosyBrown',
      'royalBlue': 'Vector4 get royalBlue',
      'saddleBrown': 'Vector4 get saddleBrown',
      'salmon': 'Vector4 get salmon',
      'sandyBrown': 'Vector4 get sandyBrown',
      'seaGreen': 'Vector4 get seaGreen',
      'seaShell': 'Vector4 get seaShell',
      'sienna': 'Vector4 get sienna',
      'silver': 'Vector4 get silver',
      'skyBlue': 'Vector4 get skyBlue',
      'slateBlue': 'Vector4 get slateBlue',
      'slateGray': 'Vector4 get slateGray',
      'snow': 'Vector4 get snow',
      'springGreen': 'Vector4 get springGreen',
      'steelBlue': 'Vector4 get steelBlue',
      'tan': 'Vector4 get tan',
      'teal': 'Vector4 get teal',
      'thistle': 'Vector4 get thistle',
      'tomato': 'Vector4 get tomato',
      'turquoise': 'Vector4 get turquoise',
      'violet': 'Vector4 get violet',
      'wheat': 'Vector4 get wheat',
      'white': 'Vector4 get white',
      'whiteSmoke': 'Vector4 get whiteSmoke',
      'yellow': 'Vector4 get yellow',
      'yellowGreen': 'Vector4 get yellowGreen',
    },
  );
}

// =============================================================================
// Frustum Bridge
// =============================================================================

BridgedClass _createFrustumBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Frustum,
    name: 'Frustum',
    isAssignable: (v) => v is $vector_math_1.Frustum,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Frustum();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Frustum');
        final other = D4.getRequiredArg<$vector_math_1.Frustum>(positional, 0, 'other', 'Frustum');
        return $vector_math_1.Frustum.copy(other);
      },
      'matrix': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Frustum');
        final matrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'matrix', 'Frustum');
        return $vector_math_1.Frustum.matrix(matrix);
      },
    },
    getters: {
      'plane0': (visitor, target) => D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum').plane0,
      'plane1': (visitor, target) => D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum').plane1,
      'plane2': (visitor, target) => D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum').plane2,
      'plane3': (visitor, target) => D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum').plane3,
      'plane4': (visitor, target) => D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum').plane4,
      'plane5': (visitor, target) => D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum').plane5,
    },
    methods: {
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Frustum>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'setFromMatrix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum');
        D4.requireMinArgs(positional, 1, 'setFromMatrix');
        final matrix = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'matrix', 'setFromMatrix');
        t.setFromMatrix(matrix);
        return null;
      },
      'containsVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum');
        D4.requireMinArgs(positional, 1, 'containsVector3');
        final point = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'point', 'containsVector3');
        return t.containsVector3(point);
      },
      'intersectsWithAabb3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum');
        D4.requireMinArgs(positional, 1, 'intersectsWithAabb3');
        final aabb = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 0, 'aabb', 'intersectsWithAabb3');
        return t.intersectsWithAabb3(aabb);
      },
      'intersectsWithSphere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum');
        D4.requireMinArgs(positional, 1, 'intersectsWithSphere');
        final sphere = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'sphere', 'intersectsWithSphere');
        return t.intersectsWithSphere(sphere);
      },
      'calculateCorners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Frustum>(target, 'Frustum');
        D4.requireMinArgs(positional, 8, 'calculateCorners');
        final corner0 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'corner0', 'calculateCorners');
        final corner1 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'corner1', 'calculateCorners');
        final corner2 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'corner2', 'calculateCorners');
        final corner3 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 3, 'corner3', 'calculateCorners');
        final corner4 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 4, 'corner4', 'calculateCorners');
        final corner5 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 5, 'corner5', 'calculateCorners');
        final corner6 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 6, 'corner6', 'calculateCorners');
        final corner7 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 7, 'corner7', 'calculateCorners');
        t.calculateCorners(corner0, corner1, corner2, corner3, corner4, corner5, corner6, corner7);
        return null;
      },
    },
    constructorSignatures: {
      '': 'Frustum()',
      'copy': 'factory Frustum.copy(Frustum other)',
      'matrix': 'factory Frustum.matrix(Matrix4 matrix)',
    },
    methodSignatures: {
      'copyFrom': 'void copyFrom(Frustum other)',
      'setFromMatrix': 'void setFromMatrix(Matrix4 matrix)',
      'containsVector3': 'bool containsVector3(Vector3 point)',
      'intersectsWithAabb3': 'bool intersectsWithAabb3(Aabb3 aabb)',
      'intersectsWithSphere': 'bool intersectsWithSphere(Sphere sphere)',
      'calculateCorners': 'void calculateCorners(Vector3 corner0, Vector3 corner1, Vector3 corner2, Vector3 corner3, Vector3 corner4, Vector3 corner5, Vector3 corner6, Vector3 corner7)',
    },
    getterSignatures: {
      'plane0': 'Plane get plane0',
      'plane1': 'Plane get plane1',
      'plane2': 'Plane get plane2',
      'plane3': 'Plane get plane3',
      'plane4': 'Plane get plane4',
      'plane5': 'Plane get plane5',
    },
  );
}

// =============================================================================
// IntersectionResult Bridge
// =============================================================================

BridgedClass _createIntersectionResultBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.IntersectionResult,
    name: 'IntersectionResult',
    isAssignable: (v) => v is $vector_math_1.IntersectionResult,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.IntersectionResult();
      },
    },
    getters: {
      'depth': (visitor, target) => D4.validateTarget<$vector_math_1.IntersectionResult>(target, 'IntersectionResult').depth,
      'axis': (visitor, target) => D4.validateTarget<$vector_math_1.IntersectionResult>(target, 'IntersectionResult').axis,
    },
    constructorSignatures: {
      '': 'IntersectionResult()',
    },
    getterSignatures: {
      'depth': 'double? get depth',
      'axis': 'dynamic get axis',
    },
  );
}

// =============================================================================
// Matrix2 Bridge
// =============================================================================

BridgedClass _createMatrix2Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Matrix2,
    name: 'Matrix2',
    isAssignable: (v) => v is $vector_math_1.Matrix2,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Matrix2');
        final arg0 = D4.getRequiredArg<double>(positional, 0, 'arg0', 'Matrix2');
        final arg1 = D4.getRequiredArg<double>(positional, 1, 'arg1', 'Matrix2');
        final arg2 = D4.getRequiredArg<double>(positional, 2, 'arg2', 'Matrix2');
        final arg3 = D4.getRequiredArg<double>(positional, 3, 'arg3', 'Matrix2');
        return $vector_math_1.Matrix2(arg0, arg1, arg2, arg3);
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix2');
        if (positional.isEmpty) {
          throw ArgumentError('Matrix2: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<double>(positional[0], 'values');
        return $vector_math_1.Matrix2.fromList(values);
      },
      'zero': (visitor, positional, named) {
        return $vector_math_1.Matrix2.zero();
      },
      'identity': (visitor, positional, named) {
        return $vector_math_1.Matrix2.identity();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix2');
        final other = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'other', 'Matrix2');
        return $vector_math_1.Matrix2.copy(other);
      },
      'columns': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix2');
        final arg0 = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg0', 'Matrix2');
        final arg1 = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'arg1', 'Matrix2');
        return $vector_math_1.Matrix2.columns(arg0, arg1);
      },
      'outer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix2');
        final u = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'u', 'Matrix2');
        final v = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'v', 'Matrix2');
        return $vector_math_1.Matrix2.outer(u, v);
      },
      'rotation': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix2');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'Matrix2');
        return $vector_math_1.Matrix2.rotation(radians);
      },
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2').storage,
      'dimension': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2').dimension,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2').hashCode,
      'row0': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2').row0,
      'row1': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2').row1,
    },
    setters: {
      'row0': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2').row0 = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'row0'),
      'row1': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2').row1 = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'row1'),
    },
    methods: {
      'index': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'index');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'index');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'index');
        return t.index(row, col);
      },
      'entry': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'entry');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'entry');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'entry');
        return t.entry(row, col);
      },
      'setEntry': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 3, 'setEntry');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'setEntry');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'setEntry');
        final v = D4.getRequiredArg<double>(positional, 2, 'v', 'setEntry');
        t.setEntry(row, col, v);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 4, 'setValues');
        final arg0 = D4.getRequiredArg<double>(positional, 0, 'arg0', 'setValues');
        final arg1 = D4.getRequiredArg<double>(positional, 1, 'arg1', 'setValues');
        final arg2 = D4.getRequiredArg<double>(positional, 2, 'arg2', 'setValues');
        final arg3 = D4.getRequiredArg<double>(positional, 3, 'arg3', 'setValues');
        t.setValues(arg0, arg1, arg2, arg3);
        return null;
      },
      'setColumns': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'setColumns');
        final arg0 = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg0', 'setColumns');
        final arg1 = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'arg1', 'setColumns');
        t.setColumns(arg0, arg1);
        return null;
      },
      'setFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'setFrom');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'setFrom');
        t.setFrom(arg);
        return null;
      },
      'setOuter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'setOuter');
        final u = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'u', 'setOuter');
        final v = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'v', 'setOuter');
        t.setOuter(u, v);
        return null;
      },
      'splatDiagonal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'splatDiagonal');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'splatDiagonal');
        t.splatDiagonal(arg);
        return null;
      },
      'setDiagonal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'setDiagonal');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'setDiagonal');
        t.setDiagonal(arg);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.toString();
      },
      'setRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'setRow');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'setRow');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'arg', 'setRow');
        t.setRow(row, arg);
        return null;
      },
      'getRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'getRow');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'getRow');
        return t.getRow(row);
      },
      'setColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'setColumn');
        final column = D4.getRequiredArg<int>(positional, 0, 'column', 'setColumn');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'arg', 'setColumn');
        t.setColumn(column, arg);
        return null;
      },
      'getColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'getColumn');
        final column = D4.getRequiredArg<int>(positional, 0, 'column', 'getColumn');
        return t.getColumn(column);
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.clone();
      },
      'copyInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'copyInto');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'copyInto');
        return t.copyInto(arg);
      },
      'setZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        t.setZero();
        return null;
      },
      'setIdentity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        t.setIdentity();
        return null;
      },
      'transposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.transposed();
      },
      'transpose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        t.transpose();
        return null;
      },
      'absolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.absolute();
      },
      'determinant': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.determinant();
      },
      'dotRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'dotRow');
        final i = D4.getRequiredArg<int>(positional, 0, 'i', 'dotRow');
        final v = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'v', 'dotRow');
        return t.dotRow(i, v);
      },
      'dotColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 2, 'dotColumn');
        final j = D4.getRequiredArg<int>(positional, 0, 'j', 'dotColumn');
        final v = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'v', 'dotColumn');
        return t.dotColumn(j, v);
      },
      'trace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.trace();
      },
      'infinityNorm': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.infinityNorm();
      },
      'relativeError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'relativeError');
        final correct = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'correct', 'relativeError');
        return t.relativeError(correct);
      },
      'absoluteError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'absoluteError');
        final correct = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'correct', 'absoluteError');
        return t.absoluteError(correct);
      },
      'invert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        return t.invert();
      },
      'copyInverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'copyInverse');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'copyInverse');
        return t.copyInverse(arg);
      },
      'setRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'setRotation');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'setRotation');
        t.setRotation(radians);
        return null;
      },
      'scaleAdjoint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'scaleAdjoint');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scaleAdjoint');
        t.scaleAdjoint(scale);
        return null;
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'scale');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scale');
        t.scale(scale);
        return null;
      },
      'scaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'scaled');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scaled');
        return t.scaled(scale);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'add');
        final o = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'o', 'add');
        t.add(o);
        return null;
      },
      'sub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'sub');
        final o = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'o', 'sub');
        t.sub(o);
        return null;
      },
      'negate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        t.negate();
        return null;
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'multiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'multiply');
        t.multiply(arg);
        return null;
      },
      'multiplied': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'multiplied');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'multiplied');
        return t.multiplied(arg);
      },
      'transposeMultiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'transposeMultiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'transposeMultiply');
        t.transposeMultiply(arg);
        return null;
      },
      'multiplyTranspose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'multiplyTranspose');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'multiplyTranspose');
        t.multiplyTranspose(arg);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'transform');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'transform');
        return t.transform(arg);
      },
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'transformed');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'transformed');
        final out = D4.getOptionalArg<$vector_math_1.Vector2?>(positional, 1, 'out');
        return t.transformed(arg, out);
      },
      'copyIntoArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
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
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        D4.requireMinArgs(positional, 1, 'copyFromArray');
        if (positional.isEmpty) {
          throw ArgumentError('copyFromArray: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        t.copyFromArray(array, offset);
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        final other = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix2>(target, 'Matrix2');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
    },
    staticMethods: {
      'solve': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'solve');
        final A = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'A', 'solve');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'x', 'solve');
        final b = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'b', 'solve');
        return $vector_math_1.Matrix2.solve(A, x, b);
      },
    },
    constructorSignatures: {
      '': 'factory Matrix2(double arg0, double arg1, double arg2, double arg3)',
      'fromList': 'factory Matrix2.fromList(List<double> values)',
      'zero': 'Matrix2.zero()',
      'identity': 'factory Matrix2.identity()',
      'copy': 'factory Matrix2.copy(Matrix2 other)',
      'columns': 'factory Matrix2.columns(Vector2 arg0, Vector2 arg1)',
      'outer': 'factory Matrix2.outer(Vector2 u, Vector2 v)',
      'rotation': 'factory Matrix2.rotation(double radians)',
    },
    methodSignatures: {
      'index': 'int index(int row, int col)',
      'entry': 'double entry(int row, int col)',
      'setEntry': 'void setEntry(int row, int col, double v)',
      'setValues': 'void setValues(double arg0, double arg1, double arg2, double arg3)',
      'setColumns': 'void setColumns(Vector2 arg0, Vector2 arg1)',
      'setFrom': 'void setFrom(Matrix2 arg)',
      'setOuter': 'void setOuter(Vector2 u, Vector2 v)',
      'splatDiagonal': 'void splatDiagonal(double arg)',
      'setDiagonal': 'void setDiagonal(Vector2 arg)',
      'toString': 'String toString()',
      'setRow': 'void setRow(int row, Vector2 arg)',
      'getRow': 'Vector2 getRow(int row)',
      'setColumn': 'void setColumn(int column, Vector2 arg)',
      'getColumn': 'Vector2 getColumn(int column)',
      'clone': 'Matrix2 clone()',
      'copyInto': 'Matrix2 copyInto(Matrix2 arg)',
      'setZero': 'void setZero()',
      'setIdentity': 'void setIdentity()',
      'transposed': 'Matrix2 transposed()',
      'transpose': 'void transpose()',
      'absolute': 'Matrix2 absolute()',
      'determinant': 'double determinant()',
      'dotRow': 'double dotRow(int i, Vector2 v)',
      'dotColumn': 'double dotColumn(int j, Vector2 v)',
      'trace': 'double trace()',
      'infinityNorm': 'double infinityNorm()',
      'relativeError': 'double relativeError(Matrix2 correct)',
      'absoluteError': 'double absoluteError(Matrix2 correct)',
      'invert': 'double invert()',
      'copyInverse': 'double copyInverse(Matrix2 arg)',
      'setRotation': 'void setRotation(double radians)',
      'scaleAdjoint': 'void scaleAdjoint(double scale)',
      'scale': 'void scale(double scale)',
      'scaled': 'Matrix2 scaled(double scale)',
      'add': 'void add(Matrix2 o)',
      'sub': 'void sub(Matrix2 o)',
      'negate': 'void negate()',
      'multiply': 'void multiply(Matrix2 arg)',
      'multiplied': 'Matrix2 multiplied(Matrix2 arg)',
      'transposeMultiply': 'void transposeMultiply(Matrix2 arg)',
      'multiplyTranspose': 'void multiplyTranspose(Matrix2 arg)',
      'transform': 'Vector2 transform(Vector2 arg)',
      'transformed': 'Vector2 transformed(Vector2 arg, [Vector2? out])',
      'copyIntoArray': 'void copyIntoArray(List<num> array, [int offset = 0])',
      'copyFromArray': 'void copyFromArray(List<double> array, [int offset = 0])',
    },
    getterSignatures: {
      'storage': 'Float64List get storage',
      'dimension': 'int get dimension',
      'hashCode': 'int get hashCode',
      'row0': 'Vector2 get row0',
      'row1': 'Vector2 get row1',
    },
    setterSignatures: {
      'row0': 'set row0(Vector2 value)',
      'row1': 'set row1(Vector2 value)',
    },
    staticMethodSignatures: {
      'solve': 'void solve(Matrix2 A, Vector2 x, Vector2 b)',
    },
  );
}

// =============================================================================
// Matrix3 Bridge
// =============================================================================

BridgedClass _createMatrix3Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Matrix3,
    name: 'Matrix3',
    isAssignable: (v) => v is $vector_math_1.Matrix3,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 9, 'Matrix3');
        final arg0 = D4.getRequiredArg<double>(positional, 0, 'arg0', 'Matrix3');
        final arg1 = D4.getRequiredArg<double>(positional, 1, 'arg1', 'Matrix3');
        final arg2 = D4.getRequiredArg<double>(positional, 2, 'arg2', 'Matrix3');
        final arg3 = D4.getRequiredArg<double>(positional, 3, 'arg3', 'Matrix3');
        final arg4 = D4.getRequiredArg<double>(positional, 4, 'arg4', 'Matrix3');
        final arg5 = D4.getRequiredArg<double>(positional, 5, 'arg5', 'Matrix3');
        final arg6 = D4.getRequiredArg<double>(positional, 6, 'arg6', 'Matrix3');
        final arg7 = D4.getRequiredArg<double>(positional, 7, 'arg7', 'Matrix3');
        final arg8 = D4.getRequiredArg<double>(positional, 8, 'arg8', 'Matrix3');
        return $vector_math_1.Matrix3(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix3');
        if (positional.isEmpty) {
          throw ArgumentError('Matrix3: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<double>(positional[0], 'values');
        return $vector_math_1.Matrix3.fromList(values);
      },
      'zero': (visitor, positional, named) {
        return $vector_math_1.Matrix3.zero();
      },
      'identity': (visitor, positional, named) {
        return $vector_math_1.Matrix3.identity();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix3');
        final other = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'other', 'Matrix3');
        return $vector_math_1.Matrix3.copy(other);
      },
      'columns': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Matrix3');
        final arg0 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg0', 'Matrix3');
        final arg1 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'arg1', 'Matrix3');
        final arg2 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'arg2', 'Matrix3');
        return $vector_math_1.Matrix3.columns(arg0, arg1, arg2);
      },
      'outer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix3');
        final u = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'u', 'Matrix3');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'v', 'Matrix3');
        return $vector_math_1.Matrix3.outer(u, v);
      },
      'rotationX': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix3');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'Matrix3');
        return $vector_math_1.Matrix3.rotationX(radians);
      },
      'rotationY': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix3');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'Matrix3');
        return $vector_math_1.Matrix3.rotationY(radians);
      },
      'rotationZ': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix3');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'Matrix3');
        return $vector_math_1.Matrix3.rotationZ(radians);
      },
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').storage,
      'dimension': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').dimension,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').hashCode,
      'row0': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').row0,
      'row1': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').row1,
      'row2': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').row2,
      'right': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').right,
      'up': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').up,
      'forward': (visitor, target) => D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').forward,
    },
    setters: {
      'row0': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').row0 = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'row0'),
      'row1': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').row1 = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'row1'),
      'row2': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3').row2 = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'row2'),
    },
    methods: {
      'index': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 2, 'index');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'index');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'index');
        return t.index(row, col);
      },
      'entry': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 2, 'entry');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'entry');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'entry');
        return t.entry(row, col);
      },
      'setEntry': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 3, 'setEntry');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'setEntry');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'setEntry');
        final v = D4.getRequiredArg<double>(positional, 2, 'v', 'setEntry');
        t.setEntry(row, col, v);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 9, 'setValues');
        final arg0 = D4.getRequiredArg<double>(positional, 0, 'arg0', 'setValues');
        final arg1 = D4.getRequiredArg<double>(positional, 1, 'arg1', 'setValues');
        final arg2 = D4.getRequiredArg<double>(positional, 2, 'arg2', 'setValues');
        final arg3 = D4.getRequiredArg<double>(positional, 3, 'arg3', 'setValues');
        final arg4 = D4.getRequiredArg<double>(positional, 4, 'arg4', 'setValues');
        final arg5 = D4.getRequiredArg<double>(positional, 5, 'arg5', 'setValues');
        final arg6 = D4.getRequiredArg<double>(positional, 6, 'arg6', 'setValues');
        final arg7 = D4.getRequiredArg<double>(positional, 7, 'arg7', 'setValues');
        final arg8 = D4.getRequiredArg<double>(positional, 8, 'arg8', 'setValues');
        t.setValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        return null;
      },
      'setColumns': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 3, 'setColumns');
        final arg0 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg0', 'setColumns');
        final arg1 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'arg1', 'setColumns');
        final arg2 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'arg2', 'setColumns');
        t.setColumns(arg0, arg1, arg2);
        return null;
      },
      'setFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'setFrom');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'setFrom');
        t.setFrom(arg);
        return null;
      },
      'setOuter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 2, 'setOuter');
        final u = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'u', 'setOuter');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'v', 'setOuter');
        t.setOuter(u, v);
        return null;
      },
      'splatDiagonal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'splatDiagonal');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'splatDiagonal');
        t.splatDiagonal(arg);
        return null;
      },
      'setDiagonal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'setDiagonal');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'setDiagonal');
        t.setDiagonal(arg);
        return null;
      },
      'setUpper2x2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'setUpper2x2');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix2>(positional, 0, 'arg', 'setUpper2x2');
        t.setUpper2x2(arg);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.toString();
      },
      'setRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 2, 'setRow');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'setRow');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'arg', 'setRow');
        t.setRow(row, arg);
        return null;
      },
      'getRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'getRow');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'getRow');
        return t.getRow(row);
      },
      'setColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 2, 'setColumn');
        final column = D4.getRequiredArg<int>(positional, 0, 'column', 'setColumn');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'arg', 'setColumn');
        t.setColumn(column, arg);
        return null;
      },
      'getColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'getColumn');
        final column = D4.getRequiredArg<int>(positional, 0, 'column', 'getColumn');
        return t.getColumn(column);
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.clone();
      },
      'copyInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'copyInto');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'copyInto');
        return t.copyInto(arg);
      },
      'setZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        t.setZero();
        return null;
      },
      'setIdentity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        t.setIdentity();
        return null;
      },
      'transposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.transposed();
      },
      'transpose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        t.transpose();
        return null;
      },
      'absolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.absolute();
      },
      'determinant': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.determinant();
      },
      'dotRow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 2, 'dotRow');
        final i = D4.getRequiredArg<int>(positional, 0, 'i', 'dotRow');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'v', 'dotRow');
        return t.dotRow(i, v);
      },
      'dotColumn': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 2, 'dotColumn');
        final j = D4.getRequiredArg<int>(positional, 0, 'j', 'dotColumn');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'v', 'dotColumn');
        return t.dotColumn(j, v);
      },
      'trace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.trace();
      },
      'infinityNorm': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.infinityNorm();
      },
      'relativeError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'relativeError');
        final correct = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'correct', 'relativeError');
        return t.relativeError(correct);
      },
      'absoluteError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'absoluteError');
        final correct = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'correct', 'absoluteError');
        return t.absoluteError(correct);
      },
      'invert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.invert();
      },
      'copyInverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'copyInverse');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'copyInverse');
        return t.copyInverse(arg);
      },
      'copyNormalMatrix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'copyNormalMatrix');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'copyNormalMatrix');
        t.copyNormalMatrix(arg);
        return null;
      },
      'setRotationX': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'setRotationX');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'setRotationX');
        t.setRotationX(radians);
        return null;
      },
      'setRotationY': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'setRotationY');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'setRotationY');
        t.setRotationY(radians);
        return null;
      },
      'setRotationZ': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'setRotationZ');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'setRotationZ');
        t.setRotationZ(radians);
        return null;
      },
      'scaleAdjoint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'scaleAdjoint');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scaleAdjoint');
        t.scaleAdjoint(scale);
        return null;
      },
      'absoluteRotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'absoluteRotate');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'absoluteRotate');
        return t.absoluteRotate(arg);
      },
      'absoluteRotate2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'absoluteRotate2');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'absoluteRotate2');
        return t.absoluteRotate2(arg);
      },
      'transform2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'transform2');
        final arg = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 0, 'arg', 'transform2');
        return t.transform2(arg);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'scale');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scale');
        t.scale(scale);
        return null;
      },
      'scaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'scaled');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scaled');
        return t.scaled(scale);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'add');
        final o = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'o', 'add');
        t.add(o);
        return null;
      },
      'sub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'sub');
        final o = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'o', 'sub');
        t.sub(o);
        return null;
      },
      'negate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        t.negate();
        return null;
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'multiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'multiply');
        t.multiply(arg);
        return null;
      },
      'multiplied': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'multiplied');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'multiplied');
        return t.multiplied(arg);
      },
      'transposeMultiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'transposeMultiply');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'transposeMultiply');
        t.transposeMultiply(arg);
        return null;
      },
      'multiplyTranspose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'multiplyTranspose');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'arg', 'multiplyTranspose');
        t.multiplyTranspose(arg);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'transform');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'transform');
        return t.transform(arg);
      },
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'transformed');
        final arg = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'arg', 'transformed');
        final out = D4.getOptionalArg<$vector_math_1.Vector3?>(positional, 1, 'out');
        return t.transformed(arg, out);
      },
      'copyIntoArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
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
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
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
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        D4.requireMinArgs(positional, 1, 'applyToVector3Array');
        if (positional.isEmpty) {
          throw ArgumentError('applyToVector3Array: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        return t.applyToVector3Array(array, offset);
      },
      'isIdentity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.isIdentity();
      },
      'isZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        return t.isZero();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        final other = D4.getRequiredArg<dynamic>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        final other = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Matrix3>(target, 'Matrix3');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
    },
    staticMethods: {
      'solve2': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'solve2');
        final A = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'A', 'solve2');
        final x = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 1, 'x', 'solve2');
        final b = D4.getRequiredArg<$vector_math_1.Vector2>(positional, 2, 'b', 'solve2');
        return $vector_math_1.Matrix3.solve2(A, x, b);
      },
      'solve': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'solve');
        final A = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'A', 'solve');
        final x = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'x', 'solve');
        final b = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'b', 'solve');
        return $vector_math_1.Matrix3.solve(A, x, b);
      },
    },
    constructorSignatures: {
      '': 'factory Matrix3(double arg0, double arg1, double arg2, double arg3, double arg4, double arg5, double arg6, double arg7, double arg8)',
      'fromList': 'factory Matrix3.fromList(List<double> values)',
      'zero': 'Matrix3.zero()',
      'identity': 'factory Matrix3.identity()',
      'copy': 'factory Matrix3.copy(Matrix3 other)',
      'columns': 'factory Matrix3.columns(Vector3 arg0, Vector3 arg1, Vector3 arg2)',
      'outer': 'factory Matrix3.outer(Vector3 u, Vector3 v)',
      'rotationX': 'factory Matrix3.rotationX(double radians)',
      'rotationY': 'factory Matrix3.rotationY(double radians)',
      'rotationZ': 'factory Matrix3.rotationZ(double radians)',
    },
    methodSignatures: {
      'index': 'int index(int row, int col)',
      'entry': 'double entry(int row, int col)',
      'setEntry': 'void setEntry(int row, int col, double v)',
      'setValues': 'void setValues(double arg0, double arg1, double arg2, double arg3, double arg4, double arg5, double arg6, double arg7, double arg8)',
      'setColumns': 'void setColumns(Vector3 arg0, Vector3 arg1, Vector3 arg2)',
      'setFrom': 'void setFrom(Matrix3 arg)',
      'setOuter': 'void setOuter(Vector3 u, Vector3 v)',
      'splatDiagonal': 'void splatDiagonal(double arg)',
      'setDiagonal': 'void setDiagonal(Vector3 arg)',
      'setUpper2x2': 'void setUpper2x2(Matrix2 arg)',
      'toString': 'String toString()',
      'setRow': 'void setRow(int row, Vector3 arg)',
      'getRow': 'Vector3 getRow(int row)',
      'setColumn': 'void setColumn(int column, Vector3 arg)',
      'getColumn': 'Vector3 getColumn(int column)',
      'clone': 'Matrix3 clone()',
      'copyInto': 'Matrix3 copyInto(Matrix3 arg)',
      'setZero': 'void setZero()',
      'setIdentity': 'void setIdentity()',
      'transposed': 'Matrix3 transposed()',
      'transpose': 'void transpose()',
      'absolute': 'Matrix3 absolute()',
      'determinant': 'double determinant()',
      'dotRow': 'double dotRow(int i, Vector3 v)',
      'dotColumn': 'double dotColumn(int j, Vector3 v)',
      'trace': 'double trace()',
      'infinityNorm': 'double infinityNorm()',
      'relativeError': 'double relativeError(Matrix3 correct)',
      'absoluteError': 'double absoluteError(Matrix3 correct)',
      'invert': 'double invert()',
      'copyInverse': 'double copyInverse(Matrix3 arg)',
      'copyNormalMatrix': 'void copyNormalMatrix(Matrix4 arg)',
      'setRotationX': 'void setRotationX(double radians)',
      'setRotationY': 'void setRotationY(double radians)',
      'setRotationZ': 'void setRotationZ(double radians)',
      'scaleAdjoint': 'void scaleAdjoint(double scale)',
      'absoluteRotate': 'Vector3 absoluteRotate(Vector3 arg)',
      'absoluteRotate2': 'Vector2 absoluteRotate2(Vector2 arg)',
      'transform2': 'Vector2 transform2(Vector2 arg)',
      'scale': 'void scale(double scale)',
      'scaled': 'Matrix3 scaled(double scale)',
      'add': 'void add(Matrix3 o)',
      'sub': 'void sub(Matrix3 o)',
      'negate': 'void negate()',
      'multiply': 'void multiply(Matrix3 arg)',
      'multiplied': 'Matrix3 multiplied(Matrix3 arg)',
      'transposeMultiply': 'void transposeMultiply(Matrix3 arg)',
      'multiplyTranspose': 'void multiplyTranspose(Matrix3 arg)',
      'transform': 'Vector3 transform(Vector3 arg)',
      'transformed': 'Vector3 transformed(Vector3 arg, [Vector3? out])',
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
      'row0': 'Vector3 get row0',
      'row1': 'Vector3 get row1',
      'row2': 'Vector3 get row2',
      'right': 'Vector3 get right',
      'up': 'Vector3 get up',
      'forward': 'Vector3 get forward',
    },
    setterSignatures: {
      'row0': 'set row0(Vector3 value)',
      'row1': 'set row1(Vector3 value)',
      'row2': 'set row2(Vector3 value)',
    },
    staticMethodSignatures: {
      'solve2': 'void solve2(Matrix3 A, Vector2 x, Vector2 b)',
      'solve': 'void solve(Matrix3 A, Vector3 x, Vector3 b)',
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
    isAssignable: (v) => v is $vector_math_1.Matrix4,
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
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row0 = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'row0'),
      'row1': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row1 = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'row1'),
      'row2': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row2 = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'row2'),
      'row3': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Matrix4>(target, 'Matrix4').row3 = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'row3'),
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
// Obb3 Bridge
// =============================================================================

BridgedClass _createObb3Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Obb3,
    name: 'Obb3',
    isAssignable: (v) => v is $vector_math_1.Obb3,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Obb3();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Obb3');
        final other = D4.getRequiredArg<$vector_math_1.Obb3>(positional, 0, 'other', 'Obb3');
        return $vector_math_1.Obb3.copy(other);
      },
      'centerExtentsAxes': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'Obb3');
        final center = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'center', 'Obb3');
        final halfExtents = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'halfExtents', 'Obb3');
        final axis0 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'axis0', 'Obb3');
        final axis1 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 3, 'axis1', 'Obb3');
        final axis2 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 4, 'axis2', 'Obb3');
        return $vector_math_1.Obb3.centerExtentsAxes(center, halfExtents, axis0, axis1, axis2);
      },
    },
    getters: {
      'center': (visitor, target) => D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3').center,
      'halfExtents': (visitor, target) => D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3').halfExtents,
      'axis0': (visitor, target) => D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3').axis0,
      'axis1': (visitor, target) => D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3').axis1,
      'axis2': (visitor, target) => D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3').axis2,
    },
    methods: {
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Obb3>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'copyInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'copyInto');
        final other = D4.getRequiredArg<$vector_math_1.Obb3>(positional, 0, 'other', 'copyInto');
        t.copyInto(other);
        return null;
      },
      'resetRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        t.resetRotation();
        return null;
      },
      'translate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'translate');
        final offset = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'offset', 'translate');
        t.translate(offset);
        return null;
      },
      'rotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'rotate');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 't', 'rotate');
        t.rotate(t_);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 't', 'transform');
        t.transform(t_);
        return null;
      },
      'copyCorner': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 2, 'copyCorner');
        final cornerIndex = D4.getRequiredArg<int>(positional, 0, 'cornerIndex', 'copyCorner');
        final corner = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'corner', 'copyCorner');
        t.copyCorner(cornerIndex, corner);
        return null;
      },
      'closestPointTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 2, 'closestPointTo');
        final p = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'p', 'closestPointTo');
        final q = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'q', 'closestPointTo');
        t.closestPointTo(p, q);
        return null;
      },
      'intersectsWithObb3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithObb3');
        final other = D4.getRequiredArg<$vector_math_1.Obb3>(positional, 0, 'other', 'intersectsWithObb3');
        final epsilon = D4.getOptionalArgWithDefault<double>(positional, 1, 'epsilon', 1e-3);
        return t.intersectsWithObb3(other, epsilon);
      },
      'intersectsWithTriangle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithTriangle');
        final other = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'other', 'intersectsWithTriangle');
        final result = D4.getOptionalNamedArg<$vector_math_1.IntersectionResult?>(named, 'result');
        return t.intersectsWithTriangle(other, result: result);
      },
      'intersectsWithVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithVector3');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'intersectsWithVector3');
        return t.intersectsWithVector3(other);
      },
      'intersectsWithQuad': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Obb3>(target, 'Obb3');
        D4.requireMinArgs(positional, 1, 'intersectsWithQuad');
        final other = D4.getRequiredArg<$vector_math_1.Quad>(positional, 0, 'other', 'intersectsWithQuad');
        final result = D4.getOptionalNamedArg<$vector_math_1.IntersectionResult?>(named, 'result');
        return t.intersectsWithQuad(other, result: result);
      },
    },
    constructorSignatures: {
      '': 'Obb3()',
      'copy': 'Obb3.copy(Obb3 other)',
      'centerExtentsAxes': 'Obb3.centerExtentsAxes(Vector3 center, Vector3 halfExtents, Vector3 axis0, Vector3 axis1, Vector3 axis2)',
    },
    methodSignatures: {
      'copyFrom': 'void copyFrom(Obb3 other)',
      'copyInto': 'void copyInto(Obb3 other)',
      'resetRotation': 'void resetRotation()',
      'translate': 'void translate(Vector3 offset)',
      'rotate': 'void rotate(Matrix3 t)',
      'transform': 'void transform(Matrix4 t)',
      'copyCorner': 'void copyCorner(int cornerIndex, Vector3 corner)',
      'closestPointTo': 'void closestPointTo(Vector3 p, Vector3 q)',
      'intersectsWithObb3': 'bool intersectsWithObb3(Obb3 other, [double epsilon = 1e-3])',
      'intersectsWithTriangle': 'bool intersectsWithTriangle(Triangle other, {IntersectionResult? result})',
      'intersectsWithVector3': 'bool intersectsWithVector3(Vector3 other)',
      'intersectsWithQuad': 'bool intersectsWithQuad(Quad other, {IntersectionResult? result})',
    },
    getterSignatures: {
      'center': 'Vector3 get center',
      'halfExtents': 'Vector3 get halfExtents',
      'axis0': 'Vector3 get axis0',
      'axis1': 'Vector3 get axis1',
      'axis2': 'Vector3 get axis2',
    },
  );
}

// =============================================================================
// Plane Bridge
// =============================================================================

BridgedClass _createPlaneBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Plane,
    name: 'Plane',
    isAssignable: (v) => v is $vector_math_1.Plane,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Plane();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Plane');
        final other = D4.getRequiredArg<$vector_math_1.Plane>(positional, 0, 'other', 'Plane');
        return $vector_math_1.Plane.copy(other);
      },
      'components': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Plane');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Plane');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Plane');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'Plane');
        final constant = D4.getRequiredArg<double>(positional, 3, 'constant', 'Plane');
        return $vector_math_1.Plane.components(x, y, z, constant);
      },
      'normalconstant': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Plane');
        final normal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'normal_', 'Plane');
        final constant = D4.getRequiredArg<double>(positional, 1, 'constant', 'Plane');
        return $vector_math_1.Plane.normalconstant(normal, constant);
      },
    },
    getters: {
      'constant': (visitor, target) => D4.validateTarget<$vector_math_1.Plane>(target, 'Plane').constant,
      'normal': (visitor, target) => D4.validateTarget<$vector_math_1.Plane>(target, 'Plane').normal,
    },
    setters: {
      'constant': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Plane>(target, 'Plane').constant = D4.extractBridgedArg<double>(value, 'constant'),
    },
    methods: {
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Plane>(target, 'Plane');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final o = D4.getRequiredArg<$vector_math_1.Plane>(positional, 0, 'o', 'copyFrom');
        t.copyFrom(o);
        return null;
      },
      'setFromComponents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Plane>(target, 'Plane');
        D4.requireMinArgs(positional, 4, 'setFromComponents');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'setFromComponents');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'setFromComponents');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'setFromComponents');
        final w = D4.getRequiredArg<double>(positional, 3, 'w', 'setFromComponents');
        t.setFromComponents(x, y, z, w);
        return null;
      },
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Plane>(target, 'Plane');
        t.normalize();
        return null;
      },
      'distanceToVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Plane>(target, 'Plane');
        D4.requireMinArgs(positional, 1, 'distanceToVector3');
        final point = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'point', 'distanceToVector3');
        return t.distanceToVector3(point);
      },
    },
    staticMethods: {
      'intersection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'intersection');
        final a = D4.getRequiredArg<$vector_math_1.Plane>(positional, 0, 'a', 'intersection');
        final b = D4.getRequiredArg<$vector_math_1.Plane>(positional, 1, 'b', 'intersection');
        final c = D4.getRequiredArg<$vector_math_1.Plane>(positional, 2, 'c', 'intersection');
        final result = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 3, 'result', 'intersection');
        return $vector_math_1.Plane.intersection(a, b, c, result);
      },
    },
    constructorSignatures: {
      '': 'Plane()',
      'copy': 'Plane.copy(Plane other)',
      'components': 'Plane.components(double x, double y, double z, double constant)',
      'normalconstant': 'Plane.normalconstant(Vector3 normal_, double constant)',
    },
    methodSignatures: {
      'copyFrom': 'void copyFrom(Plane o)',
      'setFromComponents': 'void setFromComponents(double x, double y, double z, double w)',
      'normalize': 'void normalize()',
      'distanceToVector3': 'double distanceToVector3(Vector3 point)',
    },
    getterSignatures: {
      'constant': 'double get constant',
      'normal': 'Vector3 get normal',
    },
    setterSignatures: {
      'constant': 'set constant(dynamic value)',
    },
    staticMethodSignatures: {
      'intersection': 'void intersection(Plane a, Plane b, Plane c, Vector3 result)',
    },
  );
}

// =============================================================================
// Quad Bridge
// =============================================================================

BridgedClass _createQuadBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Quad,
    name: 'Quad',
    isAssignable: (v) => v is $vector_math_1.Quad,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Quad();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Quad');
        final other = D4.getRequiredArg<$vector_math_1.Quad>(positional, 0, 'other', 'Quad');
        return $vector_math_1.Quad.copy(other);
      },
      'points': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Quad');
        final point0 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'point0', 'Quad');
        final point1 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'point1', 'Quad');
        final point2 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'point2', 'Quad');
        final point3 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 3, 'point3', 'Quad');
        return $vector_math_1.Quad.points(point0, point1, point2, point3);
      },
    },
    getters: {
      'point0': (visitor, target) => D4.validateTarget<$vector_math_1.Quad>(target, 'Quad').point0,
      'point1': (visitor, target) => D4.validateTarget<$vector_math_1.Quad>(target, 'Quad').point1,
      'point2': (visitor, target) => D4.validateTarget<$vector_math_1.Quad>(target, 'Quad').point2,
      'point3': (visitor, target) => D4.validateTarget<$vector_math_1.Quad>(target, 'Quad').point3,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Quad>(target, 'Quad').hashCode,
    },
    methods: {
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quad>(target, 'Quad');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Quad>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'copyNormalInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quad>(target, 'Quad');
        D4.requireMinArgs(positional, 1, 'copyNormalInto');
        final normal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'normal', 'copyNormalInto');
        t.copyNormalInto(normal);
        return null;
      },
      'copyTriangles': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quad>(target, 'Quad');
        D4.requireMinArgs(positional, 2, 'copyTriangles');
        final triangle0 = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'triangle0', 'copyTriangles');
        final triangle1 = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 1, 'triangle1', 'copyTriangles');
        t.copyTriangles(triangle0, triangle1);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quad>(target, 'Quad');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 't', 'transform');
        t.transform(t_);
        return null;
      },
      'translate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quad>(target, 'Quad');
        D4.requireMinArgs(positional, 1, 'translate');
        final offset = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'offset', 'translate');
        t.translate(offset);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quad>(target, 'Quad');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quad>(target, 'Quad');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'Quad()',
      'copy': 'Quad.copy(Quad other)',
      'points': 'Quad.points(Vector3 point0, Vector3 point1, Vector3 point2, Vector3 point3)',
    },
    methodSignatures: {
      'copyFrom': 'void copyFrom(Quad other)',
      'copyNormalInto': 'void copyNormalInto(Vector3 normal)',
      'copyTriangles': 'void copyTriangles(Triangle triangle0, Triangle triangle1)',
      'transform': 'void transform(Matrix4 t)',
      'translate': 'void translate(Vector3 offset)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'point0': 'Vector3 get point0',
      'point1': 'Vector3 get point1',
      'point2': 'Vector3 get point2',
      'point3': 'Vector3 get point3',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Quaternion Bridge
// =============================================================================

BridgedClass _createQuaternionBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Quaternion,
    name: 'Quaternion',
    isAssignable: (v) => v is $vector_math_1.Quaternion,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Quaternion');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Quaternion');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Quaternion');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'Quaternion');
        final w = D4.getRequiredArg<double>(positional, 3, 'w', 'Quaternion');
        return $vector_math_1.Quaternion(x, y, z, w);
      },
      'fromRotation': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Quaternion');
        final rotationMatrix = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'rotationMatrix', 'Quaternion');
        return $vector_math_1.Quaternion.fromRotation(rotationMatrix);
      },
      'axisAngle': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Quaternion');
        final axis = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'axis', 'Quaternion');
        final angle = D4.getRequiredArg<double>(positional, 1, 'angle', 'Quaternion');
        return $vector_math_1.Quaternion.axisAngle(axis, angle);
      },
      'fromTwoVectors': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Quaternion');
        final a = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'a', 'Quaternion');
        final b = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'b', 'Quaternion');
        return $vector_math_1.Quaternion.fromTwoVectors(a, b);
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Quaternion');
        final original = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'original', 'Quaternion');
        return $vector_math_1.Quaternion.copy(original);
      },
      'random': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Quaternion');
        final rn = D4.getRequiredArg<$dart_math.Random>(positional, 0, 'rn', 'Quaternion');
        return $vector_math_1.Quaternion.random(rn);
      },
      'identity': (visitor, positional, named) {
        return $vector_math_1.Quaternion.identity();
      },
      'dq': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Quaternion');
        final q = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'q', 'Quaternion');
        final omega = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'omega', 'Quaternion');
        return $vector_math_1.Quaternion.dq(q, omega);
      },
      'euler': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Quaternion');
        final yaw = D4.getRequiredArg<double>(positional, 0, 'yaw', 'Quaternion');
        final pitch = D4.getRequiredArg<double>(positional, 1, 'pitch', 'Quaternion');
        final roll = D4.getRequiredArg<double>(positional, 2, 'roll', 'Quaternion');
        return $vector_math_1.Quaternion.euler(yaw, pitch, roll);
      },
      'fromFloat64List': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Quaternion');
        final qStorage = D4.getRequiredArg<Float64List>(positional, 0, '_qStorage', 'Quaternion');
        return $vector_math_1.Quaternion.fromFloat64List(qStorage);
      },
      'fromBuffer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Quaternion');
        final buffer = D4.getRequiredArg<ByteBuffer>(positional, 0, 'buffer', 'Quaternion');
        final offset = D4.getRequiredArg<int>(positional, 1, 'offset', 'Quaternion');
        return $vector_math_1.Quaternion.fromBuffer(buffer, offset);
      },
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').storage,
      'x': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').x,
      'y': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').y,
      'z': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').z,
      'w': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').w,
      'radians': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').radians,
      'axis': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').axis,
      'length2': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').length2,
      'length': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').length,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').hashCode,
    },
    setters: {
      'x': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').x = D4.extractBridgedArg<double>(value, 'x'),
      'y': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').y = D4.extractBridgedArg<double>(value, 'y'),
      'z': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').z = D4.extractBridgedArg<double>(value, 'z'),
      'w': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion').w = D4.extractBridgedArg<double>(value, 'w'),
    },
    methods: {
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.clone();
      },
      'setFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'setFrom');
        final source = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'source', 'setFrom');
        t.setFrom(source);
        return null;
      },
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 4, 'setValues');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'setValues');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'setValues');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'setValues');
        final w = D4.getRequiredArg<double>(positional, 3, 'w', 'setValues');
        t.setValues(x, y, z, w);
        return null;
      },
      'setAxisAngle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 2, 'setAxisAngle');
        final axis = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'axis', 'setAxisAngle');
        final radians = D4.getRequiredArg<double>(positional, 1, 'radians', 'setAxisAngle');
        t.setAxisAngle(axis, radians);
        return null;
      },
      'setFromRotation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'setFromRotation');
        final rotationMatrix = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'rotationMatrix', 'setFromRotation');
        t.setFromRotation(rotationMatrix);
        return null;
      },
      'setFromTwoVectors': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 2, 'setFromTwoVectors');
        final a = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'a', 'setFromTwoVectors');
        final b = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'b', 'setFromTwoVectors');
        t.setFromTwoVectors(a, b);
        return null;
      },
      'setRandom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'setRandom');
        final rn = D4.getRequiredArg<$dart_math.Random>(positional, 0, 'rn', 'setRandom');
        t.setRandom(rn);
        return null;
      },
      'setDQ': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 2, 'setDQ');
        final q = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'q', 'setDQ');
        final omega = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'omega', 'setDQ');
        t.setDQ(q, omega);
        return null;
      },
      'setEuler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 3, 'setEuler');
        final yaw = D4.getRequiredArg<double>(positional, 0, 'yaw', 'setEuler');
        final pitch = D4.getRequiredArg<double>(positional, 1, 'pitch', 'setEuler');
        final roll = D4.getRequiredArg<double>(positional, 2, 'roll', 'setEuler');
        t.setEuler(yaw, pitch, roll);
        return null;
      },
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.normalize();
      },
      'negate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        t.negate();
        return null;
      },
      'conjugate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        t.conjugate();
        return null;
      },
      'inverse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        t.inverse();
        return null;
      },
      'normalized': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.normalized();
      },
      'negated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.negated();
      },
      'conjugated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.conjugated();
      },
      'inverted': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.inverted();
      },
      'rotated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'rotated');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'v', 'rotated');
        return t.rotated(v);
      },
      'rotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'rotate');
        final v = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'v', 'rotate');
        return t.rotate(v);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'add');
        final arg = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'arg', 'add');
        t.add(arg);
        return null;
      },
      'sub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'sub');
        final arg = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'arg', 'sub');
        t.sub(arg);
        return null;
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'scale');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scale');
        t.scale(scale);
        return null;
      },
      'scaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'scaled');
        final scale = D4.getRequiredArg<double>(positional, 0, 'scale', 'scaled');
        return t.scaled(scale);
      },
      'asRotationMatrix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.asRotationMatrix();
      },
      'copyRotationInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'copyRotationInto');
        final rotationMatrix = D4.getRequiredArg<$vector_math_1.Matrix3>(positional, 0, 'rotationMatrix', 'copyRotationInto');
        return t.copyRotationInto(rotationMatrix);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        return t.toString();
      },
      'relativeError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'relativeError');
        final correct = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'correct', 'relativeError');
        return t.relativeError(correct);
      },
      'absoluteError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        D4.requireMinArgs(positional, 1, 'absoluteError');
        final correct = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'correct', 'absoluteError');
        return t.absoluteError(correct);
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        final other = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        final other = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$vector_math_1.Quaternion>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Quaternion>(target, 'Quaternion');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    constructorSignatures: {
      '': 'factory Quaternion(double x, double y, double z, double w)',
      'fromRotation': 'factory Quaternion.fromRotation(Matrix3 rotationMatrix)',
      'axisAngle': 'factory Quaternion.axisAngle(Vector3 axis, double angle)',
      'fromTwoVectors': 'factory Quaternion.fromTwoVectors(Vector3 a, Vector3 b)',
      'copy': 'factory Quaternion.copy(Quaternion original)',
      'random': 'factory Quaternion.random(math.Random rn)',
      'identity': 'factory Quaternion.identity()',
      'dq': 'factory Quaternion.dq(Quaternion q, Vector3 omega)',
      'euler': 'factory Quaternion.euler(double yaw, double pitch, double roll)',
      'fromFloat64List': 'Quaternion.fromFloat64List(Float64List _qStorage)',
      'fromBuffer': 'Quaternion.fromBuffer(ByteBuffer buffer, int offset)',
    },
    methodSignatures: {
      'clone': 'Quaternion clone()',
      'setFrom': 'void setFrom(Quaternion source)',
      'setValues': 'void setValues(double x, double y, double z, double w)',
      'setAxisAngle': 'void setAxisAngle(Vector3 axis, double radians)',
      'setFromRotation': 'void setFromRotation(Matrix3 rotationMatrix)',
      'setFromTwoVectors': 'void setFromTwoVectors(Vector3 a, Vector3 b)',
      'setRandom': 'void setRandom(math.Random rn)',
      'setDQ': 'void setDQ(Quaternion q, Vector3 omega)',
      'setEuler': 'void setEuler(double yaw, double pitch, double roll)',
      'normalize': 'double normalize()',
      'negate': 'void negate()',
      'conjugate': 'void conjugate()',
      'inverse': 'void inverse()',
      'normalized': 'Quaternion normalized()',
      'negated': 'Quaternion negated()',
      'conjugated': 'Quaternion conjugated()',
      'inverted': 'Quaternion inverted()',
      'rotated': 'Vector3 rotated(Vector3 v)',
      'rotate': 'Vector3 rotate(Vector3 v)',
      'add': 'void add(Quaternion arg)',
      'sub': 'void sub(Quaternion arg)',
      'scale': 'void scale(double scale)',
      'scaled': 'Quaternion scaled(double scale)',
      'asRotationMatrix': 'Matrix3 asRotationMatrix()',
      'copyRotationInto': 'Matrix3 copyRotationInto(Matrix3 rotationMatrix)',
      'toString': 'String toString()',
      'relativeError': 'double relativeError(Quaternion correct)',
      'absoluteError': 'double absoluteError(Quaternion correct)',
    },
    getterSignatures: {
      'storage': 'Float64List get storage',
      'x': 'double get x',
      'y': 'double get y',
      'z': 'double get z',
      'w': 'double get w',
      'radians': 'double get radians',
      'axis': 'Vector3 get axis',
      'length2': 'double get length2',
      'length': 'double get length',
      'hashCode': 'int get hashCode',
    },
    setterSignatures: {
      'x': 'set x(double value)',
      'y': 'set y(double value)',
      'z': 'set z(double value)',
      'w': 'set w(double value)',
    },
  );
}

// =============================================================================
// Ray Bridge
// =============================================================================

BridgedClass _createRayBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Ray,
    name: 'Ray',
    isAssignable: (v) => v is $vector_math_1.Ray,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Ray();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Ray');
        final other = D4.getRequiredArg<$vector_math_1.Ray>(positional, 0, 'other', 'Ray');
        return $vector_math_1.Ray.copy(other);
      },
      'originDirection': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Ray');
        final origin = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'origin', 'Ray');
        final direction = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'direction', 'Ray');
        return $vector_math_1.Ray.originDirection(origin, direction);
      },
    },
    getters: {
      'origin': (visitor, target) => D4.validateTarget<$vector_math_1.Ray>(target, 'Ray').origin,
      'direction': (visitor, target) => D4.validateTarget<$vector_math_1.Ray>(target, 'Ray').direction,
    },
    methods: {
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Ray>(target, 'Ray');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Ray>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'at': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Ray>(target, 'Ray');
        D4.requireMinArgs(positional, 1, 'at');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'at');
        return t.at(t_);
      },
      'copyAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Ray>(target, 'Ray');
        D4.requireMinArgs(positional, 2, 'copyAt');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'copyAt');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'copyAt');
        t.copyAt(other, t_);
        return null;
      },
      'intersectsWithSphere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Ray>(target, 'Ray');
        D4.requireMinArgs(positional, 1, 'intersectsWithSphere');
        final other = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'other', 'intersectsWithSphere');
        return t.intersectsWithSphere(other);
      },
      'intersectsWithTriangle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Ray>(target, 'Ray');
        D4.requireMinArgs(positional, 1, 'intersectsWithTriangle');
        final other = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'other', 'intersectsWithTriangle');
        return t.intersectsWithTriangle(other);
      },
      'intersectsWithQuad': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Ray>(target, 'Ray');
        D4.requireMinArgs(positional, 1, 'intersectsWithQuad');
        final other = D4.getRequiredArg<$vector_math_1.Quad>(positional, 0, 'other', 'intersectsWithQuad');
        return t.intersectsWithQuad(other);
      },
      'intersectsWithAabb3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Ray>(target, 'Ray');
        D4.requireMinArgs(positional, 1, 'intersectsWithAabb3');
        final other = D4.getRequiredArg<$vector_math_1.Aabb3>(positional, 0, 'other', 'intersectsWithAabb3');
        return t.intersectsWithAabb3(other);
      },
    },
    constructorSignatures: {
      '': 'Ray()',
      'copy': 'Ray.copy(Ray other)',
      'originDirection': 'Ray.originDirection(Vector3 origin, Vector3 direction)',
    },
    methodSignatures: {
      'copyFrom': 'void copyFrom(Ray other)',
      'at': 'Vector3 at(double t)',
      'copyAt': 'void copyAt(Vector3 other, double t)',
      'intersectsWithSphere': 'double? intersectsWithSphere(Sphere other)',
      'intersectsWithTriangle': 'double? intersectsWithTriangle(Triangle other)',
      'intersectsWithQuad': 'double? intersectsWithQuad(Quad other)',
      'intersectsWithAabb3': 'double? intersectsWithAabb3(Aabb3 other)',
    },
    getterSignatures: {
      'origin': 'Vector3 get origin',
      'direction': 'Vector3 get direction',
    },
  );
}

// =============================================================================
// Sphere Bridge
// =============================================================================

BridgedClass _createSphereBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Sphere,
    name: 'Sphere',
    isAssignable: (v) => v is $vector_math_1.Sphere,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Sphere();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Sphere');
        final other = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'other', 'Sphere');
        return $vector_math_1.Sphere.copy(other);
      },
      'centerRadius': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Sphere');
        final center = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'center', 'Sphere');
        final radius = D4.getRequiredArg<double>(positional, 1, 'radius', 'Sphere');
        return $vector_math_1.Sphere.centerRadius(center, radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$vector_math_1.Sphere>(target, 'Sphere').radius,
      'center': (visitor, target) => D4.validateTarget<$vector_math_1.Sphere>(target, 'Sphere').center,
    },
    setters: {
      'radius': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Sphere>(target, 'Sphere').radius = D4.extractBridgedArg<double>(value, 'radius'),
    },
    methods: {
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Sphere>(target, 'Sphere');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'containsVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Sphere>(target, 'Sphere');
        D4.requireMinArgs(positional, 1, 'containsVector3');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'containsVector3');
        return t.containsVector3(other);
      },
      'intersectsWithVector3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Sphere>(target, 'Sphere');
        D4.requireMinArgs(positional, 1, 'intersectsWithVector3');
        final other = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'other', 'intersectsWithVector3');
        return t.intersectsWithVector3(other);
      },
      'intersectsWithSphere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Sphere>(target, 'Sphere');
        D4.requireMinArgs(positional, 1, 'intersectsWithSphere');
        final other = D4.getRequiredArg<$vector_math_1.Sphere>(positional, 0, 'other', 'intersectsWithSphere');
        return t.intersectsWithSphere(other);
      },
    },
    constructorSignatures: {
      '': 'Sphere()',
      'copy': 'Sphere.copy(Sphere other)',
      'centerRadius': 'Sphere.centerRadius(Vector3 center, double radius)',
    },
    methodSignatures: {
      'copyFrom': 'void copyFrom(Sphere other)',
      'containsVector3': 'bool containsVector3(Vector3 other)',
      'intersectsWithVector3': 'bool intersectsWithVector3(Vector3 other)',
      'intersectsWithSphere': 'bool intersectsWithSphere(Sphere other)',
    },
    getterSignatures: {
      'radius': 'double get radius',
      'center': 'Vector3 get center',
    },
    setterSignatures: {
      'radius': 'set radius(dynamic value)',
    },
  );
}

// =============================================================================
// Triangle Bridge
// =============================================================================

BridgedClass _createTriangleBridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Triangle,
    name: 'Triangle',
    isAssignable: (v) => v is $vector_math_1.Triangle,
    constructors: {
      '': (visitor, positional, named) {
        return $vector_math_1.Triangle();
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Triangle');
        final other = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'other', 'Triangle');
        return $vector_math_1.Triangle.copy(other);
      },
      'points': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Triangle');
        final point0 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'point0', 'Triangle');
        final point1 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 1, 'point1', 'Triangle');
        final point2 = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 2, 'point2', 'Triangle');
        return $vector_math_1.Triangle.points(point0, point1, point2);
      },
    },
    getters: {
      'point0': (visitor, target) => D4.validateTarget<$vector_math_1.Triangle>(target, 'Triangle').point0,
      'point1': (visitor, target) => D4.validateTarget<$vector_math_1.Triangle>(target, 'Triangle').point1,
      'point2': (visitor, target) => D4.validateTarget<$vector_math_1.Triangle>(target, 'Triangle').point2,
    },
    methods: {
      'copyFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Triangle>(target, 'Triangle');
        D4.requireMinArgs(positional, 1, 'copyFrom');
        final other = D4.getRequiredArg<$vector_math_1.Triangle>(positional, 0, 'other', 'copyFrom');
        t.copyFrom(other);
        return null;
      },
      'copyNormalInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Triangle>(target, 'Triangle');
        D4.requireMinArgs(positional, 1, 'copyNormalInto');
        final normal = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'normal', 'copyNormalInto');
        t.copyNormalInto(normal);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Triangle>(target, 'Triangle');
        D4.requireMinArgs(positional, 1, 'transform');
        final t_ = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 't', 'transform');
        t.transform(t_);
        return null;
      },
      'translate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Triangle>(target, 'Triangle');
        D4.requireMinArgs(positional, 1, 'translate');
        final offset = D4.getRequiredArg<$vector_math_1.Vector3>(positional, 0, 'offset', 'translate');
        t.translate(offset);
        return null;
      },
    },
    constructorSignatures: {
      '': 'Triangle()',
      'copy': 'Triangle.copy(Triangle other)',
      'points': 'Triangle.points(Vector3 point0, Vector3 point1, Vector3 point2)',
    },
    methodSignatures: {
      'copyFrom': 'void copyFrom(Triangle other)',
      'copyNormalInto': 'void copyNormalInto(Vector3 normal)',
      'transform': 'void transform(Matrix4 t)',
      'translate': 'void translate(Vector3 offset)',
    },
    getterSignatures: {
      'point0': 'Vector3 get point0',
      'point1': 'Vector3 get point1',
      'point2': 'Vector3 get point2',
    },
  );
}

// =============================================================================
// Vector Bridge
// =============================================================================

BridgedClass _createVectorBridge() {
  return BridgedClass(
    nativeType: Vector,
    name: 'Vector',
    isAssignable: (v) => v is Vector,
    constructors: {
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<Vector>(target, 'Vector').storage,
    },
    getterSignatures: {
      'storage': 'List<double> get storage',
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
    isAssignable: (v) => v is $vector_math_1.Vector2,
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
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').length = D4.extractBridgedArg<double>(value, 'length'),
      'xy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').xy = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'xy'),
      'yx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').yx = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'yx'),
      'r': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').r = D4.extractBridgedArg<double>(value, 'r'),
      'g': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').g = D4.extractBridgedArg<double>(value, 'g'),
      's': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').s = D4.extractBridgedArg<double>(value, 's'),
      't': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').t = D4.extractBridgedArg<double>(value, 't'),
      'x': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').x = D4.extractBridgedArg<double>(value, 'x'),
      'y': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').y = D4.extractBridgedArg<double>(value, 'y'),
      'rg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').rg = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'rg'),
      'gr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').gr = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'gr'),
      'st': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').st = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'st'),
      'ts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector2>(target, 'Vector2').ts = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ts'),
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

// =============================================================================
// Vector3 Bridge
// =============================================================================

BridgedClass _createVector3Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Vector3,
    name: 'Vector3',
    isAssignable: (v) => v is $vector_math_1.Vector3,
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
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').length = D4.extractBridgedArg<double>(value, 'length'),
      'xy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xy = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'xy'),
      'xz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xz = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'xz'),
      'yx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yx = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'yx'),
      'yz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yz = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'yz'),
      'zx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zx = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'zx'),
      'zy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zy = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'zy'),
      'xyz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xyz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xyz'),
      'xzy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').xzy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xzy'),
      'yxz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yxz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'yxz'),
      'yzx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').yzx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'yzx'),
      'zxy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zxy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zxy'),
      'zyx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').zyx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zyx'),
      'r': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').r = D4.extractBridgedArg<double>(value, 'r'),
      'g': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').g = D4.extractBridgedArg<double>(value, 'g'),
      'b': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').b = D4.extractBridgedArg<double>(value, 'b'),
      's': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').s = D4.extractBridgedArg<double>(value, 's'),
      't': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').t = D4.extractBridgedArg<double>(value, 't'),
      'p': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').p = D4.extractBridgedArg<double>(value, 'p'),
      'x': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').x = D4.extractBridgedArg<double>(value, 'x'),
      'y': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').y = D4.extractBridgedArg<double>(value, 'y'),
      'z': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').z = D4.extractBridgedArg<double>(value, 'z'),
      'rg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rg = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'rg'),
      'rb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rb = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'rb'),
      'gr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gr = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'gr'),
      'gb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gb = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'gb'),
      'br': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').br = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'br'),
      'bg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bg = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'bg'),
      'rgb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rgb = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rgb'),
      'rbg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').rbg = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rbg'),
      'grb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').grb = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'grb'),
      'gbr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').gbr = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'gbr'),
      'brg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').brg = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'brg'),
      'bgr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').bgr = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'bgr'),
      'st': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').st = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'st'),
      'sp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').sp = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'sp'),
      'ts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ts = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ts'),
      'tp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tp = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'tp'),
      'ps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').ps = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ps'),
      'pt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pt = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'pt'),
      'stp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').stp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'stp'),
      'spt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').spt = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'spt'),
      'tsp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tsp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tsp'),
      'tps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').tps = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tps'),
      'pst': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pst = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'pst'),
      'pts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector3>(target, 'Vector3').pts = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'pts'),
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
// Vector4 Bridge
// =============================================================================

BridgedClass _createVector4Bridge() {
  return BridgedClass(
    nativeType: $vector_math_1.Vector4,
    name: 'Vector4',
    isAssignable: (v) => v is $vector_math_1.Vector4,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Vector4');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector4');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector4');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'Vector4');
        final w = D4.getRequiredArg<double>(positional, 3, 'w', 'Vector4');
        return $vector_math_1.Vector4(x, y, z, w);
      },
      'array': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector4');
        if (positional.isEmpty) {
          throw ArgumentError('Vector4: Missing required argument "array" at position 0');
        }
        final array = D4.coerceList<double>(positional[0], 'array');
        final offset = D4.getOptionalArgWithDefault<int>(positional, 1, 'offset', 0);
        return $vector_math_1.Vector4.array(array, offset);
      },
      'zero': (visitor, positional, named) {
        return $vector_math_1.Vector4.zero();
      },
      'identity': (visitor, positional, named) {
        return $vector_math_1.Vector4.identity();
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector4');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'Vector4');
        return $vector_math_1.Vector4.all(value);
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector4');
        final other = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'other', 'Vector4');
        return $vector_math_1.Vector4.copy(other);
      },
      'fromFloat64List': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Vector4');
        final v4storage = D4.getRequiredArg<Float64List>(positional, 0, '_v4storage', 'Vector4');
        return $vector_math_1.Vector4.fromFloat64List(v4storage);
      },
      'fromBuffer': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector4');
        final buffer = D4.getRequiredArg<ByteBuffer>(positional, 0, 'buffer', 'Vector4');
        final offset = D4.getRequiredArg<int>(positional, 1, 'offset', 'Vector4');
        return $vector_math_1.Vector4.fromBuffer(buffer, offset);
      },
      'random': (visitor, positional, named) {
        final rng = D4.getOptionalArg<$dart_math.Random?>(positional, 0, 'rng');
        return $vector_math_1.Vector4.random(rng);
      },
    },
    getters: {
      'storage': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').storage,
      'hashCode': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').hashCode,
      'length': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').length,
      'length2': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').length2,
      'isInfinite': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').isInfinite,
      'isNaN': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').isNaN,
      'xx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xx,
      'xy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xy,
      'xz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xz,
      'xw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xw,
      'yx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yx,
      'yy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yy,
      'yz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yz,
      'yw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yw,
      'zx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zx,
      'zy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zy,
      'zz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zz,
      'zw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zw,
      'wx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wx,
      'wy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wy,
      'wz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wz,
      'ww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ww,
      'xxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxx,
      'xxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxy,
      'xxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxz,
      'xxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxw,
      'xyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyx,
      'xyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyy,
      'xyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyz,
      'xyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyw,
      'xzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzx,
      'xzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzy,
      'xzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzz,
      'xzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzw,
      'xwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwx,
      'xwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwy,
      'xwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwz,
      'xww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xww,
      'yxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxx,
      'yxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxy,
      'yxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxz,
      'yxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxw,
      'yyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyx,
      'yyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyy,
      'yyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyz,
      'yyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyw,
      'yzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzx,
      'yzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzy,
      'yzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzz,
      'yzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzw,
      'ywx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywx,
      'ywy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywy,
      'ywz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywz,
      'yww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yww,
      'zxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxx,
      'zxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxy,
      'zxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxz,
      'zxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxw,
      'zyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyx,
      'zyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyy,
      'zyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyz,
      'zyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyw,
      'zzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzx,
      'zzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzy,
      'zzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzz,
      'zzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzw,
      'zwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwx,
      'zwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwy,
      'zwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwz,
      'zww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zww,
      'wxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxx,
      'wxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxy,
      'wxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxz,
      'wxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxw,
      'wyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyx,
      'wyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyy,
      'wyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyz,
      'wyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyw,
      'wzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzx,
      'wzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzy,
      'wzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzz,
      'wzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzw,
      'wwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwx,
      'wwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwy,
      'wwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwz,
      'www': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').www,
      'xxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxxx,
      'xxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxxy,
      'xxxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxxz,
      'xxxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxxw,
      'xxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxyx,
      'xxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxyy,
      'xxyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxyz,
      'xxyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxyw,
      'xxzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxzx,
      'xxzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxzy,
      'xxzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxzz,
      'xxzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxzw,
      'xxwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxwx,
      'xxwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxwy,
      'xxwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxwz,
      'xxww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xxww,
      'xyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyxx,
      'xyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyxy,
      'xyxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyxz,
      'xyxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyxw,
      'xyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyyx,
      'xyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyyy,
      'xyyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyyz,
      'xyyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyyw,
      'xyzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyzx,
      'xyzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyzy,
      'xyzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyzz,
      'xyzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyzw,
      'xywx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xywx,
      'xywy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xywy,
      'xywz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xywz,
      'xyww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyww,
      'xzxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzxx,
      'xzxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzxy,
      'xzxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzxz,
      'xzxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzxw,
      'xzyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzyx,
      'xzyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzyy,
      'xzyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzyz,
      'xzyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzyw,
      'xzzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzzx,
      'xzzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzzy,
      'xzzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzzz,
      'xzzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzzw,
      'xzwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzwx,
      'xzwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzwy,
      'xzwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzwz,
      'xzww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzww,
      'xwxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwxx,
      'xwxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwxy,
      'xwxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwxz,
      'xwxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwxw,
      'xwyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwyx,
      'xwyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwyy,
      'xwyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwyz,
      'xwyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwyw,
      'xwzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwzx,
      'xwzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwzy,
      'xwzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwzz,
      'xwzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwzw,
      'xwwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwwx,
      'xwwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwwy,
      'xwwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwwz,
      'xwww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwww,
      'yxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxxx,
      'yxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxxy,
      'yxxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxxz,
      'yxxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxxw,
      'yxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxyx,
      'yxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxyy,
      'yxyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxyz,
      'yxyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxyw,
      'yxzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxzx,
      'yxzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxzy,
      'yxzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxzz,
      'yxzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxzw,
      'yxwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxwx,
      'yxwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxwy,
      'yxwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxwz,
      'yxww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxww,
      'yyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyxx,
      'yyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyxy,
      'yyxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyxz,
      'yyxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyxw,
      'yyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyyx,
      'yyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyyy,
      'yyyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyyz,
      'yyyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyyw,
      'yyzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyzx,
      'yyzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyzy,
      'yyzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyzz,
      'yyzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyzw,
      'yywx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yywx,
      'yywy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yywy,
      'yywz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yywz,
      'yyww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yyww,
      'yzxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzxx,
      'yzxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzxy,
      'yzxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzxz,
      'yzxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzxw,
      'yzyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzyx,
      'yzyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzyy,
      'yzyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzyz,
      'yzyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzyw,
      'yzzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzzx,
      'yzzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzzy,
      'yzzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzzz,
      'yzzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzzw,
      'yzwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzwx,
      'yzwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzwy,
      'yzwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzwz,
      'yzww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzww,
      'ywxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywxx,
      'ywxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywxy,
      'ywxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywxz,
      'ywxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywxw,
      'ywyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywyx,
      'ywyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywyy,
      'ywyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywyz,
      'ywyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywyw,
      'ywzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywzx,
      'ywzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywzy,
      'ywzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywzz,
      'ywzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywzw,
      'ywwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywwx,
      'ywwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywwy,
      'ywwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywwz,
      'ywww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywww,
      'zxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxxx,
      'zxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxxy,
      'zxxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxxz,
      'zxxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxxw,
      'zxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxyx,
      'zxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxyy,
      'zxyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxyz,
      'zxyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxyw,
      'zxzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxzx,
      'zxzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxzy,
      'zxzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxzz,
      'zxzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxzw,
      'zxwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxwx,
      'zxwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxwy,
      'zxwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxwz,
      'zxww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxww,
      'zyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyxx,
      'zyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyxy,
      'zyxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyxz,
      'zyxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyxw,
      'zyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyyx,
      'zyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyyy,
      'zyyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyyz,
      'zyyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyyw,
      'zyzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyzx,
      'zyzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyzy,
      'zyzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyzz,
      'zyzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyzw,
      'zywx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zywx,
      'zywy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zywy,
      'zywz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zywz,
      'zyww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyww,
      'zzxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzxx,
      'zzxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzxy,
      'zzxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzxz,
      'zzxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzxw,
      'zzyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzyx,
      'zzyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzyy,
      'zzyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzyz,
      'zzyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzyw,
      'zzzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzzx,
      'zzzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzzy,
      'zzzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzzz,
      'zzzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzzw,
      'zzwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzwx,
      'zzwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzwy,
      'zzwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzwz,
      'zzww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zzww,
      'zwxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwxx,
      'zwxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwxy,
      'zwxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwxz,
      'zwxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwxw,
      'zwyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwyx,
      'zwyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwyy,
      'zwyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwyz,
      'zwyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwyw,
      'zwzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwzx,
      'zwzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwzy,
      'zwzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwzz,
      'zwzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwzw,
      'zwwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwwx,
      'zwwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwwy,
      'zwwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwwz,
      'zwww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwww,
      'wxxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxxx,
      'wxxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxxy,
      'wxxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxxz,
      'wxxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxxw,
      'wxyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxyx,
      'wxyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxyy,
      'wxyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxyz,
      'wxyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxyw,
      'wxzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxzx,
      'wxzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxzy,
      'wxzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxzz,
      'wxzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxzw,
      'wxwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxwx,
      'wxwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxwy,
      'wxwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxwz,
      'wxww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxww,
      'wyxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyxx,
      'wyxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyxy,
      'wyxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyxz,
      'wyxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyxw,
      'wyyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyyx,
      'wyyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyyy,
      'wyyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyyz,
      'wyyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyyw,
      'wyzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyzx,
      'wyzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyzy,
      'wyzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyzz,
      'wyzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyzw,
      'wywx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wywx,
      'wywy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wywy,
      'wywz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wywz,
      'wyww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyww,
      'wzxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzxx,
      'wzxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzxy,
      'wzxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzxz,
      'wzxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzxw,
      'wzyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzyx,
      'wzyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzyy,
      'wzyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzyz,
      'wzyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzyw,
      'wzzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzzx,
      'wzzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzzy,
      'wzzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzzz,
      'wzzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzzw,
      'wzwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzwx,
      'wzwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzwy,
      'wzwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzwz,
      'wzww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzww,
      'wwxx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwxx,
      'wwxy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwxy,
      'wwxz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwxz,
      'wwxw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwxw,
      'wwyx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwyx,
      'wwyy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwyy,
      'wwyz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwyz,
      'wwyw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwyw,
      'wwzx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwzx,
      'wwzy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwzy,
      'wwzz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwzz,
      'wwzw': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwzw,
      'wwwx': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwwx,
      'wwwy': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwwy,
      'wwwz': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwwz,
      'wwww': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wwww,
      'r': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').r,
      'g': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').g,
      'b': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').b,
      'a': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').a,
      's': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').s,
      't': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').t,
      'p': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').p,
      'q': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').q,
      'x': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').x,
      'y': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').y,
      'z': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').z,
      'w': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').w,
      'rr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rr,
      'rg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rg,
      'rb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rb,
      'ra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ra,
      'gr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gr,
      'gg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gg,
      'gb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gb,
      'ga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ga,
      'br': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').br,
      'bg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bg,
      'bb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bb,
      'ba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ba,
      'ar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ar,
      'ag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ag,
      'ab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ab,
      'aa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aa,
      'rrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrr,
      'rrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrg,
      'rrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrb,
      'rra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rra,
      'rgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgr,
      'rgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgg,
      'rgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgb,
      'rga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rga,
      'rbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbr,
      'rbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbg,
      'rbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbb,
      'rba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rba,
      'rar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rar,
      'rag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rag,
      'rab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rab,
      'raa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').raa,
      'grr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grr,
      'grg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grg,
      'grb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grb,
      'gra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gra,
      'ggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggr,
      'ggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggg,
      'ggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggb,
      'gga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gga,
      'gbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbr,
      'gbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbg,
      'gbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbb,
      'gba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gba,
      'gar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gar,
      'gag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gag,
      'gab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gab,
      'gaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gaa,
      'brr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brr,
      'brg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brg,
      'brb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brb,
      'bra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bra,
      'bgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgr,
      'bgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgg,
      'bgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgb,
      'bga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bga,
      'bbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbr,
      'bbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbg,
      'bbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbb,
      'bba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bba,
      'bar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bar,
      'bag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bag,
      'bab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bab,
      'baa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').baa,
      'arr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arr,
      'arg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arg,
      'arb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arb,
      'ara': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ara,
      'agr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agr,
      'agg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agg,
      'agb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agb,
      'aga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aga,
      'abr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abr,
      'abg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abg,
      'abb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abb,
      'aba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aba,
      'aar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aar,
      'aag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aag,
      'aab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aab,
      'aaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aaa,
      'rrrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrrr,
      'rrrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrrg,
      'rrrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrrb,
      'rrra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrra,
      'rrgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrgr,
      'rrgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrgg,
      'rrgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrgb,
      'rrga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrga,
      'rrbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrbr,
      'rrbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrbg,
      'rrbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrbb,
      'rrba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrba,
      'rrar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrar,
      'rrag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrag,
      'rrab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rrab,
      'rraa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rraa,
      'rgrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgrr,
      'rgrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgrg,
      'rgrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgrb,
      'rgra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgra,
      'rggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rggr,
      'rggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rggg,
      'rggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rggb,
      'rgga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgga,
      'rgbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgbr,
      'rgbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgbg,
      'rgbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgbb,
      'rgba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgba,
      'rgar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgar,
      'rgag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgag,
      'rgab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgab,
      'rgaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgaa,
      'rbrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbrr,
      'rbrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbrg,
      'rbrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbrb,
      'rbra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbra,
      'rbgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbgr,
      'rbgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbgg,
      'rbgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbgb,
      'rbga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbga,
      'rbbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbbr,
      'rbbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbbg,
      'rbbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbbb,
      'rbba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbba,
      'rbar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbar,
      'rbag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbag,
      'rbab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbab,
      'rbaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbaa,
      'rarr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rarr,
      'rarg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rarg,
      'rarb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rarb,
      'rara': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rara,
      'ragr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ragr,
      'ragg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ragg,
      'ragb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ragb,
      'raga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').raga,
      'rabr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rabr,
      'rabg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rabg,
      'rabb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rabb,
      'raba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').raba,
      'raar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').raar,
      'raag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').raag,
      'raab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').raab,
      'raaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').raaa,
      'grrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grrr,
      'grrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grrg,
      'grrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grrb,
      'grra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grra,
      'grgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grgr,
      'grgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grgg,
      'grgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grgb,
      'grga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grga,
      'grbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grbr,
      'grbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grbg,
      'grbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grbb,
      'grba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grba,
      'grar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grar,
      'grag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grag,
      'grab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grab,
      'graa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').graa,
      'ggrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggrr,
      'ggrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggrg,
      'ggrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggrb,
      'ggra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggra,
      'gggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gggr,
      'gggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gggg,
      'gggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gggb,
      'ggga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggga,
      'ggbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggbr,
      'ggbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggbg,
      'ggbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggbb,
      'ggba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggba,
      'ggar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggar,
      'ggag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggag,
      'ggab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggab,
      'ggaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ggaa,
      'gbrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbrr,
      'gbrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbrg,
      'gbrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbrb,
      'gbra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbra,
      'gbgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbgr,
      'gbgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbgg,
      'gbgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbgb,
      'gbga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbga,
      'gbbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbbr,
      'gbbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbbg,
      'gbbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbbb,
      'gbba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbba,
      'gbar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbar,
      'gbag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbag,
      'gbab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbab,
      'gbaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbaa,
      'garr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').garr,
      'garg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').garg,
      'garb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').garb,
      'gara': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gara,
      'gagr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gagr,
      'gagg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gagg,
      'gagb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gagb,
      'gaga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gaga,
      'gabr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gabr,
      'gabg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gabg,
      'gabb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gabb,
      'gaba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gaba,
      'gaar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gaar,
      'gaag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gaag,
      'gaab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gaab,
      'gaaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gaaa,
      'brrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brrr,
      'brrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brrg,
      'brrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brrb,
      'brra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brra,
      'brgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brgr,
      'brgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brgg,
      'brgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brgb,
      'brga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brga,
      'brbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brbr,
      'brbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brbg,
      'brbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brbb,
      'brba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brba,
      'brar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brar,
      'brag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brag,
      'brab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brab,
      'braa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').braa,
      'bgrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgrr,
      'bgrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgrg,
      'bgrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgrb,
      'bgra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgra,
      'bggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bggr,
      'bggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bggg,
      'bggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bggb,
      'bgga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgga,
      'bgbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgbr,
      'bgbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgbg,
      'bgbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgbb,
      'bgba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgba,
      'bgar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgar,
      'bgag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgag,
      'bgab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgab,
      'bgaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgaa,
      'bbrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbrr,
      'bbrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbrg,
      'bbrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbrb,
      'bbra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbra,
      'bbgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbgr,
      'bbgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbgg,
      'bbgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbgb,
      'bbga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbga,
      'bbbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbbr,
      'bbbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbbg,
      'bbbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbbb,
      'bbba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbba,
      'bbar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbar,
      'bbag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbag,
      'bbab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbab,
      'bbaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bbaa,
      'barr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').barr,
      'barg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').barg,
      'barb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').barb,
      'bara': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bara,
      'bagr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bagr,
      'bagg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bagg,
      'bagb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bagb,
      'baga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').baga,
      'babr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').babr,
      'babg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').babg,
      'babb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').babb,
      'baba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').baba,
      'baar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').baar,
      'baag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').baag,
      'baab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').baab,
      'baaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').baaa,
      'arrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arrr,
      'arrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arrg,
      'arrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arrb,
      'arra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arra,
      'argr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').argr,
      'argg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').argg,
      'argb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').argb,
      'arga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arga,
      'arbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arbr,
      'arbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arbg,
      'arbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arbb,
      'arba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arba,
      'arar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arar,
      'arag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arag,
      'arab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arab,
      'araa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').araa,
      'agrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agrr,
      'agrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agrg,
      'agrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agrb,
      'agra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agra,
      'aggr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aggr,
      'aggg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aggg,
      'aggb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aggb,
      'agga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agga,
      'agbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agbr,
      'agbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agbg,
      'agbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agbb,
      'agba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agba,
      'agar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agar,
      'agag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agag,
      'agab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agab,
      'agaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agaa,
      'abrr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abrr,
      'abrg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abrg,
      'abrb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abrb,
      'abra': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abra,
      'abgr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abgr,
      'abgg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abgg,
      'abgb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abgb,
      'abga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abga,
      'abbr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abbr,
      'abbg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abbg,
      'abbb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abbb,
      'abba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abba,
      'abar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abar,
      'abag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abag,
      'abab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abab,
      'abaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abaa,
      'aarr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aarr,
      'aarg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aarg,
      'aarb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aarb,
      'aara': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aara,
      'aagr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aagr,
      'aagg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aagg,
      'aagb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aagb,
      'aaga': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aaga,
      'aabr': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aabr,
      'aabg': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aabg,
      'aabb': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aabb,
      'aaba': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aaba,
      'aaar': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aaar,
      'aaag': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aaag,
      'aaab': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aaab,
      'aaaa': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').aaaa,
      'ss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ss,
      'st': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').st,
      'sp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sp,
      'sq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sq,
      'ts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ts,
      'tt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tt,
      'tp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tp,
      'tq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tq,
      'ps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ps,
      'pt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pt,
      'pp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pp,
      'pq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pq,
      'qs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qs,
      'qt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qt,
      'qp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qp,
      'qq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qq,
      'sss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sss,
      'sst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sst,
      'ssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssp,
      'ssq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssq,
      'sts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sts,
      'stt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stt,
      'stp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stp,
      'stq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stq,
      'sps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sps,
      'spt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spt,
      'spp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spp,
      'spq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spq,
      'sqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqs,
      'sqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqt,
      'sqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqp,
      'sqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqq,
      'tss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tss,
      'tst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tst,
      'tsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsp,
      'tsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsq,
      'tts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tts,
      'ttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttt,
      'ttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttp,
      'ttq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttq,
      'tps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tps,
      'tpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpt,
      'tpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpp,
      'tpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpq,
      'tqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqs,
      'tqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqt,
      'tqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqp,
      'tqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqq,
      'pss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pss,
      'pst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pst,
      'psp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psp,
      'psq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psq,
      'pts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pts,
      'ptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptt,
      'ptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptp,
      'ptq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptq,
      'pps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pps,
      'ppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppt,
      'ppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppp,
      'ppq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppq,
      'pqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqs,
      'pqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqt,
      'pqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqp,
      'pqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqq,
      'qss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qss,
      'qst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qst,
      'qsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsp,
      'qsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsq,
      'qts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qts,
      'qtt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtt,
      'qtp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtp,
      'qtq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtq,
      'qps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qps,
      'qpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpt,
      'qpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpp,
      'qpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpq,
      'qqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqs,
      'qqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqt,
      'qqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqp,
      'qqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqq,
      'ssss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssss,
      'ssst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssst,
      'sssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sssp,
      'sssq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sssq,
      'ssts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssts,
      'sstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sstt,
      'sstp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sstp,
      'sstq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sstq,
      'ssps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssps,
      'sspt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sspt,
      'sspp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sspp,
      'sspq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sspq,
      'ssqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssqs,
      'ssqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssqt,
      'ssqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssqp,
      'ssqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ssqq,
      'stss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stss,
      'stst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stst,
      'stsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stsp,
      'stsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stsq,
      'stts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stts,
      'sttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sttt,
      'sttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sttp,
      'sttq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sttq,
      'stps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stps,
      'stpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stpt,
      'stpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stpp,
      'stpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stpq,
      'stqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stqs,
      'stqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stqt,
      'stqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stqp,
      'stqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stqq,
      'spss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spss,
      'spst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spst,
      'spsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spsp,
      'spsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spsq,
      'spts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spts,
      'sptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sptt,
      'sptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sptp,
      'sptq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sptq,
      'spps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spps,
      'sppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sppt,
      'sppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sppp,
      'sppq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sppq,
      'spqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spqs,
      'spqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spqt,
      'spqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spqp,
      'spqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spqq,
      'sqss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqss,
      'sqst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqst,
      'sqsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqsp,
      'sqsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqsq,
      'sqts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqts,
      'sqtt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqtt,
      'sqtp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqtp,
      'sqtq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqtq,
      'sqps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqps,
      'sqpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqpt,
      'sqpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqpp,
      'sqpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqpq,
      'sqqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqqs,
      'sqqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqqt,
      'sqqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqqp,
      'sqqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqqq,
      'tsss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsss,
      'tsst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsst,
      'tssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tssp,
      'tssq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tssq,
      'tsts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsts,
      'tstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tstt,
      'tstp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tstp,
      'tstq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tstq,
      'tsps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsps,
      'tspt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tspt,
      'tspp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tspp,
      'tspq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tspq,
      'tsqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsqs,
      'tsqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsqt,
      'tsqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsqp,
      'tsqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsqq,
      'ttss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttss,
      'ttst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttst,
      'ttsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttsp,
      'ttsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttsq,
      'ttts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttts,
      'tttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tttt,
      'tttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tttp,
      'tttq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tttq,
      'ttps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttps,
      'ttpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttpt,
      'ttpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttpp,
      'ttpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttpq,
      'ttqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttqs,
      'ttqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttqt,
      'ttqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttqp,
      'ttqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ttqq,
      'tpss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpss,
      'tpst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpst,
      'tpsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpsp,
      'tpsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpsq,
      'tpts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpts,
      'tptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tptt,
      'tptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tptp,
      'tptq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tptq,
      'tpps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpps,
      'tppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tppt,
      'tppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tppp,
      'tppq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tppq,
      'tpqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpqs,
      'tpqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpqt,
      'tpqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpqp,
      'tpqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpqq,
      'tqss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqss,
      'tqst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqst,
      'tqsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqsp,
      'tqsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqsq,
      'tqts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqts,
      'tqtt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqtt,
      'tqtp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqtp,
      'tqtq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqtq,
      'tqps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqps,
      'tqpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqpt,
      'tqpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqpp,
      'tqpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqpq,
      'tqqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqqs,
      'tqqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqqt,
      'tqqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqqp,
      'tqqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqqq,
      'psss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psss,
      'psst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psst,
      'pssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pssp,
      'pssq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pssq,
      'psts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psts,
      'pstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pstt,
      'pstp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pstp,
      'pstq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pstq,
      'psps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psps,
      'pspt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pspt,
      'pspp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pspp,
      'pspq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pspq,
      'psqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psqs,
      'psqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psqt,
      'psqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psqp,
      'psqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psqq,
      'ptss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptss,
      'ptst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptst,
      'ptsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptsp,
      'ptsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptsq,
      'ptts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptts,
      'pttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pttt,
      'pttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pttp,
      'pttq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pttq,
      'ptps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptps,
      'ptpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptpt,
      'ptpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptpp,
      'ptpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptpq,
      'ptqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptqs,
      'ptqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptqt,
      'ptqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptqp,
      'ptqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptqq,
      'ppss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppss,
      'ppst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppst,
      'ppsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppsp,
      'ppsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppsq,
      'ppts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppts,
      'pptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pptt,
      'pptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pptp,
      'pptq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pptq,
      'ppps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppps,
      'pppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pppt,
      'pppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pppp,
      'pppq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pppq,
      'ppqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppqs,
      'ppqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppqt,
      'ppqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppqp,
      'ppqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ppqq,
      'pqss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqss,
      'pqst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqst,
      'pqsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqsp,
      'pqsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqsq,
      'pqts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqts,
      'pqtt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqtt,
      'pqtp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqtp,
      'pqtq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqtq,
      'pqps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqps,
      'pqpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqpt,
      'pqpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqpp,
      'pqpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqpq,
      'pqqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqqs,
      'pqqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqqt,
      'pqqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqqp,
      'pqqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqqq,
      'qsss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsss,
      'qsst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsst,
      'qssp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qssp,
      'qssq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qssq,
      'qsts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsts,
      'qstt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qstt,
      'qstp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qstp,
      'qstq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qstq,
      'qsps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsps,
      'qspt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qspt,
      'qspp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qspp,
      'qspq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qspq,
      'qsqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsqs,
      'qsqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsqt,
      'qsqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsqp,
      'qsqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsqq,
      'qtss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtss,
      'qtst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtst,
      'qtsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtsp,
      'qtsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtsq,
      'qtts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtts,
      'qttt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qttt,
      'qttp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qttp,
      'qttq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qttq,
      'qtps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtps,
      'qtpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtpt,
      'qtpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtpp,
      'qtpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtpq,
      'qtqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtqs,
      'qtqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtqt,
      'qtqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtqp,
      'qtqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtqq,
      'qpss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpss,
      'qpst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpst,
      'qpsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpsp,
      'qpsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpsq,
      'qpts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpts,
      'qptt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qptt,
      'qptp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qptp,
      'qptq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qptq,
      'qpps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpps,
      'qppt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qppt,
      'qppp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qppp,
      'qppq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qppq,
      'qpqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpqs,
      'qpqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpqt,
      'qpqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpqp,
      'qpqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpqq,
      'qqss': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqss,
      'qqst': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqst,
      'qqsp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqsp,
      'qqsq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqsq,
      'qqts': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqts,
      'qqtt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqtt,
      'qqtp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqtp,
      'qqtq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqtq,
      'qqps': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqps,
      'qqpt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqpt,
      'qqpp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqpp,
      'qqpq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqpq,
      'qqqs': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqqs,
      'qqqt': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqqt,
      'qqqp': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqqp,
      'qqqq': (visitor, target) => D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qqqq,
    },
    setters: {
      'length': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').length = D4.extractBridgedArg<double>(value, 'length'),
      'xy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xy = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'xy'),
      'xz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xz = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'xz'),
      'xw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xw = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'xw'),
      'yx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yx = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'yx'),
      'yz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yz = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'yz'),
      'yw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yw = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'yw'),
      'zx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zx = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'zx'),
      'zy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zy = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'zy'),
      'zw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zw = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'zw'),
      'wx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wx = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'wx'),
      'wy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wy = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'wy'),
      'wz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wz = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'wz'),
      'xyz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xyz'),
      'xyw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyw = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xyw'),
      'xzy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xzy'),
      'xzw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzw = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xzw'),
      'xwy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xwy'),
      'xwz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'xwz'),
      'yxz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'yxz'),
      'yxw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxw = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'yxw'),
      'yzx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'yzx'),
      'yzw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzw = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'yzw'),
      'ywx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'ywx'),
      'ywz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'ywz'),
      'zxy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zxy'),
      'zxw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxw = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zxw'),
      'zyx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zyx'),
      'zyw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyw = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zyw'),
      'zwx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zwx'),
      'zwy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'zwy'),
      'wxy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'wxy'),
      'wxz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'wxz'),
      'wyx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'wyx'),
      'wyz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyz = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'wyz'),
      'wzx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzx = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'wzx'),
      'wzy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzy = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'wzy'),
      'xyzw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xyzw = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'xyzw'),
      'xywz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xywz = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'xywz'),
      'xzyw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzyw = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'xzyw'),
      'xzwy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xzwy = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'xzwy'),
      'xwyz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwyz = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'xwyz'),
      'xwzy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').xwzy = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'xwzy'),
      'yxzw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxzw = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'yxzw'),
      'yxwz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yxwz = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'yxwz'),
      'yzxw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzxw = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'yzxw'),
      'yzwx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').yzwx = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'yzwx'),
      'ywxz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywxz = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'ywxz'),
      'ywzx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ywzx = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'ywzx'),
      'zxyw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxyw = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'zxyw'),
      'zxwy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zxwy = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'zxwy'),
      'zyxw': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zyxw = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'zyxw'),
      'zywx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zywx = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'zywx'),
      'zwxy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwxy = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'zwxy'),
      'zwyx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').zwyx = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'zwyx'),
      'wxyz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxyz = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'wxyz'),
      'wxzy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wxzy = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'wxzy'),
      'wyxz': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyxz = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'wyxz'),
      'wyzx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wyzx = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'wyzx'),
      'wzxy': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzxy = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'wzxy'),
      'wzyx': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').wzyx = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'wzyx'),
      'r': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').r = D4.extractBridgedArg<double>(value, 'r'),
      'g': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').g = D4.extractBridgedArg<double>(value, 'g'),
      'b': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').b = D4.extractBridgedArg<double>(value, 'b'),
      'a': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').a = D4.extractBridgedArg<double>(value, 'a'),
      's': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').s = D4.extractBridgedArg<double>(value, 's'),
      't': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').t = D4.extractBridgedArg<double>(value, 't'),
      'p': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').p = D4.extractBridgedArg<double>(value, 'p'),
      'q': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').q = D4.extractBridgedArg<double>(value, 'q'),
      'x': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').x = D4.extractBridgedArg<double>(value, 'x'),
      'y': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').y = D4.extractBridgedArg<double>(value, 'y'),
      'z': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').z = D4.extractBridgedArg<double>(value, 'z'),
      'w': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').w = D4.extractBridgedArg<double>(value, 'w'),
      'rg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rg = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'rg'),
      'rb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rb = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'rb'),
      'ra': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ra = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ra'),
      'gr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gr = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'gr'),
      'gb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gb = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'gb'),
      'ga': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ga = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ga'),
      'br': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').br = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'br'),
      'bg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bg = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'bg'),
      'ba': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ba = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ba'),
      'ar': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ar = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ar'),
      'ag': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ag = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ag'),
      'ab': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ab = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ab'),
      'rgb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgb = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rgb'),
      'rga': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rga = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rga'),
      'rbg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbg = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rbg'),
      'rba': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rba = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rba'),
      'rag': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rag = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rag'),
      'rab': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rab = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'rab'),
      'grb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grb = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'grb'),
      'gra': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gra = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'gra'),
      'gbr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbr = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'gbr'),
      'gba': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gba = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'gba'),
      'gar': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gar = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'gar'),
      'gab': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gab = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'gab'),
      'brg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brg = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'brg'),
      'bra': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bra = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'bra'),
      'bgr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgr = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'bgr'),
      'bga': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bga = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'bga'),
      'bar': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bar = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'bar'),
      'bag': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bag = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'bag'),
      'arg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arg = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'arg'),
      'arb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arb = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'arb'),
      'agr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agr = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'agr'),
      'agb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agb = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'agb'),
      'abr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abr = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'abr'),
      'abg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abg = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'abg'),
      'rgba': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgba = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'rgba'),
      'rgab': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rgab = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'rgab'),
      'rbga': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbga = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'rbga'),
      'rbag': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rbag = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'rbag'),
      'ragb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ragb = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'ragb'),
      'rabg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').rabg = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'rabg'),
      'grba': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grba = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'grba'),
      'grab': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').grab = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'grab'),
      'gbra': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbra = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'gbra'),
      'gbar': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gbar = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'gbar'),
      'garb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').garb = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'garb'),
      'gabr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').gabr = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'gabr'),
      'brga': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brga = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'brga'),
      'brag': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').brag = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'brag'),
      'bgra': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgra = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'bgra'),
      'bgar': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bgar = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'bgar'),
      'barg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').barg = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'barg'),
      'bagr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').bagr = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'bagr'),
      'argb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').argb = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'argb'),
      'arbg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').arbg = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'arbg'),
      'agrb': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agrb = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'agrb'),
      'agbr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').agbr = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'agbr'),
      'abrg': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abrg = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'abrg'),
      'abgr': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').abgr = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'abgr'),
      'st': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').st = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'st'),
      'sp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sp = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'sp'),
      'sq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sq = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'sq'),
      'ts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ts = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ts'),
      'tp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tp = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'tp'),
      'tq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tq = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'tq'),
      'ps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ps = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'ps'),
      'pt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pt = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'pt'),
      'pq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pq = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'pq'),
      'qs': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qs = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'qs'),
      'qt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qt = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'qt'),
      'qp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qp = D4.extractBridgedArg<$vector_math_1.Vector2>(value, 'qp'),
      'stp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'stp'),
      'stq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stq = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'stq'),
      'spt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spt = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'spt'),
      'spq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spq = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'spq'),
      'sqt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqt = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'sqt'),
      'sqp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'sqp'),
      'tsp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tsp'),
      'tsq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsq = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tsq'),
      'tps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tps = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tps'),
      'tpq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpq = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tpq'),
      'tqs': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqs = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tqs'),
      'tqp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'tqp'),
      'pst': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pst = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'pst'),
      'psq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psq = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'psq'),
      'pts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pts = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'pts'),
      'ptq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptq = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'ptq'),
      'pqs': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqs = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'pqs'),
      'pqt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqt = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'pqt'),
      'qst': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qst = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'qst'),
      'qsp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qsp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'qsp'),
      'qts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qts = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'qts'),
      'qtp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtp = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'qtp'),
      'qps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qps = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'qps'),
      'qpt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpt = D4.extractBridgedArg<$vector_math_1.Vector3>(value, 'qpt'),
      'stpq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stpq = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'stpq'),
      'stqp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').stqp = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'stqp'),
      'sptq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sptq = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'sptq'),
      'spqt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').spqt = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'spqt'),
      'sqtp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqtp = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'sqtp'),
      'sqpt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').sqpt = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'sqpt'),
      'tspq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tspq = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'tspq'),
      'tsqp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tsqp = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'tsqp'),
      'tpsq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpsq = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'tpsq'),
      'tpqs': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tpqs = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'tpqs'),
      'tqsp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqsp = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'tqsp'),
      'tqps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').tqps = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'tqps'),
      'pstq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pstq = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'pstq'),
      'psqt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').psqt = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'psqt'),
      'ptsq': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptsq = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'ptsq'),
      'ptqs': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').ptqs = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'ptqs'),
      'pqst': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqst = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'pqst'),
      'pqts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').pqts = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'pqts'),
      'qstp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qstp = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'qstp'),
      'qspt': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qspt = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'qspt'),
      'qtsp': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtsp = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'qtsp'),
      'qtps': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qtps = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'qtps'),
      'qpst': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpst = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'qpst'),
      'qpts': (visitor, target, value) => 
        D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4').qpts = D4.extractBridgedArg<$vector_math_1.Vector4>(value, 'qpts'),
    },
    methods: {
      'setValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 4, 'setValues');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'setValues');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'setValues');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'setValues');
        final w = D4.getRequiredArg<double>(positional, 3, 'w', 'setValues');
        t.setValues(x, y, z, w);
        return null;
      },
      'setZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.setZero();
        return null;
      },
      'setIdentity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.setIdentity();
        return null;
      },
      'setFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'setFrom');
        final other = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'other', 'setFrom');
        t.setFrom(other);
        return null;
      },
      'splat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'splat');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'splat');
        t.splat(arg);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        return t.toString();
      },
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        return t.normalize();
      },
      'normalizeLength': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        return t.normalizeLength();
      },
      'normalized': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        return t.normalized();
      },
      'normalizeInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'normalizeInto');
        final out = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'out', 'normalizeInto');
        return t.normalizeInto(out);
      },
      'distanceTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'distanceTo');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'distanceTo');
        return t.distanceTo(arg);
      },
      'distanceToSquared': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'distanceToSquared');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'distanceToSquared');
        return t.distanceToSquared(arg);
      },
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'applyMatrix4': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'applyMatrix4');
        final arg = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'arg', 'applyMatrix4');
        t.applyMatrix4(arg);
        return null;
      },
      'relativeError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'relativeError');
        final correct = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'correct', 'relativeError');
        return t.relativeError(correct);
      },
      'absoluteError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'absoluteError');
        final correct = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'correct', 'absoluteError');
        return t.absoluteError(correct);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'add');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'add');
        t.add(arg);
        return null;
      },
      'addScaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 2, 'addScaled');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'addScaled');
        final factor = D4.getRequiredArg<double>(positional, 1, 'factor', 'addScaled');
        t.addScaled(arg, factor);
        return null;
      },
      'sub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'sub');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'sub');
        t.sub(arg);
        return null;
      },
      'multiply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'multiply');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'multiply');
        t.multiply(arg);
        return null;
      },
      'div': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'div');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'div');
        t.div(arg);
        return null;
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'scale');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'scale');
        t.scale(arg);
        return null;
      },
      'scaled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'scaled');
        final arg = D4.getRequiredArg<double>(positional, 0, 'arg', 'scaled');
        return t.scaled(arg);
      },
      'negate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.negate();
        return null;
      },
      'absolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.absolute();
        return null;
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'max', 'clamp');
        t.clamp(min, max);
        return null;
      },
      'clampScalar': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 2, 'clampScalar');
        final min = D4.getRequiredArg<double>(positional, 0, 'min', 'clampScalar');
        final max = D4.getRequiredArg<double>(positional, 1, 'max', 'clampScalar');
        t.clampScalar(min, max);
        return null;
      },
      'floor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.floor();
        return null;
      },
      'ceil': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.ceil();
        return null;
      },
      'round': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.round();
        return null;
      },
      'roundToZero': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        t.roundToZero();
        return null;
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        return t.clone();
      },
      'copyInto': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        D4.requireMinArgs(positional, 1, 'copyInto');
        final arg = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'arg', 'copyInto');
        return t.copyInto(arg);
      },
      'copyIntoArray': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
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
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
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
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        final other = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$vector_math_1.Vector4>(target, 'Vector4');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticMethods: {
      'min': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'min');
        final a = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'a', 'min');
        final b = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'b', 'min');
        final result = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 2, 'result', 'min');
        return $vector_math_1.Vector4.min(a, b, result);
      },
      'max': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'max');
        final a = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'a', 'max');
        final b = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'b', 'max');
        final result = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 2, 'result', 'max');
        return $vector_math_1.Vector4.max(a, b, result);
      },
      'mix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'mix');
        final min = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 0, 'min', 'mix');
        final max = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 1, 'max', 'mix');
        final a = D4.getRequiredArg<double>(positional, 2, 'a', 'mix');
        final result = D4.getRequiredArg<$vector_math_1.Vector4>(positional, 3, 'result', 'mix');
        return $vector_math_1.Vector4.mix(min, max, a, result);
      },
    },
    constructorSignatures: {
      '': 'factory Vector4(double x, double y, double z, double w)',
      'array': 'factory Vector4.array(List<double> array, [int offset = 0])',
      'zero': 'Vector4.zero()',
      'identity': 'factory Vector4.identity()',
      'all': 'factory Vector4.all(double value)',
      'copy': 'factory Vector4.copy(Vector4 other)',
      'fromFloat64List': 'Vector4.fromFloat64List(Float64List _v4storage)',
      'fromBuffer': 'Vector4.fromBuffer(ByteBuffer buffer, int offset)',
      'random': 'factory Vector4.random([math.Random? rng])',
    },
    methodSignatures: {
      'setValues': 'void setValues(double x, double y, double z, double w)',
      'setZero': 'void setZero()',
      'setIdentity': 'void setIdentity()',
      'setFrom': 'void setFrom(Vector4 other)',
      'splat': 'void splat(double arg)',
      'toString': 'String toString()',
      'normalize': 'double normalize()',
      'normalizeLength': 'double normalizeLength()',
      'normalized': 'Vector4 normalized()',
      'normalizeInto': 'Vector4 normalizeInto(Vector4 out)',
      'distanceTo': 'double distanceTo(Vector4 arg)',
      'distanceToSquared': 'double distanceToSquared(Vector4 arg)',
      'dot': 'double dot(Vector4 other)',
      'applyMatrix4': 'void applyMatrix4(Matrix4 arg)',
      'relativeError': 'double relativeError(Vector4 correct)',
      'absoluteError': 'double absoluteError(Vector4 correct)',
      'add': 'void add(Vector4 arg)',
      'addScaled': 'void addScaled(Vector4 arg, double factor)',
      'sub': 'void sub(Vector4 arg)',
      'multiply': 'void multiply(Vector4 arg)',
      'div': 'void div(Vector4 arg)',
      'scale': 'void scale(double arg)',
      'scaled': 'Vector4 scaled(double arg)',
      'negate': 'void negate()',
      'absolute': 'void absolute()',
      'clamp': 'void clamp(Vector4 min, Vector4 max)',
      'clampScalar': 'void clampScalar(double min, double max)',
      'floor': 'void floor()',
      'ceil': 'void ceil()',
      'round': 'void round()',
      'roundToZero': 'void roundToZero()',
      'clone': 'Vector4 clone()',
      'copyInto': 'Vector4 copyInto(Vector4 arg)',
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
      'xw': 'Vector2 get xw',
      'yx': 'Vector2 get yx',
      'yy': 'Vector2 get yy',
      'yz': 'Vector2 get yz',
      'yw': 'Vector2 get yw',
      'zx': 'Vector2 get zx',
      'zy': 'Vector2 get zy',
      'zz': 'Vector2 get zz',
      'zw': 'Vector2 get zw',
      'wx': 'Vector2 get wx',
      'wy': 'Vector2 get wy',
      'wz': 'Vector2 get wz',
      'ww': 'Vector2 get ww',
      'xxx': 'Vector3 get xxx',
      'xxy': 'Vector3 get xxy',
      'xxz': 'Vector3 get xxz',
      'xxw': 'Vector3 get xxw',
      'xyx': 'Vector3 get xyx',
      'xyy': 'Vector3 get xyy',
      'xyz': 'Vector3 get xyz',
      'xyw': 'Vector3 get xyw',
      'xzx': 'Vector3 get xzx',
      'xzy': 'Vector3 get xzy',
      'xzz': 'Vector3 get xzz',
      'xzw': 'Vector3 get xzw',
      'xwx': 'Vector3 get xwx',
      'xwy': 'Vector3 get xwy',
      'xwz': 'Vector3 get xwz',
      'xww': 'Vector3 get xww',
      'yxx': 'Vector3 get yxx',
      'yxy': 'Vector3 get yxy',
      'yxz': 'Vector3 get yxz',
      'yxw': 'Vector3 get yxw',
      'yyx': 'Vector3 get yyx',
      'yyy': 'Vector3 get yyy',
      'yyz': 'Vector3 get yyz',
      'yyw': 'Vector3 get yyw',
      'yzx': 'Vector3 get yzx',
      'yzy': 'Vector3 get yzy',
      'yzz': 'Vector3 get yzz',
      'yzw': 'Vector3 get yzw',
      'ywx': 'Vector3 get ywx',
      'ywy': 'Vector3 get ywy',
      'ywz': 'Vector3 get ywz',
      'yww': 'Vector3 get yww',
      'zxx': 'Vector3 get zxx',
      'zxy': 'Vector3 get zxy',
      'zxz': 'Vector3 get zxz',
      'zxw': 'Vector3 get zxw',
      'zyx': 'Vector3 get zyx',
      'zyy': 'Vector3 get zyy',
      'zyz': 'Vector3 get zyz',
      'zyw': 'Vector3 get zyw',
      'zzx': 'Vector3 get zzx',
      'zzy': 'Vector3 get zzy',
      'zzz': 'Vector3 get zzz',
      'zzw': 'Vector3 get zzw',
      'zwx': 'Vector3 get zwx',
      'zwy': 'Vector3 get zwy',
      'zwz': 'Vector3 get zwz',
      'zww': 'Vector3 get zww',
      'wxx': 'Vector3 get wxx',
      'wxy': 'Vector3 get wxy',
      'wxz': 'Vector3 get wxz',
      'wxw': 'Vector3 get wxw',
      'wyx': 'Vector3 get wyx',
      'wyy': 'Vector3 get wyy',
      'wyz': 'Vector3 get wyz',
      'wyw': 'Vector3 get wyw',
      'wzx': 'Vector3 get wzx',
      'wzy': 'Vector3 get wzy',
      'wzz': 'Vector3 get wzz',
      'wzw': 'Vector3 get wzw',
      'wwx': 'Vector3 get wwx',
      'wwy': 'Vector3 get wwy',
      'wwz': 'Vector3 get wwz',
      'www': 'Vector3 get www',
      'xxxx': 'Vector4 get xxxx',
      'xxxy': 'Vector4 get xxxy',
      'xxxz': 'Vector4 get xxxz',
      'xxxw': 'Vector4 get xxxw',
      'xxyx': 'Vector4 get xxyx',
      'xxyy': 'Vector4 get xxyy',
      'xxyz': 'Vector4 get xxyz',
      'xxyw': 'Vector4 get xxyw',
      'xxzx': 'Vector4 get xxzx',
      'xxzy': 'Vector4 get xxzy',
      'xxzz': 'Vector4 get xxzz',
      'xxzw': 'Vector4 get xxzw',
      'xxwx': 'Vector4 get xxwx',
      'xxwy': 'Vector4 get xxwy',
      'xxwz': 'Vector4 get xxwz',
      'xxww': 'Vector4 get xxww',
      'xyxx': 'Vector4 get xyxx',
      'xyxy': 'Vector4 get xyxy',
      'xyxz': 'Vector4 get xyxz',
      'xyxw': 'Vector4 get xyxw',
      'xyyx': 'Vector4 get xyyx',
      'xyyy': 'Vector4 get xyyy',
      'xyyz': 'Vector4 get xyyz',
      'xyyw': 'Vector4 get xyyw',
      'xyzx': 'Vector4 get xyzx',
      'xyzy': 'Vector4 get xyzy',
      'xyzz': 'Vector4 get xyzz',
      'xyzw': 'Vector4 get xyzw',
      'xywx': 'Vector4 get xywx',
      'xywy': 'Vector4 get xywy',
      'xywz': 'Vector4 get xywz',
      'xyww': 'Vector4 get xyww',
      'xzxx': 'Vector4 get xzxx',
      'xzxy': 'Vector4 get xzxy',
      'xzxz': 'Vector4 get xzxz',
      'xzxw': 'Vector4 get xzxw',
      'xzyx': 'Vector4 get xzyx',
      'xzyy': 'Vector4 get xzyy',
      'xzyz': 'Vector4 get xzyz',
      'xzyw': 'Vector4 get xzyw',
      'xzzx': 'Vector4 get xzzx',
      'xzzy': 'Vector4 get xzzy',
      'xzzz': 'Vector4 get xzzz',
      'xzzw': 'Vector4 get xzzw',
      'xzwx': 'Vector4 get xzwx',
      'xzwy': 'Vector4 get xzwy',
      'xzwz': 'Vector4 get xzwz',
      'xzww': 'Vector4 get xzww',
      'xwxx': 'Vector4 get xwxx',
      'xwxy': 'Vector4 get xwxy',
      'xwxz': 'Vector4 get xwxz',
      'xwxw': 'Vector4 get xwxw',
      'xwyx': 'Vector4 get xwyx',
      'xwyy': 'Vector4 get xwyy',
      'xwyz': 'Vector4 get xwyz',
      'xwyw': 'Vector4 get xwyw',
      'xwzx': 'Vector4 get xwzx',
      'xwzy': 'Vector4 get xwzy',
      'xwzz': 'Vector4 get xwzz',
      'xwzw': 'Vector4 get xwzw',
      'xwwx': 'Vector4 get xwwx',
      'xwwy': 'Vector4 get xwwy',
      'xwwz': 'Vector4 get xwwz',
      'xwww': 'Vector4 get xwww',
      'yxxx': 'Vector4 get yxxx',
      'yxxy': 'Vector4 get yxxy',
      'yxxz': 'Vector4 get yxxz',
      'yxxw': 'Vector4 get yxxw',
      'yxyx': 'Vector4 get yxyx',
      'yxyy': 'Vector4 get yxyy',
      'yxyz': 'Vector4 get yxyz',
      'yxyw': 'Vector4 get yxyw',
      'yxzx': 'Vector4 get yxzx',
      'yxzy': 'Vector4 get yxzy',
      'yxzz': 'Vector4 get yxzz',
      'yxzw': 'Vector4 get yxzw',
      'yxwx': 'Vector4 get yxwx',
      'yxwy': 'Vector4 get yxwy',
      'yxwz': 'Vector4 get yxwz',
      'yxww': 'Vector4 get yxww',
      'yyxx': 'Vector4 get yyxx',
      'yyxy': 'Vector4 get yyxy',
      'yyxz': 'Vector4 get yyxz',
      'yyxw': 'Vector4 get yyxw',
      'yyyx': 'Vector4 get yyyx',
      'yyyy': 'Vector4 get yyyy',
      'yyyz': 'Vector4 get yyyz',
      'yyyw': 'Vector4 get yyyw',
      'yyzx': 'Vector4 get yyzx',
      'yyzy': 'Vector4 get yyzy',
      'yyzz': 'Vector4 get yyzz',
      'yyzw': 'Vector4 get yyzw',
      'yywx': 'Vector4 get yywx',
      'yywy': 'Vector4 get yywy',
      'yywz': 'Vector4 get yywz',
      'yyww': 'Vector4 get yyww',
      'yzxx': 'Vector4 get yzxx',
      'yzxy': 'Vector4 get yzxy',
      'yzxz': 'Vector4 get yzxz',
      'yzxw': 'Vector4 get yzxw',
      'yzyx': 'Vector4 get yzyx',
      'yzyy': 'Vector4 get yzyy',
      'yzyz': 'Vector4 get yzyz',
      'yzyw': 'Vector4 get yzyw',
      'yzzx': 'Vector4 get yzzx',
      'yzzy': 'Vector4 get yzzy',
      'yzzz': 'Vector4 get yzzz',
      'yzzw': 'Vector4 get yzzw',
      'yzwx': 'Vector4 get yzwx',
      'yzwy': 'Vector4 get yzwy',
      'yzwz': 'Vector4 get yzwz',
      'yzww': 'Vector4 get yzww',
      'ywxx': 'Vector4 get ywxx',
      'ywxy': 'Vector4 get ywxy',
      'ywxz': 'Vector4 get ywxz',
      'ywxw': 'Vector4 get ywxw',
      'ywyx': 'Vector4 get ywyx',
      'ywyy': 'Vector4 get ywyy',
      'ywyz': 'Vector4 get ywyz',
      'ywyw': 'Vector4 get ywyw',
      'ywzx': 'Vector4 get ywzx',
      'ywzy': 'Vector4 get ywzy',
      'ywzz': 'Vector4 get ywzz',
      'ywzw': 'Vector4 get ywzw',
      'ywwx': 'Vector4 get ywwx',
      'ywwy': 'Vector4 get ywwy',
      'ywwz': 'Vector4 get ywwz',
      'ywww': 'Vector4 get ywww',
      'zxxx': 'Vector4 get zxxx',
      'zxxy': 'Vector4 get zxxy',
      'zxxz': 'Vector4 get zxxz',
      'zxxw': 'Vector4 get zxxw',
      'zxyx': 'Vector4 get zxyx',
      'zxyy': 'Vector4 get zxyy',
      'zxyz': 'Vector4 get zxyz',
      'zxyw': 'Vector4 get zxyw',
      'zxzx': 'Vector4 get zxzx',
      'zxzy': 'Vector4 get zxzy',
      'zxzz': 'Vector4 get zxzz',
      'zxzw': 'Vector4 get zxzw',
      'zxwx': 'Vector4 get zxwx',
      'zxwy': 'Vector4 get zxwy',
      'zxwz': 'Vector4 get zxwz',
      'zxww': 'Vector4 get zxww',
      'zyxx': 'Vector4 get zyxx',
      'zyxy': 'Vector4 get zyxy',
      'zyxz': 'Vector4 get zyxz',
      'zyxw': 'Vector4 get zyxw',
      'zyyx': 'Vector4 get zyyx',
      'zyyy': 'Vector4 get zyyy',
      'zyyz': 'Vector4 get zyyz',
      'zyyw': 'Vector4 get zyyw',
      'zyzx': 'Vector4 get zyzx',
      'zyzy': 'Vector4 get zyzy',
      'zyzz': 'Vector4 get zyzz',
      'zyzw': 'Vector4 get zyzw',
      'zywx': 'Vector4 get zywx',
      'zywy': 'Vector4 get zywy',
      'zywz': 'Vector4 get zywz',
      'zyww': 'Vector4 get zyww',
      'zzxx': 'Vector4 get zzxx',
      'zzxy': 'Vector4 get zzxy',
      'zzxz': 'Vector4 get zzxz',
      'zzxw': 'Vector4 get zzxw',
      'zzyx': 'Vector4 get zzyx',
      'zzyy': 'Vector4 get zzyy',
      'zzyz': 'Vector4 get zzyz',
      'zzyw': 'Vector4 get zzyw',
      'zzzx': 'Vector4 get zzzx',
      'zzzy': 'Vector4 get zzzy',
      'zzzz': 'Vector4 get zzzz',
      'zzzw': 'Vector4 get zzzw',
      'zzwx': 'Vector4 get zzwx',
      'zzwy': 'Vector4 get zzwy',
      'zzwz': 'Vector4 get zzwz',
      'zzww': 'Vector4 get zzww',
      'zwxx': 'Vector4 get zwxx',
      'zwxy': 'Vector4 get zwxy',
      'zwxz': 'Vector4 get zwxz',
      'zwxw': 'Vector4 get zwxw',
      'zwyx': 'Vector4 get zwyx',
      'zwyy': 'Vector4 get zwyy',
      'zwyz': 'Vector4 get zwyz',
      'zwyw': 'Vector4 get zwyw',
      'zwzx': 'Vector4 get zwzx',
      'zwzy': 'Vector4 get zwzy',
      'zwzz': 'Vector4 get zwzz',
      'zwzw': 'Vector4 get zwzw',
      'zwwx': 'Vector4 get zwwx',
      'zwwy': 'Vector4 get zwwy',
      'zwwz': 'Vector4 get zwwz',
      'zwww': 'Vector4 get zwww',
      'wxxx': 'Vector4 get wxxx',
      'wxxy': 'Vector4 get wxxy',
      'wxxz': 'Vector4 get wxxz',
      'wxxw': 'Vector4 get wxxw',
      'wxyx': 'Vector4 get wxyx',
      'wxyy': 'Vector4 get wxyy',
      'wxyz': 'Vector4 get wxyz',
      'wxyw': 'Vector4 get wxyw',
      'wxzx': 'Vector4 get wxzx',
      'wxzy': 'Vector4 get wxzy',
      'wxzz': 'Vector4 get wxzz',
      'wxzw': 'Vector4 get wxzw',
      'wxwx': 'Vector4 get wxwx',
      'wxwy': 'Vector4 get wxwy',
      'wxwz': 'Vector4 get wxwz',
      'wxww': 'Vector4 get wxww',
      'wyxx': 'Vector4 get wyxx',
      'wyxy': 'Vector4 get wyxy',
      'wyxz': 'Vector4 get wyxz',
      'wyxw': 'Vector4 get wyxw',
      'wyyx': 'Vector4 get wyyx',
      'wyyy': 'Vector4 get wyyy',
      'wyyz': 'Vector4 get wyyz',
      'wyyw': 'Vector4 get wyyw',
      'wyzx': 'Vector4 get wyzx',
      'wyzy': 'Vector4 get wyzy',
      'wyzz': 'Vector4 get wyzz',
      'wyzw': 'Vector4 get wyzw',
      'wywx': 'Vector4 get wywx',
      'wywy': 'Vector4 get wywy',
      'wywz': 'Vector4 get wywz',
      'wyww': 'Vector4 get wyww',
      'wzxx': 'Vector4 get wzxx',
      'wzxy': 'Vector4 get wzxy',
      'wzxz': 'Vector4 get wzxz',
      'wzxw': 'Vector4 get wzxw',
      'wzyx': 'Vector4 get wzyx',
      'wzyy': 'Vector4 get wzyy',
      'wzyz': 'Vector4 get wzyz',
      'wzyw': 'Vector4 get wzyw',
      'wzzx': 'Vector4 get wzzx',
      'wzzy': 'Vector4 get wzzy',
      'wzzz': 'Vector4 get wzzz',
      'wzzw': 'Vector4 get wzzw',
      'wzwx': 'Vector4 get wzwx',
      'wzwy': 'Vector4 get wzwy',
      'wzwz': 'Vector4 get wzwz',
      'wzww': 'Vector4 get wzww',
      'wwxx': 'Vector4 get wwxx',
      'wwxy': 'Vector4 get wwxy',
      'wwxz': 'Vector4 get wwxz',
      'wwxw': 'Vector4 get wwxw',
      'wwyx': 'Vector4 get wwyx',
      'wwyy': 'Vector4 get wwyy',
      'wwyz': 'Vector4 get wwyz',
      'wwyw': 'Vector4 get wwyw',
      'wwzx': 'Vector4 get wwzx',
      'wwzy': 'Vector4 get wwzy',
      'wwzz': 'Vector4 get wwzz',
      'wwzw': 'Vector4 get wwzw',
      'wwwx': 'Vector4 get wwwx',
      'wwwy': 'Vector4 get wwwy',
      'wwwz': 'Vector4 get wwwz',
      'wwww': 'Vector4 get wwww',
      'r': 'double get r',
      'g': 'double get g',
      'b': 'double get b',
      'a': 'double get a',
      's': 'double get s',
      't': 'double get t',
      'p': 'double get p',
      'q': 'double get q',
      'x': 'double get x',
      'y': 'double get y',
      'z': 'double get z',
      'w': 'double get w',
      'rr': 'Vector2 get rr',
      'rg': 'Vector2 get rg',
      'rb': 'Vector2 get rb',
      'ra': 'Vector2 get ra',
      'gr': 'Vector2 get gr',
      'gg': 'Vector2 get gg',
      'gb': 'Vector2 get gb',
      'ga': 'Vector2 get ga',
      'br': 'Vector2 get br',
      'bg': 'Vector2 get bg',
      'bb': 'Vector2 get bb',
      'ba': 'Vector2 get ba',
      'ar': 'Vector2 get ar',
      'ag': 'Vector2 get ag',
      'ab': 'Vector2 get ab',
      'aa': 'Vector2 get aa',
      'rrr': 'Vector3 get rrr',
      'rrg': 'Vector3 get rrg',
      'rrb': 'Vector3 get rrb',
      'rra': 'Vector3 get rra',
      'rgr': 'Vector3 get rgr',
      'rgg': 'Vector3 get rgg',
      'rgb': 'Vector3 get rgb',
      'rga': 'Vector3 get rga',
      'rbr': 'Vector3 get rbr',
      'rbg': 'Vector3 get rbg',
      'rbb': 'Vector3 get rbb',
      'rba': 'Vector3 get rba',
      'rar': 'Vector3 get rar',
      'rag': 'Vector3 get rag',
      'rab': 'Vector3 get rab',
      'raa': 'Vector3 get raa',
      'grr': 'Vector3 get grr',
      'grg': 'Vector3 get grg',
      'grb': 'Vector3 get grb',
      'gra': 'Vector3 get gra',
      'ggr': 'Vector3 get ggr',
      'ggg': 'Vector3 get ggg',
      'ggb': 'Vector3 get ggb',
      'gga': 'Vector3 get gga',
      'gbr': 'Vector3 get gbr',
      'gbg': 'Vector3 get gbg',
      'gbb': 'Vector3 get gbb',
      'gba': 'Vector3 get gba',
      'gar': 'Vector3 get gar',
      'gag': 'Vector3 get gag',
      'gab': 'Vector3 get gab',
      'gaa': 'Vector3 get gaa',
      'brr': 'Vector3 get brr',
      'brg': 'Vector3 get brg',
      'brb': 'Vector3 get brb',
      'bra': 'Vector3 get bra',
      'bgr': 'Vector3 get bgr',
      'bgg': 'Vector3 get bgg',
      'bgb': 'Vector3 get bgb',
      'bga': 'Vector3 get bga',
      'bbr': 'Vector3 get bbr',
      'bbg': 'Vector3 get bbg',
      'bbb': 'Vector3 get bbb',
      'bba': 'Vector3 get bba',
      'bar': 'Vector3 get bar',
      'bag': 'Vector3 get bag',
      'bab': 'Vector3 get bab',
      'baa': 'Vector3 get baa',
      'arr': 'Vector3 get arr',
      'arg': 'Vector3 get arg',
      'arb': 'Vector3 get arb',
      'ara': 'Vector3 get ara',
      'agr': 'Vector3 get agr',
      'agg': 'Vector3 get agg',
      'agb': 'Vector3 get agb',
      'aga': 'Vector3 get aga',
      'abr': 'Vector3 get abr',
      'abg': 'Vector3 get abg',
      'abb': 'Vector3 get abb',
      'aba': 'Vector3 get aba',
      'aar': 'Vector3 get aar',
      'aag': 'Vector3 get aag',
      'aab': 'Vector3 get aab',
      'aaa': 'Vector3 get aaa',
      'rrrr': 'Vector4 get rrrr',
      'rrrg': 'Vector4 get rrrg',
      'rrrb': 'Vector4 get rrrb',
      'rrra': 'Vector4 get rrra',
      'rrgr': 'Vector4 get rrgr',
      'rrgg': 'Vector4 get rrgg',
      'rrgb': 'Vector4 get rrgb',
      'rrga': 'Vector4 get rrga',
      'rrbr': 'Vector4 get rrbr',
      'rrbg': 'Vector4 get rrbg',
      'rrbb': 'Vector4 get rrbb',
      'rrba': 'Vector4 get rrba',
      'rrar': 'Vector4 get rrar',
      'rrag': 'Vector4 get rrag',
      'rrab': 'Vector4 get rrab',
      'rraa': 'Vector4 get rraa',
      'rgrr': 'Vector4 get rgrr',
      'rgrg': 'Vector4 get rgrg',
      'rgrb': 'Vector4 get rgrb',
      'rgra': 'Vector4 get rgra',
      'rggr': 'Vector4 get rggr',
      'rggg': 'Vector4 get rggg',
      'rggb': 'Vector4 get rggb',
      'rgga': 'Vector4 get rgga',
      'rgbr': 'Vector4 get rgbr',
      'rgbg': 'Vector4 get rgbg',
      'rgbb': 'Vector4 get rgbb',
      'rgba': 'Vector4 get rgba',
      'rgar': 'Vector4 get rgar',
      'rgag': 'Vector4 get rgag',
      'rgab': 'Vector4 get rgab',
      'rgaa': 'Vector4 get rgaa',
      'rbrr': 'Vector4 get rbrr',
      'rbrg': 'Vector4 get rbrg',
      'rbrb': 'Vector4 get rbrb',
      'rbra': 'Vector4 get rbra',
      'rbgr': 'Vector4 get rbgr',
      'rbgg': 'Vector4 get rbgg',
      'rbgb': 'Vector4 get rbgb',
      'rbga': 'Vector4 get rbga',
      'rbbr': 'Vector4 get rbbr',
      'rbbg': 'Vector4 get rbbg',
      'rbbb': 'Vector4 get rbbb',
      'rbba': 'Vector4 get rbba',
      'rbar': 'Vector4 get rbar',
      'rbag': 'Vector4 get rbag',
      'rbab': 'Vector4 get rbab',
      'rbaa': 'Vector4 get rbaa',
      'rarr': 'Vector4 get rarr',
      'rarg': 'Vector4 get rarg',
      'rarb': 'Vector4 get rarb',
      'rara': 'Vector4 get rara',
      'ragr': 'Vector4 get ragr',
      'ragg': 'Vector4 get ragg',
      'ragb': 'Vector4 get ragb',
      'raga': 'Vector4 get raga',
      'rabr': 'Vector4 get rabr',
      'rabg': 'Vector4 get rabg',
      'rabb': 'Vector4 get rabb',
      'raba': 'Vector4 get raba',
      'raar': 'Vector4 get raar',
      'raag': 'Vector4 get raag',
      'raab': 'Vector4 get raab',
      'raaa': 'Vector4 get raaa',
      'grrr': 'Vector4 get grrr',
      'grrg': 'Vector4 get grrg',
      'grrb': 'Vector4 get grrb',
      'grra': 'Vector4 get grra',
      'grgr': 'Vector4 get grgr',
      'grgg': 'Vector4 get grgg',
      'grgb': 'Vector4 get grgb',
      'grga': 'Vector4 get grga',
      'grbr': 'Vector4 get grbr',
      'grbg': 'Vector4 get grbg',
      'grbb': 'Vector4 get grbb',
      'grba': 'Vector4 get grba',
      'grar': 'Vector4 get grar',
      'grag': 'Vector4 get grag',
      'grab': 'Vector4 get grab',
      'graa': 'Vector4 get graa',
      'ggrr': 'Vector4 get ggrr',
      'ggrg': 'Vector4 get ggrg',
      'ggrb': 'Vector4 get ggrb',
      'ggra': 'Vector4 get ggra',
      'gggr': 'Vector4 get gggr',
      'gggg': 'Vector4 get gggg',
      'gggb': 'Vector4 get gggb',
      'ggga': 'Vector4 get ggga',
      'ggbr': 'Vector4 get ggbr',
      'ggbg': 'Vector4 get ggbg',
      'ggbb': 'Vector4 get ggbb',
      'ggba': 'Vector4 get ggba',
      'ggar': 'Vector4 get ggar',
      'ggag': 'Vector4 get ggag',
      'ggab': 'Vector4 get ggab',
      'ggaa': 'Vector4 get ggaa',
      'gbrr': 'Vector4 get gbrr',
      'gbrg': 'Vector4 get gbrg',
      'gbrb': 'Vector4 get gbrb',
      'gbra': 'Vector4 get gbra',
      'gbgr': 'Vector4 get gbgr',
      'gbgg': 'Vector4 get gbgg',
      'gbgb': 'Vector4 get gbgb',
      'gbga': 'Vector4 get gbga',
      'gbbr': 'Vector4 get gbbr',
      'gbbg': 'Vector4 get gbbg',
      'gbbb': 'Vector4 get gbbb',
      'gbba': 'Vector4 get gbba',
      'gbar': 'Vector4 get gbar',
      'gbag': 'Vector4 get gbag',
      'gbab': 'Vector4 get gbab',
      'gbaa': 'Vector4 get gbaa',
      'garr': 'Vector4 get garr',
      'garg': 'Vector4 get garg',
      'garb': 'Vector4 get garb',
      'gara': 'Vector4 get gara',
      'gagr': 'Vector4 get gagr',
      'gagg': 'Vector4 get gagg',
      'gagb': 'Vector4 get gagb',
      'gaga': 'Vector4 get gaga',
      'gabr': 'Vector4 get gabr',
      'gabg': 'Vector4 get gabg',
      'gabb': 'Vector4 get gabb',
      'gaba': 'Vector4 get gaba',
      'gaar': 'Vector4 get gaar',
      'gaag': 'Vector4 get gaag',
      'gaab': 'Vector4 get gaab',
      'gaaa': 'Vector4 get gaaa',
      'brrr': 'Vector4 get brrr',
      'brrg': 'Vector4 get brrg',
      'brrb': 'Vector4 get brrb',
      'brra': 'Vector4 get brra',
      'brgr': 'Vector4 get brgr',
      'brgg': 'Vector4 get brgg',
      'brgb': 'Vector4 get brgb',
      'brga': 'Vector4 get brga',
      'brbr': 'Vector4 get brbr',
      'brbg': 'Vector4 get brbg',
      'brbb': 'Vector4 get brbb',
      'brba': 'Vector4 get brba',
      'brar': 'Vector4 get brar',
      'brag': 'Vector4 get brag',
      'brab': 'Vector4 get brab',
      'braa': 'Vector4 get braa',
      'bgrr': 'Vector4 get bgrr',
      'bgrg': 'Vector4 get bgrg',
      'bgrb': 'Vector4 get bgrb',
      'bgra': 'Vector4 get bgra',
      'bggr': 'Vector4 get bggr',
      'bggg': 'Vector4 get bggg',
      'bggb': 'Vector4 get bggb',
      'bgga': 'Vector4 get bgga',
      'bgbr': 'Vector4 get bgbr',
      'bgbg': 'Vector4 get bgbg',
      'bgbb': 'Vector4 get bgbb',
      'bgba': 'Vector4 get bgba',
      'bgar': 'Vector4 get bgar',
      'bgag': 'Vector4 get bgag',
      'bgab': 'Vector4 get bgab',
      'bgaa': 'Vector4 get bgaa',
      'bbrr': 'Vector4 get bbrr',
      'bbrg': 'Vector4 get bbrg',
      'bbrb': 'Vector4 get bbrb',
      'bbra': 'Vector4 get bbra',
      'bbgr': 'Vector4 get bbgr',
      'bbgg': 'Vector4 get bbgg',
      'bbgb': 'Vector4 get bbgb',
      'bbga': 'Vector4 get bbga',
      'bbbr': 'Vector4 get bbbr',
      'bbbg': 'Vector4 get bbbg',
      'bbbb': 'Vector4 get bbbb',
      'bbba': 'Vector4 get bbba',
      'bbar': 'Vector4 get bbar',
      'bbag': 'Vector4 get bbag',
      'bbab': 'Vector4 get bbab',
      'bbaa': 'Vector4 get bbaa',
      'barr': 'Vector4 get barr',
      'barg': 'Vector4 get barg',
      'barb': 'Vector4 get barb',
      'bara': 'Vector4 get bara',
      'bagr': 'Vector4 get bagr',
      'bagg': 'Vector4 get bagg',
      'bagb': 'Vector4 get bagb',
      'baga': 'Vector4 get baga',
      'babr': 'Vector4 get babr',
      'babg': 'Vector4 get babg',
      'babb': 'Vector4 get babb',
      'baba': 'Vector4 get baba',
      'baar': 'Vector4 get baar',
      'baag': 'Vector4 get baag',
      'baab': 'Vector4 get baab',
      'baaa': 'Vector4 get baaa',
      'arrr': 'Vector4 get arrr',
      'arrg': 'Vector4 get arrg',
      'arrb': 'Vector4 get arrb',
      'arra': 'Vector4 get arra',
      'argr': 'Vector4 get argr',
      'argg': 'Vector4 get argg',
      'argb': 'Vector4 get argb',
      'arga': 'Vector4 get arga',
      'arbr': 'Vector4 get arbr',
      'arbg': 'Vector4 get arbg',
      'arbb': 'Vector4 get arbb',
      'arba': 'Vector4 get arba',
      'arar': 'Vector4 get arar',
      'arag': 'Vector4 get arag',
      'arab': 'Vector4 get arab',
      'araa': 'Vector4 get araa',
      'agrr': 'Vector4 get agrr',
      'agrg': 'Vector4 get agrg',
      'agrb': 'Vector4 get agrb',
      'agra': 'Vector4 get agra',
      'aggr': 'Vector4 get aggr',
      'aggg': 'Vector4 get aggg',
      'aggb': 'Vector4 get aggb',
      'agga': 'Vector4 get agga',
      'agbr': 'Vector4 get agbr',
      'agbg': 'Vector4 get agbg',
      'agbb': 'Vector4 get agbb',
      'agba': 'Vector4 get agba',
      'agar': 'Vector4 get agar',
      'agag': 'Vector4 get agag',
      'agab': 'Vector4 get agab',
      'agaa': 'Vector4 get agaa',
      'abrr': 'Vector4 get abrr',
      'abrg': 'Vector4 get abrg',
      'abrb': 'Vector4 get abrb',
      'abra': 'Vector4 get abra',
      'abgr': 'Vector4 get abgr',
      'abgg': 'Vector4 get abgg',
      'abgb': 'Vector4 get abgb',
      'abga': 'Vector4 get abga',
      'abbr': 'Vector4 get abbr',
      'abbg': 'Vector4 get abbg',
      'abbb': 'Vector4 get abbb',
      'abba': 'Vector4 get abba',
      'abar': 'Vector4 get abar',
      'abag': 'Vector4 get abag',
      'abab': 'Vector4 get abab',
      'abaa': 'Vector4 get abaa',
      'aarr': 'Vector4 get aarr',
      'aarg': 'Vector4 get aarg',
      'aarb': 'Vector4 get aarb',
      'aara': 'Vector4 get aara',
      'aagr': 'Vector4 get aagr',
      'aagg': 'Vector4 get aagg',
      'aagb': 'Vector4 get aagb',
      'aaga': 'Vector4 get aaga',
      'aabr': 'Vector4 get aabr',
      'aabg': 'Vector4 get aabg',
      'aabb': 'Vector4 get aabb',
      'aaba': 'Vector4 get aaba',
      'aaar': 'Vector4 get aaar',
      'aaag': 'Vector4 get aaag',
      'aaab': 'Vector4 get aaab',
      'aaaa': 'Vector4 get aaaa',
      'ss': 'Vector2 get ss',
      'st': 'Vector2 get st',
      'sp': 'Vector2 get sp',
      'sq': 'Vector2 get sq',
      'ts': 'Vector2 get ts',
      'tt': 'Vector2 get tt',
      'tp': 'Vector2 get tp',
      'tq': 'Vector2 get tq',
      'ps': 'Vector2 get ps',
      'pt': 'Vector2 get pt',
      'pp': 'Vector2 get pp',
      'pq': 'Vector2 get pq',
      'qs': 'Vector2 get qs',
      'qt': 'Vector2 get qt',
      'qp': 'Vector2 get qp',
      'qq': 'Vector2 get qq',
      'sss': 'Vector3 get sss',
      'sst': 'Vector3 get sst',
      'ssp': 'Vector3 get ssp',
      'ssq': 'Vector3 get ssq',
      'sts': 'Vector3 get sts',
      'stt': 'Vector3 get stt',
      'stp': 'Vector3 get stp',
      'stq': 'Vector3 get stq',
      'sps': 'Vector3 get sps',
      'spt': 'Vector3 get spt',
      'spp': 'Vector3 get spp',
      'spq': 'Vector3 get spq',
      'sqs': 'Vector3 get sqs',
      'sqt': 'Vector3 get sqt',
      'sqp': 'Vector3 get sqp',
      'sqq': 'Vector3 get sqq',
      'tss': 'Vector3 get tss',
      'tst': 'Vector3 get tst',
      'tsp': 'Vector3 get tsp',
      'tsq': 'Vector3 get tsq',
      'tts': 'Vector3 get tts',
      'ttt': 'Vector3 get ttt',
      'ttp': 'Vector3 get ttp',
      'ttq': 'Vector3 get ttq',
      'tps': 'Vector3 get tps',
      'tpt': 'Vector3 get tpt',
      'tpp': 'Vector3 get tpp',
      'tpq': 'Vector3 get tpq',
      'tqs': 'Vector3 get tqs',
      'tqt': 'Vector3 get tqt',
      'tqp': 'Vector3 get tqp',
      'tqq': 'Vector3 get tqq',
      'pss': 'Vector3 get pss',
      'pst': 'Vector3 get pst',
      'psp': 'Vector3 get psp',
      'psq': 'Vector3 get psq',
      'pts': 'Vector3 get pts',
      'ptt': 'Vector3 get ptt',
      'ptp': 'Vector3 get ptp',
      'ptq': 'Vector3 get ptq',
      'pps': 'Vector3 get pps',
      'ppt': 'Vector3 get ppt',
      'ppp': 'Vector3 get ppp',
      'ppq': 'Vector3 get ppq',
      'pqs': 'Vector3 get pqs',
      'pqt': 'Vector3 get pqt',
      'pqp': 'Vector3 get pqp',
      'pqq': 'Vector3 get pqq',
      'qss': 'Vector3 get qss',
      'qst': 'Vector3 get qst',
      'qsp': 'Vector3 get qsp',
      'qsq': 'Vector3 get qsq',
      'qts': 'Vector3 get qts',
      'qtt': 'Vector3 get qtt',
      'qtp': 'Vector3 get qtp',
      'qtq': 'Vector3 get qtq',
      'qps': 'Vector3 get qps',
      'qpt': 'Vector3 get qpt',
      'qpp': 'Vector3 get qpp',
      'qpq': 'Vector3 get qpq',
      'qqs': 'Vector3 get qqs',
      'qqt': 'Vector3 get qqt',
      'qqp': 'Vector3 get qqp',
      'qqq': 'Vector3 get qqq',
      'ssss': 'Vector4 get ssss',
      'ssst': 'Vector4 get ssst',
      'sssp': 'Vector4 get sssp',
      'sssq': 'Vector4 get sssq',
      'ssts': 'Vector4 get ssts',
      'sstt': 'Vector4 get sstt',
      'sstp': 'Vector4 get sstp',
      'sstq': 'Vector4 get sstq',
      'ssps': 'Vector4 get ssps',
      'sspt': 'Vector4 get sspt',
      'sspp': 'Vector4 get sspp',
      'sspq': 'Vector4 get sspq',
      'ssqs': 'Vector4 get ssqs',
      'ssqt': 'Vector4 get ssqt',
      'ssqp': 'Vector4 get ssqp',
      'ssqq': 'Vector4 get ssqq',
      'stss': 'Vector4 get stss',
      'stst': 'Vector4 get stst',
      'stsp': 'Vector4 get stsp',
      'stsq': 'Vector4 get stsq',
      'stts': 'Vector4 get stts',
      'sttt': 'Vector4 get sttt',
      'sttp': 'Vector4 get sttp',
      'sttq': 'Vector4 get sttq',
      'stps': 'Vector4 get stps',
      'stpt': 'Vector4 get stpt',
      'stpp': 'Vector4 get stpp',
      'stpq': 'Vector4 get stpq',
      'stqs': 'Vector4 get stqs',
      'stqt': 'Vector4 get stqt',
      'stqp': 'Vector4 get stqp',
      'stqq': 'Vector4 get stqq',
      'spss': 'Vector4 get spss',
      'spst': 'Vector4 get spst',
      'spsp': 'Vector4 get spsp',
      'spsq': 'Vector4 get spsq',
      'spts': 'Vector4 get spts',
      'sptt': 'Vector4 get sptt',
      'sptp': 'Vector4 get sptp',
      'sptq': 'Vector4 get sptq',
      'spps': 'Vector4 get spps',
      'sppt': 'Vector4 get sppt',
      'sppp': 'Vector4 get sppp',
      'sppq': 'Vector4 get sppq',
      'spqs': 'Vector4 get spqs',
      'spqt': 'Vector4 get spqt',
      'spqp': 'Vector4 get spqp',
      'spqq': 'Vector4 get spqq',
      'sqss': 'Vector4 get sqss',
      'sqst': 'Vector4 get sqst',
      'sqsp': 'Vector4 get sqsp',
      'sqsq': 'Vector4 get sqsq',
      'sqts': 'Vector4 get sqts',
      'sqtt': 'Vector4 get sqtt',
      'sqtp': 'Vector4 get sqtp',
      'sqtq': 'Vector4 get sqtq',
      'sqps': 'Vector4 get sqps',
      'sqpt': 'Vector4 get sqpt',
      'sqpp': 'Vector4 get sqpp',
      'sqpq': 'Vector4 get sqpq',
      'sqqs': 'Vector4 get sqqs',
      'sqqt': 'Vector4 get sqqt',
      'sqqp': 'Vector4 get sqqp',
      'sqqq': 'Vector4 get sqqq',
      'tsss': 'Vector4 get tsss',
      'tsst': 'Vector4 get tsst',
      'tssp': 'Vector4 get tssp',
      'tssq': 'Vector4 get tssq',
      'tsts': 'Vector4 get tsts',
      'tstt': 'Vector4 get tstt',
      'tstp': 'Vector4 get tstp',
      'tstq': 'Vector4 get tstq',
      'tsps': 'Vector4 get tsps',
      'tspt': 'Vector4 get tspt',
      'tspp': 'Vector4 get tspp',
      'tspq': 'Vector4 get tspq',
      'tsqs': 'Vector4 get tsqs',
      'tsqt': 'Vector4 get tsqt',
      'tsqp': 'Vector4 get tsqp',
      'tsqq': 'Vector4 get tsqq',
      'ttss': 'Vector4 get ttss',
      'ttst': 'Vector4 get ttst',
      'ttsp': 'Vector4 get ttsp',
      'ttsq': 'Vector4 get ttsq',
      'ttts': 'Vector4 get ttts',
      'tttt': 'Vector4 get tttt',
      'tttp': 'Vector4 get tttp',
      'tttq': 'Vector4 get tttq',
      'ttps': 'Vector4 get ttps',
      'ttpt': 'Vector4 get ttpt',
      'ttpp': 'Vector4 get ttpp',
      'ttpq': 'Vector4 get ttpq',
      'ttqs': 'Vector4 get ttqs',
      'ttqt': 'Vector4 get ttqt',
      'ttqp': 'Vector4 get ttqp',
      'ttqq': 'Vector4 get ttqq',
      'tpss': 'Vector4 get tpss',
      'tpst': 'Vector4 get tpst',
      'tpsp': 'Vector4 get tpsp',
      'tpsq': 'Vector4 get tpsq',
      'tpts': 'Vector4 get tpts',
      'tptt': 'Vector4 get tptt',
      'tptp': 'Vector4 get tptp',
      'tptq': 'Vector4 get tptq',
      'tpps': 'Vector4 get tpps',
      'tppt': 'Vector4 get tppt',
      'tppp': 'Vector4 get tppp',
      'tppq': 'Vector4 get tppq',
      'tpqs': 'Vector4 get tpqs',
      'tpqt': 'Vector4 get tpqt',
      'tpqp': 'Vector4 get tpqp',
      'tpqq': 'Vector4 get tpqq',
      'tqss': 'Vector4 get tqss',
      'tqst': 'Vector4 get tqst',
      'tqsp': 'Vector4 get tqsp',
      'tqsq': 'Vector4 get tqsq',
      'tqts': 'Vector4 get tqts',
      'tqtt': 'Vector4 get tqtt',
      'tqtp': 'Vector4 get tqtp',
      'tqtq': 'Vector4 get tqtq',
      'tqps': 'Vector4 get tqps',
      'tqpt': 'Vector4 get tqpt',
      'tqpp': 'Vector4 get tqpp',
      'tqpq': 'Vector4 get tqpq',
      'tqqs': 'Vector4 get tqqs',
      'tqqt': 'Vector4 get tqqt',
      'tqqp': 'Vector4 get tqqp',
      'tqqq': 'Vector4 get tqqq',
      'psss': 'Vector4 get psss',
      'psst': 'Vector4 get psst',
      'pssp': 'Vector4 get pssp',
      'pssq': 'Vector4 get pssq',
      'psts': 'Vector4 get psts',
      'pstt': 'Vector4 get pstt',
      'pstp': 'Vector4 get pstp',
      'pstq': 'Vector4 get pstq',
      'psps': 'Vector4 get psps',
      'pspt': 'Vector4 get pspt',
      'pspp': 'Vector4 get pspp',
      'pspq': 'Vector4 get pspq',
      'psqs': 'Vector4 get psqs',
      'psqt': 'Vector4 get psqt',
      'psqp': 'Vector4 get psqp',
      'psqq': 'Vector4 get psqq',
      'ptss': 'Vector4 get ptss',
      'ptst': 'Vector4 get ptst',
      'ptsp': 'Vector4 get ptsp',
      'ptsq': 'Vector4 get ptsq',
      'ptts': 'Vector4 get ptts',
      'pttt': 'Vector4 get pttt',
      'pttp': 'Vector4 get pttp',
      'pttq': 'Vector4 get pttq',
      'ptps': 'Vector4 get ptps',
      'ptpt': 'Vector4 get ptpt',
      'ptpp': 'Vector4 get ptpp',
      'ptpq': 'Vector4 get ptpq',
      'ptqs': 'Vector4 get ptqs',
      'ptqt': 'Vector4 get ptqt',
      'ptqp': 'Vector4 get ptqp',
      'ptqq': 'Vector4 get ptqq',
      'ppss': 'Vector4 get ppss',
      'ppst': 'Vector4 get ppst',
      'ppsp': 'Vector4 get ppsp',
      'ppsq': 'Vector4 get ppsq',
      'ppts': 'Vector4 get ppts',
      'pptt': 'Vector4 get pptt',
      'pptp': 'Vector4 get pptp',
      'pptq': 'Vector4 get pptq',
      'ppps': 'Vector4 get ppps',
      'pppt': 'Vector4 get pppt',
      'pppp': 'Vector4 get pppp',
      'pppq': 'Vector4 get pppq',
      'ppqs': 'Vector4 get ppqs',
      'ppqt': 'Vector4 get ppqt',
      'ppqp': 'Vector4 get ppqp',
      'ppqq': 'Vector4 get ppqq',
      'pqss': 'Vector4 get pqss',
      'pqst': 'Vector4 get pqst',
      'pqsp': 'Vector4 get pqsp',
      'pqsq': 'Vector4 get pqsq',
      'pqts': 'Vector4 get pqts',
      'pqtt': 'Vector4 get pqtt',
      'pqtp': 'Vector4 get pqtp',
      'pqtq': 'Vector4 get pqtq',
      'pqps': 'Vector4 get pqps',
      'pqpt': 'Vector4 get pqpt',
      'pqpp': 'Vector4 get pqpp',
      'pqpq': 'Vector4 get pqpq',
      'pqqs': 'Vector4 get pqqs',
      'pqqt': 'Vector4 get pqqt',
      'pqqp': 'Vector4 get pqqp',
      'pqqq': 'Vector4 get pqqq',
      'qsss': 'Vector4 get qsss',
      'qsst': 'Vector4 get qsst',
      'qssp': 'Vector4 get qssp',
      'qssq': 'Vector4 get qssq',
      'qsts': 'Vector4 get qsts',
      'qstt': 'Vector4 get qstt',
      'qstp': 'Vector4 get qstp',
      'qstq': 'Vector4 get qstq',
      'qsps': 'Vector4 get qsps',
      'qspt': 'Vector4 get qspt',
      'qspp': 'Vector4 get qspp',
      'qspq': 'Vector4 get qspq',
      'qsqs': 'Vector4 get qsqs',
      'qsqt': 'Vector4 get qsqt',
      'qsqp': 'Vector4 get qsqp',
      'qsqq': 'Vector4 get qsqq',
      'qtss': 'Vector4 get qtss',
      'qtst': 'Vector4 get qtst',
      'qtsp': 'Vector4 get qtsp',
      'qtsq': 'Vector4 get qtsq',
      'qtts': 'Vector4 get qtts',
      'qttt': 'Vector4 get qttt',
      'qttp': 'Vector4 get qttp',
      'qttq': 'Vector4 get qttq',
      'qtps': 'Vector4 get qtps',
      'qtpt': 'Vector4 get qtpt',
      'qtpp': 'Vector4 get qtpp',
      'qtpq': 'Vector4 get qtpq',
      'qtqs': 'Vector4 get qtqs',
      'qtqt': 'Vector4 get qtqt',
      'qtqp': 'Vector4 get qtqp',
      'qtqq': 'Vector4 get qtqq',
      'qpss': 'Vector4 get qpss',
      'qpst': 'Vector4 get qpst',
      'qpsp': 'Vector4 get qpsp',
      'qpsq': 'Vector4 get qpsq',
      'qpts': 'Vector4 get qpts',
      'qptt': 'Vector4 get qptt',
      'qptp': 'Vector4 get qptp',
      'qptq': 'Vector4 get qptq',
      'qpps': 'Vector4 get qpps',
      'qppt': 'Vector4 get qppt',
      'qppp': 'Vector4 get qppp',
      'qppq': 'Vector4 get qppq',
      'qpqs': 'Vector4 get qpqs',
      'qpqt': 'Vector4 get qpqt',
      'qpqp': 'Vector4 get qpqp',
      'qpqq': 'Vector4 get qpqq',
      'qqss': 'Vector4 get qqss',
      'qqst': 'Vector4 get qqst',
      'qqsp': 'Vector4 get qqsp',
      'qqsq': 'Vector4 get qqsq',
      'qqts': 'Vector4 get qqts',
      'qqtt': 'Vector4 get qqtt',
      'qqtp': 'Vector4 get qqtp',
      'qqtq': 'Vector4 get qqtq',
      'qqps': 'Vector4 get qqps',
      'qqpt': 'Vector4 get qqpt',
      'qqpp': 'Vector4 get qqpp',
      'qqpq': 'Vector4 get qqpq',
      'qqqs': 'Vector4 get qqqs',
      'qqqt': 'Vector4 get qqqt',
      'qqqp': 'Vector4 get qqqp',
      'qqqq': 'Vector4 get qqqq',
    },
    setterSignatures: {
      'length': 'set length(double value)',
      'xy': 'set xy(Vector2 value)',
      'xz': 'set xz(Vector2 value)',
      'xw': 'set xw(Vector2 value)',
      'yx': 'set yx(Vector2 value)',
      'yz': 'set yz(Vector2 value)',
      'yw': 'set yw(Vector2 value)',
      'zx': 'set zx(Vector2 value)',
      'zy': 'set zy(Vector2 value)',
      'zw': 'set zw(Vector2 value)',
      'wx': 'set wx(Vector2 value)',
      'wy': 'set wy(Vector2 value)',
      'wz': 'set wz(Vector2 value)',
      'xyz': 'set xyz(Vector3 value)',
      'xyw': 'set xyw(Vector3 value)',
      'xzy': 'set xzy(Vector3 value)',
      'xzw': 'set xzw(Vector3 value)',
      'xwy': 'set xwy(Vector3 value)',
      'xwz': 'set xwz(Vector3 value)',
      'yxz': 'set yxz(Vector3 value)',
      'yxw': 'set yxw(Vector3 value)',
      'yzx': 'set yzx(Vector3 value)',
      'yzw': 'set yzw(Vector3 value)',
      'ywx': 'set ywx(Vector3 value)',
      'ywz': 'set ywz(Vector3 value)',
      'zxy': 'set zxy(Vector3 value)',
      'zxw': 'set zxw(Vector3 value)',
      'zyx': 'set zyx(Vector3 value)',
      'zyw': 'set zyw(Vector3 value)',
      'zwx': 'set zwx(Vector3 value)',
      'zwy': 'set zwy(Vector3 value)',
      'wxy': 'set wxy(Vector3 value)',
      'wxz': 'set wxz(Vector3 value)',
      'wyx': 'set wyx(Vector3 value)',
      'wyz': 'set wyz(Vector3 value)',
      'wzx': 'set wzx(Vector3 value)',
      'wzy': 'set wzy(Vector3 value)',
      'xyzw': 'set xyzw(Vector4 value)',
      'xywz': 'set xywz(Vector4 value)',
      'xzyw': 'set xzyw(Vector4 value)',
      'xzwy': 'set xzwy(Vector4 value)',
      'xwyz': 'set xwyz(Vector4 value)',
      'xwzy': 'set xwzy(Vector4 value)',
      'yxzw': 'set yxzw(Vector4 value)',
      'yxwz': 'set yxwz(Vector4 value)',
      'yzxw': 'set yzxw(Vector4 value)',
      'yzwx': 'set yzwx(Vector4 value)',
      'ywxz': 'set ywxz(Vector4 value)',
      'ywzx': 'set ywzx(Vector4 value)',
      'zxyw': 'set zxyw(Vector4 value)',
      'zxwy': 'set zxwy(Vector4 value)',
      'zyxw': 'set zyxw(Vector4 value)',
      'zywx': 'set zywx(Vector4 value)',
      'zwxy': 'set zwxy(Vector4 value)',
      'zwyx': 'set zwyx(Vector4 value)',
      'wxyz': 'set wxyz(Vector4 value)',
      'wxzy': 'set wxzy(Vector4 value)',
      'wyxz': 'set wyxz(Vector4 value)',
      'wyzx': 'set wyzx(Vector4 value)',
      'wzxy': 'set wzxy(Vector4 value)',
      'wzyx': 'set wzyx(Vector4 value)',
      'r': 'set r(double value)',
      'g': 'set g(double value)',
      'b': 'set b(double value)',
      'a': 'set a(double value)',
      's': 'set s(double value)',
      't': 'set t(double value)',
      'p': 'set p(double value)',
      'q': 'set q(double value)',
      'x': 'set x(double value)',
      'y': 'set y(double value)',
      'z': 'set z(double value)',
      'w': 'set w(double value)',
      'rg': 'set rg(Vector2 value)',
      'rb': 'set rb(Vector2 value)',
      'ra': 'set ra(Vector2 value)',
      'gr': 'set gr(Vector2 value)',
      'gb': 'set gb(Vector2 value)',
      'ga': 'set ga(Vector2 value)',
      'br': 'set br(Vector2 value)',
      'bg': 'set bg(Vector2 value)',
      'ba': 'set ba(Vector2 value)',
      'ar': 'set ar(Vector2 value)',
      'ag': 'set ag(Vector2 value)',
      'ab': 'set ab(Vector2 value)',
      'rgb': 'set rgb(Vector3 value)',
      'rga': 'set rga(Vector3 value)',
      'rbg': 'set rbg(Vector3 value)',
      'rba': 'set rba(Vector3 value)',
      'rag': 'set rag(Vector3 value)',
      'rab': 'set rab(Vector3 value)',
      'grb': 'set grb(Vector3 value)',
      'gra': 'set gra(Vector3 value)',
      'gbr': 'set gbr(Vector3 value)',
      'gba': 'set gba(Vector3 value)',
      'gar': 'set gar(Vector3 value)',
      'gab': 'set gab(Vector3 value)',
      'brg': 'set brg(Vector3 value)',
      'bra': 'set bra(Vector3 value)',
      'bgr': 'set bgr(Vector3 value)',
      'bga': 'set bga(Vector3 value)',
      'bar': 'set bar(Vector3 value)',
      'bag': 'set bag(Vector3 value)',
      'arg': 'set arg(Vector3 value)',
      'arb': 'set arb(Vector3 value)',
      'agr': 'set agr(Vector3 value)',
      'agb': 'set agb(Vector3 value)',
      'abr': 'set abr(Vector3 value)',
      'abg': 'set abg(Vector3 value)',
      'rgba': 'set rgba(Vector4 value)',
      'rgab': 'set rgab(Vector4 value)',
      'rbga': 'set rbga(Vector4 value)',
      'rbag': 'set rbag(Vector4 value)',
      'ragb': 'set ragb(Vector4 value)',
      'rabg': 'set rabg(Vector4 value)',
      'grba': 'set grba(Vector4 value)',
      'grab': 'set grab(Vector4 value)',
      'gbra': 'set gbra(Vector4 value)',
      'gbar': 'set gbar(Vector4 value)',
      'garb': 'set garb(Vector4 value)',
      'gabr': 'set gabr(Vector4 value)',
      'brga': 'set brga(Vector4 value)',
      'brag': 'set brag(Vector4 value)',
      'bgra': 'set bgra(Vector4 value)',
      'bgar': 'set bgar(Vector4 value)',
      'barg': 'set barg(Vector4 value)',
      'bagr': 'set bagr(Vector4 value)',
      'argb': 'set argb(Vector4 value)',
      'arbg': 'set arbg(Vector4 value)',
      'agrb': 'set agrb(Vector4 value)',
      'agbr': 'set agbr(Vector4 value)',
      'abrg': 'set abrg(Vector4 value)',
      'abgr': 'set abgr(Vector4 value)',
      'st': 'set st(Vector2 value)',
      'sp': 'set sp(Vector2 value)',
      'sq': 'set sq(Vector2 value)',
      'ts': 'set ts(Vector2 value)',
      'tp': 'set tp(Vector2 value)',
      'tq': 'set tq(Vector2 value)',
      'ps': 'set ps(Vector2 value)',
      'pt': 'set pt(Vector2 value)',
      'pq': 'set pq(Vector2 value)',
      'qs': 'set qs(Vector2 value)',
      'qt': 'set qt(Vector2 value)',
      'qp': 'set qp(Vector2 value)',
      'stp': 'set stp(Vector3 value)',
      'stq': 'set stq(Vector3 value)',
      'spt': 'set spt(Vector3 value)',
      'spq': 'set spq(Vector3 value)',
      'sqt': 'set sqt(Vector3 value)',
      'sqp': 'set sqp(Vector3 value)',
      'tsp': 'set tsp(Vector3 value)',
      'tsq': 'set tsq(Vector3 value)',
      'tps': 'set tps(Vector3 value)',
      'tpq': 'set tpq(Vector3 value)',
      'tqs': 'set tqs(Vector3 value)',
      'tqp': 'set tqp(Vector3 value)',
      'pst': 'set pst(Vector3 value)',
      'psq': 'set psq(Vector3 value)',
      'pts': 'set pts(Vector3 value)',
      'ptq': 'set ptq(Vector3 value)',
      'pqs': 'set pqs(Vector3 value)',
      'pqt': 'set pqt(Vector3 value)',
      'qst': 'set qst(Vector3 value)',
      'qsp': 'set qsp(Vector3 value)',
      'qts': 'set qts(Vector3 value)',
      'qtp': 'set qtp(Vector3 value)',
      'qps': 'set qps(Vector3 value)',
      'qpt': 'set qpt(Vector3 value)',
      'stpq': 'set stpq(Vector4 value)',
      'stqp': 'set stqp(Vector4 value)',
      'sptq': 'set sptq(Vector4 value)',
      'spqt': 'set spqt(Vector4 value)',
      'sqtp': 'set sqtp(Vector4 value)',
      'sqpt': 'set sqpt(Vector4 value)',
      'tspq': 'set tspq(Vector4 value)',
      'tsqp': 'set tsqp(Vector4 value)',
      'tpsq': 'set tpsq(Vector4 value)',
      'tpqs': 'set tpqs(Vector4 value)',
      'tqsp': 'set tqsp(Vector4 value)',
      'tqps': 'set tqps(Vector4 value)',
      'pstq': 'set pstq(Vector4 value)',
      'psqt': 'set psqt(Vector4 value)',
      'ptsq': 'set ptsq(Vector4 value)',
      'ptqs': 'set ptqs(Vector4 value)',
      'pqst': 'set pqst(Vector4 value)',
      'pqts': 'set pqts(Vector4 value)',
      'qstp': 'set qstp(Vector4 value)',
      'qspt': 'set qspt(Vector4 value)',
      'qtsp': 'set qtsp(Vector4 value)',
      'qtps': 'set qtps(Vector4 value)',
      'qpst': 'set qpst(Vector4 value)',
      'qpts': 'set qpts(Vector4 value)',
    },
    staticMethodSignatures: {
      'min': 'void min(Vector4 a, Vector4 b, Vector4 result)',
      'max': 'void max(Vector4 a, Vector4 b, Vector4 result)',
      'mix': 'void mix(Vector4 min, Vector4 max, double a, Vector4 result)',
    },
  );
}

// =============================================================================
// TextSelection Bridge
// =============================================================================

BridgedClass _createTextSelectionBridge() {
  return BridgedClass(
    nativeType: $flutter_8.TextSelection,
    name: 'TextSelection',
    isAssignable: (v) => v is $flutter_8.TextSelection,
    constructors: {
      '': (visitor, positional, named) {
        final baseOffset = D4.getRequiredNamedArg<int>(named, 'baseOffset', 'TextSelection');
        final extentOffset = D4.getRequiredNamedArg<int>(named, 'extentOffset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        final isDirectional = D4.getNamedArgWithDefault<bool>(named, 'isDirectional', false);
        return $flutter_8.TextSelection(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'collapsed': (visitor, positional, named) {
        final offset = D4.getRequiredNamedArg<int>(named, 'offset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        return $flutter_8.TextSelection.collapsed(offset: offset, affinity: affinity);
      },
      'fromPosition': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextSelection');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'TextSelection');
        return $flutter_8.TextSelection.fromPosition(position);
      },
    },
    getters: {
      'baseOffset': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').baseOffset,
      'extentOffset': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').extentOffset,
      'affinity': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').affinity,
      'isDirectional': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').isDirectional,
      'base': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').base,
      'extent': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').extent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').end,
      'isValid': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').isValid,
      'isCollapsed': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').isCollapsed,
      'isNormalized': (visitor, target) => D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection').isNormalized,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        final baseOffset = D4.getOptionalNamedArg<int?>(named, 'baseOffset');
        final extentOffset = D4.getOptionalNamedArg<int?>(named, 'extentOffset');
        final affinity = D4.getOptionalNamedArg<TextAffinity?>(named, 'affinity');
        final isDirectional = D4.getOptionalNamedArg<bool?>(named, 'isDirectional');
        return t.copyWith(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'expandTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'expandTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'expandTo');
        final extentAtIndex = D4.getOptionalArgWithDefault<bool>(positional, 1, 'extentAtIndex', false);
        return t.expandTo(position, extentAtIndex);
      },
      'extendTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'extendTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'extendTo');
        return t.extendTo(position);
      },
      'textBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textBefore');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textBefore');
        return t.textBefore(text);
      },
      'textAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textAfter');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textAfter');
        return t.textAfter(text);
      },
      'textInside': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textInside');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textInside');
        return t.textInside(text);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextSelection>(target, 'TextSelection');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const TextSelection({required int baseOffset, required int extentOffset, TextAffinity affinity = TextAffinity.downstream, bool isDirectional = false})',
      'collapsed': 'const TextSelection.collapsed({required int offset, TextAffinity affinity = TextAffinity.downstream})',
      'fromPosition': 'TextSelection.fromPosition(TextPosition position)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'copyWith': 'TextSelection copyWith({int? baseOffset, int? extentOffset, TextAffinity? affinity, bool? isDirectional})',
      'expandTo': 'TextSelection expandTo(TextPosition position, [bool extentAtIndex = false])',
      'extendTo': 'TextSelection extendTo(TextPosition position)',
      'textBefore': 'String textBefore(String text)',
      'textAfter': 'String textAfter(String text)',
      'textInside': 'String textInside(String text)',
    },
    getterSignatures: {
      'baseOffset': 'int get baseOffset',
      'extentOffset': 'int get extentOffset',
      'affinity': 'TextAffinity get affinity',
      'isDirectional': 'bool get isDirectional',
      'base': 'TextPosition get base',
      'extent': 'TextPosition get extent',
      'hashCode': 'int get hashCode',
      'start': 'int get start',
      'end': 'int get end',
      'isValid': 'bool get isValid',
      'isCollapsed': 'bool get isCollapsed',
      'isNormalized': 'bool get isNormalized',
    },
  );
}

// =============================================================================
// SemanticsEvent Bridge
// =============================================================================

BridgedClass _createSemanticsEventBridge() {
  return BridgedClass(
    nativeType: $flutter_7.SemanticsEvent,
    name: 'SemanticsEvent',
    isAssignable: (v) => v is $flutter_7.SemanticsEvent,
    constructors: {
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsEvent>(target, 'SemanticsEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsEvent>(target, 'SemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsEvent>(target, 'SemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsEvent>(target, 'SemanticsEvent');
        return t.toString();
      },
    },
    methodSignatures: {
      'toMap': 'Map<String, dynamic> toMap({int? nodeId})',
      'getDataMap': 'Map<String, dynamic> getDataMap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'String get type',
    },
  );
}

// =============================================================================
// AnnounceSemanticsEvent Bridge
// =============================================================================

BridgedClass _createAnnounceSemanticsEventBridge() {
  return BridgedClass(
    nativeType: AnnounceSemanticsEvent,
    name: 'AnnounceSemanticsEvent',
    isAssignable: (v) => v is AnnounceSemanticsEvent,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'AnnounceSemanticsEvent');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'AnnounceSemanticsEvent');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'AnnounceSemanticsEvent');
        final viewId = D4.getRequiredArg<int>(positional, 2, 'viewId', 'AnnounceSemanticsEvent');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_7.Assertiveness>(named, 'assertiveness', $flutter_7.Assertiveness.polite);
        return AnnounceSemanticsEvent(message, textDirection, viewId, assertiveness: assertiveness);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').type,
      'viewId': (visitor, target) => D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').viewId,
      'message': (visitor, target) => D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').message,
      'textDirection': (visitor, target) => D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').textDirection,
      'assertiveness': (visitor, target) => D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').assertiveness,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const AnnounceSemanticsEvent(String message, TextDirection textDirection, int viewId, {Assertiveness assertiveness = Assertiveness.polite})',
    },
    methodSignatures: {
      'toMap': 'Map<String, dynamic> toMap({int? nodeId})',
      'getDataMap': 'Map<String, dynamic> getDataMap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'String get type',
      'viewId': 'int get viewId',
      'message': 'String get message',
      'textDirection': 'TextDirection get textDirection',
      'assertiveness': 'Assertiveness get assertiveness',
    },
  );
}

// =============================================================================
// TooltipSemanticsEvent Bridge
// =============================================================================

BridgedClass _createTooltipSemanticsEventBridge() {
  return BridgedClass(
    nativeType: TooltipSemanticsEvent,
    name: 'TooltipSemanticsEvent',
    isAssignable: (v) => v is TooltipSemanticsEvent,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TooltipSemanticsEvent');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'TooltipSemanticsEvent');
        return TooltipSemanticsEvent(message);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent').type,
      'message': (visitor, target) => D4.validateTarget<TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent').message,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TooltipSemanticsEvent(String message)',
    },
    methodSignatures: {
      'toMap': 'Map<String, dynamic> toMap({int? nodeId})',
      'getDataMap': 'Map<String, dynamic> getDataMap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'String get type',
      'message': 'String get message',
    },
  );
}

// =============================================================================
// LongPressSemanticsEvent Bridge
// =============================================================================

BridgedClass _createLongPressSemanticsEventBridge() {
  return BridgedClass(
    nativeType: LongPressSemanticsEvent,
    name: 'LongPressSemanticsEvent',
    isAssignable: (v) => v is LongPressSemanticsEvent,
    constructors: {
      '': (visitor, positional, named) {
        return LongPressSemanticsEvent();
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const LongPressSemanticsEvent()',
    },
    methodSignatures: {
      'toMap': 'Map<String, dynamic> toMap({int? nodeId})',
      'getDataMap': 'Map<String, dynamic> getDataMap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'String get type',
    },
  );
}

// =============================================================================
// TapSemanticEvent Bridge
// =============================================================================

BridgedClass _createTapSemanticEventBridge() {
  return BridgedClass(
    nativeType: TapSemanticEvent,
    name: 'TapSemanticEvent',
    isAssignable: (v) => v is TapSemanticEvent,
    constructors: {
      '': (visitor, positional, named) {
        return TapSemanticEvent();
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<TapSemanticEvent>(target, 'TapSemanticEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TapSemanticEvent>(target, 'TapSemanticEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TapSemanticEvent>(target, 'TapSemanticEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<TapSemanticEvent>(target, 'TapSemanticEvent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TapSemanticEvent()',
    },
    methodSignatures: {
      'toMap': 'Map<String, dynamic> toMap({int? nodeId})',
      'getDataMap': 'Map<String, dynamic> getDataMap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'String get type',
    },
  );
}

// =============================================================================
// FocusSemanticEvent Bridge
// =============================================================================

BridgedClass _createFocusSemanticEventBridge() {
  return BridgedClass(
    nativeType: FocusSemanticEvent,
    name: 'FocusSemanticEvent',
    isAssignable: (v) => v is FocusSemanticEvent,
    constructors: {
      '': (visitor, positional, named) {
        return FocusSemanticEvent();
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<FocusSemanticEvent>(target, 'FocusSemanticEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FocusSemanticEvent>(target, 'FocusSemanticEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FocusSemanticEvent>(target, 'FocusSemanticEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<FocusSemanticEvent>(target, 'FocusSemanticEvent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const FocusSemanticEvent()',
    },
    methodSignatures: {
      'toMap': 'Map<String, dynamic> toMap({int? nodeId})',
      'getDataMap': 'Map<String, dynamic> getDataMap()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'String get type',
    },
  );
}

// =============================================================================
// SemanticsTag Bridge
// =============================================================================

BridgedClass _createSemanticsTagBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsTag,
    name: 'SemanticsTag',
    isAssignable: (v) => v is $flutter_6.SemanticsTag,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SemanticsTag');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'SemanticsTag');
        return $flutter_6.SemanticsTag(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsTag>(target, 'SemanticsTag').name,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsTag>(target, 'SemanticsTag');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const SemanticsTag(String name)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// ChildSemanticsConfigurationsResult Bridge
// =============================================================================

BridgedClass _createChildSemanticsConfigurationsResultBridge() {
  return BridgedClass(
    nativeType: $flutter_6.ChildSemanticsConfigurationsResult,
    name: 'ChildSemanticsConfigurationsResult',
    isAssignable: (v) => v is $flutter_6.ChildSemanticsConfigurationsResult,
    constructors: {
    },
    getters: {
      'mergeUp': (visitor, target) => D4.validateTarget<$flutter_6.ChildSemanticsConfigurationsResult>(target, 'ChildSemanticsConfigurationsResult').mergeUp,
      'siblingMergeGroups': (visitor, target) => D4.validateTarget<$flutter_6.ChildSemanticsConfigurationsResult>(target, 'ChildSemanticsConfigurationsResult').siblingMergeGroups,
    },
    getterSignatures: {
      'mergeUp': 'List<SemanticsConfiguration> get mergeUp',
      'siblingMergeGroups': 'List<List<SemanticsConfiguration>> get siblingMergeGroups',
    },
  );
}

// =============================================================================
// ChildSemanticsConfigurationsResultBuilder Bridge
// =============================================================================

BridgedClass _createChildSemanticsConfigurationsResultBuilderBridge() {
  return BridgedClass(
    nativeType: ChildSemanticsConfigurationsResultBuilder,
    name: 'ChildSemanticsConfigurationsResultBuilder',
    isAssignable: (v) => v is ChildSemanticsConfigurationsResultBuilder,
    constructors: {
      '': (visitor, positional, named) {
        return ChildSemanticsConfigurationsResultBuilder();
      },
    },
    methods: {
      'markAsMergeUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
        D4.requireMinArgs(positional, 1, 'markAsMergeUp');
        final config = D4.getRequiredArg<$flutter_6.SemanticsConfiguration>(positional, 0, 'config', 'markAsMergeUp');
        t.markAsMergeUp(config);
        return null;
      },
      'markAsSiblingMergeGroup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
        D4.requireMinArgs(positional, 1, 'markAsSiblingMergeGroup');
        if (positional.isEmpty) {
          throw ArgumentError('markAsSiblingMergeGroup: Missing required argument "configs" at position 0');
        }
        final configs = D4.coerceList<$flutter_6.SemanticsConfiguration>(positional[0], 'configs');
        t.markAsSiblingMergeGroup(configs);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
        return (t as dynamic).build();
      },
    },
    constructorSignatures: {
      '': 'ChildSemanticsConfigurationsResultBuilder()',
    },
    methodSignatures: {
      'markAsMergeUp': 'void markAsMergeUp(SemanticsConfiguration config)',
      'markAsSiblingMergeGroup': 'void markAsSiblingMergeGroup(List<SemanticsConfiguration> configs)',
      'build': 'ChildSemanticsConfigurationsResult build()',
    },
  );
}

// =============================================================================
// CustomSemanticsAction Bridge
// =============================================================================

BridgedClass _createCustomSemanticsActionBridge() {
  return BridgedClass(
    nativeType: $flutter_6.CustomSemanticsAction,
    name: 'CustomSemanticsAction',
    isAssignable: (v) => v is $flutter_6.CustomSemanticsAction,
    constructors: {
      '': (visitor, positional, named) {
        final label = D4.getRequiredNamedArg<String>(named, 'label', 'CustomSemanticsAction');
        return $flutter_6.CustomSemanticsAction(label: label);
      },
      'overridingAction': (visitor, positional, named) {
        final hint = D4.getRequiredNamedArg<String>(named, 'hint', 'CustomSemanticsAction');
        final action = D4.getRequiredNamedArg<SemanticsAction>(named, 'action', 'CustomSemanticsAction');
        return $flutter_6.CustomSemanticsAction.overridingAction(hint: hint, action: action);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$flutter_6.CustomSemanticsAction>(target, 'CustomSemanticsAction').label,
      'hint': (visitor, target) => D4.validateTarget<$flutter_6.CustomSemanticsAction>(target, 'CustomSemanticsAction').hint,
      'action': (visitor, target) => D4.validateTarget<$flutter_6.CustomSemanticsAction>(target, 'CustomSemanticsAction').action,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_6.CustomSemanticsAction>(target, 'CustomSemanticsAction').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.CustomSemanticsAction>(target, 'CustomSemanticsAction');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.CustomSemanticsAction>(target, 'CustomSemanticsAction');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'getIdentifier': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getIdentifier');
        final action = D4.getRequiredArg<$flutter_6.CustomSemanticsAction>(positional, 0, 'action', 'getIdentifier');
        return $flutter_6.CustomSemanticsAction.getIdentifier(action);
      },
      'getAction': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getAction');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'getAction');
        return $flutter_6.CustomSemanticsAction.getAction(id);
      },
    },
    constructorSignatures: {
      '': 'const CustomSemanticsAction({required String label})',
      'overridingAction': 'const CustomSemanticsAction.overridingAction({required String hint, required SemanticsAction action})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'label': 'String? get label',
      'hint': 'String? get hint',
      'action': 'SemanticsAction? get action',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'getIdentifier': 'int getIdentifier(CustomSemanticsAction action)',
      'getAction': 'CustomSemanticsAction? getAction(int id)',
    },
  );
}

// =============================================================================
// AttributedString Bridge
// =============================================================================

BridgedClass _createAttributedStringBridge() {
  return BridgedClass(
    nativeType: $flutter_6.AttributedString,
    name: 'AttributedString',
    isAssignable: (v) => v is $flutter_6.AttributedString,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AttributedString');
        final string = D4.getRequiredArg<String>(positional, 0, 'string', 'AttributedString');
        final attributes = named.containsKey('attributes') && named['attributes'] != null
            ? D4.coerceList<StringAttribute>(named['attributes'], 'attributes')
            : const <StringAttribute>[];
        return $flutter_6.AttributedString(string, attributes: attributes);
      },
    },
    getters: {
      'string': (visitor, target) => D4.validateTarget<$flutter_6.AttributedString>(target, 'AttributedString').string,
      'attributes': (visitor, target) => D4.validateTarget<$flutter_6.AttributedString>(target, 'AttributedString').attributes,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_6.AttributedString>(target, 'AttributedString').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedString>(target, 'AttributedString');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedString>(target, 'AttributedString');
        final other = D4.getRequiredArg<$flutter_6.AttributedString>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedString>(target, 'AttributedString');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'AttributedString(String string, {List<StringAttribute> attributes = const <StringAttribute>[]})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'string': 'String get string',
      'attributes': 'List<StringAttribute> get attributes',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// AttributedStringProperty Bridge
// =============================================================================

BridgedClass _createAttributedStringPropertyBridge() {
  return BridgedClass(
    nativeType: AttributedStringProperty,
    name: 'AttributedStringProperty',
    isAssignable: (v) => v is AttributedStringProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AttributedStringProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'AttributedStringProperty');
        final value = D4.getRequiredArg<$flutter_6.AttributedString?>(positional, 1, 'value', 'AttributedStringProperty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showWhenEmpty = D4.getNamedArgWithDefault<bool>(named, 'showWhenEmpty', false);
        final level = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'level', $flutter_3.DiagnosticLevel.info);
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        if (!named.containsKey('defaultValue')) {
          return AttributedStringProperty(name, value, showName: showName, showWhenEmpty: showWhenEmpty, level: level, description: description);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'AttributedStringProperty');
          return AttributedStringProperty(name, value, showName: showName, showWhenEmpty: showWhenEmpty, level: level, description: description, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'showWhenEmpty': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').showWhenEmpty,
      'isInteresting': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').isInteresting,
      'expandableValue': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').value,
      'exception': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').defaultValue,
      'level': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').level,
      'name': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty').textTreeConfiguration,
    },
    methods: {
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_3.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<AttributedStringProperty>(target, 'AttributedStringProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'AttributedStringProperty(String name, AttributedString? value, {bool showName = true, bool showWhenEmpty = false, Object? defaultValue = kNoDefaultValue, DiagnosticLevel level = DiagnosticLevel.info, String? description})',
    },
    methodSignatures: {
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'toDescription': 'String toDescription({TextTreeConfiguration? parentConfiguration})',
      'getProperties': 'List<DiagnosticsNode> getProperties()',
      'getChildren': 'List<DiagnosticsNode> getChildren()',
      'isFiltered': 'bool isFiltered(DiagnosticLevel minLevel)',
      'toTimelineArguments': 'Map<String, String>? toTimelineArguments()',
      'toJsonMapIterative': 'Map<String, Object?> toJsonMapIterative(DiagnosticsSerializationDelegate delegate)',
      'toString': 'String toString({TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, TextTreeConfiguration? parentConfiguration, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
    },
    getterSignatures: {
      'showWhenEmpty': 'bool get showWhenEmpty',
      'isInteresting': 'bool get isInteresting',
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'value': 'AttributedString get value',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'level': 'DiagnosticLevel get level',
      'name': 'String? get name',
      'showSeparator': 'bool get showSeparator',
      'showName': 'bool get showName',
      'linePrefix': 'String? get linePrefix',
      'emptyBodyDescription': 'String? get emptyBodyDescription',
      'style': 'DiagnosticsTreeStyle? get style',
      'allowTruncate': 'bool get allowTruncate',
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// SemanticsLabelBuilder Bridge
// =============================================================================

BridgedClass _createSemanticsLabelBuilderBridge() {
  return BridgedClass(
    nativeType: SemanticsLabelBuilder,
    name: 'SemanticsLabelBuilder',
    isAssignable: (v) => v is SemanticsLabelBuilder,
    constructors: {
      '': (visitor, positional, named) {
        final separator = D4.getNamedArgWithDefault<String>(named, 'separator', ' ');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return SemanticsLabelBuilder(separator: separator, textDirection: textDirection);
      },
    },
    getters: {
      'separator': (visitor, target) => D4.validateTarget<SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').separator,
      'textDirection': (visitor, target) => D4.validateTarget<SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').textDirection,
      'isEmpty': (visitor, target) => D4.validateTarget<SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').isEmpty,
      'length': (visitor, target) => D4.validateTarget<SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').length,
    },
    methods: {
      'addPart': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
        D4.requireMinArgs(positional, 1, 'addPart');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'addPart');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.addPart(label, textDirection: textDirection);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
        return (t as dynamic).build();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
        t.clear();
        return null;
      },
    },
    constructorSignatures: {
      '': 'SemanticsLabelBuilder({String separator = \' \', TextDirection? textDirection})',
    },
    methodSignatures: {
      'addPart': 'void addPart(String label, {TextDirection? textDirection})',
      'build': 'String build()',
      'clear': 'void clear()',
    },
    getterSignatures: {
      'separator': 'String get separator',
      'textDirection': 'TextDirection? get textDirection',
      'isEmpty': 'bool get isEmpty',
      'length': 'int get length',
    },
  );
}

// =============================================================================
// SemanticsData Bridge
// =============================================================================

BridgedClass _createSemanticsDataBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsData,
    name: 'SemanticsData',
    isAssignable: (v) => v is $flutter_6.SemanticsData,
    constructors: {
      '': (visitor, positional, named) {
        final flagsCollection = D4.getRequiredNamedArg<SemanticsFlags>(named, 'flagsCollection', 'SemanticsData');
        final actions = D4.getRequiredNamedArg<int>(named, 'actions', 'SemanticsData');
        final identifier = D4.getRequiredNamedArg<String>(named, 'identifier', 'SemanticsData');
        final traversalParentIdentifier = D4.getRequiredNamedArg<Object?>(named, 'traversalParentIdentifier', 'SemanticsData');
        final traversalChildIdentifier = D4.getRequiredNamedArg<Object?>(named, 'traversalChildIdentifier', 'SemanticsData');
        final attributedLabel = D4.getRequiredNamedArg<$flutter_6.AttributedString>(named, 'attributedLabel', 'SemanticsData');
        final attributedValue = D4.getRequiredNamedArg<$flutter_6.AttributedString>(named, 'attributedValue', 'SemanticsData');
        final attributedIncreasedValue = D4.getRequiredNamedArg<$flutter_6.AttributedString>(named, 'attributedIncreasedValue', 'SemanticsData');
        final attributedDecreasedValue = D4.getRequiredNamedArg<$flutter_6.AttributedString>(named, 'attributedDecreasedValue', 'SemanticsData');
        final attributedHint = D4.getRequiredNamedArg<$flutter_6.AttributedString>(named, 'attributedHint', 'SemanticsData');
        final tooltip = D4.getRequiredNamedArg<String>(named, 'tooltip', 'SemanticsData');
        final textDirection = D4.getRequiredNamedArg<TextDirection?>(named, 'textDirection', 'SemanticsData');
        final rect = D4.getRequiredNamedArg<Rect>(named, 'rect', 'SemanticsData');
        final textSelection = D4.getRequiredNamedArg<$flutter_8.TextSelection?>(named, 'textSelection', 'SemanticsData');
        final scrollIndex = D4.getRequiredNamedArg<int?>(named, 'scrollIndex', 'SemanticsData');
        final scrollChildCount = D4.getRequiredNamedArg<int?>(named, 'scrollChildCount', 'SemanticsData');
        final scrollPosition = D4.getRequiredNamedArg<double?>(named, 'scrollPosition', 'SemanticsData');
        final scrollExtentMax = D4.getRequiredNamedArg<double?>(named, 'scrollExtentMax', 'SemanticsData');
        final scrollExtentMin = D4.getRequiredNamedArg<double?>(named, 'scrollExtentMin', 'SemanticsData');
        final platformViewId = D4.getRequiredNamedArg<int?>(named, 'platformViewId', 'SemanticsData');
        final maxValueLength = D4.getRequiredNamedArg<int?>(named, 'maxValueLength', 'SemanticsData');
        final currentValueLength = D4.getRequiredNamedArg<int?>(named, 'currentValueLength', 'SemanticsData');
        final headingLevel = D4.getRequiredNamedArg<int>(named, 'headingLevel', 'SemanticsData');
        final linkUrl = D4.getRequiredNamedArg<Uri?>(named, 'linkUrl', 'SemanticsData');
        final role = D4.getRequiredNamedArg<SemanticsRole>(named, 'role', 'SemanticsData');
        if (!named.containsKey('controlsNodes')) {
          throw ArgumentError('SemanticsData: Missing required named argument "controlsNodes"');
        }
        final controlsNodes = D4.coerceSetOrNull<String>(named['controlsNodes'], 'controlsNodes');
        final validationResult = D4.getRequiredNamedArg<SemanticsValidationResult>(named, 'validationResult', 'SemanticsData');
        final hitTestBehavior = D4.getRequiredNamedArg<SemanticsHitTestBehavior>(named, 'hitTestBehavior', 'SemanticsData');
        final inputType = D4.getRequiredNamedArg<SemanticsInputType>(named, 'inputType', 'SemanticsData');
        final locale = D4.getRequiredNamedArg<Locale?>(named, 'locale', 'SemanticsData');
        final minValue = D4.getRequiredNamedArg<String?>(named, 'minValue', 'SemanticsData');
        final maxValue = D4.getRequiredNamedArg<String?>(named, 'maxValue', 'SemanticsData');
        final tags = D4.coerceSetOrNull<$flutter_6.SemanticsTag>(named['tags'], 'tags');
        final transform = D4.getOptionalNamedArg<$vector_math_1.Matrix4?>(named, 'transform');
        final customSemanticsActionIds = D4.coerceListOrNull<int>(named['customSemanticsActionIds'], 'customSemanticsActionIds');
        return $flutter_6.SemanticsData(flagsCollection: flagsCollection, actions: actions, identifier: identifier, traversalParentIdentifier: traversalParentIdentifier, traversalChildIdentifier: traversalChildIdentifier, attributedLabel: attributedLabel, attributedValue: attributedValue, attributedIncreasedValue: attributedIncreasedValue, attributedDecreasedValue: attributedDecreasedValue, attributedHint: attributedHint, tooltip: tooltip, textDirection: textDirection, rect: rect, textSelection: textSelection, scrollIndex: scrollIndex, scrollChildCount: scrollChildCount, scrollPosition: scrollPosition, scrollExtentMax: scrollExtentMax, scrollExtentMin: scrollExtentMin, platformViewId: platformViewId, maxValueLength: maxValueLength, currentValueLength: currentValueLength, headingLevel: headingLevel, linkUrl: linkUrl, role: role, controlsNodes: controlsNodes, validationResult: validationResult, hitTestBehavior: hitTestBehavior, inputType: inputType, locale: locale, minValue: minValue, maxValue: maxValue, tags: tags, transform: transform, customSemanticsActionIds: customSemanticsActionIds);
      },
    },
    getters: {
      'flags': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').flags,
      'flagsCollection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').flagsCollection,
      'actions': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').actions,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').traversalChildIdentifier,
      'label': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').value,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').tooltip,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').headingLevel,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').textDirection,
      'textSelection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').textSelection,
      'scrollChildCount': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').scrollChildCount,
      'scrollIndex': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').scrollIndex,
      'scrollPosition': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').scrollPosition,
      'scrollExtentMax': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').scrollExtentMax,
      'scrollExtentMin': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').scrollExtentMin,
      'platformViewId': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').platformViewId,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').currentValueLength,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').linkUrl,
      'rect': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').rect,
      'tags': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').tags,
      'transform': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').transform,
      'customSemanticsActionIds': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').customSemanticsActionIds,
      'role': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').role,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').controlsNodes,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').inputType,
      'locale': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').locale,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').maxValue,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').minValue,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData').hashCode,
    },
    methods: {
      'hasFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        D4.requireMinArgs(positional, 1, 'hasFlag');
        final flag = D4.getRequiredArg<SemanticsFlag>(positional, 0, 'flag', 'hasFlag');
        return t.hasFlag(flag);
      },
      'hasAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        D4.requireMinArgs(positional, 1, 'hasAction');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 0, 'action', 'hasAction');
        return t.hasAction(action);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        return t.toStringShort();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'SemanticsData({required SemanticsFlags flagsCollection, required int actions, required String identifier, required Object? traversalParentIdentifier, required Object? traversalChildIdentifier, required AttributedString attributedLabel, required AttributedString attributedValue, required AttributedString attributedIncreasedValue, required AttributedString attributedDecreasedValue, required AttributedString attributedHint, required String tooltip, required TextDirection? textDirection, required Rect rect, required TextSelection? textSelection, required int? scrollIndex, required int? scrollChildCount, required double? scrollPosition, required double? scrollExtentMax, required double? scrollExtentMin, required int? platformViewId, required int? maxValueLength, required int? currentValueLength, required int headingLevel, required Uri? linkUrl, required SemanticsRole role, required Set<String>? controlsNodes, required SemanticsValidationResult validationResult, required SemanticsHitTestBehavior hitTestBehavior, required SemanticsInputType inputType, required Locale? locale, required String? minValue, required String? maxValue, Set<SemanticsTag>? tags, Matrix4? transform, List<int>? customSemanticsActionIds})',
    },
    methodSignatures: {
      'hasFlag': 'bool hasFlag(SemanticsFlag flag)',
      'hasAction': 'bool hasAction(SemanticsAction action)',
      'toStringShort': 'String toStringShort()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'flags': 'int get flags',
      'flagsCollection': 'SemanticsFlags get flagsCollection',
      'actions': 'int get actions',
      'identifier': 'String get identifier',
      'traversalParentIdentifier': 'Object? get traversalParentIdentifier',
      'traversalChildIdentifier': 'Object? get traversalChildIdentifier',
      'label': 'String get label',
      'attributedLabel': 'AttributedString get attributedLabel',
      'value': 'String get value',
      'attributedValue': 'AttributedString get attributedValue',
      'increasedValue': 'String get increasedValue',
      'attributedIncreasedValue': 'AttributedString get attributedIncreasedValue',
      'decreasedValue': 'String get decreasedValue',
      'attributedDecreasedValue': 'AttributedString get attributedDecreasedValue',
      'hint': 'String get hint',
      'attributedHint': 'AttributedString get attributedHint',
      'tooltip': 'String get tooltip',
      'headingLevel': 'int get headingLevel',
      'textDirection': 'TextDirection? get textDirection',
      'textSelection': 'TextSelection? get textSelection',
      'scrollChildCount': 'int? get scrollChildCount',
      'scrollIndex': 'int? get scrollIndex',
      'scrollPosition': 'double? get scrollPosition',
      'scrollExtentMax': 'double? get scrollExtentMax',
      'scrollExtentMin': 'double? get scrollExtentMin',
      'platformViewId': 'int? get platformViewId',
      'maxValueLength': 'int? get maxValueLength',
      'currentValueLength': 'int? get currentValueLength',
      'linkUrl': 'Uri? get linkUrl',
      'rect': 'Rect get rect',
      'tags': 'Set<SemanticsTag>? get tags',
      'transform': 'Matrix4? get transform',
      'customSemanticsActionIds': 'List<int>? get customSemanticsActionIds',
      'role': 'SemanticsRole get role',
      'controlsNodes': 'Set<String>? get controlsNodes',
      'validationResult': 'SemanticsValidationResult get validationResult',
      'hitTestBehavior': 'ui.SemanticsHitTestBehavior get hitTestBehavior',
      'inputType': 'SemanticsInputType get inputType',
      'locale': 'Locale? get locale',
      'maxValue': 'String? get maxValue',
      'minValue': 'String? get minValue',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// SemanticsHintOverrides Bridge
// =============================================================================

BridgedClass _createSemanticsHintOverridesBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsHintOverrides,
    name: 'SemanticsHintOverrides',
    isAssignable: (v) => v is $flutter_6.SemanticsHintOverrides,
    constructors: {
      '': (visitor, positional, named) {
        final onTapHint = D4.getOptionalNamedArg<String?>(named, 'onTapHint');
        final onLongPressHint = D4.getOptionalNamedArg<String?>(named, 'onLongPressHint');
        return $flutter_6.SemanticsHintOverrides(onTapHint: onTapHint, onLongPressHint: onLongPressHint);
      },
    },
    getters: {
      'onTapHint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').onTapHint,
      'onLongPressHint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').onLongPressHint,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').isNotEmpty,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').hashCode,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const SemanticsHintOverrides({String? onTapHint, String? onLongPressHint})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
    },
    getterSignatures: {
      'onTapHint': 'String? get onTapHint',
      'onLongPressHint': 'String? get onLongPressHint',
      'isNotEmpty': 'bool get isNotEmpty',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// SemanticsProperties Bridge
// =============================================================================

BridgedClass _createSemanticsPropertiesBridge() {
  return BridgedClass(
    nativeType: SemanticsProperties,
    name: 'SemanticsProperties',
    isAssignable: (v) => v is SemanticsProperties,
    constructors: {
      '': (visitor, positional, named) {
        final enabled = D4.getOptionalNamedArg<bool?>(named, 'enabled');
        final checked = D4.getOptionalNamedArg<bool?>(named, 'checked');
        final mixed = D4.getOptionalNamedArg<bool?>(named, 'mixed');
        final expanded = D4.getOptionalNamedArg<bool?>(named, 'expanded');
        final selected = D4.getOptionalNamedArg<bool?>(named, 'selected');
        final toggled = D4.getOptionalNamedArg<bool?>(named, 'toggled');
        final button = D4.getOptionalNamedArg<bool?>(named, 'button');
        final link = D4.getOptionalNamedArg<bool?>(named, 'link');
        final linkUrl = D4.getOptionalNamedArg<Uri?>(named, 'linkUrl');
        final header = D4.getOptionalNamedArg<bool?>(named, 'header');
        final headingLevel = D4.getOptionalNamedArg<int?>(named, 'headingLevel');
        final textField = D4.getOptionalNamedArg<bool?>(named, 'textField');
        final slider = D4.getOptionalNamedArg<bool?>(named, 'slider');
        final keyboardKey = D4.getOptionalNamedArg<bool?>(named, 'keyboardKey');
        final readOnly = D4.getOptionalNamedArg<bool?>(named, 'readOnly');
        final focusable = D4.getOptionalNamedArg<bool?>(named, 'focusable');
        final focused = D4.getOptionalNamedArg<bool?>(named, 'focused');
        final accessibilityFocusBlockType = D4.getOptionalNamedArg<$flutter_6.AccessibilityFocusBlockType?>(named, 'accessibilityFocusBlockType');
        final inMutuallyExclusiveGroup = D4.getOptionalNamedArg<bool?>(named, 'inMutuallyExclusiveGroup');
        final hidden = D4.getOptionalNamedArg<bool?>(named, 'hidden');
        final obscured = D4.getOptionalNamedArg<bool?>(named, 'obscured');
        final multiline = D4.getOptionalNamedArg<bool?>(named, 'multiline');
        final scopesRoute = D4.getOptionalNamedArg<bool?>(named, 'scopesRoute');
        final namesRoute = D4.getOptionalNamedArg<bool?>(named, 'namesRoute');
        final image = D4.getOptionalNamedArg<bool?>(named, 'image');
        final liveRegion = D4.getOptionalNamedArg<bool?>(named, 'liveRegion');
        final isRequired = D4.getOptionalNamedArg<bool?>(named, 'isRequired');
        final maxValueLength = D4.getOptionalNamedArg<int?>(named, 'maxValueLength');
        final currentValueLength = D4.getOptionalNamedArg<int?>(named, 'currentValueLength');
        final identifier = D4.getOptionalNamedArg<String?>(named, 'identifier');
        final traversalParentIdentifier = D4.getOptionalNamedArg<Object?>(named, 'traversalParentIdentifier');
        final traversalChildIdentifier = D4.getOptionalNamedArg<Object?>(named, 'traversalChildIdentifier');
        final label = D4.getOptionalNamedArg<String?>(named, 'label');
        final attributedLabel = D4.getOptionalNamedArg<$flutter_6.AttributedString?>(named, 'attributedLabel');
        final value = D4.getOptionalNamedArg<String?>(named, 'value');
        final attributedValue = D4.getOptionalNamedArg<$flutter_6.AttributedString?>(named, 'attributedValue');
        final increasedValue = D4.getOptionalNamedArg<String?>(named, 'increasedValue');
        final attributedIncreasedValue = D4.getOptionalNamedArg<$flutter_6.AttributedString?>(named, 'attributedIncreasedValue');
        final decreasedValue = D4.getOptionalNamedArg<String?>(named, 'decreasedValue');
        final attributedDecreasedValue = D4.getOptionalNamedArg<$flutter_6.AttributedString?>(named, 'attributedDecreasedValue');
        final hint = D4.getOptionalNamedArg<String?>(named, 'hint');
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final attributedHint = D4.getOptionalNamedArg<$flutter_6.AttributedString?>(named, 'attributedHint');
        final hintOverrides = D4.getOptionalNamedArg<$flutter_6.SemanticsHintOverrides?>(named, 'hintOverrides');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final sortKey = D4.getOptionalNamedArg<$flutter_6.SemanticsSortKey?>(named, 'sortKey');
        final tagForChildren = D4.getOptionalNamedArg<$flutter_6.SemanticsTag?>(named, 'tagForChildren');
        final role = D4.getOptionalNamedArg<SemanticsRole?>(named, 'role');
        final controlsNodes = D4.coerceSetOrNull<String>(named['controlsNodes'], 'controlsNodes');
        final inputType = D4.getOptionalNamedArg<SemanticsInputType?>(named, 'inputType');
        final validationResult = D4.getNamedArgWithDefault<SemanticsValidationResult>(named, 'validationResult', $dart_ui.SemanticsValidationResult.none);
        final hitTestBehavior = D4.getOptionalNamedArg<SemanticsHitTestBehavior?>(named, 'hitTestBehavior');
        final onTapRaw = named['onTap'];
        final onLongPressRaw = named['onLongPress'];
        final onScrollLeftRaw = named['onScrollLeft'];
        final onScrollRightRaw = named['onScrollRight'];
        final onScrollUpRaw = named['onScrollUp'];
        final onScrollDownRaw = named['onScrollDown'];
        final onIncreaseRaw = named['onIncrease'];
        final onDecreaseRaw = named['onDecrease'];
        final onCopyRaw = named['onCopy'];
        final onCutRaw = named['onCut'];
        final onPasteRaw = named['onPaste'];
        final onMoveCursorForwardByCharacterRaw = named['onMoveCursorForwardByCharacter'];
        final onMoveCursorBackwardByCharacterRaw = named['onMoveCursorBackwardByCharacter'];
        final onMoveCursorForwardByWordRaw = named['onMoveCursorForwardByWord'];
        final onMoveCursorBackwardByWordRaw = named['onMoveCursorBackwardByWord'];
        final onSetSelectionRaw = named['onSetSelection'];
        final onSetTextRaw = named['onSetText'];
        final onDidGainAccessibilityFocusRaw = named['onDidGainAccessibilityFocus'];
        final onDidLoseAccessibilityFocusRaw = named['onDidLoseAccessibilityFocus'];
        final onFocusRaw = named['onFocus'];
        final onDismissRaw = named['onDismiss'];
        final onExpandRaw = named['onExpand'];
        final onCollapseRaw = named['onCollapse'];
        Map<$flutter_6.CustomSemanticsAction, void Function()>? customSemanticsActions;
        if (named.containsKey('customSemanticsActions') && named['customSemanticsActions'] != null) {
          // Convert map with function values inline
          final customSemanticsActionsRaw = named['customSemanticsActions'] as Map?;
          if (customSemanticsActionsRaw != null) {
            for (final entry in customSemanticsActionsRaw.entries) {
              final k = D4.extractBridgedArg<$flutter_6.CustomSemanticsAction>(entry.key, 'customSemanticsActions[key]');
              final v = entry.value;
              if (v == null) {
                // Skip null values for non-nullable function type
              } else if (v is Callable) {
                customSemanticsActions ??= <$flutter_6.CustomSemanticsAction, void Function()>{};
                customSemanticsActions![k] = () { D4.callInterpreterCallback(visitor, v, []); };
              } else {
                customSemanticsActions ??= <$flutter_6.CustomSemanticsAction, void Function()>{};
                customSemanticsActions![k] = v as void Function();
              }
            }
          }
        } else {
          customSemanticsActions = null;
        }
        final minValue = D4.getOptionalNamedArg<String?>(named, 'minValue');
        final maxValue = D4.getOptionalNamedArg<String?>(named, 'maxValue');
        return SemanticsProperties(enabled: enabled, checked: checked, mixed: mixed, expanded: expanded, selected: selected, toggled: toggled, button: button, link: link, linkUrl: linkUrl, header: header, headingLevel: headingLevel, textField: textField, slider: slider, keyboardKey: keyboardKey, readOnly: readOnly, focusable: focusable, focused: focused, accessibilityFocusBlockType: accessibilityFocusBlockType, inMutuallyExclusiveGroup: inMutuallyExclusiveGroup, hidden: hidden, obscured: obscured, multiline: multiline, scopesRoute: scopesRoute, namesRoute: namesRoute, image: image, liveRegion: liveRegion, isRequired: isRequired, maxValueLength: maxValueLength, currentValueLength: currentValueLength, identifier: identifier, traversalParentIdentifier: traversalParentIdentifier, traversalChildIdentifier: traversalChildIdentifier, label: label, attributedLabel: attributedLabel, value: value, attributedValue: attributedValue, increasedValue: increasedValue, attributedIncreasedValue: attributedIncreasedValue, decreasedValue: decreasedValue, attributedDecreasedValue: attributedDecreasedValue, hint: hint, tooltip: tooltip, attributedHint: attributedHint, hintOverrides: hintOverrides, textDirection: textDirection, sortKey: sortKey, tagForChildren: tagForChildren, role: role, controlsNodes: controlsNodes, inputType: inputType, validationResult: validationResult, hitTestBehavior: hitTestBehavior, onTap: onTapRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapRaw, []); }, onLongPress: onLongPressRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onLongPressRaw, []); }, onScrollLeft: onScrollLeftRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollLeftRaw, []); }, onScrollRight: onScrollRightRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollRightRaw, []); }, onScrollUp: onScrollUpRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollUpRaw, []); }, onScrollDown: onScrollDownRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollDownRaw, []); }, onIncrease: onIncreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onIncreaseRaw, []); }, onDecrease: onDecreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDecreaseRaw, []); }, onCopy: onCopyRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCopyRaw, []); }, onCut: onCutRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCutRaw, []); }, onPaste: onPasteRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onPasteRaw, []); }, onMoveCursorForwardByCharacter: onMoveCursorForwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorForwardByCharacterRaw, [p0]); }, onMoveCursorBackwardByCharacter: onMoveCursorBackwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorBackwardByCharacterRaw, [p0]); }, onMoveCursorForwardByWord: onMoveCursorForwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorForwardByWordRaw, [p0]); }, onMoveCursorBackwardByWord: onMoveCursorBackwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorBackwardByWordRaw, [p0]); }, onSetSelection: onSetSelectionRaw == null ? null : ($flutter_8.TextSelection p0) { D4.callInterpreterCallback(visitor!, onSetSelectionRaw, [p0]); }, onSetText: onSetTextRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onSetTextRaw, [p0]); }, onDidGainAccessibilityFocus: onDidGainAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDidGainAccessibilityFocusRaw, []); }, onDidLoseAccessibilityFocus: onDidLoseAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDidLoseAccessibilityFocusRaw, []); }, onFocus: onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); }, onDismiss: onDismissRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDismissRaw, []); }, onExpand: onExpandRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onExpandRaw, []); }, onCollapse: onCollapseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCollapseRaw, []); }, customSemanticsActions: customSemanticsActions, minValue: minValue, maxValue: maxValue);
      },
    },
    getters: {
      'enabled': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').enabled,
      'checked': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').checked,
      'mixed': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').mixed,
      'expanded': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').expanded,
      'toggled': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').toggled,
      'selected': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').selected,
      'button': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').button,
      'link': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').link,
      'header': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').header,
      'textField': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').textField,
      'slider': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').slider,
      'keyboardKey': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').keyboardKey,
      'readOnly': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').readOnly,
      'focusable': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').focusable,
      'focused': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').focused,
      'accessibilityFocusBlockType': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').accessibilityFocusBlockType,
      'inMutuallyExclusiveGroup': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').inMutuallyExclusiveGroup,
      'hidden': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').hidden,
      'obscured': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').obscured,
      'multiline': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').multiline,
      'scopesRoute': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').scopesRoute,
      'namesRoute': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').namesRoute,
      'image': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').image,
      'liveRegion': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').liveRegion,
      'isRequired': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').isRequired,
      'maxValueLength': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').currentValueLength,
      'identifier': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').traversalChildIdentifier,
      'label': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').value,
      'attributedValue': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').tooltip,
      'headingLevel': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').headingLevel,
      'hintOverrides': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').hintOverrides,
      'textDirection': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').textDirection,
      'sortKey': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').sortKey,
      'tagForChildren': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').tagForChildren,
      'linkUrl': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').linkUrl,
      'onTap': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onTap,
      'onLongPress': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onLongPress,
      'onScrollLeft': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onScrollLeft,
      'onScrollRight': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onScrollRight,
      'onScrollUp': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onScrollUp,
      'onScrollDown': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onScrollDown,
      'onIncrease': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onIncrease,
      'onDecrease': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onDecrease,
      'onCopy': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onCopy,
      'onCut': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onCut,
      'onPaste': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onPaste,
      'onMoveCursorForwardByCharacter': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorForwardByCharacter,
      'onMoveCursorBackwardByCharacter': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorBackwardByCharacter,
      'onMoveCursorForwardByWord': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorForwardByWord,
      'onMoveCursorBackwardByWord': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorBackwardByWord,
      'onSetSelection': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onSetSelection,
      'onSetText': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onSetText,
      'onDidGainAccessibilityFocus': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onDidGainAccessibilityFocus,
      'onDidLoseAccessibilityFocus': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onDidLoseAccessibilityFocus,
      'onFocus': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onFocus,
      'onDismiss': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onDismiss,
      'onExpand': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onExpand,
      'onCollapse': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').onCollapse,
      'customSemanticsActions': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').customSemanticsActions,
      'role': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').role,
      'controlsNodes': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').controlsNodes,
      'validationResult': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').inputType,
      'maxValue': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').maxValue,
      'minValue': (visitor, target) => D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties').minValue,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties');
        return t.toStringShort();
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsProperties>(target, 'SemanticsProperties');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
    },
    constructorSignatures: {
      '': 'const SemanticsProperties({bool? enabled, bool? checked, bool? mixed, bool? expanded, bool? selected, bool? toggled, bool? button, bool? link, Uri? linkUrl, bool? header, int? headingLevel, bool? textField, bool? slider, bool? keyboardKey, bool? readOnly, bool? focusable, bool? focused, AccessibilityFocusBlockType? accessibilityFocusBlockType, bool? inMutuallyExclusiveGroup, bool? hidden, bool? obscured, bool? multiline, bool? scopesRoute, bool? namesRoute, bool? image, bool? liveRegion, bool? isRequired, int? maxValueLength, int? currentValueLength, String? identifier, Object? traversalParentIdentifier, Object? traversalChildIdentifier, String? label, AttributedString? attributedLabel, String? value, AttributedString? attributedValue, String? increasedValue, AttributedString? attributedIncreasedValue, String? decreasedValue, AttributedString? attributedDecreasedValue, String? hint, String? tooltip, AttributedString? attributedHint, SemanticsHintOverrides? hintOverrides, TextDirection? textDirection, SemanticsSortKey? sortKey, SemanticsTag? tagForChildren, SemanticsRole? role, Set<String>? controlsNodes, SemanticsInputType? inputType, SemanticsValidationResult validationResult = SemanticsValidationResult.none, SemanticsHitTestBehavior? hitTestBehavior, void Function()? onTap, void Function()? onLongPress, void Function()? onScrollLeft, void Function()? onScrollRight, void Function()? onScrollUp, void Function()? onScrollDown, void Function()? onIncrease, void Function()? onDecrease, void Function()? onCopy, void Function()? onCut, void Function()? onPaste, void Function(bool)? onMoveCursorForwardByCharacter, void Function(bool)? onMoveCursorBackwardByCharacter, void Function(bool)? onMoveCursorForwardByWord, void Function(bool)? onMoveCursorBackwardByWord, void Function(TextSelection)? onSetSelection, void Function(String)? onSetText, void Function()? onDidGainAccessibilityFocus, void Function()? onDidLoseAccessibilityFocus, void Function()? onFocus, void Function()? onDismiss, void Function()? onExpand, void Function()? onCollapse, Map<CustomSemanticsAction, void Function()>? customSemanticsActions, String? minValue, String? maxValue})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
    },
    getterSignatures: {
      'enabled': 'bool? get enabled',
      'checked': 'bool? get checked',
      'mixed': 'bool? get mixed',
      'expanded': 'bool? get expanded',
      'toggled': 'bool? get toggled',
      'selected': 'bool? get selected',
      'button': 'bool? get button',
      'link': 'bool? get link',
      'header': 'bool? get header',
      'textField': 'bool? get textField',
      'slider': 'bool? get slider',
      'keyboardKey': 'bool? get keyboardKey',
      'readOnly': 'bool? get readOnly',
      'focusable': 'bool? get focusable',
      'focused': 'bool? get focused',
      'accessibilityFocusBlockType': 'AccessibilityFocusBlockType? get accessibilityFocusBlockType',
      'inMutuallyExclusiveGroup': 'bool? get inMutuallyExclusiveGroup',
      'hidden': 'bool? get hidden',
      'obscured': 'bool? get obscured',
      'multiline': 'bool? get multiline',
      'scopesRoute': 'bool? get scopesRoute',
      'namesRoute': 'bool? get namesRoute',
      'image': 'bool? get image',
      'liveRegion': 'bool? get liveRegion',
      'isRequired': 'bool? get isRequired',
      'maxValueLength': 'int? get maxValueLength',
      'currentValueLength': 'int? get currentValueLength',
      'identifier': 'String? get identifier',
      'traversalParentIdentifier': 'Object? get traversalParentIdentifier',
      'traversalChildIdentifier': 'Object? get traversalChildIdentifier',
      'label': 'String? get label',
      'attributedLabel': 'AttributedString? get attributedLabel',
      'value': 'String? get value',
      'attributedValue': 'AttributedString? get attributedValue',
      'increasedValue': 'String? get increasedValue',
      'attributedIncreasedValue': 'AttributedString? get attributedIncreasedValue',
      'decreasedValue': 'String? get decreasedValue',
      'attributedDecreasedValue': 'AttributedString? get attributedDecreasedValue',
      'hint': 'String? get hint',
      'attributedHint': 'AttributedString? get attributedHint',
      'tooltip': 'String? get tooltip',
      'headingLevel': 'int? get headingLevel',
      'hintOverrides': 'SemanticsHintOverrides? get hintOverrides',
      'textDirection': 'TextDirection? get textDirection',
      'sortKey': 'SemanticsSortKey? get sortKey',
      'tagForChildren': 'SemanticsTag? get tagForChildren',
      'linkUrl': 'Uri? get linkUrl',
      'onTap': 'VoidCallback? get onTap',
      'onLongPress': 'VoidCallback? get onLongPress',
      'onScrollLeft': 'VoidCallback? get onScrollLeft',
      'onScrollRight': 'VoidCallback? get onScrollRight',
      'onScrollUp': 'VoidCallback? get onScrollUp',
      'onScrollDown': 'VoidCallback? get onScrollDown',
      'onIncrease': 'VoidCallback? get onIncrease',
      'onDecrease': 'VoidCallback? get onDecrease',
      'onCopy': 'VoidCallback? get onCopy',
      'onCut': 'VoidCallback? get onCut',
      'onPaste': 'VoidCallback? get onPaste',
      'onMoveCursorForwardByCharacter': 'MoveCursorHandler? get onMoveCursorForwardByCharacter',
      'onMoveCursorBackwardByCharacter': 'MoveCursorHandler? get onMoveCursorBackwardByCharacter',
      'onMoveCursorForwardByWord': 'MoveCursorHandler? get onMoveCursorForwardByWord',
      'onMoveCursorBackwardByWord': 'MoveCursorHandler? get onMoveCursorBackwardByWord',
      'onSetSelection': 'SetSelectionHandler? get onSetSelection',
      'onSetText': 'SetTextHandler? get onSetText',
      'onDidGainAccessibilityFocus': 'VoidCallback? get onDidGainAccessibilityFocus',
      'onDidLoseAccessibilityFocus': 'VoidCallback? get onDidLoseAccessibilityFocus',
      'onFocus': 'VoidCallback? get onFocus',
      'onDismiss': 'VoidCallback? get onDismiss',
      'onExpand': 'VoidCallback? get onExpand',
      'onCollapse': 'VoidCallback? get onCollapse',
      'customSemanticsActions': 'Map<CustomSemanticsAction, VoidCallback>? get customSemanticsActions',
      'role': 'SemanticsRole? get role',
      'controlsNodes': 'Set<String>? get controlsNodes',
      'validationResult': 'SemanticsValidationResult get validationResult',
      'hitTestBehavior': 'ui.SemanticsHitTestBehavior? get hitTestBehavior',
      'inputType': 'SemanticsInputType? get inputType',
      'maxValue': 'String? get maxValue',
      'minValue': 'String? get minValue',
    },
  );
}

// =============================================================================
// SemanticsNode Bridge
// =============================================================================

BridgedClass _createSemanticsNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsNode,
    name: 'SemanticsNode',
    isAssignable: (v) => v is $flutter_6.SemanticsNode,
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getOptionalNamedArg<$flutter_4.Key?>(named, 'key');
        final showOnScreenRaw = named['showOnScreen'];
        return $flutter_6.SemanticsNode(key: key, showOnScreen: showOnScreenRaw == null ? null : () { D4.callInterpreterCallback(visitor!, showOnScreenRaw, []); });
      },
      'root': (visitor, positional, named) {
        final key = D4.getOptionalNamedArg<$flutter_4.Key?>(named, 'key');
        final showOnScreenRaw = named['showOnScreen'];
        final owner = D4.getRequiredNamedArg<$flutter_6.SemanticsOwner>(named, 'owner', 'SemanticsNode');
        return $flutter_6.SemanticsNode.root(key: key, showOnScreen: showOnScreenRaw == null ? null : () { D4.callInterpreterCallback(visitor!, showOnScreenRaw, []); }, owner: owner);
      },
    },
    getters: {
      'key': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').key,
      'id': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').id,
      'transform': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').transform,
      'rect': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').rect,
      'parentSemanticsClipRect': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').parentSemanticsClipRect,
      'parentPaintClipRect': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').parentPaintClipRect,
      'indexInParent': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').indexInParent,
      'isInvisible': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').isInvisible,
      'isMergedIntoParent': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').isMergedIntoParent,
      'areUserActionsBlocked': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').areUserActionsBlocked,
      'isPartOfNodeMerging': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').isPartOfNodeMerging,
      'mergeAllDescendantsIntoThisNode': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').mergeAllDescendantsIntoThisNode,
      'hasChildren': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').hasChildren,
      'childrenCount': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').childrenCount,
      'childrenCountInTraversalOrder': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').childrenCountInTraversalOrder,
      'owner': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').owner,
      'attached': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').attached,
      'parent': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').parent,
      'traversalParent': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').traversalParent,
      'depth': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').depth,
      'tags': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').tags,
      'flagsCollection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').flagsCollection,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').traversalChildIdentifier,
      'label': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').value,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').tooltip,
      'hintOverrides': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').hintOverrides,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').textDirection,
      'sortKey': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').sortKey,
      'textSelection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').textSelection,
      'isMultiline': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').isMultiline,
      'scrollChildCount': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').scrollChildCount,
      'scrollIndex': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').scrollIndex,
      'scrollPosition': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').scrollPosition,
      'scrollExtentMax': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').scrollExtentMax,
      'scrollExtentMin': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').scrollExtentMin,
      'platformViewId': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').platformViewId,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').currentValueLength,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').headingLevel,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').linkUrl,
      'role': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').role,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').controlsNodes,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').minValue,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').maxValue,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').inputType,
    },
    setters: {
      'transform': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').transform = D4.extractBridgedArgOrNull<$vector_math_1.Matrix4>(value, 'transform'),
      'rect': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').rect = D4.extractBridgedArg<Rect>(value, 'rect'),
      'parentSemanticsClipRect': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').parentSemanticsClipRect = D4.extractBridgedArgOrNull<Rect>(value, 'parentSemanticsClipRect'),
      'parentPaintClipRect': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').parentPaintClipRect = D4.extractBridgedArgOrNull<Rect>(value, 'parentPaintClipRect'),
      'indexInParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').indexInParent = D4.extractBridgedArgOrNull<int>(value, 'indexInParent'),
      'isMergedIntoParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').isMergedIntoParent = D4.extractBridgedArg<bool>(value, 'isMergedIntoParent'),
      'areUserActionsBlocked': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').areUserActionsBlocked = D4.extractBridgedArg<bool>(value, 'areUserActionsBlocked'),
      'traversalParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').traversalParent = D4.extractBridgedArgOrNull<$flutter_6.SemanticsNode>(value, 'traversalParent'),
      'tags': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').tags = value == null ? null : (value as Set).cast<$flutter_6.SemanticsTag>().toSet(),
    },
    methods: {
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        t.visitChildren(($flutter_6.SemanticsNode p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; });
        return null;
      },
      'isTagged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'isTagged');
        final tag = D4.getRequiredArg<$flutter_6.SemanticsTag>(positional, 0, 'tag', 'isTagged');
        return t.isTagged(tag);
      },
      'hasFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'hasFlag');
        final flag = D4.getRequiredArg<SemanticsFlag>(positional, 0, 'flag', 'hasFlag');
        return t.hasFlag(flag);
      },
      'updateWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final config = D4.getRequiredNamedArg<$flutter_6.SemanticsConfiguration?>(named, 'config', 'updateWith');
        final childrenInInversePaintOrder = D4.coerceListOrNull<$flutter_6.SemanticsNode>(named['childrenInInversePaintOrder'], 'childrenInInversePaintOrder');
        t.updateWith(config: config, childrenInInversePaintOrder: childrenInInversePaintOrder);
        return null;
      },
      'getSemanticsData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        return t.getSemanticsData();
      },
      'sendEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'sendEvent');
        final event = D4.getRequiredArg<$flutter_7.SemanticsEvent>(positional, 0, 'event', 'sendEvent');
        t.sendEvent(event);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        return t.toStringShort();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final childOrder = D4.getNamedArgWithDefault<$flutter_6.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_6.DebugSemanticsDumpOrder.traversalOrder);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, childOrder: childOrder, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getNamedArgWithDefault<$flutter_3.DiagnosticsTreeStyle?>(named, 'style', $flutter_3.DiagnosticsTreeStyle.sparse);
        final childOrder = D4.getNamedArgWithDefault<$flutter_6.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_6.DebugSemanticsDumpOrder.traversalOrder);
        return t.toDiagnosticsNode(name: name, style: style, childOrder: childOrder);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final childOrder = D4.getNamedArgWithDefault<$flutter_6.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_6.DebugSemanticsDumpOrder.traversalOrder);
        return t.debugDescribeChildren(childOrder: childOrder);
      },
      'debugListChildrenInOrder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'debugListChildrenInOrder');
        final childOrder = D4.getRequiredArg<$flutter_6.DebugSemanticsDumpOrder>(positional, 0, 'childOrder', 'debugListChildrenInOrder');
        return t.debugListChildrenInOrder(childOrder);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
    },
    constructorSignatures: {
      '': 'SemanticsNode({Key? key, VoidCallback? showOnScreen})',
      'root': 'SemanticsNode.root({Key? key, VoidCallback? showOnScreen, required SemanticsOwner owner})',
    },
    methodSignatures: {
      'visitChildren': 'void visitChildren(SemanticsNodeVisitor visitor)',
      'isTagged': 'bool isTagged(SemanticsTag tag)',
      'hasFlag': 'bool hasFlag(SemanticsFlag flag)',
      'updateWith': 'void updateWith({required SemanticsConfiguration? config, List<SemanticsNode>? childrenInInversePaintOrder})',
      'getSemanticsData': 'SemanticsData getSemanticsData()',
      'sendEvent': 'void sendEvent(SemanticsEvent event)',
      'toStringShort': 'String toStringShort()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, DebugSemanticsDumpOrder childOrder = DebugSemanticsDumpOrder.traversalOrder, int wrapWidth = 65})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style = DiagnosticsTreeStyle.sparse, DebugSemanticsDumpOrder childOrder = DebugSemanticsDumpOrder.traversalOrder})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren({DebugSemanticsDumpOrder childOrder = DebugSemanticsDumpOrder.traversalOrder})',
      'debugListChildrenInOrder': 'List<SemanticsNode> debugListChildrenInOrder(DebugSemanticsDumpOrder childOrder)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
    },
    getterSignatures: {
      'key': 'Key? get key',
      'id': 'int get id',
      'transform': 'Matrix4? get transform',
      'rect': 'Rect get rect',
      'parentSemanticsClipRect': 'Rect? get parentSemanticsClipRect',
      'parentPaintClipRect': 'Rect? get parentPaintClipRect',
      'indexInParent': 'int? get indexInParent',
      'isInvisible': 'bool get isInvisible',
      'isMergedIntoParent': 'bool get isMergedIntoParent',
      'areUserActionsBlocked': 'bool get areUserActionsBlocked',
      'isPartOfNodeMerging': 'bool get isPartOfNodeMerging',
      'mergeAllDescendantsIntoThisNode': 'bool get mergeAllDescendantsIntoThisNode',
      'hasChildren': 'bool get hasChildren',
      'childrenCount': 'int get childrenCount',
      'childrenCountInTraversalOrder': 'int get childrenCountInTraversalOrder',
      'owner': 'SemanticsOwner? get owner',
      'attached': 'bool get attached',
      'parent': 'SemanticsNode? get parent',
      'traversalParent': 'SemanticsNode? get traversalParent',
      'depth': 'int get depth',
      'tags': 'Set<SemanticsTag>? get tags',
      'flagsCollection': 'SemanticsFlags get flagsCollection',
      'identifier': 'String get identifier',
      'traversalParentIdentifier': 'Object? get traversalParentIdentifier',
      'traversalChildIdentifier': 'Object? get traversalChildIdentifier',
      'label': 'String get label',
      'attributedLabel': 'AttributedString get attributedLabel',
      'value': 'String get value',
      'attributedValue': 'AttributedString get attributedValue',
      'increasedValue': 'String get increasedValue',
      'attributedIncreasedValue': 'AttributedString get attributedIncreasedValue',
      'decreasedValue': 'String get decreasedValue',
      'attributedDecreasedValue': 'AttributedString get attributedDecreasedValue',
      'hint': 'String get hint',
      'attributedHint': 'AttributedString get attributedHint',
      'tooltip': 'String get tooltip',
      'hintOverrides': 'SemanticsHintOverrides? get hintOverrides',
      'textDirection': 'TextDirection? get textDirection',
      'sortKey': 'SemanticsSortKey? get sortKey',
      'textSelection': 'TextSelection? get textSelection',
      'isMultiline': 'bool? get isMultiline',
      'scrollChildCount': 'int? get scrollChildCount',
      'scrollIndex': 'int? get scrollIndex',
      'scrollPosition': 'double? get scrollPosition',
      'scrollExtentMax': 'double? get scrollExtentMax',
      'scrollExtentMin': 'double? get scrollExtentMin',
      'platformViewId': 'int? get platformViewId',
      'maxValueLength': 'int? get maxValueLength',
      'currentValueLength': 'int? get currentValueLength',
      'headingLevel': 'int get headingLevel',
      'linkUrl': 'Uri? get linkUrl',
      'role': 'SemanticsRole get role',
      'controlsNodes': 'Set<String>? get controlsNodes',
      'minValue': 'String? get minValue',
      'maxValue': 'String? get maxValue',
      'validationResult': 'SemanticsValidationResult get validationResult',
      'hitTestBehavior': 'ui.SemanticsHitTestBehavior get hitTestBehavior',
      'inputType': 'SemanticsInputType get inputType',
    },
    setterSignatures: {
      'transform': 'set transform(Matrix4? value)',
      'rect': 'set rect(Rect value)',
      'parentSemanticsClipRect': 'set parentSemanticsClipRect(dynamic value)',
      'parentPaintClipRect': 'set parentPaintClipRect(dynamic value)',
      'indexInParent': 'set indexInParent(dynamic value)',
      'isMergedIntoParent': 'set isMergedIntoParent(bool value)',
      'areUserActionsBlocked': 'set areUserActionsBlocked(bool value)',
      'traversalParent': 'set traversalParent(SemanticsNode? value)',
      'tags': 'set tags(dynamic value)',
    },
  );
}

// =============================================================================
// SemanticsOwner Bridge
// =============================================================================

BridgedClass _createSemanticsOwnerBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsOwner,
    name: 'SemanticsOwner',
    isAssignable: (v) => v is $flutter_6.SemanticsOwner,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('onSemanticsUpdate') || named['onSemanticsUpdate'] == null) {
          throw ArgumentError('SemanticsOwner: Missing required named argument "onSemanticsUpdate"');
        }
        final onSemanticsUpdateRaw = named['onSemanticsUpdate'];
        return $flutter_6.SemanticsOwner(onSemanticsUpdate: (SemanticsUpdate p0) { D4.callInterpreterCallback(visitor!, onSemanticsUpdateRaw, [p0]); });
      },
    },
    getters: {
      'onSemanticsUpdate': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner').onSemanticsUpdate,
      'rootSemanticsNode': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner').rootSemanticsNode,
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner').hasListeners,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        (t as dynamic).dispose();
        return null;
      },
      'sendSemanticsUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        t.sendSemanticsUpdate();
        return null;
      },
      'performAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 2, 'performAction');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'performAction');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 1, 'action', 'performAction');
        final args = D4.getOptionalArg<Object?>(positional, 2, 'args');
        t.performAction(id, action, args);
        return null;
      },
      'performActionAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 2, 'performActionAt');
        final position = D4.getRequiredArg<Offset>(positional, 0, 'position', 'performActionAt');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 1, 'action', 'performActionAt');
        final args = D4.getOptionalArg<Object?>(positional, 2, 'args');
        t.performActionAt(position, action, args);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        return t.toString();
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
    },
    constructorSignatures: {
      '': 'SemanticsOwner({required void Function(SemanticsUpdate) onSemanticsUpdate})',
    },
    methodSignatures: {
      'dispose': 'void dispose()',
      'sendSemanticsUpdate': 'void sendSemanticsUpdate()',
      'performAction': 'void performAction(int id, SemanticsAction action, [Object? args])',
      'performActionAt': 'void performActionAt(Offset position, SemanticsAction action, [Object? args])',
      'toString': 'String toString()',
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
    },
    getterSignatures: {
      'onSemanticsUpdate': 'SemanticsUpdateCallback get onSemanticsUpdate',
      'rootSemanticsNode': 'SemanticsNode? get rootSemanticsNode',
      'hasListeners': 'bool get hasListeners',
    },
  );
}

// =============================================================================
// SemanticsConfiguration Bridge
// =============================================================================

BridgedClass _createSemanticsConfigurationBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsConfiguration,
    name: 'SemanticsConfiguration',
    isAssignable: (v) => v is $flutter_6.SemanticsConfiguration,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_6.SemanticsConfiguration();
      },
    },
    getters: {
      'isSemanticBoundary': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSemanticBoundary,
      'localeForSubtree': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').localeForSubtree,
      'locale': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').locale,
      'isBlockingUserActions': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingUserActions,
      'explicitChildNodes': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').explicitChildNodes,
      'isBlockingSemanticsOfPreviouslyPaintedNodes': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingSemanticsOfPreviouslyPaintedNodes,
      'hasBeenAnnotated': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hasBeenAnnotated,
      'onTap': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onTap,
      'onLongPress': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onLongPress,
      'onScrollLeft': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollLeft,
      'onDismiss': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDismiss,
      'onScrollRight': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollRight,
      'onScrollUp': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollUp,
      'onScrollDown': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollDown,
      'onScrollToOffset': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollToOffset,
      'onIncrease': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onIncrease,
      'onDecrease': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDecrease,
      'onCopy': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCopy,
      'onCut': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCut,
      'onPaste': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onPaste,
      'onShowOnScreen': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onShowOnScreen,
      'onMoveCursorForwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByCharacter,
      'onMoveCursorBackwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByCharacter,
      'onMoveCursorForwardByWord': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByWord,
      'onMoveCursorBackwardByWord': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByWord,
      'onSetSelection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetSelection,
      'onSetText': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetText,
      'onDidGainAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidGainAccessibilityFocus,
      'onDidLoseAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidLoseAccessibilityFocus,
      'onFocus': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onFocus,
      'onExpand': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onExpand,
      'onCollapse': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCollapse,
      'childConfigurationsDelegate': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').childConfigurationsDelegate,
      'sortKey': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').sortKey,
      'indexInParent': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').indexInParent,
      'scrollChildCount': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollChildCount,
      'scrollIndex': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollIndex,
      'platformViewId': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').platformViewId,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').currentValueLength,
      'isMergingSemanticsOfDescendants': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMergingSemanticsOfDescendants,
      'customSemanticsActions': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').customSemanticsActions,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalChildIdentifier,
      'role': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').role,
      'label': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').value,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').tooltip,
      'hintOverrides': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hintOverrides,
      'scopesRoute': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scopesRoute,
      'namesRoute': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').namesRoute,
      'isImage': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isImage,
      'liveRegion': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').liveRegion,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').textDirection,
      'isSelected': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSelected,
      'isExpanded': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isExpanded,
      'isEnabled': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isEnabled,
      'isChecked': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isChecked,
      'isCheckStateMixed': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isCheckStateMixed,
      'isToggled': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isToggled,
      'isInMutuallyExclusiveGroup': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isInMutuallyExclusiveGroup,
      'isFocusable': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocusable,
      'isFocused': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocused,
      'accessibilityFocusBlockType': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').accessibilityFocusBlockType,
      'isButton': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isButton,
      'isLink': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isLink,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').linkUrl,
      'isHeader': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHeader,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').headingLevel,
      'isSlider': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSlider,
      'isKeyboardKey': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isKeyboardKey,
      'isHidden': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHidden,
      'isTextField': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isTextField,
      'isReadOnly': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isReadOnly,
      'isObscured': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isObscured,
      'isMultiline': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMultiline,
      'isRequired': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isRequired,
      'hasImplicitScrolling': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hasImplicitScrolling,
      'textSelection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').textSelection,
      'scrollPosition': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollPosition,
      'scrollExtentMax': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMax,
      'scrollExtentMin': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMin,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').controlsNodes,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').inputType,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValue,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').minValue,
      'tagsForChildren': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').tagsForChildren,
    },
    setters: {
      'isSemanticBoundary': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSemanticBoundary = D4.extractBridgedArg<bool>(value, 'isSemanticBoundary'),
      'localeForSubtree': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').localeForSubtree = D4.extractBridgedArgOrNull<Locale>(value, 'localeForSubtree'),
      'locale': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').locale = D4.extractBridgedArgOrNull<Locale>(value, 'locale'),
      'isBlockingUserActions': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingUserActions = D4.extractBridgedArg<bool>(value, 'isBlockingUserActions'),
      'explicitChildNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').explicitChildNodes = D4.extractBridgedArg<bool>(value, 'explicitChildNodes'),
      'isBlockingSemanticsOfPreviouslyPaintedNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingSemanticsOfPreviouslyPaintedNodes = D4.extractBridgedArg<bool>(value, 'isBlockingSemanticsOfPreviouslyPaintedNodes'),
      'onTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onTap = D4.extractBridgedArgOrNull<dynamic>(value, 'onTap'),
      'onLongPress': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onLongPress = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPress'),
      'onScrollLeft': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollLeft = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollLeft'),
      'onDismiss': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDismiss = D4.extractBridgedArgOrNull<dynamic>(value, 'onDismiss'),
      'onScrollRight': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollRight = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollRight'),
      'onScrollUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollUp = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollUp'),
      'onScrollDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollDown = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollDown'),
      'onScrollToOffset': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollToOffset = D4.extractBridgedArgOrNull<$flutter_6.ScrollToOffsetHandler>(value, 'onScrollToOffset'),
      'onIncrease': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onIncrease = D4.extractBridgedArgOrNull<dynamic>(value, 'onIncrease'),
      'onDecrease': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDecrease = D4.extractBridgedArgOrNull<dynamic>(value, 'onDecrease'),
      'onCopy': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCopy = D4.extractBridgedArgOrNull<dynamic>(value, 'onCopy'),
      'onCut': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCut = D4.extractBridgedArgOrNull<dynamic>(value, 'onCut'),
      'onPaste': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onPaste = D4.extractBridgedArgOrNull<dynamic>(value, 'onPaste'),
      'onShowOnScreen': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onShowOnScreen = D4.extractBridgedArgOrNull<dynamic>(value, 'onShowOnScreen'),
      'onMoveCursorForwardByCharacter': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByCharacter = D4.extractBridgedArgOrNull<$flutter_6.MoveCursorHandler>(value, 'onMoveCursorForwardByCharacter'),
      'onMoveCursorBackwardByCharacter': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByCharacter = D4.extractBridgedArgOrNull<$flutter_6.MoveCursorHandler>(value, 'onMoveCursorBackwardByCharacter'),
      'onMoveCursorForwardByWord': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByWord = D4.extractBridgedArgOrNull<$flutter_6.MoveCursorHandler>(value, 'onMoveCursorForwardByWord'),
      'onMoveCursorBackwardByWord': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByWord = D4.extractBridgedArgOrNull<$flutter_6.MoveCursorHandler>(value, 'onMoveCursorBackwardByWord'),
      'onSetSelection': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetSelection = D4.extractBridgedArgOrNull<$flutter_6.SetSelectionHandler>(value, 'onSetSelection'),
      'onSetText': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetText = D4.extractBridgedArgOrNull<$flutter_6.SetTextHandler>(value, 'onSetText'),
      'onDidGainAccessibilityFocus': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidGainAccessibilityFocus = D4.extractBridgedArgOrNull<dynamic>(value, 'onDidGainAccessibilityFocus'),
      'onDidLoseAccessibilityFocus': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidLoseAccessibilityFocus = D4.extractBridgedArgOrNull<dynamic>(value, 'onDidLoseAccessibilityFocus'),
      'onFocus': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onFocus = D4.extractBridgedArgOrNull<dynamic>(value, 'onFocus'),
      'onExpand': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onExpand = D4.extractBridgedArgOrNull<dynamic>(value, 'onExpand'),
      'onCollapse': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCollapse = D4.extractBridgedArgOrNull<dynamic>(value, 'onCollapse'),
      'childConfigurationsDelegate': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').childConfigurationsDelegate = D4.extractBridgedArgOrNull<$flutter_6.ChildSemanticsConfigurationsDelegate>(value, 'childConfigurationsDelegate'),
      'sortKey': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').sortKey = D4.extractBridgedArgOrNull<$flutter_6.SemanticsSortKey>(value, 'sortKey'),
      'indexInParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').indexInParent = D4.extractBridgedArgOrNull<int>(value, 'indexInParent'),
      'scrollChildCount': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollChildCount = D4.extractBridgedArgOrNull<int>(value, 'scrollChildCount'),
      'scrollIndex': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollIndex = D4.extractBridgedArgOrNull<int>(value, 'scrollIndex'),
      'platformViewId': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').platformViewId = D4.extractBridgedArgOrNull<int>(value, 'platformViewId'),
      'maxValueLength': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValueLength = D4.extractBridgedArgOrNull<int>(value, 'maxValueLength'),
      'currentValueLength': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').currentValueLength = D4.extractBridgedArgOrNull<int>(value, 'currentValueLength'),
      'isMergingSemanticsOfDescendants': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMergingSemanticsOfDescendants = D4.extractBridgedArg<bool>(value, 'isMergingSemanticsOfDescendants'),
      'customSemanticsActions': (visitor, target, value) {
        if (value == null) {
          throw ArgumentError('SemanticsConfiguration.customSemanticsActions: non-nullable map value cannot be null');
        }
        // Convert map with function values inline
        final customSemanticsActionsMapRaw = value as Map?;
        final customSemanticsActionsMap = <$flutter_6.CustomSemanticsAction, void Function()>{};
        if (customSemanticsActionsMapRaw != null) {
          for (final entry in customSemanticsActionsMapRaw.entries) {
            final k = D4.extractBridgedArg<$flutter_6.CustomSemanticsAction>(entry.key, 'customSemanticsActionsMap[key]');
            final v = entry.value;
            if (v == null) {
              // Skip null values for non-nullable function type
            } else if (v is Callable) {
              customSemanticsActionsMap[k] = () { D4.callInterpreterCallback(visitor!, v, []); };
            } else {
              customSemanticsActionsMap[k] = v as void Function();
            }
          }
        }
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').customSemanticsActions = customSemanticsActionsMap;
      },
      'identifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').identifier = D4.extractBridgedArg<String>(value, 'identifier'),
      'traversalParentIdentifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalParentIdentifier = D4.extractBridgedArgOrNull<Object>(value, 'traversalParentIdentifier'),
      'traversalChildIdentifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalChildIdentifier = D4.extractBridgedArgOrNull<Object>(value, 'traversalChildIdentifier'),
      'role': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').role = D4.extractBridgedArg<SemanticsRole>(value, 'role'),
      'label': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').label = D4.extractBridgedArg<String>(value, 'label'),
      'attributedLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedLabel = D4.extractBridgedArg<$flutter_6.AttributedString>(value, 'attributedLabel'),
      'value': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').value = D4.extractBridgedArg<String>(value, 'value'),
      'attributedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedValue = D4.extractBridgedArg<$flutter_6.AttributedString>(value, 'attributedValue'),
      'increasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').increasedValue = D4.extractBridgedArg<String>(value, 'increasedValue'),
      'attributedIncreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedIncreasedValue = D4.extractBridgedArg<$flutter_6.AttributedString>(value, 'attributedIncreasedValue'),
      'decreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').decreasedValue = D4.extractBridgedArg<String>(value, 'decreasedValue'),
      'attributedDecreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedDecreasedValue = D4.extractBridgedArg<$flutter_6.AttributedString>(value, 'attributedDecreasedValue'),
      'hint': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hint = D4.extractBridgedArg<String>(value, 'hint'),
      'attributedHint': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedHint = D4.extractBridgedArg<$flutter_6.AttributedString>(value, 'attributedHint'),
      'tooltip': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').tooltip = D4.extractBridgedArg<String>(value, 'tooltip'),
      'hintOverrides': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hintOverrides = D4.extractBridgedArgOrNull<$flutter_6.SemanticsHintOverrides>(value, 'hintOverrides'),
      'scopesRoute': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scopesRoute = D4.extractBridgedArg<bool>(value, 'scopesRoute'),
      'namesRoute': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').namesRoute = D4.extractBridgedArg<bool>(value, 'namesRoute'),
      'isImage': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isImage = D4.extractBridgedArg<bool>(value, 'isImage'),
      'liveRegion': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').liveRegion = D4.extractBridgedArg<bool>(value, 'liveRegion'),
      'textDirection': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').textDirection = D4.extractBridgedArgOrNull<TextDirection>(value, 'textDirection'),
      'isSelected': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSelected = D4.extractBridgedArg<bool>(value, 'isSelected'),
      'isExpanded': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isExpanded = D4.extractBridgedArgOrNull<bool>(value, 'isExpanded'),
      'isEnabled': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isEnabled = D4.extractBridgedArgOrNull<bool>(value, 'isEnabled'),
      'isChecked': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isChecked = D4.extractBridgedArgOrNull<bool>(value, 'isChecked'),
      'isCheckStateMixed': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isCheckStateMixed = D4.extractBridgedArgOrNull<bool>(value, 'isCheckStateMixed'),
      'isToggled': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isToggled = D4.extractBridgedArgOrNull<bool>(value, 'isToggled'),
      'isInMutuallyExclusiveGroup': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isInMutuallyExclusiveGroup = D4.extractBridgedArg<bool>(value, 'isInMutuallyExclusiveGroup'),
      'isFocusable': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocusable = D4.extractBridgedArg<bool>(value, 'isFocusable'),
      'isFocused': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocused = D4.extractBridgedArgOrNull<bool>(value, 'isFocused'),
      'accessibilityFocusBlockType': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').accessibilityFocusBlockType = D4.extractBridgedArg<$flutter_6.AccessibilityFocusBlockType>(value, 'accessibilityFocusBlockType'),
      'isButton': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isButton = D4.extractBridgedArg<bool>(value, 'isButton'),
      'isLink': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isLink = D4.extractBridgedArg<bool>(value, 'isLink'),
      'linkUrl': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').linkUrl = D4.extractBridgedArgOrNull<Uri>(value, 'linkUrl'),
      'isHeader': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHeader = D4.extractBridgedArg<bool>(value, 'isHeader'),
      'headingLevel': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').headingLevel = D4.extractBridgedArg<int>(value, 'headingLevel'),
      'isSlider': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSlider = D4.extractBridgedArg<bool>(value, 'isSlider'),
      'isKeyboardKey': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isKeyboardKey = D4.extractBridgedArg<bool>(value, 'isKeyboardKey'),
      'isHidden': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHidden = D4.extractBridgedArg<bool>(value, 'isHidden'),
      'isTextField': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isTextField = D4.extractBridgedArg<bool>(value, 'isTextField'),
      'isReadOnly': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isReadOnly = D4.extractBridgedArg<bool>(value, 'isReadOnly'),
      'isObscured': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isObscured = D4.extractBridgedArg<bool>(value, 'isObscured'),
      'isMultiline': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMultiline = D4.extractBridgedArg<bool>(value, 'isMultiline'),
      'isRequired': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isRequired = D4.extractBridgedArgOrNull<bool>(value, 'isRequired'),
      'hasImplicitScrolling': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hasImplicitScrolling = D4.extractBridgedArg<bool>(value, 'hasImplicitScrolling'),
      'textSelection': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').textSelection = D4.extractBridgedArgOrNull<$flutter_8.TextSelection>(value, 'textSelection'),
      'scrollPosition': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollPosition = D4.extractBridgedArgOrNull<double>(value, 'scrollPosition'),
      'scrollExtentMax': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMax = D4.extractBridgedArgOrNull<double>(value, 'scrollExtentMax'),
      'scrollExtentMin': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMin = D4.extractBridgedArgOrNull<double>(value, 'scrollExtentMin'),
      'controlsNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').controlsNodes = value == null ? null : (value as Set).cast<String>().toSet(),
      'validationResult': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').validationResult = D4.extractBridgedArg<SemanticsValidationResult>(value, 'validationResult'),
      'hitTestBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hitTestBehavior = D4.extractBridgedArg<SemanticsHitTestBehavior>(value, 'hitTestBehavior'),
      'inputType': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').inputType = D4.extractBridgedArg<SemanticsInputType>(value, 'inputType'),
      'maxValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValue = D4.extractBridgedArgOrNull<String>(value, 'maxValue'),
      'minValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').minValue = D4.extractBridgedArgOrNull<String>(value, 'minValue'),
    },
    methods: {
      'getActionHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'getActionHandler');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 0, 'action', 'getActionHandler');
        return t.getActionHandler(action);
      },
      'tagsChildrenWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'tagsChildrenWith');
        final tag = D4.getRequiredArg<$flutter_6.SemanticsTag>(positional, 0, 'tag', 'tagsChildrenWith');
        return t.tagsChildrenWith(tag);
      },
      'addTagForChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'addTagForChildren');
        final tag = D4.getRequiredArg<$flutter_6.SemanticsTag>(positional, 0, 'tag', 'addTagForChildren');
        t.addTagForChildren(tag);
        return null;
      },
      'isCompatibleWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'isCompatibleWith');
        final other = D4.getRequiredArg<$flutter_6.SemanticsConfiguration?>(positional, 0, 'other', 'isCompatibleWith');
        return t.isCompatibleWith(other);
      },
      'absorb': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'absorb');
        final child = D4.getRequiredArg<$flutter_6.SemanticsConfiguration>(positional, 0, 'child', 'absorb');
        t.absorb(child);
        return null;
      },
      'copy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        return t.copy();
      },
    },
    constructorSignatures: {
      '': 'SemanticsConfiguration()',
    },
    methodSignatures: {
      'getActionHandler': 'SemanticsActionHandler? getActionHandler(SemanticsAction action)',
      'tagsChildrenWith': 'bool tagsChildrenWith(SemanticsTag tag)',
      'addTagForChildren': 'void addTagForChildren(SemanticsTag tag)',
      'isCompatibleWith': 'bool isCompatibleWith(SemanticsConfiguration? other)',
      'absorb': 'void absorb(SemanticsConfiguration child)',
      'copy': 'SemanticsConfiguration copy()',
    },
    getterSignatures: {
      'isSemanticBoundary': 'bool get isSemanticBoundary',
      'localeForSubtree': 'Locale? get localeForSubtree',
      'locale': 'Locale? get locale',
      'isBlockingUserActions': 'bool get isBlockingUserActions',
      'explicitChildNodes': 'bool get explicitChildNodes',
      'isBlockingSemanticsOfPreviouslyPaintedNodes': 'bool get isBlockingSemanticsOfPreviouslyPaintedNodes',
      'hasBeenAnnotated': 'bool get hasBeenAnnotated',
      'onTap': 'VoidCallback? get onTap',
      'onLongPress': 'VoidCallback? get onLongPress',
      'onScrollLeft': 'VoidCallback? get onScrollLeft',
      'onDismiss': 'VoidCallback? get onDismiss',
      'onScrollRight': 'VoidCallback? get onScrollRight',
      'onScrollUp': 'VoidCallback? get onScrollUp',
      'onScrollDown': 'VoidCallback? get onScrollDown',
      'onScrollToOffset': 'ScrollToOffsetHandler? get onScrollToOffset',
      'onIncrease': 'VoidCallback? get onIncrease',
      'onDecrease': 'VoidCallback? get onDecrease',
      'onCopy': 'VoidCallback? get onCopy',
      'onCut': 'VoidCallback? get onCut',
      'onPaste': 'VoidCallback? get onPaste',
      'onShowOnScreen': 'VoidCallback? get onShowOnScreen',
      'onMoveCursorForwardByCharacter': 'MoveCursorHandler? get onMoveCursorForwardByCharacter',
      'onMoveCursorBackwardByCharacter': 'MoveCursorHandler? get onMoveCursorBackwardByCharacter',
      'onMoveCursorForwardByWord': 'MoveCursorHandler? get onMoveCursorForwardByWord',
      'onMoveCursorBackwardByWord': 'MoveCursorHandler? get onMoveCursorBackwardByWord',
      'onSetSelection': 'SetSelectionHandler? get onSetSelection',
      'onSetText': 'SetTextHandler? get onSetText',
      'onDidGainAccessibilityFocus': 'VoidCallback? get onDidGainAccessibilityFocus',
      'onDidLoseAccessibilityFocus': 'VoidCallback? get onDidLoseAccessibilityFocus',
      'onFocus': 'VoidCallback? get onFocus',
      'onExpand': 'VoidCallback? get onExpand',
      'onCollapse': 'VoidCallback? get onCollapse',
      'childConfigurationsDelegate': 'ChildSemanticsConfigurationsDelegate? get childConfigurationsDelegate',
      'sortKey': 'SemanticsSortKey? get sortKey',
      'indexInParent': 'int? get indexInParent',
      'scrollChildCount': 'int? get scrollChildCount',
      'scrollIndex': 'int? get scrollIndex',
      'platformViewId': 'int? get platformViewId',
      'maxValueLength': 'int? get maxValueLength',
      'currentValueLength': 'int? get currentValueLength',
      'isMergingSemanticsOfDescendants': 'bool get isMergingSemanticsOfDescendants',
      'customSemanticsActions': 'Map<CustomSemanticsAction, VoidCallback> get customSemanticsActions',
      'identifier': 'String get identifier',
      'traversalParentIdentifier': 'Object? get traversalParentIdentifier',
      'traversalChildIdentifier': 'Object? get traversalChildIdentifier',
      'role': 'SemanticsRole get role',
      'label': 'String get label',
      'attributedLabel': 'AttributedString get attributedLabel',
      'value': 'String get value',
      'attributedValue': 'AttributedString get attributedValue',
      'increasedValue': 'String get increasedValue',
      'attributedIncreasedValue': 'AttributedString get attributedIncreasedValue',
      'decreasedValue': 'String get decreasedValue',
      'attributedDecreasedValue': 'AttributedString get attributedDecreasedValue',
      'hint': 'String get hint',
      'attributedHint': 'AttributedString get attributedHint',
      'tooltip': 'String get tooltip',
      'hintOverrides': 'SemanticsHintOverrides? get hintOverrides',
      'scopesRoute': 'bool get scopesRoute',
      'namesRoute': 'bool get namesRoute',
      'isImage': 'bool get isImage',
      'liveRegion': 'bool get liveRegion',
      'textDirection': 'TextDirection? get textDirection',
      'isSelected': 'bool get isSelected',
      'isExpanded': 'bool? get isExpanded',
      'isEnabled': 'bool? get isEnabled',
      'isChecked': 'bool? get isChecked',
      'isCheckStateMixed': 'bool? get isCheckStateMixed',
      'isToggled': 'bool? get isToggled',
      'isInMutuallyExclusiveGroup': 'bool get isInMutuallyExclusiveGroup',
      'isFocusable': 'bool get isFocusable',
      'isFocused': 'bool? get isFocused',
      'accessibilityFocusBlockType': 'AccessibilityFocusBlockType get accessibilityFocusBlockType',
      'isButton': 'bool get isButton',
      'isLink': 'bool get isLink',
      'linkUrl': 'Uri? get linkUrl',
      'isHeader': 'bool get isHeader',
      'headingLevel': 'int get headingLevel',
      'isSlider': 'bool get isSlider',
      'isKeyboardKey': 'bool get isKeyboardKey',
      'isHidden': 'bool get isHidden',
      'isTextField': 'bool get isTextField',
      'isReadOnly': 'bool get isReadOnly',
      'isObscured': 'bool get isObscured',
      'isMultiline': 'bool get isMultiline',
      'isRequired': 'bool? get isRequired',
      'hasImplicitScrolling': 'bool get hasImplicitScrolling',
      'textSelection': 'TextSelection? get textSelection',
      'scrollPosition': 'double? get scrollPosition',
      'scrollExtentMax': 'double? get scrollExtentMax',
      'scrollExtentMin': 'double? get scrollExtentMin',
      'controlsNodes': 'Set<String>? get controlsNodes',
      'validationResult': 'SemanticsValidationResult get validationResult',
      'hitTestBehavior': 'ui.SemanticsHitTestBehavior get hitTestBehavior',
      'inputType': 'SemanticsInputType get inputType',
      'maxValue': 'String? get maxValue',
      'minValue': 'String? get minValue',
      'tagsForChildren': 'Iterable<SemanticsTag>? get tagsForChildren',
    },
    setterSignatures: {
      'isSemanticBoundary': 'set isSemanticBoundary(bool value)',
      'localeForSubtree': 'set localeForSubtree(Locale? value)',
      'locale': 'set locale(dynamic value)',
      'isBlockingUserActions': 'set isBlockingUserActions(dynamic value)',
      'explicitChildNodes': 'set explicitChildNodes(dynamic value)',
      'isBlockingSemanticsOfPreviouslyPaintedNodes': 'set isBlockingSemanticsOfPreviouslyPaintedNodes(dynamic value)',
      'onTap': 'set onTap(VoidCallback? value)',
      'onLongPress': 'set onLongPress(VoidCallback? value)',
      'onScrollLeft': 'set onScrollLeft(VoidCallback? value)',
      'onDismiss': 'set onDismiss(VoidCallback? value)',
      'onScrollRight': 'set onScrollRight(VoidCallback? value)',
      'onScrollUp': 'set onScrollUp(VoidCallback? value)',
      'onScrollDown': 'set onScrollDown(VoidCallback? value)',
      'onScrollToOffset': 'set onScrollToOffset(ScrollToOffsetHandler? value)',
      'onIncrease': 'set onIncrease(VoidCallback? value)',
      'onDecrease': 'set onDecrease(VoidCallback? value)',
      'onCopy': 'set onCopy(VoidCallback? value)',
      'onCut': 'set onCut(VoidCallback? value)',
      'onPaste': 'set onPaste(VoidCallback? value)',
      'onShowOnScreen': 'set onShowOnScreen(VoidCallback? value)',
      'onMoveCursorForwardByCharacter': 'set onMoveCursorForwardByCharacter(MoveCursorHandler? value)',
      'onMoveCursorBackwardByCharacter': 'set onMoveCursorBackwardByCharacter(MoveCursorHandler? value)',
      'onMoveCursorForwardByWord': 'set onMoveCursorForwardByWord(MoveCursorHandler? value)',
      'onMoveCursorBackwardByWord': 'set onMoveCursorBackwardByWord(MoveCursorHandler? value)',
      'onSetSelection': 'set onSetSelection(SetSelectionHandler? value)',
      'onSetText': 'set onSetText(SetTextHandler? value)',
      'onDidGainAccessibilityFocus': 'set onDidGainAccessibilityFocus(VoidCallback? value)',
      'onDidLoseAccessibilityFocus': 'set onDidLoseAccessibilityFocus(VoidCallback? value)',
      'onFocus': 'set onFocus(VoidCallback? value)',
      'onExpand': 'set onExpand(VoidCallback? value)',
      'onCollapse': 'set onCollapse(VoidCallback? value)',
      'childConfigurationsDelegate': 'set childConfigurationsDelegate(ChildSemanticsConfigurationsDelegate? value)',
      'sortKey': 'set sortKey(SemanticsSortKey? value)',
      'indexInParent': 'set indexInParent(int? value)',
      'scrollChildCount': 'set scrollChildCount(int? value)',
      'scrollIndex': 'set scrollIndex(int? value)',
      'platformViewId': 'set platformViewId(int? value)',
      'maxValueLength': 'set maxValueLength(int? value)',
      'currentValueLength': 'set currentValueLength(int? value)',
      'isMergingSemanticsOfDescendants': 'set isMergingSemanticsOfDescendants(bool value)',
      'customSemanticsActions': 'set customSemanticsActions(Map<CustomSemanticsAction, VoidCallback> value)',
      'identifier': 'set identifier(String value)',
      'traversalParentIdentifier': 'set traversalParentIdentifier(Object? value)',
      'traversalChildIdentifier': 'set traversalChildIdentifier(Object? value)',
      'role': 'set role(SemanticsRole value)',
      'label': 'set label(String value)',
      'attributedLabel': 'set attributedLabel(AttributedString value)',
      'value': 'set value(String value)',
      'attributedValue': 'set attributedValue(AttributedString value)',
      'increasedValue': 'set increasedValue(String value)',
      'attributedIncreasedValue': 'set attributedIncreasedValue(AttributedString value)',
      'decreasedValue': 'set decreasedValue(String value)',
      'attributedDecreasedValue': 'set attributedDecreasedValue(AttributedString value)',
      'hint': 'set hint(String value)',
      'attributedHint': 'set attributedHint(AttributedString value)',
      'tooltip': 'set tooltip(String value)',
      'hintOverrides': 'set hintOverrides(SemanticsHintOverrides? value)',
      'scopesRoute': 'set scopesRoute(bool value)',
      'namesRoute': 'set namesRoute(bool value)',
      'isImage': 'set isImage(bool value)',
      'liveRegion': 'set liveRegion(bool value)',
      'textDirection': 'set textDirection(TextDirection? value)',
      'isSelected': 'set isSelected(bool value)',
      'isExpanded': 'set isExpanded(bool? value)',
      'isEnabled': 'set isEnabled(bool? value)',
      'isChecked': 'set isChecked(bool? value)',
      'isCheckStateMixed': 'set isCheckStateMixed(bool? value)',
      'isToggled': 'set isToggled(bool? value)',
      'isInMutuallyExclusiveGroup': 'set isInMutuallyExclusiveGroup(bool value)',
      'isFocusable': 'set isFocusable(bool value)',
      'isFocused': 'set isFocused(bool? value)',
      'accessibilityFocusBlockType': 'set accessibilityFocusBlockType(AccessibilityFocusBlockType value)',
      'isButton': 'set isButton(bool value)',
      'isLink': 'set isLink(bool value)',
      'linkUrl': 'set linkUrl(Uri? value)',
      'isHeader': 'set isHeader(bool value)',
      'headingLevel': 'set headingLevel(int value)',
      'isSlider': 'set isSlider(bool value)',
      'isKeyboardKey': 'set isKeyboardKey(bool value)',
      'isHidden': 'set isHidden(bool value)',
      'isTextField': 'set isTextField(bool value)',
      'isReadOnly': 'set isReadOnly(bool value)',
      'isObscured': 'set isObscured(bool value)',
      'isMultiline': 'set isMultiline(bool value)',
      'isRequired': 'set isRequired(bool? value)',
      'hasImplicitScrolling': 'set hasImplicitScrolling(bool value)',
      'textSelection': 'set textSelection(TextSelection? value)',
      'scrollPosition': 'set scrollPosition(double? value)',
      'scrollExtentMax': 'set scrollExtentMax(double? value)',
      'scrollExtentMin': 'set scrollExtentMin(double? value)',
      'controlsNodes': 'set controlsNodes(Set<String>? value)',
      'validationResult': 'set validationResult(SemanticsValidationResult value)',
      'hitTestBehavior': 'set hitTestBehavior(ui.SemanticsHitTestBehavior value)',
      'inputType': 'set inputType(SemanticsInputType value)',
      'maxValue': 'set maxValue(String? value)',
      'minValue': 'set minValue(String? value)',
    },
  );
}

// =============================================================================
// SemanticsSortKey Bridge
// =============================================================================

BridgedClass _createSemanticsSortKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsSortKey,
    name: 'SemanticsSortKey',
    isAssignable: (v) => v is $flutter_6.SemanticsSortKey,
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey').name,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_6.SemanticsSortKey>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'doCompare': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        D4.requireMinArgs(positional, 1, 'doCompare');
        final other = D4.getRequiredArg<$flutter_6.SemanticsSortKey>(positional, 0, 'other', 'doCompare');
        return t.doCompare(other);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    methodSignatures: {
      'compareTo': 'int compareTo(SemanticsSortKey other)',
      'doCompare': 'int doCompare(SemanticsSortKey other)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'name': 'String? get name',
    },
  );
}

// =============================================================================
// OrdinalSortKey Bridge
// =============================================================================

BridgedClass _createOrdinalSortKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_6.OrdinalSortKey,
    name: 'OrdinalSortKey',
    isAssignable: (v) => v is $flutter_6.OrdinalSortKey,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OrdinalSortKey');
        final order = D4.getRequiredArg<double>(positional, 0, 'order', 'OrdinalSortKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        return $flutter_6.OrdinalSortKey(order, name: name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey').name,
      'order': (visitor, target) => D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey').order,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_6.SemanticsSortKey>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'doCompare': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        D4.requireMinArgs(positional, 1, 'doCompare');
        final other = D4.getRequiredArg<$flutter_6.OrdinalSortKey>(positional, 0, 'other', 'doCompare');
        return t.doCompare(other);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const OrdinalSortKey(double order, {String? name})',
    },
    methodSignatures: {
      'compareTo': 'int compareTo(SemanticsSortKey other)',
      'doCompare': 'int doCompare(OrdinalSortKey other)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'name': 'String? get name',
      'order': 'double get order',
    },
  );
}

// =============================================================================
// SemanticsService Bridge
// =============================================================================

BridgedClass _createSemanticsServiceBridge() {
  return BridgedClass(
    nativeType: SemanticsService,
    name: 'SemanticsService',
    isAssignable: (v) => v is SemanticsService,
    constructors: {
    },
    staticMethods: {
      'announce': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'announce');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'announce');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'announce');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_7.Assertiveness>(named, 'assertiveness', $flutter_7.Assertiveness.polite);
        return SemanticsService.announce(message, textDirection, assertiveness: assertiveness);
      },
      'sendAnnouncement': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'sendAnnouncement');
        final view = D4.getRequiredArg<FlutterView>(positional, 0, 'view', 'sendAnnouncement');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'sendAnnouncement');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 2, 'textDirection', 'sendAnnouncement');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_7.Assertiveness>(named, 'assertiveness', $flutter_7.Assertiveness.polite);
        return SemanticsService.sendAnnouncement(view, message, textDirection, assertiveness: assertiveness);
      },
      'tooltip': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'tooltip');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'tooltip');
        return SemanticsService.tooltip(message);
      },
    },
    staticMethodSignatures: {
      'announce': 'Future<void> announce(String message, TextDirection textDirection, {Assertiveness assertiveness = Assertiveness.polite})',
      'sendAnnouncement': 'Future<void> sendAnnouncement(FlutterView view, String message, TextDirection textDirection, {Assertiveness assertiveness = Assertiveness.polite})',
      'tooltip': 'Future<void> tooltip(String message)',
    },
  );
}

