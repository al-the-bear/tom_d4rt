// D4rt Bridge - Generated file, do not edit
// Sources: 52 files
// Generated: 2026-02-28T12:39:23.660716

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:math' as $dart_math;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_1;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_2;
import 'package:flutter/src/foundation/platform.dart' as $flutter_3;
import 'package:flutter/src/foundation/serialization.dart' as $flutter_4;
import 'package:flutter/src/gestures/events.dart' as $flutter_5;
import 'package:flutter/src/scheduler/binding.dart' as $flutter_6;
import 'package:flutter/src/scheduler/priority.dart' as $flutter_7;
import 'package:flutter/src/services/asset_bundle.dart' as $flutter_8;
import 'package:flutter/src/services/asset_manifest.dart' as $flutter_9;
import 'package:flutter/src/services/autofill.dart' as $flutter_10;
import 'package:flutter/src/services/binary_messenger.dart' as $flutter_11;
import 'package:flutter/src/services/binding.dart' as $flutter_12;
import 'package:flutter/src/services/browser_context_menu.dart' as $flutter_13;
import 'package:flutter/src/services/clipboard.dart' as $flutter_14;
import 'package:flutter/src/services/debug.dart' as $flutter_15;
import 'package:flutter/src/services/deferred_component.dart' as $flutter_16;
import 'package:flutter/src/services/flavor.dart' as $flutter_17;
import 'package:flutter/src/services/flutter_version.dart' as $flutter_18;
import 'package:flutter/src/services/font_loader.dart' as $flutter_19;
import 'package:flutter/src/services/haptic_feedback.dart' as $flutter_20;
import 'package:flutter/src/services/hardware_keyboard.dart' as $flutter_21;
import 'package:flutter/src/services/keyboard_inserted_content.dart' as $flutter_22;
import 'package:flutter/src/services/keyboard_key.g.dart' as $flutter_23;
import 'package:flutter/src/services/keyboard_maps.g.dart' as $flutter_24;
import 'package:flutter/src/services/live_text.dart' as $flutter_25;
import 'package:flutter/src/services/message_codec.dart' as $flutter_26;
import 'package:flutter/src/services/message_codecs.dart' as $flutter_27;
import 'package:flutter/src/services/mouse_cursor.dart' as $flutter_28;
import 'package:flutter/src/services/mouse_tracking.dart' as $flutter_29;
import 'package:flutter/src/services/platform_channel.dart' as $flutter_30;
import 'package:flutter/src/services/platform_views.dart' as $flutter_31;
import 'package:flutter/src/services/predictive_back_event.dart' as $flutter_32;
import 'package:flutter/src/services/process_text.dart' as $flutter_33;
import 'package:flutter/src/services/raw_keyboard_macos.dart' as $flutter_34;
import 'package:flutter/src/services/restoration.dart' as $flutter_35;
import 'package:flutter/src/services/scribe.dart' as $flutter_36;
import 'package:flutter/src/services/sensitive_content.dart' as $flutter_37;
import 'package:flutter/src/services/service_extensions.dart' as $flutter_38;
import 'package:flutter/src/services/spell_check.dart' as $flutter_39;
import 'package:flutter/src/services/system_channels.dart' as $flutter_40;
import 'package:flutter/src/services/system_chrome.dart' as $flutter_41;
import 'package:flutter/src/services/system_navigator.dart' as $flutter_42;
import 'package:flutter/src/services/system_sound.dart' as $flutter_43;
import 'package:flutter/src/services/text_boundary.dart' as $flutter_44;
import 'package:flutter/src/services/text_editing.dart' as $flutter_45;
import 'package:flutter/src/services/text_editing_delta.dart' as $flutter_46;
import 'package:flutter/src/services/text_formatter.dart' as $flutter_47;
import 'package:flutter/src/services/text_input.dart' as $flutter_48;
import 'package:flutter/src/services/text_layout_metrics.dart' as $flutter_49;
import 'package:flutter/src/services/undo_manager.dart' as $flutter_50;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;
import 'package:flutter/src/foundation/binding.dart' as $aux_flutter_2;

/// Bridge class for flutter_services module.
class FlutterServicesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createAssetBundleBridge(),
      _createNetworkAssetBundleBridge(),
      _createCachingAssetBundleBridge(),
      _createPlatformAssetBundleBridge(),
      _createAssetManifestBridge(),
      _createAssetMetadataBridge(),
      _createMatrix4Bridge(),
      _createAutofillConfigurationBridge(),
      _createAutofillScopeBridge(),
      _createTextSelectionBridge(),
      _createTextEditingDeltaBridge(),
      _createBinaryMessengerBridge(),
      _createDiagnosticPropertiesBuilderBridge(),
      _createWriteBufferBridge(),
      _createReadBufferBridge(),
      _createLogicalKeyboardKeyBridge(),
      _createPhysicalKeyboardKeyBridge(),
      _createHardwareKeyboardBridge(),
      _createRestorationManagerBridge(),
      _createServicesBindingBridge(),
      _createSystemContextMenuClientBridge(),
      _createBrowserContextMenuBridge(),
      _createClipboardDataBridge(),
      _createClipboardBridge(),
      _createDeferredComponentBridge(),
      _createFlutterVersionBridge(),
      _createFontLoaderBridge(),
      _createHapticFeedbackBridge(),
      _createKeyboardInsertedContentBridge(),
      _createLiveTextBridge(),
      _createMessageCodecBridge(),
      _createMethodCallBridge(),
      _createMethodCodecBridge(),
      _createPlatformExceptionBridge(),
      _createMissingPluginExceptionBridge(),
      _createBinaryCodecBridge(),
      _createStringCodecBridge(),
      _createJSONMessageCodecBridge(),
      _createJSONMethodCodecBridge(),
      _createStandardMessageCodecBridge(),
      _createStandardMethodCodecBridge(),
      _createPointerEventBridge(),
      _createMouseCursorManagerBridge(),
      _createMouseCursorSessionBridge(),
      _createMouseCursorBridge(),
      _createSystemMouseCursorBridge(),
      _createSystemMouseCursorsBridge(),
      _createMouseTrackerAnnotationBridge(),
      _createBasicMessageChannelBridge(),
      _createMethodChannelBridge(),
      _createOptionalMethodChannelBridge(),
      _createEventChannelBridge(),
      _createPlatformViewsRegistryBridge(),
      _createPlatformViewsServiceBridge(),
      _createAndroidPointerPropertiesBridge(),
      _createAndroidPointerCoordsBridge(),
      _createAndroidMotionEventBridge(),
      _createAndroidViewControllerBridge(),
      _createSurfaceAndroidViewControllerBridge(),
      _createExpensiveAndroidViewControllerBridge(),
      _createHybridAndroidViewControllerBridge(),
      _createTextureAndroidViewControllerBridge(),
      _createDarwinPlatformViewControllerBridge(),
      _createUiKitViewControllerBridge(),
      _createAppKitViewControllerBridge(),
      _createPlatformViewControllerBridge(),
      _createPredictiveBackEventBridge(),
      _createProcessTextActionBridge(),
      _createProcessTextServiceBridge(),
      _createDefaultProcessTextServiceBridge(),
      _createScribeBridge(),
      _createSensitiveContentServiceBridge(),
      _createSuggestionSpanBridge(),
      _createSpellCheckResultsBridge(),
      _createSpellCheckServiceBridge(),
      _createDefaultSpellCheckServiceBridge(),
      _createSystemChannelsBridge(),
      _createApplicationSwitcherDescriptionBridge(),
      _createSystemUiOverlayStyleBridge(),
      _createSystemChromeBridge(),
      _createSystemNavigatorBridge(),
      _createSystemSoundBridge(),
      _createTextBoundaryBridge(),
      _createCharacterBoundaryBridge(),
      _createLineBoundaryBridge(),
      _createParagraphBoundaryBridge(),
      _createDocumentBoundaryBridge(),
      _createTextInputFormatterBridge(),
      _createFilteringTextInputFormatterBridge(),
      _createLengthLimitingTextInputFormatterBridge(),
      _createTextLayoutMetricsBridge(),
      _createUndoManagerBridge(),
      _createUndoManagerClientBridge(),
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
      'AssetBundle': 'package:flutter/src/services/asset_bundle.dart',
      'NetworkAssetBundle': 'package:flutter/src/services/asset_bundle.dart',
      'CachingAssetBundle': 'package:flutter/src/services/asset_bundle.dart',
      'PlatformAssetBundle': 'package:flutter/src/services/asset_bundle.dart',
      'AssetManifest': 'package:flutter/src/services/asset_manifest.dart',
      'AssetMetadata': 'package:flutter/src/services/asset_manifest.dart',
      'Matrix4': 'package:vector_math/vector_math_64.dart',
      'AutofillConfiguration': 'package:flutter/src/services/autofill.dart',
      'AutofillScope': 'package:flutter/src/services/autofill.dart',
      'TextSelection': 'package:flutter/src/services/text_editing.dart',
      'TextEditingDelta': 'package:flutter/src/services/text_editing_delta.dart',
      'BinaryMessenger': 'package:flutter/src/services/binary_messenger.dart',
      'DiagnosticPropertiesBuilder': 'package:flutter/src/foundation/diagnostics.dart',
      'WriteBuffer': 'package:flutter/src/foundation/serialization.dart',
      'ReadBuffer': 'package:flutter/src/foundation/serialization.dart',
      'LogicalKeyboardKey': 'package:flutter/src/services/keyboard_key.g.dart',
      'PhysicalKeyboardKey': 'package:flutter/src/services/keyboard_key.g.dart',
      'HardwareKeyboard': 'package:flutter/src/services/hardware_keyboard.dart',
      'RestorationManager': 'package:flutter/src/services/restoration.dart',
      'ServicesBinding': 'package:flutter/src/services/binding.dart',
      'SystemContextMenuClient': 'package:flutter/src/services/binding.dart',
      'BrowserContextMenu': 'package:flutter/src/services/browser_context_menu.dart',
      'ClipboardData': 'package:flutter/src/services/clipboard.dart',
      'Clipboard': 'package:flutter/src/services/clipboard.dart',
      'DeferredComponent': 'package:flutter/src/services/deferred_component.dart',
      'FlutterVersion': 'package:flutter/src/services/flutter_version.dart',
      'FontLoader': 'package:flutter/src/services/font_loader.dart',
      'HapticFeedback': 'package:flutter/src/services/haptic_feedback.dart',
      'KeyboardInsertedContent': 'package:flutter/src/services/keyboard_inserted_content.dart',
      'LiveText': 'package:flutter/src/services/live_text.dart',
      'MessageCodec': 'package:flutter/src/services/message_codec.dart',
      'MethodCall': 'package:flutter/src/services/message_codec.dart',
      'MethodCodec': 'package:flutter/src/services/message_codec.dart',
      'PlatformException': 'package:flutter/src/services/message_codec.dart',
      'MissingPluginException': 'package:flutter/src/services/message_codec.dart',
      'BinaryCodec': 'package:flutter/src/services/message_codecs.dart',
      'StringCodec': 'package:flutter/src/services/message_codecs.dart',
      'JSONMessageCodec': 'package:flutter/src/services/message_codecs.dart',
      'JSONMethodCodec': 'package:flutter/src/services/message_codecs.dart',
      'StandardMessageCodec': 'package:flutter/src/services/message_codecs.dart',
      'StandardMethodCodec': 'package:flutter/src/services/message_codecs.dart',
      'PointerEvent': 'package:flutter/src/gestures/events.dart',
      'MouseCursorManager': 'package:flutter/src/services/mouse_cursor.dart',
      'MouseCursorSession': 'package:flutter/src/services/mouse_cursor.dart',
      'MouseCursor': 'package:flutter/src/services/mouse_cursor.dart',
      'SystemMouseCursor': 'package:flutter/src/services/mouse_cursor.dart',
      'SystemMouseCursors': 'package:flutter/src/services/mouse_cursor.dart',
      'MouseTrackerAnnotation': 'package:flutter/src/services/mouse_tracking.dart',
      'BasicMessageChannel': 'package:flutter/src/services/platform_channel.dart',
      'MethodChannel': 'package:flutter/src/services/platform_channel.dart',
      'OptionalMethodChannel': 'package:flutter/src/services/platform_channel.dart',
      'EventChannel': 'package:flutter/src/services/platform_channel.dart',
      'PlatformViewsRegistry': 'package:flutter/src/services/platform_views.dart',
      'PlatformViewsService': 'package:flutter/src/services/platform_views.dart',
      'AndroidPointerProperties': 'package:flutter/src/services/platform_views.dart',
      'AndroidPointerCoords': 'package:flutter/src/services/platform_views.dart',
      'AndroidMotionEvent': 'package:flutter/src/services/platform_views.dart',
      'AndroidViewController': 'package:flutter/src/services/platform_views.dart',
      'SurfaceAndroidViewController': 'package:flutter/src/services/platform_views.dart',
      'ExpensiveAndroidViewController': 'package:flutter/src/services/platform_views.dart',
      'HybridAndroidViewController': 'package:flutter/src/services/platform_views.dart',
      'TextureAndroidViewController': 'package:flutter/src/services/platform_views.dart',
      'DarwinPlatformViewController': 'package:flutter/src/services/platform_views.dart',
      'UiKitViewController': 'package:flutter/src/services/platform_views.dart',
      'AppKitViewController': 'package:flutter/src/services/platform_views.dart',
      'PlatformViewController': 'package:flutter/src/services/platform_views.dart',
      'PredictiveBackEvent': 'package:flutter/src/services/predictive_back_event.dart',
      'ProcessTextAction': 'package:flutter/src/services/process_text.dart',
      'ProcessTextService': 'package:flutter/src/services/process_text.dart',
      'DefaultProcessTextService': 'package:flutter/src/services/process_text.dart',
      'Scribe': 'package:flutter/src/services/scribe.dart',
      'SensitiveContentService': 'package:flutter/src/services/sensitive_content.dart',
      'SuggestionSpan': 'package:flutter/src/services/spell_check.dart',
      'SpellCheckResults': 'package:flutter/src/services/spell_check.dart',
      'SpellCheckService': 'package:flutter/src/services/spell_check.dart',
      'DefaultSpellCheckService': 'package:flutter/src/services/spell_check.dart',
      'SystemChannels': 'package:flutter/src/services/system_channels.dart',
      'ApplicationSwitcherDescription': 'package:flutter/src/services/system_chrome.dart',
      'SystemUiOverlayStyle': 'package:flutter/src/services/system_chrome.dart',
      'SystemChrome': 'package:flutter/src/services/system_chrome.dart',
      'SystemNavigator': 'package:flutter/src/services/system_navigator.dart',
      'SystemSound': 'package:flutter/src/services/system_sound.dart',
      'TextBoundary': 'package:flutter/src/services/text_boundary.dart',
      'CharacterBoundary': 'package:flutter/src/services/text_boundary.dart',
      'LineBoundary': 'package:flutter/src/services/text_boundary.dart',
      'ParagraphBoundary': 'package:flutter/src/services/text_boundary.dart',
      'DocumentBoundary': 'package:flutter/src/services/text_boundary.dart',
      'TextInputFormatter': 'package:flutter/src/services/text_formatter.dart',
      'FilteringTextInputFormatter': 'package:flutter/src/services/text_formatter.dart',
      'LengthLimitingTextInputFormatter': 'package:flutter/src/services/text_formatter.dart',
      'TextLayoutMetrics': 'package:flutter/src/services/text_layout_metrics.dart',
      'UndoManager': 'package:flutter/src/services/undo_manager.dart',
      'UndoManagerClient': 'package:flutter/src/services/undo_manager.dart',
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
      BridgedEnumDefinition<$flutter_3.TargetPlatform>(
        name: 'TargetPlatform',
        values: $flutter_3.TargetPlatform.values,
      ),
      BridgedEnumDefinition<$flutter_32.SwipeEdge>(
        name: 'SwipeEdge',
        values: $flutter_32.SwipeEdge.values,
      ),
      BridgedEnumDefinition<$flutter_37.ContentSensitivity>(
        name: 'ContentSensitivity',
        values: $flutter_37.ContentSensitivity.values,
      ),
      BridgedEnumDefinition<$flutter_38.ServicesServiceExtensions>(
        name: 'ServicesServiceExtensions',
        values: $flutter_38.ServicesServiceExtensions.values,
      ),
      BridgedEnumDefinition<$flutter_41.DeviceOrientation>(
        name: 'DeviceOrientation',
        values: $flutter_41.DeviceOrientation.values,
      ),
      BridgedEnumDefinition<$flutter_41.SystemUiOverlay>(
        name: 'SystemUiOverlay',
        values: $flutter_41.SystemUiOverlay.values,
      ),
      BridgedEnumDefinition<$flutter_41.SystemUiMode>(
        name: 'SystemUiMode',
        values: $flutter_41.SystemUiMode.values,
      ),
      BridgedEnumDefinition<$flutter_43.SystemSoundType>(
        name: 'SystemSoundType',
        values: $flutter_43.SystemSoundType.values,
      ),
      BridgedEnumDefinition<$flutter_47.MaxLengthEnforcement>(
        name: 'MaxLengthEnforcement',
        values: $flutter_47.MaxLengthEnforcement.values,
      ),
      BridgedEnumDefinition<$flutter_50.UndoDirection>(
        name: 'UndoDirection',
        values: $flutter_50.UndoDirection.values,
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
      'TargetPlatform': 'package:flutter/src/foundation/platform.dart',
      'SwipeEdge': 'package:flutter/src/services/predictive_back_event.dart',
      'ContentSensitivity': 'package:flutter/src/services/sensitive_content.dart',
      'ServicesServiceExtensions': 'package:flutter/src/services/service_extensions.dart',
      'DeviceOrientation': 'package:flutter/src/services/system_chrome.dart',
      'SystemUiOverlay': 'package:flutter/src/services/system_chrome.dart',
      'SystemUiMode': 'package:flutter/src/services/system_chrome.dart',
      'SystemSoundType': 'package:flutter/src/services/system_sound.dart',
      'MaxLengthEnforcement': 'package:flutter/src/services/text_formatter.dart',
      'UndoDirection': 'package:flutter/src/services/undo_manager.dart',
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
      interpreter.registerGlobalVariable('rootBundle', $flutter_8.rootBundle, importPath, sourceUri: 'package:flutter/src/services/asset_bundle.dart');
    } catch (e) {
      errors.add('Failed to register variable "rootBundle": $e');
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
      interpreter.registerGlobalVariable('debugPrintKeyboardEvents', $flutter_15.debugPrintKeyboardEvents, importPath, sourceUri: 'package:flutter/src/services/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintKeyboardEvents": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugProfilePlatformChannels', $flutter_15.debugProfilePlatformChannels, importPath, sourceUri: 'package:flutter/src/services/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugProfilePlatformChannels": $e');
    }
    try {
      interpreter.registerGlobalVariable('appFlavor', $flutter_17.appFlavor, importPath, sourceUri: 'package:flutter/src/services/flavor.dart');
    } catch (e) {
      errors.add('Failed to register variable "appFlavor": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAndroidToLogicalKey', $flutter_24.kAndroidToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAndroidToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAndroidToPhysicalKey', $flutter_24.kAndroidToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAndroidToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAndroidNumPadMap', $flutter_24.kAndroidNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAndroidNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kFuchsiaToLogicalKey', $flutter_24.kFuchsiaToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kFuchsiaToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kFuchsiaToPhysicalKey', $flutter_24.kFuchsiaToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kFuchsiaToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsToPhysicalKey', $flutter_24.kMacOsToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsNumPadMap', $flutter_24.kMacOsNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsFunctionKeyMap', $flutter_24.kMacOsFunctionKeyMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsFunctionKeyMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsToLogicalKey', $flutter_24.kMacOsToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosToPhysicalKey', $flutter_24.kIosToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosSpecialLogicalMap', $flutter_24.kIosSpecialLogicalMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosSpecialLogicalMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosNumPadMap', $flutter_24.kIosNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosToLogicalKey', $flutter_24.kIosToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGlfwToLogicalKey', $flutter_24.kGlfwToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGlfwToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGlfwNumpadMap', $flutter_24.kGlfwNumpadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGlfwNumpadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGtkToLogicalKey', $flutter_24.kGtkToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGtkToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGtkNumpadMap', $flutter_24.kGtkNumpadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGtkNumpadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kLinuxToPhysicalKey', $flutter_24.kLinuxToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kLinuxToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebToLogicalKey', $flutter_24.kWebToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebToPhysicalKey', $flutter_24.kWebToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebNumPadMap', $flutter_24.kWebNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebLocationMap', $flutter_24.kWebLocationMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebLocationMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowsToLogicalKey', $flutter_24.kWindowsToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowsToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowsToPhysicalKey', $flutter_24.kWindowsToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowsToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowsNumPadMap', $flutter_24.kWindowsNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowsNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kProfilePlatformChannels', $flutter_30.kProfilePlatformChannels, importPath, sourceUri: 'package:flutter/src/services/platform_channel.dart');
    } catch (e) {
      errors.add('Failed to register variable "kProfilePlatformChannels": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformViewsRegistry', $flutter_31.platformViewsRegistry, importPath, sourceUri: 'package:flutter/src/services/platform_views.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformViewsRegistry": $e');
    }
    interpreter.registerGlobalGetter('shouldProfilePlatformChannels', () => $flutter_30.shouldProfilePlatformChannels, importPath, sourceUri: 'package:flutter/src/services/platform_channel.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_services):\n${errors.join("\n")}');
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
      'debugAssertAllServicesVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllServicesVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllServicesVarsUnset');
        return $flutter_15.debugAssertAllServicesVarsUnset(reason);
      },
      'runeToLowerCase': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'runeToLowerCase');
        final rune = D4.getRequiredArg<int>(positional, 0, 'rune', 'runeToLowerCase');
        return $flutter_34.runeToLowerCase(rune);
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
      'debugAssertAllServicesVarsUnset': 'package:flutter/src/services/debug.dart',
      'runeToLowerCase': 'package:flutter/src/services/raw_keyboard_macos.dart',
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
      'debugAssertAllServicesVarsUnset': 'bool debugAssertAllServicesVarsUnset(String reason)',
      'runeToLowerCase': 'int runeToLowerCase(int rune)',
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
      'package:flutter/src/foundation/platform.dart',
      'package:flutter/src/foundation/serialization.dart',
      'package:flutter/src/gestures/events.dart',
      'package:flutter/src/services/asset_bundle.dart',
      'package:flutter/src/services/asset_manifest.dart',
      'package:flutter/src/services/autofill.dart',
      'package:flutter/src/services/binary_messenger.dart',
      'package:flutter/src/services/binding.dart',
      'package:flutter/src/services/browser_context_menu.dart',
      'package:flutter/src/services/clipboard.dart',
      'package:flutter/src/services/debug.dart',
      'package:flutter/src/services/deferred_component.dart',
      'package:flutter/src/services/flavor.dart',
      'package:flutter/src/services/flutter_version.dart',
      'package:flutter/src/services/font_loader.dart',
      'package:flutter/src/services/haptic_feedback.dart',
      'package:flutter/src/services/hardware_keyboard.dart',
      'package:flutter/src/services/keyboard_inserted_content.dart',
      'package:flutter/src/services/keyboard_key.g.dart',
      'package:flutter/src/services/keyboard_maps.g.dart',
      'package:flutter/src/services/live_text.dart',
      'package:flutter/src/services/message_codec.dart',
      'package:flutter/src/services/message_codecs.dart',
      'package:flutter/src/services/mouse_cursor.dart',
      'package:flutter/src/services/mouse_tracking.dart',
      'package:flutter/src/services/platform_channel.dart',
      'package:flutter/src/services/platform_views.dart',
      'package:flutter/src/services/predictive_back_event.dart',
      'package:flutter/src/services/process_text.dart',
      'package:flutter/src/services/raw_keyboard_macos.dart',
      'package:flutter/src/services/restoration.dart',
      'package:flutter/src/services/scribe.dart',
      'package:flutter/src/services/sensitive_content.dart',
      'package:flutter/src/services/service_extensions.dart',
      'package:flutter/src/services/spell_check.dart',
      'package:flutter/src/services/system_channels.dart',
      'package:flutter/src/services/system_chrome.dart',
      'package:flutter/src/services/system_navigator.dart',
      'package:flutter/src/services/system_sound.dart',
      'package:flutter/src/services/text_boundary.dart',
      'package:flutter/src/services/text_editing.dart',
      'package:flutter/src/services/text_editing_delta.dart',
      'package:flutter/src/services/text_formatter.dart',
      'package:flutter/src/services/text_layout_metrics.dart',
      'package:flutter/src/services/undo_manager.dart',
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
    imports.writeln("import 'package:flutter/services.dart';");
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
    'TargetPlatform',
    'SwipeEdge',
    'ContentSensitivity',
    'ServicesServiceExtensions',
    'DeviceOrientation',
    'SystemUiOverlay',
    'SystemUiMode',
    'SystemSoundType',
    'MaxLengthEnforcement',
    'UndoDirection',
  ];

}

// =============================================================================
// AssetBundle Bridge
// =============================================================================

BridgedClass _createAssetBundleBridge() {
  return BridgedClass(
    nativeType: $flutter_8.AssetBundle,
    name: 'AssetBundle',
    constructors: {
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AssetBundle>(target, 'AssetBundle');
        return t.toString();
      },
    },
    methodSignatures: {
      'load': 'Future<ByteData> load(String key)',
      'loadBuffer': 'Future<ui.ImmutableBuffer> loadBuffer(String key)',
      'loadString': 'Future<String> loadString(String key, {bool cache = true})',
      'loadStructuredData': 'Future<T> loadStructuredData(String key, Future<T> Function(String value) parser)',
      'loadStructuredBinaryData': 'Future<T> loadStructuredBinaryData(String key, FutureOr<T> Function(ByteData data) parser)',
      'evict': 'void evict(String key)',
      'clear': 'void clear()',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// NetworkAssetBundle Bridge
// =============================================================================

BridgedClass _createNetworkAssetBundleBridge() {
  return BridgedClass(
    nativeType: $flutter_8.NetworkAssetBundle,
    name: 'NetworkAssetBundle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NetworkAssetBundle');
        final baseUrl = D4.getRequiredArg<Uri>(positional, 0, 'baseUrl', 'NetworkAssetBundle');
        return $flutter_8.NetworkAssetBundle(baseUrl);
      },
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'NetworkAssetBundle(Uri baseUrl)',
    },
    methodSignatures: {
      'load': 'Future<ByteData> load(String key)',
      'loadBuffer': 'Future<ImmutableBuffer> loadBuffer(String key)',
      'loadString': 'Future<String> loadString(String key, {bool cache = true})',
      'loadStructuredData': 'Future<T> loadStructuredData(String key, Future<T> Function(String) parser)',
      'loadStructuredBinaryData': 'Future<T> loadStructuredBinaryData(String key, FutureOr<T> Function(ByteData) parser)',
      'evict': 'void evict(String key)',
      'clear': 'void clear()',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// CachingAssetBundle Bridge
// =============================================================================

BridgedClass _createCachingAssetBundleBridge() {
  return BridgedClass(
    nativeType: $flutter_8.CachingAssetBundle,
    name: 'CachingAssetBundle',
    constructors: {
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.CachingAssetBundle>(target, 'CachingAssetBundle');
        return t.toString();
      },
    },
    methodSignatures: {
      'load': 'Future<ByteData> load(String key)',
      'loadBuffer': 'Future<ui.ImmutableBuffer> loadBuffer(String key)',
      'loadString': 'Future<String> loadString(String key, {bool cache = true})',
      'loadStructuredData': 'Future<T> loadStructuredData(String key, Future<T> Function(String value) parser)',
      'loadStructuredBinaryData': 'Future<T> loadStructuredBinaryData(String key, FutureOr<T> Function(ByteData data) parser)',
      'evict': 'void evict(String key)',
      'clear': 'void clear()',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// PlatformAssetBundle Bridge
// =============================================================================

BridgedClass _createPlatformAssetBundleBridge() {
  return BridgedClass(
    nativeType: $flutter_8.PlatformAssetBundle,
    name: 'PlatformAssetBundle',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_8.PlatformAssetBundle();
      },
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'PlatformAssetBundle()',
    },
    methodSignatures: {
      'load': 'Future<ByteData> load(String key)',
      'loadBuffer': 'Future<ui.ImmutableBuffer> loadBuffer(String key)',
      'loadString': 'Future<String> loadString(String key, {bool cache = true})',
      'loadStructuredData': 'Future<T> loadStructuredData(String key, Future<T> Function(String) parser)',
      'loadStructuredBinaryData': 'Future<T> loadStructuredBinaryData(String key, FutureOr<T> Function(ByteData) parser)',
      'evict': 'void evict(String key)',
      'clear': 'void clear()',
      'toString': 'String toString()',
    },
  );
}

// =============================================================================
// AssetManifest Bridge
// =============================================================================

BridgedClass _createAssetManifestBridge() {
  return BridgedClass(
    nativeType: $flutter_9.AssetManifest,
    name: 'AssetManifest',
    constructors: {
    },
    methods: {
      'listAssets': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.AssetManifest>(target, 'AssetManifest');
        return t.listAssets();
      },
      'getAssetVariants': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_9.AssetManifest>(target, 'AssetManifest');
        D4.requireMinArgs(positional, 1, 'getAssetVariants');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'getAssetVariants');
        return t.getAssetVariants(key);
      },
    },
    staticMethods: {
      'loadFromAssetBundle': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadFromAssetBundle');
        final bundle = D4.getRequiredArg<$flutter_8.AssetBundle>(positional, 0, 'bundle', 'loadFromAssetBundle');
        return $flutter_9.AssetManifest.loadFromAssetBundle(bundle);
      },
    },
    methodSignatures: {
      'listAssets': 'List<String> listAssets()',
      'getAssetVariants': 'List<AssetMetadata>? getAssetVariants(String key)',
    },
    staticMethodSignatures: {
      'loadFromAssetBundle': 'Future<AssetManifest> loadFromAssetBundle(AssetBundle bundle)',
    },
  );
}

// =============================================================================
// AssetMetadata Bridge
// =============================================================================

BridgedClass _createAssetMetadataBridge() {
  return BridgedClass(
    nativeType: $flutter_9.AssetMetadata,
    name: 'AssetMetadata',
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getRequiredNamedArg<String>(named, 'key', 'AssetMetadata');
        final targetDevicePixelRatio = D4.getRequiredNamedArg<double?>(named, 'targetDevicePixelRatio', 'AssetMetadata');
        final main = D4.getRequiredNamedArg<bool>(named, 'main', 'AssetMetadata');
        return $flutter_9.AssetMetadata(key: key, targetDevicePixelRatio: targetDevicePixelRatio, main: main);
      },
    },
    getters: {
      'targetDevicePixelRatio': (visitor, target) => D4.validateTarget<$flutter_9.AssetMetadata>(target, 'AssetMetadata').targetDevicePixelRatio,
      'key': (visitor, target) => D4.validateTarget<$flutter_9.AssetMetadata>(target, 'AssetMetadata').key,
      'main': (visitor, target) => D4.validateTarget<$flutter_9.AssetMetadata>(target, 'AssetMetadata').main,
    },
    constructorSignatures: {
      '': 'const AssetMetadata({required String key, required double? targetDevicePixelRatio, required bool main})',
    },
    getterSignatures: {
      'targetDevicePixelRatio': 'double? get targetDevicePixelRatio',
      'key': 'String get key',
      'main': 'bool get main',
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
// AutofillConfiguration Bridge
// =============================================================================

BridgedClass _createAutofillConfigurationBridge() {
  return BridgedClass(
    nativeType: $flutter_10.AutofillConfiguration,
    name: 'AutofillConfiguration',
    constructors: {
      '': (visitor, positional, named) {
        final uniqueIdentifier = D4.getRequiredNamedArg<String>(named, 'uniqueIdentifier', 'AutofillConfiguration');
        if (!named.containsKey('autofillHints') || named['autofillHints'] == null) {
          throw ArgumentError('AutofillConfiguration: Missing required named argument "autofillHints"');
        }
        final autofillHints = D4.coerceList<String>(named['autofillHints'], 'autofillHints');
        final currentEditingValue = D4.getRequiredNamedArg<$flutter_48.TextEditingValue>(named, 'currentEditingValue', 'AutofillConfiguration');
        final hintText = D4.getOptionalNamedArg<String?>(named, 'hintText');
        return $flutter_10.AutofillConfiguration(uniqueIdentifier: uniqueIdentifier, autofillHints: autofillHints, currentEditingValue: currentEditingValue, hintText: hintText);
      },
    },
    getters: {
      'enabled': (visitor, target) => D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration').enabled,
      'uniqueIdentifier': (visitor, target) => D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration').uniqueIdentifier,
      'autofillHints': (visitor, target) => D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration').autofillHints,
      'currentEditingValue': (visitor, target) => D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration').currentEditingValue,
      'hintText': (visitor, target) => D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration').hintText,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration').hashCode,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AutofillConfiguration>(target, 'AutofillConfiguration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'disabled': (visitor) => $flutter_10.AutofillConfiguration.disabled,
    },
    constructorSignatures: {
      '': 'const AutofillConfiguration({required String uniqueIdentifier, required List<String> autofillHints, required TextEditingValue currentEditingValue, String? hintText})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic>? toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'enabled': 'bool get enabled',
      'uniqueIdentifier': 'String get uniqueIdentifier',
      'autofillHints': 'List<String> get autofillHints',
      'currentEditingValue': 'TextEditingValue get currentEditingValue',
      'hintText': 'String? get hintText',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'disabled': 'AutofillConfiguration get disabled',
    },
  );
}

// =============================================================================
// AutofillScope Bridge
// =============================================================================

BridgedClass _createAutofillScopeBridge() {
  return BridgedClass(
    nativeType: $flutter_10.AutofillScope,
    name: 'AutofillScope',
    constructors: {
    },
    getters: {
      'autofillClients': (visitor, target) => D4.validateTarget<$flutter_10.AutofillScope>(target, 'AutofillScope').autofillClients,
    },
    methods: {
      'getAutofillClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AutofillScope>(target, 'AutofillScope');
        D4.requireMinArgs(positional, 1, 'getAutofillClient');
        final autofillId = D4.getRequiredArg<String>(positional, 0, 'autofillId', 'getAutofillClient');
        return t.getAutofillClient(autofillId);
      },
      'attach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AutofillScope>(target, 'AutofillScope');
        D4.requireMinArgs(positional, 2, 'attach');
        final trigger = D4.getRequiredArg<$flutter_48.TextInputClient>(positional, 0, 'trigger', 'attach');
        final configuration = D4.getRequiredArg<$flutter_48.TextInputConfiguration>(positional, 1, 'configuration', 'attach');
        return t.attach(trigger, configuration);
      },
    },
    methodSignatures: {
      'getAutofillClient': 'AutofillClient? getAutofillClient(String autofillId)',
      'attach': 'TextInputConnection attach(TextInputClient trigger, TextInputConfiguration configuration)',
    },
    getterSignatures: {
      'autofillClients': 'Iterable<AutofillClient> get autofillClients',
    },
  );
}

// =============================================================================
// TextSelection Bridge
// =============================================================================

BridgedClass _createTextSelectionBridge() {
  return BridgedClass(
    nativeType: $flutter_45.TextSelection,
    name: 'TextSelection',
    constructors: {
      '': (visitor, positional, named) {
        final baseOffset = D4.getRequiredNamedArg<int>(named, 'baseOffset', 'TextSelection');
        final extentOffset = D4.getRequiredNamedArg<int>(named, 'extentOffset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        final isDirectional = D4.getNamedArgWithDefault<bool>(named, 'isDirectional', false);
        return $flutter_45.TextSelection(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'collapsed': (visitor, positional, named) {
        final offset = D4.getRequiredNamedArg<int>(named, 'offset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        return $flutter_45.TextSelection.collapsed(offset: offset, affinity: affinity);
      },
      'fromPosition': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextSelection');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'TextSelection');
        return $flutter_45.TextSelection.fromPosition(position);
      },
    },
    getters: {
      'baseOffset': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').baseOffset,
      'extentOffset': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').extentOffset,
      'affinity': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').affinity,
      'isDirectional': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').isDirectional,
      'base': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').base,
      'extent': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').extent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').end,
      'isValid': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').isValid,
      'isCollapsed': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').isCollapsed,
      'isNormalized': (visitor, target) => D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection').isNormalized,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
        final baseOffset = D4.getOptionalNamedArg<int?>(named, 'baseOffset');
        final extentOffset = D4.getOptionalNamedArg<int?>(named, 'extentOffset');
        final affinity = D4.getOptionalNamedArg<TextAffinity?>(named, 'affinity');
        final isDirectional = D4.getOptionalNamedArg<bool?>(named, 'isDirectional');
        return t.copyWith(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'expandTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'expandTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'expandTo');
        final extentAtIndex = D4.getOptionalArgWithDefault<bool>(positional, 1, 'extentAtIndex', false);
        return t.expandTo(position, extentAtIndex);
      },
      'extendTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'extendTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'extendTo');
        return t.extendTo(position);
      },
      'textBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textBefore');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textBefore');
        return t.textBefore(text);
      },
      'textAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textAfter');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textAfter');
        return t.textAfter(text);
      },
      'textInside': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textInside');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textInside');
        return t.textInside(text);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_45.TextSelection>(target, 'TextSelection');
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
// TextEditingDelta Bridge
// =============================================================================

