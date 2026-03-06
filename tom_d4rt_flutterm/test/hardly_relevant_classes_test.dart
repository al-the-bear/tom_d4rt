/// Tests for hardly relevant Flutter bridge classes.
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Run tests: flutter test test/hardly_relevant_classes_test.dart
///
/// The test app is started automatically in setUpAll and stopped in tearDownAll
/// when needed.
///
/// Tests are organized by Flutter package and test the bridged classes
/// listed in testplan_hardly_relevant.md.
///
/// Total: 1062 test entries (1 class per file, hardly relevant priority)
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
  // ANIMATION PACKAGE (31 files)
  // ============================================================
  group('animation/', () {
    test('animation_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_eager_listener_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_eager_listener_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_lazy_listener_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_lazy_listener_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_local_listeners_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_local_listeners_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_local_status_listeners_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_local_status_listeners_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('catmull_rom_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/catmull_rom_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('catmull_rom_spline_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/catmull_rom_spline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('animation/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/color_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('constant_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/constant_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cubic_test.dart', () async {
      final result = await SendTestRunner.send('animation/cubic_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('curve2_d_sample_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/curve2_d_sample_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('curve2_d_test.dart', () async {
      final result = await SendTestRunner.send('animation/curve2_d_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('curve_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/curve_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('curves_test.dart', () async {
      final result = await SendTestRunner.send('animation/curves_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('elastic_in_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/elastic_in_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('elastic_in_out_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/elastic_in_out_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('elastic_out_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/elastic_out_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flipped_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/flipped_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('int_tween_test.dart', () async {
      final result = await SendTestRunner.send('animation/int_tween_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('interval_test.dart', () async {
      final result = await SendTestRunner.send('animation/interval_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('parametric_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/parametric_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rect_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/rect_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reverse_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/reverse_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('saw_tooth_test.dart', () async {
      final result = await SendTestRunner.send('animation/saw_tooth_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('size_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/size_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('split_test.dart', () async {
      final result = await SendTestRunner.send('animation/split_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('step_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/step_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('three_point_cubic_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/three_point_cubic_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('threshold_test.dart', () async {
      final result = await SendTestRunner.send('animation/threshold_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // CUPERTINO PACKAGE (15 files)
  // ============================================================
  group('cupertino/', () {
    test('class_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_button_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_button_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_desktop_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_desktop_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_expansion_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_expansion_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_focus_halo_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_focus_halo_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_linear_activity_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_linear_activity_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_list_section_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_list_section_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_list_tile_chevron_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_list_tile_chevron_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_thumb_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_thumb_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansion_tile_transition_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/expansion_tile_transition_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_cupertino_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/inherited_cupertino_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_bar_bottom_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/navigation_bar_bottom_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_visibility_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/overlay_visibility_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_cupertino_tab_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/restorable_cupertino_tab_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // DART:UI PACKAGE (76 files)
  // ============================================================
  group('dart_ui/', () {
    test('app_exit_response_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_exit_response_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_exit_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_exit_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_lifecycle_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_lifecycle_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('backdrop_filter_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/backdrop_filter_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('blend_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/blend_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('blur_style_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/blur_style_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_height_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/box_height_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_width_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/box_width_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('callback_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/callback_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('channel_buffers_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/channel_buffers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checked_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/checked_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_op_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/clip_op_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_path_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_path_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_rect_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_r_rect_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_superellipse_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_r_superellipse_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_rect_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_rect_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/clip_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_filter_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/color_filter_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_space_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/color_space_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_performance_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_performance_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_plugin_registrant_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_plugin_registrant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_feature_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/display_feature_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_feature_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/display_feature_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('filter_quality_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/filter_quality_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('font_style_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/font_style_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('fragment_program_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/fragment_program_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fragment_shader_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/fragment_shader_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('frame_phase_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/frame_phase_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_byte_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/image_byte_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filter_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/image_filter_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_sampler_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/image_sampler_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('isolate_name_server_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/isolate_name_server_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_device_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/key_event_device_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/key_event_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('offset_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/offset_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('opacity_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/opacity_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/painting_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('path_fill_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_fill_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('path_operation_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_operation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('picture_rasterization_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/picture_rasterization_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pixel_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pixel_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/placeholder_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('plugin_utilities_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/plugin_utilities_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('point_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/point_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_change_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_change_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_device_kind_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_device_kind_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_kind_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_signal_kind_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_isolate_token_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/root_isolate_token_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_input_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_input_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_role_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_role_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_validation_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_validation_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_mask_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/shader_mask_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('singleton_flutter_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/singleton_flutter_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stroke_cap_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/stroke_cap_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('stroke_join_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/stroke_join_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_color_palette_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/system_color_palette_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('target_pixel_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/target_pixel_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_affinity_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_affinity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_align_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/text_align_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_decoration_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_decoration_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_leading_distribution_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_leading_distribution_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tile_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/tile_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/transform_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tristate_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/tristate_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_float_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_float_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec2_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec2_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec3_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec3_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec4_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec4_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertex_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/vertex_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_focus_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_focus_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_focus_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_focus_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE (37 files)
  // ============================================================
  group('foundation/', () {
    test('abstract_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/abstract_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('caching_iterable_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/caching_iterable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('category_test.dart', () async {
      final result = await SendTestRunner.send('foundation/category_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('foundation/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostic_level_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostic_level_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_tree_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_tree_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_tree_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_block_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_serialization_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_serialization_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_stack_trace_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_stack_trace_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_tree_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_tree_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('documentation_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/documentation_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('double_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/double_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('enum_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/enum_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('error_spacer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/error_spacer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('factory_test.dart', () async {
      final result = await SendTestRunner.send('foundation/factory_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('flag_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flag_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flags_summary_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flags_summary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_memory_allocations_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flutter_memory_allocations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/foundation_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('int_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/int_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('iterable_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/iterable_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('message_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/message_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_created_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_created_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_disposed_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_disposed_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_flag_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_flag_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('percent_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/percent_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('string_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/string_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('summary_test.dart', () async {
      final result = await SendTestRunner.send('foundation/summary_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('target_platform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/target_platform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_tree_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/text_tree_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_tree_renderer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/text_tree_renderer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // GESTURES PACKAGE (45 files)
  // ============================================================
  group('gestures/', () {
    test('base_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/base_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('gestures/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_start_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_start_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_start_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_start_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'flutter_error_details_for_pointer_event_dispatcher_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'gestures/flutter_error_details_for_pointer_event_dispatcher_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('gesture_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_disposition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_recognizer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_test_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/hit_test_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_testable_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/hit_testable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_scroll_view_fling_velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('least_squares_solver_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/least_squares_solver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mac_o_s_scroll_view_fling_velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/mac_o_s_scroll_view_fling_velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multitouch_drag_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multitouch_drag_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('offset_pair_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/offset_pair_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('one_sequence_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/one_sequence_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_added_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_added_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_cancel_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_cancel_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_enter_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_enter_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_event_converter_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_converter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_event_resampler_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_resampler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_exit_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_exit_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_hover_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_hover_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_move_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_move_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_end_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_end_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_start_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_start_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_update_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_update_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_removed_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_removed_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scale_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scale_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scroll_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scroll_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scroll_inertia_cancel_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scroll_inertia_cancel_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_signal_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_resolver_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_signal_resolver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('polynomial_fit_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/polynomial_fit_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('primary_pointer_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/primary_pointer_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sampling_clock_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/sampling_clock_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_move_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_move_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('velocity_estimate_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_estimate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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

  // ============================================================
  // RENDERING PACKAGE (96 files)
  // ============================================================
  group('rendering/', () {
    test('alignment_geometry_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/alignment_geometry_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('alignment_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/alignment_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('annotated_region_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotated_region_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('annotation_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotation_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('annotation_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotation_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('backdrop_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/backdrop_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cache_extent_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/cache_extent_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('child_layout_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/child_layout_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('rendering/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clear_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clear_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('const_test.dart', () async {
      final result = await SendTestRunner.send('rendering/const_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_parent_data_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/container_parent_data_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cross_axis_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/cross_axis_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('decoration_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/decoration_position_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_debug_creator_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/diagnostics_debug_creator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directionally_extend_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/directionally_extend_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flex_fit_test.dart', () async {
      final result = await SendTestRunner.send('rendering/flex_fit_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_header_snap_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/floating_header_snap_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flow_painting_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/flow_painting_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flow_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/flow_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fraction_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/fraction_column_width_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fractional_offset_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/fractional_offset_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('granularly_extend_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/granularly_extend_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('growth_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/growth_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filter_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/image_filter_config_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filter_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/image_filter_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/list_wheel_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('main_axis_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/main_axis_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('main_axis_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/main_axis_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('max_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/max_column_width_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('min_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/min_column_width_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_child_layout_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/multi_child_layout_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('over_scroll_header_stretch_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/over_scroll_header_stretch_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_box_fit_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/overflow_box_fit_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('performance_overlay_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/performance_overlay_option_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('persistent_header_show_on_screen_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/persistent_header_show_on_screen_configuration_test.dart',
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

    test('platform_view_hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_hit_test_behavior_test.dart',
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

    test('render_app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_app_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_clip_r_superellipse_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_darwin_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_darwin_platform_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_decorated_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_decorated_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_editable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_inline_children_container_defaults_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_inline_children_container_defaults_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_with_layout_callback_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_object_with_layout_callback_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_performance_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_performance_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_proxy_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_box_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_box_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_constrained_cross_axis_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_constrained_cross_axis_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_cross_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_cross_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_edge_insets_padding_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_edge_insets_padding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_remaining_and_overscroll_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_and_overscroll_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_remaining_with_scrollable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_with_scrollable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fixed_extent_box_adaptor_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fixed_extent_box_adaptor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_floating_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_floating_pinned_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_main_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_main_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_semantics_annotations_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_semantics_annotations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_single_box_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_single_box_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ui_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/rendering_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('revealed_offset_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/revealed_offset_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/scroll_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_all_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_all_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_paragraph_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_paragraph_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_word_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_word_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selected_content_range_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selected_content_range_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_edge_update_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_edge_update_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_event_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_extend_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_extend_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_handler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_registrant_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_registrant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_logical_container_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_logical_container_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_paint_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_paint_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_physical_container_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_physical_container_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stack_fit_test.dart', () async {
      final result = await SendTestRunner.send('rendering/stack_fit_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_cell_vertical_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_cell_vertical_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_granularity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_granularity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_handle_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_selection_handle_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/texture_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_indentation_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/tree_sliver_indentation_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_node_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/tree_sliver_node_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_caret_movement_run_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/vertical_caret_movement_run_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('wrap_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('wrap_cross_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_cross_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE (4 files)
  // ============================================================
  group('scheduler/', () {
    test('class_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('priority_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/priority_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler_phase_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_phase_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SEMANTICS PACKAGE (10 files)
  // ============================================================
  group('semantics/', () {
    test('accessibility_focus_block_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/accessibility_focus_block_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('announce_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/announce_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('assertiveness_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/assertiveness_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('attributed_string_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/attributed_string_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('semantics/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('debug_semantics_dump_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/debug_semantics_dump_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/focus_semantic_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('long_press_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/long_press_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tap_semantic_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tooltip_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SERVICES PACKAGE (90 files)
  // ============================================================
  group('services/', () {
    test('android_motion_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_motion_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_pointer_coords_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_pointer_coords_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_pointer_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_pointer_properties_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('application_switcher_description_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/application_switcher_description_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_hints_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_hints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_scope_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_scope_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('background_isolate_binary_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/background_isolate_binary_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('binary_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/binary_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('services/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('content_sensitivity_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/content_sensitivity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('deferred_component_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/deferred_component_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delta_text_input_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/delta_text_input_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/device_orientation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_cursor_drag_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/floating_cursor_drag_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('g_l_f_w_key_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/g_l_f_w_key_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gtk_key_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/gtk_key_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_custom_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_custom_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_live_text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_look_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_paste_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_paste_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_search_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_search_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_select_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_select_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_share_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_data_transit_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_data_transit_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_event_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_test.dart', () async {
      final result = await SendTestRunner.send('services/key_event_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_helper_test.dart', () async {
      final result = await SendTestRunner.send('services/key_helper_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_message_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_message_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_repeat_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_repeat_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_lock_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_lock_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_side_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_side_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('max_length_enforcement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/max_length_enforcement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

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

    test('missing_plugin_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/missing_plugin_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('modifier_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/modifier_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_cursor_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_cursor_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_cursor_session_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_cursor_session_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_tracker_annotation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_tracker_annotation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_floating_cursor_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_floating_cursor_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_android_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_android_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_fuchsia_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_fuchsia_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_ios_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_ios_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_mac_os_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_mac_os_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_windows_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_windows_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_keyboard_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_keyboard_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_bucket_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_bucket_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scribble_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/scribble_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_changed_cause_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_changed_cause_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_rect_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_rect_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sensitive_content_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/sensitive_content_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/services_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_dashes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_dashes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_quotes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_quotes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('swipe_edge_test.dart', () async {
      final result = await SendTestRunner.send('services/swipe_edge_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_context_menu_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_context_menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_sound_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_sound_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_capitalization_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_capitalization_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_deletion_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_deletion_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_insertion_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_insertion_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_non_text_update_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_non_text_update_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_replacement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_replacement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_connection_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_connection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_control_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_control_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_test.dart', () async {
      final result = await SendTestRunner.send('services/text_input_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_selection_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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

    test('decoration_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decoration_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_platform_menu_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_platform_menu_delegate_test.dart',
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

    test('default_transition_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_transition_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delete_character_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_character_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delete_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_to_line_break_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delete_to_next_word_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/delete_to_next_word_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/desktop_text_selection_toolbar_layout_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dev_tools_deep_link_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dev_tools_deep_link_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_orientation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/device_orientation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagonal_drag_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/diagonal_drag_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_controller_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_controller_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dialog_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_caret_movement_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_caret_movement_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_focus_traversal_policy_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_focus_traversal_policy_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directional_text_editing_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directional_text_editing_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('disable_widget_inspector_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/disable_widget_inspector_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_menu_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_menu_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismiss_update_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dismiss_update_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dismissible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/dismissible_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('disposable_build_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/disposable_build_context_test.dart',
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

    test('do_nothing_and_stop_propagation_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_and_stop_propagation_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('do_nothing_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/do_nothing_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_boundary_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_boundary_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_target_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/drag_target_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_scrollable_actuator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_actuator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_scrollable_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_scrollable_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_scrollable_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('driven_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/driven_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_dragging_auto_scroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_dragging_auto_scroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_insets_geometry_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_insets_geometry_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_insets_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/edge_insets_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('editable_text_tap_outside_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_tap_outside_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('editable_text_tap_up_outside_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_tap_up_outside_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('empty_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/empty_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('enable_widget_inspector_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/enable_widget_inspector_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('exclude_focus_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/exclude_focus_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('exclude_focus_traversal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/exclude_focus_traversal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expand_selection_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expand_selection_to_document_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expand_selection_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expand_selection_to_line_break_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansible_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/expansible_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/expansible_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_by_character_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_by_character_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_by_page_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_by_page_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_document_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('extend_selection_to_line_break_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_line_break_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'extend_selection_to_next_paragraph_boundary_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('extend_selection_to_next_word_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_next_word_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_line_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_page_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('feedback_test.dart', () async {
      final result = await SendTestRunner.send('widgets/feedback_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_scroll_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_scroll_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flex_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flex_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_header_snap_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/floating_header_snap_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_attachment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_attachment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_highlight_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_highlight_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_order_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focus_order_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_scope_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_scope_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_traversal_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_traversal_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fractional_translation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fractional_translation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_factory_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_factory_with_handlers_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_with_handlers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('global_object_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/global_object_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_flight_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_flight_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hold_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hold_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_custom_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_custom_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_live_text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_look_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_paste_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_paste_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_search_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_search_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_select_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_select_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_share_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_data_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_data_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_data_test.dart', () async {
      final result = await SendTestRunner.send('widgets/icon_data_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('idle_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/idle_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ignore_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ignore_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_icon_test.dart', () async {
      final result = await SendTestRunner.send('widgets/image_icon_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('img_element_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/img_element_platform_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('indexed_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_model_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_model_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_button_variant_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_button_variant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_reference_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_reference_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_serialization_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_serialization_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/key_event_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_set_test.dart', () async {
      final result = await SendTestRunner.send('widgets/key_set_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keyboard_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('labeled_global_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/labeled_global_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layout_id_test.dart', () async {
      final result = await SendTestRunner.send('widgets/layout_id_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('lexical_focus_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/lexical_focus_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_input_status_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_input_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('local_history_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/local_history_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('localizations_resolver_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/localizations_resolver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('lock_state_test.dart', () async {
      final result = await SendTestRunner.send('widgets/lock_state_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('logical_key_set_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/logical_key_set_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('lookup_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/lookup_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix4_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/matrix4_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/matrix_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_serializable_shortcut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/menu_serializable_shortcut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('meta_data_test.dart', () async {
      final result = await SendTestRunner.send('widgets/meta_data_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('modal_barrier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/modal_barrier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_selectable_selection_container_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_selectable_selection_container_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigator_pop_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigator_pop_handler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('nested_scroll_view_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nested_scroll_view_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('nested_scroll_view_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nested_scroll_view_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('next_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/next_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('next_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/next_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notifiable_element_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notifiable_element_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('numeric_focus_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/numeric_focus_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_key_test.dart', () async {
      final result = await SendTestRunner.send('widgets/object_key_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('options_view_open_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/options_view_open_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ordered_traversal_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ordered_traversal_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('orientation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/orientation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('orientation_test.dart', () async {
      final result = await SendTestRunner.send('widgets/orientation_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_bar_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_bar_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_child_layout_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_child_layout_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_child_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_child_location_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_portal_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_portal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overscroll_indicator_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overscroll_indicator_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overscroll_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overscroll_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_route_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_route_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_test.dart', () async {
      final result = await SendTestRunner.send('widgets/page_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pan_axis_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pan_axis_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('paste_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/paste_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_provided_menu_item_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_provided_menu_item_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_route_information_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_route_information_provider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_selectable_region_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_selectable_region_context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_creation_params_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_view_creation_params_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pop_entry_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pop_entry_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pop_navigator_router_delegate_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pop_navigator_router_delegate_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/popup_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/popup_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/popup_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('predictive_back_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/predictive_back_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('preferred_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferred_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('preferred_size_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferred_size_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('previous_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/previous_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('previous_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/previous_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('prioritized_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/prioritized_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('prioritized_intents_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/prioritized_intents_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/radio_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_group_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/radio_group_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_autocomplete_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_autocomplete_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_dialog_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_dialog_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_gesture_detector_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_gesture_detector_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_gesture_detector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_gesture_detector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_image_test.dart', () async {
      final result = await SendTestRunner.send('widgets/raw_image_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_keyboard_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_menu_anchor_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_menu_anchor_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_menu_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_menu_anchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_menu_overlay_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_menu_overlay_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_radio_test.dart', () async {
      final result = await SendTestRunner.send('widgets/raw_radio_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_scrollbar_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_scrollbar_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_tooltip_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_tooltip_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_tooltip_test.dart', () async {
      final result = await SendTestRunner.send('widgets/raw_tooltip_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_web_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_web_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reading_order_traversal_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reading_order_traversal_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('redo_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/redo_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_linux_test.dart',
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

    test('regular_window_controller_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('relative_positioned_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/relative_positioned_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('relative_rect_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/relative_rect_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_abstract_layout_builder_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_abstract_layout_builder_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_nested_scroll_view_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_nested_scroll_view_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_to_widget_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_to_widget_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_to_widget_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_to_widget_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_overlap_absorber_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_sliver_overlap_absorber_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_overlap_injector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_sliver_overlap_injector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tap_region_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tap_region_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tap_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tap_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tree_root_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tree_root_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_two_dimensional_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_two_dimensional_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_web_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_web_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_delayed_drag_start_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_delayed_drag_start_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_drag_start_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_drag_start_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('repeat_mode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/repeat_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('repeating_animation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/repeating_animation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('replace_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/replace_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('request_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/request_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('request_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/request_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_bool_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_bool_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_change_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_change_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_date_time_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_date_time_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_double_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_double_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_enum_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_enum_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_int_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_int_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_listenable_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_listenable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_num_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_num_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_num_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_num_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_route_future_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_route_future_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_string_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_string_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_back_button_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_back_button_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_element_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_element_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_aware_test.dart', () async {
      final result = await SendTestRunner.send('widgets/route_aware_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_information_reporting_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_information_reporting_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_information_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_information_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_observer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_pop_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_pop_disposition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_transition_record_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_transition_record_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('router_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/router_config_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_activity_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_activity_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_aware_image_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_aware_image_provider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_deceleration_rate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_deceleration_rate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_drag_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_drag_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_end_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_end_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_hold_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_hold_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_increment_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_increment_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_increment_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_increment_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_metrics_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_metrics_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_notification_observer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_notification_observer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_notification_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_notification_observer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_position_alignment_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_alignment_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_position_with_single_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_with_single_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_start_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_start_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_to_document_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_update_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_update_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_view_keyboard_dismiss_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_view_keyboard_dismiss_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_view_test.dart', () async {
      final result = await SendTestRunner.send('widgets/scroll_view_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollable_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollable_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_orientation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/select_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_all_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/select_all_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/select_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_selection_status_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_selection_status_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_selection_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_container_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_container_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_listener_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_listener_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_registrar_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_registrar_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_debugger_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/semantics_debugger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_gesture_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/semantics_gesture_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sensitive_content_host_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sensitive_content_host_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sensitive_content_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sensitive_content_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_activator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_map_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_map_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_registrar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_registrar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_registry_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_registry_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_serialization_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_serialization_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_activator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('size_changed_layout_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/size_changed_layout_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('size_changed_layout_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/size_changed_layout_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sized_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_grid_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_builder_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_ensure_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_ensure_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_fade_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_fade_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_multi_box_adaptor_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_multi_box_adaptor_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_multi_box_adaptor_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_multi_box_adaptor_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_overlap_absorber_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_absorber_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_overlap_absorber_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_absorber_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_overlap_injector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_injector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_persistent_header_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_persistent_header_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_reorderable_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_reorderable_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_with_keep_alive_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_with_keep_alive_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_container_render_object_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_container_render_object_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_multi_child_render_object_widget_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_multi_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('standard_component_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/standard_component_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('static_selection_container_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/static_selection_container_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('status_transition_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/status_transition_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stream_builder_base_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stream_builder_base_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stretch_effect_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stretch_effect_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/system_context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_text_scaler_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/system_text_scaler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_region_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tap_region_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'text_selection_gesture_detector_builder_delegate_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/text_selection_gesture_detector_builder_delegate_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('text_selection_gesture_detector_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_gesture_detector_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_toolbar_layout_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_style_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_style_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_test.dart', () async {
      final result = await SendTestRunner.send('widgets/texture_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('ticker_mode_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ticker_mode_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggleable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toggleable_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggleable_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toggleable_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toolbar_items_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_items_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toolbar_options_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_options_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_position_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_position_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tracking_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tracking_scroll_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transformation_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transformation_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transition_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transition_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transition_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transition_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transpose_characters_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transpose_characters_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('traversal_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('traversal_edge_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_edge_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_test.dart', () async {
      final result = await SendTestRunner.send('widgets/tree_sliver_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_builder_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_scrollable_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_scrollable_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_scrollable_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_scrollable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_viewport_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_viewport_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_history_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_history_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unfocus_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unfocus_disposition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unique_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unique_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unmanaged_restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unmanaged_restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('update_selection_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/update_selection_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('user_scroll_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/user_scroll_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('viewport_element_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/viewport_element_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('viewport_notification_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/viewport_notification_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('void_callback_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/void_callback_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('void_callback_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/void_callback_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('weak_map_test.dart', () async {
      final result = await SendTestRunner.send('widgets/weak_map_test.dart');
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

    test('widget_inspector_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_order_traversal_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_order_traversal_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_border_side_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_border_side_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_color_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_color_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_mapper_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_mapper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_mouse_cursor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_mouse_cursor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_outlined_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_outlined_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_property_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_property_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_text_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_text_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_states_constraint_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_states_constraint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_to_render_box_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_to_render_box_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_positioner_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_anchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_positioner_constraint_adjustment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_constraint_adjustment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_positioner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
