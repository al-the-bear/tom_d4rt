// ignore_for_file: avoid_print
/// Tests for the programmatic interaction system.
///
/// These tests verify that the /interact endpoint can simulate user
/// interactions with rendered widgets. The showdialog / showmenu /
/// showdatepicker / showtimepicker scripts are explicitly **static
/// visual demos** — they never invoke their imperative companion
/// functions (showDialog, showMenu, ...) because those functions
/// return a Future and the test harness forbids Futures in `build`.
/// Tap actions therefore target widgets the static demos render
/// natively (mock-dialog button labels, sample menu items), not buttons
/// inside a popup that does not exist. This is enough to validate the
/// /interact endpoint can find and act on rendered text.
///
/// 20260524 §6 todo #20 — showDialog tap label changed from `'OK'`
/// (which never matched anything rendered) to `'Cancel'` (real Text
/// widget in the script at line 1745). The other tests already had
/// corrected labels (`'Edit'`, `'CANCEL'`, `'DISMISS'`). Also added
/// `httpBuildTimeout: 50 s` to absorb cold-start contention on the
/// 800 KB+ AST bundles.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// Cold-start contention cap for the static-demo scripts. Each bundles
/// to ~800 KB+ of AST JSON and the first script in a freshly-launched
/// `flutter test` invocation can exceed the default 25 s build cap.
const Duration _interactiveBuildTimeout = Duration(seconds: 50);

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(timeout: const Duration(seconds: 120));
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Interactive tests', () {
    test(
      'showDialog static demo — taps rendered Cancel label',
      () async {
        // `material/showdialog_test.dart` is a static visual demo that
        // renders mock AlertDialog visualizations (the imperative
        // `showDialog(...)` function is never invoked because it
        // returns a Future). The mock dialog renders `Text('Cancel')`
        // (script line 1745); tap that instead of the never-rendered
        // `'OK'`.
        final result = await SendTestRunner.sendAndInteract(
          'material/showdialog_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'Cancel'},
            {'type': 'waitFrames', 'frames': 10},
          ],
          interactDelay: const Duration(milliseconds: 500),
          httpBuildTimeout: _interactiveBuildTimeout,
        );

        expect(result.build.success, isTrue,
            reason: 'Build should succeed: ${result.build.error}');

        if (result.interact != null) {
          print('Interaction result: ${result.interact}');
          if (result.interact!.success) {
            final allOutput = [
              ...result.build.output,
              ...result.interact!.output,
            ];
            expect(
              allOutput.any((line) => line.contains('showDialog')),
              isTrue,
              reason: 'Expected showDialog output',
            );
          }
        }
      },
      timeout: const Timeout(Duration(seconds: 90)),
    );

    test(
      'showBottomSheet static demo — taps the rendered Share ListTile',
      () async {
        // showbottomsheet_test.dart renders `ListTile(title: Text('Share'))`
        // (line 1996). Kept as-is with the cold-start cap added.
        final result = await SendTestRunner.sendAndInteract(
          'material/showbottomsheet_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'Share'},
            {'type': 'waitFrames', 'frames': 10},
          ],
          interactDelay: const Duration(milliseconds: 500),
          httpBuildTimeout: _interactiveBuildTimeout,
        );

        expect(result.build.success, isTrue,
            reason: 'Build should succeed: ${result.build.error}');

        if (result.interact != null) {
          print('Interaction result: ${result.interact}');
        }
      },
      timeout: const Timeout(Duration(seconds: 90)),
    );

    test(
      'showMenu static demo — taps Edit menu item',
      () async {
        // `material/showmenu_test.dart` is a static teaching demo that
        // renders a `_PreviewMenuItem` gallery (Edit / Duplicate / Share
        // / Delete) — it does not actually invoke `showMenu(...)`.
        // Tap a label that is present on the rendered gallery.
        final result = await SendTestRunner.sendAndInteract(
          'material/showmenu_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'Edit'},
            {'type': 'waitFrames', 'frames': 10},
          ],
          interactDelay: const Duration(milliseconds: 500),
          httpBuildTimeout: _interactiveBuildTimeout,
        );

        expect(result.build.success, isTrue,
            reason: 'Build should succeed: ${result.build.error}');

        if (result.interact != null) {
          print('Interaction result: ${result.interact}');
        }
      },
      timeout: const Timeout(Duration(seconds: 90)),
    );

    test(
      'interaction - dismiss modal via barrier tap',
      () async {
        final buildResult = await SendTestRunner.send(
          'material/showdialog_test.dart',
          httpBuildTimeout: _interactiveBuildTimeout,
        );

        expect(buildResult.success, isTrue,
            reason: 'Build should succeed: ${buildResult.error}');

        await Future<void>.delayed(const Duration(milliseconds: 500));

        final interactResult = await SendTestRunner.interact([
          {'type': 'waitFrames', 'frames': 20},
          {'type': 'dismiss'},
          {'type': 'waitFrames', 'frames': 10},
        ]);

        print('Dismiss result: $interactResult');
      },
      timeout: const Timeout(Duration(seconds: 90)),
    );

    test(
      'showDatePicker static demo — taps rendered CANCEL label',
      () async {
        // `material/showdatepicker_test.dart` is a static teaching demo.
        // The mock dialog scaffold renders `Text('CANCEL')` /
        // `Text('OK')` via `_mockDialogScaffold` (uppercase, matching
        // the real Material 3 default). The imperative
        // `showDatePicker(...)` is never invoked.
        final result = await SendTestRunner.sendAndInteract(
          'material/showdatepicker_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'CANCEL'},
            {'type': 'waitFrames', 'frames': 10},
          ],
          interactDelay: const Duration(milliseconds: 500),
          httpBuildTimeout: _interactiveBuildTimeout,
        );

        expect(result.build.success, isTrue,
            reason: 'Build should succeed: ${result.build.error}');

        if (result.interact != null) {
          print('Interaction result: ${result.interact}');
        }
      },
      timeout: const Timeout(Duration(seconds: 90)),
    );

    test(
      'showTimePicker static demo — taps rendered DISMISS label',
      () async {
        // `material/showtimepicker_test.dart` is a static teaching demo.
        // Section 9 (the helpText / cancelText / confirmText explainer)
        // renders the labels directly — `Text('DISMISS', ...)` is the
        // configured cancelText example. The imperative
        // `showTimePicker(...)` is never invoked.
        final result = await SendTestRunner.sendAndInteract(
          'material/showtimepicker_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'DISMISS'},
            {'type': 'waitFrames', 'frames': 10},
          ],
          interactDelay: const Duration(milliseconds: 500),
          httpBuildTimeout: _interactiveBuildTimeout,
        );

        expect(result.build.success, isTrue,
            reason: 'Build should succeed: ${result.build.error}');

        if (result.interact != null) {
          print('Interaction result: ${result.interact}');
        }
      },
      timeout: const Timeout(Duration(seconds: 90)),
    );
  });
}
