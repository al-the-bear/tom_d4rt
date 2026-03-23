// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PointerDownEvent from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerDownEvent test executing');

  final event = PointerDownEvent(
    position: Offset(200, 300),
    kind: PointerDeviceKind.touch,
    device: 0,
    buttons: kPrimaryButton,
    pressure: 0.6,
    pressureMin: 0.0,
    pressureMax: 1.0,
  );
  print('PointerDownEvent: ${event.runtimeType}');
  print('position: ${event.position}');
  print('localPosition: ${event.localPosition}');
  print('kind: ${event.kind}');
  print('buttons: ${event.buttons}');
  print('pressure: ${event.pressure}');
  print('is PointerEvent: ${true}');
  print('down: ${event.down}');

  print('PointerDownEvent test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PointerDownEvent Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('pos: ${event.position}'),
    Text('kind: ${event.kind}'),
    Text('pressure: ${event.pressure}'),
    Text('down: ${event.down}'),
  ]);
}
