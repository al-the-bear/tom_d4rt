// D4rt Bridge - Generated file, do not edit
// Sources: 27 files
// Generated: 2026-06-14T13:48:41.729494

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member, unnecessary_cast, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_is_empty, unnecessary_question_mark, unreachable_switch_case, unintended_html_in_doc_comment, empty_constructor_bodies, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_call_super, no_logic_in_create_state, use_key_in_widget_constructors, annotate_overrides, unnecessary_import

import 'package:tom_d4rt/d4rt.dart';
import 'dart:async';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/foundation/assertions.dart' as $flutter_1;
import 'package:flutter/src/foundation/basic_types.dart' as $flutter_2;
import 'package:flutter/src/foundation/binding.dart' as $flutter_3;
import 'package:flutter/src/foundation/diagnostics.dart' as $flutter_4;
import 'package:flutter/src/gestures/arena.dart' as $flutter_5;
import 'package:flutter/src/gestures/binding.dart' as $flutter_6;
import 'package:flutter/src/gestures/constants.dart' as $flutter_7;
import 'package:flutter/src/gestures/converter.dart' as $flutter_8;
import 'package:flutter/src/gestures/debug.dart' as $flutter_9;
import 'package:flutter/src/gestures/drag.dart' as $flutter_10;
import 'package:flutter/src/gestures/drag_details.dart' as $flutter_11;
import 'package:flutter/src/gestures/eager.dart' as $flutter_12;
import 'package:flutter/src/gestures/events.dart' as $flutter_13;
import 'package:flutter/src/gestures/force_press.dart' as $flutter_14;
import 'package:flutter/src/gestures/gesture_details.dart' as $flutter_15;
import 'package:flutter/src/gestures/gesture_settings.dart' as $flutter_16;
import 'package:flutter/src/gestures/hit_test.dart' as $flutter_17;
import 'package:flutter/src/gestures/long_press.dart' as $flutter_18;
import 'package:flutter/src/gestures/lsq_solver.dart' as $flutter_19;
import 'package:flutter/src/gestures/monodrag.dart' as $flutter_20;
import 'package:flutter/src/gestures/multidrag.dart' as $flutter_21;
import 'package:flutter/src/gestures/multitap.dart' as $flutter_22;
import 'package:flutter/src/gestures/pointer_router.dart' as $flutter_23;
import 'package:flutter/src/gestures/pointer_signal_resolver.dart' as $flutter_24;
import 'package:flutter/src/gestures/recognizer.dart' as $flutter_25;
import 'package:flutter/src/gestures/resampler.dart' as $flutter_26;
import 'package:flutter/src/gestures/scale.dart' as $flutter_27;
import 'package:flutter/src/gestures/tap.dart' as $flutter_28;
import 'package:flutter/src/gestures/tap_and_drag.dart' as $flutter_29;
import 'package:flutter/src/gestures/team.dart' as $flutter_30;
import 'package:flutter/src/gestures/velocity_tracker.dart' as $flutter_31;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart' as $tom_d4rt_flutter_1;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/state_user_bridge.dart' as $tom_d4rt_flutter_2;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/strut_style_user_bridge.dart' as $tom_d4rt_flutter_3;
import 'package:tom_d4rt_flutter/src/d4rt_user_bridges/text_user_bridge.dart' as $tom_d4rt_flutter_4;
import 'package:vector_math/vector_math_64.dart' as $vector_math_1;

/// Bridge class for flutter_gestures module.
class FlutterGesturesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createGestureArenaMemberBridge(),
      _createGestureArenaEntryBridge(),
      _createGestureArenaManagerBridge(),
      _createDeviceGestureSettingsBridge(),
      _createPointerAddedEventBridge(),
      _createPointerRemovedEventBridge(),
      _createPointerHoverEventBridge(),
      _createPointerEnterEventBridge(),
      _createPointerExitEventBridge(),
      _createPointerDownEventBridge(),
      _createPointerMoveEventBridge(),
      _createPointerUpEventBridge(),
      _createPointerSignalEventBridge(),
      _createPointerScrollEventBridge(),
      _createPointerScrollInertiaCancelEventBridge(),
      _createPointerScaleEventBridge(),
      _createPointerPanZoomStartEventBridge(),
      _createPointerPanZoomUpdateEventBridge(),
      _createPointerPanZoomEndEventBridge(),
      _createPointerCancelEventBridge(),
      _createHitTestableBridge(),
      _createHitTestDispatcherBridge(),
      _createHitTestTargetBridge(),
      _createHitTestEntryBridge(),
      _createHitTestResultBridge(),
      _createPointerRouterBridge(),
      _createPointerSignalResolverBridge(),
      _createSamplingClockBridge(),
      _createFlutterErrorDetailsForPointerEventDispatcherBridge(),
      _createGestureBindingBridge(),
      _createPointerEventConverterBridge(),
      _createVelocityBridge(),
      _createVelocityEstimateBridge(),
      _createVelocityTrackerBridge(),
      _createIOSScrollViewFlingVelocityTrackerBridge(),
      _createMacOSScrollViewFlingVelocityTrackerBridge(),
      _createDragDownDetailsBridge(),
      _createDragStartDetailsBridge(),
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
      _createGestureRecognizerBridge(),
      _createOneSequenceGestureRecognizerBridge(),
      _createPrimaryPointerGestureRecognizerBridge(),
      _createOffsetPairBridge(),
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
      _createTapMoveDetailsBridge(),
      _createBaseTapGestureRecognizerBridge(),
      _createTapGestureRecognizerBridge(),
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
      'DeviceGestureSettings': 'package:flutter/src/gestures/gesture_settings.dart',
      'PointerAddedEvent': 'package:flutter/src/gestures/events.dart',
      'PointerRemovedEvent': 'package:flutter/src/gestures/events.dart',
      'PointerHoverEvent': 'package:flutter/src/gestures/events.dart',
      'PointerEnterEvent': 'package:flutter/src/gestures/events.dart',
      'PointerExitEvent': 'package:flutter/src/gestures/events.dart',
      'PointerDownEvent': 'package:flutter/src/gestures/events.dart',
      'PointerMoveEvent': 'package:flutter/src/gestures/events.dart',
      'PointerUpEvent': 'package:flutter/src/gestures/events.dart',
      'PointerSignalEvent': 'package:flutter/src/gestures/events.dart',
      'PointerScrollEvent': 'package:flutter/src/gestures/events.dart',
      'PointerScrollInertiaCancelEvent': 'package:flutter/src/gestures/events.dart',
      'PointerScaleEvent': 'package:flutter/src/gestures/events.dart',
      'PointerPanZoomStartEvent': 'package:flutter/src/gestures/events.dart',
      'PointerPanZoomUpdateEvent': 'package:flutter/src/gestures/events.dart',
      'PointerPanZoomEndEvent': 'package:flutter/src/gestures/events.dart',
      'PointerCancelEvent': 'package:flutter/src/gestures/events.dart',
      'HitTestable': 'package:flutter/src/gestures/hit_test.dart',
      'HitTestDispatcher': 'package:flutter/src/gestures/hit_test.dart',
      'HitTestTarget': 'package:flutter/src/gestures/hit_test.dart',
      'HitTestEntry': 'package:flutter/src/gestures/hit_test.dart',
      'HitTestResult': 'package:flutter/src/gestures/hit_test.dart',
      'PointerRouter': 'package:flutter/src/gestures/pointer_router.dart',
      'PointerSignalResolver': 'package:flutter/src/gestures/pointer_signal_resolver.dart',
      'SamplingClock': 'package:flutter/src/gestures/binding.dart',
      'FlutterErrorDetailsForPointerEventDispatcher': 'package:flutter/src/gestures/binding.dart',
      'GestureBinding': 'package:flutter/src/gestures/binding.dart',
      'PointerEventConverter': 'package:flutter/src/gestures/converter.dart',
      'Velocity': 'package:flutter/src/gestures/velocity_tracker.dart',
      'VelocityEstimate': 'package:flutter/src/gestures/velocity_tracker.dart',
      'VelocityTracker': 'package:flutter/src/gestures/velocity_tracker.dart',
      'IOSScrollViewFlingVelocityTracker': 'package:flutter/src/gestures/velocity_tracker.dart',
      'MacOSScrollViewFlingVelocityTracker': 'package:flutter/src/gestures/velocity_tracker.dart',
      'DragDownDetails': 'package:flutter/src/gestures/drag_details.dart',
      'DragStartDetails': 'package:flutter/src/gestures/drag_details.dart',
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
      'GestureRecognizer': 'package:flutter/src/gestures/recognizer.dart',
      'OneSequenceGestureRecognizer': 'package:flutter/src/gestures/recognizer.dart',
      'PrimaryPointerGestureRecognizer': 'package:flutter/src/gestures/recognizer.dart',
      'OffsetPair': 'package:flutter/src/gestures/recognizer.dart',
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
      'TapMoveDetails': 'package:flutter/src/gestures/tap.dart',
      'BaseTapGestureRecognizer': 'package:flutter/src/gestures/tap.dart',
      'TapGestureRecognizer': 'package:flutter/src/gestures/tap.dart',
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
      'PointerAddedEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerAddedEvent'],
      'PointerRemovedEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerRemovedEvent'],
      'PointerHoverEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerHoverEvent'],
      'PointerEnterEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerEnterEvent'],
      'PointerExitEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerExitEvent'],
      'PointerDownEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerDownEvent'],
      'PointerMoveEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerMoveEvent'],
      'PointerUpEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerUpEvent'],
      'PointerSignalEvent': ['PointerEvent', 'Diagnosticable', '_RespondablePointerEvent'],
      'PointerScrollEvent': ['PointerSignalEvent', 'PointerEvent', 'Diagnosticable', '_RespondablePointerEvent', '_PointerEventDescription', '_CopyPointerScrollEvent'],
      'PointerScrollInertiaCancelEvent': ['PointerSignalEvent', 'PointerEvent', 'Diagnosticable', '_RespondablePointerEvent', '_PointerEventDescription', '_CopyPointerScrollInertiaCancelEvent'],
      'PointerScaleEvent': ['PointerSignalEvent', 'PointerEvent', 'Diagnosticable', '_RespondablePointerEvent', '_PointerEventDescription', '_CopyPointerScaleEvent'],
      'PointerPanZoomStartEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerPanZoomStartEvent'],
      'PointerPanZoomUpdateEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerPanZoomUpdateEvent'],
      'PointerPanZoomEndEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerPanZoomEndEvent'],
      'PointerCancelEvent': ['PointerEvent', 'Diagnosticable', '_PointerEventDescription', '_CopyPointerCancelEvent'],
      'FlutterErrorDetailsForPointerEventDispatcher': ['FlutterErrorDetails', 'Diagnosticable'],
      'GestureBinding': ['BindingBase', 'HitTestable', 'HitTestDispatcher', 'HitTestTarget'],
      'IOSScrollViewFlingVelocityTracker': ['VelocityTracker'],
      'MacOSScrollViewFlingVelocityTracker': ['IOSScrollViewFlingVelocityTracker', 'VelocityTracker'],
      'DragDownDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'DragStartDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'DragUpdateDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'DragEndDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'EagerGestureRecognizer': ['OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'ForcePressDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'ForcePressGestureRecognizer': ['OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'LongPressDownDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'LongPressStartDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'LongPressMoveUpdateDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'LongPressEndDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'LongPressGestureRecognizer': ['PrimaryPointerGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'GestureRecognizer': ['GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'OneSequenceGestureRecognizer': ['GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'PrimaryPointerGestureRecognizer': ['OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'DragGestureRecognizer': ['OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'VerticalDragGestureRecognizer': ['DragGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'HorizontalDragGestureRecognizer': ['DragGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'PanGestureRecognizer': ['DragGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'MultiDragGestureRecognizer': ['GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'ImmediateMultiDragGestureRecognizer': ['MultiDragGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'HorizontalMultiDragGestureRecognizer': ['MultiDragGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'VerticalMultiDragGestureRecognizer': ['MultiDragGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'DelayedMultiDragGestureRecognizer': ['MultiDragGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'TapDownDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'TapUpDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'BaseTapGestureRecognizer': ['PrimaryPointerGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'TapGestureRecognizer': ['BaseTapGestureRecognizer', 'PrimaryPointerGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'DoubleTapGestureRecognizer': ['GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'MultiTapGestureRecognizer': ['GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'SerialTapDownDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'SerialTapCancelDetails': ['Diagnosticable'],
      'SerialTapUpDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'SerialTapGestureRecognizer': ['GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'ScaleStartDetails': ['Diagnosticable'],
      'ScaleUpdateDetails': ['Diagnosticable'],
      'ScaleEndDetails': ['Diagnosticable'],
      'ScaleGestureRecognizer': ['OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable'],
      'TapDragDownDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'TapDragUpDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'TapDragStartDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'TapDragUpdateDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'TapDragEndDetails': ['PositionedGestureDetails', 'Diagnosticable'],
      'BaseTapAndDragGestureRecognizer': ['OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable', '_TapStatusTrackerMixin'],
      'TapAndHorizontalDragGestureRecognizer': ['BaseTapAndDragGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable', '_TapStatusTrackerMixin'],
      'TapAndPanGestureRecognizer': ['BaseTapAndDragGestureRecognizer', 'OneSequenceGestureRecognizer', 'GestureRecognizer', 'GestureArenaMember', 'DiagnosticableTreeMixin', 'DiagnosticableTree', 'Diagnosticable', '_TapStatusTrackerMixin'],
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
      'RespondPointerEventCallback',
      'PointerRoute',
      'PointerSignalResolvedCallback',
      'InformationCollector',
      'IterableFilter',
      'AsyncCallback',
      'AsyncValueGetter',
      'AsyncValueSetter',
      'ServiceExtensionCallback',
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
      'VoidCallback',
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_5.GestureDisposition>(
        name: 'GestureDisposition',
        values: $flutter_5.GestureDisposition.values,
      ),
      BridgedEnumDefinition<$flutter_25.DragStartBehavior>(
        name: 'DragStartBehavior',
        values: $flutter_25.DragStartBehavior.values,
      ),
      BridgedEnumDefinition<$flutter_25.MultitouchDragStrategy>(
        name: 'MultitouchDragStrategy',
        values: $flutter_25.MultitouchDragStrategy.values,
      ),
      BridgedEnumDefinition<$flutter_25.GestureRecognizerState>(
        name: 'GestureRecognizerState',
        values: $flutter_25.GestureRecognizerState.values,
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
      'MultitouchDragStrategy': 'package:flutter/src/gestures/recognizer.dart',
      'GestureRecognizerState': 'package:flutter/src/gestures/recognizer.dart',
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
      interpreter.registerGlobalVariable('kPrimaryButton', $flutter_13.kPrimaryButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrimaryButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kSecondaryButton', $flutter_13.kSecondaryButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kSecondaryButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrimaryMouseButton', $flutter_13.kPrimaryMouseButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrimaryMouseButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kSecondaryMouseButton', $flutter_13.kSecondaryMouseButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kSecondaryMouseButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kStylusContact', $flutter_13.kStylusContact, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kStylusContact": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrimaryStylusButton', $flutter_13.kPrimaryStylusButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrimaryStylusButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kTertiaryButton', $flutter_13.kTertiaryButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kTertiaryButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMiddleMouseButton', $flutter_13.kMiddleMouseButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMiddleMouseButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kSecondaryStylusButton', $flutter_13.kSecondaryStylusButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kSecondaryStylusButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kBackMouseButton', $flutter_13.kBackMouseButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kBackMouseButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kForwardMouseButton', $flutter_13.kForwardMouseButton, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kForwardMouseButton": $e');
    }
    try {
      interpreter.registerGlobalVariable('kTouchContact', $flutter_13.kTouchContact, importPath, sourceUri: 'package:flutter/src/gestures/events.dart');
    } catch (e) {
      errors.add('Failed to register variable "kTouchContact": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPressTimeout', $flutter_7.kPressTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPressTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kHoverTapTimeout', $flutter_7.kHoverTapTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kHoverTapTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kHoverTapSlop', $flutter_7.kHoverTapSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kHoverTapSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kLongPressTimeout', $flutter_7.kLongPressTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kLongPressTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapTimeout', $flutter_7.kDoubleTapTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapMinTime', $flutter_7.kDoubleTapMinTime, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapMinTime": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapTouchSlop', $flutter_7.kDoubleTapTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDoubleTapSlop', $flutter_7.kDoubleTapSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDoubleTapSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kZoomControlsTimeout', $flutter_7.kZoomControlsTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kZoomControlsTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kTouchSlop', $flutter_7.kTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPagingTouchSlop', $flutter_7.kPagingTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPagingTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPanSlop', $flutter_7.kPanSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPanSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kScaleSlop', $flutter_7.kScaleSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kScaleSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kWindowTouchSlop', $flutter_7.kWindowTouchSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kWindowTouchSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMinFlingVelocity', $flutter_7.kMinFlingVelocity, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMinFlingVelocity": $e');
    }
    try {
      interpreter.registerGlobalVariable('kMaxFlingVelocity', $flutter_7.kMaxFlingVelocity, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kMaxFlingVelocity": $e');
    }
    try {
      interpreter.registerGlobalVariable('kJumpTapTimeout', $flutter_7.kJumpTapTimeout, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kJumpTapTimeout": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrecisePointerHitSlop', $flutter_7.kPrecisePointerHitSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrecisePointerHitSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrecisePointerPanSlop', $flutter_7.kPrecisePointerPanSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrecisePointerPanSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('kPrecisePointerScaleSlop', $flutter_7.kPrecisePointerScaleSlop, importPath, sourceUri: 'package:flutter/src/gestures/constants.dart');
    } catch (e) {
      errors.add('Failed to register variable "kPrecisePointerScaleSlop": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintHitTestResults', $flutter_9.debugPrintHitTestResults, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintHitTestResults": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintMouseHoverEvents', $flutter_9.debugPrintMouseHoverEvents, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintMouseHoverEvents": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintGestureArenaDiagnostics', $flutter_9.debugPrintGestureArenaDiagnostics, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintGestureArenaDiagnostics": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintRecognizerCallbacksTrace', $flutter_9.debugPrintRecognizerCallbacksTrace, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintRecognizerCallbacksTrace": $e');
    }
    try {
      interpreter.registerGlobalVariable('debugPrintResamplingMargin', $flutter_9.debugPrintResamplingMargin, importPath, sourceUri: 'package:flutter/src/gestures/debug.dart');
    } catch (e) {
      errors.add('Failed to register variable "debugPrintResamplingMargin": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDefaultMouseScrollToScaleFactor', $flutter_27.kDefaultMouseScrollToScaleFactor, importPath, sourceUri: 'package:flutter/src/gestures/scale.dart');
    } catch (e) {
      errors.add('Failed to register variable "kDefaultMouseScrollToScaleFactor": $e');
    }
    try {
      interpreter.registerGlobalVariable('kDefaultTrackpadScrollToScaleFactor', $flutter_27.kDefaultTrackpadScrollToScaleFactor, importPath, sourceUri: 'package:flutter/src/gestures/scale.dart');
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
      'nthMouseButton': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'nthMouseButton');
        final number = D4.getRequiredArg<int>(positional, 0, 'number', 'nthMouseButton');
        return $flutter_13.nthMouseButton(number);
      },
      'nthStylusButton': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'nthStylusButton');
        final number = D4.getRequiredArg<int>(positional, 0, 'number', 'nthStylusButton');
        return $flutter_13.nthStylusButton(number);
      },
      'smallestButton': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'smallestButton');
        final buttons = D4.getRequiredArg<int>(positional, 0, 'buttons', 'smallestButton');
        return $flutter_13.smallestButton(buttons);
      },
      'isSingleButton': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isSingleButton');
        final buttons = D4.getRequiredArg<int>(positional, 0, 'buttons', 'isSingleButton');
        return $flutter_13.isSingleButton(buttons);
      },
      'computeHitSlop': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'computeHitSlop');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'kind', 'computeHitSlop');
        final settings = D4.getRequiredArg<$flutter_16.DeviceGestureSettings?>(positional, 1, 'settings', 'computeHitSlop');
        return $flutter_13.computeHitSlop(kind, settings);
      },
      'computePanSlop': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'computePanSlop');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'kind', 'computePanSlop');
        final settings = D4.getRequiredArg<$flutter_16.DeviceGestureSettings?>(positional, 1, 'settings', 'computePanSlop');
        return $flutter_13.computePanSlop(kind, settings);
      },
      'computeScaleSlop': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'computeScaleSlop');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'kind', 'computeScaleSlop');
        return $flutter_13.computeScaleSlop(kind);
      },
      'debugAssertAllGesturesVarsUnset': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'debugAssertAllGesturesVarsUnset');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'debugAssertAllGesturesVarsUnset');
        return $flutter_9.debugAssertAllGesturesVarsUnset(reason);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'nthMouseButton': 'package:flutter/src/gestures/events.dart',
      'nthStylusButton': 'package:flutter/src/gestures/events.dart',
      'smallestButton': 'package:flutter/src/gestures/events.dart',
      'isSingleButton': 'package:flutter/src/gestures/events.dart',
      'computeHitSlop': 'package:flutter/src/gestures/events.dart',
      'computePanSlop': 'package:flutter/src/gestures/events.dart',
      'computeScaleSlop': 'package:flutter/src/gestures/events.dart',
      'debugAssertAllGesturesVarsUnset': 'package:flutter/src/gestures/debug.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'nthMouseButton': 'int nthMouseButton(int number)',
      'nthStylusButton': 'int nthStylusButton(int number)',
      'smallestButton': 'int smallestButton(int buttons)',
      'isSingleButton': 'bool isSingleButton(int buttons)',
      'computeHitSlop': 'double computeHitSlop(PointerDeviceKind kind, DeviceGestureSettings? settings)',
      'computePanSlop': 'double computePanSlop(PointerDeviceKind kind, DeviceGestureSettings? settings)',
      'computeScaleSlop': 'double computeScaleSlop(PointerDeviceKind kind)',
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
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:flutter/gestures.dart';";
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
    'GestureDisposition',
    'DragStartBehavior',
    'MultitouchDragStrategy',
    'GestureRecognizerState',
  ];

}

// =============================================================================
// GestureArenaMember Bridge
// =============================================================================

BridgedClass _createGestureArenaMemberBridge() {
  return BridgedClass(
    nativeType: $flutter_5.GestureArenaMember,
    name: 'GestureArenaMember',
    isAssignable: (v) => v is $flutter_5.GestureArenaMember,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaMember>(target, 'GestureArenaMember');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaMember>(target, 'GestureArenaMember');
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
    nativeType: $flutter_5.GestureArenaEntry,
    name: 'GestureArenaEntry',
    isAssignable: (v) => v is $flutter_5.GestureArenaEntry,
    constructors: {
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaEntry>(target, 'GestureArenaEntry');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
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
    nativeType: $flutter_5.GestureArenaManager,
    name: 'GestureArenaManager',
    isAssignable: (v) => v is $flutter_5.GestureArenaManager,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_5.GestureArenaManager();
      },
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 2, 'add');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'add');
        final member = D4.getRequiredArg<$flutter_5.GestureArenaMember>(positional, 1, 'member', 'add');
        return t.add(pointer, member);
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 1, 'close');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'close');
        t.close(pointer);
        return null;
      },
      'sweep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 1, 'sweep');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'sweep');
        t.sweep(pointer);
        return null;
      },
      'hold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaManager>(target, 'GestureArenaManager');
        D4.requireMinArgs(positional, 1, 'hold');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'hold');
        t.hold(pointer);
        return null;
      },
      'release': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.GestureArenaManager>(target, 'GestureArenaManager');
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
// DeviceGestureSettings Bridge
// =============================================================================

