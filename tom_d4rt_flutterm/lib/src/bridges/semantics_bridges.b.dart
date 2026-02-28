// D4rt Bridge - Generated file, do not edit
// Sources: 14 files
// Generated: 2026-02-28T15:11:47.089719

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
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_2;
import 'package:flutter/src/foundation/key.dart' as $flutter_3;
import 'package:flutter/src/semantics/binding.dart' as $flutter_4;
import 'package:flutter/src/semantics/debug.dart' as $flutter_5;
import 'package:flutter/src/semantics/semantics.dart' as $flutter_6;
import 'package:flutter/src/semantics/semantics_event.dart' as $flutter_7;
import 'package:flutter/src/semantics/semantics_service.dart' as $flutter_8;
import 'package:flutter/src/services/text_editing.dart' as $flutter_9;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;
import 'package:flutter/src/foundation/binding.dart' as $aux_flutter;
import 'package:flutter/src/foundation/change_notifier.dart' as $aux_flutter_3;

/// Bridge class for flutter_semantics module.
class FlutterSemanticsBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createSemanticsBindingBridge(),
      _createSemanticsHandleBridge(),
      _createDiagnosticsNodeBridge(),
      _createDiagnosticPropertiesBuilderBridge(),
      _createKeyBridge(),
      _createMatrix4Bridge(),
      _createTextSelectionBridge(),
      _createSemanticsEventBridge(),
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
      'SemanticsBinding': 'package:flutter/src/semantics/binding.dart',
      'SemanticsHandle': 'package:flutter/src/semantics/binding.dart',
      'DiagnosticsNode': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticPropertiesBuilder': 'package:flutter/src/foundation/diagnostics.dart',
      'Key': 'package:flutter/src/foundation/key.dart',
      'Matrix4': 'package:vector_math/vector_math_64.dart',
      'TextSelection': 'package:flutter/src/services/text_editing.dart',
      'SemanticsEvent': 'package:flutter/src/semantics/semantics_event.dart',
      'SemanticsTag': 'package:flutter/src/semantics/semantics.dart',
      'ChildSemanticsConfigurationsResult': 'package:flutter/src/semantics/semantics.dart',
      'ChildSemanticsConfigurationsResultBuilder': 'package:flutter/src/semantics/semantics.dart',
      'CustomSemanticsAction': 'package:flutter/src/semantics/semantics.dart',
      'AttributedString': 'package:flutter/src/semantics/semantics.dart',
      'AttributedStringProperty': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsLabelBuilder': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsData': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsHintOverrides': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsProperties': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsNode': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsOwner': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsConfiguration': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsSortKey': 'package:flutter/src/semantics/semantics.dart',
      'OrdinalSortKey': 'package:flutter/src/semantics/semantics.dart',
      'SemanticsService': 'package:flutter/src/semantics/semantics_service.dart',
      'Vector3': 'package:vector_math/vector_math_64.dart',
      'Vector2': 'package:vector_math/vector_math_64.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_2.DiagnosticLevel>(
        name: 'DiagnosticLevel',
        values: $flutter_2.DiagnosticLevel.values,
      ),
      BridgedEnumDefinition<$flutter_2.DiagnosticsTreeStyle>(
        name: 'DiagnosticsTreeStyle',
        values: $flutter_2.DiagnosticsTreeStyle.values,
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
      'DiagnosticLevel': 'package:flutter/src/foundation/diagnostics.dart',
      'DiagnosticsTreeStyle': 'package:flutter/src/foundation/diagnostics.dart',
      'AccessibilityFocusBlockType': 'package:flutter/src/semantics/semantics.dart',
      'DebugSemanticsDumpOrder': 'package:flutter/src/semantics/semantics.dart',
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
      interpreter.registerGlobalVariable('debugSemanticsDisableAnimations', $flutter_5.debugSemanticsDisableAnimations, importPath, sourceUri: 'package:flutter/src/semantics/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugSemanticsDisableAnimations": $e');
    }
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
      'debugResetSemanticsIdCounter': (visitor, positional, named, typeArgs) {
        return $flutter_6.debugResetSemanticsIdCounter();
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
      'debugResetSemanticsIdCounter': 'package:flutter/src/semantics/semantics.dart',
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
      'package:flutter/src/foundation/diagnostics.dart',
      'package:flutter/src/foundation/key.dart',
      'package:flutter/src/semantics/binding.dart',
      'package:flutter/src/semantics/debug.dart',
      'package:flutter/src/semantics/semantics.dart',
      'package:flutter/src/semantics/semantics_event.dart',
      'package:flutter/src/semantics/semantics_service.dart',
      'package:flutter/src/services/text_editing.dart',
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
    imports.writeln("import 'package:flutter/semantics.dart';");
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
    'DiagnosticLevel',
    'DiagnosticsTreeStyle',
    'AccessibilityFocusBlockType',
    'DebugSemanticsDumpOrder',
  ];

}

