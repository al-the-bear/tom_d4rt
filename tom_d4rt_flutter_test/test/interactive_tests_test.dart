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
// testlog_20260528-2206 TODO #6 — library-level @Timeout default.
//
// Dart `package:test` applies a 30 s default timeout to `setUpAll` /
// `tearDownAll` / `setUp` / `tearDown` and any `test()` without an
// explicit `timeout:` override. The 2206 baseline captured a
// `test_30s_timeout` error on this file's `(setUpAll)` because the
// source-direct test_app's cold launch + port reap can exceed 30 s
// when the host is under sweep load (§U25 cold-start performance
// limit + host-saturation contention documented across the 20260529
// regression turns).
//
// The internal `SendTestRunner.setUp(timeout: 180s)` below cannot
// kick in if the outer wrapper has already fired. Per-test
// `timeout:` overrides (90 s each) only apply to `test()` blocks,
// not to setUpAll. The library-level `@Timeout` annotation is the
// supported `package:test` mechanism to extend the suite default
// for everything that doesn't carry its own override.
//
// 240 s gives ~2× headroom over the inner 180 s `SendTestRunner.setUp`
// timeout — enough to absorb a worst-case cold launch while still
// bounded enough to detect a genuinely-stuck setUpAll within a
// reasonable wall-time. The per-test 90 s timeouts further down
// still apply unchanged — they override this library default for
// the test() blocks they appear on.
@Timeout(Duration(seconds: 240))
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// Cold-start contention cap for the static-demo scripts. Each bundles
/// to ~800 KB+ of AST JSON and the first script in a freshly-launched
/// `flutter test` invocation can exceed the default 25 s build cap.
const Duration _interactiveBuildTimeout = Duration(seconds: 50);

void main() {
  setUpAll(() async {
    // testlog_20260528-2206 TODO #6 — bumped from 120 s to 180 s
    // for parity with the AST sibling. Mirrors the 1401-TODO #11
    // (H2) headroom rationale: when this suite runs late in a
    // multi-suite sweep the host has accumulated dyld/filesystem
    // cache pressure plus stale port-binds; 120 s is the prior
    // 1401 failure point, 180 s gives 50 % headroom. Combined with
    // the library-level `@Timeout(240 s)` annotation above, the
    // outer wrapper now allows enough room for this to actually
    // complete.
    await SendTestRunner.setUp(timeout: const Duration(seconds: 180));
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
