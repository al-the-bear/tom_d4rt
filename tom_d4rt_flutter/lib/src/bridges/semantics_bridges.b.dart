// D4rt Bridge - Generated file, do not edit
// Sources: 5 files
// Generated: 2026-06-10T13:34:58.416836

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member

import 'package:tom_d4rt/d4rt.dart';
import 'dart:async';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/basic_types.dart' as $flutter_1;
import 'package:flutter/src/foundation/binding.dart' as $flutter_2;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_3;
import 'package:flutter/src/foundation/key.dart' as $flutter_4;
import 'package:flutter/src/semantics/binding.dart' as $flutter_5;
import 'package:flutter/src/semantics/debug.dart' as $flutter_6;
import 'package:flutter/src/semantics/semantics.dart' as $flutter_7;
import 'package:flutter/src/semantics/semantics_event.dart' as $flutter_8;
import 'package:flutter/src/semantics/semantics_service.dart' as $flutter_9;
import 'package:flutter/src/services/text_editing.dart' as $flutter_10;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart' as $tom_d4rt_flutter_1;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/state_user_bridge.dart' as $tom_d4rt_flutter_2;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/strut_style_user_bridge.dart' as $tom_d4rt_flutter_3;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/text_user_bridge.dart' as $tom_d4rt_flutter_4;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;
import 'package:flutter/src/foundation/change_notifier.dart' as $aux_flutter_2;

