/// Re-runs the 116 scripts flagged as suspicious in
/// `tom_d4rt_flutter_ast/doc/suspicious_tests.md` —
/// the entries that have been audited (`[x] checked`) but
/// did **not** earn the `[x] is ok` mark, meaning they
/// either fall short of the 400-line threshold, fail to use
/// the class their filename advertises, or use it only
/// inside string snippets / harness fallbacks rather than
/// in live widget code.
///
/// This suite exists to keep the failing population pinned
/// in CI: as each script is rewritten to actually exercise
/// its target class with real visual output, the rewrite
/// must keep this suite green. When all 116 scripts have
/// been rewritten and re-marked `[x] is ok` in
/// `suspicious_tests.md`, this file can be retired.
///
/// Each test corresponds to a script in the
/// `send_ast_via_http_scripts/` directory. The driver is
/// the AST-based `SendTestRunner` (port 4242).
///
/// IMPORTANT: never run this file concurrently with other
/// test files that use the same port — see
/// `dart_test.yaml` (concurrency: 1).
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Test App Health', () {
    test('app is running', () async {
      final isRunning = await SendTestRunner.isAppRunning();
      expect(
        isRunning,
        isTrue,
        reason: 'Test app should be running (managed by setUpAll).',
      );
    });
  });

  // ============================================================
  // CUPERTINO (13 files)
  // ============================================================
  group('cupertino/', () {
    test('cupertino_controls_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_controls_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_desktop_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_desktop_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_focus_halo_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_focus_halo_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_form_scroll_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_form_scroll_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_sections_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_sections_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_secondary_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_secondary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_tabbar_scaffold_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_tabbar_scaffold_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('form_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/form_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_cupertino_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/inherited_cupertino_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_visibility_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/overlay_visibility_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('textfield_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/textfield_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // DART_UI (6 files)
  // ============================================================
  group('dart_ui/', () {
    test('scene_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/scene_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_mask_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/shader_mask_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_action_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_action_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_flags_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_flags_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/string_attribute_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_color_palette_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/system_color_palette_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('target_image_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/target_image_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/transform_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ztmp_path_metrics_access_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/ztmp_path_metrics_access_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_constraints_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_constraints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_focus_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_focus_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_flag_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_flag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_float_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_float_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec3_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec3_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec4_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec4_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_out_string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/spell_out_string_attribute_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // FOUNDATION (1 file)
  // ============================================================
  group('foundation/', () {
    test('diagnostics_tree_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_tree_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_disposed_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_disposed_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('double_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/double_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('enum_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/enum_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flag_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flag_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_memory_allocations_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flutter_memory_allocations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/foundation_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('iterable_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/iterable_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('percent_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/percent_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('string_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/string_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('target_platform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/target_platform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unicode_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/unicode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('aggregated_timings_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/aggregated_timings_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('partial_stack_frame_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/partial_stack_frame_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_tree_renderer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/text_tree_renderer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stack_frame_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/stack_frame_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('error_spacer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/error_spacer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // GESTURES (5 files)
  // ============================================================
  group('gestures/', () {
    test('device_gesture_settings_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/device_gesture_settings_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_removed_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_removed_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('primary_pointer_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/primary_pointer_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_horizontal_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_horizontal_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_update_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_update_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_start_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_start_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_start_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_start_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_error_details_for_pointer_event_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/flutter_error_details_for_pointer_event_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_disposition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_recognizer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_testable_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/hit_testable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('long_press_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/long_press_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mac_o_s_scroll_view_fling_velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/mac_o_s_scroll_view_fling_velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multitouch_drag_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multitouch_drag_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('one_sequence_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/one_sequence_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_added_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_added_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_enter_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_enter_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/vertical_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_cancel_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_cancel_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('eager_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/eager_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delayed_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/delayed_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_drag_pointer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_drag_pointer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('base_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/base_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_cancel_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_cancel_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('base_tap_and_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/base_tap_and_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_exit_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_exit_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_end_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_end_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_resolver_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_signal_resolver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_end_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_end_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_signal_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_start_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_start_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scroll_inertia_cancel_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scroll_inertia_cancel_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_hover_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_hover_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_move_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_move_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scroll_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scroll_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('horizontal_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/horizontal_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_pan_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_pan_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scale_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scale_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // PHYSICS (1 file)
  // ============================================================
  group('physics/', () {
    test('spring_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/spring_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // MATERIAL (39 files)
  // ============================================================
  group('material/', () {
    test('bottom_navigation_bar_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('card_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/card_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_bar_layout_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_bar_layout_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_styles_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_styles_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_bar_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_bar_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_text_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_text_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('collapse_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/collapse_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drawer_controller_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_controller_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_menu_close_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_close_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('end_drawer_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/end_drawer_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gapped_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/gapped_range_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gapped_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/gapped_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hour_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/hour_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_tile_title_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_title_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_banner_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_banner_closed_reason_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_accelerator_callback_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_accelerator_callback_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_destination_label_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_destination_label_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_drawer_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_drawer_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_rail_label_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_rail_label_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('paginated_data_table_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paginated_data_table_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_position_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('progress_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/progress_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refresh_progress_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_progress_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refreshindicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refreshindicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snack_bar_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snack_bar_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_closed_reason_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stepper_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/stepper_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_bar_indicator_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_bar_indicator_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tabs_test.dart', () async {
      final result = await SendTestRunner.send('material/tabs_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_selection_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_text_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_selection_toolbar_text_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('themadata_test.dart', () async {
      final result = await SendTestRunner.send('material/themadata_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('theme_extension_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/theme_extension_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('theme_mode_test.dart', () async {
      final result = await SendTestRunner.send('material/theme_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('thumb_test.dart', () async {
      final result = await SendTestRunner.send('material/thumb_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('time_of_day_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/time_of_day_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('time_picker_entry_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/time_picker_entry_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('timeofday_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/timeofday_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggle_buttons_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/toggle_buttons_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggle_buttons_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/toggle_buttons_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggle_segmented_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/toggle_segmented_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('elevated_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/elevated_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('aboutdialog_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/aboutdialog_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('licensepage_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/licensepage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedicon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/animatedicon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_toolbar_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/desktop_text_selection_toolbar_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('themes_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/themes_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('timepicker_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/timepicker_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('datetime_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/datetime_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // PAINTING (4 files)
  // ============================================================
  group('painting/', () {
    test('axis_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/axis_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('axis_test.dart', () async {
      final result = await SendTestRunner.send('painting/axis_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('decoration_image_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/decoration_image_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/color_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_insets_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/edge_insets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_logo_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/flutter_logo_decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/transform_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('accumulator_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/accumulator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_stream_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('network_image_load_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/network_image_load_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/placeholder_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gradient_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradient_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inline_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inline_span_semantics_information_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_semantics_information_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('linear_border_edge_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/linear_border_edge_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('resize_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_size_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_size_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/box_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('star_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/star_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_chunk_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_chunk_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_directional_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_stream_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fitted_sizes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/fitted_sizes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('automatic_notched_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/automatic_notched_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/box_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gradients_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradients_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rounded_superellipse_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/rounded_superellipse_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('outlined_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/outlined_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notched_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/notched_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrix_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_providers_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_providers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shape_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shape_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('linear_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/linear_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_radius_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_radius_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // PROXIES (5 files)
  // ============================================================
  group('proxies/', () {
    test('customclipper_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/customclipper_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('custompaint_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/custompaint_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flowdelegate_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/flowdelegate_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multichildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/multichildlayout_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('singlechildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/singlechildlayout_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // RENDERING (30 files)
  // ============================================================
  group('rendering/', () {
    test('const_test.dart', () async {
      final result = await SendTestRunner.send('rendering/const_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/scroll_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_event_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_extend_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_extend_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_granularity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_granularity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_header_snap_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/floating_header_snap_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('over_scroll_header_stretch_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/over_scroll_header_stretch_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pipeline_manifold_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/pipeline_manifold_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_span_index_semantics_tag_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/placeholder_span_index_semantics_tag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_render_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_render_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/rendering_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_abstract_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_abstract_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_android_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_android_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_opacity_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_opacity_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_size_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_size_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_block_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_block_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_clip_r_superellipse_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_editable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_editable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_shader_mask_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_shader_mask_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_box_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_box_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_floating_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_floating_pinned_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_pinned_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ui_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_hit_test_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_hit_test_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_layout_dimensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_layout_dimensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_paint_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_paint_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_error_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_error_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_word_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_word_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_constraints_transform_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_constraints_transform_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_follower_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_follower_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('follower_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/follower_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clear_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clear_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flow_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/flow_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_paragraph_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_paragraph_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('picture_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/picture_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // SCHEDULER (1 file)
  // ============================================================
  group('scheduler/', () {
    test('scheduler_phase_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_phase_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // REPRO_FA5 (2 files)
  // ============================================================
  group('repro_fa5/', () {
    test('canary_must_fail.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa5/canary_must_fail.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_widget_exact_type.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa5/inherited_widget_exact_type.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // REPRO_FA6 (1 file)
  // ============================================================
  group('repro_fa6/', () {
    test('canary_must_fail.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa6/canary_must_fail.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // RETEST/FOUNDATION (1 file)
  // ============================================================
  group('retest/foundation/', () {
    test('object_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // RETEST/SERVICES (1 file)
  // ============================================================
  group('retest/services/', () {
    test('method_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/services/method_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // SEMANTICS (2 files)
  // ============================================================
  group('semantics/', () {
    test('accessibility_focus_block_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/accessibility_focus_block_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('assertiveness_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/assertiveness_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('debug_semantics_dump_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/debug_semantics_dump_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tap_semantic_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tooltip_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // SERVICES (5 files)
  // ============================================================
  group('services/', () {
    test('content_sensitivity_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/content_sensitivity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/device_orientation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_cursor_drag_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/floating_cursor_drag_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_data_transit_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_data_transit_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_lock_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_lock_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_side_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_side_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('max_length_enforcement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/max_length_enforcement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('message_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/message_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('method_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/method_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_changed_cause_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_changed_cause_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/services_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_quotes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_quotes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/spell_check_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('swipe_edge_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/swipe_edge_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_sound_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_sound_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_capitalization_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_capitalization_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('modifier_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/modifier_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_share_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_look_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('missing_plugin_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/missing_plugin_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_views_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_views_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_rect_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_rect_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_channels_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_channels_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_version_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/flutter_version_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // WIDGETS (48 files)
  // ============================================================
  group('widgets/', () {
    test('action_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/action_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('actions_test.dart', () async {
      final result = await SendTestRunner.send('widgets/actions_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('align_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/align_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_fractionally_sized_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_fractionally_sized_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_positioned_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_positioned_directional_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/app_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_highlighted_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_highlighted_option_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_group_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_group_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('automatic_keep_alive_client_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/automatic_keep_alive_client_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('back_button_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/back_button_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('backdrop_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backdrop_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/border_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/box_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clip_r_superellipse_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/color_filtered_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('constrained_layout_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/constrained_layout_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('constraints_transform_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/constraints_transform_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_selection_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_selection_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_text_editing_shortcuts_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_text_editing_shortcuts_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_text_style_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_text_style_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('do_nothing_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('do_nothing_and_stop_propagation_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_and_stop_propagation_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_target_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_target_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dual_transition_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dual_transition_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('img_element_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/img_element_platform_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigatorstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigatorstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_transition_record_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_transition_record_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_increment_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_increment_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_selection_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcuts_actions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcuts_actions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_trigger_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_trigger_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unmanaged_restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unmanaged_restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('web_browser_detection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/web_browser_detection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_inspector_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedsize_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedsize_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('heromode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/heromode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('streambuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/streambuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sized_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sized_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedpositioned_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedpositioned_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/container_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_overlap_absorber_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_sliver_overlap_absorber_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('opacity_full_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/opacity_full_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedpadding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedpadding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('padding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/padding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_overlap_injector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_sliver_overlap_injector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('futurebuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/futurebuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sizing_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sizing_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedbuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedbuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('align_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/align_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('banner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/banner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flow_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/flow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/placeholder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_widgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_widgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_feature_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/display_feature_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expanded_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expanded_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flexible_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/flexible_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('textcontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/textcontroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notification_locale_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notification_locale_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('nestedscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nestedscrollview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // BATCH 1 DEEP DEMOS (9 files, 2026-05-05)
  // Hand-authored 1467+-line demos for the next nine entries
  // (idx 244..252) in `doc/short_tests_verification.md`. Six
  // were already deep when the batch opened (showdialog,
  // announce_semantics_event, animation_min, painting/matrix,
  // root_isolate_token, editable_text_misc); three were freshly
  // authored in this turn (focus_semantic_event, clamped_simulation,
  // selectable_chip_attributes). All nine are pinned here so any
  // future bridge/interpreter regression keeps them visible in CI.
  // ============================================================
  group('batch1_deep_demos/', () {
    test('material/showdialog_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showdialog_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics/announce_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/announce_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics/focus_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/focus_semantic_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation/animation_min_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_min_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physics/clamped_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/clamped_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/matrix_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrix_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/selectable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selectable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/editable_text_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/root_isolate_token_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/root_isolate_token_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 2 DEEP DEMOS (9 files, 2026-05-05)
  // Hand-authored 1500+-line demos for the next nine entries
  // (idx 253..261) in `doc/short_tests_verification.md`. All nine
  // were short stubs (80-102 lines) before this batch; each was
  // rewritten as a 12-section magazine with a unique palette
  // theme, real instances of the target class, and 1500+ lines.
  //
  // Themes:
  //   - PointerEventResampler          → Phosphor Lagoon
  //   - LongPressSemanticsEvent        → Granite Watchtower
  //   - PointerPanZoomUpdateEvent      → Glacial Topaz
  //   - IOSSystemContextMenuItemDataCut → Slate Iris
  //   - CarouselController             → Carnival Citrine
  //   - MenuAnchor                     → Aubergine Velvet
  //   - ReorderableListView            → Mosaic Plum
  //   - KeyHelper                      → Steel Cypress
  //   - FontLoader                     → Letterpress Saffron
  // ============================================================
  group('batch2_deep_demos/', () {
    test('gestures/pointer_event_resampler_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_resampler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics/long_press_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/long_press_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/pointer_pan_zoom_update_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_update_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/i_o_s_system_context_menu_item_data_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/carousel_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/menuanchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menuanchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/reorderablelistview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderablelistview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/key_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/font_loader_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/font_loader_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // Batch 3 deep demos — hand-authored 1500+ line rewrites of
  // verbose stub scripts. Each demo is themed and dramatises one
  // Flutter type with multiple visual displays + instructive prose.
  //   - TargetPlatform                              → Compass Obsidian
  //   - Priority                                    → Tide Cobalt
  //   - BoxDecoration                               → Stained Glass Cathedral
  //   - AttributedStringProperty                    → Inkwell Verbena
  //   - BoundedFrictionSimulation                   → Glacier Citrus
  //   - PersistentHeaderShowOnScreenConfiguration   → Tide Limestone
  //   - Localizations                               → Atlas Walnut
  //   - IOSSystemContextMenuItemDataPaste           → Tablet Marigold
  //   - OffsetPair                                  → Compass Mahogany
  // (idx 264 repro_fa2/scrolling_pill.dart is a narrow hypothesis
  //  reproducer — intentionally left as-is; idx 271 substituted.)
  // ============================================================
  group('batch3_deep_demos/', () {
    test('foundation/targetplatform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/targetplatform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler/priority_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/priority_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/box_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/box_decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics/attributed_string_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/attributed_string_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physics/bounded_friction_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/bounded_friction_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'rendering/persistent_header_show_on_screen_configuration_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'rendering/persistent_header_show_on_screen_configuration_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('widgets/localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'services/i_o_s_system_context_menu_item_data_paste_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'services/i_o_s_system_context_menu_item_data_paste_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('gestures/offset_pair_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/offset_pair_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // Batch 4 deep demos — hand-authored 1900+ line rewrites of
  // verbose stub scripts (idx 272-280). Each demo dramatises one
  // Flutter type with multiple visual displays + instructive prose.
  //   - SemanticsEvent                       → Lighthouse Beacon
  //   - Scaffold (advanced slots)            → Compass Cinnabar
  //   - Icon                                 → Glyph Lapis
  //   - Velocity / VelocityTracker           → Drift Argent
  //   - SuggestionSpan                       → Quill Tangerine
  //   - ListBody                             → Stack Spruce
  //   - FadeForwardsPageTransitionsBuilder   → Curtain Garnet
  //   - TextSelectionToolbarAnchors          → Pin Saffron
  //   - TextSelectionToolbarLayoutDelegate   → Sextant Indigo
  // ============================================================
  group('batch4_deep_demos/', () {
    test('semantics/semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/scaffold_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/velocity_drag_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_drag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/suggestion_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/suggestion_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/listbody_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/listbody_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'material/fade_forwards_page_transitions_builder_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'material/fade_forwards_page_transitions_builder_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('widgets/text_selection_toolbar_anchors_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_toolbar_anchors_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'widgets/text_selection_toolbar_layout_delegate_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/text_selection_toolbar_layout_delegate_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );
  });

  group('batch5_deep_demos/', () {
    test('widgets/scroll_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/valuelistenablebuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/valuelistenablebuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_floating_cursor_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_floating_cursor_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/least_squares_solver_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/least_squares_solver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_expansion_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_expansion_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/sliverfillremaining_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliverfillremaining_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'services/i_o_s_system_context_menu_item_data_select_all_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'services/i_o_s_system_context_menu_item_data_select_all_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('widgets/formstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/formstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 6 DEEP DEMOS (9 files, 2026-05-08)
  // First batch of the next-100 campaign. Hand-authored
  // 1500+-line deep demos with unique themes per file. Three
  // entries (decoration_test, documentation_icon_test,
  // bottom_navigation_bar_landscape_layout_test) were already
  // 2000+-line deep demos authored in earlier work but had
  // never been registered here; they were normalized
  // (analyzer-clean, single ignore_for_file line) and
  // registered alongside the six freshly authored entries.
  //
  // Themes:
  //   - DefaultSpellCheckService       → The Proofreader's Desk
  //   - Decoration (abstract)          → Plaster Carmine
  //   - IconData / IconDataProperty    → Atlas Iris
  //   - PerformanceModeRequestHandle   → Cockpit Performance Gauges
  //   - DefaultProcessTextService      → Etymologist's Workbench
  //   - IOSSystemContextMenuItemData
  //         (LiveText, sealed siblings) → iOS Brushed Aluminum
  //   - BottomNavigationBarLandscapeLayout → Pier Cerulean
  //   - Sliver delegates (builder/list/
  //         animated/safe-area/visibility/
  //         layout-builder)            → Card-Catalog Drawer
  //   - Stack / Positioned / IndexedStack → Theatrical Stage
  // ============================================================
  group('batch6_deep_demos/', () {
    test('services/default_spell_check_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/default_spell_check_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/documentation_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/documentation_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler/performance_mode_request_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/performance_mode_request_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/default_process_text_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/default_process_text_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'services/i_o_s_system_context_menu_item_data_live_text_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'services/i_o_s_system_context_menu_item_data_live_text_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'material/bottom_navigation_bar_landscape_layout_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'material/bottom_navigation_bar_landscape_layout_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('widgets/sliver_delegates_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_delegates_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stack_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch7_deep_demos/', () {
    test('material/showdatepicker_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showdatepicker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/network_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/network_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/shapes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shapes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/mouse_tracker_annotation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_tracker_annotation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physics/gravity_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/gravity_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/scale_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/scale_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/autofill_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/i_o_s_system_context_menu_item_data_custom_test.dart',
        () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_custom_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
  group('batch8_deep_demos/', () {
    test('cupertino/cupertino_picker_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_picker_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/velocity_estimate_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_estimate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/datarow_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/datarow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/text_painting_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_painting_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/layer_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler/scheduler_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_keyboard_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_keyboard_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/text_input_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/richtext_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/richtext_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/sliver_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch9_deep_demos/', () {
    test('animation/cubic_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/cubic_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/observer_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/observer_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/fab_location_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_location_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/render_custom_multi_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_multi_child_layout_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_key_event_data_fuchsia_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_fuchsia_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/text_input_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/inherited_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/notificationlistener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notificationlistener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/overlay_portal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch10_deep_demos/', () {
    test('animation/animation_max_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_max_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_nav_segmented_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_nav_segmented_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/immediate_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/immediate_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/process_text_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/process_text_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/text_editing_delta_deletion_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_deletion_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/row_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/row_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/scaffoldstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scaffoldstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/text_selection_gesture_detector_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_gesture_detector_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/toggleable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toggleable_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch11_deep_demos/', () {
    test('foundation/diagnosticable_tree_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/diagnostics_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_block_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/summary_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/summary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/polynomial_fit_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/polynomial_fit_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/performance_overlay_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/performance_overlay_option_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/android_pointer_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_pointer_properties_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_key_event_data_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/text_editing_delta_non_text_update_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_non_text_update_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/text_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch12_deep_demos/', () {
    test('animation/curves_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/curves_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_spell_check_suggestions_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_spell_check_suggestions_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/aggregated_timed_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/aggregated_timed_block_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/message_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/message_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/timed_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/timed_block_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/positioned_gesture_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/positioned_gesture_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/date_range_picker_dialog_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_range_picker_dialog_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/tooltip_feedback_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_feedback_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/backbutton_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backbutton_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/interactive_viewer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/interactive_viewer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
  group('batch13_deep_demos/', () {
    test('repro_fa5/inherited_model_inherit_from.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa5/inherited_model_inherit_from.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/velocity_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/text_editing_delta_replacement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_replacement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dialog_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/pagecontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pagecontroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_key_event_data_android_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_android_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/menu_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/renderobjects_basic_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_basic_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/showtimepicker_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showtimepicker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/asset_metadata_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/asset_metadata_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch14_deep_demos/', () {
    test('widgets/draggablescrollablesheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggablescrollablesheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/diagnosticable_tree_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/focus_traversal_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_traversal_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/element_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/element_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/notched_shapes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/notched_shapes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_key_event_data_ios_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_ios_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/popup_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/render_box_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_box_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/tabcontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tabcontroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch15_deep_demos/', () {
    test('cupertino/cupertino_text_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_magnifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/color_scheme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/color_scheme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/renderobjects_clip_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_clip_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/scroll_notifications_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_notifications_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/diagnosticable_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_key_event_data_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/raw_key_event_data_windows_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_windows_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/shaderfilter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shaderfilter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch16_deep_demos/', () {
    test('widgets/preferredsize_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferredsize_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/snackbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snackbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_scroll_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest/services/message_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/services/message_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/showmenu_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showmenu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/abstract_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/abstract_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/category_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/category_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/diagnosticable_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/application_switcher_description_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/application_switcher_description_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch17_deep_demos/', () {
    test('rendering/render_composite_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_composite_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/progress_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/progress_sheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/divider_listtile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/divider_listtile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest/widgets/raw_keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_keyboard_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/binary_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/binary_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_list_tile_chevron_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_list_tile_chevron_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/diagnostics_stack_trace_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_stack_trace_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/key_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/blocksemantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/blocksemantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 18 DEEP DEMOS (9 files, 2026-05-11)
  // Hand-authored visual demos averaging ~1950 lines covering
  // BitField, ReadBuffer/WriteBuffer, ObjectCreated lifecycle
  // (×2 variants), RenderView/RenderViewport, RestorationMixin,
  // RestorationManager platform round-trip, TextSelection model,
  // and the GridView constructor family.
  // ============================================================
  group('batch18_deep_demos/', () {
    test('foundation/bit_field_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/bit_field_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/buffers_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/buffers_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/object_created_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_created_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest/foundation/object_created_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_created_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/renderobjects_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/restoration_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/restoration_platform_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_platform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/text_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/gridview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gridview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 19 DEEP DEMOS (7 files, 2026-05-12)
  // Carry-over hand-authored visual demos for CupertinoColors,
  // BottomAppBar, SegmentedButton, FocusNode, LayoutBuilder,
  // Opacity, and RotationTransition. Each file is 1800+ lines
  // with rich semantic content, multi-panel visual layouts,
  // and instructive prose. Analyzer-clean with no ignore
  // pragmas.
  // ============================================================
  group('batch19_deep_demos/', () {
    test('cupertino/cupertino_colors_system_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_colors_system_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/bottom_app_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_app_bar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/segmentedbutton_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/segmentedbutton_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/focusnode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focusnode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/layoutbuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layoutbuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/rotationtransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/rotationtransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 20 DEEP DEMOS (9 files, 2026-05-12)
  // First batch of the 100-file rewrite campaign. Hand-authored
  // visual posters averaging ~2100 lines each, covering
  // ScrollPhysics deceleration, CupertinoThemeData, Shortcuts/
  // Actions infrastructure, AutofillGroup, dart:ui Paragraph,
  // ScrollNotification, Cupertino class tour, AppBarTheme, and
  // showModalBottomSheet. All analyzer-clean.
  // ============================================================
  group('batch20_deep_demos/', () {
    test('repro_fa2/scroll_decel_minus_telemetry.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa2/scroll_decel_minus_telemetry.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_theming_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_theming_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/shortcuts_actions_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcuts_actions_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/autofill_context_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/paragraph_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/paragraph_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/scrollnotification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollnotification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/class_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/class_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/appbar_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/appbar_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/showbottomsheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showbottomsheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 21 DEEP DEMOS (9 files, 2026-05-12)
  // Second batch of the 100-file rewrite campaign. Hand-authored
  // visual posters averaging ~2200 lines each, covering
  // Table/Wrap/Flow layout-of-many, ExpansionTile, Scaffold
  // FAB locations, advanced foundation primitives, RenderObject
  // layer pipeline, CupertinoPicker overlays, FlutterError,
  // RenderObject sizing, and Cupertino list widgets.
  // ============================================================
  group('batch21_deep_demos/', () {
    test('widgets/table_wrap_flow_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/table_wrap_flow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/expansiontile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansiontile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/scaffold_fab_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_fab_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/foundation_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/foundation_misc_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/render_layers_pipeline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_layers_pipeline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_picker_default_selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_picker_default_selection_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/error_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/error_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/renderobjects_sizing_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_sizing_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/list_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 22 DEEP DEMOS (9 files, 2026-05-12)
  // Hand-authored ~800-2600 line visual deep demos covering:
  // FAB locations + ScaffoldMessenger, CupertinoThumbPainter,
  // CupertinoSliverRefreshControl, ImageStream, DataTable,
  // TextEditingValue, ListView, GestureDetector, TickerFuture.
  // ============================================================
  group('batch22_deep_demos/', () {
    test('material/fablocation_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fablocation_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_thumb_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_thumb_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_refresh_mag_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_refresh_mag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/image_stream_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/data_table_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/data_table_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/text_editing_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/listview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/listview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/gesturedetector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesturedetector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler/tickerfuture_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/tickerfuture_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // BATCH 23 DEEP DEMOS (9 files, 2026-05-12)
  // Hand-authored ~1400-2600 line visual deep demos covering:
  // gesture details (Tap/Force/Drag/Scale), RawScrollbar,
  // ObstructingPreferredSizeWidget/CupertinoNavigationBar,
  // MediaQuery, AssetBundle/AssetImage, advanced TextField,
  // Offstage/Visibility/IgnorePointer family, SystemChrome,
  // dart:ui Paragraph/TextStyle primitives.
  // ============================================================
  group('batch23_deep_demos/', () {
    test('gestures/tap_force_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_force_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/rawscrollbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rawscrollbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/obstructing_preferred_size_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/obstructing_preferred_size_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/mediaquery_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/mediaquery_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/asset_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/asset_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/text_editing_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_editing_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/offstage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/system_chrome_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_chrome_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/text_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch24_deep_demos/', () {
    test('widgets/safearea_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/safearea_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_page_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_page_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/route_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/pageroute_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/pageroute_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/reorderable_material_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/reorderable_material_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/texttheme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/texttheme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/animated_widgets_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_widgets_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/license_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/license_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/advanced_decorations_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/advanced_decorations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch25_deep_demos/', () {
    test('animation/animation_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_misc_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/renderobjects_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_page_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_page_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/renderobjects_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_layout_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_misc_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/render_mixins_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_mixins_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/autocomplete_chips_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/autocomplete_chips_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/layers_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layers_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/gradient_rendering_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/gradient_rendering_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch26_deep_demos/', () {
    test('services/services_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/services_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/textspan_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/textspan_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/card_ink_splash_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/card_ink_splash_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/menubar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menubar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/picture_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/picture_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/segmented_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/segmented_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/inkwell_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inkwell_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/sliverwidgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliverwidgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/navigation_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch27_deep_demos/', () {
    test('material/nav_badge_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/nav_badge_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/gesture_callbacks_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_callbacks_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/channels_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/channels_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/slidetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slidetransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/fadetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fadetransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/key_events_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_events_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/listtile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/listtile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/gesture_callbacks_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_callbacks_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/draggable_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_sheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch28_deep_demos/', () {
    test('widgets/page_view_tabview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_view_tabview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/animatedopacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedopacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics/semantics_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/sliver_delegates_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_delegates_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/image_test.dart', () async {
      final result = await SendTestRunner.send('widgets/image_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/visibility_test.dart', () async {
      final result = await SendTestRunner.send('widgets/visibility_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/custompaint_test.dart', () async {
      final result = await SendTestRunner.send('widgets/custompaint_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/cursor_test.dart', () async {
      final result = await SendTestRunner.send('services/cursor_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/diagnostics_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // Batch A — 2026-05-16 deep-demo continuation (9 files)
  // CircleAvatar, InputDecorationTheme, Builder, MaterialBanner,
  // Key, LayoutBuilder (adv), SelectableText,
  // FloatingActionButton, CupertinoApp
  // ============================================================
  group('batch29_deep_demos/', () {
    test('material/circleavatar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/circleavatar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/text_field_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_field_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/builder_test.dart', () async {
      final result = await SendTestRunner.send('widgets/builder_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/materialbanner_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialbanner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/key_test.dart', () async {
      final result = await SendTestRunner.send('widgets/key_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/layout_builder_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layout_builder_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/selectabletext_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selectabletext_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/floatingactionbutton_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floatingactionbutton_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertinoapp_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertinoapp_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // Batch B — 2026-05-16 deep-demo continuation (11 files)
  // 8 rewritten (Hero, DialogTheme, RenderSliver types,
  // DropdownMenu, ScaleTransition, CupertinoSliverRefreshControl,
  // Dialog/BottomSheet, Form) plus 3 already-deep + analyzer-clean
  // (AnimatedContainer, AnimatedList, FormField) marked Fixed.
  // ============================================================
  group('batch30_deep_demos/', () {
    test('widgets/hero_test.dart', () async {
      final result = await SendTestRunner.send('widgets/hero_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dialog_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/render_sliver_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dropdown_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/scaletransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scaletransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/refresh_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/refresh_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dialog_bottom_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_bottom_sheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/form_test.dart', () async {
      final result = await SendTestRunner.send('widgets/form_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/form_field_test.dart', () async {
      final result = await SendTestRunner.send('widgets/form_field_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/animatedcontainer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedcontainer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/animatedlist_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedlist_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // Batch C — 2026-05-20 short_tests_verification_2 deep-demo
  // rewrite, Batch 1 of 12 (9 files). All files freshly authored
  // by per-file subagents, each ≥1274 lines, analyzer-clean.
  // ============================================================
  group('batch31_short_tests2_demos_b1/', () {
    test('foundation/text_tree_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/text_tree_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/animatedgrid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedgrid_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/animation_test.dart', () async {
      final result = await SendTestRunner.send('widgets/animation_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/bottomappbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottomappbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/pageview_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pageview_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/cliprrect_test.dart', () async {
      final result = await SendTestRunner.send('widgets/cliprrect_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/interactiveviewer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/interactiveviewer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/recognizers_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/recognizers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services/codecs_test.dart', () async {
      final result = await SendTestRunner.send('services/codecs_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch32_short_tests2_demos_b2/', () {
    test('material/buttons_test.dart', () async {
      final result = await SendTestRunner.send('material/buttons_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/materialapp_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialapp_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/tab_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/tab_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/key_test.dart', () async {
      final result = await SendTestRunner.send('foundation/key_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/button_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/button_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/navigator_test.dart', () async {
      final result = await SendTestRunner.send('widgets/navigator_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/picker_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/picker_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/debug_overflow_indicator_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/debug_overflow_indicator_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/component_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/component_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch33_short_tests2_demos_b3/', () {
    test('material/bottomnavigationbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottomnavigationbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/transform_test.dart', () async {
      final result = await SendTestRunner.send('widgets/transform_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/primitives_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/primitives_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/customscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/customscrollview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/widgetstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/widgetstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/wrap_test.dart', () async {
      final result = await SendTestRunner.send('widgets/wrap_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation/alwaysstoppedanimation_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/alwaysstoppedanimation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dropdownform_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdownform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/clip_r_rect_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_r_rect_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch34_short_tests2_demos_b4/', () {
    test('material/icontheme_test.dart', () async {
      final result = await SendTestRunner.send('material/icontheme_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/formcontrols_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/formcontrols_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_themes_batch2_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch2_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/stepper_test.dart', () async {
      final result = await SendTestRunner.send('material/stepper_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/decoratedbox_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decoratedbox_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/absorbpointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/absorbpointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/mergeable_test.dart', () async {
      final result = await SendTestRunner.send('material/mergeable_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/material_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/togglebuttons_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/togglebuttons_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch35_short_tests2_demos_b5/', () {
    test('cupertino/datepicker_modes_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/datepicker_modes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/table_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_themes_batch3_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch3_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/callback_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/callback_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/input_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/statefulwidget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/statefulwidget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest/widgets/render_nested_scroll_view_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/render_nested_scroll_view_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/border_test.dart', () async {
      final result = await SendTestRunner.send('painting/border_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation/animatable_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animatable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch36_short_tests2_demos_b6/', () {
    test('widgets/constrainedbox_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/constrainedbox_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/edgeinsets_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/edgeinsets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/divider_test.dart', () async {
      final result = await SendTestRunner.send('material/divider_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/render_object_to_widget_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_to_widget_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_themes_batch1_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch1_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation/compoundanimation_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/compoundanimation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/draggable_test.dart', () async {
      final result = await SendTestRunner.send('widgets/draggable_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation/tweensequence_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/tweensequence_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/nav_destinations_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/nav_destinations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch37_short_tests2_demos_b7/', () {
    test('rendering/textpainter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/textpainter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation/notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/render_tree_root_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tree_root_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dropdown_test.dart', () async {
      final result = await SendTestRunner.send('material/dropdown_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/sliverappbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/sliverappbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/misc_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/misc_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/progress_test.dart', () async {
      final result = await SendTestRunner.send('material/progress_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/cupertino_themes_batch4_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch4_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/buttonstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/buttonstyle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch38_short_tests2_demos_b8/', () {
    test('physics/simulations_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/simulations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/boxconstraints_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/boxconstraints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/inputdecoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/inputdecoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dialog_test.dart', () async {
      final result = await SendTestRunner.send('material/dialog_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/materialcolor_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialcolor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler/ticker_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/ticker_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/tooltip_badge_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_badge_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/app_exit_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_exit_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/search_test.dart', () async {
      final result = await SendTestRunner.send('material/search_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch39_short_tests2_demos_b9/', () {
    test('cupertino/dialog_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/dialog_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/scrollbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scrollbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/render_fractional_translation_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_fractional_translation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/picker_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/picker_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/theme_test.dart', () async {
      final result = await SendTestRunner.send('material/theme_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation/curve_test.dart', () async {
      final result = await SendTestRunner.send('animation/curve_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/traversal_edge_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_edge_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering/render_fractionally_sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_fractionally_sized_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/app_exit_response_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_exit_response_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch40_short_tests2_demos_b10/', () {
    test('painting/gradient_shadow_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradient_shadow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting/textstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/textstyle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/backdrop_filter_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/backdrop_filter_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/accessibility_features_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/accessibility_features_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation/tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/scaffold_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/scaffold_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/app_lifecycle_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_lifecycle_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/blur_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/blur_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch41_short_tests2_demos_b11/', () {
    test('rendering/render_exclude_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_exclude_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/channel_buffers_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/channel_buffers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/blend_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/blend_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/box_width_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/box_width_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/dynamic_scheme_variant_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dynamic_scheme_variant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui/class_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/class_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino/icons_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/icons_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gestures/class_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/class_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('batch42_short_tests2_demos_b12/', () {
    test('material/material_tap_target_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_tap_target_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('retest/material/button_bar_layout_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_bar_layout_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material/checkbox_list_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/checkbox_list_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest/material/dropdown_menu_close_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/dropdown_menu_close_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest/material/button_text_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_text_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest/material/material_banner_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/material_banner_closed_reason_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'retest/material/navigation_destination_label_behavior_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/material/navigation_destination_label_behavior_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('material/drawer_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
