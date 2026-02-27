// D4rt Bridge - Generated file, do not edit
// Sources: 51 files
// Generated: 2026-02-27T12:13:15.245060

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as $dart_math;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/src/foundation/assertions.dart' as $flutter_1;
import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_2;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_3;
import 'package:flutter/src/foundation/platform.dart' as $flutter_4;
import 'package:flutter/src/gestures/events.dart' as $flutter_5;
import 'package:flutter/src/gestures/hit_test.dart' as $flutter_6;
import 'package:flutter/src/gestures/recognizer.dart' as $flutter_7;
import 'package:flutter/src/painting/alignment.dart' as $flutter_8;
import 'package:flutter/src/painting/basic_types.dart' as $flutter_9;
import 'package:flutter/src/painting/beveled_rectangle_border.dart' as $flutter_10;
import 'package:flutter/src/painting/binding.dart' as $flutter_11;
import 'package:flutter/src/painting/border_radius.dart' as $flutter_12;
import 'package:flutter/src/painting/borders.dart' as $flutter_13;
import 'package:flutter/src/painting/box_border.dart' as $flutter_14;
import 'package:flutter/src/painting/box_decoration.dart' as $flutter_15;
import 'package:flutter/src/painting/box_fit.dart' as $flutter_16;
import 'package:flutter/src/painting/box_shadow.dart' as $flutter_17;
import 'package:flutter/src/painting/circle_border.dart' as $flutter_18;
import 'package:flutter/src/painting/clip.dart' as $flutter_19;
import 'package:flutter/src/painting/colors.dart' as $flutter_20;
import 'package:flutter/src/painting/continuous_rectangle_border.dart' as $flutter_21;
import 'package:flutter/src/painting/debug.dart' as $flutter_22;
import 'package:flutter/src/painting/decoration.dart' as $flutter_23;
import 'package:flutter/src/painting/decoration_image.dart' as $flutter_24;
import 'package:flutter/src/painting/edge_insets.dart' as $flutter_25;
import 'package:flutter/src/painting/flutter_logo.dart' as $flutter_26;
import 'package:flutter/src/painting/fractional_offset.dart' as $flutter_27;
import 'package:flutter/src/painting/geometry.dart' as $flutter_28;
import 'package:flutter/src/painting/gradient.dart' as $flutter_29;
import 'package:flutter/src/painting/image_cache.dart' as $flutter_30;
import 'package:flutter/src/painting/image_decoder.dart' as $flutter_31;
import 'package:flutter/src/painting/image_provider.dart' as $flutter_32;
import 'package:flutter/src/painting/image_resolution.dart' as $flutter_33;
import 'package:flutter/src/painting/image_stream.dart' as $flutter_34;
import 'package:flutter/src/painting/inline_span.dart' as $flutter_35;
import 'package:flutter/src/painting/linear_border.dart' as $flutter_36;
import 'package:flutter/src/painting/matrix_utils.dart' as $flutter_37;
import 'package:flutter/src/painting/notched_shapes.dart' as $flutter_38;
import 'package:flutter/src/painting/oval_border.dart' as $flutter_39;
import 'package:flutter/src/painting/paint_utilities.dart' as $flutter_40;
import 'package:flutter/src/painting/placeholder_span.dart' as $flutter_41;
import 'package:flutter/src/painting/rounded_rectangle_border.dart' as $flutter_42;
import 'package:flutter/src/painting/shader_warm_up.dart' as $flutter_43;
import 'package:flutter/src/painting/shape_decoration.dart' as $flutter_44;
import 'package:flutter/src/painting/stadium_border.dart' as $flutter_45;
import 'package:flutter/src/painting/star_border.dart' as $flutter_46;
import 'package:flutter/src/painting/strut_style.dart' as $flutter_47;
import 'package:flutter/src/painting/text_painter.dart' as $flutter_48;
import 'package:flutter/src/painting/text_scaler.dart' as $flutter_49;
import 'package:flutter/src/painting/text_span.dart' as $flutter_50;
import 'package:flutter/src/painting/text_style.dart' as $flutter_51;
import 'package:flutter/src/scheduler/binding.dart' as $flutter_52;
import 'package:flutter/src/scheduler/priority.dart' as $flutter_53;
import 'package:flutter/src/services/asset_bundle.dart' as $flutter_54;
import 'package:flutter/src/services/binary_messenger.dart' as $flutter_55;
import 'package:flutter/src/services/binding.dart' as $flutter_56;
import 'package:flutter/src/services/hardware_keyboard.dart' as $flutter_57;
import 'package:flutter/src/services/mouse_cursor.dart' as $flutter_58;
import 'package:flutter/src/services/mouse_tracking.dart' as $flutter_59;
import 'package:flutter/src/services/restoration.dart' as $flutter_60;
import 'package:flutter/src/services/text_boundary.dart' as $flutter_61;
import 'package:flutter/src/services/text_editing.dart' as $flutter_62;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;
import 'package:flutter/src/foundation/binding.dart' as $aux_flutter;

/// Bridge class for flutter_painting module.
class FlutterPaintingBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createAlignmentGeometryBridge(),
      _createAlignmentBridge(),
      _createAlignmentDirectionalBridge(),
      _createTextAlignVerticalBridge(),
      _createBeveledRectangleBorderBridge(),
      _createPaintingBindingBridge(),
      _createBorderRadiusGeometryBridge(),
      _createBorderRadiusBridge(),
      _createBorderRadiusDirectionalBridge(),
      _createBorderSideBridge(),
      _createShapeBorderBridge(),
      _createOutlinedBorderBridge(),
      _createBoxBorderBridge(),
      _createBorderBridge(),
      _createBorderDirectionalBridge(),
      _createBoxDecorationBridge(),
      _createFittedSizesBridge(),
      _createBoxShadowBridge(),
      _createCircleBorderBridge(),
      _createClipContextBridge(),
      _createHSVColorBridge(),
      _createHSLColorBridge(),
      _createColorSwatchBridge(),
      _createColorPropertyBridge(),
      _createContinuousRectangleBorderBridge(),
      _createImageSizeInfoBridge(),
      _createDecorationBridge(),
      _createBoxPainterBridge(),
      _createDecorationImageBridge(),
      _createDecorationImagePainterBridge(),
      _createEdgeInsetsGeometryBridge(),
      _createEdgeInsetsBridge(),
      _createEdgeInsetsDirectionalBridge(),
      _createFlutterLogoDecorationBridge(),
      _createFractionalOffsetBridge(),
      _createGradientTransformBridge(),
      _createGradientRotationBridge(),
      _createGradientBridge(),
      _createLinearGradientBridge(),
      _createRadialGradientBridge(),
      _createSweepGradientBridge(),
      _createImageCacheBridge(),
      _createImageCacheStatusBridge(),
      _createImageConfigurationBridge(),
      _createImageProviderBridge(),
      _createAssetBundleImageKeyBridge(),
      _createAssetBundleImageProviderBridge(),
      _createResizeImageKeyBridge(),
      _createResizeImageBridge(),
      _createNetworkImageBridge(),
      _createFileImageBridge(),
      _createMemoryImageBridge(),
      _createExactAssetImageBridge(),
      _createNetworkImageLoadExceptionBridge(),
      _createAssetImageBridge(),
      _createImageInfoBridge(),
      _createImageStreamListenerBridge(),
      _createImageChunkEventBridge(),
      _createImageStreamBridge(),
      _createImageStreamCompleterHandleBridge(),
      _createImageStreamCompleterBridge(),
      _createOneFrameImageStreamCompleterBridge(),
      _createMultiFrameImageStreamCompleterBridge(),
      _createAccumulatorBridge(),
      _createInlineSpanSemanticsInformationBridge(),
      _createInlineSpanBridge(),
      _createLinearBorderEdgeBridge(),
      _createLinearBorderBridge(),
      _createMatrixUtilsBridge(),
      _createTransformPropertyBridge(),
      _createNotchedShapeBridge(),
      _createCircularNotchedRectangleBridge(),
      _createAutomaticNotchedShapeBridge(),
      _createOvalBorderBridge(),
      _createPlaceholderSpanBridge(),
      _createRoundedRectangleBorderBridge(),
      _createRoundedSuperellipseBorderBridge(),
      _createShaderWarmUpBridge(),
      _createShapeDecorationBridge(),
      _createStadiumBorderBridge(),
      _createStarBorderBridge(),
      _createStrutStyleBridge(),
      _createTextSelectionBridge(),
      _createPlaceholderDimensionsBridge(),
      _createWordBoundaryBridge(),
      _createTextPainterBridge(),
      _createTextScalerBridge(),
      _createTextSpanBridge(),
      _createTextStyleBridge(),
      _createMatrix4Bridge(),
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
      'AlignmentGeometry': 'package:flutter/src/painting/alignment.dart',
      'Alignment': 'package:flutter/src/painting/alignment.dart',
      'AlignmentDirectional': 'package:flutter/src/painting/alignment.dart',
      'TextAlignVertical': 'package:flutter/src/painting/alignment.dart',
      'BeveledRectangleBorder': 'package:flutter/src/painting/beveled_rectangle_border.dart',
      'PaintingBinding': 'package:flutter/src/painting/binding.dart',
      'BorderRadiusGeometry': 'package:flutter/src/painting/border_radius.dart',
      'BorderRadius': 'package:flutter/src/painting/border_radius.dart',
      'BorderRadiusDirectional': 'package:flutter/src/painting/border_radius.dart',
      'BorderSide': 'package:flutter/src/painting/borders.dart',
      'ShapeBorder': 'package:flutter/src/painting/borders.dart',
      'OutlinedBorder': 'package:flutter/src/painting/borders.dart',
      'BoxBorder': 'package:flutter/src/painting/box_border.dart',
      'Border': 'package:flutter/src/painting/box_border.dart',
      'BorderDirectional': 'package:flutter/src/painting/box_border.dart',
      'BoxDecoration': 'package:flutter/src/painting/box_decoration.dart',
      'FittedSizes': 'package:flutter/src/painting/box_fit.dart',
      'BoxShadow': 'package:flutter/src/painting/box_shadow.dart',
      'CircleBorder': 'package:flutter/src/painting/circle_border.dart',
      'ClipContext': 'package:flutter/src/painting/clip.dart',
      'HSVColor': 'package:flutter/src/painting/colors.dart',
      'HSLColor': 'package:flutter/src/painting/colors.dart',
      'ColorSwatch': 'package:flutter/src/painting/colors.dart',
      'ColorProperty': 'package:flutter/src/painting/colors.dart',
      'ContinuousRectangleBorder': 'package:flutter/src/painting/continuous_rectangle_border.dart',
      'ImageSizeInfo': 'package:flutter/src/painting/debug.dart',
      'Decoration': 'package:flutter/src/painting/decoration.dart',
      'BoxPainter': 'package:flutter/src/painting/decoration.dart',
      'DecorationImage': 'package:flutter/src/painting/decoration_image.dart',
      'DecorationImagePainter': 'package:flutter/src/painting/decoration_image.dart',
      'EdgeInsetsGeometry': 'package:flutter/src/painting/edge_insets.dart',
      'EdgeInsets': 'package:flutter/src/painting/edge_insets.dart',
      'EdgeInsetsDirectional': 'package:flutter/src/painting/edge_insets.dart',
      'FlutterLogoDecoration': 'package:flutter/src/painting/flutter_logo.dart',
      'FractionalOffset': 'package:flutter/src/painting/fractional_offset.dart',
      'GradientTransform': 'package:flutter/src/painting/gradient.dart',
      'GradientRotation': 'package:flutter/src/painting/gradient.dart',
      'Gradient': 'package:flutter/src/painting/gradient.dart',
      'LinearGradient': 'package:flutter/src/painting/gradient.dart',
      'RadialGradient': 'package:flutter/src/painting/gradient.dart',
      'SweepGradient': 'package:flutter/src/painting/gradient.dart',
      'ImageCache': 'package:flutter/src/painting/image_cache.dart',
      'ImageCacheStatus': 'package:flutter/src/painting/image_cache.dart',
      'ImageConfiguration': 'package:flutter/src/painting/image_provider.dart',
      'ImageProvider': 'package:flutter/src/painting/image_provider.dart',
      'AssetBundleImageKey': 'package:flutter/src/painting/image_provider.dart',
      'AssetBundleImageProvider': 'package:flutter/src/painting/image_provider.dart',
      'ResizeImageKey': 'package:flutter/src/painting/image_provider.dart',
      'ResizeImage': 'package:flutter/src/painting/image_provider.dart',
      'NetworkImage': 'package:flutter/src/painting/image_provider.dart',
      'FileImage': 'package:flutter/src/painting/image_provider.dart',
      'MemoryImage': 'package:flutter/src/painting/image_provider.dart',
      'ExactAssetImage': 'package:flutter/src/painting/image_provider.dart',
      'NetworkImageLoadException': 'package:flutter/src/painting/image_provider.dart',
      'AssetImage': 'package:flutter/src/painting/image_resolution.dart',
      'ImageInfo': 'package:flutter/src/painting/image_stream.dart',
      'ImageStreamListener': 'package:flutter/src/painting/image_stream.dart',
      'ImageChunkEvent': 'package:flutter/src/painting/image_stream.dart',
      'ImageStream': 'package:flutter/src/painting/image_stream.dart',
      'ImageStreamCompleterHandle': 'package:flutter/src/painting/image_stream.dart',
      'ImageStreamCompleter': 'package:flutter/src/painting/image_stream.dart',
      'OneFrameImageStreamCompleter': 'package:flutter/src/painting/image_stream.dart',
      'MultiFrameImageStreamCompleter': 'package:flutter/src/painting/image_stream.dart',
      'Accumulator': 'package:flutter/src/painting/inline_span.dart',
      'InlineSpanSemanticsInformation': 'package:flutter/src/painting/inline_span.dart',
      'InlineSpan': 'package:flutter/src/painting/inline_span.dart',
      'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart',
      'LinearBorder': 'package:flutter/src/painting/linear_border.dart',
      'MatrixUtils': 'package:flutter/src/painting/matrix_utils.dart',
      'TransformProperty': 'package:flutter/src/painting/matrix_utils.dart',
      'NotchedShape': 'package:flutter/src/painting/notched_shapes.dart',
      'CircularNotchedRectangle': 'package:flutter/src/painting/notched_shapes.dart',
      'AutomaticNotchedShape': 'package:flutter/src/painting/notched_shapes.dart',
      'OvalBorder': 'package:flutter/src/painting/oval_border.dart',
      'PlaceholderSpan': 'package:flutter/src/painting/placeholder_span.dart',
      'RoundedRectangleBorder': 'package:flutter/src/painting/rounded_rectangle_border.dart',
      'RoundedSuperellipseBorder': 'package:flutter/src/painting/rounded_rectangle_border.dart',
      'ShaderWarmUp': 'package:flutter/src/painting/shader_warm_up.dart',
      'ShapeDecoration': 'package:flutter/src/painting/shape_decoration.dart',
      'StadiumBorder': 'package:flutter/src/painting/stadium_border.dart',
      'StarBorder': 'package:flutter/src/painting/star_border.dart',
      'StrutStyle': 'package:flutter/src/painting/strut_style.dart',
      'TextSelection': 'package:flutter/src/services/text_editing.dart',
      'PlaceholderDimensions': 'package:flutter/src/painting/text_painter.dart',
      'WordBoundary': 'package:flutter/src/painting/text_painter.dart',
      'TextPainter': 'package:flutter/src/painting/text_painter.dart',
      'TextScaler': 'package:flutter/src/painting/text_scaler.dart',
      'TextSpan': 'package:flutter/src/painting/text_span.dart',
      'TextStyle': 'package:flutter/src/painting/text_style.dart',
      'Matrix4': 'package:vector_math/vector_math_64.dart',
      'Vector3': 'package:vector_math/vector_math_64.dart',
      'Vector2': 'package:vector_math/vector_math_64.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_9.RenderComparison>(
        name: 'RenderComparison',
        values: $flutter_9.RenderComparison.values,
      ),
      BridgedEnumDefinition<$flutter_9.Axis>(
        name: 'Axis',
        values: $flutter_9.Axis.values,
      ),
      BridgedEnumDefinition<$flutter_9.VerticalDirection>(
        name: 'VerticalDirection',
        values: $flutter_9.VerticalDirection.values,
      ),
      BridgedEnumDefinition<$flutter_9.AxisDirection>(
        name: 'AxisDirection',
        values: $flutter_9.AxisDirection.values,
      ),
      BridgedEnumDefinition<$flutter_13.BorderStyle>(
        name: 'BorderStyle',
        values: $flutter_13.BorderStyle.values,
      ),
      BridgedEnumDefinition<$flutter_14.BoxShape>(
        name: 'BoxShape',
        values: $flutter_14.BoxShape.values,
      ),
      BridgedEnumDefinition<$flutter_16.BoxFit>(
        name: 'BoxFit',
        values: $flutter_16.BoxFit.values,
      ),
      BridgedEnumDefinition<$flutter_24.ImageRepeat>(
        name: 'ImageRepeat',
        values: $flutter_24.ImageRepeat.values,
      ),
      BridgedEnumDefinition<$flutter_26.FlutterLogoStyle>(
        name: 'FlutterLogoStyle',
        values: $flutter_26.FlutterLogoStyle.values,
      ),
      BridgedEnumDefinition<$flutter_32.ResizeImagePolicy>(
        name: 'ResizeImagePolicy',
        values: $flutter_32.ResizeImagePolicy.values,
      ),
      BridgedEnumDefinition<$flutter_32.WebHtmlElementStrategy>(
        name: 'WebHtmlElementStrategy',
        values: $flutter_32.WebHtmlElementStrategy.values,
      ),
      BridgedEnumDefinition<$flutter_48.TextOverflow>(
        name: 'TextOverflow',
        values: $flutter_48.TextOverflow.values,
      ),
      BridgedEnumDefinition<$flutter_48.TextWidthBasis>(
        name: 'TextWidthBasis',
        values: $flutter_48.TextWidthBasis.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'RenderComparison': 'package:flutter/src/painting/basic_types.dart',
      'Axis': 'package:flutter/src/painting/basic_types.dart',
      'VerticalDirection': 'package:flutter/src/painting/basic_types.dart',
      'AxisDirection': 'package:flutter/src/painting/basic_types.dart',
      'BorderStyle': 'package:flutter/src/painting/borders.dart',
      'BoxShape': 'package:flutter/src/painting/box_border.dart',
      'BoxFit': 'package:flutter/src/painting/box_fit.dart',
      'ImageRepeat': 'package:flutter/src/painting/decoration_image.dart',
      'FlutterLogoStyle': 'package:flutter/src/painting/flutter_logo.dart',
      'ResizeImagePolicy': 'package:flutter/src/painting/image_provider.dart',
      'WebHtmlElementStrategy': 'package:flutter/src/painting/image_provider.dart',
      'TextOverflow': 'package:flutter/src/painting/text_painter.dart',
      'TextWidthBasis': 'package:flutter/src/painting/text_painter.dart',
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
      interpreter.registerGlobalVariable('debugDisableShadows', $flutter_22.debugDisableShadows, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugDisableShadows": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugNetworkImageHttpClientProvider', $flutter_22.debugNetworkImageHttpClientProvider, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugNetworkImageHttpClientProvider": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugOnPaintImage', $flutter_22.debugOnPaintImage, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugOnPaintImage": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugInvertOversizedImages', $flutter_22.debugInvertOversizedImages, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugInvertOversizedImages": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugImageOverheadAllowance', $flutter_22.debugImageOverheadAllowance, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugImageOverheadAllowance": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugCaptureShaderWarmUpPicture', $flutter_22.debugCaptureShaderWarmUpPicture, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugCaptureShaderWarmUpPicture": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugCaptureShaderWarmUpImage', $flutter_22.debugCaptureShaderWarmUpImage, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugCaptureShaderWarmUpImage": $e');
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
    try {
      interpreter.registerGlobalVariable('kDefaultFontSize', $flutter_48.kDefaultFontSize, importPath, sourceUri: 'package:flutter/src/painting/text_painter.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDefaultFontSize": $e');
    }
    interpreter.registerGlobalGetter('imageCache', () => $flutter_11.imageCache, importPath, sourceUri: 'package:flutter/src/painting/binding.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_painting):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'flipAxis': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'flipAxis');
        final direction = D4.getRequiredArg<$flutter_9.Axis>(positional, 0, 'direction', 'flipAxis');
        return $flutter_9.flipAxis(direction);
      },
      'axisDirectionToAxis': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'axisDirectionToAxis');
        final axisDirection = D4.getRequiredArg<$flutter_9.AxisDirection>(positional, 0, 'axisDirection', 'axisDirectionToAxis');
        return $flutter_9.axisDirectionToAxis(axisDirection);
      },
      'textDirectionToAxisDirection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'textDirectionToAxisDirection');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'textDirection', 'textDirectionToAxisDirection');
        return $flutter_9.textDirectionToAxisDirection(textDirection);
      },
      'flipAxisDirection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'flipAxisDirection');
        final axisDirection = D4.getRequiredArg<$flutter_9.AxisDirection>(positional, 0, 'axisDirection', 'flipAxisDirection');
        return $flutter_9.flipAxisDirection(axisDirection);
      },
      'axisDirectionIsReversed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'axisDirectionIsReversed');
        final axisDirection = D4.getRequiredArg<$flutter_9.AxisDirection>(positional, 0, 'axisDirection', 'axisDirectionIsReversed');
        return $flutter_9.axisDirectionIsReversed(axisDirection);
      },
      'paintBorder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'paintBorder');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintBorder');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintBorder');
        final top = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'top', $flutter_13.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'right', $flutter_13.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'bottom', $flutter_13.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'left', $flutter_13.BorderSide.none);
        return $flutter_13.paintBorder(canvas, rect, top: top, right: right, bottom: bottom, left: left);
      },
      'applyBoxFit': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'applyBoxFit');
        final fit = D4.getRequiredArg<$flutter_16.BoxFit>(positional, 0, 'fit', 'applyBoxFit');
        final inputSize = D4.getRequiredArg<Size>(positional, 1, 'inputSize', 'applyBoxFit');
        final outputSize = D4.getRequiredArg<Size>(positional, 2, 'outputSize', 'applyBoxFit');
        return $flutter_16.applyBoxFit(fit, inputSize, outputSize);
      },
      'debugAssertAllPaintingVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllPaintingVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllPaintingVarsUnset');
        final debugDisableShadowsOverride = D4.getNamedArgWithDefault<bool>(named, 'debugDisableShadowsOverride', false);
        return $flutter_22.debugAssertAllPaintingVarsUnset(reason, debugDisableShadowsOverride: debugDisableShadowsOverride);
      },
      'debugCheckCanResolveTextDirection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'debugCheckCanResolveTextDirection');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'debugCheckCanResolveTextDirection');
        final target = D4.getRequiredArg<String>(positional, 1, 'target', 'debugCheckCanResolveTextDirection');
        return $flutter_22.debugCheckCanResolveTextDirection(direction, target);
      },
      'paintImage': (visitor, positional, named, typeArgs) {
        final canvas = D4.getRequiredNamedArg<Canvas>(named, 'canvas', 'paintImage');
        final rect = D4.getRequiredNamedArg<Rect>(named, 'rect', 'paintImage');
        final image = D4.getRequiredNamedArg<Image>(named, 'image', 'paintImage');
        final debugImageLabel = D4.getOptionalNamedArg<String?>(named, 'debugImageLabel');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final opacity = D4.getNamedArgWithDefault<double>(named, 'opacity', 1.0);
        final colorFilter = D4.getOptionalNamedArg<ColorFilter?>(named, 'colorFilter');
        final fit = D4.getOptionalNamedArg<$flutter_16.BoxFit?>(named, 'fit');
        final alignment = D4.getNamedArgWithDefault<$flutter_8.Alignment>(named, 'alignment', $flutter_8.Alignment.center);
        final centerSlice = D4.getOptionalNamedArg<Rect?>(named, 'centerSlice');
        final repeat = D4.getNamedArgWithDefault<$flutter_24.ImageRepeat>(named, 'repeat', $flutter_24.ImageRepeat.noRepeat);
        final flipHorizontally = D4.getNamedArgWithDefault<bool>(named, 'flipHorizontally', false);
        final invertColors = D4.getNamedArgWithDefault<bool>(named, 'invertColors', false);
        final filterQuality = D4.getNamedArgWithDefault<FilterQuality>(named, 'filterQuality', FilterQuality.medium);
        final isAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'isAntiAlias', false);
        final blendMode = D4.getNamedArgWithDefault<BlendMode>(named, 'blendMode', BlendMode.srcOver);
        return $flutter_24.paintImage(canvas: canvas, rect: rect, image: image, debugImageLabel: debugImageLabel, scale: scale, opacity: opacity, colorFilter: colorFilter, fit: fit, alignment: alignment, centerSlice: centerSlice, repeat: repeat, flipHorizontally: flipHorizontally, invertColors: invertColors, filterQuality: filterQuality, isAntiAlias: isAntiAlias, blendMode: blendMode);
      },
      'positionDependentBox': (visitor, positional, named, typeArgs) {
        final size = D4.getRequiredNamedArg<Size>(named, 'size', 'positionDependentBox');
        final childSize = D4.getRequiredNamedArg<Size>(named, 'childSize', 'positionDependentBox');
        final target = D4.getRequiredNamedArg<Offset>(named, 'target', 'positionDependentBox');
        final preferBelow = D4.getRequiredNamedArg<bool>(named, 'preferBelow', 'positionDependentBox');
        final verticalOffset = D4.getNamedArgWithDefault<double>(named, 'verticalOffset', 0.0);
        final margin = D4.getNamedArgWithDefault<double>(named, 'margin', 10.0);
        return $flutter_28.positionDependentBox(size: size, childSize: childSize, target: target, preferBelow: preferBelow, verticalOffset: verticalOffset, margin: margin);
      },
      'decodeImageFromList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'decodeImageFromList');
        final bytes = D4.getRequiredArg<Uint8List>(positional, 0, 'bytes', 'decodeImageFromList');
        return $flutter_31.decodeImageFromList(bytes);
      },
      'combineSemanticsInfo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'combineSemanticsInfo');
        final infoList = D4.getRequiredArg<List<$flutter_35.InlineSpanSemanticsInformation>>(positional, 0, 'infoList', 'combineSemanticsInfo');
        return $flutter_35.combineSemanticsInfo(infoList);
      },
      'debugDescribeTransform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugDescribeTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'debugDescribeTransform');
        return $flutter_37.debugDescribeTransform(transform);
      },
      'paintZigZag': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'paintZigZag');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintZigZag');
        final paint = D4.getRequiredArg<Paint>(positional, 1, 'paint', 'paintZigZag');
        final start = D4.getRequiredArg<Offset>(positional, 2, 'start', 'paintZigZag');
        final end = D4.getRequiredArg<Offset>(positional, 3, 'end', 'paintZigZag');
        final zigs = D4.getRequiredArg<int>(positional, 4, 'zigs', 'paintZigZag');
        final width = D4.getRequiredArg<double>(positional, 5, 'width', 'paintZigZag');
        return $flutter_40.paintZigZag(canvas, paint, start, end, zigs, width);
      },
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
      'lerpFontVariations': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpFontVariations');
        final a = D4.getRequiredArg<List<FontVariation>?>(positional, 0, 'a', 'lerpFontVariations');
        final b = D4.getRequiredArg<List<FontVariation>?>(positional, 1, 'b', 'lerpFontVariations');
        final t = D4.getRequiredArg<double>(positional, 2, 't', 'lerpFontVariations');
        return $flutter_51.lerpFontVariations(a, b, t);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'flipAxis': 'package:flutter/src/painting/basic_types.dart',
      'axisDirectionToAxis': 'package:flutter/src/painting/basic_types.dart',
      'textDirectionToAxisDirection': 'package:flutter/src/painting/basic_types.dart',
      'flipAxisDirection': 'package:flutter/src/painting/basic_types.dart',
      'axisDirectionIsReversed': 'package:flutter/src/painting/basic_types.dart',
      'paintBorder': 'package:flutter/src/painting/borders.dart',
      'applyBoxFit': 'package:flutter/src/painting/box_fit.dart',
      'debugAssertAllPaintingVarsUnset': 'package:flutter/src/painting/debug.dart',
      'debugCheckCanResolveTextDirection': 'package:flutter/src/painting/debug.dart',
      'paintImage': 'package:flutter/src/painting/decoration_image.dart',
      'positionDependentBox': 'package:flutter/src/painting/geometry.dart',
      'decodeImageFromList': 'package:flutter/src/painting/image_decoder.dart',
      'combineSemanticsInfo': 'package:flutter/src/painting/inline_span.dart',
      'debugDescribeTransform': 'package:flutter/src/painting/matrix_utils.dart',
      'paintZigZag': 'package:flutter/src/painting/paint_utilities.dart',
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
      'lerpFontVariations': 'package:flutter/src/painting/text_style.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'flipAxis': 'Axis flipAxis(Axis direction)',
      'axisDirectionToAxis': 'Axis axisDirectionToAxis(AxisDirection axisDirection)',
      'textDirectionToAxisDirection': 'AxisDirection textDirectionToAxisDirection(TextDirection textDirection)',
      'flipAxisDirection': 'AxisDirection flipAxisDirection(AxisDirection axisDirection)',
      'axisDirectionIsReversed': 'bool axisDirectionIsReversed(AxisDirection axisDirection)',
      'paintBorder': 'void paintBorder(Canvas canvas, Rect rect, {BorderSide top = BorderSide.none, BorderSide right = BorderSide.none, BorderSide bottom = BorderSide.none, BorderSide left = BorderSide.none})',
      'applyBoxFit': 'FittedSizes applyBoxFit(BoxFit fit, Size inputSize, Size outputSize)',
      'debugAssertAllPaintingVarsUnset': 'bool debugAssertAllPaintingVarsUnset(String reason, {bool debugDisableShadowsOverride = false})',
      'debugCheckCanResolveTextDirection': 'bool debugCheckCanResolveTextDirection(TextDirection? direction, String target)',
      'paintImage': 'void paintImage({required Canvas canvas, required Rect rect, required ui.Image image, String? debugImageLabel, double scale = 1.0, double opacity = 1.0, ColorFilter? colorFilter, BoxFit? fit, Alignment alignment = Alignment.center, Rect? centerSlice, ImageRepeat repeat = ImageRepeat.noRepeat, bool flipHorizontally = false, bool invertColors = false, FilterQuality filterQuality = FilterQuality.medium, bool isAntiAlias = false, BlendMode blendMode = BlendMode.srcOver})',
      'positionDependentBox': 'Offset positionDependentBox({required Size size, required Size childSize, required Offset target, required bool preferBelow, double verticalOffset = 0.0, double margin = 10.0})',
      'decodeImageFromList': 'Future<ui.Image> decodeImageFromList(Uint8List bytes)',
      'combineSemanticsInfo': 'List<InlineSpanSemanticsInformation> combineSemanticsInfo(List<InlineSpanSemanticsInformation> infoList)',
      'debugDescribeTransform': 'List<String> debugDescribeTransform(Matrix4? transform)',
      'paintZigZag': 'void paintZigZag(Canvas canvas, Paint paint, Offset start, Offset end, int zigs, double width)',
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
      'lerpFontVariations': 'List<FontVariation>? lerpFontVariations(List<FontVariation>? a, List<FontVariation>? b, double t)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:flutter/src/painting/alignment.dart',
      'package:flutter/src/painting/basic_types.dart',
      'package:flutter/src/painting/beveled_rectangle_border.dart',
      'package:flutter/src/painting/binding.dart',
      'package:flutter/src/painting/border_radius.dart',
      'package:flutter/src/painting/borders.dart',
      'package:flutter/src/painting/box_border.dart',
      'package:flutter/src/painting/box_decoration.dart',
      'package:flutter/src/painting/box_fit.dart',
      'package:flutter/src/painting/box_shadow.dart',
      'package:flutter/src/painting/circle_border.dart',
      'package:flutter/src/painting/clip.dart',
      'package:flutter/src/painting/colors.dart',
      'package:flutter/src/painting/continuous_rectangle_border.dart',
      'package:flutter/src/painting/debug.dart',
      'package:flutter/src/painting/decoration.dart',
      'package:flutter/src/painting/decoration_image.dart',
      'package:flutter/src/painting/edge_insets.dart',
      'package:flutter/src/painting/flutter_logo.dart',
      'package:flutter/src/painting/fractional_offset.dart',
      'package:flutter/src/painting/geometry.dart',
      'package:flutter/src/painting/gradient.dart',
      'package:flutter/src/painting/image_cache.dart',
      'package:flutter/src/painting/image_decoder.dart',
      'package:flutter/src/painting/image_provider.dart',
      'package:flutter/src/painting/image_resolution.dart',
      'package:flutter/src/painting/image_stream.dart',
      'package:flutter/src/painting/inline_span.dart',
      'package:flutter/src/painting/linear_border.dart',
      'package:flutter/src/painting/matrix_utils.dart',
      'package:flutter/src/painting/notched_shapes.dart',
      'package:flutter/src/painting/oval_border.dart',
      'package:flutter/src/painting/paint_utilities.dart',
      'package:flutter/src/painting/placeholder_span.dart',
      'package:flutter/src/painting/rounded_rectangle_border.dart',
      'package:flutter/src/painting/shader_warm_up.dart',
      'package:flutter/src/painting/shape_decoration.dart',
      'package:flutter/src/painting/stadium_border.dart',
      'package:flutter/src/painting/star_border.dart',
      'package:flutter/src/painting/strut_style.dart',
      'package:flutter/src/painting/text_painter.dart',
      'package:flutter/src/painting/text_scaler.dart',
      'package:flutter/src/painting/text_span.dart',
      'package:flutter/src/painting/text_style.dart',
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
    imports.writeln("import 'package:flutter/painting.dart';");
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
    'RenderComparison',
    'Axis',
    'VerticalDirection',
    'AxisDirection',
    'BorderStyle',
    'BoxShape',
    'BoxFit',
    'ImageRepeat',
    'FlutterLogoStyle',
    'ResizeImagePolicy',
    'WebHtmlElementStrategy',
    'TextOverflow',
    'TextWidthBasis',
  ];

}

