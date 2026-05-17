// D4rt Bridge - Generated file, do not edit
// Sources: 46 files
// Generated: 2026-05-17T15:08:50.848849

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/assertions.dart' as $flutter_1;
import 'package:flutter/src/foundation/basic_types.dart' as $flutter_2;
import 'package:flutter/src/foundation/binding.dart' as $flutter_3;
import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_4;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_5;
import 'package:flutter/src/foundation/platform.dart' as $flutter_6;
import 'package:flutter/src/gestures/events.dart' as $flutter_7;
import 'package:flutter/src/gestures/hit_test.dart' as $flutter_8;
import 'package:flutter/src/gestures/recognizer.dart' as $flutter_9;
import 'package:flutter/src/painting/alignment.dart' as $flutter_10;
import 'package:flutter/src/painting/basic_types.dart' as $flutter_11;
import 'package:flutter/src/painting/beveled_rectangle_border.dart' as $flutter_12;
import 'package:flutter/src/painting/binding.dart' as $flutter_13;
import 'package:flutter/src/painting/border_radius.dart' as $flutter_14;
import 'package:flutter/src/painting/borders.dart' as $flutter_15;
import 'package:flutter/src/painting/box_border.dart' as $flutter_16;
import 'package:flutter/src/painting/box_decoration.dart' as $flutter_17;
import 'package:flutter/src/painting/box_fit.dart' as $flutter_18;
import 'package:flutter/src/painting/box_shadow.dart' as $flutter_19;
import 'package:flutter/src/painting/circle_border.dart' as $flutter_20;
import 'package:flutter/src/painting/clip.dart' as $flutter_21;
import 'package:flutter/src/painting/colors.dart' as $flutter_22;
import 'package:flutter/src/painting/continuous_rectangle_border.dart' as $flutter_23;
import 'package:flutter/src/painting/debug.dart' as $flutter_24;
import 'package:flutter/src/painting/decoration.dart' as $flutter_25;
import 'package:flutter/src/painting/decoration_image.dart' as $flutter_26;
import 'package:flutter/src/painting/edge_insets.dart' as $flutter_27;
import 'package:flutter/src/painting/flutter_logo.dart' as $flutter_28;
import 'package:flutter/src/painting/fractional_offset.dart' as $flutter_29;
import 'package:flutter/src/painting/geometry.dart' as $flutter_30;
import 'package:flutter/src/painting/gradient.dart' as $flutter_31;
import 'package:flutter/src/painting/image_cache.dart' as $flutter_32;
import 'package:flutter/src/painting/image_decoder.dart' as $flutter_33;
import 'package:flutter/src/painting/image_provider.dart' as $flutter_34;
import 'package:flutter/src/painting/image_resolution.dart' as $flutter_35;
import 'package:flutter/src/painting/image_stream.dart' as $flutter_36;
import 'package:flutter/src/painting/inline_span.dart' as $flutter_37;
import 'package:flutter/src/painting/linear_border.dart' as $flutter_38;
import 'package:flutter/src/painting/matrix_utils.dart' as $flutter_39;
import 'package:flutter/src/painting/notched_shapes.dart' as $flutter_40;
import 'package:flutter/src/painting/oval_border.dart' as $flutter_41;
import 'package:flutter/src/painting/paint_utilities.dart' as $flutter_42;
import 'package:flutter/src/painting/placeholder_span.dart' as $flutter_43;
import 'package:flutter/src/painting/rounded_rectangle_border.dart' as $flutter_44;
import 'package:flutter/src/painting/shader_warm_up.dart' as $flutter_45;
import 'package:flutter/src/painting/shape_decoration.dart' as $flutter_46;
import 'package:flutter/src/painting/stadium_border.dart' as $flutter_47;
import 'package:flutter/src/painting/star_border.dart' as $flutter_48;
import 'package:flutter/src/painting/strut_style.dart' as $flutter_49;
import 'package:flutter/src/painting/text_painter.dart' as $flutter_50;
import 'package:flutter/src/painting/text_scaler.dart' as $flutter_51;
import 'package:flutter/src/painting/text_span.dart' as $flutter_52;
import 'package:flutter/src/painting/text_style.dart' as $flutter_53;
import 'package:flutter/src/scheduler/binding.dart' as $flutter_54;
import 'package:flutter/src/scheduler/priority.dart' as $flutter_55;
import 'package:flutter/src/services/asset_bundle.dart' as $flutter_56;
import 'package:flutter/src/services/binary_messenger.dart' as $flutter_57;
import 'package:flutter/src/services/binding.dart' as $flutter_58;
import 'package:flutter/src/services/hardware_keyboard.dart' as $flutter_59;
import 'package:flutter/src/services/mouse_cursor.dart' as $flutter_60;
import 'package:flutter/src/services/mouse_tracking.dart' as $flutter_61;
import 'package:flutter/src/services/restoration.dart' as $flutter_62;
import 'package:flutter/src/services/text_boundary.dart' as $flutter_63;
import 'package:flutter/src/services/text_editing.dart' as $flutter_64;
import 'package:tom_d4rt_flutter_test/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart' as $tom_d4rt_flutter_test_1;
import 'package:tom_d4rt_flutter_test/src/d4rt_user_bridges/state_user_bridge.dart' as $tom_d4rt_flutter_test_2;
import 'package:tom_d4rt_flutter_test/src/d4rt_user_bridges/strut_style_user_bridge.dart' as $tom_d4rt_flutter_test_3;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;

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
    };
  }

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
      'MemoryAllocations': 'FlutterMemoryAllocations',
    };
  }

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
      'ValueChanged',
      'ValueSetter',
      'ValueGetter',
      'IterableFilter',
      'AsyncCallback',
      'AsyncValueSetter',
      'AsyncValueGetter',
      'ComputePropertyValueCallback',
      'FlutterExceptionHandler',
      'DiagnosticPropertiesTransformer',
      'InformationCollector',
      'StackTraceDemangler',
      'ServiceExtensionCallback',
      'VoidCallback',
      'BytesReceivedCallback',
      'DebugPrintCallback',
      'ComputeCallback',
      'ComputeImpl',
      'LicenseEntryCollector',
      'ObjectEventListener',
      'TimelineSyncFunction',
      'TargetImageSizeCallback',
      'SystemUiChangeCallback',
      'SchedulingStrategy',
      'TimingsCallback',
      'TaskCallback',
      'FrameCallback',
      'HttpClientProvider',
      'PaintImageCallback',
      'ShaderWarmUpPictureCallback',
      'ShaderWarmUpImageCallback',
      'ImageErrorListener',
      'ImageDecoderCallback',
      'DecoderBufferCallback',
      'ImageListener',
      'ImageChunkListener',
      'InlineSpanVisitor',
      'MessageHandler',
      'PlatformMessageResponseCallback',
      'KeyEventCallback',
      'RespondPointerEventCallback',
      'PointerRoute',
      'PointerSignalResolvedCallback',
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
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_11.RenderComparison>(
        name: 'RenderComparison',
        values: $flutter_11.RenderComparison.values,
      ),
      BridgedEnumDefinition<$flutter_11.Axis>(
        name: 'Axis',
        values: $flutter_11.Axis.values,
      ),
      BridgedEnumDefinition<$flutter_11.VerticalDirection>(
        name: 'VerticalDirection',
        values: $flutter_11.VerticalDirection.values,
      ),
      BridgedEnumDefinition<$flutter_11.AxisDirection>(
        name: 'AxisDirection',
        values: $flutter_11.AxisDirection.values,
      ),
      BridgedEnumDefinition<$flutter_15.BorderStyle>(
        name: 'BorderStyle',
        values: $flutter_15.BorderStyle.values,
      ),
      BridgedEnumDefinition<$flutter_16.BoxShape>(
        name: 'BoxShape',
        values: $flutter_16.BoxShape.values,
      ),
      BridgedEnumDefinition<$flutter_18.BoxFit>(
        name: 'BoxFit',
        values: $flutter_18.BoxFit.values,
      ),
      BridgedEnumDefinition<$flutter_26.ImageRepeat>(
        name: 'ImageRepeat',
        values: $flutter_26.ImageRepeat.values,
      ),
      BridgedEnumDefinition<$flutter_28.FlutterLogoStyle>(
        name: 'FlutterLogoStyle',
        values: $flutter_28.FlutterLogoStyle.values,
      ),
      BridgedEnumDefinition<$flutter_34.ResizeImagePolicy>(
        name: 'ResizeImagePolicy',
        values: $flutter_34.ResizeImagePolicy.values,
      ),
      BridgedEnumDefinition<$flutter_34.WebHtmlElementStrategy>(
        name: 'WebHtmlElementStrategy',
        values: $flutter_34.WebHtmlElementStrategy.values,
      ),
      BridgedEnumDefinition<$flutter_50.TextOverflow>(
        name: 'TextOverflow',
        values: $flutter_50.TextOverflow.values,
      ),
      BridgedEnumDefinition<$flutter_50.TextWidthBasis>(
        name: 'TextWidthBasis',
        values: $flutter_50.TextWidthBasis.values,
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

  /// GEN-107: Library re-exports declared by the bridged source
  /// libraries. Each tuple mirrors a Dart `export '…'` directive.
  /// Consumed by `registerBridges` via `D4rt.registerLibraryReExport`
  /// (mirrored on `D4rtRunner` in tom_d4rt_ast).
  static List<({String source, String target, Set<String>? show, Set<String>? hide})>
  bridgeReExports() {
    return [
      (source: 'package:flutter/painting.dart', target: 'dart:ui', show: {'PlaceholderAlignment', 'Shadow', 'TextHeightBehavior', 'TextLeadingDistribution', 'kTextHeightNone'}, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/alignment.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/basic_types.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/beveled_rectangle_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/binding.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/border_radius.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/borders.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/box_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/box_decoration.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/box_fit.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/box_shadow.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/circle_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/clip.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/colors.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/continuous_rectangle_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/debug.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/decoration.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/decoration_image.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/edge_insets.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/flutter_logo.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/fractional_offset.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/geometry.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/gradient.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/image_cache.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/image_decoder.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/image_provider.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/image_resolution.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/image_stream.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/inline_span.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/linear_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/matrix_utils.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/notched_shapes.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/oval_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/paint_utilities.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/placeholder_span.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/rounded_rectangle_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/shader_warm_up.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/shape_decoration.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/stadium_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/star_border.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/strut_style.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/text_painter.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/text_scaler.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/text_span.dart', show: null, hide: null),
      (source: 'package:flutter/painting.dart', target: 'package:flutter/src/painting/text_style.dart', show: null, hide: null),
      (source: 'package:flutter/src/foundation/assertions.dart', target: 'package:flutter/src/foundation/basic_types.dart', show: {'IterableFilter'}, hide: null),
      (source: 'package:flutter/src/foundation/assertions.dart', target: 'package:flutter/src/foundation/diagnostics.dart', show: {'DiagnosticLevel', 'DiagnosticPropertiesBuilder', 'DiagnosticsNode', 'DiagnosticsTreeStyle'}, hide: null),
      (source: 'package:flutter/src/foundation/assertions.dart', target: 'package:flutter/src/foundation/stack_frame.dart', show: {'StackFrame'}, hide: null),
      (source: 'package:flutter/src/foundation/binding.dart', target: 'dart:ui', show: {'PlatformDispatcher', 'SingletonFlutterWindow', 'clampDouble'}, hide: null),
      (source: 'package:flutter/src/foundation/binding.dart', target: 'package:flutter/src/foundation/basic_types.dart', show: {'AsyncCallback', 'AsyncValueGetter', 'AsyncValueSetter'}, hide: null),
      (source: 'package:flutter/src/foundation/change_notifier.dart', target: 'dart:ui', show: {'VoidCallback'}, hide: null),
      (source: 'package:flutter/src/foundation/consolidate_response.dart', target: 'dart:io', show: {'HttpClientResponse'}, hide: null),
      (source: 'package:flutter/src/foundation/consolidate_response.dart', target: 'dart:typed_data', show: {'Uint8List'}, hide: null),
      (source: 'package:flutter/src/foundation/debug.dart', target: 'dart:ui', show: {'Brightness'}, hide: null),
      (source: 'package:flutter/src/foundation/debug.dart', target: 'package:flutter/src/foundation/print.dart', show: {'DebugPrintCallback'}, hide: null),
      (source: 'package:flutter/src/foundation/serialization.dart', target: 'dart:typed_data', show: {'ByteData', 'Endian', 'Float32List', 'Float64List', 'Int32List', 'Int64List', 'Uint8List'}, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:meta/meta.dart', show: {'factory', 'immutable', 'internal', 'mustCallSuper', 'nonVirtual', 'optionalTypeArgs', 'protected', 'required', 'visibleForOverriding', 'visibleForTesting'}, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/annotations.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/assertions.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/basic_types.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/binding.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/bitfield.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/capabilities.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/change_notifier.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/collections.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/consolidate_response.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/constants.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/debug.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/diagnostics.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/isolates.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/key.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/licenses.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/memory_allocations.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/node.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/object.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/observer_list.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/persistent_hash_map.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/platform.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/print.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/serialization.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/service_extensions.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/stack_frame.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/synchronous_future.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/timeline.dart', show: null, hide: null),
      (source: 'package:flutter/foundation.dart', target: 'package:flutter/src/foundation/unicode.dart', show: null, hide: null),
      (source: 'package:flutter/src/painting/basic_types.dart', target: 'dart:ui', show: {'BlendMode', 'BlurStyle', 'Canvas', 'Clip', 'Color', 'ColorFilter', 'FilterQuality', 'FontFeature', 'FontStyle', 'FontVariation', 'FontWeight', 'GlyphInfo', 'ImageShader', 'Locale', 'MaskFilter', 'Offset', 'Paint', 'PaintingStyle', 'Path', 'PathFillType', 'PathOperation', 'RRect', 'RSTransform', 'RSuperellipse', 'Radius', 'Rect', 'Shader', 'Shadow', 'Size', 'StrokeCap', 'StrokeJoin', 'TextAffinity', 'TextAlign', 'TextBaseline', 'TextBox', 'TextDecoration', 'TextDecorationStyle', 'TextDirection', 'TextHeightBehavior', 'TextLeadingDistribution', 'TextPosition', 'TileMode', 'VertexMode'}, hide: null),
      (source: 'package:flutter/src/painting/basic_types.dart', target: 'package:flutter/foundation.dart', show: {'VoidCallback'}, hide: null),
      (source: 'package:flutter/src/services/asset_bundle.dart', target: 'dart:typed_data', show: {'ByteData'}, hide: null),
      (source: 'package:flutter/src/services/asset_bundle.dart', target: 'dart:ui', show: {'ImmutableBuffer'}, hide: null),
      (source: 'package:flutter/src/services/autofill.dart', target: 'package:flutter/src/services/text_input.dart', show: {'TextEditingValue', 'TextInputClient', 'TextInputConfiguration', 'TextInputConnection'}, hide: null),
      (source: 'package:flutter/src/services/text_editing.dart', target: 'dart:ui', show: {'TextAffinity', 'TextPosition'}, hide: null),
      (source: 'package:flutter/src/services/text_input.dart', target: 'dart:ui', show: {'Brightness', 'FontWeight', 'Offset', 'Rect', 'Size', 'TextAlign', 'TextDirection', 'TextPosition', 'TextRange'}, hide: null),
      (source: 'package:flutter/src/services/text_input.dart', target: 'package:vector_math/vector_math_64.dart', show: {'Matrix4'}, hide: null),
      (source: 'package:flutter/src/services/text_input.dart', target: 'package:flutter/src/services/autofill.dart', show: {'AutofillConfiguration', 'AutofillScope'}, hide: null),
      (source: 'package:flutter/src/services/text_input.dart', target: 'package:flutter/src/services/text_editing.dart', show: {'TextSelection'}, hide: null),
      (source: 'package:flutter/src/services/text_editing_delta.dart', target: 'dart:ui', show: {'TextRange'}, hide: null),
      (source: 'package:flutter/src/services/text_editing_delta.dart', target: 'package:flutter/src/services/text_editing.dart', show: {'TextSelection'}, hide: null),
      (source: 'package:flutter/src/services/text_editing_delta.dart', target: 'package:flutter/src/services/text_input.dart', show: {'TextEditingValue'}, hide: null),
      (source: 'package:flutter/src/services/binary_messenger.dart', target: 'dart:typed_data', show: {'ByteData'}, hide: null),
      (source: 'package:flutter/src/services/binary_messenger.dart', target: 'dart:ui', show: {'PlatformMessageResponseCallback'}, hide: null),
      (source: 'package:flutter/src/services/keyboard_key.g.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/hardware_keyboard.dart', target: 'dart:ui', show: {'KeyData'}, hide: null),
      (source: 'package:flutter/src/services/hardware_keyboard.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/hardware_keyboard.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/restoration.dart', target: 'dart:typed_data', show: {'Uint8List'}, hide: null),
      (source: 'package:flutter/src/services/binding.dart', target: 'dart:ui', show: {'ChannelBuffers', 'RootIsolateToken'}, hide: null),
      (source: 'package:flutter/src/services/binding.dart', target: 'package:flutter/src/services/binary_messenger.dart', show: {'BinaryMessenger'}, hide: null),
      (source: 'package:flutter/src/services/binding.dart', target: 'package:flutter/src/services/hardware_keyboard.dart', show: {'HardwareKeyboard', 'KeyEventManager'}, hide: null),
      (source: 'package:flutter/src/services/binding.dart', target: 'package:flutter/src/services/restoration.dart', show: {'RestorationManager'}, hide: null),
      (source: 'package:flutter/src/services/debug.dart', target: 'package:flutter/src/services/hardware_keyboard.dart', show: {'KeyDataTransitMode'}, hide: null),
      (source: 'package:flutter/src/services/font_loader.dart', target: 'dart:typed_data', show: {'ByteData'}, hide: null),
      (source: 'package:flutter/src/services/keyboard_maps.g.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/message_codec.dart', target: 'dart:typed_data', show: {'ByteData'}, hide: null),
      (source: 'package:flutter/src/services/message_codecs.dart', target: 'dart:typed_data', show: {'ByteData'}, hide: null),
      (source: 'package:flutter/src/services/message_codecs.dart', target: 'package:flutter/foundation.dart', show: {'ReadBuffer', 'WriteBuffer'}, hide: null),
      (source: 'package:flutter/src/services/message_codecs.dart', target: 'package:flutter/src/services/message_codec.dart', show: {'MethodCall'}, hide: null),
      (source: 'package:flutter/src/gestures/gesture_settings.dart', target: 'dart:ui', show: {'FlutterView'}, hide: null),
      (source: 'package:flutter/src/gestures/events.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/events.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/gestures/events.dart', target: 'package:vector_math/vector_math_64.dart', show: {'Matrix4'}, hide: null),
      (source: 'package:flutter/src/gestures/events.dart', target: 'package:flutter/src/gestures/gesture_settings.dart', show: {'DeviceGestureSettings'}, hide: null),
      (source: 'package:flutter/src/gestures/hit_test.dart', target: 'dart:ui', show: {'Offset'}, hide: null),
      (source: 'package:flutter/src/gestures/hit_test.dart', target: 'package:vector_math/vector_math_64.dart', show: {'Matrix4'}, hide: null),
      (source: 'package:flutter/src/gestures/hit_test.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/pointer_router.dart', target: 'package:vector_math/vector_math_64.dart', show: {'Matrix4'}, hide: null),
      (source: 'package:flutter/src/gestures/pointer_router.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/pointer_signal_resolver.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerSignalEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/binding.dart', target: 'dart:ui', show: {'Offset'}, hide: null),
      (source: 'package:flutter/src/gestures/binding.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticsNode', 'InformationCollector'}, hide: null),
      (source: 'package:flutter/src/gestures/binding.dart', target: 'package:flutter/src/gestures/arena.dart', show: {'GestureArenaManager'}, hide: null),
      (source: 'package:flutter/src/gestures/binding.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/binding.dart', target: 'package:flutter/src/gestures/hit_test.dart', show: {'HitTestEntry', 'HitTestResult', 'HitTestTarget'}, hide: null),
      (source: 'package:flutter/src/gestures/binding.dart', target: 'package:flutter/src/gestures/pointer_router.dart', show: {'PointerRouter'}, hide: null),
      (source: 'package:flutter/src/gestures/binding.dart', target: 'package:flutter/src/gestures/pointer_signal_resolver.dart', show: {'PointerSignalResolver'}, hide: null),
      (source: 'package:flutter/src/gestures/converter.dart', target: 'dart:ui', show: {'PointerData'}, hide: null),
      (source: 'package:flutter/src/gestures/converter.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/velocity_tracker.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/drag_details.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/drag_details.dart', target: 'package:flutter/src/gestures/velocity_tracker.dart', show: {'Velocity'}, hide: null),
      (source: 'package:flutter/src/gestures/drag.dart', target: 'package:flutter/src/gestures/drag_details.dart', show: {'DragEndDetails', 'DragUpdateDetails'}, hide: null),
      (source: 'package:flutter/src/gestures/eager.dart', target: 'dart:ui', show: {'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/eager.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent', 'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/force_press.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/force_press.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent', 'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/long_press.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/long_press.dart', target: 'package:flutter/src/gestures/arena.dart', show: {'GestureDisposition'}, hide: null),
      (source: 'package:flutter/src/gestures/long_press.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent', 'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/long_press.dart', target: 'package:flutter/src/gestures/velocity_tracker.dart', show: {'Velocity'}, hide: null),
      (source: 'package:flutter/src/gestures/team.dart', target: 'package:flutter/src/gestures/arena.dart', show: {'GestureArenaEntry', 'GestureArenaMember'}, hide: null),
      (source: 'package:flutter/src/gestures/recognizer.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/recognizer.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/gestures/recognizer.dart', target: 'package:vector_math/vector_math_64.dart', show: {'Matrix4'}, hide: null),
      (source: 'package:flutter/src/gestures/recognizer.dart', target: 'package:flutter/src/gestures/arena.dart', show: {'GestureDisposition'}, hide: null),
      (source: 'package:flutter/src/gestures/recognizer.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent', 'PointerEvent', 'PointerPanZoomStartEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/recognizer.dart', target: 'package:flutter/src/gestures/gesture_settings.dart', show: {'DeviceGestureSettings'}, hide: null),
      (source: 'package:flutter/src/gestures/recognizer.dart', target: 'package:flutter/src/gestures/team.dart', show: {'GestureArenaTeam'}, hide: null),
      (source: 'package:flutter/src/gestures/monodrag.dart', target: 'dart:ui', show: {'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/monodrag.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/gestures/monodrag.dart', target: 'package:flutter/src/gestures/drag.dart', show: {'DragEndDetails', 'DragUpdateDetails'}, hide: null),
      (source: 'package:flutter/src/gestures/monodrag.dart', target: 'package:flutter/src/gestures/drag_details.dart', show: {'DragDownDetails', 'DragStartDetails', 'DragUpdateDetails', 'GestureDragDownCallback', 'GestureDragStartCallback', 'GestureDragUpdateCallback'}, hide: null),
      (source: 'package:flutter/src/gestures/monodrag.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent', 'PointerEvent', 'PointerPanZoomStartEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/monodrag.dart', target: 'package:flutter/src/gestures/recognizer.dart', show: {'DragStartBehavior'}, hide: null),
      (source: 'package:flutter/src/gestures/monodrag.dart', target: 'package:flutter/src/gestures/velocity_tracker.dart', show: {'VelocityEstimate', 'VelocityTracker'}, hide: null),
      (source: 'package:flutter/src/gestures/multidrag.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/multidrag.dart', target: 'package:flutter/src/gestures/arena.dart', show: {'GestureDisposition'}, hide: null),
      (source: 'package:flutter/src/gestures/multidrag.dart', target: 'package:flutter/src/gestures/drag.dart', show: {'Drag'}, hide: null),
      (source: 'package:flutter/src/gestures/multidrag.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/multidrag.dart', target: 'package:flutter/src/gestures/gesture_settings.dart', show: {'DeviceGestureSettings'}, hide: null),
      (source: 'package:flutter/src/gestures/tap.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/tap.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/gestures/tap.dart', target: 'package:vector_math/vector_math_64.dart', show: {'Matrix4'}, hide: null),
      (source: 'package:flutter/src/gestures/tap.dart', target: 'package:flutter/src/gestures/arena.dart', show: {'GestureDisposition'}, hide: null),
      (source: 'package:flutter/src/gestures/tap.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerCancelEvent', 'PointerDownEvent', 'PointerEvent', 'PointerUpEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/multitap.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/multitap.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/multitap.dart', target: 'package:flutter/src/gestures/tap.dart', show: {'GestureTapCancelCallback', 'GestureTapDownCallback', 'TapDownDetails', 'TapUpDetails'}, hide: null),
      (source: 'package:flutter/src/gestures/resampler.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/scale.dart', target: 'dart:ui', show: {'Offset', 'PointerDeviceKind'}, hide: null),
      (source: 'package:flutter/src/gestures/scale.dart', target: 'package:flutter/src/gestures/events.dart', show: {'PointerDownEvent', 'PointerEvent', 'PointerPanZoomStartEvent'}, hide: null),
      (source: 'package:flutter/src/gestures/scale.dart', target: 'package:flutter/src/gestures/recognizer.dart', show: {'DragStartBehavior'}, hide: null),
      (source: 'package:flutter/src/gestures/scale.dart', target: 'package:flutter/src/gestures/velocity_tracker.dart', show: {'Velocity'}, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/arena.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/binding.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/constants.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/converter.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/debug.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/drag.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/drag_details.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/eager.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/events.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/force_press.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/gesture_details.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/gesture_settings.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/hit_test.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/long_press.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/lsq_solver.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/monodrag.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/multidrag.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/multitap.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/pointer_router.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/pointer_signal_resolver.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/recognizer.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/resampler.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/scale.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/tap.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/tap_and_drag.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/team.dart', show: null, hide: null),
      (source: 'package:flutter/gestures.dart', target: 'package:flutter/src/gestures/velocity_tracker.dart', show: null, hide: null),
      (source: 'package:flutter/src/services/mouse_cursor.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticLevel', 'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/mouse_cursor.dart', target: 'package:flutter/gestures.dart', show: {'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/services/mouse_tracking.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/mouse_tracking.dart', target: 'package:flutter/gestures.dart', show: {'PointerEnterEvent', 'PointerExitEvent', 'PointerHoverEvent'}, hide: null),
      (source: 'package:flutter/src/services/mouse_tracking.dart', target: 'package:flutter/src/services/mouse_cursor.dart', show: {'MouseCursor'}, hide: null),
      (source: 'package:flutter/src/services/platform_channel.dart', target: 'package:flutter/src/services/_background_isolate_binary_messenger_io.dart', show: null, hide: null),
      (source: 'package:flutter/src/services/platform_channel.dart', target: 'package:flutter/src/services/binary_messenger.dart', show: {'BinaryMessenger'}, hide: null),
      (source: 'package:flutter/src/services/platform_channel.dart', target: 'package:flutter/src/services/binding.dart', show: {'RootIsolateToken'}, hide: null),
      (source: 'package:flutter/src/services/platform_channel.dart', target: 'package:flutter/src/services/message_codec.dart', show: {'MessageCodec', 'MethodCall', 'MethodCodec'}, hide: null),
      (source: 'package:flutter/src/services/platform_views.dart', target: 'dart:ui', show: {'Offset', 'Size', 'TextDirection', 'VoidCallback'}, hide: null),
      (source: 'package:flutter/src/services/platform_views.dart', target: 'package:flutter/gestures.dart', show: {'PointerEvent'}, hide: null),
      (source: 'package:flutter/src/services/platform_views.dart', target: 'package:flutter/src/services/message_codec.dart', show: {'MessageCodec'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder', 'ValueChanged'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_android.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_android.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_fuchsia.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_fuchsia.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_ios.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_ios.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_linux.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_linux.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_macos.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_macos.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_web.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_web.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_windows.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticPropertiesBuilder'}, hide: null),
      (source: 'package:flutter/src/services/raw_keyboard_windows.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: {'LogicalKeyboardKey', 'PhysicalKeyboardKey'}, hide: null),
      (source: 'package:flutter/src/services/system_channels.dart', target: 'package:flutter/src/services/platform_channel.dart', show: {'BasicMessageChannel', 'MethodChannel'}, hide: null),
      (source: 'package:flutter/src/services/system_chrome.dart', target: 'dart:ui', show: {'Brightness', 'Color'}, hide: null),
      (source: 'package:flutter/src/services/system_chrome.dart', target: 'package:flutter/src/services/binding.dart', show: {'SystemUiChangeCallback'}, hide: null),
      (source: 'package:flutter/src/services/text_formatter.dart', target: 'package:flutter/foundation.dart', show: {'TargetPlatform'}, hide: null),
      (source: 'package:flutter/src/services/text_formatter.dart', target: 'package:flutter/src/services/text_input.dart', show: {'TextEditingValue'}, hide: null),
      (source: 'package:flutter/src/services/text_layout_metrics.dart', target: 'dart:ui', show: {'TextPosition', 'TextRange'}, hide: null),
      (source: 'package:flutter/src/services/text_layout_metrics.dart', target: 'package:flutter/src/services/text_editing.dart', show: {'TextSelection'}, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/asset_bundle.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/asset_manifest.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/autofill.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/binary_messenger.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/binding.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/browser_context_menu.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/clipboard.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/debug.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/deferred_component.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/flavor.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/flutter_version.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/font_loader.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/haptic_feedback.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/hardware_keyboard.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/keyboard_inserted_content.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/keyboard_key.g.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/keyboard_maps.g.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/live_text.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/message_codec.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/message_codecs.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/mouse_cursor.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/mouse_tracking.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/platform_channel.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/platform_views.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/predictive_back_event.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/process_text.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard_android.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard_fuchsia.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard_ios.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard_linux.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard_macos.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard_web.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/raw_keyboard_windows.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/restoration.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/scribe.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/sensitive_content.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/service_extensions.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/spell_check.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/system_channels.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/system_chrome.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/system_navigator.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/system_sound.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/text_boundary.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/text_editing.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/text_editing_delta.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/text_formatter.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/text_input.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/text_layout_metrics.dart', show: null, hide: null),
      (source: 'package:flutter/services.dart', target: 'package:flutter/src/services/undo_manager.dart', show: null, hide: null),
      (source: 'package:flutter/src/painting/text_painter.dart', target: 'dart:ui', show: {'LineMetrics'}, hide: null),
      (source: 'package:flutter/src/painting/text_painter.dart', target: 'package:flutter/services.dart', show: {'TextRange', 'TextSelection'}, hide: null),
    ];
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

    // Register class aliases (typedef type aliases)
    final aliases = classAliases();
    for (final entry in aliases.entries) {
      interpreter.registerClassAlias(entry.key, entry.value, importPath);
    }

    // Register function typedefs for type resolution
    final typedefs = functionTypedefs();
    for (final name in typedefs) {
      interpreter.registerFunctionTypedef(name, importPath);
    }

    // GEN-107: Register library re-exports
    for (final r in bridgeReExports()) {
      interpreter.registerLibraryReExport(r.source, r.target, show: r.show, hide: r.hide);
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
      interpreter.registerGlobalVariable('debugDisableShadows', $flutter_24.debugDisableShadows, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugDisableShadows": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugNetworkImageHttpClientProvider', $flutter_24.debugNetworkImageHttpClientProvider, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugNetworkImageHttpClientProvider": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugOnPaintImage', $flutter_24.debugOnPaintImage, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugOnPaintImage": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugInvertOversizedImages', $flutter_24.debugInvertOversizedImages, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugInvertOversizedImages": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugImageOverheadAllowance', $flutter_24.debugImageOverheadAllowance, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugImageOverheadAllowance": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugCaptureShaderWarmUpPicture', $flutter_24.debugCaptureShaderWarmUpPicture, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugCaptureShaderWarmUpPicture": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugCaptureShaderWarmUpImage', $flutter_24.debugCaptureShaderWarmUpImage, importPath, sourceUri: 'package:flutter/src/painting/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugCaptureShaderWarmUpImage": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDefaultFontSize', $flutter_50.kDefaultFontSize, importPath, sourceUri: 'package:flutter/src/painting/text_painter.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDefaultFontSize": $e');
    }
    interpreter.registerGlobalGetter('imageCache', () => $flutter_13.imageCache, importPath, sourceUri: 'package:flutter/src/painting/binding.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_painting):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'flipAxis': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'flipAxis');
        final direction = D4.getRequiredArg<$flutter_11.Axis>(positional, 0, 'direction', 'flipAxis');
        return $flutter_11.flipAxis(direction);
      },
      'axisDirectionToAxis': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'axisDirectionToAxis');
        final axisDirection = D4.getRequiredArg<$flutter_11.AxisDirection>(positional, 0, 'axisDirection', 'axisDirectionToAxis');
        return $flutter_11.axisDirectionToAxis(axisDirection);
      },
      'textDirectionToAxisDirection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'textDirectionToAxisDirection');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'textDirection', 'textDirectionToAxisDirection');
        return $flutter_11.textDirectionToAxisDirection(textDirection);
      },
      'flipAxisDirection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'flipAxisDirection');
        final axisDirection = D4.getRequiredArg<$flutter_11.AxisDirection>(positional, 0, 'axisDirection', 'flipAxisDirection');
        return $flutter_11.flipAxisDirection(axisDirection);
      },
      'axisDirectionIsReversed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'axisDirectionIsReversed');
        final axisDirection = D4.getRequiredArg<$flutter_11.AxisDirection>(positional, 0, 'axisDirection', 'axisDirectionIsReversed');
        return $flutter_11.axisDirectionIsReversed(axisDirection);
      },
      'paintBorder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'paintBorder');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintBorder');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintBorder');
        final top = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'top', $flutter_15.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'right', $flutter_15.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'bottom', $flutter_15.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'left', $flutter_15.BorderSide.none);
        return $flutter_15.paintBorder(canvas, rect, top: top, right: right, bottom: bottom, left: left);
      },
      'applyBoxFit': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'applyBoxFit');
        final fit = D4.getRequiredArg<$flutter_18.BoxFit>(positional, 0, 'fit', 'applyBoxFit');
        final inputSize = D4.getRequiredArg<Size>(positional, 1, 'inputSize', 'applyBoxFit');
        final outputSize = D4.getRequiredArg<Size>(positional, 2, 'outputSize', 'applyBoxFit');
        return $flutter_18.applyBoxFit(fit, inputSize, outputSize);
      },
      'debugAssertAllPaintingVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllPaintingVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllPaintingVarsUnset');
        final debugDisableShadowsOverride = D4.getNamedArgWithDefault<bool>(named, 'debugDisableShadowsOverride', false);
        return $flutter_24.debugAssertAllPaintingVarsUnset(reason, debugDisableShadowsOverride: debugDisableShadowsOverride);
      },
      'debugCheckCanResolveTextDirection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'debugCheckCanResolveTextDirection');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'debugCheckCanResolveTextDirection');
        final target = D4.getRequiredArg<String>(positional, 1, 'target', 'debugCheckCanResolveTextDirection');
        return $flutter_24.debugCheckCanResolveTextDirection(direction, target);
      },
      'debugFlushLastFrameImageSizeInfo': (visitor, positional, named, typeArgs) {
        return $flutter_26.debugFlushLastFrameImageSizeInfo();
      },
      'paintImage': (visitor, positional, named, typeArgs) {
        final canvas = D4.getRequiredNamedArg<Canvas>(named, 'canvas', 'paintImage');
        final rect = D4.getRequiredNamedArg<Rect>(named, 'rect', 'paintImage');
        final image = D4.getRequiredNamedArg<Image>(named, 'image', 'paintImage');
        final debugImageLabel = D4.getOptionalNamedArg<String?>(named, 'debugImageLabel');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final opacity = D4.getNamedArgWithDefault<double>(named, 'opacity', 1.0);
        final colorFilter = D4.getOptionalNamedArg<ColorFilter?>(named, 'colorFilter');
        final fit = D4.getOptionalNamedArg<$flutter_18.BoxFit?>(named, 'fit');
        final alignment = D4.getNamedArgWithDefault<$flutter_10.Alignment>(named, 'alignment', $flutter_10.Alignment.center);
        final centerSlice = D4.getOptionalNamedArg<Rect?>(named, 'centerSlice');
        final repeat = D4.getNamedArgWithDefault<$flutter_26.ImageRepeat>(named, 'repeat', $flutter_26.ImageRepeat.noRepeat);
        final flipHorizontally = D4.getNamedArgWithDefault<bool>(named, 'flipHorizontally', false);
        final invertColors = D4.getNamedArgWithDefault<bool>(named, 'invertColors', false);
        final filterQuality = D4.getNamedArgWithDefault<FilterQuality>(named, 'filterQuality', $dart_ui.FilterQuality.medium);
        final isAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'isAntiAlias', false);
        final blendMode = D4.getNamedArgWithDefault<BlendMode>(named, 'blendMode', $dart_ui.BlendMode.srcOver);
        return $flutter_26.paintImage(canvas: canvas, rect: rect, image: image, debugImageLabel: debugImageLabel, scale: scale, opacity: opacity, colorFilter: colorFilter, fit: fit, alignment: alignment, centerSlice: centerSlice, repeat: repeat, flipHorizontally: flipHorizontally, invertColors: invertColors, filterQuality: filterQuality, isAntiAlias: isAntiAlias, blendMode: blendMode);
      },
      'positionDependentBox': (visitor, positional, named, typeArgs) {
        final size = D4.getRequiredNamedArg<Size>(named, 'size', 'positionDependentBox');
        final childSize = D4.getRequiredNamedArg<Size>(named, 'childSize', 'positionDependentBox');
        final target = D4.getRequiredNamedArg<Offset>(named, 'target', 'positionDependentBox');
        final preferBelow = D4.getRequiredNamedArg<bool>(named, 'preferBelow', 'positionDependentBox');
        final verticalOffset = D4.getNamedArgWithDefault<double>(named, 'verticalOffset', 0.0);
        final margin = D4.getNamedArgWithDefault<double>(named, 'margin', 10.0);
        return $flutter_30.positionDependentBox(size: size, childSize: childSize, target: target, preferBelow: preferBelow, verticalOffset: verticalOffset, margin: margin);
      },
      'decodeImageFromList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'decodeImageFromList');
        final bytes = D4.getRequiredArg<Uint8List>(positional, 0, 'bytes', 'decodeImageFromList');
        return $flutter_33.decodeImageFromList(bytes);
      },
      'combineSemanticsInfo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'combineSemanticsInfo');
        final infoList = D4.getRequiredArg<List<$flutter_37.InlineSpanSemanticsInformation>>(positional, 0, 'infoList', 'combineSemanticsInfo');
        return $flutter_37.combineSemanticsInfo(infoList);
      },
      'debugDescribeTransform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugDescribeTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'debugDescribeTransform');
        return $flutter_39.debugDescribeTransform(transform);
      },
      'paintZigZag': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'paintZigZag');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintZigZag');
        final paint = D4.getRequiredArg<Paint>(positional, 1, 'paint', 'paintZigZag');
        final start = D4.getRequiredArg<Offset>(positional, 2, 'start', 'paintZigZag');
        final end = D4.getRequiredArg<Offset>(positional, 3, 'end', 'paintZigZag');
        final zigs = D4.getRequiredArg<int>(positional, 4, 'zigs', 'paintZigZag');
        final width = D4.getRequiredArg<double>(positional, 5, 'width', 'paintZigZag');
        return $flutter_42.paintZigZag(canvas, paint, start, end, zigs, width);
      },
      'lerpFontVariations': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpFontVariations');
        final a = D4.getRequiredArg<List<FontVariation>?>(positional, 0, 'a', 'lerpFontVariations');
        final b = D4.getRequiredArg<List<FontVariation>?>(positional, 1, 'b', 'lerpFontVariations');
        final t = D4.getRequiredArg<double>(positional, 2, 't', 'lerpFontVariations');
        return $flutter_53.lerpFontVariations(a, b, t);
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
      'debugFlushLastFrameImageSizeInfo': 'package:flutter/src/painting/decoration_image.dart',
      'paintImage': 'package:flutter/src/painting/decoration_image.dart',
      'positionDependentBox': 'package:flutter/src/painting/geometry.dart',
      'decodeImageFromList': 'package:flutter/src/painting/image_decoder.dart',
      'combineSemanticsInfo': 'package:flutter/src/painting/inline_span.dart',
      'debugDescribeTransform': 'package:flutter/src/painting/matrix_utils.dart',
      'paintZigZag': 'package:flutter/src/painting/paint_utilities.dart',
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
      'debugFlushLastFrameImageSizeInfo': 'void debugFlushLastFrameImageSizeInfo()',
      'paintImage': 'void paintImage({required Canvas canvas, required Rect rect, required Image image, String? debugImageLabel, double scale = 1.0, double opacity = 1.0, ColorFilter? colorFilter, BoxFit? fit, Alignment alignment = Alignment.center, Rect? centerSlice, ImageRepeat repeat = ImageRepeat.noRepeat, bool flipHorizontally = false, bool invertColors = false, FilterQuality filterQuality = FilterQuality.medium, bool isAntiAlias = false, BlendMode blendMode = BlendMode.srcOver})',
      'positionDependentBox': 'Offset positionDependentBox({required Size size, required Size childSize, required Offset target, required bool preferBelow, double verticalOffset = 0.0, double margin = 10.0})',
      'decodeImageFromList': 'Future<Image> decodeImageFromList(Uint8List bytes)',
      'combineSemanticsInfo': 'List<InlineSpanSemanticsInformation> combineSemanticsInfo(List<InlineSpanSemanticsInformation> infoList)',
      'debugDescribeTransform': 'List<String> debugDescribeTransform(Matrix4? transform)',
      'paintZigZag': 'void paintZigZag(Canvas canvas, Paint paint, Offset start, Offset end, int zigs, double width)',
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
    nativeType: $flutter_10.AlignmentGeometry,
    name: 'AlignmentGeometry',
    isAssignable: (v) => v is $flutter_10.AlignmentGeometry,
    isAbstract: true,
    constructors: {
      'xy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AlignmentGeometry');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'AlignmentGeometry');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'AlignmentGeometry');
        return $flutter_10.AlignmentGeometry.xy(x, y);
      },
      'directional': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AlignmentGeometry');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'AlignmentGeometry');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'AlignmentGeometry');
        return $flutter_10.AlignmentGeometry.directional(start, y);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_10.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        return -t;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentGeometry>(target, 'AlignmentGeometry');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'topLeft': (visitor) => $flutter_10.AlignmentGeometry.topLeft,
      'topCenter': (visitor) => $flutter_10.AlignmentGeometry.topCenter,
      'topRight': (visitor) => $flutter_10.AlignmentGeometry.topRight,
      'topStart': (visitor) => $flutter_10.AlignmentGeometry.topStart,
      'topEnd': (visitor) => $flutter_10.AlignmentGeometry.topEnd,
      'centerLeft': (visitor) => $flutter_10.AlignmentGeometry.centerLeft,
      'center': (visitor) => $flutter_10.AlignmentGeometry.center,
      'centerRight': (visitor) => $flutter_10.AlignmentGeometry.centerRight,
      'centerStart': (visitor) => $flutter_10.AlignmentGeometry.centerStart,
      'centerEnd': (visitor) => $flutter_10.AlignmentGeometry.centerEnd,
      'bottomLeft': (visitor) => $flutter_10.AlignmentGeometry.bottomLeft,
      'bottomCenter': (visitor) => $flutter_10.AlignmentGeometry.bottomCenter,
      'bottomRight': (visitor) => $flutter_10.AlignmentGeometry.bottomRight,
      'bottomStart': (visitor) => $flutter_10.AlignmentGeometry.bottomStart,
      'bottomEnd': (visitor) => $flutter_10.AlignmentGeometry.bottomEnd,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_10.AlignmentGeometry?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_10.AlignmentGeometry?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_10.AlignmentGeometry.lerp(a, b, t_);
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
      'topStart': 'AlignmentGeometry get topStart',
      'topEnd': 'AlignmentGeometry get topEnd',
      'centerLeft': 'AlignmentGeometry get centerLeft',
      'center': 'AlignmentGeometry get center',
      'centerRight': 'AlignmentGeometry get centerRight',
      'centerStart': 'AlignmentGeometry get centerStart',
      'centerEnd': 'AlignmentGeometry get centerEnd',
      'bottomLeft': 'AlignmentGeometry get bottomLeft',
      'bottomCenter': 'AlignmentGeometry get bottomCenter',
      'bottomRight': 'AlignmentGeometry get bottomRight',
      'bottomStart': 'AlignmentGeometry get bottomStart',
      'bottomEnd': 'AlignmentGeometry get bottomEnd',
    },
  );
}