BridgedClass _createTextEditingDeltaBridge() {
  return BridgedClass(
    nativeType: $flutter_46.TextEditingDelta,
    name: 'TextEditingDelta',
    constructors: {
      'fromJSON': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextEditingDelta');
        if (positional.isEmpty) {
          throw ArgumentError('TextEditingDelta: Missing required argument "encoded" at position 0');
        }
        final encoded = D4.coerceMap<String, dynamic>(positional[0], 'encoded');
        return $flutter_46.TextEditingDelta.fromJSON(encoded);
      },
    },
    getters: {
      'oldText': (visitor, target) => D4.validateTarget<$flutter_46.TextEditingDelta>(target, 'TextEditingDelta').oldText,
      'selection': (visitor, target) => D4.validateTarget<$flutter_46.TextEditingDelta>(target, 'TextEditingDelta').selection,
      'composing': (visitor, target) => D4.validateTarget<$flutter_46.TextEditingDelta>(target, 'TextEditingDelta').composing,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.TextEditingDelta>(target, 'TextEditingDelta');
        D4.requireMinArgs(positional, 1, 'apply');
        final value = D4.getRequiredArg<$flutter_48.TextEditingValue>(positional, 0, 'value', 'apply');
        return t.apply(value);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.TextEditingDelta>(target, 'TextEditingDelta');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.TextEditingDelta>(target, 'TextEditingDelta');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.TextEditingDelta>(target, 'TextEditingDelta');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      'fromJSON': 'factory TextEditingDelta.fromJSON(Map<String, dynamic> encoded)',
    },
    methodSignatures: {
      'apply': 'TextEditingValue apply(TextEditingValue value)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'oldText': 'String get oldText',
      'selection': 'TextSelection get selection',
      'composing': 'TextRange get composing',
    },
  );
}

// =============================================================================
// BinaryMessenger Bridge
// =============================================================================

BridgedClass _createBinaryMessengerBridge() {
  return BridgedClass(
    nativeType: $flutter_11.BinaryMessenger,
    name: 'BinaryMessenger',
    constructors: {
    },
    methods: {
      'handlePlatformMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.BinaryMessenger>(target, 'BinaryMessenger');
        D4.requireMinArgs(positional, 3, 'handlePlatformMessage');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'handlePlatformMessage');
        final data = D4.getRequiredArg<ByteData?>(positional, 1, 'data', 'handlePlatformMessage');
        if (positional.length <= 2) {
          throw ArgumentError('handlePlatformMessage: Missing required argument "callback" at position 2');
        }
        final callbackRaw = positional[2];
        return t.handlePlatformMessage(channel, data, callbackRaw == null ? null : (ByteData? p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
      },
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.BinaryMessenger>(target, 'BinaryMessenger');
        D4.requireMinArgs(positional, 2, 'send');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'send');
        final message = D4.getRequiredArg<ByteData?>(positional, 1, 'message', 'send');
        return t.send(channel, message);
      },
      'setMessageHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.BinaryMessenger>(target, 'BinaryMessenger');
        D4.requireMinArgs(positional, 2, 'setMessageHandler');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'setMessageHandler');
        if (positional.length <= 1) {
          throw ArgumentError('setMessageHandler: Missing required argument "handler" at position 1');
        }
        final handlerRaw = positional[1];
        t.setMessageHandler(channel, handlerRaw == null ? null : (ByteData? p0) { return D4.callInterpreterCallback(visitor, handlerRaw, [p0]) as Future<ByteData?>?; });
        return null;
      },
    },
    methodSignatures: {
      'handlePlatformMessage': 'Future<void> handlePlatformMessage(String channel, ByteData? data, ui.PlatformMessageResponseCallback? callback)',
      'send': 'Future<ByteData?>? send(String channel, ByteData? message)',
      'setMessageHandler': 'void setMessageHandler(String channel, MessageHandler? handler)',
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
// WriteBuffer Bridge
// =============================================================================

BridgedClass _createWriteBufferBridge() {
  return BridgedClass(
    nativeType: $flutter_4.WriteBuffer,
    name: 'WriteBuffer',
    constructors: {
      '': (visitor, positional, named) {
        final startCapacity = D4.getNamedArgWithDefault<int>(named, 'startCapacity', 8);
        return $flutter_4.WriteBuffer(startCapacity: startCapacity);
      },
    },
    methods: {
      'putUint8': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint8');
        final byte = D4.getRequiredArg<int>(positional, 0, 'byte', 'putUint8');
        t.putUint8(byte);
        return null;
      },
      'putUint16': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint16');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putUint16');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putUint16(value, endian: endian);
        return null;
      },
      'putUint32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint32');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putUint32');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putUint32(value, endian: endian);
        return null;
      },
      'putInt32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt32');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putInt32');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putInt32(value, endian: endian);
        return null;
      },
      'putInt64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt64');
        final value = D4.getRequiredArg<int>(positional, 0, 'value', 'putInt64');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putInt64(value, endian: endian);
        return null;
      },
      'putFloat64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat64');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'putFloat64');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        t.putFloat64(value, endian: endian);
        return null;
      },
      'putUint8List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putUint8List');
        final list = D4.getRequiredArg<Uint8List>(positional, 0, 'list', 'putUint8List');
        t.putUint8List(list);
        return null;
      },
      'putInt32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt32List');
        final list = D4.getRequiredArg<Int32List>(positional, 0, 'list', 'putInt32List');
        t.putInt32List(list);
        return null;
      },
      'putInt64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putInt64List');
        final list = D4.getRequiredArg<Int64List>(positional, 0, 'list', 'putInt64List');
        t.putInt64List(list);
        return null;
      },
      'putFloat32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat32List');
        final list = D4.getRequiredArg<Float32List>(positional, 0, 'list', 'putFloat32List');
        t.putFloat32List(list);
        return null;
      },
      'putFloat64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        D4.requireMinArgs(positional, 1, 'putFloat64List');
        final list = D4.getRequiredArg<Float64List>(positional, 0, 'list', 'putFloat64List');
        t.putFloat64List(list);
        return null;
      },
      'done': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.WriteBuffer>(target, 'WriteBuffer');
        return t.done();
      },
    },
    constructorSignatures: {
      '': 'factory WriteBuffer({int startCapacity = 8})',
    },
    methodSignatures: {
      'putUint8': 'void putUint8(int byte)',
      'putUint16': 'void putUint16(int value, {Endian? endian})',
      'putUint32': 'void putUint32(int value, {Endian? endian})',
      'putInt32': 'void putInt32(int value, {Endian? endian})',
      'putInt64': 'void putInt64(int value, {Endian? endian})',
      'putFloat64': 'void putFloat64(double value, {Endian? endian})',
      'putUint8List': 'void putUint8List(Uint8List list)',
      'putInt32List': 'void putInt32List(Int32List list)',
      'putInt64List': 'void putInt64List(Int64List list)',
      'putFloat32List': 'void putFloat32List(Float32List list)',
      'putFloat64List': 'void putFloat64List(Float64List list)',
      'done': 'ByteData done()',
    },
  );
}

// =============================================================================
// ReadBuffer Bridge
// =============================================================================

BridgedClass _createReadBufferBridge() {
  return BridgedClass(
    nativeType: $flutter_4.ReadBuffer,
    name: 'ReadBuffer',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReadBuffer');
        final data = D4.getRequiredArg<ByteData>(positional, 0, 'data', 'ReadBuffer');
        return $flutter_4.ReadBuffer(data);
      },
    },
    getters: {
      'data': (visitor, target) => D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer').data,
      'hasRemaining': (visitor, target) => D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer').hasRemaining,
    },
    methods: {
      'getUint8': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        return t.getUint8();
      },
      'getUint16': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getUint16(endian: endian);
      },
      'getUint32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getUint32(endian: endian);
      },
      'getInt32': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getInt32(endian: endian);
      },
      'getInt64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getInt64(endian: endian);
      },
      'getFloat64': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        final endian = D4.getOptionalNamedArg<Endian?>(named, 'endian');
        return t.getFloat64(endian: endian);
      },
      'getUint8List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getUint8List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getUint8List');
        return t.getUint8List(length);
      },
      'getInt32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getInt32List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getInt32List');
        return t.getInt32List(length);
      },
      'getInt64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getInt64List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getInt64List');
        return t.getInt64List(length);
      },
      'getFloat32List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getFloat32List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getFloat32List');
        return t.getFloat32List(length);
      },
      'getFloat64List': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.ReadBuffer>(target, 'ReadBuffer');
        D4.requireMinArgs(positional, 1, 'getFloat64List');
        final length = D4.getRequiredArg<int>(positional, 0, 'length', 'getFloat64List');
        return t.getFloat64List(length);
      },
    },
    constructorSignatures: {
      '': 'ReadBuffer(ByteData data)',
    },
    methodSignatures: {
      'getUint8': 'int getUint8()',
      'getUint16': 'int getUint16({Endian? endian})',
      'getUint32': 'int getUint32({Endian? endian})',
      'getInt32': 'int getInt32({Endian? endian})',
      'getInt64': 'int getInt64({Endian? endian})',
      'getFloat64': 'double getFloat64({Endian? endian})',
      'getUint8List': 'Uint8List getUint8List(int length)',
      'getInt32List': 'Int32List getInt32List(int length)',
      'getInt64List': 'Int64List getInt64List(int length)',
      'getFloat32List': 'Float32List getFloat32List(int length)',
      'getFloat64List': 'Float64List getFloat64List(int length)',
    },
    getterSignatures: {
      'data': 'ByteData get data',
      'hasRemaining': 'bool get hasRemaining',
    },
  );
}

// =============================================================================
// LogicalKeyboardKey Bridge
// =============================================================================

