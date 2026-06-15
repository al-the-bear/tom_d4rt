// Widget tests for the d4rt_flutter_sample shell.
//
// One test, by necessity. The whole flow lives in a single `testWidgets`
// because the app loads its screens from assets via `rootBundle`, and a
// *second* asset-reading `testWidgets` in the same process cannot prime the
// bundle again — its loads never complete and the tab stays on its spinner.
// Building the app once also matches the app's own contract: constructing a
// second `SourceFlutterD4rt` would re-register the global Flutter bridge
// surface. So we build the app a single time and walk all three tabs through
// it: Samples (list + interpret a sample), Files (browse the snippet tree),
// and Paste & Run (editor + Execute control).
//
// A tall surface keeps the Files tree's auto-expanded sample groups from
// pushing the copy-paste-samples group below the lazy-list fold.
//
// Asset loads are async and show a spinner meanwhile, so `pumpAndSettle` can't
// be used while one is in flight — `_pumpUntilFound` pumps explicit frames and
// drives the real event loop instead. Animations (tab/route transitions,
// ExpansionTile expand) are settled with `pumpAndSettle` once no load pends.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:d4rt_flutter_sample/main.dart';

/// Pump frames until [finder] matches or [tries] is exhausted.
///
/// Asset reads via `rootBundle` complete on the real event loop, which `pump`
/// alone does not drive — so each step gives the real loop a slice via
/// `runAsync` before pumping a frame (with a non-zero duration so in-flight
/// animations, like the TabBar switch, also advance) to rebuild with whatever
/// loaded.
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
  testWidgets('runs a sample, browses the file tree, and exposes Paste & Run',
      (WidgetTester tester) async {
    // A tall surface so the lazy Files tree builds every group at once: the
    // runnable sample groups expand by default and would otherwise push the
    // copy-paste-samples group below the fold (and out of the build set).
    await tester.binding.setSurfaceSize(const Size(1200, 4000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const D4rtFlutterSampleApp());
    await _pumpUntilFound(tester, find.text('counter_app'));

    // Samples tab: the bundled runnable samples are listed.
    expect(find.text('D4rt Flutter Samples'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('counter_app'), findsOneWidget);
    expect(find.text('tip_calculator'), findsOneWidget);
    expect(find.text('clock_face'), findsOneWidget);

    // Requirement (c): the copy-paste snippets must NOT appear as a runnable
    // sample. The Files tab is lazy (TabBarView builds it only when visited),
    // so its absence here proves it is not in the run gallery.
    expect(find.text('copy-paste-samples'), findsNothing);

    // Open counter_app — its source is loaded from assets and interpreted into
    // a real Flutter widget tree at runtime. Seeing the script's own widgets
    // ('count = 0' from the interpreted CounterHome, plus its FAB) proves the
    // whole path: asset load → multi-file resolution → buildProgram → live
    // widgets.
    await tester.tap(find.text('counter_app'));
    await _pumpUntilFound(tester, find.text('count = 0'));
    expect(find.text('count = 0'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Back to the tabbed home. `_pumpUntilFound` returns as soon as the
    // underlying page peeks through the pop transition, so settle the route
    // animation first — until it finishes a RenderAbsorbPointer swallows taps.
    await tester.pageBack();
    await _pumpUntilFound(tester, find.text('counter_app'));
    await tester.pumpAndSettle();

    // Files tab: the copy-paste snippets are surfaced as their own
    // (non-runnable) group — distinct from the run gallery, which never lists
    // them. The tab content loads from assets, so pump until it appears.
    await tester.tap(find.text('Files'));
    await tester.pumpAndSettle();
    await _pumpUntilFound(tester, find.text('copy-paste-samples'));
    expect(find.text('copy-paste-samples'), findsOneWidget);

    // Expanding the group reveals its files; selecting one renders its source
    // in the read-only viewer, which offers a Copy action. The ExpansionTile
    // wraps its children in an IgnorePointer while the expand animation runs,
    // so settle it before tapping a file or the tap lands on dead space.
    await tester.tap(find.text('copy-paste-samples'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('hello_card.dart'));
    await _pumpUntilFound(tester, find.textContaining('Hello from D4rt!'));
    expect(find.byIcon(Icons.copy), findsOneWidget);

    // Paste & Run tab: the editor + Execute control are present.
    await tester.tap(find.text('Paste & Run'));
    await tester.pumpAndSettle();
    expect(find.text('Execute'), findsOneWidget);
    expect(find.text('Load snippet'), findsOneWidget);
  });
}
