/// Auto-split extended bridge tests (file 13).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_13_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
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
      SendTestRunner.expectSuccess(result);
    });

    test('action_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/action_dispatcher_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('action_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/action_listener_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('activate_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/activate_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('activate_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/activate_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('align_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/align_transition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('android_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_overscroll_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_view_surface_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_grid_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_grid_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_list_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_positioned_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_positioned_directional_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_widget_base_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_widget_base_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('annotated_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/annotated_region_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/app_kit_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('app_lifecycle_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/app_lifecycle_listener_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('async_snapshot_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/async_snapshot_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_first_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_first_option_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_highlighted_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_highlighted_option_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_last_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_last_option_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_next_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_next_option_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_next_page_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_next_page_option_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_previous_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_previous_option_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_previous_page_option_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_previous_page_option_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autofill_context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autofill_group_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_group_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('automatic_keep_alive_client_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/automatic_keep_alive_client_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autovalidate_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autovalidate_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('back_button_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/back_button_listener_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('backdrop_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backdrop_group_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('ballistic_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ballistic_scroll_activity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('banner_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/banner_location_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('banner_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/banner_painter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('base_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/base_window_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('border_radius_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/border_radius_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('border_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/border_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bottom_navigation_bar_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/bottom_navigation_bar_item_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bouncing_scroll_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/bouncing_scroll_simulation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('box_constraints_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/box_constraints_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('box_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/box_scroll_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('button_activate_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/button_activate_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('callback_shortcuts_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/callback_shortcuts_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('captured_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/captured_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('change_reporting_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/change_reporting_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('character_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/character_activator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('child_back_button_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/child_back_button_dispatcher_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('child_vicinity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/child_vicinity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('clamping_scroll_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clamping_scroll_simulation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('widgets/class_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clip_r_superellipse_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('clipboard_status_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clipboard_status_notifier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('clipboard_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clipboard_status_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('connection_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/connection_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('constrained_layout_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/constrained_layout_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('constraints_transform_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/constraints_transform_box_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('context_menu_button_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_button_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('copy_selection_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/copy_selection_text_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cross_fade_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/cross_fade_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('debug_creator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/debug_creator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('decorated_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decorated_sliver_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
