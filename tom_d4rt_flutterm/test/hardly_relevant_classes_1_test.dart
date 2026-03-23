/// Tests for hardly relevant Flutter bridge classes (part 1 of 5).
///
/// animation, cupertino, dart_ui, foundation, gestures packages
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Run tests: flutter test test/hardly_relevant_classes_1_test.dart
///
/// The test app is started automatically in setUpAll and stopped in tearDownAll
/// when needed.
///
/// Total: 204 test entries
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

}