BridgedClass _createLogicalKeyboardKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_23.LogicalKeyboardKey,
    name: 'LogicalKeyboardKey',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LogicalKeyboardKey');
        final keyId = D4.getRequiredArg<int>(positional, 0, 'keyId', 'LogicalKeyboardKey');
        return $flutter_23.LogicalKeyboardKey(keyId);
      },
    },
    getters: {
      'keyId': (visitor, target) => D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').keyId,
      'keyLabel': (visitor, target) => D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').keyLabel,
      'debugName': (visitor, target) => D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').debugName,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').hashCode,
      'isAutogenerated': (visitor, target) => D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').isAutogenerated,
      'synonyms': (visitor, target) => D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').synonyms,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'valueMask': (visitor) => $flutter_23.LogicalKeyboardKey.valueMask,
      'planeMask': (visitor) => $flutter_23.LogicalKeyboardKey.planeMask,
      'unicodePlane': (visitor) => $flutter_23.LogicalKeyboardKey.unicodePlane,
      'unprintablePlane': (visitor) => $flutter_23.LogicalKeyboardKey.unprintablePlane,
      'flutterPlane': (visitor) => $flutter_23.LogicalKeyboardKey.flutterPlane,
      'startOfPlatformPlanes': (visitor) => $flutter_23.LogicalKeyboardKey.startOfPlatformPlanes,
      'androidPlane': (visitor) => $flutter_23.LogicalKeyboardKey.androidPlane,
      'fuchsiaPlane': (visitor) => $flutter_23.LogicalKeyboardKey.fuchsiaPlane,
      'iosPlane': (visitor) => $flutter_23.LogicalKeyboardKey.iosPlane,
      'macosPlane': (visitor) => $flutter_23.LogicalKeyboardKey.macosPlane,
      'gtkPlane': (visitor) => $flutter_23.LogicalKeyboardKey.gtkPlane,
      'windowsPlane': (visitor) => $flutter_23.LogicalKeyboardKey.windowsPlane,
      'webPlane': (visitor) => $flutter_23.LogicalKeyboardKey.webPlane,
      'glfwPlane': (visitor) => $flutter_23.LogicalKeyboardKey.glfwPlane,
      'space': (visitor) => $flutter_23.LogicalKeyboardKey.space,
      'exclamation': (visitor) => $flutter_23.LogicalKeyboardKey.exclamation,
      'quote': (visitor) => $flutter_23.LogicalKeyboardKey.quote,
      'numberSign': (visitor) => $flutter_23.LogicalKeyboardKey.numberSign,
      'dollar': (visitor) => $flutter_23.LogicalKeyboardKey.dollar,
      'percent': (visitor) => $flutter_23.LogicalKeyboardKey.percent,
      'ampersand': (visitor) => $flutter_23.LogicalKeyboardKey.ampersand,
      'quoteSingle': (visitor) => $flutter_23.LogicalKeyboardKey.quoteSingle,
      'parenthesisLeft': (visitor) => $flutter_23.LogicalKeyboardKey.parenthesisLeft,
      'parenthesisRight': (visitor) => $flutter_23.LogicalKeyboardKey.parenthesisRight,
      'asterisk': (visitor) => $flutter_23.LogicalKeyboardKey.asterisk,
      'add': (visitor) => $flutter_23.LogicalKeyboardKey.add,
      'comma': (visitor) => $flutter_23.LogicalKeyboardKey.comma,
      'minus': (visitor) => $flutter_23.LogicalKeyboardKey.minus,
      'period': (visitor) => $flutter_23.LogicalKeyboardKey.period,
      'slash': (visitor) => $flutter_23.LogicalKeyboardKey.slash,
      'digit0': (visitor) => $flutter_23.LogicalKeyboardKey.digit0,
      'digit1': (visitor) => $flutter_23.LogicalKeyboardKey.digit1,
      'digit2': (visitor) => $flutter_23.LogicalKeyboardKey.digit2,
      'digit3': (visitor) => $flutter_23.LogicalKeyboardKey.digit3,
      'digit4': (visitor) => $flutter_23.LogicalKeyboardKey.digit4,
      'digit5': (visitor) => $flutter_23.LogicalKeyboardKey.digit5,
      'digit6': (visitor) => $flutter_23.LogicalKeyboardKey.digit6,
      'digit7': (visitor) => $flutter_23.LogicalKeyboardKey.digit7,
      'digit8': (visitor) => $flutter_23.LogicalKeyboardKey.digit8,
      'digit9': (visitor) => $flutter_23.LogicalKeyboardKey.digit9,
      'colon': (visitor) => $flutter_23.LogicalKeyboardKey.colon,
      'semicolon': (visitor) => $flutter_23.LogicalKeyboardKey.semicolon,
      'less': (visitor) => $flutter_23.LogicalKeyboardKey.less,
      'equal': (visitor) => $flutter_23.LogicalKeyboardKey.equal,
      'greater': (visitor) => $flutter_23.LogicalKeyboardKey.greater,
      'question': (visitor) => $flutter_23.LogicalKeyboardKey.question,
      'at': (visitor) => $flutter_23.LogicalKeyboardKey.at,
      'bracketLeft': (visitor) => $flutter_23.LogicalKeyboardKey.bracketLeft,
      'backslash': (visitor) => $flutter_23.LogicalKeyboardKey.backslash,
      'bracketRight': (visitor) => $flutter_23.LogicalKeyboardKey.bracketRight,
      'caret': (visitor) => $flutter_23.LogicalKeyboardKey.caret,
      'underscore': (visitor) => $flutter_23.LogicalKeyboardKey.underscore,
      'backquote': (visitor) => $flutter_23.LogicalKeyboardKey.backquote,
      'keyA': (visitor) => $flutter_23.LogicalKeyboardKey.keyA,
      'keyB': (visitor) => $flutter_23.LogicalKeyboardKey.keyB,
      'keyC': (visitor) => $flutter_23.LogicalKeyboardKey.keyC,
      'keyD': (visitor) => $flutter_23.LogicalKeyboardKey.keyD,
      'keyE': (visitor) => $flutter_23.LogicalKeyboardKey.keyE,
      'keyF': (visitor) => $flutter_23.LogicalKeyboardKey.keyF,
      'keyG': (visitor) => $flutter_23.LogicalKeyboardKey.keyG,
      'keyH': (visitor) => $flutter_23.LogicalKeyboardKey.keyH,
      'keyI': (visitor) => $flutter_23.LogicalKeyboardKey.keyI,
      'keyJ': (visitor) => $flutter_23.LogicalKeyboardKey.keyJ,
      'keyK': (visitor) => $flutter_23.LogicalKeyboardKey.keyK,
      'keyL': (visitor) => $flutter_23.LogicalKeyboardKey.keyL,
      'keyM': (visitor) => $flutter_23.LogicalKeyboardKey.keyM,
      'keyN': (visitor) => $flutter_23.LogicalKeyboardKey.keyN,
      'keyO': (visitor) => $flutter_23.LogicalKeyboardKey.keyO,
      'keyP': (visitor) => $flutter_23.LogicalKeyboardKey.keyP,
      'keyQ': (visitor) => $flutter_23.LogicalKeyboardKey.keyQ,
      'keyR': (visitor) => $flutter_23.LogicalKeyboardKey.keyR,
      'keyS': (visitor) => $flutter_23.LogicalKeyboardKey.keyS,
      'keyT': (visitor) => $flutter_23.LogicalKeyboardKey.keyT,
      'keyU': (visitor) => $flutter_23.LogicalKeyboardKey.keyU,
      'keyV': (visitor) => $flutter_23.LogicalKeyboardKey.keyV,
      'keyW': (visitor) => $flutter_23.LogicalKeyboardKey.keyW,
      'keyX': (visitor) => $flutter_23.LogicalKeyboardKey.keyX,
      'keyY': (visitor) => $flutter_23.LogicalKeyboardKey.keyY,
      'keyZ': (visitor) => $flutter_23.LogicalKeyboardKey.keyZ,
      'braceLeft': (visitor) => $flutter_23.LogicalKeyboardKey.braceLeft,
      'bar': (visitor) => $flutter_23.LogicalKeyboardKey.bar,
      'braceRight': (visitor) => $flutter_23.LogicalKeyboardKey.braceRight,
      'tilde': (visitor) => $flutter_23.LogicalKeyboardKey.tilde,
      'unidentified': (visitor) => $flutter_23.LogicalKeyboardKey.unidentified,
      'backspace': (visitor) => $flutter_23.LogicalKeyboardKey.backspace,
      'tab': (visitor) => $flutter_23.LogicalKeyboardKey.tab,
      'enter': (visitor) => $flutter_23.LogicalKeyboardKey.enter,
      'escape': (visitor) => $flutter_23.LogicalKeyboardKey.escape,
      'delete': (visitor) => $flutter_23.LogicalKeyboardKey.delete,
      'accel': (visitor) => $flutter_23.LogicalKeyboardKey.accel,
      'altGraph': (visitor) => $flutter_23.LogicalKeyboardKey.altGraph,
      'capsLock': (visitor) => $flutter_23.LogicalKeyboardKey.capsLock,
      'fn': (visitor) => $flutter_23.LogicalKeyboardKey.fn,
      'fnLock': (visitor) => $flutter_23.LogicalKeyboardKey.fnLock,
      'hyper': (visitor) => $flutter_23.LogicalKeyboardKey.hyper,
      'numLock': (visitor) => $flutter_23.LogicalKeyboardKey.numLock,
      'scrollLock': (visitor) => $flutter_23.LogicalKeyboardKey.scrollLock,
      'superKey': (visitor) => $flutter_23.LogicalKeyboardKey.superKey,
      'symbol': (visitor) => $flutter_23.LogicalKeyboardKey.symbol,
      'symbolLock': (visitor) => $flutter_23.LogicalKeyboardKey.symbolLock,
      'shiftLevel5': (visitor) => $flutter_23.LogicalKeyboardKey.shiftLevel5,
      'arrowDown': (visitor) => $flutter_23.LogicalKeyboardKey.arrowDown,
      'arrowLeft': (visitor) => $flutter_23.LogicalKeyboardKey.arrowLeft,
      'arrowRight': (visitor) => $flutter_23.LogicalKeyboardKey.arrowRight,
      'arrowUp': (visitor) => $flutter_23.LogicalKeyboardKey.arrowUp,
      'end': (visitor) => $flutter_23.LogicalKeyboardKey.end,
      'home': (visitor) => $flutter_23.LogicalKeyboardKey.home,
      'pageDown': (visitor) => $flutter_23.LogicalKeyboardKey.pageDown,
      'pageUp': (visitor) => $flutter_23.LogicalKeyboardKey.pageUp,
      'clear': (visitor) => $flutter_23.LogicalKeyboardKey.clear,
      'copy': (visitor) => $flutter_23.LogicalKeyboardKey.copy,
      'crSel': (visitor) => $flutter_23.LogicalKeyboardKey.crSel,
      'cut': (visitor) => $flutter_23.LogicalKeyboardKey.cut,
      'eraseEof': (visitor) => $flutter_23.LogicalKeyboardKey.eraseEof,
      'exSel': (visitor) => $flutter_23.LogicalKeyboardKey.exSel,
      'insert': (visitor) => $flutter_23.LogicalKeyboardKey.insert,
      'paste': (visitor) => $flutter_23.LogicalKeyboardKey.paste,
      'redo': (visitor) => $flutter_23.LogicalKeyboardKey.redo,
      'undo': (visitor) => $flutter_23.LogicalKeyboardKey.undo,
      'accept': (visitor) => $flutter_23.LogicalKeyboardKey.accept,
      'again': (visitor) => $flutter_23.LogicalKeyboardKey.again,
      'attn': (visitor) => $flutter_23.LogicalKeyboardKey.attn,
      'cancel': (visitor) => $flutter_23.LogicalKeyboardKey.cancel,
      'contextMenu': (visitor) => $flutter_23.LogicalKeyboardKey.contextMenu,
      'execute': (visitor) => $flutter_23.LogicalKeyboardKey.execute,
      'find': (visitor) => $flutter_23.LogicalKeyboardKey.find,
      'help': (visitor) => $flutter_23.LogicalKeyboardKey.help,
      'pause': (visitor) => $flutter_23.LogicalKeyboardKey.pause,
      'play': (visitor) => $flutter_23.LogicalKeyboardKey.play,
      'props': (visitor) => $flutter_23.LogicalKeyboardKey.props,
      'select': (visitor) => $flutter_23.LogicalKeyboardKey.select,
      'zoomIn': (visitor) => $flutter_23.LogicalKeyboardKey.zoomIn,
      'zoomOut': (visitor) => $flutter_23.LogicalKeyboardKey.zoomOut,
      'brightnessDown': (visitor) => $flutter_23.LogicalKeyboardKey.brightnessDown,
      'brightnessUp': (visitor) => $flutter_23.LogicalKeyboardKey.brightnessUp,
      'camera': (visitor) => $flutter_23.LogicalKeyboardKey.camera,
      'eject': (visitor) => $flutter_23.LogicalKeyboardKey.eject,
      'logOff': (visitor) => $flutter_23.LogicalKeyboardKey.logOff,
      'power': (visitor) => $flutter_23.LogicalKeyboardKey.power,
      'powerOff': (visitor) => $flutter_23.LogicalKeyboardKey.powerOff,
      'printScreen': (visitor) => $flutter_23.LogicalKeyboardKey.printScreen,
      'hibernate': (visitor) => $flutter_23.LogicalKeyboardKey.hibernate,
      'standby': (visitor) => $flutter_23.LogicalKeyboardKey.standby,
      'wakeUp': (visitor) => $flutter_23.LogicalKeyboardKey.wakeUp,
      'allCandidates': (visitor) => $flutter_23.LogicalKeyboardKey.allCandidates,
      'alphanumeric': (visitor) => $flutter_23.LogicalKeyboardKey.alphanumeric,
      'codeInput': (visitor) => $flutter_23.LogicalKeyboardKey.codeInput,
      'compose': (visitor) => $flutter_23.LogicalKeyboardKey.compose,
      'convert': (visitor) => $flutter_23.LogicalKeyboardKey.convert,
      'finalMode': (visitor) => $flutter_23.LogicalKeyboardKey.finalMode,
      'groupFirst': (visitor) => $flutter_23.LogicalKeyboardKey.groupFirst,
      'groupLast': (visitor) => $flutter_23.LogicalKeyboardKey.groupLast,
      'groupNext': (visitor) => $flutter_23.LogicalKeyboardKey.groupNext,
      'groupPrevious': (visitor) => $flutter_23.LogicalKeyboardKey.groupPrevious,
      'modeChange': (visitor) => $flutter_23.LogicalKeyboardKey.modeChange,
      'nextCandidate': (visitor) => $flutter_23.LogicalKeyboardKey.nextCandidate,
      'nonConvert': (visitor) => $flutter_23.LogicalKeyboardKey.nonConvert,
      'previousCandidate': (visitor) => $flutter_23.LogicalKeyboardKey.previousCandidate,
      'process': (visitor) => $flutter_23.LogicalKeyboardKey.process,
      'singleCandidate': (visitor) => $flutter_23.LogicalKeyboardKey.singleCandidate,
      'hangulMode': (visitor) => $flutter_23.LogicalKeyboardKey.hangulMode,
      'hanjaMode': (visitor) => $flutter_23.LogicalKeyboardKey.hanjaMode,
      'junjaMode': (visitor) => $flutter_23.LogicalKeyboardKey.junjaMode,
      'eisu': (visitor) => $flutter_23.LogicalKeyboardKey.eisu,
      'hankaku': (visitor) => $flutter_23.LogicalKeyboardKey.hankaku,
      'hiragana': (visitor) => $flutter_23.LogicalKeyboardKey.hiragana,
      'hiraganaKatakana': (visitor) => $flutter_23.LogicalKeyboardKey.hiraganaKatakana,
      'kanaMode': (visitor) => $flutter_23.LogicalKeyboardKey.kanaMode,
      'kanjiMode': (visitor) => $flutter_23.LogicalKeyboardKey.kanjiMode,
      'katakana': (visitor) => $flutter_23.LogicalKeyboardKey.katakana,
      'romaji': (visitor) => $flutter_23.LogicalKeyboardKey.romaji,
      'zenkaku': (visitor) => $flutter_23.LogicalKeyboardKey.zenkaku,
      'zenkakuHankaku': (visitor) => $flutter_23.LogicalKeyboardKey.zenkakuHankaku,
      'f1': (visitor) => $flutter_23.LogicalKeyboardKey.f1,
      'f2': (visitor) => $flutter_23.LogicalKeyboardKey.f2,
      'f3': (visitor) => $flutter_23.LogicalKeyboardKey.f3,
      'f4': (visitor) => $flutter_23.LogicalKeyboardKey.f4,
      'f5': (visitor) => $flutter_23.LogicalKeyboardKey.f5,
      'f6': (visitor) => $flutter_23.LogicalKeyboardKey.f6,
      'f7': (visitor) => $flutter_23.LogicalKeyboardKey.f7,
      'f8': (visitor) => $flutter_23.LogicalKeyboardKey.f8,
      'f9': (visitor) => $flutter_23.LogicalKeyboardKey.f9,
      'f10': (visitor) => $flutter_23.LogicalKeyboardKey.f10,
      'f11': (visitor) => $flutter_23.LogicalKeyboardKey.f11,
      'f12': (visitor) => $flutter_23.LogicalKeyboardKey.f12,
      'f13': (visitor) => $flutter_23.LogicalKeyboardKey.f13,
      'f14': (visitor) => $flutter_23.LogicalKeyboardKey.f14,
      'f15': (visitor) => $flutter_23.LogicalKeyboardKey.f15,
      'f16': (visitor) => $flutter_23.LogicalKeyboardKey.f16,
      'f17': (visitor) => $flutter_23.LogicalKeyboardKey.f17,
      'f18': (visitor) => $flutter_23.LogicalKeyboardKey.f18,
      'f19': (visitor) => $flutter_23.LogicalKeyboardKey.f19,
      'f20': (visitor) => $flutter_23.LogicalKeyboardKey.f20,
      'f21': (visitor) => $flutter_23.LogicalKeyboardKey.f21,
      'f22': (visitor) => $flutter_23.LogicalKeyboardKey.f22,
      'f23': (visitor) => $flutter_23.LogicalKeyboardKey.f23,
      'f24': (visitor) => $flutter_23.LogicalKeyboardKey.f24,
      'soft1': (visitor) => $flutter_23.LogicalKeyboardKey.soft1,
      'soft2': (visitor) => $flutter_23.LogicalKeyboardKey.soft2,
      'soft3': (visitor) => $flutter_23.LogicalKeyboardKey.soft3,
      'soft4': (visitor) => $flutter_23.LogicalKeyboardKey.soft4,
      'soft5': (visitor) => $flutter_23.LogicalKeyboardKey.soft5,
      'soft6': (visitor) => $flutter_23.LogicalKeyboardKey.soft6,
      'soft7': (visitor) => $flutter_23.LogicalKeyboardKey.soft7,
      'soft8': (visitor) => $flutter_23.LogicalKeyboardKey.soft8,
      'close': (visitor) => $flutter_23.LogicalKeyboardKey.close,
      'mailForward': (visitor) => $flutter_23.LogicalKeyboardKey.mailForward,
      'mailReply': (visitor) => $flutter_23.LogicalKeyboardKey.mailReply,
      'mailSend': (visitor) => $flutter_23.LogicalKeyboardKey.mailSend,
      'mediaPlayPause': (visitor) => $flutter_23.LogicalKeyboardKey.mediaPlayPause,
      'mediaStop': (visitor) => $flutter_23.LogicalKeyboardKey.mediaStop,
      'mediaTrackNext': (visitor) => $flutter_23.LogicalKeyboardKey.mediaTrackNext,
      'mediaTrackPrevious': (visitor) => $flutter_23.LogicalKeyboardKey.mediaTrackPrevious,
      'newKey': (visitor) => $flutter_23.LogicalKeyboardKey.newKey,
      'open': (visitor) => $flutter_23.LogicalKeyboardKey.open,
      'print': (visitor) => $flutter_23.LogicalKeyboardKey.print,
      'save': (visitor) => $flutter_23.LogicalKeyboardKey.save,
      'spellCheck': (visitor) => $flutter_23.LogicalKeyboardKey.spellCheck,
      'audioVolumeDown': (visitor) => $flutter_23.LogicalKeyboardKey.audioVolumeDown,
      'audioVolumeUp': (visitor) => $flutter_23.LogicalKeyboardKey.audioVolumeUp,
      'audioVolumeMute': (visitor) => $flutter_23.LogicalKeyboardKey.audioVolumeMute,
      'launchApplication2': (visitor) => $flutter_23.LogicalKeyboardKey.launchApplication2,
      'launchCalendar': (visitor) => $flutter_23.LogicalKeyboardKey.launchCalendar,
      'launchMail': (visitor) => $flutter_23.LogicalKeyboardKey.launchMail,
      'launchMediaPlayer': (visitor) => $flutter_23.LogicalKeyboardKey.launchMediaPlayer,
      'launchMusicPlayer': (visitor) => $flutter_23.LogicalKeyboardKey.launchMusicPlayer,
      'launchApplication1': (visitor) => $flutter_23.LogicalKeyboardKey.launchApplication1,
      'launchScreenSaver': (visitor) => $flutter_23.LogicalKeyboardKey.launchScreenSaver,
      'launchSpreadsheet': (visitor) => $flutter_23.LogicalKeyboardKey.launchSpreadsheet,
      'launchWebBrowser': (visitor) => $flutter_23.LogicalKeyboardKey.launchWebBrowser,
      'launchWebCam': (visitor) => $flutter_23.LogicalKeyboardKey.launchWebCam,
      'launchWordProcessor': (visitor) => $flutter_23.LogicalKeyboardKey.launchWordProcessor,
      'launchContacts': (visitor) => $flutter_23.LogicalKeyboardKey.launchContacts,
      'launchPhone': (visitor) => $flutter_23.LogicalKeyboardKey.launchPhone,
      'launchAssistant': (visitor) => $flutter_23.LogicalKeyboardKey.launchAssistant,
      'launchControlPanel': (visitor) => $flutter_23.LogicalKeyboardKey.launchControlPanel,
      'browserBack': (visitor) => $flutter_23.LogicalKeyboardKey.browserBack,
      'browserFavorites': (visitor) => $flutter_23.LogicalKeyboardKey.browserFavorites,
      'browserForward': (visitor) => $flutter_23.LogicalKeyboardKey.browserForward,
      'browserHome': (visitor) => $flutter_23.LogicalKeyboardKey.browserHome,
      'browserRefresh': (visitor) => $flutter_23.LogicalKeyboardKey.browserRefresh,
      'browserSearch': (visitor) => $flutter_23.LogicalKeyboardKey.browserSearch,
      'browserStop': (visitor) => $flutter_23.LogicalKeyboardKey.browserStop,
      'audioBalanceLeft': (visitor) => $flutter_23.LogicalKeyboardKey.audioBalanceLeft,
      'audioBalanceRight': (visitor) => $flutter_23.LogicalKeyboardKey.audioBalanceRight,
      'audioBassBoostDown': (visitor) => $flutter_23.LogicalKeyboardKey.audioBassBoostDown,
      'audioBassBoostUp': (visitor) => $flutter_23.LogicalKeyboardKey.audioBassBoostUp,
      'audioFaderFront': (visitor) => $flutter_23.LogicalKeyboardKey.audioFaderFront,
      'audioFaderRear': (visitor) => $flutter_23.LogicalKeyboardKey.audioFaderRear,
      'audioSurroundModeNext': (visitor) => $flutter_23.LogicalKeyboardKey.audioSurroundModeNext,
      'avrInput': (visitor) => $flutter_23.LogicalKeyboardKey.avrInput,
      'avrPower': (visitor) => $flutter_23.LogicalKeyboardKey.avrPower,
      'channelDown': (visitor) => $flutter_23.LogicalKeyboardKey.channelDown,
      'channelUp': (visitor) => $flutter_23.LogicalKeyboardKey.channelUp,
      'colorF0Red': (visitor) => $flutter_23.LogicalKeyboardKey.colorF0Red,
      'colorF1Green': (visitor) => $flutter_23.LogicalKeyboardKey.colorF1Green,
      'colorF2Yellow': (visitor) => $flutter_23.LogicalKeyboardKey.colorF2Yellow,
      'colorF3Blue': (visitor) => $flutter_23.LogicalKeyboardKey.colorF3Blue,
      'colorF4Grey': (visitor) => $flutter_23.LogicalKeyboardKey.colorF4Grey,
      'colorF5Brown': (visitor) => $flutter_23.LogicalKeyboardKey.colorF5Brown,
      'closedCaptionToggle': (visitor) => $flutter_23.LogicalKeyboardKey.closedCaptionToggle,
      'dimmer': (visitor) => $flutter_23.LogicalKeyboardKey.dimmer,
      'displaySwap': (visitor) => $flutter_23.LogicalKeyboardKey.displaySwap,
      'exit': (visitor) => $flutter_23.LogicalKeyboardKey.exit,
      'favoriteClear0': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteClear0,
      'favoriteClear1': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteClear1,
      'favoriteClear2': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteClear2,
      'favoriteClear3': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteClear3,
      'favoriteRecall0': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteRecall0,
      'favoriteRecall1': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteRecall1,
      'favoriteRecall2': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteRecall2,
      'favoriteRecall3': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteRecall3,
      'favoriteStore0': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteStore0,
      'favoriteStore1': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteStore1,
      'favoriteStore2': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteStore2,
      'favoriteStore3': (visitor) => $flutter_23.LogicalKeyboardKey.favoriteStore3,
      'guide': (visitor) => $flutter_23.LogicalKeyboardKey.guide,
      'guideNextDay': (visitor) => $flutter_23.LogicalKeyboardKey.guideNextDay,
      'guidePreviousDay': (visitor) => $flutter_23.LogicalKeyboardKey.guidePreviousDay,
      'info': (visitor) => $flutter_23.LogicalKeyboardKey.info,
      'instantReplay': (visitor) => $flutter_23.LogicalKeyboardKey.instantReplay,
      'link': (visitor) => $flutter_23.LogicalKeyboardKey.link,
      'listProgram': (visitor) => $flutter_23.LogicalKeyboardKey.listProgram,
      'liveContent': (visitor) => $flutter_23.LogicalKeyboardKey.liveContent,
      'lock': (visitor) => $flutter_23.LogicalKeyboardKey.lock,
      'mediaApps': (visitor) => $flutter_23.LogicalKeyboardKey.mediaApps,
      'mediaFastForward': (visitor) => $flutter_23.LogicalKeyboardKey.mediaFastForward,
      'mediaLast': (visitor) => $flutter_23.LogicalKeyboardKey.mediaLast,
      'mediaPause': (visitor) => $flutter_23.LogicalKeyboardKey.mediaPause,
      'mediaPlay': (visitor) => $flutter_23.LogicalKeyboardKey.mediaPlay,
      'mediaRecord': (visitor) => $flutter_23.LogicalKeyboardKey.mediaRecord,
      'mediaRewind': (visitor) => $flutter_23.LogicalKeyboardKey.mediaRewind,
      'mediaSkip': (visitor) => $flutter_23.LogicalKeyboardKey.mediaSkip,
      'nextFavoriteChannel': (visitor) => $flutter_23.LogicalKeyboardKey.nextFavoriteChannel,
      'nextUserProfile': (visitor) => $flutter_23.LogicalKeyboardKey.nextUserProfile,
      'onDemand': (visitor) => $flutter_23.LogicalKeyboardKey.onDemand,
      'pInPDown': (visitor) => $flutter_23.LogicalKeyboardKey.pInPDown,
      'pInPMove': (visitor) => $flutter_23.LogicalKeyboardKey.pInPMove,
      'pInPToggle': (visitor) => $flutter_23.LogicalKeyboardKey.pInPToggle,
      'pInPUp': (visitor) => $flutter_23.LogicalKeyboardKey.pInPUp,
      'playSpeedDown': (visitor) => $flutter_23.LogicalKeyboardKey.playSpeedDown,
      'playSpeedReset': (visitor) => $flutter_23.LogicalKeyboardKey.playSpeedReset,
      'playSpeedUp': (visitor) => $flutter_23.LogicalKeyboardKey.playSpeedUp,
      'randomToggle': (visitor) => $flutter_23.LogicalKeyboardKey.randomToggle,
      'rcLowBattery': (visitor) => $flutter_23.LogicalKeyboardKey.rcLowBattery,
      'recordSpeedNext': (visitor) => $flutter_23.LogicalKeyboardKey.recordSpeedNext,
      'rfBypass': (visitor) => $flutter_23.LogicalKeyboardKey.rfBypass,
      'scanChannelsToggle': (visitor) => $flutter_23.LogicalKeyboardKey.scanChannelsToggle,
      'screenModeNext': (visitor) => $flutter_23.LogicalKeyboardKey.screenModeNext,
      'settings': (visitor) => $flutter_23.LogicalKeyboardKey.settings,
      'splitScreenToggle': (visitor) => $flutter_23.LogicalKeyboardKey.splitScreenToggle,
      'stbInput': (visitor) => $flutter_23.LogicalKeyboardKey.stbInput,
      'stbPower': (visitor) => $flutter_23.LogicalKeyboardKey.stbPower,
      'subtitle': (visitor) => $flutter_23.LogicalKeyboardKey.subtitle,
      'teletext': (visitor) => $flutter_23.LogicalKeyboardKey.teletext,
      'tv': (visitor) => $flutter_23.LogicalKeyboardKey.tv,
      'tvInput': (visitor) => $flutter_23.LogicalKeyboardKey.tvInput,
      'tvPower': (visitor) => $flutter_23.LogicalKeyboardKey.tvPower,
      'videoModeNext': (visitor) => $flutter_23.LogicalKeyboardKey.videoModeNext,
      'wink': (visitor) => $flutter_23.LogicalKeyboardKey.wink,
      'zoomToggle': (visitor) => $flutter_23.LogicalKeyboardKey.zoomToggle,
      'dvr': (visitor) => $flutter_23.LogicalKeyboardKey.dvr,
      'mediaAudioTrack': (visitor) => $flutter_23.LogicalKeyboardKey.mediaAudioTrack,
      'mediaSkipBackward': (visitor) => $flutter_23.LogicalKeyboardKey.mediaSkipBackward,
      'mediaSkipForward': (visitor) => $flutter_23.LogicalKeyboardKey.mediaSkipForward,
      'mediaStepBackward': (visitor) => $flutter_23.LogicalKeyboardKey.mediaStepBackward,
      'mediaStepForward': (visitor) => $flutter_23.LogicalKeyboardKey.mediaStepForward,
      'mediaTopMenu': (visitor) => $flutter_23.LogicalKeyboardKey.mediaTopMenu,
      'navigateIn': (visitor) => $flutter_23.LogicalKeyboardKey.navigateIn,
      'navigateNext': (visitor) => $flutter_23.LogicalKeyboardKey.navigateNext,
      'navigateOut': (visitor) => $flutter_23.LogicalKeyboardKey.navigateOut,
      'navigatePrevious': (visitor) => $flutter_23.LogicalKeyboardKey.navigatePrevious,
      'pairing': (visitor) => $flutter_23.LogicalKeyboardKey.pairing,
      'mediaClose': (visitor) => $flutter_23.LogicalKeyboardKey.mediaClose,
      'audioBassBoostToggle': (visitor) => $flutter_23.LogicalKeyboardKey.audioBassBoostToggle,
      'audioTrebleDown': (visitor) => $flutter_23.LogicalKeyboardKey.audioTrebleDown,
      'audioTrebleUp': (visitor) => $flutter_23.LogicalKeyboardKey.audioTrebleUp,
      'microphoneToggle': (visitor) => $flutter_23.LogicalKeyboardKey.microphoneToggle,
      'microphoneVolumeDown': (visitor) => $flutter_23.LogicalKeyboardKey.microphoneVolumeDown,
      'microphoneVolumeUp': (visitor) => $flutter_23.LogicalKeyboardKey.microphoneVolumeUp,
      'microphoneVolumeMute': (visitor) => $flutter_23.LogicalKeyboardKey.microphoneVolumeMute,
      'speechCorrectionList': (visitor) => $flutter_23.LogicalKeyboardKey.speechCorrectionList,
      'speechInputToggle': (visitor) => $flutter_23.LogicalKeyboardKey.speechInputToggle,
      'appSwitch': (visitor) => $flutter_23.LogicalKeyboardKey.appSwitch,
      'call': (visitor) => $flutter_23.LogicalKeyboardKey.call,
      'cameraFocus': (visitor) => $flutter_23.LogicalKeyboardKey.cameraFocus,
      'endCall': (visitor) => $flutter_23.LogicalKeyboardKey.endCall,
      'goBack': (visitor) => $flutter_23.LogicalKeyboardKey.goBack,
      'goHome': (visitor) => $flutter_23.LogicalKeyboardKey.goHome,
      'headsetHook': (visitor) => $flutter_23.LogicalKeyboardKey.headsetHook,
      'lastNumberRedial': (visitor) => $flutter_23.LogicalKeyboardKey.lastNumberRedial,
      'notification': (visitor) => $flutter_23.LogicalKeyboardKey.notification,
      'mannerMode': (visitor) => $flutter_23.LogicalKeyboardKey.mannerMode,
      'voiceDial': (visitor) => $flutter_23.LogicalKeyboardKey.voiceDial,
      'tv3DMode': (visitor) => $flutter_23.LogicalKeyboardKey.tv3DMode,
      'tvAntennaCable': (visitor) => $flutter_23.LogicalKeyboardKey.tvAntennaCable,
      'tvAudioDescription': (visitor) => $flutter_23.LogicalKeyboardKey.tvAudioDescription,
      'tvAudioDescriptionMixDown': (visitor) => $flutter_23.LogicalKeyboardKey.tvAudioDescriptionMixDown,
      'tvAudioDescriptionMixUp': (visitor) => $flutter_23.LogicalKeyboardKey.tvAudioDescriptionMixUp,
      'tvContentsMenu': (visitor) => $flutter_23.LogicalKeyboardKey.tvContentsMenu,
      'tvDataService': (visitor) => $flutter_23.LogicalKeyboardKey.tvDataService,
      'tvInputComponent1': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputComponent1,
      'tvInputComponent2': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputComponent2,
      'tvInputComposite1': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputComposite1,
      'tvInputComposite2': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputComposite2,
      'tvInputHDMI1': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputHDMI1,
      'tvInputHDMI2': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputHDMI2,
      'tvInputHDMI3': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputHDMI3,
      'tvInputHDMI4': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputHDMI4,
      'tvInputVGA1': (visitor) => $flutter_23.LogicalKeyboardKey.tvInputVGA1,
      'tvMediaContext': (visitor) => $flutter_23.LogicalKeyboardKey.tvMediaContext,
      'tvNetwork': (visitor) => $flutter_23.LogicalKeyboardKey.tvNetwork,
      'tvNumberEntry': (visitor) => $flutter_23.LogicalKeyboardKey.tvNumberEntry,
      'tvRadioService': (visitor) => $flutter_23.LogicalKeyboardKey.tvRadioService,
      'tvSatellite': (visitor) => $flutter_23.LogicalKeyboardKey.tvSatellite,
      'tvSatelliteBS': (visitor) => $flutter_23.LogicalKeyboardKey.tvSatelliteBS,
      'tvSatelliteCS': (visitor) => $flutter_23.LogicalKeyboardKey.tvSatelliteCS,
      'tvSatelliteToggle': (visitor) => $flutter_23.LogicalKeyboardKey.tvSatelliteToggle,
      'tvTerrestrialAnalog': (visitor) => $flutter_23.LogicalKeyboardKey.tvTerrestrialAnalog,
      'tvTerrestrialDigital': (visitor) => $flutter_23.LogicalKeyboardKey.tvTerrestrialDigital,
      'tvTimer': (visitor) => $flutter_23.LogicalKeyboardKey.tvTimer,
      'key11': (visitor) => $flutter_23.LogicalKeyboardKey.key11,
      'key12': (visitor) => $flutter_23.LogicalKeyboardKey.key12,
      'suspend': (visitor) => $flutter_23.LogicalKeyboardKey.suspend,
      'resume': (visitor) => $flutter_23.LogicalKeyboardKey.resume,
      'sleep': (visitor) => $flutter_23.LogicalKeyboardKey.sleep,
      'abort': (visitor) => $flutter_23.LogicalKeyboardKey.abort,
      'lang1': (visitor) => $flutter_23.LogicalKeyboardKey.lang1,
      'lang2': (visitor) => $flutter_23.LogicalKeyboardKey.lang2,
      'lang3': (visitor) => $flutter_23.LogicalKeyboardKey.lang3,
      'lang4': (visitor) => $flutter_23.LogicalKeyboardKey.lang4,
      'lang5': (visitor) => $flutter_23.LogicalKeyboardKey.lang5,
      'intlBackslash': (visitor) => $flutter_23.LogicalKeyboardKey.intlBackslash,
      'intlRo': (visitor) => $flutter_23.LogicalKeyboardKey.intlRo,
      'intlYen': (visitor) => $flutter_23.LogicalKeyboardKey.intlYen,
      'controlLeft': (visitor) => $flutter_23.LogicalKeyboardKey.controlLeft,
      'controlRight': (visitor) => $flutter_23.LogicalKeyboardKey.controlRight,
      'shiftLeft': (visitor) => $flutter_23.LogicalKeyboardKey.shiftLeft,
      'shiftRight': (visitor) => $flutter_23.LogicalKeyboardKey.shiftRight,
      'altLeft': (visitor) => $flutter_23.LogicalKeyboardKey.altLeft,
      'altRight': (visitor) => $flutter_23.LogicalKeyboardKey.altRight,
      'metaLeft': (visitor) => $flutter_23.LogicalKeyboardKey.metaLeft,
      'metaRight': (visitor) => $flutter_23.LogicalKeyboardKey.metaRight,
      'control': (visitor) => $flutter_23.LogicalKeyboardKey.control,
      'shift': (visitor) => $flutter_23.LogicalKeyboardKey.shift,
      'alt': (visitor) => $flutter_23.LogicalKeyboardKey.alt,
      'meta': (visitor) => $flutter_23.LogicalKeyboardKey.meta,
      'numpadEnter': (visitor) => $flutter_23.LogicalKeyboardKey.numpadEnter,
      'numpadParenLeft': (visitor) => $flutter_23.LogicalKeyboardKey.numpadParenLeft,
      'numpadParenRight': (visitor) => $flutter_23.LogicalKeyboardKey.numpadParenRight,
      'numpadMultiply': (visitor) => $flutter_23.LogicalKeyboardKey.numpadMultiply,
      'numpadAdd': (visitor) => $flutter_23.LogicalKeyboardKey.numpadAdd,
      'numpadComma': (visitor) => $flutter_23.LogicalKeyboardKey.numpadComma,
      'numpadSubtract': (visitor) => $flutter_23.LogicalKeyboardKey.numpadSubtract,
      'numpadDecimal': (visitor) => $flutter_23.LogicalKeyboardKey.numpadDecimal,
      'numpadDivide': (visitor) => $flutter_23.LogicalKeyboardKey.numpadDivide,
      'numpad0': (visitor) => $flutter_23.LogicalKeyboardKey.numpad0,
      'numpad1': (visitor) => $flutter_23.LogicalKeyboardKey.numpad1,
      'numpad2': (visitor) => $flutter_23.LogicalKeyboardKey.numpad2,
      'numpad3': (visitor) => $flutter_23.LogicalKeyboardKey.numpad3,
      'numpad4': (visitor) => $flutter_23.LogicalKeyboardKey.numpad4,
      'numpad5': (visitor) => $flutter_23.LogicalKeyboardKey.numpad5,
      'numpad6': (visitor) => $flutter_23.LogicalKeyboardKey.numpad6,
      'numpad7': (visitor) => $flutter_23.LogicalKeyboardKey.numpad7,
      'numpad8': (visitor) => $flutter_23.LogicalKeyboardKey.numpad8,
      'numpad9': (visitor) => $flutter_23.LogicalKeyboardKey.numpad9,
      'numpadEqual': (visitor) => $flutter_23.LogicalKeyboardKey.numpadEqual,
      'gameButton1': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton1,
      'gameButton2': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton2,
      'gameButton3': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton3,
      'gameButton4': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton4,
      'gameButton5': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton5,
      'gameButton6': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton6,
      'gameButton7': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton7,
      'gameButton8': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton8,
      'gameButton9': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton9,
      'gameButton10': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton10,
      'gameButton11': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton11,
      'gameButton12': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton12,
      'gameButton13': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton13,
      'gameButton14': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton14,
      'gameButton15': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton15,
      'gameButton16': (visitor) => $flutter_23.LogicalKeyboardKey.gameButton16,
      'gameButtonA': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonA,
      'gameButtonB': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonB,
      'gameButtonC': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonC,
      'gameButtonLeft1': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonLeft1,
      'gameButtonLeft2': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonLeft2,
      'gameButtonMode': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonMode,
      'gameButtonRight1': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonRight1,
      'gameButtonRight2': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonRight2,
      'gameButtonSelect': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonSelect,
      'gameButtonStart': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonStart,
      'gameButtonThumbLeft': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonThumbLeft,
      'gameButtonThumbRight': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonThumbRight,
      'gameButtonX': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonX,
      'gameButtonY': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonY,
      'gameButtonZ': (visitor) => $flutter_23.LogicalKeyboardKey.gameButtonZ,
      'knownLogicalKeys': (visitor) => $flutter_23.LogicalKeyboardKey.knownLogicalKeys,
    },
    staticMethods: {
      'findKeyByKeyId': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findKeyByKeyId');
        final keyId = D4.getRequiredArg<int>(positional, 0, 'keyId', 'findKeyByKeyId');
        return $flutter_23.LogicalKeyboardKey.findKeyByKeyId(keyId);
      },
      'isControlCharacter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isControlCharacter');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'isControlCharacter');
        return $flutter_23.LogicalKeyboardKey.isControlCharacter(label);
      },
      'collapseSynonyms': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'collapseSynonyms');
        final input = D4.getRequiredArg<Set<$flutter_23.LogicalKeyboardKey>>(positional, 0, 'input', 'collapseSynonyms');
        return $flutter_23.LogicalKeyboardKey.collapseSynonyms(input);
      },
      'expandSynonyms': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'expandSynonyms');
        final input = D4.getRequiredArg<Set<$flutter_23.LogicalKeyboardKey>>(positional, 0, 'input', 'expandSynonyms');
        return $flutter_23.LogicalKeyboardKey.expandSynonyms(input);
      },
    },
    constructorSignatures: {
      '': 'const LogicalKeyboardKey(int keyId)',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'keyId': 'int get keyId',
      'keyLabel': 'String get keyLabel',
      'debugName': 'String? get debugName',
      'hashCode': 'int get hashCode',
      'isAutogenerated': 'bool get isAutogenerated',
      'synonyms': 'Set<LogicalKeyboardKey> get synonyms',
    },
    staticMethodSignatures: {
      'findKeyByKeyId': 'LogicalKeyboardKey? findKeyByKeyId(int keyId)',
      'isControlCharacter': 'bool isControlCharacter(String label)',
      'collapseSynonyms': 'Set<LogicalKeyboardKey> collapseSynonyms(Set<LogicalKeyboardKey> input)',
      'expandSynonyms': 'Set<LogicalKeyboardKey> expandSynonyms(Set<LogicalKeyboardKey> input)',
    },
    staticGetterSignatures: {
      'valueMask': 'int get valueMask',
      'planeMask': 'int get planeMask',
      'unicodePlane': 'int get unicodePlane',
      'unprintablePlane': 'int get unprintablePlane',
      'flutterPlane': 'int get flutterPlane',
      'startOfPlatformPlanes': 'int get startOfPlatformPlanes',
      'androidPlane': 'int get androidPlane',
      'fuchsiaPlane': 'int get fuchsiaPlane',
      'iosPlane': 'int get iosPlane',
      'macosPlane': 'int get macosPlane',
      'gtkPlane': 'int get gtkPlane',
      'windowsPlane': 'int get windowsPlane',
      'webPlane': 'int get webPlane',
      'glfwPlane': 'int get glfwPlane',
      'space': 'LogicalKeyboardKey get space',
      'exclamation': 'LogicalKeyboardKey get exclamation',
      'quote': 'LogicalKeyboardKey get quote',
      'numberSign': 'LogicalKeyboardKey get numberSign',
      'dollar': 'LogicalKeyboardKey get dollar',
      'percent': 'LogicalKeyboardKey get percent',
      'ampersand': 'LogicalKeyboardKey get ampersand',
      'quoteSingle': 'LogicalKeyboardKey get quoteSingle',
      'parenthesisLeft': 'LogicalKeyboardKey get parenthesisLeft',
      'parenthesisRight': 'LogicalKeyboardKey get parenthesisRight',
      'asterisk': 'LogicalKeyboardKey get asterisk',
      'add': 'LogicalKeyboardKey get add',
      'comma': 'LogicalKeyboardKey get comma',
      'minus': 'LogicalKeyboardKey get minus',
      'period': 'LogicalKeyboardKey get period',
      'slash': 'LogicalKeyboardKey get slash',
      'digit0': 'LogicalKeyboardKey get digit0',
      'digit1': 'LogicalKeyboardKey get digit1',
      'digit2': 'LogicalKeyboardKey get digit2',
      'digit3': 'LogicalKeyboardKey get digit3',
      'digit4': 'LogicalKeyboardKey get digit4',
      'digit5': 'LogicalKeyboardKey get digit5',
      'digit6': 'LogicalKeyboardKey get digit6',
      'digit7': 'LogicalKeyboardKey get digit7',
      'digit8': 'LogicalKeyboardKey get digit8',
      'digit9': 'LogicalKeyboardKey get digit9',
      'colon': 'LogicalKeyboardKey get colon',
      'semicolon': 'LogicalKeyboardKey get semicolon',
      'less': 'LogicalKeyboardKey get less',
      'equal': 'LogicalKeyboardKey get equal',
      'greater': 'LogicalKeyboardKey get greater',
      'question': 'LogicalKeyboardKey get question',
      'at': 'LogicalKeyboardKey get at',
      'bracketLeft': 'LogicalKeyboardKey get bracketLeft',
      'backslash': 'LogicalKeyboardKey get backslash',
      'bracketRight': 'LogicalKeyboardKey get bracketRight',
      'caret': 'LogicalKeyboardKey get caret',
      'underscore': 'LogicalKeyboardKey get underscore',
      'backquote': 'LogicalKeyboardKey get backquote',
      'keyA': 'LogicalKeyboardKey get keyA',
      'keyB': 'LogicalKeyboardKey get keyB',
      'keyC': 'LogicalKeyboardKey get keyC',
      'keyD': 'LogicalKeyboardKey get keyD',
      'keyE': 'LogicalKeyboardKey get keyE',
      'keyF': 'LogicalKeyboardKey get keyF',
      'keyG': 'LogicalKeyboardKey get keyG',
      'keyH': 'LogicalKeyboardKey get keyH',
      'keyI': 'LogicalKeyboardKey get keyI',
      'keyJ': 'LogicalKeyboardKey get keyJ',
      'keyK': 'LogicalKeyboardKey get keyK',
      'keyL': 'LogicalKeyboardKey get keyL',
      'keyM': 'LogicalKeyboardKey get keyM',
      'keyN': 'LogicalKeyboardKey get keyN',
      'keyO': 'LogicalKeyboardKey get keyO',
      'keyP': 'LogicalKeyboardKey get keyP',
      'keyQ': 'LogicalKeyboardKey get keyQ',
      'keyR': 'LogicalKeyboardKey get keyR',
      'keyS': 'LogicalKeyboardKey get keyS',
      'keyT': 'LogicalKeyboardKey get keyT',
      'keyU': 'LogicalKeyboardKey get keyU',
      'keyV': 'LogicalKeyboardKey get keyV',
      'keyW': 'LogicalKeyboardKey get keyW',
      'keyX': 'LogicalKeyboardKey get keyX',
      'keyY': 'LogicalKeyboardKey get keyY',
      'keyZ': 'LogicalKeyboardKey get keyZ',
      'braceLeft': 'LogicalKeyboardKey get braceLeft',
      'bar': 'LogicalKeyboardKey get bar',
      'braceRight': 'LogicalKeyboardKey get braceRight',
      'tilde': 'LogicalKeyboardKey get tilde',
      'unidentified': 'LogicalKeyboardKey get unidentified',
      'backspace': 'LogicalKeyboardKey get backspace',
      'tab': 'LogicalKeyboardKey get tab',
      'enter': 'LogicalKeyboardKey get enter',
      'escape': 'LogicalKeyboardKey get escape',
      'delete': 'LogicalKeyboardKey get delete',
      'accel': 'LogicalKeyboardKey get accel',
      'altGraph': 'LogicalKeyboardKey get altGraph',
      'capsLock': 'LogicalKeyboardKey get capsLock',
      'fn': 'LogicalKeyboardKey get fn',
      'fnLock': 'LogicalKeyboardKey get fnLock',
      'hyper': 'LogicalKeyboardKey get hyper',
      'numLock': 'LogicalKeyboardKey get numLock',
      'scrollLock': 'LogicalKeyboardKey get scrollLock',
      'superKey': 'LogicalKeyboardKey get superKey',
      'symbol': 'LogicalKeyboardKey get symbol',
      'symbolLock': 'LogicalKeyboardKey get symbolLock',
      'shiftLevel5': 'LogicalKeyboardKey get shiftLevel5',
      'arrowDown': 'LogicalKeyboardKey get arrowDown',
      'arrowLeft': 'LogicalKeyboardKey get arrowLeft',
      'arrowRight': 'LogicalKeyboardKey get arrowRight',
      'arrowUp': 'LogicalKeyboardKey get arrowUp',
      'end': 'LogicalKeyboardKey get end',
      'home': 'LogicalKeyboardKey get home',
      'pageDown': 'LogicalKeyboardKey get pageDown',
      'pageUp': 'LogicalKeyboardKey get pageUp',
      'clear': 'LogicalKeyboardKey get clear',
      'copy': 'LogicalKeyboardKey get copy',
      'crSel': 'LogicalKeyboardKey get crSel',
      'cut': 'LogicalKeyboardKey get cut',
      'eraseEof': 'LogicalKeyboardKey get eraseEof',
      'exSel': 'LogicalKeyboardKey get exSel',
      'insert': 'LogicalKeyboardKey get insert',
      'paste': 'LogicalKeyboardKey get paste',
      'redo': 'LogicalKeyboardKey get redo',
      'undo': 'LogicalKeyboardKey get undo',
      'accept': 'LogicalKeyboardKey get accept',
      'again': 'LogicalKeyboardKey get again',
      'attn': 'LogicalKeyboardKey get attn',
      'cancel': 'LogicalKeyboardKey get cancel',
      'contextMenu': 'LogicalKeyboardKey get contextMenu',
      'execute': 'LogicalKeyboardKey get execute',
      'find': 'LogicalKeyboardKey get find',
      'help': 'LogicalKeyboardKey get help',
      'pause': 'LogicalKeyboardKey get pause',
      'play': 'LogicalKeyboardKey get play',
      'props': 'LogicalKeyboardKey get props',
      'select': 'LogicalKeyboardKey get select',
      'zoomIn': 'LogicalKeyboardKey get zoomIn',
      'zoomOut': 'LogicalKeyboardKey get zoomOut',
      'brightnessDown': 'LogicalKeyboardKey get brightnessDown',
      'brightnessUp': 'LogicalKeyboardKey get brightnessUp',
      'camera': 'LogicalKeyboardKey get camera',
      'eject': 'LogicalKeyboardKey get eject',
      'logOff': 'LogicalKeyboardKey get logOff',
      'power': 'LogicalKeyboardKey get power',
      'powerOff': 'LogicalKeyboardKey get powerOff',
      'printScreen': 'LogicalKeyboardKey get printScreen',
      'hibernate': 'LogicalKeyboardKey get hibernate',
      'standby': 'LogicalKeyboardKey get standby',
      'wakeUp': 'LogicalKeyboardKey get wakeUp',
      'allCandidates': 'LogicalKeyboardKey get allCandidates',
      'alphanumeric': 'LogicalKeyboardKey get alphanumeric',
      'codeInput': 'LogicalKeyboardKey get codeInput',
      'compose': 'LogicalKeyboardKey get compose',
      'convert': 'LogicalKeyboardKey get convert',
      'finalMode': 'LogicalKeyboardKey get finalMode',
      'groupFirst': 'LogicalKeyboardKey get groupFirst',
      'groupLast': 'LogicalKeyboardKey get groupLast',
      'groupNext': 'LogicalKeyboardKey get groupNext',
      'groupPrevious': 'LogicalKeyboardKey get groupPrevious',
      'modeChange': 'LogicalKeyboardKey get modeChange',
      'nextCandidate': 'LogicalKeyboardKey get nextCandidate',
      'nonConvert': 'LogicalKeyboardKey get nonConvert',
      'previousCandidate': 'LogicalKeyboardKey get previousCandidate',
      'process': 'LogicalKeyboardKey get process',
      'singleCandidate': 'LogicalKeyboardKey get singleCandidate',
      'hangulMode': 'LogicalKeyboardKey get hangulMode',
      'hanjaMode': 'LogicalKeyboardKey get hanjaMode',
      'junjaMode': 'LogicalKeyboardKey get junjaMode',
      'eisu': 'LogicalKeyboardKey get eisu',
      'hankaku': 'LogicalKeyboardKey get hankaku',
      'hiragana': 'LogicalKeyboardKey get hiragana',
      'hiraganaKatakana': 'LogicalKeyboardKey get hiraganaKatakana',
      'kanaMode': 'LogicalKeyboardKey get kanaMode',
      'kanjiMode': 'LogicalKeyboardKey get kanjiMode',
      'katakana': 'LogicalKeyboardKey get katakana',
      'romaji': 'LogicalKeyboardKey get romaji',
      'zenkaku': 'LogicalKeyboardKey get zenkaku',
      'zenkakuHankaku': 'LogicalKeyboardKey get zenkakuHankaku',
      'f1': 'LogicalKeyboardKey get f1',
      'f2': 'LogicalKeyboardKey get f2',
      'f3': 'LogicalKeyboardKey get f3',
      'f4': 'LogicalKeyboardKey get f4',
      'f5': 'LogicalKeyboardKey get f5',
      'f6': 'LogicalKeyboardKey get f6',
      'f7': 'LogicalKeyboardKey get f7',
      'f8': 'LogicalKeyboardKey get f8',
      'f9': 'LogicalKeyboardKey get f9',
      'f10': 'LogicalKeyboardKey get f10',
      'f11': 'LogicalKeyboardKey get f11',
      'f12': 'LogicalKeyboardKey get f12',
      'f13': 'LogicalKeyboardKey get f13',
      'f14': 'LogicalKeyboardKey get f14',
      'f15': 'LogicalKeyboardKey get f15',
      'f16': 'LogicalKeyboardKey get f16',
      'f17': 'LogicalKeyboardKey get f17',
      'f18': 'LogicalKeyboardKey get f18',
      'f19': 'LogicalKeyboardKey get f19',
      'f20': 'LogicalKeyboardKey get f20',
      'f21': 'LogicalKeyboardKey get f21',
      'f22': 'LogicalKeyboardKey get f22',
      'f23': 'LogicalKeyboardKey get f23',
      'f24': 'LogicalKeyboardKey get f24',
      'soft1': 'LogicalKeyboardKey get soft1',
      'soft2': 'LogicalKeyboardKey get soft2',
      'soft3': 'LogicalKeyboardKey get soft3',
      'soft4': 'LogicalKeyboardKey get soft4',
      'soft5': 'LogicalKeyboardKey get soft5',
      'soft6': 'LogicalKeyboardKey get soft6',
      'soft7': 'LogicalKeyboardKey get soft7',
      'soft8': 'LogicalKeyboardKey get soft8',
      'close': 'LogicalKeyboardKey get close',
      'mailForward': 'LogicalKeyboardKey get mailForward',
      'mailReply': 'LogicalKeyboardKey get mailReply',
      'mailSend': 'LogicalKeyboardKey get mailSend',
      'mediaPlayPause': 'LogicalKeyboardKey get mediaPlayPause',
      'mediaStop': 'LogicalKeyboardKey get mediaStop',
      'mediaTrackNext': 'LogicalKeyboardKey get mediaTrackNext',
      'mediaTrackPrevious': 'LogicalKeyboardKey get mediaTrackPrevious',
      'newKey': 'LogicalKeyboardKey get newKey',
      'open': 'LogicalKeyboardKey get open',
      'print': 'LogicalKeyboardKey get print',
      'save': 'LogicalKeyboardKey get save',
      'spellCheck': 'LogicalKeyboardKey get spellCheck',
      'audioVolumeDown': 'LogicalKeyboardKey get audioVolumeDown',
      'audioVolumeUp': 'LogicalKeyboardKey get audioVolumeUp',
      'audioVolumeMute': 'LogicalKeyboardKey get audioVolumeMute',
      'launchApplication2': 'LogicalKeyboardKey get launchApplication2',
      'launchCalendar': 'LogicalKeyboardKey get launchCalendar',
      'launchMail': 'LogicalKeyboardKey get launchMail',
      'launchMediaPlayer': 'LogicalKeyboardKey get launchMediaPlayer',
      'launchMusicPlayer': 'LogicalKeyboardKey get launchMusicPlayer',
      'launchApplication1': 'LogicalKeyboardKey get launchApplication1',
      'launchScreenSaver': 'LogicalKeyboardKey get launchScreenSaver',
      'launchSpreadsheet': 'LogicalKeyboardKey get launchSpreadsheet',
      'launchWebBrowser': 'LogicalKeyboardKey get launchWebBrowser',
      'launchWebCam': 'LogicalKeyboardKey get launchWebCam',
      'launchWordProcessor': 'LogicalKeyboardKey get launchWordProcessor',
      'launchContacts': 'LogicalKeyboardKey get launchContacts',
      'launchPhone': 'LogicalKeyboardKey get launchPhone',
      'launchAssistant': 'LogicalKeyboardKey get launchAssistant',
      'launchControlPanel': 'LogicalKeyboardKey get launchControlPanel',
      'browserBack': 'LogicalKeyboardKey get browserBack',
      'browserFavorites': 'LogicalKeyboardKey get browserFavorites',
      'browserForward': 'LogicalKeyboardKey get browserForward',
      'browserHome': 'LogicalKeyboardKey get browserHome',
      'browserRefresh': 'LogicalKeyboardKey get browserRefresh',
      'browserSearch': 'LogicalKeyboardKey get browserSearch',
      'browserStop': 'LogicalKeyboardKey get browserStop',
      'audioBalanceLeft': 'LogicalKeyboardKey get audioBalanceLeft',
      'audioBalanceRight': 'LogicalKeyboardKey get audioBalanceRight',
      'audioBassBoostDown': 'LogicalKeyboardKey get audioBassBoostDown',
      'audioBassBoostUp': 'LogicalKeyboardKey get audioBassBoostUp',
      'audioFaderFront': 'LogicalKeyboardKey get audioFaderFront',
      'audioFaderRear': 'LogicalKeyboardKey get audioFaderRear',
      'audioSurroundModeNext': 'LogicalKeyboardKey get audioSurroundModeNext',
      'avrInput': 'LogicalKeyboardKey get avrInput',
      'avrPower': 'LogicalKeyboardKey get avrPower',
      'channelDown': 'LogicalKeyboardKey get channelDown',
      'channelUp': 'LogicalKeyboardKey get channelUp',
      'colorF0Red': 'LogicalKeyboardKey get colorF0Red',
      'colorF1Green': 'LogicalKeyboardKey get colorF1Green',
      'colorF2Yellow': 'LogicalKeyboardKey get colorF2Yellow',
      'colorF3Blue': 'LogicalKeyboardKey get colorF3Blue',
      'colorF4Grey': 'LogicalKeyboardKey get colorF4Grey',
      'colorF5Brown': 'LogicalKeyboardKey get colorF5Brown',
      'closedCaptionToggle': 'LogicalKeyboardKey get closedCaptionToggle',
      'dimmer': 'LogicalKeyboardKey get dimmer',
      'displaySwap': 'LogicalKeyboardKey get displaySwap',
      'exit': 'LogicalKeyboardKey get exit',
      'favoriteClear0': 'LogicalKeyboardKey get favoriteClear0',
      'favoriteClear1': 'LogicalKeyboardKey get favoriteClear1',
      'favoriteClear2': 'LogicalKeyboardKey get favoriteClear2',
      'favoriteClear3': 'LogicalKeyboardKey get favoriteClear3',
      'favoriteRecall0': 'LogicalKeyboardKey get favoriteRecall0',
      'favoriteRecall1': 'LogicalKeyboardKey get favoriteRecall1',
      'favoriteRecall2': 'LogicalKeyboardKey get favoriteRecall2',
      'favoriteRecall3': 'LogicalKeyboardKey get favoriteRecall3',
      'favoriteStore0': 'LogicalKeyboardKey get favoriteStore0',
      'favoriteStore1': 'LogicalKeyboardKey get favoriteStore1',
      'favoriteStore2': 'LogicalKeyboardKey get favoriteStore2',
      'favoriteStore3': 'LogicalKeyboardKey get favoriteStore3',
      'guide': 'LogicalKeyboardKey get guide',
      'guideNextDay': 'LogicalKeyboardKey get guideNextDay',
      'guidePreviousDay': 'LogicalKeyboardKey get guidePreviousDay',
      'info': 'LogicalKeyboardKey get info',
      'instantReplay': 'LogicalKeyboardKey get instantReplay',
      'link': 'LogicalKeyboardKey get link',
      'listProgram': 'LogicalKeyboardKey get listProgram',
      'liveContent': 'LogicalKeyboardKey get liveContent',
      'lock': 'LogicalKeyboardKey get lock',
      'mediaApps': 'LogicalKeyboardKey get mediaApps',
      'mediaFastForward': 'LogicalKeyboardKey get mediaFastForward',
      'mediaLast': 'LogicalKeyboardKey get mediaLast',
      'mediaPause': 'LogicalKeyboardKey get mediaPause',
      'mediaPlay': 'LogicalKeyboardKey get mediaPlay',
      'mediaRecord': 'LogicalKeyboardKey get mediaRecord',
      'mediaRewind': 'LogicalKeyboardKey get mediaRewind',
      'mediaSkip': 'LogicalKeyboardKey get mediaSkip',
      'nextFavoriteChannel': 'LogicalKeyboardKey get nextFavoriteChannel',
      'nextUserProfile': 'LogicalKeyboardKey get nextUserProfile',
      'onDemand': 'LogicalKeyboardKey get onDemand',
      'pInPDown': 'LogicalKeyboardKey get pInPDown',
      'pInPMove': 'LogicalKeyboardKey get pInPMove',
      'pInPToggle': 'LogicalKeyboardKey get pInPToggle',
      'pInPUp': 'LogicalKeyboardKey get pInPUp',
      'playSpeedDown': 'LogicalKeyboardKey get playSpeedDown',
      'playSpeedReset': 'LogicalKeyboardKey get playSpeedReset',
      'playSpeedUp': 'LogicalKeyboardKey get playSpeedUp',
      'randomToggle': 'LogicalKeyboardKey get randomToggle',
      'rcLowBattery': 'LogicalKeyboardKey get rcLowBattery',
      'recordSpeedNext': 'LogicalKeyboardKey get recordSpeedNext',
      'rfBypass': 'LogicalKeyboardKey get rfBypass',
      'scanChannelsToggle': 'LogicalKeyboardKey get scanChannelsToggle',
      'screenModeNext': 'LogicalKeyboardKey get screenModeNext',
      'settings': 'LogicalKeyboardKey get settings',
      'splitScreenToggle': 'LogicalKeyboardKey get splitScreenToggle',
      'stbInput': 'LogicalKeyboardKey get stbInput',
      'stbPower': 'LogicalKeyboardKey get stbPower',
      'subtitle': 'LogicalKeyboardKey get subtitle',
      'teletext': 'LogicalKeyboardKey get teletext',
      'tv': 'LogicalKeyboardKey get tv',
      'tvInput': 'LogicalKeyboardKey get tvInput',
      'tvPower': 'LogicalKeyboardKey get tvPower',
      'videoModeNext': 'LogicalKeyboardKey get videoModeNext',
      'wink': 'LogicalKeyboardKey get wink',
      'zoomToggle': 'LogicalKeyboardKey get zoomToggle',
      'dvr': 'LogicalKeyboardKey get dvr',
      'mediaAudioTrack': 'LogicalKeyboardKey get mediaAudioTrack',
      'mediaSkipBackward': 'LogicalKeyboardKey get mediaSkipBackward',
      'mediaSkipForward': 'LogicalKeyboardKey get mediaSkipForward',
      'mediaStepBackward': 'LogicalKeyboardKey get mediaStepBackward',
      'mediaStepForward': 'LogicalKeyboardKey get mediaStepForward',
      'mediaTopMenu': 'LogicalKeyboardKey get mediaTopMenu',
      'navigateIn': 'LogicalKeyboardKey get navigateIn',
      'navigateNext': 'LogicalKeyboardKey get navigateNext',
      'navigateOut': 'LogicalKeyboardKey get navigateOut',
      'navigatePrevious': 'LogicalKeyboardKey get navigatePrevious',
      'pairing': 'LogicalKeyboardKey get pairing',
      'mediaClose': 'LogicalKeyboardKey get mediaClose',
      'audioBassBoostToggle': 'LogicalKeyboardKey get audioBassBoostToggle',
      'audioTrebleDown': 'LogicalKeyboardKey get audioTrebleDown',
      'audioTrebleUp': 'LogicalKeyboardKey get audioTrebleUp',
      'microphoneToggle': 'LogicalKeyboardKey get microphoneToggle',
      'microphoneVolumeDown': 'LogicalKeyboardKey get microphoneVolumeDown',
      'microphoneVolumeUp': 'LogicalKeyboardKey get microphoneVolumeUp',
      'microphoneVolumeMute': 'LogicalKeyboardKey get microphoneVolumeMute',
      'speechCorrectionList': 'LogicalKeyboardKey get speechCorrectionList',
      'speechInputToggle': 'LogicalKeyboardKey get speechInputToggle',
      'appSwitch': 'LogicalKeyboardKey get appSwitch',
      'call': 'LogicalKeyboardKey get call',
      'cameraFocus': 'LogicalKeyboardKey get cameraFocus',
      'endCall': 'LogicalKeyboardKey get endCall',
      'goBack': 'LogicalKeyboardKey get goBack',
      'goHome': 'LogicalKeyboardKey get goHome',
      'headsetHook': 'LogicalKeyboardKey get headsetHook',
      'lastNumberRedial': 'LogicalKeyboardKey get lastNumberRedial',
      'notification': 'LogicalKeyboardKey get notification',
      'mannerMode': 'LogicalKeyboardKey get mannerMode',
      'voiceDial': 'LogicalKeyboardKey get voiceDial',
      'tv3DMode': 'LogicalKeyboardKey get tv3DMode',
      'tvAntennaCable': 'LogicalKeyboardKey get tvAntennaCable',
      'tvAudioDescription': 'LogicalKeyboardKey get tvAudioDescription',
      'tvAudioDescriptionMixDown': 'LogicalKeyboardKey get tvAudioDescriptionMixDown',
      'tvAudioDescriptionMixUp': 'LogicalKeyboardKey get tvAudioDescriptionMixUp',
      'tvContentsMenu': 'LogicalKeyboardKey get tvContentsMenu',
      'tvDataService': 'LogicalKeyboardKey get tvDataService',
      'tvInputComponent1': 'LogicalKeyboardKey get tvInputComponent1',
      'tvInputComponent2': 'LogicalKeyboardKey get tvInputComponent2',
      'tvInputComposite1': 'LogicalKeyboardKey get tvInputComposite1',
      'tvInputComposite2': 'LogicalKeyboardKey get tvInputComposite2',
      'tvInputHDMI1': 'LogicalKeyboardKey get tvInputHDMI1',
      'tvInputHDMI2': 'LogicalKeyboardKey get tvInputHDMI2',
      'tvInputHDMI3': 'LogicalKeyboardKey get tvInputHDMI3',
      'tvInputHDMI4': 'LogicalKeyboardKey get tvInputHDMI4',
      'tvInputVGA1': 'LogicalKeyboardKey get tvInputVGA1',
      'tvMediaContext': 'LogicalKeyboardKey get tvMediaContext',
      'tvNetwork': 'LogicalKeyboardKey get tvNetwork',
      'tvNumberEntry': 'LogicalKeyboardKey get tvNumberEntry',
      'tvRadioService': 'LogicalKeyboardKey get tvRadioService',
      'tvSatellite': 'LogicalKeyboardKey get tvSatellite',
      'tvSatelliteBS': 'LogicalKeyboardKey get tvSatelliteBS',
      'tvSatelliteCS': 'LogicalKeyboardKey get tvSatelliteCS',
      'tvSatelliteToggle': 'LogicalKeyboardKey get tvSatelliteToggle',
      'tvTerrestrialAnalog': 'LogicalKeyboardKey get tvTerrestrialAnalog',
      'tvTerrestrialDigital': 'LogicalKeyboardKey get tvTerrestrialDigital',
      'tvTimer': 'LogicalKeyboardKey get tvTimer',
      'key11': 'LogicalKeyboardKey get key11',
      'key12': 'LogicalKeyboardKey get key12',
      'suspend': 'LogicalKeyboardKey get suspend',
      'resume': 'LogicalKeyboardKey get resume',
      'sleep': 'LogicalKeyboardKey get sleep',
      'abort': 'LogicalKeyboardKey get abort',
      'lang1': 'LogicalKeyboardKey get lang1',
      'lang2': 'LogicalKeyboardKey get lang2',
      'lang3': 'LogicalKeyboardKey get lang3',
      'lang4': 'LogicalKeyboardKey get lang4',
      'lang5': 'LogicalKeyboardKey get lang5',
      'intlBackslash': 'LogicalKeyboardKey get intlBackslash',
      'intlRo': 'LogicalKeyboardKey get intlRo',
      'intlYen': 'LogicalKeyboardKey get intlYen',
      'controlLeft': 'LogicalKeyboardKey get controlLeft',
      'controlRight': 'LogicalKeyboardKey get controlRight',
      'shiftLeft': 'LogicalKeyboardKey get shiftLeft',
      'shiftRight': 'LogicalKeyboardKey get shiftRight',
      'altLeft': 'LogicalKeyboardKey get altLeft',
      'altRight': 'LogicalKeyboardKey get altRight',
      'metaLeft': 'LogicalKeyboardKey get metaLeft',
      'metaRight': 'LogicalKeyboardKey get metaRight',
      'control': 'LogicalKeyboardKey get control',
      'shift': 'LogicalKeyboardKey get shift',
      'alt': 'LogicalKeyboardKey get alt',
      'meta': 'LogicalKeyboardKey get meta',
      'numpadEnter': 'LogicalKeyboardKey get numpadEnter',
      'numpadParenLeft': 'LogicalKeyboardKey get numpadParenLeft',
      'numpadParenRight': 'LogicalKeyboardKey get numpadParenRight',
      'numpadMultiply': 'LogicalKeyboardKey get numpadMultiply',
      'numpadAdd': 'LogicalKeyboardKey get numpadAdd',
      'numpadComma': 'LogicalKeyboardKey get numpadComma',
      'numpadSubtract': 'LogicalKeyboardKey get numpadSubtract',
      'numpadDecimal': 'LogicalKeyboardKey get numpadDecimal',
      'numpadDivide': 'LogicalKeyboardKey get numpadDivide',
      'numpad0': 'LogicalKeyboardKey get numpad0',
      'numpad1': 'LogicalKeyboardKey get numpad1',
      'numpad2': 'LogicalKeyboardKey get numpad2',
      'numpad3': 'LogicalKeyboardKey get numpad3',
      'numpad4': 'LogicalKeyboardKey get numpad4',
      'numpad5': 'LogicalKeyboardKey get numpad5',
      'numpad6': 'LogicalKeyboardKey get numpad6',
      'numpad7': 'LogicalKeyboardKey get numpad7',
      'numpad8': 'LogicalKeyboardKey get numpad8',
      'numpad9': 'LogicalKeyboardKey get numpad9',
      'numpadEqual': 'LogicalKeyboardKey get numpadEqual',
      'gameButton1': 'LogicalKeyboardKey get gameButton1',
      'gameButton2': 'LogicalKeyboardKey get gameButton2',
      'gameButton3': 'LogicalKeyboardKey get gameButton3',
      'gameButton4': 'LogicalKeyboardKey get gameButton4',
      'gameButton5': 'LogicalKeyboardKey get gameButton5',
      'gameButton6': 'LogicalKeyboardKey get gameButton6',
      'gameButton7': 'LogicalKeyboardKey get gameButton7',
      'gameButton8': 'LogicalKeyboardKey get gameButton8',
      'gameButton9': 'LogicalKeyboardKey get gameButton9',
      'gameButton10': 'LogicalKeyboardKey get gameButton10',
      'gameButton11': 'LogicalKeyboardKey get gameButton11',
      'gameButton12': 'LogicalKeyboardKey get gameButton12',
      'gameButton13': 'LogicalKeyboardKey get gameButton13',
      'gameButton14': 'LogicalKeyboardKey get gameButton14',
      'gameButton15': 'LogicalKeyboardKey get gameButton15',
      'gameButton16': 'LogicalKeyboardKey get gameButton16',
      'gameButtonA': 'LogicalKeyboardKey get gameButtonA',
      'gameButtonB': 'LogicalKeyboardKey get gameButtonB',
      'gameButtonC': 'LogicalKeyboardKey get gameButtonC',
      'gameButtonLeft1': 'LogicalKeyboardKey get gameButtonLeft1',
      'gameButtonLeft2': 'LogicalKeyboardKey get gameButtonLeft2',
      'gameButtonMode': 'LogicalKeyboardKey get gameButtonMode',
      'gameButtonRight1': 'LogicalKeyboardKey get gameButtonRight1',
      'gameButtonRight2': 'LogicalKeyboardKey get gameButtonRight2',
      'gameButtonSelect': 'LogicalKeyboardKey get gameButtonSelect',
      'gameButtonStart': 'LogicalKeyboardKey get gameButtonStart',
      'gameButtonThumbLeft': 'LogicalKeyboardKey get gameButtonThumbLeft',
      'gameButtonThumbRight': 'LogicalKeyboardKey get gameButtonThumbRight',
      'gameButtonX': 'LogicalKeyboardKey get gameButtonX',
      'gameButtonY': 'LogicalKeyboardKey get gameButtonY',
      'gameButtonZ': 'LogicalKeyboardKey get gameButtonZ',
      'knownLogicalKeys': 'Iterable<LogicalKeyboardKey> get knownLogicalKeys',
    },
  );
}

