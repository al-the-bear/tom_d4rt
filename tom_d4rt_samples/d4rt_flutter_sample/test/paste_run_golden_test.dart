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
//  • Fixed surface + device pixel ratio, so the PNG dimensions are identical
//    on every machine.
//
//  • Real fonts loaded before pumping (see _loadRealFonts). By default
//    `flutter test` falls back to the placeholder test font, which draws every
//    glyph as a uniform box and renders no icons — the shots then show boxes
//    instead of legible text/icons. We load the Material/Cupertino icon fonts
//    from the bundled FontManifest and a committed copy of Roboto (the Material
//    default text family) so the goldens show actual text and icons.
//    Reproducibility is preserved because the exact font files are committed
//    under test/fonts/, not pulled from the (machine-specific) SDK cache.
//
// Asset loads (the Samples list) are async and show a spinner — an infinite
// animation that would make pumpAndSettle time out. So we prime the app with
// _pumpUntilFound (which drives the real event loop via runAsync) until the
// spinner has cleared before using pumpAndSettle for tab/route transitions.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

/// Load real fonts so the goldens show actual glyphs and icons instead of the
/// test framework's placeholder boxes.
///
/// Two sources:
///  • Icon fonts (MaterialIcons, CupertinoIcons) are already present in the
///    test asset bundle's `FontManifest.json`. Each is registered under the
///    exact family string the framework references — the manifest already
///    carries the `packages/…` prefix for package-provided fonts — so `Icon`
///    widgets render real glyphs.
///  • Roboto (the Material default text family on the test target platform) and
///    `monospace` (used by the Paste & Run editor's TextField, see
///    paste_run_tab.dart) are NOT bundled; they ship with the engine / are
///    platform aliases. We commit Roboto-{Regular,Medium,Bold}.ttf and
///    RobotoMono-{Regular,Bold}.ttf under test/fonts/ and register them under
///    the `Roboto` and `monospace` families respectively so all default text
///    AND the source editor render with real, reproducible glyphs.
Future<void> _loadRealFonts() async {
  // Icon fonts from the bundled FontManifest.
  final manifestJson = await rootBundle.loadString('FontManifest.json');
  final manifest =
      (json.decode(manifestJson) as List).cast<Map<String, dynamic>>();
  for (final entry in manifest) {
    final loader = FontLoader(entry['family'] as String);
    for (final font in (entry['fonts'] as List).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }

  // Text families from committed test fixtures. Paths are relative to the
  // package root, which is the CWD when `flutter test` runs.
  await _loadFamilyFromFiles('Roboto', const [
    'test/fonts/Roboto-Regular.ttf',
    'test/fonts/Roboto-Medium.ttf',
    'test/fonts/Roboto-Bold.ttf',
  ]);
  await _loadFamilyFromFiles('monospace', const [
    'test/fonts/RobotoMono-Regular.ttf',
    'test/fonts/RobotoMono-Bold.ttf',
  ]);
}

/// Register [family] from on-disk font [paths] (relative to the package root).
Future<void> _loadFamilyFromFiles(String family, List<String> paths) async {
  final loader = FontLoader(family);
  for (final path in paths) {
    final bytes = await File(path).readAsBytes();
    loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

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
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await _loadRealFonts();
  });

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