// =============================================================================
// Alignment Bridge
// =============================================================================

BridgedClass _createAlignmentBridge() {
  return BridgedClass(
    nativeType: $flutter_10.Alignment,
    name: 'Alignment',
    isAssignable: (v) => v is $flutter_10.Alignment,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Alignment');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Alignment');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Alignment');
        return $flutter_10.Alignment(x, y);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment').hashCode,
      'x': (visitor, target) => D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment').y,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_10.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        return t.toString();
      },
      'alongOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'alongOffset');
        final other = D4.getRequiredArg<Offset>(positional, 0, 'other', 'alongOffset');
        return t.alongOffset(other);
      },
      'alongSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'alongSize');
        final other = D4.getRequiredArg<Size>(positional, 0, 'other', 'alongSize');
        return t.alongSize(other);
      },
      'withinRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 1, 'withinRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'withinRect');
        return t.withinRect(rect);
      },
      'inscribe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        D4.requireMinArgs(positional, 2, 'inscribe');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inscribe');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'inscribe');
        return t.inscribe(size, rect);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_10.Alignment>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Alignment>(target, 'Alignment');
        final other = D4.getRequiredArg<$flutter_10.Alignment>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'topLeft': (visitor) => $flutter_10.Alignment.topLeft,
      'topCenter': (visitor) => $flutter_10.Alignment.topCenter,
      'topRight': (visitor) => $flutter_10.Alignment.topRight,
      'centerLeft': (visitor) => $flutter_10.Alignment.centerLeft,
      'center': (visitor) => $flutter_10.Alignment.center,
      'centerRight': (visitor) => $flutter_10.Alignment.centerRight,
      'bottomLeft': (visitor) => $flutter_10.Alignment.bottomLeft,
      'bottomCenter': (visitor) => $flutter_10.Alignment.bottomCenter,
      'bottomRight': (visitor) => $flutter_10.Alignment.bottomRight,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_10.Alignment?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_10.Alignment?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_10.Alignment.lerp(a, b, t_);
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
    nativeType: $flutter_10.AlignmentDirectional,
    name: 'AlignmentDirectional',
    isAssignable: (v) => v is $flutter_10.AlignmentDirectional,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AlignmentDirectional');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'AlignmentDirectional');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'AlignmentDirectional');
        return $flutter_10.AlignmentDirectional(start, y);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional').start,
      'y': (visitor, target) => D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional').y,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_10.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_10.AlignmentDirectional>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AlignmentDirectional>(target, 'AlignmentDirectional');
        final other = D4.getRequiredArg<$flutter_10.AlignmentDirectional>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'topStart': (visitor) => $flutter_10.AlignmentDirectional.topStart,
      'topCenter': (visitor) => $flutter_10.AlignmentDirectional.topCenter,
      'topEnd': (visitor) => $flutter_10.AlignmentDirectional.topEnd,
      'centerStart': (visitor) => $flutter_10.AlignmentDirectional.centerStart,
      'center': (visitor) => $flutter_10.AlignmentDirectional.center,
      'centerEnd': (visitor) => $flutter_10.AlignmentDirectional.centerEnd,
      'bottomStart': (visitor) => $flutter_10.AlignmentDirectional.bottomStart,
      'bottomCenter': (visitor) => $flutter_10.AlignmentDirectional.bottomCenter,
      'bottomEnd': (visitor) => $flutter_10.AlignmentDirectional.bottomEnd,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_10.AlignmentDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_10.AlignmentDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_10.AlignmentDirectional.lerp(a, b, t_);
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
    nativeType: $flutter_10.TextAlignVertical,
    name: 'TextAlignVertical',
    isAssignable: (v) => v is $flutter_10.TextAlignVertical,
    constructors: {
      '': (visitor, positional, named) {
        final y = D4.getRequiredNamedArg<double>(named, 'y', 'TextAlignVertical');
        return $flutter_10.TextAlignVertical(y: y);
      },
    },
    getters: {
      'y': (visitor, target) => D4.validateTarget<$flutter_10.TextAlignVertical>(target, 'TextAlignVertical').y,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.TextAlignVertical>(target, 'TextAlignVertical');
        return t.toString();
      },
    },
    staticGetters: {
      'top': (visitor) => $flutter_10.TextAlignVertical.top,
      'center': (visitor) => $flutter_10.TextAlignVertical.center,
      'bottom': (visitor) => $flutter_10.TextAlignVertical.bottom,
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
    nativeType: $flutter_12.BeveledRectangleBorder,
    name: 'BeveledRectangleBorder',
    isAssignable: (v) => v is $flutter_12.BeveledRectangleBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final borderRadius = D4.getNamedArgWithDefault<$flutter_14.BorderRadiusGeometry>(named, 'borderRadius', $flutter_14.BorderRadius.zero);
        return $flutter_12.BeveledRectangleBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.BeveledRectangleBorder>(target, 'BeveledRectangleBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const BeveledRectangleBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry borderRadius = BorderRadius.zero})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'BeveledRectangleBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
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
    nativeType: $flutter_13.PaintingBinding,
    name: 'PaintingBinding',
    isAssignable: (v) => v is $flutter_13.PaintingBinding,
    canBeUsedAsMixin: true,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'imageCache': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').imageCache,
      'systemFonts': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').systemFonts,
      'window': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').platformDispatcher,
      'locked': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').locked,
      'keyboard': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').keyboard,
      'keyEventManager': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').keyEventManager,
      'defaultBinaryMessenger': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').defaultBinaryMessenger,
      'channelBuffers': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').channelBuffers,
      'accessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').accessibilityFocus,
      'restorationManager': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').restorationManager,
      'lifecycleState': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').lifecycleState,
      'schedulingStrategy': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').schedulingStrategy,
      'transientCallbackCount': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').transientCallbackCount,
      'endOfFrame': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').endOfFrame,
      'hasScheduledFrame': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').hasScheduledFrame,
      'schedulerPhase': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').schedulerPhase,
      'framesEnabled': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').framesEnabled,
      'currentFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').currentFrameTimeStamp,
      'currentSystemFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').currentSystemFrameTimeStamp,
    },
    setters: {
      'schedulingStrategy': (visitor, target, value) {
        final schedulingStrategyRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'schedulingStrategy');
        D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding').schedulingStrategy = ({required int priority, required $flutter_54.SchedulerBinding scheduler}) { return D4.callInterpreterCallback(visitor!, schedulingStrategyRaw, [], {'priority': priority, 'scheduler': scheduler}) as bool; };
      },
    },
    methods: {
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.initInstances();
        return null;
      },
      'createImageCache': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.createImageCache();
      },
      'instantiateImageCodecFromBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'instantiateImageCodecFromBuffer');
        final buffer = D4.getRequiredArg<ImmutableBuffer>(positional, 0, 'buffer', 'instantiateImageCodecFromBuffer');
        final cacheWidth = D4.getOptionalNamedArg<int?>(named, 'cacheWidth');
        final cacheHeight = D4.getOptionalNamedArg<int?>(named, 'cacheHeight');
        final allowUpscaling = D4.getNamedArgWithDefault<bool>(named, 'allowUpscaling', false);
        return t.instantiateImageCodecFromBuffer(buffer, cacheWidth: cacheWidth, cacheHeight: cacheHeight, allowUpscaling: allowUpscaling);
      },
      'instantiateImageCodecWithSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'instantiateImageCodecWithSize');
        final buffer = D4.getRequiredArg<ImmutableBuffer>(positional, 0, 'buffer', 'instantiateImageCodecWithSize');
        final getTargetSizeRaw = named['getTargetSize'];
        return t.instantiateImageCodecWithSize(buffer, getTargetSize: getTargetSizeRaw == null ? null : ((int p0, int p1) { return D4.extractBridgedArg<TargetImageSize>(D4.callInterpreterCallback(visitor!, getTargetSizeRaw, [p0, p1]), 'callback', visitor) as TargetImageSize; }) as TargetImageSize Function(int, int));
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'evict');
        final asset = D4.getRequiredArg<String>(positional, 0, 'asset', 'evict');
        t.evict(asset);
        return null;
      },
      'handleMemoryPressure': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.handleMemoryPressure();
        return null;
      },
      'handleSystemMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'handleSystemMessage');
        final systemMessage = D4.getRequiredArg<Object>(positional, 0, 'systemMessage', 'handleSystemMessage');
        return t.handleSystemMessage(systemMessage);
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'lockEvents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'lockEvents');
        if (positional.isEmpty) {
          throw ArgumentError('lockEvents: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.lockEvents((() { return D4.extractBridgedArg<Future<void>>(D4.callInterpreterCallback(visitor!, callbackRaw, []), 'callback', visitor) as Future<void>; }) as Future<void> Function());
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        (t as dynamic).unlocked();
        return null;
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.reassembleApplication();
      },
      'performReassemble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.performReassemble();
      },
      'registerSignalServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerSignalServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerSignalServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerSignalServiceExtension(name: name, callback: (() { return D4.extractBridgedArg<Future<void>>(D4.callInterpreterCallback(visitor!, callbackRaw, []), 'callback', visitor) as Future<void>; }) as Future<void> Function());
        return null;
      },
      'registerBoolServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerBoolServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerBoolServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerBoolServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerBoolServiceExtension(name: name, getter: (() { return D4.extractBridgedArg<Future<bool>>(D4.callInterpreterCallback(visitor!, getterRaw, []), 'callback', visitor) as Future<bool>; }) as Future<bool> Function(), setter: ((bool p0) { return D4.extractBridgedArg<Future<void>>(D4.callInterpreterCallback(visitor!, setterRaw, [p0]), 'callback', visitor) as Future<void>; }) as Future<void> Function(bool));
        return null;
      },
      'registerNumericServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerNumericServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerNumericServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerNumericServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerNumericServiceExtension(name: name, getter: (() { return D4.extractBridgedArg<Future<double>>(D4.callInterpreterCallback(visitor!, getterRaw, []), 'callback', visitor) as Future<double>; }) as Future<double> Function(), setter: ((double p0) { return D4.extractBridgedArg<Future<void>>(D4.callInterpreterCallback(visitor!, setterRaw, [p0]), 'callback', visitor) as Future<void>; }) as Future<void> Function(double));
        return null;
      },
      'postEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
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
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerStringServiceExtension');
        if (!named.containsKey('getter') || named['getter'] == null) {
          throw ArgumentError('registerStringServiceExtension: Missing required named argument "getter"');
        }
        final getterRaw = named['getter'];
        if (!named.containsKey('setter') || named['setter'] == null) {
          throw ArgumentError('registerStringServiceExtension: Missing required named argument "setter"');
        }
        final setterRaw = named['setter'];
        t.registerStringServiceExtension(name: name, getter: (() { return D4.extractBridgedArg<Future<String>>(D4.callInterpreterCallback(visitor!, getterRaw, []), 'callback', visitor) as Future<String>; }) as Future<String> Function(), setter: ((String p0) { return D4.extractBridgedArg<Future<void>>(D4.callInterpreterCallback(visitor!, setterRaw, [p0]), 'callback', visitor) as Future<void>; }) as Future<void> Function(String));
        return null;
      },
      'registerServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: ((Map<String, String> p0) { return D4.extractBridgedArg<Future<Map<String, dynamic>>>(D4.callInterpreterCallback(visitor!, callbackRaw, [p0]), 'callback', visitor) as Future<Map<String, dynamic>>; }) as Future<Map<String, dynamic>> Function(Map<String, String>));
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.toString();
      },
      'createBinaryMessenger': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.createBinaryMessenger();
      },
      'initLicenses': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.initLicenses();
        return null;
      },
      'readInitialLifecycleStateFromNativeWindow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.readInitialLifecycleStateFromNativeWindow();
        return null;
      },
      'handleViewFocusChanged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'handleViewFocusChanged');
        final event = D4.getRequiredArg<ViewFocusEvent>(positional, 0, 'event', 'handleViewFocusChanged');
        t.handleViewFocusChanged(event);
        return null;
      },
      'handleRequestAppExit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.handleRequestAppExit();
      },
      'exitApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'exitApplication');
        final exitType = D4.getRequiredArg<AppExitType>(positional, 0, 'exitType', 'exitApplication');
        final exitCode = D4.getOptionalArgWithDefault<int>(positional, 1, 'exitCode', 0);
        return t.exitApplication(exitType, exitCode);
      },
      'createRestorationManager': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.createRestorationManager();
      },
      'setSystemUiChangeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'setSystemUiChangeCallback');
        if (positional.isEmpty) {
          throw ArgumentError('setSystemUiChangeCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.setSystemUiChangeCallback(callbackRaw == null ? null : ((bool p0) { return D4.extractBridgedArg<Future<void>>(D4.callInterpreterCallback(visitor!, callbackRaw, [p0]), 'callback', visitor) as Future<void>; }) as Future<void> Function(bool));
        return null;
      },
      'initializationComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.initializationComplete();
      },
      'addTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'addTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'removeTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'removeTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'resetInternalState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.resetInternalState();
        return null;
      },
      'handleAppLifecycleStateChanged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'handleAppLifecycleStateChanged');
        final state = D4.getRequiredArg<AppLifecycleState>(positional, 0, 'state', 'handleAppLifecycleStateChanged');
        t.handleAppLifecycleStateChanged(state);
        return null;
      },
      'scheduleTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 2, 'scheduleTask');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        final priority = D4.getRequiredArg<$flutter_55.Priority>(positional, 1, 'priority', 'scheduleTask');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return t.scheduleTask((() { return D4.castCallbackResult<FutureOr<Object?>>(D4.callInterpreterCallback(visitor!, taskRaw, [])); }) as FutureOr<Object?> Function(), priority, debugLabel: debugLabel, flow: flow);
      },
      'handleEventLoopCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.handleEventLoopCallback();
      },
      'scheduleFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
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
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'cancelFrameCallbackWithId');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'cancelFrameCallbackWithId');
        t.cancelFrameCallbackWithId(id);
        return null;
      },
      'debugAssertNoTransientCallbacks': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTransientCallbacks');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTransientCallbacks');
        return t.debugAssertNoTransientCallbacks(reason);
      },
      'debugAssertNoPendingPerformanceModeRequests': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoPendingPerformanceModeRequests');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoPendingPerformanceModeRequests');
        return t.debugAssertNoPendingPerformanceModeRequests(reason);
      },
      'debugAssertNoTimeDilation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTimeDilation');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTimeDilation');
        return t.debugAssertNoTimeDilation(reason);
      },
      'addPersistentFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'addPersistentFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPersistentFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addPersistentFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'addPostFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
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
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.ensureFrameCallbacksRegistered();
        return null;
      },
      'ensureVisualUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.ensureVisualUpdate();
        return null;
      },
      'scheduleFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.scheduleFrame();
        return null;
      },
      'scheduleForcedFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.scheduleForcedFrame();
        return null;
      },
      'scheduleWarmUpFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.scheduleWarmUpFrame();
        return null;
      },
      'resetEpoch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.resetEpoch();
        return null;
      },
      'handleBeginFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'handleBeginFrame');
        final rawTimeStamp = D4.getRequiredArg<Duration?>(positional, 0, 'rawTimeStamp', 'handleBeginFrame');
        t.handleBeginFrame(rawTimeStamp);
        return null;
      },
      'requestPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        D4.requireMinArgs(positional, 1, 'requestPerformanceMode');
        final mode = D4.getRequiredArg<DartPerformanceMode>(positional, 0, 'mode', 'requestPerformanceMode');
        return t.requestPerformanceMode(mode);
      },
      'debugGetRequestedPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        return t.debugGetRequestedPerformanceMode();
      },
      'handleDrawFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PaintingBinding>(target, 'PaintingBinding');
        t.handleDrawFrame();
        return null;
      },
    },
    staticGetters: {
      'shaderWarmUp': (visitor) => $flutter_13.PaintingBinding.shaderWarmUp,
      'instance': (visitor) => $flutter_13.PaintingBinding.instance,
    },
    staticSetters: {
      'shaderWarmUp': (visitor, value) => 
        $flutter_13.PaintingBinding.shaderWarmUp = D4.extractBridgedArgOrNull<$flutter_45.ShaderWarmUp>(value, 'shaderWarmUp'),
    },
    methodSignatures: {
      'initInstances': 'void initInstances()',
      'createImageCache': 'ImageCache createImageCache()',
      'instantiateImageCodecFromBuffer': 'Future<Codec> instantiateImageCodecFromBuffer(ImmutableBuffer buffer, {int? cacheWidth, int? cacheHeight, bool allowUpscaling = false})',
      'instantiateImageCodecWithSize': 'Future<Codec> instantiateImageCodecWithSize(ImmutableBuffer buffer, {TargetImageSizeCallback? getTargetSize})',
      'evict': 'void evict(String asset)',
      'handleMemoryPressure': 'void handleMemoryPressure()',
      'handleSystemMessage': 'Future<void> handleSystemMessage(Object systemMessage)',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'initServiceExtensions': 'void initServiceExtensions()',
      'lockEvents': 'Future<void> lockEvents(Future<void> Function() callback)',
      'unlocked': 'void unlocked()',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'performReassemble': 'Future<void> performReassemble()',
      'registerSignalServiceExtension': 'void registerSignalServiceExtension({required String name, required AsyncCallback callback})',
      'registerBoolServiceExtension': 'void registerBoolServiceExtension({required String name, required AsyncValueGetter<bool> getter, required AsyncValueSetter<bool> setter})',
      'registerNumericServiceExtension': 'void registerNumericServiceExtension({required String name, required AsyncValueGetter<double> getter, required AsyncValueSetter<double> setter})',
      'postEvent': 'void postEvent(String eventKind, Map<String, dynamic> eventData)',
      'registerStringServiceExtension': 'void registerStringServiceExtension({required String name, required AsyncValueGetter<String> getter, required AsyncValueSetter<String> setter})',
      'registerServiceExtension': 'void registerServiceExtension({required String name, required ServiceExtensionCallback callback})',
      'toString': 'String toString()',
      'createBinaryMessenger': 'BinaryMessenger createBinaryMessenger()',
      'initLicenses': 'void initLicenses()',
      'readInitialLifecycleStateFromNativeWindow': 'void readInitialLifecycleStateFromNativeWindow()',
      'handleViewFocusChanged': 'void handleViewFocusChanged(ViewFocusEvent event)',
      'handleRequestAppExit': 'Future<AppExitResponse> handleRequestAppExit()',
      'exitApplication': 'Future<AppExitResponse> exitApplication(AppExitType exitType, [int exitCode = 0])',
      'createRestorationManager': 'RestorationManager createRestorationManager()',
      'setSystemUiChangeCallback': 'void setSystemUiChangeCallback(SystemUiChangeCallback? callback)',
      'initializationComplete': 'Future<void> initializationComplete()',
      'addTimingsCallback': 'void addTimingsCallback(TimingsCallback callback)',
      'removeTimingsCallback': 'void removeTimingsCallback(TimingsCallback callback)',
      'resetInternalState': 'void resetInternalState()',
      'handleAppLifecycleStateChanged': 'void handleAppLifecycleStateChanged(AppLifecycleState state)',
      'scheduleTask': 'Future<T> scheduleTask(TaskCallback<T> task, Priority priority, {String? debugLabel, Flow? flow})',
      'handleEventLoopCallback': 'bool handleEventLoopCallback()',
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
    },
    getterSignatures: {
      'imageCache': 'ImageCache get imageCache',
      'systemFonts': 'Listenable get systemFonts',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
      'locked': 'bool get locked',
      'keyboard': 'HardwareKeyboard get keyboard',
      'keyEventManager': 'KeyEventManager get keyEventManager',
      'defaultBinaryMessenger': 'BinaryMessenger get defaultBinaryMessenger',
      'channelBuffers': 'ChannelBuffers get channelBuffers',
      'accessibilityFocus': 'ValueNotifier<int?> get accessibilityFocus',
      'restorationManager': 'RestorationManager get restorationManager',
      'lifecycleState': 'AppLifecycleState? get lifecycleState',
      'schedulingStrategy': 'SchedulingStrategy get schedulingStrategy',
      'transientCallbackCount': 'int get transientCallbackCount',
      'endOfFrame': 'Future<void> get endOfFrame',
      'hasScheduledFrame': 'bool get hasScheduledFrame',
      'schedulerPhase': 'SchedulerPhase get schedulerPhase',
      'framesEnabled': 'bool get framesEnabled',
      'currentFrameTimeStamp': 'Duration get currentFrameTimeStamp',
      'currentSystemFrameTimeStamp': 'Duration get currentSystemFrameTimeStamp',
    },
    setterSignatures: {
      'schedulingStrategy': 'set schedulingStrategy(SchedulingStrategy value)',
    },
    staticGetterSignatures: {
      'shaderWarmUp': 'ShaderWarmUp? get shaderWarmUp',
      'instance': 'PaintingBinding get instance',
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
    nativeType: $flutter_14.BorderRadiusGeometry,
    name: 'BorderRadiusGeometry',
    isAssignable: (v) => v is $flutter_14.BorderRadiusGeometry,
    isAbstract: true,
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusGeometry');
        final radius = D4.getRequiredArg<Radius>(positional, 0, 'radius', 'BorderRadiusGeometry');
        return $flutter_14.BorderRadiusGeometry.all(radius);
      },
      'circular': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusGeometry');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'BorderRadiusGeometry');
        return $flutter_14.BorderRadiusGeometry.circular(radius);
      },
      'horizontal': (visitor, positional, named) {
        final left = D4.getOptionalNamedArg<Radius?>(named, 'left');
        final right = D4.getOptionalNamedArg<Radius?>(named, 'right');
        final start = D4.getOptionalNamedArg<Radius?>(named, 'start');
        final end = D4.getOptionalNamedArg<Radius?>(named, 'end');
        return $flutter_14.BorderRadiusGeometry.horizontal(left: left, right: right, start: start, end: end);
      },
      'only': (visitor, positional, named) {
        if (!named.containsKey('topLeft') && !named.containsKey('topRight') && !named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          return $flutter_14.BorderRadiusGeometry.only();
        }
        if (named.containsKey('topLeft') && !named.containsKey('topRight') && !named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft);
        }
        if (!named.containsKey('topLeft') && named.containsKey('topRight') && !named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topRight: topRight);
        }
        if (named.containsKey('topLeft') && named.containsKey('topRight') && !named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft, topRight: topRight);
        }
        if (!named.containsKey('topLeft') && !named.containsKey('topRight') && named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(bottomLeft: bottomLeft);
        }
        if (named.containsKey('topLeft') && !named.containsKey('topRight') && named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft, bottomLeft: bottomLeft);
        }
        if (!named.containsKey('topLeft') && named.containsKey('topRight') && named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topRight: topRight, bottomLeft: bottomLeft);
        }
        if (named.containsKey('topLeft') && named.containsKey('topRight') && named.containsKey('bottomLeft') && !named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft);
        }
        if (!named.containsKey('topLeft') && !named.containsKey('topRight') && !named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(bottomRight: bottomRight);
        }
        if (named.containsKey('topLeft') && !named.containsKey('topRight') && !named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft, bottomRight: bottomRight);
        }
        if (!named.containsKey('topLeft') && named.containsKey('topRight') && !named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topRight: topRight, bottomRight: bottomRight);
        }
        if (named.containsKey('topLeft') && named.containsKey('topRight') && !named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft, topRight: topRight, bottomRight: bottomRight);
        }
        if (!named.containsKey('topLeft') && !named.containsKey('topRight') && named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(bottomLeft: bottomLeft, bottomRight: bottomRight);
        }
        if (named.containsKey('topLeft') && !named.containsKey('topRight') && named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft, bottomLeft: bottomLeft, bottomRight: bottomRight);
        }
        if (!named.containsKey('topLeft') && named.containsKey('topRight') && named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
        }
        if (named.containsKey('topLeft') && named.containsKey('topRight') && named.containsKey('bottomLeft') && named.containsKey('bottomRight')) {
          final topLeft = D4.getRequiredNamedArg<Radius>(named, 'topLeft', 'BorderRadiusGeometry');
          final topRight = D4.getRequiredNamedArg<Radius>(named, 'topRight', 'BorderRadiusGeometry');
          final bottomLeft = D4.getRequiredNamedArg<Radius>(named, 'bottomLeft', 'BorderRadiusGeometry');
          final bottomRight = D4.getRequiredNamedArg<Radius>(named, 'bottomRight', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.only(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'directional': (visitor, positional, named) {
        if (!named.containsKey('topStart') && !named.containsKey('topEnd') && !named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          return $flutter_14.BorderRadiusGeometry.directional();
        }
        if (named.containsKey('topStart') && !named.containsKey('topEnd') && !named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart);
        }
        if (!named.containsKey('topStart') && named.containsKey('topEnd') && !named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topEnd: topEnd);
        }
        if (named.containsKey('topStart') && named.containsKey('topEnd') && !named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart, topEnd: topEnd);
        }
        if (!named.containsKey('topStart') && !named.containsKey('topEnd') && named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(bottomStart: bottomStart);
        }
        if (named.containsKey('topStart') && !named.containsKey('topEnd') && named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart, bottomStart: bottomStart);
        }
        if (!named.containsKey('topStart') && named.containsKey('topEnd') && named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topEnd: topEnd, bottomStart: bottomStart);
        }
        if (named.containsKey('topStart') && named.containsKey('topEnd') && named.containsKey('bottomStart') && !named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart, topEnd: topEnd, bottomStart: bottomStart);
        }
        if (!named.containsKey('topStart') && !named.containsKey('topEnd') && !named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(bottomEnd: bottomEnd);
        }
        if (named.containsKey('topStart') && !named.containsKey('topEnd') && !named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart, bottomEnd: bottomEnd);
        }
        if (!named.containsKey('topStart') && named.containsKey('topEnd') && !named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topEnd: topEnd, bottomEnd: bottomEnd);
        }
        if (named.containsKey('topStart') && named.containsKey('topEnd') && !named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart, topEnd: topEnd, bottomEnd: bottomEnd);
        }
        if (!named.containsKey('topStart') && !named.containsKey('topEnd') && named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(bottomStart: bottomStart, bottomEnd: bottomEnd);
        }
        if (named.containsKey('topStart') && !named.containsKey('topEnd') && named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart, bottomStart: bottomStart, bottomEnd: bottomEnd);
        }
        if (!named.containsKey('topStart') && named.containsKey('topEnd') && named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topEnd: topEnd, bottomStart: bottomStart, bottomEnd: bottomEnd);
        }
        if (named.containsKey('topStart') && named.containsKey('topEnd') && named.containsKey('bottomStart') && named.containsKey('bottomEnd')) {
          final topStart = D4.getRequiredNamedArg<Radius>(named, 'topStart', 'BorderRadiusGeometry');
          final topEnd = D4.getRequiredNamedArg<Radius>(named, 'topEnd', 'BorderRadiusGeometry');
          final bottomStart = D4.getRequiredNamedArg<Radius>(named, 'bottomStart', 'BorderRadiusGeometry');
          final bottomEnd = D4.getRequiredNamedArg<Radius>(named, 'bottomEnd', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.directional(topStart: topStart, topEnd: topEnd, bottomStart: bottomStart, bottomEnd: bottomEnd);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'vertical': (visitor, positional, named) {
        if (!named.containsKey('top') && !named.containsKey('bottom')) {
          return $flutter_14.BorderRadiusGeometry.vertical();
        }
        if (named.containsKey('top') && !named.containsKey('bottom')) {
          final top = D4.getRequiredNamedArg<Radius>(named, 'top', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.vertical(top: top);
        }
        if (!named.containsKey('top') && named.containsKey('bottom')) {
          final bottom = D4.getRequiredNamedArg<Radius>(named, 'bottom', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.vertical(bottom: bottom);
        }
        if (named.containsKey('top') && named.containsKey('bottom')) {
          final top = D4.getRequiredNamedArg<Radius>(named, 'top', 'BorderRadiusGeometry');
          final bottom = D4.getRequiredNamedArg<Radius>(named, 'bottom', 'BorderRadiusGeometry');
          return $flutter_14.BorderRadiusGeometry.vertical(top: top, bottom: bottom);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry').hashCode,
    },
    methods: {
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        return -t;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusGeometry>(target, 'BorderRadiusGeometry');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_14.BorderRadiusGeometry.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_14.BorderRadiusGeometry.lerp(a, b, t_);
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
    nativeType: $flutter_14.BorderRadius,
    name: 'BorderRadius',
    isAssignable: (v) => v is $flutter_14.BorderRadius,
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadius');
        final radius = D4.getRequiredArg<Radius>(positional, 0, 'radius', 'BorderRadius');
        return $flutter_14.BorderRadius.all(radius);
      },
      'circular': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadius');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'BorderRadius');
        return $flutter_14.BorderRadius.circular(radius);
      },
      'vertical': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<Radius>(named, 'top', $dart_ui.Radius.zero);
        final bottom = D4.getNamedArgWithDefault<Radius>(named, 'bottom', $dart_ui.Radius.zero);
        return $flutter_14.BorderRadius.vertical(top: top, bottom: bottom);
      },
      'horizontal': (visitor, positional, named) {
        final left = D4.getNamedArgWithDefault<Radius>(named, 'left', $dart_ui.Radius.zero);
        final right = D4.getNamedArgWithDefault<Radius>(named, 'right', $dart_ui.Radius.zero);
        return $flutter_14.BorderRadius.horizontal(left: left, right: right);
      },
      'only': (visitor, positional, named) {
        final topLeft = D4.getNamedArgWithDefault<Radius>(named, 'topLeft', $dart_ui.Radius.zero);
        final topRight = D4.getNamedArgWithDefault<Radius>(named, 'topRight', $dart_ui.Radius.zero);
        final bottomLeft = D4.getNamedArgWithDefault<Radius>(named, 'bottomLeft', $dart_ui.Radius.zero);
        final bottomRight = D4.getNamedArgWithDefault<Radius>(named, 'bottomRight', $dart_ui.Radius.zero);
        return $flutter_14.BorderRadius.only(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius').hashCode,
      'topLeft': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius').topLeft,
      'topRight': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius').topRight,
      'bottomLeft': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius').bottomLeft,
      'bottomRight': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius').bottomRight,
    },
    methods: {
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        final topLeft = D4.getOptionalNamedArg<Radius?>(named, 'topLeft');
        final topRight = D4.getOptionalNamedArg<Radius?>(named, 'topRight');
        final bottomLeft = D4.getOptionalNamedArg<Radius?>(named, 'bottomLeft');
        final bottomRight = D4.getOptionalNamedArg<Radius?>(named, 'bottomRight');
        return t.copyWith(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight);
      },
      'toRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'toRRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'toRRect');
        return t.toRRect(rect);
      },
      'toRSuperellipse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        D4.requireMinArgs(positional, 1, 'toRSuperellipse');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'toRSuperellipse');
        return t.toRSuperellipse(rect);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_14.BorderRadius>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadius>(target, 'BorderRadius');
        final other = D4.getRequiredArg<$flutter_14.BorderRadius>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_14.BorderRadius.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_14.BorderRadius?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_14.BorderRadius?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_14.BorderRadius.lerp(a, b, t_);
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
    nativeType: $flutter_14.BorderRadiusDirectional,
    name: 'BorderRadiusDirectional',
    isAssignable: (v) => v is $flutter_14.BorderRadiusDirectional,
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusDirectional');
        final radius = D4.getRequiredArg<Radius>(positional, 0, 'radius', 'BorderRadiusDirectional');
        return $flutter_14.BorderRadiusDirectional.all(radius);
      },
      'circular': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BorderRadiusDirectional');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'BorderRadiusDirectional');
        return $flutter_14.BorderRadiusDirectional.circular(radius);
      },
      'vertical': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<Radius>(named, 'top', $dart_ui.Radius.zero);
        final bottom = D4.getNamedArgWithDefault<Radius>(named, 'bottom', $dart_ui.Radius.zero);
        return $flutter_14.BorderRadiusDirectional.vertical(top: top, bottom: bottom);
      },
      'horizontal': (visitor, positional, named) {
        final start = D4.getNamedArgWithDefault<Radius>(named, 'start', $dart_ui.Radius.zero);
        final end = D4.getNamedArgWithDefault<Radius>(named, 'end', $dart_ui.Radius.zero);
        return $flutter_14.BorderRadiusDirectional.horizontal(start: start, end: end);
      },
      'only': (visitor, positional, named) {
        final topStart = D4.getNamedArgWithDefault<Radius>(named, 'topStart', $dart_ui.Radius.zero);
        final topEnd = D4.getNamedArgWithDefault<Radius>(named, 'topEnd', $dart_ui.Radius.zero);
        final bottomStart = D4.getNamedArgWithDefault<Radius>(named, 'bottomStart', $dart_ui.Radius.zero);
        final bottomEnd = D4.getNamedArgWithDefault<Radius>(named, 'bottomEnd', $dart_ui.Radius.zero);
        return $flutter_14.BorderRadiusDirectional.only(topStart: topStart, topEnd: topEnd, bottomStart: bottomStart, bottomEnd: bottomEnd);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').hashCode,
      'topStart': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').topStart,
      'topEnd': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').topEnd,
      'bottomStart': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').bottomStart,
      'bottomEnd': (visitor, target) => D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional').bottomEnd,
    },
    methods: {
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_14.BorderRadiusGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_14.BorderRadiusDirectional>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.BorderRadiusDirectional>(target, 'BorderRadiusDirectional');
        final other = D4.getRequiredArg<$flutter_14.BorderRadiusDirectional>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_14.BorderRadiusDirectional.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_14.BorderRadiusDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_14.BorderRadiusDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_14.BorderRadiusDirectional.lerp(a, b, t_);
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
    nativeType: $flutter_15.BorderSide,
    name: 'BorderSide',
    isAssignable: (v) => v is $flutter_15.BorderSide,
    constructors: {
      '': (visitor, positional, named) {
        final color = D4.getNamedArgWithDefault<Color>(named, 'color', const $dart_ui.Color(0xFF000000));
        final width = D4.getNamedArgWithDefault<double>(named, 'width', 1.0);
        final style = D4.getNamedArgWithDefault<$flutter_15.BorderStyle>(named, 'style', $flutter_15.BorderStyle.solid);
        if (!named.containsKey('strokeAlign')) {
          return $flutter_15.BorderSide(color: color, width: width, style: style);
        }
        if (named.containsKey('strokeAlign')) {
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BorderSide');
          return $flutter_15.BorderSide(color: color, width: width, style: style, strokeAlign: strokeAlign);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'color': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').color,
      'width': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').width,
      'style': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').style,
      'strokeAlign': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').strokeAlign,
      'strokeInset': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').strokeInset,
      'strokeOutset': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').strokeOutset,
      'strokeOffset': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').strokeOffset,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final width = D4.getOptionalNamedArg<double?>(named, 'width');
        final style = D4.getOptionalNamedArg<$flutter_15.BorderStyle?>(named, 'style');
        final strokeAlign = D4.getOptionalNamedArg<double?>(named, 'strokeAlign');
        return t.copyWith(color: color, width: width, style: style, strokeAlign: strokeAlign);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'toPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        return t.toPaint();
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        return t.toStringShort();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.BorderSide>(target, 'BorderSide');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'none': (visitor) => $flutter_15.BorderSide.none,
      'strokeAlignInside': (visitor) => $flutter_15.BorderSide.strokeAlignInside,
      'strokeAlignCenter': (visitor) => $flutter_15.BorderSide.strokeAlignCenter,
      'strokeAlignOutside': (visitor) => $flutter_15.BorderSide.strokeAlignOutside,
    },
    staticMethods: {
      'merge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'merge');
        final a = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 0, 'a', 'merge');
        final b = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 1, 'b', 'merge');
        return $flutter_15.BorderSide.merge(a, b);
      },
      'canMerge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'canMerge');
        final a = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 0, 'a', 'canMerge');
        final b = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 1, 'b', 'canMerge');
        return $flutter_15.BorderSide.canMerge(a, b);
      },
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_15.BorderSide.lerp(a, b, t_);
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
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_15.ShapeBorder,
    name: 'ShapeBorder',
    isAssignable: (v) => v is $flutter_15.ShapeBorder,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder').preferPaintInterior,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.ShapeBorder>(target, 'ShapeBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_15.ShapeBorder.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
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
    nativeType: $flutter_15.OutlinedBorder,
    name: 'OutlinedBorder',
    isAssignable: (v) => v is $flutter_15.OutlinedBorder,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder').side,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        return t.copyWith(side: side);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_15.OutlinedBorder>(target, 'OutlinedBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_15.OutlinedBorder?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_15.OutlinedBorder?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_15.OutlinedBorder.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
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
    nativeType: $flutter_16.BoxBorder,
    name: 'BoxBorder',
    isAssignable: (v) => v is $flutter_16.BoxBorder,
    isAbstract: true,
    constructors: {
      'fromLTRB': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'top', $flutter_15.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'right', $flutter_15.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'bottom', $flutter_15.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'left', $flutter_15.BorderSide.none);
        return $flutter_16.BoxBorder.fromLTRB(top: top, right: right, bottom: bottom, left: left);
      },
      'all': (visitor, positional, named) {
        if (!named.containsKey('color') && !named.containsKey('width') && !named.containsKey('style') && !named.containsKey('strokeAlign')) {
          return $flutter_16.BoxBorder.all();
        }
        if (named.containsKey('color') && !named.containsKey('width') && !named.containsKey('style') && !named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color);
        }
        if (!named.containsKey('color') && named.containsKey('width') && !named.containsKey('style') && !named.containsKey('strokeAlign')) {
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          return $flutter_16.BoxBorder.all(width: width);
        }
        if (named.containsKey('color') && named.containsKey('width') && !named.containsKey('style') && !named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color, width: width);
        }
        if (!named.containsKey('color') && !named.containsKey('width') && named.containsKey('style') && !named.containsKey('strokeAlign')) {
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          return $flutter_16.BoxBorder.all(style: style);
        }
        if (named.containsKey('color') && !named.containsKey('width') && named.containsKey('style') && !named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color, style: style);
        }
        if (!named.containsKey('color') && named.containsKey('width') && named.containsKey('style') && !named.containsKey('strokeAlign')) {
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          return $flutter_16.BoxBorder.all(width: width, style: style);
        }
        if (named.containsKey('color') && named.containsKey('width') && named.containsKey('style') && !named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color, width: width, style: style);
        }
        if (!named.containsKey('color') && !named.containsKey('width') && !named.containsKey('style') && named.containsKey('strokeAlign')) {
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(strokeAlign: strokeAlign);
        }
        if (named.containsKey('color') && !named.containsKey('width') && !named.containsKey('style') && named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color, strokeAlign: strokeAlign);
        }
        if (!named.containsKey('color') && named.containsKey('width') && !named.containsKey('style') && named.containsKey('strokeAlign')) {
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(width: width, strokeAlign: strokeAlign);
        }
        if (named.containsKey('color') && named.containsKey('width') && !named.containsKey('style') && named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color, width: width, strokeAlign: strokeAlign);
        }
        if (!named.containsKey('color') && !named.containsKey('width') && named.containsKey('style') && named.containsKey('strokeAlign')) {
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(style: style, strokeAlign: strokeAlign);
        }
        if (named.containsKey('color') && !named.containsKey('width') && named.containsKey('style') && named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color, style: style, strokeAlign: strokeAlign);
        }
        if (!named.containsKey('color') && named.containsKey('width') && named.containsKey('style') && named.containsKey('strokeAlign')) {
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(width: width, style: style, strokeAlign: strokeAlign);
        }
        if (named.containsKey('color') && named.containsKey('width') && named.containsKey('style') && named.containsKey('strokeAlign')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxBorder');
          final width = D4.getRequiredNamedArg<double>(named, 'width', 'BoxBorder');
          final style = D4.getRequiredNamedArg<$flutter_15.BorderStyle>(named, 'style', 'BoxBorder');
          final strokeAlign = D4.getRequiredNamedArg<double>(named, 'strokeAlign', 'BoxBorder');
          return $flutter_16.BoxBorder.all(color: color, width: width, style: style, strokeAlign: strokeAlign);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'fromBorderSide': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BoxBorder');
        final side = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 0, 'side', 'BoxBorder');
        return $flutter_16.BoxBorder.fromBorderSide(side);
      },
      'symmetric': (visitor, positional, named) {
        if (!named.containsKey('vertical') && !named.containsKey('horizontal')) {
          return $flutter_16.BoxBorder.symmetric();
        }
        if (named.containsKey('vertical') && !named.containsKey('horizontal')) {
          final vertical = D4.getRequiredNamedArg<$flutter_15.BorderSide>(named, 'vertical', 'BoxBorder');
          return $flutter_16.BoxBorder.symmetric(vertical: vertical);
        }
        if (!named.containsKey('vertical') && named.containsKey('horizontal')) {
          final horizontal = D4.getRequiredNamedArg<$flutter_15.BorderSide>(named, 'horizontal', 'BoxBorder');
          return $flutter_16.BoxBorder.symmetric(horizontal: horizontal);
        }
        if (named.containsKey('vertical') && named.containsKey('horizontal')) {
          final vertical = D4.getRequiredNamedArg<$flutter_15.BorderSide>(named, 'vertical', 'BoxBorder');
          final horizontal = D4.getRequiredNamedArg<$flutter_15.BorderSide>(named, 'horizontal', 'BoxBorder');
          return $flutter_16.BoxBorder.symmetric(vertical: vertical, horizontal: horizontal);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'fromSTEB': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'top', $flutter_15.BorderSide.none);
        final start = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'start', $flutter_15.BorderSide.none);
        final end = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'end', $flutter_15.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'bottom', $flutter_15.BorderSide.none);
        return $flutter_16.BoxBorder.fromSTEB(top: top, start: start, end: end, bottom: bottom);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder').preferPaintInterior,
      'top': (visitor, target) => D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder').bottom,
      'isUniform': (visitor, target) => D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder').isUniform,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final shape = D4.getNamedArgWithDefault<$flutter_16.BoxShape>(named, 'shape', $flutter_16.BoxShape.rectangle);
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadius?>(named, 'borderRadius');
        t.paint(canvas, rect, textDirection: textDirection, shape: shape, borderRadius: borderRadius);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BoxBorder>(target, 'BoxBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_16.BoxBorder?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_16.BoxBorder?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_16.BoxBorder.lerp(a, b, t_);
      },
      'paintNonUniformBorder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'paintNonUniformBorder');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintNonUniformBorder');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintNonUniformBorder');
        final borderRadius = D4.getRequiredNamedArg<$flutter_14.BorderRadius?>(named, 'borderRadius', 'paintNonUniformBorder');
        final textDirection = D4.getRequiredNamedArg<TextDirection?>(named, 'textDirection', 'paintNonUniformBorder');
        final shape = D4.getNamedArgWithDefault<$flutter_16.BoxShape>(named, 'shape', $flutter_16.BoxShape.rectangle);
        final top = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'top', $flutter_15.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'right', $flutter_15.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'bottom', $flutter_15.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'left', $flutter_15.BorderSide.none);
        final color = D4.getRequiredNamedArg<Color>(named, 'color', 'paintNonUniformBorder');
        return $flutter_16.BoxBorder.paintNonUniformBorder(canvas, rect, borderRadius: borderRadius, textDirection: textDirection, shape: shape, top: top, right: right, bottom: bottom, left: left, color: color);
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
      'add': 'BoxBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
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
    nativeType: $flutter_16.Border,
    name: 'Border',
    isAssignable: (v) => v is $flutter_16.Border,
    constructors: {
      '': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'top', $flutter_15.BorderSide.none);
        final right = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'right', $flutter_15.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'bottom', $flutter_15.BorderSide.none);
        final left = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'left', $flutter_15.BorderSide.none);
        return $flutter_16.Border(top: top, right: right, bottom: bottom, left: left);
      },
      'fromBorderSide': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Border');
        final side = D4.getRequiredArg<$flutter_15.BorderSide>(positional, 0, 'side', 'Border');
        return $flutter_16.Border.fromBorderSide(side);
      },
      'symmetric': (visitor, positional, named) {
        final vertical = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'vertical', $flutter_15.BorderSide.none);
        final horizontal = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'horizontal', $flutter_15.BorderSide.none);
        return $flutter_16.Border.symmetric(vertical: vertical, horizontal: horizontal);
      },
      'all': (visitor, positional, named) {
        final color = D4.getNamedArgWithDefault<Color>(named, 'color', const $dart_ui.Color(0xFF000000));
        final width = D4.getNamedArgWithDefault<double>(named, 'width', 1.0);
        final style = D4.getNamedArgWithDefault<$flutter_15.BorderStyle>(named, 'style', $flutter_15.BorderStyle.solid);
        final strokeAlign = D4.getNamedArgWithDefault<double>(named, 'strokeAlign', $flutter_15.BorderSide.strokeAlignInside);
        return $flutter_16.Border.all(color: color, width: width, style: style, strokeAlign: strokeAlign);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').preferPaintInterior,
      'top': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').bottom,
      'isUniform': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').isUniform,
      'right': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').right,
      'left': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').left,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_16.Border>(target, 'Border').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final shape = D4.getNamedArgWithDefault<$flutter_16.BoxShape>(named, 'shape', $flutter_16.BoxShape.rectangle);
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadius?>(named, 'borderRadius');
        t.paint(canvas, rect, textDirection: textDirection, shape: shape, borderRadius: borderRadius);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.Border>(target, 'Border');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'merge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'merge');
        final a = D4.getRequiredArg<$flutter_16.Border>(positional, 0, 'a', 'merge');
        final b = D4.getRequiredArg<$flutter_16.Border>(positional, 1, 'b', 'merge');
        return $flutter_16.Border.merge(a, b);
      },
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_16.Border?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_16.Border?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_16.Border.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const Border({BorderSide top = BorderSide.none, BorderSide right = BorderSide.none, BorderSide bottom = BorderSide.none, BorderSide left = BorderSide.none})',
      'fromBorderSide': 'const Border.fromBorderSide(BorderSide side)',
      'symmetric': 'const Border.symmetric({BorderSide vertical = BorderSide.none, BorderSide horizontal = BorderSide.none})',
      'all': 'factory Border.all({Color color = const Color(0xFF000000), double width = 1.0, BorderStyle style = BorderStyle.solid, double strokeAlign = BorderSide.strokeAlignInside})',
    },
    methodSignatures: {
      'add': 'Border? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'Border scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
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
    nativeType: $flutter_16.BorderDirectional,
    name: 'BorderDirectional',
    isAssignable: (v) => v is $flutter_16.BorderDirectional,
    constructors: {
      '': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'top', $flutter_15.BorderSide.none);
        final start = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'start', $flutter_15.BorderSide.none);
        final end = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'end', $flutter_15.BorderSide.none);
        final bottom = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'bottom', $flutter_15.BorderSide.none);
        return $flutter_16.BorderDirectional(top: top, start: start, end: end, bottom: bottom);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').preferPaintInterior,
      'top': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').bottom,
      'isUniform': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').isUniform,
      'start': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').end,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final shape = D4.getNamedArgWithDefault<$flutter_16.BoxShape>(named, 'shape', $flutter_16.BoxShape.rectangle);
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadius?>(named, 'borderRadius');
        t.paint(canvas, rect, textDirection: textDirection, shape: shape, borderRadius: borderRadius);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.BorderDirectional>(target, 'BorderDirectional');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'merge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'merge');
        final a = D4.getRequiredArg<$flutter_16.BorderDirectional>(positional, 0, 'a', 'merge');
        final b = D4.getRequiredArg<$flutter_16.BorderDirectional>(positional, 1, 'b', 'merge');
        return $flutter_16.BorderDirectional.merge(a, b);
      },
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_16.BorderDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_16.BorderDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_16.BorderDirectional.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const BorderDirectional({BorderSide top = BorderSide.none, BorderSide start = BorderSide.none, BorderSide end = BorderSide.none, BorderSide bottom = BorderSide.none})',
    },
    methodSignatures: {
      'add': 'BoxBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'BorderDirectional scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
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
    nativeType: $flutter_17.BoxDecoration,
    name: 'BoxDecoration',
    isAssignable: (v) => v is $flutter_17.BoxDecoration,
    constructors: {
      '': (visitor, positional, named) {
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final image = D4.getOptionalNamedArg<$flutter_26.DecorationImage?>(named, 'image');
        final border = D4.getOptionalNamedArg<$flutter_16.BoxBorder?>(named, 'border');
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadiusGeometry?>(named, 'borderRadius');
        final boxShadow = D4.coerceListOrNull<$flutter_19.BoxShadow>(named['boxShadow'], 'boxShadow');
        final gradient = D4.getOptionalNamedArg<$flutter_31.Gradient?>(named, 'gradient');
        final backgroundBlendMode = D4.getOptionalNamedArg<BlendMode?>(named, 'backgroundBlendMode');
        final shape = D4.getNamedArgWithDefault<$flutter_16.BoxShape>(named, 'shape', $flutter_16.BoxShape.rectangle);
        return $flutter_17.BoxDecoration(color: color, image: image, border: border, borderRadius: borderRadius, boxShadow: boxShadow, gradient: gradient, backgroundBlendMode: backgroundBlendMode, shape: shape);
      },
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').isComplex,
      'color': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').color,
      'image': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').image,
      'border': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').border,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').borderRadius,
      'boxShadow': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').boxShadow,
      'gradient': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').gradient,
      'backgroundBlendMode': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').backgroundBlendMode,
      'shape': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').shape,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        return t.debugAssertIsValid();
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(onChangedRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final image = D4.getOptionalNamedArg<$flutter_26.DecorationImage?>(named, 'image');
        final border = D4.getOptionalNamedArg<$flutter_16.BoxBorder?>(named, 'border');
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadiusGeometry?>(named, 'borderRadius');
        final boxShadow = D4.coerceListOrNull<$flutter_19.BoxShadow>(named['boxShadow'], 'boxShadow');
        final gradient = D4.getOptionalNamedArg<$flutter_31.Gradient?>(named, 'gradient');
        final backgroundBlendMode = D4.getOptionalNamedArg<BlendMode?>(named, 'backgroundBlendMode');
        final shape = D4.getOptionalNamedArg<$flutter_16.BoxShape?>(named, 'shape');
        return t.copyWith(color: color, image: image, border: border, borderRadius: borderRadius, boxShadow: boxShadow, gradient: gradient, backgroundBlendMode: backgroundBlendMode, shape: shape);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.BoxDecoration>(target, 'BoxDecoration');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_17.BoxDecoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_17.BoxDecoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_17.BoxDecoration.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const BoxDecoration({Color? color, DecorationImage? image, BoxBorder? border, BorderRadiusGeometry? borderRadius, List<BoxShadow>? boxShadow, Gradient? gradient, BlendMode? backgroundBlendMode, BoxShape shape = BoxShape.rectangle})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'lerpFrom': 'BoxDecoration? lerpFrom(Decoration? a, double t)',
      'lerpTo': 'BoxDecoration? lerpTo(Decoration? b, double t)',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback? onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_18.FittedSizes,
    name: 'FittedSizes',
    isAssignable: (v) => v is $flutter_18.FittedSizes,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FittedSizes');
        final source = D4.getRequiredArg<Size>(positional, 0, 'source', 'FittedSizes');
        final destination = D4.getRequiredArg<Size>(positional, 1, 'destination', 'FittedSizes');
        return $flutter_18.FittedSizes(source, destination);
      },
    },
    getters: {
      'source': (visitor, target) => D4.validateTarget<$flutter_18.FittedSizes>(target, 'FittedSizes').source,
      'destination': (visitor, target) => D4.validateTarget<$flutter_18.FittedSizes>(target, 'FittedSizes').destination,
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
    nativeType: $flutter_19.BoxShadow,
    name: 'BoxShadow',
    isAssignable: (v) => v is $flutter_19.BoxShadow,
    constructors: {
      '': (visitor, positional, named) {
        final offset = D4.getNamedArgWithDefault<Offset>(named, 'offset', $dart_ui.Offset.zero);
        final blurRadius = D4.getNamedArgWithDefault<double>(named, 'blurRadius', 0.0);
        final spreadRadius = D4.getNamedArgWithDefault<double>(named, 'spreadRadius', 0.0);
        final blurStyle = D4.getNamedArgWithDefault<BlurStyle>(named, 'blurStyle', $dart_ui.BlurStyle.normal);
        if (!named.containsKey('color')) {
          return $flutter_19.BoxShadow(offset: offset, blurRadius: blurRadius, spreadRadius: spreadRadius, blurStyle: blurStyle);
        }
        if (named.containsKey('color')) {
          final color = D4.getRequiredNamedArg<Color>(named, 'color', 'BoxShadow');
          return $flutter_19.BoxShadow(offset: offset, blurRadius: blurRadius, spreadRadius: spreadRadius, blurStyle: blurStyle, color: color);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'spreadRadius': (visitor, target) => D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow').spreadRadius,
      'blurStyle': (visitor, target) => D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow').blurStyle,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow').hashCode,
      'color': (visitor, target) => D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow').color,
      'offset': (visitor, target) => D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow').offset,
      'blurRadius': (visitor, target) => D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow').blurRadius,
      'blurSigma': (visitor, target) => D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow').blurSigma,
    },
    methods: {
      'toPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow');
        return t.toPaint();
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow');
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final offset = D4.getOptionalNamedArg<Offset?>(named, 'offset');
        final blurRadius = D4.getOptionalNamedArg<double?>(named, 'blurRadius');
        final spreadRadius = D4.getOptionalNamedArg<double?>(named, 'spreadRadius');
        final blurStyle = D4.getOptionalNamedArg<BlurStyle?>(named, 'blurStyle');
        return t.copyWith(color: color, offset: offset, blurRadius: blurRadius, spreadRadius: spreadRadius, blurStyle: blurStyle);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.BoxShadow>(target, 'BoxShadow');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_19.BoxShadow?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_19.BoxShadow?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_19.BoxShadow.lerp(a, b, t_);
      },
      'lerpList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpList');
        if (positional.isEmpty) {
          throw ArgumentError('lerpList: Missing required argument "a" at position 0');
        }
        final a = D4.coerceListOrNull<$flutter_19.BoxShadow>(positional[0], 'a');
        if (positional.length <= 1) {
          throw ArgumentError('lerpList: Missing required argument "b" at position 1');
        }
        final b = D4.coerceListOrNull<$flutter_19.BoxShadow>(positional[1], 'b');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerpList');
        return $flutter_19.BoxShadow.lerpList(a, b, t_);
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
    nativeType: $flutter_20.CircleBorder,
    name: 'CircleBorder',
    isAssignable: (v) => v is $flutter_20.CircleBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final eccentricity = D4.getNamedArgWithDefault<double>(named, 'eccentricity', 0.0);
        return $flutter_20.CircleBorder(side: side, eccentricity: eccentricity);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder').side,
      'eccentricity': (visitor, target) => D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder').eccentricity,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final eccentricity = D4.getOptionalNamedArg<double?>(named, 'eccentricity');
        return t.copyWith(side: side, eccentricity: eccentricity);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.CircleBorder>(target, 'CircleBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const CircleBorder({BorderSide side = BorderSide.none, double eccentricity = 0.0})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'CircleBorder copyWith({BorderSide? side, double? eccentricity})',
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
    nativeType: $flutter_21.ClipContext,
    name: 'ClipContext',
    isAssignable: (v) => v is $flutter_21.ClipContext,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'canvas': (visitor, target) => D4.validateTarget<$flutter_21.ClipContext>(target, 'ClipContext').canvas,
    },
    methods: {
      'clipPathAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipPathAndPaint');
        final path = D4.getRequiredArg<Path>(positional, 0, 'path', 'clipPathAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipPathAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipPathAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipPathAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipPathAndPaint(path, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor!, painterRaw, []); });
        return null;
      },
      'clipRRectAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipRRectAndPaint');
        final rrect = D4.getRequiredArg<RRect>(positional, 0, 'rrect', 'clipRRectAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipRRectAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipRRectAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipRRectAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipRRectAndPaint(rrect, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor!, painterRaw, []); });
        return null;
      },
      'clipRSuperellipseAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipRSuperellipseAndPaint');
        final rse = D4.getRequiredArg<RSuperellipse>(positional, 0, 'rse', 'clipRSuperellipseAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipRSuperellipseAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipRSuperellipseAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipRSuperellipseAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipRSuperellipseAndPaint(rse, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor!, painterRaw, []); });
        return null;
      },
      'clipRectAndPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ClipContext>(target, 'ClipContext');
        D4.requireMinArgs(positional, 4, 'clipRectAndPaint');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'clipRectAndPaint');
        final clipBehavior = D4.getRequiredArg<Clip>(positional, 1, 'clipBehavior', 'clipRectAndPaint');
        final bounds = D4.getRequiredArg<Rect>(positional, 2, 'bounds', 'clipRectAndPaint');
        if (positional.length <= 3) {
          throw ArgumentError('clipRectAndPaint: Missing required argument "painter" at position 3');
        }
        final painterRaw = positional[3];
        t.clipRectAndPaint(rect, clipBehavior, bounds, () { D4.callInterpreterCallback(visitor!, painterRaw, []); });
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
    nativeType: $flutter_22.HSVColor,
    name: 'HSVColor',
    isAssignable: (v) => v is $flutter_22.HSVColor,
    constructors: {
      'fromAHSV': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'HSVColor');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'HSVColor');
        final hue = D4.getRequiredArg<double>(positional, 1, 'hue', 'HSVColor');
        final saturation = D4.getRequiredArg<double>(positional, 2, 'saturation', 'HSVColor');
        final value = D4.getRequiredArg<double>(positional, 3, 'value', 'HSVColor');
        return $flutter_22.HSVColor.fromAHSV(alpha, hue, saturation, value);
      },
      'fromColor': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HSVColor');
        final color = D4.getRequiredArg<Color>(positional, 0, 'color', 'HSVColor');
        return $flutter_22.HSVColor.fromColor(color);
      },
    },
    getters: {
      'alpha': (visitor, target) => D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor').alpha,
      'hue': (visitor, target) => D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor').hue,
      'saturation': (visitor, target) => D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor').saturation,
      'value': (visitor, target) => D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor').value,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor').hashCode,
    },
    methods: {
      'withAlpha': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withAlpha');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'withAlpha');
        return t.withAlpha(alpha);
      },
      'withHue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withHue');
        final hue = D4.getRequiredArg<double>(positional, 0, 'hue', 'withHue');
        return t.withHue(hue);
      },
      'withSaturation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withSaturation');
        final saturation = D4.getRequiredArg<double>(positional, 0, 'saturation', 'withSaturation');
        return t.withSaturation(saturation);
      },
      'withValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor');
        D4.requireMinArgs(positional, 1, 'withValue');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'withValue');
        return t.withValue(value);
      },
      'toColor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor');
        return t.toColor();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSVColor>(target, 'HSVColor');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_22.HSVColor?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_22.HSVColor?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_22.HSVColor.lerp(a, b, t_);
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
    nativeType: $flutter_22.HSLColor,
    name: 'HSLColor',
    isAssignable: (v) => v is $flutter_22.HSLColor,
    constructors: {
      'fromAHSL': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'HSLColor');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'HSLColor');
        final hue = D4.getRequiredArg<double>(positional, 1, 'hue', 'HSLColor');
        final saturation = D4.getRequiredArg<double>(positional, 2, 'saturation', 'HSLColor');
        final lightness = D4.getRequiredArg<double>(positional, 3, 'lightness', 'HSLColor');
        return $flutter_22.HSLColor.fromAHSL(alpha, hue, saturation, lightness);
      },
      'fromColor': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HSLColor');
        final color = D4.getRequiredArg<Color>(positional, 0, 'color', 'HSLColor');
        return $flutter_22.HSLColor.fromColor(color);
      },
    },
    getters: {
      'alpha': (visitor, target) => D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor').alpha,
      'hue': (visitor, target) => D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor').hue,
      'saturation': (visitor, target) => D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor').saturation,
      'lightness': (visitor, target) => D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor').lightness,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor').hashCode,
    },
    methods: {
      'withAlpha': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withAlpha');
        final alpha = D4.getRequiredArg<double>(positional, 0, 'alpha', 'withAlpha');
        return t.withAlpha(alpha);
      },
      'withHue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withHue');
        final hue = D4.getRequiredArg<double>(positional, 0, 'hue', 'withHue');
        return t.withHue(hue);
      },
      'withSaturation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withSaturation');
        final saturation = D4.getRequiredArg<double>(positional, 0, 'saturation', 'withSaturation');
        return t.withSaturation(saturation);
      },
      'withLightness': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor');
        D4.requireMinArgs(positional, 1, 'withLightness');
        final lightness = D4.getRequiredArg<double>(positional, 0, 'lightness', 'withLightness');
        return t.withLightness(lightness);
      },
      'toColor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor');
        return t.toColor();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.HSLColor>(target, 'HSLColor');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_22.HSLColor?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_22.HSLColor?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_22.HSLColor.lerp(a, b, t_);
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
    nativeType: $flutter_22.ColorSwatch,
    name: 'ColorSwatch',
    isAssignable: (v) => v is $flutter_22.ColorSwatch,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColorSwatch');
        final primary = D4.getRequiredArg<int>(positional, 0, 'primary', 'ColorSwatch');
        if (positional.length <= 1) {
          throw ArgumentError('ColorSwatch: Missing required argument "_swatch" at position 1');
        }
        final swatch = D4.coerceMap<dynamic, Color>(positional[1], '_swatch');
        return $flutter_22.ColorSwatch(primary, swatch);
      },
    },
    getters: {
      'keys': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').keys,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').hashCode,
      'a': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').a,
      'r': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').r,
      'g': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').g,
      'b': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').b,
      'colorSpace': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').colorSpace,
      'value': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').value,
      'alpha': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').alpha,
      'opacity': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').opacity,
      'red': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').red,
      'green': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').green,
      'blue': (visitor, target) => D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch').blue,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        return t.toString();
      },
      'toARGB32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        return t.toARGB32();
      },
      'withValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        final alpha = D4.getOptionalNamedArg<double?>(named, 'alpha');
        final red = D4.getOptionalNamedArg<double?>(named, 'red');
        final green = D4.getOptionalNamedArg<double?>(named, 'green');
        final blue = D4.getOptionalNamedArg<double?>(named, 'blue');
        final colorSpace = D4.getOptionalNamedArg<ColorSpace?>(named, 'colorSpace');
        return t.withValues(alpha: alpha, red: red, green: green, blue: blue, colorSpace: colorSpace);
      },
      'withAlpha': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withAlpha');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'withAlpha');
        return t.withAlpha(a);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'withRed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withRed');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'withRed');
        return t.withRed(r);
      },
      'withGreen': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withGreen');
        final g = D4.getRequiredArg<int>(positional, 0, 'g', 'withGreen');
        return t.withGreen(g);
      },
      'withBlue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        D4.requireMinArgs(positional, 1, 'withBlue');
        final b = D4.getRequiredArg<int>(positional, 0, 'b', 'withBlue');
        return t.withBlue(b);
      },
      'computeLuminance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        return t.computeLuminance();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorSwatch>(target, 'ColorSwatch');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_22.ColorSwatch<dynamic>?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_22.ColorSwatch<dynamic>?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_22.ColorSwatch.lerp(a, b, t_);
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
    nativeType: $flutter_22.ColorProperty,
    name: 'ColorProperty',
    isAssignable: (v) => v is $flutter_22.ColorProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColorProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ColorProperty');
        final value = D4.getRequiredArg<Color?>(positional, 1, 'value', 'ColorProperty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final style = D4.getNamedArgWithDefault<$flutter_5.DiagnosticsTreeStyle>(named, 'style', $flutter_5.DiagnosticsTreeStyle.singleLine);
        final level = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'level', $flutter_5.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_22.ColorProperty(name, value, showName: showName, style: style, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'ColorProperty');
          return $flutter_22.ColorProperty(name, value, showName: showName, style: style, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty').textTreeConfiguration,
    },
    methods: {
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_5.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_5.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_5.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.ColorProperty>(target, 'ColorProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// ContinuousRectangleBorder Bridge
// =============================================================================

BridgedClass _createContinuousRectangleBorderBridge() {
  return BridgedClass(
    nativeType: $flutter_23.ContinuousRectangleBorder,
    name: 'ContinuousRectangleBorder',
    isAssignable: (v) => v is $flutter_23.ContinuousRectangleBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final borderRadius = D4.getNamedArgWithDefault<$flutter_14.BorderRadiusGeometry>(named, 'borderRadius', $flutter_14.BorderRadius.zero);
        return $flutter_23.ContinuousRectangleBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.ContinuousRectangleBorder>(target, 'ContinuousRectangleBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ContinuousRectangleBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry borderRadius = BorderRadius.zero})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'ContinuousRectangleBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
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
    nativeType: $flutter_24.ImageSizeInfo,
    name: 'ImageSizeInfo',
    isAssignable: (v) => v is $flutter_24.ImageSizeInfo,
    constructors: {
      '': (visitor, positional, named) {
        final source = D4.getOptionalNamedArg<String?>(named, 'source');
        final displaySize = D4.getRequiredNamedArg<Size>(named, 'displaySize', 'ImageSizeInfo');
        final imageSize = D4.getRequiredNamedArg<Size>(named, 'imageSize', 'ImageSizeInfo');
        return $flutter_24.ImageSizeInfo(source: source, displaySize: displaySize, imageSize: imageSize);
      },
    },
    getters: {
      'source': (visitor, target) => D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo').source,
      'displaySize': (visitor, target) => D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo').displaySize,
      'imageSize': (visitor, target) => D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo').imageSize,
      'displaySizeInBytes': (visitor, target) => D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo').displaySizeInBytes,
      'decodedSizeInBytes': (visitor, target) => D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo').decodedSizeInBytes,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo').hashCode,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.ImageSizeInfo>(target, 'ImageSizeInfo');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_25.Decoration,
    name: 'Decoration',
    isAssignable: (v) => v is $flutter_25.Decoration,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration').isComplex,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        return t.debugAssertIsValid();
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(() { D4.callInterpreterCallback(visitor!, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.Decoration>(target, 'Decoration');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_25.Decoration.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'lerpFrom': 'Decoration? lerpFrom(Decoration? a, double t)',
      'lerpTo': 'Decoration? lerpTo(Decoration? b, double t)',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_25.BoxPainter,
    name: 'BoxPainter',
    isAssignable: (v) => v is $flutter_25.BoxPainter,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'onChanged': (visitor, target) => D4.validateTarget<$flutter_25.BoxPainter>(target, 'BoxPainter').onChanged,
    },
    methods: {
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.BoxPainter>(target, 'BoxPainter');
        D4.requireMinArgs(positional, 3, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final offset = D4.getRequiredArg<Offset>(positional, 1, 'offset', 'paint');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 2, 'configuration', 'paint');
        t.paint(canvas, offset, configuration);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.BoxPainter>(target, 'BoxPainter');
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
    nativeType: $flutter_26.DecorationImage,
    name: 'DecorationImage',
    isAssignable: (v) => v is $flutter_26.DecorationImage,
    constructors: {
      '': (visitor, positional, named) {
        final image = D4.getRequiredNamedArg<$flutter_34.ImageProvider<Object>>(named, 'image', 'DecorationImage');
        final onErrorRaw = named['onError'];
        final colorFilter = D4.getOptionalNamedArg<ColorFilter?>(named, 'colorFilter');
        final fit = D4.getOptionalNamedArg<$flutter_18.BoxFit?>(named, 'fit');
        final alignment = D4.getNamedArgWithDefault<$flutter_10.AlignmentGeometry>(named, 'alignment', $flutter_10.Alignment.center);
        final centerSlice = D4.getOptionalNamedArg<Rect?>(named, 'centerSlice');
        final repeat = D4.getNamedArgWithDefault<$flutter_26.ImageRepeat>(named, 'repeat', $flutter_26.ImageRepeat.noRepeat);
        final matchTextDirection = D4.getNamedArgWithDefault<bool>(named, 'matchTextDirection', false);
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final opacity = D4.getNamedArgWithDefault<double>(named, 'opacity', 1.0);
        final filterQuality = D4.getNamedArgWithDefault<FilterQuality>(named, 'filterQuality', $dart_ui.FilterQuality.medium);
        final invertColors = D4.getNamedArgWithDefault<bool>(named, 'invertColors', false);
        final isAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'isAntiAlias', false);
        return $flutter_26.DecorationImage(image: image, onError: onErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0, p1]); }, colorFilter: colorFilter, fit: fit, alignment: alignment, centerSlice: centerSlice, repeat: repeat, matchTextDirection: matchTextDirection, scale: scale, opacity: opacity, filterQuality: filterQuality, invertColors: invertColors, isAntiAlias: isAntiAlias);
      },
    },
    getters: {
      'image': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').image,
      'onError': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').onError,
      'colorFilter': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').colorFilter,
      'fit': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').fit,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').alignment,
      'centerSlice': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').centerSlice,
      'repeat': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').repeat,
      'matchTextDirection': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').matchTextDirection,
      'scale': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').scale,
      'opacity': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').opacity,
      'filterQuality': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').filterQuality,
      'invertColors': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').invertColors,
      'isAntiAlias': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').isAntiAlias,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage').hashCode,
    },
    methods: {
      'createPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage');
        D4.requireMinArgs(positional, 1, 'createPainter');
        if (positional.isEmpty) {
          throw ArgumentError('createPainter: Missing required argument "onChanged" at position 0');
        }
        final onChangedRaw = positional[0];
        return t.createPainter(() { D4.callInterpreterCallback(visitor!, onChangedRaw, []); });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.DecorationImage>(target, 'DecorationImage');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_26.DecorationImage?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_26.DecorationImage?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_26.DecorationImage.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const DecorationImage({required ImageProvider<Object> image, ImageErrorListener? onError, ColorFilter? colorFilter, BoxFit? fit, AlignmentGeometry alignment = Alignment.center, Rect? centerSlice, ImageRepeat repeat = ImageRepeat.noRepeat, bool matchTextDirection = false, double scale = 1.0, double opacity = 1.0, FilterQuality filterQuality = FilterQuality.medium, bool invertColors = false, bool isAntiAlias = false})',
    },
    methodSignatures: {
      'createPainter': 'DecorationImagePainter createPainter(VoidCallback onChanged)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'image': 'ImageProvider<Object> get image',
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
    nativeType: $flutter_26.DecorationImagePainter,
    name: 'DecorationImagePainter',
    isAssignable: (v) => v is $flutter_26.DecorationImagePainter,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.DecorationImagePainter>(target, 'DecorationImagePainter');
        D4.requireMinArgs(positional, 4, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final clipPath = D4.getRequiredArg<Path?>(positional, 2, 'clipPath', 'paint');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 3, 'configuration', 'paint');
        final blend = D4.getNamedArgWithDefault<double>(named, 'blend', 1.0);
        final blendMode = D4.getNamedArgWithDefault<BlendMode>(named, 'blendMode', $dart_ui.BlendMode.srcOver);
        t.paint(canvas, rect, clipPath, configuration, blend: blend, blendMode: blendMode);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.DecorationImagePainter>(target, 'DecorationImagePainter');
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
    nativeType: $flutter_27.EdgeInsetsGeometry,
    name: 'EdgeInsetsGeometry',
    isAssignable: (v) => v is $flutter_27.EdgeInsetsGeometry,
    isAbstract: true,
    constructors: {
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EdgeInsetsGeometry');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'EdgeInsetsGeometry');
        return $flutter_27.EdgeInsetsGeometry.all(value);
      },
      'only': (visitor, positional, named) {
        if (!named.containsKey('left') && !named.containsKey('right') && !named.containsKey('top') && !named.containsKey('bottom')) {
          return $flutter_27.EdgeInsetsGeometry.only();
        }
        if (named.containsKey('left') && !named.containsKey('right') && !named.containsKey('top') && !named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left);
        }
        if (!named.containsKey('left') && named.containsKey('right') && !named.containsKey('top') && !named.containsKey('bottom')) {
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(right: right);
        }
        if (named.containsKey('left') && named.containsKey('right') && !named.containsKey('top') && !named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left, right: right);
        }
        if (!named.containsKey('left') && !named.containsKey('right') && named.containsKey('top') && !named.containsKey('bottom')) {
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(top: top);
        }
        if (named.containsKey('left') && !named.containsKey('right') && named.containsKey('top') && !named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left, top: top);
        }
        if (!named.containsKey('left') && named.containsKey('right') && named.containsKey('top') && !named.containsKey('bottom')) {
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(right: right, top: top);
        }
        if (named.containsKey('left') && named.containsKey('right') && named.containsKey('top') && !named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left, right: right, top: top);
        }
        if (!named.containsKey('left') && !named.containsKey('right') && !named.containsKey('top') && named.containsKey('bottom')) {
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(bottom: bottom);
        }
        if (named.containsKey('left') && !named.containsKey('right') && !named.containsKey('top') && named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left, bottom: bottom);
        }
        if (!named.containsKey('left') && named.containsKey('right') && !named.containsKey('top') && named.containsKey('bottom')) {
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(right: right, bottom: bottom);
        }
        if (named.containsKey('left') && named.containsKey('right') && !named.containsKey('top') && named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left, right: right, bottom: bottom);
        }
        if (!named.containsKey('left') && !named.containsKey('right') && named.containsKey('top') && named.containsKey('bottom')) {
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(top: top, bottom: bottom);
        }
        if (named.containsKey('left') && !named.containsKey('right') && named.containsKey('top') && named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left, top: top, bottom: bottom);
        }
        if (!named.containsKey('left') && named.containsKey('right') && named.containsKey('top') && named.containsKey('bottom')) {
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(right: right, top: top, bottom: bottom);
        }
        if (named.containsKey('left') && named.containsKey('right') && named.containsKey('top') && named.containsKey('bottom')) {
          final left = D4.getRequiredNamedArg<double>(named, 'left', 'EdgeInsetsGeometry');
          final right = D4.getRequiredNamedArg<double>(named, 'right', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.only(left: left, right: right, top: top, bottom: bottom);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'directional': (visitor, positional, named) {
        if (!named.containsKey('start') && !named.containsKey('end') && !named.containsKey('top') && !named.containsKey('bottom')) {
          return $flutter_27.EdgeInsetsGeometry.directional();
        }
        if (named.containsKey('start') && !named.containsKey('end') && !named.containsKey('top') && !named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start);
        }
        if (!named.containsKey('start') && named.containsKey('end') && !named.containsKey('top') && !named.containsKey('bottom')) {
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(end: end);
        }
        if (named.containsKey('start') && named.containsKey('end') && !named.containsKey('top') && !named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start, end: end);
        }
        if (!named.containsKey('start') && !named.containsKey('end') && named.containsKey('top') && !named.containsKey('bottom')) {
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(top: top);
        }
        if (named.containsKey('start') && !named.containsKey('end') && named.containsKey('top') && !named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start, top: top);
        }
        if (!named.containsKey('start') && named.containsKey('end') && named.containsKey('top') && !named.containsKey('bottom')) {
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(end: end, top: top);
        }
        if (named.containsKey('start') && named.containsKey('end') && named.containsKey('top') && !named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start, end: end, top: top);
        }
        if (!named.containsKey('start') && !named.containsKey('end') && !named.containsKey('top') && named.containsKey('bottom')) {
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(bottom: bottom);
        }
        if (named.containsKey('start') && !named.containsKey('end') && !named.containsKey('top') && named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start, bottom: bottom);
        }
        if (!named.containsKey('start') && named.containsKey('end') && !named.containsKey('top') && named.containsKey('bottom')) {
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(end: end, bottom: bottom);
        }
        if (named.containsKey('start') && named.containsKey('end') && !named.containsKey('top') && named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start, end: end, bottom: bottom);
        }
        if (!named.containsKey('start') && !named.containsKey('end') && named.containsKey('top') && named.containsKey('bottom')) {
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(top: top, bottom: bottom);
        }
        if (named.containsKey('start') && !named.containsKey('end') && named.containsKey('top') && named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start, top: top, bottom: bottom);
        }
        if (!named.containsKey('start') && named.containsKey('end') && named.containsKey('top') && named.containsKey('bottom')) {
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(end: end, top: top, bottom: bottom);
        }
        if (named.containsKey('start') && named.containsKey('end') && named.containsKey('top') && named.containsKey('bottom')) {
          final start = D4.getRequiredNamedArg<double>(named, 'start', 'EdgeInsetsGeometry');
          final end = D4.getRequiredNamedArg<double>(named, 'end', 'EdgeInsetsGeometry');
          final top = D4.getRequiredNamedArg<double>(named, 'top', 'EdgeInsetsGeometry');
          final bottom = D4.getRequiredNamedArg<double>(named, 'bottom', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.directional(start: start, end: end, top: top, bottom: bottom);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'symmetric': (visitor, positional, named) {
        if (!named.containsKey('vertical') && !named.containsKey('horizontal')) {
          return $flutter_27.EdgeInsetsGeometry.symmetric();
        }
        if (named.containsKey('vertical') && !named.containsKey('horizontal')) {
          final vertical = D4.getRequiredNamedArg<double>(named, 'vertical', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.symmetric(vertical: vertical);
        }
        if (!named.containsKey('vertical') && named.containsKey('horizontal')) {
          final horizontal = D4.getRequiredNamedArg<double>(named, 'horizontal', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.symmetric(horizontal: horizontal);
        }
        if (named.containsKey('vertical') && named.containsKey('horizontal')) {
          final vertical = D4.getRequiredNamedArg<double>(named, 'vertical', 'EdgeInsetsGeometry');
          final horizontal = D4.getRequiredNamedArg<double>(named, 'horizontal', 'EdgeInsetsGeometry');
          return $flutter_27.EdgeInsetsGeometry.symmetric(vertical: vertical, horizontal: horizontal);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'fromLTRB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsetsGeometry');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'EdgeInsetsGeometry');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsetsGeometry');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'EdgeInsetsGeometry');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsetsGeometry');
        return $flutter_27.EdgeInsetsGeometry.fromLTRB(left, top, right, bottom);
      },
      'fromViewPadding': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EdgeInsetsGeometry');
        final padding = D4.getRequiredArg<ViewPadding>(positional, 0, 'padding', 'EdgeInsetsGeometry');
        final devicePixelRatio = D4.getRequiredArg<double>(positional, 1, 'devicePixelRatio', 'EdgeInsetsGeometry');
        return $flutter_27.EdgeInsetsGeometry.fromViewPadding(padding, devicePixelRatio);
      },
      'fromSTEB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsetsGeometry');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'EdgeInsetsGeometry');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsetsGeometry');
        final end = D4.getRequiredArg<double>(positional, 2, 'end', 'EdgeInsetsGeometry');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsetsGeometry');
        return $flutter_27.EdgeInsetsGeometry.fromSTEB(start, top, end, bottom);
      },
    },
    getters: {
      'isNonNegative': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').isNonNegative,
      'horizontal': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').horizontal,
      'vertical': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').vertical,
      'collapsedSize': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').collapsedSize,
      'flipped': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').flipped,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry').hashCode,
    },
    methods: {
      'along': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'along');
        final axis = D4.getRequiredArg<$flutter_11.Axis>(positional, 0, 'axis', 'along');
        return t.along(axis);
      },
      'inflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'inflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inflateSize');
        return t.inflateSize(size);
      },
      'deflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'deflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'deflateSize');
        return t.deflateSize(size);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 1, 'max', 'clamp');
        return t.clamp(min, max);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        return -t;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsGeometry>(target, 'EdgeInsetsGeometry');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_27.EdgeInsetsGeometry.zero,
      'infinity': (visitor) => $flutter_27.EdgeInsetsGeometry.infinity,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_27.EdgeInsetsGeometry.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'all': 'const factory EdgeInsetsGeometry.all(double value)',
      'only': 'const factory EdgeInsetsGeometry.only({double left, double right, double top, double bottom})',
      'directional': 'const factory EdgeInsetsGeometry.directional({double start, double end, double top, double bottom})',
      'symmetric': 'const factory EdgeInsetsGeometry.symmetric({double vertical, double horizontal})',
      'fromLTRB': 'const factory EdgeInsetsGeometry.fromLTRB(double left, double top, double right, double bottom)',
      'fromViewPadding': 'factory EdgeInsetsGeometry.fromViewPadding(ViewPadding padding, double devicePixelRatio)',
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
    nativeType: $flutter_27.EdgeInsets,
    name: 'EdgeInsets',
    isAssignable: (v) => v is $flutter_27.EdgeInsets,
    constructors: {
      'fromLTRB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsets');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'EdgeInsets');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsets');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'EdgeInsets');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsets');
        return $flutter_27.EdgeInsets.fromLTRB(left, top, right, bottom);
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EdgeInsets');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'EdgeInsets');
        return $flutter_27.EdgeInsets.all(value);
      },
      'only': (visitor, positional, named) {
        final left = D4.getNamedArgWithDefault<double>(named, 'left', 0.0);
        final top = D4.getNamedArgWithDefault<double>(named, 'top', 0.0);
        final right = D4.getNamedArgWithDefault<double>(named, 'right', 0.0);
        final bottom = D4.getNamedArgWithDefault<double>(named, 'bottom', 0.0);
        return $flutter_27.EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
      },
      'symmetric': (visitor, positional, named) {
        final vertical = D4.getNamedArgWithDefault<double>(named, 'vertical', 0.0);
        final horizontal = D4.getNamedArgWithDefault<double>(named, 'horizontal', 0.0);
        return $flutter_27.EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
      },
      'fromViewPadding': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EdgeInsets');
        final padding = D4.getRequiredArg<ViewPadding>(positional, 0, 'padding', 'EdgeInsets');
        final devicePixelRatio = D4.getRequiredArg<double>(positional, 1, 'devicePixelRatio', 'EdgeInsets');
        return $flutter_27.EdgeInsets.fromViewPadding(padding, devicePixelRatio);
      },
      'fromWindowPadding': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'EdgeInsets');
        final padding = D4.getRequiredArg<ViewPadding>(positional, 0, 'padding', 'EdgeInsets');
        final devicePixelRatio = D4.getRequiredArg<double>(positional, 1, 'devicePixelRatio', 'EdgeInsets');
        return $flutter_27.EdgeInsets.fromWindowPadding(padding, devicePixelRatio);
      },
    },
    getters: {
      'isNonNegative': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').isNonNegative,
      'horizontal': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').horizontal,
      'vertical': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').vertical,
      'collapsedSize': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').collapsedSize,
      'flipped': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').flipped,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').hashCode,
      'left': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').left,
      'top': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').top,
      'right': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').right,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').bottom,
      'topLeft': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').topLeft,
      'topRight': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').topRight,
      'bottomLeft': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').bottomLeft,
      'bottomRight': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets').bottomRight,
    },
    methods: {
      'along': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'along');
        final axis = D4.getRequiredArg<$flutter_11.Axis>(positional, 0, 'axis', 'along');
        return t.along(axis);
      },
      'inflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'inflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inflateSize');
        return t.inflateSize(size);
      },
      'deflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'deflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'deflateSize');
        return t.deflateSize(size);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 1, 'max', 'clamp');
        return t.clamp(min, max);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        return t.toString();
      },
      'inflateRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'inflateRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'inflateRect');
        return t.inflateRect(rect);
      },
      'deflateRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'deflateRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'deflateRect');
        return t.deflateRect(rect);
      },
      'inflateRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'inflateRRect');
        final rect = D4.getRequiredArg<RRect>(positional, 0, 'rect', 'inflateRRect');
        return t.inflateRRect(rect);
      },
      'deflateRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        D4.requireMinArgs(positional, 1, 'deflateRRect');
        final rect = D4.getRequiredArg<RRect>(positional, 0, 'rect', 'deflateRRect');
        return t.deflateRRect(rect);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        final left = D4.getOptionalNamedArg<double?>(named, 'left');
        final top = D4.getOptionalNamedArg<double?>(named, 'top');
        final right = D4.getOptionalNamedArg<double?>(named, 'right');
        final bottom = D4.getOptionalNamedArg<double?>(named, 'bottom');
        return t.copyWith(left: left, top: top, right: right, bottom: bottom);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_27.EdgeInsets>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsets>(target, 'EdgeInsets');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsets>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_27.EdgeInsets.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_27.EdgeInsets?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_27.EdgeInsets?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_27.EdgeInsets.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromLTRB': 'const EdgeInsets.fromLTRB(double left, double top, double right, double bottom)',
      'all': 'const EdgeInsets.all(double value)',
      'only': 'const EdgeInsets.only({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0})',
      'symmetric': 'const EdgeInsets.symmetric({double vertical = 0.0, double horizontal = 0.0})',
      'fromViewPadding': 'EdgeInsets.fromViewPadding(ViewPadding padding, double devicePixelRatio)',
      'fromWindowPadding': 'factory EdgeInsets.fromWindowPadding(ViewPadding padding, double devicePixelRatio)',
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
    nativeType: $flutter_27.EdgeInsetsDirectional,
    name: 'EdgeInsetsDirectional',
    isAssignable: (v) => v is $flutter_27.EdgeInsetsDirectional,
    constructors: {
      'fromSTEB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'EdgeInsetsDirectional');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'EdgeInsetsDirectional');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'EdgeInsetsDirectional');
        final end = D4.getRequiredArg<double>(positional, 2, 'end', 'EdgeInsetsDirectional');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'EdgeInsetsDirectional');
        return $flutter_27.EdgeInsetsDirectional.fromSTEB(start, top, end, bottom);
      },
      'only': (visitor, positional, named) {
        final start = D4.getNamedArgWithDefault<double>(named, 'start', 0.0);
        final top = D4.getNamedArgWithDefault<double>(named, 'top', 0.0);
        final end = D4.getNamedArgWithDefault<double>(named, 'end', 0.0);
        final bottom = D4.getNamedArgWithDefault<double>(named, 'bottom', 0.0);
        return $flutter_27.EdgeInsetsDirectional.only(start: start, top: top, end: end, bottom: bottom);
      },
      'symmetric': (visitor, positional, named) {
        final horizontal = D4.getNamedArgWithDefault<double>(named, 'horizontal', 0.0);
        final vertical = D4.getNamedArgWithDefault<double>(named, 'vertical', 0.0);
        return $flutter_27.EdgeInsetsDirectional.symmetric(horizontal: horizontal, vertical: vertical);
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EdgeInsetsDirectional');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'EdgeInsetsDirectional');
        return $flutter_27.EdgeInsetsDirectional.all(value);
      },
    },
    getters: {
      'isNonNegative': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').isNonNegative,
      'horizontal': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').horizontal,
      'vertical': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').vertical,
      'collapsedSize': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').collapsedSize,
      'flipped': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').flipped,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').start,
      'top': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').top,
      'end': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').end,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional').bottom,
    },
    methods: {
      'along': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'along');
        final axis = D4.getRequiredArg<$flutter_11.Axis>(positional, 0, 'axis', 'along');
        return t.along(axis);
      },
      'inflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'inflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inflateSize');
        return t.inflateSize(size);
      },
      'deflateSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'deflateSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'deflateSize');
        return t.deflateSize(size);
      },
      'subtract': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'subtract');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'other', 'subtract');
        return t.subtract(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 2, 'clamp');
        final min = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 0, 'min', 'clamp');
        final max = D4.getRequiredArg<$flutter_27.EdgeInsetsGeometry>(positional, 1, 'max', 'clamp');
        return t.clamp(min, max);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final start = D4.getOptionalNamedArg<double?>(named, 'start');
        final top = D4.getOptionalNamedArg<double?>(named, 'top');
        final end = D4.getOptionalNamedArg<double?>(named, 'end');
        final bottom = D4.getOptionalNamedArg<double?>(named, 'bottom');
        return t.copyWith(start: start, top: top, end: end, bottom: bottom);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_27.EdgeInsetsDirectional>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.EdgeInsetsDirectional>(target, 'EdgeInsetsDirectional');
        final other = D4.getRequiredArg<$flutter_27.EdgeInsetsDirectional>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_27.EdgeInsetsDirectional.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_27.EdgeInsetsDirectional?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_27.EdgeInsetsDirectional?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_27.EdgeInsetsDirectional.lerp(a, b, t_);
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
    nativeType: $flutter_28.FlutterLogoDecoration,
    name: 'FlutterLogoDecoration',
    isAssignable: (v) => v is $flutter_28.FlutterLogoDecoration,
    constructors: {
      '': (visitor, positional, named) {
        final textColor = D4.getNamedArgWithDefault<Color>(named, 'textColor', const $dart_ui.Color(0xFF757575));
        final style = D4.getNamedArgWithDefault<$flutter_28.FlutterLogoStyle>(named, 'style', $flutter_28.FlutterLogoStyle.markOnly);
        final margin = D4.getNamedArgWithDefault<$flutter_27.EdgeInsets>(named, 'margin', $flutter_27.EdgeInsets.zero);
        return $flutter_28.FlutterLogoDecoration(textColor: textColor, style: style, margin: margin);
      },
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').isComplex,
      'textColor': (visitor, target) => D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').textColor,
      'style': (visitor, target) => D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').style,
      'margin': (visitor, target) => D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').margin,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        return t.debugAssertIsValid();
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(onChangedRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.FlutterLogoDecoration>(target, 'FlutterLogoDecoration');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_28.FlutterLogoDecoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_28.FlutterLogoDecoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_28.FlutterLogoDecoration.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const FlutterLogoDecoration({Color textColor = const Color(0xFF757575), FlutterLogoStyle style = FlutterLogoStyle.markOnly, EdgeInsets margin = EdgeInsets.zero})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'lerpFrom': 'FlutterLogoDecoration? lerpFrom(Decoration? a, double t)',
      'lerpTo': 'FlutterLogoDecoration? lerpTo(Decoration? b, double t)',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback? onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_29.FractionalOffset,
    name: 'FractionalOffset',
    isAssignable: (v) => v is $flutter_29.FractionalOffset,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FractionalOffset');
        final dx = D4.getRequiredArg<double>(positional, 0, 'dx', 'FractionalOffset');
        final dy = D4.getRequiredArg<double>(positional, 1, 'dy', 'FractionalOffset');
        return $flutter_29.FractionalOffset(dx, dy);
      },
      'fromOffsetAndSize': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FractionalOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'FractionalOffset');
        final size = D4.getRequiredArg<Size>(positional, 1, 'size', 'FractionalOffset');
        return $flutter_29.FractionalOffset.fromOffsetAndSize(offset, size);
      },
      'fromOffsetAndRect': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FractionalOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'FractionalOffset');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'FractionalOffset');
        return $flutter_29.FractionalOffset.fromOffsetAndRect(offset, rect);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset').hashCode,
      'x': (visitor, target) => D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset').y,
      'dx': (visitor, target) => D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset').dx,
      'dy': (visitor, target) => D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset').dy,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_10.AlignmentGeometry>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'resolve');
        final direction = D4.getRequiredArg<TextDirection?>(positional, 0, 'direction', 'resolve');
        return t.resolve(direction);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        return t.toString();
      },
      'alongOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'alongOffset');
        final other = D4.getRequiredArg<Offset>(positional, 0, 'other', 'alongOffset');
        return t.alongOffset(other);
      },
      'alongSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'alongSize');
        final other = D4.getRequiredArg<Size>(positional, 0, 'other', 'alongSize');
        return t.alongSize(other);
      },
      'withinRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 1, 'withinRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'withinRect');
        return t.withinRect(rect);
      },
      'inscribe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        D4.requireMinArgs(positional, 2, 'inscribe');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'inscribe');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'inscribe');
        return t.inscribe(size, rect);
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_10.Alignment>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.FractionalOffset>(target, 'FractionalOffset');
        final other = D4.getRequiredArg<$flutter_10.Alignment>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: {
      'topLeft': (visitor) => $flutter_29.FractionalOffset.topLeft,
      'topCenter': (visitor) => $flutter_29.FractionalOffset.topCenter,
      'topRight': (visitor) => $flutter_29.FractionalOffset.topRight,
      'centerLeft': (visitor) => $flutter_29.FractionalOffset.centerLeft,
      'center': (visitor) => $flutter_29.FractionalOffset.center,
      'centerRight': (visitor) => $flutter_29.FractionalOffset.centerRight,
      'bottomLeft': (visitor) => $flutter_29.FractionalOffset.bottomLeft,
      'bottomCenter': (visitor) => $flutter_29.FractionalOffset.bottomCenter,
      'bottomRight': (visitor) => $flutter_29.FractionalOffset.bottomRight,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_29.FractionalOffset?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_29.FractionalOffset?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_29.FractionalOffset.lerp(a, b, t_);
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
    nativeType: $flutter_31.GradientTransform,
    name: 'GradientTransform',
    isAssignable: (v) => v is $flutter_31.GradientTransform,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.GradientTransform>(target, 'GradientTransform');
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
    nativeType: $flutter_31.GradientRotation,
    name: 'GradientRotation',
    isAssignable: (v) => v is $flutter_31.GradientRotation,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'GradientRotation');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'GradientRotation');
        return $flutter_31.GradientRotation(radians);
      },
    },
    getters: {
      'radians': (visitor, target) => D4.validateTarget<$flutter_31.GradientRotation>(target, 'GradientRotation').radians,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_31.GradientRotation>(target, 'GradientRotation').hashCode,
    },
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.GradientRotation>(target, 'GradientRotation');
        D4.requireMinArgs(positional, 1, 'transform');
        final bounds = D4.getRequiredArg<Rect>(positional, 0, 'bounds', 'transform');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.transform(bounds, textDirection: textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.GradientRotation>(target, 'GradientRotation');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.GradientRotation>(target, 'GradientRotation');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_31.Gradient,
    name: 'Gradient',
    isAssignable: (v) => v is $flutter_31.Gradient,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient').transform,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Gradient>(target, 'Gradient');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_31.Gradient.lerp(a, b, t_);
      },
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'Gradient scale(double factor)',
      'withOpacity': 'Gradient withOpacity(double opacity)',
      'lerpFrom': 'Gradient? lerpFrom(Gradient? a, double t)',
      'lerpTo': 'Gradient? lerpTo(Gradient? b, double t)',
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
    nativeType: $flutter_31.LinearGradient,
    name: 'LinearGradient',
    isAssignable: (v) => v is $flutter_31.LinearGradient,
    constructors: {
      '': (visitor, positional, named) {
        final begin = D4.getNamedArgWithDefault<$flutter_10.AlignmentGeometry>(named, 'begin', $flutter_10.Alignment.centerLeft);
        final end = D4.getNamedArgWithDefault<$flutter_10.AlignmentGeometry>(named, 'end', $flutter_10.Alignment.centerRight);
        if (!named.containsKey('colors') || named['colors'] == null) {
          throw ArgumentError('LinearGradient: Missing required named argument "colors"');
        }
        final colors = D4.coerceList<Color>(named['colors'], 'colors');
        final stops = D4.coerceListOrNull<double>(named['stops'], 'stops');
        final tileMode = D4.getNamedArgWithDefault<TileMode>(named, 'tileMode', $dart_ui.TileMode.clamp);
        final transform = D4.getOptionalNamedArg<$flutter_31.GradientTransform?>(named, 'transform');
        return $flutter_31.LinearGradient(begin: begin, end: end, colors: colors, stops: stops, tileMode: tileMode, transform: transform);
      },
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient').transform,
      'begin': (visitor, target) => D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient').begin,
      'end': (visitor, target) => D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient').end,
      'tileMode': (visitor, target) => D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient').tileMode,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient').hashCode,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.LinearGradient>(target, 'LinearGradient');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_31.LinearGradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_31.LinearGradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_31.LinearGradient.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const LinearGradient({AlignmentGeometry begin = Alignment.centerLeft, AlignmentGeometry end = Alignment.centerRight, required List<Color> colors, List<double>? stops, TileMode tileMode = TileMode.clamp, GradientTransform? transform})',
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'LinearGradient scale(double factor)',
      'withOpacity': 'LinearGradient withOpacity(double opacity)',
      'lerpFrom': 'Gradient? lerpFrom(Gradient? a, double t)',
      'lerpTo': 'Gradient? lerpTo(Gradient? b, double t)',
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
    nativeType: $flutter_31.RadialGradient,
    name: 'RadialGradient',
    isAssignable: (v) => v is $flutter_31.RadialGradient,
    constructors: {
      '': (visitor, positional, named) {
        final center = D4.getNamedArgWithDefault<$flutter_10.AlignmentGeometry>(named, 'center', $flutter_10.Alignment.center);
        final radius = D4.getNamedArgWithDefault<double>(named, 'radius', 0.5);
        if (!named.containsKey('colors') || named['colors'] == null) {
          throw ArgumentError('RadialGradient: Missing required named argument "colors"');
        }
        final colors = D4.coerceList<Color>(named['colors'], 'colors');
        final stops = D4.coerceListOrNull<double>(named['stops'], 'stops');
        final tileMode = D4.getNamedArgWithDefault<TileMode>(named, 'tileMode', $dart_ui.TileMode.clamp);
        final focal = D4.getOptionalNamedArg<$flutter_10.AlignmentGeometry?>(named, 'focal');
        final focalRadius = D4.getNamedArgWithDefault<double>(named, 'focalRadius', 0.0);
        final transform = D4.getOptionalNamedArg<$flutter_31.GradientTransform?>(named, 'transform');
        return $flutter_31.RadialGradient(center: center, radius: radius, colors: colors, stops: stops, tileMode: tileMode, focal: focal, focalRadius: focalRadius, transform: transform);
      },
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').transform,
      'center': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').center,
      'radius': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').radius,
      'tileMode': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').tileMode,
      'focal': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').focal,
      'focalRadius': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').focalRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient').hashCode,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.RadialGradient>(target, 'RadialGradient');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_31.RadialGradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_31.RadialGradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_31.RadialGradient.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const RadialGradient({AlignmentGeometry center = Alignment.center, double radius = 0.5, required List<Color> colors, List<double>? stops, TileMode tileMode = TileMode.clamp, AlignmentGeometry? focal, double focalRadius = 0.0, GradientTransform? transform})',
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'RadialGradient scale(double factor)',
      'withOpacity': 'RadialGradient withOpacity(double opacity)',
      'lerpFrom': 'Gradient? lerpFrom(Gradient? a, double t)',
      'lerpTo': 'Gradient? lerpTo(Gradient? b, double t)',
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
    nativeType: $flutter_31.SweepGradient,
    name: 'SweepGradient',
    isAssignable: (v) => v is $flutter_31.SweepGradient,
    constructors: {
      '': (visitor, positional, named) {
        final center = D4.getNamedArgWithDefault<$flutter_10.AlignmentGeometry>(named, 'center', $flutter_10.Alignment.center);
        final startAngle = D4.getNamedArgWithDefault<double>(named, 'startAngle', 0.0);
        if (!named.containsKey('colors') || named['colors'] == null) {
          throw ArgumentError('SweepGradient: Missing required named argument "colors"');
        }
        final colors = D4.coerceList<Color>(named['colors'], 'colors');
        final stops = D4.coerceListOrNull<double>(named['stops'], 'stops');
        final tileMode = D4.getNamedArgWithDefault<TileMode>(named, 'tileMode', $dart_ui.TileMode.clamp);
        final transform = D4.getOptionalNamedArg<$flutter_31.GradientTransform?>(named, 'transform');
        if (!named.containsKey('endAngle')) {
          return $flutter_31.SweepGradient(center: center, startAngle: startAngle, colors: colors, stops: stops, tileMode: tileMode, transform: transform);
        }
        if (named.containsKey('endAngle')) {
          final endAngle = D4.getRequiredNamedArg<double>(named, 'endAngle', 'SweepGradient');
          return $flutter_31.SweepGradient(center: center, startAngle: startAngle, colors: colors, stops: stops, tileMode: tileMode, transform: transform, endAngle: endAngle);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'colors': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').colors,
      'stops': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').stops,
      'transform': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').transform,
      'center': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').center,
      'startAngle': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').startAngle,
      'endAngle': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').endAngle,
      'tileMode': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').tileMode,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient').hashCode,
    },
    methods: {
      'createShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 1, 'createShader');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'createShader');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.createShader(rect, textDirection: textDirection);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_31.Gradient?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SweepGradient>(target, 'SweepGradient');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_31.SweepGradient?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_31.SweepGradient?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_31.SweepGradient.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const SweepGradient({AlignmentGeometry center = Alignment.center, double startAngle = 0.0, double endAngle = math.pi * 2, required List<Color> colors, List<double>? stops, TileMode tileMode = TileMode.clamp, GradientTransform? transform})',
    },
    methodSignatures: {
      'createShader': 'Shader createShader(Rect rect, {TextDirection? textDirection})',
      'scale': 'SweepGradient scale(double factor)',
      'withOpacity': 'SweepGradient withOpacity(double opacity)',
      'lerpFrom': 'Gradient? lerpFrom(Gradient? a, double t)',
      'lerpTo': 'Gradient? lerpTo(Gradient? b, double t)',
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
    nativeType: $flutter_32.ImageCache,
    name: 'ImageCache',
    isAssignable: (v) => v is $flutter_32.ImageCache,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_32.ImageCache();
      },
    },
    getters: {
      'maximumSize': (visitor, target) => D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').maximumSize,
      'currentSize': (visitor, target) => D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').currentSize,
      'maximumSizeBytes': (visitor, target) => D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').maximumSizeBytes,
      'currentSizeBytes': (visitor, target) => D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').currentSizeBytes,
      'liveImageCount': (visitor, target) => D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').liveImageCount,
      'pendingImageCount': (visitor, target) => D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').pendingImageCount,
    },
    setters: {
      'maximumSize': (visitor, target, value) => 
        D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').maximumSize = D4.extractBridgedArg<int>(value, 'maximumSize'),
      'maximumSizeBytes': (visitor, target, value) => 
        D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache').maximumSizeBytes = D4.extractBridgedArg<int>(value, 'maximumSizeBytes'),
    },
    methods: {
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache');
        t.clear();
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'evict');
        final includeLive = D4.getNamedArgWithDefault<bool>(named, 'includeLive', true);
        return t.evict(key, includeLive: includeLive);
      },
      'putIfAbsent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 2, 'putIfAbsent');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'putIfAbsent');
        if (positional.length <= 1) {
          throw ArgumentError('putIfAbsent: Missing required argument "loader" at position 1');
        }
        final loaderRaw = positional[1];
        final onErrorRaw = named['onError'];
        return t.putIfAbsent(key, (() { return D4.extractBridgedArg<$flutter_36.ImageStreamCompleter>(D4.callInterpreterCallback(visitor!, loaderRaw, []), 'callback', visitor) as $flutter_36.ImageStreamCompleter; }) as $flutter_36.ImageStreamCompleter Function(), onError: onErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0, p1]); });
      },
      'statusForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 1, 'statusForKey');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'statusForKey');
        return t.statusForKey(key);
      },
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'clearLiveImages': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCache>(target, 'ImageCache');
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
    nativeType: $flutter_32.ImageCacheStatus,
    name: 'ImageCacheStatus',
    isAssignable: (v) => v is $flutter_32.ImageCacheStatus,
    constructors: {
    },
    getters: {
      'pending': (visitor, target) => D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus').pending,
      'keepAlive': (visitor, target) => D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus').keepAlive,
      'live': (visitor, target) => D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus').live,
      'tracked': (visitor, target) => D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus').tracked,
      'untracked': (visitor, target) => D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus').untracked,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.ImageCacheStatus>(target, 'ImageCacheStatus');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_34.ImageConfiguration,
    name: 'ImageConfiguration',
    isAssignable: (v) => v is $flutter_34.ImageConfiguration,
    constructors: {
      '': (visitor, positional, named) {
        final bundle = D4.getOptionalNamedArg<$flutter_56.AssetBundle?>(named, 'bundle');
        final devicePixelRatio = D4.getOptionalNamedArg<double?>(named, 'devicePixelRatio');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final platform = D4.getOptionalNamedArg<$flutter_6.TargetPlatform?>(named, 'platform');
        return $flutter_34.ImageConfiguration(bundle: bundle, devicePixelRatio: devicePixelRatio, locale: locale, textDirection: textDirection, size: size, platform: platform);
      },
    },
    getters: {
      'bundle': (visitor, target) => D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration').bundle,
      'devicePixelRatio': (visitor, target) => D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration').devicePixelRatio,
      'locale': (visitor, target) => D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration').locale,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration').textDirection,
      'size': (visitor, target) => D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration').size,
      'platform': (visitor, target) => D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration').platform,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration');
        final bundle = D4.getOptionalNamedArg<$flutter_56.AssetBundle?>(named, 'bundle');
        final devicePixelRatio = D4.getOptionalNamedArg<double?>(named, 'devicePixelRatio');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final platform = D4.getOptionalNamedArg<$flutter_6.TargetPlatform?>(named, 'platform');
        return t.copyWith(bundle: bundle, devicePixelRatio: devicePixelRatio, locale: locale, textDirection: textDirection, size: size, platform: platform);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageConfiguration>(target, 'ImageConfiguration');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'empty': (visitor) => $flutter_34.ImageConfiguration.empty,
    },
    constructorSignatures: {
      '': 'const ImageConfiguration({AssetBundle? bundle, double? devicePixelRatio, Locale? locale, TextDirection? textDirection, Size? size, TargetPlatform? platform})',
    },
    methodSignatures: {
      'copyWith': 'ImageConfiguration copyWith({AssetBundle? bundle, double? devicePixelRatio, Locale? locale, TextDirection? textDirection, Size? size, TargetPlatform? platform})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bundle': 'AssetBundle? get bundle',
      'devicePixelRatio': 'double? get devicePixelRatio',
      'locale': 'Locale? get locale',
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
    nativeType: $flutter_34.ImageProvider,
    name: 'ImageProvider',
    isAssignable: (v) => v is $flutter_34.ImageProvider,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return (t as dynamic).obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<Object>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        (t as dynamic).resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return (t as dynamic).loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ImageProvider>(target, 'ImageProvider');
        return t.toString();
      },
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, T key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<T> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(T key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(T key, ImageDecoderCallback decode)',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// AssetBundleImageKey Bridge
// =============================================================================

BridgedClass _createAssetBundleImageKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_34.AssetBundleImageKey,
    name: 'AssetBundleImageKey',
    isAssignable: (v) => v is $flutter_34.AssetBundleImageKey,
    constructors: {
      '': (visitor, positional, named) {
        final bundle = D4.getRequiredNamedArg<$flutter_56.AssetBundle>(named, 'bundle', 'AssetBundleImageKey');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'AssetBundleImageKey');
        final scale = D4.getRequiredNamedArg<double>(named, 'scale', 'AssetBundleImageKey');
        return $flutter_34.AssetBundleImageKey(bundle: bundle, name: name, scale: scale);
      },
    },
    getters: {
      'bundle': (visitor, target) => D4.validateTarget<$flutter_34.AssetBundleImageKey>(target, 'AssetBundleImageKey').bundle,
      'name': (visitor, target) => D4.validateTarget<$flutter_34.AssetBundleImageKey>(target, 'AssetBundleImageKey').name,
      'scale': (visitor, target) => D4.validateTarget<$flutter_34.AssetBundleImageKey>(target, 'AssetBundleImageKey').scale,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.AssetBundleImageKey>(target, 'AssetBundleImageKey').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageKey>(target, 'AssetBundleImageKey');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageKey>(target, 'AssetBundleImageKey');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_34.AssetBundleImageProvider,
    name: 'AssetBundleImageProvider',
    isAssignable: (v) => v is $flutter_34.AssetBundleImageProvider,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        t.resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.AssetBundleImageProvider>(target, 'AssetBundleImageProvider');
        return t.toString();
      },
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, AssetBundleImageKey key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<AssetBundleImageKey> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(AssetBundleImageKey key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(AssetBundleImageKey key, ImageDecoderCallback decode)',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// ResizeImageKey Bridge
// =============================================================================

BridgedClass _createResizeImageKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_34.ResizeImageKey,
    name: 'ResizeImageKey',
    isAssignable: (v) => v is $flutter_34.ResizeImageKey,
    constructors: {
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.ResizeImageKey>(target, 'ResizeImageKey').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImageKey>(target, 'ResizeImageKey');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_34.ResizeImage,
    name: 'ResizeImage',
    isAssignable: (v) => v is $flutter_34.ResizeImage,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ResizeImage');
        final imageProvider = D4.getRequiredArg<$flutter_34.ImageProvider<Object>>(positional, 0, 'imageProvider', 'ResizeImage');
        final width = D4.getOptionalNamedArg<int?>(named, 'width');
        final height = D4.getOptionalNamedArg<int?>(named, 'height');
        final policy = D4.getNamedArgWithDefault<$flutter_34.ResizeImagePolicy>(named, 'policy', $flutter_34.ResizeImagePolicy.exact);
        final allowUpscaling = D4.getNamedArgWithDefault<bool>(named, 'allowUpscaling', false);
        return $flutter_34.ResizeImage(imageProvider, width: width, height: height, policy: policy, allowUpscaling: allowUpscaling);
      },
    },
    getters: {
      'imageProvider': (visitor, target) => D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage').imageProvider,
      'width': (visitor, target) => D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage').width,
      'height': (visitor, target) => D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage').height,
      'policy': (visitor, target) => D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage').policy,
      'allowUpscaling': (visitor, target) => D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage').allowUpscaling,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<$flutter_34.ResizeImageKey>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        t.resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_34.ResizeImageKey>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_34.ResizeImageKey>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ResizeImage>(target, 'ResizeImage');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'resizeIfNeeded': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'resizeIfNeeded');
        final cacheWidth = D4.getRequiredArg<int?>(positional, 0, 'cacheWidth', 'resizeIfNeeded');
        final cacheHeight = D4.getRequiredArg<int?>(positional, 1, 'cacheHeight', 'resizeIfNeeded');
        final provider = D4.getRequiredArg<$flutter_34.ImageProvider<Object>>(positional, 2, 'provider', 'resizeIfNeeded');
        return $flutter_34.ResizeImage.resizeIfNeeded(cacheWidth, cacheHeight, provider);
      },
    },
    constructorSignatures: {
      '': 'const ResizeImage(ImageProvider<Object> imageProvider, {int? width, int? height, ResizeImagePolicy policy = ResizeImagePolicy.exact, bool allowUpscaling = false})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, ResizeImageKey key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<ResizeImageKey> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(ResizeImageKey key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(ResizeImageKey key, ImageDecoderCallback decode)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'imageProvider': 'ImageProvider<Object> get imageProvider',
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
    nativeType: $flutter_34.NetworkImage,
    name: 'NetworkImage',
    isAssignable: (v) => v is $flutter_34.NetworkImage,
    isAbstract: true,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NetworkImage');
        final url = D4.getRequiredArg<String>(positional, 0, 'url', 'NetworkImage');
        final headers = D4.coerceMapOrNull<String, String>(named['headers'], 'headers');
        if (!named.containsKey('scale') && !named.containsKey('webHtmlElementStrategy')) {
          return $flutter_34.NetworkImage(url, headers: headers);
        }
        if (named.containsKey('scale') && !named.containsKey('webHtmlElementStrategy')) {
          final scale = D4.getRequiredNamedArg<double>(named, 'scale', 'NetworkImage');
          return $flutter_34.NetworkImage(url, headers: headers, scale: scale);
        }
        if (!named.containsKey('scale') && named.containsKey('webHtmlElementStrategy')) {
          final webHtmlElementStrategy = D4.getRequiredNamedArg<$flutter_34.WebHtmlElementStrategy>(named, 'webHtmlElementStrategy', 'NetworkImage');
          return $flutter_34.NetworkImage(url, headers: headers, webHtmlElementStrategy: webHtmlElementStrategy);
        }
        if (named.containsKey('scale') && named.containsKey('webHtmlElementStrategy')) {
          final scale = D4.getRequiredNamedArg<double>(named, 'scale', 'NetworkImage');
          final webHtmlElementStrategy = D4.getRequiredNamedArg<$flutter_34.WebHtmlElementStrategy>(named, 'webHtmlElementStrategy', 'NetworkImage');
          return $flutter_34.NetworkImage(url, headers: headers, scale: scale, webHtmlElementStrategy: webHtmlElementStrategy);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'url': (visitor, target) => D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage').url,
      'scale': (visitor, target) => D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage').scale,
      'headers': (visitor, target) => D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage').headers,
      'webHtmlElementStrategy': (visitor, target) => D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage').webHtmlElementStrategy,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<$flutter_34.NetworkImage>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        t.resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_34.NetworkImage>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_34.NetworkImage>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImage>(target, 'NetworkImage');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const factory NetworkImage(String url, {double scale, Map<String, String>? headers, WebHtmlElementStrategy webHtmlElementStrategy})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, NetworkImage key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<NetworkImage> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(NetworkImage key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(NetworkImage key, ImageDecoderCallback decode)',
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
    nativeType: $flutter_34.FileImage,
    name: 'FileImage',
    isAssignable: (v) => v is $flutter_34.FileImage,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FileImage');
        final file = D4.getRequiredArg<File>(positional, 0, 'file', 'FileImage');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        return $flutter_34.FileImage(file, scale: scale);
      },
    },
    getters: {
      'file': (visitor, target) => D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage').file,
      'scale': (visitor, target) => D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage').scale,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<$flutter_34.FileImage>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        t.resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_34.FileImage>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_34.FileImage>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.FileImage>(target, 'FileImage');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const FileImage(File file, {double scale = 1.0})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, FileImage key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<FileImage> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(FileImage key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(FileImage key, ImageDecoderCallback decode)',
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
    nativeType: $flutter_34.MemoryImage,
    name: 'MemoryImage',
    isAssignable: (v) => v is $flutter_34.MemoryImage,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MemoryImage');
        final bytes = D4.getRequiredArg<Uint8List>(positional, 0, 'bytes', 'MemoryImage');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        return $flutter_34.MemoryImage(bytes, scale: scale);
      },
    },
    getters: {
      'bytes': (visitor, target) => D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage').bytes,
      'scale': (visitor, target) => D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage').scale,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<$flutter_34.MemoryImage>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        t.resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_34.MemoryImage>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_34.MemoryImage>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.MemoryImage>(target, 'MemoryImage');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const MemoryImage(Uint8List bytes, {double scale = 1.0})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, MemoryImage key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<MemoryImage> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(MemoryImage key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(MemoryImage key, ImageDecoderCallback decode)',
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
    nativeType: $flutter_34.ExactAssetImage,
    name: 'ExactAssetImage',
    isAssignable: (v) => v is $flutter_34.ExactAssetImage,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExactAssetImage');
        final assetName = D4.getRequiredArg<String>(positional, 0, 'assetName', 'ExactAssetImage');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final bundle = D4.getOptionalNamedArg<$flutter_56.AssetBundle?>(named, 'bundle');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        return $flutter_34.ExactAssetImage(assetName, scale: scale, bundle: bundle, package: package);
      },
    },
    getters: {
      'assetName': (visitor, target) => D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage').assetName,
      'scale': (visitor, target) => D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage').scale,
      'bundle': (visitor, target) => D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage').bundle,
      'package': (visitor, target) => D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage').package,
      'keyName': (visitor, target) => D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage').keyName,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        t.resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.ExactAssetImage>(target, 'ExactAssetImage');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ExactAssetImage(String assetName, {double scale = 1.0, AssetBundle? bundle, String? package})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, AssetBundleImageKey key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<AssetBundleImageKey> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(AssetBundleImageKey key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(AssetBundleImageKey key, ImageDecoderCallback decode)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'assetName': 'String get assetName',
      'scale': 'double get scale',
      'bundle': 'AssetBundle? get bundle',
      'package': 'String? get package',
      'keyName': 'String get keyName',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// NetworkImageLoadException Bridge
// =============================================================================

BridgedClass _createNetworkImageLoadExceptionBridge() {
  return BridgedClass(
    nativeType: $flutter_34.NetworkImageLoadException,
    name: 'NetworkImageLoadException',
    isAssignable: (v) => v is $flutter_34.NetworkImageLoadException,
    constructors: {
      '': (visitor, positional, named) {
        final statusCode = D4.getRequiredNamedArg<int>(named, 'statusCode', 'NetworkImageLoadException');
        final uri = D4.getRequiredNamedArg<Uri>(named, 'uri', 'NetworkImageLoadException');
        return $flutter_34.NetworkImageLoadException(statusCode: statusCode, uri: uri);
      },
    },
    getters: {
      'statusCode': (visitor, target) => D4.validateTarget<$flutter_34.NetworkImageLoadException>(target, 'NetworkImageLoadException').statusCode,
      'uri': (visitor, target) => D4.validateTarget<$flutter_34.NetworkImageLoadException>(target, 'NetworkImageLoadException').uri,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.NetworkImageLoadException>(target, 'NetworkImageLoadException');
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
    nativeType: $flutter_35.AssetImage,
    name: 'AssetImage',
    isAssignable: (v) => v is $flutter_35.AssetImage,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AssetImage');
        final assetName = D4.getRequiredArg<String>(positional, 0, 'assetName', 'AssetImage');
        final bundle = D4.getOptionalNamedArg<$flutter_56.AssetBundle?>(named, 'bundle');
        final package = D4.getOptionalNamedArg<String?>(named, 'package');
        return $flutter_35.AssetImage(assetName, bundle: bundle, package: package);
      },
    },
    getters: {
      'assetName': (visitor, target) => D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage').assetName,
      'bundle': (visitor, target) => D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage').bundle,
      'package': (visitor, target) => D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage').package,
      'keyName': (visitor, target) => D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage').keyName,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage').hashCode,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 1, 'resolve');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolve');
        return t.resolve(configuration);
      },
      'createStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 1, 'createStream');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'createStream');
        return t.createStream(configuration);
      },
      'obtainCacheStatus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        final configuration = D4.getRequiredNamedArg<$flutter_34.ImageConfiguration>(named, 'configuration', 'obtainCacheStatus');
        final handleErrorRaw = named['handleError'];
        return t.obtainCacheStatus(configuration: configuration, handleError: handleErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
      },
      'resolveStreamForKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 4, 'resolveStreamForKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'resolveStreamForKey');
        final stream = D4.getRequiredArg<$flutter_36.ImageStream>(positional, 1, 'stream', 'resolveStreamForKey');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 2, 'key', 'resolveStreamForKey');
        if (positional.length <= 3) {
          throw ArgumentError('resolveStreamForKey: Missing required argument "handleError" at position 3');
        }
        final handleErrorRaw = positional[3];
        t.resolveStreamForKey(configuration, stream, key, (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, handleErrorRaw, [p0, p1]); });
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        final cache = D4.getOptionalNamedArg<$flutter_32.ImageCache?>(named, 'cache');
        final configuration = D4.getNamedArgWithDefault<$flutter_34.ImageConfiguration>(named, 'configuration', $flutter_34.ImageConfiguration.empty);
        return t.evict(cache: cache, configuration: configuration);
      },
      'obtainKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 1, 'obtainKey');
        final configuration = D4.getRequiredArg<$flutter_34.ImageConfiguration>(positional, 0, 'configuration', 'obtainKey');
        return t.obtainKey(configuration);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 2, 'loadBuffer');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 0, 'key', 'loadBuffer');
        if (positional.length <= 1) {
          throw ArgumentError('loadBuffer: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadBuffer(key, (ImmutableBuffer p0, {bool allowUpscaling = false, int? cacheHeight, int? cacheWidth}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'allowUpscaling': allowUpscaling, 'cacheHeight': cacheHeight, 'cacheWidth': cacheWidth}), 'callback', visitor) as Future<Codec>; });
      },
      'loadImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        D4.requireMinArgs(positional, 2, 'loadImage');
        final key = D4.getRequiredArg<$flutter_34.AssetBundleImageKey>(positional, 0, 'key', 'loadImage');
        if (positional.length <= 1) {
          throw ArgumentError('loadImage: Missing required argument "decode" at position 1');
        }
        final decodeRaw = positional[1];
        return t.loadImage(key, (ImmutableBuffer p0, {TargetImageSize Function(int, int)? getTargetSize}) { return D4.extractBridgedArg<Future<Codec>>(D4.callInterpreterCallback(visitor!, decodeRaw, [p0], {'getTargetSize': getTargetSize}), 'callback', visitor) as Future<Codec>; });
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.AssetImage>(target, 'AssetImage');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const AssetImage(String assetName, {AssetBundle? bundle, String? package})',
    },
    methodSignatures: {
      'resolve': 'ImageStream resolve(ImageConfiguration configuration)',
      'createStream': 'ImageStream createStream(ImageConfiguration configuration)',
      'obtainCacheStatus': 'Future<ImageCacheStatus?> obtainCacheStatus({required ImageConfiguration configuration, ImageErrorListener? handleError})',
      'resolveStreamForKey': 'void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream, AssetBundleImageKey key, ImageErrorListener handleError)',
      'evict': 'Future<bool> evict({ImageCache? cache, ImageConfiguration configuration = ImageConfiguration.empty})',
      'obtainKey': 'Future<AssetBundleImageKey> obtainKey(ImageConfiguration configuration)',
      'loadBuffer': 'ImageStreamCompleter loadBuffer(AssetBundleImageKey key, DecoderBufferCallback decode)',
      'loadImage': 'ImageStreamCompleter loadImage(AssetBundleImageKey key, ImageDecoderCallback decode)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'assetName': 'String get assetName',
      'bundle': 'AssetBundle? get bundle',
      'package': 'String? get package',
      'keyName': 'String get keyName',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImageInfo Bridge
// =============================================================================

BridgedClass _createImageInfoBridge() {
  return BridgedClass(
    nativeType: $flutter_36.ImageInfo,
    name: 'ImageInfo',
    isAssignable: (v) => v is $flutter_36.ImageInfo,
    constructors: {
      '': (visitor, positional, named) {
        final image = D4.getRequiredNamedArg<Image>(named, 'image', 'ImageInfo');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        return $flutter_36.ImageInfo(image: image, scale: scale, debugLabel: debugLabel);
      },
    },
    getters: {
      'image': (visitor, target) => D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo').image,
      'scale': (visitor, target) => D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo').scale,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo').debugLabel,
      'sizeBytes': (visitor, target) => D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo').sizeBytes,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo').hashCode,
    },
    methods: {
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo');
        return t.clone();
      },
      'isCloneOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo');
        D4.requireMinArgs(positional, 1, 'isCloneOf');
        final other = D4.getRequiredArg<$flutter_36.ImageInfo>(positional, 0, 'other', 'isCloneOf');
        return t.isCloneOf(other);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageInfo>(target, 'ImageInfo');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
      'image': 'Image get image',
      'scale': 'double get scale',
      'debugLabel': 'String? get debugLabel',
      'sizeBytes': 'int get sizeBytes',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ImageStreamListener Bridge
