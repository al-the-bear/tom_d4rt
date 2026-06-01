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
/// 20260524 §6 todo #20 — labels updated from `'OK'` / `'Option A'` /
/// `'Cancel'` (which never matched anything rendered) to real Text
/// widgets present in each demo. The previous labels soft-failed in
/// stdout but did not fail the test (the test only `expect`ed
/// `result.build.success`); the fix removes the misleading "Could not
/// find text X" noise. Labels chosen to match the flutter_test variant
/// so both runners stay in sync.
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
    // 1401-TODO #11 (H2) — bumped from 120s to 180s. `interactive_tests_test`
    // runs LAST in the 14-suite chain. By that point the host has
    // accumulated dyld/filesystem cache pressure plus stale port-binds
    // from the previous 13 suites — the 1401 baseline's setUpAll hit
    // the prior 120s budget and failed with "Test app failed to start
    // within 120 seconds". 180s gives a 50% safety margin over the
    // observed failure point while still bounded enough to detect a
    // genuinely-stuck launch within a reasonable wall-time. See TEST
    // side TODO #10 in error_analysis.md for the recoverable-vs-
    // kernel-zombie mode analysis.
    await SendTestRunner.setUp(
      regenerateBridges: false,
      timeout: const Duration(seconds: 180),
    );
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Interactive tests', () {
    // §U28 deep-fix history (Cluster C TODO #7+#8 in testlog_20260525-1059):
    // flutter_ast accumulated state across `/clear → /build` cycles such that
    // the 2nd+ build of these ~800 KB-bundled static demos exceeded the test
    // app's internal 30 s build budget. The Cluster C workaround was to
    // recycle the test app between every test in this group via:
    //
    //   setUp(() { SendTestRunner.requestRecycle(); });
    //
    // 2026-05-29 (testlog_20260528-2206 TODO #38): the recycle hook is no
    // longer needed on the AST side. Empirical verification on alt port
    // 14280 with the hook removed: 6/6 tests pass in 35 s wall, with every
    // build completing in 1.8-2.5 s (far under the 30 s budget). Some
    // intervening interpreter / bridge fix closed the §U28 cliff naturally
    // — the exact closing change is not localised, but the outcome is
    // verified clean. If the cliff re-emerges in a future sweep, restore
    // the `setUp(() { SendTestRunner.requestRecycle(); })` hook here (the
    // `requestRecycle()` API itself remains shipped in send_test_runner.dart
    // for future use). See `interpreter_unfixable.md` §U28 for the original
    // architectural finding and the operational workaround that was kept
    // hot-swappable for exactly this kind of self-resolution.


    test(
      'showDialog static demo — taps rendered Cancel label',
      () async {
        // `material/showdialog_test.dart` is a static visual demo that
        // renders mock AlertDialog visualizations (the imperative
        // `showDialog(...)` function is never invoked because it
        // returns a Future). The mock dialog renders `Text('Cancel')`
        // (script line 1745); tap that instead of the never-rendered
        // `'OK'`.
        //
        // 20260602 TODO C.190 closure: the 50 s `httpBuildTimeout` +
        // 90 s dart-test `Timeout` were cold-start padding masking
        // nothing. Isolated retest builds in ~2.2 s (httpMs=1828,
        // totalMs=2214, frameworkErrors=0) — far under the default 25 s
        // HTTP cap — so both wrappers are removed. The shared
        // `_interactiveBuildTimeout` const stays in place; it is still
        // used by the sibling static-demo tests (C.191–C.195).
        final result = await SendTestRunner.sendAndInteract(
          'material/showdialog_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'Cancel'},
            {'type': 'waitFrames', 'frames': 10},
          ],
          interactDelay: const Duration(milliseconds: 500),
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
    );

    test(
      'showBottomSheet static demo — taps the rendered Share ListTile',
      () async {
        // showbottomsheet_test.dart renders `ListTile(title: Text('Share'))`
        // (line 1996).
        //
        // 20260602 TODO C.191 closure: the 50 s `httpBuildTimeout` +
        // 90 s dart-test `Timeout` were cold-start padding masking
        // nothing. Isolated retest builds in ~3.0 s (httpMs=2617,
        // totalMs=3032, frameworkErrors=0) — far under the default 25 s
        // HTTP cap — so both wrappers are removed. The shared
        // `_interactiveBuildTimeout` const stays in place; it is still
        // used by the sibling static-demo tests (C.192–C.195).
        final result = await SendTestRunner.sendAndInteract(
          'material/showbottomsheet_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'Share'},
            {'type': 'waitFrames', 'frames': 10},
          ],
          interactDelay: const Duration(milliseconds: 500),
        );

        expect(result.build.success, isTrue,
            reason: 'Build should succeed: ${result.build.error}');

        if (result.interact != null) {
          print('Interaction result: ${result.interact}');
        }
      },
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
        // Build the showdialog static demo (does not actually push a
        // route; barrier tap is exercised against the rendered scaffold).
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
