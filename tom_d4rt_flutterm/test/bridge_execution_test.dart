// ignore_for_file: avoid_print
/// Integration test for Flutter bridge execution.
///
/// This tests that D4rt can execute code using the Flutter Material bridges
/// and return native Flutter objects.
import 'dart:ui' show Color;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt_flutterm/tom_d4rt_flutterm.dart';

void main() {
  group('FlutterD4rt bridge execution', () {
    late FlutterD4rt d4rt;

    setUp(() {
      d4rt = FlutterD4rt();
    });

    test('can create a Color from D4rt code', () async {
      // dart:ui types are bridged through flutter/painting.dart re-exports
      final bundle = await d4rt.interpreter.createBundleFromSource('''
import 'package:flutter/painting.dart';

Color main() {
  return Color.fromARGB(255, 100, 150, 200);
}
''');

      final result = await d4rt.executeAsync<Color>(bundle);
      print('Result: $result (${result.runtimeType})');

      expect(result, isA<Color>());
      // Color.fromARGB returns integer values for alpha/r/g/b
      expect(result.alpha, 255);
      expect(result.red, 100);
      expect(result.green, 150);
      expect(result.blue, 200);
    });

    test('can create EdgeInsets from D4rt code', () async {
      final bundle = await d4rt.interpreter.createBundleFromSource('''
import 'package:flutter/painting.dart';

EdgeInsets main() {
  return EdgeInsets.all(16.0);
}
''');

      final result = await d4rt.executeAsync<EdgeInsets>(bundle);
      print('Result: $result (${result.runtimeType})');

      expect(result, isA<EdgeInsets>());
      expect(result.left, 16.0);
      expect(result.top, 16.0);
      expect(result.right, 16.0);
      expect(result.bottom, 16.0);
    });

    testWidgets('can build a Container widget from D4rt code', (tester) async {
      // Return dynamic to avoid type checking issues
      final bundle = await d4rt.interpreter.createBundleFromSource('''
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Container(
    width: 100.0,
    height: 50.0,
    color: Colors.blue,
  );
}
''');

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final widget = d4rt.build<Widget>(bundle, context);
            print('Built widget: $widget (${widget.runtimeType})');
            return widget;
          },
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('can build a Text widget from D4rt code', (tester) async {
      // Return dynamic to avoid type checking issues
      final bundle = await d4rt.interpreter.createBundleFromSource('''
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Text('Hello from D4rt!');
}
''');

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return d4rt.build<Widget>(bundle, context);
            },
          ),
        ),
      );

      expect(find.text('Hello from D4rt!'), findsOneWidget);
    });
  });
}
