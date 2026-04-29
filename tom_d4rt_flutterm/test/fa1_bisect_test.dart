/// Fa1 bisect harness — measure FE counts on the 11 candidate scripts
/// remaining in the E2 layout-cascade cluster for testlog 20260428-1333.
///
/// Each test prints `STATUS: <bool>  FE: <int>` so the post-fix delta
/// is easy to grep without having to re-parse send_test_runner output.
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

  // Top-FE infinite-h/w + RenderFlex/RenderParagraph shapes.
  for (final script in const <String>[
    'widgets/shortcut_activator_test.dart',
    'widgets/widget_test.dart',
    'widgets/widget_state_text_style_test.dart',
    'widgets/widget_state_color_test.dart',
    'widgets/text_magnifier_configuration_test.dart',
  ]) {
    test('[fa1] $script', () async {
      final result = await SendTestRunner.send(script);
      print('FA1 STATUS: ${result.success}  FE: ${result.frameworkErrors.length}  SCRIPT: $script');
    });
  }

  // Negative-min-height (RenderEditableCustomPaint) shapes.
  for (final script in const <String>[
    'widgets/select_all_text_intent_test.dart',
    'widgets/transpose_characters_intent_test.dart',
    'widgets/undo_history_value_test.dart',
    'widgets/unfocus_disposition_test.dart',
    'widgets/update_selection_intent_test.dart',
  ]) {
    test('[fa1-neg] $script', () async {
      final result = await SendTestRunner.send(script);
      print('FA1 STATUS: ${result.success}  FE: ${result.frameworkErrors.length}  SCRIPT: $script');
    });
  }

  // C3-deferred carry-over (recheck — may have closed via prior batches).
  test('[fa1-c3] widgets/scroll_deceleration_rate_test.dart', () async {
    final result =
        await SendTestRunner.send('widgets/scroll_deceleration_rate_test.dart');
    print(
        'FA1 STATUS: ${result.success}  FE: ${result.frameworkErrors.length}  SCRIPT: widgets/scroll_deceleration_rate_test.dart');
  });

  // 2250-issue-analysis residual: scripts annotated with
  // `D4RT-SCRIPT-LIMITATION: layout cascade` per the closing-criterion
  // path documented in interpreter_unfixable.md §Fa1-N1. Re-run kept
  // here as a recurring sentinel — if any of these drop to FE=0 in a
  // future run the annotation can be removed and the script counted
  // as actually fixed.
  for (final script in const <String>[
    'widgets/snapshot_mode_test.dart',
    'widgets/restorable_double_test.dart',
    'widgets/restoration_mixin_test.dart',
    'widgets/select_all_text_intent_test.dart',
    'widgets/transpose_characters_intent_test.dart',
    'widgets/widget_state_color_test.dart',
    'widgets/text_magnifier_configuration_test.dart',
  ]) {
    test('[fa1-2250-sentinel] $script', () async {
      final result = await SendTestRunner.send(script);
      print(
          'FA1 STATUS: ${result.success}  FE: ${result.frameworkErrors.length}  SCRIPT: $script');
    });
  }
}
