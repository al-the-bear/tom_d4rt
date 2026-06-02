/// Blocking Tests — consolidated error-case harness.
///
/// This file is the single place where every script that currently wedges or
/// fails the test app is collected. Each entry is EXPECTED to fail or time
/// out under the present interpreter/bridge (transport timeout on POST /build
/// or GET /clear, or an outright crash). Keeping them here lets every other
/// suite run clean.
///
/// Sources of the entries below:
///   - W1/W2: generator_interpreter_retest wedgers that still block.
///     (W3 live_text_input_status, W4 lock_state, W5 animated_switcher were
///     moved to timeout_tests_test.dart because they pass in both runs.)
///   - crashing_tests_test.dart (now deleted): display_feature_sub_screen.
///   - essential_classes_test.dart: appbar, icon, singlechildscrollview.
///   - important_classes_test.dart: customscrollview, transform_full.
///   - secondary_classes_test.dart: selection_registrar, animation_max,
///     cupertino_spell_check_suggestions_toolbar (+ cupertino_text_magnifier,
///     which fails on the preceding /clear), ztmp_path_metrics_access,
///     semantics_action.
///   - hardly_relevant_classes_2_test.dart: selection_area, animated_icon_data.
///   - hardly_relevant_classes_3_test.dart:
///     persistent_header_show_on_screen_configuration.
///   - hardly_relevant_classes_5_test.dart: popup_window_controller_delegate.
///
/// See doc/testlog_20260602-0629-issue-analysis/error_analysis.md and
/// doc/interpreter_issues.md for the per-script diagnoses.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// Helper to check that a test truly passes (success AND no framework errors).
void expectSuccess(SendResult result) {
  final errors = result.frameworkErrors.isNotEmpty
      ? result.frameworkErrors.join('; ')
      : null;
  final reason = result.error ?? errors;
  expect(result.success && !result.hasFrameworkErrors, isTrue, reason: reason);
}

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Blocking tests - retest wedgers', () {
    test('W1: retest/widgets/context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/context_action_test.dart',
      );
      expectSuccess(result);
    });

    test('W2: retest/widgets/default_text_editing_shortcuts_test.dart',
        () async {
      final result = await SendTestRunner.send(
        'retest/widgets/default_text_editing_shortcuts_test.dart',
        waitBeforeClear: const Duration(seconds: 10),
      );
      expectSuccess(result);
    });
  });

  group('Blocking tests - relocated failing scripts', () {
    // From crashing_tests_test.dart (deleted).
    test('display_feature_sub_screen_test.dart (from secondary_classes)',
        () async {
      final result = await SendTestRunner.send(
        'widgets/display_feature_sub_screen_test.dart',
      );
      expectSuccess(result);
    });

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
    test('cupertino_spell_check_suggestions_toolbar_test.dart (from secondary_classes)',
        () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_spell_check_suggestions_toolbar_test.dart',
      );
      expectSuccess(result);
    });

    test('cupertino_text_magnifier_test.dart (from secondary_classes)',
        () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_magnifier_test.dart',
      );
      expectSuccess(result);
    });

    test('ztmp_path_metrics_access_test.dart (from secondary_classes)',
        () async {
      final result = await SendTestRunner.send(
        'dart_ui/ztmp_path_metrics_access_test.dart',
      );
      expectSuccess(result);
    });

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

    test('animated_icon_data_test.dart (from hardly_relevant_classes_2)',
        () async {
      final result = await SendTestRunner.send(
        'material/animated_icon_data_test.dart',
      );
      expectSuccess(result);
    });

    // From hardly_relevant_classes_3_test.dart.
    test('persistent_header_show_on_screen_configuration_test.dart (from hardly_relevant_classes_3)',
        () async {
      final result = await SendTestRunner.send(
        'rendering/persistent_header_show_on_screen_configuration_test.dart',
      );
      expectSuccess(result);
    });

    // From hardly_relevant_classes_5_test.dart.
    test('popup_window_controller_delegate_test.dart (from hardly_relevant_classes_5)',
        () async {
      final result = await SendTestRunner.send(
        'widgets/popup_window_controller_delegate_test.dart',
      );
      expectSuccess(result);
    });
  });
}