// =============================================================================
// PhysicalKeyboardKey Bridge
// =============================================================================

BridgedClass _createPhysicalKeyboardKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_23.PhysicalKeyboardKey,
    name: 'PhysicalKeyboardKey',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PhysicalKeyboardKey');
        final usbHidUsage = D4.getRequiredArg<int>(positional, 0, 'usbHidUsage', 'PhysicalKeyboardKey');
        return $flutter_23.PhysicalKeyboardKey(usbHidUsage);
      },
    },
    getters: {
      'usbHidUsage': (visitor, target) => D4.validateTarget<$flutter_23.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey').usbHidUsage,
      'debugName': (visitor, target) => D4.validateTarget<$flutter_23.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey').debugName,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_23.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'hyper': (visitor) => $flutter_23.PhysicalKeyboardKey.hyper,
      'superKey': (visitor) => $flutter_23.PhysicalKeyboardKey.superKey,
      'fn': (visitor) => $flutter_23.PhysicalKeyboardKey.fn,
      'fnLock': (visitor) => $flutter_23.PhysicalKeyboardKey.fnLock,
      'suspend': (visitor) => $flutter_23.PhysicalKeyboardKey.suspend,
      'resume': (visitor) => $flutter_23.PhysicalKeyboardKey.resume,
      'turbo': (visitor) => $flutter_23.PhysicalKeyboardKey.turbo,
      'privacyScreenToggle': (visitor) => $flutter_23.PhysicalKeyboardKey.privacyScreenToggle,
      'microphoneMuteToggle': (visitor) => $flutter_23.PhysicalKeyboardKey.microphoneMuteToggle,
      'sleep': (visitor) => $flutter_23.PhysicalKeyboardKey.sleep,
      'wakeUp': (visitor) => $flutter_23.PhysicalKeyboardKey.wakeUp,
      'displayToggleIntExt': (visitor) => $flutter_23.PhysicalKeyboardKey.displayToggleIntExt,
      'gameButton1': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton1,
      'gameButton2': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton2,
      'gameButton3': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton3,
      'gameButton4': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton4,
      'gameButton5': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton5,
      'gameButton6': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton6,
      'gameButton7': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton7,
      'gameButton8': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton8,
      'gameButton9': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton9,
      'gameButton10': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton10,
      'gameButton11': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton11,
      'gameButton12': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton12,
      'gameButton13': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton13,
      'gameButton14': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton14,
      'gameButton15': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton15,
      'gameButton16': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButton16,
      'gameButtonA': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonA,
      'gameButtonB': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonB,
      'gameButtonC': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonC,
      'gameButtonLeft1': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonLeft1,
      'gameButtonLeft2': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonLeft2,
      'gameButtonMode': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonMode,
      'gameButtonRight1': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonRight1,
      'gameButtonRight2': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonRight2,
      'gameButtonSelect': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonSelect,
      'gameButtonStart': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonStart,
      'gameButtonThumbLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonThumbLeft,
      'gameButtonThumbRight': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonThumbRight,
      'gameButtonX': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonX,
      'gameButtonY': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonY,
      'gameButtonZ': (visitor) => $flutter_23.PhysicalKeyboardKey.gameButtonZ,
      'usbReserved': (visitor) => $flutter_23.PhysicalKeyboardKey.usbReserved,
      'usbErrorRollOver': (visitor) => $flutter_23.PhysicalKeyboardKey.usbErrorRollOver,
      'usbPostFail': (visitor) => $flutter_23.PhysicalKeyboardKey.usbPostFail,
      'usbErrorUndefined': (visitor) => $flutter_23.PhysicalKeyboardKey.usbErrorUndefined,
      'keyA': (visitor) => $flutter_23.PhysicalKeyboardKey.keyA,
      'keyB': (visitor) => $flutter_23.PhysicalKeyboardKey.keyB,
      'keyC': (visitor) => $flutter_23.PhysicalKeyboardKey.keyC,
      'keyD': (visitor) => $flutter_23.PhysicalKeyboardKey.keyD,
      'keyE': (visitor) => $flutter_23.PhysicalKeyboardKey.keyE,
      'keyF': (visitor) => $flutter_23.PhysicalKeyboardKey.keyF,
      'keyG': (visitor) => $flutter_23.PhysicalKeyboardKey.keyG,
      'keyH': (visitor) => $flutter_23.PhysicalKeyboardKey.keyH,
      'keyI': (visitor) => $flutter_23.PhysicalKeyboardKey.keyI,
      'keyJ': (visitor) => $flutter_23.PhysicalKeyboardKey.keyJ,
      'keyK': (visitor) => $flutter_23.PhysicalKeyboardKey.keyK,
      'keyL': (visitor) => $flutter_23.PhysicalKeyboardKey.keyL,
      'keyM': (visitor) => $flutter_23.PhysicalKeyboardKey.keyM,
      'keyN': (visitor) => $flutter_23.PhysicalKeyboardKey.keyN,
      'keyO': (visitor) => $flutter_23.PhysicalKeyboardKey.keyO,
      'keyP': (visitor) => $flutter_23.PhysicalKeyboardKey.keyP,
      'keyQ': (visitor) => $flutter_23.PhysicalKeyboardKey.keyQ,
      'keyR': (visitor) => $flutter_23.PhysicalKeyboardKey.keyR,
      'keyS': (visitor) => $flutter_23.PhysicalKeyboardKey.keyS,
      'keyT': (visitor) => $flutter_23.PhysicalKeyboardKey.keyT,
      'keyU': (visitor) => $flutter_23.PhysicalKeyboardKey.keyU,
      'keyV': (visitor) => $flutter_23.PhysicalKeyboardKey.keyV,
      'keyW': (visitor) => $flutter_23.PhysicalKeyboardKey.keyW,
      'keyX': (visitor) => $flutter_23.PhysicalKeyboardKey.keyX,
      'keyY': (visitor) => $flutter_23.PhysicalKeyboardKey.keyY,
      'keyZ': (visitor) => $flutter_23.PhysicalKeyboardKey.keyZ,
      'digit1': (visitor) => $flutter_23.PhysicalKeyboardKey.digit1,
      'digit2': (visitor) => $flutter_23.PhysicalKeyboardKey.digit2,
      'digit3': (visitor) => $flutter_23.PhysicalKeyboardKey.digit3,
      'digit4': (visitor) => $flutter_23.PhysicalKeyboardKey.digit4,
      'digit5': (visitor) => $flutter_23.PhysicalKeyboardKey.digit5,
      'digit6': (visitor) => $flutter_23.PhysicalKeyboardKey.digit6,
      'digit7': (visitor) => $flutter_23.PhysicalKeyboardKey.digit7,
      'digit8': (visitor) => $flutter_23.PhysicalKeyboardKey.digit8,
      'digit9': (visitor) => $flutter_23.PhysicalKeyboardKey.digit9,
      'digit0': (visitor) => $flutter_23.PhysicalKeyboardKey.digit0,
      'enter': (visitor) => $flutter_23.PhysicalKeyboardKey.enter,
      'escape': (visitor) => $flutter_23.PhysicalKeyboardKey.escape,
      'backspace': (visitor) => $flutter_23.PhysicalKeyboardKey.backspace,
      'tab': (visitor) => $flutter_23.PhysicalKeyboardKey.tab,
      'space': (visitor) => $flutter_23.PhysicalKeyboardKey.space,
      'minus': (visitor) => $flutter_23.PhysicalKeyboardKey.minus,
      'equal': (visitor) => $flutter_23.PhysicalKeyboardKey.equal,
      'bracketLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.bracketLeft,
      'bracketRight': (visitor) => $flutter_23.PhysicalKeyboardKey.bracketRight,
      'backslash': (visitor) => $flutter_23.PhysicalKeyboardKey.backslash,
      'semicolon': (visitor) => $flutter_23.PhysicalKeyboardKey.semicolon,
      'quote': (visitor) => $flutter_23.PhysicalKeyboardKey.quote,
      'backquote': (visitor) => $flutter_23.PhysicalKeyboardKey.backquote,
      'comma': (visitor) => $flutter_23.PhysicalKeyboardKey.comma,
      'period': (visitor) => $flutter_23.PhysicalKeyboardKey.period,
      'slash': (visitor) => $flutter_23.PhysicalKeyboardKey.slash,
      'capsLock': (visitor) => $flutter_23.PhysicalKeyboardKey.capsLock,
      'f1': (visitor) => $flutter_23.PhysicalKeyboardKey.f1,
      'f2': (visitor) => $flutter_23.PhysicalKeyboardKey.f2,
      'f3': (visitor) => $flutter_23.PhysicalKeyboardKey.f3,
      'f4': (visitor) => $flutter_23.PhysicalKeyboardKey.f4,
      'f5': (visitor) => $flutter_23.PhysicalKeyboardKey.f5,
      'f6': (visitor) => $flutter_23.PhysicalKeyboardKey.f6,
      'f7': (visitor) => $flutter_23.PhysicalKeyboardKey.f7,
      'f8': (visitor) => $flutter_23.PhysicalKeyboardKey.f8,
      'f9': (visitor) => $flutter_23.PhysicalKeyboardKey.f9,
      'f10': (visitor) => $flutter_23.PhysicalKeyboardKey.f10,
      'f11': (visitor) => $flutter_23.PhysicalKeyboardKey.f11,
      'f12': (visitor) => $flutter_23.PhysicalKeyboardKey.f12,
      'printScreen': (visitor) => $flutter_23.PhysicalKeyboardKey.printScreen,
      'scrollLock': (visitor) => $flutter_23.PhysicalKeyboardKey.scrollLock,
      'pause': (visitor) => $flutter_23.PhysicalKeyboardKey.pause,
      'insert': (visitor) => $flutter_23.PhysicalKeyboardKey.insert,
      'home': (visitor) => $flutter_23.PhysicalKeyboardKey.home,
      'pageUp': (visitor) => $flutter_23.PhysicalKeyboardKey.pageUp,
      'delete': (visitor) => $flutter_23.PhysicalKeyboardKey.delete,
      'end': (visitor) => $flutter_23.PhysicalKeyboardKey.end,
      'pageDown': (visitor) => $flutter_23.PhysicalKeyboardKey.pageDown,
      'arrowRight': (visitor) => $flutter_23.PhysicalKeyboardKey.arrowRight,
      'arrowLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.arrowLeft,
      'arrowDown': (visitor) => $flutter_23.PhysicalKeyboardKey.arrowDown,
      'arrowUp': (visitor) => $flutter_23.PhysicalKeyboardKey.arrowUp,
      'numLock': (visitor) => $flutter_23.PhysicalKeyboardKey.numLock,
      'numpadDivide': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadDivide,
      'numpadMultiply': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadMultiply,
      'numpadSubtract': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadSubtract,
      'numpadAdd': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadAdd,
      'numpadEnter': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadEnter,
      'numpad1': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad1,
      'numpad2': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad2,
      'numpad3': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad3,
      'numpad4': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad4,
      'numpad5': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad5,
      'numpad6': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad6,
      'numpad7': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad7,
      'numpad8': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad8,
      'numpad9': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad9,
      'numpad0': (visitor) => $flutter_23.PhysicalKeyboardKey.numpad0,
      'numpadDecimal': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadDecimal,
      'intlBackslash': (visitor) => $flutter_23.PhysicalKeyboardKey.intlBackslash,
      'contextMenu': (visitor) => $flutter_23.PhysicalKeyboardKey.contextMenu,
      'power': (visitor) => $flutter_23.PhysicalKeyboardKey.power,
      'numpadEqual': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadEqual,
      'f13': (visitor) => $flutter_23.PhysicalKeyboardKey.f13,
      'f14': (visitor) => $flutter_23.PhysicalKeyboardKey.f14,
      'f15': (visitor) => $flutter_23.PhysicalKeyboardKey.f15,
      'f16': (visitor) => $flutter_23.PhysicalKeyboardKey.f16,
      'f17': (visitor) => $flutter_23.PhysicalKeyboardKey.f17,
      'f18': (visitor) => $flutter_23.PhysicalKeyboardKey.f18,
      'f19': (visitor) => $flutter_23.PhysicalKeyboardKey.f19,
      'f20': (visitor) => $flutter_23.PhysicalKeyboardKey.f20,
      'f21': (visitor) => $flutter_23.PhysicalKeyboardKey.f21,
      'f22': (visitor) => $flutter_23.PhysicalKeyboardKey.f22,
      'f23': (visitor) => $flutter_23.PhysicalKeyboardKey.f23,
      'f24': (visitor) => $flutter_23.PhysicalKeyboardKey.f24,
      'open': (visitor) => $flutter_23.PhysicalKeyboardKey.open,
      'help': (visitor) => $flutter_23.PhysicalKeyboardKey.help,
      'select': (visitor) => $flutter_23.PhysicalKeyboardKey.select,
      'again': (visitor) => $flutter_23.PhysicalKeyboardKey.again,
      'undo': (visitor) => $flutter_23.PhysicalKeyboardKey.undo,
      'cut': (visitor) => $flutter_23.PhysicalKeyboardKey.cut,
      'copy': (visitor) => $flutter_23.PhysicalKeyboardKey.copy,
      'paste': (visitor) => $flutter_23.PhysicalKeyboardKey.paste,
      'find': (visitor) => $flutter_23.PhysicalKeyboardKey.find,
      'audioVolumeMute': (visitor) => $flutter_23.PhysicalKeyboardKey.audioVolumeMute,
      'audioVolumeUp': (visitor) => $flutter_23.PhysicalKeyboardKey.audioVolumeUp,
      'audioVolumeDown': (visitor) => $flutter_23.PhysicalKeyboardKey.audioVolumeDown,
      'numpadComma': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadComma,
      'intlRo': (visitor) => $flutter_23.PhysicalKeyboardKey.intlRo,
      'kanaMode': (visitor) => $flutter_23.PhysicalKeyboardKey.kanaMode,
      'intlYen': (visitor) => $flutter_23.PhysicalKeyboardKey.intlYen,
      'convert': (visitor) => $flutter_23.PhysicalKeyboardKey.convert,
      'nonConvert': (visitor) => $flutter_23.PhysicalKeyboardKey.nonConvert,
      'lang1': (visitor) => $flutter_23.PhysicalKeyboardKey.lang1,
      'lang2': (visitor) => $flutter_23.PhysicalKeyboardKey.lang2,
      'lang3': (visitor) => $flutter_23.PhysicalKeyboardKey.lang3,
      'lang4': (visitor) => $flutter_23.PhysicalKeyboardKey.lang4,
      'lang5': (visitor) => $flutter_23.PhysicalKeyboardKey.lang5,
      'abort': (visitor) => $flutter_23.PhysicalKeyboardKey.abort,
      'props': (visitor) => $flutter_23.PhysicalKeyboardKey.props,
      'numpadParenLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadParenLeft,
      'numpadParenRight': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadParenRight,
      'numpadBackspace': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadBackspace,
      'numpadMemoryStore': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadMemoryStore,
      'numpadMemoryRecall': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadMemoryRecall,
      'numpadMemoryClear': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadMemoryClear,
      'numpadMemoryAdd': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadMemoryAdd,
      'numpadMemorySubtract': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadMemorySubtract,
      'numpadSignChange': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadSignChange,
      'numpadClear': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadClear,
      'numpadClearEntry': (visitor) => $flutter_23.PhysicalKeyboardKey.numpadClearEntry,
      'controlLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.controlLeft,
      'shiftLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.shiftLeft,
      'altLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.altLeft,
      'metaLeft': (visitor) => $flutter_23.PhysicalKeyboardKey.metaLeft,
      'controlRight': (visitor) => $flutter_23.PhysicalKeyboardKey.controlRight,
      'shiftRight': (visitor) => $flutter_23.PhysicalKeyboardKey.shiftRight,
      'altRight': (visitor) => $flutter_23.PhysicalKeyboardKey.altRight,
      'metaRight': (visitor) => $flutter_23.PhysicalKeyboardKey.metaRight,
      'info': (visitor) => $flutter_23.PhysicalKeyboardKey.info,
      'closedCaptionToggle': (visitor) => $flutter_23.PhysicalKeyboardKey.closedCaptionToggle,
      'brightnessUp': (visitor) => $flutter_23.PhysicalKeyboardKey.brightnessUp,
      'brightnessDown': (visitor) => $flutter_23.PhysicalKeyboardKey.brightnessDown,
      'brightnessToggle': (visitor) => $flutter_23.PhysicalKeyboardKey.brightnessToggle,
      'brightnessMinimum': (visitor) => $flutter_23.PhysicalKeyboardKey.brightnessMinimum,
      'brightnessMaximum': (visitor) => $flutter_23.PhysicalKeyboardKey.brightnessMaximum,
      'brightnessAuto': (visitor) => $flutter_23.PhysicalKeyboardKey.brightnessAuto,
      'kbdIllumUp': (visitor) => $flutter_23.PhysicalKeyboardKey.kbdIllumUp,
      'kbdIllumDown': (visitor) => $flutter_23.PhysicalKeyboardKey.kbdIllumDown,
      'mediaLast': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaLast,
      'launchPhone': (visitor) => $flutter_23.PhysicalKeyboardKey.launchPhone,
      'programGuide': (visitor) => $flutter_23.PhysicalKeyboardKey.programGuide,
      'exit': (visitor) => $flutter_23.PhysicalKeyboardKey.exit,
      'channelUp': (visitor) => $flutter_23.PhysicalKeyboardKey.channelUp,
      'channelDown': (visitor) => $flutter_23.PhysicalKeyboardKey.channelDown,
      'mediaPlay': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaPlay,
      'mediaPause': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaPause,
      'mediaRecord': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaRecord,
      'mediaFastForward': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaFastForward,
      'mediaRewind': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaRewind,
      'mediaTrackNext': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaTrackNext,
      'mediaTrackPrevious': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaTrackPrevious,
      'mediaStop': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaStop,
      'eject': (visitor) => $flutter_23.PhysicalKeyboardKey.eject,
      'mediaPlayPause': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaPlayPause,
      'speechInputToggle': (visitor) => $flutter_23.PhysicalKeyboardKey.speechInputToggle,
      'bassBoost': (visitor) => $flutter_23.PhysicalKeyboardKey.bassBoost,
      'mediaSelect': (visitor) => $flutter_23.PhysicalKeyboardKey.mediaSelect,
      'launchWordProcessor': (visitor) => $flutter_23.PhysicalKeyboardKey.launchWordProcessor,
      'launchSpreadsheet': (visitor) => $flutter_23.PhysicalKeyboardKey.launchSpreadsheet,
      'launchMail': (visitor) => $flutter_23.PhysicalKeyboardKey.launchMail,
      'launchContacts': (visitor) => $flutter_23.PhysicalKeyboardKey.launchContacts,
      'launchCalendar': (visitor) => $flutter_23.PhysicalKeyboardKey.launchCalendar,
      'launchApp2': (visitor) => $flutter_23.PhysicalKeyboardKey.launchApp2,
      'launchApp1': (visitor) => $flutter_23.PhysicalKeyboardKey.launchApp1,
      'launchInternetBrowser': (visitor) => $flutter_23.PhysicalKeyboardKey.launchInternetBrowser,
      'logOff': (visitor) => $flutter_23.PhysicalKeyboardKey.logOff,
      'lockScreen': (visitor) => $flutter_23.PhysicalKeyboardKey.lockScreen,
      'launchControlPanel': (visitor) => $flutter_23.PhysicalKeyboardKey.launchControlPanel,
      'selectTask': (visitor) => $flutter_23.PhysicalKeyboardKey.selectTask,
      'launchDocuments': (visitor) => $flutter_23.PhysicalKeyboardKey.launchDocuments,
      'spellCheck': (visitor) => $flutter_23.PhysicalKeyboardKey.spellCheck,
      'launchKeyboardLayout': (visitor) => $flutter_23.PhysicalKeyboardKey.launchKeyboardLayout,
      'launchScreenSaver': (visitor) => $flutter_23.PhysicalKeyboardKey.launchScreenSaver,
      'launchAudioBrowser': (visitor) => $flutter_23.PhysicalKeyboardKey.launchAudioBrowser,
      'launchAssistant': (visitor) => $flutter_23.PhysicalKeyboardKey.launchAssistant,
      'newKey': (visitor) => $flutter_23.PhysicalKeyboardKey.newKey,
      'close': (visitor) => $flutter_23.PhysicalKeyboardKey.close,
      'save': (visitor) => $flutter_23.PhysicalKeyboardKey.save,
      'print': (visitor) => $flutter_23.PhysicalKeyboardKey.print,
      'browserSearch': (visitor) => $flutter_23.PhysicalKeyboardKey.browserSearch,
      'browserHome': (visitor) => $flutter_23.PhysicalKeyboardKey.browserHome,
      'browserBack': (visitor) => $flutter_23.PhysicalKeyboardKey.browserBack,
      'browserForward': (visitor) => $flutter_23.PhysicalKeyboardKey.browserForward,
      'browserStop': (visitor) => $flutter_23.PhysicalKeyboardKey.browserStop,
      'browserRefresh': (visitor) => $flutter_23.PhysicalKeyboardKey.browserRefresh,
      'browserFavorites': (visitor) => $flutter_23.PhysicalKeyboardKey.browserFavorites,
      'zoomIn': (visitor) => $flutter_23.PhysicalKeyboardKey.zoomIn,
      'zoomOut': (visitor) => $flutter_23.PhysicalKeyboardKey.zoomOut,
      'zoomToggle': (visitor) => $flutter_23.PhysicalKeyboardKey.zoomToggle,
      'redo': (visitor) => $flutter_23.PhysicalKeyboardKey.redo,
      'mailReply': (visitor) => $flutter_23.PhysicalKeyboardKey.mailReply,
      'mailForward': (visitor) => $flutter_23.PhysicalKeyboardKey.mailForward,
      'mailSend': (visitor) => $flutter_23.PhysicalKeyboardKey.mailSend,
      'keyboardLayoutSelect': (visitor) => $flutter_23.PhysicalKeyboardKey.keyboardLayoutSelect,
      'showAllWindows': (visitor) => $flutter_23.PhysicalKeyboardKey.showAllWindows,
      'knownPhysicalKeys': (visitor) => $flutter_23.PhysicalKeyboardKey.knownPhysicalKeys,
    },
    staticMethods: {
      'findKeyByCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findKeyByCode');
        final usageCode = D4.getRequiredArg<int>(positional, 0, 'usageCode', 'findKeyByCode');
        return $flutter_23.PhysicalKeyboardKey.findKeyByCode(usageCode);
      },
    },
    constructorSignatures: {
      '': 'const PhysicalKeyboardKey(int usbHidUsage)',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'usbHidUsage': 'int get usbHidUsage',
      'debugName': 'String? get debugName',
      'hashCode': 'int get hashCode',
    },
    staticMethodSignatures: {
      'findKeyByCode': 'PhysicalKeyboardKey? findKeyByCode(int usageCode)',
    },
    staticGetterSignatures: {
      'hyper': 'PhysicalKeyboardKey get hyper',
      'superKey': 'PhysicalKeyboardKey get superKey',
      'fn': 'PhysicalKeyboardKey get fn',
      'fnLock': 'PhysicalKeyboardKey get fnLock',
      'suspend': 'PhysicalKeyboardKey get suspend',
      'resume': 'PhysicalKeyboardKey get resume',
      'turbo': 'PhysicalKeyboardKey get turbo',
      'privacyScreenToggle': 'PhysicalKeyboardKey get privacyScreenToggle',
      'microphoneMuteToggle': 'PhysicalKeyboardKey get microphoneMuteToggle',
      'sleep': 'PhysicalKeyboardKey get sleep',
      'wakeUp': 'PhysicalKeyboardKey get wakeUp',
      'displayToggleIntExt': 'PhysicalKeyboardKey get displayToggleIntExt',
      'gameButton1': 'PhysicalKeyboardKey get gameButton1',
      'gameButton2': 'PhysicalKeyboardKey get gameButton2',
      'gameButton3': 'PhysicalKeyboardKey get gameButton3',
      'gameButton4': 'PhysicalKeyboardKey get gameButton4',
      'gameButton5': 'PhysicalKeyboardKey get gameButton5',
      'gameButton6': 'PhysicalKeyboardKey get gameButton6',
      'gameButton7': 'PhysicalKeyboardKey get gameButton7',
      'gameButton8': 'PhysicalKeyboardKey get gameButton8',
      'gameButton9': 'PhysicalKeyboardKey get gameButton9',
      'gameButton10': 'PhysicalKeyboardKey get gameButton10',
      'gameButton11': 'PhysicalKeyboardKey get gameButton11',
      'gameButton12': 'PhysicalKeyboardKey get gameButton12',
      'gameButton13': 'PhysicalKeyboardKey get gameButton13',
      'gameButton14': 'PhysicalKeyboardKey get gameButton14',
      'gameButton15': 'PhysicalKeyboardKey get gameButton15',
      'gameButton16': 'PhysicalKeyboardKey get gameButton16',
      'gameButtonA': 'PhysicalKeyboardKey get gameButtonA',
      'gameButtonB': 'PhysicalKeyboardKey get gameButtonB',
      'gameButtonC': 'PhysicalKeyboardKey get gameButtonC',
      'gameButtonLeft1': 'PhysicalKeyboardKey get gameButtonLeft1',
      'gameButtonLeft2': 'PhysicalKeyboardKey get gameButtonLeft2',
      'gameButtonMode': 'PhysicalKeyboardKey get gameButtonMode',
      'gameButtonRight1': 'PhysicalKeyboardKey get gameButtonRight1',
      'gameButtonRight2': 'PhysicalKeyboardKey get gameButtonRight2',
      'gameButtonSelect': 'PhysicalKeyboardKey get gameButtonSelect',
      'gameButtonStart': 'PhysicalKeyboardKey get gameButtonStart',
      'gameButtonThumbLeft': 'PhysicalKeyboardKey get gameButtonThumbLeft',
      'gameButtonThumbRight': 'PhysicalKeyboardKey get gameButtonThumbRight',
      'gameButtonX': 'PhysicalKeyboardKey get gameButtonX',
      'gameButtonY': 'PhysicalKeyboardKey get gameButtonY',
      'gameButtonZ': 'PhysicalKeyboardKey get gameButtonZ',
      'usbReserved': 'PhysicalKeyboardKey get usbReserved',
      'usbErrorRollOver': 'PhysicalKeyboardKey get usbErrorRollOver',
      'usbPostFail': 'PhysicalKeyboardKey get usbPostFail',
      'usbErrorUndefined': 'PhysicalKeyboardKey get usbErrorUndefined',
      'keyA': 'PhysicalKeyboardKey get keyA',
      'keyB': 'PhysicalKeyboardKey get keyB',
      'keyC': 'PhysicalKeyboardKey get keyC',
      'keyD': 'PhysicalKeyboardKey get keyD',
      'keyE': 'PhysicalKeyboardKey get keyE',
      'keyF': 'PhysicalKeyboardKey get keyF',
      'keyG': 'PhysicalKeyboardKey get keyG',
      'keyH': 'PhysicalKeyboardKey get keyH',
      'keyI': 'PhysicalKeyboardKey get keyI',
      'keyJ': 'PhysicalKeyboardKey get keyJ',
      'keyK': 'PhysicalKeyboardKey get keyK',
      'keyL': 'PhysicalKeyboardKey get keyL',
      'keyM': 'PhysicalKeyboardKey get keyM',
      'keyN': 'PhysicalKeyboardKey get keyN',
      'keyO': 'PhysicalKeyboardKey get keyO',
      'keyP': 'PhysicalKeyboardKey get keyP',
      'keyQ': 'PhysicalKeyboardKey get keyQ',
      'keyR': 'PhysicalKeyboardKey get keyR',
      'keyS': 'PhysicalKeyboardKey get keyS',
      'keyT': 'PhysicalKeyboardKey get keyT',
      'keyU': 'PhysicalKeyboardKey get keyU',
      'keyV': 'PhysicalKeyboardKey get keyV',
      'keyW': 'PhysicalKeyboardKey get keyW',
      'keyX': 'PhysicalKeyboardKey get keyX',
      'keyY': 'PhysicalKeyboardKey get keyY',
      'keyZ': 'PhysicalKeyboardKey get keyZ',
      'digit1': 'PhysicalKeyboardKey get digit1',
      'digit2': 'PhysicalKeyboardKey get digit2',
      'digit3': 'PhysicalKeyboardKey get digit3',
      'digit4': 'PhysicalKeyboardKey get digit4',
      'digit5': 'PhysicalKeyboardKey get digit5',
      'digit6': 'PhysicalKeyboardKey get digit6',
      'digit7': 'PhysicalKeyboardKey get digit7',
      'digit8': 'PhysicalKeyboardKey get digit8',
      'digit9': 'PhysicalKeyboardKey get digit9',
      'digit0': 'PhysicalKeyboardKey get digit0',
      'enter': 'PhysicalKeyboardKey get enter',
      'escape': 'PhysicalKeyboardKey get escape',
      'backspace': 'PhysicalKeyboardKey get backspace',
      'tab': 'PhysicalKeyboardKey get tab',
      'space': 'PhysicalKeyboardKey get space',
      'minus': 'PhysicalKeyboardKey get minus',
      'equal': 'PhysicalKeyboardKey get equal',
      'bracketLeft': 'PhysicalKeyboardKey get bracketLeft',
      'bracketRight': 'PhysicalKeyboardKey get bracketRight',
      'backslash': 'PhysicalKeyboardKey get backslash',
      'semicolon': 'PhysicalKeyboardKey get semicolon',
      'quote': 'PhysicalKeyboardKey get quote',
      'backquote': 'PhysicalKeyboardKey get backquote',
      'comma': 'PhysicalKeyboardKey get comma',
      'period': 'PhysicalKeyboardKey get period',
      'slash': 'PhysicalKeyboardKey get slash',
      'capsLock': 'PhysicalKeyboardKey get capsLock',
      'f1': 'PhysicalKeyboardKey get f1',
      'f2': 'PhysicalKeyboardKey get f2',
      'f3': 'PhysicalKeyboardKey get f3',
      'f4': 'PhysicalKeyboardKey get f4',
      'f5': 'PhysicalKeyboardKey get f5',
      'f6': 'PhysicalKeyboardKey get f6',
      'f7': 'PhysicalKeyboardKey get f7',
      'f8': 'PhysicalKeyboardKey get f8',
      'f9': 'PhysicalKeyboardKey get f9',
      'f10': 'PhysicalKeyboardKey get f10',
      'f11': 'PhysicalKeyboardKey get f11',
      'f12': 'PhysicalKeyboardKey get f12',
      'printScreen': 'PhysicalKeyboardKey get printScreen',
      'scrollLock': 'PhysicalKeyboardKey get scrollLock',
      'pause': 'PhysicalKeyboardKey get pause',
      'insert': 'PhysicalKeyboardKey get insert',
      'home': 'PhysicalKeyboardKey get home',
      'pageUp': 'PhysicalKeyboardKey get pageUp',
      'delete': 'PhysicalKeyboardKey get delete',
      'end': 'PhysicalKeyboardKey get end',
      'pageDown': 'PhysicalKeyboardKey get pageDown',
      'arrowRight': 'PhysicalKeyboardKey get arrowRight',
      'arrowLeft': 'PhysicalKeyboardKey get arrowLeft',
      'arrowDown': 'PhysicalKeyboardKey get arrowDown',
      'arrowUp': 'PhysicalKeyboardKey get arrowUp',
      'numLock': 'PhysicalKeyboardKey get numLock',
      'numpadDivide': 'PhysicalKeyboardKey get numpadDivide',
      'numpadMultiply': 'PhysicalKeyboardKey get numpadMultiply',
      'numpadSubtract': 'PhysicalKeyboardKey get numpadSubtract',
      'numpadAdd': 'PhysicalKeyboardKey get numpadAdd',
      'numpadEnter': 'PhysicalKeyboardKey get numpadEnter',
      'numpad1': 'PhysicalKeyboardKey get numpad1',
      'numpad2': 'PhysicalKeyboardKey get numpad2',
      'numpad3': 'PhysicalKeyboardKey get numpad3',
      'numpad4': 'PhysicalKeyboardKey get numpad4',
      'numpad5': 'PhysicalKeyboardKey get numpad5',
      'numpad6': 'PhysicalKeyboardKey get numpad6',
      'numpad7': 'PhysicalKeyboardKey get numpad7',
      'numpad8': 'PhysicalKeyboardKey get numpad8',
      'numpad9': 'PhysicalKeyboardKey get numpad9',
      'numpad0': 'PhysicalKeyboardKey get numpad0',
      'numpadDecimal': 'PhysicalKeyboardKey get numpadDecimal',
      'intlBackslash': 'PhysicalKeyboardKey get intlBackslash',
      'contextMenu': 'PhysicalKeyboardKey get contextMenu',
      'power': 'PhysicalKeyboardKey get power',
      'numpadEqual': 'PhysicalKeyboardKey get numpadEqual',
      'f13': 'PhysicalKeyboardKey get f13',
      'f14': 'PhysicalKeyboardKey get f14',
      'f15': 'PhysicalKeyboardKey get f15',
      'f16': 'PhysicalKeyboardKey get f16',
      'f17': 'PhysicalKeyboardKey get f17',
      'f18': 'PhysicalKeyboardKey get f18',
      'f19': 'PhysicalKeyboardKey get f19',
      'f20': 'PhysicalKeyboardKey get f20',
      'f21': 'PhysicalKeyboardKey get f21',
      'f22': 'PhysicalKeyboardKey get f22',
      'f23': 'PhysicalKeyboardKey get f23',
      'f24': 'PhysicalKeyboardKey get f24',
      'open': 'PhysicalKeyboardKey get open',
      'help': 'PhysicalKeyboardKey get help',
      'select': 'PhysicalKeyboardKey get select',
      'again': 'PhysicalKeyboardKey get again',
      'undo': 'PhysicalKeyboardKey get undo',
      'cut': 'PhysicalKeyboardKey get cut',
      'copy': 'PhysicalKeyboardKey get copy',
      'paste': 'PhysicalKeyboardKey get paste',
      'find': 'PhysicalKeyboardKey get find',
      'audioVolumeMute': 'PhysicalKeyboardKey get audioVolumeMute',
      'audioVolumeUp': 'PhysicalKeyboardKey get audioVolumeUp',
      'audioVolumeDown': 'PhysicalKeyboardKey get audioVolumeDown',
      'numpadComma': 'PhysicalKeyboardKey get numpadComma',
      'intlRo': 'PhysicalKeyboardKey get intlRo',
      'kanaMode': 'PhysicalKeyboardKey get kanaMode',
      'intlYen': 'PhysicalKeyboardKey get intlYen',
      'convert': 'PhysicalKeyboardKey get convert',
      'nonConvert': 'PhysicalKeyboardKey get nonConvert',
      'lang1': 'PhysicalKeyboardKey get lang1',
      'lang2': 'PhysicalKeyboardKey get lang2',
      'lang3': 'PhysicalKeyboardKey get lang3',
      'lang4': 'PhysicalKeyboardKey get lang4',
      'lang5': 'PhysicalKeyboardKey get lang5',
      'abort': 'PhysicalKeyboardKey get abort',
      'props': 'PhysicalKeyboardKey get props',
      'numpadParenLeft': 'PhysicalKeyboardKey get numpadParenLeft',
      'numpadParenRight': 'PhysicalKeyboardKey get numpadParenRight',
      'numpadBackspace': 'PhysicalKeyboardKey get numpadBackspace',
      'numpadMemoryStore': 'PhysicalKeyboardKey get numpadMemoryStore',
      'numpadMemoryRecall': 'PhysicalKeyboardKey get numpadMemoryRecall',
      'numpadMemoryClear': 'PhysicalKeyboardKey get numpadMemoryClear',
      'numpadMemoryAdd': 'PhysicalKeyboardKey get numpadMemoryAdd',
      'numpadMemorySubtract': 'PhysicalKeyboardKey get numpadMemorySubtract',
      'numpadSignChange': 'PhysicalKeyboardKey get numpadSignChange',
      'numpadClear': 'PhysicalKeyboardKey get numpadClear',
      'numpadClearEntry': 'PhysicalKeyboardKey get numpadClearEntry',
      'controlLeft': 'PhysicalKeyboardKey get controlLeft',
      'shiftLeft': 'PhysicalKeyboardKey get shiftLeft',
      'altLeft': 'PhysicalKeyboardKey get altLeft',
      'metaLeft': 'PhysicalKeyboardKey get metaLeft',
      'controlRight': 'PhysicalKeyboardKey get controlRight',
      'shiftRight': 'PhysicalKeyboardKey get shiftRight',
      'altRight': 'PhysicalKeyboardKey get altRight',
      'metaRight': 'PhysicalKeyboardKey get metaRight',
      'info': 'PhysicalKeyboardKey get info',
      'closedCaptionToggle': 'PhysicalKeyboardKey get closedCaptionToggle',
      'brightnessUp': 'PhysicalKeyboardKey get brightnessUp',
      'brightnessDown': 'PhysicalKeyboardKey get brightnessDown',
      'brightnessToggle': 'PhysicalKeyboardKey get brightnessToggle',
      'brightnessMinimum': 'PhysicalKeyboardKey get brightnessMinimum',
      'brightnessMaximum': 'PhysicalKeyboardKey get brightnessMaximum',
      'brightnessAuto': 'PhysicalKeyboardKey get brightnessAuto',
      'kbdIllumUp': 'PhysicalKeyboardKey get kbdIllumUp',
      'kbdIllumDown': 'PhysicalKeyboardKey get kbdIllumDown',
      'mediaLast': 'PhysicalKeyboardKey get mediaLast',
      'launchPhone': 'PhysicalKeyboardKey get launchPhone',
      'programGuide': 'PhysicalKeyboardKey get programGuide',
      'exit': 'PhysicalKeyboardKey get exit',
      'channelUp': 'PhysicalKeyboardKey get channelUp',
      'channelDown': 'PhysicalKeyboardKey get channelDown',
      'mediaPlay': 'PhysicalKeyboardKey get mediaPlay',
      'mediaPause': 'PhysicalKeyboardKey get mediaPause',
      'mediaRecord': 'PhysicalKeyboardKey get mediaRecord',
      'mediaFastForward': 'PhysicalKeyboardKey get mediaFastForward',
      'mediaRewind': 'PhysicalKeyboardKey get mediaRewind',
      'mediaTrackNext': 'PhysicalKeyboardKey get mediaTrackNext',
      'mediaTrackPrevious': 'PhysicalKeyboardKey get mediaTrackPrevious',
      'mediaStop': 'PhysicalKeyboardKey get mediaStop',
      'eject': 'PhysicalKeyboardKey get eject',
      'mediaPlayPause': 'PhysicalKeyboardKey get mediaPlayPause',
      'speechInputToggle': 'PhysicalKeyboardKey get speechInputToggle',
      'bassBoost': 'PhysicalKeyboardKey get bassBoost',
      'mediaSelect': 'PhysicalKeyboardKey get mediaSelect',
      'launchWordProcessor': 'PhysicalKeyboardKey get launchWordProcessor',
      'launchSpreadsheet': 'PhysicalKeyboardKey get launchSpreadsheet',
      'launchMail': 'PhysicalKeyboardKey get launchMail',
      'launchContacts': 'PhysicalKeyboardKey get launchContacts',
      'launchCalendar': 'PhysicalKeyboardKey get launchCalendar',
      'launchApp2': 'PhysicalKeyboardKey get launchApp2',
      'launchApp1': 'PhysicalKeyboardKey get launchApp1',
      'launchInternetBrowser': 'PhysicalKeyboardKey get launchInternetBrowser',
      'logOff': 'PhysicalKeyboardKey get logOff',
      'lockScreen': 'PhysicalKeyboardKey get lockScreen',
      'launchControlPanel': 'PhysicalKeyboardKey get launchControlPanel',
      'selectTask': 'PhysicalKeyboardKey get selectTask',
      'launchDocuments': 'PhysicalKeyboardKey get launchDocuments',
      'spellCheck': 'PhysicalKeyboardKey get spellCheck',
      'launchKeyboardLayout': 'PhysicalKeyboardKey get launchKeyboardLayout',
      'launchScreenSaver': 'PhysicalKeyboardKey get launchScreenSaver',
      'launchAudioBrowser': 'PhysicalKeyboardKey get launchAudioBrowser',
      'launchAssistant': 'PhysicalKeyboardKey get launchAssistant',
      'newKey': 'PhysicalKeyboardKey get newKey',
      'close': 'PhysicalKeyboardKey get close',
      'save': 'PhysicalKeyboardKey get save',
      'print': 'PhysicalKeyboardKey get print',
      'browserSearch': 'PhysicalKeyboardKey get browserSearch',
      'browserHome': 'PhysicalKeyboardKey get browserHome',
      'browserBack': 'PhysicalKeyboardKey get browserBack',
      'browserForward': 'PhysicalKeyboardKey get browserForward',
      'browserStop': 'PhysicalKeyboardKey get browserStop',
      'browserRefresh': 'PhysicalKeyboardKey get browserRefresh',
      'browserFavorites': 'PhysicalKeyboardKey get browserFavorites',
      'zoomIn': 'PhysicalKeyboardKey get zoomIn',
      'zoomOut': 'PhysicalKeyboardKey get zoomOut',
      'zoomToggle': 'PhysicalKeyboardKey get zoomToggle',
      'redo': 'PhysicalKeyboardKey get redo',
      'mailReply': 'PhysicalKeyboardKey get mailReply',
      'mailForward': 'PhysicalKeyboardKey get mailForward',
      'mailSend': 'PhysicalKeyboardKey get mailSend',
      'keyboardLayoutSelect': 'PhysicalKeyboardKey get keyboardLayoutSelect',
      'showAllWindows': 'PhysicalKeyboardKey get showAllWindows',
      'knownPhysicalKeys': 'Iterable<PhysicalKeyboardKey> get knownPhysicalKeys',
    },
  );
}

