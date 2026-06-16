// Regression test: the hello_card copy-paste snippet must not overflow when
// rendered in a small window. The Paste & Run result pane can be short and
// narrow, so the snippet centers when there is room and scrolls otherwise —
// rendering it on a tiny surface must not raise a layout-overflow exception.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

void main() {
  testWidgets('hello_card renders without overflow on a small surface',
      (tester) async {
    // Read the snippet from disk (its source of truth) rather than via
    // rootBundle, so this test does not depend on asset priming.
    final source =
        File('assets/copy_paste_samples/hello_card.dart').readAsStringSync();

    // A deliberately small viewport — narrower and shorter than the card's
    // natural size — to exercise both the horizontal (text wrap) and vertical
    // (scroll) escape hatches.
    await tester.binding.setSurfaceSize(const Size(200, 300));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final d4rt = SourceFlutterD4rt();
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (context) {
      return d4rt.build<Widget>(source, context);
    })));
    await tester.pump(const Duration(milliseconds: 100));

    // A RenderFlex/RenderBox overflow surfaces as an exception captured by the
    // test binding — assert none was recorded.
    expect(tester.takeException(), isNull);
    expect(find.text('Hello from D4rt!'), findsOneWidget);
  });
}
