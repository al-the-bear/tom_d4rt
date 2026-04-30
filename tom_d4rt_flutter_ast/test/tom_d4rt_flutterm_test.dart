import 'package:flutter_test/flutter_test.dart';

import 'package:tom_d4rt_flutterm/tom_d4rt_flutterm.dart';

void main() {
  test('FlutterD4rt can be instantiated', () {
    final d4rt = FlutterD4rt();
    expect(d4rt.interpreter, isNotNull);
  });

  test('FlutterMaterialBridges registers without error', () {
    final d4rt = FlutterD4rt();
    // Force bridge registration
    FlutterMaterialBridges.register(d4rt.interpreter);
  });
}
