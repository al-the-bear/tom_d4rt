/// Auto-split base bridge tests (file 15).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'dart:io' show Platform;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_15_test.dart';

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

  // --- WIDGETS INDIVIDUAL SCRIPTS (172 files) ---
  group('widgets/ individual', () {
    test('always_scrollable_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/always_scrollable_scroll_physics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test(
      'android_view_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/android_view_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
      // SCD139 (2026-09-15) re-derived this rather than trusting it. The
      // original justification — added by e22671e8b on 2026-04-18, "AndroidView
      // only renders on Android — fails everywhere else" — is the weak kind
      // this audit exists to catch: platform-dependence alone does not justify
      // a skip, and the script DOES guard itself (`_supportsAndroidView` gates
      // `_status` to 'unsupported' on non-Android hosts).
      //
      // Removing it measured as PASSING on the hosted interpreter, which is
      // exactly the trap. Re-measured against the working tree, where GEN-125
      // is fixed, the script gets further and kills the companion app:
      //
      //     Bad state: Transport failure … HttpException: Connection closed
      //     before full header was received
      //
      // So the apparent pass was one defect masking another: GEN-125's
      // `ValueChanged` rejections short-circuited the build before it reached
      // the platform-view channel. The real reason is the same uncatchable
      // Objective-C `NSInvalidArgumentException` SCC47 documented for
      // `retest/rendering/render_android_view_test.dart` — raised inside the
      // macOS embedder, outside any Dart frame, fatal to the app and therefore
      // to a sibling test as well.
      //
      // Genuine HOST-CAPABILITY guard. Stays skipped, now for the measured
      // reason.
      skip: !Platform.isAndroid
          ? 'AndroidView PlatformView crashes the embedder on non-Android hosts'
          : null,
    );

    test('animated_align_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_align_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_cross_fade_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_cross_fade_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_fractionally_sized_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_fractionally_sized_box_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_modal_barrier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_modal_barrier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_physical_model_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_rotation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_rotation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_scale_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_scale_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_slide_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_slide_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animated_switcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_switcher_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autofill_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_group_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('backdrop_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backdrop_filter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bouncing_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/bouncing_scroll_physics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('build_owner_test.dart', () async {
      final result = await SendTestRunner.send('widgets/build_owner_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('build_scope_test.dart', () async {
      final result = await SendTestRunner.send('widgets/build_scope_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('checked_mode_banner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/checked_mode_banner_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('clamping_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clamping_scroll_physics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('color_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/color_filtered_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('component_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/component_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('composited_transform_follower_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_follower_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('composited_transform_target_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_target_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('content_insertion_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/content_insertion_configuration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('context_menu_button_item_test.dart', () async {
      // 1944 TODO C.41 (2026-05-31): historical 20260523-1056 §1.3/E4
      // (ast) + §2.C contention (test) parallel-driver-contention
      // wrapper REMOVED. Script runs in ~1.6 s under normal load
      // (httpMs=1572, sourceChars=45668 — 46 KB script).
      final result = await SendTestRunner.send(
        'widgets/context_menu_button_item_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('context_menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('default_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_asset_bundle_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('default_text_height_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_text_height_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // MOVED to crashing_tests_test.dart - crashes the test app
    // test('directionality_test.dart', ...)

    // MOVED to crashing_tests_test.dart - crashes the test app
    // test('display_feature_sub_screen_test.dart', ...)

    test('dual_transition_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dual_transition_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('editable_text_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('element_test.dart', () async {
      final result = await SendTestRunner.send('widgets/element_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('fade_in_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fade_in_image_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fixed_extent_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_metrics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fixed_extent_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_scroll_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fixed_extent_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_scroll_physics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('glowing_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/glowing_overscroll_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('html_element_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/html_element_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/image_filtered_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('implicitly_animated_widget_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/implicitly_animated_widget_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('implicitly_animated_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/implicitly_animated_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('indexed_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_stack_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inherited_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inherited_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_notifier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inherited_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inherited_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('leaf_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/leaf_render_object_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('leaf_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/leaf_render_object_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_builder_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_list_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_child_looping_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_looping_list_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_scroll_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('list_wheel_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_viewport_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('magnifier_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('magnifier_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_decoration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('magnifier_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_info_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('multi_child_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_child_render_object_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('multi_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_child_render_object_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('navigation_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_toolbar_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('never_scrollable_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/never_scrollable_scroll_physics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