// =============================================================================

BridgedClass _createImageStreamListenerBridge() {
  return BridgedClass(
    nativeType: $flutter_36.ImageStreamListener,
    name: 'ImageStreamListener',
    isAssignable: (v) => v is $flutter_36.ImageStreamListener,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ImageStreamListener');
        if (positional.isEmpty) {
          throw ArgumentError('ImageStreamListener: Missing required argument "onImage" at position 0');
        }
        final onImageRaw = positional[0];
        final onChunkRaw = named['onChunk'];
        final onErrorRaw = named['onError'];
        return $flutter_36.ImageStreamListener(($flutter_36.ImageInfo p0, bool p1) { D4.callInterpreterCallback(visitor!, onImageRaw, [p0, p1]); }, onChunk: onChunkRaw == null ? null : ($flutter_36.ImageChunkEvent p0) { D4.callInterpreterCallback(visitor!, onChunkRaw, [p0]); }, onError: onErrorRaw == null ? null : (Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, onErrorRaw, [p0, p1]); });
      },
    },
    getters: {
      'onImage': (visitor, target) => D4.validateTarget<$flutter_36.ImageStreamListener>(target, 'ImageStreamListener').onImage,
      'onChunk': (visitor, target) => D4.validateTarget<$flutter_36.ImageStreamListener>(target, 'ImageStreamListener').onChunk,
      'onError': (visitor, target) => D4.validateTarget<$flutter_36.ImageStreamListener>(target, 'ImageStreamListener').onError,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_36.ImageStreamListener>(target, 'ImageStreamListener').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamListener>(target, 'ImageStreamListener');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ImageStreamListener(ImageListener onImage, {ImageChunkListener? onChunk, ImageErrorListener? onError})',
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
    nativeType: $flutter_36.ImageChunkEvent,
    name: 'ImageChunkEvent',
    isAssignable: (v) => v is $flutter_36.ImageChunkEvent,
    constructors: {
      '': (visitor, positional, named) {
        final cumulativeBytesLoaded = D4.getRequiredNamedArg<int>(named, 'cumulativeBytesLoaded', 'ImageChunkEvent');
        final expectedTotalBytes = D4.getRequiredNamedArg<int?>(named, 'expectedTotalBytes', 'ImageChunkEvent');
        return $flutter_36.ImageChunkEvent(cumulativeBytesLoaded: cumulativeBytesLoaded, expectedTotalBytes: expectedTotalBytes);
      },
    },
    getters: {
      'cumulativeBytesLoaded': (visitor, target) => D4.validateTarget<$flutter_36.ImageChunkEvent>(target, 'ImageChunkEvent').cumulativeBytesLoaded,
      'expectedTotalBytes': (visitor, target) => D4.validateTarget<$flutter_36.ImageChunkEvent>(target, 'ImageChunkEvent').expectedTotalBytes,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageChunkEvent>(target, 'ImageChunkEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageChunkEvent>(target, 'ImageChunkEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageChunkEvent>(target, 'ImageChunkEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageChunkEvent>(target, 'ImageChunkEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const ImageChunkEvent({required int cumulativeBytesLoaded, required int? expectedTotalBytes})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_36.ImageStream,
    name: 'ImageStream',
    isAssignable: (v) => v is $flutter_36.ImageStream,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_36.ImageStream();
      },
    },
    getters: {
      'completer': (visitor, target) => D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream').completer,
      'key': (visitor, target) => D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream').key,
    },
    methods: {
      'setCompleter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream');
        D4.requireMinArgs(positional, 1, 'setCompleter');
        final value = D4.getRequiredArg<$flutter_36.ImageStreamCompleter>(positional, 0, 'value', 'setCompleter');
        t.setCompleter(value);
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStream>(target, 'ImageStream');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
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
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_36.ImageStreamCompleterHandle,
    name: 'ImageStreamCompleterHandle',
    isAssignable: (v) => v is $flutter_36.ImageStreamCompleterHandle,
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleterHandle>(target, 'ImageStreamCompleterHandle');
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
    nativeType: $flutter_36.ImageStreamCompleter,
    name: 'ImageStreamCompleter',
    isAssignable: (v) => v is $flutter_36.ImageStreamCompleter,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter').debugLabel,
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter').hasListeners,
    },
    setters: {
      'debugLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter').debugLabel = D4.extractBridgedArgOrNull<String>(value, 'debugLabel'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'addEphemeralErrorListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addEphemeralErrorListener');
        if (positional.isEmpty) {
          throw ArgumentError('addEphemeralErrorListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addEphemeralErrorListener((Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0, p1]); });
        return null;
      },
      'keepAlive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        return t.keepAlive();
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'onDisposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        t.onDisposed();
        return null;
      },
      'maybeDispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        t.maybeDispose();
        return null;
      },
      'addOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'removeOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'setImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'setImage');
        final image = D4.getRequiredArg<$flutter_36.ImageInfo>(positional, 0, 'image', 'setImage');
        t.setImage(image);
        return null;
      },
      'reportError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        final context = D4.getOptionalNamedArg<$flutter_5.DiagnosticsNode?>(named, 'context');
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'reportError');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        t.reportError(context: context, exception: exception, stack: stack, informationCollector: informationCollectorRaw == null ? null : (() { return D4.extractBridgedArg<Iterable<$flutter_5.DiagnosticsNode>>(D4.callInterpreterCallback(visitor!, informationCollectorRaw, []), 'callback', visitor) as Iterable<$flutter_5.DiagnosticsNode>; }) as Iterable<$flutter_5.DiagnosticsNode> Function(), silent: silent);
        return null;
      },
      'reportImageChunkEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'reportImageChunkEvent');
        final event = D4.getRequiredArg<$flutter_36.ImageChunkEvent>(positional, 0, 'event', 'reportImageChunkEvent');
        t.reportImageChunkEvent(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final description = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'description', 'debugFillProperties');
        (t as dynamic).debugFillProperties(description);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.ImageStreamCompleter>(target, 'ImageStreamCompleter');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    methodSignatures: {
      'addListener': 'void addListener(ImageStreamListener listener)',
      'addEphemeralErrorListener': 'void addEphemeralErrorListener(ImageErrorListener listener)',
      'keepAlive': 'ImageStreamCompleterHandle keepAlive()',
      'removeListener': 'void removeListener(ImageStreamListener listener)',
      'onDisposed': 'void onDisposed()',
      'maybeDispose': 'void maybeDispose()',
      'addOnLastListenerRemovedCallback': 'void addOnLastListenerRemovedCallback(VoidCallback callback)',
      'removeOnLastListenerRemovedCallback': 'void removeOnLastListenerRemovedCallback(VoidCallback callback)',
      'setImage': 'void setImage(ImageInfo image)',
      'reportError': 'void reportError({DiagnosticsNode? context, required Object exception, StackTrace? stack, InformationCollector? informationCollector, bool silent = false})',
      'reportImageChunkEvent': 'void reportImageChunkEvent(ImageChunkEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder description)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'debugLabel': 'String? get debugLabel',
      'hasListeners': 'bool get hasListeners',
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
    nativeType: $flutter_36.OneFrameImageStreamCompleter,
    name: 'OneFrameImageStreamCompleter',
    isAssignable: (v) => v is $flutter_36.OneFrameImageStreamCompleter,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OneFrameImageStreamCompleter');
        final image = D4.getRequiredArg<Future<$flutter_36.ImageInfo>>(positional, 0, 'image', 'OneFrameImageStreamCompleter');
        final informationCollectorRaw = named['informationCollector'];
        return $flutter_36.OneFrameImageStreamCompleter(image, informationCollector: informationCollectorRaw == null ? null : (() { return D4.extractBridgedArg<Iterable<$flutter_5.DiagnosticsNode>>(D4.callInterpreterCallback(visitor!, informationCollectorRaw, []), 'callback', visitor) as Iterable<$flutter_5.DiagnosticsNode>; }) as Iterable<$flutter_5.DiagnosticsNode> Function());
      },
    },
    getters: {
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter').debugLabel,
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter').hasListeners,
    },
    setters: {
      'debugLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter').debugLabel = D4.extractBridgedArgOrNull<String>(value, 'debugLabel'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'addEphemeralErrorListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addEphemeralErrorListener');
        if (positional.isEmpty) {
          throw ArgumentError('addEphemeralErrorListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addEphemeralErrorListener((Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0, p1]); });
        return null;
      },
      'keepAlive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        return t.keepAlive();
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'onDisposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        t.onDisposed();
        return null;
      },
      'maybeDispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        t.maybeDispose();
        return null;
      },
      'addOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'removeOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'setImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'setImage');
        final image = D4.getRequiredArg<$flutter_36.ImageInfo>(positional, 0, 'image', 'setImage');
        t.setImage(image);
        return null;
      },
      'reportError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        final context = D4.getOptionalNamedArg<$flutter_5.DiagnosticsNode?>(named, 'context');
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'reportError');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        t.reportError(context: context, exception: exception, stack: stack, informationCollector: informationCollectorRaw == null ? null : (() { return D4.extractBridgedArg<Iterable<$flutter_5.DiagnosticsNode>>(D4.callInterpreterCallback(visitor!, informationCollectorRaw, []), 'callback', visitor) as Iterable<$flutter_5.DiagnosticsNode>; }) as Iterable<$flutter_5.DiagnosticsNode> Function(), silent: silent);
        return null;
      },
      'reportImageChunkEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'reportImageChunkEvent');
        final event = D4.getRequiredArg<$flutter_36.ImageChunkEvent>(positional, 0, 'event', 'reportImageChunkEvent');
        t.reportImageChunkEvent(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final description = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'description', 'debugFillProperties');
        (t as dynamic).debugFillProperties(description);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.OneFrameImageStreamCompleter>(target, 'OneFrameImageStreamCompleter');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'OneFrameImageStreamCompleter(Future<ImageInfo> image, {InformationCollector? informationCollector})',
    },
    methodSignatures: {
      'addListener': 'void addListener(ImageStreamListener listener)',
      'addEphemeralErrorListener': 'void addEphemeralErrorListener(ImageErrorListener listener)',
      'keepAlive': 'ImageStreamCompleterHandle keepAlive()',
      'removeListener': 'void removeListener(ImageStreamListener listener)',
      'onDisposed': 'void onDisposed()',
      'maybeDispose': 'void maybeDispose()',
      'addOnLastListenerRemovedCallback': 'void addOnLastListenerRemovedCallback(VoidCallback callback)',
      'removeOnLastListenerRemovedCallback': 'void removeOnLastListenerRemovedCallback(VoidCallback callback)',
      'setImage': 'void setImage(ImageInfo image)',
      'reportError': 'void reportError({DiagnosticsNode? context, required Object exception, StackTrace? stack, InformationCollector? informationCollector, bool silent = false})',
      'reportImageChunkEvent': 'void reportImageChunkEvent(ImageChunkEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder description)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'debugLabel': 'String? get debugLabel',
      'hasListeners': 'bool get hasListeners',
    },
    setterSignatures: {
      'debugLabel': 'set debugLabel(String? value)',
    },
  );
}

