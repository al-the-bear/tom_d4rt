// D4rt test script: Tests PointerAddedEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerAddedEvent test executing');

  final event = PointerAddedEvent(
    position: Offset(100, 200),
    kind: PointerDeviceKind.mouse,
    device: 1,
  );
  print('PointerAddedEvent: ${event.runtimeType}');
  print('position: ${event.position}');
  print('kind: ${event.kind}');
  print('device: ${event.device}');
  print('is PointerEvent: ${event is PointerEvent}');
  print('buttons: ${event.buttons}');
  print('timeStamp: ${event.timeStamp}');

  print('PointerAddedEvent test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PointerAddedEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('pos: ${event.position}'),
    Text('kind: ${event.kind}'),
    Text('device: ${event.device}'),
  ]);
}