/// Bridge class for flutter_semantics module.
class FlutterSemanticsBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createSemanticsHandleBridge(),
      _createSemanticsBindingBridge(),
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
      'SemanticsHandle': 'package:flutter/src/semantics/binding.dart',
      'SemanticsBinding': 'package:flutter/src/semantics/binding.dart',
      'SemanticsEvent': 'package:flutter/src/semantics/semantics_event.dart',
      'AnnounceSemanticsEvent': 'package:flutter/src/semantics/semantics_event.dart',
      'TooltipSemanticsEvent': 'package:flutter/src/semantics/semantics_event.dart',
      'LongPressSemanticsEvent': 'package:flutter/src/semantics/semantics_event.dart',
      'TapSemanticEvent': 'package:flutter/src/semantics/semantics_event.dart',
      'FocusSemanticEvent': 'package:flutter/src/semantics/semantics_event.dart',
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
    };
  }

  /// Returns a map of class names to their flattened (transitive)
  /// native supertype names (superclasses, interfaces and mixins).
  ///
  /// Fed to `BridgedClass.registerSupertypes` so interpreted subclasses
  /// of bridged classes pass `is`/subtype checks against bridged
  /// ancestors and the interface-proxy supertype walk resolves up the
  /// chain (MCI#1 / A1).
  static Map<String, List<String>> classSupertypes() {
    return {
      'SemanticsBinding': ['BindingBase'],
      'AnnounceSemanticsEvent': ['SemanticsEvent'],
      'TooltipSemanticsEvent': ['SemanticsEvent'],
      'LongPressSemanticsEvent': ['SemanticsEvent'],
      'TapSemanticEvent': ['SemanticsEvent'],
      'FocusSemanticEvent': ['SemanticsEvent'],
      'AttributedStringProperty': ['DiagnosticsProperty', 'DiagnosticsNode'],
      'SemanticsData': ['Diagnosticable'],
      'SemanticsHintOverrides': ['DiagnosticableTree', 'Diagnosticable'],
      'SemanticsProperties': ['DiagnosticableTree', 'Diagnosticable'],
      'SemanticsNode': ['DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'SemanticsOwner': ['ChangeNotifier', 'Listenable'],
      'SemanticsSortKey': ['Comparable', 'Diagnosticable'],
      'OrdinalSortKey': ['SemanticsSortKey', 'Comparable', 'Diagnosticable'],
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
      BridgedEnumDefinition<$flutter_8.Assertiveness>(
        name: 'Assertiveness',
        values: $flutter_8.Assertiveness.values,
      ),
      BridgedEnumDefinition<$flutter_7.AccessibilityFocusBlockType>(
        name: 'AccessibilityFocusBlockType',
        values: $flutter_7.AccessibilityFocusBlockType.values,
      ),
      BridgedEnumDefinition<$flutter_7.DebugSemanticsDumpOrder>(
        name: 'DebugSemanticsDumpOrder',
        values: $flutter_7.DebugSemanticsDumpOrder.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'Assertiveness': 'package:flutter/src/semantics/semantics_event.dart',
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

  /// GEN-107: Library re-exports declared by the bridged source
  /// libraries. Each tuple mirrors a Dart `export '…'` directive.
  /// Consumed by `registerBridges` via `D4rt.registerLibraryReExport`
  /// (mirrored on `D4rtRunner` in tom_d4rt_ast).
  static List<({String source, String target, Set<String>? show, Set<String>? hide})>
  bridgeReExports() {
    return [
      (source: 'package:flutter/semantics.dart', target: 'dart:ui', show: {'LocaleStringAttribute', 'SpellOutStringAttribute'}, hide: null),
      (source: 'package:flutter/semantics.dart', target: 'package:flutter/src/semantics/binding.dart', show: null, hide: null),
      (source: 'package:flutter/semantics.dart', target: 'package:flutter/src/semantics/debug.dart', show: null, hide: null),
      (source: 'package:flutter/semantics.dart', target: 'package:flutter/src/semantics/semantics.dart', show: null, hide: null),
      (source: 'package:flutter/semantics.dart', target: 'package:flutter/src/semantics/semantics_event.dart', show: null, hide: null),
      (source: 'package:flutter/semantics.dart', target: 'package:flutter/src/semantics/semantics_service.dart', show: null, hide: null),
      (source: 'package:flutter/src/semantics/binding.dart', target: 'dart:ui', show: {'AccessibilityFeatures', 'SemanticsActionEvent', 'SemanticsUpdateBuilder'}, hide: null),
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
      (source: 'package:flutter/src/semantics/semantics_event.dart', target: 'dart:ui', show: {'TextDirection'}, hide: null),
      (source: 'package:flutter/src/semantics/semantics.dart', target: 'dart:ui', show: {'Offset', 'Rect', 'SemanticsAction', 'SemanticsFlag', 'SemanticsFlags', 'SemanticsRole', 'SemanticsValidationResult', 'StringAttribute', 'TextDirection', 'VoidCallback'}, hide: null),
      (source: 'package:flutter/src/semantics/semantics.dart', target: 'package:flutter/foundation.dart', show: {'DiagnosticLevel', 'DiagnosticPropertiesBuilder', 'DiagnosticsNode', 'DiagnosticsTreeStyle', 'Key', 'TextTreeConfiguration'}, hide: null),
      (source: 'package:flutter/src/semantics/semantics.dart', target: 'package:flutter/services.dart', show: {'TextSelection'}, hide: null),
      (source: 'package:flutter/src/semantics/semantics.dart', target: 'package:vector_math/vector_math_64.dart', show: {'Matrix4'}, hide: null),
      (source: 'package:flutter/src/semantics/semantics.dart', target: 'package:flutter/src/semantics/semantics_event.dart', show: {'SemanticsEvent'}, hide: null),
      (source: 'package:flutter/src/semantics/semantics_service.dart', target: 'dart:ui', show: {'TextDirection'}, hide: null),
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

    // MCI#1 / A1: Register the flattened native supertype table so
    // interpreted subclasses pass subtype checks against bridged
    // ancestors. Idempotent — safe to call per barrel.
    BridgedClass.registerSupertypes(classSupertypes());

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
      interpreter.registerGlobalVariable('debugSemanticsDisableAnimations', $flutter_6.debugSemanticsDisableAnimations, importPath, sourceUri: 'package:flutter/src/semantics/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugSemanticsDisableAnimations": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (flutter_semantics):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'debugResetSemanticsIdCounter': (visitor, positional, named, typeArgs) {
        return $flutter_7.debugResetSemanticsIdCounter();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'debugResetSemanticsIdCounter': 'package:flutter/src/semantics/semantics.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
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
      'package:flutter/src/semantics/binding.dart',
      'package:flutter/src/semantics/debug.dart',
      'package:flutter/src/semantics/semantics.dart',
      'package:flutter/src/semantics/semantics_event.dart',
      'package:flutter/src/semantics/semantics_service.dart',
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
// SemanticsBinding Bridge
// =============================================================================

BridgedClass _createSemanticsBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_5.SemanticsBinding,
    name: 'SemanticsBinding',
    isAssignable: (v) => v is $flutter_5.SemanticsBinding,
    hierarchyDepth: 1,
    canBeUsedAsMixin: true,
    isAbstract: true,
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
        return t.lockEvents((() { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }) as Future<void> Function());
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
        t.registerSignalServiceExtension(name: name, callback: (() { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }) as Future<void> Function());
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
        t.registerBoolServiceExtension(name: name, getter: (() { return Future.value(D4.callInterpreterCallback(visitor!, getterRaw, [])).then((v) => v as bool); }) as Future<bool> Function(), setter: ((bool p0) { return Future.value(D4.callInterpreterCallback(visitor!, setterRaw, [p0])); }) as Future<void> Function(bool));
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
        t.registerNumericServiceExtension(name: name, getter: (() { return Future.value(D4.callInterpreterCallback(visitor!, getterRaw, [])).then((v) => v as double); }) as Future<double> Function(), setter: ((double p0) { return Future.value(D4.callInterpreterCallback(visitor!, setterRaw, [p0])); }) as Future<void> Function(double));
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
        t.registerStringServiceExtension(name: name, getter: (() { return Future.value(D4.callInterpreterCallback(visitor!, getterRaw, [])).then((v) => v as String); }) as Future<String> Function(), setter: ((String p0) { return Future.value(D4.callInterpreterCallback(visitor!, setterRaw, [p0])); }) as Future<void> Function(String));
        return null;
      },
      'registerServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SemanticsBinding>(target, 'SemanticsBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: ((Map<String, String> p0) { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [p0])).then((v) => v as Map<String, dynamic>); }) as Future<Map<String, dynamic>> Function(Map<String, String>));
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
      'addSemanticsActionListener': 'void addSemanticsActionListener(ValueSetter<SemanticsActionEvent> listener)',
      'removeSemanticsActionListener': 'void removeSemanticsActionListener(ValueSetter<SemanticsActionEvent> listener)',
      'ensureSemantics': 'SemanticsHandle ensureSemantics()',
      'performSemanticsAction': 'void performSemanticsAction(SemanticsActionEvent action)',
      'handleAccessibilityFeaturesChanged': 'void handleAccessibilityFeaturesChanged()',
      'createSemanticsUpdateBuilder': 'SemanticsUpdateBuilder createSemanticsUpdateBuilder()',
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
    },
    getterSignatures: {
      'semanticsEnabled': 'bool get semanticsEnabled',
      'debugOutstandingSemanticsHandles': 'int get debugOutstandingSemanticsHandles',
      'accessibilityFeatures': 'AccessibilityFeatures get accessibilityFeatures',
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
// SemanticsEvent Bridge
// =============================================================================

BridgedClass _createSemanticsEventBridge() {
  return BridgedClass(
    nativeType: $flutter_8.SemanticsEvent,
    name: 'SemanticsEvent',
    isAssignable: (v) => v is $flutter_8.SemanticsEvent,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$flutter_8.SemanticsEvent>(target, 'SemanticsEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.SemanticsEvent>(target, 'SemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.SemanticsEvent>(target, 'SemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.SemanticsEvent>(target, 'SemanticsEvent');
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
    nativeType: $flutter_8.AnnounceSemanticsEvent,
    name: 'AnnounceSemanticsEvent',
    isAssignable: (v) => v is $flutter_8.AnnounceSemanticsEvent,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'AnnounceSemanticsEvent');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'AnnounceSemanticsEvent');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'AnnounceSemanticsEvent');
        final viewId = D4.getRequiredArg<int>(positional, 2, 'viewId', 'AnnounceSemanticsEvent');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_8.Assertiveness>(named, 'assertiveness', $flutter_8.Assertiveness.polite);
        return $flutter_8.AnnounceSemanticsEvent(message, textDirection, viewId, assertiveness: assertiveness);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').type,
      'viewId': (visitor, target) => D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').viewId,
      'message': (visitor, target) => D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').message,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').textDirection,
      'assertiveness': (visitor, target) => D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent').assertiveness,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.AnnounceSemanticsEvent>(target, 'AnnounceSemanticsEvent');
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
    nativeType: $flutter_8.TooltipSemanticsEvent,
    name: 'TooltipSemanticsEvent',
    isAssignable: (v) => v is $flutter_8.TooltipSemanticsEvent,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TooltipSemanticsEvent');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'TooltipSemanticsEvent');
        return $flutter_8.TooltipSemanticsEvent(message);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$flutter_8.TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent').type,
      'message': (visitor, target) => D4.validateTarget<$flutter_8.TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent').message,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TooltipSemanticsEvent>(target, 'TooltipSemanticsEvent');
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
    nativeType: $flutter_8.LongPressSemanticsEvent,
    name: 'LongPressSemanticsEvent',
    isAssignable: (v) => v is $flutter_8.LongPressSemanticsEvent,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_8.LongPressSemanticsEvent();
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$flutter_8.LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.LongPressSemanticsEvent>(target, 'LongPressSemanticsEvent');
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
    nativeType: $flutter_8.TapSemanticEvent,
    name: 'TapSemanticEvent',
    isAssignable: (v) => v is $flutter_8.TapSemanticEvent,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_8.TapSemanticEvent();
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$flutter_8.TapSemanticEvent>(target, 'TapSemanticEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TapSemanticEvent>(target, 'TapSemanticEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TapSemanticEvent>(target, 'TapSemanticEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.TapSemanticEvent>(target, 'TapSemanticEvent');
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
    nativeType: $flutter_8.FocusSemanticEvent,
    name: 'FocusSemanticEvent',
    isAssignable: (v) => v is $flutter_8.FocusSemanticEvent,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_8.FocusSemanticEvent();
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$flutter_8.FocusSemanticEvent>(target, 'FocusSemanticEvent').type,
    },
    methods: {
      'toMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FocusSemanticEvent>(target, 'FocusSemanticEvent');
        final nodeId = D4.getOptionalNamedArg<int?>(named, 'nodeId');
        return t.toMap(nodeId: nodeId);
      },
      'getDataMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FocusSemanticEvent>(target, 'FocusSemanticEvent');
        return t.getDataMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_8.FocusSemanticEvent>(target, 'FocusSemanticEvent');
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
    nativeType: $flutter_7.SemanticsTag,
    name: 'SemanticsTag',
    isAssignable: (v) => v is $flutter_7.SemanticsTag,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SemanticsTag');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'SemanticsTag');
        return $flutter_7.SemanticsTag(name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsTag>(target, 'SemanticsTag').name,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsTag>(target, 'SemanticsTag');
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
    nativeType: $flutter_7.ChildSemanticsConfigurationsResult,
    name: 'ChildSemanticsConfigurationsResult',
    isAssignable: (v) => v is $flutter_7.ChildSemanticsConfigurationsResult,
    constructors: {
    },
    getters: {
      'mergeUp': (visitor, target) => D4.validateTarget<$flutter_7.ChildSemanticsConfigurationsResult>(target, 'ChildSemanticsConfigurationsResult').mergeUp,
      'siblingMergeGroups': (visitor, target) => D4.validateTarget<$flutter_7.ChildSemanticsConfigurationsResult>(target, 'ChildSemanticsConfigurationsResult').siblingMergeGroups,
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
    nativeType: $flutter_7.ChildSemanticsConfigurationsResultBuilder,
    name: 'ChildSemanticsConfigurationsResultBuilder',
    isAssignable: (v) => v is $flutter_7.ChildSemanticsConfigurationsResultBuilder,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_7.ChildSemanticsConfigurationsResultBuilder();
      },
    },
    methods: {
      'markAsMergeUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
        D4.requireMinArgs(positional, 1, 'markAsMergeUp');
        final config = D4.getRequiredArg<$flutter_7.SemanticsConfiguration>(positional, 0, 'config', 'markAsMergeUp');
        t.markAsMergeUp(config);
        return null;
      },
      'markAsSiblingMergeGroup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
        D4.requireMinArgs(positional, 1, 'markAsSiblingMergeGroup');
        if (positional.isEmpty) {
          throw ArgumentError('markAsSiblingMergeGroup: Missing required argument "configs" at position 0');
        }
        final configs = D4.coerceList<$flutter_7.SemanticsConfiguration>(positional[0], 'configs');
        t.markAsSiblingMergeGroup(configs);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.ChildSemanticsConfigurationsResultBuilder>(target, 'ChildSemanticsConfigurationsResultBuilder');
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
    nativeType: $flutter_7.CustomSemanticsAction,
    name: 'CustomSemanticsAction',
    isAssignable: (v) => v is $flutter_7.CustomSemanticsAction,
    constructors: {
      '': (visitor, positional, named) {
        final label = D4.getRequiredNamedArg<String>(named, 'label', 'CustomSemanticsAction');
        return $flutter_7.CustomSemanticsAction(label: label);
      },
      'overridingAction': (visitor, positional, named) {
        final hint = D4.getRequiredNamedArg<String>(named, 'hint', 'CustomSemanticsAction');
        final action = D4.getRequiredNamedArg<SemanticsAction>(named, 'action', 'CustomSemanticsAction');
        return $flutter_7.CustomSemanticsAction.overridingAction(hint: hint, action: action);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$flutter_7.CustomSemanticsAction>(target, 'CustomSemanticsAction').label,
      'hint': (visitor, target) => D4.validateTarget<$flutter_7.CustomSemanticsAction>(target, 'CustomSemanticsAction').hint,
      'action': (visitor, target) => D4.validateTarget<$flutter_7.CustomSemanticsAction>(target, 'CustomSemanticsAction').action,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_7.CustomSemanticsAction>(target, 'CustomSemanticsAction').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.CustomSemanticsAction>(target, 'CustomSemanticsAction');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.CustomSemanticsAction>(target, 'CustomSemanticsAction');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticMethods: {
      'getIdentifier': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getIdentifier');
        final action = D4.getRequiredArg<$flutter_7.CustomSemanticsAction>(positional, 0, 'action', 'getIdentifier');
        return $flutter_7.CustomSemanticsAction.getIdentifier(action);
      },
      'getAction': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getAction');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'getAction');
        return $flutter_7.CustomSemanticsAction.getAction(id);
      },
      'resetForTests': (visitor, positional, named, typeArgs) {
        return $flutter_7.CustomSemanticsAction.resetForTests();
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
      'resetForTests': 'void resetForTests()',
    },
  );
}

// =============================================================================
// AttributedString Bridge
// =============================================================================

BridgedClass _createAttributedStringBridge() {
  return BridgedClass(
    nativeType: $flutter_7.AttributedString,
    name: 'AttributedString',
    isAssignable: (v) => v is $flutter_7.AttributedString,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AttributedString');
        final string = D4.getRequiredArg<String>(positional, 0, 'string', 'AttributedString');
        final attributes = named.containsKey('attributes') && named['attributes'] != null
            ? D4.coerceList<StringAttribute>(named['attributes'], 'attributes')
            : const <StringAttribute>[];
        return $flutter_7.AttributedString(string, attributes: attributes);
      },
    },
    getters: {
      'string': (visitor, target) => D4.validateTarget<$flutter_7.AttributedString>(target, 'AttributedString').string,
      'attributes': (visitor, target) => D4.validateTarget<$flutter_7.AttributedString>(target, 'AttributedString').attributes,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_7.AttributedString>(target, 'AttributedString').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedString>(target, 'AttributedString');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedString>(target, 'AttributedString');
        final other = D4.getRequiredArg<$flutter_7.AttributedString>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedString>(target, 'AttributedString');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_7.AttributedStringProperty,
    name: 'AttributedStringProperty',
    isAssignable: (v) => v is $flutter_7.AttributedStringProperty,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'AttributedStringProperty');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'AttributedStringProperty');
        final value = D4.getRequiredArg<$flutter_7.AttributedString?>(positional, 1, 'value', 'AttributedStringProperty');
        final showName = D4.getNamedArgWithDefault<bool>(named, 'showName', true);
        final showWhenEmpty = D4.getNamedArgWithDefault<bool>(named, 'showWhenEmpty', false);
        final level = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'level', $flutter_3.DiagnosticLevel.info);
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        if (!named.containsKey('defaultValue')) {
          return $flutter_7.AttributedStringProperty(name, value, showName: showName, showWhenEmpty: showWhenEmpty, level: level, description: description);
        }
        if (named.containsKey('defaultValue')) {
          final defaultValue = D4.getRequiredNamedArg<Object?>(named, 'defaultValue', 'AttributedStringProperty');
          return $flutter_7.AttributedStringProperty(name, value, showName: showName, showWhenEmpty: showWhenEmpty, level: level, description: description, defaultValue: defaultValue);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'showWhenEmpty': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').showWhenEmpty,
      'isInteresting': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').isInteresting,
      'expandableValue': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').expandableValue,
      'allowWrap': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').allowWrap,
      'allowNameWrap': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').allowNameWrap,
      'ifNull': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').ifNull,
      'ifEmpty': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').ifEmpty,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').tooltip,
      'missingIfNull': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').missingIfNull,
      'propertyType': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').propertyType,
      'value': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').value,
      'exception': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').exception,
      'defaultValue': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').defaultValue,
      'level': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').level,
      'name': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').name,
      'showSeparator': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').showSeparator,
      'showName': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').showName,
      'linePrefix': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').linePrefix,
      'emptyBodyDescription': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').emptyBodyDescription,
      'style': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').style,
      'allowTruncate': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').allowTruncate,
      'textTreeConfiguration': (visitor, target) => D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty').textTreeConfiguration,
    },
    methods: {
      'valueToString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.valueToString(parentConfiguration: parentConfiguration);
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMap');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMap');
        return t.toJsonMap(delegate);
      },
      'toDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        return t.toDescription(parentConfiguration: parentConfiguration);
      },
      'getProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.getProperties();
      },
      'getChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.getChildren();
      },
      'isFiltered': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'isFiltered');
        final minLevel = D4.getRequiredArg<$flutter_3.DiagnosticLevel>(positional, 0, 'minLevel', 'isFiltered');
        return t.isFiltered(minLevel);
      },
      'toTimelineArguments': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        return t.toTimelineArguments();
      },
      'toJsonMapIterative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        D4.requireMinArgs(positional, 1, 'toJsonMapIterative');
        final delegate = D4.getRequiredArg<$flutter_3.DiagnosticsSerializationDelegate>(positional, 0, 'delegate', 'toJsonMapIterative');
        return t.toJsonMapIterative(delegate);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
        final parentConfiguration = D4.getOptionalNamedArg<$flutter_3.TextTreeConfiguration?>(named, 'parentConfiguration');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(parentConfiguration: parentConfiguration, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.AttributedStringProperty>(target, 'AttributedStringProperty');
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
    nativeType: $flutter_7.SemanticsLabelBuilder,
    name: 'SemanticsLabelBuilder',
    isAssignable: (v) => v is $flutter_7.SemanticsLabelBuilder,
    constructors: {
      '': (visitor, positional, named) {
        final separator = D4.getNamedArgWithDefault<String>(named, 'separator', ' ');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        return $flutter_7.SemanticsLabelBuilder(separator: separator, textDirection: textDirection);
      },
    },
    getters: {
      'separator': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').separator,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').textDirection,
      'isEmpty': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').isEmpty,
      'length': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder').length,
    },
    methods: {
      'addPart': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
        D4.requireMinArgs(positional, 1, 'addPart');
        final label = D4.getRequiredArg<String>(positional, 0, 'label', 'addPart');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        t.addPart(label, textDirection: textDirection);
        return null;
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
        return (t as dynamic).build();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsLabelBuilder>(target, 'SemanticsLabelBuilder');
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
    nativeType: $flutter_7.SemanticsData,
    name: 'SemanticsData',
    isAssignable: (v) => v is $flutter_7.SemanticsData,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final flagsCollection = D4.getRequiredNamedArg<SemanticsFlags>(named, 'flagsCollection', 'SemanticsData');
        final actions = D4.getRequiredNamedArg<int>(named, 'actions', 'SemanticsData');
        final identifier = D4.getRequiredNamedArg<String>(named, 'identifier', 'SemanticsData');
        final traversalParentIdentifier = D4.getRequiredNamedArg<Object?>(named, 'traversalParentIdentifier', 'SemanticsData');
        final traversalChildIdentifier = D4.getRequiredNamedArg<Object?>(named, 'traversalChildIdentifier', 'SemanticsData');
        final attributedLabel = D4.getRequiredNamedArg<$flutter_7.AttributedString>(named, 'attributedLabel', 'SemanticsData');
        final attributedValue = D4.getRequiredNamedArg<$flutter_7.AttributedString>(named, 'attributedValue', 'SemanticsData');
        final attributedIncreasedValue = D4.getRequiredNamedArg<$flutter_7.AttributedString>(named, 'attributedIncreasedValue', 'SemanticsData');
        final attributedDecreasedValue = D4.getRequiredNamedArg<$flutter_7.AttributedString>(named, 'attributedDecreasedValue', 'SemanticsData');
        final attributedHint = D4.getRequiredNamedArg<$flutter_7.AttributedString>(named, 'attributedHint', 'SemanticsData');
        final tooltip = D4.getRequiredNamedArg<String>(named, 'tooltip', 'SemanticsData');
        final textDirection = D4.getRequiredNamedArg<TextDirection?>(named, 'textDirection', 'SemanticsData');
        final rect = D4.getRequiredNamedArg<Rect>(named, 'rect', 'SemanticsData');
        final textSelection = D4.getRequiredNamedArg<$flutter_10.TextSelection?>(named, 'textSelection', 'SemanticsData');
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
        final tags = D4.coerceSetOrNull<$flutter_7.SemanticsTag>(named['tags'], 'tags');
        final transform = D4.getOptionalNamedArg<$vector_math_1.Matrix4?>(named, 'transform');
        final customSemanticsActionIds = D4.coerceListOrNull<int>(named['customSemanticsActionIds'], 'customSemanticsActionIds');
        return $flutter_7.SemanticsData(flagsCollection: flagsCollection, actions: actions, identifier: identifier, traversalParentIdentifier: traversalParentIdentifier, traversalChildIdentifier: traversalChildIdentifier, attributedLabel: attributedLabel, attributedValue: attributedValue, attributedIncreasedValue: attributedIncreasedValue, attributedDecreasedValue: attributedDecreasedValue, attributedHint: attributedHint, tooltip: tooltip, textDirection: textDirection, rect: rect, textSelection: textSelection, scrollIndex: scrollIndex, scrollChildCount: scrollChildCount, scrollPosition: scrollPosition, scrollExtentMax: scrollExtentMax, scrollExtentMin: scrollExtentMin, platformViewId: platformViewId, maxValueLength: maxValueLength, currentValueLength: currentValueLength, headingLevel: headingLevel, linkUrl: linkUrl, role: role, controlsNodes: controlsNodes, validationResult: validationResult, hitTestBehavior: hitTestBehavior, inputType: inputType, locale: locale, minValue: minValue, maxValue: maxValue, tags: tags, transform: transform, customSemanticsActionIds: customSemanticsActionIds);
      },
    },
    getters: {
      'flagsCollection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').flagsCollection,
      'actions': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').actions,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').traversalChildIdentifier,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').attributedLabel,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').attributedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').attributedIncreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').attributedDecreasedValue,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').tooltip,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').headingLevel,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').textDirection,
      'textSelection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').textSelection,
      'scrollChildCount': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').scrollChildCount,
      'scrollIndex': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').scrollIndex,
      'scrollPosition': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').scrollPosition,
      'scrollExtentMax': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').scrollExtentMax,
      'scrollExtentMin': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').scrollExtentMin,
      'platformViewId': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').platformViewId,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').currentValueLength,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').linkUrl,
      'rect': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').rect,
      'tags': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').tags,
      'transform': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').transform,
      'customSemanticsActionIds': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').customSemanticsActionIds,
      'role': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').role,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').controlsNodes,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').inputType,
      'locale': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').locale,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').maxValue,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').minValue,
      'flags': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').flags,
      'label': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').label,
      'value': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').value,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').increasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').decreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').hint,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData').hashCode,
    },
    methods: {
      'hasFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData');
        D4.requireMinArgs(positional, 1, 'hasFlag');
        final flag = D4.getRequiredArg<SemanticsFlag>(positional, 0, 'flag', 'hasFlag');
        return t.hasFlag(flag);
      },
      'hasAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData');
        D4.requireMinArgs(positional, 1, 'hasAction');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 0, 'action', 'hasAction');
        return t.hasAction(action);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData');
        return t.toStringShort();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsData>(target, 'SemanticsData');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
      'flagsCollection': 'SemanticsFlags get flagsCollection',
      'actions': 'int get actions',
      'identifier': 'String get identifier',
      'traversalParentIdentifier': 'Object? get traversalParentIdentifier',
      'traversalChildIdentifier': 'Object? get traversalChildIdentifier',
      'attributedLabel': 'AttributedString get attributedLabel',
      'attributedValue': 'AttributedString get attributedValue',
      'attributedIncreasedValue': 'AttributedString get attributedIncreasedValue',
      'attributedDecreasedValue': 'AttributedString get attributedDecreasedValue',
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
      'hitTestBehavior': 'SemanticsHitTestBehavior get hitTestBehavior',
      'inputType': 'SemanticsInputType get inputType',
      'locale': 'Locale? get locale',
      'maxValue': 'String? get maxValue',
      'minValue': 'String? get minValue',
      'flags': 'int get flags',
      'label': 'String get label',
      'value': 'String get value',
      'increasedValue': 'String get increasedValue',
      'decreasedValue': 'String get decreasedValue',
      'hint': 'String get hint',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// SemanticsHintOverrides Bridge
