// D4rt test script: Tests PointerCancelEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerCancelEvent test executing');

  final event = PointerCancelEvent(
    position: Offset(50, 80),
    device: 2,
  );
  print('PointerCancelEvent: ${event.runtimeType}');
  print('position: ${event.position}');
  print('device: ${event.device}');
  print('is PointerEvent: ${event is PointerEvent}');
  print('pointer: ${event.pointer}');

  print('PointerCancelEvent test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PointerCancelEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('pos: ${event.position}'),
    Text('device: ${event.device}'),
  ]);
}
