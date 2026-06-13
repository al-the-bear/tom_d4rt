/// Auto-split extended bridge tests (file 15).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_15_test.dart';

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
  // WIDGETS PACKAGE (456 files)
  // ============================================================
  group('widgets/', () {
    test('extend_selection_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_document_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // MOVED to crashing_tests_test.dart - crashes the test app
    // test('extend_selection_to_line_break_intent_test.dart', ...)

    test(
      'extend_selection_to_next_paragraph_boundary_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('extend_selection_to_next_word_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_next_word_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
      () async {
        // 1944 TODO C.95 (2026-06-01): historical 20260523-1056
        // §1.7/E32 (ast) + §2.D contention (test) cold-start-contention
        // wrapper REMOVED. TEST sibling of C.91 (AST). Script runs in
        // ~1.8 s under isolated retest (httpMs=1518, totalMs=1750,
        // frameworkErrors=0, sourceChars=28348 — 28 KB / 656-line).
        // Defaults (25 s httpBuildTimeout + 30 s dart-test) apply.
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_line_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_page_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('feedback_test.dart', () async {
      final result = await SendTestRunner.send('widgets/feedback_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_scroll_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_scroll_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flex_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flex_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_header_snap_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/floating_header_snap_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_attachment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_attachment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_highlight_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_highlight_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_order_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focus_order_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_scope_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_scope_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_traversal_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_traversal_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fractional_translation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fractional_translation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_factory_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_factory_with_handlers_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_with_handlers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('global_object_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/global_object_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_flight_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_flight_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hold_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hold_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_custom_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_custom_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_live_text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_look_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_paste_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_paste_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_search_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_search_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_select_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_select_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_share_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_data_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_data_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_data_test.dart', () async {
      final result = await SendTestRunner.send('widgets/icon_data_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('idle_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/idle_scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ignore_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ignore_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_icon_test.dart', () async {
      final result = await SendTestRunner.send('widgets/image_icon_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('img_element_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/img_element_platform_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('indexed_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_model_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_model_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_button_test.dart', () async {
      // 1944 TODO C.96 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` (Timeout(Duration(seconds: 60)))
      // REMOVED. No AST sibling — TEST-only entry. Script runs in
      // ~2.2 s under isolated retest (httpMs=1939, totalMs=2177,
      // frameworkErrors=0, sourceChars=34763 — 35 KB inspector-
      // button widget test with rich output: outputLines=18).
      // Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/inspector_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_button_variant_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_button_variant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_reference_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_reference_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inspector_serialization_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_serialization_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/key_event_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_set_test.dart', () async {
      final result = await SendTestRunner.send('widgets/key_set_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keyboard_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('labeled_global_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/labeled_global_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layout_id_test.dart', () async {
      final result = await SendTestRunner.send('widgets/layout_id_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('lexical_focus_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/lexical_focus_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_input_status_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_input_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('local_history_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/local_history_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