// =============================================================================
// MultiFrameImageStreamCompleter Bridge
// =============================================================================

BridgedClass _createMultiFrameImageStreamCompleterBridge() {
  return BridgedClass(
    nativeType: $flutter_36.MultiFrameImageStreamCompleter,
    name: 'MultiFrameImageStreamCompleter',
    isAssignable: (v) => v is $flutter_36.MultiFrameImageStreamCompleter,
    constructors: {
      '': (visitor, positional, named) {
        final codec = D4.getRequiredNamedArg<Future<Codec>>(named, 'codec', 'MultiFrameImageStreamCompleter');
        final scale = D4.getRequiredNamedArg<double>(named, 'scale', 'MultiFrameImageStreamCompleter');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final chunkEvents = D4.getOptionalNamedArg<Stream<$flutter_36.ImageChunkEvent>?>(named, 'chunkEvents');
        final informationCollectorRaw = named['informationCollector'];
        return $flutter_36.MultiFrameImageStreamCompleter(codec: codec, scale: scale, debugLabel: debugLabel, chunkEvents: chunkEvents, informationCollector: informationCollectorRaw == null ? null : (() { return D4.extractBridgedArg<Iterable<$flutter_5.DiagnosticsNode>>(D4.callInterpreterCallback(visitor!, informationCollectorRaw, []), 'callback', visitor) as Iterable<$flutter_5.DiagnosticsNode>; }) as Iterable<$flutter_5.DiagnosticsNode> Function());
      },
    },
    getters: {
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter').debugLabel,
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter').hasListeners,
    },
    setters: {
      'debugLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter').debugLabel = D4.extractBridgedArgOrNull<String>(value, 'debugLabel'),
    },
    methods: {
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'addListener');
        t.addListener(listener);
        return null;
      },
      'addEphemeralErrorListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addEphemeralErrorListener');
        if (positional.isEmpty) {
          throw ArgumentError('addEphemeralErrorListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addEphemeralErrorListener((Object p0, StackTrace? p1) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0, p1]); });
        return null;
      },
      'keepAlive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        return t.keepAlive();
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeListener');
        final listener = D4.getRequiredArg<$flutter_36.ImageStreamListener>(positional, 0, 'listener', 'removeListener');
        t.removeListener(listener);
        return null;
      },
      'onDisposed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        t.onDisposed();
        return null;
      },
      'maybeDispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        t.maybeDispose();
        return null;
      },
      'addOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'addOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'removeOnLastListenerRemovedCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'removeOnLastListenerRemovedCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnLastListenerRemovedCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeOnLastListenerRemovedCallback(() { D4.callInterpreterCallback(visitor!, callbackRaw, []); });
        return null;
      },
      'setImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'setImage');
        final image = D4.getRequiredArg<$flutter_36.ImageInfo>(positional, 0, 'image', 'setImage');
        t.setImage(image);
        return null;
      },
      'reportError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        final context = D4.getOptionalNamedArg<$flutter_5.DiagnosticsNode?>(named, 'context');
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'reportError');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        t.reportError(context: context, exception: exception, stack: stack, informationCollector: informationCollectorRaw == null ? null : (() { return D4.extractBridgedArg<Iterable<$flutter_5.DiagnosticsNode>>(D4.callInterpreterCallback(visitor!, informationCollectorRaw, []), 'callback', visitor) as Iterable<$flutter_5.DiagnosticsNode>; }) as Iterable<$flutter_5.DiagnosticsNode> Function(), silent: silent);
        return null;
      },
      'reportImageChunkEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'reportImageChunkEvent');
        final event = D4.getRequiredArg<$flutter_36.ImageChunkEvent>(positional, 0, 'event', 'reportImageChunkEvent');
        t.reportImageChunkEvent(event);
        return null;
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final description = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'description', 'debugFillProperties');
        (t as dynamic).debugFillProperties(description);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_36.MultiFrameImageStreamCompleter>(target, 'MultiFrameImageStreamCompleter');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'MultiFrameImageStreamCompleter({required Future<Codec> codec, required double scale, String? debugLabel, Stream<ImageChunkEvent>? chunkEvents, InformationCollector? informationCollector})',
    },
    methodSignatures: {
      'addListener': 'void addListener(ImageStreamListener listener)',
      'addEphemeralErrorListener': 'void addEphemeralErrorListener(ImageErrorListener listener)',
      'keepAlive': 'ImageStreamCompleterHandle keepAlive()',
      'removeListener': 'void removeListener(ImageStreamListener listener)',
      'onDisposed': 'void onDisposed()',
      'maybeDispose': 'void maybeDispose()',
      'addOnLastListenerRemovedCallback': 'void addOnLastListenerRemovedCallback(VoidCallback callback)',
      'removeOnLastListenerRemovedCallback': 'void removeOnLastListenerRemovedCallback(VoidCallback callback)',
      'setImage': 'void setImage(ImageInfo image)',
      'reportError': 'void reportError({DiagnosticsNode? context, required Object exception, StackTrace? stack, InformationCollector? informationCollector, bool silent = false})',
      'reportImageChunkEvent': 'void reportImageChunkEvent(ImageChunkEvent event)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder description)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'debugLabel': 'String? get debugLabel',
      'hasListeners': 'bool get hasListeners',
    },
    setterSignatures: {
      'debugLabel': 'set debugLabel(String? value)',
    },
  );
}