// =============================================================================
// HardwareKeyboard Bridge
// =============================================================================

BridgedClass _createHardwareKeyboardBridge() {
  return BridgedClass(
    nativeType: $flutter_21.HardwareKeyboard,
    name: 'HardwareKeyboard',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_21.HardwareKeyboard();
      },
    },
    getters: {
      'physicalKeysPressed': (visitor, target) => D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard').physicalKeysPressed,
      'logicalKeysPressed': (visitor, target) => D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard').logicalKeysPressed,
      'lockModesEnabled': (visitor, target) => D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard').lockModesEnabled,
      'isControlPressed': (visitor, target) => D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard').isControlPressed,
      'isShiftPressed': (visitor, target) => D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard').isShiftPressed,
      'isAltPressed': (visitor, target) => D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard').isAltPressed,
      'isMetaPressed': (visitor, target) => D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard').isMetaPressed,
    },
    methods: {
      'lookUpLayout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'lookUpLayout');
        final physicalKey = D4.getRequiredArg<$flutter_23.PhysicalKeyboardKey>(positional, 0, 'physicalKey', 'lookUpLayout');
        return t.lookUpLayout(physicalKey);
      },
      'isLogicalKeyPressed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'isLogicalKeyPressed');
        final key = D4.getRequiredArg<$flutter_23.LogicalKeyboardKey>(positional, 0, 'key', 'isLogicalKeyPressed');
        return t.isLogicalKeyPressed(key);
      },
      'isPhysicalKeyPressed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'isPhysicalKeyPressed');
        final key = D4.getRequiredArg<$flutter_23.PhysicalKeyboardKey>(positional, 0, 'key', 'isPhysicalKeyPressed');
        return t.isPhysicalKeyPressed(key);
      },
      'addHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'addHandler');
        if (positional.isEmpty) {
          throw ArgumentError('addHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.addHandler(($flutter_21.KeyEvent p0) { return D4.callInterpreterCallback(visitor, handlerRaw, [p0]) as bool; });
        return null;
      },
      'removeHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'removeHandler');
        if (positional.isEmpty) {
          throw ArgumentError('removeHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.removeHandler(($flutter_21.KeyEvent p0) { return D4.callInterpreterCallback(visitor, handlerRaw, [p0]) as bool; });
        return null;
      },
      'syncKeyboardState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard');
        return t.syncKeyboardState();
      },
      'handleKeyEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'handleKeyEvent');
        final event = D4.getRequiredArg<$flutter_21.KeyEvent>(positional, 0, 'event', 'handleKeyEvent');
        return t.handleKeyEvent(event);
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_21.HardwareKeyboard.instance,
    },
    constructorSignatures: {
      '': 'HardwareKeyboard()',
    },
    methodSignatures: {
      'lookUpLayout': 'LogicalKeyboardKey? lookUpLayout(PhysicalKeyboardKey physicalKey)',
      'isLogicalKeyPressed': 'bool isLogicalKeyPressed(LogicalKeyboardKey key)',
      'isPhysicalKeyPressed': 'bool isPhysicalKeyPressed(PhysicalKeyboardKey key)',
      'addHandler': 'void addHandler(KeyEventCallback handler)',
      'removeHandler': 'void removeHandler(KeyEventCallback handler)',
      'syncKeyboardState': 'Future<void> syncKeyboardState()',
      'handleKeyEvent': 'bool handleKeyEvent(KeyEvent event)',
    },
    getterSignatures: {
      'physicalKeysPressed': 'Set<PhysicalKeyboardKey> get physicalKeysPressed',
      'logicalKeysPressed': 'Set<LogicalKeyboardKey> get logicalKeysPressed',
      'lockModesEnabled': 'Set<KeyboardLockMode> get lockModesEnabled',
      'isControlPressed': 'bool get isControlPressed',
      'isShiftPressed': 'bool get isShiftPressed',
      'isAltPressed': 'bool get isAltPressed',
      'isMetaPressed': 'bool get isMetaPressed',
    },
    staticGetterSignatures: {
      'instance': 'HardwareKeyboard get instance',
    },
  );
}

// =============================================================================
// RestorationManager Bridge
// =============================================================================

BridgedClass _createRestorationManagerBridge() {
  return BridgedClass(
    nativeType: $flutter_35.RestorationManager,
    name: 'RestorationManager',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_35.RestorationManager();
      },
    },
    getters: {
      'rootBucket': (visitor, target) => D4.validateTarget<$flutter_35.RestorationManager>(target, 'RestorationManager').rootBucket,
      'isReplacing': (visitor, target) => D4.validateTarget<$flutter_35.RestorationManager>(target, 'RestorationManager').isReplacing,
    },
    methods: {
      'flushData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.RestorationManager>(target, 'RestorationManager');
        t.flushData();
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.RestorationManager>(target, 'RestorationManager');
        (t as dynamic).dispose();
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.RestorationManager>(target, 'RestorationManager');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.RestorationManager>(target, 'RestorationManager');
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
      '': 'RestorationManager()',
    },
    methodSignatures: {
      'flushData': 'void flushData()',
      'dispose': 'void dispose()',
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
    },
    getterSignatures: {
      'rootBucket': 'Future<RestorationBucket?> get rootBucket',
      'isReplacing': 'bool get isReplacing',
    },
  );
}

// =============================================================================
// ServicesBinding Bridge
// =============================================================================

BridgedClass _createServicesBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_12.ServicesBinding,
    name: 'ServicesBinding',
    constructors: {
    },
    getters: {
      'keyboard': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').keyboard,
      'keyEventManager': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').keyEventManager,
      'defaultBinaryMessenger': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').defaultBinaryMessenger,
      'channelBuffers': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').channelBuffers,
      'accessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').accessibilityFocus,
      'restorationManager': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').restorationManager,
      'window': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').platformDispatcher,
      'lifecycleState': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').lifecycleState,
      'transientCallbackCount': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').transientCallbackCount,
      'endOfFrame': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').endOfFrame,
      'hasScheduledFrame': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').hasScheduledFrame,
      'schedulerPhase': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').schedulerPhase,
      'framesEnabled': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').framesEnabled,
      'currentFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').currentFrameTimeStamp,
      'currentSystemFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').currentSystemFrameTimeStamp,
    },
    setters: {
      'schedulingStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding').schedulingStrategy = value as bool Function({required int priority, required $flutter_6.SchedulerBinding scheduler}),
    },
    methods: {
      'handleRequestAppExit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        return t.handleRequestAppExit();
      },
      'exitApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'exitApplication');
        final exitType = D4.getRequiredArg<AppExitType>(positional, 0, 'exitType', 'exitApplication');
        final exitCode = D4.getOptionalArgWithDefault<int>(positional, 1, 'exitCode', 0);
        return t.exitApplication(exitType, exitCode);
      },
      'setSystemUiChangeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'setSystemUiChangeCallback');
        if (positional.isEmpty) {
          throw ArgumentError('setSystemUiChangeCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.setSystemUiChangeCallback(callbackRaw == null ? null : (bool p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as Future<void>; });
        return null;
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        return t.reassembleApplication();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        return t.toString();
      },
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        t.initInstances();
        return null;
      },
      'addTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'addTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'removeTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'removeTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'scheduleTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 2, 'scheduleTask');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        final priority = D4.getRequiredArg<$flutter_7.Priority>(positional, 1, 'priority', 'scheduleTask');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return t.scheduleTask(() { return D4.callInterpreterCallback(visitor, taskRaw, []) as FutureOr<Object>; }, priority, debugLabel: debugLabel, flow: flow);
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        (t as dynamic).unlocked();
        return null;
      },
      'scheduleFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'cancelFrameCallbackWithId');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'cancelFrameCallbackWithId');
        t.cancelFrameCallbackWithId(id);
        return null;
      },
      'debugAssertNoTransientCallbacks': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTransientCallbacks');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTransientCallbacks');
        return t.debugAssertNoTransientCallbacks(reason);
      },
      'debugAssertNoPendingPerformanceModeRequests': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoPendingPerformanceModeRequests');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoPendingPerformanceModeRequests');
        return t.debugAssertNoPendingPerformanceModeRequests(reason);
      },
      'debugAssertNoTimeDilation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTimeDilation');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTimeDilation');
        return t.debugAssertNoTimeDilation(reason);
      },
      'addPersistentFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'addPersistentFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPersistentFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addPersistentFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor, callbackRaw, [p0]); });
        return null;
      },
      'addPostFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        t.ensureVisualUpdate();
        return null;
      },
      'scheduleFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        t.scheduleFrame();
        return null;
      },
      'scheduleForcedFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        t.scheduleForcedFrame();
        return null;
      },
      'scheduleWarmUpFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        t.scheduleWarmUpFrame();
        return null;
      },
      'resetEpoch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        t.resetEpoch();
        return null;
      },
      'handleBeginFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'handleBeginFrame');
        final rawTimeStamp = D4.getRequiredArg<Duration?>(positional, 0, 'rawTimeStamp', 'handleBeginFrame');
        t.handleBeginFrame(rawTimeStamp);
        return null;
      },
      'requestPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'requestPerformanceMode');
        final mode = D4.getRequiredArg<DartPerformanceMode>(positional, 0, 'mode', 'requestPerformanceMode');
        return t.requestPerformanceMode(mode);
      },
      'debugGetRequestedPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        return t.debugGetRequestedPerformanceMode();
      },
      'handleDrawFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.ServicesBinding>(target, 'ServicesBinding');
        t.handleDrawFrame();
        return null;
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_12.ServicesBinding.instance,
      'rootIsolateToken': (visitor) => $flutter_12.ServicesBinding.rootIsolateToken,
    },
    staticSetters: {
      'systemContextMenuClient': (visitor, value) => 
        $flutter_12.ServicesBinding.systemContextMenuClient = value as dynamic,
    },
    methodSignatures: {
      'handleRequestAppExit': 'Future<ui.AppExitResponse> handleRequestAppExit()',
      'exitApplication': 'Future<ui.AppExitResponse> exitApplication(ui.AppExitType exitType, [int exitCode = 0])',
      'setSystemUiChangeCallback': 'void setSystemUiChangeCallback(SystemUiChangeCallback? callback)',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'reassembleApplication': 'Future<void> reassembleApplication()',
      'toString': 'String toString()',
      'initInstances': 'void initInstances()',
      'addTimingsCallback': 'void addTimingsCallback(void Function(List<FrameTiming>) callback)',
      'removeTimingsCallback': 'void removeTimingsCallback(void Function(List<FrameTiming>) callback)',
      'initServiceExtensions': 'void initServiceExtensions()',
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
      'keyboard': 'HardwareKeyboard get keyboard',
      'keyEventManager': 'KeyEventManager get keyEventManager',
      'defaultBinaryMessenger': 'BinaryMessenger get defaultBinaryMessenger',
      'channelBuffers': 'ui.ChannelBuffers get channelBuffers',
      'accessibilityFocus': 'ValueNotifier<int?> get accessibilityFocus',
      'restorationManager': 'RestorationManager get restorationManager',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
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
      'instance': 'ServicesBinding get instance',
      'rootIsolateToken': 'ui.RootIsolateToken? get rootIsolateToken',
    },
    staticSetterSignatures: {
      'systemContextMenuClient': 'set systemContextMenuClient(SystemContextMenuClient? value)',
    },
  );
}

// =============================================================================
// SystemContextMenuClient Bridge
// =============================================================================

BridgedClass _createSystemContextMenuClientBridge() {
  return BridgedClass(
    nativeType: $flutter_12.SystemContextMenuClient,
    name: 'SystemContextMenuClient',
    constructors: {
    },
    methods: {
      'handleSystemHide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.SystemContextMenuClient>(target, 'SystemContextMenuClient');
        t.handleSystemHide();
        return null;
      },
      'handleCustomContextMenuAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.SystemContextMenuClient>(target, 'SystemContextMenuClient');
        D4.requireMinArgs(positional, 1, 'handleCustomContextMenuAction');
        final actionId = D4.getRequiredArg<String>(positional, 0, 'actionId', 'handleCustomContextMenuAction');
        t.handleCustomContextMenuAction(actionId);
        return null;
      },
    },
    methodSignatures: {
      'handleSystemHide': 'void handleSystemHide()',
      'handleCustomContextMenuAction': 'void handleCustomContextMenuAction(String actionId)',
    },
  );
}

// =============================================================================
// BrowserContextMenu Bridge
// =============================================================================

BridgedClass _createBrowserContextMenuBridge() {
  return BridgedClass(
    nativeType: $flutter_13.BrowserContextMenu,
    name: 'BrowserContextMenu',
    constructors: {
    },
    staticGetters: {
      'enabled': (visitor) => $flutter_13.BrowserContextMenu.enabled,
    },
    staticMethods: {
      'disableContextMenu': (visitor, positional, named, typeArgs) {
        return $flutter_13.BrowserContextMenu.disableContextMenu();
      },
      'enableContextMenu': (visitor, positional, named, typeArgs) {
        return $flutter_13.BrowserContextMenu.enableContextMenu();
      },
    },
    staticMethodSignatures: {
      'disableContextMenu': 'Future<void> disableContextMenu()',
      'enableContextMenu': 'Future<void> enableContextMenu()',
    },
    staticGetterSignatures: {
      'enabled': 'bool get enabled',
    },
  );
}

// =============================================================================
// ClipboardData Bridge
// =============================================================================

BridgedClass _createClipboardDataBridge() {
  return BridgedClass(
    nativeType: $flutter_14.ClipboardData,
    name: 'ClipboardData',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'ClipboardData');
        return $flutter_14.ClipboardData(text: text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_14.ClipboardData>(target, 'ClipboardData').text,
    },
    constructorSignatures: {
      '': 'const ClipboardData({required String text})',
    },
    getterSignatures: {
      'text': 'String? get text',
    },
  );
}

// =============================================================================
// Clipboard Bridge
// =============================================================================

BridgedClass _createClipboardBridge() {
  return BridgedClass(
    nativeType: $flutter_14.Clipboard,
    name: 'Clipboard',
    constructors: {
    },
    staticGetters: {
      'kTextPlain': (visitor) => $flutter_14.Clipboard.kTextPlain,
    },
    staticMethods: {
      'setData': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setData');
        final data = D4.getRequiredArg<$flutter_14.ClipboardData>(positional, 0, 'data', 'setData');
        return $flutter_14.Clipboard.setData(data);
      },
      'getData': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getData');
        final format = D4.getRequiredArg<String>(positional, 0, 'format', 'getData');
        return $flutter_14.Clipboard.getData(format);
      },
      'hasStrings': (visitor, positional, named, typeArgs) {
        return $flutter_14.Clipboard.hasStrings();
      },
    },
    staticMethodSignatures: {
      'setData': 'Future<void> setData(ClipboardData data)',
      'getData': 'Future<ClipboardData?> getData(String format)',
      'hasStrings': 'Future<bool> hasStrings()',
    },
    staticGetterSignatures: {
      'kTextPlain': 'String get kTextPlain',
    },
  );
}

// =============================================================================
// DeferredComponent Bridge
// =============================================================================

BridgedClass _createDeferredComponentBridge() {
  return BridgedClass(
    nativeType: $flutter_16.DeferredComponent,
    name: 'DeferredComponent',
    constructors: {
    },
    staticMethods: {
      'installDeferredComponent': (visitor, positional, named, typeArgs) {
        final componentName = D4.getRequiredNamedArg<String>(named, 'componentName', 'installDeferredComponent');
        return $flutter_16.DeferredComponent.installDeferredComponent(componentName: componentName);
      },
      'uninstallDeferredComponent': (visitor, positional, named, typeArgs) {
        final componentName = D4.getRequiredNamedArg<String>(named, 'componentName', 'uninstallDeferredComponent');
        return $flutter_16.DeferredComponent.uninstallDeferredComponent(componentName: componentName);
      },
    },
    staticMethodSignatures: {
      'installDeferredComponent': 'Future<void> installDeferredComponent({required String componentName})',
      'uninstallDeferredComponent': 'Future<void> uninstallDeferredComponent({required String componentName})',
    },
  );
}

// =============================================================================
// FlutterVersion Bridge
// =============================================================================

BridgedClass _createFlutterVersionBridge() {
  return BridgedClass(
    nativeType: $flutter_18.FlutterVersion,
    name: 'FlutterVersion',
    constructors: {
    },
    staticGetters: {
      'version': (visitor) => $flutter_18.FlutterVersion.version,
      'channel': (visitor) => $flutter_18.FlutterVersion.channel,
      'gitUrl': (visitor) => $flutter_18.FlutterVersion.gitUrl,
      'frameworkRevision': (visitor) => $flutter_18.FlutterVersion.frameworkRevision,
      'engineRevision': (visitor) => $flutter_18.FlutterVersion.engineRevision,
      'dartVersion': (visitor) => $flutter_18.FlutterVersion.dartVersion,
    },
    staticGetterSignatures: {
      'version': 'String? get version',
      'channel': 'String? get channel',
      'gitUrl': 'String? get gitUrl',
      'frameworkRevision': 'String? get frameworkRevision',
      'engineRevision': 'String? get engineRevision',
      'dartVersion': 'String? get dartVersion',
    },
  );
}

// =============================================================================
// FontLoader Bridge
// =============================================================================

BridgedClass _createFontLoaderBridge() {
  return BridgedClass(
    nativeType: $flutter_19.FontLoader,
    name: 'FontLoader',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontLoader');
        final family = D4.getRequiredArg<String>(positional, 0, 'family', 'FontLoader');
        return $flutter_19.FontLoader(family);
      },
    },
    getters: {
      'family': (visitor, target) => D4.validateTarget<$flutter_19.FontLoader>(target, 'FontLoader').family,
    },
    methods: {
      'addFont': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.FontLoader>(target, 'FontLoader');
        D4.requireMinArgs(positional, 1, 'addFont');
        final bytes = D4.getRequiredArg<Future<ByteData>>(positional, 0, 'bytes', 'addFont');
        t.addFont(bytes);
        return null;
      },
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.FontLoader>(target, 'FontLoader');
        return t.load();
      },
    },
    constructorSignatures: {
      '': 'FontLoader(String family)',
    },
    methodSignatures: {
      'addFont': 'void addFont(Future<ByteData> bytes)',
      'load': 'Future<void> load()',
    },
    getterSignatures: {
      'family': 'String get family',
    },
  );
}

// =============================================================================
// HapticFeedback Bridge
// =============================================================================

BridgedClass _createHapticFeedbackBridge() {
  return BridgedClass(
    nativeType: $flutter_20.HapticFeedback,
    name: 'HapticFeedback',
    constructors: {
    },
    staticMethods: {
      'vibrate': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.vibrate();
      },
      'lightImpact': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.lightImpact();
      },
      'mediumImpact': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.mediumImpact();
      },
      'heavyImpact': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.heavyImpact();
      },
      'selectionClick': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.selectionClick();
      },
      'successNotification': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.successNotification();
      },
      'warningNotification': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.warningNotification();
      },
      'errorNotification': (visitor, positional, named, typeArgs) {
        return $flutter_20.HapticFeedback.errorNotification();
      },
    },
    staticMethodSignatures: {
      'vibrate': 'Future<void> vibrate()',
      'lightImpact': 'Future<void> lightImpact()',
      'mediumImpact': 'Future<void> mediumImpact()',
      'heavyImpact': 'Future<void> heavyImpact()',
      'selectionClick': 'Future<void> selectionClick()',
      'successNotification': 'Future<void> successNotification()',
      'warningNotification': 'Future<void> warningNotification()',
      'errorNotification': 'Future<void> errorNotification()',
    },
  );
}

// =============================================================================
// KeyboardInsertedContent Bridge
// =============================================================================

