// D4rt Bridge - Generated file, do not edit
// Sources: 50 files
// Generated: 2026-03-12T16:28:17.611413

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:math' as $dart_math;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/basic_types.dart' as $flutter_1;
import 'package:flutter/src/foundation/binding.dart' as $flutter_2;
import 'package:flutter/src/foundation/change_notifier.dart' as $flutter_3;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_4;
import 'package:flutter/src/foundation/platform.dart' as $flutter_5;
import 'package:flutter/src/foundation/serialization.dart' as $flutter_6;
import 'package:flutter/src/gestures/events.dart' as $flutter_7;
import 'package:flutter/src/scheduler/binding.dart' as $flutter_8;
import 'package:flutter/src/scheduler/priority.dart' as $flutter_9;
import 'package:flutter/src/services/asset_bundle.dart' as $flutter_10;
import 'package:flutter/src/services/asset_manifest.dart' as $flutter_11;
import 'package:flutter/src/services/autofill.dart' as $flutter_12;
import 'package:flutter/src/services/binary_messenger.dart' as $flutter_13;
import 'package:flutter/src/services/binding.dart' as $flutter_14;
import 'package:flutter/src/services/browser_context_menu.dart' as $flutter_15;
import 'package:flutter/src/services/clipboard.dart' as $flutter_16;
import 'package:flutter/src/services/debug.dart' as $flutter_17;
import 'package:flutter/src/services/deferred_component.dart' as $flutter_18;
import 'package:flutter/src/services/flavor.dart' as $flutter_19;
import 'package:flutter/src/services/flutter_version.dart' as $flutter_20;
import 'package:flutter/src/services/font_loader.dart' as $flutter_21;
import 'package:flutter/src/services/haptic_feedback.dart' as $flutter_22;
import 'package:flutter/src/services/hardware_keyboard.dart' as $flutter_23;
import 'package:flutter/src/services/keyboard_inserted_content.dart' as $flutter_24;
import 'package:flutter/src/services/keyboard_key.g.dart' as $flutter_25;
import 'package:flutter/src/services/keyboard_maps.g.dart' as $flutter_26;
import 'package:flutter/src/services/live_text.dart' as $flutter_27;
import 'package:flutter/src/services/message_codec.dart' as $flutter_28;
import 'package:flutter/src/services/message_codecs.dart' as $flutter_29;
import 'package:flutter/src/services/mouse_cursor.dart' as $flutter_30;
import 'package:flutter/src/services/mouse_tracking.dart' as $flutter_31;
import 'package:flutter/src/services/platform_channel.dart' as $flutter_32;
import 'package:flutter/src/services/platform_views.dart' as $flutter_33;
import 'package:flutter/src/services/predictive_back_event.dart' as $flutter_34;
import 'package:flutter/src/services/process_text.dart' as $flutter_35;
import 'package:flutter/src/services/raw_keyboard_macos.dart' as $flutter_36;
import 'package:flutter/src/services/restoration.dart' as $flutter_37;
import 'package:flutter/src/services/scribe.dart' as $flutter_38;
import 'package:flutter/src/services/sensitive_content.dart' as $flutter_39;
import 'package:flutter/src/services/service_extensions.dart' as $flutter_40;
import 'package:flutter/src/services/spell_check.dart' as $flutter_41;
import 'package:flutter/src/services/system_channels.dart' as $flutter_42;
import 'package:flutter/src/services/system_chrome.dart' as $flutter_43;
import 'package:flutter/src/services/system_navigator.dart' as $flutter_44;
import 'package:flutter/src/services/system_sound.dart' as $flutter_45;
import 'package:flutter/src/services/text_boundary.dart' as $flutter_46;
import 'package:flutter/src/services/text_editing.dart' as $flutter_47;
import 'package:flutter/src/services/text_editing_delta.dart' as $flutter_48;
import 'package:flutter/src/services/text_formatter.dart' as $flutter_49;
import 'package:flutter/src/services/text_input.dart' as $flutter_50;
import 'package:flutter/src/services/text_layout_metrics.dart' as $flutter_51;
import 'package:flutter/src/services/undo_manager.dart' as $flutter_52;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;

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
      _createAutofillHintsBridge(),
      _createAutofillConfigurationBridge(),
      _createAutofillClientBridge(),
      _createAutofillScopeBridge(),
      _createAutofillScopeMixinBridge(),
      _createTextSelectionBridge(),
      _createTextInputTypeBridge(),
      _createTextInputConfigurationBridge(),
      _createRawFloatingCursorPointBridge(),
      _createTextEditingValueBridge(),
      _createTextSelectionDelegateBridge(),
      _createTextInputClientBridge(),
      _createScribbleClientBridge(),
      _createSelectionRectBridge(),
      _createDeltaTextInputClientBridge(),
      _createTextInputConnectionBridge(),
      _createTextInputBridge(),
      _createTextInputControlBridge(),
      _createSystemContextMenuControllerBridge(),
      _createIOSSystemContextMenuItemDataBridge(),
      _createIOSSystemContextMenuItemDataCopyBridge(),
      _createIOSSystemContextMenuItemDataCutBridge(),
      _createIOSSystemContextMenuItemDataPasteBridge(),
      _createIOSSystemContextMenuItemDataSelectAllBridge(),
      _createIOSSystemContextMenuItemDataLookUpBridge(),
      _createIOSSystemContextMenuItemDataSearchWebBridge(),
      _createIOSSystemContextMenuItemDataShareBridge(),
      _createIOSSystemContextMenuItemDataLiveTextBridge(),
      _createIOSSystemContextMenuItemDataCustomBridge(),
      _createTextEditingDeltaBridge(),
      _createTextEditingDeltaInsertionBridge(),
      _createTextEditingDeltaDeletionBridge(),
      _createTextEditingDeltaReplacementBridge(),
      _createTextEditingDeltaNonTextUpdateBridge(),
      _createBinaryMessengerBridge(),
      _createKeyboardKeyBridge(),
      _createLogicalKeyboardKeyBridge(),
      _createPhysicalKeyboardKeyBridge(),
      _createKeyEventBridge(),
      _createKeyDownEventBridge(),
      _createKeyUpEventBridge(),
      _createKeyRepeatEventBridge(),
      _createHardwareKeyboardBridge(),
      _createRestorationManagerBridge(),
      _createRestorationBucketBridge(),
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
      'AutofillHints': 'package:flutter/src/services/autofill.dart',
      'AutofillConfiguration': 'package:flutter/src/services/autofill.dart',
      'AutofillClient': 'package:flutter/src/services/autofill.dart',
      'AutofillScope': 'package:flutter/src/services/autofill.dart',
      'AutofillScopeMixin': 'package:flutter/src/services/autofill.dart',
      'TextSelection': 'package:flutter/src/services/text_editing.dart',
      'TextInputType': 'package:flutter/src/services/text_input.dart',
      'TextInputConfiguration': 'package:flutter/src/services/text_input.dart',
      'RawFloatingCursorPoint': 'package:flutter/src/services/text_input.dart',
      'TextEditingValue': 'package:flutter/src/services/text_input.dart',
      'TextSelectionDelegate': 'package:flutter/src/services/text_input.dart',
      'TextInputClient': 'package:flutter/src/services/text_input.dart',
      'ScribbleClient': 'package:flutter/src/services/text_input.dart',
      'SelectionRect': 'package:flutter/src/services/text_input.dart',
      'DeltaTextInputClient': 'package:flutter/src/services/text_input.dart',
      'TextInputConnection': 'package:flutter/src/services/text_input.dart',
      'TextInput': 'package:flutter/src/services/text_input.dart',
      'TextInputControl': 'package:flutter/src/services/text_input.dart',
      'SystemContextMenuController': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemData': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataCopy': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataCut': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataPaste': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataSelectAll': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataLookUp': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataSearchWeb': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataShare': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataLiveText': 'package:flutter/src/services/text_input.dart',
      'IOSSystemContextMenuItemDataCustom': 'package:flutter/src/services/text_input.dart',
      'TextEditingDelta': 'package:flutter/src/services/text_editing_delta.dart',
      'TextEditingDeltaInsertion': 'package:flutter/src/services/text_editing_delta.dart',
      'TextEditingDeltaDeletion': 'package:flutter/src/services/text_editing_delta.dart',
      'TextEditingDeltaReplacement': 'package:flutter/src/services/text_editing_delta.dart',
      'TextEditingDeltaNonTextUpdate': 'package:flutter/src/services/text_editing_delta.dart',
      'BinaryMessenger': 'package:flutter/src/services/binary_messenger.dart',
      'KeyboardKey': 'package:flutter/src/services/keyboard_key.g.dart',
      'LogicalKeyboardKey': 'package:flutter/src/services/keyboard_key.g.dart',
      'PhysicalKeyboardKey': 'package:flutter/src/services/keyboard_key.g.dart',
      'KeyEvent': 'package:flutter/src/services/hardware_keyboard.dart',
      'KeyDownEvent': 'package:flutter/src/services/hardware_keyboard.dart',
      'KeyUpEvent': 'package:flutter/src/services/hardware_keyboard.dart',
      'KeyRepeatEvent': 'package:flutter/src/services/hardware_keyboard.dart',
      'HardwareKeyboard': 'package:flutter/src/services/hardware_keyboard.dart',
      'RestorationManager': 'package:flutter/src/services/restoration.dart',
      'RestorationBucket': 'package:flutter/src/services/restoration.dart',
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
      'MessageHandler',
      'PlatformMessageResponseCallback',
      'KeyEventCallback',
      'SystemUiChangeCallback',
      'AsyncCallback',
      'AsyncValueGetter',
      'AsyncValueSetter',
      'ServiceExtensionCallback',
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
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_50.SmartDashesType>(
        name: 'SmartDashesType',
        values: $flutter_50.SmartDashesType.values,
      ),
      BridgedEnumDefinition<$flutter_50.SmartQuotesType>(
        name: 'SmartQuotesType',
        values: $flutter_50.SmartQuotesType.values,
      ),
      BridgedEnumDefinition<$flutter_50.TextInputAction>(
        name: 'TextInputAction',
        values: $flutter_50.TextInputAction.values,
      ),
      BridgedEnumDefinition<$flutter_50.TextCapitalization>(
        name: 'TextCapitalization',
        values: $flutter_50.TextCapitalization.values,
      ),
      BridgedEnumDefinition<$flutter_50.FloatingCursorDragState>(
        name: 'FloatingCursorDragState',
        values: $flutter_50.FloatingCursorDragState.values,
      ),
      BridgedEnumDefinition<$flutter_50.SelectionChangedCause>(
        name: 'SelectionChangedCause',
        values: $flutter_50.SelectionChangedCause.values,
      ),
      BridgedEnumDefinition<$flutter_23.KeyboardLockMode>(
        name: 'KeyboardLockMode',
        values: $flutter_23.KeyboardLockMode.values,
        getters: {
          'logicalKey': (visitor, target) => (target as $flutter_23.KeyboardLockMode).logicalKey,
        },
      ),
      BridgedEnumDefinition<$flutter_34.SwipeEdge>(
        name: 'SwipeEdge',
        values: $flutter_34.SwipeEdge.values,
      ),
      BridgedEnumDefinition<$flutter_39.ContentSensitivity>(
        name: 'ContentSensitivity',
        values: $flutter_39.ContentSensitivity.values,
      ),
      BridgedEnumDefinition<$flutter_40.ServicesServiceExtensions>(
        name: 'ServicesServiceExtensions',
        values: $flutter_40.ServicesServiceExtensions.values,
      ),
      BridgedEnumDefinition<$flutter_43.DeviceOrientation>(
        name: 'DeviceOrientation',
        values: $flutter_43.DeviceOrientation.values,
      ),
      BridgedEnumDefinition<$flutter_43.SystemUiOverlay>(
        name: 'SystemUiOverlay',
        values: $flutter_43.SystemUiOverlay.values,
      ),
      BridgedEnumDefinition<$flutter_43.SystemUiMode>(
        name: 'SystemUiMode',
        values: $flutter_43.SystemUiMode.values,
      ),
      BridgedEnumDefinition<$flutter_45.SystemSoundType>(
        name: 'SystemSoundType',
        values: $flutter_45.SystemSoundType.values,
      ),
      BridgedEnumDefinition<$flutter_49.MaxLengthEnforcement>(
        name: 'MaxLengthEnforcement',
        values: $flutter_49.MaxLengthEnforcement.values,
      ),
      BridgedEnumDefinition<$flutter_52.UndoDirection>(
        name: 'UndoDirection',
        values: $flutter_52.UndoDirection.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'SmartDashesType': 'package:flutter/src/services/text_input.dart',
      'SmartQuotesType': 'package:flutter/src/services/text_input.dart',
      'TextInputAction': 'package:flutter/src/services/text_input.dart',
      'TextCapitalization': 'package:flutter/src/services/text_input.dart',
      'FloatingCursorDragState': 'package:flutter/src/services/text_input.dart',
      'SelectionChangedCause': 'package:flutter/src/services/text_input.dart',
      'KeyboardLockMode': 'package:flutter/src/services/hardware_keyboard.dart',
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
      interpreter.registerGlobalVariable('rootBundle', $flutter_10.rootBundle, importPath, sourceUri: 'package:flutter/src/services/asset_bundle.dart');
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
      interpreter.registerGlobalVariable('debugPrintKeyboardEvents', $flutter_17.debugPrintKeyboardEvents, importPath, sourceUri: 'package:flutter/src/services/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintKeyboardEvents": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugProfilePlatformChannels', $flutter_17.debugProfilePlatformChannels, importPath, sourceUri: 'package:flutter/src/services/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugProfilePlatformChannels": $e');
    }
    try {
      interpreter.registerGlobalVariable('appFlavor', $flutter_19.appFlavor, importPath, sourceUri: 'package:flutter/src/services/flavor.dart');
    } catch (e) {
      errors.add('Failed to register variable "appFlavor": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAndroidToLogicalKey', $flutter_26.kAndroidToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAndroidToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAndroidToPhysicalKey', $flutter_26.kAndroidToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAndroidToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kAndroidNumPadMap', $flutter_26.kAndroidNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kAndroidNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kFuchsiaToLogicalKey', $flutter_26.kFuchsiaToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kFuchsiaToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kFuchsiaToPhysicalKey', $flutter_26.kFuchsiaToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kFuchsiaToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsToPhysicalKey', $flutter_26.kMacOsToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsNumPadMap', $flutter_26.kMacOsNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsFunctionKeyMap', $flutter_26.kMacOsFunctionKeyMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsFunctionKeyMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMacOsToLogicalKey', $flutter_26.kMacOsToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMacOsToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosToPhysicalKey', $flutter_26.kIosToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosSpecialLogicalMap', $flutter_26.kIosSpecialLogicalMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosSpecialLogicalMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosNumPadMap', $flutter_26.kIosNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kIosToLogicalKey', $flutter_26.kIosToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kIosToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGlfwToLogicalKey', $flutter_26.kGlfwToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGlfwToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGlfwNumpadMap', $flutter_26.kGlfwNumpadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGlfwNumpadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGtkToLogicalKey', $flutter_26.kGtkToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGtkToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kGtkNumpadMap', $flutter_26.kGtkNumpadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kGtkNumpadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kLinuxToPhysicalKey', $flutter_26.kLinuxToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kLinuxToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebToLogicalKey', $flutter_26.kWebToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebToPhysicalKey', $flutter_26.kWebToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebNumPadMap', $flutter_26.kWebNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWebLocationMap', $flutter_26.kWebLocationMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWebLocationMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowsToLogicalKey', $flutter_26.kWindowsToLogicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowsToLogicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowsToPhysicalKey', $flutter_26.kWindowsToPhysicalKey, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowsToPhysicalKey": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowsNumPadMap', $flutter_26.kWindowsNumPadMap, importPath, sourceUri: 'package:flutter/src/services/keyboard_maps.g.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowsNumPadMap": $e');
    }
    try {
      interpreter.registerGlobalVariable('kProfilePlatformChannels', $flutter_32.kProfilePlatformChannels, importPath, sourceUri: 'package:flutter/src/services/platform_channel.dart');
    } catch (e) {
      errors.add('Failed to register variable "kProfilePlatformChannels": $e');
    }
    try {
      interpreter.registerGlobalVariable('platformViewsRegistry', $flutter_33.platformViewsRegistry, importPath, sourceUri: 'package:flutter/src/services/platform_views.dart');
    } catch (e) {
      errors.add('Failed to register variable "platformViewsRegistry": $e');
    }
    interpreter.registerGlobalGetter('shouldProfilePlatformChannels', () => $flutter_32.shouldProfilePlatformChannels, importPath, sourceUri: 'package:flutter/src/services/platform_channel.dart');

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
      'debugIsSerializableForRestoration': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugIsSerializableForRestoration');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'debugIsSerializableForRestoration');
        return $flutter_37.debugIsSerializableForRestoration(object);
      },
      'debugAssertAllServicesVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllServicesVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllServicesVarsUnset');
        return $flutter_17.debugAssertAllServicesVarsUnset(reason);
      },
      'runeToLowerCase': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'runeToLowerCase');
        final rune = D4.getRequiredArg<int>(positional, 0, 'rune', 'runeToLowerCase');
        return $flutter_36.runeToLowerCase(rune);
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
      'debugIsSerializableForRestoration': 'package:flutter/src/services/restoration.dart',
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
      'debugIsSerializableForRestoration': 'bool debugIsSerializableForRestoration(Object? object)',
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
      'package:flutter/src/services/text_input.dart',
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
    'SmartDashesType',
    'SmartQuotesType',
    'TextInputAction',
    'TextCapitalization',
    'FloatingCursorDragState',
    'SelectionChangedCause',
    'KeyboardLockMode',
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
    nativeType: $flutter_10.AssetBundle,
    name: 'AssetBundle',
    isAssignable: (v) => v is $flutter_10.AssetBundle,
    constructors: {
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.AssetBundle>(target, 'AssetBundle');
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
    nativeType: $flutter_10.NetworkAssetBundle,
    name: 'NetworkAssetBundle',
    isAssignable: (v) => v is $flutter_10.NetworkAssetBundle,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NetworkAssetBundle');
        final baseUrl = D4.getRequiredArg<Uri>(positional, 0, 'baseUrl', 'NetworkAssetBundle');
        return $flutter_10.NetworkAssetBundle(baseUrl);
      },
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.NetworkAssetBundle>(target, 'NetworkAssetBundle');
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
    nativeType: $flutter_10.CachingAssetBundle,
    name: 'CachingAssetBundle',
    isAssignable: (v) => v is $flutter_10.CachingAssetBundle,
    constructors: {
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.CachingAssetBundle>(target, 'CachingAssetBundle');
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
    nativeType: $flutter_10.PlatformAssetBundle,
    name: 'PlatformAssetBundle',
    isAssignable: (v) => v is $flutter_10.PlatformAssetBundle,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_10.PlatformAssetBundle();
      },
    },
    methods: {
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'load');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'load');
        return t.load(key);
      },
      'loadBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadBuffer');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadBuffer');
        return t.loadBuffer(key);
      },
      'loadString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'loadString');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadString');
        final cache = D4.getNamedArgWithDefault<bool>(named, 'cache', true);
        return t.loadString(key, cache: cache);
      },
      'loadStructuredData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredData(key, (String p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as Future<dynamic>; });
      },
      'loadStructuredBinaryData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 2, 'loadStructuredBinaryData');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'loadStructuredBinaryData');
        if (positional.length <= 1) {
          throw ArgumentError('loadStructuredBinaryData: Missing required argument "parser" at position 1');
        }
        final parserRaw = positional[1];
        return t.loadStructuredBinaryData(key, (ByteData p0) { return D4.callInterpreterCallback(visitor!, parserRaw, [p0]) as FutureOr<Object>; });
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        D4.requireMinArgs(positional, 1, 'evict');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'evict');
        t.evict(key);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.PlatformAssetBundle>(target, 'PlatformAssetBundle');
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
    nativeType: $flutter_11.AssetManifest,
    name: 'AssetManifest',
    isAssignable: (v) => v is $flutter_11.AssetManifest,
    constructors: {
    },
    methods: {
      'listAssets': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.AssetManifest>(target, 'AssetManifest');
        return t.listAssets();
      },
      'getAssetVariants': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.AssetManifest>(target, 'AssetManifest');
        D4.requireMinArgs(positional, 1, 'getAssetVariants');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'getAssetVariants');
        return t.getAssetVariants(key);
      },
    },
    staticMethods: {
      'loadFromAssetBundle': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadFromAssetBundle');
        final bundle = D4.getRequiredArg<$flutter_10.AssetBundle>(positional, 0, 'bundle', 'loadFromAssetBundle');
        return $flutter_11.AssetManifest.loadFromAssetBundle(bundle);
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
    nativeType: $flutter_11.AssetMetadata,
    name: 'AssetMetadata',
    isAssignable: (v) => v is $flutter_11.AssetMetadata,
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getRequiredNamedArg<String>(named, 'key', 'AssetMetadata');
        final targetDevicePixelRatio = D4.getRequiredNamedArg<double?>(named, 'targetDevicePixelRatio', 'AssetMetadata');
        final main = D4.getRequiredNamedArg<bool>(named, 'main', 'AssetMetadata');
        return $flutter_11.AssetMetadata(key: key, targetDevicePixelRatio: targetDevicePixelRatio, main: main);
      },
    },
    getters: {
      'targetDevicePixelRatio': (visitor, target) => D4.validateTarget<$flutter_11.AssetMetadata>(target, 'AssetMetadata').targetDevicePixelRatio,
      'key': (visitor, target) => D4.validateTarget<$flutter_11.AssetMetadata>(target, 'AssetMetadata').key,
      'main': (visitor, target) => D4.validateTarget<$flutter_11.AssetMetadata>(target, 'AssetMetadata').main,
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
// AutofillHints Bridge
// =============================================================================

BridgedClass _createAutofillHintsBridge() {
  return BridgedClass(
    nativeType: $flutter_12.AutofillHints,
    name: 'AutofillHints',
    isAssignable: (v) => v is $flutter_12.AutofillHints,
    constructors: {
    },
    staticGetters: {
      'addressCity': (visitor) => $flutter_12.AutofillHints.addressCity,
      'addressCityAndState': (visitor) => $flutter_12.AutofillHints.addressCityAndState,
      'addressState': (visitor) => $flutter_12.AutofillHints.addressState,
      'birthday': (visitor) => $flutter_12.AutofillHints.birthday,
      'birthdayDay': (visitor) => $flutter_12.AutofillHints.birthdayDay,
      'birthdayMonth': (visitor) => $flutter_12.AutofillHints.birthdayMonth,
      'birthdayYear': (visitor) => $flutter_12.AutofillHints.birthdayYear,
      'countryCode': (visitor) => $flutter_12.AutofillHints.countryCode,
      'countryName': (visitor) => $flutter_12.AutofillHints.countryName,
      'creditCardExpirationDate': (visitor) => $flutter_12.AutofillHints.creditCardExpirationDate,
      'creditCardExpirationDay': (visitor) => $flutter_12.AutofillHints.creditCardExpirationDay,
      'creditCardExpirationMonth': (visitor) => $flutter_12.AutofillHints.creditCardExpirationMonth,
      'creditCardExpirationYear': (visitor) => $flutter_12.AutofillHints.creditCardExpirationYear,
      'creditCardFamilyName': (visitor) => $flutter_12.AutofillHints.creditCardFamilyName,
      'creditCardGivenName': (visitor) => $flutter_12.AutofillHints.creditCardGivenName,
      'creditCardMiddleName': (visitor) => $flutter_12.AutofillHints.creditCardMiddleName,
      'creditCardName': (visitor) => $flutter_12.AutofillHints.creditCardName,
      'creditCardNumber': (visitor) => $flutter_12.AutofillHints.creditCardNumber,
      'creditCardSecurityCode': (visitor) => $flutter_12.AutofillHints.creditCardSecurityCode,
      'creditCardType': (visitor) => $flutter_12.AutofillHints.creditCardType,
      'email': (visitor) => $flutter_12.AutofillHints.email,
      'familyName': (visitor) => $flutter_12.AutofillHints.familyName,
      'fullStreetAddress': (visitor) => $flutter_12.AutofillHints.fullStreetAddress,
      'gender': (visitor) => $flutter_12.AutofillHints.gender,
      'givenName': (visitor) => $flutter_12.AutofillHints.givenName,
      'impp': (visitor) => $flutter_12.AutofillHints.impp,
      'jobTitle': (visitor) => $flutter_12.AutofillHints.jobTitle,
      'language': (visitor) => $flutter_12.AutofillHints.language,
      'location': (visitor) => $flutter_12.AutofillHints.location,
      'middleInitial': (visitor) => $flutter_12.AutofillHints.middleInitial,
      'middleName': (visitor) => $flutter_12.AutofillHints.middleName,
      'name': (visitor) => $flutter_12.AutofillHints.name,
      'namePrefix': (visitor) => $flutter_12.AutofillHints.namePrefix,
      'nameSuffix': (visitor) => $flutter_12.AutofillHints.nameSuffix,
      'newPassword': (visitor) => $flutter_12.AutofillHints.newPassword,
      'newUsername': (visitor) => $flutter_12.AutofillHints.newUsername,
      'nickname': (visitor) => $flutter_12.AutofillHints.nickname,
      'oneTimeCode': (visitor) => $flutter_12.AutofillHints.oneTimeCode,
      'organizationName': (visitor) => $flutter_12.AutofillHints.organizationName,
      'password': (visitor) => $flutter_12.AutofillHints.password,
      'photo': (visitor) => $flutter_12.AutofillHints.photo,
      'postalAddress': (visitor) => $flutter_12.AutofillHints.postalAddress,
      'postalAddressExtended': (visitor) => $flutter_12.AutofillHints.postalAddressExtended,
      'postalAddressExtendedPostalCode': (visitor) => $flutter_12.AutofillHints.postalAddressExtendedPostalCode,
      'postalCode': (visitor) => $flutter_12.AutofillHints.postalCode,
      'streetAddressLevel1': (visitor) => $flutter_12.AutofillHints.streetAddressLevel1,
      'streetAddressLevel2': (visitor) => $flutter_12.AutofillHints.streetAddressLevel2,
      'streetAddressLevel3': (visitor) => $flutter_12.AutofillHints.streetAddressLevel3,
      'streetAddressLevel4': (visitor) => $flutter_12.AutofillHints.streetAddressLevel4,
      'streetAddressLine1': (visitor) => $flutter_12.AutofillHints.streetAddressLine1,
      'streetAddressLine2': (visitor) => $flutter_12.AutofillHints.streetAddressLine2,
      'streetAddressLine3': (visitor) => $flutter_12.AutofillHints.streetAddressLine3,
      'sublocality': (visitor) => $flutter_12.AutofillHints.sublocality,
      'telephoneNumber': (visitor) => $flutter_12.AutofillHints.telephoneNumber,
      'telephoneNumberAreaCode': (visitor) => $flutter_12.AutofillHints.telephoneNumberAreaCode,
      'telephoneNumberCountryCode': (visitor) => $flutter_12.AutofillHints.telephoneNumberCountryCode,
      'telephoneNumberDevice': (visitor) => $flutter_12.AutofillHints.telephoneNumberDevice,
      'telephoneNumberExtension': (visitor) => $flutter_12.AutofillHints.telephoneNumberExtension,
      'telephoneNumberLocal': (visitor) => $flutter_12.AutofillHints.telephoneNumberLocal,
      'telephoneNumberLocalPrefix': (visitor) => $flutter_12.AutofillHints.telephoneNumberLocalPrefix,
      'telephoneNumberLocalSuffix': (visitor) => $flutter_12.AutofillHints.telephoneNumberLocalSuffix,
      'telephoneNumberNational': (visitor) => $flutter_12.AutofillHints.telephoneNumberNational,
      'transactionAmount': (visitor) => $flutter_12.AutofillHints.transactionAmount,
      'transactionCurrency': (visitor) => $flutter_12.AutofillHints.transactionCurrency,
      'url': (visitor) => $flutter_12.AutofillHints.url,
      'username': (visitor) => $flutter_12.AutofillHints.username,
    },
    staticGetterSignatures: {
      'addressCity': 'String get addressCity',
      'addressCityAndState': 'String get addressCityAndState',
      'addressState': 'String get addressState',
      'birthday': 'String get birthday',
      'birthdayDay': 'String get birthdayDay',
      'birthdayMonth': 'String get birthdayMonth',
      'birthdayYear': 'String get birthdayYear',
      'countryCode': 'String get countryCode',
      'countryName': 'String get countryName',
      'creditCardExpirationDate': 'String get creditCardExpirationDate',
      'creditCardExpirationDay': 'String get creditCardExpirationDay',
      'creditCardExpirationMonth': 'String get creditCardExpirationMonth',
      'creditCardExpirationYear': 'String get creditCardExpirationYear',
      'creditCardFamilyName': 'String get creditCardFamilyName',
      'creditCardGivenName': 'String get creditCardGivenName',
      'creditCardMiddleName': 'String get creditCardMiddleName',
      'creditCardName': 'String get creditCardName',
      'creditCardNumber': 'String get creditCardNumber',
      'creditCardSecurityCode': 'String get creditCardSecurityCode',
      'creditCardType': 'String get creditCardType',
      'email': 'String get email',
      'familyName': 'String get familyName',
      'fullStreetAddress': 'String get fullStreetAddress',
      'gender': 'String get gender',
      'givenName': 'String get givenName',
      'impp': 'String get impp',
      'jobTitle': 'String get jobTitle',
      'language': 'String get language',
      'location': 'String get location',
      'middleInitial': 'String get middleInitial',
      'middleName': 'String get middleName',
      'name': 'String get name',
      'namePrefix': 'String get namePrefix',
      'nameSuffix': 'String get nameSuffix',
      'newPassword': 'String get newPassword',
      'newUsername': 'String get newUsername',
      'nickname': 'String get nickname',
      'oneTimeCode': 'String get oneTimeCode',
      'organizationName': 'String get organizationName',
      'password': 'String get password',
      'photo': 'String get photo',
      'postalAddress': 'String get postalAddress',
      'postalAddressExtended': 'String get postalAddressExtended',
      'postalAddressExtendedPostalCode': 'String get postalAddressExtendedPostalCode',
      'postalCode': 'String get postalCode',
      'streetAddressLevel1': 'String get streetAddressLevel1',
      'streetAddressLevel2': 'String get streetAddressLevel2',
      'streetAddressLevel3': 'String get streetAddressLevel3',
      'streetAddressLevel4': 'String get streetAddressLevel4',
      'streetAddressLine1': 'String get streetAddressLine1',
      'streetAddressLine2': 'String get streetAddressLine2',
      'streetAddressLine3': 'String get streetAddressLine3',
      'sublocality': 'String get sublocality',
      'telephoneNumber': 'String get telephoneNumber',
      'telephoneNumberAreaCode': 'String get telephoneNumberAreaCode',
      'telephoneNumberCountryCode': 'String get telephoneNumberCountryCode',
      'telephoneNumberDevice': 'String get telephoneNumberDevice',
      'telephoneNumberExtension': 'String get telephoneNumberExtension',
      'telephoneNumberLocal': 'String get telephoneNumberLocal',
      'telephoneNumberLocalPrefix': 'String get telephoneNumberLocalPrefix',
      'telephoneNumberLocalSuffix': 'String get telephoneNumberLocalSuffix',
      'telephoneNumberNational': 'String get telephoneNumberNational',
      'transactionAmount': 'String get transactionAmount',
      'transactionCurrency': 'String get transactionCurrency',
      'url': 'String get url',
      'username': 'String get username',
    },
  );
}

// =============================================================================
// AutofillConfiguration Bridge
// =============================================================================

BridgedClass _createAutofillConfigurationBridge() {
  return BridgedClass(
    nativeType: $flutter_12.AutofillConfiguration,
    name: 'AutofillConfiguration',
    isAssignable: (v) => v is $flutter_12.AutofillConfiguration,
    constructors: {
      '': (visitor, positional, named) {
        final uniqueIdentifier = D4.getRequiredNamedArg<String>(named, 'uniqueIdentifier', 'AutofillConfiguration');
        if (!named.containsKey('autofillHints') || named['autofillHints'] == null) {
          throw ArgumentError('AutofillConfiguration: Missing required named argument "autofillHints"');
        }
        final autofillHints = D4.coerceList<String>(named['autofillHints'], 'autofillHints');
        final currentEditingValue = D4.getRequiredNamedArg<$flutter_50.TextEditingValue>(named, 'currentEditingValue', 'AutofillConfiguration');
        final hintText = D4.getOptionalNamedArg<String?>(named, 'hintText');
        return $flutter_12.AutofillConfiguration(uniqueIdentifier: uniqueIdentifier, autofillHints: autofillHints, currentEditingValue: currentEditingValue, hintText: hintText);
      },
    },
    getters: {
      'enabled': (visitor, target) => D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration').enabled,
      'uniqueIdentifier': (visitor, target) => D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration').uniqueIdentifier,
      'autofillHints': (visitor, target) => D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration').autofillHints,
      'currentEditingValue': (visitor, target) => D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration').currentEditingValue,
      'hintText': (visitor, target) => D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration').hintText,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration').hashCode,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillConfiguration>(target, 'AutofillConfiguration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'disabled': (visitor) => $flutter_12.AutofillConfiguration.disabled,
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
// AutofillClient Bridge
// =============================================================================

BridgedClass _createAutofillClientBridge() {
  return BridgedClass(
    nativeType: $flutter_12.AutofillClient,
    name: 'AutofillClient',
    isAssignable: (v) => v is $flutter_12.AutofillClient,
    constructors: {
    },
    getters: {
      'autofillId': (visitor, target) => D4.validateTarget<$flutter_12.AutofillClient>(target, 'AutofillClient').autofillId,
      'textInputConfiguration': (visitor, target) => D4.validateTarget<$flutter_12.AutofillClient>(target, 'AutofillClient').textInputConfiguration,
    },
    methods: {
      'autofill': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillClient>(target, 'AutofillClient');
        D4.requireMinArgs(positional, 1, 'autofill');
        final newEditingValue = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'newEditingValue', 'autofill');
        t.autofill(newEditingValue);
        return null;
      },
    },
    methodSignatures: {
      'autofill': 'void autofill(TextEditingValue newEditingValue)',
    },
    getterSignatures: {
      'autofillId': 'String get autofillId',
      'textInputConfiguration': 'TextInputConfiguration get textInputConfiguration',
    },
  );
}

// =============================================================================
// AutofillScope Bridge
// =============================================================================

BridgedClass _createAutofillScopeBridge() {
  return BridgedClass(
    nativeType: $flutter_12.AutofillScope,
    name: 'AutofillScope',
    isAssignable: (v) => v is $flutter_12.AutofillScope,
    constructors: {
    },
    getters: {
      'autofillClients': (visitor, target) => D4.validateTarget<$flutter_12.AutofillScope>(target, 'AutofillScope').autofillClients,
    },
    methods: {
      'getAutofillClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillScope>(target, 'AutofillScope');
        D4.requireMinArgs(positional, 1, 'getAutofillClient');
        final autofillId = D4.getRequiredArg<String>(positional, 0, 'autofillId', 'getAutofillClient');
        return t.getAutofillClient(autofillId);
      },
      'attach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillScope>(target, 'AutofillScope');
        D4.requireMinArgs(positional, 2, 'attach');
        final trigger = D4.getRequiredArg<$flutter_50.TextInputClient>(positional, 0, 'trigger', 'attach');
        final configuration = D4.getRequiredArg<$flutter_50.TextInputConfiguration>(positional, 1, 'configuration', 'attach');
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
// AutofillScopeMixin Bridge
// =============================================================================

BridgedClass _createAutofillScopeMixinBridge() {
  return BridgedClass(
    nativeType: $flutter_12.AutofillScopeMixin,
    name: 'AutofillScopeMixin',
    isAssignable: (v) => v is $flutter_12.AutofillScopeMixin,
    constructors: {
    },
    getters: {
      'autofillClients': (visitor, target) => D4.validateTarget<$flutter_12.AutofillScopeMixin>(target, 'AutofillScopeMixin').autofillClients,
    },
    methods: {
      'attach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillScopeMixin>(target, 'AutofillScopeMixin');
        D4.requireMinArgs(positional, 2, 'attach');
        final trigger = D4.getRequiredArg<$flutter_50.TextInputClient>(positional, 0, 'trigger', 'attach');
        final configuration = D4.getRequiredArg<$flutter_50.TextInputConfiguration>(positional, 1, 'configuration', 'attach');
        return t.attach(trigger, configuration);
      },
      'getAutofillClient': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.AutofillScopeMixin>(target, 'AutofillScopeMixin');
        D4.requireMinArgs(positional, 1, 'getAutofillClient');
        final autofillId = D4.getRequiredArg<String>(positional, 0, 'autofillId', 'getAutofillClient');
        return t.getAutofillClient(autofillId);
      },
    },
    methodSignatures: {
      'attach': 'TextInputConnection attach(TextInputClient trigger, TextInputConfiguration configuration)',
      'getAutofillClient': 'AutofillClient? getAutofillClient(String autofillId)',
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
    nativeType: $flutter_47.TextSelection,
    name: 'TextSelection',
    isAssignable: (v) => v is $flutter_47.TextSelection,
    constructors: {
      '': (visitor, positional, named) {
        final baseOffset = D4.getRequiredNamedArg<int>(named, 'baseOffset', 'TextSelection');
        final extentOffset = D4.getRequiredNamedArg<int>(named, 'extentOffset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        final isDirectional = D4.getNamedArgWithDefault<bool>(named, 'isDirectional', false);
        return $flutter_47.TextSelection(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'collapsed': (visitor, positional, named) {
        final offset = D4.getRequiredNamedArg<int>(named, 'offset', 'TextSelection');
        final affinity = D4.getNamedArgWithDefault<TextAffinity>(named, 'affinity', $dart_ui.TextAffinity.downstream);
        return $flutter_47.TextSelection.collapsed(offset: offset, affinity: affinity);
      },
      'fromPosition': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextSelection');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'TextSelection');
        return $flutter_47.TextSelection.fromPosition(position);
      },
    },
    getters: {
      'baseOffset': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').baseOffset,
      'extentOffset': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').extentOffset,
      'affinity': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').affinity,
      'isDirectional': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').isDirectional,
      'base': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').base,
      'extent': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').extent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').hashCode,
      'start': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').start,
      'end': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').end,
      'isValid': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').isValid,
      'isCollapsed': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').isCollapsed,
      'isNormalized': (visitor, target) => D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection').isNormalized,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
        return t.toString();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
        final baseOffset = D4.getOptionalNamedArg<int?>(named, 'baseOffset');
        final extentOffset = D4.getOptionalNamedArg<int?>(named, 'extentOffset');
        final affinity = D4.getOptionalNamedArg<TextAffinity?>(named, 'affinity');
        final isDirectional = D4.getOptionalNamedArg<bool?>(named, 'isDirectional');
        return t.copyWith(baseOffset: baseOffset, extentOffset: extentOffset, affinity: affinity, isDirectional: isDirectional);
      },
      'expandTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'expandTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'expandTo');
        final extentAtIndex = D4.getOptionalArgWithDefault<bool>(positional, 1, 'extentAtIndex', false);
        return t.expandTo(position, extentAtIndex);
      },
      'extendTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'extendTo');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'extendTo');
        return t.extendTo(position);
      },
      'textBefore': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textBefore');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textBefore');
        return t.textBefore(text);
      },
      'textAfter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textAfter');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textAfter');
        return t.textAfter(text);
      },
      'textInside': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
        D4.requireMinArgs(positional, 1, 'textInside');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textInside');
        return t.textInside(text);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_47.TextSelection>(target, 'TextSelection');
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
// TextInputType Bridge
// =============================================================================

