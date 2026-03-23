/// Tests for hardly relevant Flutter bridge classes (part 2 of 5).
///
/// material, painting, physics packages
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Run tests: flutter test test/hardly_relevant_classes_2_test.dart
///
/// The test app is started automatically in setUpAll and stopped in tearDownAll
/// when needed.
///
/// Total: 202 test entries
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
  // MATERIAL PACKAGE (167 files)
  // ============================================================
  group('material/', () {
    test('adaptation_test.dart', () async {
      final result = await SendTestRunner.send('material/adaptation_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_icon_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/animated_icon_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/animated_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/autocomplete_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('back_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/back_button_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('back_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/back_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bottom_navigation_bar_landscape_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_landscape_layout_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bottom_navigation_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bottom_navigation_bar_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_navigation_bar_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

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

    test('button_bar_test.dart', () async {
      final result = await SendTestRunner.send('material/button_bar_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_bar_theme_data_test.dart',
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

    test('carousel_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('carousel_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('carousel_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('carousel_view_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_view_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('carousel_view_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/carousel_view_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checked_popup_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/checked_popup_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('material/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('close_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/close_button_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('close_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/close_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('collapse_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/collapse_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_based_material_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/cupertino_based_material_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('date_picker_entry_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_picker_entry_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('date_picker_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_picker_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('day_period_test.dart', () async {
      final result = await SendTestRunner.send('material/day_period_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drawer_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drawer_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_button_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drawer_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drawer_controller_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_controller_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drawer_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drop_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drop_range_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drop_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drop_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_button_hide_underline_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_button_hide_underline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_menu_close_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_close_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_menu_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_menu_form_field_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_form_field_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('durations_test.dart', () async {
      final result = await SendTestRunner.send('material/durations_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('dynamic_scheme_variant_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dynamic_scheme_variant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('easing_test.dart', () async {
      final result = await SendTestRunner.send('material/easing_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('elevation_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/elevation_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('end_drawer_button_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/end_drawer_button_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('end_drawer_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/end_drawer_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expand_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expand_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansion_panel_radio_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansion_panel_radio_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_center_offset_x_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_center_offset_x_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_contained_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_contained_offset_y_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_docked_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_docked_offset_y_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_end_offset_x_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_end_offset_x_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_float_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_float_offset_y_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_mini_offset_adjustment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_mini_offset_adjustment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_start_offset_x_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_start_offset_x_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_top_offset_y_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_top_offset_y_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fade_forwards_page_transitions_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fade_forwards_page_transitions_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flexible_space_bar_settings_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/flexible_space_bar_settings_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_label_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_label_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_label_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_label_behavior_test.dart',
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

    test('gregorian_calendar_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/gregorian_calendar_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('grid_tile_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/grid_tile_bar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('grid_tile_test.dart', () async {
      final result = await SendTestRunner.send('material/grid_tile_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('handle_range_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/handle_range_slider_thumb_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('handle_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/handle_thumb_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hour_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/hour_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/icon_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icons_test.dart', () async {
      final result = await SendTestRunner.send('material/icons_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('ink_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/ink_decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ink_sparkle_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/ink_sparkle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('input_date_picker_form_field_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_date_picker_form_field_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('input_decoration_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_decoration_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('input_decorator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_decorator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('interactive_ink_feature_factory_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/interactive_ink_feature_factory_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_tile_control_affinity_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_control_affinity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_tile_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_tile_title_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_title_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_test.dart', () async {
      final result = await SendTestRunner.send('material/magnifier_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_banner_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_banner_closed_reason_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_point_arc_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_point_arc_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_rect_arc_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_rect_arc_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_rect_center_arc_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_rect_center_arc_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_scroll_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_state_outline_input_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_state_outline_input_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_state_underline_input_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_state_underline_input_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_tap_target_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_tap_target_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_accelerator_callback_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_accelerator_callback_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_accelerator_label_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_accelerator_label_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_button_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_button_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mergeable_material_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/mergeable_material_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('modal_bottom_sheet_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/modal_bottom_sheet_route_test.dart',
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

    test('navigation_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_rail_label_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_rail_label_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('no_splash_test.dart', () async {
      final result = await SendTestRunner.send('material/no_splash_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('paddle_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paddle_range_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('paddle_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paddle_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('paginated_data_table_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paginated_data_table_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('persistent_bottom_sheet_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/persistent_bottom_sheet_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_adaptive_icons_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/platform_adaptive_icons_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_button_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_button_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_divider_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_divider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_item_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_item_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_position_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'predictive_back_fullscreen_page_transitions_builder_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'material/predictive_back_fullscreen_page_transitions_builder_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('progress_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/progress_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_chip_test.dart', () async {
      final result = await SendTestRunner.send('material/raw_chip_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('rectangular_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_range_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rectangular_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_range_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rectangular_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refresh_indicator_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_indicator_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refresh_indicator_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_indicator_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refresh_indicator_trigger_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_indicator_trigger_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refresh_progress_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_progress_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_time_of_day_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/restorable_time_of_day_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_range_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_range_slider_thumb_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_range_slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_range_slider_tick_mark_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rounded_rect_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_range_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rounded_rect_range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_range_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rounded_rect_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_geometry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_prelayout_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_prelayout_geometry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('script_category_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/script_category_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scrollbar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('search_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('search_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('segmented_button_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/segmented_button_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_area_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selection_area_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_area_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selection_area_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shape_border_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/shape_border_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('show_value_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/show_value_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('simple_dialog_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/simple_dialog_option_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slider_interaction_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_interaction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snack_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_suggestions_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/spell_check_suggestions_toolbar_layout_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('standard_fab_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/standard_fab_location_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('step_style_test.dart', () async {
      final result = await SendTestRunner.send('material/step_style_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('stretch_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/stretch_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_indicator_animation_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_indicator_animation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_page_selector_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_page_selector_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_page_selector_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_page_selector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_row_ink_well_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/table_row_ink_well_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tappable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tappable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_magnifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('theme_data_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/theme_data_tween_test.dart',
      );
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

    test('tooltip_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('underline_tab_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/underline_tab_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_divider_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/vertical_divider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_input_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/widget_state_input_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PAINTING PACKAGE (32 files)
  // ============================================================
  group('painting/', () {
    test('accumulator_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/accumulator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_bundle_image_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/asset_bundle_image_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_bundle_image_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/asset_bundle_image_provider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

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

    test('border_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_fit_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_fit_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_shape_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_shape_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('painting/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/clip_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/color_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fitted_sizes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/fitted_sizes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_logo_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/flutter_logo_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_repeat_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_repeat_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_size_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_size_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_stream_completer_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_completer_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inline_span_semantics_information_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_semantics_information_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inline_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrix_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_frame_image_stream_completer_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/multi_frame_image_stream_completer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('network_image_load_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/network_image_load_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('one_frame_image_stream_completer_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/one_frame_image_stream_completer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/painting_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_comparison_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/render_comparison_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('resize_image_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_warm_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shader_warm_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_overflow_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_overflow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_width_basis_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_width_basis_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/transform_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/vertical_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('web_html_element_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/web_html_element_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('web_image_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/web_image_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE (3 files)
  // ============================================================
  group('physics/', () {
    test('bounded_friction_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/bounded_friction_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('physics/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('spring_type_test.dart', () async {
      final result = await SendTestRunner.send('physics/spring_type_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

}
