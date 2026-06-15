// Smoke test for the sample gallery shell and the interpret-at-runtime path.
//
// The gallery shows a CircularProgressIndicator while it loads the asset
// manifest, and the sample host shows one while it loads a program. A spinner
// animates forever, so `pumpAndSettle` would time out on it — this test pumps
// explicit frames to let the async asset loads resolve instead.
//
// Gallery listing and sample interpretation are covered in a single test on
// purpose: the app constructs one `SourceFlutterD4rt` (which registers the
// global Flutter bridge surface), so building a second app in the same test
// process is avoided.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:d4rt_flutter_sample/main.dart';

/// Pump frames until [finder] matches or [tries] is exhausted.
///
/// The gallery and host pages load source from assets asynchronously and show
/// a continuous spinner meanwhile, so `pumpAndSettle` can't be used. Asset
/// reads via `rootBundle` complete on the real event loop, which `pump` alone
/// does not drive — so each step gives the real loop a slice via `runAsync`
/// before pumping a frame to rebuild with whatever loaded.
Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  int tries = 60,
}) async {
  for (var i = 0; i < tries; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump();
    if (finder.evaluate().isNotEmpty) return;
  }
}

void main() {
  testWidgets('lists bundled samples and interprets one at runtime',
      (WidgetTester tester) async {
    await tester.pumpWidget(const D4rtFlutterSampleApp());
    await _pumpUntilFound(tester, find.text('counter_app'));

    // The gallery enumerates the bundled samples from assets.
    expect(find.text('D4rt Flutter Samples'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('counter_app'), findsOneWidget);
    expect(find.text('tip_calculator'), findsOneWidget);
    expect(find.text('clock_face'), findsOneWidget);

    // Open counter_app — its source is loaded from assets and interpreted into
    // a real Flutter widget tree at runtime. Seeing the script's own widgets
    // ('count = 0' from the interpreted CounterHome, plus its FAB) proves the
    // whole path: asset load → multi-file resolution → buildProgram → live
    // widgets. The increment interaction is exercised by running the app.
    await tester.tap(find.text('counter_app'));
    await _pumpUntilFound(tester, find.text('count = 0'));

    expect(find.text('count = 0'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
