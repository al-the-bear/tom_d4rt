/// Auto-split base bridge tests (file 09).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_09_test.dart';

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

  // --- GESTURES INDIVIDUAL SCRIPTS (25 files) ---
  group('gestures/ individual', () {
    test('base_tap_and_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/base_tap_and_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delayed_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/delayed_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_gesture_settings_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/device_gesture_settings_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_test.dart', () async {
      final result = await SendTestRunner.send('gestures/drag_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('eager_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/eager_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('horizontal_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/horizontal_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('immediate_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/immediate_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('long_press_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/long_press_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_drag_pointer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_drag_pointer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('positioned_gesture_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/positioned_gesture_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_cancel_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_cancel_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_up_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_up_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_horizontal_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_horizontal_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_pan_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_pan_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_end_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_end_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_start_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_start_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_up_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_up_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_update_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_update_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/vertical_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