// =============================================================================

BridgedClass _createSemanticsHintOverridesBridge() {
  return BridgedClass(
    nativeType: $flutter_7.SemanticsHintOverrides,
    name: 'SemanticsHintOverrides',
    isAssignable: (v) => v is $flutter_7.SemanticsHintOverrides,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final onTapHint = D4.getOptionalNamedArg<String?>(named, 'onTapHint');
        final onLongPressHint = D4.getOptionalNamedArg<String?>(named, 'onLongPressHint');
        return $flutter_7.SemanticsHintOverrides(onTapHint: onTapHint, onLongPressHint: onLongPressHint);
      },
    },
    getters: {
      'onTapHint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').onTapHint,
      'onLongPressHint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').onLongPressHint,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').isNotEmpty,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides').hashCode,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsHintOverrides>(target, 'SemanticsHintOverrides');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
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
    nativeType: $flutter_7.SemanticsProperties,
    name: 'SemanticsProperties',
    isAssignable: (v) => v is $flutter_7.SemanticsProperties,
    hierarchyDepth: 2,
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
        final accessibilityFocusBlockType = D4.getOptionalNamedArg<$flutter_7.AccessibilityFocusBlockType?>(named, 'accessibilityFocusBlockType');
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
        final attributedLabel = D4.getOptionalNamedArg<$flutter_7.AttributedString?>(named, 'attributedLabel');
        final value = D4.getOptionalNamedArg<String?>(named, 'value');
        final attributedValue = D4.getOptionalNamedArg<$flutter_7.AttributedString?>(named, 'attributedValue');
        final increasedValue = D4.getOptionalNamedArg<String?>(named, 'increasedValue');
        final attributedIncreasedValue = D4.getOptionalNamedArg<$flutter_7.AttributedString?>(named, 'attributedIncreasedValue');
        final decreasedValue = D4.getOptionalNamedArg<String?>(named, 'decreasedValue');
        final attributedDecreasedValue = D4.getOptionalNamedArg<$flutter_7.AttributedString?>(named, 'attributedDecreasedValue');
        final hint = D4.getOptionalNamedArg<String?>(named, 'hint');
        final tooltip = D4.getOptionalNamedArg<String?>(named, 'tooltip');
        final attributedHint = D4.getOptionalNamedArg<$flutter_7.AttributedString?>(named, 'attributedHint');
        final hintOverrides = D4.getOptionalNamedArg<$flutter_7.SemanticsHintOverrides?>(named, 'hintOverrides');
        final textDirection = D4.getOptionalNamedArg<TextDirection?>(named, 'textDirection');
        final sortKey = D4.getOptionalNamedArg<$flutter_7.SemanticsSortKey?>(named, 'sortKey');
        final tagForChildren = D4.getOptionalNamedArg<$flutter_7.SemanticsTag?>(named, 'tagForChildren');
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
        Map<$flutter_7.CustomSemanticsAction, void Function()>? customSemanticsActions;
        if (named.containsKey('customSemanticsActions') && named['customSemanticsActions'] != null) {
          // Convert map with function values inline
          final customSemanticsActionsRaw = named['customSemanticsActions'] as Map?;
          if (customSemanticsActionsRaw != null) {
            for (final entry in customSemanticsActionsRaw.entries) {
              final k = D4.extractBridgedArg<$flutter_7.CustomSemanticsAction>(entry.key, 'customSemanticsActions[key]');
              final v = entry.value;
              if (v == null) {
                // Skip null values for non-nullable function type
              } else if (v is Callable) {
                customSemanticsActions ??= <$flutter_7.CustomSemanticsAction, void Function()>{};
                customSemanticsActions![k] = () { D4.callInterpreterCallback(visitor, v, []); };
              } else {
                customSemanticsActions ??= <$flutter_7.CustomSemanticsAction, void Function()>{};
                customSemanticsActions![k] = v as void Function();
              }
            }
          }
        } else {
          customSemanticsActions = null;
        }
        final minValue = D4.getOptionalNamedArg<String?>(named, 'minValue');
        final maxValue = D4.getOptionalNamedArg<String?>(named, 'maxValue');
        return $flutter_7.SemanticsProperties(enabled: enabled, checked: checked, mixed: mixed, expanded: expanded, selected: selected, toggled: toggled, button: button, link: link, linkUrl: linkUrl, header: header, headingLevel: headingLevel, textField: textField, slider: slider, keyboardKey: keyboardKey, readOnly: readOnly, focusable: focusable, focused: focused, accessibilityFocusBlockType: accessibilityFocusBlockType, inMutuallyExclusiveGroup: inMutuallyExclusiveGroup, hidden: hidden, obscured: obscured, multiline: multiline, scopesRoute: scopesRoute, namesRoute: namesRoute, image: image, liveRegion: liveRegion, isRequired: isRequired, maxValueLength: maxValueLength, currentValueLength: currentValueLength, identifier: identifier, traversalParentIdentifier: traversalParentIdentifier, traversalChildIdentifier: traversalChildIdentifier, label: label, attributedLabel: attributedLabel, value: value, attributedValue: attributedValue, increasedValue: increasedValue, attributedIncreasedValue: attributedIncreasedValue, decreasedValue: decreasedValue, attributedDecreasedValue: attributedDecreasedValue, hint: hint, tooltip: tooltip, attributedHint: attributedHint, hintOverrides: hintOverrides, textDirection: textDirection, sortKey: sortKey, tagForChildren: tagForChildren, role: role, controlsNodes: controlsNodes, inputType: inputType, validationResult: validationResult, hitTestBehavior: hitTestBehavior, onTap: onTapRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapRaw, []); }, onLongPress: onLongPressRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onLongPressRaw, []); }, onScrollLeft: onScrollLeftRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollLeftRaw, []); }, onScrollRight: onScrollRightRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollRightRaw, []); }, onScrollUp: onScrollUpRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollUpRaw, []); }, onScrollDown: onScrollDownRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollDownRaw, []); }, onIncrease: onIncreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onIncreaseRaw, []); }, onDecrease: onDecreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDecreaseRaw, []); }, onCopy: onCopyRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCopyRaw, []); }, onCut: onCutRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCutRaw, []); }, onPaste: onPasteRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onPasteRaw, []); }, onMoveCursorForwardByCharacter: onMoveCursorForwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorForwardByCharacterRaw, [p0]); }, onMoveCursorBackwardByCharacter: onMoveCursorBackwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorBackwardByCharacterRaw, [p0]); }, onMoveCursorForwardByWord: onMoveCursorForwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorForwardByWordRaw, [p0]); }, onMoveCursorBackwardByWord: onMoveCursorBackwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorBackwardByWordRaw, [p0]); }, onSetSelection: onSetSelectionRaw == null ? null : ($flutter_10.TextSelection p0) { D4.callInterpreterCallback(visitor!, onSetSelectionRaw, [p0]); }, onSetText: onSetTextRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onSetTextRaw, [p0]); }, onDidGainAccessibilityFocus: onDidGainAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDidGainAccessibilityFocusRaw, []); }, onDidLoseAccessibilityFocus: onDidLoseAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDidLoseAccessibilityFocusRaw, []); }, onFocus: onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); }, onDismiss: onDismissRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDismissRaw, []); }, onExpand: onExpandRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onExpandRaw, []); }, onCollapse: onCollapseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCollapseRaw, []); }, customSemanticsActions: customSemanticsActions, minValue: minValue, maxValue: maxValue);
      },
    },
    getters: {
      'enabled': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').enabled,
      'checked': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').checked,
      'mixed': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').mixed,
      'expanded': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').expanded,
      'toggled': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').toggled,
      'selected': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').selected,
      'button': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').button,
      'link': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').link,
      'header': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').header,
      'textField': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').textField,
      'slider': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').slider,
      'keyboardKey': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').keyboardKey,
      'readOnly': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').readOnly,
      'focusable': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').focusable,
      'focused': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').focused,
      'accessibilityFocusBlockType': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').accessibilityFocusBlockType,
      'inMutuallyExclusiveGroup': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').inMutuallyExclusiveGroup,
      'hidden': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').hidden,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').obscured,
      'multiline': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').multiline,
      'scopesRoute': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').scopesRoute,
      'namesRoute': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').namesRoute,
      'image': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').image,
      'liveRegion': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').liveRegion,
      'isRequired': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').isRequired,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').currentValueLength,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').traversalChildIdentifier,
      'label': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').value,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').tooltip,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').headingLevel,
      'hintOverrides': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').hintOverrides,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').textDirection,
      'sortKey': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').sortKey,
      'tagForChildren': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').tagForChildren,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').linkUrl,
      'onTap': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onTap,
      'onLongPress': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onLongPress,
      'onScrollLeft': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onScrollLeft,
      'onScrollRight': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onScrollRight,
      'onScrollUp': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onScrollUp,
      'onScrollDown': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onScrollDown,
      'onIncrease': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onIncrease,
      'onDecrease': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onDecrease,
      'onCopy': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onCopy,
      'onCut': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onCut,
      'onPaste': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onPaste,
      'onMoveCursorForwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorForwardByCharacter,
      'onMoveCursorBackwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorBackwardByCharacter,
      'onMoveCursorForwardByWord': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorForwardByWord,
      'onMoveCursorBackwardByWord': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onMoveCursorBackwardByWord,
      'onSetSelection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onSetSelection,
      'onSetText': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onSetText,
      'onDidGainAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onDidGainAccessibilityFocus,
      'onDidLoseAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onDidLoseAccessibilityFocus,
      'onFocus': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onFocus,
      'onDismiss': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onDismiss,
      'onExpand': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onExpand,
      'onCollapse': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').onCollapse,
      'customSemanticsActions': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').customSemanticsActions,
      'role': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').role,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').controlsNodes,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').inputType,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').maxValue,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties').minValue,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties');
        return t.toStringShort();
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_3.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties');
        return t.debugDescribeChildren();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsProperties>(target, 'SemanticsProperties');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
    },
    constructorSignatures: {
      '': 'const SemanticsProperties({bool? enabled, bool? checked, bool? mixed, bool? expanded, bool? selected, bool? toggled, bool? button, bool? link, Uri? linkUrl, bool? header, int? headingLevel, bool? textField, bool? slider, bool? keyboardKey, bool? readOnly, bool? focusable, bool? focused, AccessibilityFocusBlockType? accessibilityFocusBlockType, bool? inMutuallyExclusiveGroup, bool? hidden, bool? obscured, bool? multiline, bool? scopesRoute, bool? namesRoute, bool? image, bool? liveRegion, bool? isRequired, int? maxValueLength, int? currentValueLength, String? identifier, Object? traversalParentIdentifier, Object? traversalChildIdentifier, String? label, AttributedString? attributedLabel, String? value, AttributedString? attributedValue, String? increasedValue, AttributedString? attributedIncreasedValue, String? decreasedValue, AttributedString? attributedDecreasedValue, String? hint, String? tooltip, AttributedString? attributedHint, SemanticsHintOverrides? hintOverrides, TextDirection? textDirection, SemanticsSortKey? sortKey, SemanticsTag? tagForChildren, SemanticsRole? role, Set<String>? controlsNodes, SemanticsInputType? inputType, SemanticsValidationResult validationResult = SemanticsValidationResult.none, SemanticsHitTestBehavior? hitTestBehavior, VoidCallback? onTap, VoidCallback? onLongPress, VoidCallback? onScrollLeft, VoidCallback? onScrollRight, VoidCallback? onScrollUp, VoidCallback? onScrollDown, VoidCallback? onIncrease, VoidCallback? onDecrease, VoidCallback? onCopy, VoidCallback? onCut, VoidCallback? onPaste, MoveCursorHandler? onMoveCursorForwardByCharacter, MoveCursorHandler? onMoveCursorBackwardByCharacter, MoveCursorHandler? onMoveCursorForwardByWord, MoveCursorHandler? onMoveCursorBackwardByWord, SetSelectionHandler? onSetSelection, SetTextHandler? onSetText, VoidCallback? onDidGainAccessibilityFocus, VoidCallback? onDidLoseAccessibilityFocus, VoidCallback? onFocus, VoidCallback? onDismiss, VoidCallback? onExpand, VoidCallback? onCollapse, Map<CustomSemanticsAction, VoidCallback>? customSemanticsActions, String? minValue, String? maxValue})',
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
      'hitTestBehavior': 'SemanticsHitTestBehavior? get hitTestBehavior',
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
    nativeType: $flutter_7.SemanticsNode,
    name: 'SemanticsNode',
    isAssignable: (v) => v is $flutter_7.SemanticsNode,
    hierarchyDepth: 3,
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getOptionalNamedArg<$flutter_4.Key?>(named, 'key');
        final showOnScreenRaw = named['showOnScreen'];
        return $flutter_7.SemanticsNode(key: key, showOnScreen: showOnScreenRaw == null ? null : () { D4.callInterpreterCallback(visitor!, showOnScreenRaw, []); });
      },
      'root': (visitor, positional, named) {
        final key = D4.getOptionalNamedArg<$flutter_4.Key?>(named, 'key');
        final showOnScreenRaw = named['showOnScreen'];
        final owner = D4.getRequiredNamedArg<$flutter_7.SemanticsOwner>(named, 'owner', 'SemanticsNode');
        return $flutter_7.SemanticsNode.root(key: key, showOnScreen: showOnScreenRaw == null ? null : () { D4.callInterpreterCallback(visitor!, showOnScreenRaw, []); }, owner: owner);
      },
    },
    getters: {
      'key': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').key,
      'parentSemanticsClipRect': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').parentSemanticsClipRect,
      'parentPaintClipRect': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').parentPaintClipRect,
      'indexInParent': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').indexInParent,
      'tags': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').tags,
      'id': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').id,
      'transform': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').transform,
      'rect': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').rect,
      'isInvisible': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').isInvisible,
      'isMergedIntoParent': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').isMergedIntoParent,
      'areUserActionsBlocked': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').areUserActionsBlocked,
      'isPartOfNodeMerging': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').isPartOfNodeMerging,
      'mergeAllDescendantsIntoThisNode': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').mergeAllDescendantsIntoThisNode,
      'hasChildren': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').hasChildren,
      'childrenCount': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').childrenCount,
      'childrenCountInTraversalOrder': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').childrenCountInTraversalOrder,
      'owner': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').owner,
      'attached': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').attached,
      'parent': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').parent,
      'traversalParent': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').traversalParent,
      'depth': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').depth,
      'debugIsDirty': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').debugIsDirty,
      'flagsCollection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').flagsCollection,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').traversalChildIdentifier,
      'label': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').value,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').tooltip,
      'hintOverrides': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').hintOverrides,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').textDirection,
      'sortKey': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').sortKey,
      'textSelection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').textSelection,
      'isMultiline': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').isMultiline,
      'scrollChildCount': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').scrollChildCount,
      'scrollIndex': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').scrollIndex,
      'scrollPosition': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').scrollPosition,
      'scrollExtentMax': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').scrollExtentMax,
      'scrollExtentMin': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').scrollExtentMin,
      'platformViewId': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').platformViewId,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').currentValueLength,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').headingLevel,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').linkUrl,
      'role': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').role,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').controlsNodes,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').minValue,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').maxValue,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').inputType,
    },
    setters: {
      'parentSemanticsClipRect': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').parentSemanticsClipRect = D4.extractBridgedArgOrNull<Rect>(value, 'parentSemanticsClipRect'),
      'parentPaintClipRect': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').parentPaintClipRect = D4.extractBridgedArgOrNull<Rect>(value, 'parentPaintClipRect'),
      'indexInParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').indexInParent = D4.extractBridgedArgOrNull<int>(value, 'indexInParent'),
      'tags': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').tags = value == null ? null : D4.coerceSet<$flutter_7.SemanticsTag>(value, 'tags'),
      'transform': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').transform = D4.extractBridgedArgOrNull<$vector_math_1.Matrix4>(value, 'transform'),
      'rect': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').rect = D4.extractBridgedArg<Rect>(value, 'rect'),
      'isMergedIntoParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').isMergedIntoParent = D4.extractBridgedArg<bool>(value, 'isMergedIntoParent'),
      'areUserActionsBlocked': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').areUserActionsBlocked = D4.extractBridgedArg<bool>(value, 'areUserActionsBlocked'),
      'traversalParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode').traversalParent = D4.extractBridgedArgOrNull<$flutter_7.SemanticsNode>(value, 'traversalParent'),
    },
    methods: {
      'visitChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'visitChildren');
        if (positional.isEmpty) {
          throw ArgumentError('visitChildren: Missing required argument "visitor" at position 0');
        }
        final visitor_Raw = positional[0];
        t.visitChildren((($flutter_7.SemanticsNode p0) { return D4.callInterpreterCallback(visitor!, visitor_Raw, [p0]) as bool; }) as bool Function($flutter_7.SemanticsNode));
        return null;
      },
      'attach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'attach');
        final owner = D4.getRequiredArg<$flutter_7.SemanticsOwner>(positional, 0, 'owner', 'attach');
        t.attach(owner);
        return null;
      },
      'detach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        t.detach();
        return null;
      },
      'isTagged': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'isTagged');
        final tag = D4.getRequiredArg<$flutter_7.SemanticsTag>(positional, 0, 'tag', 'isTagged');
        return t.isTagged(tag);
      },
      'hasFlag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'hasFlag');
        final flag = D4.getRequiredArg<SemanticsFlag>(positional, 0, 'flag', 'hasFlag');
        return t.hasFlag(flag);
      },
      'updateWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        final config = D4.getRequiredNamedArg<$flutter_7.SemanticsConfiguration?>(named, 'config', 'updateWith');
        final childrenInInversePaintOrder = D4.coerceListOrNull<$flutter_7.SemanticsNode>(named['childrenInInversePaintOrder'], 'childrenInInversePaintOrder');
        t.updateWith(config: config, childrenInInversePaintOrder: childrenInInversePaintOrder);
        return null;
      },
      'getSemanticsData': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        return t.getSemanticsData();
      },
      'sendEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'sendEvent');
        final event = D4.getRequiredArg<$flutter_8.SemanticsEvent>(positional, 0, 'event', 'sendEvent');
        t.sendEvent(event);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        return t.toStringShort();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.debug);
        final childOrder = D4.getNamedArgWithDefault<$flutter_7.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_7.DebugSemanticsDumpOrder.traversalOrder);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, childOrder: childOrder, wrapWidth: wrapWidth);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getNamedArgWithDefault<$flutter_3.DiagnosticsTreeStyle?>(named, 'style', $flutter_3.DiagnosticsTreeStyle.sparse);
        final childOrder = D4.getNamedArgWithDefault<$flutter_7.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_7.DebugSemanticsDumpOrder.traversalOrder);
        return t.toDiagnosticsNode(name: name, style: style, childOrder: childOrder);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        final childOrder = D4.getNamedArgWithDefault<$flutter_7.DebugSemanticsDumpOrder>(named, 'childOrder', $flutter_7.DebugSemanticsDumpOrder.traversalOrder);
        return t.debugDescribeChildren(childOrder: childOrder);
      },
      'debugListChildrenInOrder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        D4.requireMinArgs(positional, 1, 'debugListChildrenInOrder');
        final childOrder = D4.getRequiredArg<$flutter_7.DebugSemanticsDumpOrder>(positional, 0, 'childOrder', 'debugListChildrenInOrder');
        return t.debugListChildrenInOrder(childOrder);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsNode>(target, 'SemanticsNode');
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
      'attach': 'void attach(SemanticsOwner owner)',
      'detach': 'void detach()',
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
      'parentSemanticsClipRect': 'Rect? get parentSemanticsClipRect',
      'parentPaintClipRect': 'Rect? get parentPaintClipRect',
      'indexInParent': 'int? get indexInParent',
      'tags': 'Set<SemanticsTag>? get tags',
      'id': 'int get id',
      'transform': 'Matrix4? get transform',
      'rect': 'Rect get rect',
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
      'debugIsDirty': 'bool? get debugIsDirty',
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
      'hitTestBehavior': 'SemanticsHitTestBehavior get hitTestBehavior',
      'inputType': 'SemanticsInputType get inputType',
    },
    setterSignatures: {
      'parentSemanticsClipRect': 'set parentSemanticsClipRect(dynamic value)',
      'parentPaintClipRect': 'set parentPaintClipRect(dynamic value)',
      'indexInParent': 'set indexInParent(dynamic value)',
      'tags': 'set tags(dynamic value)',
      'transform': 'set transform(Matrix4? value)',
      'rect': 'set rect(Rect value)',
      'isMergedIntoParent': 'set isMergedIntoParent(bool value)',
      'areUserActionsBlocked': 'set areUserActionsBlocked(bool value)',
      'traversalParent': 'set traversalParent(SemanticsNode? value)',
    },
  );
}