BridgedClass _createTextInputTypeBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextInputType,
    name: 'TextInputType',
    isAssignable: (v) => v is $flutter_50.TextInputType,
    constructors: {
      'numberWithOptions': (visitor, positional, named) {
        final signed = D4.getNamedArgWithDefault<bool?>(named, 'signed', false);
        final decimal = D4.getNamedArgWithDefault<bool?>(named, 'decimal', false);
        return $flutter_50.TextInputType.numberWithOptions(signed: signed, decimal: decimal);
      },
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$flutter_50.TextInputType>(target, 'TextInputType').index,
      'signed': (visitor, target) => D4.validateTarget<$flutter_50.TextInputType>(target, 'TextInputType').signed,
      'decimal': (visitor, target) => D4.validateTarget<$flutter_50.TextInputType>(target, 'TextInputType').decimal,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.TextInputType>(target, 'TextInputType').hashCode,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputType>(target, 'TextInputType');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputType>(target, 'TextInputType');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputType>(target, 'TextInputType');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'text': (visitor) => $flutter_50.TextInputType.text,
      'multiline': (visitor) => $flutter_50.TextInputType.multiline,
      'number': (visitor) => $flutter_50.TextInputType.number,
      'phone': (visitor) => $flutter_50.TextInputType.phone,
      'datetime': (visitor) => $flutter_50.TextInputType.datetime,
      'emailAddress': (visitor) => $flutter_50.TextInputType.emailAddress,
      'url': (visitor) => $flutter_50.TextInputType.url,
      'visiblePassword': (visitor) => $flutter_50.TextInputType.visiblePassword,
      'name': (visitor) => $flutter_50.TextInputType.name,
      'streetAddress': (visitor) => $flutter_50.TextInputType.streetAddress,
      'none': (visitor) => $flutter_50.TextInputType.none,
      'webSearch': (visitor) => $flutter_50.TextInputType.webSearch,
      'twitter': (visitor) => $flutter_50.TextInputType.twitter,
      'values': (visitor) => $flutter_50.TextInputType.values,
    },
    constructorSignatures: {
      'numberWithOptions': 'const TextInputType.numberWithOptions({bool? signed = false, bool? decimal = false})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'index': 'int get index',
      'signed': 'bool? get signed',
      'decimal': 'bool? get decimal',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'text': 'TextInputType get text',
      'multiline': 'TextInputType get multiline',
      'number': 'TextInputType get number',
      'phone': 'TextInputType get phone',
      'datetime': 'TextInputType get datetime',
      'emailAddress': 'TextInputType get emailAddress',
      'url': 'TextInputType get url',
      'visiblePassword': 'TextInputType get visiblePassword',
      'name': 'TextInputType get name',
      'streetAddress': 'TextInputType get streetAddress',
      'none': 'TextInputType get none',
      'webSearch': 'TextInputType get webSearch',
      'twitter': 'TextInputType get twitter',
      'values': 'List<TextInputType> get values',
    },
  );
}

// =============================================================================
// TextInputConfiguration Bridge
// =============================================================================

BridgedClass _createTextInputConfigurationBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextInputConfiguration,
    name: 'TextInputConfiguration',
    isAssignable: (v) => v is $flutter_50.TextInputConfiguration,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final inputType = D4.getNamedArgWithDefault<$flutter_50.TextInputType>(named, 'inputType', $flutter_50.TextInputType.text);
        final readOnly = D4.getNamedArgWithDefault<bool>(named, 'readOnly', false);
        final obscureText = D4.getNamedArgWithDefault<bool>(named, 'obscureText', false);
        final autocorrect = D4.getNamedArgWithDefault<bool>(named, 'autocorrect', true);
        final smartDashesType = D4.getOptionalNamedArg<$flutter_50.SmartDashesType?>(named, 'smartDashesType');
        final smartQuotesType = D4.getOptionalNamedArg<$flutter_50.SmartQuotesType?>(named, 'smartQuotesType');
        final enableSuggestions = D4.getNamedArgWithDefault<bool>(named, 'enableSuggestions', true);
        final enableInteractiveSelection = D4.getNamedArgWithDefault<bool>(named, 'enableInteractiveSelection', true);
        final actionLabel = D4.getOptionalNamedArg<String?>(named, 'actionLabel');
        final inputAction = D4.getNamedArgWithDefault<$flutter_50.TextInputAction>(named, 'inputAction', $flutter_50.TextInputAction.done);
        final keyboardAppearance = D4.getNamedArgWithDefault<Brightness>(named, 'keyboardAppearance', $dart_ui.Brightness.light);
        final textCapitalization = D4.getNamedArgWithDefault<$flutter_50.TextCapitalization>(named, 'textCapitalization', $flutter_50.TextCapitalization.none);
        final autofillConfiguration = D4.getNamedArgWithDefault<$flutter_12.AutofillConfiguration>(named, 'autofillConfiguration', $flutter_12.AutofillConfiguration.disabled);
        final enableIMEPersonalizedLearning = D4.getNamedArgWithDefault<bool>(named, 'enableIMEPersonalizedLearning', true);
        final allowedMimeTypes = named.containsKey('allowedMimeTypes') && named['allowedMimeTypes'] != null
            ? D4.coerceList<String>(named['allowedMimeTypes'], 'allowedMimeTypes')
            : const <String>[];
        final enableDeltaModel = D4.getNamedArgWithDefault<bool>(named, 'enableDeltaModel', false);
        final hintLocales = named.containsKey('hintLocales') && named['hintLocales'] != null
            ? D4.coerceListOrNull<Locale>(named['hintLocales'], 'hintLocales')
            : const <Locale>[];
        return $flutter_50.TextInputConfiguration(viewId: viewId, inputType: inputType, readOnly: readOnly, obscureText: obscureText, autocorrect: autocorrect, smartDashesType: smartDashesType, smartQuotesType: smartQuotesType, enableSuggestions: enableSuggestions, enableInteractiveSelection: enableInteractiveSelection, actionLabel: actionLabel, inputAction: inputAction, keyboardAppearance: keyboardAppearance, textCapitalization: textCapitalization, autofillConfiguration: autofillConfiguration, enableIMEPersonalizedLearning: enableIMEPersonalizedLearning, allowedMimeTypes: allowedMimeTypes, enableDeltaModel: enableDeltaModel, hintLocales: hintLocales);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').viewId,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').inputType,
      'readOnly': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').readOnly,
      'obscureText': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').obscureText,
      'autocorrect': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').autocorrect,
      'autofillConfiguration': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').autofillConfiguration,
      'smartDashesType': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').smartDashesType,
      'smartQuotesType': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').smartQuotesType,
      'enableSuggestions': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').enableSuggestions,
      'enableInteractiveSelection': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').enableInteractiveSelection,
      'actionLabel': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').actionLabel,
      'inputAction': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').inputAction,
      'textCapitalization': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').textCapitalization,
      'keyboardAppearance': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').keyboardAppearance,
      'enableIMEPersonalizedLearning': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').enableIMEPersonalizedLearning,
      'allowedMimeTypes': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').allowedMimeTypes,
      'hintLocales': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').hintLocales,
      'enableDeltaModel': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').enableDeltaModel,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration');
        final viewId = D4.getOptionalNamedArg<int?>(named, 'viewId');
        final inputType = D4.getOptionalNamedArg<$flutter_50.TextInputType?>(named, 'inputType');
        final readOnly = D4.getOptionalNamedArg<bool?>(named, 'readOnly');
        final obscureText = D4.getOptionalNamedArg<bool?>(named, 'obscureText');
        final autocorrect = D4.getOptionalNamedArg<bool?>(named, 'autocorrect');
        final smartDashesType = D4.getOptionalNamedArg<$flutter_50.SmartDashesType?>(named, 'smartDashesType');
        final smartQuotesType = D4.getOptionalNamedArg<$flutter_50.SmartQuotesType?>(named, 'smartQuotesType');
        final enableSuggestions = D4.getOptionalNamedArg<bool?>(named, 'enableSuggestions');
        final enableInteractiveSelection = D4.getOptionalNamedArg<bool?>(named, 'enableInteractiveSelection');
        final actionLabel = D4.getOptionalNamedArg<String?>(named, 'actionLabel');
        final inputAction = D4.getOptionalNamedArg<$flutter_50.TextInputAction?>(named, 'inputAction');
        final keyboardAppearance = D4.getOptionalNamedArg<Brightness?>(named, 'keyboardAppearance');
        final textCapitalization = D4.getOptionalNamedArg<$flutter_50.TextCapitalization?>(named, 'textCapitalization');
        final enableIMEPersonalizedLearning = D4.getOptionalNamedArg<bool?>(named, 'enableIMEPersonalizedLearning');
        final allowedMimeTypes = D4.coerceListOrNull<String>(named['allowedMimeTypes'], 'allowedMimeTypes');
        final autofillConfiguration = D4.getOptionalNamedArg<$flutter_12.AutofillConfiguration?>(named, 'autofillConfiguration');
        final enableDeltaModel = D4.getOptionalNamedArg<bool?>(named, 'enableDeltaModel');
        final hintLocales = D4.coerceListOrNull<Locale>(named['hintLocales'], 'hintLocales');
        return t.copyWith(viewId: viewId, inputType: inputType, readOnly: readOnly, obscureText: obscureText, autocorrect: autocorrect, smartDashesType: smartDashesType, smartQuotesType: smartQuotesType, enableSuggestions: enableSuggestions, enableInteractiveSelection: enableInteractiveSelection, actionLabel: actionLabel, inputAction: inputAction, keyboardAppearance: keyboardAppearance, textCapitalization: textCapitalization, enableIMEPersonalizedLearning: enableIMEPersonalizedLearning, allowedMimeTypes: allowedMimeTypes, autofillConfiguration: autofillConfiguration, enableDeltaModel: enableDeltaModel, hintLocales: hintLocales);
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConfiguration>(target, 'TextInputConfiguration');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const TextInputConfiguration({int? viewId, TextInputType inputType = TextInputType.text, bool readOnly = false, bool obscureText = false, bool autocorrect = true, SmartDashesType? smartDashesType, SmartQuotesType? smartQuotesType, bool enableSuggestions = true, bool enableInteractiveSelection = true, String? actionLabel, TextInputAction inputAction = TextInputAction.done, Brightness keyboardAppearance = Brightness.light, TextCapitalization textCapitalization = TextCapitalization.none, AutofillConfiguration autofillConfiguration = AutofillConfiguration.disabled, bool enableIMEPersonalizedLearning = true, List<String> allowedMimeTypes = const <String>[], bool enableDeltaModel = false, List<Locale>? hintLocales = const <Locale>[]})',
    },
    methodSignatures: {
      'copyWith': 'TextInputConfiguration copyWith({int? viewId, TextInputType? inputType, bool? readOnly, bool? obscureText, bool? autocorrect, SmartDashesType? smartDashesType, SmartQuotesType? smartQuotesType, bool? enableSuggestions, bool? enableInteractiveSelection, String? actionLabel, TextInputAction? inputAction, Brightness? keyboardAppearance, TextCapitalization? textCapitalization, bool? enableIMEPersonalizedLearning, List<String>? allowedMimeTypes, AutofillConfiguration? autofillConfiguration, bool? enableDeltaModel, List<Locale>? hintLocales})',
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'viewId': 'int? get viewId',
      'inputType': 'TextInputType get inputType',
      'readOnly': 'bool get readOnly',
      'obscureText': 'bool get obscureText',
      'autocorrect': 'bool get autocorrect',
      'autofillConfiguration': 'AutofillConfiguration get autofillConfiguration',
      'smartDashesType': 'SmartDashesType get smartDashesType',
      'smartQuotesType': 'SmartQuotesType get smartQuotesType',
      'enableSuggestions': 'bool get enableSuggestions',
      'enableInteractiveSelection': 'bool get enableInteractiveSelection',
      'actionLabel': 'String? get actionLabel',
      'inputAction': 'TextInputAction get inputAction',
      'textCapitalization': 'TextCapitalization get textCapitalization',
      'keyboardAppearance': 'Brightness get keyboardAppearance',
      'enableIMEPersonalizedLearning': 'bool get enableIMEPersonalizedLearning',
      'allowedMimeTypes': 'List<String> get allowedMimeTypes',
      'hintLocales': 'List<Locale>? get hintLocales',
      'enableDeltaModel': 'bool get enableDeltaModel',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// RawFloatingCursorPoint Bridge
// =============================================================================

BridgedClass _createRawFloatingCursorPointBridge() {
  return BridgedClass(
    nativeType: $flutter_50.RawFloatingCursorPoint,
    name: 'RawFloatingCursorPoint',
    isAssignable: (v) => v is $flutter_50.RawFloatingCursorPoint,
    constructors: {
      '': (visitor, positional, named) {
        final offset = D4.getOptionalNamedArg<Offset?>(named, 'offset');
        final startLocation = D4.getOptionalNamedArg<(Offset, $flutter_47.TextPosition)?>(named, 'startLocation');
        final state = D4.getRequiredNamedArg<$flutter_50.FloatingCursorDragState>(named, 'state', 'RawFloatingCursorPoint');
        return $flutter_50.RawFloatingCursorPoint(offset: offset, startLocation: startLocation, state: state);
      },
    },
    getters: {
      'offset': (visitor, target) => D4.validateTarget<$flutter_50.RawFloatingCursorPoint>(target, 'RawFloatingCursorPoint').offset,
      'startLocation': (visitor, target) => D4.validateTarget<$flutter_50.RawFloatingCursorPoint>(target, 'RawFloatingCursorPoint').startLocation,
      'state': (visitor, target) => D4.validateTarget<$flutter_50.RawFloatingCursorPoint>(target, 'RawFloatingCursorPoint').state,
    },
    constructorSignatures: {
      '': 'RawFloatingCursorPoint({Offset? offset, (Offset, TextPosition)? startLocation, required FloatingCursorDragState state})',
    },
    getterSignatures: {
      'offset': 'Offset? get offset',
      'startLocation': '(Offset, TextPosition)? get startLocation',
      'state': 'FloatingCursorDragState get state',
    },
  );
}

// =============================================================================
// TextEditingValue Bridge
// =============================================================================

BridgedClass _createTextEditingValueBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextEditingValue,
    name: 'TextEditingValue',
    isAssignable: (v) => v is $flutter_50.TextEditingValue,
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getNamedArgWithDefault<String>(named, 'text', '');
        final selection = D4.getNamedArgWithDefault<$flutter_47.TextSelection>(named, 'selection', const $flutter_47.TextSelection.collapsed(offset: -1));
        final composing = D4.getNamedArgWithDefault<TextRange>(named, 'composing', $dart_ui.TextRange.empty);
        return $flutter_50.TextEditingValue(text: text, selection: selection, composing: composing);
      },
      'fromJSON': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextEditingValue');
        if (positional.isEmpty) {
          throw ArgumentError('TextEditingValue: Missing required argument "encoded" at position 0');
        }
        final encoded = D4.coerceMap<String, dynamic>(positional[0], 'encoded');
        return $flutter_50.TextEditingValue.fromJSON(encoded);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue').text,
      'selection': (visitor, target) => D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue').selection,
      'composing': (visitor, target) => D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue').composing,
      'isComposingRangeValid': (visitor, target) => D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue').isComposingRangeValid,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue');
        final text = D4.getOptionalNamedArg<String?>(named, 'text');
        final selection = D4.getOptionalNamedArg<$flutter_47.TextSelection?>(named, 'selection');
        final composing = D4.getOptionalNamedArg<TextRange?>(named, 'composing');
        return t.copyWith(text: text, selection: selection, composing: composing);
      },
      'replaced': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue');
        D4.requireMinArgs(positional, 2, 'replaced');
        final replacementRange = D4.getRequiredArg<TextRange>(positional, 0, 'replacementRange', 'replaced');
        final replacementString = D4.getRequiredArg<String>(positional, 1, 'replacementString', 'replaced');
        return t.replaced(replacementRange, replacementString);
      },
      'toJSON': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue');
        return t.toJSON();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextEditingValue>(target, 'TextEditingValue');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'empty': (visitor) => $flutter_50.TextEditingValue.empty,
    },
    constructorSignatures: {
      '': 'const TextEditingValue({String text = \'\', TextSelection selection = const TextSelection.collapsed(offset: -1), TextRange composing = TextRange.empty})',
      'fromJSON': 'factory TextEditingValue.fromJSON(Map<String, dynamic> encoded)',
    },
    methodSignatures: {
      'copyWith': 'TextEditingValue copyWith({String? text, TextSelection? selection, TextRange? composing})',
      'replaced': 'TextEditingValue replaced(TextRange replacementRange, String replacementString)',
      'toJSON': 'Map<String, dynamic> toJSON()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'text': 'String get text',
      'selection': 'TextSelection get selection',
      'composing': 'TextRange get composing',
      'isComposingRangeValid': 'bool get isComposingRangeValid',
      'hashCode': 'int get hashCode',
    },
    staticGetterSignatures: {
      'empty': 'TextEditingValue get empty',
    },
  );
}

// =============================================================================
// TextSelectionDelegate Bridge
// =============================================================================

BridgedClass _createTextSelectionDelegateBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextSelectionDelegate,
    name: 'TextSelectionDelegate',
    isAssignable: (v) => v is $flutter_50.TextSelectionDelegate,
    constructors: {
    },
    getters: {
      'textEditingValue': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').textEditingValue,
      'cutEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').cutEnabled,
      'copyEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').copyEnabled,
      'pasteEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').pasteEnabled,
      'selectAllEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').selectAllEnabled,
      'lookUpEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').lookUpEnabled,
      'searchWebEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').searchWebEnabled,
      'shareEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').shareEnabled,
      'liveTextInputEnabled': (visitor, target) => D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate').liveTextInputEnabled,
    },
    methods: {
      'userUpdateTextEditingValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate');
        D4.requireMinArgs(positional, 2, 'userUpdateTextEditingValue');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'userUpdateTextEditingValue');
        final cause = D4.getRequiredArg<$flutter_50.SelectionChangedCause>(positional, 1, 'cause', 'userUpdateTextEditingValue');
        t.userUpdateTextEditingValue(value, cause);
        return null;
      },
      'hideToolbar': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate');
        final hideHandles = D4.getOptionalArgWithDefault<bool>(positional, 0, 'hideHandles', true);
        t.hideToolbar(hideHandles);
        return null;
      },
      'bringIntoView': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate');
        D4.requireMinArgs(positional, 1, 'bringIntoView');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'bringIntoView');
        t.bringIntoView(position);
        return null;
      },
      'cutSelection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate');
        D4.requireMinArgs(positional, 1, 'cutSelection');
        final cause = D4.getRequiredArg<$flutter_50.SelectionChangedCause>(positional, 0, 'cause', 'cutSelection');
        t.cutSelection(cause);
        return null;
      },
      'pasteText': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate');
        D4.requireMinArgs(positional, 1, 'pasteText');
        final cause = D4.getRequiredArg<$flutter_50.SelectionChangedCause>(positional, 0, 'cause', 'pasteText');
        return t.pasteText(cause);
      },
      'selectAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate');
        D4.requireMinArgs(positional, 1, 'selectAll');
        final cause = D4.getRequiredArg<$flutter_50.SelectionChangedCause>(positional, 0, 'cause', 'selectAll');
        t.selectAll(cause);
        return null;
      },
      'copySelection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextSelectionDelegate>(target, 'TextSelectionDelegate');
        D4.requireMinArgs(positional, 1, 'copySelection');
        final cause = D4.getRequiredArg<$flutter_50.SelectionChangedCause>(positional, 0, 'cause', 'copySelection');
        t.copySelection(cause);
        return null;
      },
    },
    methodSignatures: {
      'userUpdateTextEditingValue': 'void userUpdateTextEditingValue(TextEditingValue value, SelectionChangedCause cause)',
      'hideToolbar': 'void hideToolbar([bool hideHandles = true])',
      'bringIntoView': 'void bringIntoView(TextPosition position)',
      'cutSelection': 'void cutSelection(SelectionChangedCause cause)',
      'pasteText': 'Future<void> pasteText(SelectionChangedCause cause)',
      'selectAll': 'void selectAll(SelectionChangedCause cause)',
      'copySelection': 'void copySelection(SelectionChangedCause cause)',
    },
    getterSignatures: {
      'textEditingValue': 'TextEditingValue get textEditingValue',
      'cutEnabled': 'bool get cutEnabled',
      'copyEnabled': 'bool get copyEnabled',
      'pasteEnabled': 'bool get pasteEnabled',
      'selectAllEnabled': 'bool get selectAllEnabled',
      'lookUpEnabled': 'bool get lookUpEnabled',
      'searchWebEnabled': 'bool get searchWebEnabled',
      'shareEnabled': 'bool get shareEnabled',
      'liveTextInputEnabled': 'bool get liveTextInputEnabled',
    },
  );
}

// =============================================================================
// TextInputClient Bridge
// =============================================================================

BridgedClass _createTextInputClientBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextInputClient,
    name: 'TextInputClient',
    isAssignable: (v) => v is $flutter_50.TextInputClient,
    constructors: {
    },
    getters: {
      'currentTextEditingValue': (visitor, target) => D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient').currentTextEditingValue,
      'currentAutofillScope': (visitor, target) => D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient').currentAutofillScope,
    },
    methods: {
      'updateEditingValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 1, 'updateEditingValue');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'updateEditingValue');
        t.updateEditingValue(value);
        return null;
      },
      'performAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 1, 'performAction');
        final action = D4.getRequiredArg<$flutter_50.TextInputAction>(positional, 0, 'action', 'performAction');
        t.performAction(action);
        return null;
      },
      'insertContent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 1, 'insertContent');
        final content = D4.getRequiredArg<$flutter_24.KeyboardInsertedContent>(positional, 0, 'content', 'insertContent');
        t.insertContent(content);
        return null;
      },
      'performPrivateCommand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 2, 'performPrivateCommand');
        final action = D4.getRequiredArg<String>(positional, 0, 'action', 'performPrivateCommand');
        if (positional.length <= 1) {
          throw ArgumentError('performPrivateCommand: Missing required argument "data" at position 1');
        }
        final data = D4.coerceMap<String, dynamic>(positional[1], 'data');
        t.performPrivateCommand(action, data);
        return null;
      },
      'updateFloatingCursor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 1, 'updateFloatingCursor');
        final point = D4.getRequiredArg<$flutter_50.RawFloatingCursorPoint>(positional, 0, 'point', 'updateFloatingCursor');
        t.updateFloatingCursor(point);
        return null;
      },
      'showAutocorrectionPromptRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 2, 'showAutocorrectionPromptRect');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'showAutocorrectionPromptRect');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'showAutocorrectionPromptRect');
        t.showAutocorrectionPromptRect(start, end);
        return null;
      },
      'connectionClosed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        t.connectionClosed();
        return null;
      },
      'didChangeInputControl': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 2, 'didChangeInputControl');
        final oldControl = D4.getRequiredArg<$flutter_50.TextInputControl?>(positional, 0, 'oldControl', 'didChangeInputControl');
        final newControl = D4.getRequiredArg<$flutter_50.TextInputControl?>(positional, 1, 'newControl', 'didChangeInputControl');
        t.didChangeInputControl(oldControl, newControl);
        return null;
      },
      'showToolbar': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        t.showToolbar();
        return null;
      },
      'insertTextPlaceholder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 1, 'insertTextPlaceholder');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'insertTextPlaceholder');
        t.insertTextPlaceholder(size);
        return null;
      },
      'removeTextPlaceholder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        t.removeTextPlaceholder();
        return null;
      },
      'performSelector': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputClient>(target, 'TextInputClient');
        D4.requireMinArgs(positional, 1, 'performSelector');
        final selectorName = D4.getRequiredArg<String>(positional, 0, 'selectorName', 'performSelector');
        t.performSelector(selectorName);
        return null;
      },
    },
    methodSignatures: {
      'updateEditingValue': 'void updateEditingValue(TextEditingValue value)',
      'performAction': 'void performAction(TextInputAction action)',
      'insertContent': 'void insertContent(KeyboardInsertedContent content)',
      'performPrivateCommand': 'void performPrivateCommand(String action, Map<String, dynamic> data)',
      'updateFloatingCursor': 'void updateFloatingCursor(RawFloatingCursorPoint point)',
      'showAutocorrectionPromptRect': 'void showAutocorrectionPromptRect(int start, int end)',
      'connectionClosed': 'void connectionClosed()',
      'didChangeInputControl': 'void didChangeInputControl(TextInputControl? oldControl, TextInputControl? newControl)',
      'showToolbar': 'void showToolbar()',
      'insertTextPlaceholder': 'void insertTextPlaceholder(Size size)',
      'removeTextPlaceholder': 'void removeTextPlaceholder()',
      'performSelector': 'void performSelector(String selectorName)',
    },
    getterSignatures: {
      'currentTextEditingValue': 'TextEditingValue? get currentTextEditingValue',
      'currentAutofillScope': 'AutofillScope? get currentAutofillScope',
    },
  );
}

// =============================================================================
// ScribbleClient Bridge
// =============================================================================

BridgedClass _createScribbleClientBridge() {
  return BridgedClass(
    nativeType: $flutter_50.ScribbleClient,
    name: 'ScribbleClient',
    isAssignable: (v) => v is $flutter_50.ScribbleClient,
    constructors: {
    },
    getters: {
      'elementIdentifier': (visitor, target) => D4.validateTarget<$flutter_50.ScribbleClient>(target, 'ScribbleClient').elementIdentifier,
      'bounds': (visitor, target) => D4.validateTarget<$flutter_50.ScribbleClient>(target, 'ScribbleClient').bounds,
    },
    methods: {
      'onScribbleFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.ScribbleClient>(target, 'ScribbleClient');
        D4.requireMinArgs(positional, 1, 'onScribbleFocus');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'onScribbleFocus');
        t.onScribbleFocus(offset);
        return null;
      },
      'isInScribbleRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.ScribbleClient>(target, 'ScribbleClient');
        D4.requireMinArgs(positional, 1, 'isInScribbleRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'isInScribbleRect');
        return t.isInScribbleRect(rect);
      },
    },
    methodSignatures: {
      'onScribbleFocus': 'void onScribbleFocus(Offset offset)',
      'isInScribbleRect': 'bool isInScribbleRect(Rect rect)',
    },
    getterSignatures: {
      'elementIdentifier': 'String get elementIdentifier',
      'bounds': 'Rect get bounds',
    },
  );
}

// =============================================================================
// SelectionRect Bridge
// =============================================================================

BridgedClass _createSelectionRectBridge() {
  return BridgedClass(
    nativeType: $flutter_50.SelectionRect,
    name: 'SelectionRect',
    isAssignable: (v) => v is $flutter_50.SelectionRect,
    constructors: {
      '': (visitor, positional, named) {
        final position = D4.getRequiredNamedArg<int>(named, 'position', 'SelectionRect');
        final bounds = D4.getRequiredNamedArg<Rect>(named, 'bounds', 'SelectionRect');
        final direction = D4.getNamedArgWithDefault<TextDirection>(named, 'direction', $dart_ui.TextDirection.ltr);
        return $flutter_50.SelectionRect(position: position, bounds: bounds, direction: direction);
      },
    },
    getters: {
      'position': (visitor, target) => D4.validateTarget<$flutter_50.SelectionRect>(target, 'SelectionRect').position,
      'bounds': (visitor, target) => D4.validateTarget<$flutter_50.SelectionRect>(target, 'SelectionRect').bounds,
      'direction': (visitor, target) => D4.validateTarget<$flutter_50.SelectionRect>(target, 'SelectionRect').direction,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.SelectionRect>(target, 'SelectionRect').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SelectionRect>(target, 'SelectionRect');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SelectionRect>(target, 'SelectionRect');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const SelectionRect({required int position, required Rect bounds, TextDirection direction = TextDirection.ltr})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'position': 'int get position',
      'bounds': 'Rect get bounds',
      'direction': 'TextDirection get direction',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// DeltaTextInputClient Bridge
// =============================================================================

BridgedClass _createDeltaTextInputClientBridge() {
  return BridgedClass(
    nativeType: $flutter_50.DeltaTextInputClient,
    name: 'DeltaTextInputClient',
    isAssignable: (v) => v is $flutter_50.DeltaTextInputClient,
    constructors: {
    },
    getters: {
      'currentTextEditingValue': (visitor, target) => D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient').currentTextEditingValue,
      'currentAutofillScope': (visitor, target) => D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient').currentAutofillScope,
    },
    methods: {
      'updateEditingValueWithDeltas': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 1, 'updateEditingValueWithDeltas');
        if (positional.isEmpty) {
          throw ArgumentError('updateEditingValueWithDeltas: Missing required argument "textEditingDeltas" at position 0');
        }
        final textEditingDeltas = D4.coerceList<$flutter_48.TextEditingDelta>(positional[0], 'textEditingDeltas');
        t.updateEditingValueWithDeltas(textEditingDeltas);
        return null;
      },
      'updateEditingValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 1, 'updateEditingValue');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'updateEditingValue');
        t.updateEditingValue(value);
        return null;
      },
      'performAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 1, 'performAction');
        final action = D4.getRequiredArg<$flutter_50.TextInputAction>(positional, 0, 'action', 'performAction');
        t.performAction(action);
        return null;
      },
      'insertContent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 1, 'insertContent');
        final content = D4.getRequiredArg<$flutter_24.KeyboardInsertedContent>(positional, 0, 'content', 'insertContent');
        t.insertContent(content);
        return null;
      },
      'performPrivateCommand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 2, 'performPrivateCommand');
        final action = D4.getRequiredArg<String>(positional, 0, 'action', 'performPrivateCommand');
        if (positional.length <= 1) {
          throw ArgumentError('performPrivateCommand: Missing required argument "data" at position 1');
        }
        final data = D4.coerceMap<String, dynamic>(positional[1], 'data');
        t.performPrivateCommand(action, data);
        return null;
      },
      'updateFloatingCursor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 1, 'updateFloatingCursor');
        final point = D4.getRequiredArg<$flutter_50.RawFloatingCursorPoint>(positional, 0, 'point', 'updateFloatingCursor');
        t.updateFloatingCursor(point);
        return null;
      },
      'showAutocorrectionPromptRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 2, 'showAutocorrectionPromptRect');
        final start = D4.getRequiredArg<int>(positional, 0, 'start', 'showAutocorrectionPromptRect');
        final end = D4.getRequiredArg<int>(positional, 1, 'end', 'showAutocorrectionPromptRect');
        t.showAutocorrectionPromptRect(start, end);
        return null;
      },
      'connectionClosed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        t.connectionClosed();
        return null;
      },
      'didChangeInputControl': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 2, 'didChangeInputControl');
        final oldControl = D4.getRequiredArg<$flutter_50.TextInputControl?>(positional, 0, 'oldControl', 'didChangeInputControl');
        final newControl = D4.getRequiredArg<$flutter_50.TextInputControl?>(positional, 1, 'newControl', 'didChangeInputControl');
        t.didChangeInputControl(oldControl, newControl);
        return null;
      },
      'showToolbar': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        t.showToolbar();
        return null;
      },
      'insertTextPlaceholder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 1, 'insertTextPlaceholder');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'insertTextPlaceholder');
        t.insertTextPlaceholder(size);
        return null;
      },
      'removeTextPlaceholder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        t.removeTextPlaceholder();
        return null;
      },
      'performSelector': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.DeltaTextInputClient>(target, 'DeltaTextInputClient');
        D4.requireMinArgs(positional, 1, 'performSelector');
        final selectorName = D4.getRequiredArg<String>(positional, 0, 'selectorName', 'performSelector');
        t.performSelector(selectorName);
        return null;
      },
    },
    methodSignatures: {
      'updateEditingValueWithDeltas': 'void updateEditingValueWithDeltas(List<TextEditingDelta> textEditingDeltas)',
      'updateEditingValue': 'void updateEditingValue(TextEditingValue value)',
      'performAction': 'void performAction(TextInputAction action)',
      'insertContent': 'void insertContent(KeyboardInsertedContent content)',
      'performPrivateCommand': 'void performPrivateCommand(String action, Map<String, dynamic> data)',
      'updateFloatingCursor': 'void updateFloatingCursor(RawFloatingCursorPoint point)',
      'showAutocorrectionPromptRect': 'void showAutocorrectionPromptRect(int start, int end)',
      'connectionClosed': 'void connectionClosed()',
      'didChangeInputControl': 'void didChangeInputControl(TextInputControl? oldControl, TextInputControl? newControl)',
      'showToolbar': 'void showToolbar()',
      'insertTextPlaceholder': 'void insertTextPlaceholder(Size size)',
      'removeTextPlaceholder': 'void removeTextPlaceholder()',
      'performSelector': 'void performSelector(String selectorName)',
    },
    getterSignatures: {
      'currentTextEditingValue': 'TextEditingValue? get currentTextEditingValue',
      'currentAutofillScope': 'AutofillScope? get currentAutofillScope',
    },
  );
}

