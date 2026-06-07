/// OPEN A.7 — investigation-first CONTROL (step a).
///
/// §U16 claims an empty-string `Text('')` and §U19 claims a per-character
/// non-Latin `TextSpan` stream each trip a NaN `Offset`/`Rect` assertion in
/// `dart:ui` painting *only* through the bridged d4rt pipeline, and that
/// "native Flutter short-circuits" the empty/degenerate paragraph.
///
/// This test is the control: it renders the EXACT minimal repro shapes from
/// §U16 / §U19 with **native, non-interpreted** Flutter widgets and asserts no
/// NaN assertion is thrown. If native Flutter is clean here, the NaN is a
/// genuine interpreter/bridge defect (branch: continue to a fix). If native
/// Flutter throws the same NaN, the issue is a genuine Flutter/platform
/// restriction (branch: keep the curated limits entry, stop).
@TestOn('vm')
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('A.7 control — native Flutter, no interpreter', () {
    testWidgets('U16: native Column[Text(""), Text("foo")] paints without NaN',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: <Widget>[
                Text(''), // the §U16 trigger
                Text('foo'),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      // A NaN Offset assertion would surface here as a caught exception.
      expect(tester.takeException(), isNull,
          reason: 'native Text("") must paint without a NaN Offset banner');
    });

    testWidgets('U16: native Text("") under IntrinsicHeight paints without NaN',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Text(''),
                  Text('foo'),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull,
          reason:
              'native Text("") under IntrinsicHeight must paint without NaN');
    });

    testWidgets(
        'U19: native per-char non-Latin TextSpan stream paints without NaN',
        (WidgetTester tester) async {
      const String hiragana = 'こんにちは';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RichText(
              text: TextSpan(
                style: const TextStyle(fontFamily: 'monospace'),
                children: <InlineSpan>[
                  for (int i = 0; i < hiragana.length; i++)
                    TextSpan(
                      text: hiragana[i],
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull,
          reason:
              'native per-char non-Latin TextSpan must paint without a NaN '
              'Rect banner');
    });
  });
}
