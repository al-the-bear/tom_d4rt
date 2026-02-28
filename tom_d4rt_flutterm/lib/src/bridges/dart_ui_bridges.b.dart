// D4rt Bridge - Generated file, do not edit
// Sources: 13 files
// Generated: 2026-02-28T15:10:47.987076

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as $dart_ui;
import 'dart:ui';


/// Bridge class for dart_ui module.
class DartUiBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createChannelBuffersBridge(),
      _createSceneBridge(),
      _createTransformEngineLayerBridge(),
      _createOffsetEngineLayerBridge(),
      _createClipRectEngineLayerBridge(),
      _createClipRRectEngineLayerBridge(),
      _createClipRSuperellipseEngineLayerBridge(),
      _createClipPathEngineLayerBridge(),
      _createOpacityEngineLayerBridge(),
      _createColorFilterEngineLayerBridge(),
      _createImageFilterEngineLayerBridge(),
      _createBackdropFilterEngineLayerBridge(),
      _createShaderMaskEngineLayerBridge(),
      _createSceneBuilderBridge(),
      _createOffsetBaseBridge(),
      _createOffsetBridge(),
      _createSizeBridge(),
      _createRectBridge(),
      _createRadiusBridge(),
      _createRRectBridge(),
      _createRSuperellipseBridge(),
      _createRSTransformBridge(),
      _createIsolateNameServerBridge(),
      _createKeyDataBridge(),
      _createDartPluginRegistrantBridge(),
      _createColorBridge(),
      _createPaintBridge(),
      _createImageBridge(),
      _createFrameInfoBridge(),
      _createCodecBridge(),
      _createTargetImageSizeBridge(),
      _createEngineLayerBridge(),
      _createPathBridge(),
      _createTangentBridge(),
      _createPathMetricsBridge(),
      _createPathMetricIteratorBridge(),
      _createPathMetricBridge(),
      _createMaskFilterBridge(),
      _createColorFilterBridge(),
      _createImageFilterBridge(),
      _createShaderBridge(),
      _createGradientBridge(),
      _createImageShaderBridge(),
      _createFragmentProgramBridge(),
      _createUniformFloatSlotBridge(),
      _createUniformVec2SlotBridge(),
      _createUniformVec3SlotBridge(),
      _createUniformVec4SlotBridge(),
      _createImageSamplerSlotBridge(),
      _createFragmentShaderBridge(),
      _createVerticesBridge(),
      _createCanvasBridge(),
      _createPictureBridge(),
      _createPictureRecorderBridge(),
      _createShadowBridge(),
      _createImmutableBufferBridge(),
      _createImageDescriptorBridge(),
      _createPictureRasterizationExceptionBridge(),
      _createRootIsolateTokenBridge(),
      _createPlatformDispatcherBridge(),
      _createSystemColorBridge(),
      _createSystemColorPaletteBridge(),
      _createFrameTimingBridge(),
      _createViewPaddingBridge(),
      _createViewConstraintsBridge(),
      _createDisplayFeatureBridge(),
      _createLocaleBridge(),
      _createSemanticsActionEventBridge(),
      _createViewFocusEventBridge(),
      _createCallbackHandleBridge(),
      _createPluginUtilitiesBridge(),
      _createPointerDataBridge(),
      _createPointerDataPacketBridge(),
      _createSemanticsActionBridge(),
      _createSemanticsFlagBridge(),
      _createSemanticsFlagsBridge(),
      _createStringAttributeBridge(),
      _createSpellOutStringAttributeBridge(),
      _createLocaleStringAttributeBridge(),
      _createSemanticsUpdateBuilderBridge(),
      _createSemanticsUpdateBridge(),
      _createFontWeightBridge(),
      _createFontFeatureBridge(),
      _createFontVariationBridge(),
      _createGlyphInfoBridge(),
      _createTextDecorationBridge(),
      _createTextHeightBehaviorBridge(),
      _createTextStyleBridge(),
      _createParagraphStyleBridge(),
      _createStrutStyleBridge(),
      _createTextBoxBridge(),
      _createTextPositionBridge(),
      _createTextRangeBridge(),
      _createParagraphConstraintsBridge(),
      _createLineMetricsBridge(),
      _createParagraphBridge(),
      _createParagraphBuilderBridge(),
      _createDisplayBridge(),
      _createFlutterViewBridge(),
      _createAccessibilityFeaturesBridge(),
      _createFrameDataBridge(),
      _createGestureSettingsBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'ChannelBuffers': 'dart:i',
      'Scene': 'dart:i',
      'TransformEngineLayer': 'dart:i',
      'OffsetEngineLayer': 'dart:i',
      'ClipRectEngineLayer': 'dart:i',
      'ClipRRectEngineLayer': 'dart:i',
      'ClipRSuperellipseEngineLayer': 'dart:i',
      'ClipPathEngineLayer': 'dart:i',
      'OpacityEngineLayer': 'dart:i',
      'ColorFilterEngineLayer': 'dart:i',
      'ImageFilterEngineLayer': 'dart:i',
      'BackdropFilterEngineLayer': 'dart:i',
      'ShaderMaskEngineLayer': 'dart:i',
      'SceneBuilder': 'dart:i',
      'OffsetBase': 'dart:i',
      'Offset': 'dart:i',
      'Size': 'dart:i',
      'Rect': 'dart:i',
      'Radius': 'dart:i',
      'RRect': 'dart:i',
      'RSuperellipse': 'dart:i',
      'RSTransform': 'dart:i',
      'IsolateNameServer': 'dart:i',
      'KeyData': 'dart:i',
      'DartPluginRegistrant': 'dart:i',
      'Color': 'dart:i',
      'Paint': 'dart:i',
      'Image': 'dart:i',
      'FrameInfo': 'dart:i',
      'Codec': 'dart:i',
      'TargetImageSize': 'dart:i',
      'EngineLayer': 'dart:i',
      'Path': 'dart:i',
      'Tangent': 'dart:i',
      'PathMetrics': 'dart:i',
      'PathMetricIterator': 'dart:i',
      'PathMetric': 'dart:i',
      'MaskFilter': 'dart:i',
      'ColorFilter': 'dart:i',
      'ImageFilter': 'dart:i',
      'Shader': 'dart:i',
      'Gradient': 'dart:i',
      'ImageShader': 'dart:i',
      'FragmentProgram': 'dart:i',
      'UniformFloatSlot': 'dart:i',
      'UniformVec2Slot': 'dart:i',
      'UniformVec3Slot': 'dart:i',
      'UniformVec4Slot': 'dart:i',
      'ImageSamplerSlot': 'dart:i',
      'FragmentShader': 'dart:i',
      'Vertices': 'dart:i',
      'Canvas': 'dart:i',
      'Picture': 'dart:i',
      'PictureRecorder': 'dart:i',
      'Shadow': 'dart:i',
      'ImmutableBuffer': 'dart:i',
      'ImageDescriptor': 'dart:i',
      'PictureRasterizationException': 'dart:i',
      'RootIsolateToken': 'dart:i',
      'PlatformDispatcher': 'dart:i',
      'SystemColor': 'dart:i',
      'SystemColorPalette': 'dart:i',
      'FrameTiming': 'dart:i',
      'ViewPadding': 'dart:i',
      'ViewConstraints': 'dart:i',
      'DisplayFeature': 'dart:i',
      'Locale': 'dart:i',
      'SemanticsActionEvent': 'dart:i',
      'ViewFocusEvent': 'dart:i',
      'CallbackHandle': 'dart:i',
      'PluginUtilities': 'dart:i',
      'PointerData': 'dart:i',
      'PointerDataPacket': 'dart:i',
      'SemanticsAction': 'dart:i',
      'SemanticsFlag': 'dart:i',
      'SemanticsFlags': 'dart:i',
      'StringAttribute': 'dart:i',
      'SpellOutStringAttribute': 'dart:i',
      'LocaleStringAttribute': 'dart:i',
      'SemanticsUpdateBuilder': 'dart:i',
      'SemanticsUpdate': 'dart:i',
      'FontWeight': 'dart:i',
      'FontFeature': 'dart:i',
      'FontVariation': 'dart:i',
      'GlyphInfo': 'dart:i',
      'TextDecoration': 'dart:i',
      'TextHeightBehavior': 'dart:i',
      'TextStyle': 'dart:i',
      'ParagraphStyle': 'dart:i',
      'StrutStyle': 'dart:i',
      'TextBox': 'dart:i',
      'TextPosition': 'dart:i',
      'TextRange': 'dart:i',
      'ParagraphConstraints': 'dart:i',
      'LineMetrics': 'dart:i',
      'Paragraph': 'dart:i',
      'ParagraphBuilder': 'dart:i',
      'Display': 'dart:i',
      'FlutterView': 'dart:i',
      'AccessibilityFeatures': 'dart:i',
      'FrameData': 'dart:i',
      'GestureSettings': 'dart:i',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$dart_ui.KeyEventType>(
        name: 'KeyEventType',
        values: $dart_ui.KeyEventType.values,
        getters: {
          'label': (visitor, target) => (target as $dart_ui.KeyEventType).label,
        },
      ),
      BridgedEnumDefinition<$dart_ui.KeyEventDeviceType>(
        name: 'KeyEventDeviceType',
        values: $dart_ui.KeyEventDeviceType.values,
        getters: {
          'label': (visitor, target) => (target as $dart_ui.KeyEventDeviceType).label,
        },
      ),
      BridgedEnumDefinition<$dart_ui.BlendMode>(
        name: 'BlendMode',
        values: $dart_ui.BlendMode.values,
      ),
      BridgedEnumDefinition<$dart_ui.FilterQuality>(
        name: 'FilterQuality',
        values: $dart_ui.FilterQuality.values,
      ),
      BridgedEnumDefinition<$dart_ui.StrokeCap>(
        name: 'StrokeCap',
        values: $dart_ui.StrokeCap.values,
      ),
      BridgedEnumDefinition<$dart_ui.StrokeJoin>(
        name: 'StrokeJoin',
        values: $dart_ui.StrokeJoin.values,
      ),
      BridgedEnumDefinition<$dart_ui.PaintingStyle>(
        name: 'PaintingStyle',
        values: $dart_ui.PaintingStyle.values,
      ),
      BridgedEnumDefinition<$dart_ui.Clip>(
        name: 'Clip',
        values: $dart_ui.Clip.values,
      ),
      BridgedEnumDefinition<$dart_ui.ColorSpace>(
        name: 'ColorSpace',
        values: $dart_ui.ColorSpace.values,
      ),
      BridgedEnumDefinition<$dart_ui.ImageByteFormat>(
        name: 'ImageByteFormat',
        values: $dart_ui.ImageByteFormat.values,
      ),
      BridgedEnumDefinition<$dart_ui.PixelFormat>(
        name: 'PixelFormat',
        values: $dart_ui.PixelFormat.values,
      ),
      BridgedEnumDefinition<$dart_ui.TargetPixelFormat>(
        name: 'TargetPixelFormat',
        values: $dart_ui.TargetPixelFormat.values,
      ),
      BridgedEnumDefinition<$dart_ui.PathFillType>(
        name: 'PathFillType',
        values: $dart_ui.PathFillType.values,
      ),
      BridgedEnumDefinition<$dart_ui.PathOperation>(
        name: 'PathOperation',
        values: $dart_ui.PathOperation.values,
      ),
      BridgedEnumDefinition<$dart_ui.BlurStyle>(
        name: 'BlurStyle',
        values: $dart_ui.BlurStyle.values,
      ),
      BridgedEnumDefinition<$dart_ui.TileMode>(
        name: 'TileMode',
        values: $dart_ui.TileMode.values,
      ),
      BridgedEnumDefinition<$dart_ui.VertexMode>(
        name: 'VertexMode',
        values: $dart_ui.VertexMode.values,
      ),
      BridgedEnumDefinition<$dart_ui.PointMode>(
        name: 'PointMode',
        values: $dart_ui.PointMode.values,
      ),
      BridgedEnumDefinition<$dart_ui.ClipOp>(
        name: 'ClipOp',
        values: $dart_ui.ClipOp.values,
      ),
      BridgedEnumDefinition<$dart_ui.FramePhase>(
        name: 'FramePhase',
        values: $dart_ui.FramePhase.values,
      ),
      BridgedEnumDefinition<AppLifecycleState>(
        name: 'AppLifecycleState',
        values: AppLifecycleState.values,
      ),
      BridgedEnumDefinition<AppExitResponse>(
        name: 'AppExitResponse',
        values: AppExitResponse.values,
      ),
      BridgedEnumDefinition<AppExitType>(
        name: 'AppExitType',
        values: AppExitType.values,
      ),
      BridgedEnumDefinition<$dart_ui.DisplayFeatureType>(
        name: 'DisplayFeatureType',
        values: $dart_ui.DisplayFeatureType.values,
      ),
      BridgedEnumDefinition<$dart_ui.DisplayFeatureState>(
        name: 'DisplayFeatureState',
        values: $dart_ui.DisplayFeatureState.values,
      ),
      BridgedEnumDefinition<$dart_ui.DartPerformanceMode>(
        name: 'DartPerformanceMode',
        values: $dart_ui.DartPerformanceMode.values,
      ),
      BridgedEnumDefinition<$dart_ui.ViewFocusState>(
        name: 'ViewFocusState',
        values: $dart_ui.ViewFocusState.values,
      ),
      BridgedEnumDefinition<$dart_ui.ViewFocusDirection>(
        name: 'ViewFocusDirection',
        values: $dart_ui.ViewFocusDirection.values,
      ),
      BridgedEnumDefinition<$dart_ui.PointerChange>(
        name: 'PointerChange',
        values: $dart_ui.PointerChange.values,
      ),
      BridgedEnumDefinition<$dart_ui.PointerDeviceKind>(
        name: 'PointerDeviceKind',
        values: $dart_ui.PointerDeviceKind.values,
      ),
      BridgedEnumDefinition<$dart_ui.PointerSignalKind>(
        name: 'PointerSignalKind',
        values: $dart_ui.PointerSignalKind.values,
      ),
      BridgedEnumDefinition<$dart_ui.SemanticsRole>(
        name: 'SemanticsRole',
        values: $dart_ui.SemanticsRole.values,
      ),
      BridgedEnumDefinition<$dart_ui.SemanticsInputType>(
        name: 'SemanticsInputType',
        values: $dart_ui.SemanticsInputType.values,
      ),
      BridgedEnumDefinition<$dart_ui.CheckedState>(
        name: 'CheckedState',
        values: $dart_ui.CheckedState.values,
        getters: {
          'value': (visitor, target) => (target as $dart_ui.CheckedState).value,
        },
        methods: {
          'hasConflict': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_ui.CheckedState;
            return Function.apply(t.hasConflict, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'merge': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_ui.CheckedState;
            return Function.apply(t.merge, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$dart_ui.Tristate>(
        name: 'Tristate',
        values: $dart_ui.Tristate.values,
        getters: {
          'value': (visitor, target) => (target as $dart_ui.Tristate).value,
        },
        methods: {
          'hasConflict': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_ui.Tristate;
            return Function.apply(t.hasConflict, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'merge': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_ui.Tristate;
            return Function.apply(t.merge, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'toBoolOrNull': (visitor, target, positional, named, typeArgs) {
            final t = target as $dart_ui.Tristate;
            return Function.apply(t.toBoolOrNull, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$dart_ui.SemanticsHitTestBehavior>(
        name: 'SemanticsHitTestBehavior',
        values: $dart_ui.SemanticsHitTestBehavior.values,
      ),
      BridgedEnumDefinition<$dart_ui.SemanticsValidationResult>(
        name: 'SemanticsValidationResult',
        values: $dart_ui.SemanticsValidationResult.values,
      ),
      BridgedEnumDefinition<$dart_ui.FontStyle>(
        name: 'FontStyle',
        values: $dart_ui.FontStyle.values,
      ),
      BridgedEnumDefinition<$dart_ui.TextAlign>(
        name: 'TextAlign',
        values: $dart_ui.TextAlign.values,
      ),
      BridgedEnumDefinition<$dart_ui.TextBaseline>(
        name: 'TextBaseline',
        values: $dart_ui.TextBaseline.values,
      ),
      BridgedEnumDefinition<$dart_ui.TextDecorationStyle>(
        name: 'TextDecorationStyle',
        values: $dart_ui.TextDecorationStyle.values,
      ),
      BridgedEnumDefinition<$dart_ui.TextLeadingDistribution>(
        name: 'TextLeadingDistribution',
        values: $dart_ui.TextLeadingDistribution.values,
      ),
      BridgedEnumDefinition<$dart_ui.TextDirection>(
        name: 'TextDirection',
        values: $dart_ui.TextDirection.values,
      ),
      BridgedEnumDefinition<$dart_ui.TextAffinity>(
        name: 'TextAffinity',
        values: $dart_ui.TextAffinity.values,
      ),
      BridgedEnumDefinition<$dart_ui.BoxHeightStyle>(
        name: 'BoxHeightStyle',
        values: $dart_ui.BoxHeightStyle.values,
      ),
      BridgedEnumDefinition<$dart_ui.BoxWidthStyle>(
        name: 'BoxWidthStyle',
        values: $dart_ui.BoxWidthStyle.values,
      ),
      BridgedEnumDefinition<$dart_ui.PlaceholderAlignment>(
        name: 'PlaceholderAlignment',
        values: $dart_ui.PlaceholderAlignment.values,
      ),
      BridgedEnumDefinition<$dart_ui.Brightness>(
        name: 'Brightness',
        values: $dart_ui.Brightness.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'KeyEventType': 'dart:i',
      'KeyEventDeviceType': 'dart:i',
      'BlendMode': 'dart:i',
      'FilterQuality': 'dart:i',
      'StrokeCap': 'dart:i',
      'StrokeJoin': 'dart:i',
      'PaintingStyle': 'dart:i',
      'Clip': 'dart:i',
      'ColorSpace': 'dart:i',
      'ImageByteFormat': 'dart:i',
      'PixelFormat': 'dart:i',
      'TargetPixelFormat': 'dart:i',
      'PathFillType': 'dart:i',
      'PathOperation': 'dart:i',
      'BlurStyle': 'dart:i',
      'TileMode': 'dart:i',
      'VertexMode': 'dart:i',
      'PointMode': 'dart:i',
      'ClipOp': 'dart:i',
      'FramePhase': 'dart:i',
      'AppLifecycleState': 'dart:i',
      'AppExitResponse': 'dart:i',
      'AppExitType': 'dart:i',
      'DisplayFeatureType': 'dart:i',
      'DisplayFeatureState': 'dart:i',
      'DartPerformanceMode': 'dart:i',
      'ViewFocusState': 'dart:i',
      'ViewFocusDirection': 'dart:i',
      'PointerChange': 'dart:i',
      'PointerDeviceKind': 'dart:i',
      'PointerSignalKind': 'dart:i',
      'SemanticsRole': 'dart:i',
      'SemanticsInputType': 'dart:i',
      'CheckedState': 'dart:i',
      'Tristate': 'dart:i',
      'SemanticsHitTestBehavior': 'dart:i',
      'SemanticsValidationResult': 'dart:i',
      'FontStyle': 'dart:i',
      'TextAlign': 'dart:i',
      'TextBaseline': 'dart:i',
      'TextDecorationStyle': 'dart:i',
      'TextLeadingDistribution': 'dart:i',
      'TextDirection': 'dart:i',
      'TextAffinity': 'dart:i',
      'BoxHeightStyle': 'dart:i',
      'BoxWidthStyle': 'dart:i',
      'PlaceholderAlignment': 'dart:i',
      'Brightness': 'dart:i',
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
      interpreter.registerGlobalVariable('keepToString', keepToString, importPath, sourceUri: 'dart:i');
    } catch (e) {
      errors.add('Failed to register variable "keepToString": $e');
    }
    try {
      interpreter.registerGlobalVariable('channelBuffers', channelBuffers, importPath, sourceUri: 'dart:i');
    } catch (e) {
      errors.add('Failed to register variable "channelBuffers": $e');
    }
    try {
      interpreter.registerGlobalVariable('isRunningOnPlatformThread', isRunningOnPlatformThread, importPath, sourceUri: 'dart:i');
    } catch (e) {
      errors.add('Failed to register variable "isRunningOnPlatformThread": $e');
    }
    try {
      interpreter.registerGlobalVariable('kTextHeightNone', kTextHeightNone, importPath, sourceUri: 'dart:i');
    } catch (e) {
      errors.add('Failed to register variable "kTextHeightNone": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (dart_ui):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'lerpDouble': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpDouble');
        final a = D4.getRequiredArg<num?>(positional, 0, 'a', 'lerpDouble');
        final b = D4.getRequiredArg<num?>(positional, 1, 'b', 'lerpDouble');
        final t = D4.getRequiredArg<double>(positional, 2, 't', 'lerpDouble');
        return lerpDouble(a, b, t);
      },
      'clampDouble': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'clampDouble');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'clampDouble');
        final min = D4.getRequiredArg<double>(positional, 1, 'min', 'clampDouble');
        final max = D4.getRequiredArg<double>(positional, 2, 'max', 'clampDouble');
        return clampDouble(x, min, max);
      },
      'instantiateImageCodec': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'instantiateImageCodec');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'instantiateImageCodec');
        final targetWidth = D4.getOptionalNamedArg<int?>(named, 'targetWidth');
        final targetHeight = D4.getOptionalNamedArg<int?>(named, 'targetHeight');
        final allowUpscaling = D4.getNamedArgWithDefault<bool>(named, 'allowUpscaling', true);
        return instantiateImageCodec(list, targetWidth: targetWidth, targetHeight: targetHeight, allowUpscaling: allowUpscaling);
      },
      'instantiateImageCodecFromBuffer': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'instantiateImageCodecFromBuffer');
        final buffer = D4.getRequiredArg<$dart_ui.ImmutableBuffer>(positional, 0, 'buffer', 'instantiateImageCodecFromBuffer');
        final targetWidth = D4.getOptionalNamedArg<int?>(named, 'targetWidth');
        final targetHeight = D4.getOptionalNamedArg<int?>(named, 'targetHeight');
        final allowUpscaling = D4.getNamedArgWithDefault<bool>(named, 'allowUpscaling', true);
        return instantiateImageCodecFromBuffer(buffer, targetWidth: targetWidth, targetHeight: targetHeight, allowUpscaling: allowUpscaling);
      },
      'instantiateImageCodecWithSize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'instantiateImageCodecWithSize');
        final buffer = D4.getRequiredArg<$dart_ui.ImmutableBuffer>(positional, 0, 'buffer', 'instantiateImageCodecWithSize');
        final getTargetSizeRaw = named['getTargetSize'];
        final getTargetSize = getTargetSizeRaw == null ? null : (int p0, int p1) { return D4.callInterpreterCallback(visitor, getTargetSizeRaw, [p0, p1]) as $dart_ui.TargetImageSize; };
        return instantiateImageCodecWithSize(buffer, getTargetSize: getTargetSize);
      },
      'decodeImageFromList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'decodeImageFromList');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'decodeImageFromList');
        if (positional.length <= 1) {
          throw ArgumentError('decodeImageFromList: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final callback = ($dart_ui.Image p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); };
        return decodeImageFromList(list, callback);
      },
      'decodeImageFromPixels': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 5, 'decodeImageFromPixels');
        final pixels = D4.getRequiredArg<Uint8List>(positional, 0, 'pixels', 'decodeImageFromPixels');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'decodeImageFromPixels');
        final height = D4.getRequiredArg<int>(positional, 2, 'height', 'decodeImageFromPixels');
        final format = D4.getRequiredArg<$dart_ui.PixelFormat>(positional, 3, 'format', 'decodeImageFromPixels');
        if (positional.length <= 4) {
          throw ArgumentError('decodeImageFromPixels: Missing required argument "callback" at position 4');
        }
        final callbackRaw = positional[4];
        final callback = ($dart_ui.Image p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); };
        final rowBytes = D4.getOptionalNamedArg<int?>(named, 'rowBytes');
        final targetWidth = D4.getOptionalNamedArg<int?>(named, 'targetWidth');
        final targetHeight = D4.getOptionalNamedArg<int?>(named, 'targetHeight');
        final allowUpscaling = D4.getNamedArgWithDefault<bool>(named, 'allowUpscaling', true);
        final targetFormat = D4.getNamedArgWithDefault<$dart_ui.TargetPixelFormat>(named, 'targetFormat', $dart_ui.TargetPixelFormat.dontCare);
        return decodeImageFromPixels(pixels, width, height, format, callback, rowBytes: rowBytes, targetWidth: targetWidth, targetHeight: targetHeight, allowUpscaling: allowUpscaling, targetFormat: targetFormat);
      },
      'decodeImageFromPixelsSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'decodeImageFromPixelsSync');
        final pixels = D4.getRequiredArg<Uint8List>(positional, 0, 'pixels', 'decodeImageFromPixelsSync');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'decodeImageFromPixelsSync');
        final height = D4.getRequiredArg<int>(positional, 2, 'height', 'decodeImageFromPixelsSync');
        final format = D4.getRequiredArg<$dart_ui.PixelFormat>(positional, 3, 'format', 'decodeImageFromPixelsSync');
        return decodeImageFromPixelsSync(pixels, width, height, format);
      },
      'runOnPlatformThread': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'runOnPlatformThread');
        if (positional.isEmpty) {
          throw ArgumentError('runOnPlatformThread: Missing required argument "computation" at position 0');
        }
        final computationRaw = positional[0];
        final computation = () { return D4.callInterpreterCallback(visitor, computationRaw, []) as FutureOr<Object>; };
        return runOnPlatformThread<dynamic>(computation);
      },
      'loadFontFromList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadFontFromList');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'loadFontFromList');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        return loadFontFromList(list, fontFamily: fontFamily);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'lerpDouble': 'dart:i',
      'clampDouble': 'dart:i',
      'instantiateImageCodec': 'dart:i',
      'instantiateImageCodecFromBuffer': 'dart:i',
      'instantiateImageCodecWithSize': 'dart:i',
      'decodeImageFromList': 'dart:i',
      'decodeImageFromPixels': 'dart:i',
      'decodeImageFromPixelsSync': 'dart:i',
      'runOnPlatformThread': 'dart:i',
      'loadFontFromList': 'dart:i',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'lerpDouble': 'double? lerpDouble(num? a, num? b, double t)',
      'clampDouble': 'double clampDouble(double x, double min, double max)',
      'instantiateImageCodec': 'Future<Codec> instantiateImageCodec(Uint8List list, {int? targetWidth, int? targetHeight, bool allowUpscaling = true})',
      'instantiateImageCodecFromBuffer': 'Future<Codec> instantiateImageCodecFromBuffer(ImmutableBuffer buffer, {int? targetWidth, int? targetHeight, bool allowUpscaling = true})',
      'instantiateImageCodecWithSize': 'Future<Codec> instantiateImageCodecWithSize(ImmutableBuffer buffer, {TargetImageSizeCallback? getTargetSize})',
      'decodeImageFromList': 'void decodeImageFromList(Uint8List list, ImageDecoderCallback callback)',
      'decodeImageFromPixels': 'void decodeImageFromPixels(Uint8List pixels, int width, int height, PixelFormat format, ImageDecoderCallback callback, {int? rowBytes, int? targetWidth, int? targetHeight, bool allowUpscaling = true, TargetPixelFormat targetFormat = TargetPixelFormat.dontCare})',
      'decodeImageFromPixelsSync': 'Image decodeImageFromPixelsSync(Uint8List pixels, int width, int height, PixelFormat format)',
      'runOnPlatformThread': 'Future<R> runOnPlatformThread(FutureOr<R> Function() computation)',
      'loadFontFromList': 'Future<void> loadFontFromList(Uint8List list, {String? fontFamily})',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'dart:i',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:flutter_material_bridges/dart:ui';";
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
    'KeyEventType',
    'KeyEventDeviceType',
    'BlendMode',
    'FilterQuality',
    'StrokeCap',
    'StrokeJoin',
    'PaintingStyle',
    'Clip',
    'ColorSpace',
    'ImageByteFormat',
    'PixelFormat',
    'TargetPixelFormat',
    'PathFillType',
    'PathOperation',
    'BlurStyle',
    'TileMode',
    'VertexMode',
    'PointMode',
    'ClipOp',
    'FramePhase',
    'AppLifecycleState',
    'AppExitResponse',
    'AppExitType',
    'DisplayFeatureType',
    'DisplayFeatureState',
    'DartPerformanceMode',
    'ViewFocusState',
    'ViewFocusDirection',
    'PointerChange',
    'PointerDeviceKind',
    'PointerSignalKind',
    'SemanticsRole',
    'SemanticsInputType',
    'CheckedState',
    'Tristate',
    'SemanticsHitTestBehavior',
    'SemanticsValidationResult',
    'FontStyle',
    'TextAlign',
    'TextBaseline',
    'TextDecorationStyle',
    'TextLeadingDistribution',
    'TextDirection',
    'TextAffinity',
    'BoxHeightStyle',
    'BoxWidthStyle',
    'PlaceholderAlignment',
    'Brightness',
  ];

}

// =============================================================================
// ChannelBuffers Bridge
// =============================================================================

BridgedClass _createChannelBuffersBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ChannelBuffers,
    name: 'ChannelBuffers',
    constructors: {
      '': (visitor, positional, named) {
        return $dart_ui.ChannelBuffers();
      },
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 3, 'push');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'push');
        final data = D4.getRequiredArg<ByteData?>(positional, 1, 'data', 'push');
        if (positional.length <= 2) {
          throw ArgumentError('push: Missing required argument "callback" at position 2');
        }
        final callbackRaw = positional[2];
        t.push(name, data, (ByteData? p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'setListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 2, 'setListener');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'setListener');
        if (positional.length <= 1) {
          throw ArgumentError('setListener: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.setListener(name, (ByteData? p0, void Function(ByteData?) p1) { D4.callInterpreterCallback(visitor, callbackRaw, [p0, p1]); });
        return null;
      },
      'clearListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 1, 'clearListener');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'clearListener');
        t.clearListener(name);
        return null;
      },
      'sendChannelUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 1, 'sendChannelUpdate');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'sendChannelUpdate');
        final listening = D4.getRequiredNamedArg<bool>(named, 'listening', 'sendChannelUpdate');
        t.sendChannelUpdate(name, listening: listening);
        return null;
      },
      'drain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 2, 'drain');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'drain');
        if (positional.length <= 1) {
          throw ArgumentError('drain: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        return t.drain(name, (ByteData? p0, void Function(ByteData?) p1) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0, p1]) as Future<void>; });
      },
      'handleMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 1, 'handleMessage');
        final data = D4.getRequiredArg<ByteData>(positional, 0, 'data', 'handleMessage');
        t.handleMessage(data);
        return null;
      },
      'resize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 2, 'resize');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'resize');
        final newSize = D4.getRequiredArg<int>(positional, 1, 'newSize', 'resize');
        t.resize(name, newSize);
        return null;
      },
      'allowOverflow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ChannelBuffers>(target, 'ChannelBuffers');
        D4.requireMinArgs(positional, 2, 'allowOverflow');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'allowOverflow');
        final allowed = D4.getRequiredArg<bool>(positional, 1, 'allowed', 'allowOverflow');
        t.allowOverflow(name, allowed);
        return null;
      },
    },
    staticGetters: {
      'kDefaultBufferSize': (visitor) => $dart_ui.ChannelBuffers.kDefaultBufferSize,
      'kControlChannelName': (visitor) => $dart_ui.ChannelBuffers.kControlChannelName,
    },
    constructorSignatures: {
      '': 'ChannelBuffers()',
    },
    methodSignatures: {
      'push': 'void push(String name, ByteData? data, PlatformMessageResponseCallback callback)',
      'setListener': 'void setListener(String name, ChannelCallback callback)',
      'clearListener': 'void clearListener(String name)',
      'sendChannelUpdate': 'void sendChannelUpdate(String name, {required bool listening})',
      'drain': 'Future<void> drain(String name, DrainChannelCallback callback)',
      'handleMessage': 'void handleMessage(ByteData data)',
      'resize': 'void resize(String name, int newSize)',
      'allowOverflow': 'void allowOverflow(String name, bool allowed)',
    },
    staticGetterSignatures: {
      'kDefaultBufferSize': 'int get kDefaultBufferSize',
      'kControlChannelName': 'String get kControlChannelName',
    },
  );
}

// =============================================================================
// Scene Bridge
// =============================================================================

BridgedClass _createSceneBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Scene,
    name: 'Scene',
    constructors: {
    },
    methods: {
      'toImageSync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Scene>(target, 'Scene');
        D4.requireMinArgs(positional, 2, 'toImageSync');
        final width = D4.getRequiredArg<int>(positional, 0, 'width', 'toImageSync');
        final height = D4.getRequiredArg<int>(positional, 1, 'height', 'toImageSync');
        return t.toImageSync(width, height);
      },
      'toImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Scene>(target, 'Scene');
        D4.requireMinArgs(positional, 2, 'toImage');
        final width = D4.getRequiredArg<int>(positional, 0, 'width', 'toImage');
        final height = D4.getRequiredArg<int>(positional, 1, 'height', 'toImage');
        return t.toImage(width, height);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Scene>(target, 'Scene');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'toImageSync': 'Image toImageSync(int width, int height)',
      'toImage': 'Future<Image> toImage(int width, int height)',
      'dispose': 'void dispose()',
    },
  );
}

// =============================================================================
// TransformEngineLayer Bridge
// =============================================================================

BridgedClass _createTransformEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TransformEngineLayer,
    name: 'TransformEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TransformEngineLayer>(target, 'TransformEngineLayer');
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
// OffsetEngineLayer Bridge
// =============================================================================

BridgedClass _createOffsetEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.OffsetEngineLayer,
    name: 'OffsetEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OffsetEngineLayer>(target, 'OffsetEngineLayer');
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
// ClipRectEngineLayer Bridge
// =============================================================================

BridgedClass _createClipRectEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ClipRectEngineLayer,
    name: 'ClipRectEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ClipRectEngineLayer>(target, 'ClipRectEngineLayer');
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
// ClipRRectEngineLayer Bridge
// =============================================================================

BridgedClass _createClipRRectEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ClipRRectEngineLayer,
    name: 'ClipRRectEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ClipRRectEngineLayer>(target, 'ClipRRectEngineLayer');
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
// ClipRSuperellipseEngineLayer Bridge
// =============================================================================

BridgedClass _createClipRSuperellipseEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ClipRSuperellipseEngineLayer,
    name: 'ClipRSuperellipseEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ClipRSuperellipseEngineLayer>(target, 'ClipRSuperellipseEngineLayer');
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
// ClipPathEngineLayer Bridge
// =============================================================================

BridgedClass _createClipPathEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ClipPathEngineLayer,
    name: 'ClipPathEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ClipPathEngineLayer>(target, 'ClipPathEngineLayer');
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
// OpacityEngineLayer Bridge
// =============================================================================

BridgedClass _createOpacityEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.OpacityEngineLayer,
    name: 'OpacityEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OpacityEngineLayer>(target, 'OpacityEngineLayer');
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
// ColorFilterEngineLayer Bridge
// =============================================================================

BridgedClass _createColorFilterEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ColorFilterEngineLayer,
    name: 'ColorFilterEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ColorFilterEngineLayer>(target, 'ColorFilterEngineLayer');
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
// ImageFilterEngineLayer Bridge
// =============================================================================

BridgedClass _createImageFilterEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ImageFilterEngineLayer,
    name: 'ImageFilterEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ImageFilterEngineLayer>(target, 'ImageFilterEngineLayer');
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
// BackdropFilterEngineLayer Bridge
// =============================================================================

BridgedClass _createBackdropFilterEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.BackdropFilterEngineLayer,
    name: 'BackdropFilterEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.BackdropFilterEngineLayer>(target, 'BackdropFilterEngineLayer');
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
// ShaderMaskEngineLayer Bridge
// =============================================================================

BridgedClass _createShaderMaskEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ShaderMaskEngineLayer,
    name: 'ShaderMaskEngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ShaderMaskEngineLayer>(target, 'ShaderMaskEngineLayer');
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
// SceneBuilder Bridge
// =============================================================================

