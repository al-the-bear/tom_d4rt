/// Smoke test: the compiled bundle assets deserialize and render through the
/// analyzer-free [FlutterD4rt] runtime.
///
/// This proves the Phase-1 pipeline end-to-end on the device side — load the
/// pre-compiled `AstBundle` JSON from assets, reconstruct it via
/// `AstBundle.fromJson`, and build a real Flutter widget tree — with no
/// analyzer and no `dart:io` involved at runtime.
library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

void main() {
  testWidgets('counter_app bundle renders a MaterialApp', (tester) async {
    final raw = await rootBundle.loadString('assets/bundles/counter_app.json');
    final bundle = AstBundle.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    final d4rt = FlutterD4rt();
    await tester.pumpWidget(
      Builder(builder: (context) => d4rt.build<Widget>(bundle, context)),
    );
    await tester.pumpAndSettle();

    // counter.dart renders an AppBar titled "Counter (multi-file)".
    expect(find.text('Counter (multi-file)'), findsOneWidget);
    expect(find.text('count = 0'), findsOneWidget);

    // Tapping the FAB routes through the script's setState proxy.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('count = 1'), findsOneWidget);
  });
}