BridgedClass _createDeviceGestureSettingsBridge() {
  return BridgedClass(
    nativeType: $flutter_16.DeviceGestureSettings,
    name: 'DeviceGestureSettings',
    isAssignable: (v) => v is $flutter_16.DeviceGestureSettings,
    constructors: {
      '': (visitor, positional, named) {
        final touchSlop = D4.getOptionalNamedArg<double?>(named, 'touchSlop');
        return $flutter_16.DeviceGestureSettings(touchSlop: touchSlop);
      },
      'fromView': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DeviceGestureSettings');
        final view = D4.getRequiredArg<FlutterView>(positional, 0, 'view', 'DeviceGestureSettings');
        return $flutter_16.DeviceGestureSettings.fromView(view);
      },
    },
    getters: {
      'touchSlop': (visitor, target) => D4.validateTarget<$flutter_16.DeviceGestureSettings>(target, 'DeviceGestureSettings').touchSlop,
      'panSlop': (visitor, target) => D4.validateTarget<$flutter_16.DeviceGestureSettings>(target, 'DeviceGestureSettings').panSlop,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_16.DeviceGestureSettings>(target, 'DeviceGestureSettings').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.DeviceGestureSettings>(target, 'DeviceGestureSettings');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_16.DeviceGestureSettings>(target, 'DeviceGestureSettings');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const DeviceGestureSettings({double? touchSlop})',
      'fromView': 'factory DeviceGestureSettings.fromView(FlutterView view)',
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
// PointerAddedEvent Bridge
// =============================================================================

BridgedClass _createPointerAddedEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerAddedEvent,
    name: 'PointerAddedEvent',
    isAssignable: (v) => v is $flutter_13.PointerAddedEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final obscured = D4.getNamedArgWithDefault<bool>(named, 'obscured', false);
        final pressureMin = D4.getNamedArgWithDefault<double>(named, 'pressureMin', 1.0);
        final pressureMax = D4.getNamedArgWithDefault<double>(named, 'pressureMax', 1.0);
        final distance = D4.getNamedArgWithDefault<double>(named, 'distance', 0.0);
        final distanceMax = D4.getNamedArgWithDefault<double>(named, 'distanceMax', 0.0);
        final radiusMin = D4.getNamedArgWithDefault<double>(named, 'radiusMin', 0.0);
        final radiusMax = D4.getNamedArgWithDefault<double>(named, 'radiusMax', 0.0);
        final orientation = D4.getNamedArgWithDefault<double>(named, 'orientation', 0.0);
        final tilt = D4.getNamedArgWithDefault<double>(named, 'tilt', 0.0);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_13.PointerAddedEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, obscured: obscured, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerAddedEvent>(target, 'PointerAddedEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerAddedEvent({int viewId = 0, Duration timeStamp = Duration.zero, int pointer = 0, PointerDeviceKind kind = PointerDeviceKind.touch, int device = 0, Offset position = Offset.zero, bool obscured = false, double pressureMin = 1.0, double pressureMax = 1.0, double distance = 0.0, double distanceMax = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerAddedEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerAddedEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerRemovedEvent Bridge
// =============================================================================

BridgedClass _createPointerRemovedEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerRemovedEvent,
    name: 'PointerRemovedEvent',
    isAssignable: (v) => v is $flutter_13.PointerRemovedEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final obscured = D4.getNamedArgWithDefault<bool>(named, 'obscured', false);
        final pressureMin = D4.getNamedArgWithDefault<double>(named, 'pressureMin', 1.0);
        final pressureMax = D4.getNamedArgWithDefault<double>(named, 'pressureMax', 1.0);
        final distanceMax = D4.getNamedArgWithDefault<double>(named, 'distanceMax', 0.0);
        final radiusMin = D4.getNamedArgWithDefault<double>(named, 'radiusMin', 0.0);
        final radiusMax = D4.getNamedArgWithDefault<double>(named, 'radiusMax', 0.0);
        final original = D4.getOptionalNamedArg<$flutter_13.PointerRemovedEvent?>(named, 'original');
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_13.PointerRemovedEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, obscured: obscured, pressureMin: pressureMin, pressureMax: pressureMax, distanceMax: distanceMax, radiusMin: radiusMin, radiusMax: radiusMax, original: original, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerRemovedEvent>(target, 'PointerRemovedEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerRemovedEvent({int viewId = 0, Duration timeStamp = Duration.zero, int pointer = 0, PointerDeviceKind kind = PointerDeviceKind.touch, int device = 0, Offset position = Offset.zero, bool obscured = false, double pressureMin = 1.0, double pressureMax = 1.0, double distanceMax = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, PointerRemovedEvent? original, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerRemovedEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerRemovedEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerHoverEvent Bridge
// =============================================================================

BridgedClass _createPointerHoverEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerHoverEvent,
    name: 'PointerHoverEvent',
    isAssignable: (v) => v is $flutter_13.PointerHoverEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
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
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_13.PointerHoverEvent(viewId: viewId, timeStamp: timeStamp, kind: kind, pointer: pointer, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerHoverEvent>(target, 'PointerHoverEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerHoverEvent({int viewId = 0, Duration timeStamp = Duration.zero, PointerDeviceKind kind = PointerDeviceKind.touch, int pointer = 0, int device = 0, Offset position = Offset.zero, Offset delta = Offset.zero, int buttons = 0, bool obscured = false, double pressureMin = 1.0, double pressureMax = 1.0, double distance = 0.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, bool synthesized = false, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerHoverEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerHoverEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerEnterEvent Bridge
// =============================================================================

BridgedClass _createPointerEnterEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerEnterEvent,
    name: 'PointerEnterEvent',
    isAssignable: (v) => v is $flutter_13.PointerEnterEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
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
        final down = D4.getNamedArgWithDefault<bool>(named, 'down', false);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_13.PointerEnterEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, down: down, synthesized: synthesized, embedderId: embedderId);
      },
      'fromMouseEvent': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PointerEnterEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'PointerEnterEvent');
        return $flutter_13.PointerEnterEvent.fromMouseEvent(event);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerEnterEvent>(target, 'PointerEnterEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerEnterEvent({int viewId = 0, Duration timeStamp = Duration.zero, int pointer = 0, PointerDeviceKind kind = PointerDeviceKind.touch, int device = 0, Offset position = Offset.zero, Offset delta = Offset.zero, int buttons = 0, bool obscured = false, double pressureMin = 1.0, double pressureMax = 1.0, double distance = 0.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, bool down = false, bool synthesized = false, int embedderId = 0})',
      'fromMouseEvent': 'factory PointerEnterEvent.fromMouseEvent(PointerEvent event)',
    },
    methodSignatures: {
      'transformed': 'PointerEnterEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerEnterEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerExitEvent Bridge
// =============================================================================

BridgedClass _createPointerExitEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerExitEvent,
    name: 'PointerExitEvent',
    isAssignable: (v) => v is $flutter_13.PointerExitEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
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
        final down = D4.getNamedArgWithDefault<bool>(named, 'down', false);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_13.PointerExitEvent(viewId: viewId, timeStamp: timeStamp, kind: kind, pointer: pointer, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, down: down, synthesized: synthesized, embedderId: embedderId);
      },
      'fromMouseEvent': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PointerExitEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'PointerExitEvent');
        return $flutter_13.PointerExitEvent.fromMouseEvent(event);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerExitEvent>(target, 'PointerExitEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerExitEvent({int viewId = 0, Duration timeStamp = Duration.zero, PointerDeviceKind kind = PointerDeviceKind.touch, int pointer = 0, int device = 0, Offset position = Offset.zero, Offset delta = Offset.zero, int buttons = 0, bool obscured = false, double pressureMin = 1.0, double pressureMax = 1.0, double distance = 0.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, bool down = false, bool synthesized = false, int embedderId = 0})',
      'fromMouseEvent': 'factory PointerExitEvent.fromMouseEvent(PointerEvent event)',
    },
    methodSignatures: {
      'transformed': 'PointerExitEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerExitEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerDownEvent Bridge
// =============================================================================

BridgedClass _createPointerDownEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerDownEvent,
    name: 'PointerDownEvent',
    isAssignable: (v) => v is $flutter_13.PointerDownEvent,
    hierarchyDepth: 4,
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
          return $flutter_13.PointerDownEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId);
        }
        if (named.containsKey('buttons')) {
          final buttons = D4.getRequiredNamedArg<int>(named, 'buttons', 'PointerDownEvent');
          return $flutter_13.PointerDownEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId, buttons: buttons);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerDownEvent>(target, 'PointerDownEvent');
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerMoveEvent Bridge
// =============================================================================

BridgedClass _createPointerMoveEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerMoveEvent,
    name: 'PointerMoveEvent',
    isAssignable: (v) => v is $flutter_13.PointerMoveEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.touch);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
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
        final platformData = D4.getNamedArgWithDefault<int>(named, 'platformData', 0);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        if (!named.containsKey('buttons')) {
          return $flutter_13.PointerMoveEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, platformData: platformData, synthesized: synthesized, embedderId: embedderId);
        }
        if (named.containsKey('buttons')) {
          final buttons = D4.getRequiredNamedArg<int>(named, 'buttons', 'PointerMoveEvent');
          return $flutter_13.PointerMoveEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, platformData: platformData, synthesized: synthesized, embedderId: embedderId, buttons: buttons);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerMoveEvent>(target, 'PointerMoveEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerMoveEvent({int viewId = 0, Duration timeStamp = Duration.zero, int pointer = 0, PointerDeviceKind kind = PointerDeviceKind.touch, int device = 0, Offset position = Offset.zero, Offset delta = Offset.zero, int buttons = kPrimaryButton, bool obscured = false, double pressure = 1.0, double pressureMin = 1.0, double pressureMax = 1.0, double distanceMax = 0.0, double size = 0.0, double radiusMajor = 0.0, double radiusMinor = 0.0, double radiusMin = 0.0, double radiusMax = 0.0, double orientation = 0.0, double tilt = 0.0, int platformData = 0, bool synthesized = false, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerMoveEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerMoveEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerUpEvent Bridge
// =============================================================================

BridgedClass _createPointerUpEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerUpEvent,
    name: 'PointerUpEvent',
    isAssignable: (v) => v is $flutter_13.PointerUpEvent,
    hierarchyDepth: 4,
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
        return $flutter_13.PointerUpEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerUpEvent>(target, 'PointerUpEvent');
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerSignalEvent Bridge
// =============================================================================

BridgedClass _createPointerSignalEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerSignalEvent,
    name: 'PointerSignalEvent',
    isAssignable: (v) => v is $flutter_13.PointerSignalEvent,
    hierarchyDepth: 3,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'respond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerSignalEvent>(target, 'PointerSignalEvent');
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
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerScrollEvent Bridge
// =============================================================================

BridgedClass _createPointerScrollEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerScrollEvent,
    name: 'PointerScrollEvent',
    isAssignable: (v) => v is $flutter_13.PointerScrollEvent,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.mouse);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final scrollDelta = D4.getNamedArgWithDefault<Offset>(named, 'scrollDelta', $dart_ui.Offset.zero);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        final onRespondRaw = named['onRespond'];
        return $flutter_13.PointerScrollEvent(viewId: viewId, timeStamp: timeStamp, kind: kind, device: device, position: position, scrollDelta: scrollDelta, embedderId: embedderId, onRespond: onRespondRaw == null ? null : ({required bool allowPlatformDefault}) { D4.callInterpreterCallback(visitor!, onRespondRaw, [], {'allowPlatformDefault': allowPlatformDefault}); });
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').distanceMin,
      'scrollDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent').scrollDelta,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
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
        final onRespondRaw = named['onRespond'];
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId, onRespond: onRespondRaw == null ? null : ({required bool allowPlatformDefault}) { D4.callInterpreterCallback(visitor!, onRespondRaw, [], {'allowPlatformDefault': allowPlatformDefault}); });
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'respond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
        final allowPlatformDefault = D4.getRequiredNamedArg<bool>(named, 'allowPlatformDefault', 'respond');
        t.respond(allowPlatformDefault: allowPlatformDefault);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollEvent>(target, 'PointerScrollEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerScrollEvent({int viewId = 0, Duration timeStamp = Duration.zero, PointerDeviceKind kind = PointerDeviceKind.mouse, int device = 0, Offset position = Offset.zero, Offset scrollDelta = Offset.zero, int embedderId = 0, RespondPointerEventCallback? onRespond})',
    },
    methodSignatures: {
      'transformed': 'PointerScrollEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerScrollEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId, RespondPointerEventCallback? onRespond})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'respond': 'void respond({required bool allowPlatformDefault})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
      'scrollDelta': 'Offset get scrollDelta',
    },
  );
}

// =============================================================================
// PointerScrollInertiaCancelEvent Bridge
// =============================================================================

BridgedClass _createPointerScrollInertiaCancelEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerScrollInertiaCancelEvent,
    name: 'PointerScrollInertiaCancelEvent',
    isAssignable: (v) => v is $flutter_13.PointerScrollInertiaCancelEvent,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.mouse);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        return $flutter_13.PointerScrollInertiaCancelEvent(viewId: viewId, timeStamp: timeStamp, kind: kind, device: device, position: position, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'respond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
        final allowPlatformDefault = D4.getRequiredNamedArg<bool>(named, 'allowPlatformDefault', 'respond');
        t.respond(allowPlatformDefault: allowPlatformDefault);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScrollInertiaCancelEvent>(target, 'PointerScrollInertiaCancelEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerScrollInertiaCancelEvent({int viewId = 0, Duration timeStamp = Duration.zero, PointerDeviceKind kind = PointerDeviceKind.mouse, int device = 0, Offset position = Offset.zero, int embedderId = 0})',
    },
    methodSignatures: {
      'transformed': 'PointerScrollInertiaCancelEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerScrollInertiaCancelEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'respond': 'void respond({required bool allowPlatformDefault})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerScaleEvent Bridge
// =============================================================================

BridgedClass _createPointerScaleEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerScaleEvent,
    name: 'PointerScaleEvent',
    isAssignable: (v) => v is $flutter_13.PointerScaleEvent,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final kind = D4.getNamedArgWithDefault<PointerDeviceKind>(named, 'kind', $dart_ui.PointerDeviceKind.mouse);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        return $flutter_13.PointerScaleEvent(viewId: viewId, timeStamp: timeStamp, kind: kind, device: device, position: position, embedderId: embedderId, scale: scale);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').distanceMin,
      'scale': (visitor, target) => D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent').scale,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
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
        final scale = D4.getOptionalNamedArg<double?>(named, 'scale');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId, scale: scale);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'respond': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
        final allowPlatformDefault = D4.getRequiredNamedArg<bool>(named, 'allowPlatformDefault', 'respond');
        t.respond(allowPlatformDefault: allowPlatformDefault);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerScaleEvent>(target, 'PointerScaleEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerScaleEvent({int viewId = 0, Duration timeStamp = Duration.zero, PointerDeviceKind kind = PointerDeviceKind.mouse, int device = 0, Offset position = Offset.zero, int embedderId = 0, double scale = 1.0})',
    },
    methodSignatures: {
      'transformed': 'PointerScaleEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerScaleEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId, double? scale})',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'respond': 'void respond({required bool allowPlatformDefault})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
      'scale': 'double get scale',
    },
  );
}

// =============================================================================
// PointerPanZoomStartEvent Bridge
// =============================================================================

BridgedClass _createPointerPanZoomStartEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerPanZoomStartEvent,
    name: 'PointerPanZoomStartEvent',
    isAssignable: (v) => v is $flutter_13.PointerPanZoomStartEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        return $flutter_13.PointerPanZoomStartEvent(viewId: viewId, timeStamp: timeStamp, device: device, pointer: pointer, position: position, embedderId: embedderId, synthesized: synthesized);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomStartEvent>(target, 'PointerPanZoomStartEvent');
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerPanZoomUpdateEvent Bridge
// =============================================================================

BridgedClass _createPointerPanZoomUpdateEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerPanZoomUpdateEvent,
    name: 'PointerPanZoomUpdateEvent',
    isAssignable: (v) => v is $flutter_13.PointerPanZoomUpdateEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        final pan = D4.getNamedArgWithDefault<Offset>(named, 'pan', $dart_ui.Offset.zero);
        final panDelta = D4.getNamedArgWithDefault<Offset>(named, 'panDelta', $dart_ui.Offset.zero);
        final scale = D4.getNamedArgWithDefault<double>(named, 'scale', 1.0);
        final rotation = D4.getNamedArgWithDefault<double>(named, 'rotation', 0.0);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        return $flutter_13.PointerPanZoomUpdateEvent(viewId: viewId, timeStamp: timeStamp, device: device, pointer: pointer, position: position, embedderId: embedderId, pan: pan, panDelta: panDelta, scale: scale, rotation: rotation, synthesized: synthesized);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').distanceMin,
      'pan': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').pan,
      'panDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').panDelta,
      'scale': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').scale,
      'rotation': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').rotation,
      'localPan': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').localPan,
      'localPanDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent').localPanDelta,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent');
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
        final pan = D4.getOptionalNamedArg<Offset?>(named, 'pan');
        final localPan = D4.getOptionalNamedArg<Offset?>(named, 'localPan');
        final panDelta = D4.getOptionalNamedArg<Offset?>(named, 'panDelta');
        final localPanDelta = D4.getOptionalNamedArg<Offset?>(named, 'localPanDelta');
        final scale = D4.getOptionalNamedArg<double?>(named, 'scale');
        final rotation = D4.getOptionalNamedArg<double?>(named, 'rotation');
        return t.copyWith(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, delta: delta, buttons: buttons, obscured: obscured, pressure: pressure, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, synthesized: synthesized, embedderId: embedderId, pan: pan, localPan: localPan, panDelta: panDelta, localPanDelta: localPanDelta, scale: scale, rotation: rotation);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomUpdateEvent>(target, 'PointerPanZoomUpdateEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerPanZoomUpdateEvent({int viewId = 0, Duration timeStamp = Duration.zero, int device = 0, int pointer = 0, Offset position = Offset.zero, int embedderId = 0, Offset pan = Offset.zero, Offset panDelta = Offset.zero, double scale = 1.0, double rotation = 0.0, bool synthesized = false})',
    },
    methodSignatures: {
      'transformed': 'PointerPanZoomUpdateEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerPanZoomUpdateEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId, Offset? pan, Offset? localPan, Offset? panDelta, Offset? localPanDelta, double? scale, double? rotation})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
      'pan': 'Offset get pan',
      'panDelta': 'Offset get panDelta',
      'scale': 'double get scale',
      'rotation': 'double get rotation',
      'localPan': 'Offset get localPan',
      'localPanDelta': 'Offset get localPanDelta',
    },
  );
}

// =============================================================================
// PointerPanZoomEndEvent Bridge
// =============================================================================

BridgedClass _createPointerPanZoomEndEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerPanZoomEndEvent,
    name: 'PointerPanZoomEndEvent',
    isAssignable: (v) => v is $flutter_13.PointerPanZoomEndEvent,
    hierarchyDepth: 4,
    constructors: {
      '': (visitor, positional, named) {
        final viewId = D4.getNamedArgWithDefault<int>(named, 'viewId', 0);
        final timeStamp = D4.getNamedArgWithDefault<Duration>(named, 'timeStamp', Duration.zero);
        final device = D4.getNamedArgWithDefault<int>(named, 'device', 0);
        final pointer = D4.getNamedArgWithDefault<int>(named, 'pointer', 0);
        final position = D4.getNamedArgWithDefault<Offset>(named, 'position', $dart_ui.Offset.zero);
        final embedderId = D4.getNamedArgWithDefault<int>(named, 'embedderId', 0);
        final synthesized = D4.getNamedArgWithDefault<bool>(named, 'synthesized', false);
        return $flutter_13.PointerPanZoomEndEvent(viewId: viewId, timeStamp: timeStamp, device: device, pointer: pointer, position: position, embedderId: embedderId, synthesized: synthesized);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerPanZoomEndEvent>(target, 'PointerPanZoomEndEvent');
        return t.toStringFull();
      },
    },
    constructorSignatures: {
      '': 'const PointerPanZoomEndEvent({int viewId = 0, Duration timeStamp = Duration.zero, int device = 0, int pointer = 0, Offset position = Offset.zero, int embedderId = 0, bool synthesized = false})',
    },
    methodSignatures: {
      'transformed': 'PointerPanZoomEndEvent transformed(Matrix4? transform)',
      'copyWith': 'PointerPanZoomEndEvent copyWith({int? viewId, Duration? timeStamp, int? pointer, PointerDeviceKind? kind, int? device, Offset? position, Offset? delta, int? buttons, bool? obscured, double? pressure, double? pressureMin, double? pressureMax, double? distance, double? distanceMax, double? size, double? radiusMajor, double? radiusMinor, double? radiusMin, double? radiusMax, double? orientation, double? tilt, bool? synthesized, int? embedderId})',
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// PointerCancelEvent Bridge
// =============================================================================

BridgedClass _createPointerCancelEventBridge() {
  return BridgedClass(
    nativeType: $flutter_13.PointerCancelEvent,
    name: 'PointerCancelEvent',
    isAssignable: (v) => v is $flutter_13.PointerCancelEvent,
    hierarchyDepth: 4,
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
        return $flutter_13.PointerCancelEvent(viewId: viewId, timeStamp: timeStamp, pointer: pointer, kind: kind, device: device, position: position, buttons: buttons, obscured: obscured, pressureMin: pressureMin, pressureMax: pressureMax, distance: distance, distanceMax: distanceMax, size: size, radiusMajor: radiusMajor, radiusMinor: radiusMinor, radiusMin: radiusMin, radiusMax: radiusMax, orientation: orientation, tilt: tilt, embedderId: embedderId);
      },
    },
    getters: {
      'viewId': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').viewId,
      'embedderId': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').embedderId,
      'timeStamp': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').timeStamp,
      'pointer': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').pointer,
      'kind': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').kind,
      'device': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').device,
      'position': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').position,
      'delta': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').delta,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').buttons,
      'down': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').down,
      'obscured': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').obscured,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').pressure,
      'pressureMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').pressureMin,
      'pressureMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').pressureMax,
      'distance': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').distance,
      'distanceMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').distanceMax,
      'size': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').size,
      'radiusMajor': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMajor,
      'radiusMinor': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMinor,
      'radiusMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMin,
      'radiusMax': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').radiusMax,
      'orientation': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').orientation,
      'tilt': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').tilt,
      'platformData': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').platformData,
      'synthesized': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').synthesized,
      'transform': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').transform,
      'original': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').original,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').localPosition,
      'localDelta': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').localDelta,
      'distanceMin': (visitor, target) => D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent').distanceMin,
    },
    methods: {
      'transformed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent');
        D4.requireMinArgs(positional, 1, 'transformed');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4?>(positional, 0, 'transform', 'transformed');
        return t.transformed(transform);
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent');
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
        final t = D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringFull': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_13.PointerCancelEvent>(target, 'PointerCancelEvent');
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
      'delta': 'Offset get delta',
      'buttons': 'int get buttons',
      'down': 'bool get down',
      'obscured': 'bool get obscured',
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
      'synthesized': 'bool get synthesized',
      'transform': 'Matrix4? get transform',
      'original': 'PointerEvent? get original',
      'localPosition': 'Offset get localPosition',
      'localDelta': 'Offset get localDelta',
      'distanceMin': 'double get distanceMin',
    },
  );
}

// =============================================================================
// HitTestable Bridge
// =============================================================================

BridgedClass _createHitTestableBridge() {
  return BridgedClass(
    nativeType: $flutter_17.HitTestable,
    name: 'HitTestable',
    isAssignable: (v) => v is $flutter_17.HitTestable,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestable>(target, 'HitTestable');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final result = D4.getRequiredArg<$flutter_17.HitTestResult>(positional, 0, 'result', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        t.hitTest(result, position);
        return null;
      },
      'hitTestInView': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestable>(target, 'HitTestable');
        D4.requireMinArgs(positional, 3, 'hitTestInView');
        final result = D4.getRequiredArg<$flutter_17.HitTestResult>(positional, 0, 'result', 'hitTestInView');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTestInView');
        final viewId = D4.getRequiredArg<int>(positional, 2, 'viewId', 'hitTestInView');
        t.hitTestInView(result, position, viewId);
        return null;
      },
    },
    methodSignatures: {
      'hitTest': 'void hitTest(HitTestResult result, Offset position)',
      'hitTestInView': 'void hitTestInView(HitTestResult result, Offset position, int viewId)',
    },
  );
}

