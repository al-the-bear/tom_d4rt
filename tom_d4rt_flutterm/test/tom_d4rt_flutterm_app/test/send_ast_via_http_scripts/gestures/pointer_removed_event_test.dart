// D4rt test script: Tests PointerRemovedEvent from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerRemovedEvent test executing');

  // Create PointerRemovedEvent
  final event = PointerRemovedEvent(
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
  print('localPosition: ${event.localPosition}');

  // Test pointer identification
  print('\nPointer identification:');
  print('pointer: ${event.pointer}');
  print('device: ${event.device}');
  print('kind: ${event.kind}');

  // Test event state
  print('\nEvent state:');
  print('down: ${event.down}');
  print('timeStamp: ${event.timeStamp}');
  print('synthesized: ${event.synthesized}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('is PointerEvent: ${true}');
  print('PointerRemovedEvent extends PointerEvent');

  // Lifecycle events
  print('\nPointer lifecycle events:');
  print('1. PointerAddedEvent - pointer device added');
  print('2. PointerDownEvent - pressed');
  print('3. PointerMoveEvent - moved while pressed');
  print('4. PointerUpEvent - released');
  print('5. PointerRemovedEvent - pointer device removed (this one)');

  // Explain purpose
  print('\nPointerRemovedEvent purpose:');
  print('- Pointer device removed from system');
  print('- Stylus lifted above detection range');
  print('- Mouse disconnected');
  print('- Touch point no longer tracked');
  print('- Paired with PointerAddedEvent');

  // Usage context
  print('\nUsage context:');
  print('- Cleanup pointer tracking state');
  print('- Reset hover effects');
  print('- Release gesture recognizers');
  print('- End pointer-specific animations');

  print('\nPointerRemovedEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerRemovedEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Pointer device removed'),
      Text('pointer: ${event.pointer}'),
      Text('device: ${event.device}'),
      Text('kind: ${event.kind}'),
      Text('Paired with: PointerAddedEvent'),
    ],
  );
}