BridgedClass _createSceneBuilderBridge() {
  return BridgedClass(
    nativeType: SceneBuilder,
    name: 'SceneBuilder',
    constructors: {
      '': (visitor, positional, named) {
        return SceneBuilder();
      },
    },
    methods: {
      'pushTransform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushTransform');
        final matrix4 = D4.getRequiredArg<Float64List>(positional, 0, 'matrix4', 'pushTransform');
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.TransformEngineLayer?>(named, 'oldLayer');
        return t.pushTransform(matrix4, oldLayer: oldLayer);
      },
      'pushOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 2, 'pushOffset');
        final dx = D4.getRequiredArg<double>(positional, 0, 'dx', 'pushOffset');
        final dy = D4.getRequiredArg<double>(positional, 1, 'dy', 'pushOffset');
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.OffsetEngineLayer?>(named, 'oldLayer');
        return t.pushOffset(dx, dy, oldLayer: oldLayer);
      },
      'pushClipRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushClipRect');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'pushClipRect');
        final clipBehavior = D4.getNamedArgWithDefault<$dart_ui.Clip>(named, 'clipBehavior', $dart_ui.Clip.antiAlias);
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.ClipRectEngineLayer?>(named, 'oldLayer');
        return t.pushClipRect(rect, clipBehavior: clipBehavior, oldLayer: oldLayer);
      },
      'pushClipRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushClipRRect');
        final rrect = D4.getRequiredArg<$dart_ui.RRect>(positional, 0, 'rrect', 'pushClipRRect');
        final clipBehavior = D4.getNamedArgWithDefault<$dart_ui.Clip>(named, 'clipBehavior', $dart_ui.Clip.antiAlias);
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.ClipRRectEngineLayer?>(named, 'oldLayer');
        return t.pushClipRRect(rrect, clipBehavior: clipBehavior, oldLayer: oldLayer);
      },
      'pushClipRSuperellipse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushClipRSuperellipse');
        final rsuperellipse = D4.getRequiredArg<$dart_ui.RSuperellipse>(positional, 0, 'rsuperellipse', 'pushClipRSuperellipse');
        final clipBehavior = D4.getNamedArgWithDefault<$dart_ui.Clip>(named, 'clipBehavior', $dart_ui.Clip.antiAlias);
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.ClipRSuperellipseEngineLayer?>(named, 'oldLayer');
        return t.pushClipRSuperellipse(rsuperellipse, clipBehavior: clipBehavior, oldLayer: oldLayer);
      },
      'pushClipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushClipPath');
        final path = D4.getRequiredArg<$dart_ui.Path>(positional, 0, 'path', 'pushClipPath');
        final clipBehavior = D4.getNamedArgWithDefault<$dart_ui.Clip>(named, 'clipBehavior', $dart_ui.Clip.antiAlias);
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.ClipPathEngineLayer?>(named, 'oldLayer');
        return t.pushClipPath(path, clipBehavior: clipBehavior, oldLayer: oldLayer);
      },
      'pushOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushOpacity');
        final alpha = D4.getRequiredArg<int>(positional, 0, 'alpha', 'pushOpacity');
        final offset = D4.getNamedArgWithDefault<$dart_ui.Offset?>(named, 'offset', $dart_ui.Offset.zero);
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.OpacityEngineLayer?>(named, 'oldLayer');
        return t.pushOpacity(alpha, offset: offset, oldLayer: oldLayer);
      },
      'pushColorFilter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushColorFilter');
        final filter = D4.getRequiredArg<$dart_ui.ColorFilter>(positional, 0, 'filter', 'pushColorFilter');
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.ColorFilterEngineLayer?>(named, 'oldLayer');
        return t.pushColorFilter(filter, oldLayer: oldLayer);
      },
      'pushImageFilter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushImageFilter');
        final filter = D4.getRequiredArg<$dart_ui.ImageFilter>(positional, 0, 'filter', 'pushImageFilter');
        final offset = D4.getNamedArgWithDefault<$dart_ui.Offset>(named, 'offset', $dart_ui.Offset.zero);
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.ImageFilterEngineLayer?>(named, 'oldLayer');
        return t.pushImageFilter(filter, offset: offset, oldLayer: oldLayer);
      },
      'pushBackdropFilter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'pushBackdropFilter');
        final filter = D4.getRequiredArg<$dart_ui.ImageFilter>(positional, 0, 'filter', 'pushBackdropFilter');
        final blendMode = D4.getNamedArgWithDefault<$dart_ui.BlendMode>(named, 'blendMode', $dart_ui.BlendMode.srcOver);
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.BackdropFilterEngineLayer?>(named, 'oldLayer');
        final backdropId = D4.getOptionalNamedArg<int?>(named, 'backdropId');
        return t.pushBackdropFilter(filter, blendMode: blendMode, oldLayer: oldLayer, backdropId: backdropId);
      },
      'pushShaderMask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 3, 'pushShaderMask');
        final shader = D4.getRequiredArg<$dart_ui.Shader>(positional, 0, 'shader', 'pushShaderMask');
        final maskRect = D4.getRequiredArg<$dart_ui.Rect>(positional, 1, 'maskRect', 'pushShaderMask');
        final blendMode = D4.getRequiredArg<$dart_ui.BlendMode>(positional, 2, 'blendMode', 'pushShaderMask');
        final oldLayer = D4.getOptionalNamedArg<$dart_ui.ShaderMaskEngineLayer?>(named, 'oldLayer');
        final filterQuality = D4.getNamedArgWithDefault<$dart_ui.FilterQuality>(named, 'filterQuality', $dart_ui.FilterQuality.low);
        return t.pushShaderMask(shader, maskRect, blendMode, oldLayer: oldLayer, filterQuality: filterQuality);
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        t.pop();
        return null;
      },
      'addRetained': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'addRetained');
        final retainedLayer = D4.getRequiredArg<$dart_ui.EngineLayer>(positional, 0, 'retainedLayer', 'addRetained');
        t.addRetained(retainedLayer);
        return null;
      },
      'addPerformanceOverlay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 2, 'addPerformanceOverlay');
        final enabledOptions = D4.getRequiredArg<int>(positional, 0, 'enabledOptions', 'addPerformanceOverlay');
        final bounds = D4.getRequiredArg<$dart_ui.Rect>(positional, 1, 'bounds', 'addPerformanceOverlay');
        t.addPerformanceOverlay(enabledOptions, bounds);
        return null;
      },
      'addPicture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 2, 'addPicture');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'addPicture');
        final picture = D4.getRequiredArg<$dart_ui.Picture>(positional, 1, 'picture', 'addPicture');
        final isComplexHint = D4.getNamedArgWithDefault<bool>(named, 'isComplexHint', false);
        final willChangeHint = D4.getNamedArgWithDefault<bool>(named, 'willChangeHint', false);
        t.addPicture(offset, picture, isComplexHint: isComplexHint, willChangeHint: willChangeHint);
        return null;
      },
      'addTexture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'addTexture');
        final textureId = D4.getRequiredArg<int>(positional, 0, 'textureId', 'addTexture');
        final offset = D4.getNamedArgWithDefault<$dart_ui.Offset>(named, 'offset', $dart_ui.Offset.zero);
        final width = D4.getNamedArgWithDefault<double>(named, 'width', 0.0);
        final height = D4.getNamedArgWithDefault<double>(named, 'height', 0.0);
        final freeze = D4.getNamedArgWithDefault<bool>(named, 'freeze', false);
        final filterQuality = D4.getNamedArgWithDefault<$dart_ui.FilterQuality>(named, 'filterQuality', $dart_ui.FilterQuality.low);
        t.addTexture(textureId, offset: offset, width: width, height: height, freeze: freeze, filterQuality: filterQuality);
        return null;
      },
      'addPlatformView': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        D4.requireMinArgs(positional, 1, 'addPlatformView');
        final viewId = D4.getRequiredArg<int>(positional, 0, 'viewId', 'addPlatformView');
        final offset = D4.getNamedArgWithDefault<$dart_ui.Offset>(named, 'offset', $dart_ui.Offset.zero);
        final width = D4.getNamedArgWithDefault<double>(named, 'width', 0.0);
        final height = D4.getNamedArgWithDefault<double>(named, 'height', 0.0);
        t.addPlatformView(viewId, offset: offset, width: width, height: height);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SceneBuilder>(target, 'SceneBuilder');
        return (t as dynamic).build();
      },
    },
    constructorSignatures: {
      '': 'factory SceneBuilder()',
    },
    methodSignatures: {
      'pushTransform': 'TransformEngineLayer pushTransform(Float64List matrix4, {TransformEngineLayer? oldLayer})',
      'pushOffset': 'OffsetEngineLayer pushOffset(double dx, double dy, {OffsetEngineLayer? oldLayer})',
      'pushClipRect': 'ClipRectEngineLayer pushClipRect(Rect rect, {Clip clipBehavior = Clip.antiAlias, ClipRectEngineLayer? oldLayer})',
      'pushClipRRect': 'ClipRRectEngineLayer pushClipRRect(RRect rrect, {Clip clipBehavior = Clip.antiAlias, ClipRRectEngineLayer? oldLayer})',
      'pushClipRSuperellipse': 'ClipRSuperellipseEngineLayer pushClipRSuperellipse(RSuperellipse rsuperellipse, {Clip clipBehavior = Clip.antiAlias, ClipRSuperellipseEngineLayer? oldLayer})',
      'pushClipPath': 'ClipPathEngineLayer pushClipPath(Path path, {Clip clipBehavior = Clip.antiAlias, ClipPathEngineLayer? oldLayer})',
      'pushOpacity': 'OpacityEngineLayer pushOpacity(int alpha, {Offset? offset = Offset.zero, OpacityEngineLayer? oldLayer})',
      'pushColorFilter': 'ColorFilterEngineLayer pushColorFilter(ColorFilter filter, {ColorFilterEngineLayer? oldLayer})',
      'pushImageFilter': 'ImageFilterEngineLayer pushImageFilter(ImageFilter filter, {Offset offset = Offset.zero, ImageFilterEngineLayer? oldLayer})',
      'pushBackdropFilter': 'BackdropFilterEngineLayer pushBackdropFilter(ImageFilter filter, {BlendMode blendMode = BlendMode.srcOver, BackdropFilterEngineLayer? oldLayer, int? backdropId})',
      'pushShaderMask': 'ShaderMaskEngineLayer pushShaderMask(Shader shader, Rect maskRect, BlendMode blendMode, {ShaderMaskEngineLayer? oldLayer, FilterQuality filterQuality = FilterQuality.low})',
      'pop': 'void pop()',
      'addRetained': 'void addRetained(EngineLayer retainedLayer)',
      'addPerformanceOverlay': 'void addPerformanceOverlay(int enabledOptions, Rect bounds)',
      'addPicture': 'void addPicture(Offset offset, Picture picture, {bool isComplexHint = false, bool willChangeHint = false})',
      'addTexture': 'void addTexture(int textureId, {Offset offset = Offset.zero, double width = 0.0, double height = 0.0, bool freeze = false, FilterQuality filterQuality = FilterQuality.low})',
      'addPlatformView': 'void addPlatformView(int viewId, {Offset offset = Offset.zero, double width = 0.0, double height = 0.0})',
      'build': 'Scene build()',
    },
  );
}

// =============================================================================
// OffsetBase Bridge
// =============================================================================

BridgedClass _createOffsetBaseBridge() {
  return BridgedClass(
    nativeType: $dart_ui.OffsetBase,
    name: 'OffsetBase',
    constructors: {
    },
    getters: {
      'isInfinite': (visitor, target) => D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase').isInfinite,
      'isFinite': (visitor, target) => D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase').isFinite,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase');
        return t.toString();
      },
      '<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator<');
        return t < other;
      },
      '<=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator<=');
        return t <= other;
      },
      '>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator>');
        return t > other;
      },
      '>=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator>=');
        return t >= other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.OffsetBase>(target, 'OffsetBase');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isInfinite': 'bool get isInfinite',
      'isFinite': 'bool get isFinite',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Offset Bridge
// =============================================================================

BridgedClass _createOffsetBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Offset,
    name: 'Offset',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Offset');
        final dx = D4.getRequiredArg<double>(positional, 0, 'dx', 'Offset');
        final dy = D4.getRequiredArg<double>(positional, 1, 'dy', 'Offset');
        return $dart_ui.Offset(dx, dy);
      },
      'fromDirection': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Offset');
        final direction = D4.getRequiredArg<double>(positional, 0, 'direction', 'Offset');
        final distance = D4.getOptionalArgWithDefault<double>(positional, 1, 'distance', 1.0);
        return $dart_ui.Offset.fromDirection(direction, distance);
      },
    },
    getters: {
      'isInfinite': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').isInfinite,
      'isFinite': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').isFinite,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').hashCode,
      'dx': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').dx,
      'dy': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').dy,
      'distance': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').distance,
      'distanceSquared': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').distanceSquared,
      'direction': (visitor, target) => D4.validateTarget<$dart_ui.Offset>(target, 'Offset').direction,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        return t.toString();
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        D4.requireMinArgs(positional, 2, 'scale');
        final scaleX = D4.getRequiredArg<double>(positional, 0, 'scaleX', 'scale');
        final scaleY = D4.getRequiredArg<double>(positional, 1, 'scaleY', 'scale');
        return t.scale(scaleX, scaleY);
      },
      'translate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        D4.requireMinArgs(positional, 2, 'translate');
        final translateX = D4.getRequiredArg<double>(positional, 0, 'translateX', 'translate');
        final translateY = D4.getRequiredArg<double>(positional, 1, 'translateY', 'translate');
        return t.translate(translateX, translateY);
      },
      '<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator<');
        return t < other;
      },
      '<=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator<=');
        return t <= other;
      },
      '>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator>');
        return t > other;
      },
      '>=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator>=');
        return t >= other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '&': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Offset>(target, 'Offset');
        final other = D4.getRequiredArg<$dart_ui.Size>(positional, 0, 'other', 'operator&');
        return t & other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $dart_ui.Offset.zero,
      'infinite': (visitor) => $dart_ui.Offset.infinite,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.Offset?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.Offset?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.Offset.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const Offset(double dx, double dy)',
      'fromDirection': 'factory Offset.fromDirection(double direction, [double distance = 1.0])',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'scale': 'Offset scale(double scaleX, double scaleY)',
      'translate': 'Offset translate(double translateX, double translateY)',
    },
    getterSignatures: {
      'isInfinite': 'bool get isInfinite',
      'isFinite': 'bool get isFinite',
      'hashCode': 'int get hashCode',
      'dx': 'double get dx',
      'dy': 'double get dy',
      'distance': 'double get distance',
      'distanceSquared': 'double get distanceSquared',
      'direction': 'double get direction',
    },
    staticMethodSignatures: {
      'lerp': 'Offset? lerp(Offset? a, Offset? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'Offset get zero',
      'infinite': 'Offset get infinite',
    },
  );
}

// =============================================================================
// Size Bridge
// =============================================================================

BridgedClass _createSizeBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Size,
    name: 'Size',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Size');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Size');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'Size');
        return $dart_ui.Size(width, height);
      },
      'copy': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Size');
        final source = D4.getRequiredArg<$dart_ui.Size>(positional, 0, 'source', 'Size');
        return $dart_ui.Size.copy(source);
      },
      'square': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Size');
        final dimension = D4.getRequiredArg<double>(positional, 0, 'dimension', 'Size');
        return $dart_ui.Size.square(dimension);
      },
      'fromWidth': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Size');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Size');
        return $dart_ui.Size.fromWidth(width);
      },
      'fromHeight': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Size');
        final height = D4.getRequiredArg<double>(positional, 0, 'height', 'Size');
        return $dart_ui.Size.fromHeight(height);
      },
      'fromRadius': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Size');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Size');
        return $dart_ui.Size.fromRadius(radius);
      },
    },
    getters: {
      'isInfinite': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').isInfinite,
      'isFinite': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').isFinite,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').hashCode,
      'width': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').height,
      'aspectRatio': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').aspectRatio,
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').isEmpty,
      'shortestSide': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').shortestSide,
      'longestSide': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').longestSide,
      'flipped': (visitor, target) => D4.validateTarget<$dart_ui.Size>(target, 'Size').flipped,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        return t.toString();
      },
      'topLeft': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'topLeft');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'topLeft');
        return t.topLeft(origin);
      },
      'topCenter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'topCenter');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'topCenter');
        return t.topCenter(origin);
      },
      'topRight': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'topRight');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'topRight');
        return t.topRight(origin);
      },
      'centerLeft': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'centerLeft');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'centerLeft');
        return t.centerLeft(origin);
      },
      'center': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'center');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'center');
        return t.center(origin);
      },
      'centerRight': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'centerRight');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'centerRight');
        return t.centerRight(origin);
      },
      'bottomLeft': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'bottomLeft');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'bottomLeft');
        return t.bottomLeft(origin);
      },
      'bottomCenter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'bottomCenter');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'bottomCenter');
        return t.bottomCenter(origin);
      },
      'bottomRight': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'bottomRight');
        final origin = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'origin', 'bottomRight');
        return t.bottomRight(origin);
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        D4.requireMinArgs(positional, 1, 'contains');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'contains');
        return t.contains(offset);
      },
      '<': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator<');
        return t < other;
      },
      '<=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator<=');
        return t <= other;
      },
      '>': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator>');
        return t > other;
      },
      '>=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator>=');
        return t >= other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<$dart_ui.OffsetBase>(positional, 0, 'other', 'operator-');
        return t - other;
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Size>(target, 'Size');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $dart_ui.Size.zero,
      'infinite': (visitor) => $dart_ui.Size.infinite,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.Size?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.Size?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.Size.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const Size(double width, double height)',
      'copy': 'Size.copy(Size source)',
      'square': 'const Size.square(double dimension)',
      'fromWidth': 'const Size.fromWidth(double width)',
      'fromHeight': 'const Size.fromHeight(double height)',
      'fromRadius': 'const Size.fromRadius(double radius)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'topLeft': 'Offset topLeft(Offset origin)',
      'topCenter': 'Offset topCenter(Offset origin)',
      'topRight': 'Offset topRight(Offset origin)',
      'centerLeft': 'Offset centerLeft(Offset origin)',
      'center': 'Offset center(Offset origin)',
      'centerRight': 'Offset centerRight(Offset origin)',
      'bottomLeft': 'Offset bottomLeft(Offset origin)',
      'bottomCenter': 'Offset bottomCenter(Offset origin)',
      'bottomRight': 'Offset bottomRight(Offset origin)',
      'contains': 'bool contains(Offset offset)',
    },
    getterSignatures: {
      'isInfinite': 'bool get isInfinite',
      'isFinite': 'bool get isFinite',
      'hashCode': 'int get hashCode',
      'width': 'double get width',
      'height': 'double get height',
      'aspectRatio': 'double get aspectRatio',
      'isEmpty': 'bool get isEmpty',
      'shortestSide': 'double get shortestSide',
      'longestSide': 'double get longestSide',
      'flipped': 'Size get flipped',
    },
    staticMethodSignatures: {
      'lerp': 'Size? lerp(Size? a, Size? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'Size get zero',
      'infinite': 'Size get infinite',
    },
  );
}

// =============================================================================
// Rect Bridge
// =============================================================================

BridgedClass _createRectBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Rect,
    name: 'Rect',
    constructors: {
      'fromLTRB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Rect');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'Rect');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'Rect');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'Rect');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'Rect');
        return $dart_ui.Rect.fromLTRB(left, top, right, bottom);
      },
      'fromLTWH': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Rect');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'Rect');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'Rect');
        final width = D4.getRequiredArg<double>(positional, 2, 'width', 'Rect');
        final height = D4.getRequiredArg<double>(positional, 3, 'height', 'Rect');
        return $dart_ui.Rect.fromLTWH(left, top, width, height);
      },
      'fromCircle': (visitor, positional, named) {
        final center = D4.getRequiredNamedArg<$dart_ui.Offset>(named, 'center', 'Rect');
        final radius = D4.getRequiredNamedArg<double>(named, 'radius', 'Rect');
        return $dart_ui.Rect.fromCircle(center: center, radius: radius);
      },
      'fromCenter': (visitor, positional, named) {
        final center = D4.getRequiredNamedArg<$dart_ui.Offset>(named, 'center', 'Rect');
        final width = D4.getRequiredNamedArg<double>(named, 'width', 'Rect');
        final height = D4.getRequiredNamedArg<double>(named, 'height', 'Rect');
        return $dart_ui.Rect.fromCenter(center: center, width: width, height: height);
      },
      'fromPoints': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Rect');
        final a = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'a', 'Rect');
        final b = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'b', 'Rect');
        return $dart_ui.Rect.fromPoints(a, b);
      },
    },
    getters: {
      'left': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').left,
      'top': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').top,
      'right': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').right,
      'bottom': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').bottom,
      'width': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').height,
      'size': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').size,
      'hasNaN': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').hasNaN,
      'isInfinite': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').isInfinite,
      'isFinite': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').isFinite,
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').isEmpty,
      'shortestSide': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').shortestSide,
      'longestSide': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').longestSide,
      'topLeft': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').topLeft,
      'topCenter': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').topCenter,
      'topRight': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').topRight,
      'centerLeft': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').centerLeft,
      'center': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').center,
      'centerRight': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').centerRight,
      'bottomLeft': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').bottomLeft,
      'bottomCenter': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').bottomCenter,
      'bottomRight': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').bottomRight,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.Rect>(target, 'Rect').hashCode,
    },
    methods: {
      'shift': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'shift');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'shift');
        return t.shift(offset);
      },
      'translate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 2, 'translate');
        final translateX = D4.getRequiredArg<double>(positional, 0, 'translateX', 'translate');
        final translateY = D4.getRequiredArg<double>(positional, 1, 'translateY', 'translate');
        return t.translate(translateX, translateY);
      },
      'inflate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'inflate');
        final delta = D4.getRequiredArg<double>(positional, 0, 'delta', 'inflate');
        return t.inflate(delta);
      },
      'deflate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'deflate');
        final delta = D4.getRequiredArg<double>(positional, 0, 'delta', 'deflate');
        return t.deflate(delta);
      },
      'intersect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'intersect');
        final other = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'other', 'intersect');
        return t.intersect(other);
      },
      'expandToInclude': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'expandToInclude');
        final other = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'other', 'expandToInclude');
        return t.expandToInclude(other);
      },
      'overlaps': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'overlaps');
        final other = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'other', 'overlaps');
        return t.overlaps(other);
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        D4.requireMinArgs(positional, 1, 'contains');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'contains');
        return t.contains(offset);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Rect>(target, 'Rect');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $dart_ui.Rect.zero,
      'largest': (visitor) => $dart_ui.Rect.largest,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.Rect?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.Rect?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.Rect.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromLTRB': 'const Rect.fromLTRB(double left, double top, double right, double bottom)',
      'fromLTWH': 'const Rect.fromLTWH(double left, double top, double width, double height)',
      'fromCircle': 'Rect.fromCircle({required Offset center, required double radius})',
      'fromCenter': 'Rect.fromCenter({required Offset center, required double width, required double height})',
      'fromPoints': 'Rect.fromPoints(Offset a, Offset b)',
    },
    methodSignatures: {
      'shift': 'Rect shift(Offset offset)',
      'translate': 'Rect translate(double translateX, double translateY)',
      'inflate': 'Rect inflate(double delta)',
      'deflate': 'Rect deflate(double delta)',
      'intersect': 'Rect intersect(Rect other)',
      'expandToInclude': 'Rect expandToInclude(Rect other)',
      'overlaps': 'bool overlaps(Rect other)',
      'contains': 'bool contains(Offset offset)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'left': 'double get left',
      'top': 'double get top',
      'right': 'double get right',
      'bottom': 'double get bottom',
      'width': 'double get width',
      'height': 'double get height',
      'size': 'Size get size',
      'hasNaN': 'bool get hasNaN',
      'isInfinite': 'bool get isInfinite',
      'isFinite': 'bool get isFinite',
      'isEmpty': 'bool get isEmpty',
      'shortestSide': 'double get shortestSide',
      'longestSide': 'double get longestSide',
      'topLeft': 'Offset get topLeft',
      'topCenter': 'Offset get topCenter',
      'topRight': 'Offset get topRight',
      'centerLeft': 'Offset get centerLeft',
      'center': 'Offset get center',
      'centerRight': 'Offset get centerRight',
      'bottomLeft': 'Offset get bottomLeft',
      'bottomCenter': 'Offset get bottomCenter',
      'bottomRight': 'Offset get bottomRight',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'Rect? lerp(Rect? a, Rect? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'Rect get zero',
      'largest': 'Rect get largest',
    },
  );
}

// =============================================================================
// Radius Bridge
// =============================================================================

BridgedClass _createRadiusBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Radius,
    name: 'Radius',
    constructors: {
      'circular': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Radius');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Radius');
        return $dart_ui.Radius.circular(radius);
      },
      'elliptical': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Radius');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Radius');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Radius');
        return $dart_ui.Radius.elliptical(x, y);
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$dart_ui.Radius>(target, 'Radius').x,
      'y': (visitor, target) => D4.validateTarget<$dart_ui.Radius>(target, 'Radius').y,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.Radius>(target, 'Radius').hashCode,
    },
    methods: {
      'clamp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final minimum = D4.getOptionalNamedArg<$dart_ui.Radius?>(named, 'minimum');
        final maximum = D4.getOptionalNamedArg<$dart_ui.Radius?>(named, 'maximum');
        return t.clamp(minimum: minimum, maximum: maximum);
      },
      'clampValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final minimumX = D4.getOptionalNamedArg<double?>(named, 'minimumX');
        final minimumY = D4.getOptionalNamedArg<double?>(named, 'minimumY');
        final maximumX = D4.getOptionalNamedArg<double?>(named, 'maximumX');
        final maximumY = D4.getOptionalNamedArg<double?>(named, 'maximumY');
        return t.clampValues(minimumX: minimumX, minimumY: minimumY, maximumX: maximumX, maximumY: maximumY);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$dart_ui.Radius>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final other = D4.getRequiredArg<$dart_ui.Radius>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '~/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator~/');
        return t ~/ other;
      },
      '%': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator%');
        return t % other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Radius>(target, 'Radius');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $dart_ui.Radius.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.Radius?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.Radius?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.Radius.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'circular': 'const Radius.circular(double radius)',
      'elliptical': 'const Radius.elliptical(double x, double y)',
    },
    methodSignatures: {
      'clamp': 'Radius clamp({Radius? minimum, Radius? maximum})',
      'clampValues': 'Radius clampValues({double? minimumX, double? minimumY, double? maximumX, double? maximumY})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'Radius? lerp(Radius? a, Radius? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'Radius get zero',
    },
  );
}

// =============================================================================
// RRect Bridge
// =============================================================================

BridgedClass _createRRectBridge() {
  return BridgedClass(
    nativeType: $dart_ui.RRect,
    name: 'RRect',
    constructors: {
      'fromLTRBXY': (visitor, positional, named) {
        D4.requireMinArgs(positional, 6, 'RRect');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'RRect');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'RRect');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'RRect');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'RRect');
        final radiusX = D4.getRequiredArg<double>(positional, 4, 'radiusX', 'RRect');
        final radiusY = D4.getRequiredArg<double>(positional, 5, 'radiusY', 'RRect');
        return $dart_ui.RRect.fromLTRBXY(left, top, right, bottom, radiusX, radiusY);
      },
      'fromLTRBR': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'RRect');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'RRect');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'RRect');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'RRect');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'RRect');
        final radius = D4.getRequiredArg<$dart_ui.Radius>(positional, 4, 'radius', 'RRect');
        return $dart_ui.RRect.fromLTRBR(left, top, right, bottom, radius);
      },
      'fromRectXY': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'RRect');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'RRect');
        final radiusX = D4.getRequiredArg<double>(positional, 1, 'radiusX', 'RRect');
        final radiusY = D4.getRequiredArg<double>(positional, 2, 'radiusY', 'RRect');
        return $dart_ui.RRect.fromRectXY(rect, radiusX, radiusY);
      },
      'fromRectAndRadius': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'RRect');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'RRect');
        final radius = D4.getRequiredArg<$dart_ui.Radius>(positional, 1, 'radius', 'RRect');
        return $dart_ui.RRect.fromRectAndRadius(rect, radius);
      },
      'fromLTRBAndCorners': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'RRect');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'RRect');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'RRect');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'RRect');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'RRect');
        final topLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topLeft', $dart_ui.Radius.zero);
        final topRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topRight', $dart_ui.Radius.zero);
        final bottomRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomRight', $dart_ui.Radius.zero);
        final bottomLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomLeft', $dart_ui.Radius.zero);
        return $dart_ui.RRect.fromLTRBAndCorners(left, top, right, bottom, topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft);
      },
      'fromRectAndCorners': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RRect');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'RRect');
        final topLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topLeft', $dart_ui.Radius.zero);
        final topRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topRight', $dart_ui.Radius.zero);
        final bottomRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomRight', $dart_ui.Radius.zero);
        final bottomLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomLeft', $dart_ui.Radius.zero);
        return $dart_ui.RRect.fromRectAndCorners(rect, topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft);
      },
    },
    getters: {
      'left': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').left,
      'top': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').top,
      'right': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').right,
      'bottom': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').bottom,
      'tlRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').tlRadiusX,
      'tlRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').tlRadiusY,
      'tlRadius': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').tlRadius,
      'trRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').trRadiusX,
      'trRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').trRadiusY,
      'trRadius': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').trRadius,
      'brRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').brRadiusX,
      'brRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').brRadiusY,
      'brRadius': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').brRadius,
      'blRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').blRadiusX,
      'blRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').blRadiusY,
      'blRadius': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').blRadius,
      'width': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').height,
      'outerRect': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').outerRect,
      'safeInnerRect': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').safeInnerRect,
      'middleRect': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').middleRect,
      'wideMiddleRect': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').wideMiddleRect,
      'tallMiddleRect': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').tallMiddleRect,
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').isEmpty,
      'isFinite': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').isFinite,
      'isRect': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').isRect,
      'isStadium': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').isStadium,
      'isEllipse': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').isEllipse,
      'isCircle': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').isCircle,
      'shortestSide': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').shortestSide,
      'longestSide': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').longestSide,
      'hasNaN': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').hasNaN,
      'center': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').center,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.RRect>(target, 'RRect').hashCode,
    },
    methods: {
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RRect>(target, 'RRect');
        D4.requireMinArgs(positional, 1, 'contains');
        final point = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'point', 'contains');
        return t.contains(point);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RRect>(target, 'RRect');
        return t.toString();
      },
      'shift': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RRect>(target, 'RRect');
        D4.requireMinArgs(positional, 1, 'shift');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'shift');
        return t.shift(offset);
      },
      'inflate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RRect>(target, 'RRect');
        D4.requireMinArgs(positional, 1, 'inflate');
        final delta = D4.getRequiredArg<double>(positional, 0, 'delta', 'inflate');
        return t.inflate(delta);
      },
      'deflate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RRect>(target, 'RRect');
        D4.requireMinArgs(positional, 1, 'deflate');
        final delta = D4.getRequiredArg<double>(positional, 0, 'delta', 'deflate');
        return t.deflate(delta);
      },
      'scaleRadii': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RRect>(target, 'RRect');
        return t.scaleRadii();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RRect>(target, 'RRect');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $dart_ui.RRect.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.RRect?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.RRect?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.RRect.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromLTRBXY': 'const RRect.fromLTRBXY(double left, double top, double right, double bottom, double radiusX, double radiusY)',
      'fromLTRBR': 'RRect.fromLTRBR(double left, double top, double right, double bottom, Radius radius)',
      'fromRectXY': 'RRect.fromRectXY(Rect rect, double radiusX, double radiusY)',
      'fromRectAndRadius': 'RRect.fromRectAndRadius(Rect rect, Radius radius)',
      'fromLTRBAndCorners': 'RRect.fromLTRBAndCorners(double left, double top, double right, double bottom, {Radius topLeft = Radius.zero, Radius topRight = Radius.zero, Radius bottomRight = Radius.zero, Radius bottomLeft = Radius.zero})',
      'fromRectAndCorners': 'RRect.fromRectAndCorners(Rect rect, {Radius topLeft = Radius.zero, Radius topRight = Radius.zero, Radius bottomRight = Radius.zero, Radius bottomLeft = Radius.zero})',
    },
    methodSignatures: {
      'contains': 'bool contains(Offset point)',
      'toString': 'String toString()',
      'shift': 'RRect shift(Offset offset)',
      'inflate': 'RRect inflate(double delta)',
      'deflate': 'RRect deflate(double delta)',
      'scaleRadii': 'RRect scaleRadii()',
    },
    getterSignatures: {
      'left': 'double get left',
      'top': 'double get top',
      'right': 'double get right',
      'bottom': 'double get bottom',
      'tlRadiusX': 'double get tlRadiusX',
      'tlRadiusY': 'double get tlRadiusY',
      'tlRadius': 'Radius get tlRadius',
      'trRadiusX': 'double get trRadiusX',
      'trRadiusY': 'double get trRadiusY',
      'trRadius': 'Radius get trRadius',
      'brRadiusX': 'double get brRadiusX',
      'brRadiusY': 'double get brRadiusY',
      'brRadius': 'Radius get brRadius',
      'blRadiusX': 'double get blRadiusX',
      'blRadiusY': 'double get blRadiusY',
      'blRadius': 'Radius get blRadius',
      'width': 'double get width',
      'height': 'double get height',
      'outerRect': 'Rect get outerRect',
      'safeInnerRect': 'Rect get safeInnerRect',
      'middleRect': 'Rect get middleRect',
      'wideMiddleRect': 'Rect get wideMiddleRect',
      'tallMiddleRect': 'Rect get tallMiddleRect',
      'isEmpty': 'bool get isEmpty',
      'isFinite': 'bool get isFinite',
      'isRect': 'bool get isRect',
      'isStadium': 'bool get isStadium',
      'isEllipse': 'bool get isEllipse',
      'isCircle': 'bool get isCircle',
      'shortestSide': 'double get shortestSide',
      'longestSide': 'double get longestSide',
      'hasNaN': 'bool get hasNaN',
      'center': 'Offset get center',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'RRect? lerp(RRect? a, RRect? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'RRect get zero',
    },
  );
}

// =============================================================================
// RSuperellipse Bridge
// =============================================================================

