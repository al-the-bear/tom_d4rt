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
/// Total: 51 unique scripts.
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
  // RENDERING PACKAGE TESTS (21 files)
  // ============================================================
  group('rendering/', () {
    // C.172 (1944) — FIXED 20260602: removed the §6/E8 cold-start wrapper
    // (50 s httpBuildTimeout + 60 s dart-test Timeout). Isolated retest
    // builds this 62 KB script in ~2.7 s (httpMs~2252, frameworkErrors=0);
    // the wrapper was padding that masked nothing. Defaults now apply
    // (25 s httpBuildTimeout + 30 s dart-test timeout).
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

    test(
      'render_custom_paint_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'rendering/render_custom_paint_test.dart',
          // 20260523-1056 baseline §S/E1/E38: under parallel-driver
          // contention the /build for this 1521-line, 60 KB script can
          // exceed the default 25 s HTTP cap on the first request after
          // the test app cold-start. Serial isolated re-runs complete in
          // ~2 s. 50 s leaves 10 s of headroom under the 60 s
          // dart-test wrapper.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'render_custom_single_child_layout_box_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'rendering/render_custom_single_child_layout_box_test.dart',
          // 20260524-2003 baseline §6/E7/E14/E17 + T4/T15/T18: same
          // cold-start contention pattern as the sibling
          // render_custom_paint_test (§S/E1) — /build for this
          // render-heavy script can exceed the default 25 s HTTP cap on
          // the first request after the test app cold-start. Bump to
          // 50 s with 10 s headroom under the 60 s dart-test wrapper.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

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

    // render_pointer_test.dart: re-enabled in secondary_classes_test.dart
    // (verified passing in 1.6s on 2026-04-26 after clusters 23/24/26 fixes).

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
  // WIDGETS PACKAGE TESTS (27 files)
  // ============================================================
  group('widgets/', () {
    test('retest: widgets/android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/android_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'retest: widgets/app_kit_view_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/app_kit_view_test.dart',
          // 20260523-1056 baseline §1.10/E39 (= §S/S5 — listed in
          // the wedge-candidate cluster because it appeared in both
          // ast and flutter_test runs in timeout_tests_test).
          // Serial isolated re-run produces 2.2 s (ast) / 2.3 s
          // (flutter_test) with frameworkErrors=0. The cross-project
          // failure was cold-start contention, not a real wedge.
          // Same family as E1/E12/E25/E36: 50 s leaves 10 s of
          // headroom under the 60 s dart-test wrapper.
          //
          // NOTE: The retest occurrence of this script in
          // generator_interpreter_retest_test.dart is a DIFFERENT
          // failure (F5 / Cluster B — Set<Factory<…>> coercion), not
          // this contention issue. That one was fixed via entry #15.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'retest: widgets/back_button_listener_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/back_button_listener_test.dart',
          // 20260524 §6 todo #11 / F6: 78 KB / 1.07 MB AST bundle.
          // Cold-start build hits the default 25 s caller cap before
          // /build returns. Bump to 50 s so the build completes.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'retest: widgets/box_scroll_view_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/box_scroll_view_test.dart',
          // 20260524-2003 baseline §6/E20 (= todo #4): cold-start
          // contention in the timeout retest cluster. Standard
          // caller-side 25 s → 50 s cap with 60 s dart-test wrapper.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

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

    test(
      'selectable_region_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/selectable_region_test.dart',
          // 20260523-1056 baseline §1.3/E8 (secondary instance): same
          // cold-start contention as the secondary_classes_test entry.
          // 1456-line / 54 KB script; ~1.5 s typical. 50 s leaves
          // 10 s of headroom under the 60 s dart-test wrapper.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

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

    test(
      'sliver_animated_list_state_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/sliver_animated_list_state_test.dart',
          // 20260523-1056 baseline §1.10/E40: Transport failure 25s
          // — cold-start contention. This 858-line / 31 KB script
          // (412 KB bundle) builds in ~1.4 s in both variants. Same
          // family as the §1.3–§1.8 E-series: 50 s leaves 10 s of
          // headroom under the 60 s dart-test wrapper.
          //
          // NOTE: The script also appears in
          // hardly_relevant_classes_5_test.dart and
          // generator_interpreter_issues_test.dart, but those
          // suites did NOT surface this script as errored in the
          // 20260523-1056 baseline — only the timeout_tests
          // occurrence was caught by the contention. The other two
          // entries are left at the default 25 s cap to keep the
          // patch surface minimal.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

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

    test('stateless_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateless_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

}