// =============================================================================
// AlignmentGeometry Bridge
// =============================================================================

BridgedClass _createAlignmentGeometryBridge() {
  return BridgedClass(
    nativeType: $flutter_8.AlignmentGeometry,
    name: 'AlignmentGeometry',
    constructors: {
      'xy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AlignmentGeometry');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'AlignmentGeometry');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'AlignmentGeometry');
        return $flutter_8.AlignmentGeometry.xy(x, y);
      },
      'directional': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AlignmentGeometry');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'AlignmentGeometry');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'AlignmentGeometry');
        return $flutter_8.AlignmentGeometry.directional(start, y);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_8.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        return -t;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'topLeft': (visitor) => $flutter_8.AlignmentGeometry.topLeft,
      'topCenter': (visitor) => $flutter_8.AlignmentGeometry.topCenter,
      'topRight': (visitor) => $flutter_8.AlignmentGeometry.topRight,
      'centerLeft': (visitor) => $flutter_8.AlignmentGeometry.centerLeft,
      'center': (visitor) => $flutter_8.AlignmentGeometry.center,
      'centerRight': (visitor) => $flutter_8.AlignmentGeometry.centerRight,
      'bottomLeft': (visitor) => $flutter_8.AlignmentGeometry.bottomLeft,
      'bottomCenter': (visitor) => $flutter_8.AlignmentGeometry.bottomCenter,
      'bottomRight': (visitor) => $flutter_8.AlignmentGeometry.bottomRight,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_8.AlignmentGeometry?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_8.AlignmentGeometry?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_8.AlignmentGeometry.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'xy': 'const factory AlignmentGeometry.xy(double x, double y)',
      'directional': 'const factory AlignmentGeometry.directional(double start, double y)',
    },
    methodSignatures: {
      'add': 'AlignmentGeometry add(AlignmentGeometry other)',
      'resolve': 'Alignment resolve(TextDirection? direction)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'AlignmentGeometry? lerp(AlignmentGeometry? a, AlignmentGeometry? b, double t)',
    },
    staticGetterSignatures: {
      'topLeft': 'AlignmentGeometry get topLeft',
      'topCenter': 'AlignmentGeometry get topCenter',
      'topRight': 'AlignmentGeometry get topRight',
      'centerLeft': 'AlignmentGeometry get centerLeft',
      'center': 'AlignmentGeometry get center',
      'centerRight': 'AlignmentGeometry get centerRight',
      'bottomLeft': 'AlignmentGeometry get bottomLeft',
      'bottomCenter': 'AlignmentGeometry get bottomCenter',
      'bottomRight': 'AlignmentGeometry get bottomRight',
    },
  );
}

// =============================================================================
// Alignment Bridge
// =============================================================================

BridgedClass _createAlignmentBridge() {
  return BridgedClass(
    nativeType: $flutter_8.Alignment,
    name: 'Alignment',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Alignment');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Alignment');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Alignment');
        return $flutter_8.Alignment(x, y);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment').hashCode,
      'x': (visitor, target) => D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment').y,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_8.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        return t.toString();
      },
      'alongOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'alongOffset');
        final other = D4.getRequiredArg<Offset>(positional, 0, 'other', 'alongOffset');
        return t.alongOffset(other);
      },
      'alongSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'alongSize');
        final other = D4.getRequiredArg<Size>(positional, 0, 'other', 'alongSize');
        return t.alongSize(other);
      },
      'withinRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'withinRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'withinRect');
        return t.withinRect(rect);
      },
      'inscribe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 2, 'inscribe');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inscribe');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'inscribe');
        return t.inscribe(size, rect);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_8.Alignment>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<$flutter_8.Alignment>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'topLeft': (visitor) => $flutter_8.Alignment.topLeft,
      'topCenter': (visitor) => $flutter_8.Alignment.topCenter,
      'topRight': (visitor) => $flutter_8.Alignment.topRight,
      'centerLeft': (visitor) => $flutter_8.Alignment.centerLeft,
      'center': (visitor) => $flutter_8.Alignment.center,
      'centerRight': (visitor) => $flutter_8.Alignment.centerRight,
      'bottomLeft': (visitor) => $flutter_8.Alignment.bottomLeft,
      'bottomCenter': (visitor) => $flutter_8.Alignment.bottomCenter,
      'bottomRight': (visitor) => $flutter_8.Alignment.bottomRight,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_8.Alignment?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_8.Alignment?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_8.Alignment.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const Alignment(double x, double y)',
    },
    methodSignatures: {
      'add': 'AlignmentGeometry add(AlignmentGeometry other)',
      'resolve': 'Alignment resolve(TextDirection? direction)',
      'toString': 'String toString()',
      'alongOffset': 'Offset alongOffset(Offset other)',
      'alongSize': 'Offset alongSize(Size other)',
      'withinRect': 'Offset withinRect(Rect rect)',
      'inscribe': 'Rect inscribe(Size size, Rect rect)',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
      'x': 'double get x',
      'y': 'double get y',
    },
    staticMethodSignatures: {
      'lerp': 'Alignment? lerp(Alignment? a, Alignment? b, double t)',
    },
    staticGetterSignatures: {
      'topLeft': 'Alignment get topLeft',
      'topCenter': 'Alignment get topCenter',
      'topRight': 'Alignment get topRight',
      'centerLeft': 'Alignment get centerLeft',
      'center': 'Alignment get center',
      'centerRight': 'Alignment get centerRight',
      'bottomLeft': 'Alignment get bottomLeft',
      'bottomCenter': 'Alignment get bottomCenter',
      'bottomRight': 'Alignment get bottomRight',
    },
  );
}

// =============================================================================
// AlignmentDirectional Bridge
// =============================================================================

BridgedClass _createAlignmentDirectionalBridge() {
  return BridgedClass(
    nativeType: $flutter_8.AlignmentDirectional,
    name: 'AlignmentDirectional',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AlignmentDirectional');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'AlignmentDirectional');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'AlignmentDirectional');
        return $flutter_8.AlignmentDirectional(start, y);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional').start,
      'y': (visitor, target) => D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional').y,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_8.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_8.AlignmentDirectional>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<$flutter_8.AlignmentDirectional>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'topStart': (visitor) => $flutter_8.AlignmentDirectional.topStart,
      'topCenter': (visitor) => $flutter_8.AlignmentDirectional.topCenter,
      'topEnd': (visitor) => $flutter_8.AlignmentDirectional.topEnd,
      'centerStart': (visitor) => $flutter_8.AlignmentDirectional.centerStart,
      'center': (visitor) => $flutter_8.AlignmentDirectional.center,
      'centerEnd': (visitor) => $flutter_8.AlignmentDirectional.centerEnd,
      'bottomStart': (visitor) => $flutter_8.AlignmentDirectional.bottomStart,
      'bottomCenter': (visitor) => $flutter_8.AlignmentDirectional.bottomCenter,
      'bottomEnd': (visitor) => $flutter_8.AlignmentDirectional.bottomEnd,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_8.AlignmentDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_8.AlignmentDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_8.AlignmentDirectional.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const AlignmentDirectional(double start, double y)',
    },
    methodSignatures: {
      'add': 'AlignmentGeometry add(AlignmentGeometry other)',
      'resolve': 'Alignment resolve(TextDirection? direction)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
      'start': 'double get start',
      'y': 'double get y',
    },
    staticMethodSignatures: {
      'lerp': 'AlignmentDirectional? lerp(AlignmentDirectional? a, AlignmentDirectional? b, double t)',
    },
    staticGetterSignatures: {
      'topStart': 'AlignmentDirectional get topStart',
      'topCenter': 'AlignmentDirectional get topCenter',
      'topEnd': 'AlignmentDirectional get topEnd',
      'centerStart': 'AlignmentDirectional get centerStart',
      'center': 'AlignmentDirectional get center',
      'centerEnd': 'AlignmentDirectional get centerEnd',
      'bottomStart': 'AlignmentDirectional get bottomStart',
      'bottomCenter': 'AlignmentDirectional get bottomCenter',
      'bottomEnd': 'AlignmentDirectional get bottomEnd',
    },
  );
}

// =============================================================================
// TextAlignVertical Bridge
// =============================================================================

BridgedClass _createTextAlignVerticalBridge() {
  return BridgedClass(
    nativeType: $flutter_8.TextAlignVertical,
    name: 'TextAlignVertical',
    constructors: {
      '': (visitor, positional, named) {
        final y = D4.getRequiredNamedArg<double>(named, 'y', 'TextAlignVertical');
        return $flutter_8.TextAlignVertical(y: y);
      },
    },
    getters: {
      'y': (visitor, target) => D4.validateTarget<$flutter_8.TextAlignVertical>(target, 'TextAlignVertical').y,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TextAlignVertical>(target, 'TextAlignVertical');
        return t.toString();
      },
    },
    staticGetters: {
      'top': (visitor) => $flutter_8.TextAlignVertical.top,
      'center': (visitor) => $flutter_8.TextAlignVertical.center,
      'bottom': (visitor) => $flutter_8.TextAlignVertical.bottom,
    },
    constructorSignatures: {
      '': 'const TextAlignVertical({required double y})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'y': 'double get y',
    },
    staticGetterSignatures: {
      'top': 'TextAlignVertical get top',
      'center': 'TextAlignVertical get center',
      'bottom': 'TextAlignVertical get bottom',
    },
  );
}

// =============================================================================
// BeveledRectangleBorder Bridge
// =============================================================================

BridgedClass _createBeveledRectangleBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_10.BeveledRectangleBorder,
    name: 'BeveledRectangleBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final borderRadius = D4.getNamedArgWithDefault<$flutter_12.BorderRadiusGeometry>(named, 'borderRadius', $flutter_12.BorderRadius.zero);
        return $flutter_10.BeveledRectangleBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const BeveledRectangleBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry borderRadius = BorderRadius.zero})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'BeveledRectangleBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'borderRadius': 'BorderRadiusGeometry get borderRadius',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// PaintingBinding Bridge
// =============================================================================

BridgedClass _createPaintingBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_11.PaintingBinding,
    name: 'PaintingBinding',
    constructors: {
    },
    getters: {
      'imageCache': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').imageCache,
      'systemFonts': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').systemFonts,
      'window': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').platformDispatcher,
      'keyboard': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').keyboard,
      'keyEventManager': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').keyEventManager,
      'defaultBinaryMessenger': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').defaultBinaryMessenger,
      'channelBuffers': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').channelBuffers,
      'accessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').accessibilityFocus,
      'restorationManager': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').restorationManager,
      'lifecycleState': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').lifecycleState,
      'transientCallbackCount': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').transientCallbackCount,
      'endOfFrame': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').endOfFrame,
      'hasScheduledFrame': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').hasScheduledFrame,
      'schedulerPhase': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').schedulerPhase,
      'framesEnabled': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').framesEnabled,
      'currentFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').currentFrameTimeStamp,
      'currentSystemFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').currentSystemFrameTimeStamp,
    },
    setters: {
      'schedulingStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding').schedulingStrategy = value as bool Function({required int priority, required $flutter_52.SchedulerBinding scheduler}),
    },
    methods: {
      'instantiateImageCodecFromBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'instantiateImageCodecFromBuffer');
        final buffer = D4.getRequiredArg<ImmutableBuffer>(positional, 0, 'buffer', 'instantiateImageCodecFromBuffer');
        final cacheWidth = D4.getOptionalNamedArg<int?>(named, 'cacheWidth');
        final cacheHeight = D4.getOptionalNamedArg<int?>(named, 'cacheHeight');
        final allowUpscaling = D4.getNamedArgWithDefault<bool>(named, 'allowUpscaling', false);
        return t.instantiateImageCodecFromBuffer(buffer, cacheWidth: cacheWidth, cacheHeight: cacheHeight, allowUpscaling: allowUpscaling);
      },
      'instantiateImageCodecWithSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'instantiateImageCodecWithSize');
        final buffer = D4.getRequiredArg<ImmutableBuffer>(positional, 0, 'buffer', 'instantiateImageCodecWithSize');
        final getTargetSizeRaw = named['getTargetSize'];
        return t.instantiateImageCodecWithSize(buffer, getTargetSize: getTargetSizeRaw == null ? null : (int p0, int p1) { return D4.callInterpreterCallback(visitor, getTargetSizeRaw, [p0, p1]) as TargetImageSize; });
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        return t.reassembleApplication();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        return t.toString();
      },
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        t.initInstances();
        return null;
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'handleRequestAppExit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        return t.handleRequestAppExit();
      },
      'exitApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'exitApplication');
        final exitType = D4.getRequiredArg<AppExitType>(positional, 0, 'exitType', 'exitApplication');
        final exitCode = D4.getOptionalArgWithDefault<int>(positional, 1, 'exitCode', 0);
        return t.exitApplication(exitType, exitCode);
      },
      'setSystemUiChangeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'setSystemUiChangeCallback');
        if (positional.isEmpty) {
          throw ArgumentError('setSystemUiChangeCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.setSystemUiChangeCallback(callbackRaw == null ? null : (bool p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as Future<void>; });
        return null;
      },
      'addTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'addTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'removeTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'removeTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'scheduleTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 2, 'scheduleTask');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        final priority = D4.getRequiredArg<$flutter_53.Priority>(positional, 1, 'priority', 'scheduleTask');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return t.scheduleTask(() { return D4.callInterpreterCallback(visitor, taskRaw, []) as FutureOr<Object>; }, priority, debugLabel: debugLabel, flow: flow);
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        (t as dynamic).unlocked();
        return null;
      },
      'scheduleFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
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
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'cancelFrameCallbackWithId');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'cancelFrameCallbackWithId');
        t.cancelFrameCallbackWithId(id);
        return null;
      },
      'debugAssertNoTransientCallbacks': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTransientCallbacks');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTransientCallbacks');
        return t.debugAssertNoTransientCallbacks(reason);
      },
      'debugAssertNoPendingPerformanceModeRequests': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoPendingPerformanceModeRequests');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoPendingPerformanceModeRequests');
        return t.debugAssertNoPendingPerformanceModeRequests(reason);
      },
      'debugAssertNoTimeDilation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTimeDilation');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTimeDilation');
        return t.debugAssertNoTimeDilation(reason);
      },
      'addPersistentFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'addPersistentFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPersistentFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addPersistentFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'addPostFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
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
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        t.ensureVisualUpdate();
        return null;
      },
      'scheduleFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        t.scheduleFrame();
        return null;
      },
      'scheduleForcedFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        t.scheduleForcedFrame();
        return null;
      },
      'scheduleWarmUpFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        t.scheduleWarmUpFrame();
        return null;
      },
      'resetEpoch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        t.resetEpoch();
        return null;
      },
      'handleBeginFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'handleBeginFrame');
        final rawTimeStamp = D4.getRequiredArg<Duration?>(positional, 0, 'rawTimeStamp', 'handleBeginFrame');
        t.handleBeginFrame(rawTimeStamp);
        return null;
      },
      'requestPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'requestPerformanceMode');
        final mode = D4.getRequiredArg<DartPerformanceMode>(positional, 0, 'mode', 'requestPerformanceMode');
        return t.requestPerformanceMode(mode);
      },
      'debugGetRequestedPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        return t.debugGetRequestedPerformanceMode();
      },
      'handleDrawFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.PaintingBinding>(target, 'PaintingBinding');
        t.handleDrawFrame();
        return null;
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_11.PaintingBinding.instance,
      'shaderWarmUp': (visitor) => $flutter_11.PaintingBinding.shaderWarmUp,
    },
    staticSetters: {
      'shaderWarmUp': (visitor, value) => 
        $flutter_11.PaintingBinding.shaderWarmUp = value as $flutter_43.ShaderWarmUp?,
    },
    methodSignatures: {
      'instantiateImageCodecFromBuffer': 'Future<ui.Codec> instantiateImageCodecFromBuffer(ui.ImmutableBuffer buffer, {int? cacheWidth, int? cacheHeight, bool allowUpscaling = false})',
      'instantiateImageCodecWithSize': 'Future<ui.Codec> instantiateImageCodecWithSize(ui.ImmutableBuffer buffer, {ui.TargetImageSizeCallback? getTargetSize})',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'toString': 'String toString()',
      'initInstances': 'void initInstances()',
      'initServiceExtensions': 'void initServiceExtensions()',
      'handleRequestAppExit': 'Future<AppExitResponse> handleRequestAppExit()',
      'exitApplication': 'Future<AppExitResponse> exitApplication(AppExitType exitType, [int exitCode = 0])',
      'setSystemUiChangeCallback': 'void setSystemUiChangeCallback(Future<void> Function(bool)? callback)',
      'addTimingsCallback': 'void addTimingsCallback(void Function(List<FrameTiming>) callback)',
      'removeTimingsCallback': 'void removeTimingsCallback(void Function(List<FrameTiming>) callback)',
      'scheduleTask': 'Future<T> scheduleTask(FutureOr<T> Function() task, Priority priority, {String? debugLabel, Flow? flow})',
      'unlocked': 'void unlocked()',
      'scheduleFrameCallback': 'int scheduleFrameCallback(void Function(Duration) callback, {bool rescheduling = false, bool scheduleNewFrame = true})',
      'cancelFrameCallbackWithId': 'void cancelFrameCallbackWithId(int id)',
      'debugAssertNoTransientCallbacks': 'bool debugAssertNoTransientCallbacks(String reason)',
      'debugAssertNoPendingPerformanceModeRequests': 'bool debugAssertNoPendingPerformanceModeRequests(String reason)',
      'debugAssertNoTimeDilation': 'bool debugAssertNoTimeDilation(String reason)',
      'addPersistentFrameCallback': 'void addPersistentFrameCallback(void Function(Duration) callback)',
      'addPostFrameCallback': 'void addPostFrameCallback(void Function(Duration) callback, {String debugLabel = \'callback\'})',
      'ensureVisualUpdate': 'void ensureVisualUpdate()',
      'scheduleFrame': 'void scheduleFrame()',
      'scheduleForcedFrame': 'void scheduleForcedFrame()',
      'scheduleWarmUpFrame': 'void scheduleWarmUpFrame()',
      'resetEpoch': 'void resetEpoch()',
      'handleBeginFrame': 'void handleBeginFrame(Duration? rawTimeStamp)',
      'requestPerformanceMode': 'PerformanceModeRequestHandle? requestPerformanceMode(DartPerformanceMode mode)',
      'debugGetRequestedPerformanceMode': 'DartPerformanceMode? debugGetRequestedPerformanceMode()',
      'handleDrawFrame': 'void handleDrawFrame()',
    },
    getterSignatures: {
      'imageCache': 'ImageCache get imageCache',
      'systemFonts': 'Listenable get systemFonts',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
      'keyboard': 'HardwareKeyboard get keyboard',
      'keyEventManager': 'KeyEventManager get keyEventManager',
      'defaultBinaryMessenger': 'BinaryMessenger get defaultBinaryMessenger',
      'channelBuffers': 'ChannelBuffers get channelBuffers',
      'accessibilityFocus': 'ValueNotifier<int?> get accessibilityFocus',
      'restorationManager': 'RestorationManager get restorationManager',
      'lifecycleState': 'AppLifecycleState? get lifecycleState',
      'transientCallbackCount': 'int get transientCallbackCount',
      'endOfFrame': 'Future<void> get endOfFrame',
      'hasScheduledFrame': 'bool get hasScheduledFrame',
      'schedulerPhase': 'SchedulerPhase get schedulerPhase',
      'framesEnabled': 'bool get framesEnabled',
      'currentFrameTimeStamp': 'Duration get currentFrameTimeStamp',
      'currentSystemFrameTimeStamp': 'Duration get currentSystemFrameTimeStamp',
    },
    setterSignatures: {
      'schedulingStrategy': 'set schedulingStrategy(bool Function({required int priority, required SchedulerBinding scheduler}) value)',
    },
    staticGetterSignatures: {
      'instance': 'PaintingBinding get instance',
      'shaderWarmUp': 'ShaderWarmUp? get shaderWarmUp',
    },
    staticSetterSignatures: {
      'shaderWarmUp': 'set shaderWarmUp(dynamic value)',
    },
  );
}

// =============================================================================
// BorderRadiusGeometry Bridge
// =============================================================================

BridgedClass _createBorderRadiusGeometryBridge() {
  return BridgedClass(
    nativeType: $flutter_12.BorderRadiusGeometry,
    name: 'BorderRadiusGeometry',
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusGeometry');
        final radius = D4.getRequiredArg<Radius>(positional, 0, 'radius', 'BorderRadiusGeometry');
        return $flutter_12.BorderRadiusGeometry.all(radius);
      },
      'circular': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusGeometry');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'BorderRadiusGeometry');
        return $flutter_12.BorderRadiusGeometry.circular(radius);
      },
      'horizontal': (visitor, positional, named) {
        final left = D4.getOptionalNamedArg<Radius?>(named, 'left');
        final right = D4.getOptionalNamedArg<Radius?>(named, 'right');
        final start = D4.getOptionalNamedArg<Radius?>(named, 'start');
        final end = D4.getOptionalNamedArg<Radius?>(named, 'end');
        return $flutter_12.BorderRadiusGeometry.horizontal(left: left, right: right, start: start, end: end);
      },
      'only': (visitor, positional, named) {
        final topLeft = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'topLeft', 'BorderRadiusGeometry', '<default unavailable>');
        final topRight = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'topRight', 'BorderRadiusGeometry', '<default unavailable>');
        final bottomLeft = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry', '<default unavailable>');
        final bottomRight = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'bottomRight', 'BorderRadiusGeometry', '<default unavailable>');
        return $flutter_12.BorderRadiusGeometry.only(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
      },
      'directional': (visitor, positional, named) {
        final topStart = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'topStart', 'BorderRadiusGeometry', '<default unavailable>');
        final topEnd = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'topEnd', 'BorderRadiusGeometry', '<default unavailable>');
        final bottomStart = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'bottomStart', 'BorderRadiusGeometry', '<default unavailable>');
        final bottomEnd = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry', '<default unavailable>');
        return $flutter_12.BorderRadiusGeometry.directional(topStart: topStart, topEnd: topEnd, bottomStart: bottomStart, bottomEnd: bottomEnd);
      },
      'vertical': (visitor, positional, named) {
        final top = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'top', 'BorderRadiusGeometry', '<default unavailable>');
        final bottom = D4.getRequiredNamedArgTodoDefault<Radius>(named, 'bottom', 'BorderRadiusGeometry', '<default unavailable>');
        return $flutter_12.BorderRadiusGeometry.vertical(top: top, bottom: bottom);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry').hashCode,
    },
    methods: {
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        return -t;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_12.BorderRadiusGeometry.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_12.BorderRadiusGeometry.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'all': 'const factory BorderRadiusGeometry.all(Radius radius)',
      'circular': 'factory BorderRadiusGeometry.circular(double radius)',
      'horizontal': 'factory BorderRadiusGeometry.horizontal({Radius? left, Radius? right, Radius? start, Radius? end})',
      'only': 'const factory BorderRadiusGeometry.only({Radius topLeft, Radius topRight, Radius bottomLeft, Radius bottomRight})',
      'directional': 'const factory BorderRadiusGeometry.directional({Radius topStart, Radius topEnd, Radius bottomStart, Radius bottomEnd})',
      'vertical': 'const factory BorderRadiusGeometry.vertical({Radius top, Radius bottom})',
    },
    methodSignatures: {
      'subtract': 'BorderRadiusGeometry subtract(BorderRadiusGeometry other)',
      'add': 'BorderRadiusGeometry add(BorderRadiusGeometry other)',
      'resolve': 'BorderRadius resolve(TextDirection? direction)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'BorderRadiusGeometry? lerp(BorderRadiusGeometry? a, BorderRadiusGeometry? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'BorderRadiusGeometry get zero',
    },
  );
}

// =============================================================================
// BorderRadius Bridge
// =============================================================================

BridgedClass _createBorderRadiusBridge() {
  return BridgedClass(
    nativeType: $flutter_12.BorderRadius,
    name: 'BorderRadius',
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadius');
        final radius = D4.getRequiredArg<Radius>(positional, 0, 'radius', 'BorderRadius');
        return $flutter_12.BorderRadius.all(radius);
      },
      'circular': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadius');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'BorderRadius');
        return $flutter_12.BorderRadius.circular(radius);
      },
      'vertical': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<Radius>(named, 'top', Radius.zero);
        final bottom = D4.getNamedArgWithDefault<Radius>(named, 'bottom', Radius.zero);
        return $flutter_12.BorderRadius.vertical(top: top, bottom: bottom);
      },
      'horizontal': (visitor, positional, named) {
        final left = D4.getNamedArgWithDefault<Radius>(named, 'left', Radius.zero);
        final right = D4.getNamedArgWithDefault<Radius>(named, 'right', Radius.zero);
        return $flutter_12.BorderRadius.horizontal(left: left, right: right);
      },
      'only': (visitor, positional, named) {
        final topLeft = D4.getNamedArgWithDefault<Radius>(named, 'topLeft', Radius.zero);
        final topRight = D4.getNamedArgWithDefault<Radius>(named, 'topRight', Radius.zero);
        final bottomLeft = D4.getNamedArgWithDefault<Radius>(named, 'bottomLeft', Radius.zero);
        final bottomRight = D4.getNamedArgWithDefault<Radius>(named, 'bottomRight', Radius.zero);
        return $flutter_12.BorderRadius.only(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius').hashCode,
      'topLeft': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius').topLeft,
      'topRight': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius').topRight,
      'bottomLeft': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius').bottomLeft,
      'bottomRight': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius').bottomRight,
    },
    methods: {
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        final topLeft = D4.getOptionalNamedArg<Radius?>(named, 'topLeft');
        final topRight = D4.getOptionalNamedArg<Radius?>(named, 'topRight');
        final bottomLeft = D4.getOptionalNamedArg<Radius?>(named, 'bottomLeft');
        final bottomRight = D4.getOptionalNamedArg<Radius?>(named, 'bottomRight');
        return t.copyWith(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
      },
      'toRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'toRRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'toRRect');
        return t.toRRect(rect);
      },
      'toRSuperellipse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'toRSuperellipse');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'toRSuperellipse');
        return t.toRSuperellipse(rect);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_12.BorderRadius>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<$flutter_12.BorderRadius>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_12.BorderRadius.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_12.BorderRadius?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_12.BorderRadius?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_12.BorderRadius.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'all': 'const BorderRadius.all(Radius radius)',
      'circular': 'BorderRadius.circular(double radius)',
      'vertical': 'const BorderRadius.vertical({Radius top = Radius.zero, Radius bottom = Radius.zero})',
      'horizontal': 'const BorderRadius.horizontal({Radius left = Radius.zero, Radius right = Radius.zero})',
      'only': 'const BorderRadius.only({Radius topLeft = Radius.zero, Radius topRight = Radius.zero, Radius bottomLeft = Radius.zero, Radius bottomRight = Radius.zero})',
    },
    methodSignatures: {
      'subtract': 'BorderRadiusGeometry subtract(BorderRadiusGeometry other)',
      'add': 'BorderRadiusGeometry add(BorderRadiusGeometry other)',
      'resolve': 'BorderRadius resolve(TextDirection? direction)',
      'toString': 'String toString()',
      'copyWith': 'BorderRadius copyWith({Radius? topLeft, Radius? topRight, Radius? bottomLeft, Radius? bottomRight})',
      'toRRect': 'RRect toRRect(Rect rect)',
      'toRSuperellipse': 'RSuperellipse toRSuperellipse(Rect rect)',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
      'topLeft': 'Radius get topLeft',
      'topRight': 'Radius get topRight',
      'bottomLeft': 'Radius get bottomLeft',
      'bottomRight': 'Radius get bottomRight',
    },
    staticMethodSignatures: {
      'lerp': 'BorderRadius? lerp(BorderRadius? a, BorderRadius? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'BorderRadius get zero',
    },
  );
}

// =============================================================================
// BorderRadiusDirectional Bridge
// =============================================================================

BridgedClass _createBorderRadiusDirectionalBridge() {
  return BridgedClass(
    nativeType: $flutter_12.BorderRadiusDirectional,
    name: 'BorderRadiusDirectional',
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusDirectional');
        final radius = D4.getRequiredArg<Radius>(positional, 0, 'radius', 'BorderRadiusDirectional');
        return $flutter_12.BorderRadiusDirectional.all(radius);
      },
      'circular': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusDirectional');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'BorderRadiusDirectional');
        return $flutter_12.BorderRadiusDirectional.circular(radius);
      },
      'vertical': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<Radius>(named, 'top', Radius.zero);
        final bottom = D4.getNamedArgWithDefault<Radius>(named, 'bottom', Radius.zero);
        return $flutter_12.BorderRadiusDirectional.vertical(top: top, bottom: bottom);
      },
      'horizontal': (visitor, positional, named) {
        final start = D4.getNamedArgWithDefault<Radius>(named, 'start', Radius.zero);
        final end = D4.getNamedArgWithDefault<Radius>(named, 'end', Radius.zero);
        return $flutter_12.BorderRadiusDirectional.horizontal(start: start, end: end);
      },
      'only': (visitor, positional, named) {
        final topStart = D4.getNamedArgWithDefault<Radius>(named, 'topStart', Radius.zero);
        final topEnd = D4.getNamedArgWithDefault<Radius>(named, 'topEnd', Radius.zero);
        final bottomStart = D4.getNamedArgWithDefault<Radius>(named, 'bottomStart', Radius.zero);
        final bottomEnd = D4.getNamedArgWithDefault<Radius>(named, 'bottomEnd', Radius.zero);
        return $flutter_12.BorderRadiusDirectional.only(topStart: topStart, topEnd: topEnd, bottomStart: bottomStart, bottomEnd: bottomEnd);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').hashCode,
      'topStart': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').topStart,
      'topEnd': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').topEnd,
      'bottomStart': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').bottomStart,
      'bottomEnd': (visitor, target) => D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').bottomEnd,
    },
    methods: {
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_12.BorderRadiusGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_12.BorderRadiusDirectional>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<$flutter_12.BorderRadiusDirectional>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_12.BorderRadiusDirectional.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_12.BorderRadiusDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_12.BorderRadiusDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_12.BorderRadiusDirectional.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'all': 'const BorderRadiusDirectional.all(Radius radius)',
      'circular': 'BorderRadiusDirectional.circular(double radius)',
      'vertical': 'const BorderRadiusDirectional.vertical({Radius top = Radius.zero, Radius bottom = Radius.zero})',
      'horizontal': 'const BorderRadiusDirectional.horizontal({Radius start = Radius.zero, Radius end = Radius.zero})',
      'only': 'const BorderRadiusDirectional.only({Radius topStart = Radius.zero, Radius topEnd = Radius.zero, Radius bottomStart = Radius.zero, Radius bottomEnd = Radius.zero})',
    },
    methodSignatures: {
      'subtract': 'BorderRadiusGeometry subtract(BorderRadiusGeometry other)',
      'add': 'BorderRadiusGeometry add(BorderRadiusGeometry other)',
      'resolve': 'BorderRadius resolve(TextDirection? direction)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
      'topStart': 'Radius get topStart',
      'topEnd': 'Radius get topEnd',
      'bottomStart': 'Radius get bottomStart',
      'bottomEnd': 'Radius get bottomEnd',
    },
    staticMethodSignatures: {
      'lerp': 'BorderRadiusDirectional? lerp(BorderRadiusDirectional? a, BorderRadiusDirectional? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'BorderRadiusDirectional get zero',
    },
  );
}

