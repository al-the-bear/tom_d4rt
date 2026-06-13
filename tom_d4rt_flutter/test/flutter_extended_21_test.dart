/// Auto-split extended bridge tests (file 21).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_21_test.dart';

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
  // WIDGETS PACKAGE TESTS (27 files)
  // ============================================================
  group('widgets/', () {
    test('retest: widgets/android_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/android_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // 20260602 1944 TODO C.185 (TEST-side sibling of AST-side C.175):
    // pre-fix isolated retest built in totalMs=2529 (httpMs=2297) with
    // frameworkErrors=0 — far under the default 25 s HTTP cap, so the
    // historical §1.10/E39 (= §S/S5) cold-start padding (50 s
    // httpBuildTimeout + 60 s dart-test wrapper) masked nothing.
    // Wrappers removed; defaults (25 s HTTP + 30 s dart-test) apply.
    test('retest: widgets/app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/app_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // testlog_20260529-1944 TODO C.186 — wrapper removed (was 50 s
    // httpBuildTimeout + 60 s dart-test Timeout). The §6 todo #5 baseline
    // "~18 s totalMs" was a cold-start contention flake; the isolated retest
    // builds in ~1.6 s (httpMs=1623, totalMs=1894, sourceChars=78203,
    // frameworkErrors=0) — far under the default 25 s cap. Defaults apply.
    test('retest: widgets/back_button_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/back_button_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // testlog_20260529-1944 TODO C.187 — removed the 50 s httpBuildTimeout
    // override + 60 s dart-test wrapper (the §6/E20 cold-start padding). The
    // pre-fix isolated retest built in ~1.8 s (httpMs=1563, totalMs=1789,
    // sourceChars=60999, frameworkErrors=0), far under the default 25 s HTTP
    // cap — the wrapper masked nothing. Defaults (25 s httpBuildTimeout +
    // 30 s dart-test timeout) now apply. TEST-side sibling of AST-side C.177.
    test('retest: widgets/box_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/box_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

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
      final result = await SendTestRunner.send('widgets/scrollable_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    // testlog_20260529-1944 TODO C.188 — removed the cold-start wrapper
    // (50 s httpBuildTimeout + 60 s dart-test Timeout). Isolated retest
    // builds in ~1.6 s (httpMs=1557, totalMs=1782, frameworkErrors=0,
    // outputLines=17) — far under the default 25 s httpBuildTimeout cap.
    // TEST-side sibling of the AST-side C.178. Defaults now apply.
    test('selectable_region_test.dart', () async {
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

    test('sliver_animated_grid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

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

  // ============================================================
  // RELOCATED PASSING TESTS
  // Moved here because they pass in both the AST and TEST runs:
  //   - directionality / extend_selection_to_line_break_intent:
  //       from crashing_tests_test.dart (now deleted).
  //   - live_text_input_status / lock_state / animated_switcher:
  //       previously the W3/W4/W5 entries of blocking_tests_test.dart.
  // ============================================================
  group('relocated passing', () {
    test('directionality_test.dart (from crashing_tests)', () async {
      final result = await SendTestRunner.send(
        'widgets/directionality_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'extend_selection_to_line_break_intent_test.dart (from crashing_tests)',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_line_break_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'retest/widgets/live_text_input_status_test.dart (from blocking W3)',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/live_text_input_status_test.dart',
          waitBeforeClear: const Duration(seconds: 10),
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('retest/widgets/lock_state_test.dart (from blocking W4)', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/lock_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets/animated_switcher_test.dart (from blocking W5)', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_switcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  group('Blocking tests - retest wedgers', () {
    test(
      'W2: retest/widgets/default_text_editing_shortcuts_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/default_text_editing_shortcuts_test.dart',
          waitBeforeClear: const Duration(seconds: 10),
        );
        expectSuccess(result);
      },
    );
  });

  group('Blocking tests - relocated failing scripts', () {
    // From crashing_tests_test.dart (deleted).
    test(
      'display_feature_sub_screen_test.dart (from secondary_classes)',
      () async {
        final result = await SendTestRunner.send(
          'widgets/display_feature_sub_screen_test.dart',
        );
        expectSuccess(result);
      },
    );

    // From essential_classes_test.dart.
    test('appbar_test.dart (from essential_classes)', () async {
      final result = await SendTestRunner.send('widgets/appbar_test.dart');
      expectSuccess(result);
    });

    test('icon_test.dart (from essential_classes)', () async {
      final result = await SendTestRunner.send('widgets/icon_test.dart');
      expectSuccess(result);
    });

    test('singlechildscrollview_test.dart (from essential_classes)', () async {
      final result = await SendTestRunner.send(
        'widgets/singlechildscrollview_test.dart',
      );
      expectSuccess(result);
    });

    // From important_classes_test.dart.
    test('customscrollview_test.dart (from important_classes)', () async {
      final result = await SendTestRunner.send(
        'widgets/customscrollview_test.dart',
      );
      expectSuccess(result);
    });

    test('transform_full_test.dart (from important_classes)', () async {
      final result = await SendTestRunner.send(
        'widgets/transform_full_test.dart',
      );
      expectSuccess(result);
    });

    // From secondary_classes_test.dart.
    test('selection_registrar_test.dart (from secondary_classes)', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_registrar_test.dart',
      );
      expectSuccess(result);
    });

    test('animation_max_test.dart (from secondary_classes)', () async {
      final result = await SendTestRunner.send(
        'animation/animation_max_test.dart',
      );
      expectSuccess(result);
    });

    // The wedger that causes the cupertino_text_magnifier /clear timeout.
    test(
      'cupertino_spell_check_suggestions_toolbar_test.dart (from secondary_classes)',
      () async {
        final result = await SendTestRunner.send(
          'cupertino/cupertino_spell_check_suggestions_toolbar_test.dart',
        );
        expectSuccess(result);
      },
    );

    test(
      'cupertino_text_magnifier_test.dart (from secondary_classes)',
      () async {
        final result = await SendTestRunner.send(
          'cupertino/cupertino_text_magnifier_test.dart',
        );
        expectSuccess(result);
      },
    );

    test(
      'ztmp_path_metrics_access_test.dart (from secondary_classes)',
      () async {
        final result = await SendTestRunner.send(
          'dart_ui/ztmp_path_metrics_access_test.dart',
        );
        expectSuccess(result);
      },
    );

    test('semantics_action_test.dart (from secondary_classes)', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_action_test.dart',
      );
      expectSuccess(result);
    });

    // From hardly_relevant_classes_2_test.dart.
    test('selection_area_test.dart (from hardly_relevant_classes_2)', () async {
      final result = await SendTestRunner.send(
        'material/selection_area_test.dart',
      );
      expectSuccess(result);
    });

    test(
      'animated_icon_data_test.dart (from hardly_relevant_classes_2)',
      () async {
        final result = await SendTestRunner.send(
          'material/animated_icon_data_test.dart',
        );
        expectSuccess(result);
      },
    );

    // From hardly_relevant_classes_3_test.dart.
    test(
      'persistent_header_show_on_screen_configuration_test.dart (from hardly_relevant_classes_3)',
      () async {
        final result = await SendTestRunner.send(
          'rendering/persistent_header_show_on_screen_configuration_test.dart',
        );
        expectSuccess(result);
      },
    );

    // From hardly_relevant_classes_5_test.dart.
    test(
      'popup_window_controller_delegate_test.dart (from hardly_relevant_classes_5)',
      () async {
        final result = await SendTestRunner.send(
          'widgets/popup_window_controller_delegate_test.dart',
        );
        expectSuccess(result);
      },
    );
  });
}

void expectSuccess(SendResult result) {
  final errors = result.frameworkErrors.isNotEmpty
      ? result.frameworkErrors.join('; ')
      : null;
  final reason = result.error ?? errors;
  expect(result.success && !result.hasFrameworkErrors, isTrue, reason: reason);
}
