/// Timeout tests — moved out of the main test files because they consistently
/// time out under the d4rt interpreter.
///
/// These tests were extracted from:
///   - generator_interpreter_issues_test.dart
///   - generator_interpreter_retest_test.dart
///   - hardly_relevant_classes_1_test.dart
///   - hardly_relevant_classes_3_test.dart
///   - secondary_classes_test.dart
///
/// They are kept in this dedicated file so the main test runs are not slowed
/// down by 30s+ timeouts. Once the underlying interpreter or generator
/// issues are fixed, these tests can be moved back.
///
/// Total: 62 unique scripts.
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
  // DART_UI PACKAGE TESTS (1 files)
  // ============================================================
  group('dart_ui/', () {
    test('opacity_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/opacity_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // RENDERING PACKAGE TESTS (22 files)
  // ============================================================
  group('rendering/', () {
    test('layer_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: rendering/render_animated_size_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/render_animated_size_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_backdrop_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_backdrop_filter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_block_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_block_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_box_container_defaults_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_box_container_defaults_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_constrained_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_constrained_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_constraints_transform_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_constraints_transform_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_custom_multi_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_multi_child_layout_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_custom_paint_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_paint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_custom_single_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_single_child_layout_box_test.dart',
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

    test('render_physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_physical_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_physical_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_physical_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_pointer_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_pointer_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_proxy_box_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_box_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_proxy_box_with_hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_box_with_hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_repaint_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_repaint_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_rotated_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_rotated_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: rendering/render_sliver_box_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/render_sliver_box_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // SERVICES PACKAGE TESTS (3 files)
  // ============================================================
  group('services/', () {
    test('retest: services/message_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/services/message_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: services/method_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/services/method_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_layout_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_layout_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // ============================================================
  // WIDGETS PACKAGE TESTS (36 files)
  // ============================================================
  group('widgets/', () {
    test('retest: widgets/android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/android_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: widgets/app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/app_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: widgets/back_button_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/back_button_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: widgets/box_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/box_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: widgets/context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/context_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('retest: widgets/default_selection_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/default_selection_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollable_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_orientation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_container_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_container_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_mask_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shader_mask_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shared_app_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shared_app_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shrink_wrapping_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shrink_wrapping_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_child_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_child_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_child_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_ticker_provider_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_ticker_provider_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_grid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_builder_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_constrained_cross_axis_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_constrained_cross_axis_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_cross_axis_expanded_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_expanded_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_cross_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_floating_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_floating_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_layout_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_layout_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_main_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_main_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_offstage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_prototype_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_prototype_extent_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_reorderable_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_reorderable_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_resizing_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_resizing_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_safe_area_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_safe_area_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stateless_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateless_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

}