// =============================================================================
// BorderSide Bridge
// =============================================================================

BridgedClass _createBorderSideBridge() {
  return BridgedClass(
    nativeType: $flutter_13.BorderSide,
    name: 'BorderSide',
    constructors: {
      '': (visitor, positional, named) {
        final color = D4.getNamedArgWithDefault<Color>(named, 'color', const Color(0xFF000000));
        final width = D4.getNamedArgWithDefault<double>(named, 'width', 1.0);
        final style = D4.getNamedArgWithDefault<$flutter_13.BorderStyle>(named, 'style', $flutter_13.BorderStyle.solid);
        if (!named.containsKey('strokeAlign')) {
          return $flutter_13.BorderSide(color: color, width: width, style: style);
        }
        if (named.containsKey('strokeAlign')) {
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BorderSide');
          return $flutter_13.BorderSide(color: color, width: width, style: style, strokeAlign: strokeAlign);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'color': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').color,
      'width': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').width,
      'style': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').style,
      'strokeAlign': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').strokeAlign,
      'strokeInset': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').strokeInset,
      'strokeOutset': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').strokeOutset,
      'strokeOffset': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').strokeOffset,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final width = D4.getOptionalNamedArg<double?>(named, 'width');
        final style = D4.getOptionalNamedArg<$flutter_13.BorderStyle?>(named, 'style');
        final strokeAlign = D4.getOptionalNamedArg<double?>(named, 'strokeAlign');
        return t.copyWith(color: color, width: width, style: style, strokeAlign: strokeAlign);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'toPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide');
        return t.toPaint();
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BorderSide>(target, 'BorderSide');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'none': (visitor) => $flutter_13.BorderSide.none,
      'strokeAlignInside': (visitor) => $flutter_13.BorderSide.strokeAlignInside,
      'strokeAlignCenter': (visitor) => $flutter_13.BorderSide.strokeAlignCenter,
      'strokeAlignOutside': (visitor) => $flutter_13.BorderSide.strokeAlignOutside,
    },
    staticMethods: {
      'merge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'merge');
        final a = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 0, 'a', 'merge');
        final b = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 1, 'b', 'merge');
        return $flutter_13.BorderSide.merge(a, b);
      },
      'canMerge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'canMerge');
        final a = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 0, 'a', 'canMerge');
        final b = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 1, 'b', 'canMerge');
        return $flutter_13.BorderSide.canMerge(a, b);
      },
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_13.BorderSide.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const BorderSide({Color color = const Color(0xFF000000), double width = 1.0, BorderStyle style = BorderStyle.solid, double strokeAlign = strokeAlignInside})',
    },
    methodSignatures: {
      'copyWith': 'BorderSide copyWith({Color? color, double? width, BorderStyle? style, double? strokeAlign})',
      'scale': 'BorderSide scale(double t)',
      'toPaint': 'Paint toPaint()',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'color': 'Color get color',
      'width': 'double get width',
      'style': 'BorderStyle get style',
      'strokeAlign': 'double get strokeAlign',
      'strokeInset': 'double get strokeInset',
      'strokeOutset': 'double get strokeOutset',
      'strokeOffset': 'double get strokeOffset',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'merge': 'BorderSide merge(BorderSide a, BorderSide b)',
      'canMerge': 'bool canMerge(BorderSide a, BorderSide b)',
      'lerp': 'BorderSide lerp(BorderSide a, BorderSide b, double t)',
    },
    staticGetterSignatures: {
      'none': 'BorderSide get none',
      'strokeAlignInside': 'double get strokeAlignInside',
      'strokeAlignCenter': 'double get strokeAlignCenter',
      'strokeAlignOutside': 'double get strokeAlignOutside',
    },
  );
}

// =============================================================================
// ShapeBorder Bridge
// =============================================================================

BridgedClass _createShapeBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_13.ShapeBorder,
    name: 'ShapeBorder',
    constructors: {
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder').preferPaintInterior,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.ShapeBorder>(target, 'ShapeBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_13.ShapeBorder.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
    },
    staticMethodSignatures: {
      'lerp': 'ShapeBorder? lerp(ShapeBorder? a, ShapeBorder? b, double t)',
    },
  );
}

// =============================================================================
// OutlinedBorder Bridge
// =============================================================================

BridgedClass _createOutlinedBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_13.OutlinedBorder,
    name: 'OutlinedBorder',
    constructors: {
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder').side,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        return t.copyWith(side: side);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.OutlinedBorder>(target, 'OutlinedBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_13.OutlinedBorder?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_13.OutlinedBorder?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_13.OutlinedBorder.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'OutlinedBorder copyWith({BorderSide? side})',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
    },
    staticMethodSignatures: {
      'lerp': 'OutlinedBorder? lerp(OutlinedBorder? a, OutlinedBorder? b, double t)',
    },
  );
}

// =============================================================================
// BoxBorder Bridge
// =============================================================================

BridgedClass _createBoxBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_14.BoxBorder,
    name: 'BoxBorder',
    constructors: {
      'fromLTRB': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'top', $flutter_13.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'right', $flutter_13.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'bottom', $flutter_13.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'left', $flutter_13.BorderSide.none);
        return $flutter_14.BoxBorder.fromLTRB(top: top, right: right, bottom: bottom, left: left);
      },
      'all': (visitor, positional, named) {
        final color = D4.getRequiredNamedArgTodoDefault<Color>(named, 'color', 'BoxBorder', '<default unavailable>');
        final width = D4.getRequiredNamedArgTodoDefault<double>(named, 'width', 'BoxBorder', '<default unavailable>');
        final style = D4.getRequiredNamedArgTodoDefault<$flutter_13.BorderStyle>(named, 'style', 'BoxBorder', '<default unavailable>');
        final strokeAlign = D4.getRequiredNamedArgTodoDefault<double>(named, 'strokeAlign', 'BoxBorder', '<default unavailable>');
        return $flutter_14.BoxBorder.all(color: color, width: width, style: style, strokeAlign: strokeAlign);
      },
      'fromBorderSide': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BoxBorder');
        final side = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 0, 'side', 'BoxBorder');
        return $flutter_14.BoxBorder.fromBorderSide(side);
      },
      'symmetric': (visitor, positional, named) {
        final vertical = D4.getRequiredNamedArgTodoDefault<$flutter_13.BorderSide>(named, 'vertical', 'BoxBorder', '<default unavailable>');
        final horizontal = D4.getRequiredNamedArgTodoDefault<$flutter_13.BorderSide>(named, 'horizontal', 'BoxBorder', '<default unavailable>');
        return $flutter_14.BoxBorder.symmetric(vertical: vertical, horizontal: horizontal);
      },
      'fromSTEB': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'top', $flutter_13.BorderSide.none);
        final start = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'start', $flutter_13.BorderSide.none);
        final end = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'end', $flutter_13.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'bottom', $flutter_13.BorderSide.none);
        return $flutter_14.BoxBorder.fromSTEB(top: top, start: start, end: end, bottom: bottom);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder').preferPaintInterior,
      'top': (visitor, target) => D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder').bottom,
      'isUniform': (visitor, target) => D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder').isUniform,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final shape = D4.getNamedArgWithDefault<$flutter_14.BoxShape>(named, 'shape', $flutter_14.BoxShape.rectangle);
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadius?>(named, 'borderRadius');
        t.paint(canvas, rect, textDirection: textDirection, shape: shape, borderRadius: borderRadius);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BoxBorder>(target, 'BoxBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_14.BoxBorder?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_14.BoxBorder?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_14.BoxBorder.lerp(a, b, t_);
      },
      'paintNonUniformBorder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'paintNonUniformBorder');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintNonUniformBorder');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintNonUniformBorder');
        final borderRadius = D4.getRequiredNamedArg<$flutter_12.BorderRadius?>(named, 'borderRadius', 'paintNonUniformBorder');
        final textDirection = D4.getRequiredNamedArg<TextDirection?>(named, 'textDirection', 'paintNonUniformBorder');
        final shape = D4.getNamedArgWithDefault<$flutter_14.BoxShape>(named, 'shape', $flutter_14.BoxShape.rectangle);
        final top = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'top', $flutter_13.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'right', $flutter_13.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'bottom', $flutter_13.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'left', $flutter_13.BorderSide.none);
        final color = D4.getRequiredNamedArg<Color>(named, 'color', 'paintNonUniformBorder');
        return $flutter_14.BoxBorder.paintNonUniformBorder(canvas, rect, borderRadius: borderRadius, textDirection: textDirection, shape: shape, top: top, right: right, bottom: bottom, left: left, color: color);
      },
    },
    constructorSignatures: {
      'fromLTRB': 'factory BoxBorder.fromLTRB({BorderSide top = BorderSide.none, BorderSide right = BorderSide.none, BorderSide bottom = BorderSide.none, BorderSide left = BorderSide.none})',
      'all': 'factory BoxBorder.all({Color color, double width, BorderStyle style, double strokeAlign})',
      'fromBorderSide': 'const factory BoxBorder.fromBorderSide(BorderSide side)',
      'symmetric': 'const factory BoxBorder.symmetric({BorderSide vertical, BorderSide horizontal})',
      'fromSTEB': 'factory BoxBorder.fromSTEB({BorderSide top = BorderSide.none, BorderSide start = BorderSide.none, BorderSide end = BorderSide.none, BorderSide bottom = BorderSide.none})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection, BoxShape shape = BoxShape.rectangle, BorderRadius? borderRadius})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'top': 'BorderSide get top',
      'bottom': 'BorderSide get bottom',
      'isUniform': 'bool get isUniform',
    },
    staticMethodSignatures: {
      'lerp': 'BoxBorder? lerp(BoxBorder? a, BoxBorder? b, double t)',
      'paintNonUniformBorder': 'void paintNonUniformBorder(Canvas canvas, Rect rect, {required BorderRadius? borderRadius, required TextDirection? textDirection, BoxShape shape = BoxShape.rectangle, BorderSide top = BorderSide.none, BorderSide right = BorderSide.none, BorderSide bottom = BorderSide.none, BorderSide left = BorderSide.none, required Color color})',
    },
  );
}

// =============================================================================
// Border Bridge
// =============================================================================

BridgedClass _createBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_14.Border,
    name: 'Border',
    constructors: {
      '': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'top', $flutter_13.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'right', $flutter_13.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'bottom', $flutter_13.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'left', $flutter_13.BorderSide.none);
        return $flutter_14.Border(top: top, right: right, bottom: bottom, left: left);
      },
      'fromBorderSide': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Border');
        final side = D4.getRequiredArg<$flutter_13.BorderSide>(positional, 0, 'side', 'Border');
        return $flutter_14.Border.fromBorderSide(side);
      },
      'symmetric': (visitor, positional, named) {
        final vertical = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'vertical', $flutter_13.BorderSide.none);
        final horizontal = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'horizontal', $flutter_13.BorderSide.none);
        return $flutter_14.Border.symmetric(vertical: vertical, horizontal: horizontal);
      },
      'all': (visitor, positional, named) {
        final color = D4.getNamedArgWithDefault<Color>(named, 'color', const Color(0xFF000000));
        final width = D4.getNamedArgWithDefault<double>(named, 'width', 1.0);
        final style = D4.getNamedArgWithDefault<$flutter_13.BorderStyle>(named, 'style', $flutter_13.BorderStyle.solid);
        final strokeAlign = D4.getNamedArgWithDefault<double>(named, 'strokeAlign', $flutter_13.BorderSide.strokeAlignInside);
        return $flutter_14.Border.all(color: color, width: width, style: style, strokeAlign: strokeAlign);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').preferPaintInterior,
      'top': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').bottom,
      'isUniform': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').isUniform,
      'right': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').right,
      'left': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').left,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_14.Border>(target, 'Border').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final shape = D4.getNamedArgWithDefault<$flutter_14.BoxShape>(named, 'shape', $flutter_14.BoxShape.rectangle);
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadius?>(named, 'borderRadius');
        t.paint(canvas, rect, textDirection: textDirection, shape: shape, borderRadius: borderRadius);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        return t.toString();
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.Border>(target, 'Border');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'merge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'merge');
        final a = D4.getRequiredArg<$flutter_14.Border>(positional, 0, 'a', 'merge');
        final b = D4.getRequiredArg<$flutter_14.Border>(positional, 1, 'b', 'merge');
        return $flutter_14.Border.merge(a, b);
      },
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_14.Border?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_14.Border?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_14.Border.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const Border({BorderSide top = BorderSide.none, BorderSide right = BorderSide.none, BorderSide bottom = BorderSide.none, BorderSide left = BorderSide.none})',
      'fromBorderSide': 'const Border.fromBorderSide(BorderSide side)',
      'symmetric': 'const Border.symmetric({BorderSide vertical = BorderSide.none, BorderSide horizontal = BorderSide.none})',
      'all': 'factory Border.all({Color color = const Color(0xFF000000), double width = 1.0, BorderStyle style = BorderStyle.solid, double strokeAlign = BorderSide.strokeAlignInside})',
    },
    methodSignatures: {
      'scale': 'Border scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection, BoxShape shape = BoxShape.rectangle, BorderRadius? borderRadius})',
      'toString': 'String toString()',
      'add': 'BoxBorder? add(ShapeBorder other, {bool reversed = false})',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'top': 'BorderSide get top',
      'bottom': 'BorderSide get bottom',
      'isUniform': 'bool get isUniform',
      'right': 'BorderSide get right',
      'left': 'BorderSide get left',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'merge': 'Border merge(Border a, Border b)',
      'lerp': 'Border? lerp(Border? a, Border? b, double t)',
    },
  );
}

// =============================================================================
// BorderDirectional Bridge
// =============================================================================

BridgedClass _createBorderDirectionalBridge() {
  return BridgedClass(
    nativeType: $flutter_14.BorderDirectional,
    name: 'BorderDirectional',
    constructors: {
      '': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'top', $flutter_13.BorderSide.none);
        final start = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'start', $flutter_13.BorderSide.none);
        final end = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'end', $flutter_13.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'bottom', $flutter_13.BorderSide.none);
        return $flutter_14.BorderDirectional(top: top, start: start, end: end, bottom: bottom);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').preferPaintInterior,
      'top': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').bottom,
      'isUniform': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').isUniform,
      'start': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').end,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final shape = D4.getNamedArgWithDefault<$flutter_14.BoxShape>(named, 'shape', $flutter_14.BoxShape.rectangle);
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadius?>(named, 'borderRadius');
        t.paint(canvas, rect, textDirection: textDirection, shape: shape, borderRadius: borderRadius);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        return t.toString();
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderDirectional>(target, 'BorderDirectional');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'merge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'merge');
        final a = D4.getRequiredArg<$flutter_14.BorderDirectional>(positional, 0, 'a', 'merge');
        final b = D4.getRequiredArg<$flutter_14.BorderDirectional>(positional, 1, 'b', 'merge');
        return $flutter_14.BorderDirectional.merge(a, b);
      },
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_14.BorderDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_14.BorderDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_14.BorderDirectional.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const BorderDirectional({BorderSide top = BorderSide.none, BorderSide start = BorderSide.none, BorderSide end = BorderSide.none, BorderSide bottom = BorderSide.none})',
    },
    methodSignatures: {
      'scale': 'BorderDirectional scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection, BoxShape shape = BoxShape.rectangle, BorderRadius? borderRadius})',
      'toString': 'String toString()',
      'add': 'BoxBorder? add(ShapeBorder other, {bool reversed = false})',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'top': 'BorderSide get top',
      'bottom': 'BorderSide get bottom',
      'isUniform': 'bool get isUniform',
      'start': 'BorderSide get start',
      'end': 'BorderSide get end',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'merge': 'BorderDirectional merge(BorderDirectional a, BorderDirectional b)',
      'lerp': 'BorderDirectional? lerp(BorderDirectional? a, BorderDirectional? b, double t)',
    },
  );
}

// =============================================================================
// BoxDecoration Bridge
// =============================================================================

BridgedClass _createBoxDecorationBridge() {
  return BridgedClass(
    nativeType: $flutter_15.BoxDecoration,
    name: 'BoxDecoration',
    constructors: {
      '': (visitor, positional, named) {
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final image = D4.getOptionalNamedArg<$flutter_24.DecorationImage?>(named, 'image');
        final border = D4.getOptionalNamedArg<$flutter_14.BoxBorder?>(named, 'border');
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadiusGeometry?>(named, 'borderRadius');
        final boxShadow = D4.coerceListOrNull<$flutter_17.BoxShadow>(named['boxShadow'], 'boxShadow');
        final gradient = D4.getOptionalNamedArg<$flutter_29.Gradient?>(named, 'gradient');
        final backgroundBlendMode = D4.getOptionalNamedArg<BlendMode?>(named, 'backgroundBlendMode');
        final shape = D4.getNamedArgWithDefault<$flutter_14.BoxShape>(named, 'shape', $flutter_14.BoxShape.rectangle);
        return $flutter_15.BoxDecoration(color: color, image: image, border: border, borderRadius: borderRadius, boxShadow: boxShadow, gradient: gradient, backgroundBlendMode: backgroundBlendMode, shape: shape);
      },
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').isComplex,
      'color': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').color,
      'image': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').image,
      'border': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').border,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').borderRadius,
      'boxShadow': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').boxShadow,
      'gradient': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').gradient,
      'backgroundBlendMode': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').backgroundBlendMode,
      'shape': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').shape,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        return t.debugAssertIsValid();
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(onChangedRaw == null ? null : () { D4.callInterpreterCallback(visitor, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final image = D4.getOptionalNamedArg<$flutter_24.DecorationImage?>(named, 'image');
        final border = D4.getOptionalNamedArg<$flutter_14.BoxBorder?>(named, 'border');
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadiusGeometry?>(named, 'borderRadius');
        final boxShadow = D4.coerceListOrNull<$flutter_17.BoxShadow>(named['boxShadow'], 'boxShadow');
        final gradient = D4.getOptionalNamedArg<$flutter_29.Gradient?>(named, 'gradient');
        final backgroundBlendMode = D4.getOptionalNamedArg<BlendMode?>(named, 'backgroundBlendMode');
        final shape = D4.getOptionalNamedArg<$flutter_14.BoxShape?>(named, 'shape');
        return t.copyWith(color: color, image: image, border: border, borderRadius: borderRadius, boxShadow: boxShadow, gradient: gradient, backgroundBlendMode: backgroundBlendMode, shape: shape);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BoxDecoration>(target, 'BoxDecoration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_15.BoxDecoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_15.BoxDecoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_15.BoxDecoration.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const BoxDecoration({Color? color, DecorationImage? image, BoxBorder? border, BorderRadiusGeometry? borderRadius, List<BoxShadow>? boxShadow, Gradient? gradient, BlendMode? backgroundBlendMode, BoxShape shape = BoxShape.rectangle})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback? onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'copyWith': 'BoxDecoration copyWith({Color? color, DecorationImage? image, BoxBorder? border, BorderRadiusGeometry? borderRadius, List<BoxShadow>? boxShadow, Gradient? gradient, BlendMode? backgroundBlendMode, BoxShape? shape})',
      'scale': 'BoxDecoration scale(double factor)',
    },
    getterSignatures: {
      'padding': 'EdgeInsetsGeometry get padding',
      'isComplex': 'bool get isComplex',
      'color': 'Color? get color',
      'image': 'DecorationImage? get image',
      'border': 'BoxBorder? get border',
      'borderRadius': 'BorderRadiusGeometry? get borderRadius',
      'boxShadow': 'List<BoxShadow>? get boxShadow',
      'gradient': 'Gradient? get gradient',
      'backgroundBlendMode': 'BlendMode? get backgroundBlendMode',
      'shape': 'BoxShape get shape',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'BoxDecoration? lerp(BoxDecoration? a, BoxDecoration? b, double t)',
    },
  );
}

// =============================================================================
// FittedSizes Bridge
// =============================================================================

BridgedClass _createFittedSizesBridge() {
  return BridgedClass(
    nativeType: $flutter_16.FittedSizes,
    name: 'FittedSizes',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FittedSizes');
        final source = D4.getRequiredArg<Size>(positional, 0, 'source', 'FittedSizes');
        final destination = D4.getRequiredArg<Size>(positional, 1, 'destination', 'FittedSizes');
        return $flutter_16.FittedSizes(source, destination);
      },
    },
    getters: {
      'source': (visitor, target) => D4.validateTarget<$flutter_16.FittedSizes>(target, 'FittedSizes').source,
      'destination': (visitor, target) => D4.validateTarget<$flutter_16.FittedSizes>(target, 'FittedSizes').destination,
    },
    constructorSignatures: {
      '': 'const FittedSizes(Size source, Size destination)',
    },
    getterSignatures: {
      'source': 'Size get source',
      'destination': 'Size get destination',
    },
  );
}

// =============================================================================
// BoxShadow Bridge
// =============================================================================

BridgedClass _createBoxShadowBridge() {
  return BridgedClass(
    nativeType: $flutter_17.BoxShadow,
    name: 'BoxShadow',
    constructors: {
      '': (visitor, positional, named) {
        final offset = D4.getNamedArgWithDefault<Offset>(named, 'offset', Offset.zero);
        final blurRadius = D4.getNamedArgWithDefault<double>(named, 'blurRadius', 0.0);
        final spreadRadius = D4.getNamedArgWithDefault<double>(named, 'spreadRadius', 0.0);
        final blurStyle = D4.getNamedArgWithDefault<BlurStyle>(named, 'blurStyle', BlurStyle.normal);
        if (!named.containsKey('color')) {
          return $flutter_17.BoxShadow(offset: offset, blurRadius: blurRadius, spreadRadius: spreadRadius, blurStyle: blurStyle);
        }
        if (named.containsKey('color')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxShadow');
          return $flutter_17.BoxShadow(offset: offset, blurRadius: blurRadius, spreadRadius: spreadRadius, blurStyle: blurStyle, color: color);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'spreadRadius': (visitor, target) => D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow').spreadRadius,
      'blurStyle': (visitor, target) => D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow').blurStyle,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow').hashCode,
      'color': (visitor, target) => D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow').color,
      'offset': (visitor, target) => D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow').offset,
      'blurRadius': (visitor, target) => D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow').blurRadius,
      'blurSigma': (visitor, target) => D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow').blurSigma,
    },
    methods: {
      'toPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow');
        return t.toPaint();
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final offset = D4.getOptionalNamedArg<Offset?>(named, 'offset');
        final blurRadius = D4.getOptionalNamedArg<double?>(named, 'blurRadius');
        final spreadRadius = D4.getOptionalNamedArg<double?>(named, 'spreadRadius');
        final blurStyle = D4.getOptionalNamedArg<BlurStyle?>(named, 'blurStyle');
        return t.copyWith(color: color, offset: offset, blurRadius: blurRadius, spreadRadius: spreadRadius, blurStyle: blurStyle);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxShadow>(target, 'BoxShadow');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_17.BoxShadow?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_17.BoxShadow?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_17.BoxShadow.lerp(a, b, t_);
      },
      'lerpList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpList');
        if (positional.isEmpty) {
          throw ArgumentError('lerpList: Missing required argument "a" at position 0');
        }
        final a = D4.coerceListOrNull<$flutter_17.BoxShadow>(positional[0], 'a');
        if (positional.length <= 1) {
          throw ArgumentError('lerpList: Missing required argument "b" at position 1');
        }
        final b = D4.coerceListOrNull<$flutter_17.BoxShadow>(positional[1], 'b');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerpList');
        return $flutter_17.BoxShadow.lerpList(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const BoxShadow({Color color = const Color(_kColorDefault), Offset offset = Offset.zero, double blurRadius = 0.0, double spreadRadius = 0.0, BlurStyle blurStyle = BlurStyle.normal})',
    },
    methodSignatures: {
      'toPaint': 'Paint toPaint()',
      'scale': 'BoxShadow scale(double factor)',
      'copyWith': 'BoxShadow copyWith({Color? color, Offset? offset, double? blurRadius, double? spreadRadius, BlurStyle? blurStyle})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'spreadRadius': 'double get spreadRadius',
      'blurStyle': 'BlurStyle get blurStyle',
      'hashCode': 'int get hashCode',
      'color': 'Color get color',
      'offset': 'Offset get offset',
      'blurRadius': 'double get blurRadius',
      'blurSigma': 'double get blurSigma',
    },
    staticMethodSignatures: {
      'lerp': 'BoxShadow? lerp(BoxShadow? a, BoxShadow? b, double t)',
      'lerpList': 'List<BoxShadow>? lerpList(List<BoxShadow>? a, List<BoxShadow>? b, double t)',
    },
  );
}

// =============================================================================
// CircleBorder Bridge
// =============================================================================

BridgedClass _createCircleBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_18.CircleBorder,
    name: 'CircleBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final eccentricity = D4.getNamedArgWithDefault<double>(named, 'eccentricity', 0.0);
        return $flutter_18.CircleBorder(side: side, eccentricity: eccentricity);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder').side,
      'eccentricity': (visitor, target) => D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder').eccentricity,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final eccentricity = D4.getOptionalNamedArg<double?>(named, 'eccentricity');
        return t.copyWith(side: side, eccentricity: eccentricity);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.CircleBorder>(target, 'CircleBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const CircleBorder({BorderSide side = BorderSide.none, double eccentricity = 0.0})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'CircleBorder copyWith({BorderSide? side, double? eccentricity})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'eccentricity': 'double get eccentricity',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ClipContext Bridge
// =============================================================================

BridgedClass _createClipContextBridge() {
  return BridgedClass(
    nativeType: $flutter_19.ClipContext,
    name: 'ClipContext',
    constructors: {
    },
    getters: {
      'canvas': (visitor, target) => D4.validateTarget<$flutter_19.ClipContext>(target, 'ClipContext').canvas,
    },
    methods: {
      'clipPathAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipPathAndPaint');
        final path = D4.getRequiredArg<Path>(positional, 0, 'path', 'clipPathAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipPathAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipPathAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipPathAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipPathAndPaint(path, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor, painterRaw, []); });
        return null;
      },
      'clipRRectAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipRRectAndPaint');
        final rrect = D4.getRequiredArg<RRect>(positional, 0, 'rrect', 'clipRRectAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipRRectAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipRRectAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipRRectAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipRRectAndPaint(rrect, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor, painterRaw, []); });
        return null;
      },
      'clipRSuperellipseAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipRSuperellipseAndPaint');
        final rse = D4.getRequiredArg<RSuperellipse>(positional, 0, 'rse', 'clipRSuperellipseAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipRSuperellipseAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipRSuperellipseAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipRSuperellipseAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipRSuperellipseAndPaint(rse, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor, painterRaw, []); });
        return null;
      },
      'clipRectAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipRectAndPaint');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'clipRectAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipRectAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipRectAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipRectAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipRectAndPaint(rect, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor, painterRaw, []); });
        return null;
      },
    },
    methodSignatures: {
      'clipPathAndPaint': 'void clipPathAndPaint(Path path, Clip clipBehavior, Rect bounds, VoidCallback painter)',
      'clipRRectAndPaint': 'void clipRRectAndPaint(RRect rrect, Clip clipBehavior, Rect bounds, VoidCallback painter)',
      'clipRSuperellipseAndPaint': 'void clipRSuperellipseAndPaint(RSuperellipse rse, Clip clipBehavior, Rect bounds, VoidCallback painter)',
      'clipRectAndPaint': 'void clipRectAndPaint(Rect rect, Clip clipBehavior, Rect bounds, VoidCallback painter)',
    },
    getterSignatures: {
      'canvas': 'Canvas get canvas',
    },
  );
}

// =============================================================================
// HSVColor Bridge
// =============================================================================

BridgedClass _createHSVColorBridge() {
  return BridgedClass(
    nativeType: $flutter_20.HSVColor,
    name: 'HSVColor',
    constructors: {
      'fromAHSV': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'HSVColor');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'HSVColor');
        final hue = D4.getRequiredArg<double>(positional, 1, 'hue', 'HSVColor');
        final saturation = D4.getRequiredArg<double>(positional, 2, 'saturation', 'HSVColor');
        final value = D4.getRequiredArg<double>(positional, 3, 'value', 'HSVColor');
        return $flutter_20.HSVColor.fromAHSV(alpha, hue, saturation, value);
      },
      'fromColor': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HSVColor');
        final color = D4.getRequiredArg<Color>(positional, 0, 'color', 'HSVColor');
        return $flutter_20.HSVColor.fromColor(color);
      },
    },
    getters: {
      'alpha': (visitor, target) => D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor').alpha,
      'hue': (visitor, target) => D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor').hue,
      'saturation': (visitor, target) => D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor').saturation,
      'value': (visitor, target) => D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor').value,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor').hashCode,
    },
    methods: {
      'withAlpha': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withAlpha');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'withAlpha');
        return t.withAlpha(alpha);
      },
      'withHue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withHue');
        final hue = D4.getRequiredArg<double>(positional, 0, 'hue', 'withHue');
        return t.withHue(hue);
      },
      'withSaturation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withSaturation');
        final saturation = D4.getRequiredArg<double>(positional, 0, 'saturation', 'withSaturation');
        return t.withSaturation(saturation);
      },
      'withValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withValue');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'withValue');
        return t.withValue(value);
      },
      'toColor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor');
        return t.toColor();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSVColor>(target, 'HSVColor');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_20.HSVColor?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_20.HSVColor?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_20.HSVColor.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromAHSV': 'const HSVColor.fromAHSV(double alpha, double hue, double saturation, double value)',
      'fromColor': 'factory HSVColor.fromColor(Color color)',
    },
    methodSignatures: {
      'withAlpha': 'HSVColor withAlpha(double alpha)',
      'withHue': 'HSVColor withHue(double hue)',
      'withSaturation': 'HSVColor withSaturation(double saturation)',
      'withValue': 'HSVColor withValue(double value)',
      'toColor': 'Color toColor()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'alpha': 'double get alpha',
      'hue': 'double get hue',
      'saturation': 'double get saturation',
      'value': 'double get value',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'HSVColor? lerp(HSVColor? a, HSVColor? b, double t)',
    },
  );
}

// =============================================================================
// HSLColor Bridge
// =============================================================================