BridgedClass _createRSuperellipseBridge() {
  return BridgedClass(
    nativeType: $dart_ui.RSuperellipse,
    name: 'RSuperellipse',
    constructors: {
      'fromLTRBXY': (visitor, positional, named) {
        D4.requireMinArgs(positional, 6, 'RSuperellipse');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'RSuperellipse');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'RSuperellipse');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'RSuperellipse');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'RSuperellipse');
        final radiusX = D4.getRequiredArg<double>(positional, 4, 'radiusX', 'RSuperellipse');
        final radiusY = D4.getRequiredArg<double>(positional, 5, 'radiusY', 'RSuperellipse');
        return $dart_ui.RSuperellipse.fromLTRBXY(left, top, right, bottom, radiusX, radiusY);
      },
      'fromLTRBR': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'RSuperellipse');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'RSuperellipse');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'RSuperellipse');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'RSuperellipse');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'RSuperellipse');
        final radius = D4.getRequiredArg<$dart_ui.Radius>(positional, 4, 'radius', 'RSuperellipse');
        return $dart_ui.RSuperellipse.fromLTRBR(left, top, right, bottom, radius);
      },
      'fromRectXY': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'RSuperellipse');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'RSuperellipse');
        final radiusX = D4.getRequiredArg<double>(positional, 1, 'radiusX', 'RSuperellipse');
        final radiusY = D4.getRequiredArg<double>(positional, 2, 'radiusY', 'RSuperellipse');
        return $dart_ui.RSuperellipse.fromRectXY(rect, radiusX, radiusY);
      },
      'fromRectAndRadius': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'RSuperellipse');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'RSuperellipse');
        final radius = D4.getRequiredArg<$dart_ui.Radius>(positional, 1, 'radius', 'RSuperellipse');
        return $dart_ui.RSuperellipse.fromRectAndRadius(rect, radius);
      },
      'fromLTRBAndCorners': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'RSuperellipse');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'RSuperellipse');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'RSuperellipse');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'RSuperellipse');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'RSuperellipse');
        final topLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topLeft', $dart_ui.Radius.zero);
        final topRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topRight', $dart_ui.Radius.zero);
        final bottomRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomRight', $dart_ui.Radius.zero);
        final bottomLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomLeft', $dart_ui.Radius.zero);
        return $dart_ui.RSuperellipse.fromLTRBAndCorners(left, top, right, bottom, topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft);
      },
      'fromRectAndCorners': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RSuperellipse');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'RSuperellipse');
        final topLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topLeft', $dart_ui.Radius.zero);
        final topRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'topRight', $dart_ui.Radius.zero);
        final bottomRight = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomRight', $dart_ui.Radius.zero);
        final bottomLeft = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'bottomLeft', $dart_ui.Radius.zero);
        return $dart_ui.RSuperellipse.fromRectAndCorners(rect, topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft);
      },
    },
    getters: {
      'left': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').left,
      'top': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').top,
      'right': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').right,
      'bottom': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').bottom,
      'tlRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').tlRadiusX,
      'tlRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').tlRadiusY,
      'tlRadius': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').tlRadius,
      'trRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').trRadiusX,
      'trRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').trRadiusY,
      'trRadius': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').trRadius,
      'brRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').brRadiusX,
      'brRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').brRadiusY,
      'brRadius': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').brRadius,
      'blRadiusX': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').blRadiusX,
      'blRadiusY': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').blRadiusY,
      'blRadius': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').blRadius,
      'width': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').height,
      'outerRect': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').outerRect,
      'safeInnerRect': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').safeInnerRect,
      'middleRect': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').middleRect,
      'wideMiddleRect': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').wideMiddleRect,
      'tallMiddleRect': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').tallMiddleRect,
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').isEmpty,
      'isFinite': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').isFinite,
      'isRect': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').isRect,
      'isStadium': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').isStadium,
      'isEllipse': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').isEllipse,
      'isCircle': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').isCircle,
      'shortestSide': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').shortestSide,
      'longestSide': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').longestSide,
      'hasNaN': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').hasNaN,
      'center': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').center,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse').hashCode,
    },
    methods: {
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse');
        D4.requireMinArgs(positional, 1, 'contains');
        final point = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'point', 'contains');
        return t.contains(point);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse');
        return t.toString();
      },
      'shift': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse');
        D4.requireMinArgs(positional, 1, 'shift');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'shift');
        return t.shift(offset);
      },
      'inflate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse');
        D4.requireMinArgs(positional, 1, 'inflate');
        final delta = D4.getRequiredArg<double>(positional, 0, 'delta', 'inflate');
        return t.inflate(delta);
      },
      'deflate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse');
        D4.requireMinArgs(positional, 1, 'deflate');
        final delta = D4.getRequiredArg<double>(positional, 0, 'delta', 'deflate');
        return t.deflate(delta);
      },
      'scaleRadii': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse');
        return t.scaleRadii();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.RSuperellipse>(target, 'RSuperellipse');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $dart_ui.RSuperellipse.zero,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.RSuperellipse?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.RSuperellipse?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.RSuperellipse.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      'fromLTRBXY': 'const RSuperellipse.fromLTRBXY(double left, double top, double right, double bottom, double radiusX, double radiusY)',
      'fromLTRBR': 'RSuperellipse.fromLTRBR(double left, double top, double right, double bottom, Radius radius)',
      'fromRectXY': 'RSuperellipse.fromRectXY(Rect rect, double radiusX, double radiusY)',
      'fromRectAndRadius': 'RSuperellipse.fromRectAndRadius(Rect rect, Radius radius)',
      'fromLTRBAndCorners': 'RSuperellipse.fromLTRBAndCorners(double left, double top, double right, double bottom, {Radius topLeft = Radius.zero, Radius topRight = Radius.zero, Radius bottomRight = Radius.zero, Radius bottomLeft = Radius.zero})',
      'fromRectAndCorners': 'RSuperellipse.fromRectAndCorners(Rect rect, {Radius topLeft = Radius.zero, Radius topRight = Radius.zero, Radius bottomRight = Radius.zero, Radius bottomLeft = Radius.zero})',
    },
    methodSignatures: {
      'contains': 'bool contains(Offset point)',
      'toString': 'String toString()',
      'shift': 'RSuperellipse shift(Offset offset)',
      'inflate': 'RSuperellipse inflate(double delta)',
      'deflate': 'RSuperellipse deflate(double delta)',
      'scaleRadii': 'RSuperellipse scaleRadii()',
    },
    getterSignatures: {
      'left': 'double get left',
      'top': 'double get top',
      'right': 'double get right',
      'bottom': 'double get bottom',
      'tlRadiusX': 'double get tlRadiusX',
      'tlRadiusY': 'double get tlRadiusY',
      'tlRadius': 'Radius get tlRadius',
      'trRadiusX': 'double get trRadiusX',
      'trRadiusY': 'double get trRadiusY',
      'trRadius': 'Radius get trRadius',
      'brRadiusX': 'double get brRadiusX',
      'brRadiusY': 'double get brRadiusY',
      'brRadius': 'Radius get brRadius',
      'blRadiusX': 'double get blRadiusX',
      'blRadiusY': 'double get blRadiusY',
      'blRadius': 'Radius get blRadius',
      'width': 'double get width',
      'height': 'double get height',
      'outerRect': 'Rect get outerRect',
      'safeInnerRect': 'Rect get safeInnerRect',
      'middleRect': 'Rect get middleRect',
      'wideMiddleRect': 'Rect get wideMiddleRect',
      'tallMiddleRect': 'Rect get tallMiddleRect',
      'isEmpty': 'bool get isEmpty',
      'isFinite': 'bool get isFinite',
      'isRect': 'bool get isRect',
      'isStadium': 'bool get isStadium',
      'isEllipse': 'bool get isEllipse',
      'isCircle': 'bool get isCircle',
      'shortestSide': 'double get shortestSide',
      'longestSide': 'double get longestSide',
      'hasNaN': 'bool get hasNaN',
      'center': 'Offset get center',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'RSuperellipse? lerp(RSuperellipse? a, RSuperellipse? b, double t)',
    },
    staticGetterSignatures: {
      'zero': 'RSuperellipse get zero',
    },
  );
}

// =============================================================================
// RSTransform Bridge
// =============================================================================

BridgedClass _createRSTransformBridge() {
  return BridgedClass(
    nativeType: $dart_ui.RSTransform,
    name: 'RSTransform',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'RSTransform');
        final scos = D4.getRequiredArg<double>(positional, 0, 'scos', 'RSTransform');
        final ssin = D4.getRequiredArg<double>(positional, 1, 'ssin', 'RSTransform');
        final tx = D4.getRequiredArg<double>(positional, 2, 'tx', 'RSTransform');
        final ty = D4.getRequiredArg<double>(positional, 3, 'ty', 'RSTransform');
        return $dart_ui.RSTransform(scos, ssin, tx, ty);
      },
      'fromComponents': (visitor, positional, named) {
        final rotation = D4.getRequiredNamedArg<double>(named, 'rotation', 'RSTransform');
        final scale = D4.getRequiredNamedArg<double>(named, 'scale', 'RSTransform');
        final anchorX = D4.getRequiredNamedArg<double>(named, 'anchorX', 'RSTransform');
        final anchorY = D4.getRequiredNamedArg<double>(named, 'anchorY', 'RSTransform');
        final translateX = D4.getRequiredNamedArg<double>(named, 'translateX', 'RSTransform');
        final translateY = D4.getRequiredNamedArg<double>(named, 'translateY', 'RSTransform');
        return $dart_ui.RSTransform.fromComponents(rotation: rotation, scale: scale, anchorX: anchorX, anchorY: anchorY, translateX: translateX, translateY: translateY);
      },
    },
    getters: {
      'scos': (visitor, target) => D4.validateTarget<$dart_ui.RSTransform>(target, 'RSTransform').scos,
      'ssin': (visitor, target) => D4.validateTarget<$dart_ui.RSTransform>(target, 'RSTransform').ssin,
      'tx': (visitor, target) => D4.validateTarget<$dart_ui.RSTransform>(target, 'RSTransform').tx,
      'ty': (visitor, target) => D4.validateTarget<$dart_ui.RSTransform>(target, 'RSTransform').ty,
    },
    constructorSignatures: {
      '': 'RSTransform(double scos, double ssin, double tx, double ty)',
      'fromComponents': 'factory RSTransform.fromComponents({required double rotation, required double scale, required double anchorX, required double anchorY, required double translateX, required double translateY})',
    },
    getterSignatures: {
      'scos': 'double get scos',
      'ssin': 'double get ssin',
      'tx': 'double get tx',
      'ty': 'double get ty',
    },
  );
}

// =============================================================================
// IsolateNameServer Bridge
// =============================================================================

BridgedClass _createIsolateNameServerBridge() {
  return BridgedClass(
    nativeType: IsolateNameServer,
    name: 'IsolateNameServer',
    constructors: {
    },
    staticMethods: {
      'lookupPortByName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lookupPortByName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'lookupPortByName');
        return IsolateNameServer.lookupPortByName(name);
      },
      'registerPortWithName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'registerPortWithName');
        final port = D4.getRequiredArg<SendPort>(positional, 0, 'port', 'registerPortWithName');
        final name = D4.getRequiredArg<String>(positional, 1, 'name', 'registerPortWithName');
        return IsolateNameServer.registerPortWithName(port, name);
      },
      'removePortNameMapping': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removePortNameMapping');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'removePortNameMapping');
        return IsolateNameServer.removePortNameMapping(name);
      },
    },
    staticMethodSignatures: {
      'lookupPortByName': 'SendPort? lookupPortByName(String name)',
      'registerPortWithName': 'bool registerPortWithName(SendPort port, String name)',
      'removePortNameMapping': 'bool removePortNameMapping(String name)',
    },
  );
}

// =============================================================================
// KeyData Bridge
// =============================================================================

BridgedClass _createKeyDataBridge() {
  return BridgedClass(
    nativeType: $dart_ui.KeyData,
    name: 'KeyData',
    constructors: {
      '': (visitor, positional, named) {
        final timeStamp = D4.getRequiredNamedArg<Duration>(named, 'timeStamp', 'KeyData');
        final type = D4.getRequiredNamedArg<$dart_ui.KeyEventType>(named, 'type', 'KeyData');
        final physical = D4.getRequiredNamedArg<int>(named, 'physical', 'KeyData');
        final logical = D4.getRequiredNamedArg<int>(named, 'logical', 'KeyData');
        final character = D4.getRequiredNamedArg<String?>(named, 'character', 'KeyData');
        final synthesized = D4.getRequiredNamedArg<bool>(named, 'synthesized', 'KeyData');
        final deviceType = D4.getNamedArgWithDefault<$dart_ui.KeyEventDeviceType>(named, 'deviceType', $dart_ui.KeyEventDeviceType.keyboard);
        return $dart_ui.KeyData(timeStamp: timeStamp, type: type, physical: physical, logical: logical, character: character, synthesized: synthesized, deviceType: deviceType);
      },
    },
    getters: {
      'timeStamp': (visitor, target) => D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData').timeStamp,
      'type': (visitor, target) => D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData').type,
      'deviceType': (visitor, target) => D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData').deviceType,
      'physical': (visitor, target) => D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData').physical,
      'logical': (visitor, target) => D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData').logical,
      'character': (visitor, target) => D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData').character,
      'synthesized': (visitor, target) => D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData').synthesized,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData');
        return t.toString();
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.KeyData>(target, 'KeyData');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const KeyData({required Duration timeStamp, required KeyEventType type, required int physical, required int logical, required String? character, required bool synthesized, KeyEventDeviceType deviceType = KeyEventDeviceType.keyboard})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'toStringFull': 'String toStringFull()',
    },
    getterSignatures: {
      'timeStamp': 'Duration get timeStamp',
      'type': 'KeyEventType get type',
      'deviceType': 'KeyEventDeviceType get deviceType',
      'physical': 'int get physical',
      'logical': 'int get logical',
      'character': 'String? get character',
      'synthesized': 'bool get synthesized',
    },
  );
}

// =============================================================================
// DartPluginRegistrant Bridge
// =============================================================================

BridgedClass _createDartPluginRegistrantBridge() {
  return BridgedClass(
    nativeType: DartPluginRegistrant,
    name: 'DartPluginRegistrant',
    constructors: {
    },
    staticMethods: {
      'ensureInitialized': (visitor, positional, named, typeArgs) {
        return DartPluginRegistrant.ensureInitialized();
      },
    },
    staticMethodSignatures: {
      'ensureInitialized': 'void ensureInitialized()',
    },
  );
}

// =============================================================================
// Color Bridge
// =============================================================================

BridgedClass _createColorBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Color,
    name: 'Color',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Color');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'Color');
        return $dart_ui.Color(value);
      },
      'from': (visitor, positional, named) {
        final alpha = D4.getRequiredNamedArg<double>(named, 'alpha', 'Color');
        final red = D4.getRequiredNamedArg<double>(named, 'red', 'Color');
        final green = D4.getRequiredNamedArg<double>(named, 'green', 'Color');
        final blue = D4.getRequiredNamedArg<double>(named, 'blue', 'Color');
        final colorSpace = D4.getNamedArgWithDefault<$dart_ui.ColorSpace>(named, 'colorSpace', $dart_ui.ColorSpace.sRGB);
        return $dart_ui.Color.from(alpha: alpha, red: red, green: green, blue: blue, colorSpace: colorSpace);
      },
      'fromARGB': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Color');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'Color');
        final r = D4.getRequiredArg<int>(positional, 1, 'r', 'Color');
        final g = D4.getRequiredArg<int>(positional, 2, 'g', 'Color');
        final b = D4.getRequiredArg<int>(positional, 3, 'b', 'Color');
        return $dart_ui.Color.fromARGB(a, r, g, b);
      },
      'fromRGBO': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Color');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'Color');
        final g = D4.getRequiredArg<int>(positional, 1, 'g', 'Color');
        final b = D4.getRequiredArg<int>(positional, 2, 'b', 'Color');
        final opacity = D4.getRequiredArg<double>(positional, 3, 'opacity', 'Color');
        return $dart_ui.Color.fromRGBO(r, g, b, opacity);
      },
    },
    getters: {
      'a': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').a,
      'r': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').r,
      'g': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').g,
      'b': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').b,
      'colorSpace': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').colorSpace,
      'value': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').value,
      'alpha': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').alpha,
      'opacity': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').opacity,
      'red': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').red,
      'green': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').green,
      'blue': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').blue,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.Color>(target, 'Color').hashCode,
    },
    methods: {
      'toARGB32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        return t.toARGB32();
      },
      'withValues': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        final alpha = D4.getOptionalNamedArg<double?>(named, 'alpha');
        final red = D4.getOptionalNamedArg<double?>(named, 'red');
        final green = D4.getOptionalNamedArg<double?>(named, 'green');
        final blue = D4.getOptionalNamedArg<double?>(named, 'blue');
        final colorSpace = D4.getOptionalNamedArg<$dart_ui.ColorSpace?>(named, 'colorSpace');
        return t.withValues(alpha: alpha, red: red, green: green, blue: blue, colorSpace: colorSpace);
      },
      'withAlpha': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        D4.requireMinArgs(positional, 1, 'withAlpha');
        final a = D4.getRequiredArg<int>(positional, 0, 'a', 'withAlpha');
        return t.withAlpha(a);
      },
      'withOpacity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        D4.requireMinArgs(positional, 1, 'withOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'withOpacity');
        return t.withOpacity(opacity);
      },
      'withRed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        D4.requireMinArgs(positional, 1, 'withRed');
        final r = D4.getRequiredArg<int>(positional, 0, 'r', 'withRed');
        return t.withRed(r);
      },
      'withGreen': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        D4.requireMinArgs(positional, 1, 'withGreen');
        final g = D4.getRequiredArg<int>(positional, 0, 'g', 'withGreen');
        return t.withGreen(g);
      },
      'withBlue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        D4.requireMinArgs(positional, 1, 'withBlue');
        final b = D4.getRequiredArg<int>(positional, 0, 'b', 'withBlue');
        return t.withBlue(b);
      },
      'computeLuminance': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        return t.computeLuminance();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Color>(target, 'Color');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final x = D4.getRequiredArg<$dart_ui.Color?>(positional, 0, 'x', 'lerp');
        final y = D4.getRequiredArg<$dart_ui.Color?>(positional, 1, 'y', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.Color.lerp(x, y, t_);
      },
      'alphaBlend': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'alphaBlend');
        final foreground = D4.getRequiredArg<$dart_ui.Color>(positional, 0, 'foreground', 'alphaBlend');
        final background = D4.getRequiredArg<$dart_ui.Color>(positional, 1, 'background', 'alphaBlend');
        return $dart_ui.Color.alphaBlend(foreground, background);
      },
      'getAlphaFromOpacity': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getAlphaFromOpacity');
        final opacity = D4.getRequiredArg<double>(positional, 0, 'opacity', 'getAlphaFromOpacity');
        return $dart_ui.Color.getAlphaFromOpacity(opacity);
      },
    },
    constructorSignatures: {
      '': 'const Color(int value)',
      'from': 'const Color.from({required double alpha, required double red, required double green, required double blue, ColorSpace colorSpace = ColorSpace.sRGB})',
      'fromARGB': 'const Color.fromARGB(int a, int r, int g, int b)',
      'fromRGBO': 'const Color.fromRGBO(int r, int g, int b, double opacity)',
    },
    methodSignatures: {
      'toARGB32': 'int toARGB32()',
      'withValues': 'Color withValues({double? alpha, double? red, double? green, double? blue, ColorSpace? colorSpace})',
      'withAlpha': 'Color withAlpha(int a)',
      'withOpacity': 'Color withOpacity(double opacity)',
      'withRed': 'Color withRed(int r)',
      'withGreen': 'Color withGreen(int g)',
      'withBlue': 'Color withBlue(int b)',
      'computeLuminance': 'double computeLuminance()',
      'toString': 'String toString()',
    },
    getterSignatures: {
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
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'Color? lerp(Color? x, Color? y, double t)',
      'alphaBlend': 'Color alphaBlend(Color foreground, Color background)',
      'getAlphaFromOpacity': 'int getAlphaFromOpacity(double opacity)',
    },
  );
}

// =============================================================================
// Paint Bridge
// =============================================================================

BridgedClass _createPaintBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Paint,
    name: 'Paint',
    constructors: {
      '': (visitor, positional, named) {
        return $dart_ui.Paint();
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Paint');
        final other = D4.getRequiredArg<$dart_ui.Paint>(positional, 0, 'other', 'Paint');
        return $dart_ui.Paint.from(other);
      },
    },
    getters: {
      'isAntiAlias': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').isAntiAlias,
      'color': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').color,
      'blendMode': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').blendMode,
      'style': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').style,
      'strokeWidth': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeWidth,
      'strokeCap': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeCap,
      'strokeJoin': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeJoin,
      'strokeMiterLimit': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeMiterLimit,
      'maskFilter': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').maskFilter,
      'filterQuality': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').filterQuality,
      'shader': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').shader,
      'colorFilter': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').colorFilter,
      'imageFilter': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').imageFilter,
      'invertColors': (visitor, target) => D4.validateTarget<$dart_ui.Paint>(target, 'Paint').invertColors,
    },
    setters: {
      'isAntiAlias': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').isAntiAlias = value as dynamic,
      'color': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').color = value as dynamic,
      'blendMode': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').blendMode = value as dynamic,
      'style': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').style = value as dynamic,
      'strokeWidth': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeWidth = value as dynamic,
      'strokeCap': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeCap = value as dynamic,
      'strokeJoin': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeJoin = value as dynamic,
      'strokeMiterLimit': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').strokeMiterLimit = value as dynamic,
      'maskFilter': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').maskFilter = value as dynamic,
      'filterQuality': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').filterQuality = value as dynamic,
      'shader': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').shader = value as dynamic,
      'colorFilter': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').colorFilter = value as dynamic,
      'imageFilter': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').imageFilter = value as dynamic,
      'invertColors': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Paint>(target, 'Paint').invertColors = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paint>(target, 'Paint');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Paint()',
      'from': 'Paint.from(Paint other)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isAntiAlias': 'bool get isAntiAlias',
      'color': 'Color get color',
      'blendMode': 'BlendMode get blendMode',
      'style': 'PaintingStyle get style',
      'strokeWidth': 'double get strokeWidth',
      'strokeCap': 'StrokeCap get strokeCap',
      'strokeJoin': 'StrokeJoin get strokeJoin',
      'strokeMiterLimit': 'double get strokeMiterLimit',
      'maskFilter': 'MaskFilter? get maskFilter',
      'filterQuality': 'FilterQuality get filterQuality',
      'shader': 'Shader? get shader',
      'colorFilter': 'ColorFilter? get colorFilter',
      'imageFilter': 'ImageFilter? get imageFilter',
      'invertColors': 'bool get invertColors',
    },
    setterSignatures: {
      'isAntiAlias': 'set isAntiAlias(bool value)',
      'color': 'set color(Color value)',
      'blendMode': 'set blendMode(BlendMode value)',
      'style': 'set style(PaintingStyle value)',
      'strokeWidth': 'set strokeWidth(double value)',
      'strokeCap': 'set strokeCap(StrokeCap value)',
      'strokeJoin': 'set strokeJoin(StrokeJoin value)',
      'strokeMiterLimit': 'set strokeMiterLimit(double value)',
      'maskFilter': 'set maskFilter(MaskFilter? value)',
      'filterQuality': 'set filterQuality(FilterQuality value)',
      'shader': 'set shader(Shader? value)',
      'colorFilter': 'set colorFilter(ColorFilter? value)',
      'imageFilter': 'set imageFilter(ImageFilter? value)',
      'invertColors': 'set invertColors(bool value)',
    },
  );
}

// =============================================================================
// Image Bridge
// =============================================================================

BridgedClass _createImageBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Image,
    name: 'Image',
    constructors: {
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$dart_ui.Image>(target, 'Image').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.Image>(target, 'Image').height,
      'debugDisposed': (visitor, target) => D4.validateTarget<$dart_ui.Image>(target, 'Image').debugDisposed,
      'colorSpace': (visitor, target) => D4.validateTarget<$dart_ui.Image>(target, 'Image').colorSpace,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Image>(target, 'Image');
        (t as dynamic).dispose();
        return null;
      },
      'toByteData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Image>(target, 'Image');
        final format = D4.getNamedArgWithDefault<$dart_ui.ImageByteFormat>(named, 'format', $dart_ui.ImageByteFormat.rawRgba);
        return t.toByteData(format: format);
      },
      'debugGetOpenHandleStackTraces': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Image>(target, 'Image');
        return t.debugGetOpenHandleStackTraces();
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Image>(target, 'Image');
        return t.clone();
      },
      'isCloneOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Image>(target, 'Image');
        D4.requireMinArgs(positional, 1, 'isCloneOf');
        final other = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'other', 'isCloneOf');
        return t.isCloneOf(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Image>(target, 'Image');
        return t.toString();
      },
    },
    staticGetters: {
      'onCreate': (visitor) => $dart_ui.Image.onCreate,
      'onDispose': (visitor) => $dart_ui.Image.onDispose,
    },
    staticSetters: {
      'onCreate': (visitor, value) => 
        $dart_ui.Image.onCreate = value as ImageEventCallback?,
      'onDispose': (visitor, value) => 
        $dart_ui.Image.onDispose = value as ImageEventCallback?,
    },
    methodSignatures: {
      'dispose': 'void dispose()',
      'toByteData': 'Future<ByteData?> toByteData({ImageByteFormat format = ImageByteFormat.rawRgba})',
      'debugGetOpenHandleStackTraces': 'List<StackTrace>? debugGetOpenHandleStackTraces()',
      'clone': 'Image clone()',
      'isCloneOf': 'bool isCloneOf(Image other)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'width': 'int get width',
      'height': 'int get height',
      'debugDisposed': 'bool get debugDisposed',
      'colorSpace': 'ColorSpace get colorSpace',
    },
    staticGetterSignatures: {
      'onCreate': 'ImageEventCallback? get onCreate',
      'onDispose': 'ImageEventCallback? get onDispose',
    },
    staticSetterSignatures: {
      'onCreate': 'set onCreate(dynamic value)',
      'onDispose': 'set onDispose(dynamic value)',
    },
  );
}

// =============================================================================
// FrameInfo Bridge
// =============================================================================

BridgedClass _createFrameInfoBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FrameInfo,
    name: 'FrameInfo',
    constructors: {
    },
    getters: {
      'duration': (visitor, target) => D4.validateTarget<$dart_ui.FrameInfo>(target, 'FrameInfo').duration,
      'image': (visitor, target) => D4.validateTarget<$dart_ui.FrameInfo>(target, 'FrameInfo').image,
    },
    getterSignatures: {
      'duration': 'Duration get duration',
      'image': 'Image get image',
    },
  );
}

// =============================================================================
// Codec Bridge
// =============================================================================

BridgedClass _createCodecBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Codec,
    name: 'Codec',
    constructors: {
    },
    getters: {
      'frameCount': (visitor, target) => D4.validateTarget<$dart_ui.Codec>(target, 'Codec').frameCount,
      'repetitionCount': (visitor, target) => D4.validateTarget<$dart_ui.Codec>(target, 'Codec').repetitionCount,
    },
    methods: {
      'getNextFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Codec>(target, 'Codec');
        return t.getNextFrame();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Codec>(target, 'Codec');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'getNextFrame': 'Future<FrameInfo> getNextFrame()',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'frameCount': 'int get frameCount',
      'repetitionCount': 'int get repetitionCount',
    },
  );
}

// =============================================================================
// TargetImageSize Bridge
// =============================================================================

BridgedClass _createTargetImageSizeBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TargetImageSize,
    name: 'TargetImageSize',
    constructors: {
      '': (visitor, positional, named) {
        final width = D4.getOptionalNamedArg<int?>(named, 'width');
        final height = D4.getOptionalNamedArg<int?>(named, 'height');
        return $dart_ui.TargetImageSize(width: width, height: height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$dart_ui.TargetImageSize>(target, 'TargetImageSize').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.TargetImageSize>(target, 'TargetImageSize').height,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TargetImageSize>(target, 'TargetImageSize');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TargetImageSize({int? width, int? height})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'width': 'int? get width',
      'height': 'int? get height',
    },
  );
}

// =============================================================================
// EngineLayer Bridge
// =============================================================================

BridgedClass _createEngineLayerBridge() {
  return BridgedClass(
    nativeType: $dart_ui.EngineLayer,
    name: 'EngineLayer',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.EngineLayer>(target, 'EngineLayer');
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
// Path Bridge
// =============================================================================

BridgedClass _createPathBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Path,
    name: 'Path',
    constructors: {
      '': (visitor, positional, named) {
        return $dart_ui.Path();
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Path');
        final source = D4.getRequiredArg<$dart_ui.Path>(positional, 0, 'source', 'Path');
        return $dart_ui.Path.from(source);
      },
    },
    getters: {
      'fillType': (visitor, target) => D4.validateTarget<$dart_ui.Path>(target, 'Path').fillType,
    },
    setters: {
      'fillType': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.Path>(target, 'Path').fillType = value as dynamic,
    },
    methods: {
      'moveTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 2, 'moveTo');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'moveTo');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'moveTo');
        t.moveTo(x, y);
        return null;
      },
      'relativeMoveTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 2, 'relativeMoveTo');
        final dx = D4.getRequiredArg<double>(positional, 0, 'dx', 'relativeMoveTo');
        final dy = D4.getRequiredArg<double>(positional, 1, 'dy', 'relativeMoveTo');
        t.relativeMoveTo(dx, dy);
        return null;
      },
      'lineTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 2, 'lineTo');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'lineTo');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'lineTo');
        t.lineTo(x, y);
        return null;
      },
      'relativeLineTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 2, 'relativeLineTo');
        final dx = D4.getRequiredArg<double>(positional, 0, 'dx', 'relativeLineTo');
        final dy = D4.getRequiredArg<double>(positional, 1, 'dy', 'relativeLineTo');
        t.relativeLineTo(dx, dy);
        return null;
      },
      'quadraticBezierTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 4, 'quadraticBezierTo');
        final x1 = D4.getRequiredArg<double>(positional, 0, 'x1', 'quadraticBezierTo');
        final y1 = D4.getRequiredArg<double>(positional, 1, 'y1', 'quadraticBezierTo');
        final x2 = D4.getRequiredArg<double>(positional, 2, 'x2', 'quadraticBezierTo');
        final y2 = D4.getRequiredArg<double>(positional, 3, 'y2', 'quadraticBezierTo');
        t.quadraticBezierTo(x1, y1, x2, y2);
        return null;
      },
      'relativeQuadraticBezierTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 4, 'relativeQuadraticBezierTo');
        final x1 = D4.getRequiredArg<double>(positional, 0, 'x1', 'relativeQuadraticBezierTo');
        final y1 = D4.getRequiredArg<double>(positional, 1, 'y1', 'relativeQuadraticBezierTo');
        final x2 = D4.getRequiredArg<double>(positional, 2, 'x2', 'relativeQuadraticBezierTo');
        final y2 = D4.getRequiredArg<double>(positional, 3, 'y2', 'relativeQuadraticBezierTo');
        t.relativeQuadraticBezierTo(x1, y1, x2, y2);
        return null;
      },
      'cubicTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 6, 'cubicTo');
        final x1 = D4.getRequiredArg<double>(positional, 0, 'x1', 'cubicTo');
        final y1 = D4.getRequiredArg<double>(positional, 1, 'y1', 'cubicTo');
        final x2 = D4.getRequiredArg<double>(positional, 2, 'x2', 'cubicTo');
        final y2 = D4.getRequiredArg<double>(positional, 3, 'y2', 'cubicTo');
        final x3 = D4.getRequiredArg<double>(positional, 4, 'x3', 'cubicTo');
        final y3 = D4.getRequiredArg<double>(positional, 5, 'y3', 'cubicTo');
        t.cubicTo(x1, y1, x2, y2, x3, y3);
        return null;
      },
      'relativeCubicTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 6, 'relativeCubicTo');
        final x1 = D4.getRequiredArg<double>(positional, 0, 'x1', 'relativeCubicTo');
        final y1 = D4.getRequiredArg<double>(positional, 1, 'y1', 'relativeCubicTo');
        final x2 = D4.getRequiredArg<double>(positional, 2, 'x2', 'relativeCubicTo');
        final y2 = D4.getRequiredArg<double>(positional, 3, 'y2', 'relativeCubicTo');
        final x3 = D4.getRequiredArg<double>(positional, 4, 'x3', 'relativeCubicTo');
        final y3 = D4.getRequiredArg<double>(positional, 5, 'y3', 'relativeCubicTo');
        t.relativeCubicTo(x1, y1, x2, y2, x3, y3);
        return null;
      },
      'conicTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 5, 'conicTo');
        final x1 = D4.getRequiredArg<double>(positional, 0, 'x1', 'conicTo');
        final y1 = D4.getRequiredArg<double>(positional, 1, 'y1', 'conicTo');
        final x2 = D4.getRequiredArg<double>(positional, 2, 'x2', 'conicTo');
        final y2 = D4.getRequiredArg<double>(positional, 3, 'y2', 'conicTo');
        final w = D4.getRequiredArg<double>(positional, 4, 'w', 'conicTo');
        t.conicTo(x1, y1, x2, y2, w);
        return null;
      },
      'relativeConicTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 5, 'relativeConicTo');
        final x1 = D4.getRequiredArg<double>(positional, 0, 'x1', 'relativeConicTo');
        final y1 = D4.getRequiredArg<double>(positional, 1, 'y1', 'relativeConicTo');
        final x2 = D4.getRequiredArg<double>(positional, 2, 'x2', 'relativeConicTo');
        final y2 = D4.getRequiredArg<double>(positional, 3, 'y2', 'relativeConicTo');
        final w = D4.getRequiredArg<double>(positional, 4, 'w', 'relativeConicTo');
        t.relativeConicTo(x1, y1, x2, y2, w);
        return null;
      },
      'arcTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 4, 'arcTo');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'arcTo');
        final startAngle = D4.getRequiredArg<double>(positional, 1, 'startAngle', 'arcTo');
        final sweepAngle = D4.getRequiredArg<double>(positional, 2, 'sweepAngle', 'arcTo');
        final forceMoveTo = D4.getRequiredArg<bool>(positional, 3, 'forceMoveTo', 'arcTo');
        t.arcTo(rect, startAngle, sweepAngle, forceMoveTo);
        return null;
      },
      'arcToPoint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'arcToPoint');
        final arcEnd = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'arcEnd', 'arcToPoint');
        final radius = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'radius', $dart_ui.Radius.zero);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0.0);
        final largeArc = D4.getNamedArgWithDefault<bool>(named, 'largeArc', false);
        final clockwise = D4.getNamedArgWithDefault<bool>(named, 'clockwise', true);
        t.arcToPoint(arcEnd, radius: radius, rotation: rotation, largeArc: largeArc, clockwise: clockwise);
        return null;
      },
      'relativeArcToPoint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'relativeArcToPoint');
        final arcEndDelta = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'arcEndDelta', 'relativeArcToPoint');
        final radius = D4.getNamedArgWithDefault<$dart_ui.Radius>(named, 'radius', $dart_ui.Radius.zero);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0.0);
        final largeArc = D4.getNamedArgWithDefault<bool>(named, 'largeArc', false);
        final clockwise = D4.getNamedArgWithDefault<bool>(named, 'clockwise', true);
        t.relativeArcToPoint(arcEndDelta, radius: radius, rotation: rotation, largeArc: largeArc, clockwise: clockwise);
        return null;
      },
      'addRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'addRect');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'addRect');
        t.addRect(rect);
        return null;
      },
      'addOval': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'addOval');
        final oval = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'oval', 'addOval');
        t.addOval(oval);
        return null;
      },
      'addArc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 3, 'addArc');
        final oval = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'oval', 'addArc');
        final startAngle = D4.getRequiredArg<double>(positional, 1, 'startAngle', 'addArc');
        final sweepAngle = D4.getRequiredArg<double>(positional, 2, 'sweepAngle', 'addArc');
        t.addArc(oval, startAngle, sweepAngle);
        return null;
      },
      'addPolygon': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 2, 'addPolygon');
        if (positional.isEmpty) {
          throw ArgumentError('addPolygon: Missing required argument "points" at position 0');
        }
        final points = D4.coerceList<$dart_ui.Offset>(positional[0], 'points');
        final close = D4.getRequiredArg<bool>(positional, 1, 'close', 'addPolygon');
        t.addPolygon(points, close);
        return null;
      },
      'addRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'addRRect');
        final rrect = D4.getRequiredArg<$dart_ui.RRect>(positional, 0, 'rrect', 'addRRect');
        t.addRRect(rrect);
        return null;
      },
      'addRSuperellipse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'addRSuperellipse');
        final rsuperellipse = D4.getRequiredArg<$dart_ui.RSuperellipse>(positional, 0, 'rsuperellipse', 'addRSuperellipse');
        t.addRSuperellipse(rsuperellipse);
        return null;
      },
      'addPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 2, 'addPath');
        final path = D4.getRequiredArg<$dart_ui.Path>(positional, 0, 'path', 'addPath');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'offset', 'addPath');
        final matrix4 = D4.getOptionalNamedArg<Float64List?>(named, 'matrix4');
        t.addPath(path, offset, matrix4: matrix4);
        return null;
      },
      'extendWithPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 2, 'extendWithPath');
        final path = D4.getRequiredArg<$dart_ui.Path>(positional, 0, 'path', 'extendWithPath');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'offset', 'extendWithPath');
        final matrix4 = D4.getOptionalNamedArg<Float64List?>(named, 'matrix4');
        t.extendWithPath(path, offset, matrix4: matrix4);
        return null;
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        t.close();
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        t.reset();
        return null;
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'contains');
        final point = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'point', 'contains');
        return t.contains(point);
      },
      'shift': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'shift');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'shift');
        return t.shift(offset);
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        D4.requireMinArgs(positional, 1, 'transform');
        final matrix4 = D4.getRequiredArg<Float64List>(positional, 0, 'matrix4', 'transform');
        return t.transform(matrix4);
      },
      'getBounds': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        return t.getBounds();
      },
      'computeMetrics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Path>(target, 'Path');
        final forceClosed = D4.getNamedArgWithDefault<bool>(named, 'forceClosed', false);
        return t.computeMetrics(forceClosed: forceClosed);
      },
    },
    staticMethods: {
      'combine': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'combine');
        final operation = D4.getRequiredArg<$dart_ui.PathOperation>(positional, 0, 'operation', 'combine');
        final path1 = D4.getRequiredArg<$dart_ui.Path>(positional, 1, 'path1', 'combine');
        final path2 = D4.getRequiredArg<$dart_ui.Path>(positional, 2, 'path2', 'combine');
        return $dart_ui.Path.combine(operation, path1, path2);
      },
    },
    constructorSignatures: {
      '': 'factory Path()',
      'from': 'factory Path.from(Path source)',
    },
    methodSignatures: {
      'moveTo': 'void moveTo(double x, double y)',
      'relativeMoveTo': 'void relativeMoveTo(double dx, double dy)',
      'lineTo': 'void lineTo(double x, double y)',
      'relativeLineTo': 'void relativeLineTo(double dx, double dy)',
      'quadraticBezierTo': 'void quadraticBezierTo(double x1, double y1, double x2, double y2)',
      'relativeQuadraticBezierTo': 'void relativeQuadraticBezierTo(double x1, double y1, double x2, double y2)',
      'cubicTo': 'void cubicTo(double x1, double y1, double x2, double y2, double x3, double y3)',
      'relativeCubicTo': 'void relativeCubicTo(double x1, double y1, double x2, double y2, double x3, double y3)',
      'conicTo': 'void conicTo(double x1, double y1, double x2, double y2, double w)',
      'relativeConicTo': 'void relativeConicTo(double x1, double y1, double x2, double y2, double w)',
      'arcTo': 'void arcTo(Rect rect, double startAngle, double sweepAngle, bool forceMoveTo)',
      'arcToPoint': 'void arcToPoint(Offset arcEnd, {Radius radius = Radius.zero, double rotation = 0.0, bool largeArc = false, bool clockwise = true})',
      'relativeArcToPoint': 'void relativeArcToPoint(Offset arcEndDelta, {Radius radius = Radius.zero, double rotation = 0.0, bool largeArc = false, bool clockwise = true})',
      'addRect': 'void addRect(Rect rect)',
      'addOval': 'void addOval(Rect oval)',
      'addArc': 'void addArc(Rect oval, double startAngle, double sweepAngle)',
      'addPolygon': 'void addPolygon(List<Offset> points, bool close)',
      'addRRect': 'void addRRect(RRect rrect)',
      'addRSuperellipse': 'void addRSuperellipse(RSuperellipse rsuperellipse)',
      'addPath': 'void addPath(Path path, Offset offset, {Float64List? matrix4})',
      'extendWithPath': 'void extendWithPath(Path path, Offset offset, {Float64List? matrix4})',
      'close': 'void close()',
      'reset': 'void reset()',
      'contains': 'bool contains(Offset point)',
      'shift': 'Path shift(Offset offset)',
      'transform': 'Path transform(Float64List matrix4)',
      'getBounds': 'Rect getBounds()',
      'computeMetrics': 'PathMetrics computeMetrics({bool forceClosed = false})',
    },
    getterSignatures: {
      'fillType': 'PathFillType get fillType',
    },
    setterSignatures: {
      'fillType': 'set fillType(PathFillType value)',
    },
    staticMethodSignatures: {
      'combine': 'Path combine(PathOperation operation, Path path1, Path path2)',
    },
  );
}