// =============================================================================
// HitTestDispatcher Bridge
// =============================================================================

BridgedClass _createHitTestDispatcherBridge() {
  return BridgedClass(
    nativeType: $flutter_17.HitTestDispatcher,
    name: 'HitTestDispatcher',
    isAssignable: (v) => v is $flutter_17.HitTestDispatcher,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'dispatchEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestDispatcher>(target, 'HitTestDispatcher');
        D4.requireMinArgs(positional, 2, 'dispatchEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'dispatchEvent');
        final result = D4.getRequiredArg<$flutter_17.HitTestResult>(positional, 1, 'result', 'dispatchEvent');
        t.dispatchEvent(event, result);
        return null;
      },
    },
    methodSignatures: {
      'dispatchEvent': 'void dispatchEvent(PointerEvent event, HitTestResult result)',
    },
  );
}

// =============================================================================
// HitTestTarget Bridge
// =============================================================================

BridgedClass _createHitTestTargetBridge() {
  return BridgedClass(
    nativeType: $flutter_17.HitTestTarget,
    name: 'HitTestTarget',
    isAssignable: (v) => v is $flutter_17.HitTestTarget,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestTarget>(target, 'HitTestTarget');
        D4.requireMinArgs(positional, 2, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        final entry = D4.getRequiredArg<$flutter_17.HitTestEntry<$flutter_17.HitTestTarget>>(positional, 1, 'entry', 'handleEvent');
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
    nativeType: $flutter_17.HitTestEntry,
    name: 'HitTestEntry',
    isAssignable: (v) => v is $flutter_17.HitTestEntry,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HitTestEntry');
        final target_ = D4.getRequiredArg<$flutter_17.HitTestTarget>(positional, 0, 'target', 'HitTestEntry');
        return $flutter_17.HitTestEntry(target_);
      },
    },
    getters: {
      'target': (visitor, target) => D4.validateTarget<$flutter_17.HitTestEntry>(target, 'HitTestEntry').target,
      'transform': (visitor, target) => D4.validateTarget<$flutter_17.HitTestEntry>(target, 'HitTestEntry').transform,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestEntry>(target, 'HitTestEntry');
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
    nativeType: $flutter_17.HitTestResult,
    name: 'HitTestResult',
    isAssignable: (v) => v is $flutter_17.HitTestResult,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_17.HitTestResult();
      },
      'wrap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HitTestResult');
        final result = D4.getRequiredArg<$flutter_17.HitTestResult>(positional, 0, 'result', 'HitTestResult');
        return $flutter_17.HitTestResult.wrap(result);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$flutter_17.HitTestResult>(target, 'HitTestResult').path,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestResult>(target, 'HitTestResult');
        D4.requireMinArgs(positional, 1, 'add');
        final entry = D4.getRequiredArg<$flutter_17.HitTestEntry<$flutter_17.HitTestTarget>>(positional, 0, 'entry', 'add');
        t.add(entry);
        return null;
      },
      'pushTransform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestResult>(target, 'HitTestResult');
        D4.requireMinArgs(positional, 1, 'pushTransform');
        final transform = D4.getRequiredArg<$vector_math_1.Matrix4>(positional, 0, 'transform', 'pushTransform');
        t.pushTransform(transform);
        return null;
      },
      'pushOffset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestResult>(target, 'HitTestResult');
        D4.requireMinArgs(positional, 1, 'pushOffset');
        final offset = D4.getRequiredArg<Offset>(positional, 0, 'offset', 'pushOffset');
        t.pushOffset(offset);
        return null;
      },
      'popTransform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestResult>(target, 'HitTestResult');
        t.popTransform();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_17.HitTestResult>(target, 'HitTestResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'HitTestResult()',
      'wrap': 'HitTestResult.wrap(HitTestResult result)',
    },
    methodSignatures: {
      'add': 'void add(HitTestEntry<HitTestTarget> entry)',
      'pushTransform': 'void pushTransform(Matrix4 transform)',
      'pushOffset': 'void pushOffset(Offset offset)',
      'popTransform': 'void popTransform()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'path': 'Iterable<HitTestEntry<HitTestTarget>> get path',
    },
  );
}

// =============================================================================
// PointerRouter Bridge
// =============================================================================

BridgedClass _createPointerRouterBridge() {
  return BridgedClass(
    nativeType: $flutter_23.PointerRouter,
    name: 'PointerRouter',
    isAssignable: (v) => v is $flutter_23.PointerRouter,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_23.PointerRouter();
      },
    },
    getters: {
      'debugGlobalRouteCount': (visitor, target) => D4.validateTarget<$flutter_23.PointerRouter>(target, 'PointerRouter').debugGlobalRouteCount,
    },
    methods: {
      'addRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 2, 'addRoute');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'addRoute');
        if (positional.length <= 1) {
          throw ArgumentError('addRoute: Missing required argument "route" at position 1');
        }
        final routeRaw = positional[1];
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 2, 'transform');
        t.addRoute(pointer, ($flutter_13.PointerEvent p0) { D4.callInterpreterCallback(visitor!, routeRaw, [p0]); }, transform);
        return null;
      },
      'removeRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 2, 'removeRoute');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'removeRoute');
        if (positional.length <= 1) {
          throw ArgumentError('removeRoute: Missing required argument "route" at position 1');
        }
        final routeRaw = positional[1];
        t.removeRoute(pointer, ($flutter_13.PointerEvent p0) { D4.callInterpreterCallback(visitor!, routeRaw, [p0]); });
        return null;
      },
      'addGlobalRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 1, 'addGlobalRoute');
        if (positional.isEmpty) {
          throw ArgumentError('addGlobalRoute: Missing required argument "route" at position 0');
        }
        final routeRaw = positional[0];
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.addGlobalRoute(($flutter_13.PointerEvent p0) { D4.callInterpreterCallback(visitor!, routeRaw, [p0]); }, transform);
        return null;
      },
      'removeGlobalRoute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 1, 'removeGlobalRoute');
        if (positional.isEmpty) {
          throw ArgumentError('removeGlobalRoute: Missing required argument "route" at position 0');
        }
        final routeRaw = positional[0];
        t.removeGlobalRoute(($flutter_13.PointerEvent p0) { D4.callInterpreterCallback(visitor!, routeRaw, [p0]); });
        return null;
      },
      'route': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_23.PointerRouter>(target, 'PointerRouter');
        D4.requireMinArgs(positional, 1, 'route');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'route');
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
    nativeType: $flutter_24.PointerSignalResolver,
    name: 'PointerSignalResolver',
    isAssignable: (v) => v is $flutter_24.PointerSignalResolver,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_24.PointerSignalResolver();
      },
    },
    methods: {
      'register': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.PointerSignalResolver>(target, 'PointerSignalResolver');
        D4.requireMinArgs(positional, 2, 'register');
        final event = D4.getRequiredArg<$flutter_13.PointerSignalEvent>(positional, 0, 'event', 'register');
        if (positional.length <= 1) {
          throw ArgumentError('register: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.register(event, ($flutter_13.PointerSignalEvent p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_24.PointerSignalResolver>(target, 'PointerSignalResolver');
        D4.requireMinArgs(positional, 1, 'resolve');
        final event = D4.getRequiredArg<$flutter_13.PointerSignalEvent>(positional, 0, 'event', 'resolve');
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
    nativeType: $flutter_6.SamplingClock,
    name: 'SamplingClock',
    isAssignable: (v) => v is $flutter_6.SamplingClock,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_6.SamplingClock();
      },
    },
    methods: {
      'now': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SamplingClock>(target, 'SamplingClock');
        return t.now();
      },
      'stopwatch': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.SamplingClock>(target, 'SamplingClock');
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
// FlutterErrorDetailsForPointerEventDispatcher Bridge
// =============================================================================

BridgedClass _createFlutterErrorDetailsForPointerEventDispatcherBridge() {
  return BridgedClass(
    nativeType: $flutter_6.FlutterErrorDetailsForPointerEventDispatcher,
    name: 'FlutterErrorDetailsForPointerEventDispatcher',
    isAssignable: (v) => v is $flutter_6.FlutterErrorDetailsForPointerEventDispatcher,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final exception = D4.getRequiredNamedArg<Object>(named, 'exception', 'FlutterErrorDetailsForPointerEventDispatcher');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final library = D4.getNamedArgWithDefault<String?>(named, 'library', 'Flutter framework');
        final context = D4.getOptionalNamedArg<$flutter_4.DiagnosticsNode?>(named, 'context');
        final event = D4.getOptionalNamedArg<$flutter_13.PointerEvent?>(named, 'event');
        final hitTestEntry = D4.getOptionalNamedArg<$flutter_17.HitTestEntry<$flutter_17.HitTestTarget>?>(named, 'hitTestEntry');
        final informationCollectorRaw = named['informationCollector'];
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        return $flutter_6.FlutterErrorDetailsForPointerEventDispatcher(exception: exception, stack: stack, library: library, context: context, event: event, hitTestEntry: hitTestEntry, informationCollector: informationCollectorRaw == null ? null : (() { return D4.extractBridgedArg<Iterable<$flutter_4.DiagnosticsNode>>(D4.callInterpreterCallback(visitor!, informationCollectorRaw, []), 'callback', visitor) as Iterable<$flutter_4.DiagnosticsNode>; }) as Iterable<$flutter_4.DiagnosticsNode> Function(), silent: silent);
      },
    },
    getters: {
      'event': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').event,
      'hitTestEntry': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').hitTestEntry,
      'exception': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').exception,
      'stack': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').stack,
      'library': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').library,
      'context': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').context,
      'stackFilter': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').stackFilter,
      'informationCollector': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').informationCollector,
      'silent': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').silent,
      'summary': (visitor, target) => D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher').summary,
    },
    methods: {
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        final context = D4.getOptionalNamedArg<$flutter_4.DiagnosticsNode?>(named, 'context');
        final exception = D4.getOptionalNamedArg<Object?>(named, 'exception');
        final informationCollectorRaw = named['informationCollector'];
        final library = D4.getOptionalNamedArg<String?>(named, 'library');
        final silent = D4.getOptionalNamedArg<bool?>(named, 'silent');
        final stack = D4.getOptionalNamedArg<StackTrace?>(named, 'stack');
        final stackFilterRaw = named['stackFilter'];
        return t.copyWith(context: context, exception: exception, informationCollector: informationCollectorRaw == null ? null : (() { return D4.extractBridgedArg<Iterable<$flutter_4.DiagnosticsNode>>(D4.callInterpreterCallback(visitor!, informationCollectorRaw, []), 'callback', visitor) as Iterable<$flutter_4.DiagnosticsNode>; }) as Iterable<$flutter_4.DiagnosticsNode> Function(), library: library, silent: silent, stack: stack, stackFilter: stackFilterRaw == null ? null : ((Iterable<String> p0) { return D4.extractBridgedArg<Iterable<String>>(D4.callInterpreterCallback(visitor!, stackFilterRaw, [p0]), 'callback', visitor) as Iterable<String>; }) as Iterable<String> Function(Iterable<String>));
      },
      'exceptionAsString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        return t.exceptionAsString();
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.FlutterErrorDetailsForPointerEventDispatcher>(target, 'FlutterErrorDetailsForPointerEventDispatcher');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const FlutterErrorDetailsForPointerEventDispatcher({required Object exception, StackTrace? stack, String? library = \'Flutter framework\', DiagnosticsNode? context, PointerEvent? event, HitTestEntry<HitTestTarget>? hitTestEntry, InformationCollector? informationCollector, bool silent = false})',
    },
    methodSignatures: {
      'copyWith': 'FlutterErrorDetails copyWith({DiagnosticsNode? context, Object? exception, InformationCollector? informationCollector, String? library, bool? silent, StackTrace? stack, IterableFilter<String>? stackFilter})',
      'exceptionAsString': 'String exceptionAsString()',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'event': 'PointerEvent? get event',
      'hitTestEntry': 'HitTestEntry<HitTestTarget>? get hitTestEntry',
      'exception': 'Object get exception',
      'stack': 'StackTrace? get stack',
      'library': 'String? get library',
      'context': 'DiagnosticsNode? get context',
      'stackFilter': 'IterableFilter<String>? get stackFilter',
      'informationCollector': 'InformationCollector? get informationCollector',
      'silent': 'bool get silent',
      'summary': 'DiagnosticsNode get summary',
    },
  );
}

// =============================================================================
// GestureBinding Bridge
// =============================================================================

BridgedClass _createGestureBindingBridge() {
  return BridgedClass(
    nativeType: $flutter_6.GestureBinding,
    name: 'GestureBinding',
    isAssignable: (v) => v is $flutter_6.GestureBinding,
    hierarchyDepth: 4,
    canBeUsedAsMixin: true,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'pointerRouter': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').pointerRouter,
      'gestureArena': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').gestureArena,
      'pointerSignalResolver': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').pointerSignalResolver,
      'resamplingEnabled': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').resamplingEnabled,
      'samplingOffset': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').samplingOffset,
      'debugSamplingClock': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').debugSamplingClock,
      'samplingClock': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').samplingClock,
      'window': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').window,
      'platformDispatcher': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').platformDispatcher,
      'locked': (visitor, target) => D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').locked,
    },
    setters: {
      'resamplingEnabled': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').resamplingEnabled = D4.extractBridgedArg<bool>(value, 'resamplingEnabled'),
      'samplingOffset': (visitor, target, value) => 
        D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding').samplingOffset = D4.extractBridgedArg<Duration>(value, 'samplingOffset'),
    },
    methods: {
      'initInstances': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        t.initInstances();
        return null;
      },
      'unlocked': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        (t as dynamic).unlocked();
        return null;
      },
      'cancelPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 1, 'cancelPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'cancelPointer');
        t.cancelPointer(pointer);
        return null;
      },
      'handlePointerEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 1, 'handlePointerEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handlePointerEvent');
        t.handlePointerEvent(event);
        return null;
      },
      'hitTestInView': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 3, 'hitTestInView');
        final result = D4.getRequiredArg<$flutter_17.HitTestResult>(positional, 0, 'result', 'hitTestInView');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTestInView');
        final viewId = D4.getRequiredArg<int>(positional, 2, 'viewId', 'hitTestInView');
        t.hitTestInView(result, position, viewId);
        return null;
      },
      'hitTest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 2, 'hitTest');
        final result = D4.getRequiredArg<$flutter_17.HitTestResult>(positional, 0, 'result', 'hitTest');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'hitTest');
        t.hitTest(result, position);
        return null;
      },
      'dispatchEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 2, 'dispatchEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'dispatchEvent');
        final hitTestResult = D4.getRequiredArg<$flutter_17.HitTestResult?>(positional, 1, 'hitTestResult', 'dispatchEvent');
        t.dispatchEvent(event, hitTestResult);
        return null;
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 2, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        final entry = D4.getRequiredArg<$flutter_17.HitTestEntry<$flutter_17.HitTestTarget>>(positional, 1, 'entry', 'handleEvent');
        t.handleEvent(event, entry);
        return null;
      },
      'resetGestureBinding': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        t.resetGestureBinding();
        return null;
      },
      'debugCheckZone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 1, 'debugCheckZone');
        final entryPoint = D4.getRequiredArg<String>(positional, 0, 'entryPoint', 'debugCheckZone');
        return t.debugCheckZone(entryPoint);
      },
      'initServiceExtensions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        (t as dynamic).initServiceExtensions();
        return null;
      },
      'lockEvents': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        D4.requireMinArgs(positional, 1, 'lockEvents');
        if (positional.isEmpty) {
          throw ArgumentError('lockEvents: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        return t.lockEvents((() { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }) as Future<void> Function());
      },
      'reassembleApplication': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        return t.reassembleApplication();
      },
      'performReassemble': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        return t.performReassemble();
      },
      'registerSignalServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerSignalServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerSignalServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerSignalServiceExtension(name: name, callback: (() { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }) as Future<void> Function());
        return null;
      },
      'registerBoolServiceExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
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
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
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
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
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
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
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
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'registerServiceExtension');
        if (!named.containsKey('callback') || named['callback'] == null) {
          throw ArgumentError('registerServiceExtension: Missing required named argument "callback"');
        }
        final callbackRaw = named['callback'];
        t.registerServiceExtension(name: name, callback: ((Map<String, String> p0) { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [p0])).then((v) => v as Map<String, dynamic>); }) as Future<Map<String, dynamic>> Function(Map<String, String>));
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.GestureBinding>(target, 'GestureBinding');
        return t.toString();
      },
    },
    staticGetters: {
      'instance': (visitor) => $flutter_6.GestureBinding.instance,
    },
    methodSignatures: {
      'initInstances': 'void initInstances()',
      'unlocked': 'void unlocked()',
      'cancelPointer': 'void cancelPointer(int pointer)',
      'handlePointerEvent': 'void handlePointerEvent(PointerEvent event)',
      'hitTestInView': 'void hitTestInView(HitTestResult result, Offset position, int viewId)',
      'hitTest': 'void hitTest(HitTestResult result, Offset position)',
      'dispatchEvent': 'void dispatchEvent(PointerEvent event, HitTestResult? hitTestResult)',
      'handleEvent': 'void handleEvent(PointerEvent event, HitTestEntry<HitTestTarget> entry)',
      'resetGestureBinding': 'void resetGestureBinding()',
      'debugCheckZone': 'bool debugCheckZone(String entryPoint)',
      'initServiceExtensions': 'void initServiceExtensions()',
      'lockEvents': 'Future<void> lockEvents(Future<void> Function() callback)',
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
      'pointerRouter': 'PointerRouter get pointerRouter',
      'gestureArena': 'GestureArenaManager get gestureArena',
      'pointerSignalResolver': 'PointerSignalResolver get pointerSignalResolver',
      'resamplingEnabled': 'bool get resamplingEnabled',
      'samplingOffset': 'Duration get samplingOffset',
      'debugSamplingClock': 'SamplingClock? get debugSamplingClock',
      'samplingClock': 'SamplingClock get samplingClock',
      'window': 'SingletonFlutterWindow get window',
      'platformDispatcher': 'PlatformDispatcher get platformDispatcher',
      'locked': 'bool get locked',
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
// PointerEventConverter Bridge
// =============================================================================

BridgedClass _createPointerEventConverterBridge() {
  return BridgedClass(
    nativeType: $flutter_8.PointerEventConverter,
    name: 'PointerEventConverter',
    isAssignable: (v) => v is $flutter_8.PointerEventConverter,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'expand': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "data" at position 0');
        }
        final data = D4.coerceList<PointerData>(positional[0], 'data');
        if (positional.length <= 1) {
          throw ArgumentError('expand: Missing required argument "devicePixelRatioForView" at position 1');
        }
        final devicePixelRatioForViewRaw = positional[1];
        final devicePixelRatioForView = ((int p0) { return D4.callInterpreterCallback(visitor!, devicePixelRatioForViewRaw, [p0]) as double?; }) as double? Function(int);
        return $flutter_8.PointerEventConverter.expand(data, devicePixelRatioForView);
      },
    },
    staticMethodSignatures: {
      'expand': 'Iterable<PointerEvent> expand(Iterable<PointerData> data, DevicePixelRatioGetter devicePixelRatioForView)',
    },
  );
}

// =============================================================================
// Velocity Bridge
// =============================================================================

BridgedClass _createVelocityBridge() {
  return BridgedClass(
    nativeType: $flutter_31.Velocity,
    name: 'Velocity',
    isAssignable: (v) => v is $flutter_31.Velocity,
    constructors: {
      '': (visitor, positional, named) {
        final pixelsPerSecond = D4.getRequiredNamedArg<Offset>(named, 'pixelsPerSecond', 'Velocity');
        return $flutter_31.Velocity(pixelsPerSecond: pixelsPerSecond);
      },
    },
    getters: {
      'pixelsPerSecond': (visitor, target) => D4.validateTarget<$flutter_31.Velocity>(target, 'Velocity').pixelsPerSecond,
      'hashCode': (visitor, target) => D4.validateTarget<$flutter_31.Velocity>(target, 'Velocity').hashCode,
    },
    methods: {
      'clampMagnitude': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Velocity>(target, 'Velocity');
        D4.requireMinArgs(positional, 2, 'clampMagnitude');
        final minValue = D4.getRequiredArg<double>(positional, 0, 'minValue', 'clampMagnitude');
        final maxValue = D4.getRequiredArg<double>(positional, 1, 'maxValue', 'clampMagnitude');
        return t.clampMagnitude(minValue, maxValue);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Velocity>(target, 'Velocity');
        return t.toString();
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Velocity>(target, 'Velocity');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$flutter_31.Velocity>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Velocity>(target, 'Velocity');
        final other = D4.getRequiredArg<$flutter_31.Velocity>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.Velocity>(target, 'Velocity');
        // GEN-103: Dart spec — non-null == null is always false.
        if (positional.isEmpty || positional[0] == null) return false;
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_31.Velocity.zero,
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
// VelocityEstimate Bridge
// =============================================================================

BridgedClass _createVelocityEstimateBridge() {
  return BridgedClass(
    nativeType: $flutter_31.VelocityEstimate,
    name: 'VelocityEstimate',
    isAssignable: (v) => v is $flutter_31.VelocityEstimate,
    constructors: {
      '': (visitor, positional, named) {
        final pixelsPerSecond = D4.getRequiredNamedArg<Offset>(named, 'pixelsPerSecond', 'VelocityEstimate');
        final confidence = D4.getRequiredNamedArg<double>(named, 'confidence', 'VelocityEstimate');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VelocityEstimate');
        final offset = D4.getRequiredNamedArg<Offset>(named, 'offset', 'VelocityEstimate');
        return $flutter_31.VelocityEstimate(pixelsPerSecond: pixelsPerSecond, confidence: confidence, duration: duration, offset: offset);
      },
    },
    getters: {
      'pixelsPerSecond': (visitor, target) => D4.validateTarget<$flutter_31.VelocityEstimate>(target, 'VelocityEstimate').pixelsPerSecond,
      'confidence': (visitor, target) => D4.validateTarget<$flutter_31.VelocityEstimate>(target, 'VelocityEstimate').confidence,
      'duration': (visitor, target) => D4.validateTarget<$flutter_31.VelocityEstimate>(target, 'VelocityEstimate').duration,
      'offset': (visitor, target) => D4.validateTarget<$flutter_31.VelocityEstimate>(target, 'VelocityEstimate').offset,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.VelocityEstimate>(target, 'VelocityEstimate');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const VelocityEstimate({required Offset pixelsPerSecond, required double confidence, required Duration duration, required Offset offset})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'pixelsPerSecond': 'Offset get pixelsPerSecond',
      'confidence': 'double get confidence',
      'duration': 'Duration get duration',
      'offset': 'Offset get offset',
    },
  );
}

// =============================================================================
// VelocityTracker Bridge
// =============================================================================

BridgedClass _createVelocityTrackerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.VelocityTracker,
    name: 'VelocityTracker',
    isAssignable: (v) => v is $flutter_31.VelocityTracker,
    constructors: {
      'withKind': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VelocityTracker');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'kind', 'VelocityTracker');
        return $flutter_31.VelocityTracker.withKind(kind);
      },
    },
    getters: {
      'kind': (visitor, target) => D4.validateTarget<$flutter_31.VelocityTracker>(target, 'VelocityTracker').kind,
    },
    methods: {
      'addPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.VelocityTracker>(target, 'VelocityTracker');
        D4.requireMinArgs(positional, 2, 'addPosition');
        final time = D4.getRequiredArg<Duration>(positional, 0, 'time', 'addPosition');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'addPosition');
        t.addPosition(time, position);
        return null;
      },
      'getVelocityEstimate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.VelocityTracker>(target, 'VelocityTracker');
        return t.getVelocityEstimate();
      },
      'getVelocity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.VelocityTracker>(target, 'VelocityTracker');
        return t.getVelocity();
      },
    },
    constructorSignatures: {
      'withKind': 'VelocityTracker.withKind(PointerDeviceKind kind)',
    },
    methodSignatures: {
      'addPosition': 'void addPosition(Duration time, Offset position)',
      'getVelocityEstimate': 'VelocityEstimate? getVelocityEstimate()',
      'getVelocity': 'Velocity getVelocity()',
    },
    getterSignatures: {
      'kind': 'PointerDeviceKind get kind',
    },
  );
}