BridgedClass _createKeyboardInsertedContentBridge() {
  return BridgedClass(
    nativeType: $flutter_22.KeyboardInsertedContent,
    name: 'KeyboardInsertedContent',
    constructors: {
      '': (visitor, positional, named) {
        final mimeType = D4.getRequiredNamedArg<String>(named, 'mimeType', 'KeyboardInsertedContent');
        final uri = D4.getRequiredNamedArg<String>(named, 'uri', 'KeyboardInsertedContent');
        final data = D4.getOptionalNamedArg<Uint8List?>(named, 'data');
        return $flutter_22.KeyboardInsertedContent(mimeType: mimeType, uri: uri, data: data);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'KeyboardInsertedContent');
        if (positional.isEmpty) {
          throw ArgumentError('KeyboardInsertedContent: Missing required argument "metadata" at position 0');
        }
        final metadata = D4.coerceMap<String, dynamic>(positional[0], 'metadata');
        return $flutter_22.KeyboardInsertedContent.fromJson(metadata);
      },
    },
    getters: {
      'mimeType': (visitor, target) => D4.validateTarget<$flutter_22.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').mimeType,
      'uri': (visitor, target) => D4.validateTarget<$flutter_22.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').uri,
      'data': (visitor, target) => D4.validateTarget<$flutter_22.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').data,
      'hasData': (visitor, target) => D4.validateTarget<$flutter_22.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').hasData,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_22.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.KeyboardInsertedContent>(target, 'KeyboardInsertedContent');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.KeyboardInsertedContent>(target, 'KeyboardInsertedContent');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const KeyboardInsertedContent({required String mimeType, required String uri, Uint8List? data})',
      'fromJson': 'KeyboardInsertedContent.fromJson(Map<String, dynamic> metadata)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'mimeType': 'String get mimeType',
      'uri': 'String get uri',
      'data': 'Uint8List? get data',
      'hasData': 'bool get hasData',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// LiveText Bridge
// =============================================================================

BridgedClass _createLiveTextBridge() {
  return BridgedClass(
    nativeType: $flutter_25.LiveText,
    name: 'LiveText',
    constructors: {
    },
    staticMethods: {
      'isLiveTextInputAvailable': (visitor, positional, named, typeArgs) {
        return $flutter_25.LiveText.isLiveTextInputAvailable();
      },
      'startLiveTextInput': (visitor, positional, named, typeArgs) {
        return $flutter_25.LiveText.startLiveTextInput();
      },
    },
    staticMethodSignatures: {
      'isLiveTextInputAvailable': 'Future<bool> isLiveTextInputAvailable()',
      'startLiveTextInput': 'void startLiveTextInput()',
    },
  );
}

// =============================================================================
// MessageCodec Bridge
// =============================================================================

BridgedClass _createMessageCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_26.MessageCodec,
    name: 'MessageCodec',
    constructors: {
    },
    methods: {
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MessageCodec>(target, 'MessageCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MessageCodec>(target, 'MessageCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
    },
    methodSignatures: {
      'encodeMessage': 'ByteData? encodeMessage(T message)',
      'decodeMessage': 'T? decodeMessage(ByteData? message)',
    },
  );
}

// =============================================================================
// MethodCall Bridge
// =============================================================================

BridgedClass _createMethodCallBridge() {
  return BridgedClass(
    nativeType: $flutter_26.MethodCall,
    name: 'MethodCall',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MethodCall');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'MethodCall');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return $flutter_26.MethodCall(method, arguments);
      },
    },
    getters: {
      'method': (visitor, target) => D4.validateTarget<$flutter_26.MethodCall>(target, 'MethodCall').method,
      'arguments': (visitor, target) => D4.validateTarget<$flutter_26.MethodCall>(target, 'MethodCall').arguments,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MethodCall>(target, 'MethodCall');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const MethodCall(String method, [dynamic arguments])',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'method': 'String get method',
      'arguments': 'dynamic get arguments',
    },
  );
}

// =============================================================================
// MethodCodec Bridge
// =============================================================================

BridgedClass _createMethodCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_26.MethodCodec,
    name: 'MethodCodec',
    constructors: {
    },
    methods: {
      'encodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeMethodCall');
        final methodCall = D4.getRequiredArg<$flutter_26.MethodCall>(positional, 0, 'methodCall', 'encodeMethodCall');
        return t.encodeMethodCall(methodCall);
      },
      'decodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeMethodCall');
        final methodCall = D4.getRequiredArg<ByteData?>(positional, 0, 'methodCall', 'decodeMethodCall');
        return t.decodeMethodCall(methodCall);
      },
      'decodeEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeEnvelope');
        final envelope = D4.getRequiredArg<ByteData>(positional, 0, 'envelope', 'decodeEnvelope');
        return t.decodeEnvelope(envelope);
      },
      'encodeSuccessEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeSuccessEnvelope');
        final result = D4.getRequiredArg<Object?>(positional, 0, 'result', 'encodeSuccessEnvelope');
        return t.encodeSuccessEnvelope(result);
      },
      'encodeErrorEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MethodCodec>(target, 'MethodCodec');
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'encodeErrorEnvelope');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final details = D4.getOptionalNamedArg<Object?>(named, 'details');
        return t.encodeErrorEnvelope(code: code, message: message, details: details);
      },
    },
    methodSignatures: {
      'encodeMethodCall': 'ByteData encodeMethodCall(MethodCall methodCall)',
      'decodeMethodCall': 'MethodCall decodeMethodCall(ByteData? methodCall)',
      'decodeEnvelope': 'dynamic decodeEnvelope(ByteData envelope)',
      'encodeSuccessEnvelope': 'ByteData encodeSuccessEnvelope(Object? result)',
      'encodeErrorEnvelope': 'ByteData encodeErrorEnvelope({required String code, String? message, Object? details})',
    },
  );
}

// =============================================================================
// PlatformException Bridge
// =============================================================================

BridgedClass _createPlatformExceptionBridge() {
  return BridgedClass(
    nativeType: $flutter_26.PlatformException,
    name: 'PlatformException',
    constructors: {
      '': (visitor, positional, named) {
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'PlatformException');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final details = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'details', 'PlatformException', '<default unavailable>');
        final stacktrace = D4.getOptionalNamedArg<String?>(named, 'stacktrace');
        return $flutter_26.PlatformException(code: code, message: message, details: details, stacktrace: stacktrace);
      },
    },
    getters: {
      'code': (visitor, target) => D4.validateTarget<$flutter_26.PlatformException>(target, 'PlatformException').code,
      'message': (visitor, target) => D4.validateTarget<$flutter_26.PlatformException>(target, 'PlatformException').message,
      'details': (visitor, target) => D4.validateTarget<$flutter_26.PlatformException>(target, 'PlatformException').details,
      'stacktrace': (visitor, target) => D4.validateTarget<$flutter_26.PlatformException>(target, 'PlatformException').stacktrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.PlatformException>(target, 'PlatformException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'PlatformException({required String code, String? message, dynamic details, String? stacktrace})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'code': 'String get code',
      'message': 'String? get message',
      'details': 'dynamic get details',
      'stacktrace': 'String? get stacktrace',
    },
  );
}

// =============================================================================
// MissingPluginException Bridge
// =============================================================================

BridgedClass _createMissingPluginExceptionBridge() {
  return BridgedClass(
    nativeType: $flutter_26.MissingPluginException,
    name: 'MissingPluginException',
    constructors: {
      '': (visitor, positional, named) {
        final message = D4.getOptionalArg<String?>(positional, 0, 'message');
        return $flutter_26.MissingPluginException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$flutter_26.MissingPluginException>(target, 'MissingPluginException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.MissingPluginException>(target, 'MissingPluginException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'MissingPluginException([String? message])',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String? get message',
    },
  );
}

// =============================================================================
// BinaryCodec Bridge
// =============================================================================

BridgedClass _createBinaryCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_27.BinaryCodec,
    name: 'BinaryCodec',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_27.BinaryCodec();
      },
    },
    methods: {
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.BinaryCodec>(target, 'BinaryCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.BinaryCodec>(target, 'BinaryCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
    },
    constructorSignatures: {
      '': 'const BinaryCodec()',
    },
    methodSignatures: {
      'decodeMessage': 'ByteData? decodeMessage(ByteData? message)',
      'encodeMessage': 'ByteData? encodeMessage(ByteData? message)',
    },
  );
}

// =============================================================================
// StringCodec Bridge
// =============================================================================

BridgedClass _createStringCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_27.StringCodec,
    name: 'StringCodec',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_27.StringCodec();
      },
    },
    methods: {
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StringCodec>(target, 'StringCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StringCodec>(target, 'StringCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<String?>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
    },
    constructorSignatures: {
      '': 'const StringCodec()',
    },
    methodSignatures: {
      'decodeMessage': 'String? decodeMessage(ByteData? message)',
      'encodeMessage': 'ByteData? encodeMessage(String? message)',
    },
  );
}

// =============================================================================
// JSONMessageCodec Bridge
// =============================================================================

BridgedClass _createJSONMessageCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_27.JSONMessageCodec,
    name: 'JSONMessageCodec',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_27.JSONMessageCodec();
      },
    },
    methods: {
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.JSONMessageCodec>(target, 'JSONMessageCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<Object?>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.JSONMessageCodec>(target, 'JSONMessageCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
    },
    constructorSignatures: {
      '': 'const JSONMessageCodec()',
    },
    methodSignatures: {
      'encodeMessage': 'ByteData? encodeMessage(Object? message)',
      'decodeMessage': 'dynamic decodeMessage(ByteData? message)',
    },
  );
}

// =============================================================================
// JSONMethodCodec Bridge
// =============================================================================

BridgedClass _createJSONMethodCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_27.JSONMethodCodec,
    name: 'JSONMethodCodec',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_27.JSONMethodCodec();
      },
    },
    methods: {
      'encodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeMethodCall');
        final methodCall = D4.getRequiredArg<$flutter_26.MethodCall>(positional, 0, 'methodCall', 'encodeMethodCall');
        return t.encodeMethodCall(methodCall);
      },
      'decodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeMethodCall');
        final methodCall = D4.getRequiredArg<ByteData?>(positional, 0, 'methodCall', 'decodeMethodCall');
        return t.decodeMethodCall(methodCall);
      },
      'decodeEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeEnvelope');
        final envelope = D4.getRequiredArg<ByteData>(positional, 0, 'envelope', 'decodeEnvelope');
        return t.decodeEnvelope(envelope);
      },
      'encodeSuccessEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeSuccessEnvelope');
        final result = D4.getRequiredArg<Object?>(positional, 0, 'result', 'encodeSuccessEnvelope');
        return t.encodeSuccessEnvelope(result);
      },
      'encodeErrorEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.JSONMethodCodec>(target, 'JSONMethodCodec');
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'encodeErrorEnvelope');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final details = D4.getOptionalNamedArg<Object?>(named, 'details');
        return t.encodeErrorEnvelope(code: code, message: message, details: details);
      },
    },
    constructorSignatures: {
      '': 'const JSONMethodCodec()',
    },
    methodSignatures: {
      'encodeMethodCall': 'ByteData encodeMethodCall(MethodCall methodCall)',
      'decodeMethodCall': 'MethodCall decodeMethodCall(ByteData? methodCall)',
      'decodeEnvelope': 'dynamic decodeEnvelope(ByteData envelope)',
      'encodeSuccessEnvelope': 'ByteData encodeSuccessEnvelope(Object? result)',
      'encodeErrorEnvelope': 'ByteData encodeErrorEnvelope({required String code, String? message, Object? details})',
    },
  );
}

// =============================================================================
// StandardMessageCodec Bridge
// =============================================================================

BridgedClass _createStandardMessageCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_27.StandardMessageCodec,
    name: 'StandardMessageCodec',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_27.StandardMessageCodec();
      },
    },
    methods: {
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<Object?>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
      'writeValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 2, 'writeValue');
        final buffer = D4.getRequiredArg<$flutter_4.WriteBuffer>(positional, 0, 'buffer', 'writeValue');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'writeValue');
        t.writeValue(buffer, value);
        return null;
      },
      'readValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'readValue');
        final buffer = D4.getRequiredArg<$flutter_4.ReadBuffer>(positional, 0, 'buffer', 'readValue');
        return t.readValue(buffer);
      },
      'readValueOfType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 2, 'readValueOfType');
        final type = D4.getRequiredArg<int>(positional, 0, 'type', 'readValueOfType');
        final buffer = D4.getRequiredArg<$flutter_4.ReadBuffer>(positional, 1, 'buffer', 'readValueOfType');
        return t.readValueOfType(type, buffer);
      },
      'writeSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 2, 'writeSize');
        final buffer = D4.getRequiredArg<$flutter_4.WriteBuffer>(positional, 0, 'buffer', 'writeSize');
        final value = D4.getRequiredArg<int>(positional, 1, 'value', 'writeSize');
        t.writeSize(buffer, value);
        return null;
      },
      'readSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'readSize');
        final buffer = D4.getRequiredArg<$flutter_4.ReadBuffer>(positional, 0, 'buffer', 'readSize');
        return t.readSize(buffer);
      },
    },
    constructorSignatures: {
      '': 'const StandardMessageCodec()',
    },
    methodSignatures: {
      'encodeMessage': 'ByteData? encodeMessage(Object? message)',
      'decodeMessage': 'dynamic decodeMessage(ByteData? message)',
      'writeValue': 'void writeValue(WriteBuffer buffer, Object? value)',
      'readValue': 'Object? readValue(ReadBuffer buffer)',
      'readValueOfType': 'Object? readValueOfType(int type, ReadBuffer buffer)',
      'writeSize': 'void writeSize(WriteBuffer buffer, int value)',
      'readSize': 'int readSize(ReadBuffer buffer)',
    },
  );
}

// =============================================================================
// StandardMethodCodec Bridge
// =============================================================================

BridgedClass _createStandardMethodCodecBridge() {
  return BridgedClass(
    nativeType: $flutter_27.StandardMethodCodec,
    name: 'StandardMethodCodec',
    constructors: {
      '': (visitor, positional, named) {
        final messageCodec = D4.getOptionalArgWithDefault<$flutter_27.StandardMessageCodec>(positional, 0, 'messageCodec', const $flutter_27.StandardMessageCodec());
        return $flutter_27.StandardMethodCodec(messageCodec);
      },
    },
    getters: {
      'messageCodec': (visitor, target) => D4.validateTarget<$flutter_27.StandardMethodCodec>(target, 'StandardMethodCodec').messageCodec,
    },
    methods: {
      'encodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMethodCodec>(target, 'StandardMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeMethodCall');
        final methodCall = D4.getRequiredArg<$flutter_26.MethodCall>(positional, 0, 'methodCall', 'encodeMethodCall');
        return t.encodeMethodCall(methodCall);
      },
      'decodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMethodCodec>(target, 'StandardMethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeMethodCall');
        final methodCall = D4.getRequiredArg<ByteData?>(positional, 0, 'methodCall', 'decodeMethodCall');
        return t.decodeMethodCall(methodCall);
      },
      'encodeSuccessEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMethodCodec>(target, 'StandardMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeSuccessEnvelope');
        final result = D4.getRequiredArg<Object?>(positional, 0, 'result', 'encodeSuccessEnvelope');
        return t.encodeSuccessEnvelope(result);
      },
      'encodeErrorEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMethodCodec>(target, 'StandardMethodCodec');
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'encodeErrorEnvelope');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final details = D4.getOptionalNamedArg<Object?>(named, 'details');
        return t.encodeErrorEnvelope(code: code, message: message, details: details);
      },
      'decodeEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.StandardMethodCodec>(target, 'StandardMethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeEnvelope');
        final envelope = D4.getRequiredArg<ByteData>(positional, 0, 'envelope', 'decodeEnvelope');
        return t.decodeEnvelope(envelope);
      },
    },
    constructorSignatures: {
      '': 'const StandardMethodCodec([StandardMessageCodec messageCodec = const StandardMessageCodec()])',
    },
    methodSignatures: {
      'encodeMethodCall': 'ByteData encodeMethodCall(MethodCall methodCall)',
      'decodeMethodCall': 'MethodCall decodeMethodCall(ByteData? methodCall)',
      'encodeSuccessEnvelope': 'ByteData encodeSuccessEnvelope(Object? result)',
      'encodeErrorEnvelope': 'ByteData encodeErrorEnvelope({required String code, String? message, Object? details})',
      'decodeEnvelope': 'dynamic decodeEnvelope(ByteData envelope)',
    },
    getterSignatures: {
      'messageCodec': 'StandardMessageCodec get messageCodec',
    },
  );
}

// =============================================================================
// PointerEvent Bridge
// =============================================================================

BridgedClass _createPointerEventBridge() {
  return BridgedClass(
    nativeType: $flutter_5.PointerEvent,
    name: 'PointerEvent',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent');
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
        final t = D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.PointerEvent>(target, 'PointerEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    staticMethods: {
      'transformPosition': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transformPosition');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformPosition');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'transformPosition');
        return $flutter_5.PointerEvent.transformPosition(transform, position);
      },
      'transformDeltaViaPositions': (visitor, positional, named, typeArgs) {
        final untransformedEndPosition = D4.getRequiredNamedArg<Offset>(named, 'untransformedEndPosition', 'transformDeltaViaPositions');
        final transformedEndPosition = D4.getOptionalNamedArg<Offset?>(named, 'transformedEndPosition');
        final untransformedDelta = D4.getRequiredNamedArg<Offset>(named, 'untransformedDelta', 'transformDeltaViaPositions');
        final transform = D4.getRequiredNamedArg<$vector_math_1.Matrix4?>(named, 'transform', 'transformDeltaViaPositions');
        return $flutter_5.PointerEvent.transformDeltaViaPositions(untransformedEndPosition: untransformedEndPosition, transformedEndPosition: transformedEndPosition, untransformedDelta: untransformedDelta, transform: transform);
      },
      'removePerspectiveTransform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removePerspectiveTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'removePerspectiveTransform');
        return $flutter_5.PointerEvent.removePerspectiveTransform(transform);
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
// MouseCursorManager Bridge
// =============================================================================

BridgedClass _createMouseCursorManagerBridge() {
  return BridgedClass(
    nativeType: $flutter_28.MouseCursorManager,
    name: 'MouseCursorManager',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MouseCursorManager');
        final fallbackMouseCursor = D4.getRequiredArg<$flutter_28.MouseCursor>(positional, 0, 'fallbackMouseCursor', 'MouseCursorManager');
        return $flutter_28.MouseCursorManager(fallbackMouseCursor);
      },
    },
    getters: {
      'fallbackMouseCursor': (visitor, target) => D4.validateTarget<$flutter_28.MouseCursorManager>(target, 'MouseCursorManager').fallbackMouseCursor,
    },
    methods: {
      'debugDeviceActiveCursor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MouseCursorManager>(target, 'MouseCursorManager');
        D4.requireMinArgs(positional, 1, 'debugDeviceActiveCursor');
        final device = D4.getRequiredArg<int>(positional, 0, 'device', 'debugDeviceActiveCursor');
        return t.debugDeviceActiveCursor(device);
      },
      'handleDeviceCursorUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MouseCursorManager>(target, 'MouseCursorManager');
        D4.requireMinArgs(positional, 3, 'handleDeviceCursorUpdate');
        final device = D4.getRequiredArg<int>(positional, 0, 'device', 'handleDeviceCursorUpdate');
        final triggeringEvent = D4.getRequiredArg<$flutter_5.PointerEvent?>(positional, 1, 'triggeringEvent', 'handleDeviceCursorUpdate');
        final cursorCandidates = D4.getRequiredArg<Iterable<$flutter_28.MouseCursor>>(positional, 2, 'cursorCandidates', 'handleDeviceCursorUpdate');
        t.handleDeviceCursorUpdate(device, triggeringEvent, cursorCandidates);
        return null;
      },
    },
    constructorSignatures: {
      '': 'MouseCursorManager(MouseCursor fallbackMouseCursor)',
    },
    methodSignatures: {
      'debugDeviceActiveCursor': 'MouseCursor? debugDeviceActiveCursor(int device)',
      'handleDeviceCursorUpdate': 'void handleDeviceCursorUpdate(int device, PointerEvent? triggeringEvent, Iterable<MouseCursor> cursorCandidates)',
    },
    getterSignatures: {
      'fallbackMouseCursor': 'MouseCursor get fallbackMouseCursor',
    },
  );
}

// =============================================================================
// MouseCursorSession Bridge
// =============================================================================

BridgedClass _createMouseCursorSessionBridge() {
  return BridgedClass(
    nativeType: $flutter_28.MouseCursorSession,
    name: 'MouseCursorSession',
    constructors: {
    },
    getters: {
      'cursor': (visitor, target) => (D4.validateTarget<$flutter_28.MouseCursorSession>(target, 'MouseCursorSession') as dynamic).cursor,
      'device': (visitor, target) => D4.validateTarget<$flutter_28.MouseCursorSession>(target, 'MouseCursorSession').device,
    },
    getterSignatures: {
      'cursor': 'MouseCursor get cursor',
      'device': 'int get device',
    },
  );
}

// =============================================================================
// MouseCursor Bridge
// =============================================================================

BridgedClass _createMouseCursorBridge() {
  return BridgedClass(
    nativeType: $flutter_28.MouseCursor,
    name: 'MouseCursor',
    constructors: {
    },
    getters: {
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_28.MouseCursor>(target, 'MouseCursor').debugDescription,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MouseCursor>(target, 'MouseCursor');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MouseCursor>(target, 'MouseCursor');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MouseCursor>(target, 'MouseCursor');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    staticGetters: {
      'defer': (visitor) => $flutter_28.MouseCursor.defer,
      'uncontrolled': (visitor) => $flutter_28.MouseCursor.uncontrolled,
    },
    methodSignatures: {
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'debugDescription': 'String get debugDescription',
    },
    staticGetterSignatures: {
      'defer': 'MouseCursor get defer',
      'uncontrolled': 'MouseCursor get uncontrolled',
    },
  );
}

// =============================================================================
// SystemMouseCursor Bridge
// =============================================================================

BridgedClass _createSystemMouseCursorBridge() {
  return BridgedClass(
    nativeType: $flutter_28.SystemMouseCursor,
    name: 'SystemMouseCursor',
    constructors: {
    },
    getters: {
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_28.SystemMouseCursor>(target, 'SystemMouseCursor').debugDescription,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.SystemMouseCursor>(target, 'SystemMouseCursor').kind,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_28.SystemMouseCursor>(target, 'SystemMouseCursor').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.SystemMouseCursor>(target, 'SystemMouseCursor');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.SystemMouseCursor>(target, 'SystemMouseCursor');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.SystemMouseCursor>(target, 'SystemMouseCursor');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.SystemMouseCursor>(target, 'SystemMouseCursor');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'debugDescription': 'String get debugDescription',
      'kind': 'String get kind',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// SystemMouseCursors Bridge
// =============================================================================

BridgedClass _createSystemMouseCursorsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.SystemMouseCursors,
    name: 'SystemMouseCursors',
    constructors: {
    },
    staticGetters: {
      'none': (visitor) => $flutter_28.SystemMouseCursors.none,
      'basic': (visitor) => $flutter_28.SystemMouseCursors.basic,
      'click': (visitor) => $flutter_28.SystemMouseCursors.click,
      'forbidden': (visitor) => $flutter_28.SystemMouseCursors.forbidden,
      'wait': (visitor) => $flutter_28.SystemMouseCursors.wait,
      'progress': (visitor) => $flutter_28.SystemMouseCursors.progress,
      'contextMenu': (visitor) => $flutter_28.SystemMouseCursors.contextMenu,
      'help': (visitor) => $flutter_28.SystemMouseCursors.help,
      'text': (visitor) => $flutter_28.SystemMouseCursors.text,
      'verticalText': (visitor) => $flutter_28.SystemMouseCursors.verticalText,
      'cell': (visitor) => $flutter_28.SystemMouseCursors.cell,
      'precise': (visitor) => $flutter_28.SystemMouseCursors.precise,
      'move': (visitor) => $flutter_28.SystemMouseCursors.move,
      'grab': (visitor) => $flutter_28.SystemMouseCursors.grab,
      'grabbing': (visitor) => $flutter_28.SystemMouseCursors.grabbing,
      'noDrop': (visitor) => $flutter_28.SystemMouseCursors.noDrop,
      'alias': (visitor) => $flutter_28.SystemMouseCursors.alias,
      'copy': (visitor) => $flutter_28.SystemMouseCursors.copy,
      'disappearing': (visitor) => $flutter_28.SystemMouseCursors.disappearing,
      'allScroll': (visitor) => $flutter_28.SystemMouseCursors.allScroll,
      'resizeLeftRight': (visitor) => $flutter_28.SystemMouseCursors.resizeLeftRight,
      'resizeUpDown': (visitor) => $flutter_28.SystemMouseCursors.resizeUpDown,
      'resizeUpLeftDownRight': (visitor) => $flutter_28.SystemMouseCursors.resizeUpLeftDownRight,
      'resizeUpRightDownLeft': (visitor) => $flutter_28.SystemMouseCursors.resizeUpRightDownLeft,
      'resizeUp': (visitor) => $flutter_28.SystemMouseCursors.resizeUp,
      'resizeDown': (visitor) => $flutter_28.SystemMouseCursors.resizeDown,
      'resizeLeft': (visitor) => $flutter_28.SystemMouseCursors.resizeLeft,
      'resizeRight': (visitor) => $flutter_28.SystemMouseCursors.resizeRight,
      'resizeUpLeft': (visitor) => $flutter_28.SystemMouseCursors.resizeUpLeft,
      'resizeUpRight': (visitor) => $flutter_28.SystemMouseCursors.resizeUpRight,
      'resizeDownLeft': (visitor) => $flutter_28.SystemMouseCursors.resizeDownLeft,
      'resizeDownRight': (visitor) => $flutter_28.SystemMouseCursors.resizeDownRight,
      'resizeColumn': (visitor) => $flutter_28.SystemMouseCursors.resizeColumn,
      'resizeRow': (visitor) => $flutter_28.SystemMouseCursors.resizeRow,
      'zoomIn': (visitor) => $flutter_28.SystemMouseCursors.zoomIn,
      'zoomOut': (visitor) => $flutter_28.SystemMouseCursors.zoomOut,
    },
    staticGetterSignatures: {
      'none': 'SystemMouseCursor get none',
      'basic': 'SystemMouseCursor get basic',
      'click': 'SystemMouseCursor get click',
      'forbidden': 'SystemMouseCursor get forbidden',
      'wait': 'SystemMouseCursor get wait',
      'progress': 'SystemMouseCursor get progress',
      'contextMenu': 'SystemMouseCursor get contextMenu',
      'help': 'SystemMouseCursor get help',
      'text': 'SystemMouseCursor get text',
      'verticalText': 'SystemMouseCursor get verticalText',
      'cell': 'SystemMouseCursor get cell',
      'precise': 'SystemMouseCursor get precise',
      'move': 'SystemMouseCursor get move',
      'grab': 'SystemMouseCursor get grab',
      'grabbing': 'SystemMouseCursor get grabbing',
      'noDrop': 'SystemMouseCursor get noDrop',
      'alias': 'SystemMouseCursor get alias',
      'copy': 'SystemMouseCursor get copy',
      'disappearing': 'SystemMouseCursor get disappearing',
      'allScroll': 'SystemMouseCursor get allScroll',
      'resizeLeftRight': 'SystemMouseCursor get resizeLeftRight',
      'resizeUpDown': 'SystemMouseCursor get resizeUpDown',
      'resizeUpLeftDownRight': 'SystemMouseCursor get resizeUpLeftDownRight',
      'resizeUpRightDownLeft': 'SystemMouseCursor get resizeUpRightDownLeft',
      'resizeUp': 'SystemMouseCursor get resizeUp',
      'resizeDown': 'SystemMouseCursor get resizeDown',
      'resizeLeft': 'SystemMouseCursor get resizeLeft',
      'resizeRight': 'SystemMouseCursor get resizeRight',
      'resizeUpLeft': 'SystemMouseCursor get resizeUpLeft',
      'resizeUpRight': 'SystemMouseCursor get resizeUpRight',
      'resizeDownLeft': 'SystemMouseCursor get resizeDownLeft',
      'resizeDownRight': 'SystemMouseCursor get resizeDownRight',
      'resizeColumn': 'SystemMouseCursor get resizeColumn',
      'resizeRow': 'SystemMouseCursor get resizeRow',
      'zoomIn': 'SystemMouseCursor get zoomIn',
      'zoomOut': 'SystemMouseCursor get zoomOut',
    },
  );
}

// =============================================================================
// MouseTrackerAnnotation Bridge
// =============================================================================

BridgedClass _createMouseTrackerAnnotationBridge() {
  return BridgedClass(
    nativeType: $flutter_29.MouseTrackerAnnotation,
    name: 'MouseTrackerAnnotation',
    constructors: {
      '': (visitor, positional, named) {
        final onEnterRaw = named['onEnter'];
        final onExitRaw = named['onExit'];
        final cursor = D4.getNamedArgWithDefault<$flutter_28.MouseCursor>(named, 'cursor', $flutter_28.MouseCursor.defer);
        final validForMouseTracker = D4.getNamedArgWithDefault<bool>(named, 'validForMouseTracker', true);
        return $flutter_29.MouseTrackerAnnotation(onEnter: onEnterRaw == null ? null : ($flutter_5.PointerEnterEvent p0) { D4.callInterpreterCallback(visitor, onEnterRaw, [p0]); }, onExit: onExitRaw == null ? null : ($flutter_5.PointerExitEvent p0) { D4.callInterpreterCallback(visitor, onExitRaw, [p0]); }, cursor: cursor, validForMouseTracker: validForMouseTracker);
      },
    },
    getters: {
      'onEnter': (visitor, target) => D4.validateTarget<$flutter_29.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation').onEnter,
      'onExit': (visitor, target) => D4.validateTarget<$flutter_29.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation').onExit,
      'cursor': (visitor, target) => (D4.validateTarget<$flutter_29.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation') as dynamic).cursor,
      'validForMouseTracker': (visitor, target) => D4.validateTarget<$flutter_29.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation').validForMouseTracker,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const MouseTrackerAnnotation({void Function(PointerEnterEvent)? onEnter, void Function(PointerExitEvent)? onExit, MouseCursor cursor = MouseCursor.defer, bool validForMouseTracker = true})',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'onEnter': 'PointerEnterEventListener? get onEnter',
      'onExit': 'PointerExitEventListener? get onExit',
      'cursor': 'MouseCursor get cursor',
      'validForMouseTracker': 'bool get validForMouseTracker',
    },
  );
}

// =============================================================================
// BasicMessageChannel Bridge
// =============================================================================

BridgedClass _createBasicMessageChannelBridge() {
  return BridgedClass(
    nativeType: $flutter_30.BasicMessageChannel,
    name: 'BasicMessageChannel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'BasicMessageChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'BasicMessageChannel');
        final codec = D4.getRequiredArg<$flutter_26.MessageCodec<dynamic>>(positional, 1, 'codec', 'BasicMessageChannel');
        final binaryMessenger = D4.getOptionalNamedArg<$flutter_11.BinaryMessenger?>(named, 'binaryMessenger');
        return $flutter_30.BasicMessageChannel(name, codec, binaryMessenger: binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_30.BasicMessageChannel>(target, 'BasicMessageChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_30.BasicMessageChannel>(target, 'BasicMessageChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_30.BasicMessageChannel>(target, 'BasicMessageChannel').binaryMessenger,
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.BasicMessageChannel>(target, 'BasicMessageChannel');
        D4.requireMinArgs(positional, 1, 'send');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'send');
        return t.send(message);
      },
      'setMessageHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.BasicMessageChannel>(target, 'BasicMessageChannel');
        D4.requireMinArgs(positional, 1, 'setMessageHandler');
        if (positional.isEmpty) {
          throw ArgumentError('setMessageHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.setMessageHandler(handlerRaw == null ? null : (dynamic p0) { return D4.callInterpreterCallback(visitor, handlerRaw, [p0]) as Future<dynamic>; });
        return null;
      },
    },
    constructorSignatures: {
      '': 'const BasicMessageChannel(String name, MessageCodec<T> codec, {BinaryMessenger? binaryMessenger})',
    },
    methodSignatures: {
      'send': 'Future<T?> send(T message)',
      'setMessageHandler': 'void setMessageHandler(Future<T> Function(T? message)? handler)',
    },
    getterSignatures: {
      'name': 'String get name',
      'codec': 'MessageCodec<T> get codec',
      'binaryMessenger': 'BinaryMessenger get binaryMessenger',
    },
  );
}

// =============================================================================
// MethodChannel Bridge
// =============================================================================

BridgedClass _createMethodChannelBridge() {
  return BridgedClass(
    nativeType: $flutter_30.MethodChannel,
    name: 'MethodChannel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MethodChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MethodChannel');
        final codec = D4.getOptionalArgWithDefault<$flutter_26.MethodCodec>(positional, 1, 'codec', const $flutter_27.StandardMethodCodec());
        final binaryMessenger = D4.getOptionalArg<$flutter_11.BinaryMessenger?>(positional, 2, 'binaryMessenger');
        return $flutter_30.MethodChannel(name, codec, binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_30.MethodChannel>(target, 'MethodChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_30.MethodChannel>(target, 'MethodChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_30.MethodChannel>(target, 'MethodChannel').binaryMessenger,
    },
    methods: {
      'invokeMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMethod(method, arguments);
      },
      'invokeListMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeListMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeListMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeListMethod(method, arguments);
      },
      'invokeMapMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMapMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMapMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMapMethod(method, arguments);
      },
      'setMethodCallHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'setMethodCallHandler');
        if (positional.isEmpty) {
          throw ArgumentError('setMethodCallHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.setMethodCallHandler(handlerRaw == null ? null : ($flutter_26.MethodCall p0) { return D4.callInterpreterCallback(visitor, handlerRaw, [p0]) as Future<dynamic>; });
        return null;
      },
    },
    constructorSignatures: {
      '': 'const MethodChannel(String name, [MethodCodec codec = const StandardMethodCodec(), BinaryMessenger? binaryMessenger])',
    },
    methodSignatures: {
      'invokeMethod': 'Future<T?> invokeMethod(String method, [dynamic arguments])',
      'invokeListMethod': 'Future<List<T>?> invokeListMethod(String method, [dynamic arguments])',
      'invokeMapMethod': 'Future<Map<K, V>?> invokeMapMethod(String method, [dynamic arguments])',
      'setMethodCallHandler': 'void setMethodCallHandler(Future<dynamic> Function(MethodCall call)? handler)',
    },
    getterSignatures: {
      'name': 'String get name',
      'codec': 'MethodCodec get codec',
      'binaryMessenger': 'BinaryMessenger get binaryMessenger',
    },
  );
}

// =============================================================================
// OptionalMethodChannel Bridge
// =============================================================================

BridgedClass _createOptionalMethodChannelBridge() {
  return BridgedClass(
    nativeType: $flutter_30.OptionalMethodChannel,
    name: 'OptionalMethodChannel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OptionalMethodChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'OptionalMethodChannel');
        final codec = D4.getOptionalArgWithDefault<$flutter_26.MethodCodec>(positional, 1, 'codec', const $flutter_27.StandardMethodCodec());
        final binaryMessenger = D4.getOptionalArg<$flutter_11.BinaryMessenger?>(positional, 2, 'binaryMessenger');
        return $flutter_30.OptionalMethodChannel(name, codec, binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_30.OptionalMethodChannel>(target, 'OptionalMethodChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_30.OptionalMethodChannel>(target, 'OptionalMethodChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_30.OptionalMethodChannel>(target, 'OptionalMethodChannel').binaryMessenger,
    },
    methods: {
      'invokeMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMethod(method, arguments);
      },
      'invokeListMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeListMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeListMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeListMethod(method, arguments);
      },
      'invokeMapMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMapMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMapMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMapMethod(method, arguments);
      },
      'setMethodCallHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'setMethodCallHandler');
        if (positional.isEmpty) {
          throw ArgumentError('setMethodCallHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.setMethodCallHandler(handlerRaw == null ? null : ($flutter_26.MethodCall p0) { return D4.callInterpreterCallback(visitor, handlerRaw, [p0]) as Future<dynamic>; });
        return null;
      },
    },
    constructorSignatures: {
      '': 'const OptionalMethodChannel(String name, [MethodCodec codec = const StandardMethodCodec(), BinaryMessenger? binaryMessenger])',
    },
    methodSignatures: {
      'invokeMethod': 'Future<T?> invokeMethod(String method, [dynamic arguments])',
      'invokeListMethod': 'Future<List<T>?> invokeListMethod(String method, [dynamic arguments])',
      'invokeMapMethod': 'Future<Map<K, V>?> invokeMapMethod(String method, [dynamic arguments])',
      'setMethodCallHandler': 'void setMethodCallHandler(Future<dynamic> Function(MethodCall)? handler)',
    },
    getterSignatures: {
      'name': 'String get name',
      'codec': 'MethodCodec get codec',
      'binaryMessenger': 'BinaryMessenger get binaryMessenger',
    },
  );
}

// =============================================================================
// EventChannel Bridge
// =============================================================================

BridgedClass _createEventChannelBridge() {
  return BridgedClass(
    nativeType: $flutter_30.EventChannel,
    name: 'EventChannel',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EventChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'EventChannel');
        final codec = D4.getOptionalArgWithDefault<$flutter_26.MethodCodec>(positional, 1, 'codec', const $flutter_27.StandardMethodCodec());
        final binaryMessenger = D4.getOptionalArg<$flutter_11.BinaryMessenger?>(positional, 2, 'binaryMessenger');
        return $flutter_30.EventChannel(name, codec, binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_30.EventChannel>(target, 'EventChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_30.EventChannel>(target, 'EventChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_30.EventChannel>(target, 'EventChannel').binaryMessenger,
    },
    methods: {
      'receiveBroadcastStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.EventChannel>(target, 'EventChannel');
        final arguments = D4.getOptionalArg<dynamic>(positional, 0, 'arguments');
        return t.receiveBroadcastStream(arguments);
      },
    },
    constructorSignatures: {
      '': 'const EventChannel(String name, [MethodCodec codec = const StandardMethodCodec(), BinaryMessenger? binaryMessenger])',
    },
    methodSignatures: {
      'receiveBroadcastStream': 'Stream<dynamic> receiveBroadcastStream([dynamic arguments])',
    },
    getterSignatures: {
      'name': 'String get name',
      'codec': 'MethodCodec get codec',
      'binaryMessenger': 'BinaryMessenger get binaryMessenger',
    },
  );
}

// =============================================================================
// PlatformViewsRegistry Bridge
// =============================================================================