// =============================================================================
// TextInputConnection Bridge
// =============================================================================

BridgedClass _createTextInputConnectionBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextInputConnection,
    name: 'TextInputConnection',
    isAssignable: (v) => v is $flutter_50.TextInputConnection,
    constructors: {
    },
    getters: {
      'attached': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection').attached,
      'scribbleInProgress': (visitor, target) => D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection').scribbleInProgress,
    },
    methods: {
      'show': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        t.show();
        return null;
      },
      'requestAutofill': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        t.requestAutofill();
        return null;
      },
      'updateConfig': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        D4.requireMinArgs(positional, 1, 'updateConfig');
        final configuration = D4.getRequiredArg<$flutter_50.TextInputConfiguration>(positional, 0, 'configuration', 'updateConfig');
        t.updateConfig(configuration);
        return null;
      },
      'setEditingState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        D4.requireMinArgs(positional, 1, 'setEditingState');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'setEditingState');
        t.setEditingState(value);
        return null;
      },
      'setEditableSizeAndTransform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        D4.requireMinArgs(positional, 2, 'setEditableSizeAndTransform');
        final editableBoxSize = D4.getRequiredArg<Size>(positional, 0, 'editableBoxSize', 'setEditableSizeAndTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 1, 'transform', 'setEditableSizeAndTransform');
        t.setEditableSizeAndTransform(editableBoxSize, transform);
        return null;
      },
      'setComposingRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        D4.requireMinArgs(positional, 1, 'setComposingRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'setComposingRect');
        t.setComposingRect(rect);
        return null;
      },
      'setCaretRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        D4.requireMinArgs(positional, 1, 'setCaretRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'setCaretRect');
        t.setCaretRect(rect);
        return null;
      },
      'setSelectionRects': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        D4.requireMinArgs(positional, 1, 'setSelectionRects');
        if (positional.isEmpty) {
          throw ArgumentError('setSelectionRects: Missing required argument "selectionRects" at position 0');
        }
        final selectionRects = D4.coerceList<$flutter_50.SelectionRect>(positional[0], 'selectionRects');
        t.setSelectionRects(selectionRects);
        return null;
      },
      'setStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        final fontFamily = D4.getRequiredNamedArg<String?>(named, 'fontFamily', 'setStyle');
        final fontSize = D4.getRequiredNamedArg<double?>(named, 'fontSize', 'setStyle');
        final fontWeight = D4.getRequiredNamedArg<FontWeight?>(named, 'fontWeight', 'setStyle');
        final textDirection = D4.getRequiredNamedArg<TextDirection>(named, 'textDirection', 'setStyle');
        final textAlign = D4.getRequiredNamedArg<TextAlign>(named, 'textAlign', 'setStyle');
        t.setStyle(fontFamily: fontFamily, fontSize: fontSize, fontWeight: fontWeight, textDirection: textDirection, textAlign: textAlign);
        return null;
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        t.close();
        return null;
      },
      'connectionClosedReceived': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputConnection>(target, 'TextInputConnection');
        t.connectionClosedReceived();
        return null;
      },
    },
    methodSignatures: {
      'show': 'void show()',
      'requestAutofill': 'void requestAutofill()',
      'updateConfig': 'void updateConfig(TextInputConfiguration configuration)',
      'setEditingState': 'void setEditingState(TextEditingValue value)',
      'setEditableSizeAndTransform': 'void setEditableSizeAndTransform(Size editableBoxSize, Matrix4 transform)',
      'setComposingRect': 'void setComposingRect(Rect rect)',
      'setCaretRect': 'void setCaretRect(Rect rect)',
      'setSelectionRects': 'void setSelectionRects(List<SelectionRect> selectionRects)',
      'setStyle': 'void setStyle({required String? fontFamily, required double? fontSize, required FontWeight? fontWeight, required TextDirection textDirection, required TextAlign textAlign})',
      'close': 'void close()',
      'connectionClosedReceived': 'void connectionClosedReceived()',
    },
    getterSignatures: {
      'attached': 'bool get attached',
      'scribbleInProgress': 'bool get scribbleInProgress',
    },
  );
}

// =============================================================================
// TextInput Bridge
// =============================================================================

BridgedClass _createTextInputBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextInput,
    name: 'TextInput',
    isAssignable: (v) => v is $flutter_50.TextInput,
    constructors: {
    },
    getters: {
      'scribbleInProgress': (visitor, target) => D4.validateTarget<$flutter_50.TextInput>(target, 'TextInput').scribbleInProgress,
    },
    staticMethods: {
      'setInputControl': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setInputControl');
        final newControl = D4.getRequiredArg<$flutter_50.TextInputControl?>(positional, 0, 'newControl', 'setInputControl');
        return $flutter_50.TextInput.setInputControl(newControl);
      },
      'restorePlatformInputControl': (visitor, positional, named, typeArgs) {
        return $flutter_50.TextInput.restorePlatformInputControl();
      },
      'ensureInitialized': (visitor, positional, named, typeArgs) {
        return $flutter_50.TextInput.ensureInitialized();
      },
      'attach': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'attach');
        final client = D4.getRequiredArg<$flutter_50.TextInputClient>(positional, 0, 'client', 'attach');
        final configuration = D4.getRequiredArg<$flutter_50.TextInputConfiguration>(positional, 1, 'configuration', 'attach');
        return $flutter_50.TextInput.attach(client, configuration);
      },
      'updateEditingValue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'updateEditingValue');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'updateEditingValue');
        return $flutter_50.TextInput.updateEditingValue(value);
      },
      'finishAutofillContext': (visitor, positional, named, typeArgs) {
        final shouldSave = D4.getNamedArgWithDefault<bool>(named, 'shouldSave', true);
        return $flutter_50.TextInput.finishAutofillContext(shouldSave: shouldSave);
      },
      'registerScribbleElement': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'registerScribbleElement');
        final elementIdentifier = D4.getRequiredArg<String>(positional, 0, 'elementIdentifier', 'registerScribbleElement');
        final scribbleClient = D4.getRequiredArg<$flutter_50.ScribbleClient>(positional, 1, 'scribbleClient', 'registerScribbleElement');
        return $flutter_50.TextInput.registerScribbleElement(elementIdentifier, scribbleClient);
      },
      'unregisterScribbleElement': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'unregisterScribbleElement');
        final elementIdentifier = D4.getRequiredArg<String>(positional, 0, 'elementIdentifier', 'unregisterScribbleElement');
        return $flutter_50.TextInput.unregisterScribbleElement(elementIdentifier);
      },
    },
    getterSignatures: {
      'scribbleInProgress': 'bool get scribbleInProgress',
    },
    staticMethodSignatures: {
      'setInputControl': 'void setInputControl(TextInputControl? newControl)',
      'restorePlatformInputControl': 'void restorePlatformInputControl()',
      'ensureInitialized': 'void ensureInitialized()',
      'attach': 'TextInputConnection attach(TextInputClient client, TextInputConfiguration configuration)',
      'updateEditingValue': 'void updateEditingValue(TextEditingValue value)',
      'finishAutofillContext': 'void finishAutofillContext({bool shouldSave = true})',
      'registerScribbleElement': 'void registerScribbleElement(String elementIdentifier, ScribbleClient scribbleClient)',
      'unregisterScribbleElement': 'void unregisterScribbleElement(String elementIdentifier)',
    },
  );
}

// =============================================================================
// TextInputControl Bridge
// =============================================================================

BridgedClass _createTextInputControlBridge() {
  return BridgedClass(
    nativeType: $flutter_50.TextInputControl,
    name: 'TextInputControl',
    isAssignable: (v) => v is $flutter_50.TextInputControl,
    constructors: {
    },
    methods: {
      'attach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 2, 'attach');
        final client = D4.getRequiredArg<$flutter_50.TextInputClient>(positional, 0, 'client', 'attach');
        final configuration = D4.getRequiredArg<$flutter_50.TextInputConfiguration>(positional, 1, 'configuration', 'attach');
        t.attach(client, configuration);
        return null;
      },
      'detach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 1, 'detach');
        final client = D4.getRequiredArg<$flutter_50.TextInputClient>(positional, 0, 'client', 'detach');
        t.detach(client);
        return null;
      },
      'show': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        t.show();
        return null;
      },
      'hide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        t.hide();
        return null;
      },
      'updateConfig': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 1, 'updateConfig');
        final configuration = D4.getRequiredArg<$flutter_50.TextInputConfiguration>(positional, 0, 'configuration', 'updateConfig');
        t.updateConfig(configuration);
        return null;
      },
      'setEditingState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 1, 'setEditingState');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'setEditingState');
        t.setEditingState(value);
        return null;
      },
      'setEditableSizeAndTransform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 2, 'setEditableSizeAndTransform');
        final editableBoxSize = D4.getRequiredArg<Size>(positional, 0, 'editableBoxSize', 'setEditableSizeAndTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 1, 'transform', 'setEditableSizeAndTransform');
        t.setEditableSizeAndTransform(editableBoxSize, transform);
        return null;
      },
      'setComposingRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 1, 'setComposingRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'setComposingRect');
        t.setComposingRect(rect);
        return null;
      },
      'setCaretRect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 1, 'setCaretRect');
        final rect = D4.getRequiredArg<Rect>(positional, 0, 'rect', 'setCaretRect');
        t.setCaretRect(rect);
        return null;
      },
      'setSelectionRects': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        D4.requireMinArgs(positional, 1, 'setSelectionRects');
        if (positional.isEmpty) {
          throw ArgumentError('setSelectionRects: Missing required argument "selectionRects" at position 0');
        }
        final selectionRects = D4.coerceList<$flutter_50.SelectionRect>(positional[0], 'selectionRects');
        t.setSelectionRects(selectionRects);
        return null;
      },
      'setStyle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        final fontFamily = D4.getRequiredNamedArg<String?>(named, 'fontFamily', 'setStyle');
        final fontSize = D4.getRequiredNamedArg<double?>(named, 'fontSize', 'setStyle');
        final fontWeight = D4.getRequiredNamedArg<FontWeight?>(named, 'fontWeight', 'setStyle');
        final textDirection = D4.getRequiredNamedArg<TextDirection>(named, 'textDirection', 'setStyle');
        final textAlign = D4.getRequiredNamedArg<TextAlign>(named, 'textAlign', 'setStyle');
        t.setStyle(fontFamily: fontFamily, fontSize: fontSize, fontWeight: fontWeight, textDirection: textDirection, textAlign: textAlign);
        return null;
      },
      'requestAutofill': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        t.requestAutofill();
        return null;
      },
      'finishAutofillContext': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.TextInputControl>(target, 'TextInputControl');
        final shouldSave = D4.getNamedArgWithDefault<bool>(named, 'shouldSave', true);
        t.finishAutofillContext(shouldSave: shouldSave);
        return null;
      },
    },
    methodSignatures: {
      'attach': 'void attach(TextInputClient client, TextInputConfiguration configuration)',
      'detach': 'void detach(TextInputClient client)',
      'show': 'void show()',
      'hide': 'void hide()',
      'updateConfig': 'void updateConfig(TextInputConfiguration configuration)',
      'setEditingState': 'void setEditingState(TextEditingValue value)',
      'setEditableSizeAndTransform': 'void setEditableSizeAndTransform(Size editableBoxSize, Matrix4 transform)',
      'setComposingRect': 'void setComposingRect(Rect rect)',
      'setCaretRect': 'void setCaretRect(Rect rect)',
      'setSelectionRects': 'void setSelectionRects(List<SelectionRect> selectionRects)',
      'setStyle': 'void setStyle({required String? fontFamily, required double? fontSize, required FontWeight? fontWeight, required TextDirection textDirection, required TextAlign textAlign})',
      'requestAutofill': 'void requestAutofill()',
      'finishAutofillContext': 'void finishAutofillContext({bool shouldSave = true})',
    },
  );
}

// =============================================================================
// SystemContextMenuController Bridge
// =============================================================================