// =============================================================================
// IOSScrollViewFlingVelocityTracker Bridge
// =============================================================================

BridgedClass _createIOSScrollViewFlingVelocityTrackerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.IOSScrollViewFlingVelocityTracker,
    name: 'IOSScrollViewFlingVelocityTracker',
    isAssignable: (v) => v is $flutter_31.IOSScrollViewFlingVelocityTracker,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'IOSScrollViewFlingVelocityTracker');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'kind', 'IOSScrollViewFlingVelocityTracker');
        return $flutter_31.IOSScrollViewFlingVelocityTracker(kind);
      },
    },
    getters: {
      'kind': (visitor, target) => D4.validateTarget<$flutter_31.IOSScrollViewFlingVelocityTracker>(target, 'IOSScrollViewFlingVelocityTracker').kind,
    },
    methods: {
      'addPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.IOSScrollViewFlingVelocityTracker>(target, 'IOSScrollViewFlingVelocityTracker');
        D4.requireMinArgs(positional, 2, 'addPosition');
        final time = D4.getRequiredArg<Duration>(positional, 0, 'time', 'addPosition');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'addPosition');
        t.addPosition(time, position);
        return null;
      },
      'getVelocityEstimate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.IOSScrollViewFlingVelocityTracker>(target, 'IOSScrollViewFlingVelocityTracker');
        return t.getVelocityEstimate();
      },
      'getVelocity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.IOSScrollViewFlingVelocityTracker>(target, 'IOSScrollViewFlingVelocityTracker');
        return t.getVelocity();
      },
    },
    constructorSignatures: {
      '': 'IOSScrollViewFlingVelocityTracker(PointerDeviceKind kind)',
    },
    methodSignatures: {
      'addPosition': 'void addPosition(Duration time, Offset position)',
      'getVelocityEstimate': 'VelocityEstimate getVelocityEstimate()',
      'getVelocity': 'Velocity getVelocity()',
    },
    getterSignatures: {
      'kind': 'PointerDeviceKind get kind',
    },
  );
}

// =============================================================================
// MacOSScrollViewFlingVelocityTracker Bridge
// =============================================================================

BridgedClass _createMacOSScrollViewFlingVelocityTrackerBridge() {
  return BridgedClass(
    nativeType: $flutter_31.MacOSScrollViewFlingVelocityTracker,
    name: 'MacOSScrollViewFlingVelocityTracker',
    isAssignable: (v) => v is $flutter_31.MacOSScrollViewFlingVelocityTracker,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MacOSScrollViewFlingVelocityTracker');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'kind', 'MacOSScrollViewFlingVelocityTracker');
        return $flutter_31.MacOSScrollViewFlingVelocityTracker(kind);
      },
    },
    getters: {
      'kind': (visitor, target) => D4.validateTarget<$flutter_31.MacOSScrollViewFlingVelocityTracker>(target, 'MacOSScrollViewFlingVelocityTracker').kind,
    },
    methods: {
      'addPosition': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.MacOSScrollViewFlingVelocityTracker>(target, 'MacOSScrollViewFlingVelocityTracker');
        D4.requireMinArgs(positional, 2, 'addPosition');
        final time = D4.getRequiredArg<Duration>(positional, 0, 'time', 'addPosition');
        final position = D4.getRequiredArg<Offset>(positional, 1, 'position', 'addPosition');
        t.addPosition(time, position);
        return null;
      },
      'getVelocityEstimate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.MacOSScrollViewFlingVelocityTracker>(target, 'MacOSScrollViewFlingVelocityTracker');
        return t.getVelocityEstimate();
      },
      'getVelocity': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_31.MacOSScrollViewFlingVelocityTracker>(target, 'MacOSScrollViewFlingVelocityTracker');
        return t.getVelocity();
      },
    },
    constructorSignatures: {
      '': 'MacOSScrollViewFlingVelocityTracker(PointerDeviceKind kind)',
    },
    methodSignatures: {
      'addPosition': 'void addPosition(Duration time, Offset position)',
      'getVelocityEstimate': 'VelocityEstimate getVelocityEstimate()',
      'getVelocity': 'Velocity getVelocity()',
    },
    getterSignatures: {
      'kind': 'PointerDeviceKind get kind',
    },
  );
}

// =============================================================================
// DragDownDetails Bridge
// =============================================================================

BridgedClass _createDragDownDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_11.DragDownDetails,
    name: 'DragDownDetails',
    isAssignable: (v) => v is $flutter_11.DragDownDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        return $flutter_11.DragDownDetails(globalPosition: globalPosition, localPosition: localPosition);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragDownDetails>(target, 'DragDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragDownDetails>(target, 'DragDownDetails').localPosition,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragDownDetails>(target, 'DragDownDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragDownDetails>(target, 'DragDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragDownDetails>(target, 'DragDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragDownDetails>(target, 'DragDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'DragDownDetails({Offset globalPosition = Offset.zero, Offset? localPosition})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
// DragStartDetails Bridge
// =============================================================================

BridgedClass _createDragStartDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_11.DragStartDetails,
    name: 'DragStartDetails',
    isAssignable: (v) => v is $flutter_11.DragStartDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_11.DragStartDetails(globalPosition: globalPosition, localPosition: localPosition, sourceTimeStamp: sourceTimeStamp, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails').localPosition,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails').sourceTimeStamp,
      'kind': (visitor, target) => D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails').kind,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragStartDetails>(target, 'DragStartDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'DragStartDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Duration? sourceTimeStamp, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toStringShort': 'String toStringShort()',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'sourceTimeStamp': 'Duration? get sourceTimeStamp',
      'kind': 'PointerDeviceKind? get kind',
    },
  );
}

// =============================================================================
// DragUpdateDetails Bridge
// =============================================================================

BridgedClass _createDragUpdateDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_11.DragUpdateDetails,
    name: 'DragUpdateDetails',
    isAssignable: (v) => v is $flutter_11.DragUpdateDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'DragUpdateDetails');
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
        final primaryDelta = D4.getOptionalNamedArg<double?>(named, 'primaryDelta');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_11.DragUpdateDetails(globalPosition: globalPosition, localPosition: localPosition, sourceTimeStamp: sourceTimeStamp, delta: delta, primaryDelta: primaryDelta, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails').localPosition,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails').sourceTimeStamp,
      'delta': (visitor, target) => D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails').delta,
      'primaryDelta': (visitor, target) => D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails').primaryDelta,
      'kind': (visitor, target) => D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails').kind,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragUpdateDetails>(target, 'DragUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'DragUpdateDetails({required Offset globalPosition, Offset? localPosition, Duration? sourceTimeStamp, Offset delta = Offset.zero, double? primaryDelta, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_11.DragEndDetails,
    name: 'DragEndDetails',
    isAssignable: (v) => v is $flutter_11.DragEndDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final velocity = D4.getNamedArgWithDefault<$flutter_31.Velocity>(named, 'velocity', $flutter_31.Velocity.zero);
        final primaryVelocity = D4.getOptionalNamedArg<double?>(named, 'primaryVelocity');
        return $flutter_11.DragEndDetails(globalPosition: globalPosition, localPosition: localPosition, velocity: velocity, primaryVelocity: primaryVelocity);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails').localPosition,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails').velocity,
      'primaryVelocity': (visitor, target) => D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails').primaryVelocity,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_11.DragEndDetails>(target, 'DragEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'DragEndDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Velocity velocity = Velocity.zero, double? primaryVelocity})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_10.Drag,
    name: 'Drag',
    isAssignable: (v) => v is $flutter_10.Drag,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'update': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Drag>(target, 'Drag');
        D4.requireMinArgs(positional, 1, 'update');
        final details = D4.getRequiredArg<$flutter_11.DragUpdateDetails>(positional, 0, 'details', 'update');
        t.update(details);
        return null;
      },
      'end': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Drag>(target, 'Drag');
        D4.requireMinArgs(positional, 1, 'end');
        final details = D4.getRequiredArg<$flutter_11.DragEndDetails>(positional, 0, 'details', 'end');
        t.end(details);
        return null;
      },
      'cancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_10.Drag>(target, 'Drag');
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
    nativeType: $flutter_12.EagerGestureRecognizer,
    name: 'EagerGestureRecognizer',
    isAssignable: (v) => v is $flutter_12.EagerGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_12.EagerGestureRecognizer(supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_12.EagerGestureRecognizer(supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').team,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_12.EagerGestureRecognizer>(target, 'EagerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'EagerGestureRecognizer({Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
    },
  );
}

// =============================================================================
// ForcePressDetails Bridge
// =============================================================================

BridgedClass _createForcePressDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_14.ForcePressDetails,
    name: 'ForcePressDetails',
    isAssignable: (v) => v is $flutter_14.ForcePressDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'ForcePressDetails');
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final pressure = D4.getRequiredNamedArg<double>(named, 'pressure', 'ForcePressDetails');
        return $flutter_14.ForcePressDetails(globalPosition: globalPosition, localPosition: localPosition, pressure: pressure);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressDetails>(target, 'ForcePressDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressDetails>(target, 'ForcePressDetails').localPosition,
      'pressure': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressDetails>(target, 'ForcePressDetails').pressure,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressDetails>(target, 'ForcePressDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressDetails>(target, 'ForcePressDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressDetails>(target, 'ForcePressDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressDetails>(target, 'ForcePressDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ForcePressDetails({required Offset globalPosition, Offset? localPosition, required double pressure})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_14.ForcePressGestureRecognizer,
    name: 'ForcePressGestureRecognizer',
    isAssignable: (v) => v is $flutter_14.ForcePressGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final startPressure = D4.getNamedArgWithDefault<double>(named, 'startPressure', 0.4);
        final peakPressure = D4.getNamedArgWithDefault<double>(named, 'peakPressure', 0.85);
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('interpolation') && !named.containsKey('allowedButtonsFilter')) {
          return $flutter_14.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('interpolation') && !named.containsKey('allowedButtonsFilter')) {
          final interpolationRaw = named['interpolation'];
          final interpolation = ((double p0, double p1, double p2) { return D4.callInterpreterCallback(visitor!, interpolationRaw, [p0, p1, p2]) as double; }) as double Function(double, double, double);
          return $flutter_14.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices, interpolation: interpolation);
        }
        if (!named.containsKey('interpolation') && named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_14.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        if (named.containsKey('interpolation') && named.containsKey('allowedButtonsFilter')) {
          final interpolationRaw = named['interpolation'];
          final interpolation = ((double p0, double p1, double p2) { return D4.callInterpreterCallback(visitor!, interpolationRaw, [p0, p1, p2]) as double; }) as double Function(double, double, double);
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_14.ForcePressGestureRecognizer(startPressure: startPressure, peakPressure: peakPressure, debugOwner: debugOwner, supportedDevices: supportedDevices, interpolation: interpolation, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').team,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onUpdate,
      'onPeak': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onPeak,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onEnd,
      'startPressure': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').startPressure,
      'peakPressure': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').peakPressure,
      'interpolation': (visitor, target) => D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').interpolation,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onStart = onStartRaw == null ? null : ($flutter_14.ForcePressDetails p0) { D4.callInterpreterCallback(visitor!, onStartRaw, [p0]); };
      },
      'onUpdate': (visitor, target, value) {
        final onUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onUpdate');
        D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onUpdate = onUpdateRaw == null ? null : ($flutter_14.ForcePressDetails p0) { D4.callInterpreterCallback(visitor!, onUpdateRaw, [p0]); };
      },
      'onPeak': (visitor, target, value) {
        final onPeakRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onPeak');
        D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onPeak = onPeakRaw == null ? null : ($flutter_14.ForcePressDetails p0) { D4.callInterpreterCallback(visitor!, onPeakRaw, [p0]); };
      },
      'onEnd': (visitor, target, value) {
        final onEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onEnd');
        D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer').onEnd = onEndRaw == null ? null : ($flutter_14.ForcePressDetails p0) { D4.callInterpreterCallback(visitor!, onEndRaw, [p0]); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_14.ForcePressGestureRecognizer>(target, 'ForcePressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'ForcePressGestureRecognizer({double startPressure = 0.4, double peakPressure = 0.85, GestureForceInterpolation interpolation = _inverseLerp, Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'onStart': 'GestureForcePressStartCallback? get onStart',
      'onUpdate': 'GestureForcePressUpdateCallback? get onUpdate',
      'onPeak': 'GestureForcePressPeakCallback? get onPeak',
      'onEnd': 'GestureForcePressEndCallback? get onEnd',
      'startPressure': 'double get startPressure',
      'peakPressure': 'double get peakPressure',
      'interpolation': 'GestureForceInterpolation get interpolation',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
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
    nativeType: $flutter_15.PositionedGestureDetails,
    name: 'PositionedGestureDetails',
    isAssignable: (v) => v is $flutter_15.PositionedGestureDetails,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_15.PositionedGestureDetails>(target, 'PositionedGestureDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_15.PositionedGestureDetails>(target, 'PositionedGestureDetails').localPosition,
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
    nativeType: $flutter_18.LongPressDownDetails,
    name: 'LongPressDownDetails',
    isAssignable: (v) => v is $flutter_18.LongPressDownDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_18.LongPressDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressDownDetails>(target, 'LongPressDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressDownDetails>(target, 'LongPressDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_18.LongPressDownDetails>(target, 'LongPressDownDetails').kind,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressDownDetails>(target, 'LongPressDownDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressDownDetails>(target, 'LongPressDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressDownDetails>(target, 'LongPressDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressDownDetails>(target, 'LongPressDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressDownDetails({Offset globalPosition = Offset.zero, Offset? localPosition, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_18.LongPressStartDetails,
    name: 'LongPressStartDetails',
    isAssignable: (v) => v is $flutter_18.LongPressStartDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        return $flutter_18.LongPressStartDetails(globalPosition: globalPosition, localPosition: localPosition);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressStartDetails>(target, 'LongPressStartDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressStartDetails>(target, 'LongPressStartDetails').localPosition,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressStartDetails>(target, 'LongPressStartDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressStartDetails>(target, 'LongPressStartDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressStartDetails>(target, 'LongPressStartDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressStartDetails>(target, 'LongPressStartDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressStartDetails({Offset globalPosition = Offset.zero, Offset? localPosition})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_18.LongPressMoveUpdateDetails,
    name: 'LongPressMoveUpdateDetails',
    isAssignable: (v) => v is $flutter_18.LongPressMoveUpdateDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final offsetFromOrigin = D4.getNamedArgWithDefault<Offset>(named, 'offsetFromOrigin', $dart_ui.Offset.zero);
        final localOffsetFromOrigin = D4.getOptionalNamedArg<Offset?>(named, 'localOffsetFromOrigin');
        return $flutter_18.LongPressMoveUpdateDetails(globalPosition: globalPosition, localPosition: localPosition, offsetFromOrigin: offsetFromOrigin, localOffsetFromOrigin: localOffsetFromOrigin);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').localPosition,
      'offsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').offsetFromOrigin,
      'localOffsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails').localOffsetFromOrigin,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressMoveUpdateDetails>(target, 'LongPressMoveUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressMoveUpdateDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Offset offsetFromOrigin = Offset.zero, Offset? localOffsetFromOrigin})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_18.LongPressEndDetails,
    name: 'LongPressEndDetails',
    isAssignable: (v) => v is $flutter_18.LongPressEndDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final velocity = D4.getNamedArgWithDefault<$flutter_31.Velocity>(named, 'velocity', $flutter_31.Velocity.zero);
        return $flutter_18.LongPressEndDetails(globalPosition: globalPosition, localPosition: localPosition, velocity: velocity);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressEndDetails>(target, 'LongPressEndDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressEndDetails>(target, 'LongPressEndDetails').localPosition,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_18.LongPressEndDetails>(target, 'LongPressEndDetails').velocity,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressEndDetails>(target, 'LongPressEndDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressEndDetails>(target, 'LongPressEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressEndDetails>(target, 'LongPressEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressEndDetails>(target, 'LongPressEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'const LongPressEndDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Velocity velocity = Velocity.zero})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_18.LongPressGestureRecognizer,
    name: 'LongPressGestureRecognizer',
    isAssignable: (v) => v is $flutter_18.LongPressGestureRecognizer,
    hierarchyDepth: 7,
    constructors: {
      '': (visitor, positional, named) {
        final duration = D4.getOptionalNamedArg<Duration?>(named, 'duration');
        final postAcceptSlopTolerance = D4.getNamedArgWithDefault<double?>(named, 'postAcceptSlopTolerance', null);
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_18.LongPressGestureRecognizer(duration: duration, postAcceptSlopTolerance: postAcceptSlopTolerance, supportedDevices: supportedDevices, debugOwner: debugOwner, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int));
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').team,
      'deadline': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').deadline,
      'preAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').preAcceptSlopTolerance,
      'postAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').postAcceptSlopTolerance,
      'state': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').state,
      'primaryPointer': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').primaryPointer,
      'initialPosition': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').initialPosition,
      'onLongPressDown': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressDown,
      'onLongPressCancel': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressCancel,
      'onLongPress': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPress,
      'onLongPressStart': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressStart,
      'onLongPressMoveUpdate': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressMoveUpdate,
      'onLongPressUp': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressUp,
      'onLongPressEnd': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressEnd,
      'onSecondaryLongPressDown': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressDown,
      'onSecondaryLongPressCancel': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressCancel,
      'onSecondaryLongPress': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPress,
      'onSecondaryLongPressStart': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressStart,
      'onSecondaryLongPressMoveUpdate': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressMoveUpdate,
      'onSecondaryLongPressUp': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressUp,
      'onSecondaryLongPressEnd': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressEnd,
      'onTertiaryLongPressDown': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressDown,
      'onTertiaryLongPressCancel': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressCancel,
      'onTertiaryLongPress': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPress,
      'onTertiaryLongPressStart': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressStart,
      'onTertiaryLongPressMoveUpdate': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressMoveUpdate,
      'onTertiaryLongPressUp': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressUp,
      'onTertiaryLongPressEnd': (visitor, target) => D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressEnd,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'onLongPressDown': (visitor, target, value) {
        final onLongPressDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPressDown');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressDown = onLongPressDownRaw == null ? null : ($flutter_18.LongPressDownDetails p0) { D4.callInterpreterCallback(visitor!, onLongPressDownRaw, [p0]); };
      },
      'onLongPressCancel': (visitor, target, value) {
        final onLongPressCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPressCancel');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressCancel = onLongPressCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onLongPressCancelRaw, []); };
      },
      'onLongPress': (visitor, target, value) {
        final onLongPressRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPress');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPress = onLongPressRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onLongPressRaw, []); };
      },
      'onLongPressStart': (visitor, target, value) {
        final onLongPressStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPressStart');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressStart = onLongPressStartRaw == null ? null : ($flutter_18.LongPressStartDetails p0) { D4.callInterpreterCallback(visitor!, onLongPressStartRaw, [p0]); };
      },
      'onLongPressMoveUpdate': (visitor, target, value) {
        final onLongPressMoveUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPressMoveUpdate');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressMoveUpdate = onLongPressMoveUpdateRaw == null ? null : ($flutter_18.LongPressMoveUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onLongPressMoveUpdateRaw, [p0]); };
      },
      'onLongPressUp': (visitor, target, value) {
        final onLongPressUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPressUp');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressUp = onLongPressUpRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onLongPressUpRaw, []); };
      },
      'onLongPressEnd': (visitor, target, value) {
        final onLongPressEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongPressEnd');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onLongPressEnd = onLongPressEndRaw == null ? null : ($flutter_18.LongPressEndDetails p0) { D4.callInterpreterCallback(visitor!, onLongPressEndRaw, [p0]); };
      },
      'onSecondaryLongPressDown': (visitor, target, value) {
        final onSecondaryLongPressDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryLongPressDown');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressDown = onSecondaryLongPressDownRaw == null ? null : ($flutter_18.LongPressDownDetails p0) { D4.callInterpreterCallback(visitor!, onSecondaryLongPressDownRaw, [p0]); };
      },
      'onSecondaryLongPressCancel': (visitor, target, value) {
        final onSecondaryLongPressCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryLongPressCancel');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressCancel = onSecondaryLongPressCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSecondaryLongPressCancelRaw, []); };
      },
      'onSecondaryLongPress': (visitor, target, value) {
        final onSecondaryLongPressRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryLongPress');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPress = onSecondaryLongPressRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSecondaryLongPressRaw, []); };
      },
      'onSecondaryLongPressStart': (visitor, target, value) {
        final onSecondaryLongPressStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryLongPressStart');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressStart = onSecondaryLongPressStartRaw == null ? null : ($flutter_18.LongPressStartDetails p0) { D4.callInterpreterCallback(visitor!, onSecondaryLongPressStartRaw, [p0]); };
      },
      'onSecondaryLongPressMoveUpdate': (visitor, target, value) {
        final onSecondaryLongPressMoveUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryLongPressMoveUpdate');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressMoveUpdate = onSecondaryLongPressMoveUpdateRaw == null ? null : ($flutter_18.LongPressMoveUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onSecondaryLongPressMoveUpdateRaw, [p0]); };
      },
      'onSecondaryLongPressUp': (visitor, target, value) {
        final onSecondaryLongPressUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryLongPressUp');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressUp = onSecondaryLongPressUpRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSecondaryLongPressUpRaw, []); };
      },
      'onSecondaryLongPressEnd': (visitor, target, value) {
        final onSecondaryLongPressEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryLongPressEnd');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onSecondaryLongPressEnd = onSecondaryLongPressEndRaw == null ? null : ($flutter_18.LongPressEndDetails p0) { D4.callInterpreterCallback(visitor!, onSecondaryLongPressEndRaw, [p0]); };
      },
      'onTertiaryLongPressDown': (visitor, target, value) {
        final onTertiaryLongPressDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryLongPressDown');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressDown = onTertiaryLongPressDownRaw == null ? null : ($flutter_18.LongPressDownDetails p0) { D4.callInterpreterCallback(visitor!, onTertiaryLongPressDownRaw, [p0]); };
      },
      'onTertiaryLongPressCancel': (visitor, target, value) {
        final onTertiaryLongPressCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryLongPressCancel');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressCancel = onTertiaryLongPressCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTertiaryLongPressCancelRaw, []); };
      },
      'onTertiaryLongPress': (visitor, target, value) {
        final onTertiaryLongPressRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryLongPress');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPress = onTertiaryLongPressRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTertiaryLongPressRaw, []); };
      },
      'onTertiaryLongPressStart': (visitor, target, value) {
        final onTertiaryLongPressStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryLongPressStart');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressStart = onTertiaryLongPressStartRaw == null ? null : ($flutter_18.LongPressStartDetails p0) { D4.callInterpreterCallback(visitor!, onTertiaryLongPressStartRaw, [p0]); };
      },
      'onTertiaryLongPressMoveUpdate': (visitor, target, value) {
        final onTertiaryLongPressMoveUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryLongPressMoveUpdate');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressMoveUpdate = onTertiaryLongPressMoveUpdateRaw == null ? null : ($flutter_18.LongPressMoveUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onTertiaryLongPressMoveUpdateRaw, [p0]); };
      },
      'onTertiaryLongPressUp': (visitor, target, value) {
        final onTertiaryLongPressUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryLongPressUp');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressUp = onTertiaryLongPressUpRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTertiaryLongPressUpRaw, []); };
      },
      'onTertiaryLongPressEnd': (visitor, target, value) {
        final onTertiaryLongPressEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryLongPressEnd');
        D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer').onTertiaryLongPressEnd = onTertiaryLongPressEndRaw == null ? null : ($flutter_18.LongPressEndDetails p0) { D4.callInterpreterCallback(visitor!, onTertiaryLongPressEndRaw, [p0]); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'handlePrimaryPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handlePrimaryPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handlePrimaryPointer');
        t.handlePrimaryPointer(event);
        return null;
      },
      'didExceedDeadline': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        t.didExceedDeadline();
        return null;
      },
      'didExceedDeadlineWithEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_18.LongPressGestureRecognizer>(target, 'LongPressGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didExceedDeadlineWithEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'didExceedDeadlineWithEvent');
        t.didExceedDeadlineWithEvent(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'LongPressGestureRecognizer({Duration? duration, double? postAcceptSlopTolerance = null, Set<PointerDeviceKind>? supportedDevices, Object? debugOwner, AllowedButtonsFilter? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'handlePrimaryPointer': 'void handlePrimaryPointer(PointerEvent event)',
      'didExceedDeadline': 'void didExceedDeadline()',
      'didExceedDeadlineWithEvent': 'void didExceedDeadlineWithEvent(PointerDownEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'deadline': 'Duration? get deadline',
      'preAcceptSlopTolerance': 'double? get preAcceptSlopTolerance',
      'postAcceptSlopTolerance': 'double? get postAcceptSlopTolerance',
      'state': 'GestureRecognizerState get state',
      'primaryPointer': 'int? get primaryPointer',
      'initialPosition': 'OffsetPair? get initialPosition',
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
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
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
    nativeType: $flutter_19.PolynomialFit,
    name: 'PolynomialFit',
    isAssignable: (v) => v is $flutter_19.PolynomialFit,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PolynomialFit');
        final degree = D4.getRequiredArg<int>(positional, 0, 'degree', 'PolynomialFit');
        return $flutter_19.PolynomialFit(degree);
      },
    },
    getters: {
      'coefficients': (visitor, target) => D4.validateTarget<$flutter_19.PolynomialFit>(target, 'PolynomialFit').coefficients,
      'confidence': (visitor, target) => D4.validateTarget<$flutter_19.PolynomialFit>(target, 'PolynomialFit').confidence,
    },
    setters: {
      'confidence': (visitor, target, value) => 
        D4.validateTarget<$flutter_19.PolynomialFit>(target, 'PolynomialFit').confidence = D4.extractBridgedArg<double>(value, 'confidence'),
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.PolynomialFit>(target, 'PolynomialFit');
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
    nativeType: $flutter_19.LeastSquaresSolver,
    name: 'LeastSquaresSolver',
    isAssignable: (v) => v is $flutter_19.LeastSquaresSolver,
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
        return $flutter_19.LeastSquaresSolver(x, y, w);
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$flutter_19.LeastSquaresSolver>(target, 'LeastSquaresSolver').x,
      'y': (visitor, target) => D4.validateTarget<$flutter_19.LeastSquaresSolver>(target, 'LeastSquaresSolver').y,
      'w': (visitor, target) => D4.validateTarget<$flutter_19.LeastSquaresSolver>(target, 'LeastSquaresSolver').w,
    },
    methods: {
      'solve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_19.LeastSquaresSolver>(target, 'LeastSquaresSolver');
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
    nativeType: $flutter_30.GestureArenaTeam,
    name: 'GestureArenaTeam',
    isAssignable: (v) => v is $flutter_30.GestureArenaTeam,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_30.GestureArenaTeam();
      },
    },
    getters: {
      'captain': (visitor, target) => D4.validateTarget<$flutter_30.GestureArenaTeam>(target, 'GestureArenaTeam').captain,
    },
    setters: {
      'captain': (visitor, target, value) => 
        D4.validateTarget<$flutter_30.GestureArenaTeam>(target, 'GestureArenaTeam').captain = D4.extractBridgedArgOrNull<$flutter_5.GestureArenaMember>(value, 'captain'),
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_30.GestureArenaTeam>(target, 'GestureArenaTeam');
        D4.requireMinArgs(positional, 2, 'add');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'add');
        final member = D4.getRequiredArg<$flutter_5.GestureArenaMember>(positional, 1, 'member', 'add');
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
// GestureRecognizer Bridge
// =============================================================================

BridgedClass _createGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_25.GestureRecognizer,
    name: 'GestureRecognizer',
    isAssignable: (v) => v is $flutter_25.GestureRecognizer,
    hierarchyDepth: 4,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer').debugDescription,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.GestureRecognizer>(target, 'GestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(dynamic value)',
      'supportedDevices': 'set supportedDevices(dynamic value)',
    },
  );
}

// =============================================================================
// OneSequenceGestureRecognizer Bridge
// =============================================================================

BridgedClass _createOneSequenceGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_25.OneSequenceGestureRecognizer,
    name: 'OneSequenceGestureRecognizer',
    isAssignable: (v) => v is $flutter_25.OneSequenceGestureRecognizer,
    hierarchyDepth: 5,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').team,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OneSequenceGestureRecognizer>(target, 'OneSequenceGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
    },
  );
}

// =============================================================================
// PrimaryPointerGestureRecognizer Bridge
// =============================================================================

BridgedClass _createPrimaryPointerGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_25.PrimaryPointerGestureRecognizer,
    name: 'PrimaryPointerGestureRecognizer',
    isAssignable: (v) => v is $flutter_25.PrimaryPointerGestureRecognizer,
    hierarchyDepth: 6,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').team,
      'deadline': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').deadline,
      'preAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').preAcceptSlopTolerance,
      'postAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').postAcceptSlopTolerance,
      'state': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').state,
      'primaryPointer': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').primaryPointer,
      'initialPosition': (visitor, target) => D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').initialPosition,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'handlePrimaryPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handlePrimaryPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handlePrimaryPointer');
        t.handlePrimaryPointer(event);
        return null;
      },
      'didExceedDeadline': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        t.didExceedDeadline();
        return null;
      },
      'didExceedDeadlineWithEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.PrimaryPointerGestureRecognizer>(target, 'PrimaryPointerGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didExceedDeadlineWithEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'didExceedDeadlineWithEvent');
        t.didExceedDeadlineWithEvent(event);
        return null;
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'handlePrimaryPointer': 'void handlePrimaryPointer(PointerEvent event)',
      'didExceedDeadline': 'void didExceedDeadline()',
      'didExceedDeadlineWithEvent': 'void didExceedDeadlineWithEvent(PointerDownEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'deadline': 'Duration? get deadline',
      'preAcceptSlopTolerance': 'double? get preAcceptSlopTolerance',
      'postAcceptSlopTolerance': 'double? get postAcceptSlopTolerance',
      'state': 'GestureRecognizerState get state',
      'primaryPointer': 'int? get primaryPointer',
      'initialPosition': 'OffsetPair? get initialPosition',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
    },
  );
}