BridgedClass _createPlatformViewsRegistryBridge() {
  return BridgedClass(
    nativeType: $flutter_31.PlatformViewsRegistry,
    name: 'PlatformViewsRegistry',
    constructors: {
    },
    methods: {
      'getNextPlatformViewId': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.PlatformViewsRegistry>(target, 'PlatformViewsRegistry');
        return t.getNextPlatformViewId();
      },
    },
    methodSignatures: {
      'getNextPlatformViewId': 'int getNextPlatformViewId()',
    },
  );
}

// =============================================================================
// PlatformViewsService Bridge
// =============================================================================

BridgedClass _createPlatformViewsServiceBridge() {
  return BridgedClass(
    nativeType: $flutter_31.PlatformViewsService,
    name: 'PlatformViewsService',
    constructors: {
    },
    staticMethods: {
      'initAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_26.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onFocusRaw, []); };
        return $flutter_31.PlatformViewsService.initAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initSurfaceAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initSurfaceAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initSurfaceAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initSurfaceAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initSurfaceAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_26.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onFocusRaw, []); };
        return $flutter_31.PlatformViewsService.initSurfaceAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initExpensiveAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initExpensiveAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initExpensiveAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initExpensiveAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initExpensiveAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_26.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onFocusRaw, []); };
        return $flutter_31.PlatformViewsService.initExpensiveAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initHybridAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initHybridAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initHybridAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initHybridAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initHybridAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_26.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onFocusRaw, []); };
        return $flutter_31.PlatformViewsService.initHybridAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initUiKitView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initUiKitView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initUiKitView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initUiKitView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initUiKitView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_26.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onFocusRaw, []); };
        return $flutter_31.PlatformViewsService.initUiKitView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initAppKitView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initAppKitView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initAppKitView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initAppKitView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initAppKitView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_26.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor, onFocusRaw, []); };
        return $flutter_31.PlatformViewsService.initAppKitView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
    },
    staticMethodSignatures: {
      'initAndroidView': 'AndroidViewController initAndroidView({required int id, required String viewType, required TextDirection layoutDirection, dynamic creationParams, MessageCodec<dynamic>? creationParamsCodec, VoidCallback? onFocus})',
      'initSurfaceAndroidView': 'SurfaceAndroidViewController initSurfaceAndroidView({required int id, required String viewType, required TextDirection layoutDirection, dynamic creationParams, MessageCodec<dynamic>? creationParamsCodec, VoidCallback? onFocus})',
      'initExpensiveAndroidView': 'ExpensiveAndroidViewController initExpensiveAndroidView({required int id, required String viewType, required TextDirection layoutDirection, dynamic creationParams, MessageCodec<dynamic>? creationParamsCodec, VoidCallback? onFocus})',
      'initHybridAndroidView': 'HybridAndroidViewController initHybridAndroidView({required int id, required String viewType, required TextDirection layoutDirection, dynamic creationParams, MessageCodec<dynamic>? creationParamsCodec, VoidCallback? onFocus})',
      'initUiKitView': 'Future<UiKitViewController> initUiKitView({required int id, required String viewType, required TextDirection layoutDirection, dynamic creationParams, MessageCodec<dynamic>? creationParamsCodec, VoidCallback? onFocus})',
      'initAppKitView': 'Future<AppKitViewController> initAppKitView({required int id, required String viewType, required TextDirection layoutDirection, dynamic creationParams, MessageCodec<dynamic>? creationParamsCodec, VoidCallback? onFocus})',
    },
  );
}

// =============================================================================
// AndroidPointerProperties Bridge
// =============================================================================

BridgedClass _createAndroidPointerPropertiesBridge() {
  return BridgedClass(
    nativeType: $flutter_31.AndroidPointerProperties,
    name: 'AndroidPointerProperties',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'AndroidPointerProperties');
        final toolType = D4.getRequiredNamedArg<int>(named, 'toolType', 'AndroidPointerProperties');
        return $flutter_31.AndroidPointerProperties(id: id, toolType: toolType);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerProperties>(target, 'AndroidPointerProperties').id,
      'toolType': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerProperties>(target, 'AndroidPointerProperties').toolType,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidPointerProperties>(target, 'AndroidPointerProperties');
        return t.toString();
      },
    },
    staticGetters: {
      'kToolTypeUnknown': (visitor) => $flutter_31.AndroidPointerProperties.kToolTypeUnknown,
      'kToolTypeFinger': (visitor) => $flutter_31.AndroidPointerProperties.kToolTypeFinger,
      'kToolTypeStylus': (visitor) => $flutter_31.AndroidPointerProperties.kToolTypeStylus,
      'kToolTypeMouse': (visitor) => $flutter_31.AndroidPointerProperties.kToolTypeMouse,
      'kToolTypeEraser': (visitor) => $flutter_31.AndroidPointerProperties.kToolTypeEraser,
    },
    constructorSignatures: {
      '': 'const AndroidPointerProperties({required int id, required int toolType})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'int get id',
      'toolType': 'int get toolType',
    },
    staticGetterSignatures: {
      'kToolTypeUnknown': 'int get kToolTypeUnknown',
      'kToolTypeFinger': 'int get kToolTypeFinger',
      'kToolTypeStylus': 'int get kToolTypeStylus',
      'kToolTypeMouse': 'int get kToolTypeMouse',
      'kToolTypeEraser': 'int get kToolTypeEraser',
    },
  );
}

// =============================================================================
// AndroidPointerCoords Bridge
// =============================================================================

BridgedClass _createAndroidPointerCoordsBridge() {
  return BridgedClass(
    nativeType: $flutter_31.AndroidPointerCoords,
    name: 'AndroidPointerCoords',
    constructors: {
      '': (visitor, positional, named) {
        final orientation = D4.getRequiredNamedArg<double>(named, 'orientation', 'AndroidPointerCoords');
        final pressure = D4.getRequiredNamedArg<double>(named, 'pressure', 'AndroidPointerCoords');
        final size = D4.getRequiredNamedArg<double>(named, 'size', 'AndroidPointerCoords');
        final toolMajor = D4.getRequiredNamedArg<double>(named, 'toolMajor', 'AndroidPointerCoords');
        final toolMinor = D4.getRequiredNamedArg<double>(named, 'toolMinor', 'AndroidPointerCoords');
        final touchMajor = D4.getRequiredNamedArg<double>(named, 'touchMajor', 'AndroidPointerCoords');
        final touchMinor = D4.getRequiredNamedArg<double>(named, 'touchMinor', 'AndroidPointerCoords');
        final x = D4.getRequiredNamedArg<double>(named, 'x', 'AndroidPointerCoords');
        final y = D4.getRequiredNamedArg<double>(named, 'y', 'AndroidPointerCoords');
        return $flutter_31.AndroidPointerCoords(orientation: orientation, pressure: pressure, size: size, toolMajor: toolMajor, toolMinor: toolMinor, touchMajor: touchMajor, touchMinor: touchMinor, x: x, y: y);
      },
    },
    getters: {
      'orientation': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').orientation,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').pressure,
      'size': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').size,
      'toolMajor': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').toolMajor,
      'toolMinor': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').toolMinor,
      'touchMajor': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').touchMajor,
      'touchMinor': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').touchMinor,
      'x': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords').y,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidPointerCoords>(target, 'AndroidPointerCoords');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const AndroidPointerCoords({required double orientation, required double pressure, required double size, required double toolMajor, required double toolMinor, required double touchMajor, required double touchMinor, required double x, required double y})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'orientation': 'double get orientation',
      'pressure': 'double get pressure',
      'size': 'double get size',
      'toolMajor': 'double get toolMajor',
      'toolMinor': 'double get toolMinor',
      'touchMajor': 'double get touchMajor',
      'touchMinor': 'double get touchMinor',
      'x': 'double get x',
      'y': 'double get y',
    },
  );
}

// =============================================================================
// AndroidMotionEvent Bridge
// =============================================================================

BridgedClass _createAndroidMotionEventBridge() {
  return BridgedClass(
    nativeType: $flutter_31.AndroidMotionEvent,
    name: 'AndroidMotionEvent',
    constructors: {
      '': (visitor, positional, named) {
        final downTime = D4.getRequiredNamedArg<int>(named, 'downTime', 'AndroidMotionEvent');
        final eventTime = D4.getRequiredNamedArg<int>(named, 'eventTime', 'AndroidMotionEvent');
        final action = D4.getRequiredNamedArg<int>(named, 'action', 'AndroidMotionEvent');
        final pointerCount = D4.getRequiredNamedArg<int>(named, 'pointerCount', 'AndroidMotionEvent');
        if (!named.containsKey('pointerProperties') || named['pointerProperties'] == null) {
          throw ArgumentError('AndroidMotionEvent: Missing required named argument "pointerProperties"');
        }
        final pointerProperties = D4.coerceList<$flutter_31.AndroidPointerProperties>(named['pointerProperties'], 'pointerProperties');
        if (!named.containsKey('pointerCoords') || named['pointerCoords'] == null) {
          throw ArgumentError('AndroidMotionEvent: Missing required named argument "pointerCoords"');
        }
        final pointerCoords = D4.coerceList<$flutter_31.AndroidPointerCoords>(named['pointerCoords'], 'pointerCoords');
        final metaState = D4.getRequiredNamedArg<int>(named, 'metaState', 'AndroidMotionEvent');
        final buttonState = D4.getRequiredNamedArg<int>(named, 'buttonState', 'AndroidMotionEvent');
        final xPrecision = D4.getRequiredNamedArg<double>(named, 'xPrecision', 'AndroidMotionEvent');
        final yPrecision = D4.getRequiredNamedArg<double>(named, 'yPrecision', 'AndroidMotionEvent');
        final deviceId = D4.getRequiredNamedArg<int>(named, 'deviceId', 'AndroidMotionEvent');
        final edgeFlags = D4.getRequiredNamedArg<int>(named, 'edgeFlags', 'AndroidMotionEvent');
        final source = D4.getRequiredNamedArg<int>(named, 'source', 'AndroidMotionEvent');
        final flags = D4.getRequiredNamedArg<int>(named, 'flags', 'AndroidMotionEvent');
        final motionEventId = D4.getRequiredNamedArg<int>(named, 'motionEventId', 'AndroidMotionEvent');
        return $flutter_31.AndroidMotionEvent(downTime: downTime, eventTime: eventTime, action: action, pointerCount: pointerCount, pointerProperties: pointerProperties, pointerCoords: pointerCoords, metaState: metaState, buttonState: buttonState, xPrecision: xPrecision, yPrecision: yPrecision, deviceId: deviceId, edgeFlags: edgeFlags, source: source, flags: flags, motionEventId: motionEventId);
      },
    },
    getters: {
      'downTime': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').downTime,
      'eventTime': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').eventTime,
      'action': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').action,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').pointerCount,
      'pointerProperties': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').pointerProperties,
      'pointerCoords': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').pointerCoords,
      'metaState': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').metaState,
      'buttonState': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').buttonState,
      'xPrecision': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').xPrecision,
      'yPrecision': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').yPrecision,
      'deviceId': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').deviceId,
      'edgeFlags': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').edgeFlags,
      'source': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').source,
      'flags': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').flags,
      'motionEventId': (visitor, target) => D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent').motionEventId,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidMotionEvent>(target, 'AndroidMotionEvent');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'AndroidMotionEvent({required int downTime, required int eventTime, required int action, required int pointerCount, required List<AndroidPointerProperties> pointerProperties, required List<AndroidPointerCoords> pointerCoords, required int metaState, required int buttonState, required double xPrecision, required double yPrecision, required int deviceId, required int edgeFlags, required int source, required int flags, required int motionEventId})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'downTime': 'int get downTime',
      'eventTime': 'int get eventTime',
      'action': 'int get action',
      'pointerCount': 'int get pointerCount',
      'pointerProperties': 'List<AndroidPointerProperties> get pointerProperties',
      'pointerCoords': 'List<AndroidPointerCoords> get pointerCoords',
      'metaState': 'int get metaState',
      'buttonState': 'int get buttonState',
      'xPrecision': 'double get xPrecision',
      'yPrecision': 'double get yPrecision',
      'deviceId': 'int get deviceId',
      'edgeFlags': 'int get edgeFlags',
      'source': 'int get source',
      'flags': 'int get flags',
      'motionEventId': 'int get motionEventId',
    },
  );
}

// =============================================================================
// AndroidViewController Bridge
// =============================================================================

BridgedClass _createAndroidViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.AndroidViewController,
    name: 'AndroidViewController',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) => 
        D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController').pointTransformer = value as dynamic,
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_5.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_31.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
    },
    staticGetters: {
      'kActionDown': (visitor) => $flutter_31.AndroidViewController.kActionDown,
      'kActionUp': (visitor) => $flutter_31.AndroidViewController.kActionUp,
      'kActionMove': (visitor) => $flutter_31.AndroidViewController.kActionMove,
      'kActionCancel': (visitor) => $flutter_31.AndroidViewController.kActionCancel,
      'kActionPointerDown': (visitor) => $flutter_31.AndroidViewController.kActionPointerDown,
      'kActionPointerUp': (visitor) => $flutter_31.AndroidViewController.kActionPointerUp,
      'kAndroidLayoutDirectionLtr': (visitor) => $flutter_31.AndroidViewController.kAndroidLayoutDirectionLtr,
      'kAndroidLayoutDirectionRtl': (visitor) => $flutter_31.AndroidViewController.kAndroidLayoutDirectionRtl,
      'kInputDeviceSourceUnknown': (visitor) => $flutter_31.AndroidViewController.kInputDeviceSourceUnknown,
      'kInputDeviceSourceTouchScreen': (visitor) => $flutter_31.AndroidViewController.kInputDeviceSourceTouchScreen,
      'kInputDeviceSourceMouse': (visitor) => $flutter_31.AndroidViewController.kInputDeviceSourceMouse,
      'kInputDeviceSourceStylus': (visitor) => $flutter_31.AndroidViewController.kInputDeviceSourceStylus,
      'kInputDeviceSourceTouchPad': (visitor) => $flutter_31.AndroidViewController.kInputDeviceSourceTouchPad,
    },
    staticMethods: {
      'pointerAction': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'pointerAction');
        final pointerId = D4.getRequiredArg<int>(positional, 0, 'pointerId', 'pointerAction');
        final action = D4.getRequiredArg<int>(positional, 1, 'action', 'pointerAction');
        return $flutter_31.AndroidViewController.pointerAction(pointerId, action);
      },
    },
    methodSignatures: {
      'dispatchPointerEvent': 'Future<void> dispatchPointerEvent(PointerEvent event)',
      'create': 'Future<void> create({Size? size, Offset? position})',
      'dispose': 'Future<void> dispose()',
      'clearFocus': 'Future<void> clearFocus()',
      'setSize': 'Future<Size> setSize(Size size)',
      'setOffset': 'Future<void> setOffset(Offset off)',
      'sendMotionEvent': 'Future<void> sendMotionEvent(AndroidMotionEvent event)',
      'addOnPlatformViewCreatedListener': 'void addOnPlatformViewCreatedListener(PlatformViewCreatedCallback listener)',
      'removeOnPlatformViewCreatedListener': 'void removeOnPlatformViewCreatedListener(PlatformViewCreatedCallback listener)',
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'awaitingCreation': 'bool get awaitingCreation',
      'textureId': 'int? get textureId',
      'requiresViewComposition': 'bool get requiresViewComposition',
      'pointTransformer': 'PointTransformer get pointTransformer',
      'isCreated': 'bool get isCreated',
    },
    setterSignatures: {
      'pointTransformer': 'set pointTransformer(PointTransformer value)',
    },
    staticMethodSignatures: {
      'pointerAction': 'int pointerAction(int pointerId, int action)',
    },
    staticGetterSignatures: {
      'kActionDown': 'int get kActionDown',
      'kActionUp': 'int get kActionUp',
      'kActionMove': 'int get kActionMove',
      'kActionCancel': 'int get kActionCancel',
      'kActionPointerDown': 'int get kActionPointerDown',
      'kActionPointerUp': 'int get kActionPointerUp',
      'kAndroidLayoutDirectionLtr': 'int get kAndroidLayoutDirectionLtr',
      'kAndroidLayoutDirectionRtl': 'int get kAndroidLayoutDirectionRtl',
      'kInputDeviceSourceUnknown': 'int get kInputDeviceSourceUnknown',
      'kInputDeviceSourceTouchScreen': 'int get kInputDeviceSourceTouchScreen',
      'kInputDeviceSourceMouse': 'int get kInputDeviceSourceMouse',
      'kInputDeviceSourceStylus': 'int get kInputDeviceSourceStylus',
      'kInputDeviceSourceTouchPad': 'int get kInputDeviceSourceTouchPad',
    },
  );
}

// =============================================================================
// SurfaceAndroidViewController Bridge
// =============================================================================

BridgedClass _createSurfaceAndroidViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.SurfaceAndroidViewController,
    name: 'SurfaceAndroidViewController',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) => 
        D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').pointTransformer = value as dynamic,
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_5.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_31.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
    },
    methodSignatures: {
      'dispatchPointerEvent': 'Future<void> dispatchPointerEvent(PointerEvent event)',
      'create': 'Future<void> create({Size? size, Offset? position})',
      'dispose': 'Future<void> dispose()',
      'clearFocus': 'Future<void> clearFocus()',
      'setSize': 'Future<Size> setSize(Size size)',
      'setOffset': 'Future<void> setOffset(Offset off)',
      'sendMotionEvent': 'Future<void> sendMotionEvent(AndroidMotionEvent event)',
      'addOnPlatformViewCreatedListener': 'void addOnPlatformViewCreatedListener(void Function(int) listener)',
      'removeOnPlatformViewCreatedListener': 'void removeOnPlatformViewCreatedListener(void Function(int) listener)',
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'awaitingCreation': 'bool get awaitingCreation',
      'textureId': 'int? get textureId',
      'requiresViewComposition': 'bool get requiresViewComposition',
      'pointTransformer': 'Offset Function(Offset) get pointTransformer',
      'isCreated': 'bool get isCreated',
    },
    setterSignatures: {
      'pointTransformer': 'set pointTransformer(PointTransformer value)',
    },
  );
}

// =============================================================================
// ExpensiveAndroidViewController Bridge
// =============================================================================

BridgedClass _createExpensiveAndroidViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.ExpensiveAndroidViewController,
    name: 'ExpensiveAndroidViewController',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) => 
        D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').pointTransformer = value as dynamic,
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_5.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_31.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
    },
    methodSignatures: {
      'dispatchPointerEvent': 'Future<void> dispatchPointerEvent(PointerEvent event)',
      'create': 'Future<void> create({Size? size, Offset? position})',
      'dispose': 'Future<void> dispose()',
      'clearFocus': 'Future<void> clearFocus()',
      'setSize': 'Future<Size> setSize(Size size)',
      'setOffset': 'Future<void> setOffset(Offset off)',
      'sendMotionEvent': 'Future<void> sendMotionEvent(AndroidMotionEvent event)',
      'addOnPlatformViewCreatedListener': 'void addOnPlatformViewCreatedListener(void Function(int) listener)',
      'removeOnPlatformViewCreatedListener': 'void removeOnPlatformViewCreatedListener(void Function(int) listener)',
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'awaitingCreation': 'bool get awaitingCreation',
      'textureId': 'int? get textureId',
      'requiresViewComposition': 'bool get requiresViewComposition',
      'pointTransformer': 'Offset Function(Offset) get pointTransformer',
      'isCreated': 'bool get isCreated',
    },
    setterSignatures: {
      'pointTransformer': 'set pointTransformer(PointTransformer value)',
    },
  );
}

// =============================================================================
// HybridAndroidViewController Bridge
// =============================================================================

BridgedClass _createHybridAndroidViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.HybridAndroidViewController,
    name: 'HybridAndroidViewController',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) => 
        D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController').pointTransformer = value as dynamic,
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_5.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_31.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
    },
    staticMethods: {
      'checkIfSupported': (visitor, positional, named, typeArgs) {
        return $flutter_31.HybridAndroidViewController.checkIfSupported();
      },
    },
    methodSignatures: {
      'dispatchPointerEvent': 'Future<void> dispatchPointerEvent(PointerEvent event)',
      'create': 'Future<void> create({Size? size, Offset? position})',
      'dispose': 'Future<void> dispose()',
      'clearFocus': 'Future<void> clearFocus()',
      'setSize': 'Future<Size> setSize(Size size)',
      'setOffset': 'Future<void> setOffset(Offset off)',
      'sendMotionEvent': 'Future<void> sendMotionEvent(AndroidMotionEvent event)',
      'addOnPlatformViewCreatedListener': 'void addOnPlatformViewCreatedListener(void Function(int) listener)',
      'removeOnPlatformViewCreatedListener': 'void removeOnPlatformViewCreatedListener(void Function(int) listener)',
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'awaitingCreation': 'bool get awaitingCreation',
      'textureId': 'int? get textureId',
      'requiresViewComposition': 'bool get requiresViewComposition',
      'pointTransformer': 'Offset Function(Offset) get pointTransformer',
      'isCreated': 'bool get isCreated',
    },
    setterSignatures: {
      'pointTransformer': 'set pointTransformer(PointTransformer value)',
    },
    staticMethodSignatures: {
      'checkIfSupported': 'Future<bool> checkIfSupported()',
    },
  );
}

// =============================================================================
// TextureAndroidViewController Bridge
// =============================================================================

BridgedClass _createTextureAndroidViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.TextureAndroidViewController,
    name: 'TextureAndroidViewController',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) => 
        D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController').pointTransformer = value as dynamic,
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_5.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_31.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
    },
    methodSignatures: {
      'dispatchPointerEvent': 'Future<void> dispatchPointerEvent(PointerEvent event)',
      'create': 'Future<void> create({Size? size, Offset? position})',
      'dispose': 'Future<void> dispose()',
      'clearFocus': 'Future<void> clearFocus()',
      'setSize': 'Future<Size> setSize(Size size)',
      'setOffset': 'Future<void> setOffset(Offset off)',
      'sendMotionEvent': 'Future<void> sendMotionEvent(AndroidMotionEvent event)',
      'addOnPlatformViewCreatedListener': 'void addOnPlatformViewCreatedListener(void Function(int) listener)',
      'removeOnPlatformViewCreatedListener': 'void removeOnPlatformViewCreatedListener(void Function(int) listener)',
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'awaitingCreation': 'bool get awaitingCreation',
      'textureId': 'int? get textureId',
      'requiresViewComposition': 'bool get requiresViewComposition',
      'pointTransformer': 'Offset Function(Offset) get pointTransformer',
      'isCreated': 'bool get isCreated',
    },
    setterSignatures: {
      'pointTransformer': 'set pointTransformer(PointTransformer value)',
    },
  );
}

// =============================================================================
// DarwinPlatformViewController Bridge
// =============================================================================

BridgedClass _createDarwinPlatformViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.DarwinPlatformViewController,
    name: 'DarwinPlatformViewController',
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_31.DarwinPlatformViewController>(target, 'DarwinPlatformViewController').id,
    },
    methods: {
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
        return t.acceptGesture();
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
        return t.rejectGesture();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
        return (t as dynamic).dispose();
      },
    },
    methodSignatures: {
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
      'acceptGesture': 'Future<void> acceptGesture()',
      'rejectGesture': 'Future<void> rejectGesture()',
      'dispose': 'Future<void> dispose()',
    },
    getterSignatures: {
      'id': 'int get id',
    },
  );
}

// =============================================================================
// UiKitViewController Bridge
// =============================================================================

BridgedClass _createUiKitViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.UiKitViewController,
    name: 'UiKitViewController',
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_31.UiKitViewController>(target, 'UiKitViewController').id,
    },
    methods: {
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.UiKitViewController>(target, 'UiKitViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.UiKitViewController>(target, 'UiKitViewController');
        return t.acceptGesture();
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.UiKitViewController>(target, 'UiKitViewController');
        return t.rejectGesture();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.UiKitViewController>(target, 'UiKitViewController');
        return (t as dynamic).dispose();
      },
    },
    methodSignatures: {
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
      'acceptGesture': 'Future<void> acceptGesture()',
      'rejectGesture': 'Future<void> rejectGesture()',
      'dispose': 'Future<void> dispose()',
    },
    getterSignatures: {
      'id': 'int get id',
    },
  );
}

// =============================================================================
// AppKitViewController Bridge
// =============================================================================

BridgedClass _createAppKitViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.AppKitViewController,
    name: 'AppKitViewController',
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_31.AppKitViewController>(target, 'AppKitViewController').id,
    },
    methods: {
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AppKitViewController>(target, 'AppKitViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AppKitViewController>(target, 'AppKitViewController');
        return t.acceptGesture();
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AppKitViewController>(target, 'AppKitViewController');
        return t.rejectGesture();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.AppKitViewController>(target, 'AppKitViewController');
        return (t as dynamic).dispose();
      },
    },
    methodSignatures: {
      'setLayoutDirection': 'Future<void> setLayoutDirection(TextDirection layoutDirection)',
      'acceptGesture': 'Future<void> acceptGesture()',
      'rejectGesture': 'Future<void> rejectGesture()',
      'dispose': 'Future<void> dispose()',
    },
    getterSignatures: {
      'id': 'int get id',
    },
  );
}

// =============================================================================
// PlatformViewController Bridge
// =============================================================================

BridgedClass _createPlatformViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.PlatformViewController,
    name: 'PlatformViewController',
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_31.PlatformViewController>(target, 'PlatformViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_31.PlatformViewController>(target, 'PlatformViewController').awaitingCreation,
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.PlatformViewController>(target, 'PlatformViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_5.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.PlatformViewController>(target, 'PlatformViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.PlatformViewController>(target, 'PlatformViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.PlatformViewController>(target, 'PlatformViewController');
        return t.clearFocus();
      },
    },
    methodSignatures: {
      'dispatchPointerEvent': 'Future<void> dispatchPointerEvent(PointerEvent event)',
      'create': 'Future<void> create({Size? size, Offset? position})',
      'dispose': 'Future<void> dispose()',
      'clearFocus': 'Future<void> clearFocus()',
    },
    getterSignatures: {
      'viewId': 'int get viewId',
      'awaitingCreation': 'bool get awaitingCreation',
    },
  );
}

// =============================================================================
// PredictiveBackEvent Bridge
// =============================================================================

BridgedClass _createPredictiveBackEventBridge() {
  return BridgedClass(
    nativeType: $flutter_32.PredictiveBackEvent,
    name: 'PredictiveBackEvent',
    constructors: {
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PredictiveBackEvent');
        if (positional.isEmpty) {
          throw ArgumentError('PredictiveBackEvent: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String?, Object?>(positional[0], 'map');
        return $flutter_32.PredictiveBackEvent.fromMap(map);
      },
    },
    getters: {
      'touchOffset': (visitor, target) => D4.validateTarget<$flutter_32.PredictiveBackEvent>(target, 'PredictiveBackEvent').touchOffset,
      'progress': (visitor, target) => D4.validateTarget<$flutter_32.PredictiveBackEvent>(target, 'PredictiveBackEvent').progress,
      'swipeEdge': (visitor, target) => D4.validateTarget<$flutter_32.PredictiveBackEvent>(target, 'PredictiveBackEvent').swipeEdge,
      'isButtonEvent': (visitor, target) => D4.validateTarget<$flutter_32.PredictiveBackEvent>(target, 'PredictiveBackEvent').isButtonEvent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_32.PredictiveBackEvent>(target, 'PredictiveBackEvent').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.PredictiveBackEvent>(target, 'PredictiveBackEvent');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.PredictiveBackEvent>(target, 'PredictiveBackEvent');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      'fromMap': 'factory PredictiveBackEvent.fromMap(Map<String?, Object?> map)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'touchOffset': 'Offset? get touchOffset',
      'progress': 'double get progress',
      'swipeEdge': 'SwipeEdge get swipeEdge',
      'isButtonEvent': 'bool get isButtonEvent',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ProcessTextAction Bridge
// =============================================================================

BridgedClass _createProcessTextActionBridge() {
  return BridgedClass(
    nativeType: $flutter_33.ProcessTextAction,
    name: 'ProcessTextAction',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ProcessTextAction');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'ProcessTextAction');
        final label = D4.getRequiredArg<String>(positional, 1, 'label', 'ProcessTextAction');
        return $flutter_33.ProcessTextAction(id, label);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_33.ProcessTextAction>(target, 'ProcessTextAction').id,
      'label': (visitor, target) => D4.validateTarget<$flutter_33.ProcessTextAction>(target, 'ProcessTextAction').label,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_33.ProcessTextAction>(target, 'ProcessTextAction').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ProcessTextAction>(target, 'ProcessTextAction');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const ProcessTextAction(String id, String label)',
    },
    getterSignatures: {
      'id': 'String get id',
      'label': 'String get label',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// ProcessTextService Bridge
// =============================================================================

BridgedClass _createProcessTextServiceBridge() {
  return BridgedClass(
    nativeType: $flutter_33.ProcessTextService,
    name: 'ProcessTextService',
    constructors: {
    },
    methods: {
      'queryTextActions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ProcessTextService>(target, 'ProcessTextService');
        return t.queryTextActions();
      },
      'processTextAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ProcessTextService>(target, 'ProcessTextService');
        D4.requireMinArgs(positional, 3, 'processTextAction');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'processTextAction');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'processTextAction');
        final readOnly = D4.getRequiredArg<bool>(positional, 2, 'readOnly', 'processTextAction');
        return t.processTextAction(id, text, readOnly);
      },
    },
    methodSignatures: {
      'queryTextActions': 'Future<List<ProcessTextAction>> queryTextActions()',
      'processTextAction': 'Future<String?> processTextAction(String id, String text, bool readOnly)',
    },
  );
}

// =============================================================================
// DefaultProcessTextService Bridge
// =============================================================================

BridgedClass _createDefaultProcessTextServiceBridge() {
  return BridgedClass(
    nativeType: $flutter_33.DefaultProcessTextService,
    name: 'DefaultProcessTextService',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_33.DefaultProcessTextService();
      },
    },
    methods: {
      'queryTextActions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.DefaultProcessTextService>(target, 'DefaultProcessTextService');
        return t.queryTextActions();
      },
      'processTextAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.DefaultProcessTextService>(target, 'DefaultProcessTextService');
        D4.requireMinArgs(positional, 3, 'processTextAction');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'processTextAction');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'processTextAction');
        final readOnly = D4.getRequiredArg<bool>(positional, 2, 'readOnly', 'processTextAction');
        return t.processTextAction(id, text, readOnly);
      },
    },
    constructorSignatures: {
      '': 'DefaultProcessTextService()',
    },
    methodSignatures: {
      'queryTextActions': 'Future<List<ProcessTextAction>> queryTextActions()',
      'processTextAction': 'Future<String?> processTextAction(String id, String text, bool readOnly)',
    },
  );
}

// =============================================================================
// Scribe Bridge
// =============================================================================

BridgedClass _createScribeBridge() {
  return BridgedClass(
    nativeType: $flutter_36.Scribe,
    name: 'Scribe',
    constructors: {
    },
    staticMethods: {
      'isFeatureAvailable': (visitor, positional, named, typeArgs) {
        return $flutter_36.Scribe.isFeatureAvailable();
      },
      'isStylusHandwritingAvailable': (visitor, positional, named, typeArgs) {
        return $flutter_36.Scribe.isStylusHandwritingAvailable();
      },
      'startStylusHandwriting': (visitor, positional, named, typeArgs) {
        return $flutter_36.Scribe.startStylusHandwriting();
      },
    },
    staticMethodSignatures: {
      'isFeatureAvailable': 'Future<bool> isFeatureAvailable()',
      'isStylusHandwritingAvailable': 'Future<bool> isStylusHandwritingAvailable()',
      'startStylusHandwriting': 'Future<void> startStylusHandwriting()',
    },
  );
}

// =============================================================================
// SensitiveContentService Bridge
// =============================================================================

BridgedClass _createSensitiveContentServiceBridge() {
  return BridgedClass(
    nativeType: $flutter_37.SensitiveContentService,
    name: 'SensitiveContentService',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_37.SensitiveContentService();
      },
    },
    getters: {
      'sensitiveContentChannel': (visitor, target) => D4.validateTarget<$flutter_37.SensitiveContentService>(target, 'SensitiveContentService').sensitiveContentChannel,
    },
    setters: {
      'sensitiveContentChannel': (visitor, target, value) => 
        D4.validateTarget<$flutter_37.SensitiveContentService>(target, 'SensitiveContentService').sensitiveContentChannel = value as $flutter_30.MethodChannel,
    },
    methods: {
      'setContentSensitivity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.SensitiveContentService>(target, 'SensitiveContentService');
        D4.requireMinArgs(positional, 1, 'setContentSensitivity');
        final contentSensitivity = D4.getRequiredArg<$flutter_37.ContentSensitivity>(positional, 0, 'contentSensitivity', 'setContentSensitivity');
        return t.setContentSensitivity(contentSensitivity);
      },
      'getContentSensitivity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.SensitiveContentService>(target, 'SensitiveContentService');
        return t.getContentSensitivity();
      },
      'isSupported': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.SensitiveContentService>(target, 'SensitiveContentService');
        return t.isSupported();
      },
    },
    constructorSignatures: {
      '': 'SensitiveContentService()',
    },
    methodSignatures: {
      'setContentSensitivity': 'Future<void> setContentSensitivity(ContentSensitivity contentSensitivity)',
      'getContentSensitivity': 'Future<ContentSensitivity> getContentSensitivity()',
      'isSupported': 'Future<bool> isSupported()',
    },
    getterSignatures: {
      'sensitiveContentChannel': 'MethodChannel get sensitiveContentChannel',
    },
    setterSignatures: {
      'sensitiveContentChannel': 'set sensitiveContentChannel(dynamic value)',
    },
  );
}

// =============================================================================
// SuggestionSpan Bridge
// =============================================================================

BridgedClass _createSuggestionSpanBridge() {
  return BridgedClass(
    nativeType: $flutter_39.SuggestionSpan,
    name: 'SuggestionSpan',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SuggestionSpan');
        final range = D4.getRequiredArg<TextRange>(positional, 0, 'range', 'SuggestionSpan');
        if (positional.length <= 1) {
          throw ArgumentError('SuggestionSpan: Missing required argument "suggestions" at position 1');
        }
        final suggestions = D4.coerceList<String>(positional[1], 'suggestions');
        return $flutter_39.SuggestionSpan(range, suggestions);
      },
    },
    getters: {
      'range': (visitor, target) => D4.validateTarget<$flutter_39.SuggestionSpan>(target, 'SuggestionSpan').range,
      'suggestions': (visitor, target) => D4.validateTarget<$flutter_39.SuggestionSpan>(target, 'SuggestionSpan').suggestions,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_39.SuggestionSpan>(target, 'SuggestionSpan').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SuggestionSpan>(target, 'SuggestionSpan');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SuggestionSpan>(target, 'SuggestionSpan');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const SuggestionSpan(TextRange range, List<String> suggestions)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'range': 'TextRange get range',
      'suggestions': 'List<String> get suggestions',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// SpellCheckResults Bridge
// =============================================================================

BridgedClass _createSpellCheckResultsBridge() {
  return BridgedClass(
    nativeType: $flutter_39.SpellCheckResults,
    name: 'SpellCheckResults',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SpellCheckResults');
        final spellCheckedText = D4.getRequiredArg<String>(positional, 0, 'spellCheckedText', 'SpellCheckResults');
        if (positional.length <= 1) {
          throw ArgumentError('SpellCheckResults: Missing required argument "suggestionSpans" at position 1');
        }
        final suggestionSpans = D4.coerceList<$flutter_39.SuggestionSpan>(positional[1], 'suggestionSpans');
        return $flutter_39.SpellCheckResults(spellCheckedText, suggestionSpans);
      },
    },
    getters: {
      'spellCheckedText': (visitor, target) => D4.validateTarget<$flutter_39.SpellCheckResults>(target, 'SpellCheckResults').spellCheckedText,
      'suggestionSpans': (visitor, target) => D4.validateTarget<$flutter_39.SpellCheckResults>(target, 'SpellCheckResults').suggestionSpans,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_39.SpellCheckResults>(target, 'SpellCheckResults').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SpellCheckResults>(target, 'SpellCheckResults');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SpellCheckResults>(target, 'SpellCheckResults');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const SpellCheckResults(String spellCheckedText, List<SuggestionSpan> suggestionSpans)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'spellCheckedText': 'String get spellCheckedText',
      'suggestionSpans': 'List<SuggestionSpan> get suggestionSpans',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// SpellCheckService Bridge
// =============================================================================

BridgedClass _createSpellCheckServiceBridge() {
  return BridgedClass(
    nativeType: $flutter_39.SpellCheckService,
    name: 'SpellCheckService',
    constructors: {
    },
    methods: {
      'fetchSpellCheckSuggestions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SpellCheckService>(target, 'SpellCheckService');
        D4.requireMinArgs(positional, 2, 'fetchSpellCheckSuggestions');
        final locale = D4.getRequiredArg<Locale>(positional, 0, 'locale', 'fetchSpellCheckSuggestions');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'fetchSpellCheckSuggestions');
        return t.fetchSpellCheckSuggestions(locale, text);
      },
    },
    methodSignatures: {
      'fetchSpellCheckSuggestions': 'Future<List<SuggestionSpan>?> fetchSpellCheckSuggestions(Locale locale, String text)',
    },
  );
}

