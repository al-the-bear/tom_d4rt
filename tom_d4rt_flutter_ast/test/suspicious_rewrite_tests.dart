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

  });
}
