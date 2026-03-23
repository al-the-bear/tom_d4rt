/// Tests for hardly relevant Flutter bridge classes (part 4 of 5).
///
/// widgets package (a-p, first half)
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Run tests: flutter test test/hardly_relevant_classes_4_test.dart
///
/// The test app is started automatically in setUpAll and stopped in tearDownAll
/// when needed.
///
/// Total: 228 test entries
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
  // WIDGETS PACKAGE (456 files)
  // ============================================================
  group('widgets/', () {
    test('abstract_layout_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/abstract_layout_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('action_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/action_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('action_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/action_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('activate_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/activate_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('activate_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/activate_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('align_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/align_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_overscroll_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_grid_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_grid_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_positioned_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_positioned_directional_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_widget_base_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_widget_base_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('annotated_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/annotated_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/app_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_lifecycle_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/app_lifecycle_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('async_snapshot_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/async_snapshot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_first_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_first_option_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_highlighted_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_highlighted_option_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_last_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_last_option_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_next_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_next_option_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_next_page_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_next_page_option_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_previous_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_previous_option_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_previous_page_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_previous_page_option_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_action_test.dart',
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

    test('autovalidate_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autovalidate_mode_test.dart',
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

    test('ballistic_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ballistic_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('banner_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/banner_location_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('banner_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/banner_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('base_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/base_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_radius_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/border_radius_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/border_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bottom_navigation_bar_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/bottom_navigation_bar_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bouncing_scroll_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/bouncing_scroll_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_constraints_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/box_constraints_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/box_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_activate_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/button_activate_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('callback_shortcuts_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/callback_shortcuts_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('captured_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/captured_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('change_reporting_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/change_reporting_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('character_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/character_activator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('child_back_button_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/child_back_button_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('child_vicinity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/child_vicinity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clamping_scroll_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clamping_scroll_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('widgets/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clip_r_superellipse_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clipboard_status_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clipboard_status_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clipboard_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clipboard_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('connection_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/connection_state_test.dart',
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

    test('context_menu_button_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_button_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('copy_selection_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/copy_selection_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cross_fade_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/cross_fade_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('debug_creator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/debug_creator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('decorated_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decorated_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('decoration_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decoration_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_platform_menu_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_platform_menu_delegate_test.dart',
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

    test('default_transition_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_transition_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delete_character_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_character_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delete_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_to_line_break_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delete_to_next_word_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_to_next_word_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/desktop_text_selection_toolbar_layout_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dev_tools_deep_link_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dev_tools_deep_link_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_orientation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/device_orientation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagonal_drag_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/diagonal_drag_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_caret_movement_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_caret_movement_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_focus_traversal_policy_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_traversal_policy_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_text_editing_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_text_editing_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('disable_widget_inspector_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/disable_widget_inspector_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_menu_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_menu_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_update_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_update_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismissible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/dismissible_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('disposable_build_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/disposable_build_context_test.dart',
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

    test('do_nothing_and_stop_propagation_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_and_stop_propagation_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('do_nothing_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_boundary_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_boundary_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_target_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_target_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_scrollable_actuator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_actuator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_scrollable_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_scrollable_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('driven_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/driven_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_dragging_auto_scroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_dragging_auto_scroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_insets_geometry_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_insets_geometry_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_insets_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_insets_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('editable_text_tap_outside_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_tap_outside_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('editable_text_tap_up_outside_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_tap_up_outside_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('empty_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/empty_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('enable_widget_inspector_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/enable_widget_inspector_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('exclude_focus_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/exclude_focus_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('exclude_focus_traversal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/exclude_focus_traversal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expand_selection_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expand_selection_to_document_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expand_selection_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expand_selection_to_line_break_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansible_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expansible_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/expansible_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_by_character_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_by_character_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_by_page_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_by_page_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_document_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_line_break_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'extend_selection_to_next_paragraph_boundary_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('extend_selection_to_next_word_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_next_word_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_line_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_page_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('feedback_test.dart', () async {
      final result = await SendTestRunner.send('widgets/feedback_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_scroll_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_scroll_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flex_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flex_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_header_snap_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/floating_header_snap_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_attachment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_attachment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_highlight_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_highlight_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_order_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focus_order_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_scope_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_scope_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_traversal_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_traversal_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fractional_translation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fractional_translation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_factory_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_factory_with_handlers_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_with_handlers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('global_object_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/global_object_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_flight_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_flight_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hold_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hold_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_custom_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_custom_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_live_text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_look_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_paste_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_paste_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_search_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_search_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_select_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_select_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_share_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_data_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_data_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_data_test.dart', () async {
      final result = await SendTestRunner.send('widgets/icon_data_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('idle_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/idle_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ignore_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ignore_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_icon_test.dart', () async {
      final result = await SendTestRunner.send('widgets/image_icon_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('img_element_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/img_element_platform_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('indexed_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_model_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_model_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_button_variant_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_button_variant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_reference_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_reference_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_serialization_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_serialization_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/key_event_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_set_test.dart', () async {
      final result = await SendTestRunner.send('widgets/key_set_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keyboard_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('labeled_global_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/labeled_global_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layout_id_test.dart', () async {
      final result = await SendTestRunner.send('widgets/layout_id_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('lexical_focus_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/lexical_focus_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_input_status_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_input_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('local_history_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/local_history_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('localizations_resolver_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/localizations_resolver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('lock_state_test.dart', () async {
      final result = await SendTestRunner.send('widgets/lock_state_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('logical_key_set_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/logical_key_set_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('lookup_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/lookup_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix4_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/matrix4_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/matrix_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_serializable_shortcut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/menu_serializable_shortcut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('meta_data_test.dart', () async {
      final result = await SendTestRunner.send('widgets/meta_data_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('modal_barrier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/modal_barrier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_selectable_selection_container_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_selectable_selection_container_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigator_pop_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigator_pop_handler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('nested_scroll_view_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nested_scroll_view_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('nested_scroll_view_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nested_scroll_view_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('next_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/next_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('next_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/next_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notifiable_element_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notifiable_element_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('numeric_focus_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/numeric_focus_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_key_test.dart', () async {
      final result = await SendTestRunner.send('widgets/object_key_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('options_view_open_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/options_view_open_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ordered_traversal_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ordered_traversal_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('orientation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/orientation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('orientation_test.dart', () async {
      final result = await SendTestRunner.send('widgets/orientation_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_bar_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_bar_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_child_layout_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_child_layout_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_child_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_child_location_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_portal_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_portal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overscroll_indicator_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overscroll_indicator_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overscroll_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overscroll_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_route_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_route_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_test.dart', () async {
      final result = await SendTestRunner.send('widgets/page_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pan_axis_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pan_axis_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('paste_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/paste_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_provided_menu_item_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_provided_menu_item_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_route_information_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_route_information_provider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_selectable_region_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_selectable_region_context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_creation_params_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_view_creation_params_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pop_entry_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pop_entry_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

  });
}