BridgedClass _createSystemContextMenuControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_50.SystemContextMenuController,
    name: 'SystemContextMenuController',
    isAssignable: (v) => v is $flutter_50.SystemContextMenuController,
    constructors: {
      '': (visitor, positional, named) {
        final onSystemHideRaw = named['onSystemHide'];
        return $flutter_50.SystemContextMenuController(onSystemHide: onSystemHideRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSystemHideRaw, []); });
      },
    },
    getters: {
      'onSystemHide': (visitor, target) => D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController').onSystemHide,
    },
    methods: {
      'handleSystemHide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        t.handleSystemHide();
        return null;
      },
      'handleCustomContextMenuAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        D4.requireMinArgs(positional, 1, 'handleCustomContextMenuAction');
        final callbackId = D4.getRequiredArg<String>(positional, 0, 'callbackId', 'handleCustomContextMenuAction');
        t.handleCustomContextMenuAction(callbackId);
        return null;
      },
      'show': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        D4.requireMinArgs(positional, 1, 'show');
        final targetRect = D4.getRequiredArg<Rect>(positional, 0, 'targetRect', 'show');
        return t.show(targetRect);
      },
      'showWithItems': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        D4.requireMinArgs(positional, 2, 'showWithItems');
        final targetRect = D4.getRequiredArg<Rect>(positional, 0, 'targetRect', 'showWithItems');
        if (positional.length <= 1) {
          throw ArgumentError('showWithItems: Missing required argument "items" at position 1');
        }
        final items = D4.coerceList<$flutter_50.IOSSystemContextMenuItemData>(positional[1], 'items');
        return t.showWithItems(targetRect, items);
      },
      'hide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        return t.hide();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        (t as dynamic).dispose();
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.SystemContextMenuController>(target, 'SystemContextMenuController');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'SystemContextMenuController({void Function()? onSystemHide})',
    },
    methodSignatures: {
      'handleSystemHide': 'void handleSystemHide()',
      'handleCustomContextMenuAction': 'void handleCustomContextMenuAction(String callbackId)',
      'show': 'Future<void> show(Rect targetRect)',
      'showWithItems': 'Future<void> showWithItems(Rect targetRect, List<IOSSystemContextMenuItemData> items)',
      'hide': 'Future<void> hide()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'dispose': 'void dispose()',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'onSystemHide': 'VoidCallback? get onSystemHide',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemData Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemData,
    name: 'IOSSystemContextMenuItemData',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemData,
    constructors: {
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemData>(target, 'IOSSystemContextMenuItemData').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemData>(target, 'IOSSystemContextMenuItemData').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemData>(target, 'IOSSystemContextMenuItemData');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemData()',
    },
    getterSignatures: {
      'title': 'String? get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataCopy Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataCopyBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataCopy,
    name: 'IOSSystemContextMenuItemDataCopy',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataCopy,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_50.IOSSystemContextMenuItemDataCopy();
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCopy>(target, 'IOSSystemContextMenuItemDataCopy').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCopy>(target, 'IOSSystemContextMenuItemDataCopy').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCopy>(target, 'IOSSystemContextMenuItemDataCopy');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataCopy()',
    },
    getterSignatures: {
      'title': 'String? get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataCut Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataCutBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataCut,
    name: 'IOSSystemContextMenuItemDataCut',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataCut,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_50.IOSSystemContextMenuItemDataCut();
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCut>(target, 'IOSSystemContextMenuItemDataCut').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCut>(target, 'IOSSystemContextMenuItemDataCut').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCut>(target, 'IOSSystemContextMenuItemDataCut');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataCut()',
    },
    getterSignatures: {
      'title': 'String? get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataPaste Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataPasteBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataPaste,
    name: 'IOSSystemContextMenuItemDataPaste',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataPaste,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_50.IOSSystemContextMenuItemDataPaste();
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataPaste>(target, 'IOSSystemContextMenuItemDataPaste').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataPaste>(target, 'IOSSystemContextMenuItemDataPaste').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataPaste>(target, 'IOSSystemContextMenuItemDataPaste');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataPaste()',
    },
    getterSignatures: {
      'title': 'String? get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataSelectAll Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataSelectAllBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataSelectAll,
    name: 'IOSSystemContextMenuItemDataSelectAll',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataSelectAll,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_50.IOSSystemContextMenuItemDataSelectAll();
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSelectAll>(target, 'IOSSystemContextMenuItemDataSelectAll').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSelectAll>(target, 'IOSSystemContextMenuItemDataSelectAll').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSelectAll>(target, 'IOSSystemContextMenuItemDataSelectAll');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataSelectAll()',
    },
    getterSignatures: {
      'title': 'String? get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataLookUp Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataLookUpBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataLookUp,
    name: 'IOSSystemContextMenuItemDataLookUp',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataLookUp,
    constructors: {
      '': (visitor, positional, named) {
        final title = D4.getRequiredNamedArg<String>(named, 'title', 'IOSSystemContextMenuItemDataLookUp');
        return $flutter_50.IOSSystemContextMenuItemDataLookUp(title: title);
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLookUp>(target, 'IOSSystemContextMenuItemDataLookUp').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLookUp>(target, 'IOSSystemContextMenuItemDataLookUp').hashCode,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLookUp>(target, 'IOSSystemContextMenuItemDataLookUp');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLookUp>(target, 'IOSSystemContextMenuItemDataLookUp');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLookUp>(target, 'IOSSystemContextMenuItemDataLookUp');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLookUp>(target, 'IOSSystemContextMenuItemDataLookUp');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLookUp>(target, 'IOSSystemContextMenuItemDataLookUp');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataLookUp({required String title})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'title': 'String get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataSearchWeb Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataSearchWebBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataSearchWeb,
    name: 'IOSSystemContextMenuItemDataSearchWeb',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataSearchWeb,
    constructors: {
      '': (visitor, positional, named) {
        final title = D4.getRequiredNamedArg<String>(named, 'title', 'IOSSystemContextMenuItemDataSearchWeb');
        return $flutter_50.IOSSystemContextMenuItemDataSearchWeb(title: title);
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSearchWeb>(target, 'IOSSystemContextMenuItemDataSearchWeb').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSearchWeb>(target, 'IOSSystemContextMenuItemDataSearchWeb').hashCode,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSearchWeb>(target, 'IOSSystemContextMenuItemDataSearchWeb');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSearchWeb>(target, 'IOSSystemContextMenuItemDataSearchWeb');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSearchWeb>(target, 'IOSSystemContextMenuItemDataSearchWeb');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSearchWeb>(target, 'IOSSystemContextMenuItemDataSearchWeb');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataSearchWeb>(target, 'IOSSystemContextMenuItemDataSearchWeb');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataSearchWeb({required String title})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'title': 'String get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataShare Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataShareBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataShare,
    name: 'IOSSystemContextMenuItemDataShare',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataShare,
    constructors: {
      '': (visitor, positional, named) {
        final title = D4.getRequiredNamedArg<String>(named, 'title', 'IOSSystemContextMenuItemDataShare');
        return $flutter_50.IOSSystemContextMenuItemDataShare(title: title);
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataShare>(target, 'IOSSystemContextMenuItemDataShare').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataShare>(target, 'IOSSystemContextMenuItemDataShare').hashCode,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataShare>(target, 'IOSSystemContextMenuItemDataShare');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataShare>(target, 'IOSSystemContextMenuItemDataShare');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataShare>(target, 'IOSSystemContextMenuItemDataShare');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataShare>(target, 'IOSSystemContextMenuItemDataShare');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataShare>(target, 'IOSSystemContextMenuItemDataShare');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataShare({required String title})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'title': 'String get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataLiveText Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataLiveTextBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataLiveText,
    name: 'IOSSystemContextMenuItemDataLiveText',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataLiveText,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_50.IOSSystemContextMenuItemDataLiveText();
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLiveText>(target, 'IOSSystemContextMenuItemDataLiveText').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLiveText>(target, 'IOSSystemContextMenuItemDataLiveText').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataLiveText>(target, 'IOSSystemContextMenuItemDataLiveText');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataLiveText()',
    },
    getterSignatures: {
      'title': 'String? get title',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// IOSSystemContextMenuItemDataCustom Bridge
// =============================================================================

BridgedClass _createIOSSystemContextMenuItemDataCustomBridge() {
  return BridgedClass(
    nativeType: $flutter_50.IOSSystemContextMenuItemDataCustom,
    name: 'IOSSystemContextMenuItemDataCustom',
    isAssignable: (v) => v is $flutter_50.IOSSystemContextMenuItemDataCustom,
    constructors: {
      '': (visitor, positional, named) {
        final title = D4.getRequiredNamedArg<String>(named, 'title', 'IOSSystemContextMenuItemDataCustom');
        if (!named.containsKey('onPressed') || named['onPressed'] == null) {
          throw ArgumentError('IOSSystemContextMenuItemDataCustom: Missing required named argument "onPressed"');
        }
        final onPressedRaw = named['onPressed'];
        return $flutter_50.IOSSystemContextMenuItemDataCustom(title: title, onPressed: () { D4.callInterpreterCallback(visitor!, onPressedRaw, []); });
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom').title,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom').hashCode,
      'onPressed': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom').onPressed,
      'callbackId': (visitor, target) => D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom').callbackId,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_50.IOSSystemContextMenuItemDataCustom>(target, 'IOSSystemContextMenuItemDataCustom');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const IOSSystemContextMenuItemDataCustom({required String title, required void Function() onPressed})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'title': 'String get title',
      'hashCode': 'int get hashCode',
      'onPressed': 'VoidCallback get onPressed',
      'callbackId': 'String get callbackId',
    },
  );
}

// =============================================================================
// TextEditingDelta Bridge
// =============================================================================

BridgedClass _createTextEditingDeltaBridge() {
  return BridgedClass(
    nativeType: $flutter_48.TextEditingDelta,
    name: 'TextEditingDelta',
    isAssignable: (v) => v is $flutter_48.TextEditingDelta,
    constructors: {
      'fromJSON': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextEditingDelta');
        if (positional.isEmpty) {
          throw ArgumentError('TextEditingDelta: Missing required argument "encoded" at position 0');
        }
        final encoded = D4.coerceMap<String, dynamic>(positional[0], 'encoded');
        return $flutter_48.TextEditingDelta.fromJSON(encoded);
      },
    },
    getters: {
      'oldText': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta').oldText,
      'selection': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta').selection,
      'composing': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta').composing,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta');
        D4.requireMinArgs(positional, 1, 'apply');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'apply');
        return t.apply(value);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDelta>(target, 'TextEditingDelta');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
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
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
    getterSignatures: {
      'oldText': 'String get oldText',
      'selection': 'TextSelection get selection',
      'composing': 'TextRange get composing',
    },
  );
}

// =============================================================================
// TextEditingDeltaInsertion Bridge
// =============================================================================

BridgedClass _createTextEditingDeltaInsertionBridge() {
  return BridgedClass(
    nativeType: $flutter_48.TextEditingDeltaInsertion,
    name: 'TextEditingDeltaInsertion',
    isAssignable: (v) => v is $flutter_48.TextEditingDeltaInsertion,
    constructors: {
      '': (visitor, positional, named) {
        final oldText = D4.getRequiredNamedArg<String>(named, 'oldText', 'TextEditingDeltaInsertion');
        final textInserted = D4.getRequiredNamedArg<String>(named, 'textInserted', 'TextEditingDeltaInsertion');
        final insertionOffset = D4.getRequiredNamedArg<int>(named, 'insertionOffset', 'TextEditingDeltaInsertion');
        final selection = D4.getRequiredNamedArg<$flutter_47.TextSelection>(named, 'selection', 'TextEditingDeltaInsertion');
        final composing = D4.getRequiredNamedArg<TextRange>(named, 'composing', 'TextEditingDeltaInsertion');
        return $flutter_48.TextEditingDeltaInsertion(oldText: oldText, textInserted: textInserted, insertionOffset: insertionOffset, selection: selection, composing: composing);
      },
    },
    getters: {
      'oldText': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion').oldText,
      'selection': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion').selection,
      'composing': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion').composing,
      'textInserted': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion').textInserted,
      'insertionOffset': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion').insertionOffset,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion');
        D4.requireMinArgs(positional, 1, 'apply');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'apply');
        return t.apply(value);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaInsertion>(target, 'TextEditingDeltaInsertion');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    constructorSignatures: {
      '': 'const TextEditingDeltaInsertion({required String oldText, required String textInserted, required int insertionOffset, required TextSelection selection, required TextRange composing})',
    },
    methodSignatures: {
      'apply': 'TextEditingValue apply(TextEditingValue value)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
    getterSignatures: {
      'oldText': 'String get oldText',
      'selection': 'TextSelection get selection',
      'composing': 'TextRange get composing',
      'textInserted': 'String get textInserted',
      'insertionOffset': 'int get insertionOffset',
    },
  );
}

// =============================================================================
// TextEditingDeltaDeletion Bridge
// =============================================================================

BridgedClass _createTextEditingDeltaDeletionBridge() {
  return BridgedClass(
    nativeType: $flutter_48.TextEditingDeltaDeletion,
    name: 'TextEditingDeltaDeletion',
    isAssignable: (v) => v is $flutter_48.TextEditingDeltaDeletion,
    constructors: {
      '': (visitor, positional, named) {
        final oldText = D4.getRequiredNamedArg<String>(named, 'oldText', 'TextEditingDeltaDeletion');
        final deletedRange = D4.getRequiredNamedArg<TextRange>(named, 'deletedRange', 'TextEditingDeltaDeletion');
        final selection = D4.getRequiredNamedArg<$flutter_47.TextSelection>(named, 'selection', 'TextEditingDeltaDeletion');
        final composing = D4.getRequiredNamedArg<TextRange>(named, 'composing', 'TextEditingDeltaDeletion');
        return $flutter_48.TextEditingDeltaDeletion(oldText: oldText, deletedRange: deletedRange, selection: selection, composing: composing);
      },
    },
    getters: {
      'oldText': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion').oldText,
      'selection': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion').selection,
      'composing': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion').composing,
      'deletedRange': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion').deletedRange,
      'textDeleted': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion').textDeleted,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion');
        D4.requireMinArgs(positional, 1, 'apply');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'apply');
        return t.apply(value);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaDeletion>(target, 'TextEditingDeltaDeletion');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    constructorSignatures: {
      '': 'const TextEditingDeltaDeletion({required String oldText, required TextRange deletedRange, required TextSelection selection, required TextRange composing})',
    },
    methodSignatures: {
      'apply': 'TextEditingValue apply(TextEditingValue value)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
    getterSignatures: {
      'oldText': 'String get oldText',
      'selection': 'TextSelection get selection',
      'composing': 'TextRange get composing',
      'deletedRange': 'TextRange get deletedRange',
      'textDeleted': 'String get textDeleted',
    },
  );
}

// =============================================================================
// TextEditingDeltaReplacement Bridge
// =============================================================================

BridgedClass _createTextEditingDeltaReplacementBridge() {
  return BridgedClass(
    nativeType: $flutter_48.TextEditingDeltaReplacement,
    name: 'TextEditingDeltaReplacement',
    isAssignable: (v) => v is $flutter_48.TextEditingDeltaReplacement,
    constructors: {
      '': (visitor, positional, named) {
        final oldText = D4.getRequiredNamedArg<String>(named, 'oldText', 'TextEditingDeltaReplacement');
        final replacementText = D4.getRequiredNamedArg<String>(named, 'replacementText', 'TextEditingDeltaReplacement');
        final replacedRange = D4.getRequiredNamedArg<TextRange>(named, 'replacedRange', 'TextEditingDeltaReplacement');
        final selection = D4.getRequiredNamedArg<$flutter_47.TextSelection>(named, 'selection', 'TextEditingDeltaReplacement');
        final composing = D4.getRequiredNamedArg<TextRange>(named, 'composing', 'TextEditingDeltaReplacement');
        return $flutter_48.TextEditingDeltaReplacement(oldText: oldText, replacementText: replacementText, replacedRange: replacedRange, selection: selection, composing: composing);
      },
    },
    getters: {
      'oldText': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement').oldText,
      'selection': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement').selection,
      'composing': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement').composing,
      'replacementText': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement').replacementText,
      'replacedRange': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement').replacedRange,
      'textReplaced': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement').textReplaced,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement');
        D4.requireMinArgs(positional, 1, 'apply');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'apply');
        return t.apply(value);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaReplacement>(target, 'TextEditingDeltaReplacement');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    constructorSignatures: {
      '': 'const TextEditingDeltaReplacement({required String oldText, required String replacementText, required TextRange replacedRange, required TextSelection selection, required TextRange composing})',
    },
    methodSignatures: {
      'apply': 'TextEditingValue apply(TextEditingValue value)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
    getterSignatures: {
      'oldText': 'String get oldText',
      'selection': 'TextSelection get selection',
      'composing': 'TextRange get composing',
      'replacementText': 'String get replacementText',
      'replacedRange': 'TextRange get replacedRange',
      'textReplaced': 'String get textReplaced',
    },
  );
}

// =============================================================================
// TextEditingDeltaNonTextUpdate Bridge
// =============================================================================

BridgedClass _createTextEditingDeltaNonTextUpdateBridge() {
  return BridgedClass(
    nativeType: $flutter_48.TextEditingDeltaNonTextUpdate,
    name: 'TextEditingDeltaNonTextUpdate',
    isAssignable: (v) => v is $flutter_48.TextEditingDeltaNonTextUpdate,
    constructors: {
      '': (visitor, positional, named) {
        final oldText = D4.getRequiredNamedArg<String>(named, 'oldText', 'TextEditingDeltaNonTextUpdate');
        final selection = D4.getRequiredNamedArg<$flutter_47.TextSelection>(named, 'selection', 'TextEditingDeltaNonTextUpdate');
        final composing = D4.getRequiredNamedArg<TextRange>(named, 'composing', 'TextEditingDeltaNonTextUpdate');
        return $flutter_48.TextEditingDeltaNonTextUpdate(oldText: oldText, selection: selection, composing: composing);
      },
    },
    getters: {
      'oldText': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate').oldText,
      'selection': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate').selection,
      'composing': (visitor, target) => D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate').composing,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate');
        D4.requireMinArgs(positional, 1, 'apply');
        final value = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'value', 'apply');
        return t.apply(value);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_48.TextEditingDeltaNonTextUpdate>(target, 'TextEditingDeltaNonTextUpdate');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    constructorSignatures: {
      '': 'const TextEditingDeltaNonTextUpdate({required String oldText, required TextSelection selection, required TextRange composing})',
    },
    methodSignatures: {
      'apply': 'TextEditingValue apply(TextEditingValue value)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_13.BinaryMessenger,
    name: 'BinaryMessenger',
    isAssignable: (v) => v is $flutter_13.BinaryMessenger,
    constructors: {
    },
    methods: {
      'handlePlatformMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BinaryMessenger>(target, 'BinaryMessenger');
        D4.requireMinArgs(positional, 3, 'handlePlatformMessage');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'handlePlatformMessage');
        final data = D4.getRequiredArg<ByteData?>(positional, 1, 'data', 'handlePlatformMessage');
        if (positional.length <= 2) {
          throw ArgumentError('handlePlatformMessage: Missing required argument "callback" at position 2');
        }
        final callbackRaw = positional[2];
        return t.handlePlatformMessage(channel, data, callbackRaw == null ? null : (ByteData? p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
      },
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BinaryMessenger>(target, 'BinaryMessenger');
        D4.requireMinArgs(positional, 2, 'send');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'send');
        final message = D4.getRequiredArg<ByteData?>(positional, 1, 'message', 'send');
        return t.send(channel, message);
      },
      'setMessageHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.BinaryMessenger>(target, 'BinaryMessenger');
        D4.requireMinArgs(positional, 2, 'setMessageHandler');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'setMessageHandler');
        if (positional.length <= 1) {
          throw ArgumentError('setMessageHandler: Missing required argument "handler" at position 1');
        }
        final handlerRaw = positional[1];
        t.setMessageHandler(channel, handlerRaw == null ? null : (ByteData? p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<ByteData?>?; });
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
// KeyboardKey Bridge
// =============================================================================

BridgedClass _createKeyboardKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_25.KeyboardKey,
    name: 'KeyboardKey',
    isAssignable: (v) => v is $flutter_25.KeyboardKey,
    constructors: {
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.KeyboardKey>(target, 'KeyboardKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.KeyboardKey>(target, 'KeyboardKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.KeyboardKey>(target, 'KeyboardKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.KeyboardKey>(target, 'KeyboardKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
    },
  );
}

// =============================================================================
// LogicalKeyboardKey Bridge
// =============================================================================

BridgedClass _createLogicalKeyboardKeyBridge() {
  return BridgedClass(
    nativeType: $flutter_25.LogicalKeyboardKey,
    name: 'LogicalKeyboardKey',
    isAssignable: (v) => v is $flutter_25.LogicalKeyboardKey,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LogicalKeyboardKey');
        final keyId = D4.getRequiredArg<int>(positional, 0, 'keyId', 'LogicalKeyboardKey');
        return $flutter_25.LogicalKeyboardKey(keyId);
      },
    },
    getters: {
      'keyId': (visitor, target) => D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').keyId,
      'keyLabel': (visitor, target) => D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').keyLabel,
      'debugName': (visitor, target) => D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').debugName,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').hashCode,
      'isAutogenerated': (visitor, target) => D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').isAutogenerated,
      'synonyms': (visitor, target) => D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey').synonyms,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.LogicalKeyboardKey>(target, 'LogicalKeyboardKey');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'valueMask': (visitor) => $flutter_25.LogicalKeyboardKey.valueMask,
      'planeMask': (visitor) => $flutter_25.LogicalKeyboardKey.planeMask,
      'unicodePlane': (visitor) => $flutter_25.LogicalKeyboardKey.unicodePlane,
      'unprintablePlane': (visitor) => $flutter_25.LogicalKeyboardKey.unprintablePlane,
      'flutterPlane': (visitor) => $flutter_25.LogicalKeyboardKey.flutterPlane,
      'startOfPlatformPlanes': (visitor) => $flutter_25.LogicalKeyboardKey.startOfPlatformPlanes,
      'androidPlane': (visitor) => $flutter_25.LogicalKeyboardKey.androidPlane,
      'fuchsiaPlane': (visitor) => $flutter_25.LogicalKeyboardKey.fuchsiaPlane,
      'iosPlane': (visitor) => $flutter_25.LogicalKeyboardKey.iosPlane,
      'macosPlane': (visitor) => $flutter_25.LogicalKeyboardKey.macosPlane,
      'gtkPlane': (visitor) => $flutter_25.LogicalKeyboardKey.gtkPlane,
      'windowsPlane': (visitor) => $flutter_25.LogicalKeyboardKey.windowsPlane,
      'webPlane': (visitor) => $flutter_25.LogicalKeyboardKey.webPlane,
      'glfwPlane': (visitor) => $flutter_25.LogicalKeyboardKey.glfwPlane,
      'space': (visitor) => $flutter_25.LogicalKeyboardKey.space,
      'exclamation': (visitor) => $flutter_25.LogicalKeyboardKey.exclamation,
      'quote': (visitor) => $flutter_25.LogicalKeyboardKey.quote,
      'numberSign': (visitor) => $flutter_25.LogicalKeyboardKey.numberSign,
      'dollar': (visitor) => $flutter_25.LogicalKeyboardKey.dollar,
      'percent': (visitor) => $flutter_25.LogicalKeyboardKey.percent,
      'ampersand': (visitor) => $flutter_25.LogicalKeyboardKey.ampersand,
      'quoteSingle': (visitor) => $flutter_25.LogicalKeyboardKey.quoteSingle,
      'parenthesisLeft': (visitor) => $flutter_25.LogicalKeyboardKey.parenthesisLeft,
      'parenthesisRight': (visitor) => $flutter_25.LogicalKeyboardKey.parenthesisRight,
      'asterisk': (visitor) => $flutter_25.LogicalKeyboardKey.asterisk,
      'add': (visitor) => $flutter_25.LogicalKeyboardKey.add,
      'comma': (visitor) => $flutter_25.LogicalKeyboardKey.comma,
      'minus': (visitor) => $flutter_25.LogicalKeyboardKey.minus,
      'period': (visitor) => $flutter_25.LogicalKeyboardKey.period,
      'slash': (visitor) => $flutter_25.LogicalKeyboardKey.slash,
      'digit0': (visitor) => $flutter_25.LogicalKeyboardKey.digit0,
      'digit1': (visitor) => $flutter_25.LogicalKeyboardKey.digit1,
      'digit2': (visitor) => $flutter_25.LogicalKeyboardKey.digit2,
      'digit3': (visitor) => $flutter_25.LogicalKeyboardKey.digit3,
      'digit4': (visitor) => $flutter_25.LogicalKeyboardKey.digit4,
      'digit5': (visitor) => $flutter_25.LogicalKeyboardKey.digit5,
      'digit6': (visitor) => $flutter_25.LogicalKeyboardKey.digit6,
      'digit7': (visitor) => $flutter_25.LogicalKeyboardKey.digit7,
      'digit8': (visitor) => $flutter_25.LogicalKeyboardKey.digit8,
      'digit9': (visitor) => $flutter_25.LogicalKeyboardKey.digit9,
      'colon': (visitor) => $flutter_25.LogicalKeyboardKey.colon,
      'semicolon': (visitor) => $flutter_25.LogicalKeyboardKey.semicolon,
      'less': (visitor) => $flutter_25.LogicalKeyboardKey.less,
      'equal': (visitor) => $flutter_25.LogicalKeyboardKey.equal,
      'greater': (visitor) => $flutter_25.LogicalKeyboardKey.greater,
      'question': (visitor) => $flutter_25.LogicalKeyboardKey.question,
      'at': (visitor) => $flutter_25.LogicalKeyboardKey.at,
      'bracketLeft': (visitor) => $flutter_25.LogicalKeyboardKey.bracketLeft,
      'backslash': (visitor) => $flutter_25.LogicalKeyboardKey.backslash,
      'bracketRight': (visitor) => $flutter_25.LogicalKeyboardKey.bracketRight,
      'caret': (visitor) => $flutter_25.LogicalKeyboardKey.caret,
      'underscore': (visitor) => $flutter_25.LogicalKeyboardKey.underscore,
      'backquote': (visitor) => $flutter_25.LogicalKeyboardKey.backquote,
      'keyA': (visitor) => $flutter_25.LogicalKeyboardKey.keyA,
      'keyB': (visitor) => $flutter_25.LogicalKeyboardKey.keyB,
      'keyC': (visitor) => $flutter_25.LogicalKeyboardKey.keyC,
      'keyD': (visitor) => $flutter_25.LogicalKeyboardKey.keyD,
      'keyE': (visitor) => $flutter_25.LogicalKeyboardKey.keyE,
      'keyF': (visitor) => $flutter_25.LogicalKeyboardKey.keyF,
      'keyG': (visitor) => $flutter_25.LogicalKeyboardKey.keyG,
      'keyH': (visitor) => $flutter_25.LogicalKeyboardKey.keyH,
      'keyI': (visitor) => $flutter_25.LogicalKeyboardKey.keyI,
      'keyJ': (visitor) => $flutter_25.LogicalKeyboardKey.keyJ,
      'keyK': (visitor) => $flutter_25.LogicalKeyboardKey.keyK,
      'keyL': (visitor) => $flutter_25.LogicalKeyboardKey.keyL,
      'keyM': (visitor) => $flutter_25.LogicalKeyboardKey.keyM,
      'keyN': (visitor) => $flutter_25.LogicalKeyboardKey.keyN,
      'keyO': (visitor) => $flutter_25.LogicalKeyboardKey.keyO,
      'keyP': (visitor) => $flutter_25.LogicalKeyboardKey.keyP,
      'keyQ': (visitor) => $flutter_25.LogicalKeyboardKey.keyQ,
      'keyR': (visitor) => $flutter_25.LogicalKeyboardKey.keyR,
      'keyS': (visitor) => $flutter_25.LogicalKeyboardKey.keyS,
      'keyT': (visitor) => $flutter_25.LogicalKeyboardKey.keyT,
      'keyU': (visitor) => $flutter_25.LogicalKeyboardKey.keyU,
      'keyV': (visitor) => $flutter_25.LogicalKeyboardKey.keyV,
      'keyW': (visitor) => $flutter_25.LogicalKeyboardKey.keyW,
      'keyX': (visitor) => $flutter_25.LogicalKeyboardKey.keyX,
      'keyY': (visitor) => $flutter_25.LogicalKeyboardKey.keyY,
      'keyZ': (visitor) => $flutter_25.LogicalKeyboardKey.keyZ,
      'braceLeft': (visitor) => $flutter_25.LogicalKeyboardKey.braceLeft,
      'bar': (visitor) => $flutter_25.LogicalKeyboardKey.bar,
      'braceRight': (visitor) => $flutter_25.LogicalKeyboardKey.braceRight,
      'tilde': (visitor) => $flutter_25.LogicalKeyboardKey.tilde,
      'unidentified': (visitor) => $flutter_25.LogicalKeyboardKey.unidentified,
      'backspace': (visitor) => $flutter_25.LogicalKeyboardKey.backspace,
      'tab': (visitor) => $flutter_25.LogicalKeyboardKey.tab,
      'enter': (visitor) => $flutter_25.LogicalKeyboardKey.enter,
      'escape': (visitor) => $flutter_25.LogicalKeyboardKey.escape,
      'delete': (visitor) => $flutter_25.LogicalKeyboardKey.delete,
      'accel': (visitor) => $flutter_25.LogicalKeyboardKey.accel,
      'altGraph': (visitor) => $flutter_25.LogicalKeyboardKey.altGraph,
      'capsLock': (visitor) => $flutter_25.LogicalKeyboardKey.capsLock,
      'fn': (visitor) => $flutter_25.LogicalKeyboardKey.fn,
      'fnLock': (visitor) => $flutter_25.LogicalKeyboardKey.fnLock,
      'hyper': (visitor) => $flutter_25.LogicalKeyboardKey.hyper,
      'numLock': (visitor) => $flutter_25.LogicalKeyboardKey.numLock,
      'scrollLock': (visitor) => $flutter_25.LogicalKeyboardKey.scrollLock,
      'superKey': (visitor) => $flutter_25.LogicalKeyboardKey.superKey,
      'symbol': (visitor) => $flutter_25.LogicalKeyboardKey.symbol,
      'symbolLock': (visitor) => $flutter_25.LogicalKeyboardKey.symbolLock,
      'shiftLevel5': (visitor) => $flutter_25.LogicalKeyboardKey.shiftLevel5,
      'arrowDown': (visitor) => $flutter_25.LogicalKeyboardKey.arrowDown,
      'arrowLeft': (visitor) => $flutter_25.LogicalKeyboardKey.arrowLeft,
      'arrowRight': (visitor) => $flutter_25.LogicalKeyboardKey.arrowRight,
      'arrowUp': (visitor) => $flutter_25.LogicalKeyboardKey.arrowUp,
      'end': (visitor) => $flutter_25.LogicalKeyboardKey.end,
      'home': (visitor) => $flutter_25.LogicalKeyboardKey.home,
      'pageDown': (visitor) => $flutter_25.LogicalKeyboardKey.pageDown,
      'pageUp': (visitor) => $flutter_25.LogicalKeyboardKey.pageUp,
      'clear': (visitor) => $flutter_25.LogicalKeyboardKey.clear,
      'copy': (visitor) => $flutter_25.LogicalKeyboardKey.copy,
      'crSel': (visitor) => $flutter_25.LogicalKeyboardKey.crSel,
      'cut': (visitor) => $flutter_25.LogicalKeyboardKey.cut,
      'eraseEof': (visitor) => $flutter_25.LogicalKeyboardKey.eraseEof,
      'exSel': (visitor) => $flutter_25.LogicalKeyboardKey.exSel,
      'insert': (visitor) => $flutter_25.LogicalKeyboardKey.insert,
      'paste': (visitor) => $flutter_25.LogicalKeyboardKey.paste,
      'redo': (visitor) => $flutter_25.LogicalKeyboardKey.redo,
      'undo': (visitor) => $flutter_25.LogicalKeyboardKey.undo,
      'accept': (visitor) => $flutter_25.LogicalKeyboardKey.accept,
      'again': (visitor) => $flutter_25.LogicalKeyboardKey.again,
      'attn': (visitor) => $flutter_25.LogicalKeyboardKey.attn,
      'cancel': (visitor) => $flutter_25.LogicalKeyboardKey.cancel,
      'contextMenu': (visitor) => $flutter_25.LogicalKeyboardKey.contextMenu,
      'execute': (visitor) => $flutter_25.LogicalKeyboardKey.execute,
      'find': (visitor) => $flutter_25.LogicalKeyboardKey.find,
      'help': (visitor) => $flutter_25.LogicalKeyboardKey.help,
      'pause': (visitor) => $flutter_25.LogicalKeyboardKey.pause,
      'play': (visitor) => $flutter_25.LogicalKeyboardKey.play,
      'props': (visitor) => $flutter_25.LogicalKeyboardKey.props,
      'select': (visitor) => $flutter_25.LogicalKeyboardKey.select,
      'zoomIn': (visitor) => $flutter_25.LogicalKeyboardKey.zoomIn,
      'zoomOut': (visitor) => $flutter_25.LogicalKeyboardKey.zoomOut,
      'brightnessDown': (visitor) => $flutter_25.LogicalKeyboardKey.brightnessDown,
      'brightnessUp': (visitor) => $flutter_25.LogicalKeyboardKey.brightnessUp,
      'camera': (visitor) => $flutter_25.LogicalKeyboardKey.camera,
      'eject': (visitor) => $flutter_25.LogicalKeyboardKey.eject,
      'logOff': (visitor) => $flutter_25.LogicalKeyboardKey.logOff,
      'power': (visitor) => $flutter_25.LogicalKeyboardKey.power,
      'powerOff': (visitor) => $flutter_25.LogicalKeyboardKey.powerOff,
      'printScreen': (visitor) => $flutter_25.LogicalKeyboardKey.printScreen,
      'hibernate': (visitor) => $flutter_25.LogicalKeyboardKey.hibernate,
      'standby': (visitor) => $flutter_25.LogicalKeyboardKey.standby,
      'wakeUp': (visitor) => $flutter_25.LogicalKeyboardKey.wakeUp,
      'allCandidates': (visitor) => $flutter_25.LogicalKeyboardKey.allCandidates,
      'alphanumeric': (visitor) => $flutter_25.LogicalKeyboardKey.alphanumeric,
      'codeInput': (visitor) => $flutter_25.LogicalKeyboardKey.codeInput,
      'compose': (visitor) => $flutter_25.LogicalKeyboardKey.compose,
      'convert': (visitor) => $flutter_25.LogicalKeyboardKey.convert,
      'finalMode': (visitor) => $flutter_25.LogicalKeyboardKey.finalMode,
      'groupFirst': (visitor) => $flutter_25.LogicalKeyboardKey.groupFirst,
      'groupLast': (visitor) => $flutter_25.LogicalKeyboardKey.groupLast,
      'groupNext': (visitor) => $flutter_25.LogicalKeyboardKey.groupNext,
      'groupPrevious': (visitor) => $flutter_25.LogicalKeyboardKey.groupPrevious,
      'modeChange': (visitor) => $flutter_25.LogicalKeyboardKey.modeChange,
      'nextCandidate': (visitor) => $flutter_25.LogicalKeyboardKey.nextCandidate,
      'nonConvert': (visitor) => $flutter_25.LogicalKeyboardKey.nonConvert,
      'previousCandidate': (visitor) => $flutter_25.LogicalKeyboardKey.previousCandidate,
      'process': (visitor) => $flutter_25.LogicalKeyboardKey.process,
      'singleCandidate': (visitor) => $flutter_25.LogicalKeyboardKey.singleCandidate,
      'hangulMode': (visitor) => $flutter_25.LogicalKeyboardKey.hangulMode,
      'hanjaMode': (visitor) => $flutter_25.LogicalKeyboardKey.hanjaMode,
      'junjaMode': (visitor) => $flutter_25.LogicalKeyboardKey.junjaMode,
      'eisu': (visitor) => $flutter_25.LogicalKeyboardKey.eisu,
      'hankaku': (visitor) => $flutter_25.LogicalKeyboardKey.hankaku,
      'hiragana': (visitor) => $flutter_25.LogicalKeyboardKey.hiragana,
      'hiraganaKatakana': (visitor) => $flutter_25.LogicalKeyboardKey.hiraganaKatakana,
      'kanaMode': (visitor) => $flutter_25.LogicalKeyboardKey.kanaMode,
      'kanjiMode': (visitor) => $flutter_25.LogicalKeyboardKey.kanjiMode,
      'katakana': (visitor) => $flutter_25.LogicalKeyboardKey.katakana,
      'romaji': (visitor) => $flutter_25.LogicalKeyboardKey.romaji,
      'zenkaku': (visitor) => $flutter_25.LogicalKeyboardKey.zenkaku,
      'zenkakuHankaku': (visitor) => $flutter_25.LogicalKeyboardKey.zenkakuHankaku,
      'f1': (visitor) => $flutter_25.LogicalKeyboardKey.f1,
      'f2': (visitor) => $flutter_25.LogicalKeyboardKey.f2,
      'f3': (visitor) => $flutter_25.LogicalKeyboardKey.f3,
      'f4': (visitor) => $flutter_25.LogicalKeyboardKey.f4,
      'f5': (visitor) => $flutter_25.LogicalKeyboardKey.f5,
      'f6': (visitor) => $flutter_25.LogicalKeyboardKey.f6,
      'f7': (visitor) => $flutter_25.LogicalKeyboardKey.f7,
      'f8': (visitor) => $flutter_25.LogicalKeyboardKey.f8,
      'f9': (visitor) => $flutter_25.LogicalKeyboardKey.f9,
      'f10': (visitor) => $flutter_25.LogicalKeyboardKey.f10,
      'f11': (visitor) => $flutter_25.LogicalKeyboardKey.f11,
      'f12': (visitor) => $flutter_25.LogicalKeyboardKey.f12,
      'f13': (visitor) => $flutter_25.LogicalKeyboardKey.f13,
      'f14': (visitor) => $flutter_25.LogicalKeyboardKey.f14,
      'f15': (visitor) => $flutter_25.LogicalKeyboardKey.f15,
      'f16': (visitor) => $flutter_25.LogicalKeyboardKey.f16,
      'f17': (visitor) => $flutter_25.LogicalKeyboardKey.f17,
      'f18': (visitor) => $flutter_25.LogicalKeyboardKey.f18,
      'f19': (visitor) => $flutter_25.LogicalKeyboardKey.f19,
      'f20': (visitor) => $flutter_25.LogicalKeyboardKey.f20,
      'f21': (visitor) => $flutter_25.LogicalKeyboardKey.f21,
      'f22': (visitor) => $flutter_25.LogicalKeyboardKey.f22,
      'f23': (visitor) => $flutter_25.LogicalKeyboardKey.f23,
      'f24': (visitor) => $flutter_25.LogicalKeyboardKey.f24,
      'soft1': (visitor) => $flutter_25.LogicalKeyboardKey.soft1,
      'soft2': (visitor) => $flutter_25.LogicalKeyboardKey.soft2,
      'soft3': (visitor) => $flutter_25.LogicalKeyboardKey.soft3,
      'soft4': (visitor) => $flutter_25.LogicalKeyboardKey.soft4,
      'soft5': (visitor) => $flutter_25.LogicalKeyboardKey.soft5,
      'soft6': (visitor) => $flutter_25.LogicalKeyboardKey.soft6,
      'soft7': (visitor) => $flutter_25.LogicalKeyboardKey.soft7,
      'soft8': (visitor) => $flutter_25.LogicalKeyboardKey.soft8,
      'close': (visitor) => $flutter_25.LogicalKeyboardKey.close,
      'mailForward': (visitor) => $flutter_25.LogicalKeyboardKey.mailForward,
      'mailReply': (visitor) => $flutter_25.LogicalKeyboardKey.mailReply,
      'mailSend': (visitor) => $flutter_25.LogicalKeyboardKey.mailSend,
      'mediaPlayPause': (visitor) => $flutter_25.LogicalKeyboardKey.mediaPlayPause,
      'mediaStop': (visitor) => $flutter_25.LogicalKeyboardKey.mediaStop,
      'mediaTrackNext': (visitor) => $flutter_25.LogicalKeyboardKey.mediaTrackNext,
      'mediaTrackPrevious': (visitor) => $flutter_25.LogicalKeyboardKey.mediaTrackPrevious,
      'newKey': (visitor) => $flutter_25.LogicalKeyboardKey.newKey,
      'open': (visitor) => $flutter_25.LogicalKeyboardKey.open,
      'print': (visitor) => $flutter_25.LogicalKeyboardKey.print,
      'save': (visitor) => $flutter_25.LogicalKeyboardKey.save,
      'spellCheck': (visitor) => $flutter_25.LogicalKeyboardKey.spellCheck,
      'audioVolumeDown': (visitor) => $flutter_25.LogicalKeyboardKey.audioVolumeDown,
      'audioVolumeUp': (visitor) => $flutter_25.LogicalKeyboardKey.audioVolumeUp,
      'audioVolumeMute': (visitor) => $flutter_25.LogicalKeyboardKey.audioVolumeMute,
      'launchApplication2': (visitor) => $flutter_25.LogicalKeyboardKey.launchApplication2,
      'launchCalendar': (visitor) => $flutter_25.LogicalKeyboardKey.launchCalendar,
      'launchMail': (visitor) => $flutter_25.LogicalKeyboardKey.launchMail,
      'launchMediaPlayer': (visitor) => $flutter_25.LogicalKeyboardKey.launchMediaPlayer,
      'launchMusicPlayer': (visitor) => $flutter_25.LogicalKeyboardKey.launchMusicPlayer,
      'launchApplication1': (visitor) => $flutter_25.LogicalKeyboardKey.launchApplication1,
      'launchScreenSaver': (visitor) => $flutter_25.LogicalKeyboardKey.launchScreenSaver,
      'launchSpreadsheet': (visitor) => $flutter_25.LogicalKeyboardKey.launchSpreadsheet,
      'launchWebBrowser': (visitor) => $flutter_25.LogicalKeyboardKey.launchWebBrowser,
      'launchWebCam': (visitor) => $flutter_25.LogicalKeyboardKey.launchWebCam,
      'launchWordProcessor': (visitor) => $flutter_25.LogicalKeyboardKey.launchWordProcessor,
      'launchContacts': (visitor) => $flutter_25.LogicalKeyboardKey.launchContacts,
      'launchPhone': (visitor) => $flutter_25.LogicalKeyboardKey.launchPhone,
      'launchAssistant': (visitor) => $flutter_25.LogicalKeyboardKey.launchAssistant,
      'launchControlPanel': (visitor) => $flutter_25.LogicalKeyboardKey.launchControlPanel,
      'browserBack': (visitor) => $flutter_25.LogicalKeyboardKey.browserBack,
      'browserFavorites': (visitor) => $flutter_25.LogicalKeyboardKey.browserFavorites,
      'browserForward': (visitor) => $flutter_25.LogicalKeyboardKey.browserForward,
      'browserHome': (visitor) => $flutter_25.LogicalKeyboardKey.browserHome,
      'browserRefresh': (visitor) => $flutter_25.LogicalKeyboardKey.browserRefresh,
      'browserSearch': (visitor) => $flutter_25.LogicalKeyboardKey.browserSearch,
      'browserStop': (visitor) => $flutter_25.LogicalKeyboardKey.browserStop,
      'audioBalanceLeft': (visitor) => $flutter_25.LogicalKeyboardKey.audioBalanceLeft,
      'audioBalanceRight': (visitor) => $flutter_25.LogicalKeyboardKey.audioBalanceRight,
      'audioBassBoostDown': (visitor) => $flutter_25.LogicalKeyboardKey.audioBassBoostDown,
      'audioBassBoostUp': (visitor) => $flutter_25.LogicalKeyboardKey.audioBassBoostUp,
      'audioFaderFront': (visitor) => $flutter_25.LogicalKeyboardKey.audioFaderFront,
      'audioFaderRear': (visitor) => $flutter_25.LogicalKeyboardKey.audioFaderRear,
      'audioSurroundModeNext': (visitor) => $flutter_25.LogicalKeyboardKey.audioSurroundModeNext,
      'avrInput': (visitor) => $flutter_25.LogicalKeyboardKey.avrInput,
      'avrPower': (visitor) => $flutter_25.LogicalKeyboardKey.avrPower,
      'channelDown': (visitor) => $flutter_25.LogicalKeyboardKey.channelDown,
      'channelUp': (visitor) => $flutter_25.LogicalKeyboardKey.channelUp,
      'colorF0Red': (visitor) => $flutter_25.LogicalKeyboardKey.colorF0Red,
      'colorF1Green': (visitor) => $flutter_25.LogicalKeyboardKey.colorF1Green,
      'colorF2Yellow': (visitor) => $flutter_25.LogicalKeyboardKey.colorF2Yellow,
      'colorF3Blue': (visitor) => $flutter_25.LogicalKeyboardKey.colorF3Blue,
      'colorF4Grey': (visitor) => $flutter_25.LogicalKeyboardKey.colorF4Grey,
      'colorF5Brown': (visitor) => $flutter_25.LogicalKeyboardKey.colorF5Brown,
      'closedCaptionToggle': (visitor) => $flutter_25.LogicalKeyboardKey.closedCaptionToggle,
      'dimmer': (visitor) => $flutter_25.LogicalKeyboardKey.dimmer,
      'displaySwap': (visitor) => $flutter_25.LogicalKeyboardKey.displaySwap,
      'exit': (visitor) => $flutter_25.LogicalKeyboardKey.exit,
      'favoriteClear0': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteClear0,
      'favoriteClear1': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteClear1,
      'favoriteClear2': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteClear2,
      'favoriteClear3': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteClear3,
      'favoriteRecall0': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteRecall0,
      'favoriteRecall1': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteRecall1,
      'favoriteRecall2': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteRecall2,
      'favoriteRecall3': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteRecall3,
      'favoriteStore0': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteStore0,
      'favoriteStore1': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteStore1,
      'favoriteStore2': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteStore2,
      'favoriteStore3': (visitor) => $flutter_25.LogicalKeyboardKey.favoriteStore3,
      'guide': (visitor) => $flutter_25.LogicalKeyboardKey.guide,
      'guideNextDay': (visitor) => $flutter_25.LogicalKeyboardKey.guideNextDay,
      'guidePreviousDay': (visitor) => $flutter_25.LogicalKeyboardKey.guidePreviousDay,
      'info': (visitor) => $flutter_25.LogicalKeyboardKey.info,
      'instantReplay': (visitor) => $flutter_25.LogicalKeyboardKey.instantReplay,
      'link': (visitor) => $flutter_25.LogicalKeyboardKey.link,
      'listProgram': (visitor) => $flutter_25.LogicalKeyboardKey.listProgram,
      'liveContent': (visitor) => $flutter_25.LogicalKeyboardKey.liveContent,
      'lock': (visitor) => $flutter_25.LogicalKeyboardKey.lock,
      'mediaApps': (visitor) => $flutter_25.LogicalKeyboardKey.mediaApps,
      'mediaFastForward': (visitor) => $flutter_25.LogicalKeyboardKey.mediaFastForward,
      'mediaLast': (visitor) => $flutter_25.LogicalKeyboardKey.mediaLast,
      'mediaPause': (visitor) => $flutter_25.LogicalKeyboardKey.mediaPause,
      'mediaPlay': (visitor) => $flutter_25.LogicalKeyboardKey.mediaPlay,
      'mediaRecord': (visitor) => $flutter_25.LogicalKeyboardKey.mediaRecord,
      'mediaRewind': (visitor) => $flutter_25.LogicalKeyboardKey.mediaRewind,
      'mediaSkip': (visitor) => $flutter_25.LogicalKeyboardKey.mediaSkip,
      'nextFavoriteChannel': (visitor) => $flutter_25.LogicalKeyboardKey.nextFavoriteChannel,
      'nextUserProfile': (visitor) => $flutter_25.LogicalKeyboardKey.nextUserProfile,
      'onDemand': (visitor) => $flutter_25.LogicalKeyboardKey.onDemand,
      'pInPDown': (visitor) => $flutter_25.LogicalKeyboardKey.pInPDown,
      'pInPMove': (visitor) => $flutter_25.LogicalKeyboardKey.pInPMove,
      'pInPToggle': (visitor) => $flutter_25.LogicalKeyboardKey.pInPToggle,
      'pInPUp': (visitor) => $flutter_25.LogicalKeyboardKey.pInPUp,
      'playSpeedDown': (visitor) => $flutter_25.LogicalKeyboardKey.playSpeedDown,
      'playSpeedReset': (visitor) => $flutter_25.LogicalKeyboardKey.playSpeedReset,
      'playSpeedUp': (visitor) => $flutter_25.LogicalKeyboardKey.playSpeedUp,
      'randomToggle': (visitor) => $flutter_25.LogicalKeyboardKey.randomToggle,
      'rcLowBattery': (visitor) => $flutter_25.LogicalKeyboardKey.rcLowBattery,
      'recordSpeedNext': (visitor) => $flutter_25.LogicalKeyboardKey.recordSpeedNext,
      'rfBypass': (visitor) => $flutter_25.LogicalKeyboardKey.rfBypass,
      'scanChannelsToggle': (visitor) => $flutter_25.LogicalKeyboardKey.scanChannelsToggle,
      'screenModeNext': (visitor) => $flutter_25.LogicalKeyboardKey.screenModeNext,
      'settings': (visitor) => $flutter_25.LogicalKeyboardKey.settings,
      'splitScreenToggle': (visitor) => $flutter_25.LogicalKeyboardKey.splitScreenToggle,
      'stbInput': (visitor) => $flutter_25.LogicalKeyboardKey.stbInput,
      'stbPower': (visitor) => $flutter_25.LogicalKeyboardKey.stbPower,
      'subtitle': (visitor) => $flutter_25.LogicalKeyboardKey.subtitle,
      'teletext': (visitor) => $flutter_25.LogicalKeyboardKey.teletext,
      'tv': (visitor) => $flutter_25.LogicalKeyboardKey.tv,
      'tvInput': (visitor) => $flutter_25.LogicalKeyboardKey.tvInput,
      'tvPower': (visitor) => $flutter_25.LogicalKeyboardKey.tvPower,
      'videoModeNext': (visitor) => $flutter_25.LogicalKeyboardKey.videoModeNext,
      'wink': (visitor) => $flutter_25.LogicalKeyboardKey.wink,
      'zoomToggle': (visitor) => $flutter_25.LogicalKeyboardKey.zoomToggle,
      'dvr': (visitor) => $flutter_25.LogicalKeyboardKey.dvr,
      'mediaAudioTrack': (visitor) => $flutter_25.LogicalKeyboardKey.mediaAudioTrack,
      'mediaSkipBackward': (visitor) => $flutter_25.LogicalKeyboardKey.mediaSkipBackward,
      'mediaSkipForward': (visitor) => $flutter_25.LogicalKeyboardKey.mediaSkipForward,
      'mediaStepBackward': (visitor) => $flutter_25.LogicalKeyboardKey.mediaStepBackward,
      'mediaStepForward': (visitor) => $flutter_25.LogicalKeyboardKey.mediaStepForward,
      'mediaTopMenu': (visitor) => $flutter_25.LogicalKeyboardKey.mediaTopMenu,
      'navigateIn': (visitor) => $flutter_25.LogicalKeyboardKey.navigateIn,
      'navigateNext': (visitor) => $flutter_25.LogicalKeyboardKey.navigateNext,
      'navigateOut': (visitor) => $flutter_25.LogicalKeyboardKey.navigateOut,
      'navigatePrevious': (visitor) => $flutter_25.LogicalKeyboardKey.navigatePrevious,
      'pairing': (visitor) => $flutter_25.LogicalKeyboardKey.pairing,
      'mediaClose': (visitor) => $flutter_25.LogicalKeyboardKey.mediaClose,
      'audioBassBoostToggle': (visitor) => $flutter_25.LogicalKeyboardKey.audioBassBoostToggle,
      'audioTrebleDown': (visitor) => $flutter_25.LogicalKeyboardKey.audioTrebleDown,
      'audioTrebleUp': (visitor) => $flutter_25.LogicalKeyboardKey.audioTrebleUp,
      'microphoneToggle': (visitor) => $flutter_25.LogicalKeyboardKey.microphoneToggle,
      'microphoneVolumeDown': (visitor) => $flutter_25.LogicalKeyboardKey.microphoneVolumeDown,
      'microphoneVolumeUp': (visitor) => $flutter_25.LogicalKeyboardKey.microphoneVolumeUp,
      'microphoneVolumeMute': (visitor) => $flutter_25.LogicalKeyboardKey.microphoneVolumeMute,
      'speechCorrectionList': (visitor) => $flutter_25.LogicalKeyboardKey.speechCorrectionList,
      'speechInputToggle': (visitor) => $flutter_25.LogicalKeyboardKey.speechInputToggle,
      'appSwitch': (visitor) => $flutter_25.LogicalKeyboardKey.appSwitch,
      'call': (visitor) => $flutter_25.LogicalKeyboardKey.call,
      'cameraFocus': (visitor) => $flutter_25.LogicalKeyboardKey.cameraFocus,
      'endCall': (visitor) => $flutter_25.LogicalKeyboardKey.endCall,
      'goBack': (visitor) => $flutter_25.LogicalKeyboardKey.goBack,
      'goHome': (visitor) => $flutter_25.LogicalKeyboardKey.goHome,
      'headsetHook': (visitor) => $flutter_25.LogicalKeyboardKey.headsetHook,
      'lastNumberRedial': (visitor) => $flutter_25.LogicalKeyboardKey.lastNumberRedial,
      'notification': (visitor) => $flutter_25.LogicalKeyboardKey.notification,
      'mannerMode': (visitor) => $flutter_25.LogicalKeyboardKey.mannerMode,
      'voiceDial': (visitor) => $flutter_25.LogicalKeyboardKey.voiceDial,
      'tv3DMode': (visitor) => $flutter_25.LogicalKeyboardKey.tv3DMode,
      'tvAntennaCable': (visitor) => $flutter_25.LogicalKeyboardKey.tvAntennaCable,
      'tvAudioDescription': (visitor) => $flutter_25.LogicalKeyboardKey.tvAudioDescription,
      'tvAudioDescriptionMixDown': (visitor) => $flutter_25.LogicalKeyboardKey.tvAudioDescriptionMixDown,
      'tvAudioDescriptionMixUp': (visitor) => $flutter_25.LogicalKeyboardKey.tvAudioDescriptionMixUp,
      'tvContentsMenu': (visitor) => $flutter_25.LogicalKeyboardKey.tvContentsMenu,
      'tvDataService': (visitor) => $flutter_25.LogicalKeyboardKey.tvDataService,
      'tvInputComponent1': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputComponent1,
      'tvInputComponent2': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputComponent2,
      'tvInputComposite1': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputComposite1,
      'tvInputComposite2': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputComposite2,
      'tvInputHDMI1': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputHDMI1,
      'tvInputHDMI2': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputHDMI2,
      'tvInputHDMI3': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputHDMI3,
      'tvInputHDMI4': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputHDMI4,
      'tvInputVGA1': (visitor) => $flutter_25.LogicalKeyboardKey.tvInputVGA1,
      'tvMediaContext': (visitor) => $flutter_25.LogicalKeyboardKey.tvMediaContext,
      'tvNetwork': (visitor) => $flutter_25.LogicalKeyboardKey.tvNetwork,
      'tvNumberEntry': (visitor) => $flutter_25.LogicalKeyboardKey.tvNumberEntry,
      'tvRadioService': (visitor) => $flutter_25.LogicalKeyboardKey.tvRadioService,
      'tvSatellite': (visitor) => $flutter_25.LogicalKeyboardKey.tvSatellite,
      'tvSatelliteBS': (visitor) => $flutter_25.LogicalKeyboardKey.tvSatelliteBS,
      'tvSatelliteCS': (visitor) => $flutter_25.LogicalKeyboardKey.tvSatelliteCS,
      'tvSatelliteToggle': (visitor) => $flutter_25.LogicalKeyboardKey.tvSatelliteToggle,
      'tvTerrestrialAnalog': (visitor) => $flutter_25.LogicalKeyboardKey.tvTerrestrialAnalog,
      'tvTerrestrialDigital': (visitor) => $flutter_25.LogicalKeyboardKey.tvTerrestrialDigital,
      'tvTimer': (visitor) => $flutter_25.LogicalKeyboardKey.tvTimer,
      'key11': (visitor) => $flutter_25.LogicalKeyboardKey.key11,
      'key12': (visitor) => $flutter_25.LogicalKeyboardKey.key12,
      'suspend': (visitor) => $flutter_25.LogicalKeyboardKey.suspend,
      'resume': (visitor) => $flutter_25.LogicalKeyboardKey.resume,
      'sleep': (visitor) => $flutter_25.LogicalKeyboardKey.sleep,
      'abort': (visitor) => $flutter_25.LogicalKeyboardKey.abort,
      'lang1': (visitor) => $flutter_25.LogicalKeyboardKey.lang1,
      'lang2': (visitor) => $flutter_25.LogicalKeyboardKey.lang2,
      'lang3': (visitor) => $flutter_25.LogicalKeyboardKey.lang3,
      'lang4': (visitor) => $flutter_25.LogicalKeyboardKey.lang4,
      'lang5': (visitor) => $flutter_25.LogicalKeyboardKey.lang5,
      'intlBackslash': (visitor) => $flutter_25.LogicalKeyboardKey.intlBackslash,
      'intlRo': (visitor) => $flutter_25.LogicalKeyboardKey.intlRo,
      'intlYen': (visitor) => $flutter_25.LogicalKeyboardKey.intlYen,
      'controlLeft': (visitor) => $flutter_25.LogicalKeyboardKey.controlLeft,
      'controlRight': (visitor) => $flutter_25.LogicalKeyboardKey.controlRight,
      'shiftLeft': (visitor) => $flutter_25.LogicalKeyboardKey.shiftLeft,
      'shiftRight': (visitor) => $flutter_25.LogicalKeyboardKey.shiftRight,
      'altLeft': (visitor) => $flutter_25.LogicalKeyboardKey.altLeft,
      'altRight': (visitor) => $flutter_25.LogicalKeyboardKey.altRight,
      'metaLeft': (visitor) => $flutter_25.LogicalKeyboardKey.metaLeft,
      'metaRight': (visitor) => $flutter_25.LogicalKeyboardKey.metaRight,
      'control': (visitor) => $flutter_25.LogicalKeyboardKey.control,
      'shift': (visitor) => $flutter_25.LogicalKeyboardKey.shift,
      'alt': (visitor) => $flutter_25.LogicalKeyboardKey.alt,
      'meta': (visitor) => $flutter_25.LogicalKeyboardKey.meta,
      'numpadEnter': (visitor) => $flutter_25.LogicalKeyboardKey.numpadEnter,
      'numpadParenLeft': (visitor) => $flutter_25.LogicalKeyboardKey.numpadParenLeft,
      'numpadParenRight': (visitor) => $flutter_25.LogicalKeyboardKey.numpadParenRight,
      'numpadMultiply': (visitor) => $flutter_25.LogicalKeyboardKey.numpadMultiply,
      'numpadAdd': (visitor) => $flutter_25.LogicalKeyboardKey.numpadAdd,
      'numpadComma': (visitor) => $flutter_25.LogicalKeyboardKey.numpadComma,
      'numpadSubtract': (visitor) => $flutter_25.LogicalKeyboardKey.numpadSubtract,
      'numpadDecimal': (visitor) => $flutter_25.LogicalKeyboardKey.numpadDecimal,
      'numpadDivide': (visitor) => $flutter_25.LogicalKeyboardKey.numpadDivide,
      'numpad0': (visitor) => $flutter_25.LogicalKeyboardKey.numpad0,
      'numpad1': (visitor) => $flutter_25.LogicalKeyboardKey.numpad1,
      'numpad2': (visitor) => $flutter_25.LogicalKeyboardKey.numpad2,
      'numpad3': (visitor) => $flutter_25.LogicalKeyboardKey.numpad3,
      'numpad4': (visitor) => $flutter_25.LogicalKeyboardKey.numpad4,
      'numpad5': (visitor) => $flutter_25.LogicalKeyboardKey.numpad5,
      'numpad6': (visitor) => $flutter_25.LogicalKeyboardKey.numpad6,
      'numpad7': (visitor) => $flutter_25.LogicalKeyboardKey.numpad7,
      'numpad8': (visitor) => $flutter_25.LogicalKeyboardKey.numpad8,
      'numpad9': (visitor) => $flutter_25.LogicalKeyboardKey.numpad9,
      'numpadEqual': (visitor) => $flutter_25.LogicalKeyboardKey.numpadEqual,
      'gameButton1': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton1,
      'gameButton2': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton2,
      'gameButton3': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton3,
      'gameButton4': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton4,
      'gameButton5': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton5,
      'gameButton6': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton6,
      'gameButton7': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton7,
      'gameButton8': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton8,
      'gameButton9': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton9,
      'gameButton10': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton10,
      'gameButton11': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton11,
      'gameButton12': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton12,
      'gameButton13': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton13,
      'gameButton14': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton14,
      'gameButton15': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton15,
      'gameButton16': (visitor) => $flutter_25.LogicalKeyboardKey.gameButton16,
      'gameButtonA': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonA,
      'gameButtonB': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonB,
      'gameButtonC': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonC,
      'gameButtonLeft1': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonLeft1,
      'gameButtonLeft2': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonLeft2,
      'gameButtonMode': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonMode,
      'gameButtonRight1': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonRight1,
      'gameButtonRight2': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonRight2,
      'gameButtonSelect': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonSelect,
      'gameButtonStart': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonStart,
      'gameButtonThumbLeft': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonThumbLeft,
      'gameButtonThumbRight': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonThumbRight,
      'gameButtonX': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonX,
      'gameButtonY': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonY,
      'gameButtonZ': (visitor) => $flutter_25.LogicalKeyboardKey.gameButtonZ,
      'knownLogicalKeys': (visitor) => $flutter_25.LogicalKeyboardKey.knownLogicalKeys,
    },
    staticMethods: {
      'findKeyByKeyId': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findKeyByKeyId');
        final keyId = D4.getRequiredArg<int>(positional, 0, 'keyId', 'findKeyByKeyId');
        return $flutter_25.LogicalKeyboardKey.findKeyByKeyId(keyId);
      },
      'isControlCharacter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isControlCharacter');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'isControlCharacter');
        return $flutter_25.LogicalKeyboardKey.isControlCharacter(label);
      },
      'collapseSynonyms': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'collapseSynonyms');
        if (positional.isEmpty) {
          throw ArgumentError('collapseSynonyms: Missing required argument "input" at position 0');
        }
        final input = D4.coerceSet<$flutter_25.LogicalKeyboardKey>(positional[0], 'input');
        return $flutter_25.LogicalKeyboardKey.collapseSynonyms(input);
      },
      'expandSynonyms': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'expandSynonyms');
        if (positional.isEmpty) {
          throw ArgumentError('expandSynonyms: Missing required argument "input" at position 0');
        }
        final input = D4.coerceSet<$flutter_25.LogicalKeyboardKey>(positional[0], 'input');
        return $flutter_25.LogicalKeyboardKey.expandSynonyms(input);
      },
    },
    constructorSignatures: {
      '': 'const LogicalKeyboardKey(int keyId)',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_25.PhysicalKeyboardKey,
    name: 'PhysicalKeyboardKey',
    isAssignable: (v) => v is $flutter_25.PhysicalKeyboardKey,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PhysicalKeyboardKey');
        final usbHidUsage = D4.getRequiredArg<int>(positional, 0, 'usbHidUsage', 'PhysicalKeyboardKey');
        return $flutter_25.PhysicalKeyboardKey(usbHidUsage);
      },
    },
    getters: {
      'usbHidUsage': (visitor, target) => D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey').usbHidUsage,
      'debugName': (visitor, target) => D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey').debugName,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey').hashCode,
    },
    methods: {
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PhysicalKeyboardKey>(target, 'PhysicalKeyboardKey');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'hyper': (visitor) => $flutter_25.PhysicalKeyboardKey.hyper,
      'superKey': (visitor) => $flutter_25.PhysicalKeyboardKey.superKey,
      'fn': (visitor) => $flutter_25.PhysicalKeyboardKey.fn,
      'fnLock': (visitor) => $flutter_25.PhysicalKeyboardKey.fnLock,
      'suspend': (visitor) => $flutter_25.PhysicalKeyboardKey.suspend,
      'resume': (visitor) => $flutter_25.PhysicalKeyboardKey.resume,
      'turbo': (visitor) => $flutter_25.PhysicalKeyboardKey.turbo,
      'privacyScreenToggle': (visitor) => $flutter_25.PhysicalKeyboardKey.privacyScreenToggle,
      'microphoneMuteToggle': (visitor) => $flutter_25.PhysicalKeyboardKey.microphoneMuteToggle,
      'sleep': (visitor) => $flutter_25.PhysicalKeyboardKey.sleep,
      'wakeUp': (visitor) => $flutter_25.PhysicalKeyboardKey.wakeUp,
      'displayToggleIntExt': (visitor) => $flutter_25.PhysicalKeyboardKey.displayToggleIntExt,
      'gameButton1': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton1,
      'gameButton2': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton2,
      'gameButton3': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton3,
      'gameButton4': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton4,
      'gameButton5': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton5,
      'gameButton6': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton6,
      'gameButton7': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton7,
      'gameButton8': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton8,
      'gameButton9': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton9,
      'gameButton10': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton10,
      'gameButton11': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton11,
      'gameButton12': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton12,
      'gameButton13': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton13,
      'gameButton14': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton14,
      'gameButton15': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton15,
      'gameButton16': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButton16,
      'gameButtonA': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonA,
      'gameButtonB': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonB,
      'gameButtonC': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonC,
      'gameButtonLeft1': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonLeft1,
      'gameButtonLeft2': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonLeft2,
      'gameButtonMode': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonMode,
      'gameButtonRight1': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonRight1,
      'gameButtonRight2': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonRight2,
      'gameButtonSelect': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonSelect,
      'gameButtonStart': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonStart,
      'gameButtonThumbLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonThumbLeft,
      'gameButtonThumbRight': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonThumbRight,
      'gameButtonX': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonX,
      'gameButtonY': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonY,
      'gameButtonZ': (visitor) => $flutter_25.PhysicalKeyboardKey.gameButtonZ,
      'usbReserved': (visitor) => $flutter_25.PhysicalKeyboardKey.usbReserved,
      'usbErrorRollOver': (visitor) => $flutter_25.PhysicalKeyboardKey.usbErrorRollOver,
      'usbPostFail': (visitor) => $flutter_25.PhysicalKeyboardKey.usbPostFail,
      'usbErrorUndefined': (visitor) => $flutter_25.PhysicalKeyboardKey.usbErrorUndefined,
      'keyA': (visitor) => $flutter_25.PhysicalKeyboardKey.keyA,
      'keyB': (visitor) => $flutter_25.PhysicalKeyboardKey.keyB,
      'keyC': (visitor) => $flutter_25.PhysicalKeyboardKey.keyC,
      'keyD': (visitor) => $flutter_25.PhysicalKeyboardKey.keyD,
      'keyE': (visitor) => $flutter_25.PhysicalKeyboardKey.keyE,
      'keyF': (visitor) => $flutter_25.PhysicalKeyboardKey.keyF,
      'keyG': (visitor) => $flutter_25.PhysicalKeyboardKey.keyG,
      'keyH': (visitor) => $flutter_25.PhysicalKeyboardKey.keyH,
      'keyI': (visitor) => $flutter_25.PhysicalKeyboardKey.keyI,
      'keyJ': (visitor) => $flutter_25.PhysicalKeyboardKey.keyJ,
      'keyK': (visitor) => $flutter_25.PhysicalKeyboardKey.keyK,
      'keyL': (visitor) => $flutter_25.PhysicalKeyboardKey.keyL,
      'keyM': (visitor) => $flutter_25.PhysicalKeyboardKey.keyM,
      'keyN': (visitor) => $flutter_25.PhysicalKeyboardKey.keyN,
      'keyO': (visitor) => $flutter_25.PhysicalKeyboardKey.keyO,
      'keyP': (visitor) => $flutter_25.PhysicalKeyboardKey.keyP,
      'keyQ': (visitor) => $flutter_25.PhysicalKeyboardKey.keyQ,
      'keyR': (visitor) => $flutter_25.PhysicalKeyboardKey.keyR,
      'keyS': (visitor) => $flutter_25.PhysicalKeyboardKey.keyS,
      'keyT': (visitor) => $flutter_25.PhysicalKeyboardKey.keyT,
      'keyU': (visitor) => $flutter_25.PhysicalKeyboardKey.keyU,
      'keyV': (visitor) => $flutter_25.PhysicalKeyboardKey.keyV,
      'keyW': (visitor) => $flutter_25.PhysicalKeyboardKey.keyW,
      'keyX': (visitor) => $flutter_25.PhysicalKeyboardKey.keyX,
      'keyY': (visitor) => $flutter_25.PhysicalKeyboardKey.keyY,
      'keyZ': (visitor) => $flutter_25.PhysicalKeyboardKey.keyZ,
      'digit1': (visitor) => $flutter_25.PhysicalKeyboardKey.digit1,
      'digit2': (visitor) => $flutter_25.PhysicalKeyboardKey.digit2,
      'digit3': (visitor) => $flutter_25.PhysicalKeyboardKey.digit3,
      'digit4': (visitor) => $flutter_25.PhysicalKeyboardKey.digit4,
      'digit5': (visitor) => $flutter_25.PhysicalKeyboardKey.digit5,
      'digit6': (visitor) => $flutter_25.PhysicalKeyboardKey.digit6,
      'digit7': (visitor) => $flutter_25.PhysicalKeyboardKey.digit7,
      'digit8': (visitor) => $flutter_25.PhysicalKeyboardKey.digit8,
      'digit9': (visitor) => $flutter_25.PhysicalKeyboardKey.digit9,
      'digit0': (visitor) => $flutter_25.PhysicalKeyboardKey.digit0,
      'enter': (visitor) => $flutter_25.PhysicalKeyboardKey.enter,
      'escape': (visitor) => $flutter_25.PhysicalKeyboardKey.escape,
      'backspace': (visitor) => $flutter_25.PhysicalKeyboardKey.backspace,
      'tab': (visitor) => $flutter_25.PhysicalKeyboardKey.tab,
      'space': (visitor) => $flutter_25.PhysicalKeyboardKey.space,
      'minus': (visitor) => $flutter_25.PhysicalKeyboardKey.minus,
      'equal': (visitor) => $flutter_25.PhysicalKeyboardKey.equal,
      'bracketLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.bracketLeft,
      'bracketRight': (visitor) => $flutter_25.PhysicalKeyboardKey.bracketRight,
      'backslash': (visitor) => $flutter_25.PhysicalKeyboardKey.backslash,
      'semicolon': (visitor) => $flutter_25.PhysicalKeyboardKey.semicolon,
      'quote': (visitor) => $flutter_25.PhysicalKeyboardKey.quote,
      'backquote': (visitor) => $flutter_25.PhysicalKeyboardKey.backquote,
      'comma': (visitor) => $flutter_25.PhysicalKeyboardKey.comma,
      'period': (visitor) => $flutter_25.PhysicalKeyboardKey.period,
      'slash': (visitor) => $flutter_25.PhysicalKeyboardKey.slash,
      'capsLock': (visitor) => $flutter_25.PhysicalKeyboardKey.capsLock,
      'f1': (visitor) => $flutter_25.PhysicalKeyboardKey.f1,
      'f2': (visitor) => $flutter_25.PhysicalKeyboardKey.f2,
      'f3': (visitor) => $flutter_25.PhysicalKeyboardKey.f3,
      'f4': (visitor) => $flutter_25.PhysicalKeyboardKey.f4,
      'f5': (visitor) => $flutter_25.PhysicalKeyboardKey.f5,
      'f6': (visitor) => $flutter_25.PhysicalKeyboardKey.f6,
      'f7': (visitor) => $flutter_25.PhysicalKeyboardKey.f7,
      'f8': (visitor) => $flutter_25.PhysicalKeyboardKey.f8,
      'f9': (visitor) => $flutter_25.PhysicalKeyboardKey.f9,
      'f10': (visitor) => $flutter_25.PhysicalKeyboardKey.f10,
      'f11': (visitor) => $flutter_25.PhysicalKeyboardKey.f11,
      'f12': (visitor) => $flutter_25.PhysicalKeyboardKey.f12,
      'printScreen': (visitor) => $flutter_25.PhysicalKeyboardKey.printScreen,
      'scrollLock': (visitor) => $flutter_25.PhysicalKeyboardKey.scrollLock,
      'pause': (visitor) => $flutter_25.PhysicalKeyboardKey.pause,
      'insert': (visitor) => $flutter_25.PhysicalKeyboardKey.insert,
      'home': (visitor) => $flutter_25.PhysicalKeyboardKey.home,
      'pageUp': (visitor) => $flutter_25.PhysicalKeyboardKey.pageUp,
      'delete': (visitor) => $flutter_25.PhysicalKeyboardKey.delete,
      'end': (visitor) => $flutter_25.PhysicalKeyboardKey.end,
      'pageDown': (visitor) => $flutter_25.PhysicalKeyboardKey.pageDown,
      'arrowRight': (visitor) => $flutter_25.PhysicalKeyboardKey.arrowRight,
      'arrowLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.arrowLeft,
      'arrowDown': (visitor) => $flutter_25.PhysicalKeyboardKey.arrowDown,
      'arrowUp': (visitor) => $flutter_25.PhysicalKeyboardKey.arrowUp,
      'numLock': (visitor) => $flutter_25.PhysicalKeyboardKey.numLock,
      'numpadDivide': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadDivide,
      'numpadMultiply': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadMultiply,
      'numpadSubtract': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadSubtract,
      'numpadAdd': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadAdd,
      'numpadEnter': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadEnter,
      'numpad1': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad1,
      'numpad2': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad2,
      'numpad3': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad3,
      'numpad4': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad4,
      'numpad5': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad5,
      'numpad6': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad6,
      'numpad7': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad7,
      'numpad8': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad8,
      'numpad9': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad9,
      'numpad0': (visitor) => $flutter_25.PhysicalKeyboardKey.numpad0,
      'numpadDecimal': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadDecimal,
      'intlBackslash': (visitor) => $flutter_25.PhysicalKeyboardKey.intlBackslash,
      'contextMenu': (visitor) => $flutter_25.PhysicalKeyboardKey.contextMenu,
      'power': (visitor) => $flutter_25.PhysicalKeyboardKey.power,
      'numpadEqual': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadEqual,
      'f13': (visitor) => $flutter_25.PhysicalKeyboardKey.f13,
      'f14': (visitor) => $flutter_25.PhysicalKeyboardKey.f14,
      'f15': (visitor) => $flutter_25.PhysicalKeyboardKey.f15,
      'f16': (visitor) => $flutter_25.PhysicalKeyboardKey.f16,
      'f17': (visitor) => $flutter_25.PhysicalKeyboardKey.f17,
      'f18': (visitor) => $flutter_25.PhysicalKeyboardKey.f18,
      'f19': (visitor) => $flutter_25.PhysicalKeyboardKey.f19,
      'f20': (visitor) => $flutter_25.PhysicalKeyboardKey.f20,
      'f21': (visitor) => $flutter_25.PhysicalKeyboardKey.f21,
      'f22': (visitor) => $flutter_25.PhysicalKeyboardKey.f22,
      'f23': (visitor) => $flutter_25.PhysicalKeyboardKey.f23,
      'f24': (visitor) => $flutter_25.PhysicalKeyboardKey.f24,
      'open': (visitor) => $flutter_25.PhysicalKeyboardKey.open,
      'help': (visitor) => $flutter_25.PhysicalKeyboardKey.help,
      'select': (visitor) => $flutter_25.PhysicalKeyboardKey.select,
      'again': (visitor) => $flutter_25.PhysicalKeyboardKey.again,
      'undo': (visitor) => $flutter_25.PhysicalKeyboardKey.undo,
      'cut': (visitor) => $flutter_25.PhysicalKeyboardKey.cut,
      'copy': (visitor) => $flutter_25.PhysicalKeyboardKey.copy,
      'paste': (visitor) => $flutter_25.PhysicalKeyboardKey.paste,
      'find': (visitor) => $flutter_25.PhysicalKeyboardKey.find,
      'audioVolumeMute': (visitor) => $flutter_25.PhysicalKeyboardKey.audioVolumeMute,
      'audioVolumeUp': (visitor) => $flutter_25.PhysicalKeyboardKey.audioVolumeUp,
      'audioVolumeDown': (visitor) => $flutter_25.PhysicalKeyboardKey.audioVolumeDown,
      'numpadComma': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadComma,
      'intlRo': (visitor) => $flutter_25.PhysicalKeyboardKey.intlRo,
      'kanaMode': (visitor) => $flutter_25.PhysicalKeyboardKey.kanaMode,
      'intlYen': (visitor) => $flutter_25.PhysicalKeyboardKey.intlYen,
      'convert': (visitor) => $flutter_25.PhysicalKeyboardKey.convert,
      'nonConvert': (visitor) => $flutter_25.PhysicalKeyboardKey.nonConvert,
      'lang1': (visitor) => $flutter_25.PhysicalKeyboardKey.lang1,
      'lang2': (visitor) => $flutter_25.PhysicalKeyboardKey.lang2,
      'lang3': (visitor) => $flutter_25.PhysicalKeyboardKey.lang3,
      'lang4': (visitor) => $flutter_25.PhysicalKeyboardKey.lang4,
      'lang5': (visitor) => $flutter_25.PhysicalKeyboardKey.lang5,
      'abort': (visitor) => $flutter_25.PhysicalKeyboardKey.abort,
      'props': (visitor) => $flutter_25.PhysicalKeyboardKey.props,
      'numpadParenLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadParenLeft,
      'numpadParenRight': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadParenRight,
      'numpadBackspace': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadBackspace,
      'numpadMemoryStore': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadMemoryStore,
      'numpadMemoryRecall': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadMemoryRecall,
      'numpadMemoryClear': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadMemoryClear,
      'numpadMemoryAdd': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadMemoryAdd,
      'numpadMemorySubtract': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadMemorySubtract,
      'numpadSignChange': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadSignChange,
      'numpadClear': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadClear,
      'numpadClearEntry': (visitor) => $flutter_25.PhysicalKeyboardKey.numpadClearEntry,
      'controlLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.controlLeft,
      'shiftLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.shiftLeft,
      'altLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.altLeft,
      'metaLeft': (visitor) => $flutter_25.PhysicalKeyboardKey.metaLeft,
      'controlRight': (visitor) => $flutter_25.PhysicalKeyboardKey.controlRight,
      'shiftRight': (visitor) => $flutter_25.PhysicalKeyboardKey.shiftRight,
      'altRight': (visitor) => $flutter_25.PhysicalKeyboardKey.altRight,
      'metaRight': (visitor) => $flutter_25.PhysicalKeyboardKey.metaRight,
      'info': (visitor) => $flutter_25.PhysicalKeyboardKey.info,
      'closedCaptionToggle': (visitor) => $flutter_25.PhysicalKeyboardKey.closedCaptionToggle,
      'brightnessUp': (visitor) => $flutter_25.PhysicalKeyboardKey.brightnessUp,
      'brightnessDown': (visitor) => $flutter_25.PhysicalKeyboardKey.brightnessDown,
      'brightnessToggle': (visitor) => $flutter_25.PhysicalKeyboardKey.brightnessToggle,
      'brightnessMinimum': (visitor) => $flutter_25.PhysicalKeyboardKey.brightnessMinimum,
      'brightnessMaximum': (visitor) => $flutter_25.PhysicalKeyboardKey.brightnessMaximum,
      'brightnessAuto': (visitor) => $flutter_25.PhysicalKeyboardKey.brightnessAuto,
      'kbdIllumUp': (visitor) => $flutter_25.PhysicalKeyboardKey.kbdIllumUp,
      'kbdIllumDown': (visitor) => $flutter_25.PhysicalKeyboardKey.kbdIllumDown,
      'mediaLast': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaLast,
      'launchPhone': (visitor) => $flutter_25.PhysicalKeyboardKey.launchPhone,
      'programGuide': (visitor) => $flutter_25.PhysicalKeyboardKey.programGuide,
      'exit': (visitor) => $flutter_25.PhysicalKeyboardKey.exit,
      'channelUp': (visitor) => $flutter_25.PhysicalKeyboardKey.channelUp,
      'channelDown': (visitor) => $flutter_25.PhysicalKeyboardKey.channelDown,
      'mediaPlay': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaPlay,
      'mediaPause': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaPause,
      'mediaRecord': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaRecord,
      'mediaFastForward': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaFastForward,
      'mediaRewind': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaRewind,
      'mediaTrackNext': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaTrackNext,
      'mediaTrackPrevious': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaTrackPrevious,
      'mediaStop': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaStop,
      'eject': (visitor) => $flutter_25.PhysicalKeyboardKey.eject,
      'mediaPlayPause': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaPlayPause,
      'speechInputToggle': (visitor) => $flutter_25.PhysicalKeyboardKey.speechInputToggle,
      'bassBoost': (visitor) => $flutter_25.PhysicalKeyboardKey.bassBoost,
      'mediaSelect': (visitor) => $flutter_25.PhysicalKeyboardKey.mediaSelect,
      'launchWordProcessor': (visitor) => $flutter_25.PhysicalKeyboardKey.launchWordProcessor,
      'launchSpreadsheet': (visitor) => $flutter_25.PhysicalKeyboardKey.launchSpreadsheet,
      'launchMail': (visitor) => $flutter_25.PhysicalKeyboardKey.launchMail,
      'launchContacts': (visitor) => $flutter_25.PhysicalKeyboardKey.launchContacts,
      'launchCalendar': (visitor) => $flutter_25.PhysicalKeyboardKey.launchCalendar,
      'launchApp2': (visitor) => $flutter_25.PhysicalKeyboardKey.launchApp2,
      'launchApp1': (visitor) => $flutter_25.PhysicalKeyboardKey.launchApp1,
      'launchInternetBrowser': (visitor) => $flutter_25.PhysicalKeyboardKey.launchInternetBrowser,
      'logOff': (visitor) => $flutter_25.PhysicalKeyboardKey.logOff,
      'lockScreen': (visitor) => $flutter_25.PhysicalKeyboardKey.lockScreen,
      'launchControlPanel': (visitor) => $flutter_25.PhysicalKeyboardKey.launchControlPanel,
      'selectTask': (visitor) => $flutter_25.PhysicalKeyboardKey.selectTask,
      'launchDocuments': (visitor) => $flutter_25.PhysicalKeyboardKey.launchDocuments,
      'spellCheck': (visitor) => $flutter_25.PhysicalKeyboardKey.spellCheck,
      'launchKeyboardLayout': (visitor) => $flutter_25.PhysicalKeyboardKey.launchKeyboardLayout,
      'launchScreenSaver': (visitor) => $flutter_25.PhysicalKeyboardKey.launchScreenSaver,
      'launchAudioBrowser': (visitor) => $flutter_25.PhysicalKeyboardKey.launchAudioBrowser,
      'launchAssistant': (visitor) => $flutter_25.PhysicalKeyboardKey.launchAssistant,
      'newKey': (visitor) => $flutter_25.PhysicalKeyboardKey.newKey,
      'close': (visitor) => $flutter_25.PhysicalKeyboardKey.close,
      'save': (visitor) => $flutter_25.PhysicalKeyboardKey.save,
      'print': (visitor) => $flutter_25.PhysicalKeyboardKey.print,
      'browserSearch': (visitor) => $flutter_25.PhysicalKeyboardKey.browserSearch,
      'browserHome': (visitor) => $flutter_25.PhysicalKeyboardKey.browserHome,
      'browserBack': (visitor) => $flutter_25.PhysicalKeyboardKey.browserBack,
      'browserForward': (visitor) => $flutter_25.PhysicalKeyboardKey.browserForward,
      'browserStop': (visitor) => $flutter_25.PhysicalKeyboardKey.browserStop,
      'browserRefresh': (visitor) => $flutter_25.PhysicalKeyboardKey.browserRefresh,
      'browserFavorites': (visitor) => $flutter_25.PhysicalKeyboardKey.browserFavorites,
      'zoomIn': (visitor) => $flutter_25.PhysicalKeyboardKey.zoomIn,
      'zoomOut': (visitor) => $flutter_25.PhysicalKeyboardKey.zoomOut,
      'zoomToggle': (visitor) => $flutter_25.PhysicalKeyboardKey.zoomToggle,
      'redo': (visitor) => $flutter_25.PhysicalKeyboardKey.redo,
      'mailReply': (visitor) => $flutter_25.PhysicalKeyboardKey.mailReply,
      'mailForward': (visitor) => $flutter_25.PhysicalKeyboardKey.mailForward,
      'mailSend': (visitor) => $flutter_25.PhysicalKeyboardKey.mailSend,
      'keyboardLayoutSelect': (visitor) => $flutter_25.PhysicalKeyboardKey.keyboardLayoutSelect,
      'showAllWindows': (visitor) => $flutter_25.PhysicalKeyboardKey.showAllWindows,
      'knownPhysicalKeys': (visitor) => $flutter_25.PhysicalKeyboardKey.knownPhysicalKeys,
    },
    staticMethods: {
      'findKeyByCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findKeyByCode');
        final usageCode = D4.getRequiredArg<int>(positional, 0, 'usageCode', 'findKeyByCode');
        return $flutter_25.PhysicalKeyboardKey.findKeyByCode(usageCode);
      },
    },
    constructorSignatures: {
      '': 'const PhysicalKeyboardKey(int usbHidUsage)',
    },
    methodSignatures: {
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
// KeyEvent Bridge
// =============================================================================

BridgedClass _createKeyEventBridge() {
  return BridgedClass(
    nativeType: $flutter_23.KeyEvent,
    name: 'KeyEvent',
    isAssignable: (v) => v is $flutter_23.KeyEvent,
    constructors: {
    },
    getters: {
      'physicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent').physicalKey,
      'logicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent').logicalKey,
      'character': (visitor, target) => D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent').character,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent').timeStamp,
      'deviceType': (visitor, target) => D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent').deviceType,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent').synthesized,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyEvent>(target, 'KeyEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'physicalKey': 'PhysicalKeyboardKey get physicalKey',
      'logicalKey': 'LogicalKeyboardKey get logicalKey',
      'character': 'String? get character',
      'timeStamp': 'Duration get timeStamp',
      'deviceType': 'ui.KeyEventDeviceType get deviceType',
      'synthesized': 'bool get synthesized',
    },
  );
}

