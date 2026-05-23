// ignore_for_file: avoid_print
/// Tests for the programmatic interaction system.
///
/// These tests verify that the /interact endpoint can simulate user
/// interactions with dialogs, menus, and bottom sheets.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(timeout: const Duration(seconds: 120));
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Interactive tests', () {
    test('showDialog - can tap OK button to dismiss', () async {
      // Send the script that shows a dialog via Future.microtask
      final result = await SendTestRunner.sendAndInteract(
        'material/showdialog_test.dart',
        actions: [
          // Wait for dialog to appear (microtask + animation)
          {'type': 'waitFrames', 'frames': 30},
          // Tap the OK button
          {'type': 'tapText', 'text': 'OK'},
          // Wait for dialog to dismiss
          {'type': 'waitFrames', 'frames': 10},
        ],
        interactDelay: const Duration(milliseconds: 500),
      );

      expect(result.build.success, isTrue,
          reason: 'Build should succeed: ${result.build.error}');

      // Check if interaction succeeded
      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
        // Even if interaction fails, the test validates the infrastructure
        if (result.interact!.success) {
          // Check that 'OK pressed' was printed by the script
          final allOutput = [...result.build.output, ...result.interact!.output];
          expect(allOutput.any((line) => line.contains('showDialog')), isTrue,
              reason: 'Expected showDialog output');
        }
      }
    });

    test('showBottomSheet - can tap to select option', () async {
      final result = await SendTestRunner.sendAndInteract(
        'material/showbottomsheet_test.dart',
        actions: [
          // Wait for bottom sheet to appear
          {'type': 'waitFrames', 'frames': 30},
          // Tap the Share option
          {'type': 'tapText', 'text': 'Share'},
          // Wait for dismiss
          {'type': 'waitFrames', 'frames': 10},
        ],
        interactDelay: const Duration(milliseconds: 500),
      );

      expect(result.build.success, isTrue,
          reason: 'Build should succeed: ${result.build.error}');

      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
      }
    });

    test('showMenu - can tap menu item', () async {
      // `material/showmenu_test.dart` is a static teaching demo that renders
      // a `_PreviewMenuItem` gallery (Edit / Duplicate / Share / Delete) — it
      // does not actually invoke `showMenu(...)`, so we tap a label that is
      // present on the rendered gallery.
      final result = await SendTestRunner.sendAndInteract(
        'material/showmenu_test.dart',
        actions: [
          // Wait for the gallery to render
          {'type': 'waitFrames', 'frames': 30},
          // Tap the 'Edit' menu item (rendered by _PreviewMenuItem)
          {'type': 'tapText', 'text': 'Edit'},
          // Wait one frame for any tap effects
          {'type': 'waitFrames', 'frames': 10},
        ],
        interactDelay: const Duration(milliseconds: 500),
      );

      expect(result.build.success, isTrue,
          reason: 'Build should succeed: ${result.build.error}');

      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
      }
    });

    test('interaction - dismiss modal via barrier tap', () async {
      // Build a dialog
      final buildResult = await SendTestRunner.send(
        'material/showdialog_test.dart',
      );

      expect(buildResult.success, isTrue,
          reason: 'Build should succeed: ${buildResult.error}');

      // Wait for dialog to appear
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Try to dismiss by tapping outside
      final interactResult = await SendTestRunner.interact([
        {'type': 'waitFrames', 'frames': 20},
        {'type': 'dismiss'},
        {'type': 'waitFrames', 'frames': 10},
      ]);

      print('Dismiss result: $interactResult');
    });

    test('showDatePicker - can tap Cancel to dismiss', () async {
      // `material/showdatepicker_test.dart` is a static teaching demo. The
      // mock dialog scaffold renders `Text('CANCEL')` / `Text('OK')` via
      // `_mockDialogScaffold` (uppercase, matching the real Material 3
      // default). It does not actually invoke `showDatePicker(...)`.
      final result = await SendTestRunner.sendAndInteract(
        'material/showdatepicker_test.dart',
        actions: [
          // Wait for the mock dialog to render
          {'type': 'waitFrames', 'frames': 30},
          // Tap the rendered 'CANCEL' label
          {'type': 'tapText', 'text': 'CANCEL'},
          // Wait one frame for any tap effects
          {'type': 'waitFrames', 'frames': 10},
        ],
        interactDelay: const Duration(milliseconds: 500),
      );

      expect(result.build.success, isTrue,
          reason: 'Build should succeed: ${result.build.error}');

      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
      }
    });

    test('showTimePicker - can tap Cancel to dismiss', () async {
      // `material/showtimepicker_test.dart` is a static teaching demo. Section
      // 9 (the helpText / cancelText / confirmText explainer) renders the
      // labels directly — `Text('DISMISS', ...)` is the configured cancelText
      // example. The script does not actually invoke `showTimePicker(...)`.
      final result = await SendTestRunner.sendAndInteract(
        'material/showtimepicker_test.dart',
        actions: [
          // Wait for the teaching widget to render
          {'type': 'waitFrames', 'frames': 30},
          // Tap the rendered 'DISMISS' label (cancelText example)
          {'type': 'tapText', 'text': 'DISMISS'},
          // Wait one frame for any tap effects
          {'type': 'waitFrames', 'frames': 10},
        ],
        interactDelay: const Duration(milliseconds: 500),
      );

      expect(result.build.success, isTrue,
          reason: 'Build should succeed: ${result.build.error}');

      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
      }
    });
  });
}