// =============================================================================
// SemanticsBinding Bridge
// =============================================================================

BridgedClass _createSemanticsBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_4.SemanticsBinding,
    name: 'SemanticsBinding',
    constructors: {
    },
    getters: {
      'semanticsEnabled': (visitor, target) => D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding').semanticsEnabled,
      'debugOutstandingSemanticsHandles': (visitor, target) => D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding').debugOutstandingSemanticsHandles,
      'accessibilityFeatures': (visitor, target) => D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding').accessibilityFeatures,
      'disableAnimations': (visitor, target) => D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding').disableAnimations,
      'window': (visitor, target) => D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding').platformDispatcher,
    },
    methods: {
      'addSemanticsEnabledListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'addSemanticsEnabledListener');
        if (positional.isEmpty) {
          throw ArgumentError('addSemanticsEnabledListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addSemanticsEnabledListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeSemanticsEnabledListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'removeSemanticsEnabledListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeSemanticsEnabledListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeSemanticsEnabledListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'addSemanticsActionListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'addSemanticsActionListener');
        if (positional.isEmpty) {
          throw ArgumentError('addSemanticsActionListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addSemanticsActionListener((SemanticsActionEvent p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeSemanticsActionListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'removeSemanticsActionListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeSemanticsActionListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeSemanticsActionListener((SemanticsActionEvent p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'ensureSemantics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        return t.ensureSemantics();
      },
      'createSemanticsUpdateBuilder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        return t.createSemanticsUpdateBuilder();
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        return t.reassembleApplication();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsBinding>(target, 'SemanticsBinding');
        return t.toString();
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_4.SemanticsBinding.instance,
    },
    methodSignatures: {
      'addSemanticsEnabledListener': 'void addSemanticsEnabledListener(VoidCallback listener)',
      'removeSemanticsEnabledListener': 'void removeSemanticsEnabledListener(VoidCallback listener)',
      'addSemanticsActionListener': 'void addSemanticsActionListener(ValueSetter<ui.SemanticsActionEvent> listener)',
      'removeSemanticsActionListener': 'void removeSemanticsActionListener(ValueSetter<ui.SemanticsActionEvent> listener)',
      'ensureSemantics': 'SemanticsHandle ensureSemantics()',
      'createSemanticsUpdateBuilder': 'ui.SemanticsUpdateBuilder createSemanticsUpdateBuilder()',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'semanticsEnabled': 'bool get semanticsEnabled',
      'debugOutstandingSemanticsHandles': 'int get debugOutstandingSemanticsHandles',
      'accessibilityFeatures': 'ui.AccessibilityFeatures get accessibilityFeatures',
      'disableAnimations': 'bool get disableAnimations',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
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
    nativeType: $flutter_4.SemanticsHandle,
    name: 'SemanticsHandle',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.SemanticsHandle>(target, 'SemanticsHandle');
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
// DiagnosticsNode Bridge
// =============================================================================

BridgedClass _createDiagnosticsNodeBridge() {
  return BridgedClass(
    nativeType: $flutter_2.DiagnosticsNode,
    name: 'DiagnosticsNode',
    constructors: {
      'message': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticsNode');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DiagnosticsNode');
        final style = D4.getNamedArgWithDefault<$flutter_2.DiagnosticsTreeStyle>(named, 'style', $flutter_2.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'level', $flutter_2.DiagnosticLevel.info);
        final allowWrap = D4.getNamedArgWithDefault<bool>(named, 'allowWrap', true);
        return $flutter_2.DiagnosticsNode.message(message, style: style, level: level, allowWrap: allowWrap);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').showSeparator,
      'level': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').level,
      'showName': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').emptyBodyDescription,
      'value': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').value,
      'style': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').style,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').allowNameWrap,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode').allowTruncate,
    },
    methods: {
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_2.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_2.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.getChildren();
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        return t.toTimelineArguments();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_2.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_2.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_2.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticsNode>(target, 'DiagnosticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_2.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
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
        final nodes = D4.coerceListOrNull<$flutter_2.DiagnosticsNode>(positional[0], 'nodes');
        final parent = D4.getRequiredArg<$flutter_2.DiagnosticsNode?>(positional, 1, 'parent', 'toJsonList');
        final delegate = D4.getRequiredArg<$flutter_2.DiagnosticsSerializationDelegate>(positional, 2, 'delegate', 'toJsonList');
        return $flutter_2.DiagnosticsNode.toJsonList(nodes, parent, delegate);
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
    nativeType: $flutter_2.DiagnosticPropertiesBuilder,
    name: 'DiagnosticPropertiesBuilder',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_2.DiagnosticPropertiesBuilder();
      },
      'fromProperties': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DiagnosticPropertiesBuilder');
        if (positional.isEmpty) {
          throw ArgumentError('DiagnosticPropertiesBuilder: Missing required argument "properties" at position 0');
        }
        final properties = D4.coerceList<$flutter_2.DiagnosticsNode>(positional[0], 'properties');
        return $flutter_2.DiagnosticPropertiesBuilder.fromProperties(properties);
      },
    },
    getters: {
      'properties': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').properties,
      'defaultDiagnosticsTreeStyle': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_2.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription,
    },
    setters: {
      'defaultDiagnosticsTreeStyle': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').defaultDiagnosticsTreeStyle = value as $flutter_2.DiagnosticsTreeStyle,
      'emptyBodyDescription': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder').emptyBodyDescription = value as String?,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.DiagnosticPropertiesBuilder>(target, 'DiagnosticPropertiesBuilder');
        D4.requireMinArgs(positional, 1, 'add');
        final property = D4.getRequiredArg<$flutter_2.DiagnosticsNode>(positional, 0, 'property', 'add');
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
// Key Bridge
// =============================================================================

BridgedClass _createKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_3.Key,
    name: 'Key',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Key');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'Key');
        return $flutter_3.Key(value);
      },
    },
    constructorSignatures: {
      '': 'const factory Key(String value)',
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
// TextSelection Bridge
// =============================================================================

BridgedClass _createTextSelectionBridge() {
  return BridgedClass(
    nativeType: $flutter_9.TextSelection,
    name: 'TextSelection',
    constructors: {
      '': (visitor, positional, named) {
        final baseOffset = D4.getRequiredNamedArg<int>(named, 'baseOffset', 'TextSelection');
        final extentOffset = D4.getRequiredNamedArg<int>(named, 'extentOffset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        final isDirectional = D4.getNamedArgWithDefault<bool>(named, 'isDirectional', false);
        return $flutter_9.TextSelection(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'collapsed': (visitor, positional, named) {
        final offset = D4.getRequiredNamedArg<int>(named, 'offset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        return $flutter_9.TextSelection.collapsed(offset: offset, affinity: affinity);
      },
      'fromPosition': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextSelection');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'TextSelection');
        return $flutter_9.TextSelection.fromPosition(position);
      },
    },
    getters: {
      'baseOffset': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').baseOffset,
      'extentOffset': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').extentOffset,
      'affinity': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').affinity,
      'isDirectional': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').isDirectional,
      'base': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').base,
      'extent': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').extent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').end,
      'isValid': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').isValid,
      'isCollapsed': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').isCollapsed,
      'isNormalized': (visitor, target) => D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection').isNormalized,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
        final baseOffset = D4.getOptionalNamedArg<int?>(named, 'baseOffset');
        final extentOffset = D4.getOptionalNamedArg<int?>(named, 'extentOffset');
        final affinity = D4.getOptionalNamedArg<TextAffinity?>(named, 'affinity');
        final isDirectional = D4.getOptionalNamedArg<bool?>(named, 'isDirectional');
        return t.copyWith(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'expandTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'expandTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'expandTo');
        final extentAtIndex = D4.getOptionalArgWithDefault<bool>(positional, 1, 'extentAtIndex', false);
        return t.expandTo(position, extentAtIndex);
      },
      'extendTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'extendTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'extendTo');
        return t.extendTo(position);
      },
      'textBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textBefore');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textBefore');
        return t.textBefore(text);
      },
      'textAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textAfter');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textAfter');
        return t.textAfter(text);
      },
      'textInside': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textInside');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textInside');
        return t.textInside(text);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.TextSelection>(target, 'TextSelection');
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
// SemanticsTag Bridge
// =============================================================================

BridgedClass _createSemanticsTagBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsTag,
    name: 'SemanticsTag',
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
    nativeType: $flutter_6.ChildSemanticsConfigurationsResultBuilder,
    name: 'ChildSemanticsConfigurationsResultBuilder',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_6.ChildSemanticsConfigurationsResultBuilder();
      },
    },
    methods: {
      'markAsMergeUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
        D4.requireMinArgs(positional, 1, 'markAsMergeUp');
        final config = D4.getRequiredArg<$flutter_6.SemanticsConfiguration>(positional, 0, 'config', 'markAsMergeUp');
        t.markAsMergeUp(config);
        return null;
      },
      'markAsSiblingMergeGroup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
        D4.requireMinArgs(positional, 1, 'markAsSiblingMergeGroup');
        if (positional.isEmpty) {
          throw ArgumentError('markAsSiblingMergeGroup: Missing required argument "configs" at position 0');
        }
        final configs = D4.coerceList<$flutter_6.SemanticsConfiguration>(positional[0], 'configs');
        t.markAsSiblingMergeGroup(configs);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
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
    nativeType: $flutter_6.AttributedStringProperty,
    name: 'AttributedStringProperty',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AttributedStringProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'AttributedStringProperty');
        final value = D4.getRequiredArg<$flutter_6.AttributedString?>(positional, 1, 'value', 'AttributedStringProperty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showWhenEmpty = D4.getNamedArgWithDefault<bool>(named, 'showWhenEmpty', false);
        final level = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'level', $flutter_2.DiagnosticLevel.info);
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        if (!named.containsKey('defaultValue')) {
          return $flutter_6.AttributedStringProperty(name, value, showName: showName, showWhenEmpty: showWhenEmpty, level: level, description: description);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'AttributedStringProperty');
          return $flutter_6.AttributedStringProperty(name, value, showName: showName, showWhenEmpty: showWhenEmpty, level: level, description: description, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'showWhenEmpty': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').showWhenEmpty,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').isInteresting,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').defaultValue,
      'level': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty').allowTruncate,
    },
    methods: {
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_2.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_2.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_2.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_2.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_2.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_2.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.AttributedStringProperty>(target, 'AttributedStringProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_2.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
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
    },
  );
}

