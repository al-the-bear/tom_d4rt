/// Auto-split extended bridge tests (file 09).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_09_test.dart';

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
  // RENDERING PACKAGE (96 files)
  // ============================================================
  group('rendering/', () {
    test('alignment_geometry_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/alignment_geometry_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('alignment_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/alignment_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('annotated_region_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotated_region_layer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('annotation_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotation_entry_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('annotation_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotation_result_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('backdrop_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/backdrop_key_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cache_extent_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/cache_extent_style_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('child_layout_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/child_layout_helper_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('rendering/class_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('clear_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clear_selection_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('const_test.dart', () async {
      final result = await SendTestRunner.send('rendering/const_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('container_parent_data_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/container_parent_data_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cross_axis_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/cross_axis_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('decoration_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/decoration_position_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('diagnostics_debug_creator_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/diagnostics_debug_creator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('directionally_extend_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/directionally_extend_selection_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flex_fit_test.dart', () async {
      final result = await SendTestRunner.send('rendering/flex_fit_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('floating_header_snap_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/floating_header_snap_configuration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flow_painting_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/flow_painting_context_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flow_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/flow_parent_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fraction_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/fraction_column_width_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fractional_offset_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/fractional_offset_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('granularly_extend_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/granularly_extend_selection_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('growth_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/growth_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/hit_test_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_filter_config_test.dart', () async {
      // 1944 TODO C.83 (2026-05-31): historical 20260523-1056 §1.6/E24
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. Script runs in ~1.7 s under normal load
      // (httpMs=1731, sourceChars=22641 — 22 KB / 715-line script).
      final result = await SendTestRunner.send(
        'rendering/image_filter_config_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_filter_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/image_filter_context_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/list_wheel_child_manager_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('main_axis_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/main_axis_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('main_axis_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/main_axis_size_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('max_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/max_column_width_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('min_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/min_column_width_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('multi_child_layout_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/multi_child_layout_parent_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('over_scroll_header_stretch_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/over_scroll_header_stretch_configuration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('overflow_box_fit_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/overflow_box_fit_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('performance_overlay_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/performance_overlay_option_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('pipeline_manifold_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/pipeline_manifold_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('placeholder_span_index_semantics_tag_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/placeholder_span_index_semantics_tag_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('platform_view_hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_hit_test_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('platform_view_render_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_render_box_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_abstract_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_abstract_viewport_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_android_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_android_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_animated_opacity_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_opacity_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_animated_size_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_size_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_app_kit_view_test.dart', () async {
      // 1944 TODO C.84 (2026-06-01): historical 20260523-1056 §1.6/E25
      // (= §S/S3 wedge-candidate cluster) cold-start-contention
      // wrapper REMOVED. TEST sibling of C.77 (AST). Script runs in
      // ~3.2 s under isolated retest (httpMs=2978, totalMs=3207,
      // frameworkErrors=0 — 60 KB source / 851 KB bundle). Default
      // 25 s httpBuildTimeout + 30 s dart-test timeout apply.
      final result = await SendTestRunner.send(
        'rendering/render_app_kit_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_clip_r_superellipse_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_darwin_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_darwin_platform_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_decorated_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_decorated_sliver_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_editable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_painter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_inline_children_container_defaults_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_inline_children_container_defaults_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_object_with_layout_callback_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_object_with_layout_callback_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_performance_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_performance_overlay_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_proxy_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_sliver_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_box_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_box_child_manager_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_constrained_cross_axis_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_constrained_cross_axis_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_cross_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_cross_axis_group_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_edge_insets_padding_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_edge_insets_padding_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_fill_remaining_and_overscroll_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_and_overscroll_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_fill_remaining_with_scrollable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_with_scrollable_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_fixed_extent_box_adaptor_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fixed_extent_box_adaptor_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