BridgedClass _createHSLColorBridge() {
  return BridgedClass(
    nativeType: $flutter_20.HSLColor,
    name: 'HSLColor',
    constructors: {
      'fromAHSL': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'HSLColor');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'HSLColor');
        final hue = D4.getRequiredArg<double>(positional, 1, 'hue', 'HSLColor');
        final saturation = D4.getRequiredArg<double>(positional, 2, 'saturation', 'HSLColor');
        final lightness = D4.getRequiredArg<double>(positional, 3, 'lightness', 'HSLColor');
        return $flutter_20.HSLColor.fromAHSL(alpha, hue, saturation, lightness);
      },
      'fromColor': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HSLColor');
        final color = D4.getRequiredArg<Color>(positional, 0, 'color', 'HSLColor');
        return $flutter_20.HSLColor.fromColor(color);
      },
    },
    getters: {
      'alpha': (visitor, target) => D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor').alpha,
      'hue': (visitor, target) => D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor').hue,
      'saturation': (visitor, target) => D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor').saturation,
      'lightness': (visitor, target) => D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor').lightness,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor').hashCode,
    },
    methods: {
      'withAlpha': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withAlpha');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'withAlpha');
        return t.withAlpha(alpha);
      },
      'withHue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withHue');
        final hue = D4.getRequiredArg<double>(positional, 0, 'hue', 'withHue');
        return t.withHue(hue);
      },
      'withSaturation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withSaturation');
        final saturation = D4.getRequiredArg<double>(positional, 0, 'saturation', 'withSaturation');
        return t.withSaturation(saturation);
      },
      'withLightness': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withLightness');
        final lightness = D4.getRequiredArg<double>(positional, 0, 'lightness', 'withLightness');
        return t.withLightness(lightness);
      },
      'toColor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor');
        return t.toColor();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HSLColor>(target, 'HSLColor');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_20.HSLColor?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_20.HSLColor?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_20.HSLColor.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromAHSL': 'const HSLColor.fromAHSL(double alpha, double hue, double saturation, double lightness)',
      'fromColor': 'factory HSLColor.fromColor(Color color)',
    },
    methodSignatures: {
      'withAlpha': 'HSLColor withAlpha(double alpha)',
      'withHue': 'HSLColor withHue(double hue)',
      'withSaturation': 'HSLColor withSaturation(double saturation)',
      'withLightness': 'HSLColor withLightness(double lightness)',
      'toColor': 'Color toColor()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'alpha': 'double get alpha',
      'hue': 'double get hue',
      'saturation': 'double get saturation',
      'lightness': 'double get lightness',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'HSLColor? lerp(HSLColor? a, HSLColor? b, double t)',
    },
  );
}

// =============================================================================
// ColorSwatch Bridge
// =============================================================================

BridgedClass _createColorSwatchBridge() {
  return BridgedClass(
    nativeType: $flutter_20.ColorSwatch,
    name: 'ColorSwatch',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColorSwatch');
        final primary = D4.getRequiredArg<int>(positional, 0, 'primary', 'ColorSwatch');
        if (positional.length <= 1) {
          throw ArgumentError('ColorSwatch: Missing required argument "_swatch" at position 1');
        }
        final swatch = D4.coerceMap<dynamic, Color>(positional[1], '_swatch');
        return $flutter_20.ColorSwatch(primary, swatch);
      },
    },
    getters: {
      'keys': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').keys,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').hashCode,
      'a': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').a,
      'r': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').r,
      'g': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').g,
      'b': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').b,
      'colorSpace': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').colorSpace,
      'value': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').value,
      'alpha': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').alpha,
      'opacity': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').opacity,
      'red': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').red,
      'green': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').green,
      'blue': (visitor, target) => D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch').blue,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        return t.toString();
      },
      'toARGB32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        return t.toARGB32();
      },
      'withValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        final alpha = D4.getOptionalNamedArg<double?>(named, 'alpha');
        final red = D4.getOptionalNamedArg<double?>(named, 'red');
        final green = D4.getOptionalNamedArg<double?>(named, 'green');
        final blue = D4.getOptionalNamedArg<double?>(named, 'blue');
        final colorSpace = D4.getOptionalNamedArg<ColorSpace?>(named, 'colorSpace');
        return t.withValues(alpha: alpha, red: red, green: green, blue: blue, colorSpace: colorSpace);
      },
      'withAlpha': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withAlpha');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'withAlpha');
        return t.withAlpha(a);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'withRed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withRed');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'withRed');
        return t.withRed(r);
      },
      'withGreen': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withGreen');
        final g = D4.getRequiredArg<int>(positional, 0, 'g', 'withGreen');
        return t.withGreen(g);
      },
      'withBlue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withBlue');
        final b = D4.getRequiredArg<int>(positional, 0, 'b', 'withBlue');
        return t.withBlue(b);
      },
      'computeLuminance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        return t.computeLuminance();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorSwatch>(target, 'ColorSwatch');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_20.ColorSwatch<dynamic>?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_20.ColorSwatch<dynamic>?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_20.ColorSwatch.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const ColorSwatch(int primary, Map<T, Color> _swatch)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'toARGB32': 'int toARGB32()',
      'withValues': 'Color withValues({double? alpha, double? red, double? green, double? blue, ColorSpace? colorSpace})',
      'withAlpha': 'Color withAlpha(int a)',
      'withOpacity': 'Color withOpacity(double opacity)',
      'withRed': 'Color withRed(int r)',
      'withGreen': 'Color withGreen(int g)',
      'withBlue': 'Color withBlue(int b)',
      'computeLuminance': 'double computeLuminance()',
    },
    getterSignatures: {
      'keys': 'Iterable<T> get keys',
      'hashCode': 'int get hashCode',
      'a': 'double get a',
      'r': 'double get r',
      'g': 'double get g',
      'b': 'double get b',
      'colorSpace': 'ColorSpace get colorSpace',
      'value': 'int get value',
      'alpha': 'int get alpha',
      'opacity': 'double get opacity',
      'red': 'int get red',
      'green': 'int get green',
      'blue': 'int get blue',
    },
    staticMethodSignatures: {
      'lerp': 'ColorSwatch<T>? lerp(ColorSwatch<T>? a, ColorSwatch<T>? b, double t)',
    },
  );
}

// =============================================================================
// ColorProperty Bridge
// =============================================================================

BridgedClass _createColorPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_20.ColorProperty,
    name: 'ColorProperty',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColorProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ColorProperty');
        final value = D4.getRequiredArg<Color?>(positional, 1, 'value', 'ColorProperty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final style = D4.getNamedArgWithDefault<$flutter_3.DiagnosticsTreeStyle>(named, 'style', $flutter_3.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'level', $flutter_3.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_20.ColorProperty(name, value, showName: showName, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'ColorProperty');
          return $flutter_20.ColorProperty(name, value, showName: showName, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty').allowTruncate,
    },
    methods: {
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_3.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.ColorProperty>(target, 'ColorProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'ColorProperty(String name, Color? value, {bool showName = true, Object? defaultValue = kNoDefaultValue, DiagnosticsTreeStyle style = DiagnosticsTreeStyle.singleLine, DiagnosticLevel level = DiagnosticLevel.info})',
    },
    methodSignatures: {
      'toJsonMap': 'Map<String, Object?> toJsonMap(DiagnosticsSerializationDelegate delegate)',
      'valueToString': 'String valueToString({TextTreeConfiguration? parentConfiguration})',
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
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'value': 'Color get value',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
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
// ContinuousRectangleBorder Bridge
// =============================================================================

BridgedClass _createContinuousRectangleBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_21.ContinuousRectangleBorder,
    name: 'ContinuousRectangleBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final borderRadius = D4.getNamedArgWithDefault<$flutter_12.BorderRadiusGeometry>(named, 'borderRadius', $flutter_12.BorderRadius.zero);
        return $flutter_21.ContinuousRectangleBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ContinuousRectangleBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry borderRadius = BorderRadius.zero})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'ContinuousRectangleBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'borderRadius': 'BorderRadiusGeometry get borderRadius',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImageSizeInfo Bridge
// =============================================================================

BridgedClass _createImageSizeInfoBridge() {
  return BridgedClass(
    nativeType: $flutter_22.ImageSizeInfo,
    name: 'ImageSizeInfo',
    constructors: {
      '': (visitor, positional, named) {
        final source = D4.getOptionalNamedArg<String?>(named, 'source');
        final displaySize = D4.getRequiredNamedArg<Size>(named, 'displaySize', 'ImageSizeInfo');
        final imageSize = D4.getRequiredNamedArg<Size>(named, 'imageSize', 'ImageSizeInfo');
        return $flutter_22.ImageSizeInfo(source: source, displaySize: displaySize, imageSize: imageSize);
      },
    },
    getters: {
      'source': (visitor, target) => D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo').source,
      'displaySize': (visitor, target) => D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo').displaySize,
      'imageSize': (visitor, target) => D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo').imageSize,
      'displaySizeInBytes': (visitor, target) => D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo').displaySizeInBytes,
      'decodedSizeInBytes': (visitor, target) => D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo').decodedSizeInBytes,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo').hashCode,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ImageSizeInfo>(target, 'ImageSizeInfo');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ImageSizeInfo({String? source, required Size displaySize, required Size imageSize})',
    },
    methodSignatures: {
      'toJson': 'Map<String, Object?> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'source': 'String? get source',
      'displaySize': 'Size get displaySize',
      'imageSize': 'Size get imageSize',
      'displaySizeInBytes': 'int get displaySizeInBytes',
      'decodedSizeInBytes': 'int get decodedSizeInBytes',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Decoration Bridge
// =============================================================================

BridgedClass _createDecorationBridge() {
  return BridgedClass(
    nativeType: $flutter_23.Decoration,
    name: 'Decoration',
    constructors: {
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration').isComplex,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration');
        return t.debugAssertIsValid();
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(() { D4.callInterpreterCallback(visitor, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.Decoration>(target, 'Decoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_23.Decoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_23.Decoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_23.Decoration.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'padding': 'EdgeInsetsGeometry get padding',
      'isComplex': 'bool get isComplex',
    },
    staticMethodSignatures: {
      'lerp': 'Decoration? lerp(Decoration? a, Decoration? b, double t)',
    },
  );
}

// =============================================================================
// BoxPainter Bridge
// =============================================================================

BridgedClass _createBoxPainterBridge() {
  return BridgedClass(
    nativeType: $flutter_23.BoxPainter,
    name: 'BoxPainter',
    constructors: {
    },
    getters: {
      'onChanged': (visitor, target) => D4.validateTarget<$flutter_23.BoxPainter>(target, 'BoxPainter').onChanged,
    },
    methods: {
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.BoxPainter>(target, 'BoxPainter');
        D4.requireMinArgs(positional, 3, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final offset = D4.getRequiredArg<Offset>(positional, 1, 'offset', 'paint');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 2, 'configuration', 'paint');
        t.paint(canvas, offset, configuration);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.BoxPainter>(target, 'BoxPainter');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'paint': 'void paint(Canvas canvas, Offset offset, ImageConfiguration configuration)',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'onChanged': 'VoidCallback? get onChanged',
    },
  );
}

// =============================================================================
// DecorationImage Bridge
// =============================================================================

BridgedClass _createDecorationImageBridge() {
  return BridgedClass(
    nativeType: $flutter_24.DecorationImage,
    name: 'DecorationImage',
    constructors: {
      '': (visitor, positional, named) {
        final image = D4.getRequiredNamedArg<$flutter_32.ImageProvider<Object>>(named, 'image', 'DecorationImage');
        final onErrorRaw = named['onError'];
        final colorFilter = D4.getOptionalNamedArg<ColorFilter?>(named, 'colorFilter');
        final fit = D4.getOptionalNamedArg<$flutter_16.BoxFit?>(named, 'fit');
        final alignment = D4.getNamedArgWithDefault<$flutter_8.AlignmentGeometry>(named, 'alignment', $flutter_8.Alignment.center);
        final centerSlice = D4.getOptionalNamedArg<Rect?>(named, 'centerSlice');
        final repeat = D4.getNamedArgWithDefault<$flutter_24.ImageRepeat>(named, 'repeat', $flutter_24.ImageRepeat.noRepeat);
        final matchTextDirection = D4.getNamedArgWithDefault<bool>(named, 'matchTextDirection', false);
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final opacity = D4.getNamedArgWithDefault<double>(named, 'opacity', 1.0);
        final filterQuality = D4.getNamedArgWithDefault<FilterQuality>(named, 'filterQuality', FilterQuality.medium);
        final invertColors = D4.getNamedArgWithDefault<bool>(named, 'invertColors', false);
        final isAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'isAntiAlias', false);
        return $flutter_24.DecorationImage(image: image, onError: onErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); }, colorFilter: colorFilter, fit: fit, alignment: alignment, centerSlice: centerSlice, repeat: repeat, matchTextDirection: matchTextDirection, scale: scale, opacity: opacity, filterQuality: filterQuality, invertColors: invertColors, isAntiAlias: isAntiAlias);
      },
    },
    getters: {
      'image': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').image,
      'onError': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').onError,
      'colorFilter': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').colorFilter,
      'fit': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').fit,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').alignment,
      'centerSlice': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').centerSlice,
      'repeat': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').repeat,
      'matchTextDirection': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').matchTextDirection,
      'scale': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').scale,
      'opacity': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').opacity,
      'filterQuality': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').filterQuality,
      'invertColors': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').invertColors,
      'isAntiAlias': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').isAntiAlias,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage').hashCode,
    },
    methods: {
      'createPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage');
        D4.requireMinArgs(positional, 1, 'createPainter');
        if (positional.isEmpty) {
          throw ArgumentError('createPainter: Missing required argument "onChanged" at position 0');
        }
        final onChangedRaw = positional[0];
        return t.createPainter(() { D4.callInterpreterCallback(visitor, onChangedRaw, []); });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.DecorationImage>(target, 'DecorationImage');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_24.DecorationImage?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_24.DecorationImage?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_24.DecorationImage.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const DecorationImage({required ImageProvider<Object> image, void Function(Object, StackTrace?)? onError, ColorFilter? colorFilter, BoxFit? fit, AlignmentGeometry alignment = Alignment.center, Rect? centerSlice, ImageRepeat repeat = ImageRepeat.noRepeat, bool matchTextDirection = false, double scale = 1.0, double opacity = 1.0, FilterQuality filterQuality = FilterQuality.medium, bool invertColors = false, bool isAntiAlias = false})',
    },
    methodSignatures: {
      'createPainter': 'DecorationImagePainter createPainter(VoidCallback onChanged)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'image': 'ImageProvider get image',
      'onError': 'ImageErrorListener? get onError',
      'colorFilter': 'ColorFilter? get colorFilter',
      'fit': 'BoxFit? get fit',
      'alignment': 'AlignmentGeometry get alignment',
      'centerSlice': 'Rect? get centerSlice',
      'repeat': 'ImageRepeat get repeat',
      'matchTextDirection': 'bool get matchTextDirection',
      'scale': 'double get scale',
      'opacity': 'double get opacity',
      'filterQuality': 'FilterQuality get filterQuality',
      'invertColors': 'bool get invertColors',
      'isAntiAlias': 'bool get isAntiAlias',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'DecorationImage? lerp(DecorationImage? a, DecorationImage? b, double t)',
    },
  );
}

// =============================================================================
// DecorationImagePainter Bridge
// =============================================================================

BridgedClass _createDecorationImagePainterBridge() {
  return BridgedClass(
    nativeType: $flutter_24.DecorationImagePainter,
    name: 'DecorationImagePainter',
    constructors: {
    },
    methods: {
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.DecorationImagePainter>(target, 'DecorationImagePainter');
        D4.requireMinArgs(positional, 4, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final clipPath = D4.getRequiredArg<Path?>(positional, 2, 'clipPath', 'paint');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 3, 'configuration', 'paint');
        final blend = D4.getNamedArgWithDefault<double>(named, 'blend', 1.0);
        final blendMode = D4.getNamedArgWithDefault<BlendMode>(named, 'blendMode', BlendMode.srcOver);
        t.paint(canvas, rect, clipPath, configuration, blend: blend, blendMode: blendMode);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.DecorationImagePainter>(target, 'DecorationImagePainter');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'paint': 'void paint(Canvas canvas, Rect rect, Path? clipPath, ImageConfiguration configuration, {double blend = 1.0, BlendMode blendMode = BlendMode.srcOver})',
      'dispose': 'void dispose()',
    },
  );
}

// =============================================================================
// EdgeInsetsGeometry Bridge
// =============================================================================

BridgedClass _createEdgeInsetsGeometryBridge() {
  return BridgedClass(
    nativeType: $flutter_25.EdgeInsetsGeometry,
    name: 'EdgeInsetsGeometry',
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EdgeInsetsGeometry');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'EdgeInsetsGeometry');
        return $flutter_25.EdgeInsetsGeometry.all(value);
      },
      'only': (visitor, positional, named) {
        final left = D4.getRequiredNamedArgTodoDefault<double>(named, 'left', 'EdgeInsetsGeometry', '<default unavailable>');
        final right = D4.getRequiredNamedArgTodoDefault<double>(named, 'right', 'EdgeInsetsGeometry', '<default unavailable>');
        final top = D4.getRequiredNamedArgTodoDefault<double>(named, 'top', 'EdgeInsetsGeometry', '<default unavailable>');
        final bottom = D4.getRequiredNamedArgTodoDefault<double>(named, 'bottom', 'EdgeInsetsGeometry', '<default unavailable>');
        return $flutter_25.EdgeInsetsGeometry.only(left: left, right: right, top: top, bottom: bottom);
      },
      'directional': (visitor, positional, named) {
        final start = D4.getRequiredNamedArgTodoDefault<double>(named, 'start', 'EdgeInsetsGeometry', '<default unavailable>');
        final end = D4.getRequiredNamedArgTodoDefault<double>(named, 'end', 'EdgeInsetsGeometry', '<default unavailable>');
        final top = D4.getRequiredNamedArgTodoDefault<double>(named, 'top', 'EdgeInsetsGeometry', '<default unavailable>');
        final bottom = D4.getRequiredNamedArgTodoDefault<double>(named, 'bottom', 'EdgeInsetsGeometry', '<default unavailable>');
        return $flutter_25.EdgeInsetsGeometry.directional(start: start, end: end, top: top, bottom: bottom);
      },
      'symmetric': (visitor, positional, named) {
        final vertical = D4.getRequiredNamedArgTodoDefault<double>(named, 'vertical', 'EdgeInsetsGeometry', '<default unavailable>');
        final horizontal = D4.getRequiredNamedArgTodoDefault<double>(named, 'horizontal', 'EdgeInsetsGeometry', '<default unavailable>');
        return $flutter_25.EdgeInsetsGeometry.symmetric(vertical: vertical, horizontal: horizontal);
      },
      'fromLTRB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsetsGeometry');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'EdgeInsetsGeometry');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsetsGeometry');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'EdgeInsetsGeometry');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsetsGeometry');
        return $flutter_25.EdgeInsetsGeometry.fromLTRB(left, top, right, bottom);
      },
      'fromViewPadding': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EdgeInsetsGeometry');
        final padding = D4.getRequiredArg<ViewPadding>(positional, 0, 'padding', 'EdgeInsetsGeometry');
        final devicePixelRatio = D4.getRequiredArg<double>(positional, 1, 'devicePixelRatio', 'EdgeInsetsGeometry');
        return $flutter_25.EdgeInsetsGeometry.fromViewPadding(padding, devicePixelRatio);
      },
      'fromSTEB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsetsGeometry');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'EdgeInsetsGeometry');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsetsGeometry');
        final end = D4.getRequiredArg<double>(positional, 2, 'end', 'EdgeInsetsGeometry');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsetsGeometry');
        return $flutter_25.EdgeInsetsGeometry.fromSTEB(start, top, end, bottom);
      },
    },
    getters: {
      'isNonNegative': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').isNonNegative,
      'horizontal': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').horizontal,
      'vertical': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').vertical,
      'collapsedSize': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').collapsedSize,
      'flipped': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').flipped,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').hashCode,
    },
    methods: {
      'along': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'along');
        final axis = D4.getRequiredArg<$flutter_9.Axis>(positional, 0, 'axis', 'along');
        return t.along(axis);
      },
      'inflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'inflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inflateSize');
        return t.inflateSize(size);
      },
      'deflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'deflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'deflateSize');
        return t.deflateSize(size);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 1, 'max', 'clamp');
        return t.clamp(min, max);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        return -t;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_25.EdgeInsetsGeometry.zero,
      'infinity': (visitor) => $flutter_25.EdgeInsetsGeometry.infinity,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_25.EdgeInsetsGeometry.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'all': 'const factory EdgeInsetsGeometry.all(double value)',
      'only': 'const factory EdgeInsetsGeometry.only({double left, double right, double top, double bottom})',
      'directional': 'const factory EdgeInsetsGeometry.directional({double start, double end, double top, double bottom})',
      'symmetric': 'const factory EdgeInsetsGeometry.symmetric({double vertical, double horizontal})',
      'fromLTRB': 'const factory EdgeInsetsGeometry.fromLTRB(double left, double top, double right, double bottom)',
      'fromViewPadding': 'factory EdgeInsetsGeometry.fromViewPadding(ui.ViewPadding padding, double devicePixelRatio)',
      'fromSTEB': 'const factory EdgeInsetsGeometry.fromSTEB(double start, double top, double end, double bottom)',
    },
    methodSignatures: {
      'along': 'double along(Axis axis)',
      'inflateSize': 'Size inflateSize(Size size)',
      'deflateSize': 'Size deflateSize(Size size)',
      'subtract': 'EdgeInsetsGeometry subtract(EdgeInsetsGeometry other)',
      'add': 'EdgeInsetsGeometry add(EdgeInsetsGeometry other)',
      'clamp': 'EdgeInsetsGeometry clamp(EdgeInsetsGeometry min, EdgeInsetsGeometry max)',
      'resolve': 'EdgeInsets resolve(TextDirection? direction)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isNonNegative': 'bool get isNonNegative',
      'horizontal': 'double get horizontal',
      'vertical': 'double get vertical',
      'collapsedSize': 'Size get collapsedSize',
      'flipped': 'EdgeInsetsGeometry get flipped',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'EdgeInsetsGeometry? lerp(EdgeInsetsGeometry? a, EdgeInsetsGeometry? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'EdgeInsetsGeometry get zero',
      'infinity': 'EdgeInsetsGeometry get infinity',
    },
  );
}

// =============================================================================
// EdgeInsets Bridge
// =============================================================================

BridgedClass _createEdgeInsetsBridge() {
  return BridgedClass(
    nativeType: $flutter_25.EdgeInsets,
    name: 'EdgeInsets',
    constructors: {
      'fromLTRB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsets');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'EdgeInsets');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsets');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'EdgeInsets');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsets');
        return $flutter_25.EdgeInsets.fromLTRB(left, top, right, bottom);
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EdgeInsets');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'EdgeInsets');
        return $flutter_25.EdgeInsets.all(value);
      },
      'only': (visitor, positional, named) {
        final left = D4.getNamedArgWithDefault<double>(named, 'left', 0.0);
        final top = D4.getNamedArgWithDefault<double>(named, 'top', 0.0);
        final right = D4.getNamedArgWithDefault<double>(named, 'right', 0.0);
        final bottom = D4.getNamedArgWithDefault<double>(named, 'bottom', 0.0);
        return $flutter_25.EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
      },
      'symmetric': (visitor, positional, named) {
        final vertical = D4.getNamedArgWithDefault<double>(named, 'vertical', 0.0);
        final horizontal = D4.getNamedArgWithDefault<double>(named, 'horizontal', 0.0);
        return $flutter_25.EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
      },
      'fromViewPadding': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EdgeInsets');
        final padding = D4.getRequiredArg<ViewPadding>(positional, 0, 'padding', 'EdgeInsets');
        final devicePixelRatio = D4.getRequiredArg<double>(positional, 1, 'devicePixelRatio', 'EdgeInsets');
        return $flutter_25.EdgeInsets.fromViewPadding(padding, devicePixelRatio);
      },
      'fromWindowPadding': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EdgeInsets');
        final padding = D4.getRequiredArg<ViewPadding>(positional, 0, 'padding', 'EdgeInsets');
        final devicePixelRatio = D4.getRequiredArg<double>(positional, 1, 'devicePixelRatio', 'EdgeInsets');
        return $flutter_25.EdgeInsets.fromWindowPadding(padding, devicePixelRatio);
      },
    },
    getters: {
      'isNonNegative': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').isNonNegative,
      'horizontal': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').horizontal,
      'vertical': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').vertical,
      'collapsedSize': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').collapsedSize,
      'flipped': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').flipped,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').hashCode,
      'left': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').left,
      'top': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').top,
      'right': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').right,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').bottom,
      'topLeft': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').topLeft,
      'topRight': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').topRight,
      'bottomLeft': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').bottomLeft,
      'bottomRight': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets').bottomRight,
    },
    methods: {
      'along': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'along');
        final axis = D4.getRequiredArg<$flutter_9.Axis>(positional, 0, 'axis', 'along');
        return t.along(axis);
      },
      'inflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'inflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inflateSize');
        return t.inflateSize(size);
      },
      'deflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'deflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'deflateSize');
        return t.deflateSize(size);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 1, 'max', 'clamp');
        return t.clamp(min, max);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        return t.toString();
      },
      'inflateRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'inflateRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'inflateRect');
        return t.inflateRect(rect);
      },
      'deflateRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'deflateRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'deflateRect');
        return t.deflateRect(rect);
      },
      'inflateRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'inflateRRect');
        final rect = D4.getRequiredArg<RRect>(positional, 0, 'rect', 'inflateRRect');
        return t.inflateRRect(rect);
      },
      'deflateRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'deflateRRect');
        final rect = D4.getRequiredArg<RRect>(positional, 0, 'rect', 'deflateRRect');
        return t.deflateRRect(rect);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        final left = D4.getOptionalNamedArg<double?>(named, 'left');
        final top = D4.getOptionalNamedArg<double?>(named, 'top');
        final right = D4.getOptionalNamedArg<double?>(named, 'right');
        final bottom = D4.getOptionalNamedArg<double?>(named, 'bottom');
        return t.copyWith(left: left, top: top, right: right, bottom: bottom);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_25.EdgeInsets>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsets>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_25.EdgeInsets.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_25.EdgeInsets?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_25.EdgeInsets?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_25.EdgeInsets.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromLTRB': 'const EdgeInsets.fromLTRB(double left, double top, double right, double bottom)',
      'all': 'const EdgeInsets.all(double value)',
      'only': 'const EdgeInsets.only({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0})',
      'symmetric': 'const EdgeInsets.symmetric({double vertical = 0.0, double horizontal = 0.0})',
      'fromViewPadding': 'EdgeInsets.fromViewPadding(ui.ViewPadding padding, double devicePixelRatio)',
      'fromWindowPadding': 'factory EdgeInsets.fromWindowPadding(ui.ViewPadding padding, double devicePixelRatio)',
    },
    methodSignatures: {
      'along': 'double along(Axis axis)',
      'inflateSize': 'Size inflateSize(Size size)',
      'deflateSize': 'Size deflateSize(Size size)',
      'subtract': 'EdgeInsetsGeometry subtract(EdgeInsetsGeometry other)',
      'add': 'EdgeInsetsGeometry add(EdgeInsetsGeometry other)',
      'clamp': 'EdgeInsetsGeometry clamp(EdgeInsetsGeometry min, EdgeInsetsGeometry max)',
      'resolve': 'EdgeInsets resolve(TextDirection? direction)',
      'toString': 'String toString()',
      'inflateRect': 'Rect inflateRect(Rect rect)',
      'deflateRect': 'Rect deflateRect(Rect rect)',
      'inflateRRect': 'RRect inflateRRect(RRect rect)',
      'deflateRRect': 'RRect deflateRRect(RRect rect)',
      'copyWith': 'EdgeInsets copyWith({double? left, double? top, double? right, double? bottom})',
    },
    getterSignatures: {
      'isNonNegative': 'bool get isNonNegative',
      'horizontal': 'double get horizontal',
      'vertical': 'double get vertical',
      'collapsedSize': 'Size get collapsedSize',
      'flipped': 'EdgeInsets get flipped',
      'hashCode': 'int get hashCode',
      'left': 'double get left',
      'top': 'double get top',
      'right': 'double get right',
      'bottom': 'double get bottom',
      'topLeft': 'Offset get topLeft',
      'topRight': 'Offset get topRight',
      'bottomLeft': 'Offset get bottomLeft',
      'bottomRight': 'Offset get bottomRight',
    },
    staticMethodSignatures: {
      'lerp': 'EdgeInsets? lerp(EdgeInsets? a, EdgeInsets? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'EdgeInsets get zero',
    },
  );
}

// =============================================================================
// EdgeInsetsDirectional Bridge
// =============================================================================

BridgedClass _createEdgeInsetsDirectionalBridge() {
  return BridgedClass(
    nativeType: $flutter_25.EdgeInsetsDirectional,
    name: 'EdgeInsetsDirectional',
    constructors: {
      'fromSTEB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsetsDirectional');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'EdgeInsetsDirectional');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsetsDirectional');
        final end = D4.getRequiredArg<double>(positional, 2, 'end', 'EdgeInsetsDirectional');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsetsDirectional');
        return $flutter_25.EdgeInsetsDirectional.fromSTEB(start, top, end, bottom);
      },
      'only': (visitor, positional, named) {
        final start = D4.getNamedArgWithDefault<double>(named, 'start', 0.0);
        final top = D4.getNamedArgWithDefault<double>(named, 'top', 0.0);
        final end = D4.getNamedArgWithDefault<double>(named, 'end', 0.0);
        final bottom = D4.getNamedArgWithDefault<double>(named, 'bottom', 0.0);
        return $flutter_25.EdgeInsetsDirectional.only(start: start, top: top, end: end, bottom: bottom);
      },
      'symmetric': (visitor, positional, named) {
        final horizontal = D4.getNamedArgWithDefault<double>(named, 'horizontal', 0.0);
        final vertical = D4.getNamedArgWithDefault<double>(named, 'vertical', 0.0);
        return $flutter_25.EdgeInsetsDirectional.symmetric(horizontal: horizontal, vertical: vertical);
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EdgeInsetsDirectional');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'EdgeInsetsDirectional');
        return $flutter_25.EdgeInsetsDirectional.all(value);
      },
    },
    getters: {
      'isNonNegative': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').isNonNegative,
      'horizontal': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').horizontal,
      'vertical': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').vertical,
      'collapsedSize': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').collapsedSize,
      'flipped': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').flipped,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').start,
      'top': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').top,
      'end': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').end,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').bottom,
    },
    methods: {
      'along': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'along');
        final axis = D4.getRequiredArg<$flutter_9.Axis>(positional, 0, 'axis', 'along');
        return t.along(axis);
      },
      'inflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'inflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inflateSize');
        return t.inflateSize(size);
      },
      'deflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'deflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'deflateSize');
        return t.deflateSize(size);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$flutter_25.EdgeInsetsGeometry>(positional, 1, 'max', 'clamp');
        return t.clamp(min, max);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final start = D4.getOptionalNamedArg<double?>(named, 'start');
        final top = D4.getOptionalNamedArg<double?>(named, 'top');
        final end = D4.getOptionalNamedArg<double?>(named, 'end');
        final bottom = D4.getOptionalNamedArg<double?>(named, 'bottom');
        return t.copyWith(start: start, top: top, end: end, bottom: bottom);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_25.EdgeInsetsDirectional>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<$flutter_25.EdgeInsetsDirectional>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_25.EdgeInsetsDirectional.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_25.EdgeInsetsDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_25.EdgeInsetsDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_25.EdgeInsetsDirectional.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromSTEB': 'const EdgeInsetsDirectional.fromSTEB(double start, double top, double end, double bottom)',
      'only': 'const EdgeInsetsDirectional.only({double start = 0.0, double top = 0.0, double end = 0.0, double bottom = 0.0})',
      'symmetric': 'const EdgeInsetsDirectional.symmetric({double horizontal = 0.0, double vertical = 0.0})',
      'all': 'const EdgeInsetsDirectional.all(double value)',
    },
    methodSignatures: {
      'along': 'double along(Axis axis)',
      'inflateSize': 'Size inflateSize(Size size)',
      'deflateSize': 'Size deflateSize(Size size)',
      'subtract': 'EdgeInsetsGeometry subtract(EdgeInsetsGeometry other)',
      'add': 'EdgeInsetsGeometry add(EdgeInsetsGeometry other)',
      'clamp': 'EdgeInsetsGeometry clamp(EdgeInsetsGeometry min, EdgeInsetsGeometry max)',
      'resolve': 'EdgeInsets resolve(TextDirection? direction)',
      'toString': 'String toString()',
      'copyWith': 'EdgeInsetsDirectional copyWith({double? start, double? top, double? end, double? bottom})',
    },
    getterSignatures: {
      'isNonNegative': 'bool get isNonNegative',
      'horizontal': 'double get horizontal',
      'vertical': 'double get vertical',
      'collapsedSize': 'Size get collapsedSize',
      'flipped': 'EdgeInsetsDirectional get flipped',
      'hashCode': 'int get hashCode',
      'start': 'double get start',
      'top': 'double get top',
      'end': 'double get end',
      'bottom': 'double get bottom',
    },
    staticMethodSignatures: {
      'lerp': 'EdgeInsetsDirectional? lerp(EdgeInsetsDirectional? a, EdgeInsetsDirectional? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'EdgeInsetsDirectional get zero',
    },
  );
}

