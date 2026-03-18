// D4rt test script: Tests PointerExitEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerExitEvent test executing');

  // Create PointerExitEvent
  final event = PointerExitEvent(
    pointer: 1,
    position: Offset(100.0, 200.0),
    device: 0,
    kind: ui.PointerDeviceKind.mouse,
    timeStamp: Duration.zero,
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('delta: ${event.delta}');

  // Test pointer identification
  print('\nPointer identification:');
  print('pointer: ${event.pointer}');
  print('device: ${event.device}');
  print('kind: ${event.kind}');

  // Test event state
  print('\nEvent state:');
  print('down: ${event.down}');
  print('buttons: ${event.buttons}');
  print('synthesized: ${event.synthesized}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is PointerEvent: ${event is PointerEvent}');
  print('is PointerHoverEvent: ${event is PointerHoverEvent}');
  print('PointerExitEvent extends PointerEvent');

  // Explain purpose
  print('\nPointerExitEvent purpose:');
  print('- Sent when pointer leaves a target');
  print('- Part of enter/exit tracking');
  print('- Paired with PointerEnterEvent');
  print('- Used for hover state management');
  print('- Common with mouse interactions');

  // Usage context
  print('\nUsage context:');
  print('- MouseRegion.onExit callback');
  print('- Listener.onPointerExit callback');
  print('- Detecting when cursor leaves widget');
  print('- Resetting hover visual states');

  print('\nPointerExitEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerExitEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Pointer left target'),
      Text('position: ${event.position}'),
      Text('kind: ${event.kind}'),
      Text('down: ${event.down}'),
      Text('Paired with: PointerEnterEvent'),
    ],
  );
}
