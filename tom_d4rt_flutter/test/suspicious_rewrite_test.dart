/// Source-based mirror of `suspicious_rewrite_test.dart`
/// from `tom_d4rt_flutter_ast/test/`. Runs the same 116
/// suspicious scripts through `SourceFlutterD4rt` on port
/// 4248 instead of the pre-compiled AstBundle path.
///
/// Scripts live in:
///   ../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/
///
/// IMPORTANT: never run this file concurrently with other
/// test files that use the same port — see
/// `dart_test.yaml` (concurrency: 1).
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'suspicious_rewrite_test.dart';

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
  // CUPERTINO (7 files)
  // ============================================================
  group('cupertino/', () {
    test('cupertino_desktop_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_desktop_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_focus_halo_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_focus_halo_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('form_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/form_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_cupertino_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/inherited_cupertino_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_visibility_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/overlay_visibility_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('textfield_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/textfield_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // DART_UI (1 file)
  // ============================================================
  group('dart_ui/', () {
    test('system_color_palette_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/system_color_palette_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_float_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_float_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // FOUNDATION (1 file)
  // ============================================================
  group('foundation/', () {
    test('target_platform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/target_platform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // GESTURES (2 files)
  // ============================================================
  group('gestures/', () {
    test('pointer_exit_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_exit_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // MATERIAL (31 files)
  // ============================================================
  group('material/', () {
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

    test('collapse_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/collapse_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drawer_controller_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/drawer_controller_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_menu_close_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_close_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('end_drawer_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/end_drawer_button_test.dart',
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

    test('hour_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/hour_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_tile_title_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/list_tile_title_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_banner_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_banner_closed_reason_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_accelerator_callback_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_accelerator_callback_binding_test.dart',
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

    test('navigation_rail_label_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_rail_label_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('paginated_data_table_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/paginated_data_table_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_menu_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_menu_position_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('progress_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/progress_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refresh_progress_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refresh_progress_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tabs_test.dart', () async {
      final result = await SendTestRunner.send('material/tabs_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('themadata_test.dart', () async {
      final result = await SendTestRunner.send('material/themadata_test.dart');
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

  });

  // ============================================================
  // PAINTING (2 files)
  // ============================================================
  group('painting/', () {
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

    test('matrix_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrix_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_providers_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_providers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shape_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shape_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // PROXIES (5 files)
  // ============================================================
  group('proxies/', () {
    test('customclipper_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/customclipper_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('custompaint_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/custompaint_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flowdelegate_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/flowdelegate_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multichildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/multichildlayout_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('singlechildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/singlechildlayout_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // RENDERING (17 files)
  // ============================================================
  group('rendering/', () {
    test('const_test.dart', () async {
      final result = await SendTestRunner.send('rendering/const_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_header_snap_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/floating_header_snap_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('over_scroll_header_stretch_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/over_scroll_header_stretch_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pipeline_manifold_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/pipeline_manifold_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_span_index_semantics_tag_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/placeholder_span_index_semantics_tag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_render_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_render_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_abstract_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_abstract_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_android_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_android_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_opacity_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_opacity_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_size_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_size_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_clip_r_superellipse_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_editable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_box_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_box_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_floating_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_floating_pinned_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ui_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_paint_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_paint_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // REPRO_FA5 (2 files)
  // ============================================================
  group('repro_fa5/', () {
    test('canary_must_fail.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa5/canary_must_fail.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_widget_exact_type.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa5/inherited_widget_exact_type.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // REPRO_FA6 (1 file)
  // ============================================================
  group('repro_fa6/', () {
    test('canary_must_fail.dart', () async {
      final result = await SendTestRunner.send(
        'repro_fa6/canary_must_fail.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // SEMANTICS (1 file)
  // ============================================================
  group('semantics/', () {
    test('semantics_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // SERVICES (5 files)
  // ============================================================
  group('services/', () {
    test('message_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/message_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('method_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/method_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_quotes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_quotes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/spell_check_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // WIDGETS (43 files)
  // ============================================================
  group('widgets/', () {
    test('action_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/action_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('align_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/align_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_positioned_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_positioned_directional_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/app_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_highlighted_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autocomplete_highlighted_option_test.dart',
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

    test('border_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/border_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/box_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clip_r_superellipse_test.dart',
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

    test('dismiss_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_intent_test.dart',
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

    test('drag_target_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_target_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('img_element_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/img_element_platform_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigatorstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigatorstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_transition_record_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_transition_record_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_increment_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_increment_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_selection_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unmanaged_restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unmanaged_restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('web_browser_detection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/web_browser_detection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_inspector_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sizing_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sizing_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedbuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedbuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });
}
