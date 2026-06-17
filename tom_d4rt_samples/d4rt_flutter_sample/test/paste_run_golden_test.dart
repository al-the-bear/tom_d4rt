// Golden screenshots for the "Paste & Run" tab — the section where arbitrary
// D4rt code is typed and interpreted into a live widget tree.
//
// The test drives the *real* app (D4rtFlutterSampleApp), switches to the
// Paste & Run tab, and captures four golden images that walk the core loop:
//
//   1. paste_run_1_entered.png         — a short script has been entered
//   2. paste_run_2_executed.png        — Execute pressed, script rendered
//   3. paste_run_3_modified.png        — script edited (custom dated text)
//   4. paste_run_4_executed_dated.png  — Execute pressed again, new render
//
// Regenerate the images after intentional UI changes with:
//   flutter test --update-goldens test/paste_run_golden_test.dart
//
// Two deliberate choices keep the goldens reproducible:
//
//  • Fixed date, not DateTime.now(). The requirement is "modify with a custom
//    text (e.g. the current date)". A live DateTime.now() would change the
//    rendered string every day and break the committed golden, so we bake a
//    single representative date (_kFixedDate) into the script text instead. The
//    point being demonstrated — edit the source, re-run, see the new output —
//    is identical; only the value is frozen for determinism.
//
//  • Fixed surface + device pixel ratio, so the PNG dimensions and layout are
//    identical on every machine. Text is drawn with Flutter's bundled test
//    font (uniform glyph boxes), which is the same on all platforms — that is
//    what makes goldens portable; the shots capture layout/structure rather
//    than typeface.
//
// Asset loads (the Samples list) are async and show a spinner — an infinite
// animation that would make pumpAndSettle time out. So we prime the app with
// _pumpUntilFound (which drives the real event loop via runAsync) until the
// spinner has cleared before using pumpAndSettle for tab/route transitions.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:d4rt_flutter_sample/main.dart';
import 'package:d4rt_flutter_sample/src/paste_run_tab.dart';

/// Representative "custom text" for shots 3 & 4. Frozen (not DateTime.now())
/// so the committed golden stays reproducible — see the file header.
const String _kFixedDate = '2026-06-17';

/// A short script entered for the first run.
const String _kShortScript = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return const Scaffold(
    body: Center(
      child: Text('Hello from Paste & Run'),
    ),
  );
}
''';

/// The same script edited to include the custom dated text.
const String _kDatedScript = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return const Scaffold(
    body: Center(
      child: Text('Hello from Paste & Run — $_kFixedDate'),
    ),
  );
}
''';

/// Pump frames until [finder] matches or [tries] is exhausted.
///
/// Asset reads via `rootBundle` complete on the real event loop, which `pump`
/// alone does not drive — so each step gives the real loop a slice via
/// `runAsync` before pumping a frame (non-zero duration so in-flight
/// animations advance too).
Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  int tries = 60,
}) async {
  for (var i = 0; i < tries; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump(const Duration(milliseconds: 20));
    if (finder.evaluate().isNotEmpty) return;
  }
}

void main() {
  testWidgets(
    'Paste & Run golden walk: enter, execute, edit with date, execute again',
    (WidgetTester tester) async {
      // Fixed viewport + DPR so the PNGs are byte-stable across machines.
      await tester.binding.setSurfaceSize(const Size(900, 1400));
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.binding.setSurfaceSize(null);
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const D4rtFlutterSampleApp());

      // Prime the Samples tab's async asset load so its spinner (an infinite
      // animation) clears before any pumpAndSettle is used.
      await _pumpUntilFound(tester, find.text('counter_app'));

      // Switch to the Paste & Run tab and settle the tab transition.
      await tester.tap(find.text('Paste & Run'));
      await tester.pumpAndSettle();

      // The editor is the single TextField inside the Paste & Run tab. Scope to
      // PasteRunTab because the Samples tab is kept alive and also has one.
      final editor = find.descendant(
        of: find.byType(PasteRunTab),
        matching: find.byType(TextField),
      );
      expect(editor, findsOneWidget);
      expect(find.text('Execute'), findsOneWidget);

      // --- Shot 1: a short script is entered (not yet executed) ---
      await tester.enterText(editor, _kShortScript.trim());
      await tester.pump();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/paste_run_1_entered.png'),
      );

      // --- Shot 2: executed (standard) — script renders in the result pane ---
      await tester.tap(find.text('Execute'));
      await _pumpUntilFound(tester, find.text('Hello from Paste & Run'));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/paste_run_2_executed.png'),
      );

      // --- Shot 3: modified with custom dated text (result still shows run #1) ---
      await tester.enterText(editor, _kDatedScript.trim());
      await tester.pump();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/paste_run_3_modified.png'),
      );

      // --- Shot 4: executed again — the new dated output renders ---
      await tester.tap(find.text('Execute'));
      await _pumpUntilFound(
        tester,
        find.text('Hello from Paste & Run — $_kFixedDate'),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/paste_run_4_executed_dated.png'),
      );
    },
  );
}