// =============================================================================
// Tangent Bridge
// =============================================================================

BridgedClass _createTangentBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Tangent,
    name: 'Tangent',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Tangent');
        final position = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'position', 'Tangent');
        final vector = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'vector', 'Tangent');
        return $dart_ui.Tangent(position, vector);
      },
      'fromAngle': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Tangent');
        final position = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'position', 'Tangent');
        final angle = D4.getRequiredArg<double>(positional, 1, 'angle', 'Tangent');
        return $dart_ui.Tangent.fromAngle(position, angle);
      },
    },
    getters: {
      'position': (visitor, target) => D4.validateTarget<$dart_ui.Tangent>(target, 'Tangent').position,
      'vector': (visitor, target) => D4.validateTarget<$dart_ui.Tangent>(target, 'Tangent').vector,
      'angle': (visitor, target) => D4.validateTarget<$dart_ui.Tangent>(target, 'Tangent').angle,
    },
    constructorSignatures: {
      '': 'const Tangent(Offset position, Offset vector)',
      'fromAngle': 'factory Tangent.fromAngle(Offset position, double angle)',
    },
    getterSignatures: {
      'position': 'Offset get position',
      'vector': 'Offset get vector',
      'angle': 'double get angle',
    },
  );
}

// =============================================================================
// PathMetrics Bridge
// =============================================================================

BridgedClass _createPathMetricsBridge() {
  return BridgedClass(
    nativeType: $dart_ui.PathMetrics,
    name: 'PathMetrics',
    constructors: {
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics').iterator,
      'length': (visitor, target) => D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics').length,
      'isEmpty': (visitor, target) => D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics').isNotEmpty,
      'first': (visitor, target) => D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics').first,
      'last': (visitor, target) => D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics').last,
      'single': (visitor, target) => D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics').single,
    },
    methods: {
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        return t.cast();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'followedBy');
        final other = D4.getRequiredArg<Iterable<$dart_ui.PathMetric>>(positional, 0, 'other', 'followedBy');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, toElementRaw, [p0]) as dynamic; });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        return t.whereType();
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach(($dart_ui.PathMetric p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce(($dart_ui.PathMetric p0, $dart_ui.PathMetric p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as $dart_ui.PathMetric; });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, $dart_ui.PathMetric p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        return t.toSet();
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as $dart_ui.PathMetric; });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as $dart_ui.PathMetric; });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere(($dart_ui.PathMetric p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as $dart_ui.PathMetric; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetrics>(target, 'PathMetrics');
        return t.toString();
      },
    },
    methodSignatures: {
      'cast': 'Iterable<R> cast()',
      'followedBy': 'Iterable<PathMetric> followedBy(Iterable<PathMetric> other)',
      'map': 'Iterable<T> map(T Function(PathMetric) toElement)',
      'where': 'Iterable<PathMetric> where(bool Function(PathMetric) test)',
      'whereType': 'Iterable<T> whereType()',
      'expand': 'Iterable<T> expand(Iterable<T> Function(PathMetric) toElements)',
      'contains': 'bool contains(Object? element)',
      'forEach': 'void forEach(void Function(PathMetric) action)',
      'reduce': 'PathMetric reduce(PathMetric Function(PathMetric, PathMetric) combine)',
      'fold': 'T fold(T initialValue, T Function(T, PathMetric) combine)',
      'every': 'bool every(bool Function(PathMetric) test)',
      'join': 'String join([String separator = ""])',
      'any': 'bool any(bool Function(PathMetric) test)',
      'toList': 'List<PathMetric> toList({bool growable = true})',
      'toSet': 'Set<PathMetric> toSet()',
      'take': 'Iterable<PathMetric> take(int count)',
      'takeWhile': 'Iterable<PathMetric> takeWhile(bool Function(PathMetric) test)',
      'skip': 'Iterable<PathMetric> skip(int count)',
      'skipWhile': 'Iterable<PathMetric> skipWhile(bool Function(PathMetric) test)',
      'firstWhere': 'PathMetric firstWhere(bool Function(PathMetric) test, {PathMetric Function()? orElse})',
      'lastWhere': 'PathMetric lastWhere(bool Function(PathMetric) test, {PathMetric Function()? orElse})',
      'singleWhere': 'PathMetric singleWhere(bool Function(PathMetric) test, {PathMetric Function()? orElse})',
      'elementAt': 'PathMetric elementAt(int index)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'iterator': 'Iterator<PathMetric> get iterator',
      'length': 'int get length',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'first': 'PathMetric get first',
      'last': 'PathMetric get last',
      'single': 'PathMetric get single',
    },
  );
}

// =============================================================================
// PathMetricIterator Bridge
// =============================================================================

BridgedClass _createPathMetricIteratorBridge() {
  return BridgedClass(
    nativeType: PathMetricIterator,
    name: 'PathMetricIterator',
    constructors: {
    },
    getters: {
      'current': (visitor, target) => D4.validateTarget<PathMetricIterator>(target, 'PathMetricIterator').current,
    },
    methods: {
      'moveNext': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PathMetricIterator>(target, 'PathMetricIterator');
        return t.moveNext();
      },
    },
    methodSignatures: {
      'moveNext': 'bool moveNext()',
    },
    getterSignatures: {
      'current': 'PathMetric get current',
    },
  );
}

// =============================================================================
// PathMetric Bridge
// =============================================================================

BridgedClass _createPathMetricBridge() {
  return BridgedClass(
    nativeType: $dart_ui.PathMetric,
    name: 'PathMetric',
    constructors: {
    },
    getters: {
      'length': (visitor, target) => D4.validateTarget<$dart_ui.PathMetric>(target, 'PathMetric').length,
      'isClosed': (visitor, target) => D4.validateTarget<$dart_ui.PathMetric>(target, 'PathMetric').isClosed,
      'contourIndex': (visitor, target) => D4.validateTarget<$dart_ui.PathMetric>(target, 'PathMetric').contourIndex,
    },
    methods: {
      'getTangentForOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetric>(target, 'PathMetric');
        D4.requireMinArgs(positional, 1, 'getTangentForOffset');
        final distance = D4.getRequiredArg<double>(positional, 0, 'distance', 'getTangentForOffset');
        return t.getTangentForOffset(distance);
      },
      'extractPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetric>(target, 'PathMetric');
        D4.requireMinArgs(positional, 2, 'extractPath');
        final start = D4.getRequiredArg<double>(positional, 0, 'start', 'extractPath');
        final end = D4.getRequiredArg<double>(positional, 1, 'end', 'extractPath');
        final startWithMoveTo = D4.getNamedArgWithDefault<bool>(named, 'startWithMoveTo', true);
        return t.extractPath(start, end, startWithMoveTo: startWithMoveTo);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PathMetric>(target, 'PathMetric');
        return t.toString();
      },
    },
    methodSignatures: {
      'getTangentForOffset': 'Tangent? getTangentForOffset(double distance)',
      'extractPath': 'Path extractPath(double start, double end, {bool startWithMoveTo = true})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'length': 'double get length',
      'isClosed': 'bool get isClosed',
      'contourIndex': 'int get contourIndex',
    },
  );
}

// =============================================================================
// MaskFilter Bridge
// =============================================================================

BridgedClass _createMaskFilterBridge() {
  return BridgedClass(
    nativeType: $dart_ui.MaskFilter,
    name: 'MaskFilter',
    constructors: {
      'blur': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'MaskFilter');
        final style = D4.getRequiredArg<$dart_ui.BlurStyle>(positional, 0, '_style', 'MaskFilter');
        final sigma = D4.getRequiredArg<double>(positional, 1, '_sigma', 'MaskFilter');
        return $dart_ui.MaskFilter.blur(style, sigma);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.MaskFilter>(target, 'MaskFilter').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.MaskFilter>(target, 'MaskFilter');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.MaskFilter>(target, 'MaskFilter');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      'blur': 'const MaskFilter.blur(BlurStyle _style, double _sigma)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ColorFilter Bridge
// =============================================================================

BridgedClass _createColorFilterBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ColorFilter,
    name: 'ColorFilter',
    constructors: {
      'mode': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColorFilter');
        final color = D4.getRequiredArg<$dart_ui.Color>(positional, 0, 'color', 'ColorFilter');
        final blendMode = D4.getRequiredArg<$dart_ui.BlendMode>(positional, 1, 'blendMode', 'ColorFilter');
        return $dart_ui.ColorFilter.mode(color, blendMode);
      },
      'matrix': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ColorFilter');
        if (positional.isEmpty) {
          throw ArgumentError('ColorFilter: Missing required argument "matrix" at position 0');
        }
        final matrix = D4.coerceList<double>(positional[0], 'matrix');
        return $dart_ui.ColorFilter.matrix(matrix);
      },
      'linearToSrgbGamma': (visitor, positional, named) {
        return $dart_ui.ColorFilter.linearToSrgbGamma();
      },
      'srgbToLinearGamma': (visitor, positional, named) {
        return $dart_ui.ColorFilter.srgbToLinearGamma();
      },
      'saturation': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ColorFilter');
        final saturation = D4.getRequiredArg<double>(positional, 0, 'saturation', 'ColorFilter');
        return $dart_ui.ColorFilter.saturation(saturation);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.ColorFilter>(target, 'ColorFilter').hashCode,
      'debugShortDescription': (visitor, target) => D4.validateTarget<$dart_ui.ColorFilter>(target, 'ColorFilter').debugShortDescription,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ColorFilter>(target, 'ColorFilter');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ColorFilter>(target, 'ColorFilter');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      'mode': 'const ColorFilter.mode(Color color, BlendMode blendMode)',
      'matrix': 'const ColorFilter.matrix(List<double> matrix)',
      'linearToSrgbGamma': 'const ColorFilter.linearToSrgbGamma()',
      'srgbToLinearGamma': 'const ColorFilter.srgbToLinearGamma()',
      'saturation': 'factory ColorFilter.saturation(double saturation)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
      'debugShortDescription': 'String get debugShortDescription',
    },
  );
}

// =============================================================================
// ImageFilter Bridge
// =============================================================================

BridgedClass _createImageFilterBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ImageFilter,
    name: 'ImageFilter',
    constructors: {
      'blur': (visitor, positional, named) {
        final sigmaX = D4.getNamedArgWithDefault<double>(named, 'sigmaX', 0.0);
        final sigmaY = D4.getNamedArgWithDefault<double>(named, 'sigmaY', 0.0);
        final tileMode = D4.getOptionalNamedArg<$dart_ui.TileMode?>(named, 'tileMode');
        final bounds = D4.getOptionalNamedArg<$dart_ui.Rect?>(named, 'bounds');
        return $dart_ui.ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY, tileMode: tileMode, bounds: bounds);
      },
      'dilate': (visitor, positional, named) {
        final radiusX = D4.getNamedArgWithDefault<double>(named, 'radiusX', 0.0);
        final radiusY = D4.getNamedArgWithDefault<double>(named, 'radiusY', 0.0);
        return $dart_ui.ImageFilter.dilate(radiusX: radiusX, radiusY: radiusY);
      },
      'erode': (visitor, positional, named) {
        final radiusX = D4.getNamedArgWithDefault<double>(named, 'radiusX', 0.0);
        final radiusY = D4.getNamedArgWithDefault<double>(named, 'radiusY', 0.0);
        return $dart_ui.ImageFilter.erode(radiusX: radiusX, radiusY: radiusY);
      },
      'matrix': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ImageFilter');
        final matrix4 = D4.getRequiredArg<Float64List>(positional, 0, 'matrix4', 'ImageFilter');
        final filterQuality = D4.getNamedArgWithDefault<$dart_ui.FilterQuality>(named, 'filterQuality', $dart_ui.FilterQuality.medium);
        return $dart_ui.ImageFilter.matrix(matrix4, filterQuality: filterQuality);
      },
      'compose': (visitor, positional, named) {
        final outer = D4.getRequiredNamedArg<$dart_ui.ImageFilter>(named, 'outer', 'ImageFilter');
        final inner = D4.getRequiredNamedArg<$dart_ui.ImageFilter>(named, 'inner', 'ImageFilter');
        return $dart_ui.ImageFilter.compose(outer: outer, inner: inner);
      },
      'shader': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ImageFilter');
        final shader = D4.getRequiredArg<$dart_ui.FragmentShader>(positional, 0, 'shader', 'ImageFilter');
        return $dart_ui.ImageFilter.shader(shader);
      },
    },
    getters: {
      'debugShortDescription': (visitor, target) => D4.validateTarget<$dart_ui.ImageFilter>(target, 'ImageFilter').debugShortDescription,
    },
    staticGetters: {
      'isShaderFilterSupported': (visitor) => $dart_ui.ImageFilter.isShaderFilterSupported,
    },
    constructorSignatures: {
      'blur': 'factory ImageFilter.blur({double sigmaX = 0.0, double sigmaY = 0.0, TileMode? tileMode, Rect? bounds})',
      'dilate': 'factory ImageFilter.dilate({double radiusX = 0.0, double radiusY = 0.0})',
      'erode': 'factory ImageFilter.erode({double radiusX = 0.0, double radiusY = 0.0})',
      'matrix': 'factory ImageFilter.matrix(Float64List matrix4, {FilterQuality filterQuality = FilterQuality.medium})',
      'compose': 'factory ImageFilter.compose({required ImageFilter outer, required ImageFilter inner})',
      'shader': 'factory ImageFilter.shader(FragmentShader shader)',
    },
    getterSignatures: {
      'debugShortDescription': 'String get debugShortDescription',
    },
    staticGetterSignatures: {
      'isShaderFilterSupported': 'bool get isShaderFilterSupported',
    },
  );
}

// =============================================================================
// Shader Bridge
// =============================================================================

BridgedClass _createShaderBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Shader,
    name: 'Shader',
    constructors: {
    },
    getters: {
      'debugDisposed': (visitor, target) => D4.validateTarget<$dart_ui.Shader>(target, 'Shader').debugDisposed,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Shader>(target, 'Shader');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'debugDisposed': 'bool get debugDisposed',
    },
  );
}

// =============================================================================
// Gradient Bridge
// =============================================================================

BridgedClass _createGradientBridge() {
  return BridgedClass(
    nativeType: Gradient,
    name: 'Gradient',
    constructors: {
      'linear': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Gradient');
        final from = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'from', 'Gradient');
        final to = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'to', 'Gradient');
        if (positional.length <= 2) {
          throw ArgumentError('Gradient: Missing required argument "colors" at position 2');
        }
        final colors = D4.coerceList<$dart_ui.Color>(positional[2], 'colors');
        final colorStops = positional.length > 3
            ? D4.coerceListOrNull<double>(positional[3], 'colorStops')
            : null;
        final tileMode = D4.getOptionalArgWithDefault<$dart_ui.TileMode>(positional, 4, 'tileMode', $dart_ui.TileMode.clamp);
        final matrix4 = D4.getOptionalArg<Float64List?>(positional, 5, 'matrix4');
        return Gradient.linear(from, to, colors, colorStops, tileMode, matrix4);
      },
      'radial': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Gradient');
        final center = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'center', 'Gradient');
        final radius = D4.getRequiredArg<double>(positional, 1, 'radius', 'Gradient');
        if (positional.length <= 2) {
          throw ArgumentError('Gradient: Missing required argument "colors" at position 2');
        }
        final colors = D4.coerceList<$dart_ui.Color>(positional[2], 'colors');
        final colorStops = positional.length > 3
            ? D4.coerceListOrNull<double>(positional[3], 'colorStops')
            : null;
        final tileMode = D4.getOptionalArgWithDefault<$dart_ui.TileMode>(positional, 4, 'tileMode', $dart_ui.TileMode.clamp);
        final matrix4 = D4.getOptionalArg<Float64List?>(positional, 5, 'matrix4');
        final focal = D4.getOptionalArg<$dart_ui.Offset?>(positional, 6, 'focal');
        final focalRadius = D4.getOptionalArgWithDefault<double>(positional, 7, 'focalRadius', 0.0);
        return Gradient.radial(center, radius, colors, colorStops, tileMode, matrix4, focal, focalRadius);
      },
      'sweep': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Gradient');
        final center = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'center', 'Gradient');
        if (positional.length <= 1) {
          throw ArgumentError('Gradient: Missing required argument "colors" at position 1');
        }
        final colors = D4.coerceList<$dart_ui.Color>(positional[1], 'colors');
        final colorStops = positional.length > 2
            ? D4.coerceListOrNull<double>(positional[2], 'colorStops')
            : null;
        final tileMode = D4.getOptionalArgWithDefault<$dart_ui.TileMode>(positional, 3, 'tileMode', $dart_ui.TileMode.clamp);
        final startAngle = D4.getOptionalArgWithDefault<double>(positional, 4, 'startAngle', 0.0);
        // TODO: Non-wrappable default: math.pi * 2
        final endAngle = D4.getRequiredArgTodoDefault<double>(positional, 5, 'endAngle', 'Gradient', 'math.pi * 2');
        final matrix4 = D4.getOptionalArg<Float64List?>(positional, 6, 'matrix4');
        return Gradient.sweep(center, colors, colorStops, tileMode, startAngle, endAngle, matrix4);
      },
    },
    getters: {
      'debugDisposed': (visitor, target) => D4.validateTarget<Gradient>(target, 'Gradient').debugDisposed,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Gradient>(target, 'Gradient');
        (t as dynamic).dispose();
        return null;
      },
    },
    constructorSignatures: {
      'linear': 'Gradient.linear(Offset from, Offset to, List<Color> colors, [List<double>? colorStops, TileMode tileMode = TileMode.clamp, Float64List? matrix4])',
      'radial': 'Gradient.radial(Offset center, double radius, List<Color> colors, [List<double>? colorStops, TileMode tileMode = TileMode.clamp, Float64List? matrix4, Offset? focal, double focalRadius = 0.0])',
      'sweep': 'Gradient.sweep(Offset center, List<Color> colors, [List<double>? colorStops, TileMode tileMode = TileMode.clamp, double startAngle = 0.0, double endAngle = math.pi * 2, Float64List? matrix4])',
    },
    methodSignatures: {
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'debugDisposed': 'bool get debugDisposed',
    },
  );
}

// =============================================================================
// ImageShader Bridge
// =============================================================================

BridgedClass _createImageShaderBridge() {
  return BridgedClass(
    nativeType: ImageShader,
    name: 'ImageShader',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'ImageShader');
        final image = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'image', 'ImageShader');
        final tmx = D4.getRequiredArg<$dart_ui.TileMode>(positional, 1, 'tmx', 'ImageShader');
        final tmy = D4.getRequiredArg<$dart_ui.TileMode>(positional, 2, 'tmy', 'ImageShader');
        final matrix4 = D4.getRequiredArg<Float64List>(positional, 3, 'matrix4', 'ImageShader');
        final filterQuality = D4.getOptionalNamedArg<$dart_ui.FilterQuality?>(named, 'filterQuality');
        return ImageShader(image, tmx, tmy, matrix4, filterQuality: filterQuality);
      },
    },
    getters: {
      'debugDisposed': (visitor, target) => D4.validateTarget<ImageShader>(target, 'ImageShader').debugDisposed,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ImageShader>(target, 'ImageShader');
        (t as dynamic).dispose();
        return null;
      },
    },
    constructorSignatures: {
      '': 'ImageShader(Image image, TileMode tmx, TileMode tmy, Float64List matrix4, {FilterQuality? filterQuality})',
    },
    methodSignatures: {
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'debugDisposed': 'bool get debugDisposed',
    },
  );
}

// =============================================================================
// FragmentProgram Bridge
// =============================================================================

BridgedClass _createFragmentProgramBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FragmentProgram,
    name: 'FragmentProgram',
    constructors: {
    },
    methods: {
      'fragmentShader': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentProgram>(target, 'FragmentProgram');
        return t.fragmentShader();
      },
    },
    staticMethods: {
      'fromAsset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromAsset');
        final assetKey = D4.getRequiredArg<String>(positional, 0, 'assetKey', 'fromAsset');
        return $dart_ui.FragmentProgram.fromAsset(assetKey);
      },
    },
    methodSignatures: {
      'fragmentShader': 'FragmentShader fragmentShader()',
    },
    staticMethodSignatures: {
      'fromAsset': 'Future<FragmentProgram> fromAsset(String assetKey)',
    },
  );
}

// =============================================================================
// UniformFloatSlot Bridge
// =============================================================================

BridgedClass _createUniformFloatSlotBridge() {
  return BridgedClass(
    nativeType: $dart_ui.UniformFloatSlot,
    name: 'UniformFloatSlot',
    constructors: {
    },
    getters: {
      'shaderIndex': (visitor, target) => D4.validateTarget<$dart_ui.UniformFloatSlot>(target, 'UniformFloatSlot').shaderIndex,
      'name': (visitor, target) => D4.validateTarget<$dart_ui.UniformFloatSlot>(target, 'UniformFloatSlot').name,
      'index': (visitor, target) => D4.validateTarget<$dart_ui.UniformFloatSlot>(target, 'UniformFloatSlot').index,
    },
    methods: {
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.UniformFloatSlot>(target, 'UniformFloatSlot');
        D4.requireMinArgs(positional, 1, 'set');
        final val = D4.getRequiredArg<double>(positional, 0, 'val', 'set');
        t.set(val);
        return null;
      },
    },
    methodSignatures: {
      'set': 'void set(double val)',
    },
    getterSignatures: {
      'shaderIndex': 'int get shaderIndex',
      'name': 'String get name',
      'index': 'int get index',
    },
  );
}

// =============================================================================
// UniformVec2Slot Bridge
// =============================================================================

BridgedClass _createUniformVec2SlotBridge() {
  return BridgedClass(
    nativeType: $dart_ui.UniformVec2Slot,
    name: 'UniformVec2Slot',
    constructors: {
    },
    methods: {
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.UniformVec2Slot>(target, 'UniformVec2Slot');
        D4.requireMinArgs(positional, 2, 'set');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'set');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'set');
        t.set(x, y);
        return null;
      },
    },
    methodSignatures: {
      'set': 'void set(double x, double y)',
    },
  );
}

// =============================================================================
// UniformVec3Slot Bridge
// =============================================================================

BridgedClass _createUniformVec3SlotBridge() {
  return BridgedClass(
    nativeType: $dart_ui.UniformVec3Slot,
    name: 'UniformVec3Slot',
    constructors: {
    },
    methods: {
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.UniformVec3Slot>(target, 'UniformVec3Slot');
        D4.requireMinArgs(positional, 3, 'set');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'set');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'set');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'set');
        t.set(x, y, z);
        return null;
      },
    },
    methodSignatures: {
      'set': 'void set(double x, double y, double z)',
    },
  );
}

// =============================================================================
// UniformVec4Slot Bridge
// =============================================================================

BridgedClass _createUniformVec4SlotBridge() {
  return BridgedClass(
    nativeType: $dart_ui.UniformVec4Slot,
    name: 'UniformVec4Slot',
    constructors: {
    },
    methods: {
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.UniformVec4Slot>(target, 'UniformVec4Slot');
        D4.requireMinArgs(positional, 4, 'set');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'set');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'set');
        final z = D4.getRequiredArg<double>(positional, 2, 'z', 'set');
        final w = D4.getRequiredArg<double>(positional, 3, 'w', 'set');
        t.set(x, y, z, w);
        return null;
      },
    },
    methodSignatures: {
      'set': 'void set(double x, double y, double z, double w)',
    },
  );
}

// =============================================================================
// ImageSamplerSlot Bridge
// =============================================================================

BridgedClass _createImageSamplerSlotBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ImageSamplerSlot,
    name: 'ImageSamplerSlot',
    constructors: {
    },
    getters: {
      'shaderIndex': (visitor, target) => D4.validateTarget<$dart_ui.ImageSamplerSlot>(target, 'ImageSamplerSlot').shaderIndex,
      'name': (visitor, target) => D4.validateTarget<$dart_ui.ImageSamplerSlot>(target, 'ImageSamplerSlot').name,
    },
    methods: {
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ImageSamplerSlot>(target, 'ImageSamplerSlot');
        D4.requireMinArgs(positional, 1, 'set');
        final val = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'val', 'set');
        t.set(val);
        return null;
      },
    },
    methodSignatures: {
      'set': 'void set(Image val)',
    },
    getterSignatures: {
      'shaderIndex': 'int get shaderIndex',
      'name': 'String get name',
    },
  );
}

// =============================================================================
// FragmentShader Bridge
// =============================================================================

BridgedClass _createFragmentShaderBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FragmentShader,
    name: 'FragmentShader',
    constructors: {
    },
    getters: {
      'debugDisposed': (visitor, target) => D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader').debugDisposed,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        (t as dynamic).dispose();
        return null;
      },
      'setFloat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        D4.requireMinArgs(positional, 2, 'setFloat');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'setFloat');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'setFloat');
        t.setFloat(index, value);
        return null;
      },
      'getUniformFloat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        D4.requireMinArgs(positional, 1, 'getUniformFloat');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getUniformFloat');
        final index = D4.getOptionalArg<int?>(positional, 1, 'index');
        return t.getUniformFloat(name, index);
      },
      'getUniformVec2': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        D4.requireMinArgs(positional, 1, 'getUniformVec2');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getUniformVec2');
        return t.getUniformVec2(name);
      },
      'getUniformVec3': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        D4.requireMinArgs(positional, 1, 'getUniformVec3');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getUniformVec3');
        return t.getUniformVec3(name);
      },
      'getUniformVec4': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        D4.requireMinArgs(positional, 1, 'getUniformVec4');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getUniformVec4');
        return t.getUniformVec4(name);
      },
      'getImageSampler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        D4.requireMinArgs(positional, 1, 'getImageSampler');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getImageSampler');
        return t.getImageSampler(name);
      },
      'setImageSampler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FragmentShader>(target, 'FragmentShader');
        D4.requireMinArgs(positional, 2, 'setImageSampler');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'setImageSampler');
        final image = D4.getRequiredArg<$dart_ui.Image>(positional, 1, 'image', 'setImageSampler');
        final filterQuality = D4.getNamedArgWithDefault<$dart_ui.FilterQuality>(named, 'filterQuality', $dart_ui.FilterQuality.none);
        t.setImageSampler(index, image, filterQuality: filterQuality);
        return null;
      },
    },
    methodSignatures: {
      'dispose': 'void dispose()',
      'setFloat': 'void setFloat(int index, double value)',
      'getUniformFloat': 'UniformFloatSlot getUniformFloat(String name, [int? index])',
      'getUniformVec2': 'UniformVec2Slot getUniformVec2(String name)',
      'getUniformVec3': 'UniformVec3Slot getUniformVec3(String name)',
      'getUniformVec4': 'UniformVec4Slot getUniformVec4(String name)',
      'getImageSampler': 'ImageSamplerSlot getImageSampler(String name)',
      'setImageSampler': 'void setImageSampler(int index, Image image, {FilterQuality filterQuality = FilterQuality.none})',
    },
    getterSignatures: {
      'debugDisposed': 'bool get debugDisposed',
    },
  );
}

// =============================================================================
// Vertices Bridge
// =============================================================================

BridgedClass _createVerticesBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Vertices,
    name: 'Vertices',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vertices');
        final mode = D4.getRequiredArg<$dart_ui.VertexMode>(positional, 0, 'mode', 'Vertices');
        if (positional.length <= 1) {
          throw ArgumentError('Vertices: Missing required argument "positions" at position 1');
        }
        final positions = D4.coerceList<$dart_ui.Offset>(positional[1], 'positions');
        final colors = D4.coerceListOrNull<$dart_ui.Color>(named['colors'], 'colors');
        final textureCoordinates = D4.coerceListOrNull<$dart_ui.Offset>(named['textureCoordinates'], 'textureCoordinates');
        final indices = D4.coerceListOrNull<int>(named['indices'], 'indices');
        return $dart_ui.Vertices(mode, positions, colors: colors, textureCoordinates: textureCoordinates, indices: indices);
      },
      'raw': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vertices');
        final mode = D4.getRequiredArg<$dart_ui.VertexMode>(positional, 0, 'mode', 'Vertices');
        final positions = D4.getRequiredArg<Float32List>(positional, 1, 'positions', 'Vertices');
        final colors = D4.getOptionalNamedArg<Int32List?>(named, 'colors');
        final textureCoordinates = D4.getOptionalNamedArg<Float32List?>(named, 'textureCoordinates');
        final indices = D4.getOptionalNamedArg<Uint16List?>(named, 'indices');
        return $dart_ui.Vertices.raw(mode, positions, colors: colors, textureCoordinates: textureCoordinates, indices: indices);
      },
    },
    getters: {
      'debugDisposed': (visitor, target) => D4.validateTarget<$dart_ui.Vertices>(target, 'Vertices').debugDisposed,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Vertices>(target, 'Vertices');
        (t as dynamic).dispose();
        return null;
      },
    },
    constructorSignatures: {
      '': 'Vertices(VertexMode mode, List<Offset> positions, {List<Color>? colors, List<Offset>? textureCoordinates, List<int>? indices})',
      'raw': 'Vertices.raw(VertexMode mode, Float32List positions, {Int32List? colors, Float32List? textureCoordinates, Uint16List? indices})',
    },
    methodSignatures: {
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'debugDisposed': 'bool get debugDisposed',
    },
  );
}

// =============================================================================
// Canvas Bridge
// =============================================================================