// =============================================================================
// DefaultSpellCheckService Bridge
// =============================================================================

BridgedClass _createDefaultSpellCheckServiceBridge() {
  return BridgedClass(
    nativeType: $flutter_39.DefaultSpellCheckService,
    name: 'DefaultSpellCheckService',
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_39.DefaultSpellCheckService();
      },
    },
    getters: {
      'lastSavedResults': (visitor, target) => D4.validateTarget<$flutter_39.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').lastSavedResults,
      'spellCheckChannel': (visitor, target) => D4.validateTarget<$flutter_39.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').spellCheckChannel,
    },
    setters: {
      'lastSavedResults': (visitor, target, value) => 
        D4.validateTarget<$flutter_39.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').lastSavedResults = value as $flutter_39.SpellCheckResults?,
      'spellCheckChannel': (visitor, target, value) => 
        D4.validateTarget<$flutter_39.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').spellCheckChannel = value as $flutter_30.MethodChannel,
    },
    methods: {
      'fetchSpellCheckSuggestions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.DefaultSpellCheckService>(target, 'DefaultSpellCheckService');
        D4.requireMinArgs(positional, 2, 'fetchSpellCheckSuggestions');
        final locale = D4.getRequiredArg<Locale>(positional, 0, 'locale', 'fetchSpellCheckSuggestions');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'fetchSpellCheckSuggestions');
        return t.fetchSpellCheckSuggestions(locale, text);
      },
    },
    staticMethods: {
      'mergeResults': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mergeResults');
        if (positional.isEmpty) {
          throw ArgumentError('mergeResults: Missing required argument "oldResults" at position 0');
        }
        final oldResults = D4.coerceList<$flutter_39.SuggestionSpan>(positional[0], 'oldResults');
        if (positional.length <= 1) {
          throw ArgumentError('mergeResults: Missing required argument "newResults" at position 1');
        }
        final newResults = D4.coerceList<$flutter_39.SuggestionSpan>(positional[1], 'newResults');
        return $flutter_39.DefaultSpellCheckService.mergeResults(oldResults, newResults);
      },
    },
    constructorSignatures: {
      '': 'DefaultSpellCheckService()',
    },
    methodSignatures: {
      'fetchSpellCheckSuggestions': 'Future<List<SuggestionSpan>?> fetchSpellCheckSuggestions(Locale locale, String text)',
    },
    getterSignatures: {
      'lastSavedResults': 'SpellCheckResults? get lastSavedResults',
      'spellCheckChannel': 'MethodChannel get spellCheckChannel',
    },
    setterSignatures: {
      'lastSavedResults': 'set lastSavedResults(dynamic value)',
      'spellCheckChannel': 'set spellCheckChannel(dynamic value)',
    },
    staticMethodSignatures: {
      'mergeResults': 'List<SuggestionSpan> mergeResults(List<SuggestionSpan> oldResults, List<SuggestionSpan> newResults)',
    },
  );
}

// =============================================================================
// SystemChannels Bridge
// =============================================================================

BridgedClass _createSystemChannelsBridge() {
  return BridgedClass(
    nativeType: $flutter_40.SystemChannels,
    name: 'SystemChannels',
    constructors: {
    },
    staticGetters: {
      'navigation': (visitor) => $flutter_40.SystemChannels.navigation,
      'backGesture': (visitor) => $flutter_40.SystemChannels.backGesture,
      'platform': (visitor) => $flutter_40.SystemChannels.platform,
      'statusBar': (visitor) => $flutter_40.SystemChannels.statusBar,
      'processText': (visitor) => $flutter_40.SystemChannels.processText,
      'textInput': (visitor) => $flutter_40.SystemChannels.textInput,
      'scribe': (visitor) => $flutter_40.SystemChannels.scribe,
      'spellCheck': (visitor) => $flutter_40.SystemChannels.spellCheck,
      'undoManager': (visitor) => $flutter_40.SystemChannels.undoManager,
      'keyEvent': (visitor) => $flutter_40.SystemChannels.keyEvent,
      'lifecycle': (visitor) => $flutter_40.SystemChannels.lifecycle,
      'system': (visitor) => $flutter_40.SystemChannels.system,
      'accessibility': (visitor) => $flutter_40.SystemChannels.accessibility,
      'platform_views': (visitor) => $flutter_40.SystemChannels.platform_views,
      'platform_views_2': (visitor) => $flutter_40.SystemChannels.platform_views_2,
      'skia': (visitor) => $flutter_40.SystemChannels.skia,
      'mouseCursor': (visitor) => $flutter_40.SystemChannels.mouseCursor,
      'restoration': (visitor) => $flutter_40.SystemChannels.restoration,
      'deferredComponent': (visitor) => $flutter_40.SystemChannels.deferredComponent,
      'localization': (visitor) => $flutter_40.SystemChannels.localization,
      'menu': (visitor) => $flutter_40.SystemChannels.menu,
      'contextMenu': (visitor) => $flutter_40.SystemChannels.contextMenu,
      'keyboard': (visitor) => $flutter_40.SystemChannels.keyboard,
      'sensitiveContent': (visitor) => $flutter_40.SystemChannels.sensitiveContent,
    },
    staticGetterSignatures: {
      'navigation': 'MethodChannel get navigation',
      'backGesture': 'MethodChannel get backGesture',
      'platform': 'MethodChannel get platform',
      'statusBar': 'OptionalMethodChannel get statusBar',
      'processText': 'MethodChannel get processText',
      'textInput': 'MethodChannel get textInput',
      'scribe': 'MethodChannel get scribe',
      'spellCheck': 'MethodChannel get spellCheck',
      'undoManager': 'MethodChannel get undoManager',
      'keyEvent': 'BasicMessageChannel<Object?> get keyEvent',
      'lifecycle': 'BasicMessageChannel<String?> get lifecycle',
      'system': 'BasicMessageChannel<Object?> get system',
      'accessibility': 'BasicMessageChannel<Object?> get accessibility',
      'platform_views': 'MethodChannel get platform_views',
      'platform_views_2': 'MethodChannel get platform_views_2',
      'skia': 'MethodChannel get skia',
      'mouseCursor': 'MethodChannel get mouseCursor',
      'restoration': 'MethodChannel get restoration',
      'deferredComponent': 'MethodChannel get deferredComponent',
      'localization': 'MethodChannel get localization',
      'menu': 'MethodChannel get menu',
      'contextMenu': 'MethodChannel get contextMenu',
      'keyboard': 'MethodChannel get keyboard',
      'sensitiveContent': 'MethodChannel get sensitiveContent',
    },
  );
}

// =============================================================================
// ApplicationSwitcherDescription Bridge
// =============================================================================

BridgedClass _createApplicationSwitcherDescriptionBridge() {
  return BridgedClass(
    nativeType: $flutter_41.ApplicationSwitcherDescription,
    name: 'ApplicationSwitcherDescription',
    constructors: {
      '': (visitor, positional, named) {
        final label = D4.getOptionalNamedArg<String?>(named, 'label');
        final primaryColor = D4.getOptionalNamedArg<int?>(named, 'primaryColor');
        return $flutter_41.ApplicationSwitcherDescription(label: label, primaryColor: primaryColor);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$flutter_41.ApplicationSwitcherDescription>(target, 'ApplicationSwitcherDescription').label,
      'primaryColor': (visitor, target) => D4.validateTarget<$flutter_41.ApplicationSwitcherDescription>(target, 'ApplicationSwitcherDescription').primaryColor,
    },
    constructorSignatures: {
      '': 'const ApplicationSwitcherDescription({String? label, int? primaryColor})',
    },
    getterSignatures: {
      'label': 'String? get label',
      'primaryColor': 'int? get primaryColor',
    },
  );
}

// =============================================================================
// SystemUiOverlayStyle Bridge
// =============================================================================

BridgedClass _createSystemUiOverlayStyleBridge() {
  return BridgedClass(
    nativeType: $flutter_41.SystemUiOverlayStyle,
    name: 'SystemUiOverlayStyle',
    constructors: {
      '': (visitor, positional, named) {
        final systemNavigationBarColor = D4.getOptionalNamedArg<Color?>(named, 'systemNavigationBarColor');
        final systemNavigationBarDividerColor = D4.getOptionalNamedArg<Color?>(named, 'systemNavigationBarDividerColor');
        final systemNavigationBarIconBrightness = D4.getOptionalNamedArg<Brightness?>(named, 'systemNavigationBarIconBrightness');
        final systemNavigationBarContrastEnforced = D4.getOptionalNamedArg<bool?>(named, 'systemNavigationBarContrastEnforced');
        final statusBarColor = D4.getOptionalNamedArg<Color?>(named, 'statusBarColor');
        final statusBarBrightness = D4.getOptionalNamedArg<Brightness?>(named, 'statusBarBrightness');
        final statusBarIconBrightness = D4.getOptionalNamedArg<Brightness?>(named, 'statusBarIconBrightness');
        final systemStatusBarContrastEnforced = D4.getOptionalNamedArg<bool?>(named, 'systemStatusBarContrastEnforced');
        return $flutter_41.SystemUiOverlayStyle(systemNavigationBarColor: systemNavigationBarColor, systemNavigationBarDividerColor: systemNavigationBarDividerColor, systemNavigationBarIconBrightness: systemNavigationBarIconBrightness, systemNavigationBarContrastEnforced: systemNavigationBarContrastEnforced, statusBarColor: statusBarColor, statusBarBrightness: statusBarBrightness, statusBarIconBrightness: statusBarIconBrightness, systemStatusBarContrastEnforced: systemStatusBarContrastEnforced);
      },
    },
    getters: {
      'systemNavigationBarColor': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarColor,
      'systemNavigationBarDividerColor': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarDividerColor,
      'systemNavigationBarIconBrightness': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarIconBrightness,
      'systemNavigationBarContrastEnforced': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarContrastEnforced,
      'statusBarColor': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').statusBarColor,
      'statusBarBrightness': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').statusBarBrightness,
      'statusBarIconBrightness': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').statusBarIconBrightness,
      'systemStatusBarContrastEnforced': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemStatusBarContrastEnforced,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        final systemNavigationBarColor = D4.getOptionalNamedArg<Color?>(named, 'systemNavigationBarColor');
        final systemNavigationBarDividerColor = D4.getOptionalNamedArg<Color?>(named, 'systemNavigationBarDividerColor');
        final systemNavigationBarContrastEnforced = D4.getOptionalNamedArg<bool?>(named, 'systemNavigationBarContrastEnforced');
        final statusBarColor = D4.getOptionalNamedArg<Color?>(named, 'statusBarColor');
        final statusBarBrightness = D4.getOptionalNamedArg<Brightness?>(named, 'statusBarBrightness');
        final statusBarIconBrightness = D4.getOptionalNamedArg<Brightness?>(named, 'statusBarIconBrightness');
        final systemStatusBarContrastEnforced = D4.getOptionalNamedArg<bool?>(named, 'systemStatusBarContrastEnforced');
        final systemNavigationBarIconBrightness = D4.getOptionalNamedArg<Brightness?>(named, 'systemNavigationBarIconBrightness');
        return t.copyWith(systemNavigationBarColor: systemNavigationBarColor, systemNavigationBarDividerColor: systemNavigationBarDividerColor, systemNavigationBarContrastEnforced: systemNavigationBarContrastEnforced, statusBarColor: statusBarColor, statusBarBrightness: statusBarBrightness, statusBarIconBrightness: statusBarIconBrightness, systemStatusBarContrastEnforced: systemStatusBarContrastEnforced, systemNavigationBarIconBrightness: systemNavigationBarIconBrightness);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_2.DiagnosticLevel>(named, 'minLevel', $flutter_2.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_2.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'light': (visitor) => $flutter_41.SystemUiOverlayStyle.light,
      'dark': (visitor) => $flutter_41.SystemUiOverlayStyle.dark,
    },
    constructorSignatures: {
      '': 'const SystemUiOverlayStyle({Color? systemNavigationBarColor, Color? systemNavigationBarDividerColor, Brightness? systemNavigationBarIconBrightness, bool? systemNavigationBarContrastEnforced, Color? statusBarColor, Brightness? statusBarBrightness, Brightness? statusBarIconBrightness, bool? systemStatusBarContrastEnforced})',
    },
    methodSignatures: {
      'copyWith': 'SystemUiOverlayStyle copyWith({Color? systemNavigationBarColor, Color? systemNavigationBarDividerColor, bool? systemNavigationBarContrastEnforced, Color? statusBarColor, Brightness? statusBarBrightness, Brightness? statusBarIconBrightness, bool? systemStatusBarContrastEnforced, Brightness? systemNavigationBarIconBrightness})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'systemNavigationBarColor': 'Color? get systemNavigationBarColor',
      'systemNavigationBarDividerColor': 'Color? get systemNavigationBarDividerColor',
      'systemNavigationBarIconBrightness': 'Brightness? get systemNavigationBarIconBrightness',
      'systemNavigationBarContrastEnforced': 'bool? get systemNavigationBarContrastEnforced',
      'statusBarColor': 'Color? get statusBarColor',
      'statusBarBrightness': 'Brightness? get statusBarBrightness',
      'statusBarIconBrightness': 'Brightness? get statusBarIconBrightness',
      'systemStatusBarContrastEnforced': 'bool? get systemStatusBarContrastEnforced',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'light': 'SystemUiOverlayStyle get light',
      'dark': 'SystemUiOverlayStyle get dark',
    },
  );
}

// =============================================================================
// SystemChrome Bridge
// =============================================================================

BridgedClass _createSystemChromeBridge() {
  return BridgedClass(
    nativeType: $flutter_41.SystemChrome,
    name: 'SystemChrome',
    constructors: {
    },
    staticMethods: {
      'setPreferredOrientations': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setPreferredOrientations');
        if (positional.isEmpty) {
          throw ArgumentError('setPreferredOrientations: Missing required argument "orientations" at position 0');
        }
        final orientations = D4.coerceList<$flutter_41.DeviceOrientation>(positional[0], 'orientations');
        return $flutter_41.SystemChrome.setPreferredOrientations(orientations);
      },
      'setApplicationSwitcherDescription': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setApplicationSwitcherDescription');
        final description = D4.getRequiredArg<$flutter_41.ApplicationSwitcherDescription>(positional, 0, 'description', 'setApplicationSwitcherDescription');
        return $flutter_41.SystemChrome.setApplicationSwitcherDescription(description);
      },
      'setEnabledSystemUIMode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setEnabledSystemUIMode');
        final mode = D4.getRequiredArg<$flutter_41.SystemUiMode>(positional, 0, 'mode', 'setEnabledSystemUIMode');
        final overlays = D4.coerceListOrNull<$flutter_41.SystemUiOverlay>(named['overlays'], 'overlays');
        return $flutter_41.SystemChrome.setEnabledSystemUIMode(mode, overlays: overlays);
      },
      'setSystemUIChangeCallback': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setSystemUIChangeCallback');
        if (positional.isEmpty) {
          throw ArgumentError('setSystemUIChangeCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final callback = callbackRaw == null ? null : (bool p0) { return D4.callInterpreterCallback(visitor, callbackRaw, [p0]) as Future<void>; };
        return $flutter_41.SystemChrome.setSystemUIChangeCallback(callback);
      },
      'restoreSystemUIOverlays': (visitor, positional, named, typeArgs) {
        return $flutter_41.SystemChrome.restoreSystemUIOverlays();
      },
      'setSystemUIOverlayStyle': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setSystemUIOverlayStyle');
        final style = D4.getRequiredArg<$flutter_41.SystemUiOverlayStyle>(positional, 0, 'style', 'setSystemUIOverlayStyle');
        return $flutter_41.SystemChrome.setSystemUIOverlayStyle(style);
      },
      'handleAppLifecycleStateChanged': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'handleAppLifecycleStateChanged');
        final state = D4.getRequiredArg<AppLifecycleState>(positional, 0, 'state', 'handleAppLifecycleStateChanged');
        return $flutter_41.SystemChrome.handleAppLifecycleStateChanged(state);
      },
    },
    staticMethodSignatures: {
      'setPreferredOrientations': 'Future<void> setPreferredOrientations(List<DeviceOrientation> orientations)',
      'setApplicationSwitcherDescription': 'Future<void> setApplicationSwitcherDescription(ApplicationSwitcherDescription description)',
      'setEnabledSystemUIMode': 'Future<void> setEnabledSystemUIMode(SystemUiMode mode, {List<SystemUiOverlay>? overlays})',
      'setSystemUIChangeCallback': 'Future<void> setSystemUIChangeCallback(SystemUiChangeCallback? callback)',
      'restoreSystemUIOverlays': 'Future<void> restoreSystemUIOverlays()',
      'setSystemUIOverlayStyle': 'void setSystemUIOverlayStyle(SystemUiOverlayStyle style)',
      'handleAppLifecycleStateChanged': 'void handleAppLifecycleStateChanged(AppLifecycleState state)',
    },
  );
}

// =============================================================================
// SystemNavigator Bridge
// =============================================================================

BridgedClass _createSystemNavigatorBridge() {
  return BridgedClass(
    nativeType: $flutter_42.SystemNavigator,
    name: 'SystemNavigator',
    constructors: {
    },
    staticMethods: {
      'setFrameworkHandlesBack': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setFrameworkHandlesBack');
        final frameworkHandlesBack = D4.getRequiredArg<bool>(positional, 0, 'frameworkHandlesBack', 'setFrameworkHandlesBack');
        return $flutter_42.SystemNavigator.setFrameworkHandlesBack(frameworkHandlesBack);
      },
      'pop': (visitor, positional, named, typeArgs) {
        final animated = D4.getOptionalNamedArg<bool?>(named, 'animated');
        return $flutter_42.SystemNavigator.pop(animated: animated);
      },
      'selectSingleEntryHistory': (visitor, positional, named, typeArgs) {
        return $flutter_42.SystemNavigator.selectSingleEntryHistory();
      },
      'selectMultiEntryHistory': (visitor, positional, named, typeArgs) {
        return $flutter_42.SystemNavigator.selectMultiEntryHistory();
      },
      'routeInformationUpdated': (visitor, positional, named, typeArgs) {
        final location = D4.getOptionalNamedArg<String?>(named, 'location');
        final uri = D4.getOptionalNamedArg<Uri?>(named, 'uri');
        final state = D4.getOptionalNamedArg<Object?>(named, 'state');
        final replace = D4.getNamedArgWithDefault<bool>(named, 'replace', false);
        return $flutter_42.SystemNavigator.routeInformationUpdated(location: location, uri: uri, state: state, replace: replace);
      },
    },
    staticMethodSignatures: {
      'setFrameworkHandlesBack': 'Future<void> setFrameworkHandlesBack(bool frameworkHandlesBack)',
      'pop': 'Future<void> pop({bool? animated})',
      'selectSingleEntryHistory': 'Future<void> selectSingleEntryHistory()',
      'selectMultiEntryHistory': 'Future<void> selectMultiEntryHistory()',
      'routeInformationUpdated': 'Future<void> routeInformationUpdated({String? location, Uri? uri, Object? state, bool replace = false})',
    },
  );
}

// =============================================================================
// SystemSound Bridge
// =============================================================================

BridgedClass _createSystemSoundBridge() {
  return BridgedClass(
    nativeType: $flutter_43.SystemSound,
    name: 'SystemSound',
    constructors: {
    },
    staticMethods: {
      'play': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'play');
        final type = D4.getRequiredArg<$flutter_43.SystemSoundType>(positional, 0, 'type', 'play');
        return $flutter_43.SystemSound.play(type);
      },
    },
    staticMethodSignatures: {
      'play': 'Future<void> play(SystemSoundType type)',
    },
  );
}

// =============================================================================
// TextBoundary Bridge
// =============================================================================

BridgedClass _createTextBoundaryBridge() {
  return BridgedClass(
    nativeType: $flutter_44.TextBoundary,
    name: 'TextBoundary',
    constructors: {
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.TextBoundary>(target, 'TextBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.TextBoundary>(target, 'TextBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.TextBoundary>(target, 'TextBoundary');
        D4.requireMinArgs(positional, 1, 'getTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTextBoundaryAt');
        return t.getTextBoundaryAt(position);
      },
    },
    methodSignatures: {
      'getLeadingTextBoundaryAt': 'int? getLeadingTextBoundaryAt(int position)',
      'getTrailingTextBoundaryAt': 'int? getTrailingTextBoundaryAt(int position)',
      'getTextBoundaryAt': 'TextRange getTextBoundaryAt(int position)',
    },
  );
}

// =============================================================================
// CharacterBoundary Bridge
// =============================================================================

BridgedClass _createCharacterBoundaryBridge() {
  return BridgedClass(
    nativeType: $flutter_44.CharacterBoundary,
    name: 'CharacterBoundary',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CharacterBoundary');
        final text = D4.getRequiredArg<String>(positional, 0, '_text', 'CharacterBoundary');
        return $flutter_44.CharacterBoundary(text);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.CharacterBoundary>(target, 'CharacterBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.CharacterBoundary>(target, 'CharacterBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.CharacterBoundary>(target, 'CharacterBoundary');
        D4.requireMinArgs(positional, 1, 'getTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTextBoundaryAt');
        return t.getTextBoundaryAt(position);
      },
    },
    constructorSignatures: {
      '': 'const CharacterBoundary(String _text)',
    },
    methodSignatures: {
      'getLeadingTextBoundaryAt': 'int? getLeadingTextBoundaryAt(int position)',
      'getTrailingTextBoundaryAt': 'int? getTrailingTextBoundaryAt(int position)',
      'getTextBoundaryAt': 'TextRange getTextBoundaryAt(int position)',
    },
  );
}

// =============================================================================
// LineBoundary Bridge
// =============================================================================

BridgedClass _createLineBoundaryBridge() {
  return BridgedClass(
    nativeType: $flutter_44.LineBoundary,
    name: 'LineBoundary',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LineBoundary');
        final textLayout = D4.getRequiredArg<$flutter_49.TextLayoutMetrics>(positional, 0, '_textLayout', 'LineBoundary');
        return $flutter_44.LineBoundary(textLayout);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.LineBoundary>(target, 'LineBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.LineBoundary>(target, 'LineBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.LineBoundary>(target, 'LineBoundary');
        D4.requireMinArgs(positional, 1, 'getTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTextBoundaryAt');
        return t.getTextBoundaryAt(position);
      },
    },
    constructorSignatures: {
      '': 'const LineBoundary(TextLayoutMetrics _textLayout)',
    },
    methodSignatures: {
      'getLeadingTextBoundaryAt': 'int? getLeadingTextBoundaryAt(int position)',
      'getTrailingTextBoundaryAt': 'int? getTrailingTextBoundaryAt(int position)',
      'getTextBoundaryAt': 'TextRange getTextBoundaryAt(int position)',
    },
  );
}

// =============================================================================
// ParagraphBoundary Bridge
// =============================================================================

BridgedClass _createParagraphBoundaryBridge() {
  return BridgedClass(
    nativeType: $flutter_44.ParagraphBoundary,
    name: 'ParagraphBoundary',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ParagraphBoundary');
        final text = D4.getRequiredArg<String>(positional, 0, '_text', 'ParagraphBoundary');
        return $flutter_44.ParagraphBoundary(text);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ParagraphBoundary>(target, 'ParagraphBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ParagraphBoundary>(target, 'ParagraphBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.ParagraphBoundary>(target, 'ParagraphBoundary');
        D4.requireMinArgs(positional, 1, 'getTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTextBoundaryAt');
        return t.getTextBoundaryAt(position);
      },
    },
    constructorSignatures: {
      '': 'const ParagraphBoundary(String _text)',
    },
    methodSignatures: {
      'getLeadingTextBoundaryAt': 'int? getLeadingTextBoundaryAt(int position)',
      'getTrailingTextBoundaryAt': 'int? getTrailingTextBoundaryAt(int position)',
      'getTextBoundaryAt': 'TextRange getTextBoundaryAt(int position)',
    },
  );
}

// =============================================================================
// DocumentBoundary Bridge
// =============================================================================

BridgedClass _createDocumentBoundaryBridge() {
  return BridgedClass(
    nativeType: $flutter_44.DocumentBoundary,
    name: 'DocumentBoundary',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentBoundary');
        final text = D4.getRequiredArg<String>(positional, 0, '_text', 'DocumentBoundary');
        return $flutter_44.DocumentBoundary(text);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.DocumentBoundary>(target, 'DocumentBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.DocumentBoundary>(target, 'DocumentBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_44.DocumentBoundary>(target, 'DocumentBoundary');
        D4.requireMinArgs(positional, 1, 'getTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTextBoundaryAt');
        return t.getTextBoundaryAt(position);
      },
    },
    constructorSignatures: {
      '': 'const DocumentBoundary(String _text)',
    },
    methodSignatures: {
      'getLeadingTextBoundaryAt': 'int? getLeadingTextBoundaryAt(int position)',
      'getTrailingTextBoundaryAt': 'int? getTrailingTextBoundaryAt(int position)',
      'getTextBoundaryAt': 'TextRange getTextBoundaryAt(int position)',
    },
  );
}

// =============================================================================
// TextInputFormatter Bridge
// =============================================================================

BridgedClass _createTextInputFormatterBridge() {
  return BridgedClass(
    nativeType: $flutter_47.TextInputFormatter,
    name: 'TextInputFormatter',
    constructors: {
      'withFunction': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextInputFormatter');
        if (positional.isEmpty) {
          throw ArgumentError('TextInputFormatter: Missing required argument "formatFunction" at position 0');
        }
        final formatFunctionRaw = positional[0];
        return $flutter_47.TextInputFormatter.withFunction(($flutter_48.TextEditingValue p0, $flutter_48.TextEditingValue p1) { return D4.callInterpreterCallback(visitor, formatFunctionRaw, [p0, p1]) as $flutter_48.TextEditingValue; });
      },
    },
    methods: {
      'formatEditUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextInputFormatter>(target, 'TextInputFormatter');
        D4.requireMinArgs(positional, 2, 'formatEditUpdate');
        final oldValue = D4.getRequiredArg<$flutter_48.TextEditingValue>(positional, 0, 'oldValue', 'formatEditUpdate');
        final newValue = D4.getRequiredArg<$flutter_48.TextEditingValue>(positional, 1, 'newValue', 'formatEditUpdate');
        return t.formatEditUpdate(oldValue, newValue);
      },
    },
    constructorSignatures: {
      'withFunction': 'const factory TextInputFormatter.withFunction(TextInputFormatFunction formatFunction)',
    },
    methodSignatures: {
      'formatEditUpdate': 'TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue)',
    },
  );
}

// =============================================================================
// FilteringTextInputFormatter Bridge
// =============================================================================

BridgedClass _createFilteringTextInputFormatterBridge() {
  return BridgedClass(
    nativeType: $flutter_47.FilteringTextInputFormatter,
    name: 'FilteringTextInputFormatter',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FilteringTextInputFormatter');
        final filterPattern = D4.getRequiredArg<Pattern>(positional, 0, 'filterPattern', 'FilteringTextInputFormatter');
        final allow = D4.getRequiredNamedArg<bool>(named, 'allow', 'FilteringTextInputFormatter');
        final replacementString = D4.getNamedArgWithDefault<String>(named, 'replacementString', '');
        return $flutter_47.FilteringTextInputFormatter(filterPattern, allow: allow, replacementString: replacementString);
      },
      'allow': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FilteringTextInputFormatter');
        final filterPattern = D4.getRequiredArg<Pattern>(positional, 0, 'filterPattern', 'FilteringTextInputFormatter');
        final replacementString = D4.getNamedArgWithDefault<String>(named, 'replacementString', '');
        return $flutter_47.FilteringTextInputFormatter.allow(filterPattern, replacementString: replacementString);
      },
      'deny': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FilteringTextInputFormatter');
        final filterPattern = D4.getRequiredArg<Pattern>(positional, 0, 'filterPattern', 'FilteringTextInputFormatter');
        final replacementString = D4.getNamedArgWithDefault<String>(named, 'replacementString', '');
        return $flutter_47.FilteringTextInputFormatter.deny(filterPattern, replacementString: replacementString);
      },
    },
    getters: {
      'filterPattern': (visitor, target) => D4.validateTarget<$flutter_47.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter').filterPattern,
      'allow': (visitor, target) => D4.validateTarget<$flutter_47.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter').allow,
      'replacementString': (visitor, target) => D4.validateTarget<$flutter_47.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter').replacementString,
    },
    methods: {
      'formatEditUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter');
        D4.requireMinArgs(positional, 2, 'formatEditUpdate');
        final oldValue = D4.getRequiredArg<$flutter_48.TextEditingValue>(positional, 0, 'oldValue', 'formatEditUpdate');
        final newValue = D4.getRequiredArg<$flutter_48.TextEditingValue>(positional, 1, 'newValue', 'formatEditUpdate');
        return t.formatEditUpdate(oldValue, newValue);
      },
    },
    staticGetters: {
      'singleLineFormatter': (visitor) => $flutter_47.FilteringTextInputFormatter.singleLineFormatter,
      'digitsOnly': (visitor) => $flutter_47.FilteringTextInputFormatter.digitsOnly,
    },
    constructorSignatures: {
      '': 'FilteringTextInputFormatter(Pattern filterPattern, {required bool allow, String replacementString = \'\'})',
      'allow': 'FilteringTextInputFormatter.allow(Pattern filterPattern, {String replacementString = \'\'})',
      'deny': 'FilteringTextInputFormatter.deny(Pattern filterPattern, {String replacementString = \'\'})',
    },
    methodSignatures: {
      'formatEditUpdate': 'TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue)',
    },
    getterSignatures: {
      'filterPattern': 'Pattern get filterPattern',
      'allow': 'bool get allow',
      'replacementString': 'String get replacementString',
    },
    staticGetterSignatures: {
      'singleLineFormatter': 'TextInputFormatter get singleLineFormatter',
      'digitsOnly': 'TextInputFormatter get digitsOnly',
    },
  );
}

// =============================================================================
// LengthLimitingTextInputFormatter Bridge
// =============================================================================

BridgedClass _createLengthLimitingTextInputFormatterBridge() {
  return BridgedClass(
    nativeType: $flutter_47.LengthLimitingTextInputFormatter,
    name: 'LengthLimitingTextInputFormatter',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LengthLimitingTextInputFormatter');
        final maxLength = D4.getRequiredArg<int?>(positional, 0, 'maxLength', 'LengthLimitingTextInputFormatter');
        final maxLengthEnforcement = D4.getOptionalNamedArg<$flutter_47.MaxLengthEnforcement?>(named, 'maxLengthEnforcement');
        return $flutter_47.LengthLimitingTextInputFormatter(maxLength, maxLengthEnforcement: maxLengthEnforcement);
      },
    },
    getters: {
      'maxLength': (visitor, target) => D4.validateTarget<$flutter_47.LengthLimitingTextInputFormatter>(target, 'LengthLimitingTextInputFormatter').maxLength,
      'maxLengthEnforcement': (visitor, target) => D4.validateTarget<$flutter_47.LengthLimitingTextInputFormatter>(target, 'LengthLimitingTextInputFormatter').maxLengthEnforcement,
    },
    methods: {
      'formatEditUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.LengthLimitingTextInputFormatter>(target, 'LengthLimitingTextInputFormatter');
        D4.requireMinArgs(positional, 2, 'formatEditUpdate');
        final oldValue = D4.getRequiredArg<$flutter_48.TextEditingValue>(positional, 0, 'oldValue', 'formatEditUpdate');
        final newValue = D4.getRequiredArg<$flutter_48.TextEditingValue>(positional, 1, 'newValue', 'formatEditUpdate');
        return t.formatEditUpdate(oldValue, newValue);
      },
    },
    staticMethods: {
      'getDefaultMaxLengthEnforcement': (visitor, positional, named, typeArgs) {
        final platform = D4.getOptionalArg<$flutter_3.TargetPlatform?>(positional, 0, 'platform');
        return $flutter_47.LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(platform);
      },
    },
    constructorSignatures: {
      '': 'LengthLimitingTextInputFormatter(int? maxLength, {MaxLengthEnforcement? maxLengthEnforcement})',
    },
    methodSignatures: {
      'formatEditUpdate': 'TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue)',
    },
    getterSignatures: {
      'maxLength': 'int? get maxLength',
      'maxLengthEnforcement': 'MaxLengthEnforcement? get maxLengthEnforcement',
    },
    staticMethodSignatures: {
      'getDefaultMaxLengthEnforcement': 'MaxLengthEnforcement getDefaultMaxLengthEnforcement([TargetPlatform? platform])',
    },
  );
}

// =============================================================================
// TextLayoutMetrics Bridge
// =============================================================================

BridgedClass _createTextLayoutMetricsBridge() {
  return BridgedClass(
    nativeType: $flutter_49.TextLayoutMetrics,
    name: 'TextLayoutMetrics',
    constructors: {
    },
    methods: {
      'getLineAtOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getLineAtOffset');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getLineAtOffset');
        return t.getLineAtOffset(position);
      },
      'getWordBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getWordBoundary');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getWordBoundary');
        return t.getWordBoundary(position);
      },
      'getTextPositionAbove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getTextPositionAbove');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getTextPositionAbove');
        return t.getTextPositionAbove(position);
      },
      'getTextPositionBelow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getTextPositionBelow');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getTextPositionBelow');
        return t.getTextPositionBelow(position);
      },
    },
    staticMethods: {
      'isWhitespace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isWhitespace');
        final codeUnit = D4.getRequiredArg<int>(positional, 0, 'codeUnit', 'isWhitespace');
        return $flutter_49.TextLayoutMetrics.isWhitespace(codeUnit);
      },
      'isLineTerminator': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isLineTerminator');
        final codeUnit = D4.getRequiredArg<int>(positional, 0, 'codeUnit', 'isLineTerminator');
        return $flutter_49.TextLayoutMetrics.isLineTerminator(codeUnit);
      },
    },
    methodSignatures: {
      'getLineAtOffset': 'TextSelection getLineAtOffset(TextPosition position)',
      'getWordBoundary': 'TextRange getWordBoundary(TextPosition position)',
      'getTextPositionAbove': 'TextPosition getTextPositionAbove(TextPosition position)',
      'getTextPositionBelow': 'TextPosition getTextPositionBelow(TextPosition position)',
    },
    staticMethodSignatures: {
      'isWhitespace': 'bool isWhitespace(int codeUnit)',
      'isLineTerminator': 'bool isLineTerminator(int codeUnit)',
    },
  );
}

// =============================================================================
// UndoManager Bridge
// =============================================================================

BridgedClass _createUndoManagerBridge() {
  return BridgedClass(
    nativeType: $flutter_50.UndoManager,
    name: 'UndoManager',
    constructors: {
    },
    staticGetters: {
      'client': (visitor) => $flutter_50.UndoManager.client,
    },
    staticMethods: {
      'setUndoState': (visitor, positional, named, typeArgs) {
        final canUndo = D4.getNamedArgWithDefault<bool>(named, 'canUndo', false);
        final canRedo = D4.getNamedArgWithDefault<bool>(named, 'canRedo', false);
        return $flutter_50.UndoManager.setUndoState(canUndo: canUndo, canRedo: canRedo);
      },
    },
    staticSetters: {
      'client': (visitor, value) => 
        $flutter_50.UndoManager.client = value as dynamic,
    },
    staticMethodSignatures: {
      'setUndoState': 'void setUndoState({bool canUndo = false, bool canRedo = false})',
    },
    staticGetterSignatures: {
      'client': 'UndoManagerClient? get client',
    },
    staticSetterSignatures: {
      'client': 'set client(UndoManagerClient? value)',
    },
  );
}

// =============================================================================
// UndoManagerClient Bridge
// =============================================================================

BridgedClass _createUndoManagerClientBridge() {
  return BridgedClass(
    nativeType: $flutter_50.UndoManagerClient,
    name: 'UndoManagerClient',
    constructors: {
    },
    getters: {
      'canUndo': (visitor, target) => D4.validateTarget<$flutter_50.UndoManagerClient>(target, 'UndoManagerClient').canUndo,
      'canRedo': (visitor, target) => D4.validateTarget<$flutter_50.UndoManagerClient>(target, 'UndoManagerClient').canRedo,
    },
    methods: {
      'handlePlatformUndo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.UndoManagerClient>(target, 'UndoManagerClient');
        D4.requireMinArgs(positional, 1, 'handlePlatformUndo');
        final direction = D4.getRequiredArg<$flutter_50.UndoDirection>(positional, 0, 'direction', 'handlePlatformUndo');
        t.handlePlatformUndo(direction);
        return null;
      },
      'undo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.UndoManagerClient>(target, 'UndoManagerClient');
        t.undo();
        return null;
      },
      'redo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.UndoManagerClient>(target, 'UndoManagerClient');
        t.redo();
        return null;
      },
    },
    methodSignatures: {
      'handlePlatformUndo': 'void handlePlatformUndo(UndoDirection direction)',
      'undo': 'void undo()',
      'redo': 'void redo()',
    },
    getterSignatures: {
      'canUndo': 'bool get canUndo',
      'canRedo': 'bool get canRedo',
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