// =============================================================================
// SemanticsOwner Bridge
// =============================================================================

BridgedClass _createSemanticsOwnerBridge() {
  return BridgedClass(
    nativeType: $flutter_7.SemanticsOwner,
    name: 'SemanticsOwner',
    isAssignable: (v) => v is $flutter_7.SemanticsOwner,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('onSemanticsUpdate') || named['onSemanticsUpdate'] == null) {
          throw ArgumentError('SemanticsOwner: Missing required named argument "onSemanticsUpdate"');
        }
        final onSemanticsUpdateRaw = named['onSemanticsUpdate'];
        return $flutter_7.SemanticsOwner(onSemanticsUpdate: (SemanticsUpdate p0) { D4.callInterpreterCallback(visitor!, onSemanticsUpdateRaw, [p0]); });
      },
    },
    getters: {
      'onSemanticsUpdate': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner').onSemanticsUpdate,
      'rootSemanticsNode': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner').rootSemanticsNode,
      'hasListeners': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner').hasListeners,
    },
    methods: {
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        (t as dynamic).dispose();
        return null;
      },
      'sendSemanticsUpdate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        t.sendSemanticsUpdate();
        return null;
      },
      'performAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 2, 'performAction');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'performAction');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 1, 'action', 'performAction');
        final args = D4.getOptionalArg<Object?>(positional, 2, 'args');
        t.performAction(id, action, args);
        return null;
      },
      'performActionAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 2, 'performActionAt');
        final position = D4.getRequiredArg<Offset>(positional, 0, 'position', 'performActionAt');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 1, 'action', 'performActionAt');
        final args = D4.getOptionalArg<Object?>(positional, 2, 'args');
        t.performActionAt(position, action, args);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        return t.toString();
      },
      'addListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 1, 'addListener');
        if (positional.isEmpty) {
          throw ArgumentError('addListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.addListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'removeListener': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        D4.requireMinArgs(positional, 1, 'removeListener');
        if (positional.isEmpty) {
          throw ArgumentError('removeListener: Missing required argument "listener" at position 0');
        }
        final listenerRaw = positional[0];
        t.removeListener(() { D4.callInterpreterCallback(visitor!, listenerRaw, []); });
        return null;
      },
      'notifyListeners': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsOwner>(target, 'SemanticsOwner');
        t.notifyListeners();
        return null;
      },
    },
    constructorSignatures: {
      '': 'SemanticsOwner({required SemanticsUpdateCallback onSemanticsUpdate})',
    },
    methodSignatures: {
      'dispose': 'void dispose()',
      'sendSemanticsUpdate': 'void sendSemanticsUpdate()',
      'performAction': 'void performAction(int id, SemanticsAction action, [Object? args])',
      'performActionAt': 'void performActionAt(Offset position, SemanticsAction action, [Object? args])',
      'toString': 'String toString()',
      'addListener': 'void addListener(VoidCallback listener)',
      'removeListener': 'void removeListener(VoidCallback listener)',
      'notifyListeners': 'void notifyListeners()',
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
    nativeType: $flutter_7.SemanticsConfiguration,
    name: 'SemanticsConfiguration',
    isAssignable: (v) => v is $flutter_7.SemanticsConfiguration,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_7.SemanticsConfiguration();
      },
    },
    getters: {
      'locale': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').locale,
      'isBlockingUserActions': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingUserActions,
      'explicitChildNodes': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').explicitChildNodes,
      'isBlockingSemanticsOfPreviouslyPaintedNodes': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingSemanticsOfPreviouslyPaintedNodes,
      'isSemanticBoundary': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSemanticBoundary,
      'localeForSubtree': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').localeForSubtree,
      'hasBeenAnnotated': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hasBeenAnnotated,
      'onTap': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onTap,
      'onLongPress': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onLongPress,
      'onScrollLeft': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollLeft,
      'onDismiss': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDismiss,
      'onScrollRight': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollRight,
      'onScrollUp': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollUp,
      'onScrollDown': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollDown,
      'onScrollToOffset': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollToOffset,
      'onIncrease': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onIncrease,
      'onDecrease': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDecrease,
      'onCopy': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCopy,
      'onCut': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCut,
      'onPaste': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onPaste,
      'onShowOnScreen': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onShowOnScreen,
      'onMoveCursorForwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByCharacter,
      'onMoveCursorBackwardByCharacter': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByCharacter,
      'onMoveCursorForwardByWord': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByWord,
      'onMoveCursorBackwardByWord': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByWord,
      'onSetSelection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetSelection,
      'onSetText': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetText,
      'onDidGainAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidGainAccessibilityFocus,
      'onDidLoseAccessibilityFocus': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidLoseAccessibilityFocus,
      'onFocus': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onFocus,
      'onExpand': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onExpand,
      'onCollapse': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCollapse,
      'childConfigurationsDelegate': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').childConfigurationsDelegate,
      'sortKey': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').sortKey,
      'indexInParent': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').indexInParent,
      'scrollChildCount': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollChildCount,
      'scrollIndex': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollIndex,
      'platformViewId': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').platformViewId,
      'maxValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValueLength,
      'currentValueLength': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').currentValueLength,
      'isMergingSemanticsOfDescendants': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMergingSemanticsOfDescendants,
      'customSemanticsActions': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').customSemanticsActions,
      'identifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').identifier,
      'traversalParentIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalParentIdentifier,
      'traversalChildIdentifier': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalChildIdentifier,
      'role': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').role,
      'label': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').label,
      'attributedLabel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedLabel,
      'value': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').value,
      'attributedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedValue,
      'increasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').increasedValue,
      'attributedIncreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedIncreasedValue,
      'decreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').decreasedValue,
      'attributedDecreasedValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedDecreasedValue,
      'hint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hint,
      'attributedHint': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedHint,
      'tooltip': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').tooltip,
      'hintOverrides': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hintOverrides,
      'scopesRoute': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scopesRoute,
      'namesRoute': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').namesRoute,
      'isImage': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isImage,
      'liveRegion': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').liveRegion,
      'textDirection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').textDirection,
      'isSelected': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSelected,
      'isExpanded': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isExpanded,
      'isEnabled': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isEnabled,
      'isChecked': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isChecked,
      'isCheckStateMixed': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isCheckStateMixed,
      'isToggled': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isToggled,
      'isInMutuallyExclusiveGroup': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isInMutuallyExclusiveGroup,
      'isFocusable': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocusable,
      'isFocused': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocused,
      'accessibilityFocusBlockType': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').accessibilityFocusBlockType,
      'isButton': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isButton,
      'isLink': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isLink,
      'linkUrl': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').linkUrl,
      'isHeader': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHeader,
      'headingLevel': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').headingLevel,
      'isSlider': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSlider,
      'isKeyboardKey': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isKeyboardKey,
      'isHidden': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHidden,
      'isTextField': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isTextField,
      'isReadOnly': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isReadOnly,
      'isObscured': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isObscured,
      'isMultiline': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMultiline,
      'isRequired': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isRequired,
      'hasImplicitScrolling': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hasImplicitScrolling,
      'textSelection': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').textSelection,
      'scrollPosition': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollPosition,
      'scrollExtentMax': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMax,
      'scrollExtentMin': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMin,
      'controlsNodes': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').controlsNodes,
      'validationResult': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').validationResult,
      'hitTestBehavior': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hitTestBehavior,
      'inputType': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').inputType,
      'maxValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValue,
      'minValue': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').minValue,
      'tagsForChildren': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').tagsForChildren,
    },
    setters: {
      'locale': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').locale = D4.extractBridgedArgOrNull<Locale>(value, 'locale'),
      'isBlockingUserActions': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingUserActions = D4.extractBridgedArg<bool>(value, 'isBlockingUserActions'),
      'explicitChildNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').explicitChildNodes = D4.extractBridgedArg<bool>(value, 'explicitChildNodes'),
      'isBlockingSemanticsOfPreviouslyPaintedNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isBlockingSemanticsOfPreviouslyPaintedNodes = D4.extractBridgedArg<bool>(value, 'isBlockingSemanticsOfPreviouslyPaintedNodes'),
      'isSemanticBoundary': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSemanticBoundary = D4.extractBridgedArg<bool>(value, 'isSemanticBoundary'),
      'localeForSubtree': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').localeForSubtree = D4.extractBridgedArgOrNull<Locale>(value, 'localeForSubtree'),
      'onTap': (visitor, target, value) {
        final onTapRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTap');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onTap = onTapRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapRaw, []); };
      },
      'onLongPress': (visitor, target, value) {
        final onLongPressRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPress');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onLongPress = onLongPressRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onLongPressRaw, []); };
      },
      'onScrollLeft': (visitor, target, value) {
        final onScrollLeftRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollLeft');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollLeft = onScrollLeftRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollLeftRaw, []); };
      },
      'onDismiss': (visitor, target, value) {
        final onDismissRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDismiss');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDismiss = onDismissRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDismissRaw, []); };
      },
      'onScrollRight': (visitor, target, value) {
        final onScrollRightRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollRight');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollRight = onScrollRightRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollRightRaw, []); };
      },
      'onScrollUp': (visitor, target, value) {
        final onScrollUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollUp');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollUp = onScrollUpRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollUpRaw, []); };
      },
      'onScrollDown': (visitor, target, value) {
        final onScrollDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollDown');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollDown = onScrollDownRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onScrollDownRaw, []); };
      },
      'onScrollToOffset': (visitor, target, value) {
        final onScrollToOffsetRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onScrollToOffset');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onScrollToOffset = onScrollToOffsetRaw == null ? null : (Offset p0) { D4.callInterpreterCallback(visitor!, onScrollToOffsetRaw, [p0]); };
      },
      'onIncrease': (visitor, target, value) {
        final onIncreaseRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onIncrease');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onIncrease = onIncreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onIncreaseRaw, []); };
      },
      'onDecrease': (visitor, target, value) {
        final onDecreaseRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDecrease');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDecrease = onDecreaseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDecreaseRaw, []); };
      },
      'onCopy': (visitor, target, value) {
        final onCopyRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCopy');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCopy = onCopyRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCopyRaw, []); };
      },
      'onCut': (visitor, target, value) {
        final onCutRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCut');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCut = onCutRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCutRaw, []); };
      },
      'onPaste': (visitor, target, value) {
        final onPasteRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onPaste');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onPaste = onPasteRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onPasteRaw, []); };
      },
      'onShowOnScreen': (visitor, target, value) {
        final onShowOnScreenRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onShowOnScreen');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onShowOnScreen = onShowOnScreenRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onShowOnScreenRaw, []); };
      },
      'onMoveCursorForwardByCharacter': (visitor, target, value) {
        final onMoveCursorForwardByCharacterRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onMoveCursorForwardByCharacter');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByCharacter = onMoveCursorForwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorForwardByCharacterRaw, [p0]); };
      },
      'onMoveCursorBackwardByCharacter': (visitor, target, value) {
        final onMoveCursorBackwardByCharacterRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onMoveCursorBackwardByCharacter');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByCharacter = onMoveCursorBackwardByCharacterRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorBackwardByCharacterRaw, [p0]); };
      },
      'onMoveCursorForwardByWord': (visitor, target, value) {
        final onMoveCursorForwardByWordRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onMoveCursorForwardByWord');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorForwardByWord = onMoveCursorForwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorForwardByWordRaw, [p0]); };
      },
      'onMoveCursorBackwardByWord': (visitor, target, value) {
        final onMoveCursorBackwardByWordRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onMoveCursorBackwardByWord');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onMoveCursorBackwardByWord = onMoveCursorBackwardByWordRaw == null ? null : (bool p0) { D4.callInterpreterCallback(visitor!, onMoveCursorBackwardByWordRaw, [p0]); };
      },
      'onSetSelection': (visitor, target, value) {
        final onSetSelectionRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSetSelection');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetSelection = onSetSelectionRaw == null ? null : ($flutter_10.TextSelection p0) { D4.callInterpreterCallback(visitor!, onSetSelectionRaw, [p0]); };
      },
      'onSetText': (visitor, target, value) {
        final onSetTextRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSetText');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onSetText = onSetTextRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onSetTextRaw, [p0]); };
      },
      'onDidGainAccessibilityFocus': (visitor, target, value) {
        final onDidGainAccessibilityFocusRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDidGainAccessibilityFocus');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidGainAccessibilityFocus = onDidGainAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDidGainAccessibilityFocusRaw, []); };
      },
      'onDidLoseAccessibilityFocus': (visitor, target, value) {
        final onDidLoseAccessibilityFocusRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDidLoseAccessibilityFocus');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onDidLoseAccessibilityFocus = onDidLoseAccessibilityFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDidLoseAccessibilityFocusRaw, []); };
      },
      'onFocus': (visitor, target, value) {
        final onFocusRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onFocus');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onFocus = onFocusRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onFocusRaw, []); };
      },
      'onExpand': (visitor, target, value) {
        final onExpandRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onExpand');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onExpand = onExpandRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onExpandRaw, []); };
      },
      'onCollapse': (visitor, target, value) {
        final onCollapseRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCollapse');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').onCollapse = onCollapseRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCollapseRaw, []); };
      },
      'childConfigurationsDelegate': (visitor, target, value) {
        final childConfigurationsDelegateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'childConfigurationsDelegate');
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').childConfigurationsDelegate = childConfigurationsDelegateRaw == null ? null : ((List<$flutter_7.SemanticsConfiguration> p0) { return D4.extractBridgedArg<$flutter_7.ChildSemanticsConfigurationsResult>(D4.callInterpreterCallback(visitor!, childConfigurationsDelegateRaw, [p0]), 'callback', visitor) as $flutter_7.ChildSemanticsConfigurationsResult; }) as $flutter_7.ChildSemanticsConfigurationsResult Function(List<$flutter_7.SemanticsConfiguration>);
      },
      'sortKey': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').sortKey = D4.extractBridgedArgOrNull<$flutter_7.SemanticsSortKey>(value, 'sortKey'),
      'indexInParent': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').indexInParent = D4.extractBridgedArgOrNull<int>(value, 'indexInParent'),
      'scrollChildCount': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollChildCount = D4.extractBridgedArgOrNull<int>(value, 'scrollChildCount'),
      'scrollIndex': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollIndex = D4.extractBridgedArgOrNull<int>(value, 'scrollIndex'),
      'platformViewId': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').platformViewId = D4.extractBridgedArgOrNull<int>(value, 'platformViewId'),
      'maxValueLength': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValueLength = D4.extractBridgedArgOrNull<int>(value, 'maxValueLength'),
      'currentValueLength': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').currentValueLength = D4.extractBridgedArgOrNull<int>(value, 'currentValueLength'),
      'isMergingSemanticsOfDescendants': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMergingSemanticsOfDescendants = D4.extractBridgedArg<bool>(value, 'isMergingSemanticsOfDescendants'),
      'customSemanticsActions': (visitor, target, value) {
        if (value == null) {
          throw ArgumentError('SemanticsConfiguration.customSemanticsActions: non-nullable map value cannot be null');
        }
        // Convert map with function values inline
        final customSemanticsActionsMapRaw = value as Map?;
        final customSemanticsActionsMap = <$flutter_7.CustomSemanticsAction, void Function()>{};
        if (customSemanticsActionsMapRaw != null) {
          for (final entry in customSemanticsActionsMapRaw.entries) {
            final k = D4.extractBridgedArg<$flutter_7.CustomSemanticsAction>(entry.key, 'customSemanticsActionsMap[key]');
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
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').customSemanticsActions = customSemanticsActionsMap;
      },
      'identifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').identifier = D4.extractBridgedArg<String>(value, 'identifier'),
      'traversalParentIdentifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalParentIdentifier = D4.extractBridgedArgOrNull<Object>(value, 'traversalParentIdentifier'),
      'traversalChildIdentifier': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').traversalChildIdentifier = D4.extractBridgedArgOrNull<Object>(value, 'traversalChildIdentifier'),
      'role': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').role = D4.extractBridgedArg<SemanticsRole>(value, 'role'),
      'label': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').label = D4.extractBridgedArg<String>(value, 'label'),
      'attributedLabel': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedLabel = D4.extractBridgedArg<$flutter_7.AttributedString>(value, 'attributedLabel'),
      'value': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').value = D4.extractBridgedArg<String>(value, 'value'),
      'attributedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedValue = D4.extractBridgedArg<$flutter_7.AttributedString>(value, 'attributedValue'),
      'increasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').increasedValue = D4.extractBridgedArg<String>(value, 'increasedValue'),
      'attributedIncreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedIncreasedValue = D4.extractBridgedArg<$flutter_7.AttributedString>(value, 'attributedIncreasedValue'),
      'decreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').decreasedValue = D4.extractBridgedArg<String>(value, 'decreasedValue'),
      'attributedDecreasedValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedDecreasedValue = D4.extractBridgedArg<$flutter_7.AttributedString>(value, 'attributedDecreasedValue'),
      'hint': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hint = D4.extractBridgedArg<String>(value, 'hint'),
      'attributedHint': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').attributedHint = D4.extractBridgedArg<$flutter_7.AttributedString>(value, 'attributedHint'),
      'tooltip': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').tooltip = D4.extractBridgedArg<String>(value, 'tooltip'),
      'hintOverrides': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hintOverrides = D4.extractBridgedArgOrNull<$flutter_7.SemanticsHintOverrides>(value, 'hintOverrides'),
      'scopesRoute': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scopesRoute = D4.extractBridgedArg<bool>(value, 'scopesRoute'),
      'namesRoute': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').namesRoute = D4.extractBridgedArg<bool>(value, 'namesRoute'),
      'isImage': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isImage = D4.extractBridgedArg<bool>(value, 'isImage'),
      'liveRegion': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').liveRegion = D4.extractBridgedArg<bool>(value, 'liveRegion'),
      'textDirection': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').textDirection = D4.extractBridgedArgOrNull<TextDirection>(value, 'textDirection'),
      'isSelected': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSelected = D4.extractBridgedArg<bool>(value, 'isSelected'),
      'isExpanded': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isExpanded = D4.extractBridgedArgOrNull<bool>(value, 'isExpanded'),
      'isEnabled': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isEnabled = D4.extractBridgedArgOrNull<bool>(value, 'isEnabled'),
      'isChecked': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isChecked = D4.extractBridgedArgOrNull<bool>(value, 'isChecked'),
      'isCheckStateMixed': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isCheckStateMixed = D4.extractBridgedArgOrNull<bool>(value, 'isCheckStateMixed'),
      'isToggled': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isToggled = D4.extractBridgedArgOrNull<bool>(value, 'isToggled'),
      'isInMutuallyExclusiveGroup': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isInMutuallyExclusiveGroup = D4.extractBridgedArg<bool>(value, 'isInMutuallyExclusiveGroup'),
      'isFocusable': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocusable = D4.extractBridgedArg<bool>(value, 'isFocusable'),
      'isFocused': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isFocused = D4.extractBridgedArgOrNull<bool>(value, 'isFocused'),
      'accessibilityFocusBlockType': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').accessibilityFocusBlockType = D4.extractBridgedArg<$flutter_7.AccessibilityFocusBlockType>(value, 'accessibilityFocusBlockType'),
      'isButton': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isButton = D4.extractBridgedArg<bool>(value, 'isButton'),
      'isLink': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isLink = D4.extractBridgedArg<bool>(value, 'isLink'),
      'linkUrl': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').linkUrl = D4.extractBridgedArgOrNull<Uri>(value, 'linkUrl'),
      'isHeader': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHeader = D4.extractBridgedArg<bool>(value, 'isHeader'),
      'headingLevel': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').headingLevel = D4.extractBridgedArg<int>(value, 'headingLevel'),
      'isSlider': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isSlider = D4.extractBridgedArg<bool>(value, 'isSlider'),
      'isKeyboardKey': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isKeyboardKey = D4.extractBridgedArg<bool>(value, 'isKeyboardKey'),
      'isHidden': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isHidden = D4.extractBridgedArg<bool>(value, 'isHidden'),
      'isTextField': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isTextField = D4.extractBridgedArg<bool>(value, 'isTextField'),
      'isReadOnly': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isReadOnly = D4.extractBridgedArg<bool>(value, 'isReadOnly'),
      'isObscured': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isObscured = D4.extractBridgedArg<bool>(value, 'isObscured'),
      'isMultiline': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isMultiline = D4.extractBridgedArg<bool>(value, 'isMultiline'),
      'isRequired': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').isRequired = D4.extractBridgedArgOrNull<bool>(value, 'isRequired'),
      'hasImplicitScrolling': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hasImplicitScrolling = D4.extractBridgedArg<bool>(value, 'hasImplicitScrolling'),
      'textSelection': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').textSelection = D4.extractBridgedArgOrNull<$flutter_10.TextSelection>(value, 'textSelection'),
      'scrollPosition': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollPosition = D4.extractBridgedArgOrNull<double>(value, 'scrollPosition'),
      'scrollExtentMax': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMax = D4.extractBridgedArgOrNull<double>(value, 'scrollExtentMax'),
      'scrollExtentMin': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').scrollExtentMin = D4.extractBridgedArgOrNull<double>(value, 'scrollExtentMin'),
      'controlsNodes': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').controlsNodes = value == null ? null : D4.coerceSet<String>(value, 'controlsNodes'),
      'validationResult': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').validationResult = D4.extractBridgedArg<SemanticsValidationResult>(value, 'validationResult'),
      'hitTestBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').hitTestBehavior = D4.extractBridgedArg<SemanticsHitTestBehavior>(value, 'hitTestBehavior'),
      'inputType': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').inputType = D4.extractBridgedArg<SemanticsInputType>(value, 'inputType'),
      'maxValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').maxValue = D4.extractBridgedArgOrNull<String>(value, 'maxValue'),
      'minValue': (visitor, target, value) => 
        D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration').minValue = D4.extractBridgedArgOrNull<String>(value, 'minValue'),
    },
    methods: {
      'getActionHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'getActionHandler');
        final action = D4.getRequiredArg<SemanticsAction>(positional, 0, 'action', 'getActionHandler');
        return t.getActionHandler(action);
      },
      'tagsChildrenWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'tagsChildrenWith');
        final tag = D4.getRequiredArg<$flutter_7.SemanticsTag>(positional, 0, 'tag', 'tagsChildrenWith');
        return t.tagsChildrenWith(tag);
      },
      'addTagForChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'addTagForChildren');
        final tag = D4.getRequiredArg<$flutter_7.SemanticsTag>(positional, 0, 'tag', 'addTagForChildren');
        t.addTagForChildren(tag);
        return null;
      },
      'isCompatibleWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'isCompatibleWith');
        final other = D4.getRequiredArg<$flutter_7.SemanticsConfiguration?>(positional, 0, 'other', 'isCompatibleWith');
        return t.isCompatibleWith(other);
      },
      'absorb': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration');
        D4.requireMinArgs(positional, 1, 'absorb');
        final child = D4.getRequiredArg<$flutter_7.SemanticsConfiguration>(positional, 0, 'child', 'absorb');
        t.absorb(child);
        return null;
      },
      'copy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsConfiguration>(target, 'SemanticsConfiguration');
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
      'locale': 'Locale? get locale',
      'isBlockingUserActions': 'bool get isBlockingUserActions',
      'explicitChildNodes': 'bool get explicitChildNodes',
      'isBlockingSemanticsOfPreviouslyPaintedNodes': 'bool get isBlockingSemanticsOfPreviouslyPaintedNodes',
      'isSemanticBoundary': 'bool get isSemanticBoundary',
      'localeForSubtree': 'Locale? get localeForSubtree',
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
      'hitTestBehavior': 'SemanticsHitTestBehavior get hitTestBehavior',
      'inputType': 'SemanticsInputType get inputType',
      'maxValue': 'String? get maxValue',
      'minValue': 'String? get minValue',
      'tagsForChildren': 'Iterable<SemanticsTag>? get tagsForChildren',
    },
    setterSignatures: {
      'locale': 'set locale(dynamic value)',
      'isBlockingUserActions': 'set isBlockingUserActions(dynamic value)',
      'explicitChildNodes': 'set explicitChildNodes(dynamic value)',
      'isBlockingSemanticsOfPreviouslyPaintedNodes': 'set isBlockingSemanticsOfPreviouslyPaintedNodes(dynamic value)',
      'isSemanticBoundary': 'set isSemanticBoundary(bool value)',
      'localeForSubtree': 'set localeForSubtree(Locale? value)',
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
      'hitTestBehavior': 'set hitTestBehavior(SemanticsHitTestBehavior value)',
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
    nativeType: $flutter_7.SemanticsSortKey,
    name: 'SemanticsSortKey',
    isAssignable: (v) => v is $flutter_7.SemanticsSortKey,
    hierarchyDepth: 2,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_7.SemanticsSortKey>(target, 'SemanticsSortKey').name,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsSortKey>(target, 'SemanticsSortKey');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_7.SemanticsSortKey>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'doCompare': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsSortKey>(target, 'SemanticsSortKey');
        D4.requireMinArgs(positional, 1, 'doCompare');
        final other = D4.getRequiredArg<$flutter_7.SemanticsSortKey>(positional, 0, 'other', 'doCompare');
        return t.doCompare(other);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsSortKey>(target, 'SemanticsSortKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsSortKey>(target, 'SemanticsSortKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsSortKey>(target, 'SemanticsSortKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.SemanticsSortKey>(target, 'SemanticsSortKey');
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
    nativeType: $flutter_7.OrdinalSortKey,
    name: 'OrdinalSortKey',
    isAssignable: (v) => v is $flutter_7.OrdinalSortKey,
    hierarchyDepth: 3,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OrdinalSortKey');
        final order = D4.getRequiredArg<double>(positional, 0, 'order', 'OrdinalSortKey');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        return $flutter_7.OrdinalSortKey(order, name: name);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey').name,
      'order': (visitor, target) => D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey').order,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$flutter_7.SemanticsSortKey>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      'doCompare': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey');
        D4.requireMinArgs(positional, 1, 'doCompare');
        final other = D4.getRequiredArg<$flutter_7.OrdinalSortKey>(positional, 0, 'other', 'doCompare');
        return t.doCompare(other);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_3.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey');
        final minLevel = D4.getNamedArgWithDefault<$flutter_3.DiagnosticLevel>(named, 'minLevel', $flutter_3.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_7.OrdinalSortKey>(target, 'OrdinalSortKey');
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
    nativeType: $flutter_9.SemanticsService,
    name: 'SemanticsService',
    isAssignable: (v) => v is $flutter_9.SemanticsService,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'announce': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'announce');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'announce');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 1, 'textDirection', 'announce');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_8.Assertiveness>(named, 'assertiveness', $flutter_8.Assertiveness.polite);
        return $flutter_9.SemanticsService.announce(message, textDirection, assertiveness: assertiveness);
      },
      'sendAnnouncement': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'sendAnnouncement');
        final view = D4.getRequiredArg<FlutterView>(positional, 0, 'view', 'sendAnnouncement');
        final message = D4.getRequiredArg<String>(positional, 1, 'message', 'sendAnnouncement');
        final textDirection = D4.getRequiredArg<TextDirection>(positional, 2, 'textDirection', 'sendAnnouncement');
        final assertiveness = D4.getNamedArgWithDefault<$flutter_8.Assertiveness>(named, 'assertiveness', $flutter_8.Assertiveness.polite);
        return $flutter_9.SemanticsService.sendAnnouncement(view, message, textDirection, assertiveness: assertiveness);
      },
      'tooltip': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'tooltip');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'tooltip');
        return $flutter_9.SemanticsService.tooltip(message);
      },
    },
    staticMethodSignatures: {
      'announce': 'Future<void> announce(String message, TextDirection textDirection, {Assertiveness assertiveness = Assertiveness.polite})',
      'sendAnnouncement': 'Future<void> sendAnnouncement(FlutterView view, String message, TextDirection textDirection, {Assertiveness assertiveness = Assertiveness.polite})',
      'tooltip': 'Future<void> tooltip(String message)',
    },
  );
}

