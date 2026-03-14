// D4rt test script: Tests PointerSignalResolver from gestures
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerSignalResolver test executing');

  // Create PointerSignalResolver
  final resolver = PointerSignalResolver();
  print('Created: ${resolver.runtimeType}');

  // Create a test scroll event
  final scrollEvent = PointerScrollEvent(
    pointer: 0,
    position: Offset(100.0, 200.0),
    scrollDelta: Offset(0.0, -20.0),
    device: 0,
    kind: ui.PointerDeviceKind.mouse,
    timeStamp: Duration.zero,
  );

  // Test registration
  print('\nRegistration:');
  bool handlerCalled = false;
  resolver.register(scrollEvent, (PointerSignalEvent event) {
    handlerCalled = true;
    print('  Handler called with: ${event.runtimeType}');
  });
  print('Registered handler for scroll event');

  // Test resolution
  print('\nResolution:');
  resolver.resolve(scrollEvent);
  print('handlerCalled: $handlerCalled');

  // Explain purpose
  print('\nPointerSignalResolver purpose:');
  print('- Resolves competing signal handlers');
  print('- First registered handler wins');
  print('- Used for scroll event handling');
  print('- Prevents duplicate handling');

  // Usage pattern
  print('\nUsage pattern:');
  print('1. Widget registers interest in signal');
  print('2. Resolver tracks registrations');
  print('3. resolve() called after hit test');
  print('4. First registration\'s callback wins');
  print('5. Other registrations ignored');

  // API methods
  print('\nAPI methods:');
  print('- register(event, callback): Register interest');
  print('- resolve(event): Call winning handler');

  // Context
  print('\nContext:');
  print('- Used by GestureBinding');
  print('- Part of pointer signal dispatch');
  print('- Handles scroll event routing');

  print('\nPointerSignalResolver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PointerSignalResolver Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Resolves competing handlers'),
      Text('handlerCalled: $handlerCalled'),
      Text('First registered wins'),
      Text('Used for: scroll handling'),
    ],
  );
}