// =============================================================================
// Accumulator Bridge
// =============================================================================

BridgedClass _createAccumulatorBridge() {
  return BridgedClass(
    nativeType: $flutter_37.Accumulator,
    name: 'Accumulator',
    isAssignable: (v) => v is $flutter_37.Accumulator,
    constructors: {
      '': (visitor, positional, named) {
        final value = D4.getOptionalArgWithDefault<int>(positional, 0, '_value', 0);
        return $flutter_37.Accumulator(value);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<$flutter_37.Accumulator>(target, 'Accumulator').value,
    },
    methods: {
      'increment': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.Accumulator>(target, 'Accumulator');
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
    nativeType: $flutter_37.InlineSpanSemanticsInformation,
    name: 'InlineSpanSemanticsInformation',
    isAssignable: (v) => v is $flutter_37.InlineSpanSemanticsInformation,
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
        final recognizer = D4.getOptionalNamedArg<$flutter_9.GestureRecognizer?>(named, 'recognizer');
        return $flutter_37.InlineSpanSemanticsInformation(text, isPlaceholder: isPlaceholder, semanticsLabel: semanticsLabel, semanticsIdentifier: semanticsIdentifier, stringAttributes: stringAttributes, recognizer: recognizer);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').text,
      'semanticsLabel': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').semanticsLabel,
      'semanticsIdentifier': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').semanticsIdentifier,
      'recognizer': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').recognizer,
      'isPlaceholder': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').isPlaceholder,
      'requiresOwnNode': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').requiresOwnNode,
      'stringAttributes': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').stringAttributes,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpanSemanticsInformation>(target, 'InlineSpanSemanticsInformation');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'placeholder': (visitor) => $flutter_37.InlineSpanSemanticsInformation.placeholder,
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
      'stringAttributes': 'List<StringAttribute> get stringAttributes',
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
    nativeType: $flutter_37.InlineSpan,
    name: 'InlineSpan',
    isAssignable: (v) => v is $flutter_37.InlineSpan,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'style': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan').style,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan').hashCode,
    },
    methods: {
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'build');
        final builder = D4.getRequiredArg<ParagraphBuilder>(positional, 0, 'builder', 'build');
        final textScaler = D4.getNamedArgWithDefault<$flutter_51.TextScaler>(named, 'textScaler', $flutter_51.TextScaler.noScaling);
        final dimensions = D4.coerceListOrNull<$flutter_50.PlaceholderDimensions>(named['dimensions'], 'dimensions');
        (t as dynamic).build(builder, textScaler: textScaler, dimensions: dimensions);
        return null;
      },
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitChildren((($flutter_37.InlineSpan p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; }) as bool Function($flutter_37.InlineSpan));
      },
      'visitDirectChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'visitDirectChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitDirectChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitDirectChildren((($flutter_37.InlineSpan p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; }) as bool Function($flutter_37.InlineSpan));
      },
      'getSpanForPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'getSpanForPosition');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPosition');
        return t.getSpanForPosition(position);
      },
      'getSpanForPositionVisitor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 2, 'getSpanForPositionVisitor');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPositionVisitor');
        final offset = D4.getRequiredArg<$flutter_37.Accumulator>(positional, 1, 'offset', 'getSpanForPositionVisitor');
        return t.getSpanForPositionVisitor(position, offset);
      },
      'toPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        return t.toPlainText(includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
      },
      'getSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        return t.getSemanticsInformation();
      },
      'computeSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'computeSemanticsInformation');
        if (positional.isEmpty) {
          throw ArgumentError('computeSemanticsInformation: Missing required argument "collector" at position 0');
        }
        final collector = D4.coerceList<$flutter_37.InlineSpanSemanticsInformation>(positional[0], 'collector');
        t.computeSemanticsInformation(collector);
        return null;
      },
      'computeToPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'computeToPlainText');
        final buffer = D4.getRequiredArg<StringBuffer>(positional, 0, 'buffer', 'computeToPlainText');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        t.computeToPlainText(buffer, includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
        return null;
      },
      'codeUnitAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'codeUnitAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAt');
        return t.codeUnitAt(index);
      },
      'codeUnitAtVisitor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 2, 'codeUnitAtVisitor');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAtVisitor');
        final offset = D4.getRequiredArg<$flutter_37.Accumulator>(positional, 1, 'offset', 'codeUnitAtVisitor');
        return t.codeUnitAtVisitor(index, offset);
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        return t.debugAssertIsValid();
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_37.InlineSpan>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.InlineSpan>(target, 'InlineSpan');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'build': 'void build(ParagraphBuilder builder, {TextScaler textScaler = TextScaler.noScaling, List<PlaceholderDimensions>? dimensions})',
      'visitChildren': 'bool visitChildren(InlineSpanVisitor visitor)',
      'visitDirectChildren': 'bool visitDirectChildren(InlineSpanVisitor visitor)',
      'getSpanForPosition': 'InlineSpan? getSpanForPosition(TextPosition position)',
      'getSpanForPositionVisitor': 'InlineSpan? getSpanForPositionVisitor(TextPosition position, Accumulator offset)',
      'toPlainText': 'String toPlainText({bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'getSemanticsInformation': 'List<InlineSpanSemanticsInformation> getSemanticsInformation()',
      'computeSemanticsInformation': 'void computeSemanticsInformation(List<InlineSpanSemanticsInformation> collector)',
      'computeToPlainText': 'void computeToPlainText(StringBuffer buffer, {bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'codeUnitAt': 'int? codeUnitAt(int index)',
      'codeUnitAtVisitor': 'int? codeUnitAtVisitor(int index, Accumulator offset)',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'compareTo': 'RenderComparison compareTo(InlineSpan other)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
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
    nativeType: $flutter_38.LinearBorderEdge,
    name: 'LinearBorderEdge',
    isAssignable: (v) => v is $flutter_38.LinearBorderEdge,
    constructors: {
      '': (visitor, positional, named) {
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        return $flutter_38.LinearBorderEdge(size: size, alignment: alignment);
      },
    },
    getters: {
      'size': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorderEdge>(target, 'LinearBorderEdge').size,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorderEdge>(target, 'LinearBorderEdge').alignment,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorderEdge>(target, 'LinearBorderEdge').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorderEdge>(target, 'LinearBorderEdge');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorderEdge>(target, 'LinearBorderEdge');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_38.LinearBorderEdge?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_38.LinearBorderEdge?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_38.LinearBorderEdge.lerp(a, b, t_);
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
    nativeType: $flutter_38.LinearBorder,
    name: 'LinearBorder',
    isAssignable: (v) => v is $flutter_38.LinearBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final start = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'start');
        final end = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'end');
        final top = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'top');
        final bottom = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'bottom');
        return $flutter_38.LinearBorder(side: side, start: start, end: end, top: top, bottom: bottom);
      },
      'start': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_38.LinearBorder.start(side: side, alignment: alignment, size: size);
      },
      'end': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_38.LinearBorder.end(side: side, alignment: alignment, size: size);
      },
      'top': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_38.LinearBorder.top(side: side, alignment: alignment, size: size);
      },
      'bottom': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final alignment = D4.getNamedArgWithDefault<double>(named, 'alignment', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 1.0);
        return $flutter_38.LinearBorder.bottom(side: side, alignment: alignment, size: size);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').side,
      'start': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').end,
      'top': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').top,
      'bottom': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').bottom,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final start = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'start');
        final end = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'end');
        final top = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'top');
        final bottom = D4.getOptionalNamedArg<$flutter_38.LinearBorderEdge?>(named, 'bottom');
        return t.copyWith(side: side, start: start, end: end, top: top, bottom: bottom);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_38.LinearBorder>(target, 'LinearBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'none': (visitor) => $flutter_38.LinearBorder.none,
    },
    constructorSignatures: {
      '': 'const LinearBorder({BorderSide side = BorderSide.none, LinearBorderEdge? start, LinearBorderEdge? end, LinearBorderEdge? top, LinearBorderEdge? bottom})',
      'start': 'LinearBorder.start({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
      'end': 'LinearBorder.end({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
      'top': 'LinearBorder.top({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
      'bottom': 'LinearBorder.bottom({BorderSide side = BorderSide.none, double alignment = 0.0, double size = 1.0})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'LinearBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'LinearBorder copyWith({BorderSide? side, LinearBorderEdge? start, LinearBorderEdge? end, LinearBorderEdge? top, LinearBorderEdge? bottom})',
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
    nativeType: $flutter_39.MatrixUtils,
    name: 'MatrixUtils',
    isAssignable: (v) => v is $flutter_39.MatrixUtils,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'getAsTranslation': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getAsTranslation');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'getAsTranslation');
        return $flutter_39.MatrixUtils.getAsTranslation(transform);
      },
      'getAsScale': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getAsScale');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'getAsScale');
        return $flutter_39.MatrixUtils.getAsScale(transform);
      },
      'multiplyInPlace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'multiplyInPlace');
        final a = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'a', 'multiplyInPlace');
        final b = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 1, 'b', 'multiplyInPlace');
        return $flutter_39.MatrixUtils.multiplyInPlace(a, b);
      },
      'matrixEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'matrixEquals');
        final a = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'a', 'matrixEquals');
        final b = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 1, 'b', 'matrixEquals');
        return $flutter_39.MatrixUtils.matrixEquals(a, b);
      },
      'isIdentity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isIdentity');
        final a = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'a', 'isIdentity');
        return $flutter_39.MatrixUtils.isIdentity(a);
      },
      'transformPoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transformPoint');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'transformPoint');
        final point = D4.getRequiredArg<Offset>(positional, 1, 'point', 'transformPoint');
        return $flutter_39.MatrixUtils.transformPoint(transform, point);
      },
      'transformRect': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transformRect');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'transformRect');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'transformRect');
        return $flutter_39.MatrixUtils.transformRect(transform, rect);
      },
      'inverseTransformRect': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'inverseTransformRect');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'inverseTransformRect');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'inverseTransformRect');
        return $flutter_39.MatrixUtils.inverseTransformRect(transform, rect);
      },
      'createCylindricalProjectionTransform': (visitor, positional, named, typeArgs) {
        final radius = D4.getRequiredNamedArg<double>(named, 'radius', 'createCylindricalProjectionTransform');
        final angle = D4.getRequiredNamedArg<double>(named, 'angle', 'createCylindricalProjectionTransform');
        final perspective = D4.getNamedArgWithDefault<double>(named, 'perspective', 0.001);
        final orientation = D4.getNamedArgWithDefault<$flutter_11.Axis>(named, 'orientation', $flutter_11.Axis.vertical);
        return $flutter_39.MatrixUtils.createCylindricalProjectionTransform(radius: radius, angle: angle, perspective: perspective, orientation: orientation);
      },
      'forceToPoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'forceToPoint');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'forceToPoint');
        return $flutter_39.MatrixUtils.forceToPoint(offset);
      },
    },
    staticMethodSignatures: {
      'getAsTranslation': 'Offset? getAsTranslation(Matrix4 transform)',
      'getAsScale': 'double? getAsScale(Matrix4 transform)',
      'multiplyInPlace': 'void multiplyInPlace(Matrix4 a, Matrix4 b)',
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
    nativeType: $flutter_39.TransformProperty,
    name: 'TransformProperty',
    isAssignable: (v) => v is $flutter_39.TransformProperty,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TransformProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TransformProperty');
        final value = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 1, 'value', 'TransformProperty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final level = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'level', $flutter_5.DiagnosticLevel.info);
        if (!named.containsKey('defaultValue')) {
          return $flutter_39.TransformProperty(name, value, showName: showName, level: level);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'TransformProperty');
          return $flutter_39.TransformProperty(name, value, showName: showName, level: level, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').defaultValue,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').isInteresting,
      'level': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty').textTreeConfiguration,
    },
    methods: {
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_5.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_5.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_5.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.TransformProperty>(target, 'TransformProperty');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_5.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
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
      'textTreeConfiguration': 'TextTreeConfiguration? get textTreeConfiguration',
    },
  );
}

