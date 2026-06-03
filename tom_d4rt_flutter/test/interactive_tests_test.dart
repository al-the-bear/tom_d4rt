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
// testlog_20260529-1944 TODO C.202 — library-level @Timeout(240 s)
// REMOVED. The annotation was added (2206 TODO #6) on the theory that
// the source-direct test_app's cold launch could exceed the 30 s
// `package:test` default applied to `setUpAll`. Direct measurement
// disproves that: the `SendTestRunner.setUp` cold launch (port reap +
// `flutter run` + /health poll) completes in ~16 s on an isolated
// retest — ~14 s of headroom under the 30 s default — and the AST
// sibling (`tom_d4rt_flutter_ast/test/interactive_tests_test.dart`)
// has always run with NO library annotation and passes. The inner
// `SendTestRunner.setUp(timeout:)` budget below is reduced to 25 s
// (< the 30 s default wrapper) so a genuinely-stuck launch fails fast
// with the runner's own clear message instead of the generic
// `(setUpAll)` 30 s timeout. The per-test 90 s timeouts were already
// removed in C.196–C.201; the suite now runs entirely on
// `package:test` defaults.
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

void main() {
  setUpAll(() async {
    // testlog_20260529-1944 TODO C.202 — budget reduced 180 s → 25 s.
    // The measured cold launch is ~16 s (isolated retest), so a 25 s
    // budget keeps ~9 s of headroom while staying under the 30 s
    // `package:test` default applied to `setUpAll` — the library-level
    // `@Timeout(240 s)` annotation is now removed (see header). If a
    // launch genuinely wedges, the 25 s budget fires first and surfaces
    // `SendTestRunner`'s own "failed to start within 25 seconds"
    // message rather than the generic `(setUpAll)` timeout.
    await SendTestRunner.setUp(timeout: const Duration(seconds: 25));
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
        //
        // testlog_20260529-1944 TODO C.196 — cold-start timeout wrapper
        // removed. Isolated retest builds this script in ~2.1 s
        // (httpMs=1875, totalMs=2090, frameworkErrors=0); the 50 s
        // `httpBuildTimeout`/90 s dart-test `Timeout` padding masked
        // nothing. Defaults now apply (25 s httpBuildTimeout + 30 s
        // dart-test timeout). The shared `_interactiveBuildTimeout`
        // const is RETAINED (still used by C.197–C.201).
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
        // testlog_20260529-1944 TODO C.197 — cold-start timeout wrapper
        // removed. Isolated retest builds this script in ~3.0 s
        // (httpMs=2745, totalMs=3025, frameworkErrors=0, outputLines=7);
        // the 50 s `httpBuildTimeout`/90 s dart-test `Timeout` padding
        // masked nothing. Defaults now apply (25 s httpBuildTimeout + 30 s
        // dart-test timeout). The shared `_interactiveBuildTimeout` const
        // is RETAINED (still used by C.198–C.201).
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
        //
        // testlog_20260529-1944 TODO C.198 — cold-start timeout wrapper
        // removed. Isolated retest builds this script in ~2.1 s
        // (httpMs=1841, totalMs=2070, frameworkErrors=0); the 50 s
        // `httpBuildTimeout`/90 s dart-test `Timeout` padding masked
        // nothing. Defaults now apply (25 s httpBuildTimeout + 30 s
        // dart-test timeout). The shared `_interactiveBuildTimeout`
        // const is RETAINED (still used by C.199–C.201).
        final result = await SendTestRunner.sendAndInteract(
          'material/showmenu_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'Edit'},
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
      'interaction - dismiss modal via barrier tap',
      () async {
        // testlog_20260529-1944 TODO C.199 — cold-start timeout wrapper
        // removed. Isolated retest builds `material/showdialog_test.dart`
        // in ~2.1 s (httpMs=1864, totalMs=2091, frameworkErrors=0,
        // outputLines=2); the 50 s `httpBuildTimeout`/90 s dart-test
        // `Timeout` padding masked nothing. Defaults now apply (25 s
        // httpBuildTimeout + 30 s dart-test timeout). The shared
        // `_interactiveBuildTimeout` const is RETAINED (still used by
        // C.200/C.201).
        final buildResult =
            await SendTestRunner.send('material/showdialog_test.dart');

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
    );

    test(
      'showDatePicker static demo — taps rendered CANCEL label',
      () async {
        // `material/showdatepicker_test.dart` is a static teaching demo.
        // The mock dialog scaffold renders `Text('CANCEL')` /
        // `Text('OK')` via `_mockDialogScaffold` (uppercase, matching
        // the real Material 3 default). The imperative
        // `showDatePicker(...)` is never invoked.
        //
        // testlog_20260529-1944 TODO C.200 — cold-start timeout wrapper
        // removed. Isolated retest builds this script in ~2.2 s
        // (httpMs=1921, totalMs=2196, frameworkErrors=0, outputLines=73);
        // the 50 s `httpBuildTimeout`/90 s dart-test `Timeout` padding
        // masked nothing. Defaults now apply (25 s httpBuildTimeout + 30 s
        // dart-test timeout). The shared `_interactiveBuildTimeout` const
        // is RETAINED (still used by C.201).
        final result = await SendTestRunner.sendAndInteract(
          'material/showdatepicker_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'CANCEL'},
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
      'showTimePicker static demo — taps rendered DISMISS label',
      () async {
        // `material/showtimepicker_test.dart` is a static teaching demo.
        // Section 9 (the helpText / cancelText / confirmText explainer)
        // renders the labels directly — `Text('DISMISS', ...)` is the
        // configured cancelText example. The imperative
        // `showTimePicker(...)` is never invoked.
        //
        // testlog_20260529-1944 TODO C.201 — cold-start timeout wrapper
        // removed. Isolated retest builds this script in ~2.3 s
        // (httpMs=2069, totalMs=2345, frameworkErrors=0, outputLines=41);
        // the 50 s `httpBuildTimeout`/90 s dart-test `Timeout` padding
        // masked nothing. Defaults now apply (25 s httpBuildTimeout + 30 s
        // dart-test timeout). As the LAST TEST sibling referencing the
        // shared `_interactiveBuildTimeout` const, that const declaration
        // is now DELETED (completing the deferred §C.xii cleanup).
        final result = await SendTestRunner.sendAndInteract(
          'material/showtimepicker_test.dart',
          actions: [
            {'type': 'waitFrames', 'frames': 30},
            {'type': 'tapText', 'text': 'DISMISS'},
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
  });
}
