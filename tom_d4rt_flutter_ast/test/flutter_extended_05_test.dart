/// Auto-split extended bridge tests (file 05).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_05_test.dart';

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
  // MATERIAL PACKAGE (167 files)
  // ============================================================
  group('material/', () {
    test('adaptation_test.dart', () async {
      final result = await SendTestRunner.send('material/adaptation_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('animated_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/animated_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/autocomplete_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('back_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/back_button_icon_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('back_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/back_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bottom_navigation_bar_landscape_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_landscape_layout_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bottom_navigation_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bottom_navigation_bar_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bottom_navigation_bar_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('button_bar_layout_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_bar_layout_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('button_bar_test.dart', () async {
      final result = await SendTestRunner.send('material/button_bar_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('button_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_bar_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('button_bar_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_bar_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('button_text_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_text_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('carousel_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('carousel_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_scroll_physics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('carousel_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('carousel_view_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_view_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('carousel_view_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_view_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('checked_popup_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/checked_popup_menu_item_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('material/class_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('close_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/close_button_icon_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('close_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/close_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('collapse_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/collapse_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_based_material_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/cupertino_based_material_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('date_picker_entry_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_picker_entry_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('date_picker_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_picker_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('day_period_test.dart', () async {
      final result = await SendTestRunner.send('material/day_period_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_route_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drawer_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drawer_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_button_icon_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drawer_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drawer_controller_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_controller_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drawer_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drop_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drop_range_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('drop_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drop_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dropdown_button_hide_underline_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_button_hide_underline_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dropdown_menu_close_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_close_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dropdown_menu_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_entry_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dropdown_menu_form_field_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_form_field_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dropdown_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_item_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('durations_test.dart', () async {
      final result = await SendTestRunner.send('material/durations_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('dynamic_scheme_variant_test.dart', () async {
      // 1944 TODO C.64 (2026-05-31): historical 20260523-1056 §1.5/E18
      // cold-start-contention wrapper REMOVED. Script runs in ~3.8 s
      // under normal load (httpMs=3836, bundleJsonBytes=652320 —
      // 652 KB bundle / 58 KB / 1697-line script). Slower than typical
      // but still ~26 s of headroom under the 30 s default.
      final result = await SendTestRunner.send(
        'material/dynamic_scheme_variant_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('easing_test.dart', () async {
      final result = await SendTestRunner.send('material/easing_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('elevation_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/elevation_overlay_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('end_drawer_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/end_drawer_button_icon_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('end_drawer_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/end_drawer_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expand_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expand_icon_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expansion_panel_radio_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansion_panel_radio_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_center_offset_x_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_center_offset_x_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_contained_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_contained_offset_y_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_docked_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_docked_offset_y_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_end_offset_x_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_end_offset_x_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_float_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_float_offset_y_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_mini_offset_adjustment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_mini_offset_adjustment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_start_offset_x_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_start_offset_x_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_top_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_top_offset_y_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fade_forwards_page_transitions_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fade_forwards_page_transitions_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flexible_space_bar_settings_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/flexible_space_bar_settings_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('floating_label_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_label_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