// =============================================================================
// NotchedShape Bridge
// =============================================================================

BridgedClass _createNotchedShapeBridge() {
  return BridgedClass(
    nativeType: $flutter_40.NotchedShape,
    name: 'NotchedShape',
    isAssignable: (v) => v is $flutter_40.NotchedShape,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_40.NotchedShape>(target, 'NotchedShape');
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
    nativeType: $flutter_40.CircularNotchedRectangle,
    name: 'CircularNotchedRectangle',
    isAssignable: (v) => v is $flutter_40.CircularNotchedRectangle,
    constructors: {
      '': (visitor, positional, named) {
        final inverted = D4.getNamedArgWithDefault<bool>(named, 'inverted', false);
        return $flutter_40.CircularNotchedRectangle(inverted: inverted);
      },
    },
    getters: {
      'inverted': (visitor, target) => D4.validateTarget<$flutter_40.CircularNotchedRectangle>(target, 'CircularNotchedRectangle').inverted,
    },
    methods: {
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_40.CircularNotchedRectangle>(target, 'CircularNotchedRectangle');
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
    nativeType: $flutter_40.AutomaticNotchedShape,
    name: 'AutomaticNotchedShape',
    isAssignable: (v) => v is $flutter_40.AutomaticNotchedShape,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AutomaticNotchedShape');
        final host = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'host', 'AutomaticNotchedShape');
        final guest = D4.getOptionalArg<$flutter_15.ShapeBorder?>(positional, 1, 'guest');
        return $flutter_40.AutomaticNotchedShape(host, guest);
      },
    },
    getters: {
      'host': (visitor, target) => D4.validateTarget<$flutter_40.AutomaticNotchedShape>(target, 'AutomaticNotchedShape').host,
      'guest': (visitor, target) => D4.validateTarget<$flutter_40.AutomaticNotchedShape>(target, 'AutomaticNotchedShape').guest,
    },
    methods: {
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_40.AutomaticNotchedShape>(target, 'AutomaticNotchedShape');
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
    nativeType: $flutter_41.OvalBorder,
    name: 'OvalBorder',
    isAssignable: (v) => v is $flutter_41.OvalBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final eccentricity = D4.getNamedArgWithDefault<double>(named, 'eccentricity', 1.0);
        return $flutter_41.OvalBorder(side: side, eccentricity: eccentricity);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder').side,
      'eccentricity': (visitor, target) => D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder').eccentricity,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final eccentricity = D4.getOptionalNamedArg<double?>(named, 'eccentricity');
        return t.copyWith(side: side, eccentricity: eccentricity);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.OvalBorder>(target, 'OvalBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const OvalBorder({BorderSide side = BorderSide.none, double eccentricity = 1.0})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'OvalBorder copyWith({BorderSide? side, double? eccentricity})',
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
    nativeType: $flutter_43.PlaceholderSpan,
    name: 'PlaceholderSpan',
    isAssignable: (v) => v is $flutter_43.PlaceholderSpan,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'style': (visitor, target) => D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan').style,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan').hashCode,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan').alignment,
      'baseline': (visitor, target) => D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan').baseline,
    },
    methods: {
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'build');
        final builder = D4.getRequiredArg<ParagraphBuilder>(positional, 0, 'builder', 'build');
        final textScaler = D4.getNamedArgWithDefault<$flutter_51.TextScaler>(named, 'textScaler', $flutter_51.TextScaler.noScaling);
        final dimensions = D4.coerceListOrNull<$flutter_50.PlaceholderDimensions>(named['dimensions'], 'dimensions');
        (t as dynamic).build(builder, textScaler: textScaler, dimensions: dimensions);
        return null;
      },
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitChildren((($flutter_37.InlineSpan p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; }) as bool Function($flutter_37.InlineSpan));
      },
      'visitDirectChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'visitDirectChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitDirectChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitDirectChildren((($flutter_37.InlineSpan p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; }) as bool Function($flutter_37.InlineSpan));
      },
      'getSpanForPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'getSpanForPosition');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPosition');
        return t.getSpanForPosition(position);
      },
      'getSpanForPositionVisitor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 2, 'getSpanForPositionVisitor');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPositionVisitor');
        final offset = D4.getRequiredArg<$flutter_37.Accumulator>(positional, 1, 'offset', 'getSpanForPositionVisitor');
        return t.getSpanForPositionVisitor(position, offset);
      },
      'toPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        return t.toPlainText(includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
      },
      'getSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        return t.getSemanticsInformation();
      },
      'computeSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'computeSemanticsInformation');
        if (positional.isEmpty) {
          throw ArgumentError('computeSemanticsInformation: Missing required argument "collector" at position 0');
        }
        final collector = D4.coerceList<$flutter_37.InlineSpanSemanticsInformation>(positional[0], 'collector');
        t.computeSemanticsInformation(collector);
        return null;
      },
      'computeToPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'computeToPlainText');
        final buffer = D4.getRequiredArg<StringBuffer>(positional, 0, 'buffer', 'computeToPlainText');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        t.computeToPlainText(buffer, includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
        return null;
      },
      'codeUnitAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'codeUnitAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAt');
        return t.codeUnitAt(index);
      },
      'codeUnitAtVisitor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 2, 'codeUnitAtVisitor');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAtVisitor');
        final offset = D4.getRequiredArg<$flutter_37.Accumulator>(positional, 1, 'offset', 'codeUnitAtVisitor');
        return t.codeUnitAtVisitor(index, offset);
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        return t.debugAssertIsValid();
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_37.InlineSpan>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.PlaceholderSpan>(target, 'PlaceholderSpan');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'placeholderCodeUnit': (visitor) => $flutter_43.PlaceholderSpan.placeholderCodeUnit,
    },
    methodSignatures: {
      'build': 'void build(ParagraphBuilder builder, {TextScaler textScaler = TextScaler.noScaling, List<PlaceholderDimensions>? dimensions})',
      'visitChildren': 'bool visitChildren(InlineSpanVisitor visitor)',
      'visitDirectChildren': 'bool visitDirectChildren(InlineSpanVisitor visitor)',
      'getSpanForPosition': 'InlineSpan? getSpanForPosition(TextPosition position)',
      'getSpanForPositionVisitor': 'InlineSpan? getSpanForPositionVisitor(TextPosition position, Accumulator offset)',
      'toPlainText': 'String toPlainText({bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'getSemanticsInformation': 'List<InlineSpanSemanticsInformation> getSemanticsInformation()',
      'computeSemanticsInformation': 'void computeSemanticsInformation(List<InlineSpanSemanticsInformation> collector)',
      'computeToPlainText': 'void computeToPlainText(StringBuffer buffer, {bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'codeUnitAt': 'int? codeUnitAt(int index)',
      'codeUnitAtVisitor': 'int? codeUnitAtVisitor(int index, Accumulator offset)',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'compareTo': 'RenderComparison compareTo(InlineSpan other)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
    },
    getterSignatures: {
      'style': 'TextStyle? get style',
      'hashCode': 'int get hashCode',
      'alignment': 'PlaceholderAlignment get alignment',
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
    nativeType: $flutter_44.RoundedRectangleBorder,
    name: 'RoundedRectangleBorder',
    isAssignable: (v) => v is $flutter_44.RoundedRectangleBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final borderRadius = D4.getNamedArgWithDefault<$flutter_14.BorderRadiusGeometry>(named, 'borderRadius', $flutter_14.BorderRadius.zero);
        return $flutter_44.RoundedRectangleBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedRectangleBorder>(target, 'RoundedRectangleBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const RoundedRectangleBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry borderRadius = BorderRadius.zero})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'RoundedRectangleBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
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
    nativeType: $flutter_44.RoundedSuperellipseBorder,
    name: 'RoundedSuperellipseBorder',
    isAssignable: (v) => v is $flutter_44.RoundedSuperellipseBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadiusGeometry?>(named, 'borderRadius');
        return $flutter_44.RoundedSuperellipseBorder(side: side, borderRadius: borderRadius);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').side,
      'borderRadius': (visitor, target) => D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').borderRadius,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final borderRadius = D4.getOptionalNamedArg<$flutter_14.BorderRadiusGeometry?>(named, 'borderRadius');
        return t.copyWith(side: side, borderRadius: borderRadius);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.RoundedSuperellipseBorder>(target, 'RoundedSuperellipseBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const RoundedSuperellipseBorder({BorderSide side = BorderSide.none, BorderRadiusGeometry? borderRadius})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'RoundedSuperellipseBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius})',
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
    nativeType: $flutter_45.ShaderWarmUp,
    name: 'ShaderWarmUp',
    isAssignable: (v) => v is $flutter_45.ShaderWarmUp,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'size': (visitor, target) => D4.validateTarget<$flutter_45.ShaderWarmUp>(target, 'ShaderWarmUp').size,
    },
    methods: {
      'warmUpOnCanvas': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.ShaderWarmUp>(target, 'ShaderWarmUp');
        D4.requireMinArgs(positional, 1, 'warmUpOnCanvas');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'warmUpOnCanvas');
        return t.warmUpOnCanvas(canvas);
      },
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.ShaderWarmUp>(target, 'ShaderWarmUp');
        return t.execute();
      },
    },
    methodSignatures: {
      'warmUpOnCanvas': 'Future<void> warmUpOnCanvas(Canvas canvas)',
      'execute': 'Future<void> execute()',
    },
    getterSignatures: {
      'size': 'Size get size',
    },
  );
}