// =============================================================================
// OffsetPair Bridge
// =============================================================================

BridgedClass _createOffsetPairBridge() {
  return BridgedClass(
    nativeType: $flutter_25.OffsetPair,
    name: 'OffsetPair',
    isAssignable: (v) => v is $flutter_25.OffsetPair,
    constructors: {
      '': (visitor, positional, named) {
        final local = D4.getRequiredNamedArg<Offset>(named, 'local', 'OffsetPair');
        final global = D4.getRequiredNamedArg<Offset>(named, 'global', 'OffsetPair');
        return $flutter_25.OffsetPair(local: local, global: global);
      },
      'fromEventPosition': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OffsetPair');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'OffsetPair');
        return $flutter_25.OffsetPair.fromEventPosition(event);
      },
      'fromEventDelta': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OffsetPair');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'OffsetPair');
        return $flutter_25.OffsetPair.fromEventDelta(event);
      },
    },
    getters: {
      'local': (visitor, target) => D4.validateTarget<$flutter_25.OffsetPair>(target, 'OffsetPair').local,
      'global': (visitor, target) => D4.validateTarget<$flutter_25.OffsetPair>(target, 'OffsetPair').global,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OffsetPair>(target, 'OffsetPair');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OffsetPair>(target, 'OffsetPair');
        final other = D4.getRequiredArg<$flutter_25.OffsetPair>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_25.OffsetPair>(target, 'OffsetPair');
        final other = D4.getRequiredArg<$flutter_25.OffsetPair>(positional, 0, 'other', 'operator-');
        return t - other;
      },
    },
    staticGetters: {
      'zero': (visitor) => $flutter_25.OffsetPair.zero,
    },
    constructorSignatures: {
      '': 'const OffsetPair({required Offset local, required Offset global})',
      'fromEventPosition': 'OffsetPair.fromEventPosition(PointerEvent event)',
      'fromEventDelta': 'OffsetPair.fromEventDelta(PointerEvent event)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'local': 'Offset get local',
      'global': 'Offset get global',
    },
    staticGetterSignatures: {
      'zero': 'OffsetPair get zero',
    },
  );
}

// =============================================================================
// DragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.DragGestureRecognizer,
    name: 'DragGestureRecognizer',
    isAssignable: (v) => v is $flutter_20.DragGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').lastPosition,
      'debugLastPendingEventTimestamp': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').debugLastPendingEventTimestamp,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').globalDistanceMoved,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').multitouchDragStrategy = D4.extractBridgedArg<$flutter_25.MultitouchDragStrategy>(value, 'multitouchDragStrategy'),
      'onDown': (visitor, target, value) {
        final onDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDown');
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onDown = onDownRaw == null ? null : ($flutter_11.DragDownDetails p0) { D4.callInterpreterCallback(visitor!, onDownRaw, [p0]); };
      },
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onStart = onStartRaw == null ? null : ($flutter_11.DragStartDetails p0) { D4.callInterpreterCallback(visitor!, onStartRaw, [p0]); };
      },
      'onUpdate': (visitor, target, value) {
        final onUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onUpdate');
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onUpdate = onUpdateRaw == null ? null : ($flutter_11.DragUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onUpdateRaw, [p0]); };
      },
      'onEnd': (visitor, target, value) {
        final onEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onEnd');
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onEnd = onEndRaw == null ? null : ($flutter_11.DragEndDetails p0) { D4.callInterpreterCallback(visitor!, onEndRaw, [p0]); };
      },
      'onCancel': (visitor, target, value) {
        final onCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCancel');
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onCancel = onCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCancelRaw, []); };
      },
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingDistance = D4.extractBridgedArgOrNull<double>(value, 'minFlingDistance'),
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').minFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'minFlingVelocity'),
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').maxFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'maxFlingVelocity'),
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').onlyAcceptDragOnThreshold = D4.extractBridgedArg<bool>(value, 'onlyAcceptDragOnThreshold'),
      'velocityTrackerBuilder': (visitor, target, value) {
        final velocityTrackerBuilderRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'velocityTrackerBuilder');
        D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer').velocityTrackerBuilder = (($flutter_13.PointerEvent p0) { return D4.extractBridgedArg<$flutter_31.VelocityTracker>(D4.callInterpreterCallback(visitor!, velocityTrackerBuilderRaw, [p0]), 'callback', visitor) as $flutter_31.VelocityTracker; }) as $flutter_31.VelocityTracker Function($flutter_13.PointerEvent);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.DragGestureRecognizer>(target, 'DragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
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
      'debugLastPendingEventTimestamp': 'Duration? get debugLastPendingEventTimestamp',
      'globalDistanceMoved': 'double get globalDistanceMoved',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
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
    nativeType: $flutter_20.VerticalDragGestureRecognizer,
    name: 'VerticalDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_20.VerticalDragGestureRecognizer,
    hierarchyDepth: 7,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_20.VerticalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_20.VerticalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').lastPosition,
      'debugLastPendingEventTimestamp': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').debugLastPendingEventTimestamp,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').globalDistanceMoved,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').multitouchDragStrategy = D4.extractBridgedArg<$flutter_25.MultitouchDragStrategy>(value, 'multitouchDragStrategy'),
      'onDown': (visitor, target, value) {
        final onDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDown');
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onDown = onDownRaw == null ? null : ($flutter_11.DragDownDetails p0) { D4.callInterpreterCallback(visitor!, onDownRaw, [p0]); };
      },
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onStart = onStartRaw == null ? null : ($flutter_11.DragStartDetails p0) { D4.callInterpreterCallback(visitor!, onStartRaw, [p0]); };
      },
      'onUpdate': (visitor, target, value) {
        final onUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onUpdate');
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onUpdate = onUpdateRaw == null ? null : ($flutter_11.DragUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onUpdateRaw, [p0]); };
      },
      'onEnd': (visitor, target, value) {
        final onEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onEnd');
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onEnd = onEndRaw == null ? null : ($flutter_11.DragEndDetails p0) { D4.callInterpreterCallback(visitor!, onEndRaw, [p0]); };
      },
      'onCancel': (visitor, target, value) {
        final onCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCancel');
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onCancel = onCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCancelRaw, []); };
      },
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingDistance = D4.extractBridgedArgOrNull<double>(value, 'minFlingDistance'),
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').minFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'minFlingVelocity'),
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').maxFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'maxFlingVelocity'),
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').onlyAcceptDragOnThreshold = D4.extractBridgedArg<bool>(value, 'onlyAcceptDragOnThreshold'),
      'velocityTrackerBuilder': (visitor, target, value) {
        final velocityTrackerBuilderRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'velocityTrackerBuilder');
        D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer').velocityTrackerBuilder = (($flutter_13.PointerEvent p0) { return D4.extractBridgedArg<$flutter_31.VelocityTracker>(D4.callInterpreterCallback(visitor!, velocityTrackerBuilderRaw, [p0]), 'callback', visitor) as $flutter_31.VelocityTracker; }) as $flutter_31.VelocityTracker Function($flutter_13.PointerEvent);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.VerticalDragGestureRecognizer>(target, 'VerticalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
    },
    constructorSignatures: {
      '': 'VerticalDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
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
      'debugLastPendingEventTimestamp': 'Duration? get debugLastPendingEventTimestamp',
      'globalDistanceMoved': 'double get globalDistanceMoved',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
      'dragStartBehavior': 'set dragStartBehavior(DragStartBehavior value)',
      'multitouchDragStrategy': 'set multitouchDragStrategy(MultitouchDragStrategy value)',
      'onDown': 'set onDown(GestureDragDownCallback? value)',
      'onStart': 'set onStart(GestureDragStartCallback? value)',
      'onUpdate': 'set onUpdate(GestureDragUpdateCallback? value)',
      'onEnd': 'set onEnd(GestureDragEndCallback? value)',
      'onCancel': 'set onCancel(GestureDragCancelCallback? value)',
      'minFlingDistance': 'set minFlingDistance(double? value)',
      'minFlingVelocity': 'set minFlingVelocity(double? value)',
      'maxFlingVelocity': 'set maxFlingVelocity(double? value)',
      'onlyAcceptDragOnThreshold': 'set onlyAcceptDragOnThreshold(bool value)',
      'velocityTrackerBuilder': 'set velocityTrackerBuilder(GestureVelocityTrackerBuilder value)',
    },
  );
}

// =============================================================================
// HorizontalDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createHorizontalDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.HorizontalDragGestureRecognizer,
    name: 'HorizontalDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_20.HorizontalDragGestureRecognizer,
    hierarchyDepth: 7,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_20.HorizontalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_20.HorizontalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').lastPosition,
      'debugLastPendingEventTimestamp': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').debugLastPendingEventTimestamp,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').globalDistanceMoved,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').multitouchDragStrategy = D4.extractBridgedArg<$flutter_25.MultitouchDragStrategy>(value, 'multitouchDragStrategy'),
      'onDown': (visitor, target, value) {
        final onDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDown');
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onDown = onDownRaw == null ? null : ($flutter_11.DragDownDetails p0) { D4.callInterpreterCallback(visitor!, onDownRaw, [p0]); };
      },
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onStart = onStartRaw == null ? null : ($flutter_11.DragStartDetails p0) { D4.callInterpreterCallback(visitor!, onStartRaw, [p0]); };
      },
      'onUpdate': (visitor, target, value) {
        final onUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onUpdate');
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onUpdate = onUpdateRaw == null ? null : ($flutter_11.DragUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onUpdateRaw, [p0]); };
      },
      'onEnd': (visitor, target, value) {
        final onEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onEnd');
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onEnd = onEndRaw == null ? null : ($flutter_11.DragEndDetails p0) { D4.callInterpreterCallback(visitor!, onEndRaw, [p0]); };
      },
      'onCancel': (visitor, target, value) {
        final onCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCancel');
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onCancel = onCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCancelRaw, []); };
      },
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingDistance = D4.extractBridgedArgOrNull<double>(value, 'minFlingDistance'),
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').minFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'minFlingVelocity'),
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').maxFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'maxFlingVelocity'),
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').onlyAcceptDragOnThreshold = D4.extractBridgedArg<bool>(value, 'onlyAcceptDragOnThreshold'),
      'velocityTrackerBuilder': (visitor, target, value) {
        final velocityTrackerBuilderRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'velocityTrackerBuilder');
        D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer').velocityTrackerBuilder = (($flutter_13.PointerEvent p0) { return D4.extractBridgedArg<$flutter_31.VelocityTracker>(D4.callInterpreterCallback(visitor!, velocityTrackerBuilderRaw, [p0]), 'callback', visitor) as $flutter_31.VelocityTracker; }) as $flutter_31.VelocityTracker Function($flutter_13.PointerEvent);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.HorizontalDragGestureRecognizer>(target, 'HorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
    },
    constructorSignatures: {
      '': 'HorizontalDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
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
      'debugLastPendingEventTimestamp': 'Duration? get debugLastPendingEventTimestamp',
      'globalDistanceMoved': 'double get globalDistanceMoved',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
      'dragStartBehavior': 'set dragStartBehavior(DragStartBehavior value)',
      'multitouchDragStrategy': 'set multitouchDragStrategy(MultitouchDragStrategy value)',
      'onDown': 'set onDown(GestureDragDownCallback? value)',
      'onStart': 'set onStart(GestureDragStartCallback? value)',
      'onUpdate': 'set onUpdate(GestureDragUpdateCallback? value)',
      'onEnd': 'set onEnd(GestureDragEndCallback? value)',
      'onCancel': 'set onCancel(GestureDragCancelCallback? value)',
      'minFlingDistance': 'set minFlingDistance(double? value)',
      'minFlingVelocity': 'set minFlingVelocity(double? value)',
      'maxFlingVelocity': 'set maxFlingVelocity(double? value)',
      'onlyAcceptDragOnThreshold': 'set onlyAcceptDragOnThreshold(bool value)',
      'velocityTrackerBuilder': 'set velocityTrackerBuilder(GestureVelocityTrackerBuilder value)',
    },
  );
}

// =============================================================================
// PanGestureRecognizer Bridge
// =============================================================================

BridgedClass _createPanGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_20.PanGestureRecognizer,
    name: 'PanGestureRecognizer',
    isAssignable: (v) => v is $flutter_20.PanGestureRecognizer,
    hierarchyDepth: 7,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_20.PanGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_20.PanGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').dragStartBehavior,
      'multitouchDragStrategy': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').multitouchDragStrategy,
      'onDown': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onDown,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onCancel,
      'minFlingDistance': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingDistance,
      'minFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingVelocity,
      'maxFlingVelocity': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').maxFlingVelocity,
      'onlyAcceptDragOnThreshold': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onlyAcceptDragOnThreshold,
      'velocityTrackerBuilder': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').velocityTrackerBuilder,
      'lastPosition': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').lastPosition,
      'debugLastPendingEventTimestamp': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').debugLastPendingEventTimestamp,
      'globalDistanceMoved': (visitor, target) => D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').globalDistanceMoved,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'multitouchDragStrategy': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').multitouchDragStrategy = D4.extractBridgedArg<$flutter_25.MultitouchDragStrategy>(value, 'multitouchDragStrategy'),
      'onDown': (visitor, target, value) {
        final onDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDown');
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onDown = onDownRaw == null ? null : ($flutter_11.DragDownDetails p0) { D4.callInterpreterCallback(visitor!, onDownRaw, [p0]); };
      },
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onStart = onStartRaw == null ? null : ($flutter_11.DragStartDetails p0) { D4.callInterpreterCallback(visitor!, onStartRaw, [p0]); };
      },
      'onUpdate': (visitor, target, value) {
        final onUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onUpdate');
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onUpdate = onUpdateRaw == null ? null : ($flutter_11.DragUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onUpdateRaw, [p0]); };
      },
      'onEnd': (visitor, target, value) {
        final onEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onEnd');
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onEnd = onEndRaw == null ? null : ($flutter_11.DragEndDetails p0) { D4.callInterpreterCallback(visitor!, onEndRaw, [p0]); };
      },
      'onCancel': (visitor, target, value) {
        final onCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCancel');
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onCancel = onCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCancelRaw, []); };
      },
      'minFlingDistance': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingDistance = D4.extractBridgedArgOrNull<double>(value, 'minFlingDistance'),
      'minFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').minFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'minFlingVelocity'),
      'maxFlingVelocity': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').maxFlingVelocity = D4.extractBridgedArgOrNull<double>(value, 'maxFlingVelocity'),
      'onlyAcceptDragOnThreshold': (visitor, target, value) => 
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').onlyAcceptDragOnThreshold = D4.extractBridgedArg<bool>(value, 'onlyAcceptDragOnThreshold'),
      'velocityTrackerBuilder': (visitor, target, value) {
        final velocityTrackerBuilderRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'velocityTrackerBuilder');
        D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer').velocityTrackerBuilder = (($flutter_13.PointerEvent p0) { return D4.extractBridgedArg<$flutter_31.VelocityTracker>(D4.callInterpreterCallback(visitor!, velocityTrackerBuilderRaw, [p0]), 'callback', visitor) as $flutter_31.VelocityTracker; }) as $flutter_31.VelocityTracker Function($flutter_13.PointerEvent);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'isFlingGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'isFlingGesture');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'isFlingGesture');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'isFlingGesture');
        return t.isFlingGesture(estimate, kind);
      },
      'considerFling': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'considerFling');
        final estimate = D4.getRequiredArg<$flutter_31.VelocityEstimate>(positional, 0, 'estimate', 'considerFling');
        final kind = D4.getRequiredArg<PointerDeviceKind>(positional, 1, 'kind', 'considerFling');
        return t.considerFling(estimate, kind);
      },
      'hasSufficientGlobalDistanceToAccept': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_20.PanGestureRecognizer>(target, 'PanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'hasSufficientGlobalDistanceToAccept');
        final pointerDeviceKind = D4.getRequiredArg<PointerDeviceKind>(positional, 0, 'pointerDeviceKind', 'hasSufficientGlobalDistanceToAccept');
        final deviceTouchSlop = D4.getRequiredArg<double?>(positional, 1, 'deviceTouchSlop', 'hasSufficientGlobalDistanceToAccept');
        return t.hasSufficientGlobalDistanceToAccept(pointerDeviceKind, deviceTouchSlop);
      },
    },
    constructorSignatures: {
      '': 'PanGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'isFlingGesture': 'bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind)',
      'considerFling': 'DragEndDetails? considerFling(VelocityEstimate estimate, PointerDeviceKind kind)',
      'hasSufficientGlobalDistanceToAccept': 'bool hasSufficientGlobalDistanceToAccept(PointerDeviceKind pointerDeviceKind, double? deviceTouchSlop)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
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
      'debugLastPendingEventTimestamp': 'Duration? get debugLastPendingEventTimestamp',
      'globalDistanceMoved': 'double get globalDistanceMoved',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
      'dragStartBehavior': 'set dragStartBehavior(DragStartBehavior value)',
      'multitouchDragStrategy': 'set multitouchDragStrategy(MultitouchDragStrategy value)',
      'onDown': 'set onDown(GestureDragDownCallback? value)',
      'onStart': 'set onStart(GestureDragStartCallback? value)',
      'onUpdate': 'set onUpdate(GestureDragUpdateCallback? value)',
      'onEnd': 'set onEnd(GestureDragEndCallback? value)',
      'onCancel': 'set onCancel(GestureDragCancelCallback? value)',
      'minFlingDistance': 'set minFlingDistance(double? value)',
      'minFlingVelocity': 'set minFlingVelocity(double? value)',
      'maxFlingVelocity': 'set maxFlingVelocity(double? value)',
      'onlyAcceptDragOnThreshold': 'set onlyAcceptDragOnThreshold(bool value)',
      'velocityTrackerBuilder': 'set velocityTrackerBuilder(GestureVelocityTrackerBuilder value)',
    },
  );
}

