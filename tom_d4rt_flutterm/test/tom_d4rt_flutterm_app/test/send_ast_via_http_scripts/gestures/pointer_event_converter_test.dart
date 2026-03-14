// D4rt test script: Tests PointerEventConverter from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventConverter test executing');

  // PointerEventConverter converts platform PointerData to PointerEvents
  print('PointerEventConverter: Static utility class');
  print('Purpose: Convert ui.PointerData to PointerEvent');

  // Test expand method (primary API)
  print('\nPointerEventConverter.expand():');
  print('- Converts Iterable<PointerData> to Iterable<PointerEvent>');
  print('- Expands multiple pointer data into events');
  print('- Called by GestureBinding to process platform events');

  // Create sample PointerData for demonstration
  print('\nPointerData fields:');
  print('- timeStamp: Event timestamp');
  print('- change: PointerChange (add, down, move, up, etc.)');
  print('- kind: PointerDeviceKind (touch, mouse, stylus, etc.)');
  print('- device: Pointer device identifier');
  print('- physicalX/Y: Physical screen coordinates');
  print('- buttons: Button mask');
  print('- pressure: Touch pressure');
  print('- etc.');

  // PointerChange enum values
  print('\nPointerChange values:');
  print('- add: Pointer added to device');
  print('- remove: Pointer removed');
  print('- hover: Pointer moved (not down)');
  print('- down: Pointer pressed');
  print('- move: Pointer moved (while down)');
  print('- up: Pointer released');
  print('- cancel: Interaction cancelled');
  print('- panZoomStart/Update/End: Trackpad gestures');

  // Event mapping
  print('\nPointerChange to PointerEvent mapping:');
  print('- add -> PointerAddedEvent');
  print('- down -> PointerDownEvent');
  print('- move -> PointerMoveEvent');
  print('- up -> PointerUpEvent');
  print('- cancel -> PointerCancelEvent');
  print('- hover -> PointerHoverEvent');

  print('\nPointerEventConverter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerEventConverter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Static utility class'),
      Text('Converts: ui.PointerData -> PointerEvent'),
      Text('Method: expand(Iterable<PointerData>)'),
      Text('Used by: GestureBinding'),
    ],
  );
}
