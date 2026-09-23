/// Auto-split extended bridge tests (file 06).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_06_test.dart';

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
    test('floating_label_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_label_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gapped_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/gapped_range_slider_track_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gapped_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/gapped_slider_track_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gregorian_calendar_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/gregorian_calendar_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('grid_tile_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/grid_tile_bar_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('grid_tile_test.dart', () async {
      final result = await SendTestRunner.send('material/grid_tile_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('handle_range_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/handle_range_slider_thumb_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('handle_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/handle_thumb_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('hour_format_test.dart', () async {
      // 1944 TODO C.71 (2026-05-31): historical 20260523-1056 §1.5/E19
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. Script runs in ~2.4 s under normal load
      // (httpMs=2434, sourceChars=49485 — 49 KB / 1664-line script).
      final result = await SendTestRunner.send(
        'material/hour_format_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('icon_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/icon_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('icons_test.dart', () async {
      final result = await SendTestRunner.send('material/icons_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('ink_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/ink_decoration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('ink_sparkle_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/ink_sparkle_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('input_date_picker_form_field_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_date_picker_form_field_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('input_decoration_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_decoration_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('input_decorator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_decorator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('interactive_ink_feature_factory_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/interactive_ink_feature_factory_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_tile_control_affinity_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_control_affinity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_tile_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_style_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_tile_title_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_title_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('magnifier_test.dart', () async {
      final result = await SendTestRunner.send('material/magnifier_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('material_banner_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_banner_closed_reason_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_point_arc_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_point_arc_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_rect_arc_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_rect_arc_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_rect_center_arc_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_rect_center_arc_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_scroll_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_state_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_state_outline_input_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_state_outline_input_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_state_underline_input_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_state_underline_input_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_tap_target_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_tap_target_size_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('material_text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_text_selection_handle_controls_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menu_accelerator_callback_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_accelerator_callback_binding_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menu_accelerator_label_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_accelerator_label_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menu_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_button_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menu_button_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_button_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('mergeable_material_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/mergeable_material_item_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('modal_bottom_sheet_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/modal_bottom_sheet_route_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('navigation_destination_label_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_destination_label_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('navigation_drawer_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_drawer_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('navigation_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('navigation_rail_label_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_rail_label_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('no_splash_test.dart', () async {
      final result = await SendTestRunner.send('material/no_splash_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('paddle_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paddle_range_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('paddle_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paddle_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('paginated_data_table_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paginated_data_table_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('persistent_bottom_sheet_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/persistent_bottom_sheet_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('platform_adaptive_icons_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/platform_adaptive_icons_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('popup_menu_button_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_button_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('popup_menu_divider_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_divider_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('popup_menu_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_entry_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('popup_menu_item_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_item_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('popup_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_item_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('popup_menu_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_position_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test(
      'predictive_back_fullscreen_page_transitions_builder_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'material/predictive_back_fullscreen_page_transitions_builder_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
    );

    test('progress_indicator_test.dart', () async {
      // 1944 TODO C.72 (2026-05-31): historical 20260523-1056 §1.5/E20
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. Script runs in ~1.7 s under normal load
      // (httpMs=1728, sourceChars=57863 — 58 KB / 1734-line script).
      final result = await SendTestRunner.send(
        'material/progress_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('raw_chip_test.dart', () async {
      final result = await SendTestRunner.send('material/raw_chip_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('rectangular_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_range_slider_track_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rectangular_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_range_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rectangular_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_slider_value_indicator_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('refresh_indicator_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_indicator_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
