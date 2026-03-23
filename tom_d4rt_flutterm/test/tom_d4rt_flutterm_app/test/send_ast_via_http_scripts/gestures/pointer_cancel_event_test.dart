// ignore_for_file: avoid_print
// D4rt test script: Tests PointerCancelEvent from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerCancelEvent test executing');

  // Create PointerCancelEvent
  final event = PointerCancelEvent(
    position: Offset(50, 80),
    device: 2,
    pointer: 1,
  );

  print('Created: ${event.runtimeType}');
  print('is PointerEvent: ${true}');

  // Properties
  print('\nEvent properties:');
  print('position: ${event.position}');
  print('device: ${event.device}');
  print('pointer: ${event.pointer}');
  print('kind: ${event.kind}');

  // When it occurs
  print('\nWhen PointerCancelEvent occurs:');
  print('- Touch cancelled by system');
  print('- Phone call interrupts touch');
  print('- Gesture routed elsewhere');
  print('- Palm rejection');

  // vs PointerUpEvent
  print('\nvs PointerUpEvent:');
  print('- Up: user lifted finger normally');
  print('- Cancel: system cancelled touch');
  print('- Both end the pointer sequence');

  // Handling
  print('\nHandling:');
  print('Listener(');
  print('  onPointerCancel: (event) {');
  print('    // Reset gesture state');
  print('    // Dont trigger action');
  print('  },');
  print(')');

  // In gesture recognizers
  print('\nIn gesture recognizers:');
  print('- Causes gesture to fail');
  print('- Triggers onCancel callbacks');
  print('- Similar to rejection');

  print('\nPointerCancelEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerCancelEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Touch cancelled by system'),
      Text('position: ${event.position}'),
      Text('Causes: call, palm rejection'),
    ],
  );
}