BridgedClass _createCanvasBridge() {
  return BridgedClass(
    nativeType: Canvas,
    name: 'Canvas',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Canvas');
        final recorder = D4.getRequiredArg<$dart_ui.PictureRecorder>(positional, 0, 'recorder', 'Canvas');
        final cullRect = D4.getOptionalArg<$dart_ui.Rect?>(positional, 1, 'cullRect');
        return Canvas(recorder, cullRect);
      },
    },
    methods: {
      'save': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        t.save();
        return null;
      },
      'saveLayer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'saveLayer');
        final bounds = D4.getRequiredArg<$dart_ui.Rect?>(positional, 0, 'bounds', 'saveLayer');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 1, 'paint', 'saveLayer');
        t.saveLayer(bounds, paint);
        return null;
      },
      'restore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        t.restore();
        return null;
      },
      'restoreToCount': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'restoreToCount');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'restoreToCount');
        t.restoreToCount(count);
        return null;
      },
      'getSaveCount': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        return t.getSaveCount();
      },
      'translate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'translate');
        final dx = D4.getRequiredArg<double>(positional, 0, 'dx', 'translate');
        final dy = D4.getRequiredArg<double>(positional, 1, 'dy', 'translate');
        t.translate(dx, dy);
        return null;
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'scale');
        final sx = D4.getRequiredArg<double>(positional, 0, 'sx', 'scale');
        final sy = D4.getOptionalArg<double?>(positional, 1, 'sy');
        t.scale(sx, sy);
        return null;
      },
      'rotate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'rotate');
        final radians = D4.getRequiredArg<double>(positional, 0, 'radians', 'rotate');
        t.rotate(radians);
        return null;
      },
      'skew': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'skew');
        final sx = D4.getRequiredArg<double>(positional, 0, 'sx', 'skew');
        final sy = D4.getRequiredArg<double>(positional, 1, 'sy', 'skew');
        t.skew(sx, sy);
        return null;
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'transform');
        final matrix4 = D4.getRequiredArg<Float64List>(positional, 0, 'matrix4', 'transform');
        t.transform(matrix4);
        return null;
      },
      'getTransform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        return t.getTransform();
      },
      'clipRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'clipRect');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'clipRect');
        final clipOp = D4.getNamedArgWithDefault<$dart_ui.ClipOp>(named, 'clipOp', $dart_ui.ClipOp.intersect);
        final doAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'doAntiAlias', true);
        t.clipRect(rect, clipOp: clipOp, doAntiAlias: doAntiAlias);
        return null;
      },
      'clipRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'clipRRect');
        final rrect = D4.getRequiredArg<$dart_ui.RRect>(positional, 0, 'rrect', 'clipRRect');
        final doAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'doAntiAlias', true);
        t.clipRRect(rrect, doAntiAlias: doAntiAlias);
        return null;
      },
      'clipRSuperellipse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'clipRSuperellipse');
        final rsuperellipse = D4.getRequiredArg<$dart_ui.RSuperellipse>(positional, 0, 'rsuperellipse', 'clipRSuperellipse');
        final doAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'doAntiAlias', true);
        t.clipRSuperellipse(rsuperellipse, doAntiAlias: doAntiAlias);
        return null;
      },
      'clipPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'clipPath');
        final path = D4.getRequiredArg<$dart_ui.Path>(positional, 0, 'path', 'clipPath');
        final doAntiAlias = D4.getNamedArgWithDefault<bool>(named, 'doAntiAlias', true);
        t.clipPath(path, doAntiAlias: doAntiAlias);
        return null;
      },
      'getLocalClipBounds': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        return t.getLocalClipBounds();
      },
      'getDestinationClipBounds': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        return t.getDestinationClipBounds();
      },
      'drawColor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'drawColor');
        final color = D4.getRequiredArg<$dart_ui.Color>(positional, 0, 'color', 'drawColor');
        final blendMode = D4.getRequiredArg<$dart_ui.BlendMode>(positional, 1, 'blendMode', 'drawColor');
        t.drawColor(color, blendMode);
        return null;
      },
      'drawLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 3, 'drawLine');
        final p1 = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'p1', 'drawLine');
        final p2 = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'p2', 'drawLine');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 2, 'paint', 'drawLine');
        t.drawLine(p1, p2, paint);
        return null;
      },
      'drawPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'drawPaint');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 0, 'paint', 'drawPaint');
        t.drawPaint(paint);
        return null;
      },
      'drawRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'drawRect');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'drawRect');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 1, 'paint', 'drawRect');
        t.drawRect(rect, paint);
        return null;
      },
      'drawRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'drawRRect');
        final rrect = D4.getRequiredArg<$dart_ui.RRect>(positional, 0, 'rrect', 'drawRRect');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 1, 'paint', 'drawRRect');
        t.drawRRect(rrect, paint);
        return null;
      },
      'drawDRRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 3, 'drawDRRect');
        final outer = D4.getRequiredArg<$dart_ui.RRect>(positional, 0, 'outer', 'drawDRRect');
        final inner = D4.getRequiredArg<$dart_ui.RRect>(positional, 1, 'inner', 'drawDRRect');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 2, 'paint', 'drawDRRect');
        t.drawDRRect(outer, inner, paint);
        return null;
      },
      'drawRSuperellipse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'drawRSuperellipse');
        final rsuperellipse = D4.getRequiredArg<$dart_ui.RSuperellipse>(positional, 0, 'rsuperellipse', 'drawRSuperellipse');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 1, 'paint', 'drawRSuperellipse');
        t.drawRSuperellipse(rsuperellipse, paint);
        return null;
      },
      'drawOval': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'drawOval');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'drawOval');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 1, 'paint', 'drawOval');
        t.drawOval(rect, paint);
        return null;
      },
      'drawCircle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 3, 'drawCircle');
        final c = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'c', 'drawCircle');
        final radius = D4.getRequiredArg<double>(positional, 1, 'radius', 'drawCircle');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 2, 'paint', 'drawCircle');
        t.drawCircle(c, radius, paint);
        return null;
      },
      'drawArc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 5, 'drawArc');
        final rect = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'rect', 'drawArc');
        final startAngle = D4.getRequiredArg<double>(positional, 1, 'startAngle', 'drawArc');
        final sweepAngle = D4.getRequiredArg<double>(positional, 2, 'sweepAngle', 'drawArc');
        final useCenter = D4.getRequiredArg<bool>(positional, 3, 'useCenter', 'drawArc');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 4, 'paint', 'drawArc');
        t.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
        return null;
      },
      'drawPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'drawPath');
        final path = D4.getRequiredArg<$dart_ui.Path>(positional, 0, 'path', 'drawPath');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 1, 'paint', 'drawPath');
        t.drawPath(path, paint);
        return null;
      },
      'drawImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 3, 'drawImage');
        final image = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'image', 'drawImage');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'offset', 'drawImage');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 2, 'paint', 'drawImage');
        t.drawImage(image, offset, paint);
        return null;
      },
      'drawImageRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 4, 'drawImageRect');
        final image = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'image', 'drawImageRect');
        final src = D4.getRequiredArg<$dart_ui.Rect>(positional, 1, 'src', 'drawImageRect');
        final dst = D4.getRequiredArg<$dart_ui.Rect>(positional, 2, 'dst', 'drawImageRect');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 3, 'paint', 'drawImageRect');
        t.drawImageRect(image, src, dst, paint);
        return null;
      },
      'drawImageNine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 4, 'drawImageNine');
        final image = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'image', 'drawImageNine');
        final center = D4.getRequiredArg<$dart_ui.Rect>(positional, 1, 'center', 'drawImageNine');
        final dst = D4.getRequiredArg<$dart_ui.Rect>(positional, 2, 'dst', 'drawImageNine');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 3, 'paint', 'drawImageNine');
        t.drawImageNine(image, center, dst, paint);
        return null;
      },
      'drawPicture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 1, 'drawPicture');
        final picture = D4.getRequiredArg<$dart_ui.Picture>(positional, 0, 'picture', 'drawPicture');
        t.drawPicture(picture);
        return null;
      },
      'drawParagraph': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 2, 'drawParagraph');
        final paragraph = D4.getRequiredArg<$dart_ui.Paragraph>(positional, 0, 'paragraph', 'drawParagraph');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 1, 'offset', 'drawParagraph');
        t.drawParagraph(paragraph, offset);
        return null;
      },
      'drawPoints': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 3, 'drawPoints');
        final pointMode = D4.getRequiredArg<$dart_ui.PointMode>(positional, 0, 'pointMode', 'drawPoints');
        if (positional.length <= 1) {
          throw ArgumentError('drawPoints: Missing required argument "points" at position 1');
        }
        final points = D4.coerceList<$dart_ui.Offset>(positional[1], 'points');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 2, 'paint', 'drawPoints');
        t.drawPoints(pointMode, points, paint);
        return null;
      },
      'drawRawPoints': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 3, 'drawRawPoints');
        final pointMode = D4.getRequiredArg<$dart_ui.PointMode>(positional, 0, 'pointMode', 'drawRawPoints');
        final points = D4.getRequiredArg<Float32List>(positional, 1, 'points', 'drawRawPoints');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 2, 'paint', 'drawRawPoints');
        t.drawRawPoints(pointMode, points, paint);
        return null;
      },
      'drawVertices': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 3, 'drawVertices');
        final vertices = D4.getRequiredArg<$dart_ui.Vertices>(positional, 0, 'vertices', 'drawVertices');
        final blendMode = D4.getRequiredArg<$dart_ui.BlendMode>(positional, 1, 'blendMode', 'drawVertices');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 2, 'paint', 'drawVertices');
        t.drawVertices(vertices, blendMode, paint);
        return null;
      },
      'drawAtlas': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 7, 'drawAtlas');
        final atlas = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'atlas', 'drawAtlas');
        if (positional.length <= 1) {
          throw ArgumentError('drawAtlas: Missing required argument "transforms" at position 1');
        }
        final transforms = D4.coerceList<$dart_ui.RSTransform>(positional[1], 'transforms');
        if (positional.length <= 2) {
          throw ArgumentError('drawAtlas: Missing required argument "rects" at position 2');
        }
        final rects = D4.coerceList<$dart_ui.Rect>(positional[2], 'rects');
        if (positional.length <= 3) {
          throw ArgumentError('drawAtlas: Missing required argument "colors" at position 3');
        }
        final colors = D4.coerceListOrNull<$dart_ui.Color>(positional[3], 'colors');
        final blendMode = D4.getRequiredArg<$dart_ui.BlendMode?>(positional, 4, 'blendMode', 'drawAtlas');
        final cullRect = D4.getRequiredArg<$dart_ui.Rect?>(positional, 5, 'cullRect', 'drawAtlas');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 6, 'paint', 'drawAtlas');
        t.drawAtlas(atlas, transforms, rects, colors, blendMode, cullRect, paint);
        return null;
      },
      'drawRawAtlas': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 7, 'drawRawAtlas');
        final atlas = D4.getRequiredArg<$dart_ui.Image>(positional, 0, 'atlas', 'drawRawAtlas');
        final rstTransforms = D4.getRequiredArg<Float32List>(positional, 1, 'rstTransforms', 'drawRawAtlas');
        final rects = D4.getRequiredArg<Float32List>(positional, 2, 'rects', 'drawRawAtlas');
        final colors = D4.getRequiredArg<Int32List?>(positional, 3, 'colors', 'drawRawAtlas');
        final blendMode = D4.getRequiredArg<$dart_ui.BlendMode?>(positional, 4, 'blendMode', 'drawRawAtlas');
        final cullRect = D4.getRequiredArg<$dart_ui.Rect?>(positional, 5, 'cullRect', 'drawRawAtlas');
        final paint = D4.getRequiredArg<$dart_ui.Paint>(positional, 6, 'paint', 'drawRawAtlas');
        t.drawRawAtlas(atlas, rstTransforms, rects, colors, blendMode, cullRect, paint);
        return null;
      },
      'drawShadow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Canvas>(target, 'Canvas');
        D4.requireMinArgs(positional, 4, 'drawShadow');
        final path = D4.getRequiredArg<$dart_ui.Path>(positional, 0, 'path', 'drawShadow');
        final color = D4.getRequiredArg<$dart_ui.Color>(positional, 1, 'color', 'drawShadow');
        final elevation = D4.getRequiredArg<double>(positional, 2, 'elevation', 'drawShadow');
        final transparentOccluder = D4.getRequiredArg<bool>(positional, 3, 'transparentOccluder', 'drawShadow');
        t.drawShadow(path, color, elevation, transparentOccluder);
        return null;
      },
    },
    constructorSignatures: {
      '': 'factory Canvas(PictureRecorder recorder, [Rect? cullRect])',
    },
    methodSignatures: {
      'save': 'void save()',
      'saveLayer': 'void saveLayer(Rect? bounds, Paint paint)',
      'restore': 'void restore()',
      'restoreToCount': 'void restoreToCount(int count)',
      'getSaveCount': 'int getSaveCount()',
      'translate': 'void translate(double dx, double dy)',
      'scale': 'void scale(double sx, [double? sy])',
      'rotate': 'void rotate(double radians)',
      'skew': 'void skew(double sx, double sy)',
      'transform': 'void transform(Float64List matrix4)',
      'getTransform': 'Float64List getTransform()',
      'clipRect': 'void clipRect(Rect rect, {ClipOp clipOp = ClipOp.intersect, bool doAntiAlias = true})',
      'clipRRect': 'void clipRRect(RRect rrect, {bool doAntiAlias = true})',
      'clipRSuperellipse': 'void clipRSuperellipse(RSuperellipse rsuperellipse, {bool doAntiAlias = true})',
      'clipPath': 'void clipPath(Path path, {bool doAntiAlias = true})',
      'getLocalClipBounds': 'Rect getLocalClipBounds()',
      'getDestinationClipBounds': 'Rect getDestinationClipBounds()',
      'drawColor': 'void drawColor(Color color, BlendMode blendMode)',
      'drawLine': 'void drawLine(Offset p1, Offset p2, Paint paint)',
      'drawPaint': 'void drawPaint(Paint paint)',
      'drawRect': 'void drawRect(Rect rect, Paint paint)',
      'drawRRect': 'void drawRRect(RRect rrect, Paint paint)',
      'drawDRRect': 'void drawDRRect(RRect outer, RRect inner, Paint paint)',
      'drawRSuperellipse': 'void drawRSuperellipse(RSuperellipse rsuperellipse, Paint paint)',
      'drawOval': 'void drawOval(Rect rect, Paint paint)',
      'drawCircle': 'void drawCircle(Offset c, double radius, Paint paint)',
      'drawArc': 'void drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint paint)',
      'drawPath': 'void drawPath(Path path, Paint paint)',
      'drawImage': 'void drawImage(Image image, Offset offset, Paint paint)',
      'drawImageRect': 'void drawImageRect(Image image, Rect src, Rect dst, Paint paint)',
      'drawImageNine': 'void drawImageNine(Image image, Rect center, Rect dst, Paint paint)',
      'drawPicture': 'void drawPicture(Picture picture)',
      'drawParagraph': 'void drawParagraph(Paragraph paragraph, Offset offset)',
      'drawPoints': 'void drawPoints(PointMode pointMode, List<Offset> points, Paint paint)',
      'drawRawPoints': 'void drawRawPoints(PointMode pointMode, Float32List points, Paint paint)',
      'drawVertices': 'void drawVertices(Vertices vertices, BlendMode blendMode, Paint paint)',
      'drawAtlas': 'void drawAtlas(Image atlas, List<RSTransform> transforms, List<Rect> rects, List<Color>? colors, BlendMode? blendMode, Rect? cullRect, Paint paint)',
      'drawRawAtlas': 'void drawRawAtlas(Image atlas, Float32List rstTransforms, Float32List rects, Int32List? colors, BlendMode? blendMode, Rect? cullRect, Paint paint)',
      'drawShadow': 'void drawShadow(Path path, Color color, double elevation, bool transparentOccluder)',
    },
  );
}

// =============================================================================
// Picture Bridge
// =============================================================================

BridgedClass _createPictureBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Picture,
    name: 'Picture',
    constructors: {
    },
    getters: {
      'debugDisposed': (visitor, target) => D4.validateTarget<$dart_ui.Picture>(target, 'Picture').debugDisposed,
      'approximateBytesUsed': (visitor, target) => D4.validateTarget<$dart_ui.Picture>(target, 'Picture').approximateBytesUsed,
    },
    methods: {
      'toImage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Picture>(target, 'Picture');
        D4.requireMinArgs(positional, 2, 'toImage');
        final width = D4.getRequiredArg<int>(positional, 0, 'width', 'toImage');
        final height = D4.getRequiredArg<int>(positional, 1, 'height', 'toImage');
        return t.toImage(width, height);
      },
      'toImageSync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Picture>(target, 'Picture');
        D4.requireMinArgs(positional, 2, 'toImageSync');
        final width = D4.getRequiredArg<int>(positional, 0, 'width', 'toImageSync');
        final height = D4.getRequiredArg<int>(positional, 1, 'height', 'toImageSync');
        final targetFormat = D4.getNamedArgWithDefault<$dart_ui.TargetPixelFormat>(named, 'targetFormat', $dart_ui.TargetPixelFormat.dontCare);
        return t.toImageSync(width, height, targetFormat: targetFormat);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Picture>(target, 'Picture');
        (t as dynamic).dispose();
        return null;
      },
    },
    staticGetters: {
      'onCreate': (visitor) => $dart_ui.Picture.onCreate,
      'onDispose': (visitor) => $dart_ui.Picture.onDispose,
    },
    staticSetters: {
      'onCreate': (visitor, value) => 
        $dart_ui.Picture.onCreate = value as PictureEventCallback?,
      'onDispose': (visitor, value) => 
        $dart_ui.Picture.onDispose = value as PictureEventCallback?,
    },
    methodSignatures: {
      'toImage': 'Future<Image> toImage(int width, int height)',
      'toImageSync': 'Image toImageSync(int width, int height, {TargetPixelFormat targetFormat = TargetPixelFormat.dontCare})',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'debugDisposed': 'bool get debugDisposed',
      'approximateBytesUsed': 'int get approximateBytesUsed',
    },
    staticGetterSignatures: {
      'onCreate': 'PictureEventCallback? get onCreate',
      'onDispose': 'PictureEventCallback? get onDispose',
    },
    staticSetterSignatures: {
      'onCreate': 'set onCreate(dynamic value)',
      'onDispose': 'set onDispose(dynamic value)',
    },
  );
}

// =============================================================================
// PictureRecorder Bridge
// =============================================================================

BridgedClass _createPictureRecorderBridge() {
  return BridgedClass(
    nativeType: $dart_ui.PictureRecorder,
    name: 'PictureRecorder',
    constructors: {
      '': (visitor, positional, named) {
        return $dart_ui.PictureRecorder();
      },
    },
    getters: {
      'isRecording': (visitor, target) => D4.validateTarget<$dart_ui.PictureRecorder>(target, 'PictureRecorder').isRecording,
    },
    methods: {
      'endRecording': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PictureRecorder>(target, 'PictureRecorder');
        return t.endRecording();
      },
    },
    constructorSignatures: {
      '': 'factory PictureRecorder()',
    },
    methodSignatures: {
      'endRecording': 'Picture endRecording()',
    },
    getterSignatures: {
      'isRecording': 'bool get isRecording',
    },
  );
}

// =============================================================================
// Shadow Bridge
// =============================================================================

BridgedClass _createShadowBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Shadow,
    name: 'Shadow',
    constructors: {
      '': (visitor, positional, named) {
        final offset = D4.getNamedArgWithDefault<$dart_ui.Offset>(named, 'offset', $dart_ui.Offset.zero);
        final blurRadius = D4.getNamedArgWithDefault<double>(named, 'blurRadius', 0.0);
        if (!named.containsKey('color')) {
          return $dart_ui.Shadow(offset: offset, blurRadius: blurRadius);
        }
        if (named.containsKey('color')) {
          final color = D4.getRequiredNamedArg<$dart_ui.Color>(named, 'color', 'Shadow');
          return $dart_ui.Shadow(offset: offset, blurRadius: blurRadius, color: color);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'color': (visitor, target) => D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow').color,
      'offset': (visitor, target) => D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow').offset,
      'blurRadius': (visitor, target) => D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow').blurRadius,
      'blurSigma': (visitor, target) => D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow').blurSigma,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow').hashCode,
    },
    methods: {
      'toPaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow');
        return t.toPaint();
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Shadow>(target, 'Shadow');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'convertRadiusToSigma': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'convertRadiusToSigma');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'convertRadiusToSigma');
        return $dart_ui.Shadow.convertRadiusToSigma(radius);
      },
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.Shadow?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.Shadow?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.Shadow.lerp(a, b, t_);
      },
      'lerpList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerpList');
        if (positional.isEmpty) {
          throw ArgumentError('lerpList: Missing required argument "a" at position 0');
        }
        final a = D4.coerceListOrNull<$dart_ui.Shadow>(positional[0], 'a');
        if (positional.length <= 1) {
          throw ArgumentError('lerpList: Missing required argument "b" at position 1');
        }
        final b = D4.coerceListOrNull<$dart_ui.Shadow>(positional[1], 'b');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerpList');
        return $dart_ui.Shadow.lerpList(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const Shadow({Color color = const Color(_kColorDefault), Offset offset = Offset.zero, double blurRadius = 0.0})',
    },
    methodSignatures: {
      'toPaint': 'Paint toPaint()',
      'scale': 'Shadow scale(double factor)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'color': 'Color get color',
      'offset': 'Offset get offset',
      'blurRadius': 'double get blurRadius',
      'blurSigma': 'double get blurSigma',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'convertRadiusToSigma': 'double convertRadiusToSigma(double radius)',
      'lerp': 'Shadow? lerp(Shadow? a, Shadow? b, double t)',
      'lerpList': 'List<Shadow>? lerpList(List<Shadow>? a, List<Shadow>? b, double t)',
    },
  );
}

// =============================================================================
// ImmutableBuffer Bridge
// =============================================================================

BridgedClass _createImmutableBufferBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ImmutableBuffer,
    name: 'ImmutableBuffer',
    constructors: {
    },
    getters: {
      'length': (visitor, target) => D4.validateTarget<$dart_ui.ImmutableBuffer>(target, 'ImmutableBuffer').length,
      'debugDisposed': (visitor, target) => D4.validateTarget<$dart_ui.ImmutableBuffer>(target, 'ImmutableBuffer').debugDisposed,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ImmutableBuffer>(target, 'ImmutableBuffer');
        (t as dynamic).dispose();
        return null;
      },
    },
    staticMethods: {
      'fromUint8List': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromUint8List');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'fromUint8List');
        return $dart_ui.ImmutableBuffer.fromUint8List(list);
      },
      'fromAsset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromAsset');
        final assetKey = D4.getRequiredArg<String>(positional, 0, 'assetKey', 'fromAsset');
        return $dart_ui.ImmutableBuffer.fromAsset(assetKey);
      },
      'fromFilePath': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromFilePath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'fromFilePath');
        return $dart_ui.ImmutableBuffer.fromFilePath(path);
      },
    },
    methodSignatures: {
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'length': 'int get length',
      'debugDisposed': 'bool get debugDisposed',
    },
    staticMethodSignatures: {
      'fromUint8List': 'Future<ImmutableBuffer> fromUint8List(Uint8List list)',
      'fromAsset': 'Future<ImmutableBuffer> fromAsset(String assetKey)',
      'fromFilePath': 'Future<ImmutableBuffer> fromFilePath(String path)',
    },
  );
}

// =============================================================================
// ImageDescriptor Bridge
// =============================================================================

BridgedClass _createImageDescriptorBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ImageDescriptor,
    name: 'ImageDescriptor',
    constructors: {
      'raw': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ImageDescriptor');
        final buffer = D4.getRequiredArg<$dart_ui.ImmutableBuffer>(positional, 0, 'buffer', 'ImageDescriptor');
        final width = D4.getRequiredNamedArg<int>(named, 'width', 'ImageDescriptor');
        final height = D4.getRequiredNamedArg<int>(named, 'height', 'ImageDescriptor');
        final rowBytes = D4.getOptionalNamedArg<int?>(named, 'rowBytes');
        final pixelFormat = D4.getRequiredNamedArg<$dart_ui.PixelFormat>(named, 'pixelFormat', 'ImageDescriptor');
        return $dart_ui.ImageDescriptor.raw(buffer, width: width, height: height, rowBytes: rowBytes, pixelFormat: pixelFormat);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$dart_ui.ImageDescriptor>(target, 'ImageDescriptor').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.ImageDescriptor>(target, 'ImageDescriptor').height,
      'bytesPerPixel': (visitor, target) => D4.validateTarget<$dart_ui.ImageDescriptor>(target, 'ImageDescriptor').bytesPerPixel,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ImageDescriptor>(target, 'ImageDescriptor');
        (t as dynamic).dispose();
        return null;
      },
      'instantiateCodec': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ImageDescriptor>(target, 'ImageDescriptor');
        final targetWidth = D4.getOptionalNamedArg<int?>(named, 'targetWidth');
        final targetHeight = D4.getOptionalNamedArg<int?>(named, 'targetHeight');
        final targetFormat = D4.getNamedArgWithDefault<$dart_ui.TargetPixelFormat>(named, 'targetFormat', $dart_ui.TargetPixelFormat.dontCare);
        return t.instantiateCodec(targetWidth: targetWidth, targetHeight: targetHeight, targetFormat: targetFormat);
      },
    },
    staticMethods: {
      'encoded': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'encoded');
        final buffer = D4.getRequiredArg<$dart_ui.ImmutableBuffer>(positional, 0, 'buffer', 'encoded');
        return $dart_ui.ImageDescriptor.encoded(buffer);
      },
    },
    constructorSignatures: {
      'raw': 'factory ImageDescriptor.raw(ImmutableBuffer buffer, {required int width, required int height, int? rowBytes, required PixelFormat pixelFormat})',
    },
    methodSignatures: {
      'dispose': 'void dispose()',
      'instantiateCodec': 'Future<Codec> instantiateCodec({int? targetWidth, int? targetHeight, TargetPixelFormat targetFormat = TargetPixelFormat.dontCare})',
    },
    getterSignatures: {
      'width': 'int get width',
      'height': 'int get height',
      'bytesPerPixel': 'int get bytesPerPixel',
    },
    staticMethodSignatures: {
      'encoded': 'Future<ImageDescriptor> encoded(ImmutableBuffer buffer)',
    },
  );
}

// =============================================================================
// PictureRasterizationException Bridge
// =============================================================================

BridgedClass _createPictureRasterizationExceptionBridge() {
  return BridgedClass(
    nativeType: PictureRasterizationException,
    name: 'PictureRasterizationException',
    constructors: {
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<PictureRasterizationException>(target, 'PictureRasterizationException').message,
      'stack': (visitor, target) => D4.validateTarget<PictureRasterizationException>(target, 'PictureRasterizationException').stack,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<PictureRasterizationException>(target, 'PictureRasterizationException');
        return t.toString();
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'stack': 'StackTrace? get stack',
    },
  );
}

// =============================================================================
// RootIsolateToken Bridge
// =============================================================================

BridgedClass _createRootIsolateTokenBridge() {
  return BridgedClass(
    nativeType: $dart_ui.RootIsolateToken,
    name: 'RootIsolateToken',
    constructors: {
    },
    staticGetters: {
      'instance': (visitor) => $dart_ui.RootIsolateToken.instance,
    },
    staticGetterSignatures: {
      'instance': 'RootIsolateToken? get instance',
    },
  );
}

// =============================================================================
// PlatformDispatcher Bridge
// =============================================================================

BridgedClass _createPlatformDispatcherBridge() {
  return BridgedClass(
    nativeType: $dart_ui.PlatformDispatcher,
    name: 'PlatformDispatcher',
    constructors: {
    },
    getters: {
      'onPlatformConfigurationChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPlatformConfigurationChanged,
      'displays': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').displays,
      'views': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').views,
      'implicitView': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').implicitView,
      'onMetricsChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onMetricsChanged,
      'engineId': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').engineId,
      'onViewFocusChange': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onViewFocusChange,
      'onBeginFrame': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onBeginFrame,
      'onDrawFrame': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onDrawFrame,
      'onPointerDataPacket': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPointerDataPacket,
      'onKeyData': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onKeyData,
      'onReportTimings': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onReportTimings,
      'onPlatformMessage': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPlatformMessage,
      'accessibilityFeatures': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').accessibilityFeatures,
      'onAccessibilityFeaturesChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onAccessibilityFeaturesChanged,
      'locale': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').locale,
      'locales': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').locales,
      'onLocaleChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onLocaleChanged,
      'initialLifecycleState': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').initialLifecycleState,
      'alwaysUse24HourFormat': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').alwaysUse24HourFormat,
      'lineHeightScaleFactorOverride': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').lineHeightScaleFactorOverride,
      'letterSpacingOverride': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').letterSpacingOverride,
      'wordSpacingOverride': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').wordSpacingOverride,
      'paragraphSpacingOverride': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').paragraphSpacingOverride,
      'textScaleFactor': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').textScaleFactor,
      'onTextScaleFactorChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onTextScaleFactorChanged,
      'nativeSpellCheckServiceDefined': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').nativeSpellCheckServiceDefined,
      'supportsShowingSystemContextMenu': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').supportsShowingSystemContextMenu,
      'brieflyShowPassword': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').brieflyShowPassword,
      'platformBrightness': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').platformBrightness,
      'onPlatformBrightnessChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPlatformBrightnessChanged,
      'systemFontFamily': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').systemFontFamily,
      'onSystemFontFamilyChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onSystemFontFamilyChanged,
      'semanticsEnabled': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').semanticsEnabled,
      'onSemanticsEnabledChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onSemanticsEnabledChanged,
      'onSemanticsActionEvent': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onSemanticsActionEvent,
      'frameData': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').frameData,
      'onFrameDataChanged': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onFrameDataChanged,
      'onError': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onError,
      'defaultRouteName': (visitor, target) => D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').defaultRouteName,
    },
    setters: {
      'onPlatformConfigurationChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPlatformConfigurationChanged = value as dynamic,
      'onMetricsChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onMetricsChanged = value as dynamic,
      'onViewFocusChange': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onViewFocusChange = value as dynamic,
      'onBeginFrame': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onBeginFrame = value as dynamic,
      'onDrawFrame': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onDrawFrame = value as dynamic,
      'onPointerDataPacket': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPointerDataPacket = value as dynamic,
      'onKeyData': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onKeyData = value as dynamic,
      'onReportTimings': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onReportTimings = value as dynamic,
      'onPlatformMessage': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPlatformMessage = value as dynamic,
      'onAccessibilityFeaturesChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onAccessibilityFeaturesChanged = value as dynamic,
      'onLocaleChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onLocaleChanged = value as dynamic,
      'onTextScaleFactorChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onTextScaleFactorChanged = value as dynamic,
      'onPlatformBrightnessChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onPlatformBrightnessChanged = value as dynamic,
      'onSystemFontFamilyChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onSystemFontFamilyChanged = value as dynamic,
      'onSemanticsEnabledChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onSemanticsEnabledChanged = value as dynamic,
      'onSemanticsActionEvent': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onSemanticsActionEvent = value as dynamic,
      'onFrameDataChanged': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onFrameDataChanged = value as dynamic,
      'onError': (visitor, target, value) => 
        D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher').onError = value as dynamic,
    },
    methods: {
      'view': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'view');
        return t.view(id: id);
      },
      'requestViewFocusChange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        final viewId = D4.getRequiredNamedArg<int>(named, 'viewId', 'requestViewFocusChange');
        final state = D4.getRequiredNamedArg<$dart_ui.ViewFocusState>(named, 'state', 'requestViewFocusChange');
        final direction = D4.getRequiredNamedArg<$dart_ui.ViewFocusDirection>(named, 'direction', 'requestViewFocusChange');
        t.requestViewFocusChange(viewId: viewId, state: state, direction: direction);
        return null;
      },
      'sendPlatformMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 3, 'sendPlatformMessage');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'sendPlatformMessage');
        final data = D4.getRequiredArg<ByteData?>(positional, 1, 'data', 'sendPlatformMessage');
        if (positional.length <= 2) {
          throw ArgumentError('sendPlatformMessage: Missing required argument "callback" at position 2');
        }
        final callbackRaw = positional[2];
        t.sendPlatformMessage(name, data, callbackRaw == null ? null : (ByteData? p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'sendPortPlatformMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 4, 'sendPortPlatformMessage');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'sendPortPlatformMessage');
        final data = D4.getRequiredArg<ByteData?>(positional, 1, 'data', 'sendPortPlatformMessage');
        final identifier = D4.getRequiredArg<int>(positional, 2, 'identifier', 'sendPortPlatformMessage');
        final port = D4.getRequiredArg<SendPort>(positional, 3, 'port', 'sendPortPlatformMessage');
        t.sendPortPlatformMessage(name, data, identifier, port);
        return null;
      },
      'registerBackgroundIsolate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'registerBackgroundIsolate');
        final token = D4.getRequiredArg<$dart_ui.RootIsolateToken>(positional, 0, 'token', 'registerBackgroundIsolate');
        t.registerBackgroundIsolate(token);
        return null;
      },
      'setSemanticsTreeEnabled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'setSemanticsTreeEnabled');
        final enabled = D4.getRequiredArg<bool>(positional, 0, 'enabled', 'setSemanticsTreeEnabled');
        t.setSemanticsTreeEnabled(enabled);
        return null;
      },
      'setIsolateDebugName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'setIsolateDebugName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'setIsolateDebugName');
        t.setIsolateDebugName(name);
        return null;
      },
      'requestDartPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'requestDartPerformanceMode');
        final mode = D4.getRequiredArg<$dart_ui.DartPerformanceMode>(positional, 0, 'mode', 'requestDartPerformanceMode');
        t.requestDartPerformanceMode(mode);
        return null;
      },
      'getPersistentIsolateData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        return t.getPersistentIsolateData();
      },
      'scheduleFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        t.scheduleFrame();
        return null;
      },
      'scheduleWarmUpFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        if (!named.containsKey('beginFrame') || named['beginFrame'] == null) {
          throw ArgumentError('scheduleWarmUpFrame: Missing required named argument "beginFrame"');
        }
        final beginFrameRaw = named['beginFrame'];
        if (!named.containsKey('drawFrame') || named['drawFrame'] == null) {
          throw ArgumentError('scheduleWarmUpFrame: Missing required named argument "drawFrame"');
        }
        final drawFrameRaw = named['drawFrame'];
        t.scheduleWarmUpFrame(beginFrame: () { D4.callInterpreterCallback(visitor, beginFrameRaw, []); }, drawFrame: () { D4.callInterpreterCallback(visitor, drawFrameRaw, []); });
        return null;
      },
      'updateSemantics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'updateSemantics');
        final update = D4.getRequiredArg<$dart_ui.SemanticsUpdate>(positional, 0, 'update', 'updateSemantics');
        t.updateSemantics(update);
        return null;
      },
      'setApplicationLocale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'setApplicationLocale');
        final locale = D4.getRequiredArg<$dart_ui.Locale>(positional, 0, 'locale', 'setApplicationLocale');
        t.setApplicationLocale(locale);
        return null;
      },
      'computePlatformResolvedLocale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'computePlatformResolvedLocale');
        if (positional.isEmpty) {
          throw ArgumentError('computePlatformResolvedLocale: Missing required argument "supportedLocales" at position 0');
        }
        final supportedLocales = D4.coerceList<$dart_ui.Locale>(positional[0], 'supportedLocales');
        return t.computePlatformResolvedLocale(supportedLocales);
      },
      'scaleFontSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PlatformDispatcher>(target, 'PlatformDispatcher');
        D4.requireMinArgs(positional, 1, 'scaleFontSize');
        final unscaledFontSize = D4.getRequiredArg<double>(positional, 0, 'unscaledFontSize', 'scaleFontSize');
        return t.scaleFontSize(unscaledFontSize);
      },
    },
    staticGetters: {
      'instance': (visitor) => $dart_ui.PlatformDispatcher.instance,
    },
    methodSignatures: {
      'view': 'FlutterView? view({required int id})',
      'requestViewFocusChange': 'void requestViewFocusChange({required int viewId, required ViewFocusState state, required ViewFocusDirection direction})',
      'sendPlatformMessage': 'void sendPlatformMessage(String name, ByteData? data, PlatformMessageResponseCallback? callback)',
      'sendPortPlatformMessage': 'void sendPortPlatformMessage(String name, ByteData? data, int identifier, SendPort port)',
      'registerBackgroundIsolate': 'void registerBackgroundIsolate(RootIsolateToken token)',
      'setSemanticsTreeEnabled': 'void setSemanticsTreeEnabled(bool enabled)',
      'setIsolateDebugName': 'void setIsolateDebugName(String name)',
      'requestDartPerformanceMode': 'void requestDartPerformanceMode(DartPerformanceMode mode)',
      'getPersistentIsolateData': 'ByteData? getPersistentIsolateData()',
      'scheduleFrame': 'void scheduleFrame()',
      'scheduleWarmUpFrame': 'void scheduleWarmUpFrame({required VoidCallback beginFrame, required VoidCallback drawFrame})',
      'updateSemantics': 'void updateSemantics(SemanticsUpdate update)',
      'setApplicationLocale': 'void setApplicationLocale(Locale locale)',
      'computePlatformResolvedLocale': 'Locale? computePlatformResolvedLocale(List<Locale> supportedLocales)',
      'scaleFontSize': 'double scaleFontSize(double unscaledFontSize)',
    },
    getterSignatures: {
      'onPlatformConfigurationChanged': 'VoidCallback? get onPlatformConfigurationChanged',
      'displays': 'Iterable<Display> get displays',
      'views': 'Iterable<FlutterView> get views',
      'implicitView': 'FlutterView? get implicitView',
      'onMetricsChanged': 'VoidCallback? get onMetricsChanged',
      'engineId': 'int? get engineId',
      'onViewFocusChange': 'ViewFocusChangeCallback? get onViewFocusChange',
      'onBeginFrame': 'FrameCallback? get onBeginFrame',
      'onDrawFrame': 'VoidCallback? get onDrawFrame',
      'onPointerDataPacket': 'PointerDataPacketCallback? get onPointerDataPacket',
      'onKeyData': 'KeyDataCallback? get onKeyData',
      'onReportTimings': 'TimingsCallback? get onReportTimings',
      'onPlatformMessage': 'PlatformMessageCallback? get onPlatformMessage',
      'accessibilityFeatures': 'AccessibilityFeatures get accessibilityFeatures',
      'onAccessibilityFeaturesChanged': 'VoidCallback? get onAccessibilityFeaturesChanged',
      'locale': 'Locale get locale',
      'locales': 'List<Locale> get locales',
      'onLocaleChanged': 'VoidCallback? get onLocaleChanged',
      'initialLifecycleState': 'String get initialLifecycleState',
      'alwaysUse24HourFormat': 'bool get alwaysUse24HourFormat',
      'lineHeightScaleFactorOverride': 'double? get lineHeightScaleFactorOverride',
      'letterSpacingOverride': 'double? get letterSpacingOverride',
      'wordSpacingOverride': 'double? get wordSpacingOverride',
      'paragraphSpacingOverride': 'double? get paragraphSpacingOverride',
      'textScaleFactor': 'double get textScaleFactor',
      'onTextScaleFactorChanged': 'VoidCallback? get onTextScaleFactorChanged',
      'nativeSpellCheckServiceDefined': 'bool get nativeSpellCheckServiceDefined',
      'supportsShowingSystemContextMenu': 'bool get supportsShowingSystemContextMenu',
      'brieflyShowPassword': 'bool get brieflyShowPassword',
      'platformBrightness': 'Brightness get platformBrightness',
      'onPlatformBrightnessChanged': 'VoidCallback? get onPlatformBrightnessChanged',
      'systemFontFamily': 'String? get systemFontFamily',
      'onSystemFontFamilyChanged': 'VoidCallback? get onSystemFontFamilyChanged',
      'semanticsEnabled': 'bool get semanticsEnabled',
      'onSemanticsEnabledChanged': 'VoidCallback? get onSemanticsEnabledChanged',
      'onSemanticsActionEvent': 'SemanticsActionEventCallback? get onSemanticsActionEvent',
      'frameData': 'FrameData get frameData',
      'onFrameDataChanged': 'VoidCallback? get onFrameDataChanged',
      'onError': 'ErrorCallback? get onError',
      'defaultRouteName': 'String get defaultRouteName',
    },
    setterSignatures: {
      'onPlatformConfigurationChanged': 'set onPlatformConfigurationChanged(VoidCallback? value)',
      'onMetricsChanged': 'set onMetricsChanged(VoidCallback? value)',
      'onViewFocusChange': 'set onViewFocusChange(ViewFocusChangeCallback? value)',
      'onBeginFrame': 'set onBeginFrame(FrameCallback? value)',
      'onDrawFrame': 'set onDrawFrame(VoidCallback? value)',
      'onPointerDataPacket': 'set onPointerDataPacket(PointerDataPacketCallback? value)',
      'onKeyData': 'set onKeyData(KeyDataCallback? value)',
      'onReportTimings': 'set onReportTimings(TimingsCallback? value)',
      'onPlatformMessage': 'set onPlatformMessage(PlatformMessageCallback? value)',
      'onAccessibilityFeaturesChanged': 'set onAccessibilityFeaturesChanged(VoidCallback? value)',
      'onLocaleChanged': 'set onLocaleChanged(VoidCallback? value)',
      'onTextScaleFactorChanged': 'set onTextScaleFactorChanged(VoidCallback? value)',
      'onPlatformBrightnessChanged': 'set onPlatformBrightnessChanged(VoidCallback? value)',
      'onSystemFontFamilyChanged': 'set onSystemFontFamilyChanged(VoidCallback? value)',
      'onSemanticsEnabledChanged': 'set onSemanticsEnabledChanged(VoidCallback? value)',
      'onSemanticsActionEvent': 'set onSemanticsActionEvent(SemanticsActionEventCallback? value)',
      'onFrameDataChanged': 'set onFrameDataChanged(VoidCallback? value)',
      'onError': 'set onError(ErrorCallback? value)',
    },
    staticGetterSignatures: {
      'instance': 'PlatformDispatcher get instance',
    },
  );
}

// =============================================================================
// SystemColor Bridge
// =============================================================================

BridgedClass _createSystemColorBridge() {
  return BridgedClass(
    nativeType: $dart_ui.SystemColor,
    name: 'SystemColor',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SystemColor');
        final value = D4.getOptionalNamedArg<$dart_ui.Color?>(named, 'value');
        return $dart_ui.SystemColor(name: name, value: value);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dart_ui.SystemColor>(target, 'SystemColor').name,
      'value': (visitor, target) => D4.validateTarget<$dart_ui.SystemColor>(target, 'SystemColor').value,
      'isSupported': (visitor, target) => D4.validateTarget<$dart_ui.SystemColor>(target, 'SystemColor').isSupported,
    },
    staticGetters: {
      'platformProvidesSystemColors': (visitor) => $dart_ui.SystemColor.platformProvidesSystemColors,
      'light': (visitor) => $dart_ui.SystemColor.light,
      'dark': (visitor) => $dart_ui.SystemColor.dark,
    },
    constructorSignatures: {
      '': 'const SystemColor({required String name, Color? value})',
    },
    getterSignatures: {
      'name': 'String get name',
      'value': 'Color? get value',
      'isSupported': 'bool get isSupported',
    },
    staticGetterSignatures: {
      'platformProvidesSystemColors': 'bool get platformProvidesSystemColors',
      'light': 'SystemColorPalette get light',
      'dark': 'SystemColorPalette get dark',
    },
  );
}

