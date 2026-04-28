/// Generator/Interpreter Retest — Section 1 tests with workarounds reverted.
///
/// This test file runs the ORIGINAL (broken) versions of tests that were
/// modified with script-side workarounds. These tests are expected to FAIL
/// until the underlying generator/interpreter issues are fixed.
///
/// The original scripts are stored in:
///   test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/retest/
///
/// Total: 58 tests
@TestOn('vm')
library;

import 'dart:io' show Platform;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// Helper to check that a test truly passes (success AND no framework errors).
void expectSuccess(SendResult result) {
  final errors = result.frameworkErrors.isNotEmpty
      ? result.frameworkErrors.join('; ')
      : null;
  final reason = result.error ?? errors;
  expect(result.success && !result.hasFrameworkErrors, isTrue, reason: reason);
}

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Section 1 - Tests with workarounds reverted', () {
    // Animation
    test('retest: animation/reverse_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/animation/reverse_tween_test.dart',
      );
      expectSuccess(result);
    });

    // Dart UI
    test('retest: dart_ui/key_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/dart_ui/key_event_type_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: dart_ui/vertex_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/dart_ui/vertex_mode_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: dart_ui/color_space_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/dart_ui/color_space_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: dart_ui/system_color_palette_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/dart_ui/system_color_palette_test.dart',
      );
      expectSuccess(result);
    }, skip: Platform.isLinux ? 'SystemColor not supported on Linux' : null);

    // Foundation
    test('retest: foundation/object_created_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_created_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: foundation/object_disposed_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_disposed_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: foundation/object_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_event_test.dart',
      );
      expectSuccess(result);
    });

    // Material
    test('retest: material/bottom_navigation_bar_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/bottom_navigation_bar_type_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/button_bar_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_bar_theme_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/button_bar_layout_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_bar_layout_behavior_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/button_text_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_text_theme_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/dropdown_menu_close_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/dropdown_menu_close_behavior_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/gapped_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/gapped_range_slider_track_shape_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/hour_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/hour_format_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/material_banner_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/material_banner_closed_reason_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/navigation_destination_label_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/navigation_destination_label_behavior_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/navigation_rail_label_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/navigation_rail_label_type_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/popup_menu_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/popup_menu_position_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/theme_extension_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/theme_extension_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/toggle_buttons_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/toggle_buttons_theme_data_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/toggle_buttons_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/toggle_buttons_theme_test.dart',
      );
      expectSuccess(result);
    });

    // Painting
    test('retest: painting/axis_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/painting/axis_direction_test.dart',
      );
      expectSuccess(result);
    });

    // Rendering
    test('retest: rendering/hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/hit_test_behavior_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: rendering/over_scroll_header_stretch_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/over_scroll_header_stretch_configuration_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: rendering/render_android_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/render_android_view_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: rendering/render_animated_size_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/render_animated_size_state_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: rendering/render_sliver_box_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/render_sliver_box_child_manager_test.dart',
      );
      expectSuccess(result);
    });

    // Services
    test('retest: services/message_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/services/message_codec_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: services/method_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/services/method_codec_test.dart',
      );
      expectSuccess(result);
    });

    // Widgets
    test('retest: widgets/android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/android_view_surface_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/app_kit_view_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/back_button_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/back_button_listener_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/box_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/box_scroll_view_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/context_action_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/default_selection_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/default_selection_style_test.dart',
      );
      expectSuccess(result);
    }, skip: 'crashes the test app; investigate separately');

    test('retest: widgets/default_text_editing_shortcuts_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/default_text_editing_shortcuts_test.dart',
      );
      expectSuccess(result);
    }, skip: 'crashes the test app (onLayout setter on RenderProxyBox); investigate separately');

    test('retest: widgets/live_text_input_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/live_text_input_status_test.dart',
      );
      expectSuccess(result);
    }, skip: 'crashes the test app (onLayout setter + app exit); investigate separately');

    test('retest: widgets/lock_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/lock_state_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/nested_scroll_view_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/nested_scroll_view_state_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/next_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/next_focus_intent_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/object_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/object_key_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/raw_dialog_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_dialog_route_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/raw_keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_keyboard_listener_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/raw_menu_overlay_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_menu_overlay_info_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/raw_radio_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_radio_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/redo_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/redo_text_intent_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/regular_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_delegate_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/regular_window_controller_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_linux_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/regular_window_controller_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_mac_o_s_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/regular_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/regular_window_controller_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_win32_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/regular_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/render_abstract_layout_builder_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/render_abstract_layout_builder_mixin_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/render_nested_scroll_view_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/render_nested_scroll_view_viewport_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/render_tap_region_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/render_tap_region_surface_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/replace_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/replace_text_intent_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/request_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/request_focus_action_test.dart',
      );
      expectSuccess(result);
    });
  });
}