// =============================================================================
// KeyDownEvent Bridge
// =============================================================================

BridgedClass _createKeyDownEventBridge() {
  return BridgedClass(
    nativeType: $flutter_23.KeyDownEvent,
    name: 'KeyDownEvent',
    isAssignable: (v) => v is $flutter_23.KeyDownEvent,
    constructors: {
      '': (visitor, positional, named) {
        final physicalKey = D4.getRequiredNamedArg<$flutter_25.PhysicalKeyboardKey>(named, 'physicalKey', 'KeyDownEvent');
        final logicalKey = D4.getRequiredNamedArg<$flutter_25.LogicalKeyboardKey>(named, 'logicalKey', 'KeyDownEvent');
        final character = D4.getOptionalNamedArg<String?>(named, 'character');
        final timeStamp = D4.getRequiredNamedArg<Duration>(named, 'timeStamp', 'KeyDownEvent');
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        if (!named.containsKey('deviceType')) {
          return $flutter_23.KeyDownEvent(physicalKey: physicalKey, logicalKey: logicalKey, character: character, timeStamp: timeStamp, synthesized: synthesized);
        }
        if (named.containsKey('deviceType')) {
          final deviceType = D4.getRequiredNamedArg<KeyEventDeviceType>(named, 'deviceType', 'KeyDownEvent');
          return $flutter_23.KeyDownEvent(physicalKey: physicalKey, logicalKey: logicalKey, character: character, timeStamp: timeStamp, synthesized: synthesized, deviceType: deviceType);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'physicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent').physicalKey,
      'logicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent').logicalKey,
      'character': (visitor, target) => D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent').character,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent').timeStamp,
      'deviceType': (visitor, target) => D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent').deviceType,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent').synthesized,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyDownEvent>(target, 'KeyDownEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const KeyDownEvent({required PhysicalKeyboardKey physicalKey, required LogicalKeyboardKey logicalKey, String? character, required Duration timeStamp, bool synthesized = false, KeyEventDeviceType deviceType = ui.KeyEventDeviceType.keyboard})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'physicalKey': 'PhysicalKeyboardKey get physicalKey',
      'logicalKey': 'LogicalKeyboardKey get logicalKey',
      'character': 'String? get character',
      'timeStamp': 'Duration get timeStamp',
      'deviceType': 'KeyEventDeviceType get deviceType',
      'synthesized': 'bool get synthesized',
    },
  );
}

// =============================================================================
// KeyUpEvent Bridge
// =============================================================================