// =============================================================================
// ShapeDecoration Bridge
// =============================================================================

BridgedClass _createShapeDecorationBridge() {
  return BridgedClass(
    nativeType: $flutter_46.ShapeDecoration,
    name: 'ShapeDecoration',
    isAssignable: (v) => v is $flutter_46.ShapeDecoration,
    constructors: {
      '': (visitor, positional, named) {
        final color = D4.getOptionalNamedArg<Color?>(named, 'color');
        final image = D4.getOptionalNamedArg<$flutter_26.DecorationImage?>(named, 'image');
        final gradient = D4.getOptionalNamedArg<$flutter_31.Gradient?>(named, 'gradient');
        final shadows = D4.coerceListOrNull<$flutter_19.BoxShadow>(named['shadows'], 'shadows');
        final shape = D4.getRequiredNamedArg<$flutter_15.ShapeBorder>(named, 'shape', 'ShapeDecoration');
        return $flutter_46.ShapeDecoration(color: color, image: image, gradient: gradient, shadows: shadows, shape: shape);
      },
      'fromBoxDecoration': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ShapeDecoration');
        final source = D4.getRequiredArg<$flutter_17.BoxDecoration>(positional, 0, 'source', 'ShapeDecoration');
        return $flutter_46.ShapeDecoration.fromBoxDecoration(source);
      },
    },
    getters: {
      'padding': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').padding,
      'isComplex': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').isComplex,
      'color': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').color,
      'gradient': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').gradient,
      'image': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').image,
      'shadows': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').shadows,
      'shape': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').shape,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        return t.toStringShort();
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        return t.debugAssertIsValid();
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_25.Decoration?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.hitTest(size, position, textDirection: textDirection);
      },
      'createBoxPainter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        final onChangedRaw = positional.isNotEmpty ? positional[0] : null;
        return t.createBoxPainter(onChangedRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onChangedRaw, []); });
      },
      'getClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        D4.requireMinArgs(positional, 2, 'getClipPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getClipPath');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'getClipPath');
        return t.getClipPath(rect, textDirection);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ShapeDecoration>(target, 'ShapeDecoration');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_46.ShapeDecoration?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_46.ShapeDecoration?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_46.ShapeDecoration.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const ShapeDecoration({Color? color, DecorationImage? image, Gradient? gradient, List<BoxShadow>? shadows, required ShapeBorder shape})',
      'fromBoxDecoration': 'factory ShapeDecoration.fromBoxDecoration(BoxDecoration source)',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'lerpFrom': 'ShapeDecoration? lerpFrom(Decoration? a, double t)',
      'lerpTo': 'ShapeDecoration? lerpTo(Decoration? b, double t)',
      'hitTest': 'bool hitTest(Size size, Offset position, {TextDirection? textDirection})',
      'createBoxPainter': 'BoxPainter createBoxPainter([VoidCallback? onChanged])',
      'getClipPath': 'Path getClipPath(Rect rect, TextDirection textDirection)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_47.StadiumBorder,
    name: 'StadiumBorder',
    isAssignable: (v) => v is $flutter_47.StadiumBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        return $flutter_47.StadiumBorder(side: side);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder').side,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        return t.copyWith(side: side);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.StadiumBorder>(target, 'StadiumBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const StadiumBorder({BorderSide side = BorderSide.none})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'StadiumBorder copyWith({BorderSide? side})',
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
    nativeType: $flutter_48.StarBorder,
    name: 'StarBorder',
    isAssignable: (v) => v is $flutter_48.StarBorder,
    constructors: {
      '': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final points = D4.getNamedArgWithDefault<double>(named, 'points', 5);
        final innerRadiusRatio = D4.getNamedArgWithDefault<double>(named, 'innerRadiusRatio', 0.4);
        final pointRounding = D4.getNamedArgWithDefault<double>(named, 'pointRounding', 0);
        final valleyRounding = D4.getNamedArgWithDefault<double>(named, 'valleyRounding', 0);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0);
        final squash = D4.getNamedArgWithDefault<double>(named, 'squash', 0);
        return $flutter_48.StarBorder(side: side, points: points, innerRadiusRatio: innerRadiusRatio, pointRounding: pointRounding, valleyRounding: valleyRounding, rotation: rotation, squash: squash);
      },
      'polygon': (visitor, positional, named) {
        final side = D4.getNamedArgWithDefault<$flutter_15.BorderSide>(named, 'side', $flutter_15.BorderSide.none);
        final sides = D4.getNamedArgWithDefault<double>(named, 'sides', 5);
        final pointRounding = D4.getNamedArgWithDefault<double>(named, 'pointRounding', 0);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0);
        final squash = D4.getNamedArgWithDefault<double>(named, 'squash', 0);
        return $flutter_48.StarBorder.polygon(side: side, sides: sides, pointRounding: pointRounding, rotation: rotation, squash: squash);
      },
    },
    getters: {
      'dimensions': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').dimensions,
      'preferPaintInterior': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').preferPaintInterior,
      'side': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').side,
      'points': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').points,
      'pointRounding': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').pointRounding,
      'valleyRounding': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').valleyRounding,
      'squash': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').squash,
      'innerRadiusRatio': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').innerRadiusRatio,
      'rotation': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').rotation,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder').hashCode,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'add');
        final reversed = D4.getNamedArgWithDefault<bool>(named, 'reversed', false);
        return t.add(other, reversed: reversed);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 1, 'scale');
        final t_ = D4.getRequiredArg<double>(positional, 0, 't', 'scale');
        return t.scale(t_);
      },
      'lerpFrom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 2, 'lerpFrom');
        final a = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'a', 'lerpFrom');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpFrom');
        return t.lerpFrom(a, t_);
      },
      'lerpTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 2, 'lerpTo');
        final b = D4.getRequiredArg<$flutter_15.ShapeBorder?>(positional, 0, 'b', 'lerpTo');
        final t_ = D4.getRequiredArg<double>(positional, 1, 't', 'lerpTo');
        return t.lerpTo(b, t_);
      },
      'getOuterPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 1, 'getOuterPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getOuterPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getOuterPath(rect, textDirection: textDirection);
      },
      'getInnerPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 1, 'getInnerPath');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'getInnerPath');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return t.getInnerPath(rect, textDirection: textDirection);
      },
      'paintInterior': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 3, 'paintInterior');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paintInterior');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paintInterior');
        final paint = D4.getRequiredArg<Paint>(positional, 2, 'paint', 'paintInterior');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paintInterior(canvas, rect, paint, textDirection: textDirection);
        return null;
      },
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final rect = D4.getRequiredArg<Rect>(positional, 1, 'rect', 'paint');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.paint(canvas, rect, textDirection: textDirection);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        final side = D4.getOptionalNamedArg<$flutter_15.BorderSide?>(named, 'side');
        final points = D4.getOptionalNamedArg<double?>(named, 'points');
        final innerRadiusRatio = D4.getOptionalNamedArg<double?>(named, 'innerRadiusRatio');
        final pointRounding = D4.getOptionalNamedArg<double?>(named, 'pointRounding');
        final valleyRounding = D4.getOptionalNamedArg<double?>(named, 'valleyRounding');
        final rotation = D4.getOptionalNamedArg<double?>(named, 'rotation');
        final squash = D4.getOptionalNamedArg<double?>(named, 'squash');
        return t.copyWith(side: side, points: points, innerRadiusRatio: innerRadiusRatio, pointRounding: pointRounding, valleyRounding: valleyRounding, rotation: rotation, squash: squash);
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        final other = D4.getRequiredArg<$flutter_15.ShapeBorder>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.StarBorder>(target, 'StarBorder');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const StarBorder({BorderSide side = BorderSide.none, double points = 5, double innerRadiusRatio = 0.4, double pointRounding = 0, double valleyRounding = 0, double rotation = 0, double squash = 0})',
      'polygon': 'const StarBorder.polygon({BorderSide side = BorderSide.none, double sides = 5, double pointRounding = 0, double rotation = 0, double squash = 0})',
    },
    methodSignatures: {
      'add': 'ShapeBorder? add(ShapeBorder other, {bool reversed = false})',
      'scale': 'ShapeBorder scale(double t)',
      'lerpFrom': 'ShapeBorder? lerpFrom(ShapeBorder? a, double t)',
      'lerpTo': 'ShapeBorder? lerpTo(ShapeBorder? b, double t)',
      'getOuterPath': 'Path getOuterPath(Rect rect, {TextDirection? textDirection})',
      'getInnerPath': 'Path getInnerPath(Rect rect, {TextDirection? textDirection})',
      'paintInterior': 'void paintInterior(Canvas canvas, Rect rect, Paint paint, {TextDirection? textDirection})',
      'paint': 'void paint(Canvas canvas, Rect rect, {TextDirection? textDirection})',
      'toString': 'String toString()',
      'copyWith': 'StarBorder copyWith({BorderSide? side, double? points, double? innerRadiusRatio, double? pointRounding, double? valleyRounding, double? rotation, double? squash})',
    },
    getterSignatures: {
      'dimensions': 'EdgeInsetsGeometry get dimensions',
      'preferPaintInterior': 'bool get preferPaintInterior',
      'side': 'BorderSide get side',
      'points': 'double get points',
      'pointRounding': 'double get pointRounding',
      'valleyRounding': 'double get valleyRounding',
      'squash': 'double get squash',
      'innerRadiusRatio': 'double get innerRadiusRatio',
      'rotation': 'double get rotation',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// StrutStyle Bridge
// =============================================================================

BridgedClass _createStrutStyleBridge() {
  return BridgedClass(
    nativeType: $flutter_49.StrutStyle,
    name: 'StrutStyle',
    isAssignable: (v) => v is $flutter_49.StrutStyle,
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
        return $flutter_49.StrutStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSize: fontSize, height: height, leadingDistribution: leadingDistribution, leading: leading, fontWeight: fontWeight, fontStyle: fontStyle, forceStrutHeight: forceStrutHeight, debugLabel: debugLabel, package: package);
      },
      'fromTextStyle': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'StrutStyle');
        final textStyle = D4.getRequiredArg<$flutter_53.TextStyle>(positional, 0, 'textStyle', 'StrutStyle');
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
        return $flutter_49.StrutStyle.fromTextStyle(textStyle, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSize: fontSize, height: height, leadingDistribution: leadingDistribution, leading: leading, fontWeight: fontWeight, fontStyle: fontStyle, forceStrutHeight: forceStrutHeight, debugLabel: debugLabel, package: package);
      },
    },
    getters: {
      'fontFamily': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').fontFamily,
      'fontSize': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').fontSize,
      'height': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').height,
      'leadingDistribution': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').leadingDistribution,
      'fontWeight': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').fontWeight,
      'fontStyle': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').fontStyle,
      'leading': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').leading,
      'forceStrutHeight': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').forceStrutHeight,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').debugLabel,
      'fontFamilyFallback': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').fontFamilyFallback,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle').hashCode,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_49.StrutStyle>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'inheritFromTextStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        D4.requireMinArgs(positional, 1, 'inheritFromTextStyle');
        final other = D4.getRequiredArg<$flutter_53.TextStyle?>(positional, 0, 'other', 'inheritFromTextStyle');
        return t.inheritFromTextStyle(other);
      },
      'merge': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        D4.requireMinArgs(positional, 1, 'merge');
        final other = D4.getRequiredArg<$flutter_49.StrutStyle?>(positional, 0, 'other', 'merge');
        return t.merge(other);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        return t.toStringShort();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        final prefix = D4.getNamedArgWithDefault<String>(named, 'prefix', '');
        (t as dynamic).debugFillProperties(properties, prefix: prefix);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.StrutStyle>(target, 'StrutStyle');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'disabled': (visitor) => $flutter_49.StrutStyle.disabled,
    },
    constructorSignatures: {
      '': 'const StrutStyle({String? fontFamily, List<String>? fontFamilyFallback, double? fontSize, double? height, TextLeadingDistribution? leadingDistribution, double? leading, FontWeight? fontWeight, FontStyle? fontStyle, bool? forceStrutHeight, String? debugLabel, String? package})',
      'fromTextStyle': 'StrutStyle.fromTextStyle(TextStyle textStyle, {String? fontFamily, List<String>? fontFamilyFallback, double? fontSize, double? height, TextLeadingDistribution? leadingDistribution, double? leading, FontWeight? fontWeight, FontStyle? fontStyle, bool? forceStrutHeight, String? debugLabel, String? package})',
    },
    methodSignatures: {
      'compareTo': 'RenderComparison compareTo(StrutStyle other)',
      'inheritFromTextStyle': 'StrutStyle inheritFromTextStyle(TextStyle? other)',
      'merge': 'StrutStyle merge(StrutStyle? other)',
      'toStringShort': 'String toStringShort()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties, {String prefix = \'\'})',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'fontFamily': 'String? get fontFamily',
      'fontSize': 'double? get fontSize',
      'height': 'double? get height',
      'leadingDistribution': 'TextLeadingDistribution? get leadingDistribution',
      'fontWeight': 'FontWeight? get fontWeight',
      'fontStyle': 'FontStyle? get fontStyle',
      'leading': 'double? get leading',
      'forceStrutHeight': 'bool? get forceStrutHeight',
      'debugLabel': 'String? get debugLabel',
      'fontFamilyFallback': 'List<String>? get fontFamilyFallback',
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
    nativeType: $flutter_64.TextSelection,
    name: 'TextSelection',
    isAssignable: (v) => v is $flutter_64.TextSelection,
    constructors: {
      '': (visitor, positional, named) {
        final baseOffset = D4.getRequiredNamedArg<int>(named, 'baseOffset', 'TextSelection');
        final extentOffset = D4.getRequiredNamedArg<int>(named, 'extentOffset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        final isDirectional = D4.getNamedArgWithDefault<bool>(named, 'isDirectional', false);
        return $flutter_64.TextSelection(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'collapsed': (visitor, positional, named) {
        final offset = D4.getRequiredNamedArg<int>(named, 'offset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        return $flutter_64.TextSelection.collapsed(offset: offset, affinity: affinity);
      },
      'fromPosition': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextSelection');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'TextSelection');
        return $flutter_64.TextSelection.fromPosition(position);
      },
    },
    getters: {
      'baseOffset': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').baseOffset,
      'extentOffset': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').extentOffset,
      'affinity': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').affinity,
      'isDirectional': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').isDirectional,
      'base': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').base,
      'extent': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').extent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').end,
      'isValid': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').isValid,
      'isCollapsed': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').isCollapsed,
      'isNormalized': (visitor, target) => D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection').isNormalized,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        final baseOffset = D4.getOptionalNamedArg<int?>(named, 'baseOffset');
        final extentOffset = D4.getOptionalNamedArg<int?>(named, 'extentOffset');
        final affinity = D4.getOptionalNamedArg<TextAffinity?>(named, 'affinity');
        final isDirectional = D4.getOptionalNamedArg<bool?>(named, 'isDirectional');
        return t.copyWith(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'expandTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'expandTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'expandTo');
        final extentAtIndex = D4.getOptionalArgWithDefault<bool>(positional, 1, 'extentAtIndex', false);
        return t.expandTo(position, extentAtIndex);
      },
      'extendTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'extendTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'extendTo');
        return t.extendTo(position);
      },
      'textBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textBefore');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textBefore');
        return t.textBefore(text);
      },
      'textAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textAfter');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textAfter');
        return t.textAfter(text);
      },
      'textInside': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textInside');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textInside');
        return t.textInside(text);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_64.TextSelection>(target, 'TextSelection');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_50.PlaceholderDimensions,
    name: 'PlaceholderDimensions',
    isAssignable: (v) => v is $flutter_50.PlaceholderDimensions,
    constructors: {
      '': (visitor, positional, named) {
        final size = D4.getRequiredNamedArg<Size>(named, 'size', 'PlaceholderDimensions');
        final alignment = D4.getRequiredNamedArg<PlaceholderAlignment>(named, 'alignment', 'PlaceholderDimensions');
        final baseline = D4.getOptionalNamedArg<TextBaseline?>(named, 'baseline');
        final baselineOffset = D4.getOptionalNamedArg<double?>(named, 'baselineOffset');
        return $flutter_50.PlaceholderDimensions(size: size, alignment: alignment, baseline: baseline, baselineOffset: baselineOffset);
      },
    },
    getters: {
      'size': (visitor, target) => D4.validateTarget<$flutter_50.PlaceholderDimensions>(target, 'PlaceholderDimensions').size,
      'alignment': (visitor, target) => D4.validateTarget<$flutter_50.PlaceholderDimensions>(target, 'PlaceholderDimensions').alignment,
      'baselineOffset': (visitor, target) => D4.validateTarget<$flutter_50.PlaceholderDimensions>(target, 'PlaceholderDimensions').baselineOffset,
      'baseline': (visitor, target) => D4.validateTarget<$flutter_50.PlaceholderDimensions>(target, 'PlaceholderDimensions').baseline,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.PlaceholderDimensions>(target, 'PlaceholderDimensions').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.PlaceholderDimensions>(target, 'PlaceholderDimensions');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.PlaceholderDimensions>(target, 'PlaceholderDimensions');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'empty': (visitor) => $flutter_50.PlaceholderDimensions.empty,
    },
    constructorSignatures: {
      '': 'const PlaceholderDimensions({required Size size, required PlaceholderAlignment alignment, TextBaseline? baseline, double? baselineOffset})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'size': 'Size get size',
      'alignment': 'PlaceholderAlignment get alignment',
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
    nativeType: $flutter_50.WordBoundary,
    name: 'WordBoundary',
    isAssignable: (v) => v is $flutter_50.WordBoundary,
    constructors: {
    },
    getters: {
      'moveByWordBoundary': (visitor, target) => D4.validateTarget<$flutter_50.WordBoundary>(target, 'WordBoundary').moveByWordBoundary,
    },
    methods: {
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.WordBoundary>(target, 'WordBoundary');
        D4.requireMinArgs(positional, 1, 'getTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTextBoundaryAt');
        return t.getTextBoundaryAt(position);
      },
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.WordBoundary>(target, 'WordBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.WordBoundary>(target, 'WordBoundary');
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
    nativeType: $flutter_50.TextPainter,
    name: 'TextPainter',
    isAssignable: (v) => v is $flutter_50.TextPainter,
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getOptionalNamedArg<$flutter_37.InlineSpan?>(named, 'text');
        final textAlign = D4.getNamedArgWithDefault<TextAlign>(named, 'textAlign', $dart_ui.TextAlign.start);
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final strutStyle = D4.getOptionalNamedArg<$flutter_49.StrutStyle?>(named, 'strutStyle');
        final textWidthBasis = D4.getNamedArgWithDefault<$flutter_50.TextWidthBasis>(named, 'textWidthBasis', $flutter_50.TextWidthBasis.parent);
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        if (!named.containsKey('textScaler')) {
          return $flutter_50.TextPainter(text: text, textAlign: textAlign, textDirection: textDirection, textScaleFactor: textScaleFactor, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior);
        }
        if (named.containsKey('textScaler')) {
          final textScaler = D4.getRequiredNamedArg<$flutter_51.TextScaler>(named, 'textScaler', 'TextPainter');
          return $flutter_50.TextPainter(text: text, textAlign: textAlign, textDirection: textDirection, textScaleFactor: textScaleFactor, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, textScaler: textScaler);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugPaintTextLayoutBoxes': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').debugPaintTextLayoutBoxes,
      'text': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').text,
      'plainText': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').plainText,
      'textAlign': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textAlign,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textDirection,
      'textScaleFactor': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textScaleFactor,
      'textScaler': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textScaler,
      'ellipsis': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').ellipsis,
      'locale': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').locale,
      'maxLines': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').maxLines,
      'strutStyle': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').strutStyle,
      'textWidthBasis': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textWidthBasis,
      'textHeightBehavior': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textHeightBehavior,
      'inlinePlaceholderBoxes': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').inlinePlaceholderBoxes,
      'preferredLineHeight': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').preferredLineHeight,
      'minIntrinsicWidth': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').minIntrinsicWidth,
      'maxIntrinsicWidth': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').maxIntrinsicWidth,
      'width': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').width,
      'height': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').height,
      'size': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').size,
      'didExceedMaxLines': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').didExceedMaxLines,
      'wordBoundaries': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').wordBoundaries,
      'debugDisposed': (visitor, target) => D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').debugDisposed,
    },
    setters: {
      'debugPaintTextLayoutBoxes': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').debugPaintTextLayoutBoxes = D4.extractBridgedArg<bool>(value, 'debugPaintTextLayoutBoxes'),
      'text': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').text = D4.extractBridgedArgOrNull<$flutter_37.InlineSpan>(value, 'text'),
      'textAlign': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textAlign = D4.extractBridgedArg<TextAlign>(value, 'textAlign'),
      'textDirection': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textDirection = D4.extractBridgedArgOrNull<TextDirection>(value, 'textDirection'),
      'textScaleFactor': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textScaleFactor = D4.extractBridgedArg<double>(value, 'textScaleFactor'),
      'textScaler': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textScaler = D4.extractBridgedArg<$flutter_51.TextScaler>(value, 'textScaler'),
      'ellipsis': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').ellipsis = D4.extractBridgedArgOrNull<String>(value, 'ellipsis'),
      'locale': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').locale = D4.extractBridgedArgOrNull<Locale>(value, 'locale'),
      'maxLines': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').maxLines = D4.extractBridgedArgOrNull<int>(value, 'maxLines'),
      'strutStyle': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').strutStyle = D4.extractBridgedArgOrNull<$flutter_49.StrutStyle>(value, 'strutStyle'),
      'textWidthBasis': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textWidthBasis = D4.extractBridgedArg<$flutter_50.TextWidthBasis>(value, 'textWidthBasis'),
      'textHeightBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter').textHeightBehavior = D4.extractBridgedArgOrNull<TextHeightBehavior>(value, 'textHeightBehavior'),
    },
    methods: {
      'markNeedsLayout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        t.markNeedsLayout();
        return null;
      },
      'setPlaceholderDimensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'setPlaceholderDimensions');
        if (positional.isEmpty) {
          throw ArgumentError('setPlaceholderDimensions: Missing required argument "value" at position 0');
        }
        final value = D4.coerceListOrNull<$flutter_50.PlaceholderDimensions>(positional[0], 'value');
        t.setPlaceholderDimensions(value);
        return null;
      },
      'computeDistanceToActualBaseline': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'computeDistanceToActualBaseline');
        final baseline = D4.getRequiredArg<TextBaseline>(positional, 0, 'baseline', 'computeDistanceToActualBaseline');
        return t.computeDistanceToActualBaseline(baseline);
      },
      'layout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
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
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final offset = D4.getRequiredArg<Offset>(positional, 1, 'offset', 'paint');
        t.paint(canvas, offset);
        return null;
      },
      'getOffsetAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getOffsetAfter');
        final offset = D4.getRequiredArg<int>(positional, 0, 'offset', 'getOffsetAfter');
        return t.getOffsetAfter(offset);
      },
      'getOffsetBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getOffsetBefore');
        final offset = D4.getRequiredArg<int>(positional, 0, 'offset', 'getOffsetBefore');
        return t.getOffsetBefore(offset);
      },
      'getOffsetForCaret': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 2, 'getOffsetForCaret');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getOffsetForCaret');
        final caretPrototype = D4.getRequiredArg<Rect>(positional, 1, 'caretPrototype', 'getOffsetForCaret');
        return t.getOffsetForCaret(position, caretPrototype);
      },
      'getFullHeightForCaret': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 2, 'getFullHeightForCaret');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getFullHeightForCaret');
        final caretPrototype = D4.getRequiredArg<Rect>(positional, 1, 'caretPrototype', 'getFullHeightForCaret');
        return t.getFullHeightForCaret(position, caretPrototype);
      },
      'getBoxesForSelection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getBoxesForSelection');
        final selection = D4.getRequiredArg<$flutter_64.TextSelection>(positional, 0, 'selection', 'getBoxesForSelection');
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
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getClosestGlyphForOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'getClosestGlyphForOffset');
        return t.getClosestGlyphForOffset(offset);
      },
      'getPositionForOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getPositionForOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'getPositionForOffset');
        return t.getPositionForOffset(offset);
      },
      'getWordBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getWordBoundary');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getWordBoundary');
        return t.getWordBoundary(position);
      },
      'getLineBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        D4.requireMinArgs(positional, 1, 'getLineBoundary');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getLineBoundary');
        return t.getLineBoundary(position);
      },
      'computeLineMetrics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        return t.computeLineMetrics();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextPainter>(target, 'TextPainter');
        (t as dynamic).dispose();
        return null;
      },
    },
    staticMethods: {
      'computeWidth': (visitor, positional, named, typeArgs) {
        final text = D4.getRequiredNamedArg<$flutter_37.InlineSpan>(named, 'text', 'computeWidth');
        final textDirection = D4.getRequiredNamedArg<TextDirection>(named, 'textDirection', 'computeWidth');
        final textAlign = D4.getNamedArgWithDefault<TextAlign>(named, 'textAlign', $dart_ui.TextAlign.start);
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final textScaler = D4.getNamedArgWithDefault<$flutter_51.TextScaler>(named, 'textScaler', $flutter_51.TextScaler.noScaling);
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final strutStyle = D4.getOptionalNamedArg<$flutter_49.StrutStyle?>(named, 'strutStyle');
        final textWidthBasis = D4.getNamedArgWithDefault<$flutter_50.TextWidthBasis>(named, 'textWidthBasis', $flutter_50.TextWidthBasis.parent);
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        final minWidth = D4.getNamedArgWithDefault<double>(named, 'minWidth', 0.0);
        if (!named.containsKey('maxWidth')) {
          return $flutter_50.TextPainter.computeWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth);
        }
        if (named.containsKey('maxWidth')) {
          final maxWidth = D4.getRequiredNamedArg<double>(named, 'maxWidth', 'computeWidth');
          return $flutter_50.TextPainter.computeWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth, maxWidth: maxWidth);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'computeMaxIntrinsicWidth': (visitor, positional, named, typeArgs) {
        final text = D4.getRequiredNamedArg<$flutter_37.InlineSpan>(named, 'text', 'computeMaxIntrinsicWidth');
        final textDirection = D4.getRequiredNamedArg<TextDirection>(named, 'textDirection', 'computeMaxIntrinsicWidth');
        final textAlign = D4.getNamedArgWithDefault<TextAlign>(named, 'textAlign', $dart_ui.TextAlign.start);
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final textScaler = D4.getNamedArgWithDefault<$flutter_51.TextScaler>(named, 'textScaler', $flutter_51.TextScaler.noScaling);
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final strutStyle = D4.getOptionalNamedArg<$flutter_49.StrutStyle?>(named, 'strutStyle');
        final textWidthBasis = D4.getNamedArgWithDefault<$flutter_50.TextWidthBasis>(named, 'textWidthBasis', $flutter_50.TextWidthBasis.parent);
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        final minWidth = D4.getNamedArgWithDefault<double>(named, 'minWidth', 0.0);
        if (!named.containsKey('maxWidth')) {
          return $flutter_50.TextPainter.computeMaxIntrinsicWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth);
        }
        if (named.containsKey('maxWidth')) {
          final maxWidth = D4.getRequiredNamedArg<double>(named, 'maxWidth', 'computeMaxIntrinsicWidth');
          return $flutter_50.TextPainter.computeMaxIntrinsicWidth(text: text, textDirection: textDirection, textAlign: textAlign, textScaleFactor: textScaleFactor, textScaler: textScaler, maxLines: maxLines, ellipsis: ellipsis, locale: locale, strutStyle: strutStyle, textWidthBasis: textWidthBasis, textHeightBehavior: textHeightBehavior, minWidth: minWidth, maxWidth: maxWidth);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'isHighSurrogate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isHighSurrogate');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'isHighSurrogate');
        return $flutter_50.TextPainter.isHighSurrogate(value);
      },
      'isLowSurrogate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isLowSurrogate');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'isLowSurrogate');
        return $flutter_50.TextPainter.isLowSurrogate(value);
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
      'getBoxesForSelection': 'List<TextBox> getBoxesForSelection(TextSelection selection, {BoxHeightStyle boxHeightStyle = ui.BoxHeightStyle.tight, BoxWidthStyle boxWidthStyle = ui.BoxWidthStyle.tight})',
      'getClosestGlyphForOffset': 'GlyphInfo? getClosestGlyphForOffset(Offset offset)',
      'getPositionForOffset': 'TextPosition getPositionForOffset(Offset offset)',
      'getWordBoundary': 'TextRange getWordBoundary(TextPosition position)',
      'getLineBoundary': 'TextRange getLineBoundary(TextPosition position)',
      'computeLineMetrics': 'List<LineMetrics> computeLineMetrics()',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'debugPaintTextLayoutBoxes': 'bool get debugPaintTextLayoutBoxes',
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
      'wordBoundaries': 'WordBoundary get wordBoundaries',
      'debugDisposed': 'bool get debugDisposed',
    },
    setterSignatures: {
      'debugPaintTextLayoutBoxes': 'set debugPaintTextLayoutBoxes(dynamic value)',
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
    nativeType: $flutter_51.TextScaler,
    name: 'TextScaler',
    isAssignable: (v) => v is $flutter_51.TextScaler,
    isAbstract: true,
    constructors: {
      'linear': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextScaler');
        final textScaleFactor = D4.getRequiredArg<double>(positional, 0, 'textScaleFactor', 'TextScaler');
        return $flutter_51.TextScaler.linear(textScaleFactor);
      },
    },
    getters: {
      'textScaleFactor': (visitor, target) => D4.validateTarget<$flutter_51.TextScaler>(target, 'TextScaler').textScaleFactor,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextScaler>(target, 'TextScaler');
        D4.requireMinArgs(positional, 1, 'scale');
        final fontSize = D4.getRequiredArg<double>(positional, 0, 'fontSize', 'scale');
        return t.scale(fontSize);
      },
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextScaler>(target, 'TextScaler');
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
      'noScaling': (visitor) => $flutter_51.TextScaler.noScaling,
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
    nativeType: $flutter_52.TextSpan,
    name: 'TextSpan',
    isAssignable: (v) => v is $flutter_52.TextSpan,
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getOptionalNamedArg<String?>(named, 'text');
        final children = D4.coerceListOrNull<$flutter_37.InlineSpan>(named['children'], 'children');
        final style = D4.getOptionalNamedArg<$flutter_53.TextStyle?>(named, 'style');
        final recognizer = D4.getOptionalNamedArg<$flutter_9.GestureRecognizer?>(named, 'recognizer');
        final mouseCursor = D4.getOptionalNamedArg<$flutter_60.MouseCursor?>(named, 'mouseCursor');
        final onEnterRaw = named['onEnter'];
        final onExitRaw = named['onExit'];
        final semanticsLabel = D4.getOptionalNamedArg<String?>(named, 'semanticsLabel');
        final semanticsIdentifier = D4.getOptionalNamedArg<String?>(named, 'semanticsIdentifier');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final spellOut = D4.getOptionalNamedArg<bool?>(named, 'spellOut');
        return $flutter_52.TextSpan(text: text, children: children, style: style, recognizer: recognizer, mouseCursor: mouseCursor, onEnter: onEnterRaw == null ? null : ($flutter_7.PointerEnterEvent p0) { D4.callInterpreterCallback(visitor!, onEnterRaw, [p0]); }, onExit: onExitRaw == null ? null : ($flutter_7.PointerExitEvent p0) { D4.callInterpreterCallback(visitor!, onExitRaw, [p0]); }, semanticsLabel: semanticsLabel, semanticsIdentifier: semanticsIdentifier, locale: locale, spellOut: spellOut);
      },
    },
    getters: {
      'style': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').style,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').hashCode,
      'text': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').text,
      'children': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').children,
      'recognizer': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').recognizer,
      'mouseCursor': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').mouseCursor,
      'onEnter': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').onEnter,
      'onExit': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').onExit,
      'semanticsLabel': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').semanticsLabel,
      'semanticsIdentifier': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').semanticsIdentifier,
      'locale': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').locale,
      'spellOut': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').spellOut,
      'cursor': (visitor, target) => (D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan') as dynamic).cursor,
      'validForMouseTracker': (visitor, target) => D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan').validForMouseTracker,
    },
    methods: {
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'build');
        final builder = D4.getRequiredArg<ParagraphBuilder>(positional, 0, 'builder', 'build');
        final textScaler = D4.getNamedArgWithDefault<$flutter_51.TextScaler>(named, 'textScaler', $flutter_51.TextScaler.noScaling);
        final dimensions = D4.coerceListOrNull<$flutter_50.PlaceholderDimensions>(named['dimensions'], 'dimensions');
        (t as dynamic).build(builder, textScaler: textScaler, dimensions: dimensions);
        return null;
      },
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitChildren((($flutter_37.InlineSpan p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; }) as bool Function($flutter_37.InlineSpan));
      },
      'visitDirectChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'visitDirectChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitDirectChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        return t.visitDirectChildren((($flutter_37.InlineSpan p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; }) as bool Function($flutter_37.InlineSpan));
      },
      'getSpanForPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'getSpanForPosition');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPosition');
        return t.getSpanForPosition(position);
      },
      'getSpanForPositionVisitor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 2, 'getSpanForPositionVisitor');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getSpanForPositionVisitor');
        final offset = D4.getRequiredArg<$flutter_37.Accumulator>(positional, 1, 'offset', 'getSpanForPositionVisitor');
        return t.getSpanForPositionVisitor(position, offset);
      },
      'toPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        return t.toPlainText(includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
      },
      'getSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        return t.getSemanticsInformation();
      },
      'computeSemanticsInformation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'computeSemanticsInformation');
        if (positional.isEmpty) {
          throw ArgumentError('computeSemanticsInformation: Missing required argument "collector" at position 0');
        }
        final collector = D4.coerceList<$flutter_37.InlineSpanSemanticsInformation>(positional[0], 'collector');
        final inheritedLocale = D4.getOptionalNamedArg<Locale?>(named, 'inheritedLocale');
        final inheritedSpellOut = D4.getNamedArgWithDefault<bool>(named, 'inheritedSpellOut', false);
        t.computeSemanticsInformation(collector, inheritedLocale: inheritedLocale, inheritedSpellOut: inheritedSpellOut);
        return null;
      },
      'computeToPlainText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'computeToPlainText');
        final buffer = D4.getRequiredArg<StringBuffer>(positional, 0, 'buffer', 'computeToPlainText');
        final includeSemanticsLabels = D4.getNamedArgWithDefault<bool>(named, 'includeSemanticsLabels', true);
        final includePlaceholders = D4.getNamedArgWithDefault<bool>(named, 'includePlaceholders', true);
        t.computeToPlainText(buffer, includeSemanticsLabels: includeSemanticsLabels, includePlaceholders: includePlaceholders);
        return null;
      },
      'codeUnitAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'codeUnitAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAt');
        return t.codeUnitAt(index);
      },
      'codeUnitAtVisitor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 2, 'codeUnitAtVisitor');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'codeUnitAtVisitor');
        final offset = D4.getRequiredArg<$flutter_37.Accumulator>(positional, 1, 'offset', 'codeUnitAtVisitor');
        return t.codeUnitAtVisitor(index, offset);
      },
      'debugAssertIsValid': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        return t.debugAssertIsValid();
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_37.InlineSpan>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        D4.requireMinArgs(positional, 2, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_7.PointerEvent>(positional, 0, 'event', 'handleEvent');
        final entry = D4.getRequiredArg<$flutter_8.HitTestEntry<$flutter_8.HitTestTarget>>(positional, 1, 'entry', 'handleEvent');
        t.handleEvent(event, entry);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.TextSpan>(target, 'TextSpan');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const TextSpan({String? text, List<InlineSpan>? children, TextStyle? style, GestureRecognizer? recognizer, MouseCursor? mouseCursor, PointerEnterEventListener? onEnter, PointerExitEventListener? onExit, String? semanticsLabel, String? semanticsIdentifier, Locale? locale, bool? spellOut})',
    },
    methodSignatures: {
      'build': 'void build(ParagraphBuilder builder, {TextScaler textScaler = TextScaler.noScaling, List<PlaceholderDimensions>? dimensions})',
      'visitChildren': 'bool visitChildren(InlineSpanVisitor visitor)',
      'visitDirectChildren': 'bool visitDirectChildren(InlineSpanVisitor visitor)',
      'getSpanForPosition': 'InlineSpan? getSpanForPosition(TextPosition position)',
      'getSpanForPositionVisitor': 'InlineSpan? getSpanForPositionVisitor(TextPosition position, Accumulator offset)',
      'toPlainText': 'String toPlainText({bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'getSemanticsInformation': 'List<InlineSpanSemanticsInformation> getSemanticsInformation()',
      'computeSemanticsInformation': 'void computeSemanticsInformation(List<InlineSpanSemanticsInformation> collector, {Locale? inheritedLocale, bool inheritedSpellOut = false})',
      'computeToPlainText': 'void computeToPlainText(StringBuffer buffer, {bool includeSemanticsLabels = true, bool includePlaceholders = true})',
      'codeUnitAt': 'int? codeUnitAt(int index)',
      'codeUnitAtVisitor': 'int? codeUnitAtVisitor(int index, Accumulator offset)',
      'debugAssertIsValid': 'bool debugAssertIsValid()',
      'compareTo': 'RenderComparison compareTo(InlineSpan other)',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'handleEvent': 'void handleEvent(PointerEvent event, HitTestEntry<HitTestTarget> entry)',
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
      'locale': 'Locale? get locale',
      'spellOut': 'bool? get spellOut',
      'cursor': 'MouseCursor get cursor',
      'validForMouseTracker': 'bool get validForMouseTracker',
    },
  );
}

