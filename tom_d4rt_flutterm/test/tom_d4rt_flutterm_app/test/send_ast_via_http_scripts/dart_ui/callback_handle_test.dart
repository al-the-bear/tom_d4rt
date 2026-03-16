// D4rt test script: Tests CallbackHandle from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CallbackHandle test executing');

  // Create from raw handle
  final handle1 = ui.CallbackHandle.fromRawHandle(12345);
  print('CallbackHandle created from raw: ${handle1.runtimeType}');
  print('toRawHandle: ${handle1.toRawHandle()}');

  // Create another handle
  final handle2 = ui.CallbackHandle.fromRawHandle(67890);
  print('handle2 toRawHandle: ${handle2.toRawHandle()}');

  // Same raw handle should produce equal handles
  final handle3 = ui.CallbackHandle.fromRawHandle(12345);
  print('handle1 == handle3 (same raw): ${handle1 == handle3}');
  print('handle1 == handle2 (different raw): ${handle1 == handle2}');

  // Hash code
  print('handle1 hashCode: ${handle1.hashCode}');
  print('handle3 hashCode: ${handle3.hashCode}');
  print('hashCodes equal: ${handle1.hashCode == handle3.hashCode}');

  // Various raw handles
  final handle4 = ui.CallbackHandle.fromRawHandle(0);
  print('handle from 0: ${handle4.toRawHandle()}');
  final handle5 = ui.CallbackHandle.fromRawHandle(999999);
  print('handle from 999999: ${handle5.toRawHandle()}');

  print('CallbackHandle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CallbackHandle Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Raw handle roundtrip: ${handle1.toRawHandle()}'),
      Text('Equality: same=${handle1 == handle3}, diff=${handle1 == handle2}'),
      Text('HashCode consistent: ${handle1.hashCode == handle3.hashCode}'),
    ],
  );
}