// =============================================================================
// MultiDragPointerState Bridge
// =============================================================================

BridgedClass _createMultiDragPointerStateBridge() {
  return BridgedClass(
    nativeType: $flutter_21.MultiDragPointerState,
    name: 'MultiDragPointerState',
    isAssignable: (v) => v is $flutter_21.MultiDragPointerState,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState').gestureSettings,
      'initialPosition': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState').initialPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState').kind,
      'pendingDelta': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState').pendingDelta,
    },
    methods: {
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'checkForResolutionAfterMove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState');
        t.checkForResolutionAfterMove();
        return null;
      },
      'accepted': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState');
        D4.requireMinArgs(positional, 1, 'accepted');
        if (positional.isEmpty) {
          throw ArgumentError('accepted: Missing required argument "starter" at position 0');
        }
        final starterRaw = positional[0];
        t.accepted(((Offset p0) { return D4.extractBridgedArg<$flutter_10.Drag?>(D4.callInterpreterCallback(visitor!, starterRaw, [p0]), 'callback', visitor) as $flutter_10.Drag?; }) as $flutter_10.Drag? Function(Offset));
        return null;
      },
      'rejected': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState');
        t.rejected();
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragPointerState>(target, 'MultiDragPointerState');
        (t as dynamic).dispose();
        return null;
      },
    },
    methodSignatures: {
      'resolve': 'void resolve(GestureDisposition disposition)',
      'checkForResolutionAfterMove': 'void checkForResolutionAfterMove()',
      'accepted': 'void accepted(GestureMultiDragStartCallback starter)',
      'rejected': 'void rejected()',
      'dispose': 'void dispose()',
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
    nativeType: $flutter_21.MultiDragGestureRecognizer,
    name: 'MultiDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_21.MultiDragGestureRecognizer,
    hierarchyDepth: 5,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').debugDescription,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').onStart,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer').onStart = onStartRaw == null ? null : ((Offset p0) { return D4.extractBridgedArg<$flutter_10.Drag?>(D4.callInterpreterCallback(visitor!, onStartRaw, [p0]), 'callback', visitor) as $flutter_10.Drag?; }) as $flutter_10.Drag? Function(Offset);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'createNewPointerState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.MultiDragGestureRecognizer>(target, 'MultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'createNewPointerState');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'createNewPointerState');
        return t.createNewPointerState(event);
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'createNewPointerState': 'MultiDragPointerState createNewPointerState(PointerDownEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onStart': 'GestureMultiDragStartCallback? get onStart',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'onStart': 'set onStart(dynamic value)',
    },
  );
}

// =============================================================================
// ImmediateMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createImmediateMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_21.ImmediateMultiDragGestureRecognizer,
    name: 'ImmediateMultiDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_21.ImmediateMultiDragGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_21.ImmediateMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int));
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').debugDescription,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').onStart,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer').onStart = onStartRaw == null ? null : ((Offset p0) { return D4.extractBridgedArg<$flutter_10.Drag?>(D4.callInterpreterCallback(visitor!, onStartRaw, [p0]), 'callback', visitor) as $flutter_10.Drag?; }) as $flutter_10.Drag? Function(Offset);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'createNewPointerState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.ImmediateMultiDragGestureRecognizer>(target, 'ImmediateMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'createNewPointerState');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'createNewPointerState');
        return t.createNewPointerState(event);
      },
    },
    constructorSignatures: {
      '': 'ImmediateMultiDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'createNewPointerState': 'MultiDragPointerState createNewPointerState(PointerDownEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onStart': 'GestureMultiDragStartCallback? get onStart',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'onStart': 'set onStart(GestureMultiDragStartCallback? value)',
    },
  );
}

// =============================================================================
// HorizontalMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createHorizontalMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_21.HorizontalMultiDragGestureRecognizer,
    name: 'HorizontalMultiDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_21.HorizontalMultiDragGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_21.HorizontalMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int));
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').debugDescription,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').onStart,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer').onStart = onStartRaw == null ? null : ((Offset p0) { return D4.extractBridgedArg<$flutter_10.Drag?>(D4.callInterpreterCallback(visitor!, onStartRaw, [p0]), 'callback', visitor) as $flutter_10.Drag?; }) as $flutter_10.Drag? Function(Offset);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'createNewPointerState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.HorizontalMultiDragGestureRecognizer>(target, 'HorizontalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'createNewPointerState');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'createNewPointerState');
        return t.createNewPointerState(event);
      },
    },
    constructorSignatures: {
      '': 'HorizontalMultiDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'createNewPointerState': 'MultiDragPointerState createNewPointerState(PointerDownEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onStart': 'GestureMultiDragStartCallback? get onStart',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'onStart': 'set onStart(GestureMultiDragStartCallback? value)',
    },
  );
}

// =============================================================================
// VerticalMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createVerticalMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_21.VerticalMultiDragGestureRecognizer,
    name: 'VerticalMultiDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_21.VerticalMultiDragGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        return $flutter_21.VerticalMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int));
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').debugDescription,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').onStart,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer').onStart = onStartRaw == null ? null : ((Offset p0) { return D4.extractBridgedArg<$flutter_10.Drag?>(D4.callInterpreterCallback(visitor!, onStartRaw, [p0]), 'callback', visitor) as $flutter_10.Drag?; }) as $flutter_10.Drag? Function(Offset);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'createNewPointerState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.VerticalMultiDragGestureRecognizer>(target, 'VerticalMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'createNewPointerState');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'createNewPointerState');
        return t.createNewPointerState(event);
      },
    },
    constructorSignatures: {
      '': 'VerticalMultiDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'createNewPointerState': 'MultiDragPointerState createNewPointerState(PointerDownEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onStart': 'GestureMultiDragStartCallback? get onStart',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'onStart': 'set onStart(GestureMultiDragStartCallback? value)',
    },
  );
}

// =============================================================================
// DelayedMultiDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createDelayedMultiDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_21.DelayedMultiDragGestureRecognizer,
    name: 'DelayedMultiDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_21.DelayedMultiDragGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
        if (!named.containsKey('delay')) {
          return $flutter_21.DelayedMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int));
        }
        if (named.containsKey('delay')) {
          final delay = D4.getRequiredNamedArg<Duration>(named, 'delay', 'DelayedMultiDragGestureRecognizer');
          return $flutter_21.DelayedMultiDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilterRaw == null ? null : ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int), delay: delay);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').debugDescription,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').onStart,
      'delay': (visitor, target) => D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').delay,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer').onStart = onStartRaw == null ? null : ((Offset p0) { return D4.extractBridgedArg<$flutter_10.Drag?>(D4.callInterpreterCallback(visitor!, onStartRaw, [p0]), 'callback', visitor) as $flutter_10.Drag?; }) as $flutter_10.Drag? Function(Offset);
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'createNewPointerState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_21.DelayedMultiDragGestureRecognizer>(target, 'DelayedMultiDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'createNewPointerState');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'createNewPointerState');
        return t.createNewPointerState(event);
      },
    },
    constructorSignatures: {
      '': 'DelayedMultiDragGestureRecognizer({Duration delay = kLongPressTimeout, Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter? allowedButtonsFilter})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'createNewPointerState': 'MultiDragPointerState createNewPointerState(PointerDownEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onStart': 'GestureMultiDragStartCallback? get onStart',
      'delay': 'Duration get delay',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'onStart': 'set onStart(GestureMultiDragStartCallback? value)',
    },
  );
}

// =============================================================================
// TapDownDetails Bridge
// =============================================================================

BridgedClass _createTapDownDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapDownDetails,
    name: 'TapDownDetails',
    isAssignable: (v) => v is $flutter_28.TapDownDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_28.TapDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDownDetails>(target, 'TapDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapDownDetails>(target, 'TapDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.TapDownDetails>(target, 'TapDownDetails').kind,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDownDetails>(target, 'TapDownDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDownDetails>(target, 'TapDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDownDetails>(target, 'TapDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapDownDetails>(target, 'TapDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDownDetails({Offset globalPosition = Offset.zero, Offset? localPosition, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_28.TapUpDetails,
    name: 'TapUpDetails',
    isAssignable: (v) => v is $flutter_28.TapUpDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getRequiredNamedArg<PointerDeviceKind>(named, 'kind', 'TapUpDetails');
        return $flutter_28.TapUpDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapUpDetails>(target, 'TapUpDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapUpDetails>(target, 'TapUpDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.TapUpDetails>(target, 'TapUpDetails').kind,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapUpDetails>(target, 'TapUpDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapUpDetails>(target, 'TapUpDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapUpDetails>(target, 'TapUpDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapUpDetails>(target, 'TapUpDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapUpDetails({Offset globalPosition = Offset.zero, Offset? localPosition, required PointerDeviceKind kind})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
// TapMoveDetails Bridge
// =============================================================================

BridgedClass _createTapMoveDetailsBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapMoveDetails,
    name: 'TapMoveDetails',
    isAssignable: (v) => v is $flutter_28.TapMoveDetails,
    constructors: {
      '': (visitor, positional, named) {
        final kind = D4.getRequiredNamedArg<PointerDeviceKind>(named, 'kind', 'TapMoveDetails');
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final delta = D4.getNamedArgWithDefault<Offset>(named, 'delta', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        return $flutter_28.TapMoveDetails(kind: kind, globalPosition: globalPosition, delta: delta, localPosition: localPosition);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapMoveDetails>(target, 'TapMoveDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapMoveDetails>(target, 'TapMoveDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_28.TapMoveDetails>(target, 'TapMoveDetails').kind,
      'delta': (visitor, target) => D4.validateTarget<$flutter_28.TapMoveDetails>(target, 'TapMoveDetails').delta,
    },
    constructorSignatures: {
      '': 'TapMoveDetails({required PointerDeviceKind kind, Offset globalPosition = Offset.zero, Offset delta = Offset.zero, Offset? localPosition})',
    },
    getterSignatures: {
      'globalPosition': 'Offset get globalPosition',
      'localPosition': 'Offset get localPosition',
      'kind': 'PointerDeviceKind get kind',
      'delta': 'Offset get delta',
    },
  );
}

// =============================================================================
// BaseTapGestureRecognizer Bridge
// =============================================================================

BridgedClass _createBaseTapGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_28.BaseTapGestureRecognizer,
    name: 'BaseTapGestureRecognizer',
    isAssignable: (v) => v is $flutter_28.BaseTapGestureRecognizer,
    hierarchyDepth: 7,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').team,
      'deadline': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').deadline,
      'preAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').preAcceptSlopTolerance,
      'postAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').postAcceptSlopTolerance,
      'state': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').state,
      'primaryPointer': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').primaryPointer,
      'initialPosition': (visitor, target) => D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').initialPosition,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'handlePrimaryPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handlePrimaryPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handlePrimaryPointer');
        t.handlePrimaryPointer(event);
        return null;
      },
      'didExceedDeadline': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        t.didExceedDeadline();
        return null;
      },
      'didExceedDeadlineWithEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didExceedDeadlineWithEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'didExceedDeadlineWithEvent');
        t.didExceedDeadlineWithEvent(event);
        return null;
      },
      'handleTapDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final down = D4.getRequiredNamedArg<$flutter_13.PointerDownEvent>(named, 'down', 'handleTapDown');
        t.handleTapDown(down: down);
        return null;
      },
      'handleTapUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final down = D4.getRequiredNamedArg<$flutter_13.PointerDownEvent>(named, 'down', 'handleTapUp');
        final up = D4.getRequiredNamedArg<$flutter_13.PointerUpEvent>(named, 'up', 'handleTapUp');
        t.handleTapUp(down: down, up: up);
        return null;
      },
      'handleTapMove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final move = D4.getRequiredNamedArg<$flutter_13.PointerMoveEvent>(named, 'move', 'handleTapMove');
        t.handleTapMove(move: move);
        return null;
      },
      'handleTapCancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.BaseTapGestureRecognizer>(target, 'BaseTapGestureRecognizer');
        final down = D4.getRequiredNamedArg<$flutter_13.PointerDownEvent>(named, 'down', 'handleTapCancel');
        final cancel = D4.getOptionalNamedArg<$flutter_13.PointerCancelEvent?>(named, 'cancel');
        final reason = D4.getRequiredNamedArg<String>(named, 'reason', 'handleTapCancel');
        t.handleTapCancel(down: down, cancel: cancel, reason: reason);
        return null;
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'handlePrimaryPointer': 'void handlePrimaryPointer(PointerEvent event)',
      'didExceedDeadline': 'void didExceedDeadline()',
      'didExceedDeadlineWithEvent': 'void didExceedDeadlineWithEvent(PointerDownEvent event)',
      'handleTapDown': 'void handleTapDown({required PointerDownEvent down})',
      'handleTapUp': 'void handleTapUp({required PointerDownEvent down, required PointerUpEvent up})',
      'handleTapMove': 'void handleTapMove({required PointerMoveEvent move})',
      'handleTapCancel': 'void handleTapCancel({required PointerDownEvent down, PointerCancelEvent? cancel, required String reason})',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'deadline': 'Duration? get deadline',
      'preAcceptSlopTolerance': 'double? get preAcceptSlopTolerance',
      'postAcceptSlopTolerance': 'double? get postAcceptSlopTolerance',
      'state': 'GestureRecognizerState get state',
      'primaryPointer': 'int? get primaryPointer',
      'initialPosition': 'OffsetPair? get initialPosition',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
    },
  );
}

// =============================================================================
// TapGestureRecognizer Bridge
// =============================================================================

BridgedClass _createTapGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_28.TapGestureRecognizer,
    name: 'TapGestureRecognizer',
    isAssignable: (v) => v is $flutter_28.TapGestureRecognizer,
    hierarchyDepth: 8,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter') && !named.containsKey('preAcceptSlopTolerance') && !named.containsKey('postAcceptSlopTolerance')) {
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter') && !named.containsKey('preAcceptSlopTolerance') && !named.containsKey('postAcceptSlopTolerance')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        if (!named.containsKey('allowedButtonsFilter') && named.containsKey('preAcceptSlopTolerance') && !named.containsKey('postAcceptSlopTolerance')) {
          final preAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'preAcceptSlopTolerance', 'TapGestureRecognizer');
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, preAcceptSlopTolerance: preAcceptSlopTolerance);
        }
        if (named.containsKey('allowedButtonsFilter') && named.containsKey('preAcceptSlopTolerance') && !named.containsKey('postAcceptSlopTolerance')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          final preAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'preAcceptSlopTolerance', 'TapGestureRecognizer');
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter, preAcceptSlopTolerance: preAcceptSlopTolerance);
        }
        if (!named.containsKey('allowedButtonsFilter') && !named.containsKey('preAcceptSlopTolerance') && named.containsKey('postAcceptSlopTolerance')) {
          final postAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'postAcceptSlopTolerance', 'TapGestureRecognizer');
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, postAcceptSlopTolerance: postAcceptSlopTolerance);
        }
        if (named.containsKey('allowedButtonsFilter') && !named.containsKey('preAcceptSlopTolerance') && named.containsKey('postAcceptSlopTolerance')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          final postAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'postAcceptSlopTolerance', 'TapGestureRecognizer');
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter, postAcceptSlopTolerance: postAcceptSlopTolerance);
        }
        if (!named.containsKey('allowedButtonsFilter') && named.containsKey('preAcceptSlopTolerance') && named.containsKey('postAcceptSlopTolerance')) {
          final preAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'preAcceptSlopTolerance', 'TapGestureRecognizer');
          final postAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'postAcceptSlopTolerance', 'TapGestureRecognizer');
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, preAcceptSlopTolerance: preAcceptSlopTolerance, postAcceptSlopTolerance: postAcceptSlopTolerance);
        }
        if (named.containsKey('allowedButtonsFilter') && named.containsKey('preAcceptSlopTolerance') && named.containsKey('postAcceptSlopTolerance')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          final preAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'preAcceptSlopTolerance', 'TapGestureRecognizer');
          final postAcceptSlopTolerance = D4.getRequiredNamedArg<double?>(named, 'postAcceptSlopTolerance', 'TapGestureRecognizer');
          return $flutter_28.TapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter, preAcceptSlopTolerance: preAcceptSlopTolerance, postAcceptSlopTolerance: postAcceptSlopTolerance);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').team,
      'deadline': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').deadline,
      'preAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').preAcceptSlopTolerance,
      'postAcceptSlopTolerance': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').postAcceptSlopTolerance,
      'state': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').state,
      'primaryPointer': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').primaryPointer,
      'initialPosition': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').initialPosition,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapUp,
      'onTap': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTap,
      'onTapMove': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapMove,
      'onTapCancel': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapCancel,
      'onSecondaryTap': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTap,
      'onSecondaryTapDown': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTapDown,
      'onSecondaryTapUp': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTapUp,
      'onSecondaryTapCancel': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTapCancel,
      'onTertiaryTapDown': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTertiaryTapDown,
      'onTertiaryTapUp': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTertiaryTapUp,
      'onTertiaryTapCancel': (visitor, target) => D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTertiaryTapCancel,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'onTapDown': (visitor, target, value) {
        final onTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapDown');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapDown = onTapDownRaw == null ? null : ($flutter_28.TapDownDetails p0) { D4.callInterpreterCallback(visitor!, onTapDownRaw, [p0]); };
      },
      'onTapUp': (visitor, target, value) {
        final onTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapUp');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapUp = onTapUpRaw == null ? null : ($flutter_28.TapUpDetails p0) { D4.callInterpreterCallback(visitor!, onTapUpRaw, [p0]); };
      },
      'onTap': (visitor, target, value) {
        final onTapRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTap');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTap = onTapRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapRaw, []); };
      },
      'onTapMove': (visitor, target, value) {
        final onTapMoveRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapMove');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapMove = onTapMoveRaw == null ? null : ($flutter_28.TapMoveDetails p0) { D4.callInterpreterCallback(visitor!, onTapMoveRaw, [p0]); };
      },
      'onTapCancel': (visitor, target, value) {
        final onTapCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapCancel');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTapCancel = onTapCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapCancelRaw, []); };
      },
      'onSecondaryTap': (visitor, target, value) {
        final onSecondaryTapRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryTap');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTap = onSecondaryTapRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSecondaryTapRaw, []); };
      },
      'onSecondaryTapDown': (visitor, target, value) {
        final onSecondaryTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryTapDown');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTapDown = onSecondaryTapDownRaw == null ? null : ($flutter_28.TapDownDetails p0) { D4.callInterpreterCallback(visitor!, onSecondaryTapDownRaw, [p0]); };
      },
      'onSecondaryTapUp': (visitor, target, value) {
        final onSecondaryTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryTapUp');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTapUp = onSecondaryTapUpRaw == null ? null : ($flutter_28.TapUpDetails p0) { D4.callInterpreterCallback(visitor!, onSecondaryTapUpRaw, [p0]); };
      },
      'onSecondaryTapCancel': (visitor, target, value) {
        final onSecondaryTapCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSecondaryTapCancel');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onSecondaryTapCancel = onSecondaryTapCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onSecondaryTapCancelRaw, []); };
      },
      'onTertiaryTapDown': (visitor, target, value) {
        final onTertiaryTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryTapDown');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTertiaryTapDown = onTertiaryTapDownRaw == null ? null : ($flutter_28.TapDownDetails p0) { D4.callInterpreterCallback(visitor!, onTertiaryTapDownRaw, [p0]); };
      },
      'onTertiaryTapUp': (visitor, target, value) {
        final onTertiaryTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryTapUp');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTertiaryTapUp = onTertiaryTapUpRaw == null ? null : ($flutter_28.TapUpDetails p0) { D4.callInterpreterCallback(visitor!, onTertiaryTapUpRaw, [p0]); };
      },
      'onTertiaryTapCancel': (visitor, target, value) {
        final onTertiaryTapCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTertiaryTapCancel');
        D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer').onTertiaryTapCancel = onTertiaryTapCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTertiaryTapCancelRaw, []); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
      'handlePrimaryPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handlePrimaryPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handlePrimaryPointer');
        t.handlePrimaryPointer(event);
        return null;
      },
      'didExceedDeadline': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        t.didExceedDeadline();
        return null;
      },
      'didExceedDeadlineWithEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didExceedDeadlineWithEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'didExceedDeadlineWithEvent');
        t.didExceedDeadlineWithEvent(event);
        return null;
      },
      'handleTapDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final down = D4.getRequiredNamedArg<$flutter_13.PointerDownEvent>(named, 'down', 'handleTapDown');
        t.handleTapDown(down: down);
        return null;
      },
      'handleTapUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final down = D4.getRequiredNamedArg<$flutter_13.PointerDownEvent>(named, 'down', 'handleTapUp');
        final up = D4.getRequiredNamedArg<$flutter_13.PointerUpEvent>(named, 'up', 'handleTapUp');
        t.handleTapUp(down: down, up: up);
        return null;
      },
      'handleTapMove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final move = D4.getRequiredNamedArg<$flutter_13.PointerMoveEvent>(named, 'move', 'handleTapMove');
        t.handleTapMove(move: move);
        return null;
      },
      'handleTapCancel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_28.TapGestureRecognizer>(target, 'TapGestureRecognizer');
        final down = D4.getRequiredNamedArg<$flutter_13.PointerDownEvent>(named, 'down', 'handleTapCancel');
        final cancel = D4.getOptionalNamedArg<$flutter_13.PointerCancelEvent?>(named, 'cancel');
        final reason = D4.getRequiredNamedArg<String>(named, 'reason', 'handleTapCancel');
        t.handleTapCancel(down: down, cancel: cancel, reason: reason);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TapGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior, double? preAcceptSlopTolerance = _unsetTouchSlop, double? postAcceptSlopTolerance = _unsetTouchSlop})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
      'handlePrimaryPointer': 'void handlePrimaryPointer(PointerEvent event)',
      'didExceedDeadline': 'void didExceedDeadline()',
      'didExceedDeadlineWithEvent': 'void didExceedDeadlineWithEvent(PointerDownEvent event)',
      'handleTapDown': 'void handleTapDown({required PointerDownEvent down})',
      'handleTapUp': 'void handleTapUp({required PointerDownEvent down, required PointerUpEvent up})',
      'handleTapMove': 'void handleTapMove({required PointerMoveEvent move})',
      'handleTapCancel': 'void handleTapCancel({required PointerDownEvent down, PointerCancelEvent? cancel, required String reason})',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'deadline': 'Duration? get deadline',
      'preAcceptSlopTolerance': 'double? get preAcceptSlopTolerance',
      'postAcceptSlopTolerance': 'double? get postAcceptSlopTolerance',
      'state': 'GestureRecognizerState get state',
      'primaryPointer': 'int? get primaryPointer',
      'initialPosition': 'OffsetPair? get initialPosition',
      'onTapDown': 'GestureTapDownCallback? get onTapDown',
      'onTapUp': 'GestureTapUpCallback? get onTapUp',
      'onTap': 'GestureTapCallback? get onTap',
      'onTapMove': 'GestureTapMoveCallback? get onTapMove',
      'onTapCancel': 'GestureTapCancelCallback? get onTapCancel',
      'onSecondaryTap': 'GestureTapCallback? get onSecondaryTap',
      'onSecondaryTapDown': 'GestureTapDownCallback? get onSecondaryTapDown',
      'onSecondaryTapUp': 'GestureTapUpCallback? get onSecondaryTapUp',
      'onSecondaryTapCancel': 'GestureTapCancelCallback? get onSecondaryTapCancel',
      'onTertiaryTapDown': 'GestureTapDownCallback? get onTertiaryTapDown',
      'onTertiaryTapUp': 'GestureTapUpCallback? get onTertiaryTapUp',
      'onTertiaryTapCancel': 'GestureTapCancelCallback? get onTertiaryTapCancel',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
      'onTapDown': 'set onTapDown(dynamic value)',
      'onTapUp': 'set onTapUp(dynamic value)',
      'onTap': 'set onTap(dynamic value)',
      'onTapMove': 'set onTapMove(dynamic value)',
      'onTapCancel': 'set onTapCancel(dynamic value)',
      'onSecondaryTap': 'set onSecondaryTap(dynamic value)',
      'onSecondaryTapDown': 'set onSecondaryTapDown(dynamic value)',
      'onSecondaryTapUp': 'set onSecondaryTapUp(dynamic value)',
      'onSecondaryTapCancel': 'set onSecondaryTapCancel(dynamic value)',
      'onTertiaryTapDown': 'set onTertiaryTapDown(dynamic value)',
      'onTertiaryTapUp': 'set onTertiaryTapUp(dynamic value)',
      'onTertiaryTapCancel': 'set onTertiaryTapCancel(dynamic value)',
    },
  );
}

