/// Auto-split base bridge tests (file 10).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
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

  // --- MATERIAL INDIVIDUAL SCRIPTS (74 files) ---
  group('material/ individual', () {
    test('adaptive_text_selection_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/adaptive_text_selection_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/app_bar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('base_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/base_range_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('base_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/base_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bottom_app_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_app_bar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_style_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_style_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('calendar_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/calendar_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('card_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/card_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checkbox_list_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/checkbox_list_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checkmarkable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/checkmarkable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('chip_animation_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_animation_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('colors_test.dart', () async {
      final result = await SendTestRunner.send('material/colors_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('controls_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/controls_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('data_table_source_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/data_table_source_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('data_table_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/data_table_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('data_table_theme_test.dart', () async {
      // 1944 TODO C.15 (2026-05-31): historical 20260524-2003 §6/T11
      // cold-start wrapper REMOVED. Script runs in ~1.6 s under
      // normal load (httpMs=1579). First entry of subsection §C.iii
      // (secondary_classes_test cleanup, 31 entries).
      final result = await SendTestRunner.send(
        'material/data_table_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('date_range_picker_dialog_test.dart', () async {
      // 1944 TODO C.16 (2026-05-31): historical 20260524-2003 §6/T12
      // cold-start wrapper REMOVED. Script runs in ~2.3 s under
      // normal load (httpMs=2300).
      final result = await SendTestRunner.send(
        'material/date_range_picker_dialog_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // 20260524-2003 baseline §6/E10–E12: cold-start cascade pattern in the
    // material-individual group on `secondary_classes_test`. Bump cap from
    // 25 s to 50 s with 60 s dart-test wrapper on the three date* + default
    // localizations entries.
    test('date_time_range_test.dart', () async {
      // 1944 TODO C.17 (2026-05-31): wrapper REMOVED. Script runs in
      // ~1.6 s under normal load (httpMs=1590).
      final result = await SendTestRunner.send(
        'material/date_time_range_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('date_utils_test.dart', () async {
      // 1944 TODO C.18 (2026-05-31): wrapper REMOVED. Script runs in
      // ~1.7 s under normal load (httpMs=1660).
      final result = await SendTestRunner.send('material/date_utils_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_material_localizations_test.dart', () async {
      // 1944 TODO C.19 (2026-05-31): wrapper REMOVED. Script runs in
      // ~1.6 s under normal load (httpMs=1588).
      final result = await SendTestRunner.send(
        'material/default_material_localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('deletable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/deletable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/desktop_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_toolbar_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/desktop_text_selection_toolbar_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/desktop_text_selection_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('disabled_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/disabled_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('filled_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/filled_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_action_button_animator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_action_button_animator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_action_button_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_action_button_location_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/icon_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('input_decoration_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_decoration_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_style_test.dart', () async {
      final result = await SendTestRunner.send('material/menu_style_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_drawer_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_drawer_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('outlined_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/outlined_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_list_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/radio_list_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_labels_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_labels_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_thumb_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_tick_mark_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_values_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_values_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_material_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/raw_material_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rectangular_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_slider_overlay_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_slider_overlay_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_slider_thumb_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_slider_tick_mark_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rounded_rect_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_feature_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_feature_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_messenger_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_messenger_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selectable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slider_component_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_component_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_tick_mark_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
