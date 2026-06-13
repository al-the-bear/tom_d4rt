/// Auto-split extended bridge tests (file 20).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_20_test.dart';

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
  // WIDGETS PACKAGE - continued (228 files)
  // ============================================================
  group('widgets/', () {
    test('tree_sliver_state_mixin_test.dart', () async {
      // 1944 TODO C.108 (2026-06-01): historical 20260523-1056
      // §1.8/E36 (= §S/S4 wedge-candidate cluster) cold-start-contention
      // wrapper REMOVED. Same shape as C.102/C.104 (inline
      // `httpBuildTimeout: 50s` + outer `Timeout: 60s`). Script runs
      // in ~4.0 s under isolated retest (httpMs=3469, totalMs=3988,
      // frameworkErrors=0, sourceBytes=87899, sourceChars=87798,
      // bundleJsonBytes=1038635 — 88 KB script / 1.0 MB bundle).
      // Defaults (25 s httpBuildTimeout + 30 s dart-test) apply —
      // ~26 s headroom even on this heavier script.
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_test.dart', () async {
      // 1944 TODO C.109 (2026-06-01): historical 20260524-2003 §6/T9
      // (= todo #8) cold-start-contention wrapper REMOVED. Same shape
      // as C.102/C.104/C.108. Script runs in ~1.9 s under isolated
      // retest (httpMs=1488, totalMs=1880, frameworkErrors=0,
      // sourceBytes=41332, sourceChars=41326, bundleJsonBytes=445618
      // — 41 KB / 446 KB bundle; outputLines=45 — rich coverage).
      // Defaults apply.
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
      // 1944 TODO C.110 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. Script runs in ~3.4 s
      // under isolated retest (httpMs=2886, totalMs=3408,
      // frameworkErrors=0, sourceBytes=111042, sourceChars=110942,
      // bundleJsonBytes=1252452 — 111 KB script / 1.25 MB bundle, the
      // largest single script in §C.viii). Defaults apply — ~27 s
      // headroom remains even on this heaviest entry.
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
      // 1944 TODO C.111 (2026-06-01): historical 20260523-1056 §1.8/E37
      // cold-start-contention wrapper REMOVED. Same shape as
      // C.102/C.104/C.108. Script runs in ~1.8 s under isolated retest
      // (httpMs=1382, totalMs=1838, frameworkErrors=0,
      // sourceBytes=65957, sourceChars=61573, bundleJsonBytes=799306
      // — 62 KB script / 1835-line / 799 KB bundle). Defaults apply.
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
      // 1944 TODO C.112 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. Last AST entry in
      // §C.viii — also the last `_slowTestTimeout` usage in this
      // file, so the const declaration + its doc comment are
      // removed too. Script runs in ~2.2 s under isolated retest
      // (httpMs=1748, totalMs=2225, frameworkErrors=0, sourceBytes=
      // 76028, sourceChars=75964, bundleJsonBytes=866117 — 76 KB /
      // 866 KB bundle; outputLines=3 — rich coverage). Defaults
      // apply. Closes AST half of §C.viii.
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

    // C.173 (1944) — FIXED 20260602: removed the §S/E1/E38 cold-start wrapper
    // (50 s httpBuildTimeout + 60 s dart-test Timeout). Isolated retest builds
    // this 1521-line, 60 KB script in ~2.6 s (httpMs~2190, frameworkErrors=0,
    // 959 KB bundle); the wrapper was padding that masked nothing. Defaults now
    // apply (25 s httpBuildTimeout + 30 s dart-test timeout).
    test('render_custom_paint_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_paint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // C.174 (1944) — FIXED 20260602: removed the §6/E7/E14/E17 + T4/T15/T18
    // cold-start wrapper (50 s httpBuildTimeout + 60 s dart-test Timeout).
    // Isolated retest builds this 71 KB render-heavy script in ~2.6 s
    // (httpMs~2076, frameworkErrors=0, 1.15 MB bundle); the wrapper was
    // padding that masked nothing. Defaults now apply (25 s httpBuildTimeout
    // + 30 s dart-test timeout).
    test('render_custom_single_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_single_child_layout_box_test.dart',
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

    test(
      'retest: rendering/render_sliver_box_child_manager_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/rendering/render_sliver_box_child_manager_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );
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
}
