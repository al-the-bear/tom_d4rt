/// Auto-split base bridge tests (file 12).
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

  // --- RENDERING INDIVIDUAL SCRIPTS (107 files) ---
  group('rendering/ individual', () {
    test('box_hit_test_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/box_hit_test_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_hit_test_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/box_hit_test_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_path_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clip_path_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_superellipse_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clip_r_superellipse_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_filter_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/color_filter_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('constraints_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/constraints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_box_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/container_box_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_render_object_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/container_render_object_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('custom_painter_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/custom_painter_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('debug_overflow_indicator_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/debug_overflow_indicator_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('follower_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/follower_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_parent_data_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/keep_alive_parent_data_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layer_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layer_link_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_link_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('leader_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/leader_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_body_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/list_body_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/list_wheel_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/mouse_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('performance_overlay_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/performance_overlay_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('picture_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/picture_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('relayout_when_system_fonts_change_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/relayout_when_system_fonts_change_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_absorb_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_absorb_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_aligning_shifted_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_aligning_shifted_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_annotated_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_annotated_region_test.dart',
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
      // 1944 TODO C.36 (2026-05-31): historical 20260523-1056 §S/E1
      // parallel-driver-contention wrapper REMOVED. Script runs in
      // ~2.2 s under normal load (httpMs=2179, sourceChars=60302).
      final result = await SendTestRunner.send(
        'rendering/render_custom_paint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_custom_single_child_layout_box_test.dart', () async {
      // 1944 TODO C.37 (2026-05-31): historical 20260524-2003 §6/E14
      // + T15 sibling-cold-start-contention wrapper REMOVED. Script
      // runs in ~2.3 s under normal load (httpMs=2324,
      // sourceChars=71483 — 71 KB / one of the larger scripts).
      final result = await SendTestRunner.send(
        'rendering/render_custom_single_child_layout_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_editable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_error_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_error_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_exclude_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_exclude_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_follower_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_follower_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_fractional_translation_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_fractional_translation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_fractionally_sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_fractionally_sized_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ignore_baseline_test.dart', () async {
      // 1944 TODO C.38 (2026-05-31): historical 20260524-2003 §6/E15
      // cold-start-contention wrapper REMOVED. Script runs in ~1.5 s
      // under normal load (httpMs=1516, sourceChars=48697).
      final result = await SendTestRunner.send(
        'rendering/render_ignore_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_indexed_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_indexed_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_indexed_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_indexed_stack_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_leader_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_leader_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_list_wheel_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_list_wheel_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_merge_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_merge_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_meta_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_meta_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_mouse_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_mouse_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_with_child_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_object_with_child_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_offstage_test.dart',
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

    test('render_proxy_box_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_box_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_proxy_box_with_hit_test_behavior_test.dart', () async {
      // 1944 TODO C.39 (2026-05-31): historical 20260524-2003 §6/T16
      // (todo #8) cold-start-transport-failure wrapper REMOVED.
      // Script runs in ~2.2 s under normal load (httpMs=2232,
      // sourceChars=65726 — 66 KB script).
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
  });
}
