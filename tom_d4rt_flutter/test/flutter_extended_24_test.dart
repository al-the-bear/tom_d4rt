// ignore_for_file: avoid_print
/// Auto-split extended bridge tests (file 24) — interactive suite.
///
/// Carries the interactive group(s) and their custom setUpAll/interaction
/// behaviour verbatim. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_24_test.dart';

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
    await SendTestRunner.setUp(
      suite: _kTestFileName,
      timeout: const Duration(seconds: 25),
    );
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

  group('Interactive tests', () {
    test('showDialog static demo — taps rendered Cancel label', () async {
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

      expect(
        result.build.success,
        isTrue,
        reason: 'Build should succeed: ${result.build.error}',
      );

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
    });

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

        expect(
          result.build.success,
          isTrue,
          reason: 'Build should succeed: ${result.build.error}',
        );

        if (result.interact != null) {
          print('Interaction result: ${result.interact}');
        }
      },
    );

    test('showMenu static demo — taps Edit menu item', () async {
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

      expect(
        result.build.success,
        isTrue,
        reason: 'Build should succeed: ${result.build.error}',
      );

      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
      }
    });

    test('interaction - dismiss modal via barrier tap', () async {
      // testlog_20260529-1944 TODO C.199 — cold-start timeout wrapper
      // removed. Isolated retest builds `material/showdialog_test.dart`
      // in ~2.1 s (httpMs=1864, totalMs=2091, frameworkErrors=0,
      // outputLines=2); the 50 s `httpBuildTimeout`/90 s dart-test
      // `Timeout` padding masked nothing. Defaults now apply (25 s
      // httpBuildTimeout + 30 s dart-test timeout). The shared
      // `_interactiveBuildTimeout` const is RETAINED (still used by
      // C.200/C.201).
      final buildResult = await SendTestRunner.send(
        'material/showdialog_test.dart',
      );

      expect(
        buildResult.success,
        isTrue,
        reason: 'Build should succeed: ${buildResult.error}',
      );

      await Future<void>.delayed(const Duration(milliseconds: 500));

      final interactResult = await SendTestRunner.interact([
        {'type': 'waitFrames', 'frames': 20},
        {'type': 'dismiss'},
        {'type': 'waitFrames', 'frames': 10},
      ]);

      print('Dismiss result: $interactResult');
    });

    test('showDatePicker static demo — taps rendered CANCEL label', () async {
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

      expect(
        result.build.success,
        isTrue,
        reason: 'Build should succeed: ${result.build.error}',
      );

      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
      }
    });

    test('showTimePicker static demo — taps rendered DISMISS label', () async {
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

      expect(
        result.build.success,
        isTrue,
        reason: 'Build should succeed: ${result.build.error}',
      );

      if (result.interact != null) {
        print('Interaction result: ${result.interact}');
      }
    });
  });
}