// =============================================================================
// DoubleTapGestureRecognizer Bridge
// =============================================================================

BridgedClass _createDoubleTapGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_22.DoubleTapGestureRecognizer,
    name: 'DoubleTapGestureRecognizer',
    isAssignable: (v) => v is $flutter_22.DoubleTapGestureRecognizer,
    hierarchyDepth: 5,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_22.DoubleTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_22.DoubleTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').debugDescription,
      'onDoubleTapDown': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapDown,
      'onDoubleTap': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTap,
      'onDoubleTapCancel': (visitor, target) => D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapCancel,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onDoubleTapDown': (visitor, target, value) {
        final onDoubleTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDoubleTapDown');
        D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapDown = onDoubleTapDownRaw == null ? null : ($flutter_28.TapDownDetails p0) { D4.callInterpreterCallback(visitor!, onDoubleTapDownRaw, [p0]); };
      },
      'onDoubleTap': (visitor, target, value) {
        final onDoubleTapRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDoubleTap');
        D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTap = onDoubleTapRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDoubleTapRaw, []); };
      },
      'onDoubleTapCancel': (visitor, target, value) {
        final onDoubleTapCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDoubleTapCancel');
        D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer').onDoubleTapCancel = onDoubleTapCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDoubleTapCancelRaw, []); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.DoubleTapGestureRecognizer>(target, 'DoubleTapGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'DoubleTapGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onDoubleTapDown': 'GestureTapDownCallback? get onDoubleTapDown',
      'onDoubleTap': 'GestureDoubleTapCallback? get onDoubleTap',
      'onDoubleTapCancel': 'GestureTapCancelCallback? get onDoubleTapCancel',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
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
    nativeType: $flutter_22.MultiTapGestureRecognizer,
    name: 'MultiTapGestureRecognizer',
    isAssignable: (v) => v is $flutter_22.MultiTapGestureRecognizer,
    hierarchyDepth: 5,
    constructors: {
      '': (visitor, positional, named) {
        final longTapDelay = D4.getNamedArgWithDefault<Duration>(named, 'longTapDelay', Duration.zero);
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_22.MultiTapGestureRecognizer(longTapDelay: longTapDelay, debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_22.MultiTapGestureRecognizer(longTapDelay: longTapDelay, debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').debugDescription,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapUp,
      'onTap': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTap,
      'onTapCancel': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapCancel,
      'longTapDelay': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').longTapDelay,
      'onLongTapDown': (visitor, target) => D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onLongTapDown,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onTapDown': (visitor, target, value) {
        final onTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapDown');
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapDown = onTapDownRaw == null ? null : (int p0, $flutter_28.TapDownDetails p1) { D4.callInterpreterCallback(visitor!, onTapDownRaw, [p0, p1]); };
      },
      'onTapUp': (visitor, target, value) {
        final onTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapUp');
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapUp = onTapUpRaw == null ? null : (int p0, $flutter_28.TapUpDetails p1) { D4.callInterpreterCallback(visitor!, onTapUpRaw, [p0, p1]); };
      },
      'onTap': (visitor, target, value) {
        final onTapRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTap');
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTap = onTapRaw == null ? null : (int p0) { D4.callInterpreterCallback(visitor!, onTapRaw, [p0]); };
      },
      'onTapCancel': (visitor, target, value) {
        final onTapCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapCancel');
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onTapCancel = onTapCancelRaw == null ? null : (int p0) { D4.callInterpreterCallback(visitor!, onTapCancelRaw, [p0]); };
      },
      'longTapDelay': (visitor, target, value) => 
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').longTapDelay = D4.extractBridgedArg<Duration>(value, 'longTapDelay'),
      'onLongTapDown': (visitor, target, value) {
        final onLongTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onLongTapDown');
        D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer').onLongTapDown = onLongTapDownRaw == null ? null : (int p0, $flutter_28.TapDownDetails p1) { D4.callInterpreterCallback(visitor!, onLongTapDownRaw, [p0, p1]); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.MultiTapGestureRecognizer>(target, 'MultiTapGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'MultiTapGestureRecognizer({Duration longTapDelay = Duration.zero, Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onTapDown': 'GestureMultiTapDownCallback? get onTapDown',
      'onTapUp': 'GestureMultiTapUpCallback? get onTapUp',
      'onTap': 'GestureMultiTapCallback? get onTap',
      'onTapCancel': 'GestureMultiTapCancelCallback? get onTapCancel',
      'longTapDelay': 'Duration get longTapDelay',
      'onLongTapDown': 'GestureMultiTapDownCallback? get onLongTapDown',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
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
    nativeType: $flutter_22.SerialTapDownDetails,
    name: 'SerialTapDownDetails',
    isAssignable: (v) => v is $flutter_22.SerialTapDownDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getRequiredNamedArg<PointerDeviceKind>(named, 'kind', 'SerialTapDownDetails');
        final buttons = D4.getNamedArgWithDefault<int>(named, 'buttons', 0);
        final count = D4.getNamedArgWithDefault<int>(named, 'count', 1);
        return $flutter_22.SerialTapDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, buttons: buttons, count: count);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails').kind,
      'buttons': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails').buttons,
      'count': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails').count,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapDownDetails>(target, 'SerialTapDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'SerialTapDownDetails({Offset globalPosition = Offset.zero, Offset? localPosition, required PointerDeviceKind kind, int buttons = 0, int count = 1})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_22.SerialTapCancelDetails,
    name: 'SerialTapCancelDetails',
    isAssignable: (v) => v is $flutter_22.SerialTapCancelDetails,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final count = D4.getNamedArgWithDefault<int>(named, 'count', 1);
        return $flutter_22.SerialTapCancelDetails(count: count);
      },
    },
    getters: {
      'count': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapCancelDetails>(target, 'SerialTapCancelDetails').count,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapCancelDetails>(target, 'SerialTapCancelDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapCancelDetails>(target, 'SerialTapCancelDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapCancelDetails>(target, 'SerialTapCancelDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapCancelDetails>(target, 'SerialTapCancelDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'SerialTapCancelDetails({int count = 1})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_22.SerialTapUpDetails,
    name: 'SerialTapUpDetails',
    isAssignable: (v) => v is $flutter_22.SerialTapUpDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final count = D4.getNamedArgWithDefault<int>(named, 'count', 1);
        return $flutter_22.SerialTapUpDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, count: count);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails').kind,
      'count': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails').count,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapUpDetails>(target, 'SerialTapUpDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'SerialTapUpDetails({Offset globalPosition = Offset.zero, Offset? localPosition, PointerDeviceKind? kind, int count = 1})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_22.SerialTapGestureRecognizer,
    name: 'SerialTapGestureRecognizer',
    isAssignable: (v) => v is $flutter_22.SerialTapGestureRecognizer,
    hierarchyDepth: 5,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        if (!named.containsKey('allowedButtonsFilter')) {
          return $flutter_22.SerialTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
        }
        if (named.containsKey('allowedButtonsFilter')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_22.SerialTapGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, allowedButtonsFilter: allowedButtonsFilter);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').debugDescription,
      'onSerialTapDown': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapDown,
      'onSerialTapCancel': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapCancel,
      'onSerialTapUp': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapUp,
      'isTrackingPointer': (visitor, target) => D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').isTrackingPointer,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'onSerialTapDown': (visitor, target, value) {
        final onSerialTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSerialTapDown');
        D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapDown = onSerialTapDownRaw == null ? null : ($flutter_22.SerialTapDownDetails p0) { D4.callInterpreterCallback(visitor!, onSerialTapDownRaw, [p0]); };
      },
      'onSerialTapCancel': (visitor, target, value) {
        final onSerialTapCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSerialTapCancel');
        D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapCancel = onSerialTapCancelRaw == null ? null : ($flutter_22.SerialTapCancelDetails p0) { D4.callInterpreterCallback(visitor!, onSerialTapCancelRaw, [p0]); };
      },
      'onSerialTapUp': (visitor, target, value) {
        final onSerialTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onSerialTapUp');
        D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer').onSerialTapUp = onSerialTapUpRaw == null ? null : ($flutter_22.SerialTapUpDetails p0) { D4.callInterpreterCallback(visitor!, onSerialTapUpRaw, [p0]); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_22.SerialTapGestureRecognizer>(target, 'SerialTapGestureRecognizer');
        return t.debugDescribeChildren();
      },
    },
    constructorSignatures: {
      '': 'SerialTapGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'onSerialTapDown': 'GestureSerialTapDownCallback? get onSerialTapDown',
      'onSerialTapCancel': 'GestureSerialTapCancelCallback? get onSerialTapCancel',
      'onSerialTapUp': 'GestureSerialTapUpCallback? get onSerialTapUp',
      'isTrackingPointer': 'bool get isTrackingPointer',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
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
    nativeType: $flutter_26.PointerEventResampler,
    name: 'PointerEventResampler',
    isAssignable: (v) => v is $flutter_26.PointerEventResampler,
    constructors: {
      '': (visitor, positional, named) {
        return $flutter_26.PointerEventResampler();
      },
    },
    getters: {
      'hasPendingEvents': (visitor, target) => D4.validateTarget<$flutter_26.PointerEventResampler>(target, 'PointerEventResampler').hasPendingEvents,
      'isTracked': (visitor, target) => D4.validateTarget<$flutter_26.PointerEventResampler>(target, 'PointerEventResampler').isTracked,
      'isDown': (visitor, target) => D4.validateTarget<$flutter_26.PointerEventResampler>(target, 'PointerEventResampler').isDown,
    },
    methods: {
      'addEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.PointerEventResampler>(target, 'PointerEventResampler');
        D4.requireMinArgs(positional, 1, 'addEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'addEvent');
        t.addEvent(event);
        return null;
      },
      'sample': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.PointerEventResampler>(target, 'PointerEventResampler');
        D4.requireMinArgs(positional, 3, 'sample');
        final sampleTime = D4.getRequiredArg<Duration>(positional, 0, 'sampleTime', 'sample');
        final nextSampleTime = D4.getRequiredArg<Duration>(positional, 1, 'nextSampleTime', 'sample');
        if (positional.length <= 2) {
          throw ArgumentError('sample: Missing required argument "callback" at position 2');
        }
        final callbackRaw = positional[2];
        t.sample(sampleTime, nextSampleTime, ($flutter_13.PointerEvent p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
        return null;
      },
      'stop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_26.PointerEventResampler>(target, 'PointerEventResampler');
        D4.requireMinArgs(positional, 1, 'stop');
        if (positional.isEmpty) {
          throw ArgumentError('stop: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        t.stop(($flutter_13.PointerEvent p0) { D4.callInterpreterCallback(visitor!, callbackRaw, [p0]); });
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
    nativeType: $flutter_27.ScaleStartDetails,
    name: 'ScaleStartDetails',
    isAssignable: (v) => v is $flutter_27.ScaleStartDetails,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final focalPoint = D4.getNamedArgWithDefault<Offset>(named, 'focalPoint', $dart_ui.Offset.zero);
        final localFocalPoint = D4.getOptionalNamedArg<Offset?>(named, 'localFocalPoint');
        final pointerCount = D4.getNamedArgWithDefault<int>(named, 'pointerCount', 0);
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        return $flutter_27.ScaleStartDetails(focalPoint: focalPoint, localFocalPoint: localFocalPoint, pointerCount: pointerCount, sourceTimeStamp: sourceTimeStamp, kind: kind);
      },
    },
    getters: {
      'focalPoint': (visitor, target) => D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails').focalPoint,
      'localFocalPoint': (visitor, target) => D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails').localFocalPoint,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails').pointerCount,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails').sourceTimeStamp,
      'kind': (visitor, target) => D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails').kind,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleStartDetails>(target, 'ScaleStartDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ScaleStartDetails({Offset focalPoint = Offset.zero, Offset? localFocalPoint, int pointerCount = 0, Duration? sourceTimeStamp, PointerDeviceKind? kind})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_27.ScaleUpdateDetails,
    name: 'ScaleUpdateDetails',
    isAssignable: (v) => v is $flutter_27.ScaleUpdateDetails,
    hierarchyDepth: 1,
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
        return $flutter_27.ScaleUpdateDetails(focalPoint: focalPoint, localFocalPoint: localFocalPoint, scale: scale, horizontalScale: horizontalScale, verticalScale: verticalScale, rotation: rotation, pointerCount: pointerCount, focalPointDelta: focalPointDelta, sourceTimeStamp: sourceTimeStamp);
      },
    },
    getters: {
      'focalPointDelta': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').focalPointDelta,
      'focalPoint': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').focalPoint,
      'localFocalPoint': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').localFocalPoint,
      'scale': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').scale,
      'horizontalScale': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').horizontalScale,
      'verticalScale': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').verticalScale,
      'rotation': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').rotation,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').pointerCount,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails').sourceTimeStamp,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleUpdateDetails>(target, 'ScaleUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ScaleUpdateDetails({Offset focalPoint = Offset.zero, Offset? localFocalPoint, double scale = 1.0, double horizontalScale = 1.0, double verticalScale = 1.0, double rotation = 0.0, int pointerCount = 0, Offset focalPointDelta = Offset.zero, Duration? sourceTimeStamp})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_27.ScaleEndDetails,
    name: 'ScaleEndDetails',
    isAssignable: (v) => v is $flutter_27.ScaleEndDetails,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final velocity = D4.getNamedArgWithDefault<$flutter_31.Velocity>(named, 'velocity', $flutter_31.Velocity.zero);
        final scaleVelocity = D4.getNamedArgWithDefault<double>(named, 'scaleVelocity', 0);
        final pointerCount = D4.getNamedArgWithDefault<int>(named, 'pointerCount', 0);
        return $flutter_27.ScaleEndDetails(velocity: velocity, scaleVelocity: scaleVelocity, pointerCount: pointerCount);
      },
    },
    getters: {
      'velocity': (visitor, target) => D4.validateTarget<$flutter_27.ScaleEndDetails>(target, 'ScaleEndDetails').velocity,
      'scaleVelocity': (visitor, target) => D4.validateTarget<$flutter_27.ScaleEndDetails>(target, 'ScaleEndDetails').scaleVelocity,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_27.ScaleEndDetails>(target, 'ScaleEndDetails').pointerCount,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleEndDetails>(target, 'ScaleEndDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleEndDetails>(target, 'ScaleEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleEndDetails>(target, 'ScaleEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleEndDetails>(target, 'ScaleEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'ScaleEndDetails({Velocity velocity = Velocity.zero, double scaleVelocity = 0, int pointerCount = 0})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_27.ScaleGestureRecognizer,
    name: 'ScaleGestureRecognizer',
    isAssignable: (v) => v is $flutter_27.ScaleGestureRecognizer,
    hierarchyDepth: 6,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        final dragStartBehavior = D4.getNamedArgWithDefault<$flutter_25.DragStartBehavior>(named, 'dragStartBehavior', $flutter_25.DragStartBehavior.down);
        final trackpadScrollCausesScale = D4.getNamedArgWithDefault<bool>(named, 'trackpadScrollCausesScale', false);
        if (!named.containsKey('allowedButtonsFilter') && !named.containsKey('trackpadScrollToScaleFactor')) {
          return $flutter_27.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale);
        }
        if (named.containsKey('allowedButtonsFilter') && !named.containsKey('trackpadScrollToScaleFactor')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          return $flutter_27.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale, allowedButtonsFilter: allowedButtonsFilter);
        }
        if (!named.containsKey('allowedButtonsFilter') && named.containsKey('trackpadScrollToScaleFactor')) {
          final trackpadScrollToScaleFactor = D4.getRequiredNamedArg<Offset>(named, 'trackpadScrollToScaleFactor', 'ScaleGestureRecognizer');
          return $flutter_27.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale, trackpadScrollToScaleFactor: trackpadScrollToScaleFactor);
        }
        if (named.containsKey('allowedButtonsFilter') && named.containsKey('trackpadScrollToScaleFactor')) {
          final allowedButtonsFilterRaw = named['allowedButtonsFilter'];
          final allowedButtonsFilter = ((int p0) { return D4.callInterpreterCallback(visitor!, allowedButtonsFilterRaw, [p0]) as bool; }) as bool Function(int);
          final trackpadScrollToScaleFactor = D4.getRequiredNamedArg<Offset>(named, 'trackpadScrollToScaleFactor', 'ScaleGestureRecognizer');
          return $flutter_27.ScaleGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices, dragStartBehavior: dragStartBehavior, trackpadScrollCausesScale: trackpadScrollCausesScale, allowedButtonsFilter: allowedButtonsFilter, trackpadScrollToScaleFactor: trackpadScrollToScaleFactor);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').dragStartBehavior,
      'onStart': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onStart,
      'onUpdate': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onUpdate,
      'onEnd': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onEnd,
      'trackpadScrollCausesScale': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollCausesScale,
      'trackpadScrollToScaleFactor': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollToScaleFactor,
      'pointerCount': (visitor, target) => D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').pointerCount,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'onStart': (visitor, target, value) {
        final onStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onStart');
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onStart = onStartRaw == null ? null : ($flutter_27.ScaleStartDetails p0) { D4.callInterpreterCallback(visitor!, onStartRaw, [p0]); };
      },
      'onUpdate': (visitor, target, value) {
        final onUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onUpdate');
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onUpdate = onUpdateRaw == null ? null : ($flutter_27.ScaleUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onUpdateRaw, [p0]); };
      },
      'onEnd': (visitor, target, value) {
        final onEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onEnd');
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').onEnd = onEndRaw == null ? null : ($flutter_27.ScaleEndDetails p0) { D4.callInterpreterCallback(visitor!, onEndRaw, [p0]); };
      },
      'trackpadScrollCausesScale': (visitor, target, value) => 
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollCausesScale = D4.extractBridgedArg<bool>(value, 'trackpadScrollCausesScale'),
      'trackpadScrollToScaleFactor': (visitor, target, value) => 
        D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer').trackpadScrollToScaleFactor = D4.extractBridgedArg<Offset>(value, 'trackpadScrollToScaleFactor'),
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_27.ScaleGestureRecognizer>(target, 'ScaleGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'ScaleGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices, AllowedButtonsFilter allowedButtonsFilter = _defaultButtonAcceptBehavior, DragStartBehavior dragStartBehavior = DragStartBehavior.down, bool trackpadScrollCausesScale = false, Offset trackpadScrollToScaleFactor = kDefaultTrackpadScrollToScaleFactor})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerDownEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
      'dragStartBehavior': 'DragStartBehavior get dragStartBehavior',
      'onStart': 'GestureScaleStartCallback? get onStart',
      'onUpdate': 'GestureScaleUpdateCallback? get onUpdate',
      'onEnd': 'GestureScaleEndCallback? get onEnd',
      'trackpadScrollCausesScale': 'bool get trackpadScrollCausesScale',
      'trackpadScrollToScaleFactor': 'Offset get trackpadScrollToScaleFactor',
      'pointerCount': 'int get pointerCount',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
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
    nativeType: $flutter_29.TapDragDownDetails,
    name: 'TapDragDownDetails',
    isAssignable: (v) => v is $flutter_29.TapDragDownDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'TapDragDownDetails');
        final localPosition = D4.getRequiredNamedArg<Offset>(named, 'localPosition', 'TapDragDownDetails');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragDownDetails');
        return $flutter_29.TapDragDownDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails').kind,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails').consecutiveTapCount,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragDownDetails>(target, 'TapDragDownDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragDownDetails({required Offset globalPosition, required Offset localPosition, PointerDeviceKind? kind, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_29.TapDragUpDetails,
    name: 'TapDragUpDetails',
    isAssignable: (v) => v is $flutter_29.TapDragUpDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'TapDragUpDetails');
        final localPosition = D4.getRequiredNamedArg<Offset>(named, 'localPosition', 'TapDragUpDetails');
        final kind = D4.getRequiredNamedArg<PointerDeviceKind>(named, 'kind', 'TapDragUpDetails');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragUpDetails');
        return $flutter_29.TapDragUpDetails(globalPosition: globalPosition, localPosition: localPosition, kind: kind, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails').localPosition,
      'kind': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails').kind,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails').consecutiveTapCount,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpDetails>(target, 'TapDragUpDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragUpDetails({required Offset globalPosition, required Offset localPosition, required PointerDeviceKind kind, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_29.TapDragStartDetails,
    name: 'TapDragStartDetails',
    isAssignable: (v) => v is $flutter_29.TapDragStartDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getRequiredNamedArg<Offset>(named, 'globalPosition', 'TapDragStartDetails');
        final localPosition = D4.getRequiredNamedArg<Offset>(named, 'localPosition', 'TapDragStartDetails');
        final sourceTimeStamp = D4.getOptionalNamedArg<Duration?>(named, 'sourceTimeStamp');
        final kind = D4.getOptionalNamedArg<PointerDeviceKind?>(named, 'kind');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragStartDetails');
        return $flutter_29.TapDragStartDetails(globalPosition: globalPosition, localPosition: localPosition, sourceTimeStamp: sourceTimeStamp, kind: kind, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails').localPosition,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails').sourceTimeStamp,
      'kind': (visitor, target) => D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails').kind,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails').consecutiveTapCount,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragStartDetails>(target, 'TapDragStartDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragStartDetails({required Offset globalPosition, required Offset localPosition, Duration? sourceTimeStamp, PointerDeviceKind? kind, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_29.TapDragUpdateDetails,
    name: 'TapDragUpdateDetails',
    isAssignable: (v) => v is $flutter_29.TapDragUpdateDetails,
    hierarchyDepth: 2,
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
        return $flutter_29.TapDragUpdateDetails(globalPosition: globalPosition, localPosition: localPosition, sourceTimeStamp: sourceTimeStamp, delta: delta, primaryDelta: primaryDelta, kind: kind, offsetFromOrigin: offsetFromOrigin, localOffsetFromOrigin: localOffsetFromOrigin, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').localPosition,
      'sourceTimeStamp': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').sourceTimeStamp,
      'delta': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').delta,
      'primaryDelta': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').primaryDelta,
      'kind': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').kind,
      'offsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').offsetFromOrigin,
      'localOffsetFromOrigin': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').localOffsetFromOrigin,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails').consecutiveTapCount,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragUpdateDetails>(target, 'TapDragUpdateDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragUpdateDetails({required Offset globalPosition, required Offset localPosition, Duration? sourceTimeStamp, Offset delta = Offset.zero, double? primaryDelta, PointerDeviceKind? kind, required Offset offsetFromOrigin, required Offset localOffsetFromOrigin, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_29.TapDragEndDetails,
    name: 'TapDragEndDetails',
    isAssignable: (v) => v is $flutter_29.TapDragEndDetails,
    hierarchyDepth: 2,
    constructors: {
      '': (visitor, positional, named) {
        final globalPosition = D4.getNamedArgWithDefault<Offset>(named, 'globalPosition', $dart_ui.Offset.zero);
        final localPosition = D4.getOptionalNamedArg<Offset?>(named, 'localPosition');
        final velocity = D4.getNamedArgWithDefault<$flutter_31.Velocity>(named, 'velocity', $flutter_31.Velocity.zero);
        final primaryVelocity = D4.getOptionalNamedArg<double?>(named, 'primaryVelocity');
        final consecutiveTapCount = D4.getRequiredNamedArg<int>(named, 'consecutiveTapCount', 'TapDragEndDetails');
        return $flutter_29.TapDragEndDetails(globalPosition: globalPosition, localPosition: localPosition, velocity: velocity, primaryVelocity: primaryVelocity, consecutiveTapCount: consecutiveTapCount);
      },
    },
    getters: {
      'globalPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails').globalPosition,
      'localPosition': (visitor, target) => D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails').localPosition,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails').velocity,
      'primaryVelocity': (visitor, target) => D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails').primaryVelocity,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails').consecutiveTapCount,
    },
    methods: {
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails');
        return t.toStringShort();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapDragEndDetails>(target, 'TapDragEndDetails');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
    },
    constructorSignatures: {
      '': 'TapDragEndDetails({Offset globalPosition = Offset.zero, Offset? localPosition, Velocity velocity = Velocity.zero, double? primaryVelocity, required int consecutiveTapCount})',
    },
    methodSignatures: {
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
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
    nativeType: $flutter_29.BaseTapAndDragGestureRecognizer,
    name: 'BaseTapAndDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_29.BaseTapAndDragGestureRecognizer,
    hierarchyDepth: 7,
    constructors: {
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragUpdateThrottleFrequency,
      'maxConsecutiveTap': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').maxConsecutiveTap,
      'eagerVictoryOnDrag': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').eagerVictoryOnDrag,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapUp,
      'onDragStart': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragStart,
      'onDragUpdate': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragUpdate,
      'onDragEnd': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onCancel,
      'currentDown': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').currentDown,
      'currentUp': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').currentUp,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').consecutiveTapCount,
      'onTapTrackStart': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapTrackStart,
      'onTapTrackReset': (visitor, target) => D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapTrackReset,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'dragUpdateThrottleFrequency': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').dragUpdateThrottleFrequency = D4.extractBridgedArgOrNull<Duration>(value, 'dragUpdateThrottleFrequency'),
      'maxConsecutiveTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').maxConsecutiveTap = D4.extractBridgedArgOrNull<int>(value, 'maxConsecutiveTap'),
      'eagerVictoryOnDrag': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').eagerVictoryOnDrag = D4.extractBridgedArg<bool>(value, 'eagerVictoryOnDrag'),
      'onTapDown': (visitor, target, value) {
        final onTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapDown');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapDown = onTapDownRaw == null ? null : ($flutter_29.TapDragDownDetails p0) { D4.callInterpreterCallback(visitor!, onTapDownRaw, [p0]); };
      },
      'onTapUp': (visitor, target, value) {
        final onTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapUp');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapUp = onTapUpRaw == null ? null : ($flutter_29.TapDragUpDetails p0) { D4.callInterpreterCallback(visitor!, onTapUpRaw, [p0]); };
      },
      'onDragStart': (visitor, target, value) {
        final onDragStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragStart');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragStart = onDragStartRaw == null ? null : ($flutter_29.TapDragStartDetails p0) { D4.callInterpreterCallback(visitor!, onDragStartRaw, [p0]); };
      },
      'onDragUpdate': (visitor, target, value) {
        final onDragUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragUpdate');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragUpdate = onDragUpdateRaw == null ? null : ($flutter_29.TapDragUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onDragUpdateRaw, [p0]); };
      },
      'onDragEnd': (visitor, target, value) {
        final onDragEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragEnd');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onDragEnd = onDragEndRaw == null ? null : ($flutter_29.TapDragEndDetails p0) { D4.callInterpreterCallback(visitor!, onDragEndRaw, [p0]); };
      },
      'onCancel': (visitor, target, value) {
        final onCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCancel');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onCancel = onCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCancelRaw, []); };
      },
      'onTapTrackStart': (visitor, target, value) {
        final onTapTrackStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapTrackStart');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapTrackStart = onTapTrackStartRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapTrackStartRaw, []); };
      },
      'onTapTrackReset': (visitor, target, value) {
        final onTapTrackResetRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapTrackReset');
        D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer').onTapTrackReset = onTapTrackResetRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapTrackResetRaw, []); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.BaseTapAndDragGestureRecognizer>(target, 'BaseTapAndDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
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
      'currentDown': 'PointerDownEvent? get currentDown',
      'currentUp': 'PointerUpEvent? get currentUp',
      'consecutiveTapCount': 'int get consecutiveTapCount',
      'onTapTrackStart': 'VoidCallback? get onTapTrackStart',
      'onTapTrackReset': 'VoidCallback? get onTapTrackReset',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
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
      'onTapTrackStart': 'set onTapTrackStart(VoidCallback? value)',
      'onTapTrackReset': 'set onTapTrackReset(VoidCallback? value)',
    },
  );
}