// =============================================================================
// SemanticsLabelBuilder Bridge
// =============================================================================

BridgedClass _createSemanticsLabelBuilderBridge() {
  return BridgedClass(
    nativeType: $flutter_6.SemanticsLabelBuilder,
    name: 'SemanticsLabelBuilder',
    constructors: {
      '': (visitor, positional, named) {
        final separator = D4.getNamedArgWithDefault<String>(named, 'separator', ' ');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return $flutter_6.SemanticsLabelBuilder(separator: separator, textDirection: textDirection);
      },
    },
    getters: {
      'separator': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').separator,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').textDirection,
      'isEmpty': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').isEmpty,
      'length': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').length,
    },
    methods: {
      'addPart': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
        D4.requireMinArgs(positional, 1, 'addPart');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'addPart');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.addPart(label, textDirection: textDirection);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
        return (t as dynamic).build();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
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
        final textSelection = D4.getRequiredNamedArg<$flutter_9.TextSelection?>(named, 'textSelection', 'SemanticsData');
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
        final controlsNodes = D4.getRequiredNamedArg<Set<String>?>(named, 'controlsNodes', 'SemanticsData');
        final validationResult = D4.getRequiredNamedArg<SemanticsValidationResult>(named, 'validationResult', 'SemanticsData');
        final hitTestBehavior = D4.getRequiredNamedArg<SemanticsHitTestBehavior>(named, 'hitTestBehavior', 'SemanticsData');
        final inputType = D4.getRequiredNamedArg<SemanticsInputType>(named, 'inputType', 'SemanticsData');
        final locale = D4.getRequiredNamedArg<Locale?>(named, 'locale', 'SemanticsData');
        final minValue = D4.getRequiredNamedArg<String?>(named, 'minValue', 'SemanticsData');
        final maxValue = D4.getRequiredNamedArg<String?>(named, 'maxValue', 'SemanticsData');
        final tags = D4.getOptionalNamedArg<Set<$flutter_6.SemanticsTag>?>(named, 'tags');
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
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsData>(target, 'SemanticsData');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
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
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
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
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
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
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
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
    nativeType: $flutter_6.SemanticsProperties,
    name: 'SemanticsProperties',
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
        final controlsNodes = D4.getOptionalNamedArg<Set<String>?>(named, 'controlsNodes');
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
        final customSemanticsActions = D4.coerceMapOrNull<$flutter_6.CustomSemanticsAction, void Function()>(named['customSemanticsActions'], 'customSemanticsActions');
        final minValue = D4.getOptionalNamedArg<String?>(named, 'minValue');
        final maxValue = D4.getOptionalNamedArg<String?>(named, 'maxValue');
        return $flutter_6.SemanticsProperties(enabled: enabled, checked: checked, mixed: mixed, expanded: expanded, selected: selected, toggled: toggled, button: button, link: link, linkUrl: linkUrl, header: header, headingLevel: headingLevel, textField: textField, slider: slider, keyboardKey: keyboardKey, readOnly: readOnly, focusable: focusable, focused: focused, accessibilityFocusBlockType: accessibilityFocusBlockType, inMutuallyExclusiveGroup: inMutuallyExclusiveGroup, hidden: hidden, obscured: obscured, multiline: multiline, scopesRoute: scopesRoute, namesRoute: namesRoute, image: image, liveRegion: liveRegion, isRequired: isRequired, maxValueLength: maxValueLength, currentValueLength: currentValueLength, identifier: identifier, traversalParentIdentifier: traversalParentIdentifier, traversalChildIdentifier: traversalChildIdentifier, label: label, attributedLabel: attributedLabel, value: value, attributedValue: attributedValue, increasedValue: increasedValue, attributedIncreasedValue: attributedIncreasedValue, decreasedValue: decreasedValue, attributedDecreasedValue: attributedDecreasedValue, hint: hint, tooltip: tooltip, attributedHint: attributedHint, hintOverrides: hintOverrides, textDirection: textDirection, sortKey: sortKey, tagForChildren: tagForChildren, role: role, controlsNodes: controlsNodes, inputType: inputType, validationResult: validationResult, hitTestBehavior: hitTestBehavior, onTap: onTapRaw == null ? null : () { D4.callInterpreterCallback(visitor, onTapRaw, []); }, onLongPress: onLongPressRaw == null ? null : () { D4.callInterpreterCallback(visitor, onLongPressRaw, []); }, onScrollLeft: onScrollLeftRaw == null ? null : () { D4.callInterpreterCallback(visitor, onScrollLeftRaw, []); }, onScrollRight: onScrollRightRaw == null ? null : () { D4.callInterpreterCallback(visitor, onScrollRightRaw, []); }, onScrollUp: onScrollUpRaw == null ? null : () { D4.callInterpreterCallback(visitor, onScrollUpRaw, []); }, onScrollDown: onScrollDownRaw == null ? null : () { D4.callInterpreterCallback(visitor, onScrollDownRaw, []); }, onIncrease: onIncreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor, onIncreaseRaw, []); }, onDecrease: onDecreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor, onDecreaseRaw, []); }, onCopy: onCopyRaw == null ? null : () { D4.callInterpreterCallback(visitor, onCopyRaw, []); }, onCut: onCutRaw == null ? null : () { D4.callInterpreterCallback(visitor, onCutRaw, []); }, onPaste: onPasteRaw == null ? null : () { D4.callInterpreterCallback(visitor, onPasteRaw, []); }, onMoveCursorForwardByCharacter: onMoveCursorForwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor, onMoveCursorForwardByCharacterRaw, [p0]); }, onMoveCursorBackwardByCharacter: onMoveCursorBackwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor, onMoveCursorBackwardByCharacterRaw, [p0]); }, onMoveCursorForwardByWord: onMoveCursorForwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor, onMoveCursorForwardByWordRaw, [p0]); }, onMoveCursorBackwardByWord: onMoveCursorBackwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor, onMoveCursorBackwardByWordRaw, [p0]); }, onSetSelection: onSetSelectionRaw == null ? null : ($flutter_9.TextSelection p0) { D4.callInterpreterCallback(visitor, onSetSelectionRaw, [p0]); }, onSetText: onSetTextRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor, onSetTextRaw, [p0]); }, onDidGainAccessibilityFocus: onDidGainAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onDidGainAccessibilityFocusRaw, []); }, onDidLoseAccessibilityFocus: onDidLoseAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onDidLoseAccessibilityFocusRaw, []); }, onFocus: onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onFocusRaw, []); }, onDismiss: onDismissRaw == null ? null : () { D4.callInterpreterCallback(visitor, onDismissRaw, []); }, onExpand: onExpandRaw == null ? null : () { D4.callInterpreterCallback(visitor, onExpandRaw, []); }, onCollapse: onCollapseRaw == null ? null : () { D4.callInterpreterCallback(visitor, onCollapseRaw, []); }, customSemanticsActions: customSemanticsActions, minValue: minValue, maxValue: maxValue);
      },
    },
    getters: {
      'enabled': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').enabled,
      'checked': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').checked,
      'mixed': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').mixed,
      'expanded': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').expanded,
      'toggled': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').toggled,
      'selected': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').selected,
      'button': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').button,
      'link': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').link,
      'header': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').header,
      'textField': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').textField,
      'slider': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').slider,
      'keyboardKey': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').keyboardKey,
      'readOnly': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').readOnly,
      'focusable': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').focusable,
      'focused': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').focused,
      'accessibilityFocusBlockType': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').accessibilityFocusBlockType,
      'inMutuallyExclusiveGroup': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').inMutuallyExclusiveGroup,
      'hidden': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').hidden,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').obscured,
      'multiline': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').multiline,
      'scopesRoute': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').scopesRoute,
      'namesRoute': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').namesRoute,
      'image': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').image,
      'liveRegion': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').liveRegion,
      'isRequired': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').isRequired,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').currentValueLength,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').traversalChildIdentifier,
      'label': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').value,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').tooltip,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').headingLevel,
      'hintOverrides': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').hintOverrides,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').textDirection,
      'sortKey': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').sortKey,
      'tagForChildren': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').tagForChildren,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').linkUrl,
      'onTap': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onTap,
      'onLongPress': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onLongPress,
      'onScrollLeft': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onScrollLeft,
      'onScrollRight': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onScrollRight,
      'onScrollUp': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onScrollUp,
      'onScrollDown': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onScrollDown,
      'onIncrease': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onIncrease,
      'onDecrease': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onDecrease,
      'onCopy': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onCopy,
      'onCut': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onCut,
      'onPaste': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onPaste,
      'onMoveCursorForwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorForwardByCharacter,
      'onMoveCursorBackwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorBackwardByCharacter,
      'onMoveCursorForwardByWord': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorForwardByWord,
      'onMoveCursorBackwardByWord': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorBackwardByWord,
      'onSetSelection': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onSetSelection,
      'onSetText': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onSetText,
      'onDidGainAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onDidGainAccessibilityFocus,
      'onDidLoseAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onDidLoseAccessibilityFocus,
      'onFocus': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onFocus,
      'onDismiss': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onDismiss,
      'onExpand': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onExpand,
      'onCollapse': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').onCollapse,
      'customSemanticsActions': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').customSemanticsActions,
      'role': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').role,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').controlsNodes,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').inputType,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').maxValue,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties').minValue,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties');
        return t.toStringShort();
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsProperties>(target, 'SemanticsProperties');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
    },
    constructorSignatures: {
      '': 'const SemanticsProperties({bool? enabled, bool? checked, bool? mixed, bool? expanded, bool? selected, bool? toggled, bool? button, bool? link, Uri? linkUrl, bool? header, int? headingLevel, bool? textField, bool? slider, bool? keyboardKey, bool? readOnly, bool? focusable, bool? focused, AccessibilityFocusBlockType? accessibilityFocusBlockType, bool? inMutuallyExclusiveGroup, bool? hidden, bool? obscured, bool? multiline, bool? scopesRoute, bool? namesRoute, bool? image, bool? liveRegion, bool? isRequired, int? maxValueLength, int? currentValueLength, String? identifier, Object? traversalParentIdentifier, Object? traversalChildIdentifier, String? label, AttributedString? attributedLabel, String? value, AttributedString? attributedValue, String? increasedValue, AttributedString? attributedIncreasedValue, String? decreasedValue, AttributedString? attributedDecreasedValue, String? hint, String? tooltip, AttributedString? attributedHint, SemanticsHintOverrides? hintOverrides, TextDirection? textDirection, SemanticsSortKey? sortKey, SemanticsTag? tagForChildren, SemanticsRole? role, Set<String>? controlsNodes, SemanticsInputType? inputType, SemanticsValidationResult validationResult = SemanticsValidationResult.none, SemanticsHitTestBehavior? hitTestBehavior, void Function()? onTap, void Function()? onLongPress, void Function()? onScrollLeft, void Function()? onScrollRight, void Function()? onScrollUp, void Function()? onScrollDown, void Function()? onIncrease, void Function()? onDecrease, void Function()? onCopy, void Function()? onCut, void Function()? onPaste, void Function(bool)? onMoveCursorForwardByCharacter, void Function(bool)? onMoveCursorBackwardByCharacter, void Function(bool)? onMoveCursorForwardByWord, void Function(bool)? onMoveCursorBackwardByWord, void Function(TextSelection)? onSetSelection, void Function(String)? onSetText, void Function()? onDidGainAccessibilityFocus, void Function()? onDidLoseAccessibilityFocus, void Function()? onFocus, void Function()? onDismiss, void Function()? onExpand, void Function()? onCollapse, Map<CustomSemanticsAction, void Function()>? customSemanticsActions, String? minValue, String? maxValue})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
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
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getOptionalNamedArg<$flutter_3.Key?>(named, 'key');
        final showOnScreenRaw = named['showOnScreen'];
        return $flutter_6.SemanticsNode(key: key, showOnScreen: showOnScreenRaw == null ? null : () { D4.callInterpreterCallback(visitor, showOnScreenRaw, []); });
      },
      'root': (visitor, positional, named) {
        final key = D4.getOptionalNamedArg<$flutter_3.Key?>(named, 'key');
        final showOnScreenRaw = named['showOnScreen'];
        final owner = D4.getRequiredNamedArg<$flutter_6.SemanticsOwner>(named, 'owner', 'SemanticsNode');
        return $flutter_6.SemanticsNode.root(key: key, showOnScreen: showOnScreenRaw == null ? null : () { D4.callInterpreterCallback(visitor, showOnScreenRaw, []); }, owner: owner);
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
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').transform = value as dynamic,
      'rect': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').rect = value as dynamic,
      'parentSemanticsClipRect': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').parentSemanticsClipRect = value as Rect?,
      'parentPaintClipRect': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').parentPaintClipRect = value as Rect?,
      'indexInParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').indexInParent = value as int?,
      'isMergedIntoParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').isMergedIntoParent = value as dynamic,
      'areUserActionsBlocked': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').areUserActionsBlocked = value as dynamic,
      'traversalParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode').traversalParent = value as dynamic,
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
        t.visitChildren(($flutter_6.SemanticsNode p0) { return D4.callInterpreterCallback(visitor, visitor_Raw, [p0]) as bool; });
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
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
        final childOrder = D4.getNamedArgWithDefault<$flutter_6.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_6.DebugSemanticsDumpOrder.traversalOrder);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, childOrder: childOrder, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getNamedArgWithDefault<$flutter_2.DiagnosticsTreeStyle?>(named, 'style', $flutter_2.DiagnosticsTreeStyle.sparse);
        final childOrder = D4.getNamedArgWithDefault<$flutter_6.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_6.DebugSemanticsDumpOrder.traversalOrder);
        return t.toDiagnosticsNode(name: name, style: style, childOrder: childOrder);
      },
      'debugListChildrenInOrder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'debugListChildrenInOrder');
        final childOrder = D4.getRequiredArg<$flutter_6.DebugSemanticsDumpOrder>(positional, 0, 'childOrder', 'debugListChildrenInOrder');
        return t.debugListChildrenInOrder(childOrder);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        final childOrder = D4.getNamedArgWithDefault<$flutter_6.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_6.DebugSemanticsDumpOrder.traversalOrder);
        return t.debugDescribeChildren(childOrder: childOrder);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_2.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
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
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, DebugSemanticsDumpOrder childOrder = DebugSemanticsDumpOrder.traversalOrder, int wrapWidth = 65})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style = DiagnosticsTreeStyle.sparse, DebugSemanticsDumpOrder childOrder = DebugSemanticsDumpOrder.traversalOrder})',
      'debugListChildrenInOrder': 'List<SemanticsNode> debugListChildrenInOrder(DebugSemanticsDumpOrder childOrder)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren({DebugSemanticsDumpOrder childOrder = DebugSemanticsDumpOrder.traversalOrder})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('onSemanticsUpdate') || named['onSemanticsUpdate'] == null) {
          throw ArgumentError('SemanticsOwner: Missing required named argument "onSemanticsUpdate"');
        }
        final onSemanticsUpdateRaw = named['onSemanticsUpdate'];
        return $flutter_6.SemanticsOwner(onSemanticsUpdate: (SemanticsUpdate p0) { D4.callInterpreterCallback(visitor, onSemanticsUpdateRaw, [p0]); });
      },
    },
    getters: {
      'onSemanticsUpdate': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner').onSemanticsUpdate,
      'rootSemanticsNode': (visitor, target) => D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner').rootSemanticsNode,
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
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
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
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSemanticBoundary = value as dynamic,
      'localeForSubtree': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').localeForSubtree = value as dynamic,
      'locale': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').locale = value as Locale?,
      'isBlockingUserActions': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingUserActions = value as bool,
      'explicitChildNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').explicitChildNodes = value as bool,
      'isBlockingSemanticsOfPreviouslyPaintedNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingSemanticsOfPreviouslyPaintedNodes = value as bool,
      'onTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onTap = value as dynamic,
      'onLongPress': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onLongPress = value as dynamic,
      'onScrollLeft': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollLeft = value as dynamic,
      'onDismiss': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDismiss = value as dynamic,
      'onScrollRight': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollRight = value as dynamic,
      'onScrollUp': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollUp = value as dynamic,
      'onScrollDown': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollDown = value as dynamic,
      'onScrollToOffset': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollToOffset = value as dynamic,
      'onIncrease': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onIncrease = value as dynamic,
      'onDecrease': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDecrease = value as dynamic,
      'onCopy': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCopy = value as dynamic,
      'onCut': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCut = value as dynamic,
      'onPaste': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onPaste = value as dynamic,
      'onShowOnScreen': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onShowOnScreen = value as dynamic,
      'onMoveCursorForwardByCharacter': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByCharacter = value as dynamic,
      'onMoveCursorBackwardByCharacter': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByCharacter = value as dynamic,
      'onMoveCursorForwardByWord': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByWord = value as dynamic,
      'onMoveCursorBackwardByWord': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByWord = value as dynamic,
      'onSetSelection': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetSelection = value as dynamic,
      'onSetText': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetText = value as dynamic,
      'onDidGainAccessibilityFocus': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidGainAccessibilityFocus = value as dynamic,
      'onDidLoseAccessibilityFocus': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidLoseAccessibilityFocus = value as dynamic,
      'onFocus': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onFocus = value as dynamic,
      'onExpand': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onExpand = value as dynamic,
      'onCollapse': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCollapse = value as dynamic,
      'childConfigurationsDelegate': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').childConfigurationsDelegate = value as dynamic,
      'sortKey': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').sortKey = value as dynamic,
      'indexInParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').indexInParent = value as dynamic,
      'scrollChildCount': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollChildCount = value as dynamic,
      'scrollIndex': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollIndex = value as dynamic,
      'platformViewId': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').platformViewId = value as dynamic,
      'maxValueLength': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValueLength = value as dynamic,
      'currentValueLength': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').currentValueLength = value as dynamic,
      'isMergingSemanticsOfDescendants': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMergingSemanticsOfDescendants = value as dynamic,
      'customSemanticsActions': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').customSemanticsActions = value as dynamic,
      'identifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').identifier = value as dynamic,
      'traversalParentIdentifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalParentIdentifier = value as dynamic,
      'traversalChildIdentifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalChildIdentifier = value as dynamic,
      'role': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').role = value as dynamic,
      'label': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').label = value as dynamic,
      'attributedLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedLabel = value as dynamic,
      'value': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').value = value as dynamic,
      'attributedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedValue = value as dynamic,
      'increasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').increasedValue = value as dynamic,
      'attributedIncreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedIncreasedValue = value as dynamic,
      'decreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').decreasedValue = value as dynamic,
      'attributedDecreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedDecreasedValue = value as dynamic,
      'hint': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hint = value as dynamic,
      'attributedHint': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedHint = value as dynamic,
      'tooltip': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').tooltip = value as dynamic,
      'hintOverrides': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hintOverrides = value as dynamic,
      'scopesRoute': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scopesRoute = value as dynamic,
      'namesRoute': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').namesRoute = value as dynamic,
      'isImage': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isImage = value as dynamic,
      'liveRegion': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').liveRegion = value as dynamic,
      'textDirection': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').textDirection = value as dynamic,
      'isSelected': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSelected = value as dynamic,
      'isExpanded': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isExpanded = value as dynamic,
      'isEnabled': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isEnabled = value as dynamic,
      'isChecked': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isChecked = value as dynamic,
      'isCheckStateMixed': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isCheckStateMixed = value as dynamic,
      'isToggled': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isToggled = value as dynamic,
      'isInMutuallyExclusiveGroup': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isInMutuallyExclusiveGroup = value as dynamic,
      'isFocusable': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocusable = value as dynamic,
      'isFocused': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocused = value as dynamic,
      'accessibilityFocusBlockType': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').accessibilityFocusBlockType = value as dynamic,
      'isButton': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isButton = value as dynamic,
      'isLink': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isLink = value as dynamic,
      'linkUrl': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').linkUrl = value as dynamic,
      'isHeader': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHeader = value as dynamic,
      'headingLevel': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').headingLevel = value as dynamic,
      'isSlider': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSlider = value as dynamic,
      'isKeyboardKey': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isKeyboardKey = value as dynamic,
      'isHidden': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHidden = value as dynamic,
      'isTextField': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isTextField = value as dynamic,
      'isReadOnly': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isReadOnly = value as dynamic,
      'isObscured': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isObscured = value as dynamic,
      'isMultiline': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMultiline = value as dynamic,
      'isRequired': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').isRequired = value as dynamic,
      'hasImplicitScrolling': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hasImplicitScrolling = value as dynamic,
      'textSelection': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').textSelection = value as dynamic,
      'scrollPosition': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollPosition = value as dynamic,
      'scrollExtentMax': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMax = value as dynamic,
      'scrollExtentMin': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMin = value as dynamic,
      'controlsNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').controlsNodes = value as dynamic,
      'validationResult': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').validationResult = value as dynamic,
      'hitTestBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').hitTestBehavior = value as dynamic,
      'inputType': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').inputType = value as dynamic,
      'maxValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValue = value as dynamic,
      'minValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.SemanticsConfiguration>(target, 'SemanticsConfiguration').minValue = value as dynamic,
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
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SemanticsSortKey>(target, 'SemanticsSortKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    methodSignatures: {
      'compareTo': 'int compareTo(SemanticsSortKey other)',
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
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.OrdinalSortKey>(target, 'OrdinalSortKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_2.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    constructorSignatures: {
      '': 'const OrdinalSortKey(double order, {String? name})',
    },
    methodSignatures: {
      'compareTo': 'int compareTo(SemanticsSortKey other)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_8.SemanticsService,
    name: 'SemanticsService',
    constructors: {
    },
    staticMethods: {
      'announce': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'announce');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'announce');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'announce');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_7.Assertiveness>(named, 'assertiveness', $flutter_7.Assertiveness.polite);
        return $flutter_8.SemanticsService.announce(message, textDirection, assertiveness: assertiveness);
      },
      'sendAnnouncement': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'sendAnnouncement');
        final view = D4.getRequiredArg<FlutterView>(positional, 0, 'view', 'sendAnnouncement');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'sendAnnouncement');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 2, 'textDirection', 'sendAnnouncement');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_7.Assertiveness>(named, 'assertiveness', $flutter_7.Assertiveness.polite);
        return $flutter_8.SemanticsService.sendAnnouncement(view, message, textDirection, assertiveness: assertiveness);
      },
      'tooltip': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'tooltip');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'tooltip');
        return $flutter_8.SemanticsService.tooltip(message);
      },
    },
    staticMethodSignatures: {
      'announce': 'Future<void> announce(String message, TextDirection textDirection, {Assertiveness assertiveness = Assertiveness.polite})',
      'sendAnnouncement': 'Future<void> sendAnnouncement(FlutterView view, String message, TextDirection textDirection, {Assertiveness assertiveness = Assertiveness.polite})',
      'tooltip': 'Future<void> tooltip(String message)',
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

