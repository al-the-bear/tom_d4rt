/// Auto-split base bridge tests (file 16).
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

  // --- WIDGETS INDIVIDUAL SCRIPTS (172 files) ---
  group('widgets/ individual', () {
    test('overflow_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_bar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_storage_bucket_test.dart', () async {
      // 1944 TODO C.42 (2026-05-31): historical 20260523-1056 §1.3/E6
      // (ast) + §2.C contention (test) parallel-driver-contention
      // wrapper REMOVED. Script runs in ~2.6 s under normal load
      // (httpMs=2573, sourceChars=84402 — 84 KB / 2285-line script).
      final result = await SendTestRunner.send(
        'widgets/page_storage_bucket_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_storage_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_storage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('parent_data_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/parent_data_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('parent_data_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/parent_data_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('performance_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/performance_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physical_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physical_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physical_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pinned_header_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pinned_header_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_bar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_item_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_item_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_provided_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_provided_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_link_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_view_link_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pop_scope_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pop_scope_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('positioned_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/positioned_directional_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('primary_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/primary_scroll_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('proxy_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/proxy_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('proxy_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/proxy_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_group_test.dart', () async {
      final result = await SendTestRunner.send('widgets/radio_group_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_maintaining_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/range_maintaining_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_magnifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_view_test.dart', () async {
      // 1944 TODO C.43 (2026-05-31): historical 20260523-1056 §1.3/E7
      // (ast) + §2.C contention (test) parallel-driver-contention
      // wrapper REMOVED. Script runs in ~1.6 s under normal load
      // (httpMs=1639, sourceChars=54182 — 54 KB / 1716-line script).
      final result = await SendTestRunner.send('widgets/raw_view_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_bool_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_bool_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_date_time_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_date_time_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_double_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_double_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_enum_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_enum_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_int_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_int_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_string_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_string_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_text_editing_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_text_editing_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_widget_test.dart', () async {
      final result = await SendTestRunner.send('widgets/root_widget_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollable_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollable_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollable_test.dart', () async {
      final result = await SendTestRunner.send('widgets/scrollable_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_test.dart', () async {
      // 1944 TODO C.44 (2026-05-31): historical 20260523-1056 §1.3/E8
      // (ast) + §2.C contention (test) parallel-driver-contention
      // wrapper REMOVED. Script runs in ~1.5 s under normal load
      // (httpMs=1535, sourceChars=54500 — 54 KB / 1456-line script).
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
      final result = await SendTestRunner.send('widgets/shader_mask_test.dart');
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
  });
}
