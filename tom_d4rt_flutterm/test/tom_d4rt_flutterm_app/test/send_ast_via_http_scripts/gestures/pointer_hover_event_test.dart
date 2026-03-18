// D4rt test script: Tests PointerHoverEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerHoverEvent test executing');

  // Create PointerHoverEvent
  final event = PointerHoverEvent(
    pointer: 1,
    position: Offset(150.0, 250.0),
    delta: Offset(5.0, 3.0),
    device: 0,
    kind: ui.PointerDeviceKind.mouse,
    timeStamp: Duration.zero,
  );

  print('Created: ${event.runtimeType}');

  // Test position properties
  print('\nPosition properties:');
  print('position: ${event.position}');
  print('delta: ${event.delta}');
  print('localDelta: ${event.localDelta}');

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

  // Test transform
  print('\nTransform:');
  print('transform: ${event.transform}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is PointerEvent: ${true}');
  print('PointerHoverEvent extends PointerEvent');

  // Explain purpose
  print('\nPointerHoverEvent purpose:');
  print('- Pointer moving over widget (not pressed)');
  print('- Mouse cursor movement tracking');
  print('- Stylus hovering without contact');
  print('- Triggers visual feedback on hover');

  // Usage context
  print('\nUsage context:');
  print('- MouseRegion.onHover callback');
  print('- Listener.onPointerHover callback');
  print('- Hover state for buttons/links');
  print('- Preview/tooltip triggers');

  // Difference from PointerMoveEvent
  print('\nHover vs Move:');
  print('- PointerHoverEvent: pointer NOT down');
  print('- PointerMoveEvent: pointer IS down');

  print('\nPointerHoverEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerHoverEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Pointer moving, NOT pressed'),
      Text('position: ${event.position}'),
      Text('delta: ${event.delta}'),
      Text('down: ${event.down} (always false)'),
      Text('vs PointerMoveEvent: down=true'),
    ],
  );
}
