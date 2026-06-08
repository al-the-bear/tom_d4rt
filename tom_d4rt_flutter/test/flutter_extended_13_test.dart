/// Auto-split extended bridge tests (file 13).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
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
  });
}