// =============================================================================
// SystemColorPalette Bridge
// =============================================================================

BridgedClass _createSystemColorPaletteBridge() {
  return BridgedClass(
    nativeType: $dart_ui.SystemColorPalette,
    name: 'SystemColorPalette',
    constructors: {
    },
    getters: {
      'brightness': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').brightness,
      'accentColor': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').accentColor,
      'accentColorText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').accentColorText,
      'activeText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').activeText,
      'buttonBorder': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').buttonBorder,
      'buttonFace': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').buttonFace,
      'buttonText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').buttonText,
      'canvas': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').canvas,
      'canvasText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').canvasText,
      'field': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').field,
      'fieldText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').fieldText,
      'grayText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').grayText,
      'highlight': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').highlight,
      'highlightText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').highlightText,
      'linkText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').linkText,
      'mark': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').mark,
      'markText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').markText,
      'selectedItem': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').selectedItem,
      'selectedItemText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').selectedItemText,
      'visitedText': (visitor, target) => D4.validateTarget<$dart_ui.SystemColorPalette>(target, 'SystemColorPalette').visitedText,
    },
    getterSignatures: {
      'brightness': 'Brightness get brightness',
      'accentColor': 'SystemColor get accentColor',
      'accentColorText': 'SystemColor get accentColorText',
      'activeText': 'SystemColor get activeText',
      'buttonBorder': 'SystemColor get buttonBorder',
      'buttonFace': 'SystemColor get buttonFace',
      'buttonText': 'SystemColor get buttonText',
      'canvas': 'SystemColor get canvas',
      'canvasText': 'SystemColor get canvasText',
      'field': 'SystemColor get field',
      'fieldText': 'SystemColor get fieldText',
      'grayText': 'SystemColor get grayText',
      'highlight': 'SystemColor get highlight',
      'highlightText': 'SystemColor get highlightText',
      'linkText': 'SystemColor get linkText',
      'mark': 'SystemColor get mark',
      'markText': 'SystemColor get markText',
      'selectedItem': 'SystemColor get selectedItem',
      'selectedItemText': 'SystemColor get selectedItemText',
      'visitedText': 'SystemColor get visitedText',
    },
  );
}

// =============================================================================
// FrameTiming Bridge
// =============================================================================

BridgedClass _createFrameTimingBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FrameTiming,
    name: 'FrameTiming',
    constructors: {
      '': (visitor, positional, named) {
        final vsyncStart = D4.getRequiredNamedArg<int>(named, 'vsyncStart', 'FrameTiming');
        final buildStart = D4.getRequiredNamedArg<int>(named, 'buildStart', 'FrameTiming');
        final buildFinish = D4.getRequiredNamedArg<int>(named, 'buildFinish', 'FrameTiming');
        final rasterStart = D4.getRequiredNamedArg<int>(named, 'rasterStart', 'FrameTiming');
        final rasterFinish = D4.getRequiredNamedArg<int>(named, 'rasterFinish', 'FrameTiming');
        final rasterFinishWallTime = D4.getRequiredNamedArg<int>(named, 'rasterFinishWallTime', 'FrameTiming');
        final layerCacheCount = D4.getNamedArgWithDefault<int>(named, 'layerCacheCount', 0);
        final layerCacheBytes = D4.getNamedArgWithDefault<int>(named, 'layerCacheBytes', 0);
        final pictureCacheCount = D4.getNamedArgWithDefault<int>(named, 'pictureCacheCount', 0);
        final pictureCacheBytes = D4.getNamedArgWithDefault<int>(named, 'pictureCacheBytes', 0);
        final frameNumber = D4.getNamedArgWithDefault<int>(named, 'frameNumber', -1);
        return $dart_ui.FrameTiming(vsyncStart: vsyncStart, buildStart: buildStart, buildFinish: buildFinish, rasterStart: rasterStart, rasterFinish: rasterFinish, rasterFinishWallTime: rasterFinishWallTime, layerCacheCount: layerCacheCount, layerCacheBytes: layerCacheBytes, pictureCacheCount: pictureCacheCount, pictureCacheBytes: pictureCacheBytes, frameNumber: frameNumber);
      },
    },
    getters: {
      'buildDuration': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').buildDuration,
      'rasterDuration': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').rasterDuration,
      'vsyncOverhead': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').vsyncOverhead,
      'totalSpan': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').totalSpan,
      'layerCacheCount': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').layerCacheCount,
      'layerCacheBytes': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').layerCacheBytes,
      'layerCacheMegabytes': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').layerCacheMegabytes,
      'pictureCacheCount': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').pictureCacheCount,
      'pictureCacheBytes': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').pictureCacheBytes,
      'pictureCacheMegabytes': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').pictureCacheMegabytes,
      'frameNumber': (visitor, target) => D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming').frameNumber,
    },
    methods: {
      'timestampInMicroseconds': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming');
        D4.requireMinArgs(positional, 1, 'timestampInMicroseconds');
        final phase = D4.getRequiredArg<$dart_ui.FramePhase>(positional, 0, 'phase', 'timestampInMicroseconds');
        return t.timestampInMicroseconds(phase);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FrameTiming>(target, 'FrameTiming');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'factory FrameTiming({required int vsyncStart, required int buildStart, required int buildFinish, required int rasterStart, required int rasterFinish, required int rasterFinishWallTime, int layerCacheCount = 0, int layerCacheBytes = 0, int pictureCacheCount = 0, int pictureCacheBytes = 0, int frameNumber = -1})',
    },
    methodSignatures: {
      'timestampInMicroseconds': 'int timestampInMicroseconds(FramePhase phase)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'buildDuration': 'Duration get buildDuration',
      'rasterDuration': 'Duration get rasterDuration',
      'vsyncOverhead': 'Duration get vsyncOverhead',
      'totalSpan': 'Duration get totalSpan',
      'layerCacheCount': 'int get layerCacheCount',
      'layerCacheBytes': 'int get layerCacheBytes',
      'layerCacheMegabytes': 'double get layerCacheMegabytes',
      'pictureCacheCount': 'int get pictureCacheCount',
      'pictureCacheBytes': 'int get pictureCacheBytes',
      'pictureCacheMegabytes': 'double get pictureCacheMegabytes',
      'frameNumber': 'int get frameNumber',
    },
  );
}

// =============================================================================
// ViewPadding Bridge
// =============================================================================

BridgedClass _createViewPaddingBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ViewPadding,
    name: 'ViewPadding',
    constructors: {
    },
    getters: {
      'left': (visitor, target) => D4.validateTarget<$dart_ui.ViewPadding>(target, 'ViewPadding').left,
      'top': (visitor, target) => D4.validateTarget<$dart_ui.ViewPadding>(target, 'ViewPadding').top,
      'right': (visitor, target) => D4.validateTarget<$dart_ui.ViewPadding>(target, 'ViewPadding').right,
      'bottom': (visitor, target) => D4.validateTarget<$dart_ui.ViewPadding>(target, 'ViewPadding').bottom,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ViewPadding>(target, 'ViewPadding');
        return t.toString();
      },
    },
    staticGetters: {
      'zero': (visitor) => $dart_ui.ViewPadding.zero,
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'left': 'double get left',
      'top': 'double get top',
      'right': 'double get right',
      'bottom': 'double get bottom',
    },
    staticGetterSignatures: {
      'zero': 'ViewPadding get zero',
    },
  );
}

// =============================================================================
// ViewConstraints Bridge
// =============================================================================

BridgedClass _createViewConstraintsBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ViewConstraints,
    name: 'ViewConstraints',
    constructors: {
      '': (visitor, positional, named) {
        final minWidth = D4.getNamedArgWithDefault<double>(named, 'minWidth', 0.0);
        final minHeight = D4.getNamedArgWithDefault<double>(named, 'minHeight', 0.0);
        if (!named.containsKey('maxWidth') && !named.containsKey('maxHeight')) {
          return $dart_ui.ViewConstraints(minWidth: minWidth, minHeight: minHeight);
        }
        if (named.containsKey('maxWidth') && !named.containsKey('maxHeight')) {
          final maxWidth = D4.getRequiredNamedArg<double>(named, 'maxWidth', 'ViewConstraints');
          return $dart_ui.ViewConstraints(minWidth: minWidth, minHeight: minHeight, maxWidth: maxWidth);
        }
        if (!named.containsKey('maxWidth') && named.containsKey('maxHeight')) {
          final maxHeight = D4.getRequiredNamedArg<double>(named, 'maxHeight', 'ViewConstraints');
          return $dart_ui.ViewConstraints(minWidth: minWidth, minHeight: minHeight, maxHeight: maxHeight);
        }
        if (named.containsKey('maxWidth') && named.containsKey('maxHeight')) {
          final maxWidth = D4.getRequiredNamedArg<double>(named, 'maxWidth', 'ViewConstraints');
          final maxHeight = D4.getRequiredNamedArg<double>(named, 'maxHeight', 'ViewConstraints');
          return $dart_ui.ViewConstraints(minWidth: minWidth, minHeight: minHeight, maxWidth: maxWidth, maxHeight: maxHeight);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'tight': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ViewConstraints');
        final size = D4.getRequiredArg<$dart_ui.Size>(positional, 0, 'size', 'ViewConstraints');
        return $dart_ui.ViewConstraints.tight(size);
      },
    },
    getters: {
      'minWidth': (visitor, target) => D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints').minWidth,
      'maxWidth': (visitor, target) => D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints').maxWidth,
      'minHeight': (visitor, target) => D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints').minHeight,
      'maxHeight': (visitor, target) => D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints').maxHeight,
      'isTight': (visitor, target) => D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints').isTight,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints').hashCode,
    },
    methods: {
      'isSatisfiedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints');
        D4.requireMinArgs(positional, 1, 'isSatisfiedBy');
        final size = D4.getRequiredArg<$dart_ui.Size>(positional, 0, 'size', 'isSatisfiedBy');
        return t.isSatisfiedBy(size);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints');
        return t.toString();
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ViewConstraints>(target, 'ViewConstraints');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ViewConstraints({double minWidth = 0.0, double maxWidth = double.infinity, double minHeight = 0.0, double maxHeight = double.infinity})',
      'tight': 'ViewConstraints.tight(Size size)',
    },
    methodSignatures: {
      'isSatisfiedBy': 'bool isSatisfiedBy(Size size)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'minWidth': 'double get minWidth',
      'maxWidth': 'double get maxWidth',
      'minHeight': 'double get minHeight',
      'maxHeight': 'double get maxHeight',
      'isTight': 'bool get isTight',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// DisplayFeature Bridge
// =============================================================================

BridgedClass _createDisplayFeatureBridge() {
  return BridgedClass(
    nativeType: $dart_ui.DisplayFeature,
    name: 'DisplayFeature',
    constructors: {
      '': (visitor, positional, named) {
        final bounds = D4.getRequiredNamedArg<$dart_ui.Rect>(named, 'bounds', 'DisplayFeature');
        final type = D4.getRequiredNamedArg<$dart_ui.DisplayFeatureType>(named, 'type', 'DisplayFeature');
        final state = D4.getRequiredNamedArg<$dart_ui.DisplayFeatureState>(named, 'state', 'DisplayFeature');
        return $dart_ui.DisplayFeature(bounds: bounds, type: type, state: state);
      },
    },
    getters: {
      'bounds': (visitor, target) => D4.validateTarget<$dart_ui.DisplayFeature>(target, 'DisplayFeature').bounds,
      'type': (visitor, target) => D4.validateTarget<$dart_ui.DisplayFeature>(target, 'DisplayFeature').type,
      'state': (visitor, target) => D4.validateTarget<$dart_ui.DisplayFeature>(target, 'DisplayFeature').state,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.DisplayFeature>(target, 'DisplayFeature').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.DisplayFeature>(target, 'DisplayFeature');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.DisplayFeature>(target, 'DisplayFeature');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const DisplayFeature({required Rect bounds, required DisplayFeatureType type, required DisplayFeatureState state})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bounds': 'Rect get bounds',
      'type': 'DisplayFeatureType get type',
      'state': 'DisplayFeatureState get state',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Locale Bridge
// =============================================================================

BridgedClass _createLocaleBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Locale,
    name: 'Locale',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Locale');
        final languageCode = D4.getRequiredArg<String>(positional, 0, '_languageCode', 'Locale');
        final countryCode = D4.getOptionalArg<String?>(positional, 1, '_countryCode');
        return $dart_ui.Locale(languageCode, countryCode);
      },
      'fromSubtags': (visitor, positional, named) {
        final languageCode = D4.getNamedArgWithDefault<String>(named, 'languageCode', 'und');
        final scriptCode = D4.getOptionalNamedArg<String?>(named, 'scriptCode');
        final countryCode = D4.getOptionalNamedArg<String?>(named, 'countryCode');
        return $dart_ui.Locale.fromSubtags(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
      },
    },
    getters: {
      'languageCode': (visitor, target) => D4.validateTarget<$dart_ui.Locale>(target, 'Locale').languageCode,
      'scriptCode': (visitor, target) => D4.validateTarget<$dart_ui.Locale>(target, 'Locale').scriptCode,
      'countryCode': (visitor, target) => D4.validateTarget<$dart_ui.Locale>(target, 'Locale').countryCode,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.Locale>(target, 'Locale').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Locale>(target, 'Locale');
        return t.toString();
      },
      'toLanguageTag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Locale>(target, 'Locale');
        return t.toLanguageTag();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Locale>(target, 'Locale');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const Locale(String _languageCode, [String? _countryCode])',
      'fromSubtags': 'const Locale.fromSubtags({String languageCode = \'und\', String? scriptCode, String? countryCode})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'toLanguageTag': 'String toLanguageTag()',
    },
    getterSignatures: {
      'languageCode': 'String get languageCode',
      'scriptCode': 'String? get scriptCode',
      'countryCode': 'String? get countryCode',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// SemanticsActionEvent Bridge
// =============================================================================

BridgedClass _createSemanticsActionEventBridge() {
  return BridgedClass(
    nativeType: $dart_ui.SemanticsActionEvent,
    name: 'SemanticsActionEvent',
    constructors: {
      '': (visitor, positional, named) {
        final type = D4.getRequiredNamedArg<$dart_ui.SemanticsAction>(named, 'type', 'SemanticsActionEvent');
        final viewId = D4.getRequiredNamedArg<int>(named, 'viewId', 'SemanticsActionEvent');
        final nodeId = D4.getRequiredNamedArg<int>(named, 'nodeId', 'SemanticsActionEvent');
        final arguments = D4.getOptionalNamedArg<Object?>(named, 'arguments');
        return $dart_ui.SemanticsActionEvent(type: type, viewId: viewId, nodeId: nodeId, arguments: arguments);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsActionEvent>(target, 'SemanticsActionEvent').type,
      'viewId': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsActionEvent>(target, 'SemanticsActionEvent').viewId,
      'nodeId': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsActionEvent>(target, 'SemanticsActionEvent').nodeId,
      'arguments': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsActionEvent>(target, 'SemanticsActionEvent').arguments,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsActionEvent>(target, 'SemanticsActionEvent');
        final type = D4.getOptionalNamedArg<$dart_ui.SemanticsAction?>(named, 'type');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        if (!named.containsKey('arguments')) {
          return t.copyWith(type: type, viewId: viewId, nodeId: nodeId);
        }
        if (named.containsKey('arguments')) {
          final arguments = D4.getRequiredNamedArg<Object?>(named, 'arguments', 'copyWith');
          return t.copyWith(type: type, viewId: viewId, nodeId: nodeId, arguments: arguments);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    constructorSignatures: {
      '': 'const SemanticsActionEvent({required SemanticsAction type, required int viewId, required int nodeId, Object? arguments})',
    },
    methodSignatures: {
      'copyWith': 'SemanticsActionEvent copyWith({SemanticsAction? type, int? viewId, int? nodeId, Object? arguments = _noArgumentPlaceholder})',
    },
    getterSignatures: {
      'type': 'SemanticsAction get type',
      'viewId': 'int get viewId',
      'nodeId': 'int get nodeId',
      'arguments': 'Object? get arguments',
    },
  );
}

// =============================================================================
// ViewFocusEvent Bridge
// =============================================================================

BridgedClass _createViewFocusEventBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ViewFocusEvent,
    name: 'ViewFocusEvent',
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getRequiredNamedArg<int>(named, 'viewId', 'ViewFocusEvent');
        final state = D4.getRequiredNamedArg<$dart_ui.ViewFocusState>(named, 'state', 'ViewFocusEvent');
        final direction = D4.getRequiredNamedArg<$dart_ui.ViewFocusDirection>(named, 'direction', 'ViewFocusEvent');
        return $dart_ui.ViewFocusEvent(viewId: viewId, state: state, direction: direction);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$dart_ui.ViewFocusEvent>(target, 'ViewFocusEvent').viewId,
      'state': (visitor, target) => D4.validateTarget<$dart_ui.ViewFocusEvent>(target, 'ViewFocusEvent').state,
      'direction': (visitor, target) => D4.validateTarget<$dart_ui.ViewFocusEvent>(target, 'ViewFocusEvent').direction,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ViewFocusEvent>(target, 'ViewFocusEvent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ViewFocusEvent({required int viewId, required ViewFocusState state, required ViewFocusDirection direction})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'state': 'ViewFocusState get state',
      'direction': 'ViewFocusDirection get direction',
    },
  );
}

// =============================================================================
// CallbackHandle Bridge
// =============================================================================

BridgedClass _createCallbackHandleBridge() {
  return BridgedClass(
    nativeType: $dart_ui.CallbackHandle,
    name: 'CallbackHandle',
    constructors: {
      'fromRawHandle': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CallbackHandle');
        final handle = D4.getRequiredArg<int>(positional, 0, '_handle', 'CallbackHandle');
        return $dart_ui.CallbackHandle.fromRawHandle(handle);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.CallbackHandle>(target, 'CallbackHandle').hashCode,
    },
    methods: {
      'toRawHandle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.CallbackHandle>(target, 'CallbackHandle');
        return t.toRawHandle();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.CallbackHandle>(target, 'CallbackHandle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      'fromRawHandle': 'CallbackHandle.fromRawHandle(int _handle)',
    },
    methodSignatures: {
      'toRawHandle': 'int toRawHandle()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// PluginUtilities Bridge
// =============================================================================

BridgedClass _createPluginUtilitiesBridge() {
  return BridgedClass(
    nativeType: PluginUtilities,
    name: 'PluginUtilities',
    constructors: {
    },
    staticMethods: {
      'getCallbackHandle': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getCallbackHandle');
        final callback = D4.getRequiredArg<Function>(positional, 0, 'callback', 'getCallbackHandle');
        return PluginUtilities.getCallbackHandle(callback);
      },
      'getCallbackFromHandle': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getCallbackFromHandle');
        final handle = D4.getRequiredArg<$dart_ui.CallbackHandle>(positional, 0, 'handle', 'getCallbackFromHandle');
        return PluginUtilities.getCallbackFromHandle(handle);
      },
    },
    staticMethodSignatures: {
      'getCallbackHandle': 'CallbackHandle? getCallbackHandle(Function callback)',
      'getCallbackFromHandle': 'Function? getCallbackFromHandle(CallbackHandle handle)',
    },
  );
}

// =============================================================================
// PointerData Bridge
// =============================================================================

BridgedClass _createPointerDataBridge() {
  return BridgedClass(
    nativeType: $dart_ui.PointerData,
    name: 'PointerData',
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final change = D4.getNamedArgWithDefault<$dart_ui.PointerChange>(named, 'change', $dart_ui.PointerChange.cancel);
        final kind = D4.getNamedArgWithDefault<$dart_ui.PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final signalKind = D4.getOptionalNamedArg<$dart_ui.PointerSignalKind?>(named, 'signalKind');
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final pointerIdentifier = D4.getNamedArgWithDefault<int>(named, 'pointerIdentifier', 0);
        final physicalX = D4.getNamedArgWithDefault<double>(named, 'physicalX', 0.0);
        final physicalY = D4.getNamedArgWithDefault<double>(named, 'physicalY', 0.0);
        final physicalDeltaX = D4.getNamedArgWithDefault<double>(named, 'physicalDeltaX', 0.0);
        final physicalDeltaY = D4.getNamedArgWithDefault<double>(named, 'physicalDeltaY', 0.0);
        final buttons = D4.getNamedArgWithDefault<int>(named, 'buttons', 0);
        final obscured = D4.getNamedArgWithDefault<bool>(named, 'obscured', false);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        final pressure = D4.getNamedArgWithDefault<double>(named, 'pressure', 0.0);
        final pressureMin = D4.getNamedArgWithDefault<double>(named, 'pressureMin', 0.0);
        final pressureMax = D4.getNamedArgWithDefault<double>(named, 'pressureMax', 0.0);
        final distance = D4.getNamedArgWithDefault<double>(named, 'distance', 0.0);
        final distanceMax = D4.getNamedArgWithDefault<double>(named, 'distanceMax', 0.0);
        final size = D4.getNamedArgWithDefault<double>(named, 'size', 0.0);
        final radiusMajor = D4.getNamedArgWithDefault<double>(named, 'radiusMajor', 0.0);
        final radiusMinor = D4.getNamedArgWithDefault<double>(named, 'radiusMinor', 0.0);
        final radiusMin = D4.getNamedArgWithDefault<double>(named, 'radiusMin', 0.0);
        final radiusMax = D4.getNamedArgWithDefault<double>(named, 'radiusMax', 0.0);
        final orientation = D4.getNamedArgWithDefault<double>(named, 'orientation', 0.0);
        final tilt = D4.getNamedArgWithDefault<double>(named, 'tilt', 0.0);
        final platformData = D4.getNamedArgWithDefault<int>(named, 'platformData', 0);
        final scrollDeltaX = D4.getNamedArgWithDefault<double>(named, 'scrollDeltaX', 0.0);
        final scrollDeltaY = D4.getNamedArgWithDefault<double>(named, 'scrollDeltaY', 0.0);
        final panX = D4.getNamedArgWithDefault<double>(named, 'panX', 0.0);
        final panY = D4.getNamedArgWithDefault<double>(named, 'panY', 0.0);
        final panDeltaX = D4.getNamedArgWithDefault<double>(named, 'panDeltaX', 0.0);
        final panDeltaY = D4.getNamedArgWithDefault<double>(named, 'panDeltaY', 0.0);
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 0.0);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0.0);
        final onRespondRaw = named['onRespond'];
        return $dart_ui.PointerData(viewId: viewId, embedderId: embedderId, timeStamp: timeStamp, change: change, kind: kind, signalKind: signalKind, device: device, pointerIdentifier: pointerIdentifier, physicalX: physicalX, physicalY: physicalY, physicalDeltaX: physicalDeltaX, physicalDeltaY: physicalDeltaY, buttons: buttons, obscured: obscured, synthesized: synthesized, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, platformData: platformData, scrollDeltaX: scrollDeltaX, scrollDeltaY: scrollDeltaY, panX: panX, panY: panY, panDeltaX: panDeltaX, panDeltaY: panDeltaY, scale: scale, rotation: rotation, onRespond: onRespondRaw == null ? null : ({bool allowPlatformDefault = false}) { D4.callInterpreterCallback(visitor, onRespondRaw, [], {'allowPlatformDefault': allowPlatformDefault}); });
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').timeStamp,
      'change': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').change,
      'kind': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').kind,
      'signalKind': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').signalKind,
      'device': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').device,
      'pointerIdentifier': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').pointerIdentifier,
      'physicalX': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').physicalX,
      'physicalY': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').physicalY,
      'physicalDeltaX': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').physicalDeltaX,
      'physicalDeltaY': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').physicalDeltaY,
      'buttons': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').buttons,
      'obscured': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').obscured,
      'synthesized': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').synthesized,
      'pressure': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').platformData,
      'scrollDeltaX': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').scrollDeltaX,
      'scrollDeltaY': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').scrollDeltaY,
      'panX': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').panX,
      'panY': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').panY,
      'panDeltaX': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').panDeltaX,
      'panDeltaY': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').panDeltaY,
      'scale': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').scale,
      'rotation': (visitor, target) => D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData').rotation,
    },
    methods: {
      'respond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData');
        final allowPlatformDefault = D4.getRequiredNamedArg<bool>(named, 'allowPlatformDefault', 'respond');
        t.respond(allowPlatformDefault: allowPlatformDefault);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData');
        return t.toString();
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.PointerData>(target, 'PointerData');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerData({int viewId = 0, int embedderId = 0, Duration timeStamp = Duration.zero, PointerChange change = PointerChange.cancel, PointerDeviceKind kind = PointerDeviceKind.touch, PointerSignalKind? signalKind, int device = 0, int pointerIdentifier = 0, double physicalX = 0.0, double physicalY = 0.0, double physicalDeltaX = 0.0, double physicalDeltaY = 0.0, int buttons = 0, bool obscured = false, bool synthesized = false, double pressure = 0.0, double pressureMin = 0.0, double pressureMax = 0.0, double distance = 0.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, int platformData = 0, double scrollDeltaX = 0.0, double scrollDeltaY = 0.0, double panX = 0.0, double panY = 0.0, double panDeltaX = 0.0, double panDeltaY = 0.0, double scale = 0.0, double rotation = 0.0, PointerDataRespondCallback? onRespond})',
    },
    methodSignatures: {
      'respond': 'void respond({required bool allowPlatformDefault})',
      'toString': 'String toString()',
      'toStringFull': 'String toStringFull()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'embedderId': 'int get embedderId',
      'timeStamp': 'Duration get timeStamp',
      'change': 'PointerChange get change',
      'kind': 'PointerDeviceKind get kind',
      'signalKind': 'PointerSignalKind? get signalKind',
      'device': 'int get device',
      'pointerIdentifier': 'int get pointerIdentifier',
      'physicalX': 'double get physicalX',
      'physicalY': 'double get physicalY',
      'physicalDeltaX': 'double get physicalDeltaX',
      'physicalDeltaY': 'double get physicalDeltaY',
      'buttons': 'int get buttons',
      'obscured': 'bool get obscured',
      'synthesized': 'bool get synthesized',
      'pressure': 'double get pressure',
      'pressureMin': 'double get pressureMin',
      'pressureMax': 'double get pressureMax',
      'distance': 'double get distance',
      'distanceMax': 'double get distanceMax',
      'size': 'double get size',
      'radiusMajor': 'double get radiusMajor',
      'radiusMinor': 'double get radiusMinor',
      'radiusMin': 'double get radiusMin',
      'radiusMax': 'double get radiusMax',
      'orientation': 'double get orientation',
      'tilt': 'double get tilt',
      'platformData': 'int get platformData',
      'scrollDeltaX': 'double get scrollDeltaX',
      'scrollDeltaY': 'double get scrollDeltaY',
      'panX': 'double get panX',
      'panY': 'double get panY',
      'panDeltaX': 'double get panDeltaX',
      'panDeltaY': 'double get panDeltaY',
      'scale': 'double get scale',
      'rotation': 'double get rotation',
    },
  );
}

// =============================================================================
// PointerDataPacket Bridge
// =============================================================================

BridgedClass _createPointerDataPacketBridge() {
  return BridgedClass(
    nativeType: $dart_ui.PointerDataPacket,
    name: 'PointerDataPacket',
    constructors: {
      '': (visitor, positional, named) {
        final data = named.containsKey('data') && named['data'] != null
            ? D4.coerceList<$dart_ui.PointerData>(named['data'], 'data')
            : const <$dart_ui.PointerData>[];
        return $dart_ui.PointerDataPacket(data: data);
      },
    },
    getters: {
      'data': (visitor, target) => D4.validateTarget<$dart_ui.PointerDataPacket>(target, 'PointerDataPacket').data,
    },
    constructorSignatures: {
      '': 'const PointerDataPacket({List<PointerData> data = const <PointerData>[]})',
    },
    getterSignatures: {
      'data': 'List<PointerData> get data',
    },
  );
}

// =============================================================================
// SemanticsAction Bridge
// =============================================================================

BridgedClass _createSemanticsActionBridge() {
  return BridgedClass(
    nativeType: $dart_ui.SemanticsAction,
    name: 'SemanticsAction',
    constructors: {
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsAction>(target, 'SemanticsAction').index,
      'name': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsAction>(target, 'SemanticsAction').name,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsAction>(target, 'SemanticsAction');
        return t.toString();
      },
    },
    staticGetters: {
      'tap': (visitor) => $dart_ui.SemanticsAction.tap,
      'longPress': (visitor) => $dart_ui.SemanticsAction.longPress,
      'scrollLeft': (visitor) => $dart_ui.SemanticsAction.scrollLeft,
      'scrollRight': (visitor) => $dart_ui.SemanticsAction.scrollRight,
      'scrollUp': (visitor) => $dart_ui.SemanticsAction.scrollUp,
      'scrollDown': (visitor) => $dart_ui.SemanticsAction.scrollDown,
      'scrollToOffset': (visitor) => $dart_ui.SemanticsAction.scrollToOffset,
      'increase': (visitor) => $dart_ui.SemanticsAction.increase,
      'decrease': (visitor) => $dart_ui.SemanticsAction.decrease,
      'showOnScreen': (visitor) => $dart_ui.SemanticsAction.showOnScreen,
      'moveCursorForwardByCharacter': (visitor) => $dart_ui.SemanticsAction.moveCursorForwardByCharacter,
      'moveCursorBackwardByCharacter': (visitor) => $dart_ui.SemanticsAction.moveCursorBackwardByCharacter,
      'setText': (visitor) => $dart_ui.SemanticsAction.setText,
      'setSelection': (visitor) => $dart_ui.SemanticsAction.setSelection,
      'copy': (visitor) => $dart_ui.SemanticsAction.copy,
      'cut': (visitor) => $dart_ui.SemanticsAction.cut,
      'paste': (visitor) => $dart_ui.SemanticsAction.paste,
      'didGainAccessibilityFocus': (visitor) => $dart_ui.SemanticsAction.didGainAccessibilityFocus,
      'didLoseAccessibilityFocus': (visitor) => $dart_ui.SemanticsAction.didLoseAccessibilityFocus,
      'customAction': (visitor) => $dart_ui.SemanticsAction.customAction,
      'dismiss': (visitor) => $dart_ui.SemanticsAction.dismiss,
      'moveCursorForwardByWord': (visitor) => $dart_ui.SemanticsAction.moveCursorForwardByWord,
      'moveCursorBackwardByWord': (visitor) => $dart_ui.SemanticsAction.moveCursorBackwardByWord,
      'focus': (visitor) => $dart_ui.SemanticsAction.focus,
      'expand': (visitor) => $dart_ui.SemanticsAction.expand,
      'collapse': (visitor) => $dart_ui.SemanticsAction.collapse,
      'values': (visitor) => $dart_ui.SemanticsAction.values,
    },
    staticMethods: {
      'fromIndex': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromIndex');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'fromIndex');
        return $dart_ui.SemanticsAction.fromIndex(index);
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'index': 'int get index',
      'name': 'String get name',
    },
    staticMethodSignatures: {
      'fromIndex': 'SemanticsAction? fromIndex(int index)',
    },
    staticGetterSignatures: {
      'tap': 'SemanticsAction get tap',
      'longPress': 'SemanticsAction get longPress',
      'scrollLeft': 'SemanticsAction get scrollLeft',
      'scrollRight': 'SemanticsAction get scrollRight',
      'scrollUp': 'SemanticsAction get scrollUp',
      'scrollDown': 'SemanticsAction get scrollDown',
      'scrollToOffset': 'SemanticsAction get scrollToOffset',
      'increase': 'SemanticsAction get increase',
      'decrease': 'SemanticsAction get decrease',
      'showOnScreen': 'SemanticsAction get showOnScreen',
      'moveCursorForwardByCharacter': 'SemanticsAction get moveCursorForwardByCharacter',
      'moveCursorBackwardByCharacter': 'SemanticsAction get moveCursorBackwardByCharacter',
      'setText': 'SemanticsAction get setText',
      'setSelection': 'SemanticsAction get setSelection',
      'copy': 'SemanticsAction get copy',
      'cut': 'SemanticsAction get cut',
      'paste': 'SemanticsAction get paste',
      'didGainAccessibilityFocus': 'SemanticsAction get didGainAccessibilityFocus',
      'didLoseAccessibilityFocus': 'SemanticsAction get didLoseAccessibilityFocus',
      'customAction': 'SemanticsAction get customAction',
      'dismiss': 'SemanticsAction get dismiss',
      'moveCursorForwardByWord': 'SemanticsAction get moveCursorForwardByWord',
      'moveCursorBackwardByWord': 'SemanticsAction get moveCursorBackwardByWord',
      'focus': 'SemanticsAction get focus',
      'expand': 'SemanticsAction get expand',
      'collapse': 'SemanticsAction get collapse',
      'values': 'List<SemanticsAction> get values',
    },
  );
}

// =============================================================================
// SemanticsFlag Bridge
// =============================================================================

BridgedClass _createSemanticsFlagBridge() {
  return BridgedClass(
    nativeType: $dart_ui.SemanticsFlag,
    name: 'SemanticsFlag',
    constructors: {
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlag>(target, 'SemanticsFlag').index,
      'name': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlag>(target, 'SemanticsFlag').name,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsFlag>(target, 'SemanticsFlag');
        return t.toString();
      },
    },
    staticGetters: {
      'hasCheckedState': (visitor) => $dart_ui.SemanticsFlag.hasCheckedState,
      'isChecked': (visitor) => $dart_ui.SemanticsFlag.isChecked,
      'isCheckStateMixed': (visitor) => $dart_ui.SemanticsFlag.isCheckStateMixed,
      'hasSelectedState': (visitor) => $dart_ui.SemanticsFlag.hasSelectedState,
      'isSelected': (visitor) => $dart_ui.SemanticsFlag.isSelected,
      'isButton': (visitor) => $dart_ui.SemanticsFlag.isButton,
      'isTextField': (visitor) => $dart_ui.SemanticsFlag.isTextField,
      'isSlider': (visitor) => $dart_ui.SemanticsFlag.isSlider,
      'isKeyboardKey': (visitor) => $dart_ui.SemanticsFlag.isKeyboardKey,
      'isReadOnly': (visitor) => $dart_ui.SemanticsFlag.isReadOnly,
      'isLink': (visitor) => $dart_ui.SemanticsFlag.isLink,
      'isFocusable': (visitor) => $dart_ui.SemanticsFlag.isFocusable,
      'isFocused': (visitor) => $dart_ui.SemanticsFlag.isFocused,
      'hasEnabledState': (visitor) => $dart_ui.SemanticsFlag.hasEnabledState,
      'isEnabled': (visitor) => $dart_ui.SemanticsFlag.isEnabled,
      'isInMutuallyExclusiveGroup': (visitor) => $dart_ui.SemanticsFlag.isInMutuallyExclusiveGroup,
      'isHeader': (visitor) => $dart_ui.SemanticsFlag.isHeader,
      'isObscured': (visitor) => $dart_ui.SemanticsFlag.isObscured,
      'isMultiline': (visitor) => $dart_ui.SemanticsFlag.isMultiline,
      'scopesRoute': (visitor) => $dart_ui.SemanticsFlag.scopesRoute,
      'namesRoute': (visitor) => $dart_ui.SemanticsFlag.namesRoute,
      'isHidden': (visitor) => $dart_ui.SemanticsFlag.isHidden,
      'isImage': (visitor) => $dart_ui.SemanticsFlag.isImage,
      'isLiveRegion': (visitor) => $dart_ui.SemanticsFlag.isLiveRegion,
      'hasToggledState': (visitor) => $dart_ui.SemanticsFlag.hasToggledState,
      'isToggled': (visitor) => $dart_ui.SemanticsFlag.isToggled,
      'hasImplicitScrolling': (visitor) => $dart_ui.SemanticsFlag.hasImplicitScrolling,
      'hasExpandedState': (visitor) => $dart_ui.SemanticsFlag.hasExpandedState,
      'isExpanded': (visitor) => $dart_ui.SemanticsFlag.isExpanded,
      'hasRequiredState': (visitor) => $dart_ui.SemanticsFlag.hasRequiredState,
      'isRequired': (visitor) => $dart_ui.SemanticsFlag.isRequired,
      'values': (visitor) => $dart_ui.SemanticsFlag.values,
    },
    staticMethods: {
      'fromIndex': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromIndex');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'fromIndex');
        return $dart_ui.SemanticsFlag.fromIndex(index);
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'index': 'int get index',
      'name': 'String get name',
    },
    staticMethodSignatures: {
      'fromIndex': 'SemanticsFlag? fromIndex(int index)',
    },
    staticGetterSignatures: {
      'hasCheckedState': 'SemanticsFlag get hasCheckedState',
      'isChecked': 'SemanticsFlag get isChecked',
      'isCheckStateMixed': 'SemanticsFlag get isCheckStateMixed',
      'hasSelectedState': 'SemanticsFlag get hasSelectedState',
      'isSelected': 'SemanticsFlag get isSelected',
      'isButton': 'SemanticsFlag get isButton',
      'isTextField': 'SemanticsFlag get isTextField',
      'isSlider': 'SemanticsFlag get isSlider',
      'isKeyboardKey': 'SemanticsFlag get isKeyboardKey',
      'isReadOnly': 'SemanticsFlag get isReadOnly',
      'isLink': 'SemanticsFlag get isLink',
      'isFocusable': 'SemanticsFlag get isFocusable',
      'isFocused': 'SemanticsFlag get isFocused',
      'hasEnabledState': 'SemanticsFlag get hasEnabledState',
      'isEnabled': 'SemanticsFlag get isEnabled',
      'isInMutuallyExclusiveGroup': 'SemanticsFlag get isInMutuallyExclusiveGroup',
      'isHeader': 'SemanticsFlag get isHeader',
      'isObscured': 'SemanticsFlag get isObscured',
      'isMultiline': 'SemanticsFlag get isMultiline',
      'scopesRoute': 'SemanticsFlag get scopesRoute',
      'namesRoute': 'SemanticsFlag get namesRoute',
      'isHidden': 'SemanticsFlag get isHidden',
      'isImage': 'SemanticsFlag get isImage',
      'isLiveRegion': 'SemanticsFlag get isLiveRegion',
      'hasToggledState': 'SemanticsFlag get hasToggledState',
      'isToggled': 'SemanticsFlag get isToggled',
      'hasImplicitScrolling': 'SemanticsFlag get hasImplicitScrolling',
      'hasExpandedState': 'SemanticsFlag get hasExpandedState',
      'isExpanded': 'SemanticsFlag get isExpanded',
      'hasRequiredState': 'SemanticsFlag get hasRequiredState',
      'isRequired': 'SemanticsFlag get isRequired',
      'values': 'List<SemanticsFlag> get values',
    },
  );
}