BridgedClass _createKeyUpEventBridge() {
  return BridgedClass(
    nativeType: $flutter_23.KeyUpEvent,
    name: 'KeyUpEvent',
    isAssignable: (v) => v is $flutter_23.KeyUpEvent,
    constructors: {
      '': (visitor, positional, named) {
        final physicalKey = D4.getRequiredNamedArg<$flutter_25.PhysicalKeyboardKey>(named, 'physicalKey', 'KeyUpEvent');
        final logicalKey = D4.getRequiredNamedArg<$flutter_25.LogicalKeyboardKey>(named, 'logicalKey', 'KeyUpEvent');
        final timeStamp = D4.getRequiredNamedArg<Duration>(named, 'timeStamp', 'KeyUpEvent');
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        if (!named.containsKey('deviceType')) {
          return $flutter_23.KeyUpEvent(physicalKey: physicalKey, logicalKey: logicalKey, timeStamp: timeStamp, synthesized: synthesized);
        }
        if (named.containsKey('deviceType')) {
          final deviceType = D4.getRequiredNamedArg<KeyEventDeviceType>(named, 'deviceType', 'KeyUpEvent');
          return $flutter_23.KeyUpEvent(physicalKey: physicalKey, logicalKey: logicalKey, timeStamp: timeStamp, synthesized: synthesized, deviceType: deviceType);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'physicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent').physicalKey,
      'logicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent').logicalKey,
      'character': (visitor, target) => D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent').character,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent').timeStamp,
      'deviceType': (visitor, target) => D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent').deviceType,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent').synthesized,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyUpEvent>(target, 'KeyUpEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const KeyUpEvent({required PhysicalKeyboardKey physicalKey, required LogicalKeyboardKey logicalKey, required Duration timeStamp, bool synthesized = false, KeyEventDeviceType deviceType = ui.KeyEventDeviceType.keyboard})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'physicalKey': 'PhysicalKeyboardKey get physicalKey',
      'logicalKey': 'LogicalKeyboardKey get logicalKey',
      'character': 'String? get character',
      'timeStamp': 'Duration get timeStamp',
      'deviceType': 'KeyEventDeviceType get deviceType',
      'synthesized': 'bool get synthesized',
    },
  );
}

// =============================================================================
// KeyRepeatEvent Bridge
// =============================================================================

BridgedClass _createKeyRepeatEventBridge() {
  return BridgedClass(
    nativeType: $flutter_23.KeyRepeatEvent,
    name: 'KeyRepeatEvent',
    isAssignable: (v) => v is $flutter_23.KeyRepeatEvent,
    constructors: {
      '': (visitor, positional, named) {
        final physicalKey = D4.getRequiredNamedArg<$flutter_25.PhysicalKeyboardKey>(named, 'physicalKey', 'KeyRepeatEvent');
        final logicalKey = D4.getRequiredNamedArg<$flutter_25.LogicalKeyboardKey>(named, 'logicalKey', 'KeyRepeatEvent');
        final character = D4.getOptionalNamedArg<String?>(named, 'character');
        final timeStamp = D4.getRequiredNamedArg<Duration>(named, 'timeStamp', 'KeyRepeatEvent');
        if (!named.containsKey('deviceType')) {
          return $flutter_23.KeyRepeatEvent(physicalKey: physicalKey, logicalKey: logicalKey, character: character, timeStamp: timeStamp);
        }
        if (named.containsKey('deviceType')) {
          final deviceType = D4.getRequiredNamedArg<KeyEventDeviceType>(named, 'deviceType', 'KeyRepeatEvent');
          return $flutter_23.KeyRepeatEvent(physicalKey: physicalKey, logicalKey: logicalKey, character: character, timeStamp: timeStamp, deviceType: deviceType);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'physicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent').physicalKey,
      'logicalKey': (visitor, target) => D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent').logicalKey,
      'character': (visitor, target) => D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent').character,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent').timeStamp,
      'deviceType': (visitor, target) => D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent').deviceType,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent').synthesized,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.KeyRepeatEvent>(target, 'KeyRepeatEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const KeyRepeatEvent({required PhysicalKeyboardKey physicalKey, required LogicalKeyboardKey logicalKey, String? character, required Duration timeStamp, KeyEventDeviceType deviceType = ui.KeyEventDeviceType.keyboard})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'physicalKey': 'PhysicalKeyboardKey get physicalKey',
      'logicalKey': 'LogicalKeyboardKey get logicalKey',
      'character': 'String? get character',
      'timeStamp': 'Duration get timeStamp',
      'deviceType': 'KeyEventDeviceType get deviceType',
      'synthesized': 'bool get synthesized',
    },
  );
}

// =============================================================================
// HardwareKeyboard Bridge
// =============================================================================

BridgedClass _createHardwareKeyboardBridge() {
  return BridgedClass(
    nativeType: $flutter_23.HardwareKeyboard,
    name: 'HardwareKeyboard',
    isAssignable: (v) => v is $flutter_23.HardwareKeyboard,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_23.HardwareKeyboard();
      },
    },
    getters: {
      'physicalKeysPressed': (visitor, target) => D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard').physicalKeysPressed,
      'logicalKeysPressed': (visitor, target) => D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard').logicalKeysPressed,
      'lockModesEnabled': (visitor, target) => D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard').lockModesEnabled,
      'isControlPressed': (visitor, target) => D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard').isControlPressed,
      'isShiftPressed': (visitor, target) => D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard').isShiftPressed,
      'isAltPressed': (visitor, target) => D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard').isAltPressed,
      'isMetaPressed': (visitor, target) => D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard').isMetaPressed,
    },
    methods: {
      'lookUpLayout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'lookUpLayout');
        final physicalKey = D4.getRequiredArg<$flutter_25.PhysicalKeyboardKey>(positional, 0, 'physicalKey', 'lookUpLayout');
        return t.lookUpLayout(physicalKey);
      },
      'isLogicalKeyPressed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'isLogicalKeyPressed');
        final key = D4.getRequiredArg<$flutter_25.LogicalKeyboardKey>(positional, 0, 'key', 'isLogicalKeyPressed');
        return t.isLogicalKeyPressed(key);
      },
      'isPhysicalKeyPressed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'isPhysicalKeyPressed');
        final key = D4.getRequiredArg<$flutter_25.PhysicalKeyboardKey>(positional, 0, 'key', 'isPhysicalKeyPressed');
        return t.isPhysicalKeyPressed(key);
      },
      'addHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'addHandler');
        if (positional.isEmpty) {
          throw ArgumentError('addHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.addHandler(($flutter_23.KeyEvent p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as bool; });
        return null;
      },
      'removeHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'removeHandler');
        if (positional.isEmpty) {
          throw ArgumentError('removeHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.removeHandler(($flutter_23.KeyEvent p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as bool; });
        return null;
      },
      'syncKeyboardState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard');
        return t.syncKeyboardState();
      },
      'handleKeyEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.HardwareKeyboard>(target, 'HardwareKeyboard');
        D4.requireMinArgs(positional, 1, 'handleKeyEvent');
        final event = D4.getRequiredArg<$flutter_23.KeyEvent>(positional, 0, 'event', 'handleKeyEvent');
        return t.handleKeyEvent(event);
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_23.HardwareKeyboard.instance,
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
    nativeType: $flutter_37.RestorationManager,
    name: 'RestorationManager',
    isAssignable: (v) => v is $flutter_37.RestorationManager,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_37.RestorationManager();
      },
    },
    getters: {
      'rootBucket': (visitor, target) => D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager').rootBucket,
      'isReplacing': (visitor, target) => D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager').isReplacing,
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager').hasListeners,
    },
    methods: {
      'initChannels': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager');
        t.initChannels();
        return null;
      },
      'handleRestorationUpdateFromEngine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager');
        final enabled = D4.getRequiredNamedArg<bool>(named, 'enabled', 'handleRestorationUpdateFromEngine');
        final data = D4.getRequiredNamedArg<Uint8List?>(named, 'data', 'handleRestorationUpdateFromEngine');
        t.handleRestorationUpdateFromEngine(enabled: enabled, data: data);
        return null;
      },
      'sendToEngine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager');
        D4.requireMinArgs(positional, 1, 'sendToEngine');
        final encodedData = D4.getRequiredArg<Uint8List>(positional, 0, 'encodedData', 'sendToEngine');
        return t.sendToEngine(encodedData);
      },
      'flushData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager');
        t.flushData();
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager');
        (t as dynamic).dispose();
        return null;
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationManager>(target, 'RestorationManager');
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
      '': 'RestorationManager()',
    },
    methodSignatures: {
      'initChannels': 'void initChannels()',
      'handleRestorationUpdateFromEngine': 'void handleRestorationUpdateFromEngine({required bool enabled, required Uint8List? data})',
      'sendToEngine': 'Future<void> sendToEngine(Uint8List encodedData)',
      'flushData': 'void flushData()',
      'dispose': 'void dispose()',
      'addListener': 'void addListener(void Function() listener)',
      'removeListener': 'void removeListener(void Function() listener)',
    },
    getterSignatures: {
      'rootBucket': 'Future<RestorationBucket?> get rootBucket',
      'isReplacing': 'bool get isReplacing',
      'hasListeners': 'bool get hasListeners',
    },
  );
}

// =============================================================================
// RestorationBucket Bridge
// =============================================================================

BridgedClass _createRestorationBucketBridge() {
  return BridgedClass(
    nativeType: $flutter_37.RestorationBucket,
    name: 'RestorationBucket',
    isAssignable: (v) => v is $flutter_37.RestorationBucket,
    constructors: {
      'empty': (visitor, positional, named) {
        final restorationId = D4.getRequiredNamedArg<String>(named, 'restorationId', 'RestorationBucket');
        final debugOwner = D4.getRequiredNamedArg<Object?>(named, 'debugOwner', 'RestorationBucket');
        return $flutter_37.RestorationBucket.empty(restorationId: restorationId, debugOwner: debugOwner);
      },
      'root': (visitor, positional, named) {
        final manager = D4.getRequiredNamedArg<$flutter_37.RestorationManager>(named, 'manager', 'RestorationBucket');
        if (!named.containsKey('rawData')) {
          throw ArgumentError('RestorationBucket: Missing required named argument "rawData"');
        }
        final rawData = D4.coerceMapOrNull<Object?, Object?>(named['rawData'], 'rawData');
        return $flutter_37.RestorationBucket.root(manager: manager, rawData: rawData);
      },
      'child': (visitor, positional, named) {
        final restorationId = D4.getRequiredNamedArg<String>(named, 'restorationId', 'RestorationBucket');
        final parent = D4.getRequiredNamedArg<$flutter_37.RestorationBucket>(named, 'parent', 'RestorationBucket');
        final debugOwner = D4.getRequiredNamedArg<Object?>(named, 'debugOwner', 'RestorationBucket');
        return $flutter_37.RestorationBucket.child(restorationId: restorationId, parent: parent, debugOwner: debugOwner);
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket').debugOwner,
      'isReplacing': (visitor, target) => D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket').isReplacing,
      'restorationId': (visitor, target) => D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket').restorationId,
    },
    methods: {
      'read': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        D4.requireMinArgs(positional, 1, 'read');
        final restorationId = D4.getRequiredArg<String>(positional, 0, 'restorationId', 'read');
        return t.read(restorationId);
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        D4.requireMinArgs(positional, 2, 'write');
        final restorationId = D4.getRequiredArg<String>(positional, 0, 'restorationId', 'write');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'write');
        t.write(restorationId, value);
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        D4.requireMinArgs(positional, 1, 'remove');
        final restorationId = D4.getRequiredArg<String>(positional, 0, 'restorationId', 'remove');
        return t.remove(restorationId);
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        D4.requireMinArgs(positional, 1, 'contains');
        final restorationId = D4.getRequiredArg<String>(positional, 0, 'restorationId', 'contains');
        return t.contains(restorationId);
      },
      'claimChild': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        D4.requireMinArgs(positional, 1, 'claimChild');
        final restorationId = D4.getRequiredArg<String>(positional, 0, 'restorationId', 'claimChild');
        final debugOwner = D4.getRequiredNamedArg<Object?>(named, 'debugOwner', 'claimChild');
        return t.claimChild(restorationId, debugOwner: debugOwner);
      },
      'adoptChild': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        D4.requireMinArgs(positional, 1, 'adoptChild');
        final child = D4.getRequiredArg<$flutter_37.RestorationBucket>(positional, 0, 'child', 'adoptChild');
        t.adoptChild(child);
        return null;
      },
      'rename': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        D4.requireMinArgs(positional, 1, 'rename');
        final newRestorationId = D4.getRequiredArg<String>(positional, 0, 'newRestorationId', 'rename');
        t.rename(newRestorationId);
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_37.RestorationBucket>(target, 'RestorationBucket');
        return t.toString();
      },
    },
    constructorSignatures: {
      'empty': 'RestorationBucket.empty({required String restorationId, required Object? debugOwner})',
      'root': 'RestorationBucket.root({required RestorationManager manager, required Map<Object?, Object?>? rawData})',
      'child': 'RestorationBucket.child({required String restorationId, required RestorationBucket parent, required Object? debugOwner})',
    },
    methodSignatures: {
      'read': 'P? read(String restorationId)',
      'write': 'void write(String restorationId, P value)',
      'remove': 'P? remove(String restorationId)',
      'contains': 'bool contains(String restorationId)',
      'claimChild': 'RestorationBucket claimChild(String restorationId, {required Object? debugOwner})',
      'adoptChild': 'void adoptChild(RestorationBucket child)',
      'rename': 'void rename(String newRestorationId)',
      'dispose': 'void dispose()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'isReplacing': 'bool get isReplacing',
      'restorationId': 'String get restorationId',
    },
  );
}

// =============================================================================
// ServicesBinding Bridge
// =============================================================================

