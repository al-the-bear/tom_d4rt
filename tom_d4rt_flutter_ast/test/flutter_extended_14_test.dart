/// Auto-split extended bridge tests (file 14).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_14_test.dart';

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
    test('decoration_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decoration_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('default_platform_menu_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_platform_menu_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('default_selection_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_selection_style_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('default_text_editing_shortcuts_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_text_editing_shortcuts_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('default_text_style_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_text_style_transition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('default_transition_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_transition_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('delete_character_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_character_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('delete_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_to_line_break_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('delete_to_next_word_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_to_next_word_boundary_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('desktop_text_selection_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/desktop_text_selection_toolbar_layout_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dev_tools_deep_link_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dev_tools_deep_link_property_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('device_orientation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/device_orientation_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('diagonal_drag_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/diagonal_drag_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_window_controller_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_linux_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_window_controller_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_mac_o_s_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_window_controller_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_win32_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('directional_caret_movement_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_caret_movement_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('directional_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('directional_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('directional_focus_traversal_policy_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_traversal_policy_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('directional_text_editing_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_text_editing_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('disable_widget_inspector_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/disable_widget_inspector_scope_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dismiss_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dismiss_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dismiss_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dismiss_menu_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_menu_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dismiss_update_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_update_details_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dismissible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/dismissible_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('disposable_build_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/disposable_build_context_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('do_nothing_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('do_nothing_and_stop_propagation_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_and_stop_propagation_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('do_nothing_and_stop_propagation_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_and_stop_propagation_text_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('do_nothing_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drag_boundary_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_boundary_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drag_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_boundary_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drag_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_scroll_activity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drag_target_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_target_details_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('draggable_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_details_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('draggable_scrollable_actuator_test.dart', () async {
      // 1944 TODO C.90 (2026-06-01): historical 20260523-1056 §1.7/E31
      // cold-start-contention wrapper REMOVED. Script runs in ~2.0 s
      // under isolated retest (httpMs=1491, totalMs=1963,
      // frameworkErrors=0, sourceChars=60641 — 61 KB / 1591-line /
      // 973 KB bundle). First entry in §C.vii (hardly_relevant_4 —
      // widgets-heavy suite). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_actuator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('draggable_scrollable_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('draggable_scrollable_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_notification_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('driven_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/driven_scroll_activity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('edge_dragging_auto_scroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_dragging_auto_scroller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('edge_insets_geometry_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_insets_geometry_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('edge_insets_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_insets_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('editable_text_tap_outside_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_tap_outside_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('editable_text_tap_up_outside_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_tap_up_outside_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('empty_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/empty_text_selection_controls_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('enable_widget_inspector_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/enable_widget_inspector_scope_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('exclude_focus_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/exclude_focus_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('exclude_focus_traversal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/exclude_focus_traversal_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expand_selection_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expand_selection_to_document_boundary_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expand_selection_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expand_selection_to_line_break_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expansible_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expansible_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expansible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/expansible_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('extend_selection_by_character_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_by_character_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('extend_selection_by_page_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_by_page_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