// =============================================================================
// SemanticsFlags Bridge
// =============================================================================

BridgedClass _createSemanticsFlagsBridge() {
  return BridgedClass(
    nativeType: $dart_ui.SemanticsFlags,
    name: 'SemanticsFlags',
    constructors: {
      '': (visitor, positional, named) {
        final isChecked = D4.getNamedArgWithDefault<$dart_ui.CheckedState>(named, 'isChecked', $dart_ui.CheckedState.none);
        final isSelected = D4.getNamedArgWithDefault<$dart_ui.Tristate>(named, 'isSelected', $dart_ui.Tristate.none);
        final isEnabled = D4.getNamedArgWithDefault<$dart_ui.Tristate>(named, 'isEnabled', $dart_ui.Tristate.none);
        final isToggled = D4.getNamedArgWithDefault<$dart_ui.Tristate>(named, 'isToggled', $dart_ui.Tristate.none);
        final isExpanded = D4.getNamedArgWithDefault<$dart_ui.Tristate>(named, 'isExpanded', $dart_ui.Tristate.none);
        final isRequired = D4.getNamedArgWithDefault<$dart_ui.Tristate>(named, 'isRequired', $dart_ui.Tristate.none);
        final isFocused = D4.getNamedArgWithDefault<$dart_ui.Tristate>(named, 'isFocused', $dart_ui.Tristate.none);
        final isButton = D4.getNamedArgWithDefault<bool>(named, 'isButton', false);
        final isTextField = D4.getNamedArgWithDefault<bool>(named, 'isTextField', false);
        final isInMutuallyExclusiveGroup = D4.getNamedArgWithDefault<bool>(named, 'isInMutuallyExclusiveGroup', false);
        final isHeader = D4.getNamedArgWithDefault<bool>(named, 'isHeader', false);
        final isObscured = D4.getNamedArgWithDefault<bool>(named, 'isObscured', false);
        final scopesRoute = D4.getNamedArgWithDefault<bool>(named, 'scopesRoute', false);
        final namesRoute = D4.getNamedArgWithDefault<bool>(named, 'namesRoute', false);
        final isHidden = D4.getNamedArgWithDefault<bool>(named, 'isHidden', false);
        final isImage = D4.getNamedArgWithDefault<bool>(named, 'isImage', false);
        final isLiveRegion = D4.getNamedArgWithDefault<bool>(named, 'isLiveRegion', false);
        final hasImplicitScrolling = D4.getNamedArgWithDefault<bool>(named, 'hasImplicitScrolling', false);
        final isMultiline = D4.getNamedArgWithDefault<bool>(named, 'isMultiline', false);
        final isReadOnly = D4.getNamedArgWithDefault<bool>(named, 'isReadOnly', false);
        final isLink = D4.getNamedArgWithDefault<bool>(named, 'isLink', false);
        final isSlider = D4.getNamedArgWithDefault<bool>(named, 'isSlider', false);
        final isKeyboardKey = D4.getNamedArgWithDefault<bool>(named, 'isKeyboardKey', false);
        final isAccessibilityFocusBlocked = D4.getNamedArgWithDefault<bool>(named, 'isAccessibilityFocusBlocked', false);
        return $dart_ui.SemanticsFlags(isChecked: isChecked, isSelected: isSelected, isEnabled: isEnabled, isToggled: isToggled, isExpanded: isExpanded, isRequired: isRequired, isFocused: isFocused, isButton: isButton, isTextField: isTextField, isInMutuallyExclusiveGroup: isInMutuallyExclusiveGroup, isHeader: isHeader, isObscured: isObscured, scopesRoute: scopesRoute, namesRoute: namesRoute, isHidden: isHidden, isImage: isImage, isLiveRegion: isLiveRegion, hasImplicitScrolling: hasImplicitScrolling, isMultiline: isMultiline, isReadOnly: isReadOnly, isLink: isLink, isSlider: isSlider, isKeyboardKey: isKeyboardKey, isAccessibilityFocusBlocked: isAccessibilityFocusBlocked);
      },
    },
    getters: {
      'isChecked': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isChecked,
      'isSelected': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isSelected,
      'isEnabled': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isEnabled,
      'isToggled': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isToggled,
      'isExpanded': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isExpanded,
      'isRequired': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isRequired,
      'isFocused': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isFocused,
      'isAccessibilityFocusBlocked': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isAccessibilityFocusBlocked,
      'isButton': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isButton,
      'isTextField': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isTextField,
      'isInMutuallyExclusiveGroup': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isInMutuallyExclusiveGroup,
      'isHeader': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isHeader,
      'isObscured': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isObscured,
      'scopesRoute': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').scopesRoute,
      'namesRoute': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').namesRoute,
      'isHidden': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isHidden,
      'isImage': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isImage,
      'isLiveRegion': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isLiveRegion,
      'hasImplicitScrolling': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').hasImplicitScrolling,
      'isMultiline': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isMultiline,
      'isReadOnly': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isReadOnly,
      'isLink': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isLink,
      'isSlider': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isSlider,
      'isKeyboardKey': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').isKeyboardKey,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags').hashCode,
    },
    methods: {
      'merge': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags');
        D4.requireMinArgs(positional, 1, 'merge');
        final other = D4.getRequiredArg<$dart_ui.SemanticsFlags>(positional, 0, 'other', 'merge');
        return t.merge(other);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags');
        final isChecked = D4.getOptionalNamedArg<$dart_ui.CheckedState?>(named, 'isChecked');
        final isSelected = D4.getOptionalNamedArg<$dart_ui.Tristate?>(named, 'isSelected');
        final isEnabled = D4.getOptionalNamedArg<$dart_ui.Tristate?>(named, 'isEnabled');
        final isToggled = D4.getOptionalNamedArg<$dart_ui.Tristate?>(named, 'isToggled');
        final isExpanded = D4.getOptionalNamedArg<$dart_ui.Tristate?>(named, 'isExpanded');
        final isRequired = D4.getOptionalNamedArg<$dart_ui.Tristate?>(named, 'isRequired');
        final isFocused = D4.getOptionalNamedArg<$dart_ui.Tristate?>(named, 'isFocused');
        final isButton = D4.getOptionalNamedArg<bool?>(named, 'isButton');
        final isTextField = D4.getOptionalNamedArg<bool?>(named, 'isTextField');
        final isInMutuallyExclusiveGroup = D4.getOptionalNamedArg<bool?>(named, 'isInMutuallyExclusiveGroup');
        final isHeader = D4.getOptionalNamedArg<bool?>(named, 'isHeader');
        final isObscured = D4.getOptionalNamedArg<bool?>(named, 'isObscured');
        final scopesRoute = D4.getOptionalNamedArg<bool?>(named, 'scopesRoute');
        final namesRoute = D4.getOptionalNamedArg<bool?>(named, 'namesRoute');
        final isHidden = D4.getOptionalNamedArg<bool?>(named, 'isHidden');
        final isImage = D4.getOptionalNamedArg<bool?>(named, 'isImage');
        final isLiveRegion = D4.getOptionalNamedArg<bool?>(named, 'isLiveRegion');
        final hasImplicitScrolling = D4.getOptionalNamedArg<bool?>(named, 'hasImplicitScrolling');
        final isMultiline = D4.getOptionalNamedArg<bool?>(named, 'isMultiline');
        final isReadOnly = D4.getOptionalNamedArg<bool?>(named, 'isReadOnly');
        final isLink = D4.getOptionalNamedArg<bool?>(named, 'isLink');
        final isSlider = D4.getOptionalNamedArg<bool?>(named, 'isSlider');
        final isKeyboardKey = D4.getOptionalNamedArg<bool?>(named, 'isKeyboardKey');
        final isAccessibilityFocusBlocked = D4.getOptionalNamedArg<bool?>(named, 'isAccessibilityFocusBlocked');
        return t.copyWith(isChecked: isChecked, isSelected: isSelected, isEnabled: isEnabled, isToggled: isToggled, isExpanded: isExpanded, isRequired: isRequired, isFocused: isFocused, isButton: isButton, isTextField: isTextField, isInMutuallyExclusiveGroup: isInMutuallyExclusiveGroup, isHeader: isHeader, isObscured: isObscured, scopesRoute: scopesRoute, namesRoute: namesRoute, isHidden: isHidden, isImage: isImage, isLiveRegion: isLiveRegion, hasImplicitScrolling: hasImplicitScrolling, isMultiline: isMultiline, isReadOnly: isReadOnly, isLink: isLink, isSlider: isSlider, isKeyboardKey: isKeyboardKey, isAccessibilityFocusBlocked: isAccessibilityFocusBlocked);
      },
      'toStrings': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags');
        return t.toStrings();
      },
      'hasRepeatedFlags': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags');
        D4.requireMinArgs(positional, 1, 'hasRepeatedFlags');
        final other = D4.getRequiredArg<$dart_ui.SemanticsFlags>(positional, 0, 'other', 'hasRepeatedFlags');
        return t.hasRepeatedFlags(other);
      },
      'hasConflictingFlags': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags');
        D4.requireMinArgs(positional, 1, 'hasConflictingFlags');
        final other = D4.getRequiredArg<$dart_ui.SemanticsFlags>(positional, 0, 'other', 'hasConflictingFlags');
        return t.hasConflictingFlags(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsFlags>(target, 'SemanticsFlags');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'none': (visitor) => $dart_ui.SemanticsFlags.none,
    },
    staticSetters: {
      'none': (visitor, value) => 
        $dart_ui.SemanticsFlags.none = value as $dart_ui.SemanticsFlags,
    },
    constructorSignatures: {
      '': 'SemanticsFlags({CheckedState isChecked = CheckedState.none, Tristate isSelected = Tristate.none, Tristate isEnabled = Tristate.none, Tristate isToggled = Tristate.none, Tristate isExpanded = Tristate.none, Tristate isRequired = Tristate.none, Tristate isFocused = Tristate.none, bool isButton = false, bool isTextField = false, bool isInMutuallyExclusiveGroup = false, bool isHeader = false, bool isObscured = false, bool scopesRoute = false, bool namesRoute = false, bool isHidden = false, bool isImage = false, bool isLiveRegion = false, bool hasImplicitScrolling = false, bool isMultiline = false, bool isReadOnly = false, bool isLink = false, bool isSlider = false, bool isKeyboardKey = false, bool isAccessibilityFocusBlocked = false})',
    },
    methodSignatures: {
      'merge': 'SemanticsFlags merge(SemanticsFlags other)',
      'copyWith': 'SemanticsFlags copyWith({CheckedState? isChecked, Tristate? isSelected, Tristate? isEnabled, Tristate? isToggled, Tristate? isExpanded, Tristate? isRequired, Tristate? isFocused, bool? isButton, bool? isTextField, bool? isInMutuallyExclusiveGroup, bool? isHeader, bool? isObscured, bool? scopesRoute, bool? namesRoute, bool? isHidden, bool? isImage, bool? isLiveRegion, bool? hasImplicitScrolling, bool? isMultiline, bool? isReadOnly, bool? isLink, bool? isSlider, bool? isKeyboardKey, bool? isAccessibilityFocusBlocked})',
      'toStrings': 'List<String> toStrings()',
      'hasRepeatedFlags': 'bool hasRepeatedFlags(SemanticsFlags other)',
      'hasConflictingFlags': 'bool hasConflictingFlags(SemanticsFlags other)',
    },
    getterSignatures: {
      'isChecked': 'CheckedState get isChecked',
      'isSelected': 'Tristate get isSelected',
      'isEnabled': 'Tristate get isEnabled',
      'isToggled': 'Tristate get isToggled',
      'isExpanded': 'Tristate get isExpanded',
      'isRequired': 'Tristate get isRequired',
      'isFocused': 'Tristate get isFocused',
      'isAccessibilityFocusBlocked': 'bool get isAccessibilityFocusBlocked',
      'isButton': 'bool get isButton',
      'isTextField': 'bool get isTextField',
      'isInMutuallyExclusiveGroup': 'bool get isInMutuallyExclusiveGroup',
      'isHeader': 'bool get isHeader',
      'isObscured': 'bool get isObscured',
      'scopesRoute': 'bool get scopesRoute',
      'namesRoute': 'bool get namesRoute',
      'isHidden': 'bool get isHidden',
      'isImage': 'bool get isImage',
      'isLiveRegion': 'bool get isLiveRegion',
      'hasImplicitScrolling': 'bool get hasImplicitScrolling',
      'isMultiline': 'bool get isMultiline',
      'isReadOnly': 'bool get isReadOnly',
      'isLink': 'bool get isLink',
      'isSlider': 'bool get isSlider',
      'isKeyboardKey': 'bool get isKeyboardKey',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'none': 'SemanticsFlags get none',
    },
    staticSetterSignatures: {
      'none': 'set none(dynamic value)',
    },
  );
}

// =============================================================================
// StringAttribute Bridge
// =============================================================================

BridgedClass _createStringAttributeBridge() {
  return BridgedClass(
    nativeType: $dart_ui.StringAttribute,
    name: 'StringAttribute',
    constructors: {
    },
    getters: {
      'range': (visitor, target) => D4.validateTarget<$dart_ui.StringAttribute>(target, 'StringAttribute').range,
    },
    methods: {
      'copy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.StringAttribute>(target, 'StringAttribute');
        final range = D4.getRequiredNamedArg<$dart_ui.TextRange>(named, 'range', 'copy');
        return t.copy(range: range);
      },
    },
    methodSignatures: {
      'copy': 'StringAttribute copy({required TextRange range})',
    },
    getterSignatures: {
      'range': 'TextRange get range',
    },
  );
}

// =============================================================================
// SpellOutStringAttribute Bridge
// =============================================================================

BridgedClass _createSpellOutStringAttributeBridge() {
  return BridgedClass(
    nativeType: SpellOutStringAttribute,
    name: 'SpellOutStringAttribute',
    constructors: {
      '': (visitor, positional, named) {
        final range = D4.getRequiredNamedArg<$dart_ui.TextRange>(named, 'range', 'SpellOutStringAttribute');
        return SpellOutStringAttribute(range: range);
      },
    },
    getters: {
      'range': (visitor, target) => D4.validateTarget<SpellOutStringAttribute>(target, 'SpellOutStringAttribute').range,
    },
    methods: {
      'copy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SpellOutStringAttribute>(target, 'SpellOutStringAttribute');
        final range = D4.getRequiredNamedArg<$dart_ui.TextRange>(named, 'range', 'copy');
        return t.copy(range: range);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SpellOutStringAttribute>(target, 'SpellOutStringAttribute');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'SpellOutStringAttribute({required TextRange range})',
    },
    methodSignatures: {
      'copy': 'StringAttribute copy({required TextRange range})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'range': 'TextRange get range',
    },
  );
}

// =============================================================================
// LocaleStringAttribute Bridge
// =============================================================================

BridgedClass _createLocaleStringAttributeBridge() {
  return BridgedClass(
    nativeType: LocaleStringAttribute,
    name: 'LocaleStringAttribute',
    constructors: {
      '': (visitor, positional, named) {
        final range = D4.getRequiredNamedArg<$dart_ui.TextRange>(named, 'range', 'LocaleStringAttribute');
        final locale = D4.getRequiredNamedArg<$dart_ui.Locale>(named, 'locale', 'LocaleStringAttribute');
        return LocaleStringAttribute(range: range, locale: locale);
      },
    },
    getters: {
      'range': (visitor, target) => D4.validateTarget<LocaleStringAttribute>(target, 'LocaleStringAttribute').range,
      'locale': (visitor, target) => D4.validateTarget<LocaleStringAttribute>(target, 'LocaleStringAttribute').locale,
    },
    methods: {
      'copy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LocaleStringAttribute>(target, 'LocaleStringAttribute');
        final range = D4.getRequiredNamedArg<$dart_ui.TextRange>(named, 'range', 'copy');
        return t.copy(range: range);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<LocaleStringAttribute>(target, 'LocaleStringAttribute');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'LocaleStringAttribute({required TextRange range, required Locale locale})',
    },
    methodSignatures: {
      'copy': 'StringAttribute copy({required TextRange range})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'range': 'TextRange get range',
      'locale': 'Locale get locale',
    },
  );
}

// =============================================================================
// SemanticsUpdateBuilder Bridge
// =============================================================================

BridgedClass _createSemanticsUpdateBuilderBridge() {
  return BridgedClass(
    nativeType: SemanticsUpdateBuilder,
    name: 'SemanticsUpdateBuilder',
    constructors: {
      '': (visitor, positional, named) {
        return SemanticsUpdateBuilder();
      },
    },
    methods: {
      'updateNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsUpdateBuilder>(target, 'SemanticsUpdateBuilder');
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'updateNode');
        final flags = D4.getRequiredNamedArg<$dart_ui.SemanticsFlags>(named, 'flags', 'updateNode');
        final actions = D4.getRequiredNamedArg<int>(named, 'actions', 'updateNode');
        final maxValueLength = D4.getRequiredNamedArg<int>(named, 'maxValueLength', 'updateNode');
        final currentValueLength = D4.getRequiredNamedArg<int>(named, 'currentValueLength', 'updateNode');
        final textSelectionBase = D4.getRequiredNamedArg<int>(named, 'textSelectionBase', 'updateNode');
        final textSelectionExtent = D4.getRequiredNamedArg<int>(named, 'textSelectionExtent', 'updateNode');
        final platformViewId = D4.getRequiredNamedArg<int>(named, 'platformViewId', 'updateNode');
        final scrollChildren = D4.getRequiredNamedArg<int>(named, 'scrollChildren', 'updateNode');
        final scrollIndex = D4.getRequiredNamedArg<int>(named, 'scrollIndex', 'updateNode');
        final traversalParent = D4.getRequiredNamedArg<int>(named, 'traversalParent', 'updateNode');
        final scrollPosition = D4.getRequiredNamedArg<double>(named, 'scrollPosition', 'updateNode');
        final scrollExtentMax = D4.getRequiredNamedArg<double>(named, 'scrollExtentMax', 'updateNode');
        final scrollExtentMin = D4.getRequiredNamedArg<double>(named, 'scrollExtentMin', 'updateNode');
        final rect = D4.getRequiredNamedArg<$dart_ui.Rect>(named, 'rect', 'updateNode');
        final identifier = D4.getRequiredNamedArg<String>(named, 'identifier', 'updateNode');
        final label = D4.getRequiredNamedArg<String>(named, 'label', 'updateNode');
        if (!named.containsKey('labelAttributes') || named['labelAttributes'] == null) {
          throw ArgumentError('updateNode: Missing required named argument "labelAttributes"');
        }
        final labelAttributes = D4.coerceList<$dart_ui.StringAttribute>(named['labelAttributes'], 'labelAttributes');
        final value = D4.getRequiredNamedArg<String>(named, 'value', 'updateNode');
        if (!named.containsKey('valueAttributes') || named['valueAttributes'] == null) {
          throw ArgumentError('updateNode: Missing required named argument "valueAttributes"');
        }
        final valueAttributes = D4.coerceList<$dart_ui.StringAttribute>(named['valueAttributes'], 'valueAttributes');
        final increasedValue = D4.getRequiredNamedArg<String>(named, 'increasedValue', 'updateNode');
        if (!named.containsKey('increasedValueAttributes') || named['increasedValueAttributes'] == null) {
          throw ArgumentError('updateNode: Missing required named argument "increasedValueAttributes"');
        }
        final increasedValueAttributes = D4.coerceList<$dart_ui.StringAttribute>(named['increasedValueAttributes'], 'increasedValueAttributes');
        final decreasedValue = D4.getRequiredNamedArg<String>(named, 'decreasedValue', 'updateNode');
        if (!named.containsKey('decreasedValueAttributes') || named['decreasedValueAttributes'] == null) {
          throw ArgumentError('updateNode: Missing required named argument "decreasedValueAttributes"');
        }
        final decreasedValueAttributes = D4.coerceList<$dart_ui.StringAttribute>(named['decreasedValueAttributes'], 'decreasedValueAttributes');
        final hint = D4.getRequiredNamedArg<String>(named, 'hint', 'updateNode');
        if (!named.containsKey('hintAttributes') || named['hintAttributes'] == null) {
          throw ArgumentError('updateNode: Missing required named argument "hintAttributes"');
        }
        final hintAttributes = D4.coerceList<$dart_ui.StringAttribute>(named['hintAttributes'], 'hintAttributes');
        final tooltip = D4.getRequiredNamedArg<String>(named, 'tooltip', 'updateNode');
        final textDirection = D4.getRequiredNamedArg<$dart_ui.TextDirection?>(named, 'textDirection', 'updateNode');
        final transform = D4.getRequiredNamedArg<Float64List>(named, 'transform', 'updateNode');
        final hitTestTransform = D4.getRequiredNamedArg<Float64List>(named, 'hitTestTransform', 'updateNode');
        final childrenInTraversalOrder = D4.getRequiredNamedArg<Int32List>(named, 'childrenInTraversalOrder', 'updateNode');
        final childrenInHitTestOrder = D4.getRequiredNamedArg<Int32List>(named, 'childrenInHitTestOrder', 'updateNode');
        final additionalActions = D4.getRequiredNamedArg<Int32List>(named, 'additionalActions', 'updateNode');
        final headingLevel = D4.getNamedArgWithDefault<int>(named, 'headingLevel', 0);
        final linkUrl = D4.getNamedArgWithDefault<String>(named, 'linkUrl', '');
        final role = D4.getNamedArgWithDefault<$dart_ui.SemanticsRole>(named, 'role', $dart_ui.SemanticsRole.none);
        if (!named.containsKey('controlsNodes') || named['controlsNodes'] == null) {
          throw ArgumentError('updateNode: Missing required named argument "controlsNodes"');
        }
        final controlsNodes = D4.coerceListOrNull<String>(named['controlsNodes'], 'controlsNodes');
        final validationResult = D4.getNamedArgWithDefault<$dart_ui.SemanticsValidationResult>(named, 'validationResult', $dart_ui.SemanticsValidationResult.none);
        final hitTestBehavior = D4.getNamedArgWithDefault<$dart_ui.SemanticsHitTestBehavior>(named, 'hitTestBehavior', $dart_ui.SemanticsHitTestBehavior.defer);
        final inputType = D4.getRequiredNamedArg<$dart_ui.SemanticsInputType>(named, 'inputType', 'updateNode');
        final locale = D4.getRequiredNamedArg<$dart_ui.Locale?>(named, 'locale', 'updateNode');
        final minValue = D4.getRequiredNamedArg<String>(named, 'minValue', 'updateNode');
        final maxValue = D4.getRequiredNamedArg<String>(named, 'maxValue', 'updateNode');
        t.updateNode(id: id, flags: flags, actions: actions, maxValueLength: maxValueLength, currentValueLength: currentValueLength, textSelectionBase: textSelectionBase, textSelectionExtent: textSelectionExtent, platformViewId: platformViewId, scrollChildren: scrollChildren, scrollIndex: scrollIndex, traversalParent: traversalParent, scrollPosition: scrollPosition, scrollExtentMax: scrollExtentMax, scrollExtentMin: scrollExtentMin, rect: rect, identifier: identifier, label: label, labelAttributes: labelAttributes, value: value, valueAttributes: valueAttributes, increasedValue: increasedValue, increasedValueAttributes: increasedValueAttributes, decreasedValue: decreasedValue, decreasedValueAttributes: decreasedValueAttributes, hint: hint, hintAttributes: hintAttributes, tooltip: tooltip, textDirection: textDirection, transform: transform, hitTestTransform: hitTestTransform, childrenInTraversalOrder: childrenInTraversalOrder, childrenInHitTestOrder: childrenInHitTestOrder, additionalActions: additionalActions, headingLevel: headingLevel, linkUrl: linkUrl, role: role, controlsNodes: controlsNodes, validationResult: validationResult, hitTestBehavior: hitTestBehavior, inputType: inputType, locale: locale, minValue: minValue, maxValue: maxValue);
        return null;
      },
      'updateCustomAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsUpdateBuilder>(target, 'SemanticsUpdateBuilder');
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'updateCustomAction');
        final label = D4.getOptionalNamedArg<String?>(named, 'label');
        final hint = D4.getOptionalNamedArg<String?>(named, 'hint');
        final overrideId = D4.getNamedArgWithDefault<int>(named, 'overrideId', -1);
        t.updateCustomAction(id: id, label: label, hint: hint, overrideId: overrideId);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<SemanticsUpdateBuilder>(target, 'SemanticsUpdateBuilder');
        return (t as dynamic).build();
      },
    },
    constructorSignatures: {
      '': 'factory SemanticsUpdateBuilder()',
    },
    methodSignatures: {
      'updateNode': 'void updateNode({required int id, required SemanticsFlags flags, required int actions, required int maxValueLength, required int currentValueLength, required int textSelectionBase, required int textSelectionExtent, required int platformViewId, required int scrollChildren, required int scrollIndex, required int traversalParent, required double scrollPosition, required double scrollExtentMax, required double scrollExtentMin, required Rect rect, required String identifier, required String label, required List<StringAttribute> labelAttributes, required String value, required List<StringAttribute> valueAttributes, required String increasedValue, required List<StringAttribute> increasedValueAttributes, required String decreasedValue, required List<StringAttribute> decreasedValueAttributes, required String hint, required List<StringAttribute> hintAttributes, required String tooltip, required TextDirection? textDirection, required Float64List transform, required Float64List hitTestTransform, required Int32List childrenInTraversalOrder, required Int32List childrenInHitTestOrder, required Int32List additionalActions, int headingLevel = 0, String linkUrl = \'\', SemanticsRole role = SemanticsRole.none, required List<String>? controlsNodes, SemanticsValidationResult validationResult = SemanticsValidationResult.none, SemanticsHitTestBehavior hitTestBehavior = SemanticsHitTestBehavior.defer, required SemanticsInputType inputType, required Locale? locale, required String minValue, required String maxValue})',
      'updateCustomAction': 'void updateCustomAction({required int id, String? label, String? hint, int overrideId = -1})',
      'build': 'SemanticsUpdate build()',
    },
  );
}

// =============================================================================
// SemanticsUpdate Bridge
// =============================================================================

BridgedClass _createSemanticsUpdateBridge() {
  return BridgedClass(
    nativeType: $dart_ui.SemanticsUpdate,
    name: 'SemanticsUpdate',
    constructors: {
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.SemanticsUpdate>(target, 'SemanticsUpdate');
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
// FontWeight Bridge
// =============================================================================

BridgedClass _createFontWeightBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FontWeight,
    name: 'FontWeight',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontWeight');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'FontWeight');
        return $dart_ui.FontWeight(value);
      },
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$dart_ui.FontWeight>(target, 'FontWeight').index,
      'value': (visitor, target) => D4.validateTarget<$dart_ui.FontWeight>(target, 'FontWeight').value,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.FontWeight>(target, 'FontWeight').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FontWeight>(target, 'FontWeight');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FontWeight>(target, 'FontWeight');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'w100': (visitor) => $dart_ui.FontWeight.w100,
      'w200': (visitor) => $dart_ui.FontWeight.w200,
      'w300': (visitor) => $dart_ui.FontWeight.w300,
      'w400': (visitor) => $dart_ui.FontWeight.w400,
      'w500': (visitor) => $dart_ui.FontWeight.w500,
      'w600': (visitor) => $dart_ui.FontWeight.w600,
      'w700': (visitor) => $dart_ui.FontWeight.w700,
      'w800': (visitor) => $dart_ui.FontWeight.w800,
      'w900': (visitor) => $dart_ui.FontWeight.w900,
      'normal': (visitor) => $dart_ui.FontWeight.normal,
      'bold': (visitor) => $dart_ui.FontWeight.bold,
      'values': (visitor) => $dart_ui.FontWeight.values,
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.FontWeight?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.FontWeight?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.FontWeight.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const FontWeight(int value)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'index': 'int get index',
      'value': 'int get value',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'FontWeight? lerp(FontWeight? a, FontWeight? b, double t)',
    },
    staticGetterSignatures: {
      'w100': 'FontWeight get w100',
      'w200': 'FontWeight get w200',
      'w300': 'FontWeight get w300',
      'w400': 'FontWeight get w400',
      'w500': 'FontWeight get w500',
      'w600': 'FontWeight get w600',
      'w700': 'FontWeight get w700',
      'w800': 'FontWeight get w800',
      'w900': 'FontWeight get w900',
      'normal': 'FontWeight get normal',
      'bold': 'FontWeight get bold',
      'values': 'List<FontWeight> get values',
    },
  );
}

// =============================================================================
// FontFeature Bridge
// =============================================================================

BridgedClass _createFontFeatureBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FontFeature,
    name: 'FontFeature',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontFeature');
        final feature = D4.getRequiredArg<String>(positional, 0, 'feature', 'FontFeature');
        final value = D4.getOptionalArgWithDefault<int>(positional, 1, 'value', 1);
        return $dart_ui.FontFeature(feature, value);
      },
      'enable': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontFeature');
        final feature = D4.getRequiredArg<String>(positional, 0, 'feature', 'FontFeature');
        return $dart_ui.FontFeature.enable(feature);
      },
      'disable': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontFeature');
        final feature = D4.getRequiredArg<String>(positional, 0, 'feature', 'FontFeature');
        return $dart_ui.FontFeature.disable(feature);
      },
      'alternative': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontFeature');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'FontFeature');
        return $dart_ui.FontFeature.alternative(value);
      },
      'alternativeFractions': (visitor, positional, named) {
        return $dart_ui.FontFeature.alternativeFractions();
      },
      'contextualAlternates': (visitor, positional, named) {
        return $dart_ui.FontFeature.contextualAlternates();
      },
      'caseSensitiveForms': (visitor, positional, named) {
        return $dart_ui.FontFeature.caseSensitiveForms();
      },
      'characterVariant': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontFeature');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'FontFeature');
        return $dart_ui.FontFeature.characterVariant(value);
      },
      'denominator': (visitor, positional, named) {
        return $dart_ui.FontFeature.denominator();
      },
      'fractions': (visitor, positional, named) {
        return $dart_ui.FontFeature.fractions();
      },
      'historicalForms': (visitor, positional, named) {
        return $dart_ui.FontFeature.historicalForms();
      },
      'historicalLigatures': (visitor, positional, named) {
        return $dart_ui.FontFeature.historicalLigatures();
      },
      'liningFigures': (visitor, positional, named) {
        return $dart_ui.FontFeature.liningFigures();
      },
      'localeAware': (visitor, positional, named) {
        final enable = D4.getNamedArgWithDefault<bool>(named, 'enable', true);
        return $dart_ui.FontFeature.localeAware(enable: enable);
      },
      'notationalForms': (visitor, positional, named) {
        final value = D4.getOptionalArgWithDefault<int>(positional, 0, 'value', 1);
        return $dart_ui.FontFeature.notationalForms(value);
      },
      'numerators': (visitor, positional, named) {
        return $dart_ui.FontFeature.numerators();
      },
      'oldstyleFigures': (visitor, positional, named) {
        return $dart_ui.FontFeature.oldstyleFigures();
      },
      'ordinalForms': (visitor, positional, named) {
        return $dart_ui.FontFeature.ordinalForms();
      },
      'proportionalFigures': (visitor, positional, named) {
        return $dart_ui.FontFeature.proportionalFigures();
      },
      'randomize': (visitor, positional, named) {
        return $dart_ui.FontFeature.randomize();
      },
      'stylisticAlternates': (visitor, positional, named) {
        return $dart_ui.FontFeature.stylisticAlternates();
      },
      'scientificInferiors': (visitor, positional, named) {
        return $dart_ui.FontFeature.scientificInferiors();
      },
      'stylisticSet': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontFeature');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'FontFeature');
        return $dart_ui.FontFeature.stylisticSet(value);
      },
      'subscripts': (visitor, positional, named) {
        return $dart_ui.FontFeature.subscripts();
      },
      'superscripts': (visitor, positional, named) {
        return $dart_ui.FontFeature.superscripts();
      },
      'swash': (visitor, positional, named) {
        final value = D4.getOptionalArgWithDefault<int>(positional, 0, 'value', 1);
        return $dart_ui.FontFeature.swash(value);
      },
      'tabularFigures': (visitor, positional, named) {
        return $dart_ui.FontFeature.tabularFigures();
      },
      'slashedZero': (visitor, positional, named) {
        return $dart_ui.FontFeature.slashedZero();
      },
    },
    getters: {
      'feature': (visitor, target) => D4.validateTarget<$dart_ui.FontFeature>(target, 'FontFeature').feature,
      'value': (visitor, target) => D4.validateTarget<$dart_ui.FontFeature>(target, 'FontFeature').value,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.FontFeature>(target, 'FontFeature').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FontFeature>(target, 'FontFeature');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FontFeature>(target, 'FontFeature');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const FontFeature(String feature, [int value = 1])',
      'enable': 'const FontFeature.enable(String feature)',
      'disable': 'const FontFeature.disable(String feature)',
      'alternative': 'const FontFeature.alternative(int value)',
      'alternativeFractions': 'const FontFeature.alternativeFractions()',
      'contextualAlternates': 'const FontFeature.contextualAlternates()',
      'caseSensitiveForms': 'const FontFeature.caseSensitiveForms()',
      'characterVariant': 'factory FontFeature.characterVariant(int value)',
      'denominator': 'const FontFeature.denominator()',
      'fractions': 'const FontFeature.fractions()',
      'historicalForms': 'const FontFeature.historicalForms()',
      'historicalLigatures': 'const FontFeature.historicalLigatures()',
      'liningFigures': 'const FontFeature.liningFigures()',
      'localeAware': 'const FontFeature.localeAware({bool enable = true})',
      'notationalForms': 'const FontFeature.notationalForms([int value = 1])',
      'numerators': 'const FontFeature.numerators()',
      'oldstyleFigures': 'const FontFeature.oldstyleFigures()',
      'ordinalForms': 'const FontFeature.ordinalForms()',
      'proportionalFigures': 'const FontFeature.proportionalFigures()',
      'randomize': 'const FontFeature.randomize()',
      'stylisticAlternates': 'const FontFeature.stylisticAlternates()',
      'scientificInferiors': 'const FontFeature.scientificInferiors()',
      'stylisticSet': 'factory FontFeature.stylisticSet(int value)',
      'subscripts': 'const FontFeature.subscripts()',
      'superscripts': 'const FontFeature.superscripts()',
      'swash': 'const FontFeature.swash([int value = 1])',
      'tabularFigures': 'const FontFeature.tabularFigures()',
      'slashedZero': 'const FontFeature.slashedZero()',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'feature': 'String get feature',
      'value': 'int get value',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// FontVariation Bridge
// =============================================================================

BridgedClass _createFontVariationBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FontVariation,
    name: 'FontVariation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FontVariation');
        final axis = D4.getRequiredArg<String>(positional, 0, 'axis', 'FontVariation');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'FontVariation');
        return $dart_ui.FontVariation(axis, value);
      },
      'italic': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontVariation');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'FontVariation');
        return $dart_ui.FontVariation.italic(value);
      },
      'opticalSize': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontVariation');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'FontVariation');
        return $dart_ui.FontVariation.opticalSize(value);
      },
      'slant': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontVariation');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'FontVariation');
        return $dart_ui.FontVariation.slant(value);
      },
      'width': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontVariation');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'FontVariation');
        return $dart_ui.FontVariation.width(value);
      },
      'weight': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontVariation');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'FontVariation');
        return $dart_ui.FontVariation.weight(value);
      },
    },
    getters: {
      'axis': (visitor, target) => D4.validateTarget<$dart_ui.FontVariation>(target, 'FontVariation').axis,
      'value': (visitor, target) => D4.validateTarget<$dart_ui.FontVariation>(target, 'FontVariation').value,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.FontVariation>(target, 'FontVariation').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FontVariation>(target, 'FontVariation');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FontVariation>(target, 'FontVariation');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'lerp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'lerp');
        final a = D4.getRequiredArg<$dart_ui.FontVariation?>(positional, 0, 'a', 'lerp');
        final b = D4.getRequiredArg<$dart_ui.FontVariation?>(positional, 1, 'b', 'lerp');
        final t_ = D4.getRequiredArg<double>(positional, 2, 't', 'lerp');
        return $dart_ui.FontVariation.lerp(a, b, t_);
      },
    },
    constructorSignatures: {
      '': 'const FontVariation(String axis, double value)',
      'italic': 'const FontVariation.italic(double value)',
      'opticalSize': 'const FontVariation.opticalSize(double value)',
      'slant': 'const FontVariation.slant(double value)',
      'width': 'const FontVariation.width(double value)',
      'weight': 'const FontVariation.weight(double value)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'axis': 'String get axis',
      'value': 'double get value',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'lerp': 'FontVariation? lerp(FontVariation? a, FontVariation? b, double t)',
    },
  );
}

