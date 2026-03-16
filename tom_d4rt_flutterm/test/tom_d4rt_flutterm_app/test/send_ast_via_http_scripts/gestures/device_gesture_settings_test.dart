// D4rt test script: Tests DeviceGestureSettings from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DeviceGestureSettings test executing');

  final dgs1 = DeviceGestureSettings(touchSlop: 18.0);
  print('touchSlop: ${dgs1.touchSlop}');
  print('panSlop: ${dgs1.panSlop}');

  final dgs2 = DeviceGestureSettings(touchSlop: 24.0);
  print('dgs2 touchSlop: ${dgs2.touchSlop}');

  final dgs3 = DeviceGestureSettings(touchSlop: null);
  print('null touchSlop: ${dgs3.touchSlop}');
  print('null panSlop: ${dgs3.panSlop}');

  final dgs4 = DeviceGestureSettings(touchSlop: 18.0);
  print('equals dgs1==dgs4: ${dgs1 == dgs4}');
  print('hashCode match: ${dgs1.hashCode == dgs4.hashCode}');

  print('DeviceGestureSettings test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DeviceGestureSettings Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('touchSlop: ${dgs1.touchSlop}'),
    Text('panSlop: ${dgs1.panSlop}'),
    Text('Equality: ${dgs1 == dgs4}'),
  ]);
}
