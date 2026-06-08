/// Auto-split extended bridge tests (file 20).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
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
  // WIDGETS PACKAGE - continued (228 files)
  // ============================================================
  group('widgets/', () {
    test('tree_sliver_state_mixin_test.dart', () async {
      // 1944 TODO C.122 (2026-06-01): historical 20260523-1056
      // §1.8/E36 (= §S/S4 wedge-candidate cluster) cold-start-
      // contention wrapper REMOVED. TEST sibling of C.108 (AST).
      // Inline `httpBuildTimeout: 50s` + outer `Timeout: 60s` shape
      // — original cross-project TimeoutException was cold-start
      // contention, not a real wedge. Script runs in ~4.0 s under
      // isolated retest (httpMs=3808, totalMs=4045,
      // frameworkErrors=0, sourceChars=87798 — 88 KB / 1.0 MB
      // bundle in the AST sibling baseline). Defaults (25 s
      // httpBuildTimeout + 30 s dart-test) apply — ~26 s headroom.
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_test.dart', () async {
      // 1944 TODO C.123 (2026-06-01): historical 20260524-2003 §6/T9
      // (= todo #8) cold-start-contention wrapper REMOVED. TEST
      // sibling of C.109 (AST). Same shape as the AST sibling
      // (inline `httpBuildTimeout: 50s` + outer `Timeout: 60s`).
      // Script runs in ~1.8 s under isolated retest (httpMs=1614,
      // totalMs=1842, frameworkErrors=0, sourceChars=41326 — 41 KB;
      // outputLines=45 — rich coverage). Defaults apply, matching
      // the AST sibling C.109.
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
      // 1944 TODO C.124 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling —
      // TEST-only entry. Script runs in ~3.9 s under isolated retest
      // (httpMs=3647, totalMs=3870, frameworkErrors=0,
      // sourceChars=70012 — 70 KB two-dimensional-child-list-delegate
      // widget test; outputLines=1). Defaults apply.
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
      // 1944 TODO C.125 (2026-06-01): historical 20260523-1056
      // §1.8/E37 (ast) + §2.D contention (test) cold-start-
      // contention wrapper REMOVED. TEST sibling of C.111 (AST).
      // Same inline `httpBuildTimeout: 50s` + outer `Timeout: 60s`
      // shape as the AST sibling. Script runs in ~1.9 s under
      // isolated retest (httpMs=1657, totalMs=1884,
      // frameworkErrors=0, sourceChars=61573 — 62 KB / 1835-line).
      // Defaults apply, matching the AST sibling C.111.
      final result = await SendTestRunner.send(
        'widgets/update_selection_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('user_scroll_notification_test.dart', () async {
      // 1944 TODO C.126 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling —
      // TEST-only entry. Script runs in ~2.8 s under isolated retest
      // (httpMs=2581, totalMs=2802, frameworkErrors=0,
      // sourceChars=76766 — 77 KB user-scroll-notification widget
      // test; outputLines=1). Defaults apply.
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
      // 1944 TODO C.127 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. Last `_slowTestTimeout`
      // usage in this file (and last entry in §C.viii), so the const
      // declaration + its doc comment are removed too. No AST sibling
      // — TEST-only entry. Script runs in ~2.1 s under isolated
      // retest (httpMs=1915, totalMs=2145, frameworkErrors=0,
      // sourceChars=114229 — 114 KB widget-state-property-all widget
      // test, largest TEST-side §C.viii script). Defaults apply.
      // Closes TEST half of §C.viii and the entire §C.viii cluster.
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
    // testlog_20260529-1944 TODO C.180 — removed the 50 s httpBuildTimeout
    // override + 60 s dart-test wrapper (the §6/E8 cold-start padding). The
    // pre-fix isolated retest built in ~3.0 s (httpMs=2770, frameworkErrors=0),
    // far under the default 25 s HTTP cap — the wrapper masked nothing.
    // Defaults (25 s httpBuildTimeout + 30 s dart-test timeout) now apply.
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

    // testlog_20260529-1944 TODO C.181 — removed the 60 s `_slowTestTimeout`
    // dart-test wrapper. The pre-fix isolated retest built in ~1.6 s
    // (httpMs=1369, frameworkErrors=0), far under the default 25 s HTTP cap —
    // the wrapper masked nothing. Defaults (25 s httpBuildTimeout + 30 s
    // dart-test timeout) now apply.
    test('render_custom_multi_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_multi_child_layout_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // testlog_20260529-1944 TODO C.182 — removed the 50 s `httpBuildTimeout`
    // override + 60 s dart-test `Timeout` wrapper. The pre-fix isolated retest
    // built in ~2.7 s (httpMs=2478, frameworkErrors=0), far under the default
    // 25 s HTTP cap — the historical §S/E1/E38 cold-start padding masked
    // nothing. TEST-side sibling of the AST-side C.173. Defaults (25 s
    // httpBuildTimeout + 30 s dart-test timeout) now apply.
    test('render_custom_paint_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_paint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // testlog_20260529-1944 TODO C.183 — removed the 50 s `httpBuildTimeout`
    // override + 60 s dart-test `Timeout` wrapper. The pre-fix isolated retest
    // built in ~2.4 s (httpMs=2191, frameworkErrors=0), far under the default
    // 25 s HTTP cap — the historical §6/E7/E14/E17 + T4/T15/T18 cold-start
    // padding masked nothing. TEST-side sibling of the AST-side C.174. Defaults
    // (25 s httpBuildTimeout + 30 s dart-test timeout) now apply.
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
    // testlog_20260529-1944 TODO C.184 — removed the 60 s `_slowTestTimeout`
    // dart-test wrapper. The pre-fix isolated retest built in ~2.3 s
    // (httpMs=2001, frameworkErrors=0, sourceChars=89125), far under the
    // default 25 s HTTP cap — the wrapper masked nothing. This was the LAST
    // `_slowTestTimeout` usage in the file, so the now-orphaned const
    // declaration was removed. Defaults (25 s httpBuildTimeout + 30 s
    // dart-test timeout) now apply.
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