BridgedClass _createServicesBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_14.ServicesBinding,
    name: 'ServicesBinding',
    isAssignable: (v) => v is $flutter_14.ServicesBinding,
    constructors: {
    },
    getters: {
      'keyboard': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').keyboard,
      'keyEventManager': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').keyEventManager,
      'defaultBinaryMessenger': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').defaultBinaryMessenger,
      'channelBuffers': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').channelBuffers,
      'accessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').accessibilityFocus,
      'restorationManager': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').restorationManager,
      'window': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').platformDispatcher,
      'locked': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').locked,
      'lifecycleState': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').lifecycleState,
      'schedulingStrategy': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').schedulingStrategy,
      'transientCallbackCount': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').transientCallbackCount,
      'endOfFrame': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').endOfFrame,
      'hasScheduledFrame': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').hasScheduledFrame,
      'schedulerPhase': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').schedulerPhase,
      'framesEnabled': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').framesEnabled,
      'currentFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').currentFrameTimeStamp,
      'currentSystemFrameTimeStamp': (visitor, target) => D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').currentSystemFrameTimeStamp,
    },
    setters: {
      'schedulingStrategy': (visitor, target, value) {
        final schedulingStrategyRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'schedulingStrategy');
        D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding').schedulingStrategy = ({required int priority, required $flutter_8.SchedulerBinding scheduler}) { return D4.callInterpreterCallback(visitor!, schedulingStrategyRaw, [], {'priority': priority, 'scheduler': scheduler}) as bool; };
      },
    },
    methods: {
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.initInstances();
        return null;
      },
      'createBinaryMessenger': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.createBinaryMessenger();
      },
      'handleMemoryPressure': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.handleMemoryPressure();
        return null;
      },
      'handleSystemMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'handleSystemMessage');
        final systemMessage = D4.getRequiredArg<Object>(positional, 0, 'systemMessage', 'handleSystemMessage');
        return t.handleSystemMessage(systemMessage);
      },
      'initLicenses': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.initLicenses();
        return null;
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'evict': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'evict');
        final asset = D4.getRequiredArg<String>(positional, 0, 'asset', 'evict');
        t.evict(asset);
        return null;
      },
      'readInitialLifecycleStateFromNativeWindow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.readInitialLifecycleStateFromNativeWindow();
        return null;
      },
      'handleViewFocusChanged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'handleViewFocusChanged');
        final event = D4.getRequiredArg<ViewFocusEvent>(positional, 0, 'event', 'handleViewFocusChanged');
        t.handleViewFocusChanged(event);
        return null;
      },
      'handleRequestAppExit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.handleRequestAppExit();
      },
      'exitApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'exitApplication');
        final exitType = D4.getRequiredArg<AppExitType>(positional, 0, 'exitType', 'exitApplication');
        final exitCode = D4.getOptionalArgWithDefault<int>(positional, 1, 'exitCode', 0);
        return t.exitApplication(exitType, exitCode);
      },
      'createRestorationManager': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.createRestorationManager();
      },
      'setSystemUiChangeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'setSystemUiChangeCallback');
        if (positional.isEmpty) {
          throw ArgumentError('setSystemUiChangeCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.setSystemUiChangeCallback(callbackRaw == null ? null : (bool p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as Future<void>; });
        return null;
      },
      'initializationComplete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.initializationComplete();
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'lockEvents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'lockEvents');
        if (positional.isEmpty) {
          throw ArgumentError('lockEvents: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.lockEvents(() { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        (t as dynamic).unlocked();
        return null;
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.reassembleApplication();
      },
      'performReassemble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.performReassemble();
      },
      'registerSignalServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerSignalServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerSignalServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerSignalServiceExtension(name: name, callback: () { return D4.callInterpreterCallback(visitor!, callbackRaw, []) as Future<void>; });
        return null;
      },
      'registerBoolServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: (Map<String, String> p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as Future<Map<String, dynamic>>; });
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.toString();
      },
      'addTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'addTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'removeTimingsCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'removeTimingsCallback');
        if (positional.isEmpty) {
          throw ArgumentError('removeTimingsCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.removeTimingsCallback((List<FrameTiming> p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'handleAppLifecycleStateChanged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'handleAppLifecycleStateChanged');
        final state = D4.getRequiredArg<AppLifecycleState>(positional, 0, 'state', 'handleAppLifecycleStateChanged');
        t.handleAppLifecycleStateChanged(state);
        return null;
      },
      'scheduleTask': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 2, 'scheduleTask');
        if (positional.isEmpty) {
          throw ArgumentError('scheduleTask: Missing required argument "task" at position 0');
        }
        final taskRaw = positional[0];
        final priority = D4.getRequiredArg<$flutter_9.Priority>(positional, 1, 'priority', 'scheduleTask');
        final debugLabel = D4.getOptionalNamedArg<String?>(named, 'debugLabel');
        final flow = D4.getOptionalNamedArg<Flow?>(named, 'flow');
        return t.scheduleTask(() { return D4.callInterpreterCallback(visitor!, taskRaw, []) as FutureOr<Object>; }, priority, debugLabel: debugLabel, flow: flow);
      },
      'scheduleFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'cancelFrameCallbackWithId');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'cancelFrameCallbackWithId');
        t.cancelFrameCallbackWithId(id);
        return null;
      },
      'debugAssertNoTransientCallbacks': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTransientCallbacks');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTransientCallbacks');
        return t.debugAssertNoTransientCallbacks(reason);
      },
      'debugAssertNoPendingPerformanceModeRequests': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoPendingPerformanceModeRequests');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoPendingPerformanceModeRequests');
        return t.debugAssertNoPendingPerformanceModeRequests(reason);
      },
      'debugAssertNoTimeDilation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'debugAssertNoTimeDilation');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertNoTimeDilation');
        return t.debugAssertNoTimeDilation(reason);
      },
      'addPersistentFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'addPersistentFrameCallback');
        if (positional.isEmpty) {
          throw ArgumentError('addPersistentFrameCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.addPersistentFrameCallback((Duration p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'addPostFrameCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
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
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.ensureFrameCallbacksRegistered();
        return null;
      },
      'ensureVisualUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.ensureVisualUpdate();
        return null;
      },
      'scheduleFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.scheduleFrame();
        return null;
      },
      'scheduleForcedFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.scheduleForcedFrame();
        return null;
      },
      'scheduleWarmUpFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.scheduleWarmUpFrame();
        return null;
      },
      'resetEpoch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.resetEpoch();
        return null;
      },
      'handleBeginFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'handleBeginFrame');
        final rawTimeStamp = D4.getRequiredArg<Duration?>(positional, 0, 'rawTimeStamp', 'handleBeginFrame');
        t.handleBeginFrame(rawTimeStamp);
        return null;
      },
      'requestPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        D4.requireMinArgs(positional, 1, 'requestPerformanceMode');
        final mode = D4.getRequiredArg<DartPerformanceMode>(positional, 0, 'mode', 'requestPerformanceMode');
        return t.requestPerformanceMode(mode);
      },
      'debugGetRequestedPerformanceMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        return t.debugGetRequestedPerformanceMode();
      },
      'handleDrawFrame': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ServicesBinding>(target, 'ServicesBinding');
        t.handleDrawFrame();
        return null;
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_14.ServicesBinding.instance,
      'rootIsolateToken': (visitor) => $flutter_14.ServicesBinding.rootIsolateToken,
    },
    staticSetters: {
      'systemContextMenuClient': (visitor, value) => 
        $flutter_14.ServicesBinding.systemContextMenuClient = D4.extractBridgedArgOrNull<$flutter_14.SystemContextMenuClient>(value, 'systemContextMenuClient'),
    },
    methodSignatures: {
      'initInstances': 'void initInstances()',
      'createBinaryMessenger': 'BinaryMessenger createBinaryMessenger()',
      'handleMemoryPressure': 'void handleMemoryPressure()',
      'handleSystemMessage': 'Future<void> handleSystemMessage(Object systemMessage)',
      'initLicenses': 'void initLicenses()',
      'initServiceExtensions': 'void initServiceExtensions()',
      'evict': 'void evict(String asset)',
      'readInitialLifecycleStateFromNativeWindow': 'void readInitialLifecycleStateFromNativeWindow()',
      'handleViewFocusChanged': 'void handleViewFocusChanged(ui.ViewFocusEvent event)',
      'handleRequestAppExit': 'Future<ui.AppExitResponse> handleRequestAppExit()',
      'exitApplication': 'Future<ui.AppExitResponse> exitApplication(ui.AppExitType exitType, [int exitCode = 0])',
      'createRestorationManager': 'RestorationManager createRestorationManager()',
      'setSystemUiChangeCallback': 'void setSystemUiChangeCallback(SystemUiChangeCallback? callback)',
      'initializationComplete': 'Future<void> initializationComplete()',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
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
      'addTimingsCallback': 'void addTimingsCallback(void Function(List<FrameTiming>) callback)',
      'removeTimingsCallback': 'void removeTimingsCallback(void Function(List<FrameTiming>) callback)',
      'handleAppLifecycleStateChanged': 'void handleAppLifecycleStateChanged(AppLifecycleState state)',
      'scheduleTask': 'Future<T> scheduleTask(FutureOr<T> Function() task, Priority priority, {String? debugLabel, Flow? flow})',
      'scheduleFrameCallback': 'int scheduleFrameCallback(void Function(Duration) callback, {bool rescheduling = false, bool scheduleNewFrame = true})',
      'cancelFrameCallbackWithId': 'void cancelFrameCallbackWithId(int id)',
      'debugAssertNoTransientCallbacks': 'bool debugAssertNoTransientCallbacks(String reason)',
      'debugAssertNoPendingPerformanceModeRequests': 'bool debugAssertNoPendingPerformanceModeRequests(String reason)',
      'debugAssertNoTimeDilation': 'bool debugAssertNoTimeDilation(String reason)',
      'addPersistentFrameCallback': 'void addPersistentFrameCallback(void Function(Duration) callback)',
      'addPostFrameCallback': 'void addPostFrameCallback(void Function(Duration) callback, {String debugLabel = \'callback\'})',
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
      'keyboard': 'HardwareKeyboard get keyboard',
      'keyEventManager': 'KeyEventManager get keyEventManager',
      'defaultBinaryMessenger': 'BinaryMessenger get defaultBinaryMessenger',
      'channelBuffers': 'ui.ChannelBuffers get channelBuffers',
      'accessibilityFocus': 'ValueNotifier<int?> get accessibilityFocus',
      'restorationManager': 'RestorationManager get restorationManager',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
      'locked': 'bool get locked',
      'lifecycleState': 'AppLifecycleState? get lifecycleState',
      'schedulingStrategy': 'bool Function({required int priority, required SchedulerBinding scheduler}) get schedulingStrategy',
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
    nativeType: $flutter_14.SystemContextMenuClient,
    name: 'SystemContextMenuClient',
    isAssignable: (v) => v is $flutter_14.SystemContextMenuClient,
    constructors: {
    },
    methods: {
      'handleSystemHide': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.SystemContextMenuClient>(target, 'SystemContextMenuClient');
        t.handleSystemHide();
        return null;
      },
      'handleCustomContextMenuAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.SystemContextMenuClient>(target, 'SystemContextMenuClient');
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
    nativeType: $flutter_15.BrowserContextMenu,
    name: 'BrowserContextMenu',
    isAssignable: (v) => v is $flutter_15.BrowserContextMenu,
    constructors: {
    },
    staticGetters: {
      'enabled': (visitor) => $flutter_15.BrowserContextMenu.enabled,
    },
    staticMethods: {
      'disableContextMenu': (visitor, positional, named, typeArgs) {
        return $flutter_15.BrowserContextMenu.disableContextMenu();
      },
      'enableContextMenu': (visitor, positional, named, typeArgs) {
        return $flutter_15.BrowserContextMenu.enableContextMenu();
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
    nativeType: $flutter_16.ClipboardData,
    name: 'ClipboardData',
    isAssignable: (v) => v is $flutter_16.ClipboardData,
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'ClipboardData');
        return $flutter_16.ClipboardData(text: text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$flutter_16.ClipboardData>(target, 'ClipboardData').text,
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
    nativeType: $flutter_16.Clipboard,
    name: 'Clipboard',
    isAssignable: (v) => v is $flutter_16.Clipboard,
    constructors: {
    },
    staticGetters: {
      'kTextPlain': (visitor) => $flutter_16.Clipboard.kTextPlain,
    },
    staticMethods: {
      'setData': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setData');
        final data = D4.getRequiredArg<$flutter_16.ClipboardData>(positional, 0, 'data', 'setData');
        return $flutter_16.Clipboard.setData(data);
      },
      'getData': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getData');
        final format = D4.getRequiredArg<String>(positional, 0, 'format', 'getData');
        return $flutter_16.Clipboard.getData(format);
      },
      'hasStrings': (visitor, positional, named, typeArgs) {
        return $flutter_16.Clipboard.hasStrings();
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
    nativeType: $flutter_18.DeferredComponent,
    name: 'DeferredComponent',
    isAssignable: (v) => v is $flutter_18.DeferredComponent,
    constructors: {
    },
    staticMethods: {
      'installDeferredComponent': (visitor, positional, named, typeArgs) {
        final componentName = D4.getRequiredNamedArg<String>(named, 'componentName', 'installDeferredComponent');
        return $flutter_18.DeferredComponent.installDeferredComponent(componentName: componentName);
      },
      'uninstallDeferredComponent': (visitor, positional, named, typeArgs) {
        final componentName = D4.getRequiredNamedArg<String>(named, 'componentName', 'uninstallDeferredComponent');
        return $flutter_18.DeferredComponent.uninstallDeferredComponent(componentName: componentName);
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
    nativeType: $flutter_20.FlutterVersion,
    name: 'FlutterVersion',
    isAssignable: (v) => v is $flutter_20.FlutterVersion,
    constructors: {
    },
    staticGetters: {
      'version': (visitor) => $flutter_20.FlutterVersion.version,
      'channel': (visitor) => $flutter_20.FlutterVersion.channel,
      'gitUrl': (visitor) => $flutter_20.FlutterVersion.gitUrl,
      'frameworkRevision': (visitor) => $flutter_20.FlutterVersion.frameworkRevision,
      'engineRevision': (visitor) => $flutter_20.FlutterVersion.engineRevision,
      'dartVersion': (visitor) => $flutter_20.FlutterVersion.dartVersion,
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
    nativeType: $flutter_21.FontLoader,
    name: 'FontLoader',
    isAssignable: (v) => v is $flutter_21.FontLoader,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FontLoader');
        final family = D4.getRequiredArg<String>(positional, 0, 'family', 'FontLoader');
        return $flutter_21.FontLoader(family);
      },
    },
    getters: {
      'family': (visitor, target) => D4.validateTarget<$flutter_21.FontLoader>(target, 'FontLoader').family,
    },
    methods: {
      'addFont': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.FontLoader>(target, 'FontLoader');
        D4.requireMinArgs(positional, 1, 'addFont');
        final bytes = D4.getRequiredArg<Future<ByteData>>(positional, 0, 'bytes', 'addFont');
        t.addFont(bytes);
        return null;
      },
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.FontLoader>(target, 'FontLoader');
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
    nativeType: $flutter_22.HapticFeedback,
    name: 'HapticFeedback',
    isAssignable: (v) => v is $flutter_22.HapticFeedback,
    constructors: {
    },
    staticMethods: {
      'vibrate': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.vibrate();
      },
      'lightImpact': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.lightImpact();
      },
      'mediumImpact': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.mediumImpact();
      },
      'heavyImpact': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.heavyImpact();
      },
      'selectionClick': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.selectionClick();
      },
      'successNotification': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.successNotification();
      },
      'warningNotification': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.warningNotification();
      },
      'errorNotification': (visitor, positional, named, typeArgs) {
        return $flutter_22.HapticFeedback.errorNotification();
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
    nativeType: $flutter_24.KeyboardInsertedContent,
    name: 'KeyboardInsertedContent',
    isAssignable: (v) => v is $flutter_24.KeyboardInsertedContent,
    constructors: {
      '': (visitor, positional, named) {
        final mimeType = D4.getRequiredNamedArg<String>(named, 'mimeType', 'KeyboardInsertedContent');
        final uri = D4.getRequiredNamedArg<String>(named, 'uri', 'KeyboardInsertedContent');
        final data = D4.getOptionalNamedArg<Uint8List?>(named, 'data');
        return $flutter_24.KeyboardInsertedContent(mimeType: mimeType, uri: uri, data: data);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'KeyboardInsertedContent');
        if (positional.isEmpty) {
          throw ArgumentError('KeyboardInsertedContent: Missing required argument "metadata" at position 0');
        }
        final metadata = D4.coerceMap<String, dynamic>(positional[0], 'metadata');
        return $flutter_24.KeyboardInsertedContent.fromJson(metadata);
      },
    },
    getters: {
      'mimeType': (visitor, target) => D4.validateTarget<$flutter_24.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').mimeType,
      'uri': (visitor, target) => D4.validateTarget<$flutter_24.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').uri,
      'data': (visitor, target) => D4.validateTarget<$flutter_24.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').data,
      'hasData': (visitor, target) => D4.validateTarget<$flutter_24.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').hasData,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_24.KeyboardInsertedContent>(target, 'KeyboardInsertedContent').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.KeyboardInsertedContent>(target, 'KeyboardInsertedContent');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.KeyboardInsertedContent>(target, 'KeyboardInsertedContent');
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
    nativeType: $flutter_27.LiveText,
    name: 'LiveText',
    isAssignable: (v) => v is $flutter_27.LiveText,
    constructors: {
    },
    staticMethods: {
      'isLiveTextInputAvailable': (visitor, positional, named, typeArgs) {
        return $flutter_27.LiveText.isLiveTextInputAvailable();
      },
      'startLiveTextInput': (visitor, positional, named, typeArgs) {
        return $flutter_27.LiveText.startLiveTextInput();
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
    nativeType: $flutter_28.MessageCodec,
    name: 'MessageCodec',
    isAssignable: (v) => v is $flutter_28.MessageCodec,
    constructors: {
    },
    methods: {
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MessageCodec>(target, 'MessageCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MessageCodec>(target, 'MessageCodec');
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
    nativeType: $flutter_28.MethodCall,
    name: 'MethodCall',
    isAssignable: (v) => v is $flutter_28.MethodCall,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MethodCall');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'MethodCall');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return $flutter_28.MethodCall(method, arguments);
      },
    },
    getters: {
      'method': (visitor, target) => D4.validateTarget<$flutter_28.MethodCall>(target, 'MethodCall').method,
      'arguments': (visitor, target) => D4.validateTarget<$flutter_28.MethodCall>(target, 'MethodCall').arguments,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MethodCall>(target, 'MethodCall');
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
    nativeType: $flutter_28.MethodCodec,
    name: 'MethodCodec',
    isAssignable: (v) => v is $flutter_28.MethodCodec,
    constructors: {
    },
    methods: {
      'encodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeMethodCall');
        final methodCall = D4.getRequiredArg<$flutter_28.MethodCall>(positional, 0, 'methodCall', 'encodeMethodCall');
        return t.encodeMethodCall(methodCall);
      },
      'decodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeMethodCall');
        final methodCall = D4.getRequiredArg<ByteData?>(positional, 0, 'methodCall', 'decodeMethodCall');
        return t.decodeMethodCall(methodCall);
      },
      'decodeEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeEnvelope');
        final envelope = D4.getRequiredArg<ByteData>(positional, 0, 'envelope', 'decodeEnvelope');
        return t.decodeEnvelope(envelope);
      },
      'encodeSuccessEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MethodCodec>(target, 'MethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeSuccessEnvelope');
        final result = D4.getRequiredArg<Object?>(positional, 0, 'result', 'encodeSuccessEnvelope');
        return t.encodeSuccessEnvelope(result);
      },
      'encodeErrorEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MethodCodec>(target, 'MethodCodec');
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
    nativeType: $flutter_28.PlatformException,
    name: 'PlatformException',
    isAssignable: (v) => v is $flutter_28.PlatformException,
    constructors: {
      '': (visitor, positional, named) {
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'PlatformException');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final stacktrace = D4.getOptionalNamedArg<String?>(named, 'stacktrace');
        if (!named.containsKey('details')) {
          return $flutter_28.PlatformException(code: code, message: message, stacktrace: stacktrace);
        }
        if (named.containsKey('details')) {
          final details = D4.getRequiredNamedArg<dynamic>(named, 'details', 'PlatformException');
          return $flutter_28.PlatformException(code: code, message: message, stacktrace: stacktrace, details: details);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'code': (visitor, target) => D4.validateTarget<$flutter_28.PlatformException>(target, 'PlatformException').code,
      'message': (visitor, target) => D4.validateTarget<$flutter_28.PlatformException>(target, 'PlatformException').message,
      'details': (visitor, target) => D4.validateTarget<$flutter_28.PlatformException>(target, 'PlatformException').details,
      'stacktrace': (visitor, target) => D4.validateTarget<$flutter_28.PlatformException>(target, 'PlatformException').stacktrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.PlatformException>(target, 'PlatformException');
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
    nativeType: $flutter_28.MissingPluginException,
    name: 'MissingPluginException',
    isAssignable: (v) => v is $flutter_28.MissingPluginException,
    constructors: {
      '': (visitor, positional, named) {
        final message = D4.getOptionalArg<String?>(positional, 0, 'message');
        return $flutter_28.MissingPluginException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$flutter_28.MissingPluginException>(target, 'MissingPluginException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.MissingPluginException>(target, 'MissingPluginException');
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
    nativeType: $flutter_29.BinaryCodec,
    name: 'BinaryCodec',
    isAssignable: (v) => v is $flutter_29.BinaryCodec,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_29.BinaryCodec();
      },
    },
    methods: {
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BinaryCodec>(target, 'BinaryCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BinaryCodec>(target, 'BinaryCodec');
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
    nativeType: $flutter_29.StringCodec,
    name: 'StringCodec',
    isAssignable: (v) => v is $flutter_29.StringCodec,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_29.StringCodec();
      },
    },
    methods: {
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StringCodec>(target, 'StringCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StringCodec>(target, 'StringCodec');
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
    nativeType: $flutter_29.JSONMessageCodec,
    name: 'JSONMessageCodec',
    isAssignable: (v) => v is $flutter_29.JSONMessageCodec,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_29.JSONMessageCodec();
      },
    },
    methods: {
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.JSONMessageCodec>(target, 'JSONMessageCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<Object?>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.JSONMessageCodec>(target, 'JSONMessageCodec');
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
    nativeType: $flutter_29.JSONMethodCodec,
    name: 'JSONMethodCodec',
    isAssignable: (v) => v is $flutter_29.JSONMethodCodec,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_29.JSONMethodCodec();
      },
    },
    methods: {
      'encodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeMethodCall');
        final methodCall = D4.getRequiredArg<$flutter_28.MethodCall>(positional, 0, 'methodCall', 'encodeMethodCall');
        return t.encodeMethodCall(methodCall);
      },
      'decodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeMethodCall');
        final methodCall = D4.getRequiredArg<ByteData?>(positional, 0, 'methodCall', 'decodeMethodCall');
        return t.decodeMethodCall(methodCall);
      },
      'decodeEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeEnvelope');
        final envelope = D4.getRequiredArg<ByteData>(positional, 0, 'envelope', 'decodeEnvelope');
        return t.decodeEnvelope(envelope);
      },
      'encodeSuccessEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.JSONMethodCodec>(target, 'JSONMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeSuccessEnvelope');
        final result = D4.getRequiredArg<Object?>(positional, 0, 'result', 'encodeSuccessEnvelope');
        return t.encodeSuccessEnvelope(result);
      },
      'encodeErrorEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.JSONMethodCodec>(target, 'JSONMethodCodec');
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
    nativeType: $flutter_29.StandardMessageCodec,
    name: 'StandardMessageCodec',
    isAssignable: (v) => v is $flutter_29.StandardMessageCodec,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_29.StandardMessageCodec();
      },
    },
    methods: {
      'encodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'encodeMessage');
        final message = D4.getRequiredArg<Object?>(positional, 0, 'message', 'encodeMessage');
        return t.encodeMessage(message);
      },
      'decodeMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'decodeMessage');
        final message = D4.getRequiredArg<ByteData?>(positional, 0, 'message', 'decodeMessage');
        return t.decodeMessage(message);
      },
      'writeValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 2, 'writeValue');
        final buffer = D4.getRequiredArg<$flutter_6.WriteBuffer>(positional, 0, 'buffer', 'writeValue');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'writeValue');
        t.writeValue(buffer, value);
        return null;
      },
      'readValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'readValue');
        final buffer = D4.getRequiredArg<$flutter_6.ReadBuffer>(positional, 0, 'buffer', 'readValue');
        return t.readValue(buffer);
      },
      'readValueOfType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 2, 'readValueOfType');
        final type = D4.getRequiredArg<int>(positional, 0, 'type', 'readValueOfType');
        final buffer = D4.getRequiredArg<$flutter_6.ReadBuffer>(positional, 1, 'buffer', 'readValueOfType');
        return t.readValueOfType(type, buffer);
      },
      'writeSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 2, 'writeSize');
        final buffer = D4.getRequiredArg<$flutter_6.WriteBuffer>(positional, 0, 'buffer', 'writeSize');
        final value = D4.getRequiredArg<int>(positional, 1, 'value', 'writeSize');
        t.writeSize(buffer, value);
        return null;
      },
      'readSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMessageCodec>(target, 'StandardMessageCodec');
        D4.requireMinArgs(positional, 1, 'readSize');
        final buffer = D4.getRequiredArg<$flutter_6.ReadBuffer>(positional, 0, 'buffer', 'readSize');
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
    nativeType: $flutter_29.StandardMethodCodec,
    name: 'StandardMethodCodec',
    isAssignable: (v) => v is $flutter_29.StandardMethodCodec,
    constructors: {
      '': (visitor, positional, named) {
        final messageCodec = D4.getOptionalArgWithDefault<$flutter_29.StandardMessageCodec>(positional, 0, 'messageCodec', const $flutter_29.StandardMessageCodec());
        return $flutter_29.StandardMethodCodec(messageCodec);
      },
    },
    getters: {
      'messageCodec': (visitor, target) => D4.validateTarget<$flutter_29.StandardMethodCodec>(target, 'StandardMethodCodec').messageCodec,
    },
    methods: {
      'encodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMethodCodec>(target, 'StandardMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeMethodCall');
        final methodCall = D4.getRequiredArg<$flutter_28.MethodCall>(positional, 0, 'methodCall', 'encodeMethodCall');
        return t.encodeMethodCall(methodCall);
      },
      'decodeMethodCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMethodCodec>(target, 'StandardMethodCodec');
        D4.requireMinArgs(positional, 1, 'decodeMethodCall');
        final methodCall = D4.getRequiredArg<ByteData?>(positional, 0, 'methodCall', 'decodeMethodCall');
        return t.decodeMethodCall(methodCall);
      },
      'encodeSuccessEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMethodCodec>(target, 'StandardMethodCodec');
        D4.requireMinArgs(positional, 1, 'encodeSuccessEnvelope');
        final result = D4.getRequiredArg<Object?>(positional, 0, 'result', 'encodeSuccessEnvelope');
        return t.encodeSuccessEnvelope(result);
      },
      'encodeErrorEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMethodCodec>(target, 'StandardMethodCodec');
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'encodeErrorEnvelope');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final details = D4.getOptionalNamedArg<Object?>(named, 'details');
        return t.encodeErrorEnvelope(code: code, message: message, details: details);
      },
      'decodeEnvelope': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.StandardMethodCodec>(target, 'StandardMethodCodec');
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
    nativeType: $flutter_7.PointerEvent,
    name: 'PointerEvent',
    isAssignable: (v) => v is $flutter_7.PointerEvent,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').position,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').localPosition,
      'delta': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').delta,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').localDelta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').distance,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').distanceMin,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent').original,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent');
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
        final t = D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.PointerEvent>(target, 'PointerEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    staticMethods: {
      'transformPosition': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'transformPosition');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformPosition');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'transformPosition');
        return $flutter_7.PointerEvent.transformPosition(transform, position);
      },
      'transformDeltaViaPositions': (visitor, positional, named, typeArgs) {
        final untransformedEndPosition = D4.getRequiredNamedArg<Offset>(named, 'untransformedEndPosition', 'transformDeltaViaPositions');
        final transformedEndPosition = D4.getOptionalNamedArg<Offset?>(named, 'transformedEndPosition');
        final untransformedDelta = D4.getRequiredNamedArg<Offset>(named, 'untransformedDelta', 'transformDeltaViaPositions');
        final transform = D4.getRequiredNamedArg<$vector_math_1.Matrix4?>(named, 'transform', 'transformDeltaViaPositions');
        return $flutter_7.PointerEvent.transformDeltaViaPositions(untransformedEndPosition: untransformedEndPosition, transformedEndPosition: transformedEndPosition, untransformedDelta: untransformedDelta, transform: transform);
      },
      'removePerspectiveTransform': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removePerspectiveTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'removePerspectiveTransform');
        return $flutter_7.PointerEvent.removePerspectiveTransform(transform);
      },
    },
    methodSignatures: {
      'transformed': 'PointerEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_30.MouseCursorManager,
    name: 'MouseCursorManager',
    isAssignable: (v) => v is $flutter_30.MouseCursorManager,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MouseCursorManager');
        final fallbackMouseCursor = D4.getRequiredArg<$flutter_30.MouseCursor>(positional, 0, 'fallbackMouseCursor', 'MouseCursorManager');
        return $flutter_30.MouseCursorManager(fallbackMouseCursor);
      },
    },
    getters: {
      'fallbackMouseCursor': (visitor, target) => D4.validateTarget<$flutter_30.MouseCursorManager>(target, 'MouseCursorManager').fallbackMouseCursor,
    },
    methods: {
      'debugDeviceActiveCursor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursorManager>(target, 'MouseCursorManager');
        D4.requireMinArgs(positional, 1, 'debugDeviceActiveCursor');
        final device = D4.getRequiredArg<int>(positional, 0, 'device', 'debugDeviceActiveCursor');
        return t.debugDeviceActiveCursor(device);
      },
      'handleDeviceCursorUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursorManager>(target, 'MouseCursorManager');
        D4.requireMinArgs(positional, 3, 'handleDeviceCursorUpdate');
        final device = D4.getRequiredArg<int>(positional, 0, 'device', 'handleDeviceCursorUpdate');
        final triggeringEvent = D4.getRequiredArg<$flutter_7.PointerEvent?>(positional, 1, 'triggeringEvent', 'handleDeviceCursorUpdate');
        if (positional.length <= 2) {
          throw ArgumentError('handleDeviceCursorUpdate: Missing required argument "cursorCandidates" at position 2');
        }
        final cursorCandidates = D4.coerceList<$flutter_30.MouseCursor>(positional[2], 'cursorCandidates');
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
    nativeType: $flutter_30.MouseCursorSession,
    name: 'MouseCursorSession',
    isAssignable: (v) => v is $flutter_30.MouseCursorSession,
    constructors: {
    },
    getters: {
      'cursor': (visitor, target) => (D4.validateTarget<$flutter_30.MouseCursorSession>(target, 'MouseCursorSession') as dynamic).cursor,
      'device': (visitor, target) => D4.validateTarget<$flutter_30.MouseCursorSession>(target, 'MouseCursorSession').device,
    },
    methods: {
      'activate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursorSession>(target, 'MouseCursorSession');
        return (t as dynamic).activate();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursorSession>(target, 'MouseCursorSession');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'activate': 'Future<void> activate()',
      'dispose': 'void dispose()',
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
    nativeType: $flutter_30.MouseCursor,
    name: 'MouseCursor',
    isAssignable: (v) => v is $flutter_30.MouseCursor,
    constructors: {
    },
    getters: {
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_30.MouseCursor>(target, 'MouseCursor').debugDescription,
    },
    methods: {
      'createSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursor>(target, 'MouseCursor');
        D4.requireMinArgs(positional, 1, 'createSession');
        final device = D4.getRequiredArg<int>(positional, 0, 'device', 'createSession');
        return t.createSession(device);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursor>(target, 'MouseCursor');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursor>(target, 'MouseCursor');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursor>(target, 'MouseCursor');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.MouseCursor>(target, 'MouseCursor');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
    },
    staticGetters: {
      'defer': (visitor) => $flutter_30.MouseCursor.defer,
      'uncontrolled': (visitor) => $flutter_30.MouseCursor.uncontrolled,
    },
    methodSignatures: {
      'createSession': 'MouseCursorSession createSession(int device)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_30.SystemMouseCursor,
    name: 'SystemMouseCursor',
    isAssignable: (v) => v is $flutter_30.SystemMouseCursor,
    constructors: {
    },
    getters: {
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor').debugDescription,
      'kind': (visitor, target) => D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor').kind,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor').hashCode,
    },
    methods: {
      'createSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor');
        D4.requireMinArgs(positional, 1, 'createSession');
        final device = D4.getRequiredArg<int>(positional, 0, 'device', 'createSession');
        return t.createSession(device);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.SystemMouseCursor>(target, 'SystemMouseCursor');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    methodSignatures: {
      'createSession': 'MouseCursorSession createSession(int device)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_30.SystemMouseCursors,
    name: 'SystemMouseCursors',
    isAssignable: (v) => v is $flutter_30.SystemMouseCursors,
    constructors: {
    },
    staticGetters: {
      'none': (visitor) => $flutter_30.SystemMouseCursors.none,
      'basic': (visitor) => $flutter_30.SystemMouseCursors.basic,
      'click': (visitor) => $flutter_30.SystemMouseCursors.click,
      'forbidden': (visitor) => $flutter_30.SystemMouseCursors.forbidden,
      'wait': (visitor) => $flutter_30.SystemMouseCursors.wait,
      'progress': (visitor) => $flutter_30.SystemMouseCursors.progress,
      'contextMenu': (visitor) => $flutter_30.SystemMouseCursors.contextMenu,
      'help': (visitor) => $flutter_30.SystemMouseCursors.help,
      'text': (visitor) => $flutter_30.SystemMouseCursors.text,
      'verticalText': (visitor) => $flutter_30.SystemMouseCursors.verticalText,
      'cell': (visitor) => $flutter_30.SystemMouseCursors.cell,
      'precise': (visitor) => $flutter_30.SystemMouseCursors.precise,
      'move': (visitor) => $flutter_30.SystemMouseCursors.move,
      'grab': (visitor) => $flutter_30.SystemMouseCursors.grab,
      'grabbing': (visitor) => $flutter_30.SystemMouseCursors.grabbing,
      'noDrop': (visitor) => $flutter_30.SystemMouseCursors.noDrop,
      'alias': (visitor) => $flutter_30.SystemMouseCursors.alias,
      'copy': (visitor) => $flutter_30.SystemMouseCursors.copy,
      'disappearing': (visitor) => $flutter_30.SystemMouseCursors.disappearing,
      'allScroll': (visitor) => $flutter_30.SystemMouseCursors.allScroll,
      'resizeLeftRight': (visitor) => $flutter_30.SystemMouseCursors.resizeLeftRight,
      'resizeUpDown': (visitor) => $flutter_30.SystemMouseCursors.resizeUpDown,
      'resizeUpLeftDownRight': (visitor) => $flutter_30.SystemMouseCursors.resizeUpLeftDownRight,
      'resizeUpRightDownLeft': (visitor) => $flutter_30.SystemMouseCursors.resizeUpRightDownLeft,
      'resizeUp': (visitor) => $flutter_30.SystemMouseCursors.resizeUp,
      'resizeDown': (visitor) => $flutter_30.SystemMouseCursors.resizeDown,
      'resizeLeft': (visitor) => $flutter_30.SystemMouseCursors.resizeLeft,
      'resizeRight': (visitor) => $flutter_30.SystemMouseCursors.resizeRight,
      'resizeUpLeft': (visitor) => $flutter_30.SystemMouseCursors.resizeUpLeft,
      'resizeUpRight': (visitor) => $flutter_30.SystemMouseCursors.resizeUpRight,
      'resizeDownLeft': (visitor) => $flutter_30.SystemMouseCursors.resizeDownLeft,
      'resizeDownRight': (visitor) => $flutter_30.SystemMouseCursors.resizeDownRight,
      'resizeColumn': (visitor) => $flutter_30.SystemMouseCursors.resizeColumn,
      'resizeRow': (visitor) => $flutter_30.SystemMouseCursors.resizeRow,
      'zoomIn': (visitor) => $flutter_30.SystemMouseCursors.zoomIn,
      'zoomOut': (visitor) => $flutter_30.SystemMouseCursors.zoomOut,
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
    nativeType: $flutter_31.MouseTrackerAnnotation,
    name: 'MouseTrackerAnnotation',
    isAssignable: (v) => v is $flutter_31.MouseTrackerAnnotation,
    constructors: {
      '': (visitor, positional, named) {
        final onEnterRaw = named['onEnter'];
        final onExitRaw = named['onExit'];
        final cursor = D4.getNamedArgWithDefault<$flutter_30.MouseCursor>(named, 'cursor', $flutter_30.MouseCursor.defer);
        final validForMouseTracker = D4.getNamedArgWithDefault<bool>(named, 'validForMouseTracker', true);
        return $flutter_31.MouseTrackerAnnotation(onEnter: onEnterRaw == null ? null : ($flutter_7.PointerEnterEvent p0) { D4.callInterpreterCallback(visitor!, onEnterRaw, [p0]); }, onExit: onExitRaw == null ? null : ($flutter_7.PointerExitEvent p0) { D4.callInterpreterCallback(visitor!, onExitRaw, [p0]); }, cursor: cursor, validForMouseTracker: validForMouseTracker);
      },
    },
    getters: {
      'onEnter': (visitor, target) => D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation').onEnter,
      'onExit': (visitor, target) => D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation').onExit,
      'cursor': (visitor, target) => (D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation') as dynamic).cursor,
      'validForMouseTracker': (visitor, target) => D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation').validForMouseTracker,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.MouseTrackerAnnotation>(target, 'MouseTrackerAnnotation');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const MouseTrackerAnnotation({void Function(PointerEnterEvent)? onEnter, void Function(PointerExitEvent)? onExit, MouseCursor cursor = MouseCursor.defer, bool validForMouseTracker = true})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_32.BasicMessageChannel,
    name: 'BasicMessageChannel',
    isAssignable: (v) => v is $flutter_32.BasicMessageChannel,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'BasicMessageChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'BasicMessageChannel');
        final codec = D4.getRequiredArg<$flutter_28.MessageCodec<dynamic>>(positional, 1, 'codec', 'BasicMessageChannel');
        final binaryMessenger = D4.getOptionalNamedArg<$flutter_13.BinaryMessenger?>(named, 'binaryMessenger');
        return $flutter_32.BasicMessageChannel(name, codec, binaryMessenger: binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_32.BasicMessageChannel>(target, 'BasicMessageChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_32.BasicMessageChannel>(target, 'BasicMessageChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_32.BasicMessageChannel>(target, 'BasicMessageChannel').binaryMessenger,
    },
    methods: {
      'send': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.BasicMessageChannel>(target, 'BasicMessageChannel');
        D4.requireMinArgs(positional, 1, 'send');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'send');
        return t.send(message);
      },
      'setMessageHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.BasicMessageChannel>(target, 'BasicMessageChannel');
        D4.requireMinArgs(positional, 1, 'setMessageHandler');
        if (positional.isEmpty) {
          throw ArgumentError('setMessageHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.setMessageHandler(handlerRaw == null ? null : (dynamic p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<dynamic>; });
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
    nativeType: $flutter_32.MethodChannel,
    name: 'MethodChannel',
    isAssignable: (v) => v is $flutter_32.MethodChannel,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MethodChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MethodChannel');
        final codec = D4.getOptionalArgWithDefault<$flutter_28.MethodCodec>(positional, 1, 'codec', const $flutter_29.StandardMethodCodec());
        final binaryMessenger = D4.getOptionalArg<$flutter_13.BinaryMessenger?>(positional, 2, 'binaryMessenger');
        return $flutter_32.MethodChannel(name, codec, binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_32.MethodChannel>(target, 'MethodChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_32.MethodChannel>(target, 'MethodChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_32.MethodChannel>(target, 'MethodChannel').binaryMessenger,
    },
    methods: {
      'invokeMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMethod(method, arguments);
      },
      'invokeListMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeListMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeListMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeListMethod(method, arguments);
      },
      'invokeMapMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMapMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMapMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMapMethod(method, arguments);
      },
      'setMethodCallHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.MethodChannel>(target, 'MethodChannel');
        D4.requireMinArgs(positional, 1, 'setMethodCallHandler');
        if (positional.isEmpty) {
          throw ArgumentError('setMethodCallHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.setMethodCallHandler(handlerRaw == null ? null : ($flutter_28.MethodCall p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<dynamic>; });
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
    nativeType: $flutter_32.OptionalMethodChannel,
    name: 'OptionalMethodChannel',
    isAssignable: (v) => v is $flutter_32.OptionalMethodChannel,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OptionalMethodChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'OptionalMethodChannel');
        final codec = D4.getOptionalArgWithDefault<$flutter_28.MethodCodec>(positional, 1, 'codec', const $flutter_29.StandardMethodCodec());
        final binaryMessenger = D4.getOptionalArg<$flutter_13.BinaryMessenger?>(positional, 2, 'binaryMessenger');
        return $flutter_32.OptionalMethodChannel(name, codec, binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_32.OptionalMethodChannel>(target, 'OptionalMethodChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_32.OptionalMethodChannel>(target, 'OptionalMethodChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_32.OptionalMethodChannel>(target, 'OptionalMethodChannel').binaryMessenger,
    },
    methods: {
      'invokeMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMethod(method, arguments);
      },
      'invokeListMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeListMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeListMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeListMethod(method, arguments);
      },
      'invokeMapMethod': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'invokeMapMethod');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'invokeMapMethod');
        final arguments = D4.getOptionalArg<dynamic>(positional, 1, 'arguments');
        return t.invokeMapMethod(method, arguments);
      },
      'setMethodCallHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.OptionalMethodChannel>(target, 'OptionalMethodChannel');
        D4.requireMinArgs(positional, 1, 'setMethodCallHandler');
        if (positional.isEmpty) {
          throw ArgumentError('setMethodCallHandler: Missing required argument "handler" at position 0');
        }
        final handlerRaw = positional[0];
        t.setMethodCallHandler(handlerRaw == null ? null : ($flutter_28.MethodCall p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<dynamic>; });
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
    nativeType: $flutter_32.EventChannel,
    name: 'EventChannel',
    isAssignable: (v) => v is $flutter_32.EventChannel,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'EventChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'EventChannel');
        final codec = D4.getOptionalArgWithDefault<$flutter_28.MethodCodec>(positional, 1, 'codec', const $flutter_29.StandardMethodCodec());
        final binaryMessenger = D4.getOptionalArg<$flutter_13.BinaryMessenger?>(positional, 2, 'binaryMessenger');
        return $flutter_32.EventChannel(name, codec, binaryMessenger);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_32.EventChannel>(target, 'EventChannel').name,
      'codec': (visitor, target) => D4.validateTarget<$flutter_32.EventChannel>(target, 'EventChannel').codec,
      'binaryMessenger': (visitor, target) => D4.validateTarget<$flutter_32.EventChannel>(target, 'EventChannel').binaryMessenger,
    },
    methods: {
      'receiveBroadcastStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_32.EventChannel>(target, 'EventChannel');
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
    nativeType: $flutter_33.PlatformViewsRegistry,
    name: 'PlatformViewsRegistry',
    isAssignable: (v) => v is $flutter_33.PlatformViewsRegistry,
    constructors: {
    },
    methods: {
      'getNextPlatformViewId': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.PlatformViewsRegistry>(target, 'PlatformViewsRegistry');
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
    nativeType: $flutter_33.PlatformViewsService,
    name: 'PlatformViewsService',
    isAssignable: (v) => v is $flutter_33.PlatformViewsService,
    constructors: {
    },
    staticMethods: {
      'initAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_28.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); };
        return $flutter_33.PlatformViewsService.initAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initSurfaceAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initSurfaceAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initSurfaceAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initSurfaceAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initSurfaceAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_28.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); };
        return $flutter_33.PlatformViewsService.initSurfaceAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initExpensiveAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initExpensiveAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initExpensiveAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initExpensiveAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initExpensiveAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_28.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); };
        return $flutter_33.PlatformViewsService.initExpensiveAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initHybridAndroidView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initHybridAndroidView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initHybridAndroidView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initHybridAndroidView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initHybridAndroidView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_28.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); };
        return $flutter_33.PlatformViewsService.initHybridAndroidView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initUiKitView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initUiKitView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initUiKitView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initUiKitView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initUiKitView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_28.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); };
        return $flutter_33.PlatformViewsService.initUiKitView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
      },
      'initAppKitView': (visitor, positional, named, typeArgs) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'initAppKitView');
        final viewType = D4.getRequiredNamedArg<String>(named, 'viewType', 'initAppKitView');
        final layoutDirection = D4.getRequiredNamedArg<TextDirection>(named, 'layoutDirection', 'initAppKitView');
        final creationParams = D4.getRequiredNamedArgTodoDefault<dynamic>(named, 'creationParams', 'initAppKitView', '<default unavailable>');
        final creationParamsCodec = D4.getOptionalNamedArg<$flutter_28.MessageCodec<dynamic>?>(named, 'creationParamsCodec');
        final onFocusRaw = named['onFocus'];
        final onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); };
        return $flutter_33.PlatformViewsService.initAppKitView(id: id, viewType: viewType, layoutDirection: layoutDirection, creationParams: creationParams, creationParamsCodec: creationParamsCodec, onFocus: onFocus);
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
    nativeType: $flutter_33.AndroidPointerProperties,
    name: 'AndroidPointerProperties',
    isAssignable: (v) => v is $flutter_33.AndroidPointerProperties,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'AndroidPointerProperties');
        final toolType = D4.getRequiredNamedArg<int>(named, 'toolType', 'AndroidPointerProperties');
        return $flutter_33.AndroidPointerProperties(id: id, toolType: toolType);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerProperties>(target, 'AndroidPointerProperties').id,
      'toolType': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerProperties>(target, 'AndroidPointerProperties').toolType,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidPointerProperties>(target, 'AndroidPointerProperties');
        return t.toString();
      },
    },
    staticGetters: {
      'kToolTypeUnknown': (visitor) => $flutter_33.AndroidPointerProperties.kToolTypeUnknown,
      'kToolTypeFinger': (visitor) => $flutter_33.AndroidPointerProperties.kToolTypeFinger,
      'kToolTypeStylus': (visitor) => $flutter_33.AndroidPointerProperties.kToolTypeStylus,
      'kToolTypeMouse': (visitor) => $flutter_33.AndroidPointerProperties.kToolTypeMouse,
      'kToolTypeEraser': (visitor) => $flutter_33.AndroidPointerProperties.kToolTypeEraser,
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
    nativeType: $flutter_33.AndroidPointerCoords,
    name: 'AndroidPointerCoords',
    isAssignable: (v) => v is $flutter_33.AndroidPointerCoords,
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
        return $flutter_33.AndroidPointerCoords(orientation: orientation, pressure: pressure, size: size, toolMajor: toolMajor, toolMinor: toolMinor, touchMajor: touchMajor, touchMinor: touchMinor, x: x, y: y);
      },
    },
    getters: {
      'orientation': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').orientation,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').pressure,
      'size': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').size,
      'toolMajor': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').toolMajor,
      'toolMinor': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').toolMinor,
      'touchMajor': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').touchMajor,
      'touchMinor': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').touchMinor,
      'x': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords').y,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidPointerCoords>(target, 'AndroidPointerCoords');
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
    nativeType: $flutter_33.AndroidMotionEvent,
    name: 'AndroidMotionEvent',
    isAssignable: (v) => v is $flutter_33.AndroidMotionEvent,
    constructors: {
      '': (visitor, positional, named) {
        final downTime = D4.getRequiredNamedArg<int>(named, 'downTime', 'AndroidMotionEvent');
        final eventTime = D4.getRequiredNamedArg<int>(named, 'eventTime', 'AndroidMotionEvent');
        final action = D4.getRequiredNamedArg<int>(named, 'action', 'AndroidMotionEvent');
        final pointerCount = D4.getRequiredNamedArg<int>(named, 'pointerCount', 'AndroidMotionEvent');
        if (!named.containsKey('pointerProperties') || named['pointerProperties'] == null) {
          throw ArgumentError('AndroidMotionEvent: Missing required named argument "pointerProperties"');
        }
        final pointerProperties = D4.coerceList<$flutter_33.AndroidPointerProperties>(named['pointerProperties'], 'pointerProperties');
        if (!named.containsKey('pointerCoords') || named['pointerCoords'] == null) {
          throw ArgumentError('AndroidMotionEvent: Missing required named argument "pointerCoords"');
        }
        final pointerCoords = D4.coerceList<$flutter_33.AndroidPointerCoords>(named['pointerCoords'], 'pointerCoords');
        final metaState = D4.getRequiredNamedArg<int>(named, 'metaState', 'AndroidMotionEvent');
        final buttonState = D4.getRequiredNamedArg<int>(named, 'buttonState', 'AndroidMotionEvent');
        final xPrecision = D4.getRequiredNamedArg<double>(named, 'xPrecision', 'AndroidMotionEvent');
        final yPrecision = D4.getRequiredNamedArg<double>(named, 'yPrecision', 'AndroidMotionEvent');
        final deviceId = D4.getRequiredNamedArg<int>(named, 'deviceId', 'AndroidMotionEvent');
        final edgeFlags = D4.getRequiredNamedArg<int>(named, 'edgeFlags', 'AndroidMotionEvent');
        final source = D4.getRequiredNamedArg<int>(named, 'source', 'AndroidMotionEvent');
        final flags = D4.getRequiredNamedArg<int>(named, 'flags', 'AndroidMotionEvent');
        final motionEventId = D4.getRequiredNamedArg<int>(named, 'motionEventId', 'AndroidMotionEvent');
        return $flutter_33.AndroidMotionEvent(downTime: downTime, eventTime: eventTime, action: action, pointerCount: pointerCount, pointerProperties: pointerProperties, pointerCoords: pointerCoords, metaState: metaState, buttonState: buttonState, xPrecision: xPrecision, yPrecision: yPrecision, deviceId: deviceId, edgeFlags: edgeFlags, source: source, flags: flags, motionEventId: motionEventId);
      },
    },
    getters: {
      'downTime': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').downTime,
      'eventTime': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').eventTime,
      'action': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').action,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').pointerCount,
      'pointerProperties': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').pointerProperties,
      'pointerCoords': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').pointerCoords,
      'metaState': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').metaState,
      'buttonState': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').buttonState,
      'xPrecision': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').xPrecision,
      'yPrecision': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').yPrecision,
      'deviceId': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').deviceId,
      'edgeFlags': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').edgeFlags,
      'source': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').source,
      'flags': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').flags,
      'motionEventId': (visitor, target) => D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent').motionEventId,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidMotionEvent>(target, 'AndroidMotionEvent');
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
    nativeType: $flutter_33.AndroidViewController,
    name: 'AndroidViewController',
    isAssignable: (v) => v is $flutter_33.AndroidViewController,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) => 
        D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController').pointTransformer = D4.extractBridgedArg<$flutter_33.PointTransformer>(value, 'pointTransformer'),
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_7.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_33.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AndroidViewController>(target, 'AndroidViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
    },
    staticGetters: {
      'kActionDown': (visitor) => $flutter_33.AndroidViewController.kActionDown,
      'kActionUp': (visitor) => $flutter_33.AndroidViewController.kActionUp,
      'kActionMove': (visitor) => $flutter_33.AndroidViewController.kActionMove,
      'kActionCancel': (visitor) => $flutter_33.AndroidViewController.kActionCancel,
      'kActionPointerDown': (visitor) => $flutter_33.AndroidViewController.kActionPointerDown,
      'kActionPointerUp': (visitor) => $flutter_33.AndroidViewController.kActionPointerUp,
      'kAndroidLayoutDirectionLtr': (visitor) => $flutter_33.AndroidViewController.kAndroidLayoutDirectionLtr,
      'kAndroidLayoutDirectionRtl': (visitor) => $flutter_33.AndroidViewController.kAndroidLayoutDirectionRtl,
      'kInputDeviceSourceUnknown': (visitor) => $flutter_33.AndroidViewController.kInputDeviceSourceUnknown,
      'kInputDeviceSourceTouchScreen': (visitor) => $flutter_33.AndroidViewController.kInputDeviceSourceTouchScreen,
      'kInputDeviceSourceMouse': (visitor) => $flutter_33.AndroidViewController.kInputDeviceSourceMouse,
      'kInputDeviceSourceStylus': (visitor) => $flutter_33.AndroidViewController.kInputDeviceSourceStylus,
      'kInputDeviceSourceTouchPad': (visitor) => $flutter_33.AndroidViewController.kInputDeviceSourceTouchPad,
    },
    staticMethods: {
      'pointerAction': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'pointerAction');
        final pointerId = D4.getRequiredArg<int>(positional, 0, 'pointerId', 'pointerAction');
        final action = D4.getRequiredArg<int>(positional, 1, 'action', 'pointerAction');
        return $flutter_33.AndroidViewController.pointerAction(pointerId, action);
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
    nativeType: $flutter_33.SurfaceAndroidViewController,
    name: 'SurfaceAndroidViewController',
    isAssignable: (v) => v is $flutter_33.SurfaceAndroidViewController,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) {
        final pointTransformerRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'pointTransformer');
        D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController').pointTransformer = (Offset p0) { return D4.callInterpreterCallback(visitor!, pointTransformerRaw, [p0]) as Offset; };
      },
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_7.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_33.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.SurfaceAndroidViewController>(target, 'SurfaceAndroidViewController');
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
      'pointTransformer': 'set pointTransformer(Offset Function(Offset) value)',
    },
  );
}

// =============================================================================
// ExpensiveAndroidViewController Bridge
// =============================================================================

BridgedClass _createExpensiveAndroidViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_33.ExpensiveAndroidViewController,
    name: 'ExpensiveAndroidViewController',
    isAssignable: (v) => v is $flutter_33.ExpensiveAndroidViewController,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) {
        final pointTransformerRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'pointTransformer');
        D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController').pointTransformer = (Offset p0) { return D4.callInterpreterCallback(visitor!, pointTransformerRaw, [p0]) as Offset; };
      },
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_7.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_33.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.ExpensiveAndroidViewController>(target, 'ExpensiveAndroidViewController');
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
      'pointTransformer': 'set pointTransformer(Offset Function(Offset) value)',
    },
  );
}

// =============================================================================
// HybridAndroidViewController Bridge
// =============================================================================