// =============================================================================
// FlutterLogoDecoration Bridge
// =============================================================================

BridgedClass _createFlutterLogoDecorationBridge() {
  return BridgedClass(
    nativeType: $flutter_26.FlutterLogoDecoration,
    name: 'FlutterLogoDecoration',
    constructors: {
      '': (visitor, positional, named) {
        final textColor = D4.getNamedArgWithDefault<Color>(named, 'textColor', const Color(0xFF757575));
        final style = D4.getNamedArgWithDefault<$flutter_26.FlutterLogoStyle>(named, 'style', $flutter_26.FlutterLogoStyle.markOnly);
        final margin = D4.getNamedArgWithDefault<$flutter_25.EdgeInsets>(named, 'margin', $flutter_25.EdgeInsets.zero);
        return $flutter_26.FlutterLogoDecoration(textColor: textColor, style: style, margin: margin);
      },
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').isComplex,
      'textColor': (visitor, target) => D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').textColor,
      'style': (visitor, target) => D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').style,
      'margin': (visitor, target) => D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').margin,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        return t.debugAssertIsValid();
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(onChangedRaw == null ? null : () { D4.callInterpreterCallback(visitor, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_26.FlutterLogoDecoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_26.FlutterLogoDecoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_26.FlutterLogoDecoration.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const FlutterLogoDecoration({Color textColor = const Color(0xFF757575), FlutterLogoStyle style = FlutterLogoStyle.markOnly, EdgeInsets margin = EdgeInsets.zero})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback? onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'padding': 'EdgeInsetsGeometry get padding',
      'isComplex': 'bool get isComplex',
      'textColor': 'Color get textColor',
      'style': 'FlutterLogoStyle get style',
      'margin': 'EdgeInsets get margin',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'FlutterLogoDecoration? lerp(FlutterLogoDecoration? a, FlutterLogoDecoration? b, double t)',
    },
  );
}

// =============================================================================
// FractionalOffset Bridge
// =============================================================================

BridgedClass _createFractionalOffsetBridge() {
  return BridgedClass(
    nativeType: $flutter_27.FractionalOffset,
    name: 'FractionalOffset',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FractionalOffset');
        final dx = D4.getRequiredArg<double>(positional, 0, 'dx', 'FractionalOffset');
        final dy = D4.getRequiredArg<double>(positional, 1, 'dy', 'FractionalOffset');
        return $flutter_27.FractionalOffset(dx, dy);
      },
      'fromOffsetAndSize': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FractionalOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'FractionalOffset');
        final size = D4.getRequiredArg<Size>(positional, 1, 'size', 'FractionalOffset');
        return $flutter_27.FractionalOffset.fromOffsetAndSize(offset, size);
      },
      'fromOffsetAndRect': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FractionalOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'FractionalOffset');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'FractionalOffset');
        return $flutter_27.FractionalOffset.fromOffsetAndRect(offset, rect);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset').hashCode,
      'x': (visitor, target) => D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset').y,
      'dx': (visitor, target) => D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset').dx,
      'dy': (visitor, target) => D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset').dy,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_8.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        return t.toString();
      },
      'alongOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'alongOffset');
        final other = D4.getRequiredArg<Offset>(positional, 0, 'other', 'alongOffset');
        return t.alongOffset(other);
      },
      'alongSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'alongSize');
        final other = D4.getRequiredArg<Size>(positional, 0, 'other', 'alongSize');
        return t.alongSize(other);
      },
      'withinRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'withinRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'withinRect');
        return t.withinRect(rect);
      },
      'inscribe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 2, 'inscribe');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inscribe');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'inscribe');
        return t.inscribe(size, rect);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_8.Alignment>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<$flutter_8.Alignment>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'topLeft': (visitor) => $flutter_27.FractionalOffset.topLeft,
      'topCenter': (visitor) => $flutter_27.FractionalOffset.topCenter,
      'topRight': (visitor) => $flutter_27.FractionalOffset.topRight,
      'centerLeft': (visitor) => $flutter_27.FractionalOffset.centerLeft,
      'center': (visitor) => $flutter_27.FractionalOffset.center,
      'centerRight': (visitor) => $flutter_27.FractionalOffset.centerRight,
      'bottomLeft': (visitor) => $flutter_27.FractionalOffset.bottomLeft,
      'bottomCenter': (visitor) => $flutter_27.FractionalOffset.bottomCenter,
      'bottomRight': (visitor) => $flutter_27.FractionalOffset.bottomRight,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_27.FractionalOffset?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_27.FractionalOffset?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_27.FractionalOffset.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const FractionalOffset(double dx, double dy)',
      'fromOffsetAndSize': 'factory FractionalOffset.fromOffsetAndSize(Offset offset, Size size)',
      'fromOffsetAndRect': 'factory FractionalOffset.fromOffsetAndRect(Offset offset, Rect rect)',
    },
    methodSignatures: {
      'add': 'AlignmentGeometry add(AlignmentGeometry other)',
      'resolve': 'Alignment resolve(TextDirection? direction)',
      'toString': 'String toString()',
      'alongOffset': 'Offset alongOffset(Offset other)',
      'alongSize': 'Offset alongSize(Size other)',
      'withinRect': 'Offset withinRect(Rect rect)',
      'inscribe': 'Rect inscribe(Size size, Rect rect)',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
      'x': 'double get x',
      'y': 'double get y',
      'dx': 'double get dx',
      'dy': 'double get dy',
    },
    staticMethodSignatures: {
      'lerp': 'FractionalOffset? lerp(FractionalOffset? a, FractionalOffset? b, double t)',
    },
    staticGetterSignatures: {
      'topLeft': 'FractionalOffset get topLeft',
      'topCenter': 'FractionalOffset get topCenter',
      'topRight': 'FractionalOffset get topRight',
      'centerLeft': 'FractionalOffset get centerLeft',
      'center': 'FractionalOffset get center',
      'centerRight': 'FractionalOffset get centerRight',
      'bottomLeft': 'FractionalOffset get bottomLeft',
      'bottomCenter': 'FractionalOffset get bottomCenter',
      'bottomRight': 'FractionalOffset get bottomRight',
    },
  );
}

// =============================================================================
// GradientTransform Bridge
// =============================================================================

BridgedClass _createGradientTransformBridge() {
  return BridgedClass(
    nativeType: $flutter_29.GradientTransform,
    name: 'GradientTransform',
    constructors: {
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.GradientTransform>(target, 'GradientTransform');
        D4.requireMinArgs(positional, 1, 'transform');
        final bounds = D4.getRequiredArg<Rect>(positional, 0, 'bounds', 'transform');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.transform(bounds, textDirection: textDirection);
      },
    },
    methodSignatures: {
      'transform': 'Matrix4? transform(Rect bounds, {TextDirection? textDirection})',
    },
  );
}

// =============================================================================
// GradientRotation Bridge
// =============================================================================

BridgedClass _createGradientRotationBridge() {
  return BridgedClass(
    nativeType: $flutter_29.GradientRotation,
    name: 'GradientRotation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'GradientRotation');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'GradientRotation');
        return $flutter_29.GradientRotation(radians);
      },
    },
    getters: {
      'radians': (visitor, target) => D4.validateTarget<$flutter_29.GradientRotation>(target, 'GradientRotation').radians,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_29.GradientRotation>(target, 'GradientRotation').hashCode,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.GradientRotation>(target, 'GradientRotation');
        D4.requireMinArgs(positional, 1, 'transform');
        final bounds = D4.getRequiredArg<Rect>(positional, 0, 'bounds', 'transform');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.transform(bounds, textDirection: textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.GradientRotation>(target, 'GradientRotation');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.GradientRotation>(target, 'GradientRotation');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const GradientRotation(double radians)',
    },
    methodSignatures: {
      'transform': 'Matrix4 transform(Rect bounds, {TextDirection? textDirection})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'radians': 'double get radians',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Gradient Bridge
// =============================================================================

BridgedClass _createGradientBridge() {
  return BridgedClass(
    nativeType: $flutter_29.Gradient,
    name: 'Gradient',
    constructors: {
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_29.Gradient>(target, 'Gradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_29.Gradient>(target, 'Gradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_29.Gradient>(target, 'Gradient').transform,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_29.Gradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_29.Gradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_29.Gradient.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'Gradient scale(double factor)',
      'withOpacity': 'Gradient withOpacity(double opacity)',
    },
    getterSignatures: {
      'colors': 'List<Color> get colors',
      'stops': 'List<double>? get stops',
      'transform': 'GradientTransform? get transform',
    },
    staticMethodSignatures: {
      'lerp': 'Gradient? lerp(Gradient? a, Gradient? b, double t)',
    },
  );
}

// =============================================================================
// LinearGradient Bridge
// =============================================================================

BridgedClass _createLinearGradientBridge() {
  return BridgedClass(
    nativeType: $flutter_29.LinearGradient,
    name: 'LinearGradient',
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getNamedArgWithDefault<$flutter_8.AlignmentGeometry>(named, 'begin', $flutter_8.Alignment.centerLeft);
        final end = D4.getNamedArgWithDefault<$flutter_8.AlignmentGeometry>(named, 'end', $flutter_8.Alignment.centerRight);
        if (!named.containsKey('colors') || named['colors'] == null) {
          throw ArgumentError('LinearGradient: Missing required named argument "colors"');
        }
        final colors = D4.coerceList<Color>(named['colors'], 'colors');
        final stops = D4.coerceListOrNull<double>(named['stops'], 'stops');
        final tileMode = D4.getNamedArgWithDefault<TileMode>(named, 'tileMode', TileMode.clamp);
        final transform = D4.getOptionalNamedArg<$flutter_29.GradientTransform?>(named, 'transform');
        return $flutter_29.LinearGradient(begin: begin, end: end, colors: colors, stops: stops, tileMode: tileMode, transform: transform);
      },
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient').transform,
      'begin': (visitor, target) => D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient').end,
      'tileMode': (visitor, target) => D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient').tileMode,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient').hashCode,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.LinearGradient>(target, 'LinearGradient');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_29.LinearGradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_29.LinearGradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_29.LinearGradient.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const LinearGradient({AlignmentGeometry begin = Alignment.centerLeft, AlignmentGeometry end = Alignment.centerRight, required List<Color> colors, List<double>? stops, TileMode tileMode = TileMode.clamp, GradientTransform? transform})',
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'LinearGradient scale(double factor)',
      'withOpacity': 'LinearGradient withOpacity(double opacity)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'colors': 'List<Color> get colors',
      'stops': 'List<double>? get stops',
      'transform': 'GradientTransform? get transform',
      'begin': 'AlignmentGeometry get begin',
      'end': 'AlignmentGeometry get end',
      'tileMode': 'TileMode get tileMode',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'LinearGradient? lerp(LinearGradient? a, LinearGradient? b, double t)',
    },
  );
}

// =============================================================================
// RadialGradient Bridge
// =============================================================================

BridgedClass _createRadialGradientBridge() {
  return BridgedClass(
    nativeType: $flutter_29.RadialGradient,
    name: 'RadialGradient',
    constructors: {
      '': (visitor, positional, named) {
        final center = D4.getNamedArgWithDefault<$flutter_8.AlignmentGeometry>(named, 'center', $flutter_8.Alignment.center);
        final radius = D4.getNamedArgWithDefault<double>(named, 'radius', 0.5);
        if (!named.containsKey('colors') || named['colors'] == null) {
          throw ArgumentError('RadialGradient: Missing required named argument "colors"');
        }
        final colors = D4.coerceList<Color>(named['colors'], 'colors');
        final stops = D4.coerceListOrNull<double>(named['stops'], 'stops');
        final tileMode = D4.getNamedArgWithDefault<TileMode>(named, 'tileMode', TileMode.clamp);
        final focal = D4.getOptionalNamedArg<$flutter_8.AlignmentGeometry?>(named, 'focal');
        final focalRadius = D4.getNamedArgWithDefault<double>(named, 'focalRadius', 0.0);
        final transform = D4.getOptionalNamedArg<$flutter_29.GradientTransform?>(named, 'transform');
        return $flutter_29.RadialGradient(center: center, radius: radius, colors: colors, stops: stops, tileMode: tileMode, focal: focal, focalRadius: focalRadius, transform: transform);
      },
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').transform,
      'center': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').center,
      'radius': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').radius,
      'tileMode': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').tileMode,
      'focal': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').focal,
      'focalRadius': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').focalRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient').hashCode,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.RadialGradient>(target, 'RadialGradient');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_29.RadialGradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_29.RadialGradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_29.RadialGradient.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const RadialGradient({AlignmentGeometry center = Alignment.center, double radius = 0.5, required List<Color> colors, List<double>? stops, TileMode tileMode = TileMode.clamp, AlignmentGeometry? focal, double focalRadius = 0.0, GradientTransform? transform})',
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'RadialGradient scale(double factor)',
      'withOpacity': 'RadialGradient withOpacity(double opacity)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'colors': 'List<Color> get colors',
      'stops': 'List<double>? get stops',
      'transform': 'GradientTransform? get transform',
      'center': 'AlignmentGeometry get center',
      'radius': 'double get radius',
      'tileMode': 'TileMode get tileMode',
      'focal': 'AlignmentGeometry? get focal',
      'focalRadius': 'double get focalRadius',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'RadialGradient? lerp(RadialGradient? a, RadialGradient? b, double t)',
    },
  );
}

// =============================================================================
// SweepGradient Bridge
// =============================================================================

BridgedClass _createSweepGradientBridge() {
  return BridgedClass(
    nativeType: $flutter_29.SweepGradient,
    name: 'SweepGradient',
    constructors: {
      '': (visitor, positional, named) {
        final center = D4.getNamedArgWithDefault<$flutter_8.AlignmentGeometry>(named, 'center', $flutter_8.Alignment.center);
        final startAngle = D4.getNamedArgWithDefault<double>(named, 'startAngle', 0.0);
        if (!named.containsKey('colors') || named['colors'] == null) {
          throw ArgumentError('SweepGradient: Missing required named argument "colors"');
        }
        final colors = D4.coerceList<Color>(named['colors'], 'colors');
        final stops = D4.coerceListOrNull<double>(named['stops'], 'stops');
        final tileMode = D4.getNamedArgWithDefault<TileMode>(named, 'tileMode', TileMode.clamp);
        final transform = D4.getOptionalNamedArg<$flutter_29.GradientTransform?>(named, 'transform');
        if (!named.containsKey('endAngle')) {
          return $flutter_29.SweepGradient(center: center, startAngle: startAngle, colors: colors, stops: stops, tileMode: tileMode, transform: transform);
        }
        if (named.containsKey('endAngle')) {
          final endAngle = D4.getRequiredNamedArg<double>(named, 'endAngle', 'SweepGradient');
          return $flutter_29.SweepGradient(center: center, startAngle: startAngle, colors: colors, stops: stops, tileMode: tileMode, transform: transform, endAngle: endAngle);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').transform,
      'center': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').center,
      'startAngle': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').startAngle,
      'endAngle': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').endAngle,
      'tileMode': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').tileMode,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient').hashCode,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.SweepGradient>(target, 'SweepGradient');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_29.SweepGradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_29.SweepGradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_29.SweepGradient.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const SweepGradient({AlignmentGeometry center = Alignment.center, double startAngle = 0.0, double endAngle = math.pi * 2, required List<Color> colors, List<double>? stops, TileMode tileMode = TileMode.clamp, GradientTransform? transform})',
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'SweepGradient scale(double factor)',
      'withOpacity': 'SweepGradient withOpacity(double opacity)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'colors': 'List<Color> get colors',
      'stops': 'List<double>? get stops',
      'transform': 'GradientTransform? get transform',
      'center': 'AlignmentGeometry get center',
      'startAngle': 'double get startAngle',
      'endAngle': 'double get endAngle',
      'tileMode': 'TileMode get tileMode',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'SweepGradient? lerp(SweepGradient? a, SweepGradient? b, double t)',
    },
  );
}

// =============================================================================
// ImageCache Bridge
// =============================================================================

BridgedClass _createImageCacheBridge() {
  return BridgedClass(
    nativeType: $flutter_30.ImageCache,
    name: 'ImageCache',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_30.ImageCache();
      },
    },
    getters: {
      'maximumSize': (visitor, target) => D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').maximumSize,
      'currentSize': (visitor, target) => D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').currentSize,
      'maximumSizeBytes': (visitor, target) => D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').maximumSizeBytes,
      'currentSizeBytes': (visitor, target) => D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').currentSizeBytes,
      'liveImageCount': (visitor, target) => D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').liveImageCount,
      'pendingImageCount': (visitor, target) => D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').pendingImageCount,
    },
    setters: {
      'maximumSize': (visitor, target, value) => 
        D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').maximumSize = value as dynamic,
      'maximumSizeBytes': (visitor, target, value) => 
        D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache').maximumSizeBytes = value as dynamic,
    },
    methods: {
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache');
        t.clear();
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'evict');
        final includeLive = D4.getNamedArgWithDefault<bool>(named, 'includeLive', true);
        return t.evict(key, includeLive: includeLive);
      },
      'putIfAbsent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 2, 'putIfAbsent');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'putIfAbsent');
        if (positional.length <= 1) {
          throw ArgumentError('putIfAbsent: Missing required argument "loader" at position 1');
        }
        final loaderRaw = positional[1];
        final onErrorRaw = named['onError'];
        return t.putIfAbsent(key, () { return D4.callInterpreterCallback(visitor, loaderRaw, []) as $flutter_34.ImageStreamCompleter; }, onError: onErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); });
      },
      'statusForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 1, 'statusForKey');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'statusForKey');
        return t.statusForKey(key);
      },
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'clearLiveImages': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCache>(target, 'ImageCache');
        t.clearLiveImages();
        return null;
      },
    },
    constructorSignatures: {
      '': 'ImageCache()',
    },
    methodSignatures: {
      'clear': 'void clear()',
      'evict': 'bool evict(Object key, {bool includeLive = true})',
      'putIfAbsent': 'ImageStreamCompleter? putIfAbsent(Object key, ImageStreamCompleter Function() loader, {ImageErrorListener? onError})',
      'statusForKey': 'ImageCacheStatus statusForKey(Object key)',
      'containsKey': 'bool containsKey(Object key)',
      'clearLiveImages': 'void clearLiveImages()',
    },
    getterSignatures: {
      'maximumSize': 'int get maximumSize',
      'currentSize': 'int get currentSize',
      'maximumSizeBytes': 'int get maximumSizeBytes',
      'currentSizeBytes': 'int get currentSizeBytes',
      'liveImageCount': 'int get liveImageCount',
      'pendingImageCount': 'int get pendingImageCount',
    },
    setterSignatures: {
      'maximumSize': 'set maximumSize(int value)',
      'maximumSizeBytes': 'set maximumSizeBytes(int value)',
    },
  );
}

// =============================================================================
// ImageCacheStatus Bridge
// =============================================================================

BridgedClass _createImageCacheStatusBridge() {
  return BridgedClass(
    nativeType: $flutter_30.ImageCacheStatus,
    name: 'ImageCacheStatus',
    constructors: {
    },
    getters: {
      'pending': (visitor, target) => D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus').pending,
      'keepAlive': (visitor, target) => D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus').keepAlive,
      'live': (visitor, target) => D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus').live,
      'tracked': (visitor, target) => D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus').tracked,
      'untracked': (visitor, target) => D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus').untracked,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.ImageCacheStatus>(target, 'ImageCacheStatus');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'pending': 'bool get pending',
      'keepAlive': 'bool get keepAlive',
      'live': 'bool get live',
      'tracked': 'bool get tracked',
      'untracked': 'bool get untracked',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImageConfiguration Bridge
// =============================================================================

BridgedClass _createImageConfigurationBridge() {
  return BridgedClass(
    nativeType: $flutter_32.ImageConfiguration,
    name: 'ImageConfiguration',
    constructors: {
      '': (visitor, positional, named) {
        final bundle = D4.getOptionalNamedArg<$flutter_54.AssetBundle?>(named, 'bundle');
        final devicePixelRatio = D4.getOptionalNamedArg<double?>(named, 'devicePixelRatio');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final platform = D4.getOptionalNamedArg<$flutter_4.TargetPlatform?>(named, 'platform');
        return $flutter_32.ImageConfiguration(bundle: bundle, devicePixelRatio: devicePixelRatio, locale: locale, textDirection: textDirection, size: size, platform: platform);
      },
    },
    getters: {
      'bundle': (visitor, target) => D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration').bundle,
      'devicePixelRatio': (visitor, target) => D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration').devicePixelRatio,
      'locale': (visitor, target) => D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration').locale,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration').textDirection,
      'size': (visitor, target) => D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration').size,
      'platform': (visitor, target) => D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration').platform,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration');
        final bundle = D4.getOptionalNamedArg<$flutter_54.AssetBundle?>(named, 'bundle');
        final devicePixelRatio = D4.getOptionalNamedArg<double?>(named, 'devicePixelRatio');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final platform = D4.getOptionalNamedArg<$flutter_4.TargetPlatform?>(named, 'platform');
        return t.copyWith(bundle: bundle, devicePixelRatio: devicePixelRatio, locale: locale, textDirection: textDirection, size: size, platform: platform);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageConfiguration>(target, 'ImageConfiguration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'empty': (visitor) => $flutter_32.ImageConfiguration.empty,
    },
    constructorSignatures: {
      '': 'const ImageConfiguration({AssetBundle? bundle, double? devicePixelRatio, Locale? locale, TextDirection? textDirection, Size? size, TargetPlatform? platform})',
    },
    methodSignatures: {
      'copyWith': 'ImageConfiguration copyWith({AssetBundle? bundle, double? devicePixelRatio, ui.Locale? locale, TextDirection? textDirection, Size? size, TargetPlatform? platform})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bundle': 'AssetBundle? get bundle',
      'devicePixelRatio': 'double? get devicePixelRatio',
      'locale': 'ui.Locale? get locale',
      'textDirection': 'TextDirection? get textDirection',
      'size': 'Size? get size',
      'platform': 'TargetPlatform? get platform',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'empty': 'ImageConfiguration get empty',
    },
  );
}

// =============================================================================
// ImageProvider Bridge
// =============================================================================

BridgedClass _createImageProviderBridge() {
  return BridgedClass(
    nativeType: $flutter_32.ImageProvider,
    name: 'ImageProvider',
    constructors: {
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageProvider>(target, 'ImageProvider');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageProvider>(target, 'ImageProvider');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageProvider>(target, 'ImageProvider');
        return t.toString();
      },
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<T> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// AssetBundleImageKey Bridge
// =============================================================================

BridgedClass _createAssetBundleImageKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_32.AssetBundleImageKey,
    name: 'AssetBundleImageKey',
    constructors: {
      '': (visitor, positional, named) {
        final bundle = D4.getRequiredNamedArg<$flutter_54.AssetBundle>(named, 'bundle', 'AssetBundleImageKey');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'AssetBundleImageKey');
        final scale = D4.getRequiredNamedArg<double>(named, 'scale', 'AssetBundleImageKey');
        return $flutter_32.AssetBundleImageKey(bundle: bundle, name: name, scale: scale);
      },
    },
    getters: {
      'bundle': (visitor, target) => D4.validateTarget<$flutter_32.AssetBundleImageKey>(target, 'AssetBundleImageKey').bundle,
      'name': (visitor, target) => D4.validateTarget<$flutter_32.AssetBundleImageKey>(target, 'AssetBundleImageKey').name,
      'scale': (visitor, target) => D4.validateTarget<$flutter_32.AssetBundleImageKey>(target, 'AssetBundleImageKey').scale,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.AssetBundleImageKey>(target, 'AssetBundleImageKey').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.AssetBundleImageKey>(target, 'AssetBundleImageKey');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.AssetBundleImageKey>(target, 'AssetBundleImageKey');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const AssetBundleImageKey({required AssetBundle bundle, required String name, required double scale})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bundle': 'AssetBundle get bundle',
      'name': 'String get name',
      'scale': 'double get scale',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// AssetBundleImageProvider Bridge
// =============================================================================

BridgedClass _createAssetBundleImageProviderBridge() {
  return BridgedClass(
    nativeType: $flutter_32.AssetBundleImageProvider,
    name: 'AssetBundleImageProvider',
    constructors: {
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        return t.toString();
      },
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, void Function(Object exception, StackTrace? stackTrace) handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<AssetBundleImageKey> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// ResizeImageKey Bridge
// =============================================================================

BridgedClass _createResizeImageKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_32.ResizeImageKey,
    name: 'ResizeImageKey',
    constructors: {
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.ResizeImageKey>(target, 'ResizeImageKey').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ResizeImageKey>(target, 'ResizeImageKey');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ResizeImage Bridge
// =============================================================================

BridgedClass _createResizeImageBridge() {
  return BridgedClass(
    nativeType: $flutter_32.ResizeImage,
    name: 'ResizeImage',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ResizeImage');
        final imageProvider = D4.getRequiredArg<$flutter_32.ImageProvider<Object>>(positional, 0, 'imageProvider', 'ResizeImage');
        final width = D4.getOptionalNamedArg<int?>(named, 'width');
        final height = D4.getOptionalNamedArg<int?>(named, 'height');
        final policy = D4.getNamedArgWithDefault<$flutter_32.ResizeImagePolicy>(named, 'policy', $flutter_32.ResizeImagePolicy.exact);
        final allowUpscaling = D4.getNamedArgWithDefault<bool>(named, 'allowUpscaling', false);
        return $flutter_32.ResizeImage(imageProvider, width: width, height: height, policy: policy, allowUpscaling: allowUpscaling);
      },
    },
    getters: {
      'imageProvider': (visitor, target) => D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage').imageProvider,
      'width': (visitor, target) => D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage').width,
      'height': (visitor, target) => D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage').height,
      'policy': (visitor, target) => D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage').policy,
      'allowUpscaling': (visitor, target) => D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage').allowUpscaling,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ResizeImage>(target, 'ResizeImage');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'resizeIfNeeded': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'resizeIfNeeded');
        final cacheWidth = D4.getRequiredArg<int?>(positional, 0, 'cacheWidth', 'resizeIfNeeded');
        final cacheHeight = D4.getRequiredArg<int?>(positional, 1, 'cacheHeight', 'resizeIfNeeded');
        final provider = D4.getRequiredArg<$flutter_32.ImageProvider<Object>>(positional, 2, 'provider', 'resizeIfNeeded');
        return $flutter_32.ResizeImage.resizeIfNeeded(cacheWidth, cacheHeight, provider);
      },
    },
    constructorSignatures: {
      '': 'const ResizeImage(ImageProvider<Object> imageProvider, {int? width, int? height, ResizeImagePolicy policy = ResizeImagePolicy.exact, bool allowUpscaling = false})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, void Function(Object exception, StackTrace? stackTrace) handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<ResizeImageKey> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'imageProvider': 'ImageProvider get imageProvider',
      'width': 'int? get width',
      'height': 'int? get height',
      'policy': 'ResizeImagePolicy get policy',
      'allowUpscaling': 'bool get allowUpscaling',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'resizeIfNeeded': 'ImageProvider<Object> resizeIfNeeded(int? cacheWidth, int? cacheHeight, ImageProvider<Object> provider)',
    },
  );
}

// =============================================================================
// NetworkImage Bridge
// =============================================================================

BridgedClass _createNetworkImageBridge() {
  return BridgedClass(
    nativeType: $flutter_32.NetworkImage,
    name: 'NetworkImage',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NetworkImage');
        final url = D4.getRequiredArg<String>(positional, 0, 'url', 'NetworkImage');
        final scale = D4.getRequiredNamedArgTodoDefault<double>(named, 'scale', 'NetworkImage', '<default unavailable>');
        final headers = D4.coerceMapOrNull<String, String>(named['headers'], 'headers');
        final webHtmlElementStrategy = D4.getRequiredNamedArgTodoDefault<$flutter_32.WebHtmlElementStrategy>(named, 'webHtmlElementStrategy', 'NetworkImage', '<default unavailable>');
        return $flutter_32.NetworkImage(url, scale: scale, headers: headers, webHtmlElementStrategy: webHtmlElementStrategy);
      },
    },
    getters: {
      'url': (visitor, target) => D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage').url,
      'scale': (visitor, target) => D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage').scale,
      'headers': (visitor, target) => D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage').headers,
      'webHtmlElementStrategy': (visitor, target) => D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage').webHtmlElementStrategy,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.NetworkImage>(target, 'NetworkImage');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const factory NetworkImage(String url, {double scale, Map<String, String>? headers, WebHtmlElementStrategy webHtmlElementStrategy})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, void Function(Object exception, StackTrace? stackTrace) handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<NetworkImage> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'url': 'String get url',
      'scale': 'double get scale',
      'headers': 'Map<String, String>? get headers',
      'webHtmlElementStrategy': 'WebHtmlElementStrategy get webHtmlElementStrategy',
    },
  );
}

// =============================================================================
// FileImage Bridge
// =============================================================================

BridgedClass _createFileImageBridge() {
  return BridgedClass(
    nativeType: $flutter_32.FileImage,
    name: 'FileImage',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FileImage');
        final file = D4.getRequiredArg<File>(positional, 0, 'file', 'FileImage');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        return $flutter_32.FileImage(file, scale: scale);
      },
    },
    getters: {
      'file': (visitor, target) => D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage').file,
      'scale': (visitor, target) => D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage').scale,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.FileImage>(target, 'FileImage');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const FileImage(File file, {double scale = 1.0})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, void Function(Object exception, StackTrace? stackTrace) handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<FileImage> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'file': 'File get file',
      'scale': 'double get scale',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// MemoryImage Bridge
// =============================================================================

BridgedClass _createMemoryImageBridge() {
  return BridgedClass(
    nativeType: $flutter_32.MemoryImage,
    name: 'MemoryImage',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MemoryImage');
        final bytes = D4.getRequiredArg<Uint8List>(positional, 0, 'bytes', 'MemoryImage');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        return $flutter_32.MemoryImage(bytes, scale: scale);
      },
    },
    getters: {
      'bytes': (visitor, target) => D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage').bytes,
      'scale': (visitor, target) => D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage').scale,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MemoryImage>(target, 'MemoryImage');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const MemoryImage(Uint8List bytes, {double scale = 1.0})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, void Function(Object exception, StackTrace? stackTrace) handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<MemoryImage> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bytes': 'Uint8List get bytes',
      'scale': 'double get scale',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ExactAssetImage Bridge
// =============================================================================

BridgedClass _createExactAssetImageBridge() {
  return BridgedClass(
    nativeType: $flutter_32.ExactAssetImage,
    name: 'ExactAssetImage',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExactAssetImage');
        final assetName = D4.getRequiredArg<String>(positional, 0, 'assetName', 'ExactAssetImage');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final bundle = D4.getOptionalNamedArg<$flutter_54.AssetBundle?>(named, 'bundle');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        return $flutter_32.ExactAssetImage(assetName, scale: scale, bundle: bundle, package: package);
      },
    },
    getters: {
      'assetName': (visitor, target) => D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage').assetName,
      'keyName': (visitor, target) => D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage').keyName,
      'scale': (visitor, target) => D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage').scale,
      'bundle': (visitor, target) => D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage').bundle,
      'package': (visitor, target) => D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage').package,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        return t.toString();
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_32.AssetBundleImageKey>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.callInterpreterCallback(visitor, decodeRaw, [p0], {'getTargetSize': getTargetSize}) as Future<Codec>; });
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_32.AssetBundleImageKey>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.callInterpreterCallback(visitor, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}) as Future<Codec>; });
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ExactAssetImage>(target, 'ExactAssetImage');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ExactAssetImage(String assetName, {double scale = 1.0, AssetBundle? bundle, String? package})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, void Function(Object exception, StackTrace? stackTrace) handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<AssetBundleImageKey> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
      'loadImage': 'ImageStreamCompleter loadImage(AssetBundleImageKey key, Future<Codec> Function(ImmutableBuffer, {TargetImageSize Function(int, int)? getTargetSize}) decode)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(AssetBundleImageKey key, Future<Codec> Function(ImmutableBuffer, {bool allowUpscaling, int? cacheHeight, int? cacheWidth}) decode)',
    },
    getterSignatures: {
      'assetName': 'String get assetName',
      'keyName': 'String get keyName',
      'scale': 'double get scale',
      'bundle': 'AssetBundle? get bundle',
      'package': 'String? get package',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// NetworkImageLoadException Bridge
// =============================================================================

BridgedClass _createNetworkImageLoadExceptionBridge() {
  return BridgedClass(
    nativeType: $flutter_32.NetworkImageLoadException,
    name: 'NetworkImageLoadException',
    constructors: {
      '': (visitor, positional, named) {
        final statusCode = D4.getRequiredNamedArg<int>(named, 'statusCode', 'NetworkImageLoadException');
        final uri = D4.getRequiredNamedArg<Uri>(named, 'uri', 'NetworkImageLoadException');
        return $flutter_32.NetworkImageLoadException(statusCode: statusCode, uri: uri);
      },
    },
    getters: {
      'statusCode': (visitor, target) => D4.validateTarget<$flutter_32.NetworkImageLoadException>(target, 'NetworkImageLoadException').statusCode,
      'uri': (visitor, target) => D4.validateTarget<$flutter_32.NetworkImageLoadException>(target, 'NetworkImageLoadException').uri,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.NetworkImageLoadException>(target, 'NetworkImageLoadException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'NetworkImageLoadException({required int statusCode, required Uri uri})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'statusCode': 'int get statusCode',
      'uri': 'Uri get uri',
    },
  );
}

// =============================================================================
// AssetImage Bridge
// =============================================================================

BridgedClass _createAssetImageBridge() {
  return BridgedClass(
    nativeType: $flutter_33.AssetImage,
    name: 'AssetImage',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AssetImage');
        final assetName = D4.getRequiredArg<String>(positional, 0, 'assetName', 'AssetImage');
        final bundle = D4.getOptionalNamedArg<$flutter_54.AssetBundle?>(named, 'bundle');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        return $flutter_33.AssetImage(assetName, bundle: bundle, package: package);
      },
    },
    getters: {
      'assetName': (visitor, target) => D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage').assetName,
      'keyName': (visitor, target) => D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage').keyName,
      'bundle': (visitor, target) => D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage').bundle,
      'package': (visitor, target) => D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage').package,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        final configuration = D4.getRequiredNamedArg<$flutter_32.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, handleErrorRaw, [p0, p1]); });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        final cache = D4.getOptionalNamedArg<$flutter_30.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_32.ImageConfiguration>(named, 'configuration', $flutter_32.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_32.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        return t.toString();
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_32.AssetBundleImageKey>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.callInterpreterCallback(visitor, decodeRaw, [p0], {'getTargetSize': getTargetSize}) as Future<Codec>; });
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_32.AssetBundleImageKey>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.callInterpreterCallback(visitor, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}) as Future<Codec>; });
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AssetImage>(target, 'AssetImage');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const AssetImage(String assetName, {AssetBundle? bundle, String? package})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, void Function(Object exception, StackTrace? stackTrace) handleError})',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<AssetBundleImageKey> obtainKey(ImageConfiguration configuration)',
      'toString': 'String toString()',
      'loadImage': 'ImageStreamCompleter loadImage(AssetBundleImageKey key, Future<Codec> Function(ImmutableBuffer, {TargetImageSize Function(int, int)? getTargetSize}) decode)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(AssetBundleImageKey key, Future<Codec> Function(ImmutableBuffer, {bool allowUpscaling, int? cacheHeight, int? cacheWidth}) decode)',
    },
    getterSignatures: {
      'assetName': 'String get assetName',
      'keyName': 'String get keyName',
      'bundle': 'AssetBundle? get bundle',
      'package': 'String? get package',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImageInfo Bridge
// =============================================================================

BridgedClass _createImageInfoBridge() {
  return BridgedClass(
    nativeType: $flutter_34.ImageInfo,
    name: 'ImageInfo',
    constructors: {
      '': (visitor, positional, named) {
        final image = D4.getRequiredNamedArg<Image>(named, 'image', 'ImageInfo');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        return $flutter_34.ImageInfo(image: image, scale: scale, debugLabel: debugLabel);
      },
    },
    getters: {
      'image': (visitor, target) => D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo').image,
      'sizeBytes': (visitor, target) => D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo').sizeBytes,
      'scale': (visitor, target) => D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo').scale,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo').debugLabel,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo').hashCode,
    },
    methods: {
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo');
        return t.clone();
      },
      'isCloneOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo');
        D4.requireMinArgs(positional, 1, 'isCloneOf');
        final other = D4.getRequiredArg<$flutter_34.ImageInfo>(positional, 0, 'other', 'isCloneOf');
        return t.isCloneOf(other);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageInfo>(target, 'ImageInfo');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'ImageInfo({required Image image, double scale = 1.0, String? debugLabel})',
    },
    methodSignatures: {
      'clone': 'ImageInfo clone()',
      'isCloneOf': 'bool isCloneOf(ImageInfo other)',
      'dispose': 'void dispose()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'image': 'ui.Image get image',
      'sizeBytes': 'int get sizeBytes',
      'scale': 'double get scale',
      'debugLabel': 'String? get debugLabel',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImageStreamListener Bridge
// =============================================================================

BridgedClass _createImageStreamListenerBridge() {
  return BridgedClass(
    nativeType: $flutter_34.ImageStreamListener,
    name: 'ImageStreamListener',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ImageStreamListener');
        if (positional.isEmpty) {
          throw ArgumentError('ImageStreamListener: Missing required argument "onImage" at position 0');
        }
        final onImageRaw = positional[0];
        final onChunkRaw = named['onChunk'];
        final onErrorRaw = named['onError'];
        return $flutter_34.ImageStreamListener(($flutter_34.ImageInfo p0, bool p1) { D4.callInterpreterCallback(visitor, onImageRaw, [p0, p1]); }, onChunk: onChunkRaw == null ? null : ($flutter_34.ImageChunkEvent p0) { D4.callInterpreterCallback(visitor, onChunkRaw, [p0]); }, onError: onErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); });
      },
    },
    getters: {
      'onImage': (visitor, target) => D4.validateTarget<$flutter_34.ImageStreamListener>(target, 'ImageStreamListener').onImage,
      'onChunk': (visitor, target) => D4.validateTarget<$flutter_34.ImageStreamListener>(target, 'ImageStreamListener').onChunk,
      'onError': (visitor, target) => D4.validateTarget<$flutter_34.ImageStreamListener>(target, 'ImageStreamListener').onError,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.ImageStreamListener>(target, 'ImageStreamListener').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamListener>(target, 'ImageStreamListener');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ImageStreamListener(void Function(ImageInfo, bool) onImage, {void Function(ImageChunkEvent)? onChunk, void Function(Object, StackTrace?)? onError})',
    },
    getterSignatures: {
      'onImage': 'ImageListener get onImage',
      'onChunk': 'ImageChunkListener? get onChunk',
      'onError': 'ImageErrorListener? get onError',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImageChunkEvent Bridge
// =============================================================================

BridgedClass _createImageChunkEventBridge() {
  return BridgedClass(
    nativeType: $flutter_34.ImageChunkEvent,
    name: 'ImageChunkEvent',
    constructors: {
      '': (visitor, positional, named) {
        final cumulativeBytesLoaded = D4.getRequiredNamedArg<int>(named, 'cumulativeBytesLoaded', 'ImageChunkEvent');
        final expectedTotalBytes = D4.getRequiredNamedArg<int?>(named, 'expectedTotalBytes', 'ImageChunkEvent');
        return $flutter_34.ImageChunkEvent(cumulativeBytesLoaded: cumulativeBytesLoaded, expectedTotalBytes: expectedTotalBytes);
      },
    },
    getters: {
      'cumulativeBytesLoaded': (visitor, target) => D4.validateTarget<$flutter_34.ImageChunkEvent>(target, 'ImageChunkEvent').cumulativeBytesLoaded,
      'expectedTotalBytes': (visitor, target) => D4.validateTarget<$flutter_34.ImageChunkEvent>(target, 'ImageChunkEvent').expectedTotalBytes,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageChunkEvent>(target, 'ImageChunkEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageChunkEvent>(target, 'ImageChunkEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageChunkEvent>(target, 'ImageChunkEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const ImageChunkEvent({required int cumulativeBytesLoaded, required int? expectedTotalBytes})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'cumulativeBytesLoaded': 'int get cumulativeBytesLoaded',
      'expectedTotalBytes': 'int? get expectedTotalBytes',
    },
  );
}

// =============================================================================
// ImageStream Bridge
// =============================================================================

BridgedClass _createImageStreamBridge() {
  return BridgedClass(
    nativeType: $flutter_34.ImageStream,
    name: 'ImageStream',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_34.ImageStream();
      },
    },
    getters: {
      'completer': (visitor, target) => D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream').completer,
      'key': (visitor, target) => D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream').key,
    },
    methods: {
      'setCompleter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream');
        D4.requireMinArgs(positional, 1, 'setCompleter');
        final value = D4.getRequiredArg<$flutter_34.ImageStreamCompleter>(positional, 0, 'value', 'setCompleter');
        t.setCompleter(value);
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStream>(target, 'ImageStream');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ImageStream()',
    },
    methodSignatures: {
      'setCompleter': 'void setCompleter(ImageStreamCompleter value)',
      'addListener': 'void addListener(ImageStreamListener listener)',
      'removeListener': 'void removeListener(ImageStreamListener listener)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'completer': 'ImageStreamCompleter? get completer',
      'key': 'Object get key',
    },
  );
}

