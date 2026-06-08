/// Auto-split base bridge tests (file 15).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'dart:io' show Platform;

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

  // --- WIDGETS INDIVIDUAL SCRIPTS (172 files) ---
  group('widgets/ individual', () {
    test('always_scrollable_scroll_physics_test.dart', () async {
      // 1944 TODO C.25 (2026-05-31): historical 20260523-1056 §1.3/E3
      // parallel-driver-contention wrapper REMOVED. Script runs in
      // ~1.5 s under normal load (httpMs=1457). Note: this same
      // script is the canonical §U25 source-direct cold-start
      // reproducer documented in `interpreter_unfixable.md` §U25 —
      // but the AST-bundle path completes in ~1.5 s; the §U25
      // pathology is specific to the source-direct (TEST) variant
      // and does NOT affect this AST entry.
      final result = await SendTestRunner.send(
        'widgets/always_scrollable_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'android_view_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/android_view_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
      skip: !Platform.isAndroid ? 'AndroidView only renders on Android' : null,
    );

    test('animated_align_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_align_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_cross_fade_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_cross_fade_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_fractionally_sized_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_fractionally_sized_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_modal_barrier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_modal_barrier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_physical_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_rotation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_rotation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_scale_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_scale_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_slide_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_slide_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_switcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_switcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('backdrop_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backdrop_filter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bouncing_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/bouncing_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('build_owner_test.dart', () async {
      final result = await SendTestRunner.send('widgets/build_owner_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('build_scope_test.dart', () async {
      final result = await SendTestRunner.send('widgets/build_scope_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('checked_mode_banner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/checked_mode_banner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clamping_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clamping_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/color_filtered_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('component_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/component_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('composited_transform_follower_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_follower_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('composited_transform_target_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_target_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('content_insertion_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/content_insertion_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('context_menu_button_item_test.dart', () async {
      // 1944 TODO C.26 (2026-05-31): historical 20260523-1056 §1.3/E4
      // parallel-driver-contention wrapper REMOVED. Script runs in
      // ~1.4 s under normal load (httpMs=1403).
      final result = await SendTestRunner.send(
        'widgets/context_menu_button_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('context_menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_text_height_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_text_height_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // MOVED to crashing_tests_test.dart - crashes the test app
    // test('directionality_test.dart', ...)

    // MOVED to crashing_tests_test.dart - crashes the test app
    // test('display_feature_sub_screen_test.dart', ...)

    test('dual_transition_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dual_transition_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('editable_text_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('element_test.dart', () async {
      final result = await SendTestRunner.send('widgets/element_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('fade_in_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fade_in_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_extent_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_extent_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_scroll_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_extent_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('glowing_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/glowing_overscroll_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('html_element_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/html_element_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/image_filtered_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('implicitly_animated_widget_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/implicitly_animated_widget_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('implicitly_animated_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/implicitly_animated_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('indexed_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_stack_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('leaf_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/leaf_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('leaf_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/leaf_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_builder_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_looping_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_looping_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_child_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_child_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_child_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('never_scrollable_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/never_scrollable_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
