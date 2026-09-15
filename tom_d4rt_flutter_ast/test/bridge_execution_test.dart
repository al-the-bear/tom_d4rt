// ignore_for_file: avoid_print
/// Integration test for Flutter bridge execution.
///
/// This tests that D4rt can execute code using the Flutter Material bridges
/// and return native Flutter objects.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Host-side source→bundle compiler (test-only; keeps the analyzer toolchain
// out of the runtime). The runtime executes the resulting AstBundle.
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

/// Compiles [source] into an [AstBundle], skipping the libraries already
/// bridged on [d4rt]'s runner (handled natively at runtime).
Future<AstBundle> _bundle(FlutterD4rt d4rt, String source) => AstBundler(
  bridgedLibraries: d4rt.interpreter.bridgedLibraryUris,
).createFromSource(source);

void main() {
  group('FlutterD4rt bridge execution', () {
    late FlutterD4rt d4rt;

    // SCD142 — `setUpAll`, not `setUp`, and the reason is a real defect rather
    // than a style preference. Bridge registration is pooled per PROCESS
    // (import-optimization step #20): `providePackage` returns true on the
    // second instance, its `register*` block is skipped, and with it the
    // dual-write into the instance registries. So every `FlutterD4rt` after the
    // first reports an EMPTY `bridgedLibraryUris`, the `AstBundler` below stops
    // skipping bridged imports, and the compile dies several layers away with
    //
    //     Cannot resolve import "package:flutter/material.dart" …
    //     is not bridged and not in the same package
    //
    // This file was reachable from no runner, so it sat red and unnoticed. One
    // instance is also the honest model: the instances share process-global
    // tables, so constructing one per test bought isolation that does not exist.
    // The underlying defect — a public getter whose answer depends on
    // construction order — is sce150.
    setUpAll(() {
      d4rt = FlutterD4rt();
    });

    test('can create a Color from D4rt code', () async {
      // dart:ui types are bridged through flutter/painting.dart re-exports
      final bundle = await _bundle(d4rt, '''
import 'package:flutter/painting.dart';

Color main() {
  return Color.fromARGB(255, 100, 150, 200);
}
''');

      final result = await d4rt.executeAsync<Color>(bundle);
      print('Result: $result (${result.runtimeType})');

      expect(result, isA<Color>());
      // Color.fromARGB returns integer values for alpha/r/g/b
      expect((result.a * 255.0).round().clamp(0, 255), 255);
      expect((result.r * 255.0).round().clamp(0, 255), 100);
      expect((result.g * 255.0).round().clamp(0, 255), 150);
      expect((result.b * 255.0).round().clamp(0, 255), 200);
    });

    test('can create EdgeInsets from D4rt code', () async {
      final bundle = await _bundle(d4rt, '''
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
      final bundle = await _bundle(d4rt, '''
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
      final bundle = await _bundle(d4rt, '''
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