// =============================================================================
// ImageStreamCompleterHandle Bridge
// =============================================================================

BridgedClass _createImageStreamCompleterHandleBridge() {
  return BridgedClass(
    nativeType: $flutter_34.ImageStreamCompleterHandle,
    name: 'ImageStreamCompleterHandle',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleterHandle>(target, 'ImageStreamCompleterHandle');
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
// ImageStreamCompleter Bridge
// =============================================================================

BridgedClass _createImageStreamCompleterBridge() {
  return BridgedClass(
    nativeType: $flutter_34.ImageStreamCompleter,
    name: 'ImageStreamCompleter',
    constructors: {
    },
    getters: {
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter').debugLabel,
    },
    setters: {
      'debugLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter').debugLabel = value as String?,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'addEphemeralErrorListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addEphemeralErrorListener');
        if (positional.isEmpty) {
          throw ArgumentError('addEphemeralErrorListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addEphemeralErrorListener((Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, listenerRaw, [p0, p1]); });
        return null;
      },
      'keepAlive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        return t.keepAlive();
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'maybeDispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        t.maybeDispose();
        return null;
      },
      'addOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'removeOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'reportError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        final context = D4.getOptionalNamedArg<$flutter_3.DiagnosticsNode?>(named, 'context');
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'reportError');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        t.reportError(context: context, exception: exception, stack: stack, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_3.DiagnosticsNode>; }, silent: silent);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    methodSignatures: {
      'addListener': 'void addListener(ImageStreamListener listener)',
      'addEphemeralErrorListener': 'void addEphemeralErrorListener(ImageErrorListener listener)',
      'keepAlive': 'ImageStreamCompleterHandle keepAlive()',
      'removeListener': 'void removeListener(ImageStreamListener listener)',
      'maybeDispose': 'void maybeDispose()',
      'addOnLastListenerRemovedCallback': 'void addOnLastListenerRemovedCallback(VoidCallback callback)',
      'removeOnLastListenerRemovedCallback': 'void removeOnLastListenerRemovedCallback(VoidCallback callback)',
      'reportError': 'void reportError({DiagnosticsNode? context, required Object exception, StackTrace? stack, InformationCollector? informationCollector, bool silent = false})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'debugLabel': 'String? get debugLabel',
    },
    setterSignatures: {
      'debugLabel': 'set debugLabel(dynamic value)',
    },
  );
}

// =============================================================================
// OneFrameImageStreamCompleter Bridge
// =============================================================================

BridgedClass _createOneFrameImageStreamCompleterBridge() {
  return BridgedClass(
    nativeType: $flutter_34.OneFrameImageStreamCompleter,
    name: 'OneFrameImageStreamCompleter',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OneFrameImageStreamCompleter');
        final image = D4.getRequiredArg<Future<$flutter_34.ImageInfo>>(positional, 0, 'image', 'OneFrameImageStreamCompleter');
        final informationCollectorRaw = named['informationCollector'];
        return $flutter_34.OneFrameImageStreamCompleter(image, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_3.DiagnosticsNode>; });
      },
    },
    getters: {
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter').debugLabel,
    },
    setters: {
      'debugLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter').debugLabel = value as String?,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'addEphemeralErrorListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addEphemeralErrorListener');
        if (positional.isEmpty) {
          throw ArgumentError('addEphemeralErrorListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addEphemeralErrorListener((Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, listenerRaw, [p0, p1]); });
        return null;
      },
      'keepAlive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        return t.keepAlive();
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'maybeDispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        t.maybeDispose();
        return null;
      },
      'addOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'removeOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'reportError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        final context = D4.getOptionalNamedArg<$flutter_3.DiagnosticsNode?>(named, 'context');
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'reportError');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        t.reportError(context: context, exception: exception, stack: stack, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_3.DiagnosticsNode>; }, silent: silent);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final description = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'description', 'debugFillProperties');
        (t as dynamic).debugFillProperties(description);
        return null;
      },
    },
    constructorSignatures: {
      '': 'OneFrameImageStreamCompleter(Future<ImageInfo> image, {InformationCollector? informationCollector})',
    },
    methodSignatures: {
      'addListener': 'void addListener(ImageStreamListener listener)',
      'addEphemeralErrorListener': 'void addEphemeralErrorListener(void Function(Object, StackTrace?) listener)',
      'keepAlive': 'ImageStreamCompleterHandle keepAlive()',
      'removeListener': 'void removeListener(ImageStreamListener listener)',
      'maybeDispose': 'void maybeDispose()',
      'addOnLastListenerRemovedCallback': 'void addOnLastListenerRemovedCallback(void Function() callback)',
      'removeOnLastListenerRemovedCallback': 'void removeOnLastListenerRemovedCallback(void Function() callback)',
      'reportError': 'void reportError({DiagnosticsNode? context, required Object exception, StackTrace? stack, Iterable<DiagnosticsNode> Function()? informationCollector, bool silent = false})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder description)',
    },
    getterSignatures: {
      'debugLabel': 'String? get debugLabel',
    },
    setterSignatures: {
      'debugLabel': 'set debugLabel(dynamic value)',
    },
  );
}

// =============================================================================
// MultiFrameImageStreamCompleter Bridge
// =============================================================================

BridgedClass _createMultiFrameImageStreamCompleterBridge() {
  return BridgedClass(
    nativeType: $flutter_34.MultiFrameImageStreamCompleter,
    name: 'MultiFrameImageStreamCompleter',
    constructors: {
      '': (visitor, positional, named) {
        final codec = D4.getRequiredNamedArg<Future<Codec>>(named, 'codec', 'MultiFrameImageStreamCompleter');
        final scale = D4.getRequiredNamedArg<double>(named, 'scale', 'MultiFrameImageStreamCompleter');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final chunkEvents = D4.getOptionalNamedArg<Stream<$flutter_34.ImageChunkEvent>?>(named, 'chunkEvents');
        final informationCollectorRaw = named['informationCollector'];
        return $flutter_34.MultiFrameImageStreamCompleter(codec: codec, scale: scale, debugLabel: debugLabel, chunkEvents: chunkEvents, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_3.DiagnosticsNode>; });
      },
    },
    getters: {
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter').debugLabel,
    },
    setters: {
      'debugLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter').debugLabel = value as String?,
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'addEphemeralErrorListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addEphemeralErrorListener');
        if (positional.isEmpty) {
          throw ArgumentError('addEphemeralErrorListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addEphemeralErrorListener((Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor, listenerRaw, [p0, p1]); });
        return null;
      },
      'keepAlive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        return t.keepAlive();
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_34.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'maybeDispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        t.maybeDispose();
        return null;
      },
      'addOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'removeOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor, callbackRaw, []); });
        return null;
      },
      'reportError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        final context = D4.getOptionalNamedArg<$flutter_3.DiagnosticsNode?>(named, 'context');
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'reportError');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        t.reportError(context: context, exception: exception, stack: stack, informationCollector: informationCollectorRaw == null ? null : () { return D4.callInterpreterCallback(visitor, informationCollectorRaw, []) as Iterable<$flutter_3.DiagnosticsNode>; }, silent: silent);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final description = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'description', 'debugFillProperties');
        (t as dynamic).debugFillProperties(description);
        return null;
      },
    },
    constructorSignatures: {
      '': 'MultiFrameImageStreamCompleter({required Future<ui.Codec> codec, required double scale, String? debugLabel, Stream<ImageChunkEvent>? chunkEvents, InformationCollector? informationCollector})',
    },
    methodSignatures: {
      'addListener': 'void addListener(ImageStreamListener listener)',
      'addEphemeralErrorListener': 'void addEphemeralErrorListener(void Function(Object, StackTrace?) listener)',
      'keepAlive': 'ImageStreamCompleterHandle keepAlive()',
      'removeListener': 'void removeListener(ImageStreamListener listener)',
      'maybeDispose': 'void maybeDispose()',
      'addOnLastListenerRemovedCallback': 'void addOnLastListenerRemovedCallback(void Function() callback)',
      'removeOnLastListenerRemovedCallback': 'void removeOnLastListenerRemovedCallback(void Function() callback)',
      'reportError': 'void reportError({DiagnosticsNode? context, required Object exception, StackTrace? stack, Iterable<DiagnosticsNode> Function()? informationCollector, bool silent = false})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder description)',
    },
    getterSignatures: {
      'debugLabel': 'String? get debugLabel',
    },
    setterSignatures: {
      'debugLabel': 'set debugLabel(dynamic value)',
    },
  );
}

// =============================================================================
// Accumulator Bridge
// =============================================================================

BridgedClass _createAccumulatorBridge() {
  return BridgedClass(
    nativeType: $flutter_35.Accumulator,
    name: 'Accumulator',
    constructors: {
      '': (visitor, positional, named) {
        final value = D4.getOptionalArgWithDefault<int>(positional, 0, '_value', 0);
        return $flutter_35.Accumulator(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_35.Accumulator>(target, 'Accumulator').value,
    },
    methods: {
      'increment': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.Accumulator>(target, 'Accumulator');
        D4.requireMinArgs(positional, 1, 'increment');
        final addend = D4.getRequiredArg<int>(positional, 0, 'addend', 'increment');
        t.increment(addend);
        return null;
      },
    },
    constructorSignatures: {
      '': 'Accumulator([int _value = 0])',
    },
    methodSignatures: {
      'increment': 'void increment(int addend)',
    },
    getterSignatures: {
      'value': 'int get value',
    },
  );
}

// =============================================================================
// InlineSpanSemanticsInformation Bridge
// =============================================================================

BridgedClass _createInlineSpanSemanticsInformationBridge() {
  return BridgedClass(
    nativeType: $flutter_35.InlineSpanSemanticsInformation,
    name: 'InlineSpanSemanticsInformation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InlineSpanSemanticsInformation');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'InlineSpanSemanticsInformation');
        final isPlaceholder = D4.getNamedArgWithDefault<bool>(named, 'isPlaceholder', false);
        final semanticsLabel = D4.getOptionalNamedArg<String?>(named, 'semanticsLabel');
        final semanticsIdentifier = D4.getOptionalNamedArg<String?>(named, 'semanticsIdentifier');
        final stringAttributes = named.containsKey('stringAttributes') && named['stringAttributes'] != null
            ? D4.coerceList<StringAttribute>(named['stringAttributes'], 'stringAttributes')
            : const <StringAttribute>[];
        final recognizer = D4.getOptionalNamedArg<$flutter_7.GestureRecognizer?>(named, 'recognizer');
        return $flutter_35.InlineSpanSemanticsInformation(text, isPlaceholder: isPlaceholder, semanticsLabel: semanticsLabel, semanticsIdentifier: semanticsIdentifier, stringAttributes: stringAttributes, recognizer: recognizer);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').text,
      'semanticsLabel': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').semanticsLabel,
      'semanticsIdentifier': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').semanticsIdentifier,
      'recognizer': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').recognizer,
      'isPlaceholder': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').isPlaceholder,
      'requiresOwnNode': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').requiresOwnNode,
      'stringAttributes': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').stringAttributes,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'placeholder': (visitor) => $flutter_35.InlineSpanSemanticsInformation.placeholder,
    },
    constructorSignatures: {
      '': 'const InlineSpanSemanticsInformation(String text, {bool isPlaceholder = false, String? semanticsLabel, String? semanticsIdentifier, List<StringAttribute> stringAttributes = const <ui.StringAttribute>[], GestureRecognizer? recognizer})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'text': 'String get text',
      'semanticsLabel': 'String? get semanticsLabel',
      'semanticsIdentifier': 'String? get semanticsIdentifier',
      'recognizer': 'GestureRecognizer? get recognizer',
      'isPlaceholder': 'bool get isPlaceholder',
      'requiresOwnNode': 'bool get requiresOwnNode',
      'stringAttributes': 'List<ui.StringAttribute> get stringAttributes',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'placeholder': 'InlineSpanSemanticsInformation get placeholder',
    },
  );
}

// =============================================================================
// InlineSpan Bridge
// =============================================================================

BridgedClass _createInlineSpanBridge() {
  return BridgedClass(
    nativeType: $flutter_35.InlineSpan,
    name: 'InlineSpan',
    constructors: {
    },
    getters: {
      'style': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan').style,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan').hashCode,
    },
    methods: {
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'build');
        final builder = D4.getRequiredArg<ParagraphBuilder>(positional, 0, 'builder', 'build');
        final textScaler = D4.getNamedArgWithDefault<$flutter_49.TextScaler>(named, 'textScaler', $flutter_49.TextScaler.noScaling);
        final dimensions = D4.coerceListOrNull<$flutter_48.PlaceholderDimensions>(named['dimensions'], 'dimensions');
        (t as dynamic).build(builder, textScaler: textScaler, dimensions: dimensions);
        return null;
      },
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitChildren(($flutter_35.InlineSpan p0) { return D4.callInterpreterCallback(visitor, visitor_Raw, [p0]) as bool; });
      },
      'visitDirectChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'visitDirectChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitDirectChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitDirectChildren(($flutter_35.InlineSpan p0) { return D4.callInterpreterCallback(visitor, visitor_Raw, [p0]) as bool; });
      },
      'getSpanForPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'getSpanForPosition');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPosition');
        return t.getSpanForPosition(position);
      },
      'toPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        return t.toPlainText(includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
      },
      'getSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        return t.getSemanticsInformation();
      },
      'codeUnitAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'codeUnitAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAt');
        return t.codeUnitAt(index);
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        return t.debugAssertIsValid();
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_35.InlineSpan>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.InlineSpan>(target, 'InlineSpan');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'build': 'void build(ui.ParagraphBuilder builder, {TextScaler textScaler = TextScaler.noScaling, List<PlaceholderDimensions>? dimensions})',
      'visitChildren': 'bool visitChildren(InlineSpanVisitor visitor)',
      'visitDirectChildren': 'bool visitDirectChildren(InlineSpanVisitor visitor)',
      'getSpanForPosition': 'InlineSpan? getSpanForPosition(TextPosition position)',
      'toPlainText': 'String toPlainText({bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'getSemanticsInformation': 'List<InlineSpanSemanticsInformation> getSemanticsInformation()',
      'codeUnitAt': 'int? codeUnitAt(int index)',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'compareTo': 'RenderComparison compareTo(InlineSpan other)',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
    },
    getterSignatures: {
      'style': 'TextStyle? get style',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// LinearBorderEdge Bridge
// =============================================================================

BridgedClass _createLinearBorderEdgeBridge() {
  return BridgedClass(
    nativeType: $flutter_36.LinearBorderEdge,
    name: 'LinearBorderEdge',
    constructors: {
      '': (visitor, positional, named) {
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        return $flutter_36.LinearBorderEdge(size: size, alignment: alignment);
      },
    },
    getters: {
      'size': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorderEdge>(target, 'LinearBorderEdge').size,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorderEdge>(target, 'LinearBorderEdge').alignment,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorderEdge>(target, 'LinearBorderEdge').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorderEdge>(target, 'LinearBorderEdge');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorderEdge>(target, 'LinearBorderEdge');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_36.LinearBorderEdge?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_36.LinearBorderEdge?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_36.LinearBorderEdge.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const LinearBorderEdge({double size = 1.0, double alignment = 0.0})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'size': 'double get size',
      'alignment': 'double get alignment',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'LinearBorderEdge? lerp(LinearBorderEdge? a, LinearBorderEdge? b, double t)',
    },
  );
}

// =============================================================================
// LinearBorder Bridge
// =============================================================================

BridgedClass _createLinearBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_36.LinearBorder,
    name: 'LinearBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final start = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'start');
        final end = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'end');
        final top = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'top');
        final bottom = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'bottom');
        return $flutter_36.LinearBorder(side: side, start: start, end: end, top: top, bottom: bottom);
      },
      'start': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_36.LinearBorder.start(side: side, alignment: alignment, size: size);
      },
      'end': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_36.LinearBorder.end(side: side, alignment: alignment, size: size);
      },
      'top': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_36.LinearBorder.top(side: side, alignment: alignment, size: size);
      },
      'bottom': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_36.LinearBorder.bottom(side: side, alignment: alignment, size: size);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').side,
      'start': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').end,
      'top': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').bottom,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final start = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'start');
        final end = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'end');
        final top = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'top');
        final bottom = D4.getOptionalNamedArg<$flutter_36.LinearBorderEdge?>(named, 'bottom');
        return t.copyWith(side: side, start: start, end: end, top: top, bottom: bottom);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.LinearBorder>(target, 'LinearBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'none': (visitor) => $flutter_36.LinearBorder.none,
    },
    constructorSignatures: {
      '': 'const LinearBorder({BorderSide side = BorderSide.none, LinearBorderEdge? start, LinearBorderEdge? end, LinearBorderEdge? top, LinearBorderEdge? bottom})',
      'start': 'LinearBorder.start({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
      'end': 'LinearBorder.end({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
      'top': 'LinearBorder.top({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
      'bottom': 'LinearBorder.bottom({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
    },
    methodSignatures: {
      'scale': 'LinearBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'LinearBorder copyWith({BorderSide? side, LinearBorderEdge? start, LinearBorderEdge? end, LinearBorderEdge? top, LinearBorderEdge? bottom})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'start': 'LinearBorderEdge? get start',
      'end': 'LinearBorderEdge? get end',
      'top': 'LinearBorderEdge? get top',
      'bottom': 'LinearBorderEdge? get bottom',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'none': 'LinearBorder get none',
    },
  );
}

// =============================================================================
// MatrixUtils Bridge
// =============================================================================

BridgedClass _createMatrixUtilsBridge() {
  return BridgedClass(
    nativeType: $flutter_37.MatrixUtils,
    name: 'MatrixUtils',
    constructors: {
    },
    staticMethods: {
      'getAsTranslation': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getAsTranslation');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'getAsTranslation');
        return $flutter_37.MatrixUtils.getAsTranslation(transform);
      },
      'getAsScale': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getAsScale');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'getAsScale');
        return $flutter_37.MatrixUtils.getAsScale(transform);
      },
      'matrixEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'matrixEquals');
        final a = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'a', 'matrixEquals');
        final b = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 1, 'b', 'matrixEquals');
        return $flutter_37.MatrixUtils.matrixEquals(a, b);
      },
      'isIdentity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isIdentity');
        final a = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'a', 'isIdentity');
        return $flutter_37.MatrixUtils.isIdentity(a);
      },
      'transformPoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transformPoint');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'transformPoint');
        final point = D4.getRequiredArg<Offset>(positional, 1, 'point', 'transformPoint');
        return $flutter_37.MatrixUtils.transformPoint(transform, point);
      },
      'transformRect': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transformRect');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'transformRect');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'transformRect');
        return $flutter_37.MatrixUtils.transformRect(transform, rect);
      },
      'inverseTransformRect': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'inverseTransformRect');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'inverseTransformRect');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'inverseTransformRect');
        return $flutter_37.MatrixUtils.inverseTransformRect(transform, rect);
      },
      'createCylindricalProjectionTransform': (visitor, positional, named, typeArgs) {
        final radius = D4.getRequiredNamedArg<double>(named, 'radius', 'createCylindricalProjectionTransform');
        final angle = D4.getRequiredNamedArg<double>(named, 'angle', 'createCylindricalProjectionTransform');
        final perspective = D4.getNamedArgWithDefault<double>(named, 'perspective', 0.001);
        final orientation = D4.getNamedArgWithDefault<$flutter_9.Axis>(named, 'orientation', $flutter_9.Axis.vertical);
        return $flutter_37.MatrixUtils.createCylindricalProjectionTransform(radius: radius, angle: angle, perspective: perspective, orientation: orientation);
      },
      'forceToPoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'forceToPoint');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'forceToPoint');
        return $flutter_37.MatrixUtils.forceToPoint(offset);
      },
    },
    staticMethodSignatures: {
      'getAsTranslation': 'Offset? getAsTranslation(Matrix4 transform)',
      'getAsScale': 'double? getAsScale(Matrix4 transform)',
      'matrixEquals': 'bool matrixEquals(Matrix4? a, Matrix4? b)',
      'isIdentity': 'bool isIdentity(Matrix4 a)',
      'transformPoint': 'Offset transformPoint(Matrix4 transform, Offset point)',
      'transformRect': 'Rect transformRect(Matrix4 transform, Rect rect)',
      'inverseTransformRect': 'Rect inverseTransformRect(Matrix4 transform, Rect rect)',
      'createCylindricalProjectionTransform': 'Matrix4 createCylindricalProjectionTransform({required double radius, required double angle, double perspective = 0.001, Axis orientation = Axis.vertical})',
      'forceToPoint': 'Matrix4 forceToPoint(Offset offset)',
    },
  );
}

// =============================================================================
// TransformProperty Bridge
// =============================================================================

