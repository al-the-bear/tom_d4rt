/// Auto-split extended bridge tests (file 04).
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
  // GESTURES PACKAGE (45 files)
  // ============================================================
  group('gestures/', () {
    test('base_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/base_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('gestures/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_start_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_start_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_start_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_start_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'flutter_error_details_for_pointer_event_dispatcher_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'gestures/flutter_error_details_for_pointer_event_dispatcher_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('gesture_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_disposition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_recognizer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_test_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/hit_test_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_testable_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/hit_testable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_scroll_view_fling_velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('least_squares_solver_test.dart', () async {
      // 1944 TODO C.53 (2026-05-31): historical 20260518-1449 Step 9
      // full-suite-contention wrapper REMOVED. Script runs in ~4.1 s
      // under normal load (httpMs=4067, bundleJsonBytes=938527 —
      // 939 KB bundle / 81 KB / 2337-line script). Slower than the
      // average §C.iv entry but still ~26 s of headroom under 30 s.
      final result = await SendTestRunner.send(
        'gestures/least_squares_solver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mac_o_s_scroll_view_fling_velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/mac_o_s_scroll_view_fling_velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multitouch_drag_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multitouch_drag_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('offset_pair_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/offset_pair_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('one_sequence_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/one_sequence_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_added_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_added_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_cancel_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_cancel_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_enter_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_enter_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_event_converter_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_converter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_event_resampler_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_resampler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_exit_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_exit_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_hover_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_hover_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_move_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_move_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_end_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_end_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_start_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_start_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_pan_zoom_update_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_pan_zoom_update_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_removed_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_removed_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scale_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scale_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scroll_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scroll_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_scroll_inertia_cancel_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_scroll_inertia_cancel_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_signal_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_resolver_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_signal_resolver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/pointer_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('polynomial_fit_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/polynomial_fit_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('primary_pointer_gesture_recognizer_test.dart', () async {
      // 1944 TODO C.54 (2026-05-31): historical 20260523-1056 §1.4/E17
      // cold-start-contention wrapper REMOVED. Script runs in ~1.4 s
      // under normal load (httpMs=1443, bundleJsonBytes=764877 —
      // 765 KB bundle / 71 KB / 2178-line script).
      final result = await SendTestRunner.send(
        'gestures/primary_pointer_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sampling_clock_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/sampling_clock_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_move_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_move_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('velocity_estimate_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_estimate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('velocity_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