// =============================================================================
// TapAndHorizontalDragGestureRecognizer Bridge
// =============================================================================

BridgedClass _createTapAndHorizontalDragGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_29.TapAndHorizontalDragGestureRecognizer,
    name: 'TapAndHorizontalDragGestureRecognizer',
    isAssignable: (v) => v is $flutter_29.TapAndHorizontalDragGestureRecognizer,
    hierarchyDepth: 8,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        return $flutter_29.TapAndHorizontalDragGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragUpdateThrottleFrequency,
      'maxConsecutiveTap': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').maxConsecutiveTap,
      'eagerVictoryOnDrag': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').eagerVictoryOnDrag,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapUp,
      'onDragStart': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragStart,
      'onDragUpdate': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragUpdate,
      'onDragEnd': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onCancel,
      'currentDown': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').currentDown,
      'currentUp': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').currentUp,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').consecutiveTapCount,
      'onTapTrackStart': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapTrackStart,
      'onTapTrackReset': (visitor, target) => D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapTrackReset,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'dragUpdateThrottleFrequency': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').dragUpdateThrottleFrequency = D4.extractBridgedArgOrNull<Duration>(value, 'dragUpdateThrottleFrequency'),
      'maxConsecutiveTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').maxConsecutiveTap = D4.extractBridgedArgOrNull<int>(value, 'maxConsecutiveTap'),
      'eagerVictoryOnDrag': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').eagerVictoryOnDrag = D4.extractBridgedArg<bool>(value, 'eagerVictoryOnDrag'),
      'onTapDown': (visitor, target, value) {
        final onTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapDown');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapDown = onTapDownRaw == null ? null : ($flutter_29.TapDragDownDetails p0) { D4.callInterpreterCallback(visitor!, onTapDownRaw, [p0]); };
      },
      'onTapUp': (visitor, target, value) {
        final onTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapUp');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapUp = onTapUpRaw == null ? null : ($flutter_29.TapDragUpDetails p0) { D4.callInterpreterCallback(visitor!, onTapUpRaw, [p0]); };
      },
      'onDragStart': (visitor, target, value) {
        final onDragStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragStart');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragStart = onDragStartRaw == null ? null : ($flutter_29.TapDragStartDetails p0) { D4.callInterpreterCallback(visitor!, onDragStartRaw, [p0]); };
      },
      'onDragUpdate': (visitor, target, value) {
        final onDragUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragUpdate');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragUpdate = onDragUpdateRaw == null ? null : ($flutter_29.TapDragUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onDragUpdateRaw, [p0]); };
      },
      'onDragEnd': (visitor, target, value) {
        final onDragEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragEnd');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onDragEnd = onDragEndRaw == null ? null : ($flutter_29.TapDragEndDetails p0) { D4.callInterpreterCallback(visitor!, onDragEndRaw, [p0]); };
      },
      'onCancel': (visitor, target, value) {
        final onCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCancel');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onCancel = onCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCancelRaw, []); };
      },
      'onTapTrackStart': (visitor, target, value) {
        final onTapTrackStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapTrackStart');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapTrackStart = onTapTrackStartRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapTrackStartRaw, []); };
      },
      'onTapTrackReset': (visitor, target, value) {
        final onTapTrackResetRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapTrackReset');
        D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer').onTapTrackReset = onTapTrackResetRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapTrackResetRaw, []); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndHorizontalDragGestureRecognizer>(target, 'TapAndHorizontalDragGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TapAndHorizontalDragGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
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
      'currentDown': 'PointerDownEvent? get currentDown',
      'currentUp': 'PointerUpEvent? get currentUp',
      'consecutiveTapCount': 'int get consecutiveTapCount',
      'onTapTrackStart': 'VoidCallback? get onTapTrackStart',
      'onTapTrackReset': 'VoidCallback? get onTapTrackReset',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
      'dragStartBehavior': 'set dragStartBehavior(DragStartBehavior value)',
      'dragUpdateThrottleFrequency': 'set dragUpdateThrottleFrequency(Duration? value)',
      'maxConsecutiveTap': 'set maxConsecutiveTap(int? value)',
      'eagerVictoryOnDrag': 'set eagerVictoryOnDrag(bool value)',
      'onTapDown': 'set onTapDown(GestureTapDragDownCallback? value)',
      'onTapUp': 'set onTapUp(GestureTapDragUpCallback? value)',
      'onDragStart': 'set onDragStart(GestureTapDragStartCallback? value)',
      'onDragUpdate': 'set onDragUpdate(GestureTapDragUpdateCallback? value)',
      'onDragEnd': 'set onDragEnd(GestureTapDragEndCallback? value)',
      'onCancel': 'set onCancel(GestureCancelCallback? value)',
      'onTapTrackStart': 'set onTapTrackStart(VoidCallback? value)',
      'onTapTrackReset': 'set onTapTrackReset(VoidCallback? value)',
    },
  );
}

// =============================================================================
// TapAndPanGestureRecognizer Bridge
// =============================================================================

BridgedClass _createTapAndPanGestureRecognizerBridge() {
  return BridgedClass(
    nativeType: $flutter_29.TapAndPanGestureRecognizer,
    name: 'TapAndPanGestureRecognizer',
    isAssignable: (v) => v is $flutter_29.TapAndPanGestureRecognizer,
    hierarchyDepth: 8,
    constructors: {
      '': (visitor, positional, named) {
        final debugOwner = D4.getOptionalNamedArg<Object?>(named, 'debugOwner');
        final supportedDevices = D4.coerceSetOrNull<PointerDeviceKind>(named['supportedDevices'], 'supportedDevices');
        return $flutter_29.TapAndPanGestureRecognizer(debugOwner: debugOwner, supportedDevices: supportedDevices);
      },
    },
    getters: {
      'debugOwner': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').debugOwner,
      'gestureSettings': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').gestureSettings,
      'supportedDevices': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').supportedDevices,
      'allowedButtonsFilter': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').allowedButtonsFilter,
      'debugDescription': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').debugDescription,
      'team': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').team,
      'dragStartBehavior': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragStartBehavior,
      'dragUpdateThrottleFrequency': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragUpdateThrottleFrequency,
      'maxConsecutiveTap': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').maxConsecutiveTap,
      'eagerVictoryOnDrag': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').eagerVictoryOnDrag,
      'onTapDown': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapDown,
      'onTapUp': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapUp,
      'onDragStart': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragStart,
      'onDragUpdate': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragUpdate,
      'onDragEnd': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragEnd,
      'onCancel': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onCancel,
      'currentDown': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').currentDown,
      'currentUp': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').currentUp,
      'consecutiveTapCount': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').consecutiveTapCount,
      'onTapTrackStart': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapTrackStart,
      'onTapTrackReset': (visitor, target) => D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapTrackReset,
    },
    setters: {
      'gestureSettings': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').gestureSettings = D4.extractBridgedArgOrNull<$flutter_16.DeviceGestureSettings>(value, 'gestureSettings'),
      'supportedDevices': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').supportedDevices = value == null ? null : D4.coerceSet<PointerDeviceKind>(value, 'supportedDevices'),
      'team': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').team = D4.extractBridgedArgOrNull<$flutter_30.GestureArenaTeam>(value, 'team'),
      'dragStartBehavior': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragStartBehavior = D4.extractBridgedArg<$flutter_25.DragStartBehavior>(value, 'dragStartBehavior'),
      'dragUpdateThrottleFrequency': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').dragUpdateThrottleFrequency = D4.extractBridgedArgOrNull<Duration>(value, 'dragUpdateThrottleFrequency'),
      'maxConsecutiveTap': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').maxConsecutiveTap = D4.extractBridgedArgOrNull<int>(value, 'maxConsecutiveTap'),
      'eagerVictoryOnDrag': (visitor, target, value) => 
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').eagerVictoryOnDrag = D4.extractBridgedArg<bool>(value, 'eagerVictoryOnDrag'),
      'onTapDown': (visitor, target, value) {
        final onTapDownRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapDown');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapDown = onTapDownRaw == null ? null : ($flutter_29.TapDragDownDetails p0) { D4.callInterpreterCallback(visitor!, onTapDownRaw, [p0]); };
      },
      'onTapUp': (visitor, target, value) {
        final onTapUpRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapUp');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapUp = onTapUpRaw == null ? null : ($flutter_29.TapDragUpDetails p0) { D4.callInterpreterCallback(visitor!, onTapUpRaw, [p0]); };
      },
      'onDragStart': (visitor, target, value) {
        final onDragStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragStart');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragStart = onDragStartRaw == null ? null : ($flutter_29.TapDragStartDetails p0) { D4.callInterpreterCallback(visitor!, onDragStartRaw, [p0]); };
      },
      'onDragUpdate': (visitor, target, value) {
        final onDragUpdateRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragUpdate');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragUpdate = onDragUpdateRaw == null ? null : ($flutter_29.TapDragUpdateDetails p0) { D4.callInterpreterCallback(visitor!, onDragUpdateRaw, [p0]); };
      },
      'onDragEnd': (visitor, target, value) {
        final onDragEndRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onDragEnd');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onDragEnd = onDragEndRaw == null ? null : ($flutter_29.TapDragEndDetails p0) { D4.callInterpreterCallback(visitor!, onDragEndRaw, [p0]); };
      },
      'onCancel': (visitor, target, value) {
        final onCancelRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onCancel');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onCancel = onCancelRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onCancelRaw, []); };
      },
      'onTapTrackStart': (visitor, target, value) {
        final onTapTrackStartRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapTrackStart');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapTrackStart = onTapTrackStartRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapTrackStartRaw, []); };
      },
      'onTapTrackReset': (visitor, target, value) {
        final onTapTrackResetRaw = D4.extractBridgedArgOrNull<dynamic>(value, 'onTapTrackReset');
        D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer').onTapTrackReset = onTapTrackResetRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onTapTrackResetRaw, []); };
      },
    },
    methods: {
      'acceptGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'acceptGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'acceptGesture');
        t.acceptGesture(pointer);
        return null;
      },
      'rejectGesture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'rejectGesture');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'rejectGesture');
        t.rejectGesture(pointer);
        return null;
      },
      'addPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addPointerPanZoom');
        t.addPointerPanZoom(event);
        return null;
      },
      'addAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'addAllowedPointerPanZoom');
        t.addAllowedPointerPanZoom(event);
        return null;
      },
      'addPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addPointer');
        t.addPointer(event);
        return null;
      },
      'addAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'addAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'addAllowedPointer');
        t.addAllowedPointer(event);
        return null;
      },
      'handleNonAllowedPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointer');
        final event = D4.getRequiredArg<$flutter_13.PointerDownEvent>(positional, 0, 'event', 'handleNonAllowedPointer');
        t.handleNonAllowedPointer(event);
        return null;
      },
      'isPointerAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'isPointerAllowed');
        return t.isPointerAllowed(event);
      },
      'handleNonAllowedPointerPanZoom': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleNonAllowedPointerPanZoom');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'handleNonAllowedPointerPanZoom');
        t.handleNonAllowedPointerPanZoom(event);
        return null;
      },
      'isPointerPanZoomAllowed': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'isPointerPanZoomAllowed');
        final event = D4.getRequiredArg<$flutter_13.PointerPanZoomStartEvent>(positional, 0, 'event', 'isPointerPanZoomAllowed');
        return t.isPointerPanZoomAllowed(event);
      },
      'getKindForPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'getKindForPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'getKindForPointer');
        return t.getKindForPointer(pointer);
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        (t as dynamic).dispose();
        return null;
      },
      'invokeCallback': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'invokeCallback');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeCallback');
        if (positional.length <= 1) {
          throw ArgumentError('invokeCallback: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        final debugReportRaw = named['debugReport'];
        return t.invokeCallback(name, () { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, callbackRaw, [])); }, debugReport: debugReportRaw == null ? null : (() { return D4.callInterpreterCallback(visitor!, debugReportRaw, []) as String; }) as String Function());
      },
      'debugFillProperties': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'debugFillProperties');
        final properties = D4.getRequiredArg<$flutter_4.DiagnosticPropertiesBuilder>(positional, 0, 'properties', 'debugFillProperties');
        (t as dynamic).debugFillProperties(properties);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.info);
        return t.toString(minLevel: minLevel);
      },
      'toStringShallow': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final joiner = D4.getNamedArgWithDefault<String>(named, 'joiner', ', ');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        return t.toStringShallow(joiner: joiner, minLevel: minLevel);
      },
      'toStringDeep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final prefixLineOne = D4.getNamedArgWithDefault<String>(named, 'prefixLineOne', '');
        final prefixOtherLines = D4.getOptionalNamedArg<String?>(named, 'prefixOtherLines');
        final minLevel = D4.getNamedArgWithDefault<$flutter_4.DiagnosticLevel>(named, 'minLevel', $flutter_4.DiagnosticLevel.debug);
        final wrapWidth = D4.getNamedArgWithDefault<int>(named, 'wrapWidth', 65);
        return t.toStringDeep(prefixLineOne: prefixLineOne, prefixOtherLines: prefixOtherLines, minLevel: minLevel, wrapWidth: wrapWidth);
      },
      'toStringShort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        return t.toStringShort();
      },
      'toDiagnosticsNode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final style = D4.getOptionalNamedArg<$flutter_4.DiagnosticsTreeStyle?>(named, 'style');
        return t.toDiagnosticsNode(name: name, style: style);
      },
      'debugDescribeChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        return t.debugDescribeChildren();
      },
      'handleEvent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'handleEvent');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'handleEvent');
        t.handleEvent(event);
        return null;
      },
      'didStopTrackingLastPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'didStopTrackingLastPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'didStopTrackingLastPointer');
        t.didStopTrackingLastPointer(pointer);
        return null;
      },
      'resolve': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'resolve');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 0, 'disposition', 'resolve');
        t.resolve(disposition);
        return null;
      },
      'resolvePointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 2, 'resolvePointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'resolvePointer');
        final disposition = D4.getRequiredArg<$flutter_5.GestureDisposition>(positional, 1, 'disposition', 'resolvePointer');
        t.resolvePointer(pointer, disposition);
        return null;
      },
      'startTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'startTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'startTrackingPointer');
        final transform = D4.getOptionalArg<$vector_math_1.Matrix4?>(positional, 1, 'transform');
        t.startTrackingPointer(pointer, transform);
        return null;
      },
      'stopTrackingPointer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingPointer');
        final pointer = D4.getRequiredArg<int>(positional, 0, 'pointer', 'stopTrackingPointer');
        t.stopTrackingPointer(pointer);
        return null;
      },
      'stopTrackingIfPointerNoLongerDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_29.TapAndPanGestureRecognizer>(target, 'TapAndPanGestureRecognizer');
        D4.requireMinArgs(positional, 1, 'stopTrackingIfPointerNoLongerDown');
        final event = D4.getRequiredArg<$flutter_13.PointerEvent>(positional, 0, 'event', 'stopTrackingIfPointerNoLongerDown');
        t.stopTrackingIfPointerNoLongerDown(event);
        return null;
      },
    },
    constructorSignatures: {
      '': 'TapAndPanGestureRecognizer({Object? debugOwner, Set<PointerDeviceKind>? supportedDevices})',
    },
    methodSignatures: {
      'acceptGesture': 'void acceptGesture(int pointer)',
      'rejectGesture': 'void rejectGesture(int pointer)',
      'addPointerPanZoom': 'void addPointerPanZoom(PointerPanZoomStartEvent event)',
      'addAllowedPointerPanZoom': 'void addAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'addPointer': 'void addPointer(PointerDownEvent event)',
      'addAllowedPointer': 'void addAllowedPointer(PointerDownEvent event)',
      'handleNonAllowedPointer': 'void handleNonAllowedPointer(PointerDownEvent event)',
      'isPointerAllowed': 'bool isPointerAllowed(PointerEvent event)',
      'handleNonAllowedPointerPanZoom': 'void handleNonAllowedPointerPanZoom(PointerPanZoomStartEvent event)',
      'isPointerPanZoomAllowed': 'bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event)',
      'getKindForPointer': 'PointerDeviceKind getKindForPointer(int pointer)',
      'dispose': 'void dispose()',
      'invokeCallback': 'T? invokeCallback(String name, RecognizerCallback<T> callback, {String Function()? debugReport})',
      'debugFillProperties': 'void debugFillProperties(DiagnosticPropertiesBuilder properties)',
      'toString': 'String toString({DiagnosticLevel minLevel = DiagnosticLevel.info})',
      'toStringShallow': 'String toStringShallow({String joiner = \', \', DiagnosticLevel minLevel = DiagnosticLevel.debug})',
      'toStringDeep': 'String toStringDeep({String prefixLineOne = \'\', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug, int wrapWidth = 65})',
      'toStringShort': 'String toStringShort()',
      'toDiagnosticsNode': 'DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style})',
      'debugDescribeChildren': 'List<DiagnosticsNode> debugDescribeChildren()',
      'handleEvent': 'void handleEvent(PointerEvent event)',
      'didStopTrackingLastPointer': 'void didStopTrackingLastPointer(int pointer)',
      'resolve': 'void resolve(GestureDisposition disposition)',
      'resolvePointer': 'void resolvePointer(int pointer, GestureDisposition disposition)',
      'startTrackingPointer': 'void startTrackingPointer(int pointer, [Matrix4? transform])',
      'stopTrackingPointer': 'void stopTrackingPointer(int pointer)',
      'stopTrackingIfPointerNoLongerDown': 'void stopTrackingIfPointerNoLongerDown(PointerEvent event)',
    },
    getterSignatures: {
      'debugOwner': 'Object? get debugOwner',
      'gestureSettings': 'DeviceGestureSettings? get gestureSettings',
      'supportedDevices': 'Set<PointerDeviceKind>? get supportedDevices',
      'allowedButtonsFilter': 'AllowedButtonsFilter get allowedButtonsFilter',
      'debugDescription': 'String get debugDescription',
      'team': 'GestureArenaTeam? get team',
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
      'currentDown': 'PointerDownEvent? get currentDown',
      'currentUp': 'PointerUpEvent? get currentUp',
      'consecutiveTapCount': 'int get consecutiveTapCount',
      'onTapTrackStart': 'VoidCallback? get onTapTrackStart',
      'onTapTrackReset': 'VoidCallback? get onTapTrackReset',
    },
    setterSignatures: {
      'gestureSettings': 'set gestureSettings(DeviceGestureSettings? value)',
      'supportedDevices': 'set supportedDevices(Set<PointerDeviceKind>? value)',
      'team': 'set team(GestureArenaTeam? value)',
      'dragStartBehavior': 'set dragStartBehavior(DragStartBehavior value)',
      'dragUpdateThrottleFrequency': 'set dragUpdateThrottleFrequency(Duration? value)',
      'maxConsecutiveTap': 'set maxConsecutiveTap(int? value)',
      'eagerVictoryOnDrag': 'set eagerVictoryOnDrag(bool value)',
      'onTapDown': 'set onTapDown(GestureTapDragDownCallback? value)',
      'onTapUp': 'set onTapUp(GestureTapDragUpCallback? value)',
      'onDragStart': 'set onDragStart(GestureTapDragStartCallback? value)',
      'onDragUpdate': 'set onDragUpdate(GestureTapDragUpdateCallback? value)',
      'onDragEnd': 'set onDragEnd(GestureTapDragEndCallback? value)',
      'onCancel': 'set onCancel(GestureCancelCallback? value)',
      'onTapTrackStart': 'set onTapTrackStart(VoidCallback? value)',
      'onTapTrackReset': 'set onTapTrackReset(VoidCallback? value)',
    },
  );
}