BridgedClass _createTransformPropertyBridge() {
  return BridgedClass(
    nativeType: $flutter_37.TransformProperty,
    name: 'TransformProperty',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TransformProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TransformProperty');
        final value = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 1, 'value', 'TransformProperty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final level = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'level', $flutter_3.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_37.TransformProperty(name, value, showName: showName, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'TransformProperty');
          return $flutter_37.TransformProperty(name, value, showName: showName, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty').allowTruncate,
    },
    methods: {
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_3.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.TransformProperty>(target, 'TransformProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, parentConfiguration: parentConfiguration, minLevel: minLevel, wrapWidth: wrapWidth);
      },
    },
    constructorSignatures: {
      '': 'TransformProperty(String name, Matrix4? value, {bool showName = true, Object? defaultValue = kNoDefaultValue, DiagnosticLevel level = DiagnosticLevel.info})',
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
      'expandableValue': 'bool get expandableValue',
      'allowWrap': 'bool get allowWrap',
      'allowNameWrap': 'bool get allowNameWrap',
      'ifNull': 'String? get ifNull',
      'ifEmpty': 'String? get ifEmpty',
      'tooltip': 'String? get tooltip',
      'missingIfNull': 'bool get missingIfNull',
      'propertyType': 'Type get propertyType',
      'value': 'Matrix4 get value',
      'exception': 'Object? get exception',
      'defaultValue': 'Object? get defaultValue',
      'isInteresting': 'bool get isInteresting',
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
// NotchedShape Bridge
// =============================================================================

BridgedClass _createNotchedShapeBridge() {
  return BridgedClass(
    nativeType: $flutter_38.NotchedShape,
    name: 'NotchedShape',
    constructors: {
    },
    methods: {
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.NotchedShape>(target, 'NotchedShape');
        D4.requireMinArgs(positional, 2, 'getOuterPath');
        final host = D4.getRequiredArg<Rect>(positional, 0, 'host', 'getOuterPath');
        final guest = D4.getRequiredArg<Rect?>(positional, 1, 'guest', 'getOuterPath');
        return t.getOuterPath(host, guest);
      },
    },
    methodSignatures: {
      'getOuterPath': 'Path getOuterPath(Rect host, Rect? guest)',
    },
  );
}

// =============================================================================
// CircularNotchedRectangle Bridge
// =============================================================================

BridgedClass _createCircularNotchedRectangleBridge() {
  return BridgedClass(
    nativeType: $flutter_38.CircularNotchedRectangle,
    name: 'CircularNotchedRectangle',
    constructors: {
      '': (visitor, positional, named) {
        final inverted = D4.getNamedArgWithDefault<bool>(named, 'inverted', false);
        return $flutter_38.CircularNotchedRectangle(inverted: inverted);
      },
    },
    getters: {
      'inverted': (visitor, target) => D4.validateTarget<$flutter_38.CircularNotchedRectangle>(target, 'CircularNotchedRectangle').inverted,
    },
    methods: {
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.CircularNotchedRectangle>(target, 'CircularNotchedRectangle');
        D4.requireMinArgs(positional, 2, 'getOuterPath');
        final host = D4.getRequiredArg<Rect>(positional, 0, 'host', 'getOuterPath');
        final guest = D4.getRequiredArg<Rect?>(positional, 1, 'guest', 'getOuterPath');
        return t.getOuterPath(host, guest);
      },
    },
    constructorSignatures: {
      '': 'const CircularNotchedRectangle({bool inverted = false})',
    },
    methodSignatures: {
      'getOuterPath': 'Path getOuterPath(Rect host, Rect? guest)',
    },
    getterSignatures: {
      'inverted': 'bool get inverted',
    },
  );
}

// =============================================================================
// AutomaticNotchedShape Bridge
// =============================================================================

BridgedClass _createAutomaticNotchedShapeBridge() {
  return BridgedClass(
    nativeType: $flutter_38.AutomaticNotchedShape,
    name: 'AutomaticNotchedShape',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AutomaticNotchedShape');
        final host = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'host', 'AutomaticNotchedShape');
        final guest = D4.getOptionalArg<$flutter_13.ShapeBorder?>(positional, 1, 'guest');
        return $flutter_38.AutomaticNotchedShape(host, guest);
      },
    },
    getters: {
      'host': (visitor, target) => D4.validateTarget<$flutter_38.AutomaticNotchedShape>(target, 'AutomaticNotchedShape').host,
      'guest': (visitor, target) => D4.validateTarget<$flutter_38.AutomaticNotchedShape>(target, 'AutomaticNotchedShape').guest,
    },
    methods: {
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.AutomaticNotchedShape>(target, 'AutomaticNotchedShape');
        D4.requireMinArgs(positional, 2, 'getOuterPath');
        final hostRect = D4.getRequiredArg<Rect>(positional, 0, 'hostRect', 'getOuterPath');
        final guestRect = D4.getRequiredArg<Rect?>(positional, 1, 'guestRect', 'getOuterPath');
        return t.getOuterPath(hostRect, guestRect);
      },
    },
    constructorSignatures: {
      '': 'const AutomaticNotchedShape(ShapeBorder host, [ShapeBorder? guest])',
    },
    methodSignatures: {
      'getOuterPath': 'Path getOuterPath(Rect hostRect, Rect? guestRect)',
    },
    getterSignatures: {
      'host': 'ShapeBorder get host',
      'guest': 'ShapeBorder? get guest',
    },
  );
}

// =============================================================================
// OvalBorder Bridge
// =============================================================================

BridgedClass _createOvalBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_39.OvalBorder,
    name: 'OvalBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final eccentricity = D4.getNamedArgWithDefault<double>(named, 'eccentricity', 1.0);
        return $flutter_39.OvalBorder(side: side, eccentricity: eccentricity);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder').side,
      'eccentricity': (visitor, target) => D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder').eccentricity,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final eccentricity = D4.getOptionalNamedArg<double?>(named, 'eccentricity');
        return t.copyWith(side: side, eccentricity: eccentricity);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.OvalBorder>(target, 'OvalBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const OvalBorder({BorderSide side = BorderSide.none, double eccentricity = 1.0})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'OvalBorder copyWith({BorderSide? side, double? eccentricity})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'eccentricity': 'double get eccentricity',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// PlaceholderSpan Bridge
// =============================================================================

BridgedClass _createPlaceholderSpanBridge() {
  return BridgedClass(
    nativeType: $flutter_41.PlaceholderSpan,
    name: 'PlaceholderSpan',
    constructors: {
    },
    getters: {
      'style': (visitor, target) => D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan').style,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan').hashCode,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan').alignment,
      'baseline': (visitor, target) => D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan').baseline,
    },
    methods: {
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'build');
        final builder = D4.getRequiredArg<ParagraphBuilder>(positional, 0, 'builder', 'build');
        final textScaler = D4.getNamedArgWithDefault<$flutter_49.TextScaler>(named, 'textScaler', $flutter_49.TextScaler.noScaling);
        final dimensions = D4.coerceListOrNull<$flutter_48.PlaceholderDimensions>(named['dimensions'], 'dimensions');
        (t as dynamic).build(builder, textScaler: textScaler, dimensions: dimensions);
        return null;
      },
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitChildren(($flutter_35.InlineSpan p0) { return D4.callInterpreterCallback(visitor, visitor_Raw, [p0]) as bool; });
      },
      'visitDirectChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'visitDirectChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitDirectChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitDirectChildren(($flutter_35.InlineSpan p0) { return D4.callInterpreterCallback(visitor, visitor_Raw, [p0]) as bool; });
      },
      'getSpanForPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'getSpanForPosition');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPosition');
        return t.getSpanForPosition(position);
      },
      'toPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        return t.toPlainText(includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
      },
      'getSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        return t.getSemanticsInformation();
      },
      'codeUnitAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'codeUnitAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAt');
        return t.codeUnitAt(index);
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        return t.debugAssertIsValid();
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_35.InlineSpan>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.PlaceholderSpan>(target, 'PlaceholderSpan');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'placeholderCodeUnit': (visitor) => $flutter_41.PlaceholderSpan.placeholderCodeUnit,
    },
    methodSignatures: {
      'build': 'void build(ParagraphBuilder builder, {TextScaler textScaler = TextScaler.noScaling, List<PlaceholderDimensions>? dimensions})',
      'visitChildren': 'bool visitChildren(bool Function(InlineSpan) visitor)',
      'visitDirectChildren': 'bool visitDirectChildren(bool Function(InlineSpan) visitor)',
      'getSpanForPosition': 'InlineSpan? getSpanForPosition(TextPosition position)',
      'toPlainText': 'String toPlainText({bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'getSemanticsInformation': 'List<InlineSpanSemanticsInformation> getSemanticsInformation()',
      'codeUnitAt': 'int? codeUnitAt(int index)',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'compareTo': 'RenderComparison compareTo(InlineSpan other)',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
    getterSignatures: {
      'style': 'TextStyle? get style',
      'hashCode': 'int get hashCode',
      'alignment': 'ui.PlaceholderAlignment get alignment',
      'baseline': 'TextBaseline? get baseline',
    },
    staticGetterSignatures: {
      'placeholderCodeUnit': 'int get placeholderCodeUnit',
    },
  );
}

// =============================================================================
// RoundedRectangleBorder Bridge
// =============================================================================

BridgedClass _createRoundedRectangleBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_42.RoundedRectangleBorder,
    name: 'RoundedRectangleBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final borderRadius = D4.getNamedArgWithDefault<$flutter_12.BorderRadiusGeometry>(named, 'borderRadius', $flutter_12.BorderRadius.zero);
        return $flutter_42.RoundedRectangleBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const RoundedRectangleBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry borderRadius = BorderRadius.zero})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'RoundedRectangleBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'borderRadius': 'BorderRadiusGeometry get borderRadius',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// RoundedSuperellipseBorder Bridge
// =============================================================================

BridgedClass _createRoundedSuperellipseBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_42.RoundedSuperellipseBorder,
    name: 'RoundedSuperellipseBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadiusGeometry?>(named, 'borderRadius');
        return $flutter_42.RoundedSuperellipseBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_12.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_42.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const RoundedSuperellipseBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry? borderRadius})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'RoundedSuperellipseBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'borderRadius': 'BorderRadiusGeometry get borderRadius',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ShaderWarmUp Bridge
// =============================================================================

BridgedClass _createShaderWarmUpBridge() {
  return BridgedClass(
    nativeType: $flutter_43.ShaderWarmUp,
    name: 'ShaderWarmUp',
    constructors: {
    },
    getters: {
      'size': (visitor, target) => D4.validateTarget<$flutter_43.ShaderWarmUp>(target, 'ShaderWarmUp').size,
    },
    methods: {
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.ShaderWarmUp>(target, 'ShaderWarmUp');
        return t.execute();
      },
    },
    methodSignatures: {
      'execute': 'Future<void> execute()',
    },
    getterSignatures: {
      'size': 'ui.Size get size',
    },
  );
}

// =============================================================================
// ShapeDecoration Bridge
// =============================================================================

BridgedClass _createShapeDecorationBridge() {
  return BridgedClass(
    nativeType: $flutter_44.ShapeDecoration,
    name: 'ShapeDecoration',
    constructors: {
      '': (visitor, positional, named) {
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final image = D4.getOptionalNamedArg<$flutter_24.DecorationImage?>(named, 'image');
        final gradient = D4.getOptionalNamedArg<$flutter_29.Gradient?>(named, 'gradient');
        final shadows = D4.coerceListOrNull<$flutter_17.BoxShadow>(named['shadows'], 'shadows');
        final shape = D4.getRequiredNamedArg<$flutter_13.ShapeBorder>(named, 'shape', 'ShapeDecoration');
        return $flutter_44.ShapeDecoration(color: color, image: image, gradient: gradient, shadows: shadows, shape: shape);
      },
      'fromBoxDecoration': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ShapeDecoration');
        final source = D4.getRequiredArg<$flutter_15.BoxDecoration>(positional, 0, 'source', 'ShapeDecoration');
        return $flutter_44.ShapeDecoration.fromBoxDecoration(source);
      },
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').isComplex,
      'color': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').color,
      'gradient': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').gradient,
      'image': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').image,
      'shadows': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').shadows,
      'shape': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').shape,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        return t.debugAssertIsValid();
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(onChangedRaw == null ? null : () { D4.callInterpreterCallback(visitor, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ShapeDecoration>(target, 'ShapeDecoration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_44.ShapeDecoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_44.ShapeDecoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_44.ShapeDecoration.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const ShapeDecoration({Color? color, DecorationImage? image, Gradient? gradient, List<BoxShadow>? shadows, required ShapeBorder shape})',
      'fromBoxDecoration': 'factory ShapeDecoration.fromBoxDecoration(BoxDecoration source)',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback? onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'padding': 'EdgeInsetsGeometry get padding',
      'isComplex': 'bool get isComplex',
      'color': 'Color? get color',
      'gradient': 'Gradient? get gradient',
      'image': 'DecorationImage? get image',
      'shadows': 'List<BoxShadow>? get shadows',
      'shape': 'ShapeBorder get shape',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'ShapeDecoration? lerp(ShapeDecoration? a, ShapeDecoration? b, double t)',
    },
  );
}

// =============================================================================
// StadiumBorder Bridge
// =============================================================================

BridgedClass _createStadiumBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_45.StadiumBorder,
    name: 'StadiumBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        return $flutter_45.StadiumBorder(side: side);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder').side,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        return t.copyWith(side: side);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.StadiumBorder>(target, 'StadiumBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const StadiumBorder({BorderSide side = BorderSide.none})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'StadiumBorder copyWith({BorderSide? side})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// StarBorder Bridge
// =============================================================================

BridgedClass _createStarBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_46.StarBorder,
    name: 'StarBorder',
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final points = D4.getNamedArgWithDefault<double>(named, 'points', 5);
        final innerRadiusRatio = D4.getNamedArgWithDefault<double>(named, 'innerRadiusRatio', 0.4);
        final pointRounding = D4.getNamedArgWithDefault<double>(named, 'pointRounding', 0);
        final valleyRounding = D4.getNamedArgWithDefault<double>(named, 'valleyRounding', 0);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0);
        final squash = D4.getNamedArgWithDefault<double>(named, 'squash', 0);
        return $flutter_46.StarBorder(side: side, points: points, innerRadiusRatio: innerRadiusRatio, pointRounding: pointRounding, valleyRounding: valleyRounding, rotation: rotation, squash: squash);
      },
      'polygon': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_13.BorderSide>(named, 'side', $flutter_13.BorderSide.none);
        final sides = D4.getNamedArgWithDefault<double>(named, 'sides', 5);
        final pointRounding = D4.getNamedArgWithDefault<double>(named, 'pointRounding', 0);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0);
        final squash = D4.getNamedArgWithDefault<double>(named, 'squash', 0);
        return $flutter_46.StarBorder.polygon(side: side, sides: sides, pointRounding: pointRounding, rotation: rotation, squash: squash);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').side,
      'points': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').points,
      'innerRadiusRatio': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').innerRadiusRatio,
      'pointRounding': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').pointRounding,
      'valleyRounding': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').valleyRounding,
      'rotation': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').rotation,
      'squash': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').squash,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder').hashCode,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        final side = D4.getOptionalNamedArg<$flutter_13.BorderSide?>(named, 'side');
        final points = D4.getOptionalNamedArg<double?>(named, 'points');
        final innerRadiusRatio = D4.getOptionalNamedArg<double?>(named, 'innerRadiusRatio');
        final pointRounding = D4.getOptionalNamedArg<double?>(named, 'pointRounding');
        final valleyRounding = D4.getOptionalNamedArg<double?>(named, 'valleyRounding');
        final rotation = D4.getOptionalNamedArg<double?>(named, 'rotation');
        final squash = D4.getOptionalNamedArg<double?>(named, 'squash');
        return t.copyWith(side: side, points: points, innerRadiusRatio: innerRadiusRatio, pointRounding: pointRounding, valleyRounding: valleyRounding, rotation: rotation, squash: squash);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_13.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        final other = D4.getRequiredArg<$flutter_13.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.StarBorder>(target, 'StarBorder');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const StarBorder({BorderSide side = BorderSide.none, double points = 5, double innerRadiusRatio = 0.4, double pointRounding = 0, double valleyRounding = 0, double rotation = 0, double squash = 0})',
      'polygon': 'const StarBorder.polygon({BorderSide side = BorderSide.none, double sides = 5, double pointRounding = 0, double rotation = 0, double squash = 0})',
    },
    methodSignatures: {
      'scale': 'ShapeBorder scale(double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'StarBorder copyWith({BorderSide? side, double? points, double? innerRadiusRatio, double? pointRounding, double? valleyRounding, double? rotation, double? squash})',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'points': 'double get points',
      'innerRadiusRatio': 'double get innerRadiusRatio',
      'pointRounding': 'double get pointRounding',
      'valleyRounding': 'double get valleyRounding',
      'rotation': 'double get rotation',
      'squash': 'double get squash',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// StrutStyle Bridge
// =============================================================================

BridgedClass _createStrutStyleBridge() {
  return BridgedClass(
    nativeType: $flutter_47.StrutStyle,
    name: 'StrutStyle',
    constructors: {
      '': (visitor, positional, named) {
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontFamilyFallback = D4.coerceListOrNull<String>(named['fontFamilyFallback'], 'fontFamilyFallback');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final leadingDistribution = D4.getOptionalNamedArg<TextLeadingDistribution?>(named, 'leadingDistribution');
        final leading = D4.getOptionalNamedArg<double?>(named, 'leading');
        final fontWeight = D4.getOptionalNamedArg<FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<FontStyle?>(named, 'fontStyle');
        final forceStrutHeight = D4.getOptionalNamedArg<bool?>(named, 'forceStrutHeight');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        return $flutter_47.StrutStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSize: fontSize, height: height, leadingDistribution: leadingDistribution, leading: leading, fontWeight: fontWeight, fontStyle: fontStyle, forceStrutHeight: forceStrutHeight, debugLabel: debugLabel, package: package);
      },
      'fromTextStyle': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'StrutStyle');
        final textStyle = D4.getRequiredArg<$flutter_51.TextStyle>(positional, 0, 'textStyle', 'StrutStyle');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontFamilyFallback = D4.coerceListOrNull<String>(named['fontFamilyFallback'], 'fontFamilyFallback');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final leadingDistribution = D4.getOptionalNamedArg<TextLeadingDistribution?>(named, 'leadingDistribution');
        final leading = D4.getOptionalNamedArg<double?>(named, 'leading');
        final fontWeight = D4.getOptionalNamedArg<FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<FontStyle?>(named, 'fontStyle');
        final forceStrutHeight = D4.getOptionalNamedArg<bool?>(named, 'forceStrutHeight');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        return $flutter_47.StrutStyle.fromTextStyle(textStyle, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSize: fontSize, height: height, leadingDistribution: leadingDistribution, leading: leading, fontWeight: fontWeight, fontStyle: fontStyle, forceStrutHeight: forceStrutHeight, debugLabel: debugLabel, package: package);
      },
    },
    getters: {
      'fontFamily': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').fontFamily,
      'fontFamilyFallback': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').fontFamilyFallback,
      'fontSize': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').fontSize,
      'height': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').height,
      'leadingDistribution': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').leadingDistribution,
      'fontWeight': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').fontWeight,
      'fontStyle': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').fontStyle,
      'leading': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').leading,
      'forceStrutHeight': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').forceStrutHeight,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').debugLabel,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle').hashCode,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_47.StrutStyle>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'inheritFromTextStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle');
        D4.requireMinArgs(positional, 1, 'inheritFromTextStyle');
        final other = D4.getRequiredArg<$flutter_51.TextStyle?>(positional, 0, 'other', 'inheritFromTextStyle');
        return t.inheritFromTextStyle(other);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StrutStyle>(target, 'StrutStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'disabled': (visitor) => $flutter_47.StrutStyle.disabled,
    },
    constructorSignatures: {
      '': 'const StrutStyle({String? fontFamily, List<String>? fontFamilyFallback, double? fontSize, double? height, TextLeadingDistribution? leadingDistribution, double? leading, FontWeight? fontWeight, FontStyle? fontStyle, bool? forceStrutHeight, String? debugLabel, String? package})',
      'fromTextStyle': 'StrutStyle.fromTextStyle(TextStyle textStyle, {String? fontFamily, List<String>? fontFamilyFallback, double? fontSize, double? height, TextLeadingDistribution? leadingDistribution, double? leading, FontWeight? fontWeight, FontStyle? fontStyle, bool? forceStrutHeight, String? debugLabel, String? package})',
    },
    methodSignatures: {
      'compareTo': 'RenderComparison compareTo(StrutStyle other)',
      'inheritFromTextStyle': 'StrutStyle inheritFromTextStyle(TextStyle? other)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'fontFamily': 'String? get fontFamily',
      'fontFamilyFallback': 'List<String>? get fontFamilyFallback',
      'fontSize': 'double? get fontSize',
      'height': 'double? get height',
      'leadingDistribution': 'TextLeadingDistribution? get leadingDistribution',
      'fontWeight': 'FontWeight? get fontWeight',
      'fontStyle': 'FontStyle? get fontStyle',
      'leading': 'double? get leading',
      'forceStrutHeight': 'bool? get forceStrutHeight',
      'debugLabel': 'String? get debugLabel',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'disabled': 'StrutStyle get disabled',
    },
  );
}

// =============================================================================
// TextSelection Bridge
// =============================================================================

BridgedClass _createTextSelectionBridge() {
  return BridgedClass(
    nativeType: $flutter_62.TextSelection,
    name: 'TextSelection',
    constructors: {
      '': (visitor, positional, named) {
        final baseOffset = D4.getRequiredNamedArg<int>(named, 'baseOffset', 'TextSelection');
        final extentOffset = D4.getRequiredNamedArg<int>(named, 'extentOffset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', TextAffinity.downstream);
        final isDirectional = D4.getNamedArgWithDefault<bool>(named, 'isDirectional', false);
        return $flutter_62.TextSelection(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'collapsed': (visitor, positional, named) {
        final offset = D4.getRequiredNamedArg<int>(named, 'offset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', TextAffinity.downstream);
        return $flutter_62.TextSelection.collapsed(offset: offset, affinity: affinity);
      },
      'fromPosition': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextSelection');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'TextSelection');
        return $flutter_62.TextSelection.fromPosition(position);
      },
    },
    getters: {
      'baseOffset': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').baseOffset,
      'extentOffset': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').extentOffset,
      'affinity': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').affinity,
      'isDirectional': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').isDirectional,
      'base': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').base,
      'extent': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').extent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').end,
      'isValid': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').isValid,
      'isCollapsed': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').isCollapsed,
      'isNormalized': (visitor, target) => D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection').isNormalized,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
        final baseOffset = D4.getOptionalNamedArg<int?>(named, 'baseOffset');
        final extentOffset = D4.getOptionalNamedArg<int?>(named, 'extentOffset');
        final affinity = D4.getOptionalNamedArg<TextAffinity?>(named, 'affinity');
        final isDirectional = D4.getOptionalNamedArg<bool?>(named, 'isDirectional');
        return t.copyWith(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'expandTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'expandTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'expandTo');
        final extentAtIndex = D4.getOptionalArgWithDefault<bool>(positional, 1, 'extentAtIndex', false);
        return t.expandTo(position, extentAtIndex);
      },
      'extendTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'extendTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'extendTo');
        return t.extendTo(position);
      },
      'textBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textBefore');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textBefore');
        return t.textBefore(text);
      },
      'textAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textAfter');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textAfter');
        return t.textAfter(text);
      },
      'textInside': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textInside');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textInside');
        return t.textInside(text);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_62.TextSelection>(target, 'TextSelection');
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
// PlaceholderDimensions Bridge
// =============================================================================

BridgedClass _createPlaceholderDimensionsBridge() {
  return BridgedClass(
    nativeType: $flutter_48.PlaceholderDimensions,
    name: 'PlaceholderDimensions',
    constructors: {
      '': (visitor, positional, named) {
        final size = D4.getRequiredNamedArg<Size>(named, 'size', 'PlaceholderDimensions');
        final alignment = D4.getRequiredNamedArg<PlaceholderAlignment>(named, 'alignment', 'PlaceholderDimensions');
        final baseline = D4.getOptionalNamedArg<TextBaseline?>(named, 'baseline');
        final baselineOffset = D4.getOptionalNamedArg<double?>(named, 'baselineOffset');
        return $flutter_48.PlaceholderDimensions(size: size, alignment: alignment, baseline: baseline, baselineOffset: baselineOffset);
      },
    },
    getters: {
      'size': (visitor, target) => D4.validateTarget<$flutter_48.PlaceholderDimensions>(target, 'PlaceholderDimensions').size,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_48.PlaceholderDimensions>(target, 'PlaceholderDimensions').alignment,
      'baselineOffset': (visitor, target) => D4.validateTarget<$flutter_48.PlaceholderDimensions>(target, 'PlaceholderDimensions').baselineOffset,
      'baseline': (visitor, target) => D4.validateTarget<$flutter_48.PlaceholderDimensions>(target, 'PlaceholderDimensions').baseline,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_48.PlaceholderDimensions>(target, 'PlaceholderDimensions').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.PlaceholderDimensions>(target, 'PlaceholderDimensions');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.PlaceholderDimensions>(target, 'PlaceholderDimensions');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'empty': (visitor) => $flutter_48.PlaceholderDimensions.empty,
    },
    constructorSignatures: {
      '': 'const PlaceholderDimensions({required Size size, required PlaceholderAlignment alignment, TextBaseline? baseline, double? baselineOffset})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'size': 'Size get size',
      'alignment': 'ui.PlaceholderAlignment get alignment',
      'baselineOffset': 'double? get baselineOffset',
      'baseline': 'TextBaseline? get baseline',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'empty': 'PlaceholderDimensions get empty',
    },
  );
}

// =============================================================================
// WordBoundary Bridge
// =============================================================================

BridgedClass _createWordBoundaryBridge() {
  return BridgedClass(
    nativeType: $flutter_48.WordBoundary,
    name: 'WordBoundary',
    constructors: {
    },
    getters: {
      'moveByWordBoundary': (visitor, target) => D4.validateTarget<$flutter_48.WordBoundary>(target, 'WordBoundary').moveByWordBoundary,
    },
    methods: {
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.WordBoundary>(target, 'WordBoundary');
        D4.requireMinArgs(positional, 1, 'getTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTextBoundaryAt');
        return t.getTextBoundaryAt(position);
      },
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.WordBoundary>(target, 'WordBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.WordBoundary>(target, 'WordBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
    },
    methodSignatures: {
      'getTextBoundaryAt': 'TextRange getTextBoundaryAt(int position)',
      'getLeadingTextBoundaryAt': 'int? getLeadingTextBoundaryAt(int position)',
      'getTrailingTextBoundaryAt': 'int? getTrailingTextBoundaryAt(int position)',
    },
    getterSignatures: {
      'moveByWordBoundary': 'TextBoundary get moveByWordBoundary',
    },
  );
}

// =============================================================================
// TextPainter Bridge
// =============================================================================