BridgedClass _createHybridAndroidViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_33.HybridAndroidViewController,
    name: 'HybridAndroidViewController',
    isAssignable: (v) => v is $flutter_33.HybridAndroidViewController,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) {
        final pointTransformerRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'pointTransformer');
        D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController').pointTransformer = (Offset p0) { return D4.callInterpreterCallback(visitor!, pointTransformerRaw, [p0]) as Offset; };
      },
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_7.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_33.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.HybridAndroidViewController>(target, 'HybridAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
    },
    staticMethods: {
      'checkIfSupported': (visitor, positional, named, typeArgs) {
        return $flutter_33.HybridAndroidViewController.checkIfSupported();
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
      'pointTransformer': 'set pointTransformer(Offset Function(Offset) value)',
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
    nativeType: $flutter_33.TextureAndroidViewController,
    name: 'TextureAndroidViewController',
    isAssignable: (v) => v is $flutter_33.TextureAndroidViewController,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController').awaitingCreation,
      'textureId': (visitor, target) => D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController').textureId,
      'requiresViewComposition': (visitor, target) => D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController').requiresViewComposition,
      'pointTransformer': (visitor, target) => D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController').pointTransformer,
      'isCreated': (visitor, target) => D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController').isCreated,
    },
    setters: {
      'pointTransformer': (visitor, target, value) {
        final pointTransformerRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'pointTransformer');
        D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController').pointTransformer = (Offset p0) { return D4.callInterpreterCallback(visitor!, pointTransformerRaw, [p0]) as Offset; };
      },
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_7.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        return t.clearFocus();
      },
      'setSize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setSize');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'setSize');
        return t.setSize(size);
      },
      'setOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'setOffset');
        final off = D4.getRequiredArg<Offset>(positional, 0, 'off', 'setOffset');
        return t.setOffset(off);
      },
      'sendMotionEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'sendMotionEvent');
        final event = D4.getRequiredArg<$flutter_33.AndroidMotionEvent>(positional, 0, 'event', 'sendMotionEvent');
        return t.sendMotionEvent(event);
      },
      'addOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'addOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('addOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'removeOnPlatformViewCreatedListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
        D4.requireMinArgs(positional, 1, 'removeOnPlatformViewCreatedListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeOnPlatformViewCreatedListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeOnPlatformViewCreatedListener((int p0) { D4.callInterpreterCallback(visitor!, listenerRaw, [p0]); });
        return null;
      },
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.TextureAndroidViewController>(target, 'TextureAndroidViewController');
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
      'pointTransformer': 'set pointTransformer(Offset Function(Offset) value)',
    },
  );
}

// =============================================================================
// DarwinPlatformViewController Bridge
// =============================================================================

BridgedClass _createDarwinPlatformViewControllerBridge() {
  return BridgedClass(
    nativeType: $flutter_33.DarwinPlatformViewController,
    name: 'DarwinPlatformViewController',
    isAssignable: (v) => v is $flutter_33.DarwinPlatformViewController,
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_33.DarwinPlatformViewController>(target, 'DarwinPlatformViewController').id,
    },
    methods: {
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
        return t.acceptGesture();
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
        return t.rejectGesture();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.DarwinPlatformViewController>(target, 'DarwinPlatformViewController');
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
    nativeType: $flutter_33.UiKitViewController,
    name: 'UiKitViewController',
    isAssignable: (v) => v is $flutter_33.UiKitViewController,
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_33.UiKitViewController>(target, 'UiKitViewController').id,
    },
    methods: {
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.UiKitViewController>(target, 'UiKitViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.UiKitViewController>(target, 'UiKitViewController');
        return t.acceptGesture();
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.UiKitViewController>(target, 'UiKitViewController');
        return t.rejectGesture();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.UiKitViewController>(target, 'UiKitViewController');
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
    nativeType: $flutter_33.AppKitViewController,
    name: 'AppKitViewController',
    isAssignable: (v) => v is $flutter_33.AppKitViewController,
    constructors: {
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_33.AppKitViewController>(target, 'AppKitViewController').id,
    },
    methods: {
      'setLayoutDirection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AppKitViewController>(target, 'AppKitViewController');
        D4.requireMinArgs(positional, 1, 'setLayoutDirection');
        final layoutDirection = D4.getRequiredArg<TextDirection>(positional, 0, 'layoutDirection', 'setLayoutDirection');
        return t.setLayoutDirection(layoutDirection);
      },
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AppKitViewController>(target, 'AppKitViewController');
        return t.acceptGesture();
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AppKitViewController>(target, 'AppKitViewController');
        return t.rejectGesture();
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.AppKitViewController>(target, 'AppKitViewController');
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
    nativeType: $flutter_33.PlatformViewController,
    name: 'PlatformViewController',
    isAssignable: (v) => v is $flutter_33.PlatformViewController,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_33.PlatformViewController>(target, 'PlatformViewController').viewId,
      'awaitingCreation': (visitor, target) => D4.validateTarget<$flutter_33.PlatformViewController>(target, 'PlatformViewController').awaitingCreation,
    },
    methods: {
      'dispatchPointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.PlatformViewController>(target, 'PlatformViewController');
        D4.requireMinArgs(positional, 1, 'dispatchPointerEvent');
        final event = D4.getRequiredArg<$flutter_7.PointerEvent>(positional, 0, 'event', 'dispatchPointerEvent');
        return t.dispatchPointerEvent(event);
      },
      'create': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.PlatformViewController>(target, 'PlatformViewController');
        final size = D4.getOptionalNamedArg<Size?>(named, 'size');
        final position = D4.getOptionalNamedArg<Offset?>(named, 'position');
        return t.create(size: size, position: position);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.PlatformViewController>(target, 'PlatformViewController');
        return (t as dynamic).dispose();
      },
      'clearFocus': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_33.PlatformViewController>(target, 'PlatformViewController');
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
    nativeType: $flutter_34.PredictiveBackEvent,
    name: 'PredictiveBackEvent',
    isAssignable: (v) => v is $flutter_34.PredictiveBackEvent,
    constructors: {
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PredictiveBackEvent');
        if (positional.isEmpty) {
          throw ArgumentError('PredictiveBackEvent: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String?, Object?>(positional[0], 'map');
        return $flutter_34.PredictiveBackEvent.fromMap(map);
      },
    },
    getters: {
      'touchOffset': (visitor, target) => D4.validateTarget<$flutter_34.PredictiveBackEvent>(target, 'PredictiveBackEvent').touchOffset,
      'progress': (visitor, target) => D4.validateTarget<$flutter_34.PredictiveBackEvent>(target, 'PredictiveBackEvent').progress,
      'swipeEdge': (visitor, target) => D4.validateTarget<$flutter_34.PredictiveBackEvent>(target, 'PredictiveBackEvent').swipeEdge,
      'isButtonEvent': (visitor, target) => D4.validateTarget<$flutter_34.PredictiveBackEvent>(target, 'PredictiveBackEvent').isButtonEvent,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_34.PredictiveBackEvent>(target, 'PredictiveBackEvent').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.PredictiveBackEvent>(target, 'PredictiveBackEvent');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_34.PredictiveBackEvent>(target, 'PredictiveBackEvent');
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
    nativeType: $flutter_35.ProcessTextAction,
    name: 'ProcessTextAction',
    isAssignable: (v) => v is $flutter_35.ProcessTextAction,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ProcessTextAction');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'ProcessTextAction');
        final label = D4.getRequiredArg<String>(positional, 1, 'label', 'ProcessTextAction');
        return $flutter_35.ProcessTextAction(id, label);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$flutter_35.ProcessTextAction>(target, 'ProcessTextAction').id,
      'label': (visitor, target) => D4.validateTarget<$flutter_35.ProcessTextAction>(target, 'ProcessTextAction').label,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_35.ProcessTextAction>(target, 'ProcessTextAction').hashCode,
    },
    methods: {
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.ProcessTextAction>(target, 'ProcessTextAction');
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
    nativeType: $flutter_35.ProcessTextService,
    name: 'ProcessTextService',
    isAssignable: (v) => v is $flutter_35.ProcessTextService,
    constructors: {
    },
    methods: {
      'queryTextActions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.ProcessTextService>(target, 'ProcessTextService');
        return t.queryTextActions();
      },
      'processTextAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.ProcessTextService>(target, 'ProcessTextService');
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
    nativeType: $flutter_35.DefaultProcessTextService,
    name: 'DefaultProcessTextService',
    isAssignable: (v) => v is $flutter_35.DefaultProcessTextService,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_35.DefaultProcessTextService();
      },
    },
    methods: {
      'queryTextActions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.DefaultProcessTextService>(target, 'DefaultProcessTextService');
        return t.queryTextActions();
      },
      'processTextAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_35.DefaultProcessTextService>(target, 'DefaultProcessTextService');
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
    nativeType: $flutter_38.Scribe,
    name: 'Scribe',
    isAssignable: (v) => v is $flutter_38.Scribe,
    constructors: {
    },
    staticMethods: {
      'isFeatureAvailable': (visitor, positional, named, typeArgs) {
        return $flutter_38.Scribe.isFeatureAvailable();
      },
      'isStylusHandwritingAvailable': (visitor, positional, named, typeArgs) {
        return $flutter_38.Scribe.isStylusHandwritingAvailable();
      },
      'startStylusHandwriting': (visitor, positional, named, typeArgs) {
        return $flutter_38.Scribe.startStylusHandwriting();
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
    nativeType: $flutter_39.SensitiveContentService,
    name: 'SensitiveContentService',
    isAssignable: (v) => v is $flutter_39.SensitiveContentService,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_39.SensitiveContentService();
      },
    },
    getters: {
      'sensitiveContentChannel': (visitor, target) => D4.validateTarget<$flutter_39.SensitiveContentService>(target, 'SensitiveContentService').sensitiveContentChannel,
    },
    setters: {
      'sensitiveContentChannel': (visitor, target, value) => 
        D4.validateTarget<$flutter_39.SensitiveContentService>(target, 'SensitiveContentService').sensitiveContentChannel = D4.extractBridgedArg<$flutter_32.MethodChannel>(value, 'sensitiveContentChannel'),
    },
    methods: {
      'setContentSensitivity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SensitiveContentService>(target, 'SensitiveContentService');
        D4.requireMinArgs(positional, 1, 'setContentSensitivity');
        final contentSensitivity = D4.getRequiredArg<$flutter_39.ContentSensitivity>(positional, 0, 'contentSensitivity', 'setContentSensitivity');
        return t.setContentSensitivity(contentSensitivity);
      },
      'getContentSensitivity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SensitiveContentService>(target, 'SensitiveContentService');
        return t.getContentSensitivity();
      },
      'isSupported': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_39.SensitiveContentService>(target, 'SensitiveContentService');
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
    nativeType: $flutter_41.SuggestionSpan,
    name: 'SuggestionSpan',
    isAssignable: (v) => v is $flutter_41.SuggestionSpan,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SuggestionSpan');
        final range = D4.getRequiredArg<TextRange>(positional, 0, 'range', 'SuggestionSpan');
        if (positional.length <= 1) {
          throw ArgumentError('SuggestionSpan: Missing required argument "suggestions" at position 1');
        }
        final suggestions = D4.coerceList<String>(positional[1], 'suggestions');
        return $flutter_41.SuggestionSpan(range, suggestions);
      },
    },
    getters: {
      'range': (visitor, target) => D4.validateTarget<$flutter_41.SuggestionSpan>(target, 'SuggestionSpan').range,
      'suggestions': (visitor, target) => D4.validateTarget<$flutter_41.SuggestionSpan>(target, 'SuggestionSpan').suggestions,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_41.SuggestionSpan>(target, 'SuggestionSpan').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SuggestionSpan>(target, 'SuggestionSpan');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SuggestionSpan>(target, 'SuggestionSpan');
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
    nativeType: $flutter_41.SpellCheckResults,
    name: 'SpellCheckResults',
    isAssignable: (v) => v is $flutter_41.SpellCheckResults,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SpellCheckResults');
        final spellCheckedText = D4.getRequiredArg<String>(positional, 0, 'spellCheckedText', 'SpellCheckResults');
        if (positional.length <= 1) {
          throw ArgumentError('SpellCheckResults: Missing required argument "suggestionSpans" at position 1');
        }
        final suggestionSpans = D4.coerceList<$flutter_41.SuggestionSpan>(positional[1], 'suggestionSpans');
        return $flutter_41.SpellCheckResults(spellCheckedText, suggestionSpans);
      },
    },
    getters: {
      'spellCheckedText': (visitor, target) => D4.validateTarget<$flutter_41.SpellCheckResults>(target, 'SpellCheckResults').spellCheckedText,
      'suggestionSpans': (visitor, target) => D4.validateTarget<$flutter_41.SpellCheckResults>(target, 'SpellCheckResults').suggestionSpans,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_41.SpellCheckResults>(target, 'SpellCheckResults').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SpellCheckResults>(target, 'SpellCheckResults');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SpellCheckResults>(target, 'SpellCheckResults');
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
    nativeType: $flutter_41.SpellCheckService,
    name: 'SpellCheckService',
    isAssignable: (v) => v is $flutter_41.SpellCheckService,
    constructors: {
    },
    methods: {
      'fetchSpellCheckSuggestions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.SpellCheckService>(target, 'SpellCheckService');
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
    nativeType: $flutter_41.DefaultSpellCheckService,
    name: 'DefaultSpellCheckService',
    isAssignable: (v) => v is $flutter_41.DefaultSpellCheckService,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_41.DefaultSpellCheckService();
      },
    },
    getters: {
      'lastSavedResults': (visitor, target) => D4.validateTarget<$flutter_41.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').lastSavedResults,
      'spellCheckChannel': (visitor, target) => D4.validateTarget<$flutter_41.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').spellCheckChannel,
    },
    setters: {
      'lastSavedResults': (visitor, target, value) => 
        D4.validateTarget<$flutter_41.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').lastSavedResults = D4.extractBridgedArgOrNull<$flutter_41.SpellCheckResults>(value, 'lastSavedResults'),
      'spellCheckChannel': (visitor, target, value) => 
        D4.validateTarget<$flutter_41.DefaultSpellCheckService>(target, 'DefaultSpellCheckService').spellCheckChannel = D4.extractBridgedArg<$flutter_32.MethodChannel>(value, 'spellCheckChannel'),
    },
    methods: {
      'fetchSpellCheckSuggestions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_41.DefaultSpellCheckService>(target, 'DefaultSpellCheckService');
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
        final oldResults = D4.coerceList<$flutter_41.SuggestionSpan>(positional[0], 'oldResults');
        if (positional.length <= 1) {
          throw ArgumentError('mergeResults: Missing required argument "newResults" at position 1');
        }
        final newResults = D4.coerceList<$flutter_41.SuggestionSpan>(positional[1], 'newResults');
        return $flutter_41.DefaultSpellCheckService.mergeResults(oldResults, newResults);
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
    nativeType: $flutter_42.SystemChannels,
    name: 'SystemChannels',
    isAssignable: (v) => v is $flutter_42.SystemChannels,
    constructors: {
    },
    staticGetters: {
      'navigation': (visitor) => $flutter_42.SystemChannels.navigation,
      'backGesture': (visitor) => $flutter_42.SystemChannels.backGesture,
      'platform': (visitor) => $flutter_42.SystemChannels.platform,
      'statusBar': (visitor) => $flutter_42.SystemChannels.statusBar,
      'processText': (visitor) => $flutter_42.SystemChannels.processText,
      'textInput': (visitor) => $flutter_42.SystemChannels.textInput,
      'scribe': (visitor) => $flutter_42.SystemChannels.scribe,
      'spellCheck': (visitor) => $flutter_42.SystemChannels.spellCheck,
      'undoManager': (visitor) => $flutter_42.SystemChannels.undoManager,
      'keyEvent': (visitor) => $flutter_42.SystemChannels.keyEvent,
      'lifecycle': (visitor) => $flutter_42.SystemChannels.lifecycle,
      'system': (visitor) => $flutter_42.SystemChannels.system,
      'accessibility': (visitor) => $flutter_42.SystemChannels.accessibility,
      'platform_views': (visitor) => $flutter_42.SystemChannels.platform_views,
      'platform_views_2': (visitor) => $flutter_42.SystemChannels.platform_views_2,
      'skia': (visitor) => $flutter_42.SystemChannels.skia,
      'mouseCursor': (visitor) => $flutter_42.SystemChannels.mouseCursor,
      'restoration': (visitor) => $flutter_42.SystemChannels.restoration,
      'deferredComponent': (visitor) => $flutter_42.SystemChannels.deferredComponent,
      'localization': (visitor) => $flutter_42.SystemChannels.localization,
      'menu': (visitor) => $flutter_42.SystemChannels.menu,
      'contextMenu': (visitor) => $flutter_42.SystemChannels.contextMenu,
      'keyboard': (visitor) => $flutter_42.SystemChannels.keyboard,
      'sensitiveContent': (visitor) => $flutter_42.SystemChannels.sensitiveContent,
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
    nativeType: $flutter_43.ApplicationSwitcherDescription,
    name: 'ApplicationSwitcherDescription',
    isAssignable: (v) => v is $flutter_43.ApplicationSwitcherDescription,
    constructors: {
      '': (visitor, positional, named) {
        final label = D4.getOptionalNamedArg<String?>(named, 'label');
        final primaryColor = D4.getOptionalNamedArg<int?>(named, 'primaryColor');
        return $flutter_43.ApplicationSwitcherDescription(label: label, primaryColor: primaryColor);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$flutter_43.ApplicationSwitcherDescription>(target, 'ApplicationSwitcherDescription').label,
      'primaryColor': (visitor, target) => D4.validateTarget<$flutter_43.ApplicationSwitcherDescription>(target, 'ApplicationSwitcherDescription').primaryColor,
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
    nativeType: $flutter_43.SystemUiOverlayStyle,
    name: 'SystemUiOverlayStyle',
    isAssignable: (v) => v is $flutter_43.SystemUiOverlayStyle,
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
        return $flutter_43.SystemUiOverlayStyle(systemNavigationBarColor: systemNavigationBarColor, systemNavigationBarDividerColor: systemNavigationBarDividerColor, systemNavigationBarIconBrightness: systemNavigationBarIconBrightness, systemNavigationBarContrastEnforced: systemNavigationBarContrastEnforced, statusBarColor: statusBarColor, statusBarBrightness: statusBarBrightness, statusBarIconBrightness: statusBarIconBrightness, systemStatusBarContrastEnforced: systemStatusBarContrastEnforced);
      },
    },
    getters: {
      'systemNavigationBarColor': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarColor,
      'systemNavigationBarDividerColor': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarDividerColor,
      'systemNavigationBarIconBrightness': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarIconBrightness,
      'systemNavigationBarContrastEnforced': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemNavigationBarContrastEnforced,
      'statusBarColor': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').statusBarColor,
      'statusBarBrightness': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').statusBarBrightness,
      'statusBarIconBrightness': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').statusBarIconBrightness,
      'systemStatusBarContrastEnforced': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').systemStatusBarContrastEnforced,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle').hashCode,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
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
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_43.SystemUiOverlayStyle>(target, 'SystemUiOverlayStyle');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'light': (visitor) => $flutter_43.SystemUiOverlayStyle.light,
      'dark': (visitor) => $flutter_43.SystemUiOverlayStyle.dark,
    },
    constructorSignatures: {
      '': 'const SystemUiOverlayStyle({Color? systemNavigationBarColor, Color? systemNavigationBarDividerColor, Brightness? systemNavigationBarIconBrightness, bool? systemNavigationBarContrastEnforced, Color? statusBarColor, Brightness? statusBarBrightness, Brightness? statusBarIconBrightness, bool? systemStatusBarContrastEnforced})',
    },
    methodSignatures: {
      'copyWith': 'SystemUiOverlayStyle copyWith({Color? systemNavigationBarColor, Color? systemNavigationBarDividerColor, bool? systemNavigationBarContrastEnforced, Color? statusBarColor, Brightness? statusBarBrightness, Brightness? statusBarIconBrightness, bool? systemStatusBarContrastEnforced, Brightness? systemNavigationBarIconBrightness})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_43.SystemChrome,
    name: 'SystemChrome',
    isAssignable: (v) => v is $flutter_43.SystemChrome,
    constructors: {
    },
    staticMethods: {
      'setPreferredOrientations': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setPreferredOrientations');
        if (positional.isEmpty) {
          throw ArgumentError('setPreferredOrientations: Missing required argument "orientations" at position 0');
        }
        final orientations = D4.coerceList<$flutter_43.DeviceOrientation>(positional[0], 'orientations');
        return $flutter_43.SystemChrome.setPreferredOrientations(orientations);
      },
      'setApplicationSwitcherDescription': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setApplicationSwitcherDescription');
        final description = D4.getRequiredArg<$flutter_43.ApplicationSwitcherDescription>(positional, 0, 'description', 'setApplicationSwitcherDescription');
        return $flutter_43.SystemChrome.setApplicationSwitcherDescription(description);
      },
      'setEnabledSystemUIMode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setEnabledSystemUIMode');
        final mode = D4.getRequiredArg<$flutter_43.SystemUiMode>(positional, 0, 'mode', 'setEnabledSystemUIMode');
        final overlays = D4.coerceListOrNull<$flutter_43.SystemUiOverlay>(named['overlays'], 'overlays');
        return $flutter_43.SystemChrome.setEnabledSystemUIMode(mode, overlays: overlays);
      },
      'setSystemUIChangeCallback': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setSystemUIChangeCallback');
        if (positional.isEmpty) {
          throw ArgumentError('setSystemUIChangeCallback: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final callback = callbackRaw == null ? null : (bool p0) { return D4.callInterpreterCallback(visitor!, callbackRaw, [p0]) as Future<void>; };
        return $flutter_43.SystemChrome.setSystemUIChangeCallback(callback);
      },
      'restoreSystemUIOverlays': (visitor, positional, named, typeArgs) {
        return $flutter_43.SystemChrome.restoreSystemUIOverlays();
      },
      'setSystemUIOverlayStyle': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setSystemUIOverlayStyle');
        final style = D4.getRequiredArg<$flutter_43.SystemUiOverlayStyle>(positional, 0, 'style', 'setSystemUIOverlayStyle');
        return $flutter_43.SystemChrome.setSystemUIOverlayStyle(style);
      },
      'handleAppLifecycleStateChanged': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'handleAppLifecycleStateChanged');
        final state = D4.getRequiredArg<AppLifecycleState>(positional, 0, 'state', 'handleAppLifecycleStateChanged');
        return $flutter_43.SystemChrome.handleAppLifecycleStateChanged(state);
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
    nativeType: $flutter_44.SystemNavigator,
    name: 'SystemNavigator',
    isAssignable: (v) => v is $flutter_44.SystemNavigator,
    constructors: {
    },
    staticMethods: {
      'setFrameworkHandlesBack': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setFrameworkHandlesBack');
        final frameworkHandlesBack = D4.getRequiredArg<bool>(positional, 0, 'frameworkHandlesBack', 'setFrameworkHandlesBack');
        return $flutter_44.SystemNavigator.setFrameworkHandlesBack(frameworkHandlesBack);
      },
      'pop': (visitor, positional, named, typeArgs) {
        final animated = D4.getOptionalNamedArg<bool?>(named, 'animated');
        return $flutter_44.SystemNavigator.pop(animated: animated);
      },
      'selectSingleEntryHistory': (visitor, positional, named, typeArgs) {
        return $flutter_44.SystemNavigator.selectSingleEntryHistory();
      },
      'selectMultiEntryHistory': (visitor, positional, named, typeArgs) {
        return $flutter_44.SystemNavigator.selectMultiEntryHistory();
      },
      'routeInformationUpdated': (visitor, positional, named, typeArgs) {
        final location = D4.getOptionalNamedArg<String?>(named, 'location');
        final uri = D4.getOptionalNamedArg<Uri?>(named, 'uri');
        final state = D4.getOptionalNamedArg<Object?>(named, 'state');
        final replace = D4.getNamedArgWithDefault<bool>(named, 'replace', false);
        return $flutter_44.SystemNavigator.routeInformationUpdated(location: location, uri: uri, state: state, replace: replace);
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
    nativeType: $flutter_45.SystemSound,
    name: 'SystemSound',
    isAssignable: (v) => v is $flutter_45.SystemSound,
    constructors: {
    },
    staticMethods: {
      'play': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'play');
        final type = D4.getRequiredArg<$flutter_45.SystemSoundType>(positional, 0, 'type', 'play');
        return $flutter_45.SystemSound.play(type);
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
    nativeType: $flutter_46.TextBoundary,
    name: 'TextBoundary',
    isAssignable: (v) => v is $flutter_46.TextBoundary,
    constructors: {
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.TextBoundary>(target, 'TextBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.TextBoundary>(target, 'TextBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.TextBoundary>(target, 'TextBoundary');
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
    nativeType: $flutter_46.CharacterBoundary,
    name: 'CharacterBoundary',
    isAssignable: (v) => v is $flutter_46.CharacterBoundary,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CharacterBoundary');
        final text = D4.getRequiredArg<String>(positional, 0, '_text', 'CharacterBoundary');
        return $flutter_46.CharacterBoundary(text);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.CharacterBoundary>(target, 'CharacterBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.CharacterBoundary>(target, 'CharacterBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.CharacterBoundary>(target, 'CharacterBoundary');
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
    nativeType: $flutter_46.LineBoundary,
    name: 'LineBoundary',
    isAssignable: (v) => v is $flutter_46.LineBoundary,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LineBoundary');
        final textLayout = D4.getRequiredArg<$flutter_51.TextLayoutMetrics>(positional, 0, '_textLayout', 'LineBoundary');
        return $flutter_46.LineBoundary(textLayout);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.LineBoundary>(target, 'LineBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.LineBoundary>(target, 'LineBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.LineBoundary>(target, 'LineBoundary');
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
    nativeType: $flutter_46.ParagraphBoundary,
    name: 'ParagraphBoundary',
    isAssignable: (v) => v is $flutter_46.ParagraphBoundary,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ParagraphBoundary');
        final text = D4.getRequiredArg<String>(positional, 0, '_text', 'ParagraphBoundary');
        return $flutter_46.ParagraphBoundary(text);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ParagraphBoundary>(target, 'ParagraphBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ParagraphBoundary>(target, 'ParagraphBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.ParagraphBoundary>(target, 'ParagraphBoundary');
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
    nativeType: $flutter_46.DocumentBoundary,
    name: 'DocumentBoundary',
    isAssignable: (v) => v is $flutter_46.DocumentBoundary,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentBoundary');
        final text = D4.getRequiredArg<String>(positional, 0, '_text', 'DocumentBoundary');
        return $flutter_46.DocumentBoundary(text);
      },
    },
    methods: {
      'getLeadingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.DocumentBoundary>(target, 'DocumentBoundary');
        D4.requireMinArgs(positional, 1, 'getLeadingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getLeadingTextBoundaryAt');
        return t.getLeadingTextBoundaryAt(position);
      },
      'getTrailingTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.DocumentBoundary>(target, 'DocumentBoundary');
        D4.requireMinArgs(positional, 1, 'getTrailingTextBoundaryAt');
        final position = D4.getRequiredArg<int>(positional, 0, 'position', 'getTrailingTextBoundaryAt');
        return t.getTrailingTextBoundaryAt(position);
      },
      'getTextBoundaryAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_46.DocumentBoundary>(target, 'DocumentBoundary');
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
    nativeType: $flutter_49.TextInputFormatter,
    name: 'TextInputFormatter',
    isAssignable: (v) => v is $flutter_49.TextInputFormatter,
    constructors: {
      'withFunction': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextInputFormatter');
        if (positional.isEmpty) {
          throw ArgumentError('TextInputFormatter: Missing required argument "formatFunction" at position 0');
        }
        final formatFunctionRaw = positional[0];
        return $flutter_49.TextInputFormatter.withFunction(($flutter_50.TextEditingValue p0, $flutter_50.TextEditingValue p1) { return D4.callInterpreterCallback(visitor!, formatFunctionRaw, [p0, p1]) as $flutter_50.TextEditingValue; });
      },
    },
    methods: {
      'formatEditUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.TextInputFormatter>(target, 'TextInputFormatter');
        D4.requireMinArgs(positional, 2, 'formatEditUpdate');
        final oldValue = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'oldValue', 'formatEditUpdate');
        final newValue = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 1, 'newValue', 'formatEditUpdate');
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
    nativeType: $flutter_49.FilteringTextInputFormatter,
    name: 'FilteringTextInputFormatter',
    isAssignable: (v) => v is $flutter_49.FilteringTextInputFormatter,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FilteringTextInputFormatter');
        final filterPattern = D4.getRequiredArg<Pattern>(positional, 0, 'filterPattern', 'FilteringTextInputFormatter');
        final allow = D4.getRequiredNamedArg<bool>(named, 'allow', 'FilteringTextInputFormatter');
        final replacementString = D4.getNamedArgWithDefault<String>(named, 'replacementString', '');
        return $flutter_49.FilteringTextInputFormatter(filterPattern, allow: allow, replacementString: replacementString);
      },
      'allow': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FilteringTextInputFormatter');
        final filterPattern = D4.getRequiredArg<Pattern>(positional, 0, 'filterPattern', 'FilteringTextInputFormatter');
        final replacementString = D4.getNamedArgWithDefault<String>(named, 'replacementString', '');
        return $flutter_49.FilteringTextInputFormatter.allow(filterPattern, replacementString: replacementString);
      },
      'deny': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FilteringTextInputFormatter');
        final filterPattern = D4.getRequiredArg<Pattern>(positional, 0, 'filterPattern', 'FilteringTextInputFormatter');
        final replacementString = D4.getNamedArgWithDefault<String>(named, 'replacementString', '');
        return $flutter_49.FilteringTextInputFormatter.deny(filterPattern, replacementString: replacementString);
      },
    },
    getters: {
      'filterPattern': (visitor, target) => D4.validateTarget<$flutter_49.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter').filterPattern,
      'allow': (visitor, target) => D4.validateTarget<$flutter_49.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter').allow,
      'replacementString': (visitor, target) => D4.validateTarget<$flutter_49.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter').replacementString,
    },
    methods: {
      'formatEditUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.FilteringTextInputFormatter>(target, 'FilteringTextInputFormatter');
        D4.requireMinArgs(positional, 2, 'formatEditUpdate');
        final oldValue = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'oldValue', 'formatEditUpdate');
        final newValue = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 1, 'newValue', 'formatEditUpdate');
        return t.formatEditUpdate(oldValue, newValue);
      },
    },
    staticGetters: {
      'singleLineFormatter': (visitor) => $flutter_49.FilteringTextInputFormatter.singleLineFormatter,
      'digitsOnly': (visitor) => $flutter_49.FilteringTextInputFormatter.digitsOnly,
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
    nativeType: $flutter_49.LengthLimitingTextInputFormatter,
    name: 'LengthLimitingTextInputFormatter',
    isAssignable: (v) => v is $flutter_49.LengthLimitingTextInputFormatter,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LengthLimitingTextInputFormatter');
        final maxLength = D4.getRequiredArg<int?>(positional, 0, 'maxLength', 'LengthLimitingTextInputFormatter');
        final maxLengthEnforcement = D4.getOptionalNamedArg<$flutter_49.MaxLengthEnforcement?>(named, 'maxLengthEnforcement');
        return $flutter_49.LengthLimitingTextInputFormatter(maxLength, maxLengthEnforcement: maxLengthEnforcement);
      },
    },
    getters: {
      'maxLength': (visitor, target) => D4.validateTarget<$flutter_49.LengthLimitingTextInputFormatter>(target, 'LengthLimitingTextInputFormatter').maxLength,
      'maxLengthEnforcement': (visitor, target) => D4.validateTarget<$flutter_49.LengthLimitingTextInputFormatter>(target, 'LengthLimitingTextInputFormatter').maxLengthEnforcement,
    },
    methods: {
      'formatEditUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_49.LengthLimitingTextInputFormatter>(target, 'LengthLimitingTextInputFormatter');
        D4.requireMinArgs(positional, 2, 'formatEditUpdate');
        final oldValue = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 0, 'oldValue', 'formatEditUpdate');
        final newValue = D4.getRequiredArg<$flutter_50.TextEditingValue>(positional, 1, 'newValue', 'formatEditUpdate');
        return t.formatEditUpdate(oldValue, newValue);
      },
    },
    staticMethods: {
      'getDefaultMaxLengthEnforcement': (visitor, positional, named, typeArgs) {
        final platform = D4.getOptionalArg<$flutter_5.TargetPlatform?>(positional, 0, 'platform');
        return $flutter_49.LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(platform);
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
    nativeType: $flutter_51.TextLayoutMetrics,
    name: 'TextLayoutMetrics',
    isAssignable: (v) => v is $flutter_51.TextLayoutMetrics,
    constructors: {
    },
    methods: {
      'getLineAtOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getLineAtOffset');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getLineAtOffset');
        return t.getLineAtOffset(position);
      },
      'getWordBoundary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getWordBoundary');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getWordBoundary');
        return t.getWordBoundary(position);
      },
      'getTextPositionAbove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getTextPositionAbove');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getTextPositionAbove');
        return t.getTextPositionAbove(position);
      },
      'getTextPositionBelow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_51.TextLayoutMetrics>(target, 'TextLayoutMetrics');
        D4.requireMinArgs(positional, 1, 'getTextPositionBelow');
        final position = D4.getRequiredArg<TextPosition>(positional, 0, 'position', 'getTextPositionBelow');
        return t.getTextPositionBelow(position);
      },
    },
    staticMethods: {
      'isWhitespace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isWhitespace');
        final codeUnit = D4.getRequiredArg<int>(positional, 0, 'codeUnit', 'isWhitespace');
        return $flutter_51.TextLayoutMetrics.isWhitespace(codeUnit);
      },
      'isLineTerminator': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isLineTerminator');
        final codeUnit = D4.getRequiredArg<int>(positional, 0, 'codeUnit', 'isLineTerminator');
        return $flutter_51.TextLayoutMetrics.isLineTerminator(codeUnit);
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
    nativeType: $flutter_52.UndoManager,
    name: 'UndoManager',
    isAssignable: (v) => v is $flutter_52.UndoManager,
    constructors: {
    },
    staticGetters: {
      'client': (visitor) => $flutter_52.UndoManager.client,
    },
    staticMethods: {
      'setUndoState': (visitor, positional, named, typeArgs) {
        final canUndo = D4.getNamedArgWithDefault<bool>(named, 'canUndo', false);
        final canRedo = D4.getNamedArgWithDefault<bool>(named, 'canRedo', false);
        return $flutter_52.UndoManager.setUndoState(canUndo: canUndo, canRedo: canRedo);
      },
    },
    staticSetters: {
      'client': (visitor, value) => 
        $flutter_52.UndoManager.client = D4.extractBridgedArgOrNull<$flutter_52.UndoManagerClient>(value, 'client'),
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
    nativeType: $flutter_52.UndoManagerClient,
    name: 'UndoManagerClient',
    isAssignable: (v) => v is $flutter_52.UndoManagerClient,
    constructors: {
    },
    getters: {
      'canUndo': (visitor, target) => D4.validateTarget<$flutter_52.UndoManagerClient>(target, 'UndoManagerClient').canUndo,
      'canRedo': (visitor, target) => D4.validateTarget<$flutter_52.UndoManagerClient>(target, 'UndoManagerClient').canRedo,
    },
    methods: {
      'handlePlatformUndo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.UndoManagerClient>(target, 'UndoManagerClient');
        D4.requireMinArgs(positional, 1, 'handlePlatformUndo');
        final direction = D4.getRequiredArg<$flutter_52.UndoDirection>(positional, 0, 'direction', 'handlePlatformUndo');
        t.handlePlatformUndo(direction);
        return null;
      },
      'undo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.UndoManagerClient>(target, 'UndoManagerClient');
        t.undo();
        return null;
      },
      'redo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_52.UndoManagerClient>(target, 'UndoManagerClient');
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