// =============================================================================
// TextStyle Bridge
// =============================================================================

BridgedClass _createTextStyleBridge() {
  return BridgedClass(
    nativeType: $flutter_53.TextStyle,
    name: 'TextStyle',
    isAssignable: (v) => v is $flutter_53.TextStyle,
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
        final overflow = D4.getOptionalNamedArg<$flutter_50.TextOverflow?>(named, 'overflow');
        return $flutter_53.TextStyle(inherit: inherit, color: color, backgroundColor: backgroundColor, fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle, letterSpacing: letterSpacing, wordSpacing: wordSpacing, textBaseline: textBaseline, height: height, leadingDistribution: leadingDistribution, locale: locale, foreground: foreground, background: background, shadows: shadows, fontFeatures: fontFeatures, fontVariations: fontVariations, decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle, decorationThickness: decorationThickness, debugLabel: debugLabel, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, package: package, overflow: overflow);
      },
    },
    getters: {
      'inherit': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').inherit,
      'color': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').color,
      'backgroundColor': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').backgroundColor,
      'fontFamily': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').fontFamily,
      'fontSize': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').fontSize,
      'fontWeight': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').fontWeight,
      'fontStyle': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').fontStyle,
      'letterSpacing': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').letterSpacing,
      'wordSpacing': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').wordSpacing,
      'textBaseline': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').textBaseline,
      'height': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').height,
      'leadingDistribution': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').leadingDistribution,
      'locale': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').locale,
      'foreground': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').foreground,
      'background': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').background,
      'decoration': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').decoration,
      'decorationColor': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').decorationColor,
      'decorationStyle': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').decorationStyle,
      'decorationThickness': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').decorationThickness,
      'debugLabel': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').debugLabel,
      'shadows': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').shadows,
      'fontFeatures': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').fontFeatures,
      'fontVariations': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').fontVariations,
      'overflow': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').overflow,
      'fontFamilyFallback': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').fontFamilyFallback,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
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
        final overflow = D4.getOptionalNamedArg<$flutter_50.TextOverflow?>(named, 'overflow');
        return t.copyWith(inherit: inherit, color: color, backgroundColor: backgroundColor, fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle, letterSpacing: letterSpacing, wordSpacing: wordSpacing, textBaseline: textBaseline, height: height, leadingDistribution: leadingDistribution, locale: locale, foreground: foreground, background: background, shadows: shadows, fontFeatures: fontFeatures, fontVariations: fontVariations, decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle, decorationThickness: decorationThickness, debugLabel: debugLabel, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, package: package, overflow: overflow);
      },
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
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
        final overflow = D4.getOptionalNamedArg<$flutter_50.TextOverflow?>(named, 'overflow');
        return t.apply(color: color, backgroundColor: backgroundColor, decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle, decorationThicknessFactor: decorationThicknessFactor, decorationThicknessDelta: decorationThicknessDelta, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSizeFactor: fontSizeFactor, fontSizeDelta: fontSizeDelta, fontWeightDelta: fontWeightDelta, fontStyle: fontStyle, letterSpacingFactor: letterSpacingFactor, letterSpacingDelta: letterSpacingDelta, wordSpacingFactor: wordSpacingFactor, wordSpacingDelta: wordSpacingDelta, heightFactor: heightFactor, heightDelta: heightDelta, textBaseline: textBaseline, leadingDistribution: leadingDistribution, locale: locale, shadows: shadows, fontFeatures: fontFeatures, fontVariations: fontVariations, package: package, overflow: overflow);
      },
      'merge': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        D4.requireMinArgs(positional, 1, 'merge');
        final other = D4.getRequiredArg<$flutter_53.TextStyle?>(positional, 0, 'other', 'merge');
        return t.merge(other);
      },
      'getTextStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        final textScaleFactor = D4.getNamedArgWithDefault<double>(named, 'textScaleFactor', 1.0);
        final textScaler = D4.getNamedArgWithDefault<$flutter_51.TextScaler>(named, 'textScaler', $flutter_51.TextScaler.noScaling);
        return t.getTextStyle(textScaleFactor: textScaleFactor, textScaler: textScaler);
      },
      'getParagraphStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        final textAlign = D4.getOptionalNamedArg<TextAlign?>(named, 'textAlign');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final textScaler = D4.getNamedArgWithDefault<$flutter_51.TextScaler>(named, 'textScaler', $flutter_51.TextScaler.noScaling);
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final textHeightBehavior = D4.getOptionalNamedArg<TextHeightBehavior?>(named, 'textHeightBehavior');
        final locale = D4.getOptionalNamedArg<Locale?>(named, 'locale');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final fontWeight = D4.getOptionalNamedArg<FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<FontStyle?>(named, 'fontStyle');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final strutStyle = D4.getOptionalNamedArg<$flutter_49.StrutStyle?>(named, 'strutStyle');
        return t.getParagraphStyle(textAlign: textAlign, textDirection: textDirection, textScaler: textScaler, ellipsis: ellipsis, maxLines: maxLines, textHeightBehavior: textHeightBehavior, locale: locale, fontFamily: fontFamily, fontSize: fontSize, fontWeight: fontWeight, fontStyle: fontStyle, height: height, strutStyle: strutStyle);
      },
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_53.TextStyle>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        return t.toStringShort();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_5.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        final prefix = D4.getNamedArgWithDefault<String>(named, 'prefix', '');
        (t as dynamic).debugFillProperties(properties, prefix: prefix);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_5.DiagnosticLevel>(named, 'minLevel', $flutter_5.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_5.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_53.TextStyle>(target, 'TextStyle');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$flutter_53.TextStyle?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$flutter_53.TextStyle?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $flutter_53.TextStyle.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const TextStyle({bool inherit = true, Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow})',
    },
    methodSignatures: {
      'copyWith': 'TextStyle copyWith({bool? inherit, Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow})',
      'apply': 'TextStyle apply({Color? color, Color? backgroundColor, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double decorationThicknessFactor = 1.0, double decorationThicknessDelta = 0.0, String? fontFamily, List<String>? fontFamilyFallback, double fontSizeFactor = 1.0, double fontSizeDelta = 0.0, int fontWeightDelta = 0, FontStyle? fontStyle, double letterSpacingFactor = 1.0, double letterSpacingDelta = 0.0, double wordSpacingFactor = 1.0, double wordSpacingDelta = 0.0, double heightFactor = 1.0, double heightDelta = 0.0, TextBaseline? textBaseline, TextLeadingDistribution? leadingDistribution, Locale? locale, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, String? package, TextOverflow? overflow})',
      'merge': 'TextStyle merge(TextStyle? other)',
      'getTextStyle': 'TextStyle getTextStyle({double textScaleFactor = 1.0, TextScaler textScaler = TextScaler.noScaling})',
      'getParagraphStyle': 'ParagraphStyle getParagraphStyle({TextAlign? textAlign, TextDirection? textDirection, TextScaler textScaler = TextScaler.noScaling, String? ellipsis, int? maxLines, TextHeightBehavior? textHeightBehavior, Locale? locale, String? fontFamily, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? height, StrutStyle? strutStyle})',
      'compareTo': 'RenderComparison compareTo(TextStyle other)',
      'toStringShort': 'String toStringShort()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties, {String prefix = \'\'})',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'inherit': 'bool get inherit',
      'color': 'Color? get color',
      'backgroundColor': 'Color? get backgroundColor',
      'fontFamily': 'String? get fontFamily',
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
      'fontFamilyFallback': 'List<String>? get fontFamilyFallback',
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
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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