BridgedClass _createTextPainterBridge() {
  return BridgedClass(
    nativeType: $flutter_48.TextPainter,
    name: 'TextPainter',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getOptionalNamedArg<$flutter_35.InlineSpan?>(named, 'text');
        final textAlign = D4.getNamedArgWithDefault<TextAlign>(named, 'textAlign', TextAlign.start);
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final strutStyle = D4.getOptionalNamedArg<$flutter_47.StrutStyle?>(named, 'strutStyle');
        final textWidthBasis = D4.getNamedArgWithDefault<$flutter_48.TextWidthBasis>(named, 'textWidthBasis', $flutter_48.TextWidthBasis.parent);
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        if (!named.containsKey('textScaler')) {
          return $flutter_48.TextPainter(text: text, textAlign: textAlign, textDirection: textDirection, textScaleFactor: textScaleFactor, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior);
        }
        if (named.containsKey('textScaler')) {
          final textScaler = D4.getRequiredNamedArg<$flutter_49.TextScaler>(named, 'textScaler', 'TextPainter');
          return $flutter_48.TextPainter(text: text, textAlign: textAlign, textDirection: textDirection, textScaleFactor: textScaleFactor, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, textScaler: textScaler);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').text,
      'plainText': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').plainText,
      'textAlign': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textAlign,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textDirection,
      'textScaleFactor': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textScaleFactor,
      'textScaler': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textScaler,
      'ellipsis': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').ellipsis,
      'locale': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').locale,
      'maxLines': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').maxLines,
      'strutStyle': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').strutStyle,
      'textWidthBasis': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textWidthBasis,
      'textHeightBehavior': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textHeightBehavior,
      'inlinePlaceholderBoxes': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').inlinePlaceholderBoxes,
      'preferredLineHeight': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').preferredLineHeight,
      'minIntrinsicWidth': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').minIntrinsicWidth,
      'maxIntrinsicWidth': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').maxIntrinsicWidth,
      'width': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').width,
      'height': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').height,
      'size': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').size,
      'didExceedMaxLines': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').didExceedMaxLines,
      'debugPaintTextLayoutBoxes': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').debugPaintTextLayoutBoxes,
      'wordBoundaries': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').wordBoundaries,
      'debugDisposed': (visitor, target) => D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').debugDisposed,
    },
    setters: {
      'text': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').text = value as dynamic,
      'textAlign': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textAlign = value as dynamic,
      'textDirection': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textDirection = value as dynamic,
      'textScaleFactor': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textScaleFactor = value as dynamic,
      'textScaler': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textScaler = value as dynamic,
      'ellipsis': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').ellipsis = value as dynamic,
      'locale': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').locale = value as dynamic,
      'maxLines': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').maxLines = value as dynamic,
      'strutStyle': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').strutStyle = value as dynamic,
      'textWidthBasis': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textWidthBasis = value as dynamic,
      'textHeightBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').textHeightBehavior = value as dynamic,
      'debugPaintTextLayoutBoxes': (visitor, target, value) => 
        D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter').debugPaintTextLayoutBoxes = value as bool,
    },
    methods: {
      'markNeedsLayout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        t.markNeedsLayout();
        return null;
      },
      'setPlaceholderDimensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'setPlaceholderDimensions');
        if (positional.isEmpty) {
          throw ArgumentError('setPlaceholderDimensions: Missing required argument "value" at position 0');
        }
        final value = D4.coerceListOrNull<$flutter_48.PlaceholderDimensions>(positional[0], 'value');
        t.setPlaceholderDimensions(value);
        return null;
      },
      'computeDistanceToActualBaseline': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'computeDistanceToActualBaseline');
        final baseline = D4.getRequiredArg<TextBaseline>(positional, 0, 'baseline', 'computeDistanceToActualBaseline');
        return t.computeDistanceToActualBaseline(baseline);
      },
      'layout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        final minWidth = D4.getNamedArgWithDefault<double>(named, 'minWidth', 0.0);
        if (!named.containsKey('maxWidth')) {
          t.layout(minWidth: minWidth);
          return null;
        }
        if (named.containsKey('maxWidth')) {
          final maxWidth = D4.getRequiredNamedArg<double>(named, 'maxWidth', 'layout');
          t.layout(minWidth: minWidth, maxWidth: maxWidth);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final offset = D4.getRequiredArg<Offset>(positional, 1, 'offset', 'paint');
        t.paint(canvas, offset);
        return null;
      },
      'getOffsetAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getOffsetAfter');
        final offset = D4.getRequiredArg<int>(positional, 0, 'offset', 'getOffsetAfter');
        return t.getOffsetAfter(offset);
      },
      'getOffsetBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getOffsetBefore');
        final offset = D4.getRequiredArg<int>(positional, 0, 'offset', 'getOffsetBefore');
        return t.getOffsetBefore(offset);
      },
      'getOffsetForCaret': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 2, 'getOffsetForCaret');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getOffsetForCaret');
        final caretPrototype = D4.getRequiredArg<Rect>(positional, 1, 'caretPrototype', 'getOffsetForCaret');
        return t.getOffsetForCaret(position, caretPrototype);
      },
      'getFullHeightForCaret': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 2, 'getFullHeightForCaret');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getFullHeightForCaret');
        final caretPrototype = D4.getRequiredArg<Rect>(positional, 1, 'caretPrototype', 'getFullHeightForCaret');
        return t.getFullHeightForCaret(position, caretPrototype);
      },
      'getBoxesForSelection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getBoxesForSelection');
        final selection = D4.getRequiredArg<$flutter_62.TextSelection>(positional, 0, 'selection', 'getBoxesForSelection');
        if (!named.containsKey('boxHeightStyle') && !named.containsKey('boxWidthStyle')) {
          return t.getBoxesForSelection(selection);
        }
        if (named.containsKey('boxHeightStyle') && !named.containsKey('boxWidthStyle')) {
          final boxHeightStyle = D4.getRequiredNamedArg<BoxHeightStyle>(named, 'boxHeightStyle', 'getBoxesForSelection');
          return t.getBoxesForSelection(selection, boxHeightStyle: boxHeightStyle);
        }
        if (!named.containsKey('boxHeightStyle') && named.containsKey('boxWidthStyle')) {
          final boxWidthStyle = D4.getRequiredNamedArg<BoxWidthStyle>(named, 'boxWidthStyle', 'getBoxesForSelection');
          return t.getBoxesForSelection(selection, boxWidthStyle: boxWidthStyle);
        }
        if (named.containsKey('boxHeightStyle') && named.containsKey('boxWidthStyle')) {
          final boxHeightStyle = D4.getRequiredNamedArg<BoxHeightStyle>(named, 'boxHeightStyle', 'getBoxesForSelection');
          final boxWidthStyle = D4.getRequiredNamedArg<BoxWidthStyle>(named, 'boxWidthStyle', 'getBoxesForSelection');
          return t.getBoxesForSelection(selection, boxHeightStyle: boxHeightStyle, boxWidthStyle: boxWidthStyle);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'getClosestGlyphForOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getClosestGlyphForOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'getClosestGlyphForOffset');
        return t.getClosestGlyphForOffset(offset);
      },
      'getPositionForOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getPositionForOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'getPositionForOffset');
        return t.getPositionForOffset(offset);
      },
      'getWordBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getWordBoundary');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getWordBoundary');
        return t.getWordBoundary(position);
      },
      'getLineBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getLineBoundary');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getLineBoundary');
        return t.getLineBoundary(position);
      },
      'computeLineMetrics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        return t.computeLineMetrics();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextPainter>(target, 'TextPainter');
        (t as dynamic).dispose();
        return null;
      },
    },
    staticMethods: {
      'computeWidth': (visitor, positional, named, typeArgs) {
        final text = D4.getRequiredNamedArg<$flutter_35.InlineSpan>(named, 'text', 'computeWidth');
        final textDirection = D4.getRequiredNamedArg<TextDirection>(named, 'textDirection', 'computeWidth');
        final textAlign = D4.getNamedArgWithDefault<TextAlign>(named, 'textAlign', TextAlign.start);
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final textScaler = D4.getNamedArgWithDefault<$flutter_49.TextScaler>(named, 'textScaler', $flutter_49.TextScaler.noScaling);
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final strutStyle = D4.getOptionalNamedArg<$flutter_47.StrutStyle?>(named, 'strutStyle');
        final textWidthBasis = D4.getNamedArgWithDefault<$flutter_48.TextWidthBasis>(named, 'textWidthBasis', $flutter_48.TextWidthBasis.parent);
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        final minWidth = D4.getNamedArgWithDefault<double>(named, 'minWidth', 0.0);
        if (!named.containsKey('maxWidth')) {
          return $flutter_48.TextPainter.computeWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth);
        }
        if (named.containsKey('maxWidth')) {
          final maxWidth = D4.getRequiredNamedArg<double>(named, 'maxWidth', 'computeWidth');
          return $flutter_48.TextPainter.computeWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth, maxWidth: maxWidth);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'computeMaxIntrinsicWidth': (visitor, positional, named, typeArgs) {
        final text = D4.getRequiredNamedArg<$flutter_35.InlineSpan>(named, 'text', 'computeMaxIntrinsicWidth');
        final textDirection = D4.getRequiredNamedArg<TextDirection>(named, 'textDirection', 'computeMaxIntrinsicWidth');
        final textAlign = D4.getNamedArgWithDefault<TextAlign>(named, 'textAlign', TextAlign.start);
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final textScaler = D4.getNamedArgWithDefault<$flutter_49.TextScaler>(named, 'textScaler', $flutter_49.TextScaler.noScaling);
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final strutStyle = D4.getOptionalNamedArg<$flutter_47.StrutStyle?>(named, 'strutStyle');
        final textWidthBasis = D4.getNamedArgWithDefault<$flutter_48.TextWidthBasis>(named, 'textWidthBasis', $flutter_48.TextWidthBasis.parent);
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        final minWidth = D4.getNamedArgWithDefault<double>(named, 'minWidth', 0.0);
        if (!named.containsKey('maxWidth')) {
          return $flutter_48.TextPainter.computeMaxIntrinsicWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth);
        }
        if (named.containsKey('maxWidth')) {
          final maxWidth = D4.getRequiredNamedArg<double>(named, 'maxWidth', 'computeMaxIntrinsicWidth');
          return $flutter_48.TextPainter.computeMaxIntrinsicWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth, maxWidth: maxWidth);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'isHighSurrogate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isHighSurrogate');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'isHighSurrogate');
        return $flutter_48.TextPainter.isHighSurrogate(value);
      },
      'isLowSurrogate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isLowSurrogate');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'isLowSurrogate');
        return $flutter_48.TextPainter.isLowSurrogate(value);
      },
    },
    constructorSignatures: {
      '': 'TextPainter({InlineSpan? text, TextAlign textAlign = TextAlign.start, TextDirection? textDirection, double textScaleFactor = 1.0, TextScaler textScaler = const _UnspecifiedTextScaler(), int? maxLines, String? ellipsis, Locale? locale, StrutStyle? strutStyle, TextWidthBasis textWidthBasis = TextWidthBasis.parent, TextHeightBehavior? textHeightBehavior})',
    },
    methodSignatures: {
      'markNeedsLayout': 'void markNeedsLayout()',
      'setPlaceholderDimensions': 'void setPlaceholderDimensions(List<PlaceholderDimensions>? value)',
      'computeDistanceToActualBaseline': 'double computeDistanceToActualBaseline(TextBaseline baseline)',
      'layout': 'void layout({double minWidth = 0.0, double maxWidth = double.infinity})',
      'paint': 'void paint(Canvas canvas, Offset offset)',
      'getOffsetAfter': 'int? getOffsetAfter(int offset)',
      'getOffsetBefore': 'int? getOffsetBefore(int offset)',
      'getOffsetForCaret': 'Offset getOffsetForCaret(TextPosition position, Rect caretPrototype)',
      'getFullHeightForCaret': 'double getFullHeightForCaret(TextPosition position, Rect caretPrototype)',
      'getBoxesForSelection': 'List<TextBox> getBoxesForSelection(TextSelection selection, {ui.BoxHeightStyle boxHeightStyle = ui.BoxHeightStyle.tight, ui.BoxWidthStyle boxWidthStyle = ui.BoxWidthStyle.tight})',
      'getClosestGlyphForOffset': 'ui.GlyphInfo? getClosestGlyphForOffset(Offset offset)',
      'getPositionForOffset': 'TextPosition getPositionForOffset(Offset offset)',
      'getWordBoundary': 'TextRange getWordBoundary(TextPosition position)',
      'getLineBoundary': 'TextRange getLineBoundary(TextPosition position)',
      'computeLineMetrics': 'List<ui.LineMetrics> computeLineMetrics()',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'text': 'InlineSpan? get text',
      'plainText': 'String get plainText',
      'textAlign': 'TextAlign get textAlign',
      'textDirection': 'TextDirection? get textDirection',
      'textScaleFactor': 'double get textScaleFactor',
      'textScaler': 'TextScaler get textScaler',
      'ellipsis': 'String? get ellipsis',
      'locale': 'Locale? get locale',
      'maxLines': 'int? get maxLines',
      'strutStyle': 'StrutStyle? get strutStyle',
      'textWidthBasis': 'TextWidthBasis get textWidthBasis',
      'textHeightBehavior': 'TextHeightBehavior? get textHeightBehavior',
      'inlinePlaceholderBoxes': 'List<TextBox>? get inlinePlaceholderBoxes',
      'preferredLineHeight': 'double get preferredLineHeight',
      'minIntrinsicWidth': 'double get minIntrinsicWidth',
      'maxIntrinsicWidth': 'double get maxIntrinsicWidth',
      'width': 'double get width',
      'height': 'double get height',
      'size': 'Size get size',
      'didExceedMaxLines': 'bool get didExceedMaxLines',
      'debugPaintTextLayoutBoxes': 'bool get debugPaintTextLayoutBoxes',
      'wordBoundaries': 'WordBoundary get wordBoundaries',
      'debugDisposed': 'bool get debugDisposed',
    },
    setterSignatures: {
      'text': 'set text(InlineSpan? value)',
      'textAlign': 'set textAlign(TextAlign value)',
      'textDirection': 'set textDirection(TextDirection? value)',
      'textScaleFactor': 'set textScaleFactor(double value)',
      'textScaler': 'set textScaler(TextScaler value)',
      'ellipsis': 'set ellipsis(String? value)',
      'locale': 'set locale(Locale? value)',
      'maxLines': 'set maxLines(int? value)',
      'strutStyle': 'set strutStyle(StrutStyle? value)',
      'textWidthBasis': 'set textWidthBasis(TextWidthBasis value)',
      'textHeightBehavior': 'set textHeightBehavior(TextHeightBehavior? value)',
      'debugPaintTextLayoutBoxes': 'set debugPaintTextLayoutBoxes(dynamic value)',
    },
    staticMethodSignatures: {
      'computeWidth': 'double computeWidth({required InlineSpan text, required TextDirection textDirection, TextAlign textAlign = TextAlign.start, double textScaleFactor = 1.0, TextScaler textScaler = TextScaler.noScaling, int? maxLines, String? ellipsis, Locale? locale, StrutStyle? strutStyle, TextWidthBasis textWidthBasis = TextWidthBasis.parent, TextHeightBehavior? textHeightBehavior, double minWidth = 0.0, double maxWidth = double.infinity})',
      'computeMaxIntrinsicWidth': 'double computeMaxIntrinsicWidth({required InlineSpan text, required TextDirection textDirection, TextAlign textAlign = TextAlign.start, double textScaleFactor = 1.0, TextScaler textScaler = TextScaler.noScaling, int? maxLines, String? ellipsis, Locale? locale, StrutStyle? strutStyle, TextWidthBasis textWidthBasis = TextWidthBasis.parent, TextHeightBehavior? textHeightBehavior, double minWidth = 0.0, double maxWidth = double.infinity})',
      'isHighSurrogate': 'bool isHighSurrogate(int value)',
      'isLowSurrogate': 'bool isLowSurrogate(int value)',
    },
  );
}

// =============================================================================
// TextScaler Bridge
// =============================================================================

BridgedClass _createTextScalerBridge() {
  return BridgedClass(
    nativeType: $flutter_49.TextScaler,
    name: 'TextScaler',
    constructors: {
      'linear': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextScaler');
        final textScaleFactor = D4.getRequiredArg<double>(positional, 0, 'textScaleFactor', 'TextScaler');
        return $flutter_49.TextScaler.linear(textScaleFactor);
      },
    },
    getters: {
      'textScaleFactor': (visitor, target) => D4.validateTarget<$flutter_49.TextScaler>(target, 'TextScaler').textScaleFactor,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.TextScaler>(target, 'TextScaler');
        D4.requireMinArgs(positional, 1, 'scale');
        final fontSize = D4.getRequiredArg<double>(positional, 0, 'fontSize', 'scale');
        return t.scale(fontSize);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.TextScaler>(target, 'TextScaler');
        final minScaleFactor = D4.getNamedArgWithDefault<double>(named, 'minScaleFactor', 0);
        if (!named.containsKey('maxScaleFactor')) {
          return t.clamp(minScaleFactor: minScaleFactor);
        }
        if (named.containsKey('maxScaleFactor')) {
          final maxScaleFactor = D4.getRequiredNamedArg<double>(named, 'maxScaleFactor', 'clamp');
          return t.clamp(minScaleFactor: minScaleFactor, maxScaleFactor: maxScaleFactor);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    staticGetters: {
      'noScaling': (visitor) => $flutter_49.TextScaler.noScaling,
    },
    constructorSignatures: {
      'linear': 'const factory TextScaler.linear(double textScaleFactor)',
    },
    methodSignatures: {
      'scale': 'double scale(double fontSize)',
      'clamp': 'TextScaler clamp({double minScaleFactor = 0, double maxScaleFactor = double.infinity})',
    },
    getterSignatures: {
      'textScaleFactor': 'double get textScaleFactor',
    },
    staticGetterSignatures: {
      'noScaling': 'TextScaler get noScaling',
    },
  );
}

// =============================================================================
// TextSpan Bridge
// =============================================================================

BridgedClass _createTextSpanBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextSpan,
    name: 'TextSpan',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getOptionalNamedArg<String?>(named, 'text');
        final children = D4.coerceListOrNull<$flutter_35.InlineSpan>(named['children'], 'children');
        final style = D4.getOptionalNamedArg<$flutter_51.TextStyle?>(named, 'style');
        final recognizer = D4.getOptionalNamedArg<$flutter_7.GestureRecognizer?>(named, 'recognizer');
        final mouseCursor = D4.getOptionalNamedArg<$flutter_58.MouseCursor?>(named, 'mouseCursor');
        final onEnterRaw = named['onEnter'];
        final onExitRaw = named['onExit'];
        final semanticsLabel = D4.getOptionalNamedArg<String?>(named, 'semanticsLabel');
        final semanticsIdentifier = D4.getOptionalNamedArg<String?>(named, 'semanticsIdentifier');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final spellOut = D4.getOptionalNamedArg<bool?>(named, 'spellOut');
        return $flutter_50.TextSpan(text: text, children: children, style: style, recognizer: recognizer, mouseCursor: mouseCursor, onEnter: onEnterRaw == null ? null : ($flutter_5.PointerEnterEvent p0) { D4.callInterpreterCallback(visitor, onEnterRaw, [p0]); }, onExit: onExitRaw == null ? null : ($flutter_5.PointerExitEvent p0) { D4.callInterpreterCallback(visitor, onExitRaw, [p0]); }, semanticsLabel: semanticsLabel, semanticsIdentifier: semanticsIdentifier, locale: locale, spellOut: spellOut);
      },
    },
    getters: {
      'style': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').style,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').hashCode,
      'text': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').text,
      'children': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').children,
      'recognizer': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').recognizer,
      'mouseCursor': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').mouseCursor,
      'onEnter': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').onEnter,
      'onExit': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').onExit,
      'semanticsLabel': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').semanticsLabel,
      'semanticsIdentifier': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').semanticsIdentifier,
      'locale': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').locale,
      'spellOut': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').spellOut,
      'validForMouseTracker': (visitor, target) => D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan').validForMouseTracker,
      'cursor': (visitor, target) => (D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan') as dynamic).cursor,
    },
    methods: {
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'build');
        final builder = D4.getRequiredArg<ParagraphBuilder>(positional, 0, 'builder', 'build');
        final textScaler = D4.getNamedArgWithDefault<$flutter_49.TextScaler>(named, 'textScaler', $flutter_49.TextScaler.noScaling);
        final dimensions = D4.coerceListOrNull<$flutter_48.PlaceholderDimensions>(named['dimensions'], 'dimensions');
        (t as dynamic).build(builder, textScaler: textScaler, dimensions: dimensions);
        return null;
      },
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitChildren(($flutter_35.InlineSpan p0) { return D4.callInterpreterCallback(visitor, visitor_Raw, [p0]) as bool; });
      },
      'visitDirectChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'visitDirectChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitDirectChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitDirectChildren(($flutter_35.InlineSpan p0) { return D4.callInterpreterCallback(visitor, visitor_Raw, [p0]) as bool; });
      },
      'getSpanForPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'getSpanForPosition');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPosition');
        return t.getSpanForPosition(position);
      },
      'toPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        return t.toPlainText(includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
      },
      'getSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        return t.getSemanticsInformation();
      },
      'codeUnitAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'codeUnitAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAt');
        return t.codeUnitAt(index);
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        return t.debugAssertIsValid();
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_35.InlineSpan>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 2, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_5.PointerEvent>(positional, 0, 'event', 'handleEvent');
        final entry = D4.getRequiredArg<$flutter_6.HitTestEntry>(positional, 1, 'entry', 'handleEvent');
        t.handleEvent(event, entry);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSpan>(target, 'TextSpan');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const TextSpan({String? text, List<InlineSpan>? children, TextStyle? style, GestureRecognizer? recognizer, MouseCursor? mouseCursor, void Function(PointerEnterEvent)? onEnter, void Function(PointerExitEvent)? onExit, String? semanticsLabel, String? semanticsIdentifier, Locale? locale, bool? spellOut})',
    },
    methodSignatures: {
      'build': 'void build(ui.ParagraphBuilder builder, {TextScaler textScaler = TextScaler.noScaling, List<PlaceholderDimensions>? dimensions})',
      'visitChildren': 'bool visitChildren(InlineSpanVisitor visitor)',
      'visitDirectChildren': 'bool visitDirectChildren(InlineSpanVisitor visitor)',
      'getSpanForPosition': 'InlineSpan? getSpanForPosition(TextPosition position)',
      'toPlainText': 'String toPlainText({bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'getSemanticsInformation': 'List<InlineSpanSemanticsInformation> getSemanticsInformation()',
      'codeUnitAt': 'int? codeUnitAt(int index)',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'compareTo': 'RenderComparison compareTo(InlineSpan other)',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'handleEvent': 'void handleEvent(PointerEvent event, HitTestEntry entry)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
    getterSignatures: {
      'style': 'TextStyle? get style',
      'hashCode': 'int get hashCode',
      'text': 'String? get text',
      'children': 'List<InlineSpan>? get children',
      'recognizer': 'GestureRecognizer? get recognizer',
      'mouseCursor': 'MouseCursor get mouseCursor',
      'onEnter': 'PointerEnterEventListener? get onEnter',
      'onExit': 'PointerExitEventListener? get onExit',
      'semanticsLabel': 'String? get semanticsLabel',
      'semanticsIdentifier': 'String? get semanticsIdentifier',
      'locale': 'ui.Locale? get locale',
      'spellOut': 'bool? get spellOut',
      'validForMouseTracker': 'bool get validForMouseTracker',
      'cursor': 'MouseCursor get cursor',
    },
  );
}

// =============================================================================
// TextStyle Bridge
// =============================================================================

BridgedClass _createTextStyleBridge() {
  return BridgedClass(
    nativeType: $flutter_51.TextStyle,
    name: 'TextStyle',
    constructors: {
      '': (visitor, positional, named) {
        final inherit = D4.getNamedArgWithDefault<bool>(named, 'inherit', true);
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final backgroundColor = D4.getOptionalNamedArg<Color?>(named, 'backgroundColor');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final fontWeight = D4.getOptionalNamedArg<FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<FontStyle?>(named, 'fontStyle');
        final letterSpacing = D4.getOptionalNamedArg<double?>(named, 'letterSpacing');
        final wordSpacing = D4.getOptionalNamedArg<double?>(named, 'wordSpacing');
        final textBaseline = D4.getOptionalNamedArg<TextBaseline?>(named, 'textBaseline');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final leadingDistribution = D4.getOptionalNamedArg<TextLeadingDistribution?>(named, 'leadingDistribution');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final foreground = D4.getOptionalNamedArg<Paint?>(named, 'foreground');
        final background = D4.getOptionalNamedArg<Paint?>(named, 'background');
        final shadows = D4.coerceListOrNull<Shadow>(named['shadows'], 'shadows');
        final fontFeatures = D4.coerceListOrNull<FontFeature>(named['fontFeatures'], 'fontFeatures');
        final fontVariations = D4.coerceListOrNull<FontVariation>(named['fontVariations'], 'fontVariations');
        final decoration = D4.getOptionalNamedArg<TextDecoration?>(named, 'decoration');
        final decorationColor = D4.getOptionalNamedArg<Color?>(named, 'decorationColor');
        final decorationStyle = D4.getOptionalNamedArg<TextDecorationStyle?>(named, 'decorationStyle');
        final decorationThickness = D4.getOptionalNamedArg<double?>(named, 'decorationThickness');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontFamilyFallback = D4.coerceListOrNull<String>(named['fontFamilyFallback'], 'fontFamilyFallback');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        final overflow = D4.getOptionalNamedArg<$flutter_48.TextOverflow?>(named, 'overflow');
        return $flutter_51.TextStyle(inherit: inherit, color: color, backgroundColor: backgroundColor, fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle, letterSpacing: letterSpacing, wordSpacing: wordSpacing, textBaseline: textBaseline, height: height, leadingDistribution: leadingDistribution, locale: locale, foreground: foreground, background: background, shadows: shadows, fontFeatures: fontFeatures, fontVariations: fontVariations, decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle, decorationThickness: decorationThickness, debugLabel: debugLabel, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, package: package, overflow: overflow);
      },
    },
    getters: {
      'inherit': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').inherit,
      'color': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').color,
      'backgroundColor': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').backgroundColor,
      'fontFamily': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').fontFamily,
      'fontFamilyFallback': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').fontFamilyFallback,
      'fontSize': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').fontSize,
      'fontWeight': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').fontWeight,
      'fontStyle': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').fontStyle,
      'letterSpacing': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').letterSpacing,
      'wordSpacing': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').wordSpacing,
      'textBaseline': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').textBaseline,
      'height': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').height,
      'leadingDistribution': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').leadingDistribution,
      'locale': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').locale,
      'foreground': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').foreground,
      'background': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').background,
      'decoration': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').decoration,
      'decorationColor': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').decorationColor,
      'decorationStyle': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').decorationStyle,
      'decorationThickness': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').decorationThickness,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').debugLabel,
      'shadows': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').shadows,
      'fontFeatures': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').fontFeatures,
      'fontVariations': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').fontVariations,
      'overflow': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').overflow,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        final inherit = D4.getOptionalNamedArg<bool?>(named, 'inherit');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final backgroundColor = D4.getOptionalNamedArg<Color?>(named, 'backgroundColor');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final fontWeight = D4.getOptionalNamedArg<FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<FontStyle?>(named, 'fontStyle');
        final letterSpacing = D4.getOptionalNamedArg<double?>(named, 'letterSpacing');
        final wordSpacing = D4.getOptionalNamedArg<double?>(named, 'wordSpacing');
        final textBaseline = D4.getOptionalNamedArg<TextBaseline?>(named, 'textBaseline');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final leadingDistribution = D4.getOptionalNamedArg<TextLeadingDistribution?>(named, 'leadingDistribution');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final foreground = D4.getOptionalNamedArg<Paint?>(named, 'foreground');
        final background = D4.getOptionalNamedArg<Paint?>(named, 'background');
        final shadows = D4.coerceListOrNull<Shadow>(named['shadows'], 'shadows');
        final fontFeatures = D4.coerceListOrNull<FontFeature>(named['fontFeatures'], 'fontFeatures');
        final fontVariations = D4.coerceListOrNull<FontVariation>(named['fontVariations'], 'fontVariations');
        final decoration = D4.getOptionalNamedArg<TextDecoration?>(named, 'decoration');
        final decorationColor = D4.getOptionalNamedArg<Color?>(named, 'decorationColor');
        final decorationStyle = D4.getOptionalNamedArg<TextDecorationStyle?>(named, 'decorationStyle');
        final decorationThickness = D4.getOptionalNamedArg<double?>(named, 'decorationThickness');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontFamilyFallback = D4.coerceListOrNull<String>(named['fontFamilyFallback'], 'fontFamilyFallback');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        final overflow = D4.getOptionalNamedArg<$flutter_48.TextOverflow?>(named, 'overflow');
        return t.copyWith(inherit: inherit, color: color, backgroundColor: backgroundColor, fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle, letterSpacing: letterSpacing, wordSpacing: wordSpacing, textBaseline: textBaseline, height: height, leadingDistribution: leadingDistribution, locale: locale, foreground: foreground, background: background, shadows: shadows, fontFeatures: fontFeatures, fontVariations: fontVariations, decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle, decorationThickness: decorationThickness, debugLabel: debugLabel, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, package: package, overflow: overflow);
      },
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final backgroundColor = D4.getOptionalNamedArg<Color?>(named, 'backgroundColor');
        final decoration = D4.getOptionalNamedArg<TextDecoration?>(named, 'decoration');
        final decorationColor = D4.getOptionalNamedArg<Color?>(named, 'decorationColor');
        final decorationStyle = D4.getOptionalNamedArg<TextDecorationStyle?>(named, 'decorationStyle');
        final decorationThicknessFactor = D4.getNamedArgWithDefault<double>(named, 'decorationThicknessFactor', 1.0);
        final decorationThicknessDelta = D4.getNamedArgWithDefault<double>(named, 'decorationThicknessDelta', 0.0);
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontFamilyFallback = D4.coerceListOrNull<String>(named['fontFamilyFallback'], 'fontFamilyFallback');
        final fontSizeFactor = D4.getNamedArgWithDefault<double>(named, 'fontSizeFactor', 1.0);
        final fontSizeDelta = D4.getNamedArgWithDefault<double>(named, 'fontSizeDelta', 0.0);
        final fontWeightDelta = D4.getNamedArgWithDefault<int>(named, 'fontWeightDelta', 0);
        final fontStyle = D4.getOptionalNamedArg<FontStyle?>(named, 'fontStyle');
        final letterSpacingFactor = D4.getNamedArgWithDefault<double>(named, 'letterSpacingFactor', 1.0);
        final letterSpacingDelta = D4.getNamedArgWithDefault<double>(named, 'letterSpacingDelta', 0.0);
        final wordSpacingFactor = D4.getNamedArgWithDefault<double>(named, 'wordSpacingFactor', 1.0);
        final wordSpacingDelta = D4.getNamedArgWithDefault<double>(named, 'wordSpacingDelta', 0.0);
        final heightFactor = D4.getNamedArgWithDefault<double>(named, 'heightFactor', 1.0);
        final heightDelta = D4.getNamedArgWithDefault<double>(named, 'heightDelta', 0.0);
        final textBaseline = D4.getOptionalNamedArg<TextBaseline?>(named, 'textBaseline');
        final leadingDistribution = D4.getOptionalNamedArg<TextLeadingDistribution?>(named, 'leadingDistribution');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final shadows = D4.coerceListOrNull<Shadow>(named['shadows'], 'shadows');
        final fontFeatures = D4.coerceListOrNull<FontFeature>(named['fontFeatures'], 'fontFeatures');
        final fontVariations = D4.coerceListOrNull<FontVariation>(named['fontVariations'], 'fontVariations');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        final overflow = D4.getOptionalNamedArg<$flutter_48.TextOverflow?>(named, 'overflow');
        return t.apply(color: color, backgroundColor: backgroundColor, decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle, decorationThicknessFactor: decorationThicknessFactor, decorationThicknessDelta: decorationThicknessDelta, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSizeFactor: fontSizeFactor, fontSizeDelta: fontSizeDelta, fontWeightDelta: fontWeightDelta, fontStyle: fontStyle, letterSpacingFactor: letterSpacingFactor, letterSpacingDelta: letterSpacingDelta, wordSpacingFactor: wordSpacingFactor, wordSpacingDelta: wordSpacingDelta, heightFactor: heightFactor, heightDelta: heightDelta, textBaseline: textBaseline, leadingDistribution: leadingDistribution, locale: locale, shadows: shadows, fontFeatures: fontFeatures, fontVariations: fontVariations, package: package, overflow: overflow);
      },
      'merge': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        D4.requireMinArgs(positional, 1, 'merge');
        final other = D4.getRequiredArg<$flutter_51.TextStyle?>(positional, 0, 'other', 'merge');
        return t.merge(other);
      },
      'getTextStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final textScaler = D4.getNamedArgWithDefault<$flutter_49.TextScaler>(named, 'textScaler', $flutter_49.TextScaler.noScaling);
        return t.getTextStyle(textScaleFactor: textScaleFactor, textScaler: textScaler);
      },
      'getParagraphStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        final textAlign = D4.getOptionalNamedArg<TextAlign?>(named, 'textAlign');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final textScaler = D4.getNamedArgWithDefault<$flutter_49.TextScaler>(named, 'textScaler', $flutter_49.TextScaler.noScaling);
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final fontWeight = D4.getOptionalNamedArg<FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<FontStyle?>(named, 'fontStyle');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final strutStyle = D4.getOptionalNamedArg<$flutter_47.StrutStyle?>(named, 'strutStyle');
        return t.getParagraphStyle(textAlign: textAlign, textDirection: textDirection, textScaler: textScaler, ellipsis: ellipsis, maxLines: maxLines, textHeightBehavior: textHeightBehavior, locale: locale, fontFamily: fontFamily, fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle, height: height, strutStyle: strutStyle);
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_51.TextStyle>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextStyle>(target, 'TextStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_51.TextStyle?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_51.TextStyle?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_51.TextStyle.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const TextStyle({bool inherit = true, Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow})',
    },
    methodSignatures: {
      'copyWith': 'TextStyle copyWith({bool? inherit, Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow})',
      'apply': 'TextStyle apply({Color? color, Color? backgroundColor, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double decorationThicknessFactor = 1.0, double decorationThicknessDelta = 0.0, String? fontFamily, List<String>? fontFamilyFallback, double fontSizeFactor = 1.0, double fontSizeDelta = 0.0, int fontWeightDelta = 0, FontStyle? fontStyle, double letterSpacingFactor = 1.0, double letterSpacingDelta = 0.0, double wordSpacingFactor = 1.0, double wordSpacingDelta = 0.0, double heightFactor = 1.0, double heightDelta = 0.0, TextBaseline? textBaseline, TextLeadingDistribution? leadingDistribution, Locale? locale, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, String? package, TextOverflow? overflow})',
      'merge': 'TextStyle merge(TextStyle? other)',
      'getTextStyle': 'ui.TextStyle getTextStyle({double textScaleFactor = 1.0, TextScaler textScaler = TextScaler.noScaling})',
      'getParagraphStyle': 'ui.ParagraphStyle getParagraphStyle({TextAlign? textAlign, TextDirection? textDirection, TextScaler textScaler = TextScaler.noScaling, String? ellipsis, int? maxLines, TextHeightBehavior? textHeightBehavior, Locale? locale, String? fontFamily, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? height, StrutStyle? strutStyle})',
      'compareTo': 'RenderComparison compareTo(TextStyle other)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'inherit': 'bool get inherit',
      'color': 'Color? get color',
      'backgroundColor': 'Color? get backgroundColor',
      'fontFamily': 'String? get fontFamily',
      'fontFamilyFallback': 'List<String>? get fontFamilyFallback',
      'fontSize': 'double? get fontSize',
      'fontWeight': 'FontWeight? get fontWeight',
      'fontStyle': 'FontStyle? get fontStyle',
      'letterSpacing': 'double? get letterSpacing',
      'wordSpacing': 'double? get wordSpacing',
      'textBaseline': 'TextBaseline? get textBaseline',
      'height': 'double? get height',
      'leadingDistribution': 'TextLeadingDistribution? get leadingDistribution',
      'locale': 'Locale? get locale',
      'foreground': 'Paint? get foreground',
      'background': 'Paint? get background',
      'decoration': 'TextDecoration? get decoration',
      'decorationColor': 'Color? get decorationColor',
      'decorationStyle': 'TextDecorationStyle? get decorationStyle',
      'decorationThickness': 'double? get decorationThickness',
      'debugLabel': 'String? get debugLabel',
      'shadows': 'List<Shadow>? get shadows',
      'fontFeatures': 'List<FontFeature>? get fontFeatures',
      'fontVariations': 'List<FontVariation>? get fontVariations',
      'overflow': 'TextOverflow? get overflow',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'TextStyle? lerp(TextStyle? a, TextStyle? b, double t)',
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

