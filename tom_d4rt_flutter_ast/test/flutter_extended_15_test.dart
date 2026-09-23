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
      SendTestRunner.expectSuccess(result);
    });

    // MOVED to crashing_tests_test.dart - crashes the test app
    // test('extend_selection_to_line_break_intent_test.dart', ...)

    test(
      'extend_selection_to_next_paragraph_boundary_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
    );

    test(
      'extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
    );

    test('extend_selection_to_next_word_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/extend_selection_to_next_word_boundary_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test(
      'extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
      () async {
        // 1944 TODO C.91 (2026-06-01): historical 20260523-1056
        // §1.7/E32 cold-start-contention wrapper REMOVED. Script
        // runs in ~1.8 s under isolated retest (httpMs=1470,
        // totalMs=1803, frameworkErrors=0, sourceChars=28348 — 28 KB
        // / 656-line / 195 KB bundle). Defaults apply.
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_line_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
    );

    test(
      'extend_selection_vertically_to_adjacent_page_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
    );

    test('feedback_test.dart', () async {
      final result = await SendTestRunner.send('widgets/feedback_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('fixed_scroll_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_scroll_metrics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flex_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flex_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('floating_header_snap_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/floating_header_snap_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_attachment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_attachment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_highlight_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_highlight_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_highlight_strategy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_order_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focus_order_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('focus_scope_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_scope_node_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_traversal_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_traversal_order_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fractional_translation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fractional_translation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gesture_recognizer_factory_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gesture_recognizer_factory_with_handlers_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_recognizer_factory_with_handlers_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('global_object_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/global_object_key_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('hero_controller_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_scope_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('hero_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('hero_flight_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hero_flight_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('hold_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/hold_scroll_activity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_copy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_custom_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_custom_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_cut_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_live_text_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_look_up_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_paste_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_paste_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_search_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_search_web_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_select_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_select_all_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_share_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('i_o_s_system_context_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/i_o_s_system_context_menu_item_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('icon_data_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_data_property_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('icon_data_test.dart', () async {
      final result = await SendTestRunner.send('widgets/icon_data_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('icon_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/icon_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('idle_scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/idle_scroll_activity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('ignore_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ignore_baseline_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_icon_test.dart', () async {
      final result = await SendTestRunner.send('widgets/image_icon_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('img_element_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/img_element_platform_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('indexed_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_slot_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inherited_model_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_model_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inspector_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inspector_button_variant_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_button_variant_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inspector_reference_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_reference_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inspector_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_selection_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inspector_serialization_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inspector_serialization_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('keep_alive_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_handle_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('keep_alive_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keep_alive_notification_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('key_event_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/key_event_result_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('key_set_test.dart', () async {
      final result = await SendTestRunner.send('widgets/key_set_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keyboard_listener_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('labeled_global_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/labeled_global_key_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('layout_id_test.dart', () async {
      final result = await SendTestRunner.send('widgets/layout_id_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('lexical_focus_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/lexical_focus_order_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('live_text_input_status_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_notifier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('live_text_input_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/live_text_input_status_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('local_history_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/local_history_entry_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
