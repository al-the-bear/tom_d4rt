// D4rt test script: Tests PointerEnterEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEnterEvent test executing');

  final event = PointerEnterEvent(
    position: Offset(50, 100),
    kind: PointerDeviceKind.mouse,
    device: 1,
  );
  print('PointerEnterEvent: ${event.runtimeType}');
  print('position: ${event.position}');
  print('kind: ${event.kind}');
  print('device: ${event.device}');
  print('is PointerEvent: ${true}');

  // fromMouseEvent
  final hover = PointerHoverEvent(position: Offset(60, 110), kind: PointerDeviceKind.mouse);
  final enter = PointerEnterEvent.fromMouseEvent(hover);
  print('fromMouseEvent: ${enter.position}');

  print('PointerEnterEvent test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PointerEnterEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('pos: ${event.position}'),
    Text('fromMouseEvent: ${enter.position}'),
  ]);
}
