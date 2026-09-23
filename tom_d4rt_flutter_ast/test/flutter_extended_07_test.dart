/// Auto-split extended bridge tests (file 07).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_07_test.dart';

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
    test('refresh_indicator_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_indicator_status_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('refresh_indicator_trigger_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_indicator_trigger_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('refresh_progress_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_progress_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('restorable_time_of_day_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/restorable_time_of_day_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('round_range_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_range_slider_thumb_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('round_range_slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_range_slider_tick_mark_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rounded_rect_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_range_slider_track_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rounded_rect_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_range_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rounded_rect_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scaffold_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_geometry_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scaffold_prelayout_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_prelayout_geometry_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('script_category_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/script_category_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scrollbar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scrollbar_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('search_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('search_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('segmented_button_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/segmented_button_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_area_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selection_area_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('shape_border_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/shape_border_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('show_value_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/show_value_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('simple_dialog_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/simple_dialog_option_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('slider_interaction_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_interaction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('snack_bar_theme_data_test.dart', () async {
      // 1944 TODO C.67 (2026-05-31): historical 20260523-1056 §1.5/E21
      // cold-start-contention wrapper REMOVED. Script runs in ~1.8 s
      // under normal load (httpMs=1825, bundleJsonBytes=447625 —
      // 448 KB bundle / 49 KB / 1331-line script).
      final result = await SendTestRunner.send(
        'material/snack_bar_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('spell_check_suggestions_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/spell_check_suggestions_toolbar_layout_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('standard_fab_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/standard_fab_location_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('step_style_test.dart', () async {
      final result = await SendTestRunner.send('material/step_style_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('stretch_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/stretch_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_indicator_animation_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_indicator_animation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_page_selector_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_page_selector_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_page_selector_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_page_selector_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('table_row_ink_well_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/table_row_ink_well_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tappable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tappable_chip_attributes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_magnifier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('theme_data_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/theme_data_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('theme_extension_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/theme_extension_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('theme_mode_test.dart', () async {
      final result = await SendTestRunner.send('material/theme_mode_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('thumb_test.dart', () async {
      final result = await SendTestRunner.send('material/thumb_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('time_of_day_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/time_of_day_format_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('time_picker_entry_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/time_picker_entry_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('toggle_buttons_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/toggle_buttons_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('toggle_buttons_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/toggle_buttons_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('underline_tab_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/underline_tab_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('vertical_divider_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/vertical_divider_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('widget_state_input_border_test.dart', () async {
      // 1944 TODO C.68 (2026-05-31): historical 20260523-1056 §1.5/E22
      // cold-start-contention wrapper REMOVED. Script runs in ~1.5 s
      // under normal load (httpMs=1497, bundleJsonBytes=558175 —
      // 558 KB bundle / 48 KB / 1380-line script).
      final result = await SendTestRunner.send(
        'material/widget_state_input_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