// =============================================================================
// GlyphInfo Bridge
// =============================================================================

BridgedClass _createGlyphInfoBridge() {
  return BridgedClass(
    nativeType: $dart_ui.GlyphInfo,
    name: 'GlyphInfo',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'GlyphInfo');
        final graphemeClusterLayoutBounds = D4.getRequiredArg<$dart_ui.Rect>(positional, 0, 'graphemeClusterLayoutBounds', 'GlyphInfo');
        final graphemeClusterCodeUnitRange = D4.getRequiredArg<$dart_ui.TextRange>(positional, 1, 'graphemeClusterCodeUnitRange', 'GlyphInfo');
        final writingDirection = D4.getRequiredArg<$dart_ui.TextDirection>(positional, 2, 'writingDirection', 'GlyphInfo');
        return $dart_ui.GlyphInfo(graphemeClusterLayoutBounds, graphemeClusterCodeUnitRange, writingDirection);
      },
    },
    getters: {
      'graphemeClusterLayoutBounds': (visitor, target) => D4.validateTarget<$dart_ui.GlyphInfo>(target, 'GlyphInfo').graphemeClusterLayoutBounds,
      'graphemeClusterCodeUnitRange': (visitor, target) => D4.validateTarget<$dart_ui.GlyphInfo>(target, 'GlyphInfo').graphemeClusterCodeUnitRange,
      'writingDirection': (visitor, target) => D4.validateTarget<$dart_ui.GlyphInfo>(target, 'GlyphInfo').writingDirection,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.GlyphInfo>(target, 'GlyphInfo').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.GlyphInfo>(target, 'GlyphInfo');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.GlyphInfo>(target, 'GlyphInfo');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'GlyphInfo(Rect graphemeClusterLayoutBounds, TextRange graphemeClusterCodeUnitRange, TextDirection writingDirection)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'graphemeClusterLayoutBounds': 'Rect get graphemeClusterLayoutBounds',
      'graphemeClusterCodeUnitRange': 'TextRange get graphemeClusterCodeUnitRange',
      'writingDirection': 'TextDirection get writingDirection',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// TextDecoration Bridge
// =============================================================================

BridgedClass _createTextDecorationBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TextDecoration,
    name: 'TextDecoration',
    constructors: {
      'combine': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextDecoration');
        if (positional.isEmpty) {
          throw ArgumentError('TextDecoration: Missing required argument "decorations" at position 0');
        }
        final decorations = D4.coerceList<$dart_ui.TextDecoration>(positional[0], 'decorations');
        return $dart_ui.TextDecoration.combine(decorations);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.TextDecoration>(target, 'TextDecoration').hashCode,
    },
    methods: {
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextDecoration>(target, 'TextDecoration');
        D4.requireMinArgs(positional, 1, 'contains');
        final other = D4.getRequiredArg<$dart_ui.TextDecoration>(positional, 0, 'other', 'contains');
        return t.contains(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextDecoration>(target, 'TextDecoration');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextDecoration>(target, 'TextDecoration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'none': (visitor) => $dart_ui.TextDecoration.none,
      'underline': (visitor) => $dart_ui.TextDecoration.underline,
      'overline': (visitor) => $dart_ui.TextDecoration.overline,
      'lineThrough': (visitor) => $dart_ui.TextDecoration.lineThrough,
    },
    constructorSignatures: {
      'combine': 'factory TextDecoration.combine(List<TextDecoration> decorations)',
    },
    methodSignatures: {
      'contains': 'bool contains(TextDecoration other)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'none': 'TextDecoration get none',
      'underline': 'TextDecoration get underline',
      'overline': 'TextDecoration get overline',
      'lineThrough': 'TextDecoration get lineThrough',
    },
  );
}

// =============================================================================
// TextHeightBehavior Bridge
// =============================================================================

BridgedClass _createTextHeightBehaviorBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TextHeightBehavior,
    name: 'TextHeightBehavior',
    constructors: {
      '': (visitor, positional, named) {
        final applyHeightToFirstAscent = D4.getNamedArgWithDefault<bool>(named, 'applyHeightToFirstAscent', true);
        final applyHeightToLastDescent = D4.getNamedArgWithDefault<bool>(named, 'applyHeightToLastDescent', true);
        final leadingDistribution = D4.getNamedArgWithDefault<$dart_ui.TextLeadingDistribution>(named, 'leadingDistribution', $dart_ui.TextLeadingDistribution.proportional);
        return $dart_ui.TextHeightBehavior(applyHeightToFirstAscent: applyHeightToFirstAscent, applyHeightToLastDescent: applyHeightToLastDescent, leadingDistribution: leadingDistribution);
      },
    },
    getters: {
      'applyHeightToFirstAscent': (visitor, target) => D4.validateTarget<$dart_ui.TextHeightBehavior>(target, 'TextHeightBehavior').applyHeightToFirstAscent,
      'applyHeightToLastDescent': (visitor, target) => D4.validateTarget<$dart_ui.TextHeightBehavior>(target, 'TextHeightBehavior').applyHeightToLastDescent,
      'leadingDistribution': (visitor, target) => D4.validateTarget<$dart_ui.TextHeightBehavior>(target, 'TextHeightBehavior').leadingDistribution,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.TextHeightBehavior>(target, 'TextHeightBehavior').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextHeightBehavior>(target, 'TextHeightBehavior');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextHeightBehavior>(target, 'TextHeightBehavior');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const TextHeightBehavior({bool applyHeightToFirstAscent = true, bool applyHeightToLastDescent = true, TextLeadingDistribution leadingDistribution = TextLeadingDistribution.proportional})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'applyHeightToFirstAscent': 'bool get applyHeightToFirstAscent',
      'applyHeightToLastDescent': 'bool get applyHeightToLastDescent',
      'leadingDistribution': 'TextLeadingDistribution get leadingDistribution',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// TextStyle Bridge
// =============================================================================

BridgedClass _createTextStyleBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TextStyle,
    name: 'TextStyle',
    constructors: {
      '': (visitor, positional, named) {
        final color = D4.getOptionalNamedArg<$dart_ui.Color?>(named, 'color');
        final decoration = D4.getOptionalNamedArg<$dart_ui.TextDecoration?>(named, 'decoration');
        final decorationColor = D4.getOptionalNamedArg<$dart_ui.Color?>(named, 'decorationColor');
        final decorationStyle = D4.getOptionalNamedArg<$dart_ui.TextDecorationStyle?>(named, 'decorationStyle');
        final decorationThickness = D4.getOptionalNamedArg<double?>(named, 'decorationThickness');
        final fontWeight = D4.getOptionalNamedArg<$dart_ui.FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<$dart_ui.FontStyle?>(named, 'fontStyle');
        final textBaseline = D4.getOptionalNamedArg<$dart_ui.TextBaseline?>(named, 'textBaseline');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontFamilyFallback = D4.coerceListOrNull<String>(named['fontFamilyFallback'], 'fontFamilyFallback');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final letterSpacing = D4.getOptionalNamedArg<double?>(named, 'letterSpacing');
        final wordSpacing = D4.getOptionalNamedArg<double?>(named, 'wordSpacing');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final leadingDistribution = D4.getOptionalNamedArg<$dart_ui.TextLeadingDistribution?>(named, 'leadingDistribution');
        final locale = D4.getOptionalNamedArg<$dart_ui.Locale?>(named, 'locale');
        final background = D4.getOptionalNamedArg<$dart_ui.Paint?>(named, 'background');
        final foreground = D4.getOptionalNamedArg<$dart_ui.Paint?>(named, 'foreground');
        final shadows = D4.coerceListOrNull<$dart_ui.Shadow>(named['shadows'], 'shadows');
        final fontFeatures = D4.coerceListOrNull<$dart_ui.FontFeature>(named['fontFeatures'], 'fontFeatures');
        final fontVariations = D4.coerceListOrNull<$dart_ui.FontVariation>(named['fontVariations'], 'fontVariations');
        return $dart_ui.TextStyle(color: color, decoration: decoration, decorationColor: decorationColor, decorationStyle: decorationStyle, decorationThickness: decorationThickness, fontWeight: fontWeight, fontStyle: fontStyle, textBaseline: textBaseline, fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSize: fontSize, letterSpacing: letterSpacing, wordSpacing: wordSpacing, height: height, leadingDistribution: leadingDistribution, locale: locale, background: background, foreground: foreground, shadows: shadows, fontFeatures: fontFeatures, fontVariations: fontVariations);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.TextStyle>(target, 'TextStyle').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextStyle>(target, 'TextStyle');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextStyle>(target, 'TextStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'TextStyle({Color? color, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, FontWeight? fontWeight, FontStyle? fontStyle, TextBaseline? textBaseline, String? fontFamily, List<String>? fontFamilyFallback, double? fontSize, double? letterSpacing, double? wordSpacing, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? background, Paint? foreground, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ParagraphStyle Bridge
// =============================================================================

BridgedClass _createParagraphStyleBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ParagraphStyle,
    name: 'ParagraphStyle',
    constructors: {
      '': (visitor, positional, named) {
        final textAlign = D4.getOptionalNamedArg<$dart_ui.TextAlign?>(named, 'textAlign');
        final textDirection = D4.getOptionalNamedArg<$dart_ui.TextDirection?>(named, 'textDirection');
        final maxLines = D4.getOptionalNamedArg<int?>(named, 'maxLines');
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final textHeightBehavior = D4.getOptionalNamedArg<$dart_ui.TextHeightBehavior?>(named, 'textHeightBehavior');
        final fontWeight = D4.getOptionalNamedArg<$dart_ui.FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<$dart_ui.FontStyle?>(named, 'fontStyle');
        final strutStyle = D4.getOptionalNamedArg<$dart_ui.StrutStyle?>(named, 'strutStyle');
        final ellipsis = D4.getOptionalNamedArg<String?>(named, 'ellipsis');
        final locale = D4.getOptionalNamedArg<$dart_ui.Locale?>(named, 'locale');
        return $dart_ui.ParagraphStyle(textAlign: textAlign, textDirection: textDirection, maxLines: maxLines, fontFamily: fontFamily, fontSize: fontSize, height: height, textHeightBehavior: textHeightBehavior, fontWeight: fontWeight, fontStyle: fontStyle, strutStyle: strutStyle, ellipsis: ellipsis, locale: locale);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.ParagraphStyle>(target, 'ParagraphStyle').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ParagraphStyle>(target, 'ParagraphStyle');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ParagraphStyle>(target, 'ParagraphStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'ParagraphStyle({TextAlign? textAlign, TextDirection? textDirection, int? maxLines, String? fontFamily, double? fontSize, double? height, TextHeightBehavior? textHeightBehavior, FontWeight? fontWeight, FontStyle? fontStyle, StrutStyle? strutStyle, String? ellipsis, Locale? locale})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// StrutStyle Bridge
// =============================================================================

BridgedClass _createStrutStyleBridge() {
  return BridgedClass(
    nativeType: $dart_ui.StrutStyle,
    name: 'StrutStyle',
    constructors: {
      '': (visitor, positional, named) {
        final fontFamily = D4.getOptionalNamedArg<String?>(named, 'fontFamily');
        final fontFamilyFallback = D4.coerceListOrNull<String>(named['fontFamilyFallback'], 'fontFamilyFallback');
        final fontSize = D4.getOptionalNamedArg<double?>(named, 'fontSize');
        final height = D4.getOptionalNamedArg<double?>(named, 'height');
        final leadingDistribution = D4.getOptionalNamedArg<$dart_ui.TextLeadingDistribution?>(named, 'leadingDistribution');
        final leading = D4.getOptionalNamedArg<double?>(named, 'leading');
        final fontWeight = D4.getOptionalNamedArg<$dart_ui.FontWeight?>(named, 'fontWeight');
        final fontStyle = D4.getOptionalNamedArg<$dart_ui.FontStyle?>(named, 'fontStyle');
        final forceStrutHeight = D4.getOptionalNamedArg<bool?>(named, 'forceStrutHeight');
        return $dart_ui.StrutStyle(fontFamily: fontFamily, fontFamilyFallback: fontFamilyFallback, fontSize: fontSize, height: height, leadingDistribution: leadingDistribution, leading: leading, fontWeight: fontWeight, fontStyle: fontStyle, forceStrutHeight: forceStrutHeight);
      },
    },
    getters: {
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.StrutStyle>(target, 'StrutStyle').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.StrutStyle>(target, 'StrutStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'StrutStyle({String? fontFamily, List<String>? fontFamilyFallback, double? fontSize, double? height, TextLeadingDistribution? leadingDistribution, double? leading, FontWeight? fontWeight, FontStyle? fontStyle, bool? forceStrutHeight})',
    },
    getterSignatures: {
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// TextBox Bridge
// =============================================================================

BridgedClass _createTextBoxBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TextBox,
    name: 'TextBox',
    constructors: {
      'fromLTRBD': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'TextBox');
        final left = D4.getRequiredArg<double>(positional, 0, 'left', 'TextBox');
        final top = D4.getRequiredArg<double>(positional, 1, 'top', 'TextBox');
        final right = D4.getRequiredArg<double>(positional, 2, 'right', 'TextBox');
        final bottom = D4.getRequiredArg<double>(positional, 3, 'bottom', 'TextBox');
        final direction = D4.getRequiredArg<$dart_ui.TextDirection>(positional, 4, 'direction', 'TextBox');
        return $dart_ui.TextBox.fromLTRBD(left, top, right, bottom, direction);
      },
    },
    getters: {
      'left': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').left,
      'top': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').top,
      'right': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').right,
      'bottom': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').bottom,
      'direction': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').direction,
      'start': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').start,
      'end': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').end,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox').hashCode,
    },
    methods: {
      'toRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox');
        return t.toRect();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextBox>(target, 'TextBox');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      'fromLTRBD': 'const TextBox.fromLTRBD(double left, double top, double right, double bottom, TextDirection direction)',
    },
    methodSignatures: {
      'toRect': 'Rect toRect()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'left': 'double get left',
      'top': 'double get top',
      'right': 'double get right',
      'bottom': 'double get bottom',
      'direction': 'TextDirection get direction',
      'start': 'double get start',
      'end': 'double get end',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// TextPosition Bridge
// =============================================================================

BridgedClass _createTextPositionBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TextPosition,
    name: 'TextPosition',
    constructors: {
      '': (visitor, positional, named) {
        final offset = D4.getRequiredNamedArg<int>(named, 'offset', 'TextPosition');
        final affinity = D4.getNamedArgWithDefault<$dart_ui.TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        return $dart_ui.TextPosition(offset: offset, affinity: affinity);
      },
    },
    getters: {
      'offset': (visitor, target) => D4.validateTarget<$dart_ui.TextPosition>(target, 'TextPosition').offset,
      'affinity': (visitor, target) => D4.validateTarget<$dart_ui.TextPosition>(target, 'TextPosition').affinity,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.TextPosition>(target, 'TextPosition').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextPosition>(target, 'TextPosition');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextPosition>(target, 'TextPosition');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const TextPosition({required int offset, TextAffinity affinity = TextAffinity.downstream})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'offset': 'int get offset',
      'affinity': 'TextAffinity get affinity',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// TextRange Bridge
// =============================================================================

BridgedClass _createTextRangeBridge() {
  return BridgedClass(
    nativeType: $dart_ui.TextRange,
    name: 'TextRange',
    constructors: {
      '': (visitor, positional, named) {
        final start = D4.getRequiredNamedArg<int>(named, 'start', 'TextRange');
        final end = D4.getRequiredNamedArg<int>(named, 'end', 'TextRange');
        return $dart_ui.TextRange(start: start, end: end);
      },
      'collapsed': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextRange');
        final offset = D4.getRequiredArg<int>(positional, 0, 'offset', 'TextRange');
        return $dart_ui.TextRange.collapsed(offset);
      },
    },
    getters: {
      'start': (visitor, target) => D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange').start,
      'end': (visitor, target) => D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange').end,
      'isValid': (visitor, target) => D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange').isValid,
      'isCollapsed': (visitor, target) => D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange').isCollapsed,
      'isNormalized': (visitor, target) => D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange').isNormalized,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange').hashCode,
    },
    methods: {
      'textBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange');
        D4.requireMinArgs(positional, 1, 'textBefore');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textBefore');
        return t.textBefore(text);
      },
      'textAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange');
        D4.requireMinArgs(positional, 1, 'textAfter');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textAfter');
        return t.textAfter(text);
      },
      'textInside': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange');
        D4.requireMinArgs(positional, 1, 'textInside');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textInside');
        return t.textInside(text);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.TextRange>(target, 'TextRange');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'empty': (visitor) => $dart_ui.TextRange.empty,
    },
    constructorSignatures: {
      '': 'const TextRange({required int start, required int end})',
      'collapsed': 'const TextRange.collapsed(int offset)',
    },
    methodSignatures: {
      'textBefore': 'String textBefore(String text)',
      'textAfter': 'String textAfter(String text)',
      'textInside': 'String textInside(String text)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'start': 'int get start',
      'end': 'int get end',
      'isValid': 'bool get isValid',
      'isCollapsed': 'bool get isCollapsed',
      'isNormalized': 'bool get isNormalized',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'empty': 'TextRange get empty',
    },
  );
}

// =============================================================================
// ParagraphConstraints Bridge
// =============================================================================

BridgedClass _createParagraphConstraintsBridge() {
  return BridgedClass(
    nativeType: $dart_ui.ParagraphConstraints,
    name: 'ParagraphConstraints',
    constructors: {
      '': (visitor, positional, named) {
        final width = D4.getRequiredNamedArg<double>(named, 'width', 'ParagraphConstraints');
        return $dart_ui.ParagraphConstraints(width: width);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$dart_ui.ParagraphConstraints>(target, 'ParagraphConstraints').width,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.ParagraphConstraints>(target, 'ParagraphConstraints').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ParagraphConstraints>(target, 'ParagraphConstraints');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.ParagraphConstraints>(target, 'ParagraphConstraints');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ParagraphConstraints({required double width})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'width': 'double get width',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// LineMetrics Bridge
// =============================================================================

BridgedClass _createLineMetricsBridge() {
  return BridgedClass(
    nativeType: $dart_ui.LineMetrics,
    name: 'LineMetrics',
    constructors: {
      '': (visitor, positional, named) {
        final hardBreak = D4.getRequiredNamedArg<bool>(named, 'hardBreak', 'LineMetrics');
        final ascent = D4.getRequiredNamedArg<double>(named, 'ascent', 'LineMetrics');
        final descent = D4.getRequiredNamedArg<double>(named, 'descent', 'LineMetrics');
        final unscaledAscent = D4.getRequiredNamedArg<double>(named, 'unscaledAscent', 'LineMetrics');
        final height = D4.getRequiredNamedArg<double>(named, 'height', 'LineMetrics');
        final width = D4.getRequiredNamedArg<double>(named, 'width', 'LineMetrics');
        final left = D4.getRequiredNamedArg<double>(named, 'left', 'LineMetrics');
        final baseline = D4.getRequiredNamedArg<double>(named, 'baseline', 'LineMetrics');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'LineMetrics');
        return $dart_ui.LineMetrics(hardBreak: hardBreak, ascent: ascent, descent: descent, unscaledAscent: unscaledAscent, height: height, width: width, left: left, baseline: baseline, lineNumber: lineNumber);
      },
    },
    getters: {
      'hardBreak': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').hardBreak,
      'ascent': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').ascent,
      'descent': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').descent,
      'unscaledAscent': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').unscaledAscent,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').height,
      'width': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').width,
      'left': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').left,
      'baseline': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').baseline,
      'lineNumber': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').lineNumber,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.LineMetrics>(target, 'LineMetrics');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'LineMetrics({required bool hardBreak, required double ascent, required double descent, required double unscaledAscent, required double height, required double width, required double left, required double baseline, required int lineNumber})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'hardBreak': 'bool get hardBreak',
      'ascent': 'double get ascent',
      'descent': 'double get descent',
      'unscaledAscent': 'double get unscaledAscent',
      'height': 'double get height',
      'width': 'double get width',
      'left': 'double get left',
      'baseline': 'double get baseline',
      'lineNumber': 'int get lineNumber',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// Paragraph Bridge
// =============================================================================

BridgedClass _createParagraphBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Paragraph,
    name: 'Paragraph',
    constructors: {
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').width,
      'height': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').height,
      'longestLine': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').longestLine,
      'minIntrinsicWidth': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').minIntrinsicWidth,
      'maxIntrinsicWidth': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').maxIntrinsicWidth,
      'alphabeticBaseline': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').alphabeticBaseline,
      'ideographicBaseline': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').ideographicBaseline,
      'didExceedMaxLines': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').didExceedMaxLines,
      'numberOfLines': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').numberOfLines,
      'debugDisposed': (visitor, target) => D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph').debugDisposed,
    },
    methods: {
      'layout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'layout');
        final constraints = D4.getRequiredArg<$dart_ui.ParagraphConstraints>(positional, 0, 'constraints', 'layout');
        t.layout(constraints);
        return null;
      },
      'getBoxesForRange': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 2, 'getBoxesForRange');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'getBoxesForRange');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'getBoxesForRange');
        final boxHeightStyle = D4.getNamedArgWithDefault<$dart_ui.BoxHeightStyle>(named, 'boxHeightStyle', $dart_ui.BoxHeightStyle.tight);
        final boxWidthStyle = D4.getNamedArgWithDefault<$dart_ui.BoxWidthStyle>(named, 'boxWidthStyle', $dart_ui.BoxWidthStyle.tight);
        return t.getBoxesForRange(start, end, boxHeightStyle: boxHeightStyle, boxWidthStyle: boxWidthStyle);
      },
      'getBoxesForPlaceholders': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        return t.getBoxesForPlaceholders();
      },
      'getPositionForOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'getPositionForOffset');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'getPositionForOffset');
        return t.getPositionForOffset(offset);
      },
      'getClosestGlyphInfoForOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'getClosestGlyphInfoForOffset');
        final offset = D4.getRequiredArg<$dart_ui.Offset>(positional, 0, 'offset', 'getClosestGlyphInfoForOffset');
        return t.getClosestGlyphInfoForOffset(offset);
      },
      'getGlyphInfoAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'getGlyphInfoAt');
        final codeUnitOffset = D4.getRequiredArg<int>(positional, 0, 'codeUnitOffset', 'getGlyphInfoAt');
        return t.getGlyphInfoAt(codeUnitOffset);
      },
      'getWordBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'getWordBoundary');
        final position = D4.getRequiredArg<$dart_ui.TextPosition>(positional, 0, 'position', 'getWordBoundary');
        return t.getWordBoundary(position);
      },
      'getLineBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'getLineBoundary');
        final position = D4.getRequiredArg<$dart_ui.TextPosition>(positional, 0, 'position', 'getLineBoundary');
        return t.getLineBoundary(position);
      },
      'computeLineMetrics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        return t.computeLineMetrics();
      },
      'getLineMetricsAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'getLineMetricsAt');
        final lineNumber = D4.getRequiredArg<int>(positional, 0, 'lineNumber', 'getLineMetricsAt');
        return t.getLineMetricsAt(lineNumber);
      },
      'getLineNumberAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        D4.requireMinArgs(positional, 1, 'getLineNumberAt');
        final codeUnitOffset = D4.getRequiredArg<int>(positional, 0, 'codeUnitOffset', 'getLineNumberAt');
        return t.getLineNumberAt(codeUnitOffset);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Paragraph>(target, 'Paragraph');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'layout': 'void layout(ParagraphConstraints constraints)',
      'getBoxesForRange': 'List<TextBox> getBoxesForRange(int start, int end, {BoxHeightStyle boxHeightStyle = BoxHeightStyle.tight, BoxWidthStyle boxWidthStyle = BoxWidthStyle.tight})',
      'getBoxesForPlaceholders': 'List<TextBox> getBoxesForPlaceholders()',
      'getPositionForOffset': 'TextPosition getPositionForOffset(Offset offset)',
      'getClosestGlyphInfoForOffset': 'GlyphInfo? getClosestGlyphInfoForOffset(Offset offset)',
      'getGlyphInfoAt': 'GlyphInfo? getGlyphInfoAt(int codeUnitOffset)',
      'getWordBoundary': 'TextRange getWordBoundary(TextPosition position)',
      'getLineBoundary': 'TextRange getLineBoundary(TextPosition position)',
      'computeLineMetrics': 'List<LineMetrics> computeLineMetrics()',
      'getLineMetricsAt': 'LineMetrics? getLineMetricsAt(int lineNumber)',
      'getLineNumberAt': 'int? getLineNumberAt(int codeUnitOffset)',
      'dispose': 'void dispose()',
    },
    getterSignatures: {
      'width': 'double get width',
      'height': 'double get height',
      'longestLine': 'double get longestLine',
      'minIntrinsicWidth': 'double get minIntrinsicWidth',
      'maxIntrinsicWidth': 'double get maxIntrinsicWidth',
      'alphabeticBaseline': 'double get alphabeticBaseline',
      'ideographicBaseline': 'double get ideographicBaseline',
      'didExceedMaxLines': 'bool get didExceedMaxLines',
      'numberOfLines': 'int get numberOfLines',
      'debugDisposed': 'bool get debugDisposed',
    },
  );
}

// =============================================================================
// ParagraphBuilder Bridge
// =============================================================================

BridgedClass _createParagraphBuilderBridge() {
  return BridgedClass(
    nativeType: ParagraphBuilder,
    name: 'ParagraphBuilder',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ParagraphBuilder');
        final style = D4.getRequiredArg<$dart_ui.ParagraphStyle>(positional, 0, 'style', 'ParagraphBuilder');
        return ParagraphBuilder(style);
      },
    },
    getters: {
      'placeholderCount': (visitor, target) => D4.validateTarget<ParagraphBuilder>(target, 'ParagraphBuilder').placeholderCount,
      'placeholderScales': (visitor, target) => D4.validateTarget<ParagraphBuilder>(target, 'ParagraphBuilder').placeholderScales,
    },
    methods: {
      'pushStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ParagraphBuilder>(target, 'ParagraphBuilder');
        D4.requireMinArgs(positional, 1, 'pushStyle');
        final style = D4.getRequiredArg<$dart_ui.TextStyle>(positional, 0, 'style', 'pushStyle');
        t.pushStyle(style);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ParagraphBuilder>(target, 'ParagraphBuilder');
        t.pop();
        return null;
      },
      'addText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ParagraphBuilder>(target, 'ParagraphBuilder');
        D4.requireMinArgs(positional, 1, 'addText');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'addText');
        t.addText(text);
        return null;
      },
      'addPlaceholder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ParagraphBuilder>(target, 'ParagraphBuilder');
        D4.requireMinArgs(positional, 3, 'addPlaceholder');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'addPlaceholder');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'addPlaceholder');
        final alignment = D4.getRequiredArg<$dart_ui.PlaceholderAlignment>(positional, 2, 'alignment', 'addPlaceholder');
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final baselineOffset = D4.getOptionalNamedArg<double?>(named, 'baselineOffset');
        final baseline = D4.getOptionalNamedArg<$dart_ui.TextBaseline?>(named, 'baseline');
        t.addPlaceholder(width, height, alignment, scale: scale, baselineOffset: baselineOffset, baseline: baseline);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ParagraphBuilder>(target, 'ParagraphBuilder');
        return (t as dynamic).build();
      },
    },
    constructorSignatures: {
      '': 'factory ParagraphBuilder(ParagraphStyle style)',
    },
    methodSignatures: {
      'pushStyle': 'void pushStyle(TextStyle style)',
      'pop': 'void pop()',
      'addText': 'void addText(String text)',
      'addPlaceholder': 'void addPlaceholder(double width, double height, PlaceholderAlignment alignment, {double scale = 1.0, double? baselineOffset, TextBaseline? baseline})',
      'build': 'Paragraph build()',
    },
    getterSignatures: {
      'placeholderCount': 'int get placeholderCount',
      'placeholderScales': 'List<double> get placeholderScales',
    },
  );
}

// =============================================================================
// Display Bridge
// =============================================================================

BridgedClass _createDisplayBridge() {
  return BridgedClass(
    nativeType: $dart_ui.Display,
    name: 'Display',
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$dart_ui.Display>(target, 'Display').id,
      'devicePixelRatio': (visitor, target) => D4.validateTarget<$dart_ui.Display>(target, 'Display').devicePixelRatio,
      'size': (visitor, target) => D4.validateTarget<$dart_ui.Display>(target, 'Display').size,
      'refreshRate': (visitor, target) => D4.validateTarget<$dart_ui.Display>(target, 'Display').refreshRate,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.Display>(target, 'Display');
        return t.toString();
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'int get id',
      'devicePixelRatio': 'double get devicePixelRatio',
      'size': 'Size get size',
      'refreshRate': 'double get refreshRate',
    },
  );
}

// =============================================================================
// FlutterView Bridge
// =============================================================================

BridgedClass _createFlutterViewBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FlutterView,
    name: 'FlutterView',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').viewId,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').platformDispatcher,
      'display': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').display,
      'devicePixelRatio': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').devicePixelRatio,
      'physicalConstraints': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').physicalConstraints,
      'physicalSize': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').physicalSize,
      'viewInsets': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').viewInsets,
      'viewPadding': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').viewPadding,
      'systemGestureInsets': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').systemGestureInsets,
      'padding': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').padding,
      'gestureSettings': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').gestureSettings,
      'displayFeatures': (visitor, target) => D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView').displayFeatures,
    },
    methods: {
      'render': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView');
        D4.requireMinArgs(positional, 1, 'render');
        final scene = D4.getRequiredArg<$dart_ui.Scene>(positional, 0, 'scene', 'render');
        final size = D4.getOptionalNamedArg<$dart_ui.Size?>(named, 'size');
        t.render(scene, size: size);
        return null;
      },
      'updateSemantics': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView');
        D4.requireMinArgs(positional, 1, 'updateSemantics');
        final update = D4.getRequiredArg<$dart_ui.SemanticsUpdate>(positional, 0, 'update', 'updateSemantics');
        t.updateSemantics(update);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.FlutterView>(target, 'FlutterView');
        return t.toString();
      },
    },
    methodSignatures: {
      'render': 'void render(Scene scene, {Size? size})',
      'updateSemantics': 'void updateSemantics(SemanticsUpdate update)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
      'display': 'Display get display',
      'devicePixelRatio': 'double get devicePixelRatio',
      'physicalConstraints': 'ViewConstraints get physicalConstraints',
      'physicalSize': 'Size get physicalSize',
      'viewInsets': 'ViewPadding get viewInsets',
      'viewPadding': 'ViewPadding get viewPadding',
      'systemGestureInsets': 'ViewPadding get systemGestureInsets',
      'padding': 'ViewPadding get padding',
      'gestureSettings': 'GestureSettings get gestureSettings',
      'displayFeatures': 'List<DisplayFeature> get displayFeatures',
    },
  );
}

// =============================================================================
// AccessibilityFeatures Bridge
// =============================================================================

BridgedClass _createAccessibilityFeaturesBridge() {
  return BridgedClass(
    nativeType: $dart_ui.AccessibilityFeatures,
    name: 'AccessibilityFeatures',
    constructors: {
    },
    getters: {
      'accessibleNavigation': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').accessibleNavigation,
      'invertColors': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').invertColors,
      'disableAnimations': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').disableAnimations,
      'boldText': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').boldText,
      'reduceMotion': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').reduceMotion,
      'highContrast': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').highContrast,
      'onOffSwitchLabels': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').onOffSwitchLabels,
      'supportsAnnounce': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').supportsAnnounce,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.AccessibilityFeatures>(target, 'AccessibilityFeatures');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'accessibleNavigation': 'bool get accessibleNavigation',
      'invertColors': 'bool get invertColors',
      'disableAnimations': 'bool get disableAnimations',
      'boldText': 'bool get boldText',
      'reduceMotion': 'bool get reduceMotion',
      'highContrast': 'bool get highContrast',
      'onOffSwitchLabels': 'bool get onOffSwitchLabels',
      'supportsAnnounce': 'bool get supportsAnnounce',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// FrameData Bridge
// =============================================================================

BridgedClass _createFrameDataBridge() {
  return BridgedClass(
    nativeType: $dart_ui.FrameData,
    name: 'FrameData',
    constructors: {
    },
    getters: {
      'frameNumber': (visitor, target) => D4.validateTarget<$dart_ui.FrameData>(target, 'FrameData').frameNumber,
    },
    getterSignatures: {
      'frameNumber': 'int get frameNumber',
    },
  );
}

// =============================================================================
// GestureSettings Bridge
// =============================================================================

BridgedClass _createGestureSettingsBridge() {
  return BridgedClass(
    nativeType: $dart_ui.GestureSettings,
    name: 'GestureSettings',
    constructors: {
      '': (visitor, positional, named) {
        final physicalTouchSlop = D4.getOptionalNamedArg<double?>(named, 'physicalTouchSlop');
        final physicalDoubleTapSlop = D4.getOptionalNamedArg<double?>(named, 'physicalDoubleTapSlop');
        return $dart_ui.GestureSettings(physicalTouchSlop: physicalTouchSlop, physicalDoubleTapSlop: physicalDoubleTapSlop);
      },
    },
    getters: {
      'physicalTouchSlop': (visitor, target) => D4.validateTarget<$dart_ui.GestureSettings>(target, 'GestureSettings').physicalTouchSlop,
      'physicalDoubleTapSlop': (visitor, target) => D4.validateTarget<$dart_ui.GestureSettings>(target, 'GestureSettings').physicalDoubleTapSlop,
      'hashCode': (visitor, target) => D4.validateTarget<$dart_ui.GestureSettings>(target, 'GestureSettings').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.GestureSettings>(target, 'GestureSettings');
        final physicalTouchSlop = D4.getOptionalNamedArg<double?>(named, 'physicalTouchSlop');
        final physicalDoubleTapSlop = D4.getOptionalNamedArg<double?>(named, 'physicalDoubleTapSlop');
        return t.copyWith(physicalTouchSlop: physicalTouchSlop, physicalDoubleTapSlop: physicalDoubleTapSlop);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.GestureSettings>(target, 'GestureSettings');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dart_ui.GestureSettings>(target, 'GestureSettings');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const GestureSettings({double? physicalTouchSlop, double? physicalDoubleTapSlop})',
    },
    methodSignatures: {
      'copyWith': 'GestureSettings copyWith({double? physicalTouchSlop, double? physicalDoubleTapSlop})',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'physicalTouchSlop': 'double? get physicalTouchSlop',
      'physicalDoubleTapSlop': 'double? get physicalDoubleTapSlop',
      'hashCode': 'int get hashCode',
    },
  );
}

